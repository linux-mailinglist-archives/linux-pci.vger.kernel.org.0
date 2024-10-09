Return-Path: <linux-pci+bounces-14072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5AB996692
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 12:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5B1287EA1
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 10:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36971925AC;
	Wed,  9 Oct 2024 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lrSqWVf0"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A101922F6;
	Wed,  9 Oct 2024 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468430; cv=fail; b=U+jhvKcWupjRvE1H7MUNYa2TuRsgS72aUFDJ7vxcWx+7y01UYngv4KneDhQ6TAZMbNmITHOSnVpIuMvjM/kgItM+X6va5TQ2XWjeYBVjkiv+cVO7ygB88/MeS2pDvlSsa1uJ5ueHVa+CYPL3+MrmT2y79Y4we7ML1CwK6l+r4jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468430; c=relaxed/simple;
	bh=bavqQl0aoqUHAjRcsFCoVvqDURe79oU9IwJ5VOEOnas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XO8tD36opm7lOp005zpNMzMnE/TKFfITrOYv65btxpK1F2PU7cHWNpvrqHIip1aKsgHiUR5FYPDjYWyKWP4ZedpSJRcDUYs9GiusnKXESNLPeT6cqWswn4VQit/UVoZe/wl8cP2/kOYZ7Op1aVtjLRu/YxDHev+cdlScu7GWFMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lrSqWVf0; arc=fail smtp.client-ip=52.101.69.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsbVj0EV60gFWAhSNqsdsxgZpjSJuzabhqZbwAvctP5XVWkhQgIY5G8vMo/yCvfkqmwDn7pBCEE/El1zmh+7a7nXUafKF+whM4tdm9/HSzdMjmYQ1FAwUy3hNob1DjxiSR6NRFb+r/n6GfdeVktowD0w1QYBNWEOa7WIxrLCHfGcMDqks9mMmEcJMsVPDq3/DIrjJLrzX4MHYlEMtYk9/d8U0C0bUhAAhjrR3IfOBSPI/+0xNZ8YMxDKpH5GAZAPVnWmcWgsLc9wn0P4QFxjm8gO/iNWhCLVyCwJUwT5Dx8pGPYXhcq37qX6pE2vfYyHNQP8oOEQZ7umhUBekHo6DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPliVlTAjyRM1Tuq9GY+56O5XqgUPKRcUQVD4O4fa3g=;
 b=oePdVR31cKHkZ26b+N08srihT9vGF6sCuc+n+MP02ljTLbc8GH+dscmYZujQAgNzaRSN2qAYI2FCOQidHZjaGoLOHDABhxSytwQvIMV9oGceAAl98S+Cnu77m1qmPD2jLGozDz4qv6yCT0/a5/+jF371RsDUvNSMUlS3pl9yA4mDg4ansqDns3r8EdJhJ9DQJIUIK8EmaHrguCL7oDn9pl0GqKt7srxH4ECBqz8FF87bfxCYEUPbpSj1juumjW3r0klSpG56CHT2BA2b7NWN/FFgNPG8UdOes+EIqtgkgTnDOK5N2VqUugpBepilxGfDQkQqeTwKbgaeZxdIZFNiYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPliVlTAjyRM1Tuq9GY+56O5XqgUPKRcUQVD4O4fa3g=;
 b=lrSqWVf0PJiqdd9WqpBOtknwcUGmWFPER/hycBauN3JAgIY8tJX8O9svCxfdrfc/9L9TIrzaqSTuAL0VF+u10M3bHcdIbGqpSGBPUVbxDGh5fQuJ0n3t5vAOi+/pAL/6gg7uvBRSvukoIqqwnxpEVDTNPgufAstBRZOsmWgDBuEghhKXBSvAwQJAxYY/U+rb5r0bR10T/Kf0OyYK+KGJhZoPVfQCu3bD1NXYr6w00Tva5dZmSeeL1STvGO/uJcijvK9i2wVrAqk5lGjFYNRed2zWSR3JOhgpdJSzhwXtkvZ3A5lcg8/PNU2mGYZ+SNnyYux3V+nXEjWvIdtV3BR7rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB10154.eurprd04.prod.outlook.com (2603:10a6:150:1ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 10:07:01 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 10:07:01 +0000
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
	bhelgaas@google.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH net-next 08/11] net: enetc: add i.MX95 EMDIO support
