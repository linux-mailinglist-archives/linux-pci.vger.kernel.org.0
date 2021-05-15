Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9AF381609
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 07:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbhEOF0E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 01:26:04 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:45055 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbhEOF0D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 01:26:03 -0400
Received: by mail-ed1-f50.google.com with SMTP id t15so828373edr.11
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 22:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l65J0VP8+dF+CzFmmf34XzBwKUAccEC4aN+sTYjEOtI=;
        b=hxF7q4W3+81vtr9Pf/coQ/wqxL4lziDEj9lHkM+bAQ1gjbiN50Xr188g0kc6p0Ab6V
         WWfblyT/Np6E7+0jGbHxH2f4YkL/7u8MPv9OOGUKuVVsXglc46SZDXoGd9exeg+Ds9nx
         +HusXOkl/hBlI1MDD0AjQBY49yi+69weiW2VHOtX3mjb8wYetnDksq3DM2EQderQmubi
         +sAgDtrhF1SSbvPpiFkXJV+E4R7FiRFSv42bFBU8JIjsTxZkQK7zVBt580K/D0o5vI9u
         pIHd6HaPBMon+t8OeRf0tCNUzk29KT949A4oa3WLfg6iY3HfZQpUy04Jt2pMYXfI67A5
         E5Dg==
X-Gm-Message-State: AOAM530rXAjheyD8rd5mtatdQZDeoPSIYZPKYhduRMLQVwm4wfO/Hdiw
        B8Xi0jWRPtQ51DjDaXsYatc=
X-Google-Smtp-Source: ABdhPJxKOWt67s3c4arbmA4eCFVxbLX2nJU5TzBTB1JhkMEU3nW9uORpfOz85iSHSHEdXWViuNcVeA==
X-Received: by 2002:a50:fc0b:: with SMTP id i11mr61231380edr.259.1621056289994;
        Fri, 14 May 2021 22:24:49 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id kt21sm4821487ejb.5.2021.05.14.22.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 22:24:49 -0700 (PDT)
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
Subject: [PATCH v2 14/14] PCI/sysfs: Only show value when driver_override is not NULL
Date:   Sat, 15 May 2021 05:24:34 +0000
Message-Id: <20210515052434.1413236-14-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515052434.1413236-1-kw@linux.com>
References: <20210515052434.1413236-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Only expose the value of the "driver_override" variable through the
corresponding sysfs object when a value is actually set.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5d63df7c1820..4e9f582ca10f 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -580,10 +580,11 @@ static ssize_t driver_override_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	ssize_t len;
+	ssize_t len = 0;
 
 	device_lock(dev);
-	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
+	if (pdev->driver_override)
+		len = sysfs_emit(buf, "%s\n", pdev->driver_override);
 	device_unlock(dev);
 	return len;
 }
-- 
2.31.1

