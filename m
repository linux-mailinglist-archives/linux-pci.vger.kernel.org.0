Return-Path: <linux-pci+bounces-14555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 301B199F281
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 18:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B1F1F22352
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A1D1F76B7;
	Tue, 15 Oct 2024 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NG8zezKw"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011046.outbound.protection.outlook.com [52.101.65.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62161CB9FC;
	Tue, 15 Oct 2024 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008801; cv=fail; b=u/ZLfSGxA7SK4rdN0164Y0oVVuYey2asVD708159/+DjKeXYs81CATs+a+KIjTBxOXKnMoPy40ujC3VR8w3MnxkufS6ItQj+JWPU5iXDizAbiFvV95UeLxrX+3yTuzrpoKZ/bnZR3OIqDy01yxTfL9y6h3MyVE/Qpmp/e5WDvBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008801; c=relaxed/simple;
	bh=CwJ/Zom0EpjaJEgz+uQlQ7ypWea4rpPLPrGtvxUv+/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uAOND7e0OPnPUjLmgMrDTR7MO93lbG9YDgQpEEz9VyEDS1qn7sz8VecRnhoQOTARD9IOWZDddoGqL/r/75OUBmKtktAGFSe+KcW91befSBDRG8xjypM86bPFULPJhth9NCOFmtqwY38Hex+IU5aiYniOqXAthasfHuUC02R8lmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NG8zezKw; arc=fail smtp.client-ip=52.101.65.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQSHLYBBZvC7VBQb3ZY8AG6gUwojKNsNAyTD6OworaeU4eFDzWnzQzEIXAikVphI/lm4niz5EIQsQYp8RbZmfY92QeKk2/3vK2PxEAxijqClDgN5gXxQOe/kOcksqhtjU/TfK+HOhcEmEN4Zsaz+gvgY09MbVOfWl4PWNXtSdQqQRWxXOTxTjd51RHk6FSB+tVPlm/L3cx+L7/14PRVBPyfYA3CDakcOssvr3G8Wyldud3dpbspz9hIU6K0h4I+ASHrAlHTmt5rJlXpi6BaWVhLgGEQYXyabcUh1ohV2SWPBqH9yqaW5sVodrzY/PyH6NF+cjSMaZnPZQLt9VwxeBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKexbF+hstvqX34mLthyDZdD8R3ME74H4FJH+w7Yg4E=;
 b=mHoTaHwfkzLUGadMrew5phzTdcASjWf1ho0ZtvLz2ftCUPYYeN0poiNior09SvVAH4bXpNUPMZ9gVRVxp259tdMSOFpNbp6IgjC63Uz5dqL6OtwdaVT/8BFGV5/oZZJiOW06jeYlu+vsvjrsLteDZhjuXNfzCDFguWfhuW/6xui922FLBaR48vsxY3r4UlRcnoA9LbtqYlYcCmCZC5XtmGtBMJluv6lnijyTASJx4B0ZJcb5lHuwNn34gqk1Dy6Tm6nle1xnSbNpFUJPM18xZbC6EWpn/5vT5HmsjuxyXYXFvnqG0rmgJXKOsRkTgFYj+u8avm3NY5CaNqhVVfcDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKexbF+hstvqX34mLthyDZdD8R3ME74H4FJH+w7Yg4E=;
 b=NG8zezKw+xtWaBgj7c7lFZi7IGLVJs1po284Hvxn+w+W1uvrafB8WA6waaBq7NWOKrIj9jyBiyKlCkeXmYy0dXE6aNDikizTng1xbPCtWgJ/ZIEi4wUmU6W9bhulcTFNXqOcL1lisjR+NkSAwrK+D9V7/7WKFhlxU5vQtbc2YNwmKMARenkY5zeY5KlOEOTzi8i688LYE69Pu0bRoIhuwfNaWDZb+roJOsxVJSVOB6k1vQCrgzujnLl7UIpz52RAxZsJVj+BLdPmmHeX4AgzOaFNgp9sq/gYXQEc3cuRSX1zd117u30wQRdxaGak5bXoAJ1lY1/OZsaYDJjgfE328A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10470.eurprd04.prod.outlook.com (2603:10a6:102:419::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 16:13:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 16:13:15 +0000
Date: Tue, 15 Oct 2024 12:13:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, horms@kernel.org, imx@lists.linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 net-next 04/13] net: enetc: add initial netc-blk-ctrl
 driver support
