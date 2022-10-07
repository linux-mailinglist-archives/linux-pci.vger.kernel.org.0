Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9105F5F7DBE
	for <lists+linux-pci@lfdr.de>; Fri,  7 Oct 2022 21:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiJGTOy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Oct 2022 15:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJGTOi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2022 15:14:38 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF5DD8EED;
        Fri,  7 Oct 2022 12:14:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDcZ2FP9oTAa4VYPwqgZhiOLelVGvbqhWljfW22n9Q0luLG42sK5DRLElkqPLLL30s9WycPjgLQsgA3fwLgQhp5w5gntkpjMgQAt+UntMWEUfOziU2fNfJHHMfKvmGaC4bKMYGuxnQCYrV3LKxWesLutft6Hnrl1OwDLuBrQRd/svKyAthjxb+kRHtwqDKtXlcWx4uBghKqz1elRmML6AWMEADWsx9oeKUOeHThXviPpCFEGdxjo/r3uL/4Ic2vOidCwfZVfv/5g2V51bJFjA6W+yfrx5T2cUyePVwa0GDNve/nOpnfcvf5tQD6ciBxQnsqWGUtjT3ygyOOQAQjVDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AF6juBIUfEb+5nX+4ySQMH0fMffTYAz1usWWEhHb174=;
 b=bI14bGliWB+xCSLxRHTcgj50L9nNQpkEYM10LmM+Ao+Nba4otzNA5ZG6++Vf/KB1/4MgOsGPd3V1LChV/zRtskkcm+AhlQttwd1MC6IslC2wibdpoMYDtwLJW8uVnELmQXgz2HSD0MCMNIrDM6NeDKYVsYi2MDIzSwoFzld7WdYIdeBPiO343tU6/h9o8ghQdmWrUQYEiAQIdz9Wdgp6bDNKrGgt9gQS8Vz8wXnr317HSelBIbakTaiqs0Zn0uPIsTbjgALCTAt6EiRP/u8qBOryDuq4PaHLv+I8HDHQOwHu6Gx1bFidalmt/v90+yk4jfZ3JSvD2ZT1TALKMYYmjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AF6juBIUfEb+5nX+4ySQMH0fMffTYAz1usWWEhHb174=;
 b=f79F9LjoVoSRQeWdIUtaUm9Vfp9Ae2UEKKFuXSsaEdiaOH2kz4HWy2ocE4mA/lCVGJhM0a8LJpKSjTXV9X9+piUeeO8LbpkN2JC6c78vQ73v7fu9827QI5XvoVABpX5sy4T2I88NZU+l2szifW1ouVLMF34/38374meK7jX27Fs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by PAXPR04MB8192.eurprd04.prod.outlook.com (2603:10a6:102:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 19:14:23 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::54da:4ebc:2916:de90]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::54da:4ebc:2916:de90%5]) with mapi id 15.20.5676.038; Fri, 7 Oct 2022
 19:14:23 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     imx@lists.linux.dev, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ntb@lists.linux.dev (open list:NTB DRIVER CORE),
        linux-pci@vger.kernel.org (open list:PCI ENDPOINT SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v13 6/6] PCI: endpoint: pci-epf-vntb: fix sparse build warning
