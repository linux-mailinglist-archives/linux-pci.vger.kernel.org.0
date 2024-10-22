Return-Path: <linux-pci+bounces-14980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C57659A9958
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 08:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3C4282DC7
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 06:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350E815666C;
	Tue, 22 Oct 2024 06:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VokrsB++"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B6C1465A5;
	Tue, 22 Oct 2024 06:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577301; cv=fail; b=l/d+jelXu14qKJK3rTZU96SESo9c6UYmoM3DW0O4qzVtVi6vTZ1+U7GfGB5gI7/dKqDtcRoj7F5jvB856d5AWvEQ4WFE8vnlW0sNReaQeopOlz8Hh23d/8Yp2DPvutlcD78hh9tjbsEBq40YfMhnsys26pOXWyneupaSWSG+6Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577301; c=relaxed/simple;
	bh=RY4ZZpijTUBHMdY/ozxqU3De5Xm5alyvLCJEbAYx5sA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pJzVzVDEVs7jmUufxV2BEjQkO/rSZQx01vKGfGXflyPFYbRbG4d9rtdrdOK3g/ITbaSaXXuLQLUMWcXpUp4wOudyO5H45jLFKeJ1kizMDqdi6hwLywLbQA5M57Bi6xF9dJeHwOEGYFIt6d8kqh9ziViBt0a6CMNQUp1uNzhwBAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VokrsB++; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azDqJqUe7XwpkSloTekzDB8banFvWqTVx0C2Ke1PDsH4OXI6eC5U9YisbvWQcYHeY43owGCYtCrAmlROvoW56G1TNSjx5J26dzxsbkLs3jkiPyptyw7HMdIfmHIOUh3rOmfGfwmuh3ZU1+BRXyBhnwvJkO+7BuJz/A3YLUiwzFC+xxcfhfM/XQ0eH+nlIJBcdc0s3N/9+hoGtzmIeni806VyzkuX87nV1XlDcF778sgg1I+ZIIp1669+v2JRZfXRoiD9FbcEVviPypsV8DYzmbzUlSMLCIBVtkDfghLddtL6UeXHVlVNK3SMaI5MMasSE2X+moy6y4pj0V0+I8TWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cF51rXBwr3FKJihKEGdm2vOShETmCdGZG0YyBB3HWE=;
 b=KLgjcioWJjkqpqxD9uyxwxdcQaeeHLv5j3TP29HAGc3crRtiQXScIrqZx3E1vTaGuegOx69L3/dFbw6xWacxv6T/CnDRSrpyO0ZkEu/RwHG0Y2lkGEtqaxo+YOpC4sxbrtp8FOT99EXhnJgbBhHwz9XTnqzUW29GfxGGZJ+Pt+uQS3wFnNr792hC6dGivzrpw6zqeS1d4O+xWTghpZAN97+tZ2UfHHE+j3aKYfx4pK8u3WBBIS13gjpsprq5lRPlkPrG7uZCX0qPj/kQ5DfrprmJE4XfjX7sj4qbDQ1LdlqGqXTF3Y2lXeroCuuC1YtX8fP+h2RkxsdqVGc/KmlOlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cF51rXBwr3FKJihKEGdm2vOShETmCdGZG0YyBB3HWE=;
 b=VokrsB++YTqNPNofEavXViXZfwNcY6z44HPuLWV/R2b2/CNJFQe8dKaDku7F+3LLcRa2s+AOgbLsuracm+kxyI0dmUB+0sTXRYDjNMgYdcvIHbqkokouCax986Q0L/1NDVrNAGSMh0iQIjz5C9W2TZ+IvAvZ7kjZf+5EOLUIvNZBjTUWn4OW2QMUJCtj18ldSPuhK5QkGBIyJZZjIPFGi74giUxaP1SKP8jefqiSnmCY3HYVO9aH2ZbYnNrj/LCFfHMSuyGY8hNkyLseyZDKW4ikzXJ1HlbTQWAS7H5aHPgwTcuDGgxOQPZh4x2qjFXoxtnH7BAgaizH66e0FaXa+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10178.eurprd04.prod.outlook.com (2603:10a6:102:463::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 06:08:16 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 06:08:16 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk,
	bhelgaas@google.com,
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: [PATCH v4 net-next 08/13] PCI: Add NXP NETC vendor ID and device IDs
Date: Tue, 22 Oct 2024 13:52:18 +0800
Message-Id: <20241022055223.382277-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022055223.382277-1-wei.fang@nxp.com>
References: <20241022055223.382277-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10178:EE_
X-MS-Office365-Filtering-Correlation-Id: e93b7dd8-9f67-4cc9-ad1f-08dcf25feb57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y4NJogaqAZm8v2hvbaND9vQ7WNZHJ3q2/w4Zz9vYbShUob9eKCocVJt+IsEv?=
 =?us-ascii?Q?bplnz1kF6tQX0iI021OyzUkKsob8jeVYbucyFUP2eDu/4h+EszQbDMRhEDV6?=
 =?us-ascii?Q?9Yf1z57o3+tnCzSIxiqMXNELcSIaG7teiM436tgvfVuo0uvX2ywtMj1IzmrR?=
 =?us-ascii?Q?IsiwR3I0PQgcELi05l9DTGvWy6q+VhIpAhcGEP97KbiPCHAnmHJTha0lOufE?=
 =?us-ascii?Q?ArAK34688mqTreBwuccr+zlj6R5d5nH+/EKe9Ox6PX2P04pUuQS24kFU7Oke?=
 =?us-ascii?Q?1nbofrr977lIwn+DbCibU4qxAwpbhZk5uDCyhLJHrv6CiHXvSzmWOnwq0MTy?=
 =?us-ascii?Q?tSYPsWdueckynt1ufItd6dcd0zUYThYRgR/oXthZjKFRzz27DqOuk0aZ/mD3?=
 =?us-ascii?Q?pGHa6c6Zs4pJqRpjtS0Yf6qIfmgI8iRaivr9ACS2CFABPjuMT5J3wFFqouJ6?=
 =?us-ascii?Q?BAVspHmTK1kySF/JnSdSpY9pZDT5s3xG2dMDS7D84RS9xop379MI54KnU2r6?=
 =?us-ascii?Q?a7mtK8K6VaeyUw9cRsyPTd3s7+wHmAlPP+8CkNYuBk0YGoE76iJxL8aDEai/?=
 =?us-ascii?Q?Shq0OOLcne2JUOC1ZzjWQ9LjbobFdGh/5CmdMfkZaopTiD6xBRJyAkhUvbDk?=
 =?us-ascii?Q?KgtQDgXkIgaedM4DSDQMobw7Sg4G9KlEOSJe2FUuM6de9yFfI96h3jcN4V4o?=
 =?us-ascii?Q?yA5j6KcTzb8Fll3bADMVfu1KqkAaHE0Hon0zOusIdm3Q1QoSwR59FZwtwZVD?=
 =?us-ascii?Q?8c6iq29E+JEYR11u7u/dXJsciGDuoCMdPJEfUVqtfw8w/EzJ1KFklvq5c5t2?=
 =?us-ascii?Q?PTWLFrnLWZkTLXeOkOh/94L/bPMAOQ/zxSuyTsd6+NJ4FmOnZJvJBGZWx2Pu?=
 =?us-ascii?Q?FcsRZcCNm0AfQ+6pdR6jQyxU7Kds5rcpQUG32/qhbs5kVvzwwR+obnTfUXgL?=
 =?us-ascii?Q?zdMwafQT0nbg1sNV1ApyXIJT018FIt+zLeykxkAVDBqvbkOCZzv+M6cmt6GR?=
 =?us-ascii?Q?yy0Tfna5CYqZ64acbDssMWudwFwMxWGeoX7GiEj254GOnh/XnhJlIUXOWjvg?=
 =?us-ascii?Q?1wpZtmmV3MkIbZCQe05UG8OUOsnwTN76kyNiK8pa/BOCyS+Sa6+3c9r19DXP?=
 =?us-ascii?Q?3eKdcZI0gPOQayFG3OM7LwZyth41PfEyepHIsb6MpfKeRFE6Upg6kLXbl6JR?=
 =?us-ascii?Q?Dmqgm+/pdCA0q/nfievcbFy1kEjiory21kvaVA/4ZMD0+Mes6MZMPYUCc0eq?=
 =?us-ascii?Q?/Ku8P+1XH2p+b7tQeFLaMGz3SnwWvRhmMCF3kvvyLainfwWTjsBN67Pg2ZwF?=
 =?us-ascii?Q?qFVMSVaqO3kyT1qkF40+3+jDqynSmpOGTDBuQaiWCbAXOVDDG6qpELG6Xsad?=
 =?us-ascii?Q?BHARo6YYWcESQ8SYhH0xAQqbxQ4I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NUH8tuartPOnz0dgpOUq7YOvPOb5ECd3ZCHpYhD0hUxoNi8t9owNFg8muatX?=
 =?us-ascii?Q?RSXG2vdAmP/Ljznq9Ld8TPpokMVwmVrRv784MFkDjiQGk+pK0s71VdBzdYQu?=
 =?us-ascii?Q?UMvdKAgEb8FM9PVn6sbMvHNFphj+AreUXSiuwX9YA4FnvwJDWM7fDU1mUVW3?=
 =?us-ascii?Q?NAgajR4GIqRUlUBDS4b3aIay2/GlO+yHaY6sR0PmRPJn0IGGwQZdn8NPHOqK?=
 =?us-ascii?Q?2lItGZS2PC4cR3qwyfWh5CAn+3pSPLrU2YGFcW/8VYpuz/+kefELQOGM0P2w?=
 =?us-ascii?Q?bSkggKs+FmRRGvcfNpDrOsgjDWDsDQpBJxh1AueDd2ceQOJywCJLLqljARJF?=
 =?us-ascii?Q?jJ5Q6k8jOr/Eca+tDKKPA+XEdaGaIi875YWEFIbu5On5ZcmIXWfFNo/0GBOy?=
 =?us-ascii?Q?vnub3A0p8/BfHyuN4JZjMqvVTin72vIekq3sIS5ZhcTVfCoE9eVfhZbE3pSj?=
 =?us-ascii?Q?E4+p4aCNbVHAtot44qUWrPPcf1HJt39dRaH2WAbB2Gw9aPJFjx8n/fePOgL+?=
 =?us-ascii?Q?mZCDj50fyao5yA18p8SyhaPISr4L165DMvk/MLhSJ24cljNhsx1/duNu3XvO?=
 =?us-ascii?Q?xgFoNfg6QiXmBBhAR4XTyHRlcAIAe9YnwfR1ED/i0RthWALkYVDV4/TJ1YOd?=
 =?us-ascii?Q?naWv9+iQnFZopkUxOsDTIvjlR9GJSnIbU3Fh9yrNV+ptqvbQW1XoMZgO6Qki?=
 =?us-ascii?Q?rN+to+eXrXwFgXVpbKej54ugs2n5JY8U7tJo8aQhTHN10QWruM0HJc0PoMeY?=
 =?us-ascii?Q?e98Z8rn+z1iY9s9wmD7w2XEn3wE+mNKXSEghOB8RguuXTRuFJPq1B3F9smWx?=
 =?us-ascii?Q?GdKkgZgog5aKCHHULEtT0VJSgD/c8xZAMHJCpqwaZlM3UCP9y/KSFgEovvIL?=
 =?us-ascii?Q?daCK/rgL1ml+orSSRyhkfFosA2MomPzPST/UZJNC7lg4eQdc441WOZJIhTiX?=
 =?us-ascii?Q?f+BsFS/QAbciMA/v3wAEYo8VPgwPtkppazdionVPhXN1fY0H4xKMsdVgLlbN?=
 =?us-ascii?Q?5MFSoync5UeF8oZGTxnX7ubKqtkb1P0KaC1VX7RBudrpn8itajx5ZClFnIUY?=
 =?us-ascii?Q?/F2Zl+OZudTAMhoC+/mqMD2uKb+OPlRaCcAOZ/+w7s98mF/O1ZGZhA0IIkPg?=
 =?us-ascii?Q?nau70aan+p70DlC7NArBdB6eh+qhivvXb5yDTYBdmzTtW2aJYqA/d2Rlv3Y0?=
 =?us-ascii?Q?k9rGPYGUHK3+X5FJ5X8lxhWSd85IEwna85rnCCiH/9onA+0/hIQC+5dwpEns?=
 =?us-ascii?Q?NnngpZHHYP4nWJUGe7um/B9scnYOx4axX/vWfe9ZjY2WO+DjcxCKJb/Zpfuv?=
 =?us-ascii?Q?s1qILx81BHU3RX0yNAUxYhkhalKj4jf/FVcCvB7s170RHZZEpi+gL1c/RbKZ?=
 =?us-ascii?Q?vDhALvqv42Uzu7U22c1IT5ZQRkGZ6fZy0Y6wG79mBpWJqavrd9DYsIJ65ynT?=
 =?us-ascii?Q?Q0ieOGequjiZ/RpBZnRV1fKaN4pJOEAtIZjERLFv1yF3Op83Vkd0R0+FbMCj?=
 =?us-ascii?Q?EgS3ZZNpRjuNSamo3ebWdC8Hhu1TUlpNLDXubOJqwj1jlYyyKuH77G/lxi22?=
 =?us-ascii?Q?AQRRbiPplrwAlvsV57K0ee0UFBtsFIEiUNUg2e+z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e93b7dd8-9f67-4cc9-ad1f-08dcf25feb57
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 06:08:16.8012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDXN6hD5+c/V3v4O6eubjVKfSfyo/OQCxzb9qYLc5LxJORJd9QXTG8aAvTRLPLTIXVrmF+QCdPEpI6LvxSttJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10178

NXP NETC is a multi-function RCiEP and it contains multiple functions,
such as EMDIO, PTP Timer, ENETC PF and VF. Therefore, add these device
IDs to pci_ids.h.

Below are the device IDs and corresponding drivers.
PCI_DEVICE_ID_NXP2_ENETC_PF: nxp-enetc4
PCI_DEVICE_ID_NXP2_NETC_EMDIO: fsl-enetc-mdio
PCI_DEVICE_ID_NXP2_NETC_TIMER: ptp_netc
PCI_DEVICE_ID_NXP2_ENETC_VF: fsl-enetc-vf

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
v2 changes: Refine the commit message.
v3: no changes.
v4: no changes.
---
 include/linux/pci_ids.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4cf6aaed5f35..acd7ae774913 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1556,6 +1556,13 @@
 #define PCI_DEVICE_ID_PHILIPS_SAA7146	0x7146
 #define PCI_DEVICE_ID_PHILIPS_SAA9730	0x9730
 
+/* NXP has two vendor IDs, the other one is 0x1957 */
+#define PCI_VENDOR_ID_NXP2		PCI_VENDOR_ID_PHILIPS
+#define PCI_DEVICE_ID_NXP2_ENETC_PF	0xe101
+#define PCI_DEVICE_ID_NXP2_NETC_EMDIO	0xee00
+#define PCI_DEVICE_ID_NXP2_NETC_TIMER	0xee02
+#define PCI_DEVICE_ID_NXP2_ENETC_VF	0xef00
+
 #define PCI_VENDOR_ID_EICON		0x1133
 #define PCI_DEVICE_ID_EICON_DIVA20	0xe002
 #define PCI_DEVICE_ID_EICON_DIVA20_U	0xe004
-- 
2.34.1


