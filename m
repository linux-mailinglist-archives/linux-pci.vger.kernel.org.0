Return-Path: <linux-pci+bounces-15577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0AD9B5F79
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 10:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C1928398B
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 09:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76951E9078;
	Wed, 30 Oct 2024 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BX4DNuP+"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012060.outbound.protection.outlook.com [52.101.66.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8381E3784;
	Wed, 30 Oct 2024 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282136; cv=fail; b=FKj/GlokuBrhzN8ajVQEuQNbT9WlknzggcQTD5/YYfBXqW3gVSUd7wdMLoMBXLQ7cW26gsiyJJNtkZIAQXGAXX5Dbshp8MqurW6WGnxl5+4P1PDOTVDuP57unoW4VZfSaOPLtGjLw3f/X/W+ECrsw5aUSk2gJ0Dbz3YJ4unCvJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282136; c=relaxed/simple;
	bh=hyRnsl5jU+Vel0B3sgQD+sox0n8z29Fr7D20Gkk2bo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=epUCGutTXE97Kr22lsdDe5lMy0FfXj8RV7X0mNSRv+cWxwmA7b1GpeKa2Ce6O9zcGmPzIuVbRcr9Ch/RvMpK4vg0LpK1YFLXv/V6nXQqW3tRJ9f2C1GVFv1GTQ4eEZW10XV6fgRM0P3TD6luPO+6H6sKsu5Wuvyd6dfn6XKkvSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BX4DNuP+; arc=fail smtp.client-ip=52.101.66.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuEALesVyPVByAptHgUdZUYoiCLDWVsavIb8cQkwDfaj9UjQBA68WdKfeZ9VzzY+fmTPvSrS1Cpi7EywOvBQuZVsxwwDfrSIhoJSFI+zzY3FKMZZO1ODahanIW3xGCgR1K5xJ1qX1BLUdjGL7tmf8bQqW2NIBxhJ2t9oeFjSuAN4usTqtmbLzjFIpKo3DeSRH9le+u2mdZx30EjZl8PHQy6vAGH5BMF4fIuy219Z0G0Wg116qPLQ96d3tlOStWiDl2DIdb9TYABGXUIIKK7EkJBIL3dlwU5tNHx5vDc2O7h/uDAtMoKmhntwxBkXzU28vtQOFF+iF2s0V/irkfipDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXmqI8W+fc/2sSZVXMJE0OeFFECeCOvicnTTeb8H7f4=;
 b=WNh4XrIMNKiBqytGHzsSvChnRTi8qQ3nH4mJN3i8cHmAGWxm0QydQc+cuYoG/7sUvtSvIAKcn3B7zocA8VjlLEQx7O9CMSGjZ3qTrOCt9xgomcCjRnrn6Nwk4NGUIPv2udVTDSoSp4VBYr+dpfKh+km5//xJKt78Vu9yxGCYL65qs/ieovpVkHAjJDKIK40ThL63BZDbO9oL+MUx58skmBjV2XLHd2dLhg8/JXO0AxJBL0i1q8+fYUY1JN/GkaYNq49FPEiZztevYGcVLn1DU1/WAq1044SIO7nFcgDxTlm7vdIJFCtpubw70gXY6zSyQfE1+DxIHgzs65b9Bp6fHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXmqI8W+fc/2sSZVXMJE0OeFFECeCOvicnTTeb8H7f4=;
 b=BX4DNuP+r5Bzy1luA+OHhT1Y3icVnLQp54gPUIGu3EhI8RtTzfandj/ExWRkZJRHhcMEPhVB/oLIDoAUdf0M9heD7xO6G06//8d+jD7LXfkoIVyJvRGYQf7Sh162wihkMsvaZ2RPV6Mn/d9IJQxt89+mvYyDllulNTYdonK8duo5p79u8r2tUGGc5R4b5vUHBRBXwX5KrfP649BzmOjOLFXjtiKGIdK8Oz8Y+/CqVi9/i7POrwBaZA77CWpnCIQjVCgtD+KjoBtVCcmvDCnPL4yxB9AIEgnOKhdQZ+XTh6xUMBUhotfsOTbIwyqDyAhmDpVCtdrqPRu34NeO8NMkWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8912.eurprd04.prod.outlook.com (2603:10a6:102:20f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 09:55:32 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 09:55:32 +0000
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
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: [PATCH v6 net-next 08/12] net: enetc: add i.MX95 EMDIO support
Date: Wed, 30 Oct 2024 17:39:19 +0800
Message-Id: <20241030093924.1251343-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030093924.1251343-1-wei.fang@nxp.com>
References: <20241030093924.1251343-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a55ea36-ed0f-44d9-0914-08dcf8c8fde2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C+y89e1ZHn6IiFbTreQOobKz9zOWhd76lKCLrVLDAb2YgwyFT3hKyHFJVUEo?=
 =?us-ascii?Q?Furt7SGb2GfkWe2qR0gqw8nwfVbNt4D5a6XV+LGBrTYuUwY+W1CAx8oppqBh?=
 =?us-ascii?Q?jpwIuc0xJ3PfWQrE1d+UGGWr8GKGYc+Hg1J1uL9IEEmdmNS5fw3BjaJz2pnB?=
 =?us-ascii?Q?1g7OxtxHPnPg2Bts8FQX4BBiZD3qSfLN9O1mLIsE19oayYQnki1psRJIsFX/?=
 =?us-ascii?Q?AxOEmqy44LaShb3QLwkRtZilXg+r43MBM5owRCCnrKCOMwRwx5/Xxq4t2yYX?=
 =?us-ascii?Q?ZaYKbK5D3u7dI09/1UmZMv1UrWD/9sYaRZSPpJzys4gEWzleqAlJwlL/g83O?=
 =?us-ascii?Q?DenVYuUL8n7ER1XfGxg3F8pPc6+c/SNb2YeIKJQEf5g88z/C8a/B7IXkFe7Z?=
 =?us-ascii?Q?Hyv1JHt6E9jh2Pw1GtJ+0vZRQSO6TRVooMzg1096VHOY88sk4mWyTmClyfj3?=
 =?us-ascii?Q?i17aJabdOhecIXSDMDUwSHUxBH8npaidKeiNCy2tOeTskPwyMlJ6RtO9umKI?=
 =?us-ascii?Q?0HAfbIB6bdsOA5Ixn6Xin1zhyHxmLgGsvrA0tK7X9fNMbkGjdyZm2RlHOjeY?=
 =?us-ascii?Q?GhqrkCbeEB1vYpHox7T5+KdG78HbAaCSRM3bx8DXUqw/ApoTpsqFOnPltdze?=
 =?us-ascii?Q?eB3X8wCyZ1+53nMs5TacFqr4VTsLMkUUtvATLIE2m4QP7CF5/lXds8OgHZUN?=
 =?us-ascii?Q?Reh1mFdvdMyOPybzQb6cFplmnswvuY4tW2d9XRbwd7Lh8YAo8937iCDAe3ze?=
 =?us-ascii?Q?BErjcG7inwzLDhcrSSOXf0oV31sq4qb3devKc1jnqOFKUh4kcVzJy0NWGEti?=
 =?us-ascii?Q?FDpOXEpgSt8MPQ3wC/d7Jphqs964F5yroJFhEcXodufgeA1vY2CMOKSN3Qgm?=
 =?us-ascii?Q?1dvzLqbGU3Eo4K1NQSlQ8HS2xD/XKBY9iS0uE/0TDQVNZJ6GawvnoYyq7eOT?=
 =?us-ascii?Q?8PeVSZk9hy6bEzLs4rDYXA3/a9ARb/BK0FJR6Jzkue8+H4W4kcSCryvvQSKi?=
 =?us-ascii?Q?jeg6mAinezhqlRP/YIfBfW56DQFr5PBkOVEldz5QqGe9LFAJWl1ArefqXk5Y?=
 =?us-ascii?Q?Hb5jRLkBDxHcJTtr+GfKKBU8cEqo8iaq0YpHMzXX1+Mkieyejx0V19kRFYLC?=
 =?us-ascii?Q?yaivBEUKI4khsz7+jZL9y5cL2Z4RLWdzskV20bzrgvIORDAQ1NADzqqFLBMX?=
 =?us-ascii?Q?vlX9AdbLpyBv7sPavJtMTOLG78AFiH5K28QTzKhO4T1iiQZanPkoRt1YeT/6?=
 =?us-ascii?Q?o1+4vJPQpXmUMr0fHOtyHqsoUMhKvNDw4HvxyUUFw6kDwbXu1yC3k9bglrzO?=
 =?us-ascii?Q?OZINMGv3Yxg9035bQg3dQtY+OfBCgL5g4LZJMdpk+bR7fVGjBJARVTQVCJzA?=
 =?us-ascii?Q?JAAMD7iTA6zZH9mGOAClZDFF0z2Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?un8noA9x51zekHXC/d2v41HWgl70KkMIBOUIRNL+xCtwtIZrLnshT7abYeDd?=
 =?us-ascii?Q?wGw6vXKls/Bl4Lip/1VAeXF22wQkQxR05F88PRJUuDhyZW4jnRw+5HKPE4Xs?=
 =?us-ascii?Q?N/tfasj4Powh3YRCmTbvBqOJavz4+3tpVsyyT6QiktP6sVZ05ET6F1Yb5Mgp?=
 =?us-ascii?Q?7KpGlafC+LBCTFoyL2VjxH2vfhwX6tQ+a6iyAi3t9RNuGjc02BREIxqV6TPH?=
 =?us-ascii?Q?kOLkb0vvygLD6SdtWqO5dsCs5AgwFMSeS6FO1UO+ZzqfClj1/Nm5eGNAoqOD?=
 =?us-ascii?Q?NjUmD16WmcsieNTJfkj78qR7YWFTyZYQkNRQPmYtBgzPUNck2Pph+6BbMFyD?=
 =?us-ascii?Q?WA0azmJE0dytLKeTn6cH327AFXR8e2WGPJbP6o6gpmrdzuBGf4JQoy65w+dm?=
 =?us-ascii?Q?FMjcvXAcsmTIPZc6akkhGiEU/RxoJIlK9ylkYZXBbqUDimXMEp3KgSz+F/NQ?=
 =?us-ascii?Q?e/t205DygEMEelSTb9ZVo923czuJ/RtDUwllw3aBtSg4HLqmzmvY2kmFSb/1?=
 =?us-ascii?Q?7XTYmXQScmJnn+GlBmJ6T9hO8mWLlzEqkyL/eMqzm3bCS2vI2AHC1L0jqcuI?=
 =?us-ascii?Q?DrAUZzLNlSzQxAFqSdT8p06Y7KxcrMek/rsMYniGGxb39n4HdZ3Kf3a1+WY1?=
 =?us-ascii?Q?ofEuEthqx7CCqcZhQNLbFz0sC3MB14Gf5FXGYLw8DnBYLvYEszZLjkh0hbVj?=
 =?us-ascii?Q?9CMOZpZghA0es+WyvBAaAFUX3kOv5F7AwPAxesbfu91gY5rwRQL/wjyf8uCo?=
 =?us-ascii?Q?v30ZXY8oHejyTHAcGgT/K9wBhbT4csrVMUTiFMgjpbVWgfpyiVQlAdASPDKd?=
 =?us-ascii?Q?iKdM8+VrEErOGmUSuLT2c8MO1VbLs4jFVoHDdQivCyoOXvB2x1kpEMpMZ9sA?=
 =?us-ascii?Q?F9u+pZDnWUEwLr1hHJshxfMs6IVHdb8yJiyKAHqhvtF6w5TBskjEFUc6Dbr7?=
 =?us-ascii?Q?CWcIrTHnFk5am7hTeH9kdi3r5eRG/fg2WNSBmTGSGt/vlGy5CyxcYG3KJox0?=
 =?us-ascii?Q?t7WjdztBdE4RQIRMP6+QcV7ZaTe9ecye0vwqWKqZ/njwBvDTPhLTChVtCRW4?=
 =?us-ascii?Q?dGpK42NRGOSlKprsfrhjtf1Zq5iXjCAmO+6cTbXyP4o8IY+eg7Yksa0P8LUs?=
 =?us-ascii?Q?WVxU2IvhhT1fS/t9siA15mCbrGoYVm9+DAbfz2VG/SVS8RQfsURKLEKEYuta?=
 =?us-ascii?Q?bXexDzGej7BUvvtmGZoMc/TPv6dyUBRDgWCv1kQnDE49ZcXp24yS4eAzgfx0?=
 =?us-ascii?Q?bgg+P96qb915CUptBLZKc9ioRh1pwmMU8Xku8NHuCd5nbYZHKyxjYqj0YU27?=
 =?us-ascii?Q?r+vsm4l9j/J5y+X3L4YDRQBbL6l4Dbsn7kIZg8SqfZ+ZRvXbE8FyF9i75ftn?=
 =?us-ascii?Q?YZPu+rSM28NTrqpOzFWwNh2v1ew2i12cdGPhhprivNdKElLuXXiJkT7W2TCE?=
 =?us-ascii?Q?4iSUFJ2BlZwXFJ1Wujxz5lN1QTO3SBx4HNDp09EGH8d7jSEGUmy0J0w6VNw/?=
 =?us-ascii?Q?iw9Yq4mHG+NJC+r/X8gwP/7jHwjeix1bLA4ZXyqsjWYGOD79sODNmhLrrINr?=
 =?us-ascii?Q?2YI2nVGSJ/o8VGLOOMwi0iYXVOJVwoemKqwwoB9f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a55ea36-ed0f-44d9-0914-08dcf8c8fde2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 09:55:32.0001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpI6cPAmQZqrir5P0Yc56/oFWuZfTJQ6NHU2+PavifNOvXXT4USDgN1y1nNOFMpXzvtfUCpfm6LlmJ4SWixcKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8912

