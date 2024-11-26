Return-Path: <linux-pci+bounces-17322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581C49D92EA
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 08:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F93DB25EE2
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 07:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04011B0F30;
	Tue, 26 Nov 2024 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B/OVxgxI"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF131AF4EE;
	Tue, 26 Nov 2024 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732607896; cv=fail; b=eWuBmHZL8SZK98ZIWM6hvEab7h32KaxsPn6MnPOBt/lJrKrBp/nHH/MuQuOWbDc6AaTPqfz5GoZTbbHrYGQGQlQK0O5r5BMtjjMYYKb4ZtZFlBhs3cfWsWIPEonWo7up2jQbQdH7qGT6RKhCMy1uPQe24oKVvfKFpSFNyDmK2nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732607896; c=relaxed/simple;
	bh=b6p7bctUqbrBwEYJnwNFTABSq8TtcXK6Z3nJ5qL/pJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mWmnPMV+cuaXKh0MgcFyQ4Fv+0jy2VGVbsYBUyxViAEvtZPh6abGFHNDkF+tEasJLACxtfAYRF6z8n68RjdWx9C97IzWhb2fnFrqAKAxKUDwYOKvC4RcAT0YQN3WzCavmJ+GWqpto+VXF4ntEWSeo3owKFgkTaydABej0d2oEB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B/OVxgxI; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9M/ic3DiUosb3LIJuxT7C2S3DgU+SSTbgEGiSGox3fzOgz4aGY5/pjf/HcdN5dwQfVFazBZPBYwx73EsmKFceERuaS9SB0ClBz+y48WqEg6FxEmaVCE7F9V/fDQY8NzdMZq4UpqbghdyG6GqoJnbLegqlA4r8jqVqSGssSthn2HElnXlRLx50eI+XEIHFh+u+fzzmtWcI096PtpRBHS+lrRwmqfxzZoVMcRyvBUu3kCsHHg02uFiVBIIcjRz0urmTcF/v2Jou/bz5qdwWVAblt2HTqDfCR5WqNyChwOMtRgi6vuda+W9yUjJ7jAQ8kVUN0tMfmnV4UVvLzBaxpr2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxI4VLAgO8GCMamGaj7SYQwMPhK96gaRu9Y/7KCJ42E=;
 b=f3sV3BwCT+YgDA8EySUXbPDojhYKd/6mQMZWiE1TnXazre+5QG2+BaQMMbx06WsYDZgUw3AbHh5RhA6Id6YWoptRGwySCPjqoBNw1LngbPwbctWiazf3uD6otEgblrOWcvoqEbF9DLFpQE2kBxf1nXBpKijGt46iOXwueQLbW0zVD521nPIg0ZL6fHZiTel8cO1ZxIdMAULLpulVRU3A9Wk9wzk73NADPz5sKsBnL1M5pZHPvFdiqOWweuOcYZVhxAzkcGY1lvuPDMl2zfTHoKKpMeNJ3NNSphKzK005ESOv3dcZ0OAkKHofeZqQa1MDPgjd7M0pVpBHnBXQtnOLcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxI4VLAgO8GCMamGaj7SYQwMPhK96gaRu9Y/7KCJ42E=;
 b=B/OVxgxIrjwNIF2rBhgdORDUNJvK5PU7mbD3kYSuXyiNdDiu0/7BL6+7wwCrOBWANdoyi0W8j7a7/Gw4noqSNeAP3V926/ZXJDXTK/JRqOYc5XR6+tn69Rl1rmoniH9TWbEIroqDCIsVeDvkEuSKzpTCP1q3fx2VQDHHap7tqiEA3Ijxip6tWscWHcikYqn76cjKy5xfHVq/0szUrX/MrIU33YGdYq+y+PDbvtOA0szLqAw4ef0YHMs1W6vlpJTboPYbA8tYnx00fwN1NJ1htyjj11++Elb8um4yfi0GsRm31PeyaU175DLwt1x8iO0ZpUd2IzgdE77/dKrVZ84oBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8489.eurprd04.prod.outlook.com (2603:10a6:102:1dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 07:58:11 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 07:58:11 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v7 05/10] PCI: imx6: Deassert apps_reset in imx_pcie_deassert_core_reset()
