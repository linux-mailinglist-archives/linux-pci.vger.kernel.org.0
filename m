Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B07B276F67
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 13:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgIXLJB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 07:09:01 -0400
Received: from mail-bn8nam08on2061.outbound.protection.outlook.com ([40.107.100.61]:62176
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726444AbgIXLJB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 07:09:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZE7r/R0rBVRwUHL1VeGAVaLhZKGdysgboTfmhIkefRYkjAK8+DMDbI7KfEj9fNdEgO3vPxsHZLMl5vxlkJhgD+wZ5LBO0Fc4aTq8Vb/X/3mODWXloFxQXqRt1iauQff0WEDoaoti/06tgXQO4t289YemLAIuhMlUc54MAAcVrWXQ5BpcUHMY0Tx7JhBWjwbSp5Gg0MbVU9lJHo0kejdM9q0eEtMuSKLmRtWICwl+FPEDL+LAnAcCn1AgUXSYZgEIE3LobFeizv13gbRklCOnRjCMHQtP4iRNBuRTmNeiVJ7wW5fNnPbyv5E+G86YL5GnWV+8K5P3ypGdFwG73W4ReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egHxvw+w9N0tvNHpaDO8CSDWOi3GV6GGHWZAPQoRtuc=;
 b=YnY4C0wpZ6ZeLtXZcQy2lB1LS/tj4+lV0VkqGqjw6WawRTo92kvuL4+thjkFANOHXVqYXDxu7IeRmNaontOvq34YI5QhaIXGjTMAQSizeYSPBhKkX7JVk1/O7b+pg4KMHEy2/UMA9hx54b6mAt3ehWCjeLYsrqTeCKd9Zi7HY6P9Bix07ktU67A61ZsYqAh/E0m9UEPKuxwjR56D98f8N8PmLAR1rMnaks12pGaoLtOZJHP7PbfYt+fzT0fQiXJgktOJTkNWve0u9bo/saEskDC9//VGrviJjCo+KxJZtp/CGJhoFpSfo+JcBwCyLAgw6BCmSSCHyS1/5E7hQqT1XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egHxvw+w9N0tvNHpaDO8CSDWOi3GV6GGHWZAPQoRtuc=;
 b=W8ex16ZN48IvWrNgg/3qQVUwbpCePl0Fl4RP4HmmDdxQnkA+/+VgC7CHSV71F3gelXYwuVVp8eNJ7jjt7MtFM/5KqID7r0YJwUc8WK4AAQaFyQsYGQMbhVt9XZprbTujrAKmloX5rUPmQmsJ7+QRuMHjEp58iOUNDsm5D6gY7Bc=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB4698.namprd03.prod.outlook.com (2603:10b6:5:180::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 11:08:55 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3391.027; Thu, 24 Sep 2020
 11:08:55 +0000
Date:   Thu, 24 Sep 2020 19:07:42 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 5/5] PCI: dwc: Move dw_pcie_msi_init() from each users to
 designware host
Message-ID: <20200924190742.76939458@xhacker.debian>
In-Reply-To: <20200924190421.549cb8fc@xhacker.debian>
References: <20200924190421.549cb8fc@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0072.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::36) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0072.jpnprd01.prod.outlook.com (2603:1096:404:2b::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 11:08:43 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 950f8817-b4a3-49a6-84ba-08d8607a3a43
X-MS-TrafficTypeDiagnostic: DM6PR03MB4698:
X-Microsoft-Antispam-PRVS: <DM6PR03MB469846A98C5A031AD91368ADED390@DM6PR03MB4698.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uOBA/EWW6Sn2tsmw18k8nJIRW08dSetQAc8YWMA9aQ8fVxlVQ4+g41omqmKjEhTiy+W1qnrSRvEwrNSff9Ase8AHPSKLZtwqx49Gyv68PLfKL7O73qEM+amypm34hFyhB0AEySuo5dSMkLRAJt7rDCBPEydN+JGAGede3C4JmDWVwpDObiO1jUC4vLR3b2WbuuSQm8tCADjwFjNq77MapoikCbxIvCTMfEEZ2Ag2XP3R16I3A2Tp10QvPcauZQbS7wSjZqAsWWJL9g8CVeTercalZfYqIqBcimi8fbdux6J+/df3cqHhltDy+BYtKGklGPrz1wucSIOOkQ1mlvz1EFzh9tOKTn6eLFoaaYF1/OETJmiiZ38/G4LGwtE41MuI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(39860400002)(376002)(136003)(2906002)(30864003)(86362001)(6506007)(52116002)(7696005)(83380400001)(478600001)(5660300002)(186003)(66556008)(16526019)(956004)(1076003)(26005)(316002)(66476007)(7406005)(66946007)(9686003)(55016002)(8676002)(8936002)(110136005)(4326008)(7416002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RMlcwVeKDKiEtrsFAaYSr1uIYx+ljMIdpOqJ4n8kZbE+1xKsSZlRCVUMA+ev/EgO7x4dO0n1ZueApqf9AHB5TAo6a23nDadZat/RuidMWanoSEhtiZZhiFP/0pNB2QJlSCpmdVbS6shGP7dax+pDgitP3klrMwVl/ncLOUNMQYF4p9otoYQJ3d2MMjsyaAqkCF5C7+cEZMN4nZPM6MDIl6C5AW6edB0jRPTiFrxrQHmCQkcpWVD0CpH4FkMzAG2vNX2VM2j7ppUdys54spK4vdagYdL6lZuFwOJ3BkVdco7s5amBsOPtwwsaDv5gVanevqYZld8r7mg78KwP08YpDk4xHNzitfR9fXtu1rE0FOQ7s9v8WPJnwdztU/7WXH4mgHagmCQWR3xnh/k275grRmnvwYkFbi2SFe8dCbBiBm9IgxZcStF1vSmfo2KCJk9y9XmnZb3UED2nqN7aj1f16WYF7vHZYoATNIHvEMsGi5MkkwhjMYI60NtMQAea1GmNz5ao0ZhwgEw5Cut7yKfCET0zIT3TCTwEf8TuGt9xoV9+p1MjV28eQMj1Zkb7OyEs9yyn2bHJIL8ITRmRO19a9PEX9yiVjxlTJSxG+fuinKlX1vnUMsTHZ5FviMOvlNA325S/KazSCMLmrMwFx6OIUw==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950f8817-b4a3-49a6-84ba-08d8607a3a43
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 11:08:55.6822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPTytS6VDF0pwFMYxJZGwIxIqb7SWCwf77ORKRYIyr9oDX4MVobpNC8gHkda+kK5sH03dQjTvSBW6i5NDgqitw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4698
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, dw_pcie_msi_init() allocates and maps page for msi, then
program the PCIE_MSI_ADDR_LO and PCIE_MSI_ADDR_HI. The Root Complex
may lose power during suspend-to-RAM, so when we resume, we want to
redo the latter but not the former. If designware based driver (for
example, pcie-tegra194.c) calls dw_pcie_msi_init() in resume path, the
previous msi page will be leaked. From another side, except
pci-dra7xx.c we can move the dw_pcie_msi_init() from each users to
designware host, I.E move the msi page allocation and mapping to
dw_pcie_host_init() and move the PCIE_MSI_ADDR_* programming to
dw_pcie_setup_rc(). After this moving, we solve the msi page leakage
as well.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c       |  1 +
 drivers/pci/controller/dwc/pci-exynos.c       |  2 --
 drivers/pci/controller/dwc/pci-imx6.c         |  3 ---
 drivers/pci/controller/dwc/pci-meson.c        |  8 -------
 drivers/pci/controller/dwc/pcie-artpec6.c     | 10 --------
 .../pci/controller/dwc/pcie-designware-host.c | 24 ++++++++++++-------
 .../pci/controller/dwc/pcie-designware-plat.c |  3 ---
 drivers/pci/controller/dwc/pcie-designware.h  |  5 ++++
 drivers/pci/controller/dwc/pcie-histb.c       |  3 ---
 drivers/pci/controller/dwc/pcie-kirin.c       |  3 ---
 drivers/pci/controller/dwc/pcie-qcom.c        |  3 ---
 drivers/pci/controller/dwc/pcie-spear13xx.c   |  1 -
 drivers/pci/controller/dwc/pcie-tegra194.c    |  2 --
 drivers/pci/controller/dwc/pcie-uniphier.c    |  9 +------
 14 files changed, 22 insertions(+), 55 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index dc387724cf08..d8b74389e353 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -210,6 +210,7 @@ static int dra7xx_pcie_host_init(struct pcie_port *pp)
 	dra7xx_pcie_establish_link(pci);
 	dw_pcie_wait_for_link(pci);
 	dw_pcie_msi_init(pp);
+	dw_pcie_msi_config(pp);
 	dra7xx_pcie_enable_interrupts(dra7xx);
 
 	return 0;
diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 8d82c43ae299..9cca0ce79777 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -298,8 +298,6 @@ static void exynos_pcie_msi_init(struct exynos_pcie *ep)
 	struct pcie_port *pp = &pci->pp;
 	u32 val;
 
-	dw_pcie_msi_init(pp);
-
 	/* enable MSI interrupt */
 	val = exynos_pcie_readl(ep->mem_res->elbi_base, PCIE_IRQ_EN_LEVEL);
 	val |= IRQ_MSI_ENABLE;
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5fef2613b223..dba6e351e3df 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -848,9 +848,6 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 	dw_pcie_setup_rc(pp);
 	imx6_pcie_establish_link(imx6_pcie);
 
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dw_pcie_msi_init(pp);
-
 	return 0;
 }
 
diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 4f183b96afbb..cd0d9dd8dd61 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -377,12 +377,6 @@ static int meson_pcie_establish_link(struct meson_pcie *mp)
 	return dw_pcie_wait_for_link(pci);
 }
 