Message-ID: <Zw6Ulc5du7reMiNE@lizhi-Precision-Tower-5810>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-5-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015125841.1075560-5-wei.fang@nxp.com>
X-ClientProxiedBy: SN7PR04CA0118.namprd04.prod.outlook.com
 (2603:10b6:806:122::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10470:EE_
X-MS-Office365-Filtering-Correlation-Id: de67116e-2a67-420f-2039-08dced34464f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2y6E8SWXFToAbX96LSCFm7gIU2YdNFRxlTGvckInolGTHYi18U9m71OJFZ+V?=
 =?us-ascii?Q?j17WtnUxbWjCyOO63LOXNkhXfbu9+XROsAuRX3tO8W/FRMIvRVuV6+i6keUs?=
 =?us-ascii?Q?z+zXIC6vImFjQvyaGEdKtQjLgJIt4/zOr8EdBKxGjUm9PLP94NpvgiK0F+Jq?=
 =?us-ascii?Q?SMEpkRE1JsjfT8VxkGzqsP92RwD5jKQlfZCRb9/YjMImxSmMUqh7uQPouOXP?=
 =?us-ascii?Q?NdeICZ32eeIVyZxPyrOWR42PBDRvpBGV4JCqqs8XObXPvVZ7RUwITU0Vy+Gd?=
 =?us-ascii?Q?T1l+R+M7h3rlS45/H0pdlqXvqfaV9f+mcXSgSVNG2+C9OJ9kjUqqfT4XdnM+?=
 =?us-ascii?Q?CuJ35B+IF+GBdgY8mPoH5Vk7IS8Q2Jf3dy/NHTpbN5kr26bHlM2D7rBgtoAP?=
 =?us-ascii?Q?vK9neFIE9E9woo+0zfU0Tbq6rsv+eOk52i9TjXwfvkOBeqTfc2FBwbyZw0Z/?=
 =?us-ascii?Q?gTV4lx7etZdxOMQCiQxvjUQAgdOzilCFaBkPdm87yKioNrVgFqECtI8sAElA?=
 =?us-ascii?Q?HttnlV9ENANxqff8KbedmO1bVr9cyTsP1VtGlag5CTPbeQUa8bxlfcZUQ9C4?=
 =?us-ascii?Q?51qeHJl0RmLnCDmZhuV9wmKcWI48Wftaaj/dQmMbzlncdHhhh29c53cRuf0e?=
 =?us-ascii?Q?lI7yFZ+J6mNAatQJERUSmK6pbpzUwLESD5nFDy1GV7La8NYAJ3+hWAZtex2v?=
 =?us-ascii?Q?TxrjSQnjf4xLwZGPkXOh6lCWe8nPdJ9Bq8oHS+/sznST2TqV9DdLBmZiZJc5?=
 =?us-ascii?Q?8Lt6g80UQzRDiiUFCoCywrrf9FV07UFgCU9/Li20fjoiJSqQVU8aUs9PSQcK?=
 =?us-ascii?Q?gfz1pW63mVrYnVM5DLZ7BTl0eaVvEqBJdVQKsUctMGI7jF1IFm5QVkNjtB1z?=
 =?us-ascii?Q?nwpsiLlvg1KgCIwJ0e6izIG2LRmCECkFkVhE3aFHKp8ig/U+7GmyBfSviUYV?=
 =?us-ascii?Q?Sc1VGLWIsA1w20Y9mgA893owMLXFV4cIzWJKtNvz5mA7ShlBvwQqKeELoWYw?=
 =?us-ascii?Q?4cxFRhsU1e4BwZVajoQCvnrh/H6F7tPIBp4XCIeVwF5rXvS2nhRdHPHBvVu3?=
 =?us-ascii?Q?xPJnbCEqK4AwhtvnqMn0X+z9YhgXTDdrBQus8E7tAtUCyPCITEWOsz+4hib+?=
 =?us-ascii?Q?2tDtxQBVsOK7cLO5ItDnEvpt6/+Y+rhgyBEHw8b5TANX0ocJbBqOAf45q8FZ?=
 =?us-ascii?Q?dhZUEiNYfjlQNOxMDADnj7wq35anoA+WGsZToFcmochnQAeD2vAAbuDE4XTB?=
 =?us-ascii?Q?YRE1HnooDjXYVEga2hKLrmineql94Y+eSKlrGfxoVqlmdM5T5IcV4hXXwLvC?=
 =?us-ascii?Q?eJHZWTp59v8nL3/ugbk5dfsgzcYaIBsegl/x7cQgQWwiuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dZEUS0O36DsFssLn3JB6WEFliOBL5YOwkPzcdiYgN33dPG2gRI473Cvd28j8?=
 =?us-ascii?Q?QDbnX1HYEAwupuEJzo30rMKUiN6YJa4T9eXIyknE9xT8+aRCWSE/O2Lo/pzV?=
 =?us-ascii?Q?T6wsJrPkgU1U1IvAt6mIgVpshKVl2kqcZG4xHJ10zSuIdqYMGahddcYoNxDt?=
 =?us-ascii?Q?6S1+E2nWnSVu9AMKpPAe77UjDNZnIOubqdXtzLjrbCIKpdwtjH8K/MWPqZ90?=
 =?us-ascii?Q?8+ecb1+q/dWdMswD5epn6anKd4L28xEhbEZy6lSC0Ube85yw0r2Qj67zrTL0?=
 =?us-ascii?Q?VOFnVMBJ4kVRs95OEZyvw7sPRL0H7D0z8TJuG3cOHCTYmlLtxBxgUFM2cbx4?=
 =?us-ascii?Q?B3BNTWoGHGhYDmvMT190kUIZpRueVZg2WltWNCGUd1AtchDkdLNGm9jKQ1oZ?=
 =?us-ascii?Q?w7kSQ+grLZLrizG2oRnLe4VuVYvoZFBB705u7aYJ6OYU1krDsmkpRLJLVI08?=
 =?us-ascii?Q?FwJJom+RU8Ch6ySveO/nauxyJhGRXj3CjTiruExbh70A1cTyMGyN4dzO8V2m?=
 =?us-ascii?Q?RDfttAl5pqiTwoL/2nKJ1M6DQF3kng0Vb+Dkrpolk7d5yqQpaFqXth9Lgaog?=
 =?us-ascii?Q?qxLIi4uvQm3+1OswyWfICfv041/1wFUtnpvMlNyrytMc+j/UNfDf1bGJoxxG?=
 =?us-ascii?Q?JtRaJEbR1J378NwHqcfk0V4aBOIjX4q6yBlasElDB3BLA+24XNCMQwI8Lni6?=
 =?us-ascii?Q?TbJTZPn6O5mAoVGi3pQIQ4pPURb/p55c9ILYDA6alPR1W3Fi6k058Lgyo6Ef?=
 =?us-ascii?Q?bAcA9Lxpc45M9KjRO2Y4mvZMDKI3lLoI3N/Wj+uOBmeNcj0dVu7+LYLgDSZL?=
 =?us-ascii?Q?mqmPj6QLgYjZ0x7CeLl5E0CQY0SKEyoxCdJVmCBDBFqpv0ZEcUuE/bkGHgUG?=
 =?us-ascii?Q?FANrhLWqgeYhLpJvnzOv5G0kc4l0VUh0UQKsdkI1d88rZD7paE9MH5eswhHR?=
 =?us-ascii?Q?HGgz2c0ih/wYttDcv2tuzItdHSZvP+RGxfOQHtKLQ9QZ+kf+D2o3ajsQsQth?=
 =?us-ascii?Q?D4ShtmsMy8JYzS7jTBz+KkL76GU3a2pGywGR40Bqv69cmr0zDCbDyRpXVhw5?=
 =?us-ascii?Q?mepHpCB+3iPweZuOEGyCZamoV1Ai2wL/kHi7kbfj3gkMq5kO3vJlVdFHHEOm?=
 =?us-ascii?Q?O63jSspavH4mFSZ/7XEN710UaZ9tpQPjegW4ycdVqRqAJoUcyfrxuTS6c4+z?=
 =?us-ascii?Q?krONPIYtBDnoA1VbCR/LZehwqBB7dbTK6Rc2CbXnvyx8IyFg4YTHrTznxViP?=
 =?us-ascii?Q?3EJUss8Ql7s1sDDEyNf/C2H1ekBOBlEnM2BA2qjenvCc9/cTPwO90Q//iEs9?=
 =?us-ascii?Q?zfDr0Sa9n5NEsM81VR9vIs9pnvD8T1BTZ2xPAX/NIWzJVP/VKc+N652TdeiH?=
 =?us-ascii?Q?gPe+6wccV2CxD4wFeozUZKy5kqAQ4JerCaMd+Qmi73EHq/CgYmfwd8yraUpF?=
 =?us-ascii?Q?htawr42JEspdpBHGFlgrXJcRKSmXSAFrOt6wI5P1B7CCsOy4SlmNx/bW706v?=
 =?us-ascii?Q?k/EurFmeNF3bfiQMxghu/TYnM187PV4CY+BV3Evl3EGJ5W3BmR6CK2SdZT3F?=
 =?us-ascii?Q?ttc4AT38LtxqT8W0fla0kxSxmD+0K7bUoZYWsuxE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de67116e-2a67-420f-2039-08dced34464f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 16:13:15.4530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDyJ/MYd+NnKA6XdiuO59bSGpzPN/z2svXdQITGSPnwIV30d73r7WVkp0ddKAW1WJ8yZb16NISRJTiu/y9F6Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10470

On Tue, Oct 15, 2024 at 08:58:32PM +0800, Wei Fang wrote:
> The netc-blk-ctrl driver is used to configure Integrated Endpoint
> Register Block (IERB) and Privileged Register Block (PRB) of NETC.
> For i.MX platforms, it is also used to configure the NETCMIX block.
>
> The IERB contains registers that are used for pre-boot initialization,
> debug, and non-customer configuration. The PRB controls global reset
> and global error handling for NETC. The NETCMIX block is mainly used
> to set MII protocol and PCS protocol of the links, it also contains
> settings for some other functions.
>
> Note the IERB configuration registers can only be written after being
> unlocked by PRB, otherwise, all write operations are inhibited. A warm
> reset is performed when the IERB is unlocked, and it results in an FLR
> to all NETC devices. Therefore, all NETC device drivers must be probed
> or initialized after the warm reset is finished.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2 changes:
> 1. Add linux/bits.h
> 2. Remove the useless check at the beginning of netc_blk_ctrl_probe().
> 3. Use dev_err_probe() in netc_blk_ctrl_probe().
> ---
>  drivers/net/ethernet/freescale/enetc/Kconfig  |  14 +
>  drivers/net/ethernet/freescale/enetc/Makefile |   3 +
>  .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 472 ++++++++++++++++++
>  include/linux/fsl/netc_global.h               |  39 ++
>  4 files changed, 528 insertions(+)
>  create mode 100644 drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
>  create mode 100644 include/linux/fsl/netc_global.h
>
> diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
> index 4d75e6807e92..51d80ea959d4 100644
> --- a/drivers/net/ethernet/freescale/enetc/Kconfig
> +++ b/drivers/net/ethernet/freescale/enetc/Kconfig
> @@ -75,3 +75,17 @@ config FSL_ENETC_QOS
>  	  enable/disable from user space via Qos commands(tc). In the kernel
>  	  side, it can be loaded by Qos driver. Currently, it is only support
>  	  taprio(802.1Qbv) and Credit Based Shaper(802.1Qbu).
> +
> +config NXP_NETC_BLK_CTRL
> +	tristate "NETC blocks control driver"
> +	help
> +	  This driver configures Integrated Endpoint Register Block (IERB) and
> +	  Privileged Register Block (PRB) of NETC. For i.MX platforms, it also
> +	  includes the configuration of NETCMIX block.
> +	  The IERB contains registers that are used for pre-boot initialization,
> +	  debug, and non-customer configuration. The PRB controls global reset
> +	  and global error handling for NETC. The NETCMIX block is mainly used
> +	  to set MII protocol and PCS protocol of the links, it also contains
> +	  settings for some other functions.
> +
> +	  If compiled as module (M), the module name is nxp-netc-blk-ctrl.
> diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
> index b13cbbabb2ea..5c277910d538 100644
> --- a/drivers/net/ethernet/freescale/enetc/Makefile
> +++ b/drivers/net/ethernet/freescale/enetc/Makefile
> @@ -19,3 +19,6 @@ fsl-enetc-mdio-y := enetc_pci_mdio.o enetc_mdio.o
>
>  obj-$(CONFIG_FSL_ENETC_PTP_CLOCK) += fsl-enetc-ptp.o
>  fsl-enetc-ptp-y := enetc_ptp.o
> +
> +obj-$(CONFIG_NXP_NETC_BLK_CTRL) += nxp-netc-blk-ctrl.o
> +nxp-netc-blk-ctrl-y := netc_blk_ctrl.o
> \ No newline at end of file
> diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> new file mode 100644
> index 000000000000..62c912aeeb5d
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> @@ -0,0 +1,472 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * NXP NETC Blocks Control Driver
> + *
> + * Copyright 2024 NXP
> + */
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/fsl/netc_global.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_net.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/seq_file.h>
> +
> +/* NETCMIX registers */
> +#define IMX95_CFG_LINK_IO_VAR		0x0
> +#define  IO_VAR_16FF_16G_SERDES		0x1
> +#define  IO_VAR(port, var)		(((var) & 0xf) << ((port) << 2))
> +
> +#define IMX95_CFG_LINK_MII_PROT		0x4
> +#define CFG_LINK_MII_PORT_0		GENMASK(3, 0)
> +#define CFG_LINK_MII_PORT_1		GENMASK(7, 4)
> +#define  MII_PROT_MII			0x0
> +#define  MII_PROT_RMII			0x1
> +#define  MII_PROT_RGMII			0x2
> +#define  MII_PROT_SERIAL		0x3
> +#define  MII_PROT(port, prot)		(((prot) & 0xf) << ((port) << 2))
> +
> +#define IMX95_CFG_LINK_PCS_PROT(a)	(0x8 + (a) * 4)
> +#define PCS_PROT_1G_SGMII		BIT(0)
> +#define PCS_PROT_2500M_SGMII		BIT(1)
> +#define PCS_PROT_XFI			BIT(3)
> +#define PCS_PROT_SFI			BIT(4)
> +#define PCS_PROT_10G_SXGMII		BIT(6)
> +
> +/* NETC privileged register block register */
> +#define PRB_NETCRR			0x100
> +#define  NETCRR_SR			BIT(0)
> +#define  NETCRR_LOCK			BIT(1)
> +
> +#define PRB_NETCSR			0x104
> +#define  NETCSR_ERROR			BIT(0)
> +#define  NETCSR_STATE			BIT(1)
> +
> +/* NETC integrated endpoint register block register */
> +#define IERB_EMDIOFAUXR			0x344
> +#define IERB_T0FAUXR			0x444
> +#define IERB_EFAUXR(a)			(0x3044 + 0x100 * (a))
> +#define IERB_VFAUXR(a)			(0x4004 + 0x40 * (a))
> +#define FAUXR_LDID			GENMASK(3, 0)
> +
> +/* Platform information */
> +#define IMX95_ENETC0_BUS_DEVFN		0x0
> +#define IMX95_ENETC1_BUS_DEVFN		0x40
> +#define IMX95_ENETC2_BUS_DEVFN		0x80
> +
> +/* Flags for different platforms */
> +#define NETC_HAS_NETCMIX		BIT(0)
> +
> +struct netc_devinfo {
> +	u32 flags;
> +	int (*netcmix_init)(struct platform_device *pdev);
> +	int (*ierb_init)(struct platform_device *pdev);
> +};
> +
> +struct netc_blk_ctrl {
> +	void __iomem *prb;
> +	void __iomem *ierb;
> +	void __iomem *netcmix;
> +	struct clk *ipg_clk;
> +
> +	const struct netc_devinfo *devinfo;
> +	struct platform_device *pdev;
> +	struct dentry *debugfs_root;
> +};
> +
> +static void netc_reg_write(void __iomem *base, u32 offset, u32 val)
> +{
> +	netc_write(base + offset, val);
> +}
> +
> +static u32 netc_reg_read(void __iomem *base, u32 offset)
> +{
> +	return netc_read(base + offset);
> +}
> +
> +static int netc_of_pci_get_bus_devfn(struct device_node *np)
> +{
> +	u32 reg[5];
> +	int error;
> +
> +	error = of_property_read_u32_array(np, "reg", reg, ARRAY_SIZE(reg));
> +	if (error)
> +		return error;
> +
> +	return (reg[0] >> 8) & 0xffff;
> +}
> +
> +static int netc_get_link_mii_protocol(phy_interface_t interface)
> +{
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_MII:
> +		return MII_PROT_MII;
> +	case PHY_INTERFACE_MODE_RMII:
> +		return MII_PROT_RMII;
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		return MII_PROT_RGMII;
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +	case PHY_INTERFACE_MODE_10GBASER:
> +	case PHY_INTERFACE_MODE_XGMII:
> +	case PHY_INTERFACE_MODE_USXGMII:
> +		return MII_PROT_SERIAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int imx95_netcmix_init(struct platform_device *pdev)
> +{
> +	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
> +	struct device_node *np = pdev->dev.of_node;
> +	phy_interface_t interface;
> +	int bus_devfn, mii_proto;
> +	u32 val;
> +	int err;
> +
> +	/* Default setting of MII protocol */
> +	val = MII_PROT(0, MII_PROT_RGMII) | MII_PROT(1, MII_PROT_RGMII) |
> +	      MII_PROT(2, MII_PROT_SERIAL);
> +
> +	/* Update the link MII protocol through parsing phy-mode */
> +	for_each_available_child_of_node_scoped(np, child) {
> +		for_each_available_child_of_node_scoped(child, gchild) {
> +			if (!of_device_is_compatible(gchild, "nxp,imx95-enetc"))
> +				continue;
> +
> +			bus_devfn = netc_of_pci_get_bus_devfn(gchild);
> +			if (bus_devfn < 0)
> +				return -EINVAL;
> +
> +			if (bus_devfn == IMX95_ENETC2_BUS_DEVFN)
> +				continue;
> +
> +			err = of_get_phy_mode(gchild, &interface);
> +			if (err)
> +				continue;
> +
> +			mii_proto = netc_get_link_mii_protocol(interface);
> +			if (mii_proto < 0)
> +				return -EINVAL;
> +
> +			switch (bus_devfn) {
> +			case IMX95_ENETC0_BUS_DEVFN:
> +				val = u32_replace_bits(val, mii_proto,
> +						       CFG_LINK_MII_PORT_0);
> +				break;
> +			case IMX95_ENETC1_BUS_DEVFN:
> +				val = u32_replace_bits(val, mii_proto,
> +						       CFG_LINK_MII_PORT_1);
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
> +	/* Configure Link I/O variant */
> +	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_IO_VAR,
> +		       IO_VAR(2, IO_VAR_16FF_16G_SERDES));
> +	/* Configure Link 2 PCS protocol */
> +	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_PCS_PROT(2),
> +		       PCS_PROT_10G_SXGMII);
> +	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_MII_PROT, val);
> +
> +	return 0;
> +}
> +
> +static bool netc_ierb_is_locked(struct netc_blk_ctrl *priv)
> +{
> +	return !!(netc_reg_read(priv->prb, PRB_NETCRR) & NETCRR_LOCK);
> +}
> +
> +static int netc_lock_ierb(struct netc_blk_ctrl *priv)
> +{
> +	u32 val;
> +
> +	netc_reg_write(priv->prb, PRB_NETCRR, NETCRR_LOCK);
> +
> +	return read_poll_timeout(netc_reg_read, val, !(val & NETCSR_STATE),
> +				 100, 2000, false, priv->prb, PRB_NETCSR);
> +}
> +
> +static int netc_unlock_ierb_with_warm_reset(struct netc_blk_ctrl *priv)
> +{
> +	u32 val;
> +
> +	netc_reg_write(priv->prb, PRB_NETCRR, 0);
> +
> +	return read_poll_timeout(netc_reg_read, val, !(val & NETCRR_LOCK),
> +				 1000, 100000, true, priv->prb, PRB_NETCRR);
> +}
> +
> +static int imx95_ierb_init(struct platform_device *pdev)
> +{
> +	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
> +
> +	/* EMDIO : No MSI-X intterupt */
> +	netc_reg_write(priv->ierb, IERB_EMDIOFAUXR, 0);
> +	/* ENETC0 PF */
> +	netc_reg_write(priv->ierb, IERB_EFAUXR(0), 0);
> +	/* ENETC0 VF0 */
> +	netc_reg_write(priv->ierb, IERB_VFAUXR(0), 1);
> +	/* ENETC0 VF1 */
> +	netc_reg_write(priv->ierb, IERB_VFAUXR(1), 2);
> +	/* ENETC1 PF */
> +	netc_reg_write(priv->ierb, IERB_EFAUXR(1), 3);
> +	/* ENETC1 VF0 */
> +	netc_reg_write(priv->ierb, IERB_VFAUXR(2), 5);
> +	/* ENETC1 VF1 */
> +	netc_reg_write(priv->ierb, IERB_VFAUXR(3), 6);
> +	/* ENETC2 PF */
> +	netc_reg_write(priv->ierb, IERB_EFAUXR(2), 4);
> +	/* ENETC2 VF0 */
> +	netc_reg_write(priv->ierb, IERB_VFAUXR(4), 5);
> +	/* ENETC2 VF1 */
> +	netc_reg_write(priv->ierb, IERB_VFAUXR(5), 6);
> +	/* NETC TIMER */
> +	netc_reg_write(priv->ierb, IERB_T0FAUXR, 7);
> +
> +	return 0;
> +}
> +
> +static int netc_ierb_init(struct platform_device *pdev)
> +{
> +	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
> +	const struct netc_devinfo *devinfo = priv->devinfo;
> +	int err;
> +
> +	if (netc_ierb_is_locked(priv)) {
> +		err = netc_unlock_ierb_with_warm_reset(priv);
> +		if (err) {
> +			dev_err(&pdev->dev, "Unlock IERB failed.\n");
> +			return err;
> +		}
> +	}
> +
> +	if (devinfo->ierb_init) {
> +		err = devinfo->ierb_init(pdev);
> +		if (err)
> +			return err;
> +	}
> +
> +	err = netc_lock_ierb(priv);
> +	if (err) {
> +		dev_err(&pdev->dev, "Lock IERB failed.\n");
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> +static int netc_prb_show(struct seq_file *s, void *data)
> +{
> +	struct netc_blk_ctrl *priv = s->private;
> +	u32 val;
> +
> +	val = netc_reg_read(priv->prb, PRB_NETCRR);
> +	seq_printf(s, "[PRB NETCRR] Lock:%d SR:%d\n",
> +		   (val & NETCRR_LOCK) ? 1 : 0,
> +		   (val & NETCRR_SR) ? 1 : 0);
> +
> +	val = netc_reg_read(priv->prb, PRB_NETCSR);
> +	seq_printf(s, "[PRB NETCSR] State:%d Error:%d\n",
> +		   (val & NETCSR_STATE) ? 1 : 0,
> +		   (val & NETCSR_ERROR) ? 1 : 0);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(netc_prb);
> +
> +static void netc_blk_ctrl_create_debugfs(struct netc_blk_ctrl *priv)
> +{
> +	struct dentry *root;
> +
> +	root = debugfs_create_dir("netc_blk_ctrl", NULL);
> +	if (IS_ERR(root))
> +		return;
> +
> +	priv->debugfs_root = root;
> +
> +	debugfs_create_file("prb", 0444, root, priv, &netc_prb_fops);
> +}
> +
> +static void netc_blk_ctrl_remove_debugfs(struct netc_blk_ctrl *priv)
> +{
> +	debugfs_remove_recursive(priv->debugfs_root);
> +	priv->debugfs_root = NULL;
> +}
> +
> +#else
> +
> +static void netc_blk_ctrl_create_debugfs(struct netc_blk_ctrl *priv)
> +{
> +}
> +
> +static void netc_blk_ctrl_remove_debugfs(struct netc_blk_ctrl *priv)
> +{
> +}
> +#endif
> +
> +static int netc_prb_check_error(struct netc_blk_ctrl *priv)
> +{
> +	u32 val;
> +
> +	val = netc_reg_read(priv->prb, PRB_NETCSR);
> +	if (val & NETCSR_ERROR)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static const struct netc_devinfo imx95_devinfo = {
> +	.flags = NETC_HAS_NETCMIX,

did you meet platform without NETC_HAS_NETCMIX? Add it only when it is
really used.

> +	.netcmix_init = imx95_netcmix_init,
> +	.ierb_init = imx95_ierb_init,
> +};
> +
> +static const struct of_device_id netc_blk_ctrl_match[] = {
> +	{ .compatible = "nxp,imx95-netc-blk-ctrl", .data = &imx95_devinfo },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, netc_blk_ctrl_match);
> +
> +static int netc_blk_ctrl_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	const struct netc_devinfo *devinfo;
> +	struct device *dev = &pdev->dev;
> +	const struct of_device_id *id;
> +	struct netc_blk_ctrl *priv;
> +	void __iomem *regs;
> +	int err;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->pdev = pdev;
> +	priv->ipg_clk = devm_clk_get_optional(dev, "ipg_clk");
> +	if (IS_ERR(priv->ipg_clk)) {
> +		err = PTR_ERR(priv->ipg_clk);
> +		dev_err_probe(dev, err, "Get ipg_clk failed\n");
> +		return err;
> +	}

simple
	return dev_err_probe(dev, PTR_ERR(priv->ipg_clk), "Get ipg_clk failed\n");

> +
> +	err = clk_prepare_enable(priv->ipg_clk);
> +	if (err) {
> +		dev_err_probe(dev, err, "Enable ipg_clk failed\n");
> +		goto disable_ipg_clk;
> +	}


You can use devm_clk_get_optional_enabled(dev, "ipg_clk") instead of
devm_clk_get_optional(), above tunk can be removed.

> +
> +	id = of_match_device(netc_blk_ctrl_match, dev);
> +	if (!id) {
> +		err = -EINVAL;
> +		dev_err_probe(dev, err, "Cannot match device\n");
> +		goto disable_ipg_clk;
> +	}
> +
> +	devinfo = (struct netc_devinfo *)id->data;
> +	if (!devinfo) {
> +		err = -EINVAL;
> +		dev_err_probe(dev, err, "No device information\n");
> +		goto disable_ipg_clk;
> +	}

because use devm_clk_get_optional_enabled()
simple

 return dev_err_probe(dev, -ENVAL, "No device information\n");

same for below error check code.

> +	priv->devinfo = devinfo;
> +
> +	regs = devm_platform_ioremap_resource_byname(pdev, "ierb");
> +	if (IS_ERR(regs)) {
> +		err = PTR_ERR(regs);
> +		dev_err_probe(dev, err, "Missing IERB resource\n");
> +		goto disable_ipg_clk;
> +	}
> +	priv->ierb = regs;
> +
> +	regs = devm_platform_ioremap_resource_byname(pdev, "prb");
> +	if (IS_ERR(regs)) {
> +		err = PTR_ERR(regs);
> +		dev_err_probe(dev, err, "Missing PRB resource\n");
> +		goto disable_ipg_clk;
> +	}
> +	priv->prb = regs;
> +
> +	if (devinfo->flags & NETC_HAS_NETCMIX) {
> +		regs = devm_platform_ioremap_resource_byname(pdev, "netcmix");
> +		if (IS_ERR(regs)) {
> +			err = PTR_ERR(regs);
> +			dev_err_probe(dev, err, "Missing NETCMIX resource\n");
> +			goto disable_ipg_clk;
> +		}
> +		priv->netcmix = regs;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	if (devinfo->netcmix_init) {
> +		err = devinfo->netcmix_init(pdev);
> +		if (err) {
> +			dev_err_probe(dev, err, "Initializing NETCMIX failed\n");
> +			goto disable_ipg_clk;
> +		}
> +	}
> +
> +	err = netc_ierb_init(pdev);
> +	if (err) {
> +		dev_err_probe(dev, err, "Initializing IERB failed\n");
> +		goto disable_ipg_clk;
> +	}
> +
> +	if (netc_prb_check_error(priv) < 0)
> +		dev_warn(dev, "The current IERB configuration is invalid\n");
> +
> +	netc_blk_ctrl_create_debugfs(priv);
> +
> +	err = of_platform_populate(node, NULL, NULL, dev);
> +	if (err) {
> +		dev_err_probe(dev, err, "of_platform_populate failed\n");
> +		goto remove_debugfs;
> +	}
> +
> +	return 0;
> +
> +remove_debugfs:
> +	netc_blk_ctrl_remove_debugfs(priv);
> +disable_ipg_clk:
> +	clk_disable_unprepare(priv->ipg_clk);
> +
> +	return err;
> +}
> +
> +static void netc_blk_ctrl_remove(struct platform_device *pdev)
> +{
> +	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
> +
> +	of_platform_depopulate(&pdev->dev);
> +	netc_blk_ctrl_remove_debugfs(priv);
> +	clk_disable_unprepare(priv->ipg_clk);
> +}
> +
> +static struct platform_driver netc_blk_ctrl_driver = {
> +	.driver = {
> +		.name = "nxp-netc-blk-ctrl",
> +		.of_match_table = netc_blk_ctrl_match,
> +	},
> +	.probe = netc_blk_ctrl_probe,
> +	.remove = netc_blk_ctrl_remove,
> +};
> +
> +module_platform_driver(netc_blk_ctrl_driver);
> +
> +MODULE_DESCRIPTION("NXP NETC Blocks Control Driver");
> +MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
> new file mode 100644
> index 000000000000..f26b1b6f8813
> --- /dev/null
> +++ b/include/linux/fsl/netc_global.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> +/* Copyright 2024 NXP
> + */
> +#ifndef __NETC_GLOBAL_H
> +#define __NETC_GLOBAL_H
> +
> +#include <linux/io.h>
> +
> +static inline u32 netc_read(void __iomem *reg)
> +{
> +	return ioread32(reg);
> +}
> +
> +#ifdef ioread64
> +static inline u64 netc_read64(void __iomem *reg)
> +{
> +	return ioread64(reg);
> +}
> +#else
> +static inline u64 netc_read64(void __iomem *reg)
> +{
> +	u32 low, high;
> +	u64 val;
> +
> +	low = ioread32(reg);
> +	high = ioread32(reg + 4);
> +
> +	val = (u64)high << 32 | low;
> +
> +	return val;
> +}
> +#endif

netc_read64 is not used at this patch. Add it when use it.

> +
> +static inline void netc_write(void __iomem *reg, u32 val)
> +{
> +	iowrite32(val, reg);
> +}
> +
> +#endif
> --
> 2.34.1
>

