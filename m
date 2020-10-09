Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AB628856D
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 10:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732840AbgJIIik (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 04:38:40 -0400
Received: from mail-eopbgr760082.outbound.protection.outlook.com ([40.107.76.82]:14720
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729347AbgJIIij (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Oct 2020 04:38:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYFWZw+tdyHfG1+Ec+QtVjpwY1dFQKdM3NL0WeBjwgS5VuuWj6g3mlW4EjN2GYngtoSS1jAqVD5wlT/KtwSPaFO/4O1flsPcscBcjcnndhoK6ksvGccjO/QxbYj+/u613JmFQius4ir/vZCuXdh3jWalVYNmmtjEfzB9zlI1ME4GNP18e8WSyavEnoCpaaJgp4QgWsdQD/haDhPgP21Zb49m82+StttbwEdasEmmkTscPF/mHuDg+tOc+VONavvH4/dbQFTbI+abUvZbv3sVYfIJ7mRAEh1aS/lp0Uc8vUREVKlg9wT6IYq00f9NlyaKKSFQB0oYo9YUmDYmwYSeEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eXqIw4mzCOu6TLn52Dz+PDp7w1flwlg7x1kYcufS98=;
 b=CuesTJRTpZJfUfmlxQZ3x5nND2F8SHDkNlLi55vnRwK1QkeP2FMyzmX4l6zfDMoK+iLG0c4yt+/AoVVhqp050EGg1TelXHH2E2WzZVm8QzPNgftrqx5Sd9WswnngnDAlFYh/zJvS/i+l1u/RWHneinPmEDKnncYDDLAg1j8Ios1NLIquuBBLnOTpCwoVYidy7262h4fhhbJcwxKF+aDNKDc0cs9vUXy2p3tYeSNyyxn8UCg8VG5cqNqeDwX3rnjDal9fiVRBxa5njS2c2ygm4LnyqLY7izOTM44cTbTx0abz28Z3+kb9fAocSZcY/tFCnTNtM1mW62ODY3yBcpi7SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eXqIw4mzCOu6TLn52Dz+PDp7w1flwlg7x1kYcufS98=;
 b=oaNrBydqi6C2LH3Ah2HnPAVXJe2bSLoCtUca+6X2VS2mTVHIqVzyeEzjJ+YnMB2K06/fzIVs8MLNRmfdyM0YZA2qOhaFwLuQSuAPV8vs6vYgfVSIpi5GlufywQYpdUXXAyyia7By8tMKyNLb45nIpls8E8MsICYlqb7Erq5NVhg=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
 by BN8PR03MB4978.namprd03.prod.outlook.com (2603:10b6:408:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Fri, 9 Oct
 2020 08:38:34 +0000
Received: from BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::8056:3100:523:68d]) by BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::8056:3100:523:68d%7]) with mapi id 15.20.3455.023; Fri, 9 Oct 2020
 08:38:33 +0000
Date:   Fri, 9 Oct 2020 16:37:47 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
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
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        "Kevin Hilman" <khilman@baylibre.com>,
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
        "Kunihiko Hayashi" <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: [PATCH] PCI: dwc: Move dw_pcie_msi_init() from each users to
 designware host
