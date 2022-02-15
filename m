Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9324B62F7
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 06:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiBOFjR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 00:39:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiBOFjQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 00:39:16 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130059.outbound.protection.outlook.com [40.107.13.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563A41EC4C
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 21:39:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyQOcD5N6bd61bjiaDykjTHSMTg/ABo/b/32+FdG2HhHHBjwNrQMVUkC9vxRyAbHL1VxUL8l0tN8DH66KQZ2RgdnxLUxJlRZ4mb4PIoX3PoDbjcY02c5Exdrp3usmYenFSqB6y01504ha4WaYLWb1UTboiGjHBBqvdvd2YJ1I8wa7YdkBdrmhtR31PHfLdp7vrWH3owFW8DtHKO86DU8szQKx4ezlw+uDX/DBVAUR6QC5pJfIbpSmFooVLWLUfJbO/dF6SkmcTlZm5yFZ0YtwItlNd39DOkS1asEzqmaImTeaovuPn4J1JkuSDHMGaaICdc+RnA0ICObxG8YXWeOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8lJdambt1DZkBjhSD1bu8GRiWtRwsMUN8KTre368As=;
 b=DdPp4DdugOSDEct7xE6sdbqZbH5VrC+f/33/tiCUPprrrqlueNatLWEPEyXuJR5d7MhSv+kC7V5zPE1hW5jF7kuC0mWRokjfJLBkVbpQShvEcngJO9Y0p49QwJklAOAlO61g80oUD3KqmYRaWUo+6j4TccCa+0CTJ25YkhPWLKjIFTaMBH4fYRVOcNA2v6wO5U+9cQ8n74+vyxPQP5Tez5FLXSRY1Q+jY50lc6eUwoABeZmFBj1l4xsEu2GZbBkaoy6MZLxZN42eyl8BAVwxrksRRGZDOmIjg+fzFy1+OT49vW5P85nk/vq1YmD09mngAzk5fXfg0TBKL09DM52Cfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8lJdambt1DZkBjhSD1bu8GRiWtRwsMUN8KTre368As=;
 b=ewyyAuqQZeTvMunZS8yxfTzMIeLz7V05WcocK/tZsEmD9G+pM02BoADo4LMbWGn8bODDXRBxXqoh2SYQ2CVYEYk7SjKwTX9WVdgbN2ElGgX7V93ZzBlY7JeLglP5Tt5U23lvHIkBzm2TiGlrSY5SewdZbLIDSd7C/nybn0KPbmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR04MB2976.eurprd04.prod.outlook.com (2603:10a6:802:8::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 05:39:05 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::4881:43a4:4127:f25e]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::4881:43a4:4127:f25e%6]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 05:39:05 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     linux-pci@vger.kernel.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com, kw@linux.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lznuaa@gmail.com,
        hongxing.zhu@nxp.com
Subject: [RFC PATCH 1/4] PCI: designware-ep: Allow pcie_ep_set_bar change inbound map address
Date:   Mon, 14 Feb 2022 23:38:41 -0600
Message-Id: <20220215053844.7119-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220215053844.7119-1-Frank.Li@nxp.com>
References: <20220215053844.7119-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0007.namprd21.prod.outlook.com
 (2603:10b6:a03:114::17) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cf9c484-a329-40f9-b0b6-08d9f0457af1
