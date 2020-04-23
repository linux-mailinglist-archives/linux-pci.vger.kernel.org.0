Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD621B52F1
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 05:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgDWDMA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Apr 2020 23:12:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45056 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725562AbgDWDL7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Apr 2020 23:11:59 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A1F7F383D15824AF0D7B;
        Thu, 23 Apr 2020 11:11:57 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Apr 2020 11:11:47 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <wangzhou1@hisilicon.com>, <lorenzo.pieralisi@arm.com>,
        <amurray@thegoodpenguin.co.uk>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next v2] PCI: dwc: Make hisi_pcie_platform_ops static
Date:   Thu, 23 Apr 2020 11:18:03 +0800
Message-ID: <1587611883-26960-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix the following sparse warning:

drivers/pci/controller/dwc/pcie-hisi.c:365:21: warning:
symbol 'hisi_pcie_platform_ops' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/pci/controller/dwc/pcie-hisi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-hisi.c b/drivers/pci/controller/dwc/pcie-hisi.c
index 6d9e1b2..11f5ff7 100644
--- a/drivers/pci/controller/dwc/pcie-hisi.c
+++ b/drivers/pci/controller/dwc/pcie-hisi.c
@@ -362,7 +362,7 @@ static int hisi_pcie_platform_init(struct pci_config_window *cfg)
 	return 0;
 }
 
-struct pci_ecam_ops hisi_pcie_platform_ops = {
+static struct pci_ecam_ops hisi_pcie_platform_ops = {
 	.bus_shift    = 20,
 	.init         =  hisi_pcie_platform_init,
 	.pci_ops      = {
-- 
2.6.2

