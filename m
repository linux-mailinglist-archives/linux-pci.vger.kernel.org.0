Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A085654CE08
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 18:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbiFOQNA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 12:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348685AbiFOQMx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 12:12:53 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C9A6479;
        Wed, 15 Jun 2022 09:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=X1Y+xHoeQH3UW63rjymiD/emNoqwBnemSVoIxTF9EbY=; b=iKgX6plSnGYTUQgEz3h2eQ8oq4
        FGlAIFJWTusbVwsUGEKQv5w3YldIr+Zb7y9e5Tci57QG4okfn/WNYoSJSPedAWtRsJ317QnqZ3tYN
        B1fywGUu5iwDLF9GPEgBC7jVnfl/bzFg+cc/N6mZ6JQngmxQwJYFT1EsGSRC6XIG1doRvnySpVRU/
        tzfXsXC/u1Ur26GJQGnmxT26Dpy7yBQ61LA/ooaFX1WIMUL63WFzcYKEzecykYtWm5V8bVzy+p78C
        Z+iMAawOzUWIvBjOXPztbfswoP+njdZ1jiGYb3TqxWthTb6w8cx/ik5VmwwPqeARrQ2tc76XIBIjc
        0eUneuvg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1VdO-0084iQ-Ox; Wed, 15 Jun 2022 10:12:47 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1VdJ-0004b4-QT; Wed, 15 Jun 2022 10:12:41 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 15 Jun 2022 10:12:33 -0600
Message-Id: <20220615161233.17527-22-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615161233.17527-1-logang@deltatee.com>
References: <20220615161233.17527-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v7 21/21] nvme-pci: allow mmaping the CMB in userspace
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Allow userspace to obtain CMB memory by mmaping the controller's
char device. The mmap call allocates and returns a hunk of CMB memory,
(the offset is ignored) so userspace does not have control over the
address within the CMB.

A VMA allocated in this way will only be usable by drivers that set
FOLL_PCI_P2PDMA when calling GUP. And inter-device support will be
checked the first time the pages are mapped for DMA.

Currently this is only supported by O_DIRECT to an PCI NVMe device
or through the NVMe passthrough IOCTL.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/core.c | 35 +++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h |  3 +++
 drivers/nvme/host/pci.c  | 23 +++++++++++++++++++++++
 3 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d6e76f2dc293..23fe4b544bf1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3166,6 +3166,7 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 {
 	struct nvme_ctrl *ctrl =
 		container_of(inode->i_cdev, struct nvme_ctrl, cdev);
+	int ret = -EINVAL;
 
 	switch (ctrl->state) {
 	case NVME_CTRL_LIVE:
@@ -3175,13 +3176,25 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 	}
 
 	nvme_get_ctrl(ctrl);
-	if (!try_module_get(ctrl->ops->module)) {
-		nvme_put_ctrl(ctrl);
-		return -EINVAL;
-	}
+	if (!try_module_get(ctrl->ops->module))
+		goto err_put_ctrl;
 
 	file->private_data = ctrl;
+
+	if (ctrl->ops->cdev_file_open) {
+		ret = ctrl->ops->cdev_file_open(ctrl, file);
+		if (ret)
+			goto err_put_mod;
+	}
+
 	return 0;
+
+err_put_mod:
+	module_put(ctrl->ops->module);
+err_put_ctrl:
+	nvme_put_ctrl(ctrl);
+	return ret;
+
 }
 
 static int nvme_dev_release(struct inode *inode, struct file *file)
@@ -3189,11 +3202,24 @@ static int nvme_dev_release(struct inode *inode, struct file *file)
 	struct nvme_ctrl *ctrl =
 		container_of(inode->i_cdev, struct nvme_ctrl, cdev);
 
+	if (ctrl->ops->cdev_file_release)
+		ctrl->ops->cdev_file_release(file);
+
 	module_put(ctrl->ops->module);
 	nvme_put_ctrl(ctrl);
 	return 0;
 }
 
+static int nvme_dev_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct nvme_ctrl *ctrl = file->private_data;
+
+	if (!ctrl->ops->mmap_cmb)
+		return -ENODEV;
+
+	return ctrl->ops->mmap_cmb(ctrl, vma);
+}
+
 static const struct file_operations nvme_dev_fops = {
 	.owner		= THIS_MODULE,
 	.open		= nvme_dev_open,
@@ -3201,6 +3227,7 @@ static const struct file_operations nvme_dev_fops = {
 	.unlocked_ioctl	= nvme_dev_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.uring_cmd	= nvme_dev_uring_cmd,
+	.mmap		= nvme_dev_mmap,
 };
 
 static ssize_t nvme_sysfs_reset(struct device *dev,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 957f79420cf3..44ff05d8e24d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -503,6 +503,9 @@ struct nvme_ctrl_ops {
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
 	bool (*supports_pci_p2pdma)(struct nvme_ctrl *ctrl);
+	int (*cdev_file_open)(struct nvme_ctrl *ctrl, struct file *file);
+	void (*cdev_file_release)(struct file *file);
+	int (*mmap_cmb)(struct nvme_ctrl *ctrl, struct vm_area_struct *vma);
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 52b52a7efa9a..8ef3752b7ddb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2972,6 +2972,26 @@ static bool nvme_pci_supports_pci_p2pdma(struct nvme_ctrl *ctrl)
 	return dma_pci_p2pdma_supported(dev->dev);
 }
 
+static int nvme_pci_cdev_file_open(struct nvme_ctrl *ctrl, struct file *file)
+{
+	struct pci_dev *pdev = to_pci_dev(to_nvme_dev(ctrl)->dev);
+
+	return pci_p2pdma_file_open(pdev, file);
+}
+
+static void nvme_pci_cdev_file_release(struct file *file)
+{
+	pci_p2pdma_file_release(file);
+}
+
+static int nvme_pci_mmap_cmb(struct nvme_ctrl *ctrl,
+			     struct vm_area_struct *vma)
+{
+	struct pci_dev *pdev = to_pci_dev(to_nvme_dev(ctrl)->dev);
+
+	return pci_mmap_p2pmem(pdev, vma);
+}
+
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.name			= "pcie",
 	.module			= THIS_MODULE,
@@ -2983,6 +3003,9 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.submit_async_event	= nvme_pci_submit_async_event,
 	.get_address		= nvme_pci_get_address,
 	.supports_pci_p2pdma	= nvme_pci_supports_pci_p2pdma,
+	.cdev_file_open		= nvme_pci_cdev_file_open,
+	.cdev_file_release	= nvme_pci_cdev_file_release,
+	.mmap_cmb		= nvme_pci_mmap_cmb,
 };
 
 static int nvme_dev_map(struct nvme_dev *dev)
-- 
2.30.2