Message-ID: <20201009163747.64b1de4a@xhacker.debian>
In-Reply-To: <435c8cf8-8f4a-c491-4aca-3ec5b7abe49a@nvidia.com>
References: <20200924190421.549cb8fc@xhacker.debian>
        <b977d9b4-cc98-e817-0d51-8f2c6ba1445d@nvidia.com>
        <20201006143647.3f989340@xhacker.debian>
        <435c8cf8-8f4a-c491-4aca-3ec5b7abe49a@nvidia.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0200.jpnprd01.prod.outlook.com (2603:1096:403::30)
 To BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY1PR01CA0200.jpnprd01.prod.outlook.com (2603:1096:403::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend Transport; Fri, 9 Oct 2020 08:38:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fac939c5-1c35-47b0-44ef-08d86c2eb4d0
X-MS-TrafficTypeDiagnostic: BN8PR03MB4978:
X-Microsoft-Antispam-PRVS: <BN8PR03MB4978A30FDEFE229BC4FE98A6ED080@BN8PR03MB4978.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Moz4ARLpI0/gm3PrYYH1dW6Oxcn6n9+mazMyp+rBoXnYEZ5KBINXmK2EHVIz7Ik3/oCmgAKwtNPK3OUoQ1s6yVkOz6J+iA8uS0i/e8B+tQaHYUdPIbNsWXz8LAXYjEfD0tBA73KBo81+HdBTDKDMZyWVDUPEzsw6y0k6giyE68i+DKbOoyaurDsWjji+wYW7r5ZjTAVv7buAZlnPyU2R0Ii6UXDTlfESi18ZsdY7pgBVHAPTLWgMsKqwnzLloKR0DvNT61E8sxYPDS8NkzgIWBLjsF0bvwF0VPqAs3LbV9jggKUV8rXnhtI9Dr7q8I+szVfPKu4r5RSc7bmHKhaSvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4547.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(39850400004)(346002)(9686003)(55016002)(66476007)(6916009)(6506007)(66556008)(66946007)(478600001)(956004)(5660300002)(7406005)(26005)(7416002)(86362001)(1076003)(54906003)(52116002)(7696005)(8676002)(6666004)(2906002)(8936002)(186003)(316002)(83380400001)(4326008)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GACrIvmrtosVZOxk1KJtilgpQaYso1R8wqF5Xrv1Pvn5kZpzxosfejBpKxAu9vKZQUeI/dsI0R2VjTxbxE6fIXEAyT6iG+Y9cOIr4w3oi24yIAKA1UDCTzj24wJ+/VILz/GC32UXucSbnlXCvHTTOLIxSSMSjGJxigj9gOW/1ec5RUc2CqKxHIJDAfXzM7Ua4lO6Z+NdKQRbilgYbV09CaL7D1DylDYt+l/SPuELr40WxDkaJU4UMuyfgUxFvsE+E1TYmaTNCQX5lTyHHNs00/eENLN5uIOz2vLN7XUucCjCFcTVlcU0fbhtNoXF5nSqNrOVnz6cSF/fIWaPZy87deyBtJhku9G3ej3t/MPrm9V9okh77XusXeWRgUHvB7ARU2OQp/x114iAnSS3DfyzqcQtlZ8v360qLrj5m586Vf+syH6un07nZmS34Wqd7ymG1o+/LAGiQJa2YjMjAelI3j9uud4iHeYhCFNLIuDnDJhaxqsw2e8yBmTNb2EDbvEtCGX78sEU2C+7q5rQLp6PQjHTMJJIyrAyVczmU+tKUAJ2BUMMQjre0d58ItHvekmPXYJTq6mSgE9D1eOwb3NL/LxGgatXC3rgQkMawOS98D8LiH3YjV9nuGNpnK/sRktWL8a0W555OKezHJhmrgm8Mw==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac939c5-1c35-47b0-44ef-08d86c2eb4d0
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4547.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 08:38:33.5146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZKbFB0RuGdSjrqruT4jktcVyL1lY6HRJ3S6hsobSfGWf6UWlgxUmnRNxueYrKwJq9Sl5PImgddarOBuKWPsTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4978
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Let the designware host take care the integrated msi init rather
than duplicate dw_pcie_msi_init() in each users.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---

Hi Vidya,

After V7, only this patch is left, others in v2 are not needed. There's one
more clean up chance -- we can also move dw_pcie_free_msi() to designware
host and make it static if we can clean up dra7xx. I see Rob is working on
some larger MSI clean-ups, maybe this will be done in his clean-ups.

Thanks

 drivers/pci/controller/dwc/pci-dra7xx.c           | 1 -
 drivers/pci/controller/dwc/pci-exynos.c           | 2 --
 drivers/pci/controller/dwc/pci-imx6.c             | 1 -
 drivers/pci/controller/dwc/pci-meson.c            | 2 --
 drivers/pci/controller/dwc/pcie-artpec6.c         | 1 -
 drivers/pci/controller/dwc/pcie-designware-host.c | 5 +++--
 drivers/pci/controller/dwc/pcie-designware-plat.c | 1 -
 drivers/pci/controller/dwc/pcie-designware.h      | 5 -----
 drivers/pci/controller/dwc/pcie-histb.c           | 1 -
 drivers/pci/controller/dwc/pcie-kirin.c           | 1 -
 drivers/pci/controller/dwc/pcie-qcom.c            | 1 -
 drivers/pci/controller/dwc/pcie-spear13xx.c       | 4 +---
 drivers/pci/controller/dwc/pcie-tegra194.c        | 2 --
 drivers/pci/controller/dwc/pcie-uniphier.c        | 2 --
 14 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 6d012d2b1e90..a5edaa6b6b58 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -185,7 +185,6 @@ static int dra7xx_pcie_host_init(struct pcie_port *pp)
 
 	dra7xx_pcie_establish_link(pci);
 	dw_pcie_wait_for_link(pci);
-	dw_pcie_msi_init(pp);
 	dra7xx_pcie_enable_interrupts(dra7xx);
 
 	return 0;
diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 242683cde04a..97c166885277 100644
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
index 337c74cbdfdb..cf52eb5d7d2e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -836,7 +836,6 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 	imx6_setup_phy_mpll(imx6_pcie);
 	dw_pcie_setup_rc(pp);
 	imx6_pcie_establish_link(imx6_pcie);
-	dw_pcie_msi_init(pp);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 33deb290c4e7..11bfc42fac1c 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -387,8 +387,6 @@ static int meson_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		return ret;
 
-	dw_pcie_msi_init(pp);
-
 	return 0;
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index 929448e9e0bc..73d4bf99c737 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -331,7 +331,6 @@ static int artpec6_pcie_host_init(struct pcie_port *pp)
 	dw_pcie_setup_rc(pp);
 	artpec6_pcie_establish_link(pci);
 	dw_pcie_wait_for_link(pci);
-	dw_pcie_msi_init(pp);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d02c7e74738d..7622f114223e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -275,7 +275,7 @@ void dw_pcie_free_msi(struct pcie_port *pp)
 	}
 }
 