Date:   Fri,  7 Oct 2022 15:13:26 -0400
Message-Id: <20221007191326.193079-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221007191326.193079-1-Frank.Li@nxp.com>
References: <20221007191326.193079-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|PAXPR04MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 02efded4-0a41-4f46-5336-08daa898248a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2rs/trbiKnESiT3VnY1yCU0S/1JBLTsoJIENblkv/Ic0QMqU67WFEQxJwFfvdgB9JEBTBlOJk7IzTWQ+tfA+MX6U3V8hDGtfsOA7SwRF3i6dPoekMm3y7u1s5yTLvKzuhHCaAxnM2L/xP44MlgiSRSbrpqoy2CvCUy8A6CCMUzABdSjza7y1cIvikSQkrsksDmaFyzpqe5ZVd1pklldtQXIP+Rtz18jHRfMIrLxshblPcCgUWQGk9Dj3eBi/D+L5FCSJx+XsrXsK7VaJcZ4avjK+Jvw64XSnnPwcgD5qvd3q2AlARivrRCdKlk25d69lvmz2LqX90OiFidG5pKujQf0kz5Zpng9aNH/7AUg5BCOyyHJqZ8xrRkcXQxI5mn6CKoVYlvXXzrkFz1PpbKiNPZaltcZWAFZDBBiR4TAYcZaP9msjG1l7CErMmVq1zIbAq6eweOxws8WXhVExlq7euQ9YQaNMjpsd/Zw79WKvsXpBpLKerVdTKoSqmoVsWRPptYR+ExdswL9cYdGT51V1cAgHRESt5xudUVkQH4aZ9K6mitjJ/J4a5i/+iMrNUY+OnXwp5h/65dvcPFQ82JApNBdW+q8QqdeS00UXQCys8X5hVBSxWd6pwq4whD47dVduixNzwNoo8d5vwfo4/v/PLbC0YccKHIc1mx+EvAHiC8N3aOuyxNRIKmzh+jQ1S8k74Ivgfdyi4pYcTHSuD3X44hEfcQBzTUR4uuBmQ1aC2gby2jW5iKLzFyQKicuNcIP2C3aZBDFT6Zm91rGK0CjXjGJ0/tBcUIQkgYeuB/VxkdI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(66946007)(36756003)(7416002)(38350700002)(8676002)(38100700002)(2906002)(1076003)(41300700001)(66476007)(186003)(66556008)(83380400001)(6512007)(8936002)(2616005)(52116002)(26005)(86362001)(5660300002)(921005)(6506007)(6486002)(110136005)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wsx9KZkOFICTXV2hXorz6usH0EKYqo2s9/YrRZSbp662bQF8vGRmNiV/6Na7?=
 =?us-ascii?Q?IAu8+0SMV5pqZyERp7haHH+P/6SoUxSk4fTDZ0NrbAWVfkKy/p3pM6YEUyeC?=
 =?us-ascii?Q?oDW/Ebjsq3/TUSD4JNg6ptp7LTw+AGDVRjuRIOjeORKDY53UCP79o3Og+6zV?=
 =?us-ascii?Q?5efyodxDmAmsLNTqeH13nGsWgW9VAuloC9qvHXYHmPhcuHAiJht2ibNj/8Zg?=
 =?us-ascii?Q?Tzc8KJ3oPSolvzH+4ptjdcYeLskfAL7eJyRQ12mAk9GYDtIq6qwC+xeKLilW?=
 =?us-ascii?Q?HMvGKCiAFpIydWEvo1375O8tQd2ta7QNyRgfefLRKoHV53JqaqfGBhnzQTrb?=
 =?us-ascii?Q?fO4Hd/rYbOtfwbBNos0FjqNZIXIidS4IEtyUUKjDV9rSfeJrUOd5jB0O9S1a?=
 =?us-ascii?Q?MLPDJzskTdjWyd001MrDCIbT3bdbZE+PXUHpbDv24MaRmkUTmACmpV7yJ2sR?=
 =?us-ascii?Q?+BvdHQxA6GqG/DkXp5JQSMrAqoRPrCyTU0porQjO24WB7KWZFesIWXjTVeox?=
 =?us-ascii?Q?Maod1TR4MmoEkQgxPsq1yooO6wG3ent8zcOfzUTixSRgVIZ1Oo8fup+REZtc?=
 =?us-ascii?Q?2HpC96DPpm/C1Dn6QRMWUtdzuP56GZPeUq2qWf/undz+cdCfgdisog8UjZsU?=
 =?us-ascii?Q?OJD6Fl48xbVKE9v2XZYNNgppQXtc8kch2egTz8V36Mor+hhyK1FNvOc4PH7B?=
 =?us-ascii?Q?iCU8aSsOXPpueRcYjcxnpbsfUuI26ci0Qv3ZuShkmx9RFBK2cdyNDBtliJfi?=
 =?us-ascii?Q?x2p6Wnwz1DJypdA8ZFlxmfMgXcNhB/eGL/8PNoK688hOA+fpeWe9QhzuSQ9X?=
 =?us-ascii?Q?TykDvJzUPOci+pOTzc2wQaUQH75h9IQKx7ci3NMyMyAWLT4epad78LpF0TeB?=
 =?us-ascii?Q?bXSN4Df4mYST7kvI/rC4mchAdCIhVB8tlFlzoxAYFT0COtdoUvVxc/nIErRv?=
 =?us-ascii?Q?inu4QRaNLFG58Z+7mdsLGWOKL/D3LBRDUnYXKBjUXSJ6P1ViCMKrs9j5iyOc?=
 =?us-ascii?Q?t+4lgB791oU9IvS5Y/S04IkVXgL9Mdff2FijFf3h4BsDGNv6S4DZge5iVGpz?=
 =?us-ascii?Q?yACnSzOi7sTI9bYEbF5k9lvKUnEKmJGXZUt7N8qt+aIIwMIAYIetbRB+eUNd?=
 =?us-ascii?Q?K44rsDeDBIpztRDwraqOAiOCWU0AHoiPnW2w3QrHlQEzfL2ddePhICuoFBug?=
 =?us-ascii?Q?EVBCFF7rftmmyZRBN2YFwhuOzz96ofF5S1zD9SwiItRsHQaVblRv9mYm84Tc?=
 =?us-ascii?Q?xOmKrAuOJ4VIQF46dH5JYGe3mDLF+AQE8QXuM0U2y2atGRYAvlceQSa5Gei4?=
 =?us-ascii?Q?+6JZ8/8aXA03D5nP0xv05238a+7g18iWPp3lSWMY7NydHOJ7LHNcz/A640h6?=
 =?us-ascii?Q?GuaQorYAKR/GXTpYURfiBazCFOYvxbrnjSlQ1UoUEygzYmVi7/JvCUaZ7Y+U?=
 =?us-ascii?Q?chW0TnhhkAhpN8EI3CflzF54G4wXp4+0yFgCTtyoJ5bmypya9iIq/drhDG5v?=
 =?us-ascii?Q?O+KTBQdpVHZKGxiVWef0xZexOKmd6+femZ5UOzn5tx+iBBi6U2KQU/NwcFFx?=
 =?us-ascii?Q?0q4GziFY6Nn3zlp7zvg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02efded4-0a41-4f46-5336-08daa898248a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 19:14:23.0699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4Fi0MCzi7JUbawLmImUqGsvuI6p3mpU1hMQpcV6LfwsswZ7IBRqabzzS+mXm1i9/WOdM8aFb0s67qjWyxvGNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8192
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Li <frank.li@nxp.com>