Date: Tue, 26 Nov 2024 15:56:57 +0800
Message-Id: <20241126075702.4099164-6-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
References: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PAXPR04MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b550961-c669-4ac9-923d-08dd0df012a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XDHjEt3T/XhZvdR9x7xa3xtG3+mtWRuaVDN3diq6bqcV0r7v2yTzs4TbFWFr?=
 =?us-ascii?Q?RDxpx/ImmZUFnT3f/ZctjjlqsnaNO/rpuW0nRM2NW521dh4eAWa88Xhg4NoY?=
 =?us-ascii?Q?/6iPEwEmHOKx8fkracTEkESL9OP2pFSPtZqhFZzvuL4QB8y3PS2I/Tct8ptM?=
 =?us-ascii?Q?jf5+rrvmb7ZjoF5xntCETh72px0MWbA54QbLBKiBlTEUSQJ0TlgXLLxu9SEl?=
 =?us-ascii?Q?6QthBNbG/DdlsL9SN4yfVRQapeUpuR2STz1h/iH4GErfIcw5wwXopd32OF/h?=
 =?us-ascii?Q?O9c3k+gV0nBeS1X8McIDrtI/Q4xywBjGfjiUcIK7OmEkz3ZUcjlCOp49oZRl?=
 =?us-ascii?Q?lEYShmVjWgf28gpReZkY6gT4/CbwRhsqAPHM0rL17w7eTaE8sFWCj+3+SUKz?=
 =?us-ascii?Q?hyZRrCJS1YL+zTazR8xJ+1zk7IZ5Su2/M4vOWfaxkxISwWGZFrZJ5Xx5yu6e?=
 =?us-ascii?Q?yF9ap7ZAKLkjkH3USviEVj2nnuK/o1tTz5qHtLmTqHpRRXOgveGOrunFIZfD?=
 =?us-ascii?Q?m0WcmJ/EQW37GsUWbc1bkuADPPhf7tAE+9pcnZO1P7pF7DpRHpEbYHs6KPQw?=
 =?us-ascii?Q?/uSorIpVHVTqtLAL9dLhqazxBqVOzmoYuNNFiZJRkXU2UWm45gPOuxpF7aqN?=
 =?us-ascii?Q?fEDp19yKjFGA2tk3H56zh5sNrD8VT+uDe59wG3c0Rb8oPuzQG1mHUK396lWL?=
 =?us-ascii?Q?zF4H7isiwzUKPpYRW1C5GwIv3c4UI3nlRXeCHFlFecNWieAJWR8Wwo0tC77c?=
 =?us-ascii?Q?ZL+7Km6ZNASKbACHSH0QHDCnTKFtXSZPNelsdFs6FiyjKedmd19v8rkuO4Q1?=
 =?us-ascii?Q?8CcKMondv914bmiuK8gENyNirQy599t6OHz1DQaKK+6AVFc0nMaRlSseFf8M?=
 =?us-ascii?Q?WKmyugEqENpgLffHQzys5oDPSD4gHdL0kimsz74ySWE0IO93gfxem/8yeUXG?=
 =?us-ascii?Q?PhKT1GAFotauQZV7m2qqNH8i1YOD59VrSg/uS+Sr7LLbiJRhgy2y75xKMjEi?=
 =?us-ascii?Q?FHCVjs2RO9TWXy2K64g2X5vBBEgs07HFeI3SAzVwJRkV6KvFKWBTJfA7u3we?=
 =?us-ascii?Q?oBZ2vVtbRvVx26lQl4xTsWht2MTUAT2Ip6S13zUGsXZoyq965NGJmZaicYje?=
 =?us-ascii?Q?/Fg48IHJ8/IlcJ36wi5q8W9Yd1cYmgqQcaUlotXofQc8zTWYfz7jmJPAo2Jx?=
 =?us-ascii?Q?fA4T0FhRQ7d3jcx9miZi6gg2CKAO3o+ctU29hRuy4gxwNVajZena4YoORco0?=
 =?us-ascii?Q?t6PlBXWE8wAhN3lanY9T5cXFF1YTKXzwptUbgx+D2d3WuYug8RyrJ3zJTSev?=
 =?us-ascii?Q?x8zEH9t/KKi3OJA9VRBZ/SruHF0Qxdbjal5OOZbhHvjApyJtwKYcA01aPymq?=
 =?us-ascii?Q?bRtotvJTwzuB8ZRZvFkdwqvAjegL4oiBSBDah9E9puiDlR/Ow9SFWevu0vmb?=
 =?us-ascii?Q?+AlHEaOAmhQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?adLTZHBlYNMjIUuQCbWR4vzh/EP8Lg/wiD/RQCIs2V7nkX0iH0cFtV6qnfre?=
 =?us-ascii?Q?Fdi/I4dZplDzHMpV5LCGesijI+/GVAeiNvFakAKMUffCiNLDcCHraJXT+QnO?=
 =?us-ascii?Q?SGnq5FXsd5djx6zYkHrge7bwfKU50UXkOLS64riwAC3Dv5HTJTSi0VnCVJZI?=
 =?us-ascii?Q?+Gla7JB8RwxHtEIJRQyV3851WuUvJ2rx2j9Yb9hCERnMeiiboHjblOe4u/X/?=
 =?us-ascii?Q?6MaNQWPXPHGjuh6u/rjsffL8pkrX3et4aIQwo3kA8KwgKFtdDU2UTWuRakde?=
 =?us-ascii?Q?0xyrwRrs5HAYcaEEvRiXOTFSAHjkezIB6UWrf4JyjmNdhHi73Z/ZnTmJYwfB?=
 =?us-ascii?Q?nbNsJVylq/HkcyYK11aYTwos5Fy9e1Qd1c+c7vfnpUthTctu592gYmS2PJLY?=
 =?us-ascii?Q?Xvlss+ock6idw/6IHf9vr2IckjLlwfzUiHK+Ljyqx65sPImJFih4182oCtYR?=
 =?us-ascii?Q?QtaqATQ4NegJYzlCd3n0z7F1Bfn69KY0vLRivsFUOGnvf7J29trGNGWSdY1V?=
 =?us-ascii?Q?r5FoS+yS8bymSV22urD/5a292btnQ4BSli+EuKRnQMFIqbMDjIqE306+CElX?=
 =?us-ascii?Q?Jmst0rB70skNOGdpyFhX0Qst4Ga2z52cD7tIqxvgSiPPz4BOkVqTjfSHvpmL?=
 =?us-ascii?Q?Vrr/aRPPHlZflQhmh6KeqeLqQ9KVkN9WANvo05bffPj+Q+raTrOCRZ8qEylj?=
 =?us-ascii?Q?KD92Ckkf1ZwA4GbjQryI1KLml8iRSqPIg1WgTmHdYHwg7QqLlNHw7HIQoBjP?=
 =?us-ascii?Q?qxUMcKaWe+N3wUSll1eZV6/0CHXbUru0M22dttBn3+5hrfv8aO/0/T/iauLd?=
 =?us-ascii?Q?uV4pHNsgxK8VQ0368gBWMk8R31vOASzOUCoeEUmBX6hBmBdDfCN0gATk/DOz?=
 =?us-ascii?Q?J+5XFzlcHdJaOB0UkenHS/BPNCHFNSb+7Rs9tcLx1wm61aTdl+flScYLl8ff?=
 =?us-ascii?Q?fLJGztJ3Gpa7/RYAqciJXilsV5S92r1yzZQ4Pi3P1f1Fd3eNwWfTwvAz6AA0?=
 =?us-ascii?Q?j2Zz+uT9ntxb8nCmjC1unjjrmk33r2/tKNCmaKVu2YZscfJKKG++tjLYjdhD?=
 =?us-ascii?Q?WSkbgikgls4HrMTIEqkddPEtMcY8k2k31wV0lacR5Df9XSDjMbBBqGNbWkOL?=
 =?us-ascii?Q?4gKRFr9SZPirtm+G9RMASed+cZCwFbhcT3zR6QRPs4aku7ZTx7tVUQoyfQzm?=
 =?us-ascii?Q?gWXjWXJu5J4Zu2R4/ePxMypLm2Lk8JCmwOSFNfJxdRXC1fRJ7M4qKAfjMGc0?=
 =?us-ascii?Q?nld04qZuk8MZSYbpewrX0j3YtWYFX+WU+8ihN76PQzN0Tb38eI3jCn2UuaoM?=
 =?us-ascii?Q?BGxLOwcIalvrJSg5lDLmlKeDAnR7ZtV7/PbPv8tUfhDKnw6z3zFm7UYnucO9?=
 =?us-ascii?Q?Eko+1br/nP7vWVzXXoj89XlyNME6ObnmxIrDkTbKptwA0B7otnBN620vQT69?=
 =?us-ascii?Q?XXPJAam7m/4mk3x3sJYTO1WsUXrhtu5M1ihazx/NFVsH9B774ln72ECSF5R3?=
 =?us-ascii?Q?GztxY5BlkFaNf4Tw5SuQ/5XQirdr481jMSMKvZR8/faLllsP7MTgACmxzG4d?=
 =?us-ascii?Q?/79eL4q+gfFc6FNcZqr6J8xPHbcB7+6hAUIAuyAH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b550961-c669-4ac9-923d-08dd0df012a9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 07:58:11.6370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGC6B4VeL4ZqWlSGcnGQSEwzqv8aOmlFD8uToYZWgq+ZU3OqExUFEMSlDgkxtIayo4AecdRVVcMc1V8GvSdR+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8489

Since the apps_reset is asserted in imx_pcie_assert_core_reset(), it should
be deasserted in imx_pcie_deassert_core_reset().

Fixes: 9b3fe6796d7c ("PCI: imx6: Add code to support i.MX7D")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 3538440601a7..413db182ce9f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -776,6 +776,7 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
 	reset_control_deassert(imx_pcie->pciephy_reset);
+	reset_control_deassert(imx_pcie->apps_reset);
 
 	if (imx_pcie->drvdata->core_reset)
 		imx_pcie->drvdata->core_reset(imx_pcie, false);
-- 
2.37.1


