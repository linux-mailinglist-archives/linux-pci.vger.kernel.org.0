Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1AE2E2B14
	for <lists+linux-pci@lfdr.de>; Fri, 25 Dec 2020 11:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgLYKD7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Dec 2020 05:03:59 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:46536 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726198AbgLYKD6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Dec 2020 05:03:58 -0500
X-UUID: cf4929723c7547c7bb0e31ff855ebf6a-20201225
X-UUID: cf4929723c7547c7bb0e31ff855ebf6a-20201225
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2052342563; Fri, 25 Dec 2020 18:03:14 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Dec 2020 18:03:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Dec 2020 18:03:09 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sj Huang <sj.huang@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        <youlin.pei@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <qizhong.cheng@mediatek.com>, <sin_jieyang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <drinkcat@chromium.org>
Subject: [v6,2/4] PCI: Export pci_pio_to_address() for module use
Date:   Fri, 25 Dec 2020 18:03:06 +0800
Message-ID: <20201225100308.27052-3-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201225100308.27052-1-jianjun.wang@mediatek.com>
References: <20201225100308.27052-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This interface will be used by PCI host drivers for PIO translation,
export it to support compiling those drivers as kernel modules.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 drivers/pci/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6d4d5a2f923d..3de714db2557 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4016,6 +4016,7 @@ phys_addr_t pci_pio_to_address(unsigned long pio)
 
 	return address;
 }
+EXPORT_SYMBOL(pci_pio_to_address);
 
 unsigned long __weak pci_address_to_pio(phys_addr_t address)
 {
-- 
2.25.1

