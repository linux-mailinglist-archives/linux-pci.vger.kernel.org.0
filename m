Return-Path: <linux-pci+bounces-17123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33159D4141
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 18:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A371A282DD0
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 17:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D176B482EF;
	Wed, 20 Nov 2024 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IBJUzw2P"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78519156654
	for <linux-pci@vger.kernel.org>; Wed, 20 Nov 2024 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732124250; cv=fail; b=JYK8+hskc2odGmFWgbVQLwdUJiq5yQbyqrT/FW7RwJ+GNX1x48J94oj4BObh8YMK+KyOVl1UwHh3Dp03SQ6s8vNsB4jXHcgsBpbEde73DJjKaGYk9R0mutATg1x4GpRYclyMvqvnyTOkp024k9VB921iNTD0ZcFNm3o3Q4Vsi6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732124250; c=relaxed/simple;
	bh=XKwgfCT9Oblv98U8hQucT8OP62E4MYDk/+D/z5EEqgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c1gg7VhISu6Y7G2mN9Sik0+OTamz7YJe4mzV6JAhD+DcMtgPOhqlyexDRZiftpGGlazOuz+Pj3lGatibbrqXsXIhfiZ7sTQxJNlbgqWPRE+TLbV8ghwRZUoLX7jYz+frqkDHUzrDpdsLrGyhQEoWg5BCoh+E9qAu8QN5VPFrA6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IBJUzw2P; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a84E0z3pSCJe1syj7XHEZ8wkIb4NZCds99cAkQckZ/8+wLhHN4EyE/qaLtBPCQxFymGksg1nOfGfAyTWMEMAtEnMfrtKFuoQw/K3ddYyR2o5QJ5LscBwvWvTi7BqVejZv+IJCgy93yFK4cV8HY2qBMfOPVxNfqPE2JzdcbMD+kW28FER+KeJ7TKHfjf93d3gv8ugzt/Hoz0/FjJsGc64YzC+jWplgZzmfB+3SEhPpJ1ZXkeaNn4NqvP/pb0i+3N3KOHwb/84oK/GLNkBxd1crGbovEks2J7ZkePef55B4+M08ONHFns2OywSxS/jMgBL0hejTvEKxpxkU3y6oCHURw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RF5Dl78Y3S99h9fsq1r5MBOez4DM9hZugMZcurBiZk=;
 b=FxQzjrrVHSETDg829+fQP191WoSK1zz4sNeh0nsTaA1fCnX0vHNg1wvoC/Ita4tLfwFqU/WaMNaH/jPvbzRkWMOPuQnSUB3FzQqCmR2dhoIQ+6yh+/BA4ptfA0bBOZtodXinGb8nVQYLwoBXjvnR98z5I9VsEVpqTZn51IJZ1mGdQw5vxn52G2K6DMF1vDV4m6USrUnN4991DX6TTIfL6MaIXJFhHKbEz0DTnCzda1PHEZbBJ+fWdClRTX7ErIK6i0X6aXdrzCox4LwpwsZM26WWaGHwgb8Dq0Ghte2iFtvc5tGRxKxIldLRXQqZmxYFgGZ0Za3ri5Tz5Q2GJeRhBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RF5Dl78Y3S99h9fsq1r5MBOez4DM9hZugMZcurBiZk=;
 b=IBJUzw2PK6w5c23DkFPbAYgvR3B+VEn5qycDLCQnYSFAdYYZDd5078jOLgE/rZGoqulniplhd8fa0m6RzUMtLieuVyl9VN4c3UO6oN3mcUrKITi4E0TGGMGseAAdoW8+RV8upCZuEEp33XbcWMBQCYILX8Zt5dVZrmUGLd9b3jQXdKZJGN7VLoHG8fwhHG6gi56m1sU1atIges3iYtCqVn1trb0ZfsafzJcD6q2F+vyp4RjwfetSRRwI3vXyBUUB7l9IYEL1YJn5luKvx0Gw7vyD2h8MQT3FsdaJOsbwTNrmxF/BfBTcFaTB1PcD9Ht4fmyYAAWnMnQSbtHHyaPZ7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10533.eurprd04.prod.outlook.com (2603:10a6:150:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 20 Nov
 2024 17:37:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Wed, 20 Nov 2024
 17:37:25 +0000
Date: Wed, 20 Nov 2024 12:37:17 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Jon Mason <jdmason@kudzu.us>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>, linux-pci@vger.kernel.org
Subject: Re: DWC PCIe endpoint iATU vs BAR MASK ordering
Message-ID: <Zz4eTVyh73SQo60q@lizhi-Precision-Tower-5810>
References: <ZzxeBrjYRvYgMFdv@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzxeBrjYRvYgMFdv@ryzen>
X-ClientProxiedBy: SJ0PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10533:EE_
X-MS-Office365-Filtering-Correlation-Id: 9339d75c-ce61-48e7-4540-08dd0989ff0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p3VS4lT1bJNbyJ9+B6KYOwlz/mad2JBfbWHQRcpFHbPkQxgUdCGfvx2R5LOk?=
 =?us-ascii?Q?tvbV8rJsYGGo0bfuB8jtTiOKBh0OoQjkEzfR3bytv4o10ESJEyqRTug0gUzh?=
 =?us-ascii?Q?npcHon+q1FlrNXfgohzzVu8oVByZ6nN28ozRW27HNA5fmen8WCg+alYvuRHD?=
 =?us-ascii?Q?7Vl90KbWGNYf/sbX/Q1qYklcS5cuOtM8CXHQLTrxbjaRUPWrUjF/8N5okh/c?=
 =?us-ascii?Q?gClpUsx2ePRM5VgymvAI3Q457xM5uT4KNQgglZXCFZieNtTn9Tx+tD2rs2QP?=
 =?us-ascii?Q?tX1ZkFolbhkiPb/cDiRzHvpGL8HFGUgfMErsWP8KNk65w0Nd/crIVAWeKpI6?=
 =?us-ascii?Q?/pIg5PoBgpPYQbzeMfN7LGE6wmzEP1jTKwWEW3DVsIiHavRU/PhTg2cd9JfB?=
 =?us-ascii?Q?5xY0yBzc18Te9eiZD2xpVDnWpWS9rumS2EE0sRZwDdj6ngJHWslEHgpuKuew?=
 =?us-ascii?Q?7PUSe3xR7fag/BmvBIhjsQ/xaPNbyrfWeguPAUbatkXyWuIxsR41qubAac40?=
 =?us-ascii?Q?JCtjLloT+ilQfKuxvnE/6omahHmp5dwhL3dyRSYtFrEN9QJEu0sfRoyGg65s?=
 =?us-ascii?Q?iZdYGiEIlEIMByHj5hlz0B5VibhbdeFi6tG3GzWTVSxIFI/q3fPEZHz6VuIV?=
 =?us-ascii?Q?w33nr4kOMz+283gdimph4WNJjLMJnlEpUuf23DNNO6MJK0MJPsl/rV8cBcKu?=
 =?us-ascii?Q?n7D9LqRQxWhppJwhGIZAUkBVSwtvX6BZpTagAVS4P/Mkhn6F/VdQCmdu238q?=
 =?us-ascii?Q?3jTU81adfQTKD7rp53pcBaPkdOokaQiFLrB+xdxNyJc7+NJkwuOWQmEb2q9B?=
 =?us-ascii?Q?I+XUsTOotJt3J/paB/1JG4EeebGrPPSwMh1rDOUxXAor7a9L+XDAuEWpOEGZ?=
 =?us-ascii?Q?N7fjkDOsPApYh3/Z81rQghl2bSB7msesTr9yUNiyfkom7RJ8m8UNY+6PzMBk?=
 =?us-ascii?Q?l4RGlCdBEwl6crD/ACsUgwL36cGKqT5jEy4tkvNLnpkw6zdIJn8lncTQwrlj?=
 =?us-ascii?Q?JepxB2i8oJpfV8A5RkIutWNr3ImbEUzRFpJ4DWdhWareTUt/NjnOXQyQZ2Av?=
 =?us-ascii?Q?ej9h/1OwrBuQrXHvQsSfW6XorSayE/OjHvLnXfH8Uvhv3bnM4llSQZUDM2Wq?=
 =?us-ascii?Q?kColX3XKAUeowfJv3P9j1CJ5FmQgYcIi9puMKZWjx+/hMKqFeWhSSH6SndGt?=
 =?us-ascii?Q?Fc+pCmiH3p9PMTN+4bGfSwtPqTUkJqQzpiDPIxy5VSunffG/4RqDvPdlvcVY?=
 =?us-ascii?Q?uX47ekgCBgU93ULCJ5YF26rGs17rJdcpfLc9fHlK3V3OwnjxLZzhOVbRy25u?=
 =?us-ascii?Q?Fs96RfO4aKF36jtC/H++ngRnGglGTE/QmXo2IjWfJwX8YQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lucx4zR3xTzmJOuvV2nhLuqYLvYAb+rlyT+6mT9E4Y0ORerpGgXW/DnIPs83?=
 =?us-ascii?Q?Agv1S09mTW8kSpdZg1SxrimbY7aj+IOiXWeihCLZmL/7OhNwDNvvvp+kGetO?=
 =?us-ascii?Q?4Lq4FenkMplSA0kXE3niBm8HlT23360xqcA1Yf9R+WpIrPn7aOPO60v41jkz?=
 =?us-ascii?Q?3h1D8YriwrCdw6pa+6rLZzwlc87na3i6FbmioggvwdQCyECGiISGiOVsxRzh?=
 =?us-ascii?Q?KGChSyLNc5TuBr+1Rnc8cVky5BrADl/blLI+qtmLtgs2KIsVKM1BQVvrceoO?=
 =?us-ascii?Q?I1iti2D5GFB8/wW3EDzjUlRAFHcgBqDYhB5WdjmPaIyfgCpKIwIdUtXnajYO?=
 =?us-ascii?Q?kwREVoaLth60mHfZlyNHnzWfI4wJWitANQfbhB2qocUVDpcvwosW6atkaqkS?=
 =?us-ascii?Q?ef2WpyNY8aPviv9Dph2B/lLs/YLepdN66hTL81kEDMBZcNHwOnDtBHQc+hYk?=
 =?us-ascii?Q?yHUyKDTbO3IpC2pJQF/XchBmmzgvu/D9fKfOK1pYezUf0ZxR0pFVZcy5U4zt?=
 =?us-ascii?Q?12YtLdGrWQeHVvptt1HIpweXHWSBSvVJbA5Xm2dfw3W2sRsWyLvpmhVKHroU?=
 =?us-ascii?Q?+Kb6GRut5GCaZu5ZMnDWqiCQjZULL4pYbe8B9h8CcN9VOHYp5Yfq90/Y8icM?=
 =?us-ascii?Q?nDiMfqjL1jpvsyDufMRZnBD25eqqImsL//f8INAbhNT2ci9o5edDkIf3H6CQ?=
 =?us-ascii?Q?dUj23yZiWeK6ZUWnbRIB4lJ/aHeli7uLnLojnKyWXVU/Yjcm9eKIQ4a1RNCr?=
 =?us-ascii?Q?MXT6+KA2Z4iG/RPW/iNZOMtezBJi8TTAHonsCPfm3myO7RR26TqOOV/phSqU?=
 =?us-ascii?Q?KHRlbTMobeTWPVecc/J3oDEsNpozGcQMwyTOO1jDiVOj6faBAT6wZ+rfwJX+?=
 =?us-ascii?Q?Pa0CkFoMzmNxXUThShQqdph89209KH53xM3AUeMdeFeN6bVpPbV88Odh820N?=
 =?us-ascii?Q?xaim4Uzyw2J4ZWRMthFP+NOOxVIqtfVKqdxv6lqjgciT89FcofQU8y3Vd9B8?=
 =?us-ascii?Q?OfUnwy1kKoQc9O8mIc4zNDrSJ49aM+6KFoXwtvGYlTQk8/BYoCVcDdUbZDKx?=
 =?us-ascii?Q?G96DEeSNsLtkb8jxY9JGjKHZH08P43yXp8rwK6iDatKr9ux7MsSsTHUrv+sZ?=
 =?us-ascii?Q?hJz0Izod9SAQt4DYXSDaocWd8LvxUkOaOqIazcVJrbZrJRifQZLaU33uUBFH?=
 =?us-ascii?Q?TJEMarxzSSywxIkuqMIUry7ctWStlbnqRY49Gqnx7MW8q+RcMredk5nAG3fB?=
 =?us-ascii?Q?reSVAQRyzjQJSKuwd3Twwg6OqmFOXf0IfAnfBRbX3DXvtwloBxl6jJPemnnE?=
 =?us-ascii?Q?DcafqPqBmYRkPb34y45CPPfG6p+h3fmFwe00jUROerQuhgiBdVsFDB/oC2f9?=
 =?us-ascii?Q?uO1c8pES+SoK9RUqBfGK3+v7ijoYedfSoJ4BMfewh1ID9ocUsCvh+60DumTQ?=
 =?us-ascii?Q?xmZqv7o9FpZfzR7jgUIX3861ztQDDu3FoqtZYf5gpc3Rerz5UzhjdCWeMik+?=
 =?us-ascii?Q?RkhYgU0bwyAYGj8Xa53tLxzDlGfgmMGFG7UzoRpX09Vz0gVXewojt/AYQhS2?=
 =?us-ascii?Q?tEqSe7E+jD/aK0Qv+9nmLf2MXA4QBf/lGUM3gmUH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9339d75c-ce61-48e7-4540-08dd0989ff0a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 17:37:25.1515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nrf0hZxCeMd7UBol2gB+p2P2QZ6wU1iyrjGI9d1fK2sE0Ko39RCPEzDcSdSGMzB+I44ccGunZc8q3ytcAEZYzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10533

On Tue, Nov 19, 2024 at 10:44:38AM +0100, Niklas Cassel wrote:
> Hello DWC PCIe endpoint developers,
>
>
> As I wrote in patch [1] (please review):
> The DWC Databook description for the LWR_TARGET_RW and LWR_TARGET_HW fields
> in the IATU_LWR_TARGET_ADDR_OFF_INBOUND_i registers state that:
> "Field size depends on log2(BAR_MASK+1) in BAR match mode."
>
> I.e. only the upper bits are writable, and the number of writable bits is
> dependent on the configured BAR_MASK.
>
> While patch [1] is a nice fail-safe that we definitely want to have...
> I can see that the DWC PCIe EP driver is currently broken (and has been
> since the beginning).
>
> We are programming the iATU _before_ configuring the BAR:
> https://github.com/torvalds/linux/blob/v6.12/drivers/pci/controller/dwc/pcie-designware-ep.c#L232-L247
>
> The problem is of course that the iATU registers depend on the BAR mask
> (the number of read-only bits depends on the currently set BAR mask),
> so the iATU registers should be done _after_ configuring the BAR.
>
> Doing it in this was makes a lot of sense.
> First you configure the BAR, then you configure the address translation
> for that BAR. (Since the iATU in BAR match mode obviously depends on how
> the BAR is configured.)
>
>
> Now, I would like to send a patch to change this order, so that we actually
> write things in the only order that makes sense, my problem is this line:
> https://github.com/torvalds/linux/blob/v6.12/drivers/pci/controller/dwc/pcie-designware-ep.c#L236-L237
>
> This code makes no sense to me whatsoever.
>
> If I look at the commit that introduced this early return:
> 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
>
> It is not signed off by any of the regular PCI maintainers, neither does it
> have any Acked-by by any of the regular PCI maintainers, so I kind of wonder
> why this patch is there is the first place...
> (Taking something via a different tree is fine, but that would still require
> an Acked-by by one of the maintainers for the tree which owns that file.)
>
> While I am tempted to simply send a revert for this commit, so that we can
> write the registers in the correct order (iATU after BAR mask), I still do
> not want to regress the NTB EPF driver (even if the commit appears to have
> bypassed the regular PCI maintainers).
>
> Frank, since you are the author of:
> 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
>
> Please advice on what to do here. The only thing that makes sense to me is
> that dw_pcie_ep_set_bar() always writes the BAR MASK. If dw_pcie_ep_set_bar()
> does NOT write the BAR MASK, we depend on whatever BAR MASK was there before
> dw_pcie_ep_set_bar(), which no matter how I look at it, seems horribly wrong.

dw_pcie_ep_set_bar() don't change BAR MASK because host side also use it
to allocate resource when probe. But it just change iATU map address, for
example 1M BAR1, map to EP's side 0x1000_0000, it may change to another
address 0x2000_0000.  In doorbell MSI case, you tested, it dynamtic change
to ITS address, then change back when do normal bar test, which easiest
way to understand the behavior.

I think the order write iATU and mask doesn't matter because hardware
should just ignores some bits according to mask register.

If there are another APIs, which change inbound map address, should be
better.

Maybe off topic, I think if support combine some segmement address to
one bar should be wonderful, such as combine MSI ITS address and other
register to BAR0. It is not worth to waste one bar, which just for
doorbell.

Frank

>
>
> Kind regards,
> Niklas
>
> [1] https://lore.kernel.org/linux-pci/20241116163558.2606874-10-cassel@kernel.org/

