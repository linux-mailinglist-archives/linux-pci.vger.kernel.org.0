Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D552ECC38
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 10:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbhAGJD4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 04:03:56 -0500
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:21197
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725974AbhAGJDz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jan 2021 04:03:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btUTveu2aB2KcacHYIHToP5IevIQWh1cl1Q0mQeNjB/Ga4VK9Vl8qAqN4e3zdypXs4zLRuoZWJ4uFXuJUTLfV47x1veaQzGn/gyNpkZocrihF4PSTr8bvYVDv/fI1nsjWidRBL84NI1QiQVT8DCDulKytzYjVqFI58aS3/kRBhATz920YF+YLXsXbppUFW2Jba0pjihPsx8FHuRdUwiRWhgxGSQxgFRAYjNZC9elOFWJ7gOVbkv0Z+VEo2HTqj9acOvoUnZf9TR3iAhwGWQHOxnoghb8h5aEITzjPSaxn2XdyoxSwKpfcpHxeccK86ltBxt7kc8J8tQ78hjY017sbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xiPIgsBGQsk1PW8W4Xz5jofW0uyIXaYgyx8QZ1CJKg=;
 b=E8+1Rw+MLS2DCwTdNpS1Cqu8x4pG7vTIIt+ew6ZYlVirKTACWENynH+kUidioXA2WUPe3oDFD6l+bd1ngdqkQwqlTTXiWH9ww575/yje6aRWDWgaFb4EzIcKCbnTxi811hxUUfh/DDfSZ2Gcyikdc4y+iLPha/xDTpz8+5uX+he1LEjns7E8cvbKDhkEe1TC/GrOPYZpXw3fZBzdvxC/8/Qmb3lS/INlg6hhCkSK3y5NYUyOMV56NaOa8LSCAtLIKlDim94GNnVSA9r4+M3Y691hp2tsjbCIsaN4qbzO+R9kiyXScWASoiVtz/Jrcu0r5n9INO7FEUnJ6rspgoGE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xiPIgsBGQsk1PW8W4Xz5jofW0uyIXaYgyx8QZ1CJKg=;
 b=fyP9qisPLhKtdCDZjYW0BwmygQcXALX+dynvDwYyJ/xCKEeRB1DsNwgcvKhiq3tjUu9+GW1OYo+JmHYm6jULLzhsVwmlAjaTuT/Y+KAzCMOz2wXxRqZDv4AdplF9I63yEIW7fiSvLzhVm67CgBP2EvDpz0qzrUmmINBATN1vh8U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0401MB2297.eurprd04.prod.outlook.com (2603:10a6:3:23::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.22; Thu, 7 Jan
 2021 09:02:59 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d%4]) with mapi id 15.20.3721.024; Thu, 7 Jan 2021
 09:02:59 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@axis.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com