-static void meson_pcie_enable_interrupts(struct meson_pcie *mp)
-{
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dw_pcie_msi_init(&mp->pci.pp);
-}
-
 static int meson_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 				  u32 *val)
 {
@@ -467,8 +461,6 @@ static int meson_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		return ret;
 
-	meson_pcie_enable_interrupts(mp);
-
 	return 0;
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index 97d50bb50f06..af1e6bb28e7a 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -346,15 +346,6 @@ static void artpec6_pcie_deassert_core_reset(struct artpec6_pcie *artpec6_pcie)
 	usleep_range(100, 200);
 }
 
-static void artpec6_pcie_enable_interrupts(struct artpec6_pcie *artpec6_pcie)
-{
-	struct dw_pcie *pci = artpec6_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
-
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dw_pcie_msi_init(pp);
-}
-
 static int artpec6_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -368,7 +359,6 @@ static int artpec6_pcie_host_init(struct pcie_port *pp)
 	dw_pcie_setup_rc(pp);
 	artpec6_pcie_establish_link(pci);
 	dw_pcie_wait_for_link(pci);
-	artpec6_pcie_enable_interrupts(artpec6_pcie);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 7a8adf597803..6603d7c36f2e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -296,11 +296,23 @@ void dw_pcie_msi_deinit(struct pcie_port *pp)
 	}
 }
 
