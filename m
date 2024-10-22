Return-Path: <linux-pci+bounces-14979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7C49A9953
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 08:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10FCCB22AAA
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 06:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958451547E2;
	Tue, 22 Oct 2024 06:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OoKCgA1e"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AD315443F;
	Tue, 22 Oct 2024 06:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577295; cv=fail; b=IUA+nibqJedOgdB/rpLNM/xh6CVJ7xxCWHb6A+PTKyPxlFwWK48V634GRjJ5l/bwojiR++wwCbpZoc8lv3jChyOXUUyToM8Yh3rLyObkEkHfi/SD8pj5Rp8y+svbXiJthoz6A26psNz2vj07WuSiyO/NJvtM3sZiyYreimB774s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577295; c=relaxed/simple;
	bh=Eu1BS74ANXomq1hCfFdsvWbebq6Ai6cbLT+ZoMUG2R8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WF/5Ymt3vZvH7pp878ANB00HRKU/HlRsSKP47n70Yh1iaGXVMVij0LunLYGx3MRf73gyL1J+ER4dmwflBdV0exM97AvumZclErzY4nSHKc9X+9uF4YQyvYE7NbXywETYrKsWHme0F8BTYrEn6p34+0PibRsXaNAu1xJuveD5ixc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OoKCgA1e; arc=fail smtp.client-ip=40.107.21.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FG1yi77qY2KK9Ww5nhVVf9QpPFS8aHJIR0IHgBn1wOKrafuAQsfLF2JV91jks3vxvNMi5QklMP9GneRRhKZX1FqpZCpl/U+T7F3DgEQSBFnJXGLisoxvBeRo89sm9nxVnE2KT6i04Lld5dUAw8721ULQUaIcyetugIBlF5XUBxz1m9tDo4JsU62hDHBvFA9PAlinTQEZLVGeCtJWS7kIGCizY1rVRhKQF3JLnRYbbnJ1YWz8jTwG5rnGbS2PXjSAGx4hSHv+f5VwKufasGQFwxw40k9pjkeKgAbTtz08QhBMZAVLy7pnMF3R5lOXpPLWNUypOROHigspI000zLcrXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbJbsgnVqfcvlmsoZu6lwfabIjlblR/gyIDOgIZ+eQM=;
 b=uU/aJbMTEiT+4ZIyWWb4OErDUaj5/ODygAq1Z5MSsJIG8uU3Gm3S1Ix/McM6YG4MLh4x4aQ5DKgTtVILF5JvklN6IQks+3yuRd7oipLYtqhKwIRAeUcipo0/BrIci21v6wpa1JFNHAvSOcFF2I9q0Z8F7/PnEfTKxIjkCTIssUgBVk8q3vo8MuMAEMOq4e6Lf0xWzXIezIFQ1yen9rgENcjxumADuApFR55g/J3MJcwNpLlemJhfq9wHic2EPXDgZz5KbTMtJp2/AUrR5y2JXEYPoFrnxy3/MsiS36AqrayOVWJI8oe567ky21+6dfQTAVOgnfJRYi/jNRZF40+hYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbJbsgnVqfcvlmsoZu6lwfabIjlblR/gyIDOgIZ+eQM=;
 b=OoKCgA1ebC0Z8BdWNua8k3WX4f6vCGaw8RoRgHDL85V5SKnmbi8ak2Mt1Om6VM61nJn6uPXLnI4DkDHs983ZMaYGL6I5aUiLavKWCHTeYt5v0a1NLsZpk2mAffhVdQHWWQnY1J7N4QBOSIfYSFOSZtzFuRTkrgnezd7fPeWVEXWMkDokeuHoCoJKtPUyv7rbYBJiBHQdmDxW9Q45CWcFQW0gaGvlp2dZiX6cfc9GdPOahO4C3sFKdz7gNLXOVvWq9SmLrvV7RFIyv/b+fw+edgWHCbzbF9QKOQ3oNu1bZMJoOImzSUDQpuGhuY6ZnzHBvU6VL1Ng2US6TCfEuj+H+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10178.eurprd04.prod.outlook.com (2603:10a6:102:463::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 06:08:10 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 06:08:10 +0000
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
Subject: [PATCH v4 net-next 07/13] net: enetc: remove ERR050089 workaround for i.MX95
Date: Tue, 22 Oct 2024 13:52:17 +0800
Message-Id: <20241022055223.382277-8-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 38dbd55f-66c4-4fbd-a87a-08dcf25fe795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QgsOG0sQ4v0j9QAYJNRMCEP6VPZHwoN4A3o/1Yrwef1RTXCcr3LaKsGoiENu?=
 =?us-ascii?Q?B+Iocf9+yPAEFCxHZFWaF0E8tN3PF9hmdci3XtnpOX5ttd8ToSTYSgmbw5mF?=
 =?us-ascii?Q?w8o4VTCW7WGT65ylzEAGgwg4efs6jSv31Hqqo5wqoapbvCU+zmfqlHBXxehI?=
 =?us-ascii?Q?eR6Gl9uHgA+7ZO18EIXIjQ3FO0FPSlMFrJahnaa8Hoet6iBX299+ttO6Lsnf?=
 =?us-ascii?Q?zfKHN4ooiYUgPdGx6AAJCS5OgcbIZZGGZlTO5GmMTpIWuDwsV1WF7/FPrMdG?=
 =?us-ascii?Q?lqingwCdPX3WsXCfxc61fKIqtqiMM+sUQlwtabppd7j8RfiyIAt4B/IZCbVJ?=
 =?us-ascii?Q?KLM0pIUiTzcbLjtXvkVtPVuoV+Myxq6rBjBhRyzVheTxvWPNFndDe1DVJ9sM?=
 =?us-ascii?Q?FskWynrCCQVlqXzN0mK1IpRRNeRQIxYLa5OrFg4kcijAArcpMcJr0DpZ74Ej?=
 =?us-ascii?Q?1omSTLRQX5P/wYb9iDSu4+iaxWmG2z4061JEfTGZuoZB51h7u2/7V1k2BxkV?=
 =?us-ascii?Q?TCwvG1lqZJFsf1AG8VP5nmS20ZeT0YRCT2w1/aBN/uOibbtcPxCfD9slMeYl?=
 =?us-ascii?Q?YGcjXKvECGEnV2PSYTyZp6Et8fdChDp93UAj0ZzOknmYJlvDqf0JermlPuWM?=
 =?us-ascii?Q?ApBt58gRrM7dPmM9WfbC8bsWRHKdGEMrE55NMoOQovTnEIny1QD1+v+FszHg?=
 =?us-ascii?Q?YhLETHqS/Wtq97dcwAeu6ZjrZ1OGH0q7ABVzQzFaynDWGzqQH9RiLdrp9z0A?=
 =?us-ascii?Q?M5XbTWnpjGvPW2ZX6mhp4Z+xNWMSdo8dLSNu4oNr1JuaU1OTT2aZ3nhE6OsR?=
 =?us-ascii?Q?HFw5iEb9I8xItm8jFZv8/V8vf667mVrr8xxOAuQkBYrqu7ppUsGfB51QnhNT?=
 =?us-ascii?Q?dQwqgix7NlvgWkV1tEF9wgCtBCZMmcMVg6lAj4Vc2AokGdHqp+dq6+u1CbHR?=
 =?us-ascii?Q?5ooTadb/kmsoscnKdm3Mp8BcfQ/L9AY5FSJyZr9YsVy4J8QD8lv/NKigRtRb?=
 =?us-ascii?Q?rc/mnk6zHQark1DJyU4CSPQq7dXlFzhMKM8NipZeRUyGtlgYi0CJzRuTIjrK?=
 =?us-ascii?Q?XKhnreJNQKG8CoF9zpqpZHgZ7MJ85zLnNJ6lMYt89k7ydsysnwSOft/Wh3q0?=
 =?us-ascii?Q?AgaZzMbUQVQyg1WNgpeX7SoYhGDT39HyBuGtGjccOK74JVozPazxlvrmH1qQ?=
 =?us-ascii?Q?bnynB7w9+dlraq69XZnd+3c3S5I07FGxHYs5g5ReeK5qmj40OhreVlV57GZM?=
 =?us-ascii?Q?vVAoRPh2tkWRXz1czx/E/Xk+G+x8uS1tsci5GVyPCQWDxHPX4B9Sfqrx7+IC?=
 =?us-ascii?Q?AtzAoi88qlLd2g9SndaxJ/gigY2edBhOtvRj5w/OAsqV2BG7hflMYUBRAICg?=
 =?us-ascii?Q?tzAuxkSV/62YZ0NEIKf2u+RHlL4s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HrNMfxJ3rHUqIeFDJ1jHY6EKYurNQ8H4gpY2ZB9aEaJP8/Nd3ltt9diQsvFe?=
 =?us-ascii?Q?ZJi9o7GqR+4cbgv2rZu7tFSAUs5eSyiqLBFpoZH27eWaCl2nwwbQS5OKZAyL?=
 =?us-ascii?Q?mFRTbQ44CzQRqVods6WGLyox47N6QIrmow7/4N4RA6SJS/65F8AtmhHSsM5G?=
 =?us-ascii?Q?VfWpshu2K6AyDEyBeFnaHKMZG2ftXbAsUBUgzdPTdRil1B4NkbAVSafsMMBY?=
 =?us-ascii?Q?h6bFyB3I9Uiv84vj5GeYI8UheMPqRoY2rhQ6sLJqYiHkPbpOw9Fr8HxuNxya?=
 =?us-ascii?Q?JKS+MCPghqLa+rrLSeHnvIn+K39rTS3kuFXDdfqstpr7SYsFRQiao5dygVEA?=
 =?us-ascii?Q?rsROk/4q3zbjCCui6y2Fa/3tijf8hvvr7R3ZGgWlDyKTQU1L0UjjDFhH1I1S?=
 =?us-ascii?Q?Z7ZsvLADZEp1VCNVvgQ3QWuLUrPISBJf6y61vd5Wbi2nXdhqoB2JJdFdebiA?=
 =?us-ascii?Q?1p8YfGJYAEq5U6DDmlhPDGmttqVt7OOfr1KCNDxkH55FPF111nRJSs14SWoh?=
 =?us-ascii?Q?+B5GX87emWjV2FJq0z0KEsik2GeFoEtHb77p0D6XorHi8Yiay7xNmYkqLCAJ?=
 =?us-ascii?Q?GMdZoMoyhH2DQguIDgOPBTT8D0MZ6KSQlfNFMxHTV8OK4hxVSRkT+ZSpjE3S?=
 =?us-ascii?Q?F/nQGoZEZZAywjHdMvOoq/4y+ysRcoyHmrfljXRWEFJDQlHBj1EfbjvS+nb3?=
 =?us-ascii?Q?tmKRwlXRwBZKZNF8qKOk2KyC+1ltuDRQLFGuEiITDroz8CaECDeIOD92Jx26?=
 =?us-ascii?Q?gd8uChgrBnFFpNDa0Sv2dFLWjUN3fbGqntM5VPSjL9it96MT6wd9kWArQqAX?=
 =?us-ascii?Q?2aO2jF9gksKP5sJ2lCnl3NgEISSruj7Y0Ne0KS0hEBOsUZgmRJ+U6ZQUNiX9?=
 =?us-ascii?Q?Held6ge2HKrxIhS60exd/g06GQWV+WdwqLsIFkaaFo0Da5JjFsoPMvgUxEzc?=
 =?us-ascii?Q?nSETVZH0xFKyLXgFGPPzLXpYZe4E+uJc/1IQxZTpuGZ6DG1/YP6b++4Zley1?=
 =?us-ascii?Q?AGbr65w95oVEheF1171zWeJGCClxilf+nCkFa1qrH5mt36zWWaljmj0vaddp?=
 =?us-ascii?Q?8QVLpZOWx9uv4VCIcu3KzAdXXSJVr8mJM0eTtZTaiT3pPLGWIcNtmigyH1Mc?=
 =?us-ascii?Q?v4OhN3YQF0/hLAvsbySbmj3aolNK8CJ4CHvuiU1erjnqJpQbRGVjg1a+JCYt?=
 =?us-ascii?Q?C7cT8xdlkMqrJCqTd0JkrL1aZHD6kOgQvGSqU2auFkSR4n3NDAcTulce4hmT?=
 =?us-ascii?Q?Gp62ODciNwRosYinz1/H1YsStRrYiRG8vdtjg8KF/7HyRhbORNZyXl132uPS?=
 =?us-ascii?Q?QkPIJOkXm/Vlzy6zUPvxxAWoZ0c/M/8GO/TOwrhWjBW9rVMxHbQWcw/IX9xe?=
 =?us-ascii?Q?D7+R7mur5d9YcVdBCkAK+sK27o5w91aud83mKLYBktVOM+kkHjeF73XX6/J9?=
 =?us-ascii?Q?bfYsr18ttTYoi3Jjs0WKoRDdDo6wyhmNr1nI+BkbaQIqQc1iytGdb5oJK8XQ?=
 =?us-ascii?Q?ezfGDqu20MF4fzv+H4GOIUe5lg6aDrG7AW6d298gC5xSZwMo2QVUUQ+71nF2?=
 =?us-ascii?Q?pShZp9tX1DqEt30UfzQCSh2EB9XnF+Ws44+bEqkv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38dbd55f-66c4-4fbd-a87a-08dcf25fe795
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 06:08:10.7412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjJAgmhWbsnskJMBWvf+WNeQFoUPgUXLIJqymv5I+MoFmsyBDlamoG60gXsnj5umRwnbjsw2iIWrMb76XuoCbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10178

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The ERR050089 workaround causes performance degradation and potential
functional issues (e.g., RCU stalls) under certain workloads. Since
new SoCs like i.MX95 do not require this workaround, use a static key
to compile out enetc_lock_mdio() and enetc_unlock_mdio() at runtime,
improving performance and avoiding unnecessary logic.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v2 changes: no changes
v3 changes: Change the title and refactor the commit message.
v4: no changes.
---
 .../net/ethernet/freescale/enetc/enetc_hw.h   | 34 +++++++++++++------
 .../ethernet/freescale/enetc/enetc_pci_mdio.c | 17 ++++++++++
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 1619943fb263..6a7b9b75d660 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -396,18 +396,22 @@ struct enetc_hw {
  */
 extern rwlock_t enetc_mdio_lock;
 
+DECLARE_STATIC_KEY_FALSE(enetc_has_err050089);
+
 /* use this locking primitive only on the fast datapath to
  * group together multiple non-MDIO register accesses to
  * minimize the overhead of the lock
  */
 static inline void enetc_lock_mdio(void)
 {
-	read_lock(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		read_lock(&enetc_mdio_lock);
 }
 
 static inline void enetc_unlock_mdio(void)
 {
-	read_unlock(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		read_unlock(&enetc_mdio_lock);
 }
 
 /* use these accessors only on the fast datapath under
@@ -416,14 +420,16 @@ static inline void enetc_unlock_mdio(void)
  */
 static inline u32 enetc_rd_reg_hot(void __iomem *reg)
 {
-	lockdep_assert_held(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		lockdep_assert_held(&enetc_mdio_lock);
 
 	return ioread32(reg);
 }
 
 static inline void enetc_wr_reg_hot(void __iomem *reg, u32 val)
 {
-	lockdep_assert_held(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		lockdep_assert_held(&enetc_mdio_lock);
 
 	iowrite32(val, reg);
 }
@@ -452,9 +458,13 @@ static inline u32 _enetc_rd_mdio_reg_wa(void __iomem *reg)
 	unsigned long flags;
 	u32 val;
 
-	write_lock_irqsave(&enetc_mdio_lock, flags);
-	val = ioread32(reg);
-	write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	if (static_branch_unlikely(&enetc_has_err050089)) {
+		write_lock_irqsave(&enetc_mdio_lock, flags);
+		val = ioread32(reg);
+		write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	} else {
+		val = ioread32(reg);
+	}
 
 	return val;
 }
@@ -463,9 +473,13 @@ static inline void _enetc_wr_mdio_reg_wa(void __iomem *reg, u32 val)
 {
 	unsigned long flags;
 
-	write_lock_irqsave(&enetc_mdio_lock, flags);
-	iowrite32(val, reg);
-	write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	if (static_branch_unlikely(&enetc_has_err050089)) {
+		write_lock_irqsave(&enetc_mdio_lock, flags);
+		iowrite32(val, reg);
+		write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	} else {
+		iowrite32(val, reg);
+	}
 }
 
 #ifdef ioread64
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
index a1b595bd7993..2445e35a764a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
@@ -9,6 +9,9 @@
 #define ENETC_MDIO_BUS_NAME	ENETC_MDIO_DEV_NAME " Bus"
 #define ENETC_MDIO_DRV_NAME	ENETC_MDIO_DEV_NAME " driver"
 
+DEFINE_STATIC_KEY_FALSE(enetc_has_err050089);
+EXPORT_SYMBOL_GPL(enetc_has_err050089);
+
 static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
@@ -62,6 +65,12 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 		goto err_pci_mem_reg;
 	}
 
+	if (pdev->vendor == PCI_VENDOR_ID_FREESCALE &&
+	    pdev->device == ENETC_MDIO_DEV_ID) {
+		static_branch_inc(&enetc_has_err050089);
+		dev_info(&pdev->dev, "Enabled ERR050089 workaround\n");
+	}
+
 	err = of_mdiobus_register(bus, dev->of_node);
 	if (err)
 		goto err_mdiobus_reg;
@@ -88,6 +97,14 @@ static void enetc_pci_mdio_remove(struct pci_dev *pdev)
 	struct enetc_mdio_priv *mdio_priv;
 
 	mdiobus_unregister(bus);
+
+	if (pdev->vendor == PCI_VENDOR_ID_FREESCALE &&
+	    pdev->device == ENETC_MDIO_DEV_ID) {
+		static_branch_dec(&enetc_has_err050089);
+		if (!static_key_enabled(&enetc_has_err050089.key))
+			dev_info(&pdev->dev, "Disabled ERR050089 workaround\n");
+	}
+
 	mdio_priv = bus->priv;
 	iounmap(mdio_priv->hw->port);
 	pci_release_region(pdev, 0);
-- 
2.34.1