Cc:     kishon@ti.com, minghuan.Lian@nxp.com, jesper.nilsson@axis.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        hayashi.kunihiko@socionext.com, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 4/4] PCI: dwc: Change the parameter of function dw_pcie_ep_reset_bar()
Date:   Thu,  7 Jan 2021 17:11:23 +0800
Message-Id: <20210107091123.8616-5-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210107091123.8616-1-Zhiqiang.Hou@nxp.com>
References: <20210107091123.8616-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: SG2PR06CA0085.apcprd06.prod.outlook.com
 (2603:1096:3:14::11) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SG2PR06CA0085.apcprd06.prod.outlook.com (2603:1096:3:14::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 09:02:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cbc4fba3-675b-48e1-458b-08d8b2eb0815
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2297:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2297F2EE23F4E25F21C4445884AF0@HE1PR0401MB2297.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:369;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BBwmz8AuVOjhAmdtnvw9184nLvypVFtYDiNNfViIw3jU2dgo3IwkIGkyl4jyKkJg2ja2JrAIpWC3+KuYla0aECRO9+0yJxq3nh502L3I1Jd6YBL+ARuGEzNt4KC98kB5oJ/YVs766vIoj+LbENgLpHFHp4aMhl6bsaehN2oa4yGYjECqLXXwuEyvdsX75g+K1/y6IpRS7kEPjuaww5z/Ad6kJM61mmzhVo+usD4AO2gmYQU/3tT3zSe67zO/uznGWu61AvCC7gS0BniAE4cwrY9gSbUJQGil84L/wHIvq7t/y7d06B6tH7vchGpGtNYs6hmGNcQQyzBlKBkNiIBkB8tzm5BuM1vLHND5t9bsn1gy0ktgm+xQEAK3pRKx4XNBAIkr5e5ymk2krX8tzoM/a3YRVX+JsPdlalGEIh8Hjskmyp0zPBuJBrK7+MkdO1o03y2NM6zcMEZ0wsiTDoFptg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(36756003)(956004)(8676002)(86362001)(2616005)(2906002)(6512007)(478600001)(6666004)(4326008)(66556008)(1076003)(26005)(83380400001)(6486002)(66476007)(52116002)(5660300002)(7416002)(316002)(69590400011)(186003)(6506007)(16526019)(66946007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UZ/egG3x5lQlHrJW4+1CDqt8OsE6TnN5zw6LV2CEAh8zmnj1I7LW1OxmjD0m?=
 =?us-ascii?Q?O7u3VVBchEeMFlLy85qdyeZ0IvFI8SKlJzejBei367k51uLEZc1q0q62XQcZ?=
 =?us-ascii?Q?KVkJllO/VuSWuhxnEHAasRCsEz3efF/MDN3zkWDCB4NBDmZSfkNKVtFuQQxm?=
 =?us-ascii?Q?Bgi1UWsUuzz5bxiHEXn0iYvy7jze0/S+PYU35BJeYURBFbBT+4vt+zV8n1SU?=
 =?us-ascii?Q?ktSHGvXGLkc3oEUyWNsqWpR3swwWUw1xeXpcUL3Lciii9F3NdiSufegZw5TX?=
 =?us-ascii?Q?MZvbbyv3NrVsDQhJL7+nZoe/CJObk7ojreR+WnKftEiMToj7Z6Z5NlMPq171?=
 =?us-ascii?Q?RbxPQMkUjK2+2BAmwyQbMnLbi6DXRNKB5zvgcPx/RBWC1hYZ7bAFwXiz0O7+?=
 =?us-ascii?Q?tK97KbRgYYb1dfLLnTvLdJoPMqEGaqftFe2eyDOPcOf42o3RQ2SmUnqQ/Qv8?=
 =?us-ascii?Q?KhdP4zd/ppr1ueQvKaJr+3/uPAoASMsFnFeooBBUSIAfpUGxeijYk1ellhVb?=
 =?us-ascii?Q?1KIAYq3GgP3TuSXJxmnqn6tim1XO4xLHVSPf/1tfqbcJ+fWofyQMz1FuY0t9?=
 =?us-ascii?Q?/GggbGr7i4nvuL/WTEvjlYFfNsrGEi+OcTzSoC9AoWRUvi/v7H2aV9vh+HKb?=
 =?us-ascii?Q?33xcYehBCUBRzpFOxmzOdZeps1/0mpyTNBV0psHIhJJ6wxclA/dC6Xrarbm8?=
 =?us-ascii?Q?CQnxVRHnA3Qm5lzJGUk0ODJHczT9Ft5aWYJslTV9C8M05+AqUjI66iwMa4rY?=
 =?us-ascii?Q?9jKckZudeLrF6d5HXIVprgndDByt/Kg3lxx0IHuXN+n/Q13sZeXr+XjZ4P3j?=
 =?us-ascii?Q?2hwyrgnJsfkQrQ3TTlLacHjYJym/RN8bi4R78aMBxM/ZjvlIA5sqPYm1zr19?=
 =?us-ascii?Q?cm2xSe0O0Q33u+4xT4IxjsJCMN21Hm6cIWA+2iAADkb70cpHsDrE3RlxAEmR?=
 =?us-ascii?Q?2I0P4Y4WzDQqZGkgQOmdGiFJ6QIkz4HrLryNK2912sbuQgorSRzYOiS8+pJO?=
 =?us-ascii?Q?F0S/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2021 09:02:59.3336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc4fba3-675b-48e1-458b-08d8b2eb0815
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xO0LTLwCU3pOgqw07eButTHF+zYgTdnIau1LCj7dYWvHWKCMu8m+pfAFexDAad45pn5AvAQ88B2ffhvrp0yUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2297
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This helper is endpoint mode specific, so change to use a pointer of
'struct dw_pcie_ep' as the parameter.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c          |  2 +-
 drivers/pci/controller/dwc/pci-layerscape-ep.c   |  2 +-
 drivers/pci/controller/dwc/pcie-artpec6.c        |  2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c  | 16 +++++++---------
 .../pci/controller/dwc/pcie-designware-plat.c    |  3 +--
 drivers/pci/controller/dwc/pcie-designware.h     |  5 +++--
 drivers/pci/controller/dwc/pcie-uniphier-ep.c    |  3 +--
 7 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index b105af63854a..12726c63366f 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -383,7 +383,7 @@ static void dra7xx_pcie_ep_init(struct dw_pcie_ep *ep)
 	enum pci_barno bar;
 
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
-		dw_pcie_ep_reset_bar(pci, bar);
+		dw_pcie_ep_reset_bar(ep, bar);
 
 	dra7xx_pcie_enable_wrapper_interrupts(dra7xx);
 }
diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 0f5e4104c06c..dcee95e16139 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -62,7 +62,7 @@ static void ls_pcie_ep_init(struct dw_pcie_ep *ep)
 		return;
 
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
-		dw_pcie_ep_reset_bar(pci, bar);
+		dw_pcie_ep_reset_bar(ep, bar);
 
 	pcie->ls_epc->msi_capable = ep_func->msi_cap ? true : false;
 	pcie->ls_epc->msix_capable = ep_func->msix_cap ? true : false;
diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index 597c282f586c..f833daf6d422 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -348,7 +348,7 @@ static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
 	artpec6_pcie_wait_for_phy(artpec6_pcie);
 
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
-		dw_pcie_ep_reset_bar(pci, bar);
+		dw_pcie_ep_reset_bar(ep, bar);
 }
 
 static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index d8eb9a984547..2dc960e74fd0 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -49,11 +49,11 @@ static unsigned int dw_pcie_ep_get_func_cfg_addr(struct dw_pcie_ep *ep,
 	return 0;
 }
 