+void dw_pcie_msi_config(struct pcie_port *pp)
+{
+	if (pp->msi_page) {
+		u64 msi_target = (u64)pp->msi_data;
+
+		/* Program the msi_data */
+		dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
+				    lower_32_bits(msi_target));
+		dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
+				    upper_32_bits(msi_target));
+	}
+}
+
 void dw_pcie_msi_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
-	u64 msi_target;
 
 	pp->msi_page = alloc_page(GFP_KERNEL);
 	if (!pp->msi_page) {
@@ -314,15 +326,7 @@ void dw_pcie_msi_init(struct pcie_port *pp)
 		dev_err(dev, "Failed to map MSI data\n");
 		__free_page(pp->msi_page);
 		pp->msi_page = NULL;
-		return;
 	}
-	msi_target = (u64)pp->msi_data;
-
-	/* Program the msi_data */
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
-			    lower_32_bits(msi_target));
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
-			    upper_32_bits(msi_target));
 }
 EXPORT_SYMBOL_GPL(dw_pcie_msi_init);
 
@@ -449,6 +453,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 				irq_set_chained_handler_and_data(pp->msi_irq,
 							    dw_chained_msi_isr,
 							    pp);
+			dw_pcie_msi_init(pp);
 		} else {
 			ret = pp->ops->msi_host_init(pp);
 			if (ret < 0)
@@ -654,6 +659,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
 					    4, ~0);
 		}
