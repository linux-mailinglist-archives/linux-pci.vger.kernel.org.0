Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B145256AD27
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 23:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbiGGVD1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 17:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbiGGVDZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 17:03:25 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130049.outbound.protection.outlook.com [40.107.13.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F26F205F7;
        Thu,  7 Jul 2022 14:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bx0M30LS+f5SduEKRy2MB+IAChubjr4Qo/3LHDyO001SQRli2awsRFWfkChH4Gcukx74u/L5rHN9jlExB2D5+Tfddke6zfG8sjIZ4DziYxlkY4uvJlFPwRf6R0ElJZM7iMneynRZOHc+dqiHIkurfi7wTzmBpsc1m1H4zLhRyKcoz6F2PXY/mI/3dVveULPoNe7NxfxdZaOneXMnudQkcWbNSQ/DOXh9/5TZsLJNClvlAXIvRI6jPlhcySE86stFW9tRC3BVG+AsKMjntngDeomxYG1tdsnRqrulPEC2JuawV0A6/OehXNGGHJOhsH/rLr1gw4VPXoq1EcO1oivTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK2QuO/n6FDIvSaY5NaxylfnVX6Ehlu5VYtWZQ9B39Q=;
 b=OBQ5vmiW/XKzQD5awI23CHJnegrBOJ83nxxevrUIFYTCUzUMPf7fvyDge6QaZexdvzbNXtveVTq/V9vQhxukolkhVtKcWPOhFAFOoBSyInXbaMEDeDhkaS1G23Sc0ve37tqPf1oFniFC1yATFoeUhpoBevRC0wnH8qvxiGkDTUUZOXcnVripqBGev6IdBw05dXoQGT2Fp/P2PuIw5fOTPsXyh9JJXV97SBE8d2WdzotzjEVaehNhf0oKT2tj5s/zAApvfyEBebAe2/pExtVp9dTqwIeIp6XSxkZc8h968CWpnbFp9k9Lb0uByecB7Ek96uYggw+UU40yn029pltbUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK2QuO/n6FDIvSaY5NaxylfnVX6Ehlu5VYtWZQ9B39Q=;
 b=h8Ul/v7F3BW350k/EE5W1TlX+5nyeIbgaPhgqKgvUq8/8b0HI9B3uXUcWO7P1Gtz+4OLV23+ykPlCL/+3to3cCWTxQBaq0/To9zarxp7bXUug2JRwylQ7EACuET8RxbHrq/KChzCB2H0I9dFazx+I/zvgorRN3JyacM9IRwFFXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DBBPR04MB7817.eurprd04.prod.outlook.com (2603:10a6:10:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 21:03:20 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e945:8bde:54e5:d83e]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e945:8bde:54e5:d83e%6]) with mapi id 15.20.5395.020; Thu, 7 Jul 2022
 21:03:20 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev
Subject: [PATCH 3/3] pcie: endpoint: pci-epf-vntb: add endpoint msi support
Date:   Thu,  7 Jul 2022 16:02:38 -0500
Message-Id: <20220707210238.917477-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220707210238.917477-1-Frank.Li@nxp.com>
References: <20220707210238.917477-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::14) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8568611b-241c-4f05-9178-08da605c1f1c
X-MS-TrafficTypeDiagnostic: DBBPR04MB7817:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rtT8uLBk34XMEYH2JuzfjPcwKkhTEC23nmF0qjrGQOisAiVr0B58tvPHR24RTljKi5ELfxihx/z6aLoerTmyuQ95trkMLZ2A7uAqpKSRIWV2B5UfxJuBi0puT4N9OhVCXstN6wMT1Rf3JI9G6zOPPhNVI4R8K6cJOKc/HPFxvphXy1bUGblqdWK+ZJhDwUebkslD1xv6moVtftmn3EzuOa6rVIuN9F8uLjJDEbZf71f0CTTIvtw3DxWd7jeAXhH8llzyL/1jMbEhqW7VezrKkyKfMpt+1DuKUiTWpEuXyEfRBjAxQLkMbOR72JdfPygXcffFwNi/SHbUMQC9dc8/nzuLUdXqqXgbXNCaRtPU8EWCZrlMPGsRe4Fcd2k6ExLXUeykHgYAS86NGXr3ltOvhnCRpyLpiic4pU28pZwPIswrrdzLHQCumFzvXY/1nZ16gn+TXj7/9LLr0GZ2bei/Eqzq2PbECOM+qx+kmguxhkI3Bn8V6uSn1d/YU1SIZ9obj0CwHWYSsgSSimmyDMfb7140wPJ2oDOy+FyBIdKX8T4E3JNsVfLZ5CV9kObyAUKW8vbsgpozj1bowIPLigepkMzjh14HLSKQH2KKw/Bj+fK2eIHSIuKktsowj90+665Nw40j2UkBi9uUu6tt9kUkJkbUdJQk5tiviQed1kUamGen7ltFafxhK7Fyhq9qoh0oTGUgV3L+svKWmrow3znMPclzJYJXpvsWTv61LgzWYR35tP4Rv5Rd9OlQnJNHmWSZALiaVYVKcVfLrzEGN6ms4/yaq6fkMhniLCsmVc7DuXBFC85VXAuWjaDwITu4K+hNNBwEi/D/4m22EwrpoHMktA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(38100700002)(6512007)(38350700002)(186003)(66946007)(66476007)(66556008)(4326008)(8676002)(5660300002)(316002)(921005)(83380400001)(36756003)(2906002)(2616005)(6486002)(8936002)(478600001)(41300700001)(6506007)(86362001)(6666004)(52116002)(26005)(1076003)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jtgjzYc/+AUbVG1vPFzZEINklPJ8ThK+QHtI+ok6jt137AyEckPUysMqEWQy?=
 =?us-ascii?Q?w5MNFrOa7Z/DEhQ74XdjBH/ZEPSKJ9S3OoWWET4YXYn5+uwelRSiAYM0oPr4?=
 =?us-ascii?Q?oxzluQcT0R746dQFez/doo8iInx97VPrL2Ht0D2TWkwtB1dkwAslUHQ2xY8J?=
 =?us-ascii?Q?su76JGe/2Doh2R38OcmTrw7DFRi1FXJCJpHRlzSP+BXtxdWDrpWc3H7duY+V?=
 =?us-ascii?Q?xE31be6pJgKvLva+FD/MXrh2ftY3+bSJQUtB2JAFWDk+/S3UxNHLGpVOs0tN?=
 =?us-ascii?Q?OxclHJwd0HT9qPg8/LdV50jjV1UQb8zBQV6MmKjY2uhNVot899u2CD5JJHQW?=
 =?us-ascii?Q?NGSmxfvFV8MlgYNGf72YgORV29/095+XXIS3xW8Z0JiZTbk5lbpQJVauZewb?=
 =?us-ascii?Q?QiaIHJN3ZJZN5JOgW8OVxHlnZRb/mt4bN7OzS+yUGGXok+vY/hc0bPG6XQYh?=
 =?us-ascii?Q?y7+dWb+i0D5qmWZgZIuIOBoOxUmgsP0bQ3DgAOUErZ52iUE3xQz9UHUtFMbH?=
 =?us-ascii?Q?KTzrVWA8mZUaxUz43ysTovbRYEofZpgSZTmLXfLLYjDcxGPLUNA11HkAwbMO?=
 =?us-ascii?Q?ZET4/oajShX0DvnbROCGp44jiGyub1kGmpEewKE3poOzTrlW32x+E83mTnR0?=
 =?us-ascii?Q?p5y+ThY2ySn8tJrwJ8ZEAoesXKvhfmhdy+u9vF1zf+K1LrlEgMynBtpU0CrX?=
 =?us-ascii?Q?V1ijARcneh8oAZAlOZeIHpvkSCZPjpcvdFDeItOLUBDibZERn8T/JvmkEI+6?=
 =?us-ascii?Q?I+5JEyfckPss//is5dwVSq+L7I0HaDulbZg9SXKQTA5qYrDcUM8lzDfIXgCN?=
 =?us-ascii?Q?tqKloyNgRN9W4ObvVo+TPTcnYwMZCpZldfvRKOOoOhSCcUQTBzCpiaffkhMP?=
 =?us-ascii?Q?H9M6vWHniE858a/6bYCCdscvJEaUoNVeD+2lZy8vMsM7hyPJS8eP4JS7ln/1?=
 =?us-ascii?Q?N2zTNFT6T+GSt3Y3idWggYWS3Ua/l/aipXyU4Rccbra8EnHDl7HMwX/H+PPU?=
 =?us-ascii?Q?u97Dog2z1PDR38tl5DLo6tjQ2i+wl6VAgveemGy3pDfIj/bCu97SMw0R+9Uy?=
 =?us-ascii?Q?8M/VgnuNjSymlS0MwIx9k4AdG0bfenvOLKlIQGLe97GcAPs6uhthWxe3dpc1?=
 =?us-ascii?Q?eaoF/DMsNO63TXSqwooG6BzwOsne+mZHsq9+8wodr6kvk3L70ePkbENlq2qD?=
 =?us-ascii?Q?LvpzohT7KK/VSJNkkR5LfcSr1zFmIEtDQBsDnsD6oHL6vMI25S7ZC0/BfIX9?=
 =?us-ascii?Q?1CLlKBAKSVhgt5GzTyXXbm0Mtv5FoeoPir+QX6hCKAPg1LIBaWdO0dBCKEby?=
 =?us-ascii?Q?aDEoq1npGqHNOjeTsmGubtJOgQvAHmj2/zInHx4iLFLEtqkLo9hmcXaDS6A6?=
 =?us-ascii?Q?YRNvVZ7Nnv/xPL88cmpmY5TQGhK8ATsbufzL2f9tvoImabw216jEHQqXlHN1?=
 =?us-ascii?Q?wOK8BcvgHvi1GLRXbyfz4Ddt6EP+Snhi1xP5aXb5oXUNOJhiryoOBcq/RIid?=
 =?us-ascii?Q?c9/MPkJfskbQqk6dAVH2fjg9UAKBELzCm7dBVgyz1W/80wAzHODzcoeRT1RR?=
 =?us-ascii?Q?l0FFsqQWLs/Yq3AP/WZT5Ki2xlxoJCbsts1puog2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8568611b-241c-4f05-9178-08da605c1f1c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 21:03:20.5007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWRf25z7w10b1u3vXa4M6yYg7ekdkdl9+2eQpFfBniB7scLdxUAQsbE2KwehC/nu7TSxXV7SeSPbd33/q+kklw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7817
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch add msi support for ntb endpoint(EP) side.
EP side driver query if system have msi controller.
Setup doorbell address according to struct msi_msg.

