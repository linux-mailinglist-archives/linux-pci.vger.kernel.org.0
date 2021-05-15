Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3EC3815FC
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 07:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhEOFZv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 01:25:51 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:43759 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEOFZu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 01:25:50 -0400
Received: by mail-ej1-f45.google.com with SMTP id l4so1553733ejc.10
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 22:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f/Vo3vzWm4D00TYgfRuuEzVZKXz3CRt/yuqfwwH8YIU=;
        b=Yy7KfhuZbBHQULcj9oe3N/un0FFiS0hLa0XYNhjbbAoexUPwqogCXKjJPb/bZsq80E
         fqUsREn0X7VJLhyQ/BNdDL/kSiggrUPENH2wG7XpgrDs/MjcUu8U9Re0eBsoMHwHB1a2
         /gxeHDPMC/VhmqedIVdFAMzWOZ5tzpdDIeG1yqSCIfpkK3MCgmexPMscbVc3zHrAG2XC
         5dY/aFqFVKLMQ+zgcAcy/vVehQpZE5v6c89DmhGDtw2xr7bG8cedQN3JModG2NlXRmz9
         R5G+W1yIata97q7U0cKQgfC0R55xFCcj35S76kgSJQrWY3lT7HYidSpGlDw0ajATu4Ne
         3J4g==
X-Gm-Message-State: AOAM533AUFgijxoszQ1W6f95h93KiKmPSEINGoTwjUtUMCVedUd4RTSU
        o+y+uSY0+5WtOfNVAQzhPLg=
X-Google-Smtp-Source: ABdhPJwvfP1drkhLOi+o1WZL+eJ9323MVgRNp8o3OCPnzYBWrwDvAHI0LcagZhbnOoFcGoXpLrERxQ==
X-Received: by 2002:a17:906:b0d:: with SMTP id u13mr8097847ejg.159.1621056276491;
        Fri, 14 May 2021 22:24:36 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id kt21sm4821487ejb.5.2021.05.14.22.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 22:24:35 -0700 (PDT)
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
Subject: [PATCH v2 01/14] PCI: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Sat, 15 May 2021 05:24:21 +0000
Message-Id: <20210515052434.1413236-1-kw@linux.com>
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