X-MS-TrafficTypeDiagnostic: VI1PR04MB2976:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB29769A0E5E5D29197337F81488349@VI1PR04MB2976.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDffWdBx845R+jQtXZTFWlYUtvT9tGdq+gaJgyiZbebeeb+KQw3Dy7cqqzzoCz9KOeebU8dTBbDYioFZeusp8FAfe3bQg+gudMk6Yec7iU5PZfYTrkocgY+vnwZ8J8qb/jbdhRLjGBdinPbghWelWwGAd3vypdUUV6XhtkyaQ9XFNPhxEWO/AJO/wRWWTjyZMdJEEjTM+WcHmkZOLxUW62IzCQhk7FhZ3We8y7AzgQC3oDX25lpB68/uHfYXYr0T2k93KnxFzQeWxsur6T9lSxPLOqp3L+ybDn+d2RmJpgmlaZyiN1lCDpIHXZP+tzSlYZ7qnxIy2rh6NaxiDSQLnXytibbzAG/J34XsGazhDm7SEouLb2rp5PxHXOyGQdF+d/7hFLjX+r9uWATg6ksMaaLCqIQHRHLdWGTqQuay5EbtrX2WG7bj9XhYnOL0FtLrfAd/FHUAPZAsLVWims6lF5cL60qvDNWr6nzPIa3KOcTcQzlcPUK8Orz4HAcItH0XKoGpLCQU6tbs5CVSwuHkd2nZ5TIuCqd6CBBsJfhpJY9bBHu7rhO9dcXehnunOoNCoSs1z1HIqsBSKPlD8X7t3quRnjob/AQ8HfCQUEhU3GI3LmlErpNNy79EeRvsnAr6z35ZoaSBfaRXsqQRjPjRk1fsSPxQmw8e1daNSgb34krJLDGV6GBT+FlkCnESw6VfxlqpYiy05GV8OrWOPYX+yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(5660300002)(26005)(52116002)(38350700002)(186003)(6512007)(83380400001)(38100700002)(86362001)(36756003)(2906002)(8936002)(8676002)(508600001)(66476007)(316002)(2616005)(66556008)(66946007)(6666004)(1076003)(6486002)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fCreNYRqEJp+GEA2y+gM4vanE5AVhY84q/Dn8fQUbmUVqq1khvbGjeUXShGR?=
 =?us-ascii?Q?U0CuJ+ox5SVtSl7Hpy5CnEsDQgiltl0mAmyXsJdf5x7F3niv0NYSoO4yJVl4?=
 =?us-ascii?Q?rjmG+bNF+/UGnhpU19acC4FBPjMOf7hOH2SKX+E/5iAQ5HzyQpAxMn30UeON?=
 =?us-ascii?Q?axjGqGUZjPmgKQo3t1/sp9vHgzgZDlj/CciqGit+nU+26EoN/lqBvHMHXzyT?=
 =?us-ascii?Q?EcYFXQky/2+WjjsGTRIF5blpl+Q/yoaIlS6kUfHM00QkYZiyGEpFw2mki4v1?=
 =?us-ascii?Q?ATrAuO9oR1hbrJmDQ+Xd4XWTjwvi/scdcyzGZB0v+DsdcrLiU2Pv8MWYGudj?=
 =?us-ascii?Q?CdwE2wu+XMcJgKygl0Y1/Na+GkiSllea7nfT1JL7RwwkensWXDXQh3ulY66B?=
 =?us-ascii?Q?HBjOmVA6cbHzS84Pr/EjUsYYD5AMQ52XWB+6c0csjmzZReqGroOJPQGcC92C?=
 =?us-ascii?Q?3pksTiZ8V/Hpo1AR0fXvDmRtTTG6j3k27tc3BI55uUHUzoFCuqjn0p+hqWBg?=
 =?us-ascii?Q?EIztvGM17JgwYLSpMpszv+a+KtetKMO86Lo3BVmpsQdn8dcAk2JRwKtaurKs?=
 =?us-ascii?Q?j1YUxpsibgXGvdf/vYTvU9c9mYIf5lwcyr3aL9MX69rSyJvi+fz1rxe/IgR2?=
 =?us-ascii?Q?plTUnaYZdIp9APQ2RL0NXO9U7rxOw0g6SDuY4l+BMMnFSneooB34A8E/rlXN?=
 =?us-ascii?Q?1PJFjR3fYJjMASW2HXJpevSDRFgmXgFfMx6aDPDj6GU3aFUO9i9ZS/cHAmnV?=
 =?us-ascii?Q?J1J8FAQqHG4hGrB+uQMeqsgNVCN8krdLIYRm8M5VWEgweCvaq9XlKYeuj+h9?=
 =?us-ascii?Q?9WCxlxSuSaiESIoeQoPkbUcwOBe341P6Rh/xnUgeJn11xlw00S/xmAfeS5q0?=
 =?us-ascii?Q?54O6Tt1vDMF5BzSCkW72OfgoW06EGu7ztT9w8yTAo2/GT076cBsVF1XTwCoy?=
 =?us-ascii?Q?RIhBreofHAPB/bkQ89NoN90IA9uxccFpxgRzEQhjg1HBVdjgQFoLuSPMH8H/?=
 =?us-ascii?Q?UTjcq6+7WMFBXjkS4hXdBZ5rPuvUuabSp4eRNw6TUnvpRhRbsNyrg/KtESU/?=
 =?us-ascii?Q?hT83pG6+iKm0ViylopUFxzLvNnRCGQMG4XLgkUD1IMowJ5wYIxGfiJUaW5TT?=
 =?us-ascii?Q?lU4yPNMv4EwwY5bg85HqmwGnelejOKmV7/BwE8pEqGtdcGc/fKLqd2uC0q7O?=
 =?us-ascii?Q?W02fxVlKAz+NcF/h0TMod2jgXvlkpsxH3TCi4BViYlfcJ9zkDrrxGTo4vRLY?=
 =?us-ascii?Q?1vwPI3MfZin74kUWXpwg2OlC6ENYveo/XFKisPxEYBt3S2jlsLmxwMbmSauE?=
 =?us-ascii?Q?d/kVRIFziYDBot0glWiEJSnQSINPj5kQpZLXOjiYp91DT+vhFxyQ7Dw2OmKZ?=
 =?us-ascii?Q?lyZycKC7ZZqn/fbWFNjH75g4FMKj6m+u1TO+aca3vBbPbXgprscFz1v2L5B5?=
 =?us-ascii?Q?SHqOCmGbAaskXcNRiZf0I85AX8r0ATNMpdqz5pcXexx8eEAOa5dpwU4ULauk?=
 =?us-ascii?Q?VfEZa0Aw+SQEE9KwNW0jryYZABOmLTVch8aTPCyFHaEdIZ1d4370YamwaPVw?=
 =?us-ascii?Q?Nc2Z5pv6H3yBq5xmkzE67j64m8jFyQwlZzvNkljEVHVAUM9WBJRnmifJoW6P?=
 =?us-ascii?Q?GC+iK5K7LXyxyyQ+Wr6/X5o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf9c484-a329-40f9-b0b6-08d9f0457af1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 05:39:05.7736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZ9k2C1CR+tUcnxjmXWZOQJnVqHQLDVqBUqSTVq8B20vpbPDFwofGSnZ5MiQnR2P3RT0aVOJpiHgMitCHGUhJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2976
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ntb_transfer will set memory map windows after probe.
So the inbound map address need be updated dynamtically.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 998b698f40858..cad5d9ea7cc6c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -161,7 +161,11 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no,
 	u32 free_win;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
+	if (!ep->bar_to_atu[bar])
+		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
+	else
+		free_win = ep->bar_to_atu[bar];
+
 	if (free_win >= pci->num_ib_windows) {
 		dev_err(pci->dev, "No free inbound window\n");
 		return -EINVAL;
@@ -215,6 +219,7 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_INBOUND);
 	clear_bit(atu_index, ep->ib_window_map);
 	ep->epf_bar[bar] = NULL;
+	ep->bar_to_atu[bar] = 0;
 }
 
 static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
@@ -244,6 +249,9 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if (ret)
 		return ret;
 
+	if (ep->epf_bar[bar])
+		return 0;
+
 	dw_pcie_dbi_ro_wr_en(pci);
 
 	dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - 1));
-- 
2.24.0.rc1