Date: Wed,  9 Oct 2024 17:51:13 +0800
Message-Id: <20241009095116.147412-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009095116.147412-1-wei.fang@nxp.com>
References: <20241009095116.147412-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0175.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::31) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV1PR04MB10154:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5c38f3-501a-44d6-233b-08dce84a1e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FEdHiFuKdhN8l86bndPPnctkFY/fZUCNE9FA24DYGW/2o+Rzu0eBjptTxSzI?=
 =?us-ascii?Q?tnsKn787C42auMXBqH3xp0YBx+NpNynrDT8nlBq0h3U0KD5ayt3Km67WgC+I?=
 =?us-ascii?Q?f/S5hi/qqOwq2fQAJ59hQ9xZJpnq7icUxhfVOjwkgXfmV3538eUDI5thFNOg?=
 =?us-ascii?Q?kOmzJTmGjiQgfysDjekqdaeFhzSoB+hXfvpCid0AHzk6ohbVtpgtGZ+H/gq3?=
 =?us-ascii?Q?OdBh6n1OuymdMDbARWvcEBOk8McTa570jhei5wyGjZcQMful+yD+VrGvO5jW?=
 =?us-ascii?Q?724eWvD8ybSLIQEnBWLkSphSVeq9wkQx+3rlWcfozfo54KsVTlTzWlT3DJlu?=
 =?us-ascii?Q?WU9DEz+36PR60/kEqjWfaiBkkRGXO5RFcNYw9Tsq0nsFZpvPWzDONKf4X2UO?=
 =?us-ascii?Q?oejyvQDI43IsOrguIC2+JERC3LtV+4JEc7Z7Op9BxA9pfLOzL7aao1u4gwLj?=
 =?us-ascii?Q?VbYv0qHVdYdJGGupbsjlqz9BeTGPGzO/tX1aSLKEJRIhkoyXelRm6gzuaEMR?=
 =?us-ascii?Q?2COcuqqH7dtMTSYyJA+cOTZWOVJ21AfELl5+m0welEFJrm4LfL0L/b5Dh0cG?=
 =?us-ascii?Q?HwwnJE91g1s2R8MXUK4PKEv4F7KaKpwGJ4gEQ6L1u6mOD9r+rEcy0jWdGkWe?=
 =?us-ascii?Q?QtdPnPqLyBSy+TXdMUtIrCX/je5ah/5VMfOfgwiFrNd+tYKyJIqZXzGlFoQ1?=
 =?us-ascii?Q?6FqufmvfRoJ14Ev9crr5UOXLxh7xYkWGFndeb4CpyFRNaIWP+38tGV/fiRw1?=
 =?us-ascii?Q?tM1I6TZK87R6pFjTxQqS0NvXaDoWrtT4ph1YopxD+IFAAYUQu7U12mAmrnEC?=
 =?us-ascii?Q?mBOm8gUWKq/ntom4yllOVdNvHtqnZ5dAx7f03SMn2rOlhgdDPAHLyFQDy/EG?=
 =?us-ascii?Q?qEPKRFDotS9htuP6whV4CStP/Oyc7TMwDxxlkHETNcgP+vgOn4o2+2lkBMlB?=
 =?us-ascii?Q?RYUCVD9QeBSf7HOPQD7FdTpcqauYUhjcxVTYmzM3dpflL9UhtBqUHs5ffDJf?=
 =?us-ascii?Q?4phFUhZAY6iueeAeF0jdw30YOkN0l6pRV5YYlpTETaj3p1lUAq88tgL2WfFQ?=
 =?us-ascii?Q?gMnAc+UeOWMBjkzM31pMHwr9exT0nMvFG6PLA3ESZ6Qgo1UyIgcX8oYkDfvP?=
 =?us-ascii?Q?h+fv18FG03PF5HTBI0mHfY2qHVjcJq0YmLogKDVMnM4DeN21iUxIeYPzucLX?=
 =?us-ascii?Q?h1gDMwkCiI/VgJ0EgXZERWsjF/esLRL7rxBRCEnfipISfSDRl9TTQrcwnzP9?=
 =?us-ascii?Q?vIVeQzg6bOI21tDQXZw88QsKnt8g1LbmTP9YV2sJKLMZTH9OG2iorYyd7wFB?=
 =?us-ascii?Q?7bHkL9Z/uFgsezz97Cz/p2E/HfT9u504eA89wtWccJYLq9IpnX0qDePaDPoZ?=
 =?us-ascii?Q?RTN9y00=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qJrSLMgUFF/R2UxsbU8/fnQxQ5TY1SsacuGBg66ta5sk0SzZF0TCNjGSkVz0?=
 =?us-ascii?Q?NYtsEVNKTrffIa5WOCd9y1RpVT2n4Ge4iE4khDGIs8EnSe2pIc0u3p8IdpTk?=
 =?us-ascii?Q?mmAGEGCi7RHKVnMPswGezdpk7dSIjhRHtgw1scVbVFnA8sDsbbSKKA/JgkUx?=
 =?us-ascii?Q?sDLsAvJlckM+XANSHPRHV4C5fF50cIyMapoUQ4JYIMru60HyOhHyWyiweaAK?=
 =?us-ascii?Q?+dpv1KLiTMxu5OYlNubdopMvK63KPk/Jf8kKNv08vPLRT3ODQGRz2dDQFAjN?=
 =?us-ascii?Q?diqR4yk6PqOW+6Ni0o8Dgj1+8eHpPb+BMYCxOFBW4SwgnyY0RqJ6rdEEJ8rG?=
 =?us-ascii?Q?xhFr02MOm1KAUeu5tCC3qdELjLLXYfvOiydLUFsQTjYraQ1EqcaQBMfC0IOp?=
 =?us-ascii?Q?yXofotToX5EW/GY5oV9m8WT7V4sJrhq941RJO506LRYGT1JFm9m/eM34q5HZ?=
 =?us-ascii?Q?kfWqXgxBxMWfqOam01B67Gi94GEQJY2q5+7YPFsif3fGRtcHeTxQneSxytPJ?=
 =?us-ascii?Q?oh07qgsUDU/37DBA1+tLY8tmXY/3RH1sEP9G7bdtgUcoY9CVsgg2fIq21tso?=
 =?us-ascii?Q?QZZ5y7Ivk7A7So8MvfoQmrTdrUHOBVyX6zAfN8BwYxJDEAAXfO6JOVZuX0l8?=
 =?us-ascii?Q?ju21kDfGmxAc4GphxNh4xxhwFwjhtWSUAcDbKe3xBtqvCXcV2sM8AwfOavBi?=
 =?us-ascii?Q?UcKCLUA14uLIIiOBuFjDmbwwEtjBfp5fCEK8KyqUMtSet0NoaltPlhN743ke?=
 =?us-ascii?Q?tn4vMILZMPRrHQ2w18Bh6zQo811sxB4Gybi4hUWRHXidtWDLvDW9LCSREN6B?=
 =?us-ascii?Q?p93UBsK5N8s/HwTIjds5VDH8bX5KB1NfE+Ug4RUF57AknZvx0y/NojrnzIf3?=
 =?us-ascii?Q?fNqdJeBQJvGPMn+4Baze7ngFr4FWG+Mp9Gl6SxPyJl4QyTtTOjP9oVGaS+dU?=
 =?us-ascii?Q?HP/RdSaydbu3bVMDSUtVokR9a9psbbvPRUegcKgvQC5onCFpPyGynhKVHZ6u?=
 =?us-ascii?Q?Czwz1Og83sb2WixNqe0ZVyj8kKyz3ctVUh4cXYjLBt07nZ9dCA+Dr0InPa61?=
 =?us-ascii?Q?BahAeQQo1c2KgeVM4IfmTe8It1NG8hBUJlxKH3HzKflvjUQpHhNNnp6KUJ/+?=
 =?us-ascii?Q?GBvtrwtGmgnOHLuqW14etkA8J9WdOwZnRDgu+t1ylINbnmN9ebrhYlb6JEkO?=
 =?us-ascii?Q?QbCio6FMs27hEegNgWxwapgBkPv88xgEiqh4OfLThTyIqyjjHPpy0e2EiH3U?=
 =?us-ascii?Q?rlvk6rTGbR+9BKHXC+teKYzlwld7hmklesBA+636GW6jbqBBTGozGdnrhHK6?=
 =?us-ascii?Q?BUTg5dWU6BLtD+ah/Sr/sU4740CRMYFh+cl73I/29FqavSoCnMKfiFR1Qk5w?=
 =?us-ascii?Q?tq8PjrEQdl6MEJjgZgq7O61jknAE0Qfp3xV5wFcxj8FEXbNFr+gz6pPr2BfW?=
 =?us-ascii?Q?lzre1A6sqcAOZunu9tQS0J596aKAaSkHaYv0uXv5LQWCLTnveomHJa5dLYZ7?=
 =?us-ascii?Q?fwQYXPb3cDvbrIXOX9WWzjG6fgNoekqDPdEPhkzqzTSm+uYd4u43zyN/Cs7c?=
 =?us-ascii?Q?YAKYlVY5va6Sye/dKIhNxsyu4LpA+9G6gAKEHpj2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5c38f3-501a-44d6-233b-08dce84a1e6b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:07:01.7082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6R1DmBfHXRJKJuYR5NTu3aJCEVZT9F++BXD4bF/J91mIzrr9WQHVo0N+K3h6GdjVqQZxkU2Lg6TRzTsqWEtm4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10154