-static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, u8 func_no,
+static void __dw_pcie_ep_reset_bar(struct dw_pcie_ep *ep, u8 func_no,
 				   enum pci_barno bar, int flags)
 {
 	u32 reg;
-	struct dw_pcie_ep *ep = &pci->ep;
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct dw_pcie_ep_func *func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 
 	if (!func)
@@ -70,14 +70,12 @@ static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, u8 func_no,
 	dw_pcie_dbi_ro_wr_dis(pci);
 }
 
-void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
+void dw_pcie_ep_reset_bar(struct dw_pcie_ep *ep, enum pci_barno bar)
 {
-	u8 func_no, funcs;
-
-	funcs = pci->ep.epc->max_functions;
+	u8 func_no;
 
-	for (func_no = 0; func_no < funcs; func_no++)
-		__dw_pcie_ep_reset_bar(pci, func_no, bar, 0);
+	for (func_no = 0; func_no < ep->epc->max_functions; func_no++)
+		__dw_pcie_ep_reset_bar(ep, func_no, bar, 0);
 }
 
 static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie_ep *ep, u8 func_no,
@@ -208,7 +206,7 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no,
 	enum pci_barno bar = epf_bar->barno;
 	u32 atu_index = ep->bar_to_atu[bar];
 
-	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
+	__dw_pcie_ep_reset_bar(ep, func_no, bar, epf_bar->flags);
 
 	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_INBOUND);
 	clear_bit(atu_index, ep->ib_window_map);
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 9b397c807261..49d51584a547 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -47,11 +47,10 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 
 static void dw_plat_pcie_ep_init(struct dw_pcie_ep *ep)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar;
 
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
-		dw_pcie_ep_reset_bar(pci, bar);
+		dw_pcie_ep_reset_bar(ep, bar);
 }
 
 static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index b8cbe266e01c..10ba09237def 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -415,7 +415,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 			     u16 interrupt_num);
 int dw_pcie_ep_raise_msix_irq_doorbell(struct dw_pcie_ep *ep, u8 func_no,
 				       u16 interrupt_num);
-void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar);
+void dw_pcie_ep_reset_bar(struct dw_pcie_ep *ep, enum pci_barno bar);
 struct dw_pcie_ep_func *
 dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no);
 #else
@@ -465,7 +465,8 @@ static inline int dw_pcie_ep_raise_msix_irq_doorbell(struct dw_pcie_ep *ep,
 	return 0;
 }
 
-static inline void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
+static inline void dw_pcie_ep_reset_bar(struct dw_pcie_ep *ep,
+					enum pci_barno bar)
 {
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index 69810c6b0d58..21e185bf90d6 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
@@ -134,11 +134,10 @@ static void uniphier_pcie_stop_link(struct dw_pcie *pci)
 
 static void uniphier_pcie_ep_init(struct dw_pcie_ep *ep)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar;
 
 	for (bar = BAR_0; bar <= BAR_5; bar++)
-		dw_pcie_ep_reset_bar(pci, bar);
+		dw_pcie_ep_reset_bar(ep, bar);
 }
 
 static int uniphier_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep)
-- 
2.17.1