So PCIe host can write this doorbell address to EP
side's irq.

If no msi controller exist, failback software polling.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

pci-epf-vntb.c is on ntb next branch
git://github.com/jonmason/ntb.git

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 134 +++++++++++++++---
 1 file changed, 112 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 1466dd1904175..dcaebcda4d7ad 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -44,6 +44,7 @@
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 #include <linux/ntb.h>
+#include <linux/msi.h>
 
 static struct workqueue_struct *kpcintb_workqueue;
 
@@ -143,6 +144,8 @@ struct epf_ntb {
 	void __iomem *vpci_mw_addr[MAX_MW];
 
 	struct delayed_work cmd_handler;
+
+	int msi_virqbase;
 };
 
 #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
@@ -253,7 +256,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
-	for (i = 1; i < ntb->db_count; i++) {
+	for (i = 1; i < ntb->db_count && !ntb->epf_db_phy; i++) {
 		if (readl(ntb->epf_db + i * 4)) {
 			if (readl(ntb->epf_db + i * 4))
 				ntb->db |= 1 << (i - 1);
@@ -454,11 +457,9 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	ctrl->num_mws = ntb->num_mws;
 	ntb->spad_size = spad_size;
 
-	ctrl->db_entry_size = 4;
-
 	for (i = 0; i < ntb->db_count; i++) {
 		ntb->reg->db_data[i] = 1 + i;
-		ntb->reg->db_offset[i] = 0;
+		ntb->reg->db_offset[i] = 4 * i;
 	}
 
 	return 0;
@@ -509,6 +510,28 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 	return 0;
 }
 
+static int epf_ntb_db_size(struct epf_ntb *ntb)
+{
+	const struct pci_epc_features *epc_features;
+	size_t	size = 4 * ntb->db_count;
+	u32	align;
+
+	epc_features = pci_epc_get_features(ntb->epf->epc,
+					    ntb->epf->func_no,
+					    ntb->epf->vfunc_no);
+	align = epc_features->align;
+
+	if (size < 128)
+		size = 128;
+
+	if (align)
+		size = ALIGN(size, align);
+	else
+		size = roundup_pow_of_two(size);
+
+	return size;
+}
+
 /**
  * epf_ntb_db_bar_init() - Configure Doorbell window BARs
  * @ntb: NTB device that facilitates communication between HOST and vHOST
@@ -520,35 +543,33 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	struct device *dev = &ntb->epf->dev;
 	int ret;
 	struct pci_epf_bar *epf_bar;
-	void __iomem *mw_addr;
+	void __iomem *mw_addr = NULL;
 	enum pci_barno barno;
-	size_t size = 4 * ntb->db_count;
+	size_t size;
 
 	epc_features = pci_epc_get_features(ntb->epf->epc,
 					    ntb->epf->func_no,
 					    ntb->epf->vfunc_no);
-	align = epc_features->align;
 
-	if (size < 128)
-		size = 128;
-
-	if (align)
-		size = ALIGN(size, align);
-	else
-		size = roundup_pow_of_two(size);
+	size = epf_ntb_db_size(ntb);
 
 	barno = ntb->epf_ntb_bar[BAR_DB];
+	epf_bar = &ntb->epf->bar[barno];
 
-	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
-	if (!mw_addr) {
-		dev_err(dev, "Failed to allocate OB address\n");
-		return -ENOMEM;
+	if (!ntb->epf_db_phy) {
+		mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
+		if (!mw_addr) {
+			dev_err(dev, "Failed to allocate OB address\n");
+			return -ENOMEM;
+		}
+	} else {
+		epf_bar->phys_addr = ntb->epf_db_phy;
+		epf_bar->barno = barno;
+		epf_bar->size = size;
 	}
 
 	ntb->epf_db = mw_addr;
 
-	epf_bar = &ntb->epf->bar[barno];
-
 	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
 	if (ret) {
 		dev_err(dev, "Doorbell BAR set failed\n");
@@ -704,6 +725,74 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 	return 0;
 }
 
+static void epf_ntb_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct epf_ntb *ntb = dev_get_drvdata(desc->dev);
+	struct epf_ntb_ctrl *reg = ntb->reg;
+	int size = epf_ntb_db_size(ntb);
+	u64 addr;
+
+	addr = msg->address_hi;
+	addr <<= 32;
+	addr |= msg->address_lo;
+
+	reg->db_data[desc->msi_index] = msg->data;
+
+	if (desc->msi_index == 0)
+		ntb->epf_db_phy = round_down(addr, size);
+
+	reg->db_offset[desc->msi_index] = addr - ntb->epf_db_phy;
+}
+
+static irqreturn_t epf_ntb_interrupt_handler(int irq, void *data)
+{
+	struct epf_ntb *ntb = data;
+	int index;
+
+	index = irq - ntb->msi_virqbase;
+	ntb->db |= 1 << (index - 1);
+	ntb_db_event(&ntb->ntb, index);
+
+	return IRQ_HANDLED;
+}
+
+static void epf_ntb_epc_msi_init(struct epf_ntb *ntb)
+{
+	struct irq_domain *domain;
+	struct device *dev = &ntb->epf->dev;
+	int ret;
+	int i;
+	int virq;
+
+	domain = dev_get_msi_domain(ntb->epf->epc->dev.parent);
+	if (!domain)
+		return;
+
+	dev_set_msi_domain(dev, domain);
+
+	if (platform_msi_domain_alloc_irqs(&ntb->epf->dev,
+		ntb->db_count,
+		epf_ntb_write_msi_msg)) {
+		dev_info(dev, "Can't allocate MSI, failure back to poll mode\n");
+		return;
+	}
+
+	dev_info(dev, "vntb use MSI as doorbell\n");
+
+	for (i = 0; i < ntb->db_count; i++) {
+		virq = msi_get_virq(dev, i);
+		ret = devm_request_irq(dev, virq,
+			       epf_ntb_interrupt_handler, 0,
+			       "ntb", ntb);
+
+		if (ret)
+			dev_err(dev, "request irq failure\n");
+
+		if (!i)
+			ntb->msi_virqbase = virq;
+	}
+}
+
 /**
  * epf_ntb_epc_init() - Initialize NTB interface
  * @ntb: NTB device that facilitates communication between HOST and vHOST2
@@ -1299,14 +1388,15 @@ static int epf_ntb_bind(struct pci_epf *epf)
 		goto err_bar_alloc;
 	}
 
+	epf_set_drvdata(epf, ntb);
+	epf_ntb_epc_msi_init(ntb);
+
 	ret = epf_ntb_epc_init(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to initialize EPC\n");
 		goto err_bar_alloc;
 	}
 
-	epf_set_drvdata(epf, ntb);
-
 	pci_space[0] = (ntb->vntb_pid << 16) | ntb->vntb_vid;
 	pci_vntb_table[0].vendor = ntb->vntb_vid;
 	pci_vntb_table[0].device = ntb->vntb_pid;
-- 
2.35.1

