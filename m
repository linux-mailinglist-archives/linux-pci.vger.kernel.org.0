Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634FD427939
	for <lists+linux-pci@lfdr.de>; Sat,  9 Oct 2021 12:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244725AbhJIKy6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Oct 2021 06:54:58 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13886 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244697AbhJIKyy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Oct 2021 06:54:54 -0400
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HRMGd2rMXz900t;
        Sat,  9 Oct 2021 18:48:09 +0800 (CST)
Received: from SZX1000464847.huawei.com (10.21.59.169) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Sat, 9 Oct 2021 18:52:56 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <helgaas@kernel.org>, <hch@infradead.org>, <kw@linux.com>,
        <logang@deltatee.com>, <leon@kernel.org>,
        <linux-pci@vger.kernel.org>, <rajur@chelsio.com>,
        <hverkuil-cisco@xs4all.nl>
CC:     <linux-media@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH V10 8/8] PCI/IOV: Enable 10-Bit Tag support for PCIe VF devices
Date:   Sat, 9 Oct 2021 18:49:38 +0800
Message-ID: <20211009104938.48225-9-liudongdong3@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20211009104938.48225-1-liudongdong3@huawei.com>
References: <20211009104938.48225-1-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.21.59.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable 10-Bit Tag Requester for the VF devices below the
Root Port that support 10-Bit Tag Completer.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 drivers/pci/iov.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index bd600c15258f..760ee8b939cd 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -692,6 +692,15 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 
 	pci_iov_set_numvfs(dev, nr_virtfn);
 	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
+
+	if ((pcie_tag_config == PCIE_TAG_DEFAULT) &&
+	    (iov->cap & PCI_SRIOV_CAP_VF_10BIT_TAG_REQ) &&
+	    pcie_rp_10bit_tag_cmp_supported(dev))
+		iov->ctrl |= PCI_SRIOV_CTRL_VF_10BIT_TAG_REQ_EN;
+
+	if (pcie_tag_config == PCIE_TAG_PEER2PEER)
+		iov->ctrl &= ~PCI_SRIOV_CTRL_VF_10BIT_TAG_REQ_EN;
+
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
 	msleep(100);
@@ -708,6 +717,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 
 err_pcibios:
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
+	iov->ctrl &= ~PCI_SRIOV_CTRL_VF_10BIT_TAG_REQ_EN;
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
 	ssleep(1);
@@ -740,6 +750,7 @@ static void sriov_disable(struct pci_dev *dev)
 
 	sriov_del_vfs(dev);
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
+	iov->ctrl &= ~PCI_SRIOV_CTRL_VF_10BIT_TAG_REQ_EN;
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
 	ssleep(1);
-- 
2.22.0

