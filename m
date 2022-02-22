Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0054BFE72
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 17:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiBVQYx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 11:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiBVQYw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 11:24:52 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30078.outbound.protection.outlook.com [40.107.3.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6AA166A7F
        for <linux-pci@vger.kernel.org>; Tue, 22 Feb 2022 08:24:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJKpxg4Ss6VtmVzuY1PAqdtGbWeNFirjElT2PlqfDS8PX8bwm1nvriDUZ3cg+OKqMSVIkoCA7LGXg+C62JtrSc6bVejmnbxES4ezL9IzA3t4rnd+3JmsMZllwHouf07EFQ0QXJUF0+HnTHYRxJ7IraFZUgDZvXZzMWhFa9/N4KtlffOsRMQi6vodlMWj2X/nRZMPYLZ8EgmQN6F+mjV0GnXCecV3F8ZK2vc9t2XR20t5RDmP1/CTqhDzX/DCJScs3CsEprAHAbq00OnXT4fam3eMQ20VJ35jZn8io6XW9fDE0LeDrLRKATO/767a0LNoAj7qtcqHolNi6aC0nA7MFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RgWblfR/C8f+Z8AehLHL9Zq+OOFwooZ/LpJ5Pds6d0=;
 b=X5AsZQ145GIuHD1IYVUwxPXOkNT7ypBMT8z7+DDW2c5G169A6rYg6IbC3IoqcQBp2rU4n/XlV/t3FoTSC1qIRtilFxTBH2ovRB57s+elG91V+kFvK40hNHYjHatnYLHWs0zMpnRD+wJpzC+J3R3GRfW6erNGMvo7Bmz6G33x7E/huitGzmJ5UPXsRubxbeYcYVz5s2+avHXBXFB6NIvU5o/4TkJ4GsQrpi5dd66CIWetihbRdBPc2IK+g5G3TKznCzNm1INW8x0xcUZ6LoBRc+MBg0sAAh1NSyFKaficmPCWfr4F821fLBZYJ3ul+ebcKjOn5vgzAng2IoMQztCkdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RgWblfR/C8f+Z8AehLHL9Zq+OOFwooZ/LpJ5Pds6d0=;
 b=JLok11EyMJw6tRpOd83EdUvSExmheYvdaiuRk+OLnje1v/EyHNA4HPJq1Nnfohnyez+/PlkX5Ff+YtVQARGDFiEYJkuSl3SORx9Bs2CdrbZtxTfcT9uCBUDzZDBIq5i10y2LpGK3/c85y+sIupLuXLwVm+/1ys1RD/VvBJjmKnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DBBPR04MB7899.eurprd04.prod.outlook.com (2603:10a6:10:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Tue, 22 Feb
 2022 16:24:19 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::9ce4:9be4:64f8:9c6]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::9ce4:9be4:64f8:9c6%6]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 16:24:19 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org, kishon@ti.com, lorenzo.pieralisi@arm.com,
        kw@linux.com, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lznuaa@gmail.com, hongxing.zhu@nxp.com, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com