+		dw_pcie_msi_config(pp);
 	}
 
 	/* Setup RC BARs */
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 712456f6ce36..9ccf69a3dcf4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -40,9 +40,6 @@ static int dw_plat_pcie_host_init(struct pcie_port *pp)
 	dw_pcie_setup_rc(pp);
 	dw_pcie_wait_for_link(pci);
 
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dw_pcie_msi_init(pp);
-
 	return 0;
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 43b8061e1bec..40d22fe33afe 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -372,6 +372,7 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
 void dw_pcie_msi_init(struct pcie_port *pp);
 void dw_pcie_msi_deinit(struct pcie_port *pp);
+void dw_pcie_msi_config(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
 void dw_pcie_host_deinit(struct pcie_port *pp);
@@ -390,6 +391,10 @@ static inline void dw_pcie_msi_deinit(struct pcie_port *pp)
 {
 }
 
+static inline void dw_pcie_msi_config(struct pcie_port *pp)
+{
+}
+
 static inline void dw_pcie_setup_rc(struct pcie_port *pp)
 {
 }
diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 2a2835746077..fbf53e897ca7 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -196,9 +196,6 @@ static int histb_pcie_host_init(struct pcie_port *pp)
 {
 	histb_pcie_establish_link(pp);
 
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dw_pcie_msi_init(pp);
-
 	return 0;
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index e496f51e0152..d7246995daf0 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -425,9 +425,6 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
 {
 	kirin_pcie_establish_link(pp);
 
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dw_pcie_msi_init(pp);
-
 	return 0;
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 3aac77a295ba..2abbb850fb56 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1281,9 +1281,6 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dw_pcie_msi_init(pp);
-
 	qcom_ep_reset_deassert(pcie);
 
 	ret = qcom_pcie_establish_link(pcie);
diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 62846562da0b..760e27de0082 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -157,7 +157,6 @@ static void spear13xx_pcie_enable_interrupts(struct spear13xx_pcie *spear13xx_pc
 
 	/* Enable MSI interrupt */
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		dw_pcie_msi_init(pp);
 		writel(readl(&app_reg->int_mask) |
 				MSI_CTRL_INT, &app_reg->int_mask);
 	}
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 70498689d0c0..b51fe136d345 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -783,8 +783,6 @@ static void tegra_pcie_enable_msi_interrupts(struct pcie_port *pp)
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	u32 val;
 
-	dw_pcie_msi_init(pp);
-
 	/* Enable MSI interrupt generation */
 	val = appl_readl(pcie, APPL_INTR_EN_L0_0);
 	val |= APPL_INTR_EN_L0_0_SYS_MSI_INTR_EN;
diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index 3a7f403b57b8..d7b465b669f4 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -318,14 +318,7 @@ static int uniphier_pcie_host_init(struct pcie_port *pp)
 	uniphier_pcie_irq_enable(priv);
 
 	dw_pcie_setup_rc(pp);
-	ret = uniphier_pcie_establish_link(pci);
-	if (ret)
-		return ret;
-
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dw_pcie_msi_init(pp);
-
-	return 0;
+	return uniphier_pcie_establish_link(pci);
 }
 
 static const struct dw_pcie_host_ops uniphier_pcie_host_ops = {
-- 
2.28.0