Using  epf_db[i] instead of readl() because epf_db is located in local
memory and allocated by dma_alloc_coherent().

Sparse build warning when there are not __iomem at readl().
Added __iomem force type convert in vntb_epf_peer_spad_read\write()
and vntb_epf_spad_read\write(). This require strong order at read and
write.

Signed-off-by: Frank Li <frank.li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 27 +++++++++----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 54616281da9e..9f1ec6788e51 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -136,7 +136,7 @@ struct epf_ntb {
 
 	struct epf_ntb_ctrl *reg;
 
-	void __iomem *epf_db;
+	u32 *epf_db;
 
 	phys_addr_t vpci_mw_phy[MAX_MW];
 	void __iomem *vpci_mw_addr[MAX_MW];
@@ -257,12 +257,9 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
 	for (i = 1; i < ntb->db_count; i++) {
-		if (readl(ntb->epf_db + i * sizeof(u32))) {
-			if (readl(ntb->epf_db + i * sizeof(u32)))
-				ntb->db |= 1 << (i - 1);
-
+		if (ntb->epf_db[i]) {
 			ntb_db_event(&ntb->ntb, i);
-			writel(0, ntb->epf_db + i * sizeof(u32));
+			ntb->epf_db[i] = 0;
 		}
 	}
 
@@ -529,13 +526,15 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 {
 	const struct pci_epc_features *epc_features;
-	u32 align;
 	struct device *dev = &ntb->epf->dev;
-	int ret;
 	struct pci_epf_bar *epf_bar;
-	void __iomem *mw_addr;
 	enum pci_barno barno;
-	size_t size = sizeof(u32) * ntb->db_count;
+	void *mw_addr;
+	size_t size;
+	u32 align;
+	int ret;
+
+	size = sizeof(u32) * ntb->db_count;
 
 	epc_features = pci_epc_get_features(ntb->epf->epc,
 					    ntb->epf->func_no,
@@ -1123,7 +1122,7 @@ static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	int off = ntb->reg->spad_offset, ct = ntb->reg->spad_count * sizeof(u32);
 	u32 val;
-	void __iomem *base = ntb->reg;
+	void __iomem *base = (void __iomem *)ntb->reg;
 
 	val = readl(base + off + ct + idx * sizeof(u32));
 	return val;
@@ -1134,7 +1133,7 @@ static int vntb_epf_spad_write(struct ntb_dev *ndev, int idx, u32 val)
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct epf_ntb_ctrl *ctrl = ntb->reg;
 	int off = ctrl->spad_offset, ct = ctrl->spad_count * sizeof(u32);
-	void __iomem *base = ntb->reg;
+	void __iomem *base = (void __iomem *)ntb->reg;
 
 	writel(val, base + off + ct + idx * sizeof(u32));
 	return 0;
@@ -1145,7 +1144,7 @@ static u32 vntb_epf_peer_spad_read(struct ntb_dev *ndev, int pidx, int idx)
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct epf_ntb_ctrl *ctrl = ntb->reg;
 	int off = ctrl->spad_offset;
-	void __iomem *base = ntb->reg;
+	void __iomem *base = (void __iomem *)ntb->reg;
 	u32 val;
 
 	val = readl(base + off + idx * sizeof(u32));
@@ -1157,7 +1156,7 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct epf_ntb_ctrl *ctrl = ntb->reg;
 	int off = ctrl->spad_offset;
-	void __iomem *base = ntb->reg;
+	void __iomem *base = (void __iomem *)ntb->reg;
 
 	writel(val, base + off + idx * sizeof(u32));
 	return 0;
-- 
2.34.1