The verdor ID and device ID of i.MX95 EMDIO are different from LS1028A
EMDIO, so add new vendor ID and device ID to pci_device_id table to
support i.MX95 EMDIO. And the i.MX95 EMDIO has two pins that need to be
controlled, namely MDC and MDIO.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
index 2445e35a764a..9968a1e9b5ef 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
@@ -2,6 +2,7 @@
 /* Copyright 2019 NXP */
 #include <linux/fsl/enetc_mdio.h>
 #include <linux/of_mdio.h>
+#include <linux/pinctrl/consumer.h>
 #include "enetc_pf.h"
 
 #define ENETC_MDIO_DEV_ID	0xee01
@@ -71,6 +72,8 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 		dev_info(&pdev->dev, "Enabled ERR050089 workaround\n");
 	}
 
+	pinctrl_pm_select_default_state(dev);
+
 	err = of_mdiobus_register(bus, dev->of_node);
 	if (err)
 		goto err_mdiobus_reg;
@@ -113,6 +116,7 @@ static void enetc_pci_mdio_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id enetc_pci_mdio_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_MDIO_DEV_ID) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NXP2, PCI_DEVICE_ID_NXP2_NETC_EMDIO) },
 	{ 0, } /* End of table. */
 };
 MODULE_DEVICE_TABLE(pci, enetc_pci_mdio_id_table);
-- 
2.34.1


