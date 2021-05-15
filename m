Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1F8381608
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 07:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhEOF0D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 01:26:03 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:39752 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbhEOF0C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 01:26:02 -0400
Received: by mail-ej1-f54.google.com with SMTP id l1so1587216ejb.6
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 22:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8I9eAMgW1d5+6SXiSWDrf1uaChlCS5v9S4POj4RPQdA=;
        b=UEk43dBfc/9KXCdfGF+z5seRZrxKu9xlKXzTNfjpAyia2HRnCjzN8H+qYuPSptF2YE
         99+XyD59ChD7Vf5TVjgZIuVIE7fho2KvF/ivfsGEH7Uo4qof8zay2SmEDQYyrT2JE5wl
         +geiG2Io2WbbfDf9dYX2kIfjiPik9SuyPU/bMu3BWlPRZueLVMEhA0TOTTGIWympyLc0
         slZcxQi2KMIM3y0qZ6rJfvVKSTZAAYJLRLJaGKtjMsmPVn4/x3sD0PtEMTV4PSIEoBuJ
         z1mToWwgEZiArltxDvn11LMIDUuFXk2WJ4jzveC6/hY4pPf2fHdBR0EP9sYQ/NuDxhFK
         W0hw==
X-Gm-Message-State: AOAM530+ctvKISsK6pc5eGGCVMRqNZF3yMbtAY0MZlUH56xT1Pl8aG8B
        iRAVM8Lk2A2bikzrUFbAC5o=
X-Google-Smtp-Source: ABdhPJxvwuJ+Vc4f4aGryEC1IiRJpvd+1xHQx7CFoqRNrxuoykeL0ShP0qNJDTfuYBVia8rDk6gJDQ==
X-Received: by 2002:a17:907:a06d:: with SMTP id ia13mr18482816ejc.484.1621056288974;
        Fri, 14 May 2021 22:24:48 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id kt21sm4821487ejb.5.2021.05.14.22.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 22:24:48 -0700 (PDT)
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
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 13/14] PCI/sysfs: Add missing trailing newline to devspec_show()
Date:   Sat, 15 May 2021 05:24:33 +0000
Message-Id: <20210515052434.1413236-13-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515052434.1413236-1-kw@linux.com>
References: <20210515052434.1413236-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

At the moment, when the value of the "devspec" sysfs object is read from
the user space there will be no newline present, and the utilities such
as the "cat" command won't display the result of the read correctly in
a shell, as the trailing newline is currently missing.

To fix this, append a newline character in the show() function.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index beb8d1f4fafe..5d63df7c1820 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -537,7 +537,7 @@ static ssize_t devspec_show(struct device *dev,
 
 	if (np == NULL)
 		return 0;
-	return sysfs_emit(buf, "%pOF", np);
+	return sysfs_emit(buf, "%pOF\n", np);
 }
 static DEVICE_ATTR_RO(devspec);
 #endif
-- 
2.31.1

