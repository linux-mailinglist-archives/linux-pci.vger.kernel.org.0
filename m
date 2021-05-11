Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27ED037AA46
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 17:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhEKPKZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 11:10:25 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:2301 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbhEKPKX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 11:10:23 -0400
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ffh6h4BSpz19MHt;
        Tue, 11 May 2021 23:05:00 +0800 (CST)
Received: from SZX1000464847.huawei.com (10.21.59.169) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 11 May 2021 23:09:14 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <helgaas@kernel.org>, <hch@infradead.org>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH V2 4/5] PCI/IOV: Enable 10-Bit tag support for PCIe VF devices
Date:   Tue, 11 May 2021 23:09:03 +0800
Message-ID: <1620745744-91316-5-git-send-email-liudongdong3@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620745744-91316-1-git-send-email-liudongdong3@huawei.com>
References: <1620745744-91316-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.21.59.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
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
index afc06e6..3eb4348 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -627,6 +627,10 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 
 	pci_iov_set_numvfs(dev, nr_virtfn);
 	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
+	if ((iov->cap & PCI_SRIOV_CAP_VF_10BIT_TAG_REQ) &&
+	    dev->ext_10bit_tag)
+		iov->ctrl |= PCI_SRIOV_CTRL_VF_10BIT_TAG_REQ_EN;
+
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
 	msleep(100);
@@ -643,6 +647,8 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 
 err_pcibios:
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
+	if (iov->ctrl & PCI_SRIOV_CTRL_VF_10BIT_TAG_REQ_EN)
+		iov->ctrl &= ~PCI_SRIOV_CTRL_VF_10BIT_TAG_REQ_EN;
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
 	ssleep(1);
@@ -675,6 +681,8 @@ static void sriov_disable(struct pci_dev *dev)
 
 	sriov_del_vfs(dev);
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
+	if (iov->ctrl & PCI_SRIOV_CTRL_VF_10BIT_TAG_REQ_EN)
+		iov->ctrl &= ~PCI_SRIOV_CTRL_VF_10BIT_TAG_REQ_EN;
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
 	ssleep(1);
-- 
2.7.4

