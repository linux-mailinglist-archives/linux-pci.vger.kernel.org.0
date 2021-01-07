Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110E22ECC39
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 10:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbhAGJEO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 04:04:14 -0500
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:60421
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727016AbhAGJEN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jan 2021 04:04:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTfYuTnad3n67dJaN8t+XbFjDZH955OIBWK8Ero0PvK6nvW4O5NPKKLcKMWgzs5majF0foKbytQoW4nxswSoVt0eev7dPsyuGm6/dCCgIWV+GPkRoln04yu2LTt9tjkVVZsKuBaIUn1W8C3zTnIXi+aWhGNTYm15NXIy5iX9TWfPfP73QDxRGiv9RGJv27v0fQXSXnfaY0VIuNkoms20C6BhUwdt/+ZlSAqSsdGf+SdlviJrD4P5ZcjfW2JjIyrbo9rg4cRCF72yExa4e/n9HWGXKD+UlbgQdCfbGTPWvM9jr5cBfDR0yFGmKySnPTk1KL2nHWGcpIWs89A+Xan4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKfLmrrcrEiOVMvrk5BRV8vDsC3OpuxH4Aw3JenOKwQ=;
 b=DSvv8YhmkwXh4+qSlfAaH6WqeLHMsrGnS5vmhbR+Qg8dUAwFEY//KT7neDa0wIl5381WIkBiDiPZwg0+zYqCbN2f3pnWrdecL7Gip6z7F9D7rl3d1o2CyD8C5v4gug0j3iTnnXDsaPKkSj5eWq9MoszS2d+pZge5jQtqTXzpFB0SCVKduBgdKGc290YoPO3nA/cJ9trzloevupwCnFDVtRmhxa79ggH68ZcFkvhSgRwG2PN6VakpcqPbFQkFmjXUMxEfy7Hm8PNFHExu5jG0eZER7z8ozmAq8zLwh9GpOWGdR4A/WooEv2kJ6mYyRVVrTiOaZ3XYAe0lW2mi6ZMGwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKfLmrrcrEiOVMvrk5BRV8vDsC3OpuxH4Aw3JenOKwQ=;
 b=sYIWiCcwUBE1FnL7er74cT95zRWcXnakjhrqQ6eYWZFsgFa1GNcxWK7a8ft5MBaaSDQyLTFiExLNrx7tMJ+HAuR0abMrZgo9qE7RYSK/dQDjfDx4V3pZsBKRKTqZVBDXQPqTnW5K6hCyE7DHMudVo7//yhsKyECeuStA0B5zF7w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0401MB2297.eurprd04.prod.outlook.com (2603:10a6:3:23::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.22; Thu, 7 Jan
 2021 09:02:48 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d%4]) with mapi id 15.20.3721.024; Thu, 7 Jan 2021
 09:02:48 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@axis.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com