Cc:     linux-ntb@googlegroups.com, linux-pci@vger.kernel.org
Subject: [PATCH v2 1/4] PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address
Date:   Tue, 22 Feb 2022 10:23:52 -0600
Message-Id: <20220222162355.32369-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220222162355.32369-1-Frank.Li@nxp.com>
References: <20220222162355.32369-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0190.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::15) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fc12a77-14f0-4a68-7560-08d9f61fc6c4
X-MS-TrafficTypeDiagnostic: DBBPR04MB7899:EE_
X-Microsoft-Antispam-PRVS: <DBBPR04MB7899450093FFB73AF20445C9883B9@DBBPR04MB7899.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QSlfid2WtZQ78erVvz3G/KCHAaae21MpDBSN3AKbvkMEP/NaSTn8/VNEHQ8MGu7U1WrHzE4TB1MdxXNR580EmrChpiGPmbPmcYfrYAUHlfqHfcBX5SllNwYRVVhKorrzFZWTjbPuugj8w3s1YJGfPUg2AQhIbpNbU4H91GKz7BFamgmTiXWCwSxRSpAKzNe0Sq66SM3nG0IEOlYCQODxuqaYmkJ7uCqWinoCVSj8BLeOL6f25nzICrqPCW9+TjInejabCeWSp+z4oLAmDpio5+stjpigX9SQZNmClsf5hH0cTe/fJXdLwU8o9C+8HmyyNH5Nhpy+FgqSttwha75Ye4NI37/Bu8ATyszc1vOq3L8AneZuoFmPFhksnUScxhLzi0TiU1LLK5fSseYoChJstftfmJJmcEbJcncFQQZvifyDN7XeOtYy1cvpoZUPBuwntKpGrvag4GiDOSrDCruVd9GCw2b/UtROpwAlFsF1r1jprNxRxKROE7bPRDdIVUFWiBabO/0qP7DSHxNjINRqOOT30dmQXh+/MXnM3CWpXQB2ic3dKMWewyoGEWs0kNdk/z+sfeEv2U3boTNBERVPqM5i2RFOjGRm2qcudTlPEI8cgpSBPLJLOWUvGiSX6yTcecOZvrLYR5Bj9IHs9j5Zqvnb7dT4q2mbF177OIhL2Wh5ATW/kuIh/exFo6KLwXrigFiv/xfz/5y3vD2fLebx0HX6Kj0/9s2QPtg5dlf9TV4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66556008)(83380400001)(508600001)(4326008)(36756003)(8676002)(66476007)(6486002)(52116002)(6666004)(6506007)(5660300002)(15650500001)(26005)(1076003)(186003)(86362001)(8936002)(316002)(7416002)(2616005)(38350700002)(6512007)(38100700002)(921005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+RpC4rsb86wMxRaJUeZDrDIBLrEKW0ig3xruzswmLH3rd0kXN0d7YLAy3uDL?=
 =?us-ascii?Q?Xmd1cEWKcbMJ7AMIm6YUbjQpOPN0zY7bURoalyiOjiecM1s+geVR7Dwsk68D?=
 =?us-ascii?Q?NHPPiOWlcIQBsxcJCdnXJgbHTuqpjKykNtqfKpWbMSo38LL8ZjENpHkq9l19?=
 =?us-ascii?Q?ybUlRFXOpEsnwD5gEvfcH2YYYkFpv8J3mpfRcEa/AfVd883CTvgVJPx6JgoK?=
 =?us-ascii?Q?6+a789XL4rM1zm5Nh+PdfJRXUTnvvW945pMFDF+mUlBSC8nfA+VaiuVrgq8v?=
 =?us-ascii?Q?y1GlpTPtC2JDlvm9P0QReV/SLEcSffYc10hbnWTuC2ob0AvurlTqbk2+/5Kt?=
 =?us-ascii?Q?6X3ypzALcyt28d7X7I3aEMgP+c935DHASwo0pGUAjZobhcxOFagEUSiYZbTj?=
 =?us-ascii?Q?TDxE3+4jsshKhwmgQvOaVuQ44GrKVB7wwPHG+cdyt5pouRDlW9l2OxgNqnpH?=
 =?us-ascii?Q?So8P1FN9w3l1iV3/+0D1X5xMeE2xiG5n/tcfBzCphdZVyyOefCKMwkMZQbPF?=
 =?us-ascii?Q?cEzyBkPsTQgASq1OuVJmD2Hm/xcA0qsoLx0MYgusdYd+yz/u4gZMPEWykqv3?=
 =?us-ascii?Q?RKySUdJHG0a83vpXpgt+T6MrKCLFzuC6T/DDiRLhszw0e7KbkfZmkaTuyJQq?=
 =?us-ascii?Q?OHqfG6X+sLRc51DeusYU0mRPhOdzPNVJxMfXJGhm2xtXR+RUlu5pDhmiBKDX?=
 =?us-ascii?Q?kQassyaNqfzx7LhJuDt/DeEOBTA3BaUVwpowOJeqcefs8bp+OaTMeHBq3Ars?=
 =?us-ascii?Q?BFMgaBjFwWz9NpLxcKKeeLDze3nsATWZgaZTMwY/NBzIQNuuuJDPHh3R5lnK?=
 =?us-ascii?Q?RFxkMiJWXIXOy6scXRLAm82E2cB30Mzp8l3wdcM6rlTQ/KghJksmlvYG0zX4?=
 =?us-ascii?Q?wg2NDsla3YAB+t20d6eSE080bp9fMFvfB1gIAQvYs1+cguNL9PZ828TEuJO0?=
 =?us-ascii?Q?CScia/MAjYD6GuP63uwjMHVPPi50ZF0yRhlPePQtK5U+I4rH7vXOPNwa9fTz?=
 =?us-ascii?Q?8D3wq2jttt/JDkL1zCMlhngC5UTtk19tWIt0Ts7PEwcE8BEqOYjkHMjJ7uaE?=
 =?us-ascii?Q?rLy4m30WA45jvYHgucgIbumQLnZz5w0RhcWNsV7LUGHV6ObIIDeR7mH/XMxR?=
 =?us-ascii?Q?0MiyZ33wj5g0wVtMKnmntrEBODxYMidV+KrpOlNiv7VOgKmxh0ZQze5VaVS3?=
 =?us-ascii?Q?A031F0XDmUlGVqLT4qoUyfeIPsQYXctRayzJm+r6Au3Nm7A7jpDgTJ38feAO?=
 =?us-ascii?Q?oDJCXgh7xsrDvWMIfQ+R3OnhAV6FLm3B/lEd7BptGpXTDjDvzacla2SDi2yK?=
 =?us-ascii?Q?Mqx8qruUGsTd++i1TAgwvpqSI9v2MA1gXGpWWCCPtOHbjuWrRGQDKnhyA6FF?=
 =?us-ascii?Q?0Zcb97DEYWbmKMACY5dpI+XEp9TEF7hmpTKzOWFt29clyK7zlj6tMKchO/eS?=
 =?us-ascii?Q?COV+MwXtngiDZyYgmIFlHqv4vZ0Bs2elxzYBaRFd4UoH1k4Tw6uGUoK/SVXh?=
 =?us-ascii?Q?fEbT0w21gQSd86diIoS5xjn7cQ0KaxYUwN4xVPDsxkV0R0m6UPLnrD7oXvfS?=
 =?us-ascii?Q?tg1pSYt0VcM5DHK9UDy7tL9G3W5g+g0FmusiWAVX0Tg/ezywNS1kEYP7NHZK?=
 =?us-ascii?Q?75nAJdZ90o8OfncvbSauJDs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc12a77-14f0-4a68-7560-08d9f61fc6c4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 16:24:19.1162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAYcSE8KtiKEFhejf3vBCrjczBDIeAInXbqeBSoZ+7Cqe1O7zWn3SjCgX5Nd5trU5wRMyrB8f+boiYbV8Hz2wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7899
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ntb_mw_set_trans() will set memory map window after endpoint function
driver bind. The inbound map address need be updated dynamically when
using NTB by PCIe Root Port and PCIe Endpoint connection.

Checking if iatu already assigned to the BAR, if yes, using assigned iatu
number to update inbound address map and skip set BAR's register.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Change from V1:
 - improve commit message

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

