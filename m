Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D9A26BA26
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 04:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgIPC26 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 22:28:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12717 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726402AbgIPC2A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Sep 2020 22:28:00 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6181BEED522A6A6B5DFE;
        Wed, 16 Sep 2020 10:27:58 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 10:27:50 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] PCI: tegra: convert to use DEFINE_SEQ_ATTRIBUTE macro
Date:   Wed, 16 Sep 2020 10:50:25 +0800
Message-ID: <20200916025025.3992783-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/pci/controller/pci-tegra.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index c1d34353c29b..556c30a718f0 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2564,36 +2564,14 @@ static int tegra_pcie_ports_seq_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-static const struct seq_operations tegra_pcie_ports_seq_ops = {
+static const struct seq_operations tegra_pcie_ports_sops = {
 	.start = tegra_pcie_ports_seq_start,
 	.next = tegra_pcie_ports_seq_next,
 	.stop = tegra_pcie_ports_seq_stop,
 	.show = tegra_pcie_ports_seq_show,
 };
 
-static int tegra_pcie_ports_open(struct inode *inode, struct file *file)
-{
-	struct tegra_pcie *pcie = inode->i_private;
-	struct seq_file *s;
-	int err;
-
-	err = seq_open(file, &tegra_pcie_ports_seq_ops);
-	if (err)
-		return err;
-
-	s = file->private_data;
-	s->private = pcie;
-
-	return 0;
-}
-
-static const struct file_operations tegra_pcie_ports_ops = {
-	.owner = THIS_MODULE,
-	.open = tegra_pcie_ports_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = seq_release,
-};
+DEFINE_SEQ_ATTRIBUTE(tegra_pcie_ports);
 
 static void tegra_pcie_debugfs_exit(struct tegra_pcie *pcie)
 {
@@ -2610,7 +2588,7 @@ static int tegra_pcie_debugfs_init(struct tegra_pcie *pcie)
 		return -ENOMEM;
 
 	file = debugfs_create_file("ports", S_IFREG | S_IRUGO, pcie->debugfs,
-				   pcie, &tegra_pcie_ports_ops);
+				   pcie, &tegra_pcie_ports_fops);
 	if (!file)
 		goto remove;
 
-- 
2.25.1