The verdor ID and device ID of i.MX95 EMDIO are different from LS1028A
EMDIO, so add new vendor ID and device ID to pci_device_id table to
support i.MX95 EMDIO.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v6:
1. remove pinctrl_pm_select_default_state()
2. Add macros to define the vendor ID and device ID of EMDIO.
---
 drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
index e178cd9375a1..e108cac8288d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
@@ -4,6 +4,8 @@
 #include <linux/of_mdio.h>
 #include "enetc_pf.h"
 
+#define NETC_EMDIO_VEN_ID	0x1131
+#define NETC_EMDIO_DEV_ID	0xee00
 #define ENETC_MDIO_DEV_ID	0xee01
 #define ENETC_MDIO_DEV_NAME	"FSL PCIe IE Central MDIO"
 #define ENETC_MDIO_BUS_NAME	ENETC_MDIO_DEV_NAME " Bus"
@@ -124,6 +126,7 @@ static void enetc_pci_mdio_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id enetc_pci_mdio_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_MDIO_DEV_ID) },
+	{ PCI_DEVICE(NETC_EMDIO_VEN_ID, NETC_EMDIO_DEV_ID) },
 	{ 0, } /* End of table. */
 };
 MODULE_DEVICE_TABLE(pci, enetc_pci_mdio_id_table);
-- 
2.34.1


