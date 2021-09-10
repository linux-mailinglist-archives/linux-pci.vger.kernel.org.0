Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3078B407280
	for <lists+linux-pci@lfdr.de>; Fri, 10 Sep 2021 22:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhIJU1p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Sep 2021 16:27:45 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:36684 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbhIJU1p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Sep 2021 16:27:45 -0400
Received: by mail-lf1-f42.google.com with SMTP id c8so6470639lfi.3
        for <linux-pci@vger.kernel.org>; Fri, 10 Sep 2021 13:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ci/PBCckgs64eaxt+gMPCPMWq/pAK0//yJPrgBnmYXs=;
        b=sBshwizvs8kBobki3x+rXy+x0hI47t3PQHBvN5GQrFf/dzNtCg/EDkzGqsP5TMW0ap
         Z1hqZZO+KrcRhN0kiPMQ/5vrZtg+uT1je0dDkQ7VXqeGcPARWD0kYy+ooWlumOdGoelH
         3Ixqua0E3JNo/eWmRsDOkZYdUlVjPqE7mlS13hrkY7DiqyMLyHOFG3URUSgwZcDm1eCv
         V4tsgWlyNAHiCoArssG8GBXjIjbakJRuQA37LSd0stSrXF88rrA8GDQU66MUjTabSXCv
         2oS3PHWcnu9GikmZ09FXXip7qVMk+QlTDNAFxSMVILn+z6RNgVnkcO3ha14+4CqX/Kty
         EluQ==
X-Gm-Message-State: AOAM533KJBIhCu4TEYoZzf+zJo4jCx/LupQ1p3mFFgQXSHWxOYOA809W
        NEKBma3BKDvt9DYRKgTSTN4=
X-Google-Smtp-Source: ABdhPJxUMPMgd5IGic50hPkJc6HTX7z7vXTq2n5XmwHoFBGY3T9iGmchNvVbjDu6tzTHsluMwwdh6Q==
X-Received: by 2002:a19:c757:: with SMTP id x84mr5122051lff.134.1631305592836;
        Fri, 10 Sep 2021 13:26:32 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id a22sm657667lfb.17.2021.09.10.13.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:26:32 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 7/7] PCI/sysfs: Update code to match the preferred style
Date:   Fri, 10 Sep 2021 20:26:23 +0000
Message-Id: <20210910202623.2293708-8-kw@linux.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910202623.2293708-1-kw@linux.com>
References: <20210910202623.2293708-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update code to match the preferred style while making the bitwise
operations less ambiguous with added extra parentheses surrounding the
expression.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 17535f4028af..fdfe4aa70875 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1013,7 +1013,7 @@ int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vma,
 	unsigned long nr, start, size;
 	resource_size_t pci_start = 0, pci_end;
 
-	if (pci_resource_len(pdev, resno) == 0)
+	if (!pci_resource_len(pdev, resno))
 		return 0;
 	nr = vma_pages(vma);
 	start = vma->vm_pgoff;
@@ -1055,13 +1055,13 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 	    ((res->flags & IORESOURCE_IO) && arch_can_pci_mmap_io())))
 		return -EIO;
 
-	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
+	if ((res->flags & IORESOURCE_MEM) && iomem_is_exclusive(res->start))
 		return -EINVAL;
 
 	if (!pci_mmap_fits(pdev, bar, vma, PCI_MMAP_SYSFS))
 		return -EINVAL;
 
-	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
+	mmap_type = (res->flags & IORESOURCE_MEM) ? pci_mmap_mem : pci_mmap_io;
 
 	return pci_mmap_resource_range(pdev, bar, vma, mmap_type, write_combine);
 }
-- 
2.33.0