Cc:     kishon@ti.com, minghuan.Lian@nxp.com, jesper.nilsson@axis.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        hayashi.kunihiko@socionext.com, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 2/4] PCI: dwc: Add CFG offset info into function's represented structure
Date:   Thu,  7 Jan 2021 17:11:21 +0800
Message-Id: <20210107091123.8616-3-Zhiqiang.Hou@nxp.com>
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
Received: from localhost.localdomain (119.31.174.73) by SG2PR06CA0085.apcprd06.prod.outlook.com (2603:1096:3:14::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 09:02:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3743d33e-eeef-4f87-1b0f-08d8b2eb0160
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2297:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0401MB229747484126314878BAC38184AF0@HE1PR0401MB2297.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JZ4767xiA78BFeJre8bB5RvFWFteLArTYNnEBCiDYxwknsBmElNXt5NWk1B4t1X83ejFqi/VL7Sn3SiGCe7qXpxLL4E7ot6qlWF+cfs2GzU8lCRg5Ddlflp5McWz6tBeRHUjdk4mMGngE7UekVBYgXe6A2Fx1ZlDtIvGDyev7yLMHN1K1PlYBMRhVLDctmz4/18c/LrNxIEZIOmoQ2ZovMdr0PD5YkmmByodKdY+omt109Tr8l3Yhzlwx9JFJ/MMi2TK+E4+X15hcpfkwAbTobngN/USpmOtgTAj13NcZ244dDBdJiwRXZl4QKAu7I+zaZ4yl9oEHJKTO1qhKaj9Yn/+OPTfDUUfyQN451PfVzVjUCpmf/RaVdeHKvadNOyJF2A8ZzmoID9Rj8s70MkFWsMaA3iUKtn9BasgABS1eRrQHNG+yCCXkbO2dXAn8RfKuhN/wU972QLTJDJ3J72ttw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(36756003)(956004)(8676002)(86362001)(2616005)(2906002)(6512007)(478600001)(6666004)(4326008)(66556008)(1076003)(26005)(30864003)(83380400001)(6486002)(66476007)(52116002)(5660300002)(7416002)(316002)(69590400011)(186003)(6506007)(16526019)(66946007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GpbRTh60lgVTYwrNJunHKZ2sB4QON3rWZUsXp3J8NhlFXxsYnevhcoQjxj6t?=
 =?us-ascii?Q?4Qv8wkXSrXRLM44RgzI2u0lKkFjstshfxM2biIQ1yuEXj7uBfjOVQeMmAt+C?=
 =?us-ascii?Q?lB544nwFYV0rP2/sXnt0PcJzDC3wOUZu0HpigUdkXRE3S4k6w+8ZsOk5ilE2?=
 =?us-ascii?Q?fslQCzyYjnSnrvL7uYXPa6K+t+gXgeeLYw32mRS2wzc+pB3srMbf4r/YyQIR?=
 =?us-ascii?Q?DDPSIUToylLvh6zZeD2u+j1lRTzmdZS+8wc0aeud6/tr9z1/jq8ALdg5ZBVp?=
 =?us-ascii?Q?YCBcoPe9f78abwWOxpOhJZFbn/4c64QR5ne47IigGHIjmvPLtHIwlgtJUn9r?=
 =?us-ascii?Q?/4Mp3HA7brw+n8X3WbC3Ua9ATo6mJ9qqgoVvjRq7dYqbVDlLhLJ3kWX9WJvH?=
 =?us-ascii?Q?NB+shZpQhEaAvdLt+fTBYbAbPgJuZQWQu05nPEO42cotA8Yidnevi1SNvmU0?=
 =?us-ascii?Q?9jUSFux2rp2E7CneRqJlw9KCgnnNPwYdBRoefq726FsWVEzDKwLUOhbhbI8T?=
 =?us-ascii?Q?YxQ5KykUb39tzu8K+uEoEoHnoF0pinfwwcqatwV+B+0tb6ECRJ8zkkNlT+kr?=
 =?us-ascii?Q?m02NQ5QxIWwNsaasYoYFyzt24v5O78RWH727erduH4FK2HfdqgvbOwyYrfN5?=
 =?us-ascii?Q?5AEmLhgx7ouAXI4K0WhamHFmWQeItq0OWYD5ylJns9WsSfIh3W6hAyv8VLEj?=
 =?us-ascii?Q?hjnHM5JVyQkMFqUM1KNIb/5lMpmSNG3EL1yMDaD3DNODo4NaSfNixhFJ/G0e?=
 =?us-ascii?Q?BkJT+i0KHWInUW5zOYvBdM7bR8rwvhN+CcPAv0kJsBkBKxT+rwkJryQV9nGD?=
 =?us-ascii?Q?5jokCbLBCXMnwjFaRBulbcb/fzJHIbjdpWW5241fzm4HsR/Lx5sEN+sayau6?=
 =?us-ascii?Q?5/5KpbEQ6qkPqTK72Uqh7LoStXz6Fo2QAtXX+Ghe5NLjtLLSm5M9eMImQr33?=
 =?us-ascii?Q?D95NzII/hS3PVe0D4CtEAPWkBTJbgbAwYHTU+R/XAFXqLQcSsyrvufJIuenr?=
 =?us-ascii?Q?G6aV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2021 09:02:48.1380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 3743d33e-eeef-4f87-1b0f-08d8b2eb0160
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7y+kGaMtSpu4yOJIDVh/MEti6/V8cZQbOpGny7HkPFUrtD8DTnLXWYZ5wEj6QSqZCXrP43RmNgqXrxrzr/UUzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2297
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

To avoid multiple calculating of the CFG offset for each function, store
the CFG offset info to the function's represented structure, and only do
one time calculation during the initialization.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 138 ++++++++----------
 drivers/pci/controller/dwc/pcie-designware.h  |   1 +
 2 files changed, 59 insertions(+), 80 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index e583700b5ba3..bc6ad1f96a48 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -42,24 +42,23 @@ dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
 
 static unsigned int dw_pcie_ep_func_select(struct dw_pcie_ep *ep, u8 func_no)
 {
-	unsigned int func_offset = 0;
-
 	if (ep->ops->func_conf_select)
-		func_offset = ep->ops->func_conf_select(ep, func_no);
+		return ep->ops->func_conf_select(ep, func_no);
 
-	return func_offset;
+	return 0;
 }
 
 static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, u8 func_no,
 				   enum pci_barno bar, int flags)
 {
 	u32 reg;
-	unsigned int func_offset = 0;
 	struct dw_pcie_ep *ep = &pci->ep;
+	struct dw_pcie_ep_func *func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 
-	func_offset = dw_pcie_ep_func_select(ep, func_no);
+	if (!func)
+		return;
 
-	reg = func_offset + PCI_BASE_ADDRESS_0 + (4 * bar);
+	reg = func->cfg_off + PCI_BASE_ADDRESS_0 + (4 * bar);
 	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writel_dbi2(pci, reg, 0x0);
 	dw_pcie_writel_dbi(pci, reg, 0x0);
@@ -83,17 +82,15 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie_ep *ep, u8 func_no,
 		u8 cap_ptr, u8 cap)
 {
+	struct dw_pcie_ep_func *func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-	unsigned int func_offset = 0;
 	u8 cap_id, next_cap_ptr;
 	u16 reg;
 
-	if (!cap_ptr)
+	if (!cap_ptr || !func)
 		return 0;
 
-	func_offset = dw_pcie_ep_func_select(ep, func_no);
-
-	reg = dw_pcie_readw_dbi(pci, func_offset + cap_ptr);
+	reg = dw_pcie_readw_dbi(pci, func->cfg_off + cap_ptr);
 	cap_id = (reg & 0x00ff);
 
 	if (cap_id > PCI_CAP_ID_MAX)
@@ -108,14 +105,15 @@ static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie_ep *ep, u8 func_no,
 
 static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
 {
+	struct dw_pcie_ep_func *func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-	unsigned int func_offset = 0;
 	u8 next_cap_ptr;
 	u16 reg;
 
-	func_offset = dw_pcie_ep_func_select(ep, func_no);
+	if (!func)
+		return 0;
 
-	reg = dw_pcie_readw_dbi(pci, func_offset + PCI_CAPABILITY_LIST);
+	reg = dw_pcie_readw_dbi(pci, func->cfg_off + PCI_CAPABILITY_LIST);
 	next_cap_ptr = (reg & 0x00ff);
 
 	return __dw_pcie_ep_find_next_cap(ep, func_no, next_cap_ptr, cap);
@@ -126,23 +124,26 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-	unsigned int func_offset = 0;
+	struct dw_pcie_ep_func *func = dw_pcie_ep_get_func_from_ep(ep, func_no);
+	u32 cfg_off;
 
-	func_offset = dw_pcie_ep_func_select(ep, func_no);
+	if (!func)
+		return -EINVAL;
 
+	cfg_off = func->cfg_off;
 	dw_pcie_dbi_ro_wr_en(pci);
-	dw_pcie_writew_dbi(pci, func_offset + PCI_VENDOR_ID, hdr->vendorid);
-	dw_pcie_writew_dbi(pci, func_offset + PCI_DEVICE_ID, hdr->deviceid);
-	dw_pcie_writeb_dbi(pci, func_offset + PCI_REVISION_ID, hdr->revid);
-	dw_pcie_writeb_dbi(pci, func_offset + PCI_CLASS_PROG, hdr->progif_code);
-	dw_pcie_writew_dbi(pci, func_offset + PCI_CLASS_DEVICE,
+	dw_pcie_writew_dbi(pci, cfg_off + PCI_VENDOR_ID, hdr->vendorid);
+	dw_pcie_writew_dbi(pci, cfg_off + PCI_DEVICE_ID, hdr->deviceid);
+	dw_pcie_writeb_dbi(pci, cfg_off + PCI_REVISION_ID, hdr->revid);
+	dw_pcie_writeb_dbi(pci, cfg_off + PCI_CLASS_PROG, hdr->progif_code);
+	dw_pcie_writew_dbi(pci, cfg_off + PCI_CLASS_DEVICE,
 			   hdr->subclass_code | hdr->baseclass_code << 8);
-	dw_pcie_writeb_dbi(pci, func_offset + PCI_CACHE_LINE_SIZE,
+	dw_pcie_writeb_dbi(pci, cfg_off + PCI_CACHE_LINE_SIZE,
 			   hdr->cache_line_size);
-	dw_pcie_writew_dbi(pci, func_offset + PCI_SUBSYSTEM_VENDOR_ID,
+	dw_pcie_writew_dbi(pci, cfg_off + PCI_SUBSYSTEM_VENDOR_ID,
 			   hdr->subsys_vendor_id);
-	dw_pcie_writew_dbi(pci, func_offset + PCI_SUBSYSTEM_ID, hdr->subsys_id);
-	dw_pcie_writeb_dbi(pci, func_offset + PCI_INTERRUPT_PIN,
+	dw_pcie_writew_dbi(pci, cfg_off + PCI_SUBSYSTEM_ID, hdr->subsys_id);
+	dw_pcie_writeb_dbi(pci, cfg_off + PCI_INTERRUPT_PIN,
 			   hdr->interrupt_pin);
 	dw_pcie_dbi_ro_wr_dis(pci);
 
@@ -223,12 +224,13 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
 	size_t size = epf_bar->size;
 	int flags = epf_bar->flags;
 	enum dw_pcie_as_type as_type;
+	struct dw_pcie_ep_func *func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	u32 reg;
-	unsigned int func_offset = 0;
 
-	func_offset = dw_pcie_ep_func_select(ep, func_no);
+	if (!func)
+		return -EINVAL;
 
-	reg = PCI_BASE_ADDRESS_0 + (4 * bar) + func_offset;
+	reg = PCI_BASE_ADDRESS_0 + (4 * bar) + func->cfg_off;
 
 	if (!(flags & PCI_BASE_ADDRESS_SPACE))
 		as_type = DW_PCIE_AS_MEM;
@@ -309,17 +311,13 @@ static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_pcie_ep_func *func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	u32 val, reg;
-	unsigned int func_offset = 0;
-	struct dw_pcie_ep_func *ep_func;
 
-	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
-	if (!ep_func || !ep_func->msi_cap)
+	if (!func || !func->msi_cap)
 		return -EINVAL;
 
-	func_offset = dw_pcie_ep_func_select(ep, func_no);
-
-	reg = ep_func->msi_cap + func_offset + PCI_MSI_FLAGS;
+	reg = func->msi_cap + func->cfg_off + PCI_MSI_FLAGS;
 	val = dw_pcie_readw_dbi(pci, reg);
 	if (!(val & PCI_MSI_FLAGS_ENABLE))
 		return -EINVAL;
@@ -333,17 +331,13 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_pcie_ep_func *func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	u32 val, reg;
-	unsigned int func_offset = 0;
-	struct dw_pcie_ep_func *ep_func;
 
-	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
-	if (!ep_func || !ep_func->msi_cap)
+	if (!func || !func->msi_cap)
 		return -EINVAL;
 
-	func_offset = dw_pcie_ep_func_select(ep, func_no);
-
-	reg = ep_func->msi_cap + func_offset + PCI_MSI_FLAGS;
+	reg = func->msi_cap + func->cfg_off + PCI_MSI_FLAGS;
 	val = dw_pcie_readw_dbi(pci, reg);
 	val &= ~PCI_MSI_FLAGS_QMASK;
 	val |= (interrupts << 1) & PCI_MSI_FLAGS_QMASK;
@@ -358,17 +352,13 @@ static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_pcie_ep_func *func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	u32 val, reg;
-	unsigned int func_offset = 0;
-	struct dw_pcie_ep_func *ep_func;
 
-	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
-	if (!ep_func || !ep_func->msix_cap)
+	if (!func || !func->msix_cap)
 		return -EINVAL;
 
-	func_offset = dw_pcie_ep_func_select(ep, func_no);
-
-	reg = ep_func->msix_cap + func_offset + PCI_MSIX_FLAGS;
+	reg = func->msi_cap + func->cfg_off + PCI_MSIX_FLAGS;
 	val = dw_pcie_readw_dbi(pci, reg);
 	if (!(val & PCI_MSIX_FLAGS_ENABLE))
 		return -EINVAL;
@@ -383,29 +373,25 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts,
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_pcie_ep_func *func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	u32 val, reg;
-	unsigned int func_offset = 0;
-	struct dw_pcie_ep_func *ep_func;
 
-	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
-	if (!ep_func || !ep_func->msix_cap)
+	if (!func || !func->msix_cap)
 		return -EINVAL;
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
-	func_offset = dw_pcie_ep_func_select(ep, func_no);
-
-	reg = ep_func->msix_cap + func_offset + PCI_MSIX_FLAGS;
+	reg = func->msi_cap + func->cfg_off + PCI_MSIX_FLAGS;
 	val = dw_pcie_readw_dbi(pci, reg);
 	val &= ~PCI_MSIX_FLAGS_QSIZE;
 	val |= interrupts;
 	dw_pcie_writew_dbi(pci, reg, val);
 
-	reg = ep_func->msix_cap + func_offset + PCI_MSIX_TABLE;
+	reg = func->msi_cap + func->cfg_off + PCI_MSIX_TABLE;
 	val = offset | bir;
 	dw_pcie_writel_dbi(pci, reg, val);
 
-	reg = ep_func->msix_cap + func_offset + PCI_MSIX_PBA;
+	reg = func->msi_cap + func->cfg_off + PCI_MSIX_PBA;
 	val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
 	dw_pcie_writel_dbi(pci, reg, val);
 
@@ -487,37 +473,33 @@ int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
 int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 			     u8 interrupt_num)
 {
+	struct dw_pcie_ep_func *func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-	struct dw_pcie_ep_func *ep_func;
 	struct pci_epc *epc = ep->epc;
 	unsigned int aligned_offset;
-	unsigned int func_offset = 0;
 	u16 msg_ctrl, msg_data;
 	u32 msg_addr_lower, msg_addr_upper, reg;
 	u64 msg_addr;
 	bool has_upper;
 	int ret;
 
-	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
-	if (!ep_func || !ep_func->msi_cap)
+	if (!func || !func->msi_cap)
 		return -EINVAL;
 
-	func_offset = dw_pcie_ep_func_select(ep, func_no);
-
 	/* Raise MSI per the PCI Local Bus Specification Revision 3.0, 6.8.1. */
-	reg = ep_func->msi_cap + func_offset + PCI_MSI_FLAGS;
+	reg = func->msi_cap + func->cfg_off + PCI_MSI_FLAGS;
 	msg_ctrl = dw_pcie_readw_dbi(pci, reg);
 	has_upper = !!(msg_ctrl & PCI_MSI_FLAGS_64BIT);
-	reg = ep_func->msi_cap + func_offset + PCI_MSI_ADDRESS_LO;
+	reg = func->msi_cap + func->cfg_off + PCI_MSI_ADDRESS_LO;
 	msg_addr_lower = dw_pcie_readl_dbi(pci, reg);
 	if (has_upper) {
-		reg = ep_func->msi_cap + func_offset + PCI_MSI_ADDRESS_HI;
+		reg = func->msi_cap + func->cfg_off + PCI_MSI_ADDRESS_HI;
 		msg_addr_upper = dw_pcie_readl_dbi(pci, reg);
-		reg = ep_func->msi_cap + func_offset + PCI_MSI_DATA_64;
+		reg = func->msi_cap + func->cfg_off + PCI_MSI_DATA_64;
 		msg_data = dw_pcie_readw_dbi(pci, reg);
 	} else {
 		msg_addr_upper = 0;
-		reg = ep_func->msi_cap + func_offset + PCI_MSI_DATA_32;
+		reg = func->msi_cap + func->cfg_off + PCI_MSI_DATA_32;
 		msg_data = dw_pcie_readw_dbi(pci, reg);
 	}
 	aligned_offset = msg_addr_lower & (epc->mem->window.page_size - 1);
@@ -538,12 +520,11 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 int dw_pcie_ep_raise_msix_irq_doorbell(struct dw_pcie_ep *ep, u8 func_no,
 				       u16 interrupt_num)
 {
+	struct dw_pcie_ep_func *func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-	struct dw_pcie_ep_func *ep_func;
 	u32 msg_data;
 
-	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
-	if (!ep_func || !ep_func->msix_cap)
+	if (!func || !func->msix_cap)
 		return -EINVAL;
 
 	msg_data = (func_no << PCIE_MSIX_DOORBELL_PF_SHIFT) |
@@ -557,11 +538,10 @@ int dw_pcie_ep_raise_msix_irq_doorbell(struct dw_pcie_ep *ep, u8 func_no,
 int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 			      u16 interrupt_num)
 {
+	struct dw_pcie_ep_func *func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-	struct dw_pcie_ep_func *ep_func;
 	struct pci_epf_msix_tbl *msix_tbl;
 	struct pci_epc *epc = ep->epc;
-	unsigned int func_offset = 0;
 	u32 reg, msg_data, vec_ctrl;
 	unsigned int aligned_offset;
 	u32 tbl_offset;
@@ -569,13 +549,10 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	int ret;
 	u8 bir;
 
-	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
-	if (!ep_func || !ep_func->msix_cap)
+	if (!func || !func->msix_cap)
 		return -EINVAL;
 
-	func_offset = dw_pcie_ep_func_select(ep, func_no);
-
-	reg = ep_func->msix_cap + func_offset + PCI_MSIX_TABLE;
+	reg = func->msix_cap + func->cfg_off + PCI_MSIX_TABLE;
 	tbl_offset = dw_pcie_readl_dbi(pci, reg);
 	bir = (tbl_offset & PCI_MSIX_TABLE_BIR);
 	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
@@ -753,6 +730,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 
 	for (i = 0; i < epc->max_functions; i++) {
 		funcs[i].func_no = i;
+		funcs[i].cfg_off = dw_pcie_ep_func_select(ep, i);
 		funcs[i].msi_cap = dw_pcie_ep_find_capability(ep, i,
 							      PCI_CAP_ID_MSI);
 		funcs[i].msix_cap = dw_pcie_ep_find_capability(ep, i,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 16d239c4d09b..8ee67d4b8109 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -224,6 +224,7 @@ struct dw_pcie_ep_func {
 	u8			func_no;
 	u8			msi_cap;	/* MSI capability offset */
 	u8			msix_cap;	/* MSI-X capability offset */
+	u32			cfg_off;	/* CFG offset from DBI base */
 };
 
 struct dw_pcie_ep {
-- 
2.17.1

