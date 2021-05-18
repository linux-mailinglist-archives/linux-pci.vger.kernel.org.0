Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656CA387042
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 05:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242773AbhERDmd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 23:42:33 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:44995 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbhERDm3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 23:42:29 -0400
Received: by mail-lf1-f54.google.com with SMTP id j6so9270961lfr.11
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 20:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=18Y77oCkwmGvKixeQ8r3dtdgUXHABcaq/TVHul58ByE=;
        b=linMW9O9hMzqlNBzdR6CRNQv8R4XUjW/xZU+g/1tJ4OV8rocIVv86HUSCIgP1CQ7TR
         pieeNvQs3MOCXiowyR5lVCYhrgPpQWSbrXK+ao8CtmnjnAUiSs+S9MWl4h+th9jpvRSU
         BKvCxWsvNocLgsNPMV2xhtEg2Q+x763QAJ8qKcTlD0IX0ptojojJy25wQnMSX7jlemTj
         7iOCJy0twYFgRoT4SE522HByZ0U9LSQXxqv6DFvuRAvzLNOMBxVG1JFuGGfrcXx9+HUc
         h3w2TiKVp7A1iAnthslilJebHSYJRnx+Ka8heH9C6Os9w5UmSQCLqNmjz+auEy+pg0R3
         HKdQ==
X-Gm-Message-State: AOAM53147VUrQKDwE2fYXEAbjXns8j4aFbppeQcqVWZTkvcZCAtyR6Qt
        2eXPd9KMZ0R/LGzrV/03rqM=
X-Google-Smtp-Source: ABdhPJxoyKiwli9hkNKwxKAvkjbwumSx+iPEA4tkYHM8BczY2J321K7AjH7CzkTfCjq+ZYOK6wJleQ==
X-Received: by 2002:a05:6512:1194:: with SMTP id g20mr404875lfr.407.1621309271509;
        Mon, 17 May 2021 20:41:11 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j23sm419112lfm.276.2021.05.17.20.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 20:41:10 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Joe Perches <joe@perches.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 01/14] PCI: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Tue, 18 May 2021 03:40:56 +0000
Message-Id: <20210518034109.158450-1-kw@linux.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The sysfs_emit() and sysfs_emit_at() functions were introduced to make
it less ambiguous which function is preferred when writing to the output
buffer in a device attribute's "show" callback [1].

Convert the PCI sysfs object "show" functions from sprintf(), snprintf()
and scnprintf() to sysfs_emit() and sysfs_emit_at() accordingly, as the
latter is aware of the PAGE_SIZE buffer and correctly returns the number
of bytes written into the buffer.

No functional change intended.

[1] Documentation/filesystems/sysfs.rst

Related to:
  commit ad025f8e46f3 ("PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions")

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
Changes in v2:
  None.
Changes in v3:
  Added Logan Gunthorpe's "Reviewed-by".

 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b717680377a9..5ed316ea5831 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6439,7 +6439,7 @@ static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
 
 	spin_lock(&resource_alignment_lock);
 	if (resource_alignment_param)
-		count = scnprintf(buf, PAGE_SIZE, "%s", resource_alignment_param);
+		count = sysfs_emit(buf, "%s", resource_alignment_param);
 	spin_unlock(&resource_alignment_lock);
 
 	/*
-- 
2.31.1

