Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0858738B00E
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 15:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239093AbhETNem (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 09:34:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4560 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239828AbhETNeT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 May 2021 09:34:19 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fm9b51bzVzqTQW;
        Thu, 20 May 2021 21:30:09 +0800 (CST)
Received: from dggeml759-chm.china.huawei.com (10.1.199.138) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 21:32:55 +0800
Received: from localhost.localdomain (10.175.102.38) by
 dggeml759-chm.china.huawei.com (10.1.199.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 20 May 2021 21:32:55 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] PCI: tegra: Fix build warnings when CONFIG_PCIEASPM is not set
Date:   Thu, 20 May 2021 13:42:09 +0000
Message-ID: <20210520134209.1667244-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeml759-chm.china.huawei.com (10.1.199.138)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix build warning when CONFIG_PCIEASPM is not set:

drivers/pci/controller/dwc/pcie-tegra194.c:259:18: warning:
 'event_cntr_data_offset' defined but not used [-Wunused-const-variable=]
  259 | static const u32 event_cntr_data_offset[] = {
      |                  ^~~~~~~~~~~~~~~~~~~~~~
drivers/pci/controller/dwc/pcie-tegra194.c:250:18: warning:
 'event_cntr_ctrl_offset' defined but not used [-Wunused-const-variable=]
  250 | static const u32 event_cntr_ctrl_offset[] = {
      |                  ^~~~~~~~~~~~~~~~~~~~~~
drivers/pci/controller/dwc/pcie-tegra194.c:243:27: warning:
 'pcie_gen_freq' defined but not used [-Wunused-const-variable=]
  243 | static const unsigned int pcie_gen_freq[] = {
      |                           ^~~~~~~~~~~~~

Fix it by only define then when CONFIG_PCIEASPM is set.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index bafd2c6ab3c2..b80dd071e90d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -240,6 +240,7 @@
 #define EP_STATE_DISABLED	0
 #define EP_STATE_ENABLED	1
 
+#if defined(CONFIG_PCIEASPM)
 static const unsigned int pcie_gen_freq[] = {
 	GEN1_CORE_CLK_FREQ,
 	GEN2_CORE_CLK_FREQ,
@@ -264,6 +265,7 @@ static const u32 event_cntr_data_offset[] = {
 	0x1c8,
 	0x1dc
 };
+#endif
 
 struct tegra_pcie_dw {
 	struct device *dev;

