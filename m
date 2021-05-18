Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4BF387045
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 05:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242900AbhERDmf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 23:42:35 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:33526 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241948AbhERDmd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 23:42:33 -0400
Received: by mail-lj1-f173.google.com with SMTP id o8so9845554ljp.0
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 20:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ifk2YkSOqQpMJ9eIsFLnDFbL8FFLwhL1Jb7MgPI/dEI=;
        b=SIoCjx86iOBaYux5zz808f46QfGMDH4g7Xw1YHvS2q1txBuVHKM/5LeX95Kj5MWzvx
         B4dErXetFkRpXR1RuFU7Pr9Pk8Tc1oX5IbamXmu8Sh1uAIKfXFHSxWSRqSBF84wqrFPO
         u+ra5WRyL5sx1aOEX9QsnY8Mhkk1/cCpwIfhxQBZcIkTfoF2w5EyOyAhIDZFIfrdadEN
         Rdm4lB92QyFji/7e4uZxtmUJV1ka2BcZAVID2wvC1RVjGdA3gniCdb+izj9OZE7GTc5x
         lVj/DjcdiK9BhGGl7MVx9QRYrT4VK8hTUlazfLRJKBg83DKOcg5YShj2QFnh+EQfkjTn
         EBKw==
X-Gm-Message-State: AOAM533tCLRtCcRo8GBSAu4do62qLM5sRv119S6npxh6DLm7o57+Qa3t
        PILQGOQN3KqfO6+Y4otKC30=
X-Google-Smtp-Source: ABdhPJzPUZOjS9/ZOs/DECq+1zNXpZQh4Vaf4qlznc+fZJxcJLIQnk5sYJYW+bkteJEXjFM1IG56gw==
X-Received: by 2002:a2e:5c83:: with SMTP id q125mr2287393ljb.447.1621309275684;
        Mon, 17 May 2021 20:41:15 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j23sm419112lfm.276.2021.05.17.20.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 20:41:15 -0700 (PDT)
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
Subject: [PATCH v3 05/14] PCI/IOV: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Tue, 18 May 2021 03:41:00 +0000
Message-Id: <20210518034109.158450-5-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518034109.158450-1-kw@linux.com>
References: <20210518034109.158450-1-kw@linux.com>
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

 drivers/pci/iov.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index afc06e6ce115..a71258347323 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -346,7 +346,7 @@ static ssize_t sriov_totalvfs_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%u\n", pci_sriov_get_totalvfs(pdev));
+	return sysfs_emit(buf, "%u\n", pci_sriov_get_totalvfs(pdev));
 }
 
 static ssize_t sriov_numvfs_show(struct device *dev,
@@ -361,7 +361,7 @@ static ssize_t sriov_numvfs_show(struct device *dev,
 	num_vfs = pdev->sriov->num_VFs;
 	device_unlock(&pdev->dev);
 
-	return sprintf(buf, "%u\n", num_vfs);
+	return sysfs_emit(buf, "%u\n", num_vfs);
 }
 
 /*
@@ -435,7 +435,7 @@ static ssize_t sriov_offset_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%u\n", pdev->sriov->offset);
+	return sysfs_emit(buf, "%u\n", pdev->sriov->offset);
 }
 
 static ssize_t sriov_stride_show(struct device *dev,
@@ -444,7 +444,7 @@ static ssize_t sriov_stride_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%u\n", pdev->sriov->stride);
+	return sysfs_emit(buf, "%u\n", pdev->sriov->stride);
 }
 
 static ssize_t sriov_vf_device_show(struct device *dev,
@@ -453,7 +453,7 @@ static ssize_t sriov_vf_device_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%x\n", pdev->sriov->vf_device);
+	return sysfs_emit(buf, "%x\n", pdev->sriov->vf_device);
 }
 
 static ssize_t sriov_drivers_autoprobe_show(struct device *dev,
@@ -462,7 +462,7 @@ static ssize_t sriov_drivers_autoprobe_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%u\n", pdev->sriov->drivers_autoprobe);
+	return sysfs_emit(buf, "%u\n", pdev->sriov->drivers_autoprobe);
 }
 
 static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
-- 
2.31.1

