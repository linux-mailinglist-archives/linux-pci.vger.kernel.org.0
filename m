Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6307381601
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 07:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhEOFZ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 01:25:56 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:40523 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhEOFZ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 01:25:56 -0400
Received: by mail-ed1-f43.google.com with SMTP id t3so850017edc.7
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 22:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ES7VTSt0mLOOOtyK1uMH/ESz61Of936G331zCp64LY=;
        b=JDQA6nBvPtxRWn/DSVCzYjYjSb3P016ZXgQYrZUIdqw1b/m7op6m2XLuQ4jPRNQgrM
         aLce0SWkgIydaXXxxpJDPXP/8rT4Xzz/CISfLxBIFuAvvtuJEOVn8vtDely0tSZvZgCW
         Tpkn5VMXBY8fY3LxytEr7Es8m0HEOC5KPpQ9GTrXVwxiKZpza7bHG3a3aYBCu0rTwlON
         RDvM957m8wIzXEu1cTkowKICu22cgR5weJGIIvZ3YPntRusfKyFnc9o0RvGkM2FoO78W
         LrmxaJFLJiUUS1T0WErph81SSznqnXAt23WdJv5CaJ5/AYhOLQFIaIJwrZdNamJiLehS
         DV8w==
X-Gm-Message-State: AOAM533Lx1L1xqzOlrvrTd9sRjMucuot6jWoKj+kvT4x6S1PP/An0OUI
        Rxequm71barDd7AB8gzz8gI=
X-Google-Smtp-Source: ABdhPJygPIcpBCKLUs50yfnaIlQr7YwzdjdoLmzwNRzphOsHpcVXycakggcgTJ5RAMyt0x096OU7mw==
X-Received: by 2002:aa7:d893:: with SMTP id u19mr15024467edq.258.1621056281879;
        Fri, 14 May 2021 22:24:41 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id kt21sm4821487ejb.5.2021.05.14.22.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 22:24:41 -0700 (PDT)
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
Subject: [PATCH v2 06/14] PCI/P2PDMA: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Sat, 15 May 2021 05:24:26 +0000
Message-Id: <20210515052434.1413236-6-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515052434.1413236-1-kw@linux.com>
References: <20210515052434.1413236-1-kw@linux.com>
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
---
 drivers/pci/p2pdma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 196382630363..a1351b3e2c4c 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -53,7 +53,7 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 	if (pdev->p2pdma->pool)
 		size = gen_pool_size(pdev->p2pdma->pool);
 
-	return scnprintf(buf, PAGE_SIZE, "%zd\n", size);
+	return sysfs_emit(buf, "%zd\n", size);
 }
 static DEVICE_ATTR_RO(size);
 
@@ -66,7 +66,7 @@ static ssize_t available_show(struct device *dev, struct device_attribute *attr,
 	if (pdev->p2pdma->pool)
 		avail = gen_pool_avail(pdev->p2pdma->pool);
 
-	return scnprintf(buf, PAGE_SIZE, "%zd\n", avail);
+	return sysfs_emit(buf, "%zd\n", avail);
 }
 static DEVICE_ATTR_RO(available);
 
@@ -75,8 +75,7 @@ static ssize_t published_show(struct device *dev, struct device_attribute *attr,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n",
-			 pdev->p2pdma->p2pmem_published);
+	return sysfs_emit(buf, "%d\n", pdev->p2pdma->p2pmem_published);
 }
 static DEVICE_ATTR_RO(published);
 
-- 
2.31.1