-void dw_pcie_msi_init(struct pcie_port *pp)
+static void dw_pcie_msi_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	u64 msi_target = (u64)pp->msi_data;
@@ -287,7 +287,6 @@ void dw_pcie_msi_init(struct pcie_port *pp)
 	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_LO, lower_32_bits(msi_target));
 	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
 }
-EXPORT_SYMBOL_GPL(dw_pcie_msi_init);
 
 int dw_pcie_host_init(struct pcie_port *pp)
 {
@@ -545,6 +544,8 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 					    ~0);
 		}
 	}
+	if (pci_msi_enabled() && pp->msi_data)
+		dw_pcie_msi_init(pp);
 
 	/* Setup RC BARs */
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0x00000004);
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index e3e300669ed5..9ccf69a3dcf4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -39,7 +39,6 @@ static int dw_plat_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 	dw_pcie_wait_for_link(pci);
-	dw_pcie_msi_init(pp);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 9d2f511f13fa..f9f6b276a11a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -365,7 +365,6 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
 
 #ifdef CONFIG_PCIE_DW_HOST
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
-void dw_pcie_msi_init(struct pcie_port *pp);
 void dw_pcie_free_msi(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
@@ -379,10 +378,6 @@ static inline irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 	return IRQ_NONE;
 }
 
-static inline void dw_pcie_msi_init(struct pcie_port *pp)
-{
-}
-
 static inline void dw_pcie_free_msi(struct pcie_port *pp)
 {
 }
diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index afc1abbe49aa..aa9eaee2c4bd 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -202,7 +202,6 @@ static int histb_pcie_host_init(struct pcie_port *pp)
 	pp->bridge->ops = &histb_pci_ops;
 
 	histb_pcie_establish_link(pp);
-	dw_pcie_msi_init(pp);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 6f01ae013326..dc30e43a6be9 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -429,7 +429,6 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
 	pp->bridge->ops = &kirin_pci_ops;
 
 	kirin_pcie_establish_link(pp);
-	dw_pcie_msi_init(pp);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 5eb28251dbee..4f66e534e011 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1271,7 +1271,6 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	}
 
 	dw_pcie_setup_rc(pp);
-	dw_pcie_msi_init(pp);
 
 	qcom_ep_reset_deassert(pcie);
 
diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index e348225f651f..c75550573a1e 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -129,11 +129,9 @@ static void spear13xx_pcie_enable_interrupts(struct spear13xx_pcie *spear13xx_pc
 	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
 
 	/* Enable MSI interrupt */
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		dw_pcie_msi_init(pp);
+	if (IS_ENABLED(CONFIG_PCI_MSI))
 		writel(readl(&app_reg->int_mask) |
 				MSI_CTRL_INT, &app_reg->int_mask);
-	}
 }
 
 static int spear13xx_pcie_link_up(struct dw_pcie *pci)
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index aa511ec0d800..b093be21cab2 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -772,8 +772,6 @@ static void tegra_pcie_enable_msi_interrupts(struct pcie_port *pp)
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	u32 val;
 
-	dw_pcie_msi_init(pp);
-
 	/* Enable MSI interrupt generation */
 	val = appl_readl(pcie, APPL_INTR_EN_L0_0);
 	val |= APPL_INTR_EN_L0_0_SYS_MSI_INTR_EN;
diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index 48176265c867..c19bdfed4337 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -322,8 +322,6 @@ static int uniphier_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		return ret;
 
-	dw_pcie_msi_init(pp);
-
 	return 0;
 }
 
-- 
2.28.0

