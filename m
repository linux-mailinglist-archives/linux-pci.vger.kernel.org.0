Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8FA353344
	for <lists+linux-pci@lfdr.de>; Sat,  3 Apr 2021 11:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhDCJQ2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Apr 2021 05:16:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15474 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbhDCJQ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Apr 2021 05:16:27 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FCB7X193bzyNgd;
        Sat,  3 Apr 2021 17:14:16 +0800 (CST)
Received: from linux-ioko.site (10.78.228.23) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sat, 3 Apr 2021 17:16:18 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH 3/4] PCI/IOV: Enable 10-Bit tag support for PCIe VF devices
Date:   Sat, 3 Apr 2021 16:54:18 +0800
Message-ID: <1617440059-2478-4-git-send-email-liudongdong3@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1617440059-2478-1-git-send-email-liudongdong3@huawei.com>
References: <1617440059-2478-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.78.228.23]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable VF 10-Bit Tag Requester when it's upstream component support
10-bit Tag Completer.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 drivers/pci/iov.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 4afd4ee..9bff76b 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -537,6 +537,10 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 
 	pci_iov_set_numvfs(dev, nr_virtfn);
 	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
+	if ((iov->cap & PCI_SRIOV_CAP_VF_10BIT_TAG_REQ) &&
+	    dev->ext_10bit_tag_comp_path)
+		iov->ctrl |= PCI_SRIOV_CTRL_VF_10BIT_TAG_REQ_EN;
+
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
 	msleep(100);
@@ -553,6 +557,8 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 
 err_pcibios:
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
+	if (iov->ctrl & PCI_SRIOV_CTRL_VF_10BIT_TAG_REQ_EN)
+		iov->ctrl &= ~PCI_SRIOV_CTRL_VF_10BIT_TAG_REQ_EN;
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
 	ssleep(1);
@@ -585,6 +591,8 @@ static void sriov_disable(struct pci_dev *dev)
 
 	sriov_del_vfs(dev);
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
+	if (iov->ctrl & PCI_SRIOV_CTRL_VF_10BIT_TAG_REQ_EN)
+		iov->ctrl &= ~PCI_SRIOV_CTRL_VF_10BIT_TAG_REQ_EN;
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
 	ssleep(1);
-- 
1.9.1

