Return-Path: <linux-pci+bounces-24996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140E8A75D76
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 02:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1E83A7ECA
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 00:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840ACB640;
	Mon, 31 Mar 2025 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="DsZTxIeu"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011065.outbound.protection.outlook.com [40.107.74.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19C08F49;
	Mon, 31 Mar 2025 00:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743380842; cv=fail; b=eGZWOTeQP9Yu+tdNGHb7tyKD65sl+32F4DuUgYyeGrfsxj27XoSuTb7CpIxVZKslcei1vuf/r9DEzG4nPRhsD+gX3Wv8l2ubJFNX2lU4IAS6I8Hpzqt3qShiInzZPvknuq4X5TgEQxRdSOnAMmMhrSwnU6e1JnAaAgyk8Svqfa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743380842; c=relaxed/simple;
	bh=/ze5D5nX7alVlyL1Q0Fph+LCKVqzuA5WmuyWJ/8uHc4=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=rcGgUw3bDU9fAB7vXKmXPk2XjBTAWNcuiDoFqLU3WXMo6XTj0QrsGdbXKv4jCcNwMcKe9ee+lbUSwz0y/mqA7ujkB9u2BJsTFSMrwyk9Ohy1Ie3qEYhof0lS0i6k3i3ctVKDuNosQBtTcH/kNUz+cfR8L4GhFcCykaFdQEYhF2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=DsZTxIeu; arc=fail smtp.client-ip=40.107.74.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPbjxtlqVN+vTJeqJPePsPpUyYGe1LyQuOYo7g0+vDjDLsYCq9xPSxsgkI9MWz3ha3Q/d63Bhy25I2b29Z+MrPCdAf2s/ajo5+g4sZ2wCdjgoKCXiLBWauFrxS/f70lUFQP5pHZR8lrWiCd0eBozkmK6WE3wdO4x7PhiBzQEluk+muqBuJbpj3YMxw+kNoFzZfBNLfertkrteexwPjCPo4uwaqzD8pk52dRL1ghPnkWaKclROIBspJ3SODOFgpXRakrapQo70aqDHJHi/BqPBGwM42tXMg7t6KaZQ3cn9dTUlL1Az/O0+CP/rjTiHXH0w8976PkF+YiLRzPBCoh+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9h7bXX60sVZtwK61j056sTCZLEG/ETjZhqAHk6zfpE=;
 b=XdkF9OpQX2xRFNZ+T+XMXOYWEtEqlZO64cSDCSLyLwdy54JSZ0I1WkWXVgUVLq3Qx47bMm8TUMscx0cqRZkWIX55uk5A9ue2YutKVXs+c2GxLSVdiUtAFdpPfj0+rGrLiywTPZu2IZIsWvnr2OlmIk57U9Q4sDkz4BZ225E46J/D7DQ7m94/JKgwuO9Ado89p5NWX4H22gfnK3CR/ucjd1F1CCbXR0sDK3OdXQTzkItRuwQM2J1MQT5DX3v3838To35UwFH82Thxai9qWY54ibHSGb+PpPEH+I9i4sx+blxLgoZ4csm5/ZvTwO526BO3S4iCqsPbuNaEFNsodscziQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9h7bXX60sVZtwK61j056sTCZLEG/ETjZhqAHk6zfpE=;
 b=DsZTxIeuq03wkHyqco4GjGC6/1dh2SNWi4ThPPd2nIpnE+4fHQDGV4Ng1q7vfsH5DqG579YLZ5t+bLFfpcD1WXmu03kIRUOEUahBsFr0nFiXRFLtUpGGp/m9R9mEPzgGSCcO5QaCcWJ+KZVlVWrbiTcLQI6iYo0/i1R5ohOXX/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY1PR01MB10705.jpnprd01.prod.outlook.com
 (2603:1096:400:326::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 00:27:15 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8583.033; Mon, 31 Mar 2025
 00:27:15 +0000
Message-ID: <8734eu11ul.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org,	Krzysztof =?ISO-8859-2?Q?Wilczy?=
 =?ISO-8859-2?Q?=F1ski?= <kw@linux.com>,	=?ISO-8859-2?Q?Rafa=B3_Mi=B3ecki?=
 <rafal@milecki.pl>,	Aradhya Bhatia <a-bhatia1@ti.com>,	Bjorn Helgaas
 <bhelgaas@google.com>,	Conor Dooley <conor+dt@kernel.org>,	Geert
 Uytterhoeven <geert+renesas@glider.be>,	Heiko Stuebner <heiko@sntech.de>,
	Junhao Xie <bigfoot@classfun.cn>,	Kever Yang <kever.yang@rock-chips.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,	Lorenzo Pieralisi
 <lpieralisi@kernel.org>,	Magnus Damm <magnus.damm@gmail.com>,	Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>,	Neil Armstrong
 <neil.armstrong@linaro.org>,	Rob Herring <robh@kernel.org>,	Yoshihiro
 Shimoda <yoshihiro.shimoda.uh@renesas.com>,	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: renesas: r8a779g3: Add Renesas R-Car V4H Sparrow Hawk board support
In-Reply-To: <20250330195715.332106-5-marek.vasut+renesas@mailbox.org>
References: <20250330195715.332106-1-marek.vasut+renesas@mailbox.org>
	<20250330195715.332106-5-marek.vasut+renesas@mailbox.org>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 31 Mar 2025 00:27:15 +0000
X-ClientProxiedBy: TY2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:404:42::16) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY1PR01MB10705:EE_
X-MS-Office365-Filtering-Correlation-Id: 291ba68f-62c1-48f4-8a77-08dd6feac9c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x/jkEdXg/Hsb+7EzeQK/RaN+VqkJeuxlil9tIcEN//rCal8SmS5n0lIEK5rV?=
 =?us-ascii?Q?A1q1yfN9RIjw0wBvI0O2ZFI9qIK/G4pUHEZOHpIEVNoNa7s97xPnwQe+Lm7q?=
 =?us-ascii?Q?vUCPBvem64rTf9pfeigYQzNdHSx7Knr9krvlNQT1v+zPJH7A4Uuz0I188URI?=
 =?us-ascii?Q?VbNqo5SGZix3MRX5q+A+4cjhLlueCEfUtQZTt/Sxamkay9AZrZ6gj12hz/ff?=
 =?us-ascii?Q?OGnVPzNgv85u+383BhFpwTrEZRc+4ITn7BW4PBTjFreIu+6JnoimVWtMKGkh?=
 =?us-ascii?Q?B2lzzBg1h2ydccVv4mMPKSNTYsU4CvmxpPEa6xh5IyQsT9L+CVojA6O+E7GE?=
 =?us-ascii?Q?DOu33jp4G0gh/svgvzZtdgxCUTO3+OU6x/NYfe9X+ve9XR2FdGWjwQkvZ9lE?=
 =?us-ascii?Q?B87fb1uNygf5DkTCZSNq7K1wkoGjyiVGIJXA0q5zQrVzoT+J9eQjjnIFoDx5?=
 =?us-ascii?Q?0RFeyMsk3r9tE8F8ImQRSHc+pTA0yjGYOkY3HNTXugXt8q1WDOiBVbChxxi0?=
 =?us-ascii?Q?/JTTifFZXVvePBa757FTWCK2gcoNCr5oeD4v9iBlbQegZP63XS2n3pIyd5yE?=
 =?us-ascii?Q?b2QvC0ATikbbd4elkuP56RAqoC3bexBgaZcCxbvLGwMxiePBSThLtpwlyZB7?=
 =?us-ascii?Q?gqmW2GkUsOwtWPmhelWk/QL1x5tEM5uZn25IgrP0aS3AO6daBiLxnyvznsgJ?=
 =?us-ascii?Q?PRD9uLzZF4G8BLEyK1MRLuOLD0g+hoZQ+Za+t9H3M1BLmF/VDFnzGdJUXtpC?=
 =?us-ascii?Q?tvUlYzxSjKsjHIXn4yCH4trTrWisamFLup9dQ7IN18rtmx/BCgd2bZnsJ5wr?=
 =?us-ascii?Q?ol6MUWBU/uRORlsQShlxF1aGGKWCm/Aurz6VamMxN3cajY23eH7uLXuK3X5M?=
 =?us-ascii?Q?gpGGQrdQuOSBM7ickkHfoIahYSARK+VZ7oSRhSqeZcQX63NY2LxdOS/vKNZs?=
 =?us-ascii?Q?Z5EIr4AHpmbkqs3VezH8Vr0+R/h7WherGdROqT0uobX/6NPZm2xrfM//9WVQ?=
 =?us-ascii?Q?qSEFVQ+dHKBIEVzWXxAFJAzpLn4CMEns9fSivDyXrVfeKji9oC1bVE0EjRrk?=
 =?us-ascii?Q?BIBWLdQbl1/NupJgxz8nEeY0kBtsmxSq6Wp3l50bwby/5sQ/C4lKo2PHHxAn?=
 =?us-ascii?Q?S6Lwz8hMxTKkmMjY0JDyr7F3pMQhHEtg+etibgi79cUT3XyHOkhL/vG0SIa8?=
 =?us-ascii?Q?VZRGcpxoR0WZRwyuIW4FMVYkhK66vgDCyY1qGoNfP57+VJU2CRjdoguvx9vv?=
 =?us-ascii?Q?/78z3kDjnQ1jhhjNAlhCOUzO+KfP8xnkPYGTuqfe9aAuSzNrUkhjS1fdvaTI?=
 =?us-ascii?Q?A2tUGeB0u3RiK8FKH2gZxMRPntksOCSnEdmOy84Qv1VKrXjA47+DcYSY14nI?=
 =?us-ascii?Q?rbSFM+cuDrCQXzwuxG1M0EXjz7PmRsN5J1Kuuna6mc7X3aGx6wqJY9saIWGN?=
 =?us-ascii?Q?q5AfWEGCczCqFv/osvqdaF3iXlIgBcDSilaNAoa/0qR1fr0Y4ab//A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DpILXSPVY1VcCure4TZWK0+GGCf3e1nfAELp40ko0DlVV7b/RgVK6M1EFmDw?=
 =?us-ascii?Q?JB5255GNUu+/bd0DzEm5h7RGP/fG74cycB+YAWiEmlgSfj3yIFH4Jgd5/wcc?=
 =?us-ascii?Q?7cGY/Vs9+TRjWKVn/h831aPNd/hdrF1jVkXiZwL49wuLsxrvhLMMi3m9CQ6X?=
 =?us-ascii?Q?R9FhtCZZ8cyt/NZtRI1ari+2+EkWuAVAlMkbtFzsgEfv2hSL2aRiDohrY3No?=
 =?us-ascii?Q?0wlfK7lJTMvi6+YsxoqEoxiCD7cNB/Vm959X0G8w+TOrpxLYzVXeGUs3rfDz?=
 =?us-ascii?Q?m7aBlgmsbgxw7plNvdLTkJprP5r0eusNc2Ahc9dR2JbYDNpEOwYNA3bu2jXs?=
 =?us-ascii?Q?pf6jD9IlCApnB8FqyYQKV/aV3un+mBDowmtK/1Xr00cwiCg2sCRQRQ9KV25r?=
 =?us-ascii?Q?q4Lo3YKRNgSmuWPS7ijIDoFfsze4NrYkz3n33T9QpJ2juhY4oZy0q7mzK+pR?=
 =?us-ascii?Q?Icu9R3N8362N45Tl9zCq+GgffRQzuU7DNWOsn0Ax9M95o+SjpOISd97Ug8kd?=
 =?us-ascii?Q?y/+9/vNFa/bfRi30iezzQ2eu5WQcmDemh4/H4NcHT4aGM6mnZDwwTQwCHCzc?=
 =?us-ascii?Q?hYxeld09hOxCKYSDeOvFM9RYvXHnkq1XdoZz41ZjarJcX3kqzGhs+IPiCyLI?=
 =?us-ascii?Q?sdIslz6OJHHow0zhONTzupq7+RjQvTskXkEotTjWEEN53wYAXTAfBNdOCbZf?=
 =?us-ascii?Q?Tdudtq1ddW2V34JnsCh1CMFYyLhfFQ42MoZaPXoKb/i6CRg5uyUxqjsH40jt?=
 =?us-ascii?Q?XMulH/bhuv7RDFXckbzCyD3gVRQ+dNzRHETbzVbPFNFcvmMkr5EVFJZlDWos?=
 =?us-ascii?Q?DytOkljoE/fbQZiO4tQXXyIG6nmJ5gQZIOudZScr7iCNi2f6A1wod8vxGEq2?=
 =?us-ascii?Q?hwlRIDQPPQdZFSui/a8xTQ+Y5FWzZNWIsQs6KKmiSjrINOGIgSM+rHOcNz2d?=
 =?us-ascii?Q?SZVjv6W69ozH/A7Jbr1bOxmVJXYPJOW6koGOGF88CBfNQ0T5EwlFsUNmb0lS?=
 =?us-ascii?Q?iZDaT96YleqQgixXZiGAUx69wvpDAPQHpinvdaxsRfOOliiUAvR3Yj2U96xZ?=
 =?us-ascii?Q?9Td8lfyDE/dbWmzvelM4QiGs4kEWPOEGRryZYkimMNPI+dnZ4hYBhjvniyYJ?=
 =?us-ascii?Q?piX7/d9C4AdHGQK2ungEXa3eTcqp960cMlyQB+4GlVzO3opW23vsgR4WTcTX?=
 =?us-ascii?Q?r4IN+84X6Y+XGeGbT6cqVH3w+dvVx8bdkMSO+Bd1yOqQgNNBpzo7BVUSwOrH?=
 =?us-ascii?Q?mWIEMV4ljomMYceOSOg3j5EKy9yxBotDwijO+o6TqXZrDIFA0jTl/G2id+Hj?=
 =?us-ascii?Q?B4d7Ee6dI3sxRFYH2NfksfCljrNUXNEjXDWq9uWyZ95wJV8oWAHiFYBV5fXA?=
 =?us-ascii?Q?buYhjXQm0hYo9fLV6gxesMqz+zcwkNsUvy+ft8TQ8oZ5sqYicMgvJBVvQ7cM?=
 =?us-ascii?Q?iaUoxr8PHb42gwpPhVaHdcWus5G85ZdZTWIHv8gFE8FKlMo4cbjn6kwaAimr?=
 =?us-ascii?Q?ZIHSen5PSVCYb4m9pgcV9LP32hscu3bsHiJMUpQwRVn5hQTbg79Orj+5qxy0?=
 =?us-ascii?Q?heMCYbU94whB2mrrD/JfMuKYJaLgNzIxFeU5F1PtDQVHq+7xmxcti4OjdCgC?=
 =?us-ascii?Q?6UEttWzJpKv5b6/5wWmg0tY=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 291ba68f-62c1-48f4-8a77-08dd6feac9c2
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 00:27:15.6023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OX0E8HpLody65sxejmQQH/UV7EK/nsFyTXar6wpXikVJmBYCE1FJ0IMBmP9rhxkdBpsjfznCkxtVvii75C244r7iQdw0GYkrhSk21A8ZugjkOYST9oB0VRpZQ0j6iESB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10705


Hi Marek

Thank you for the patch

> Add Renesas R-Car V4H Sparrow Hawk board based on R-Car V4H ES3.0 (R8A779G3)
> SoC. This is a single-board computer with single gigabit ethernet, DSI-to-eDP
> bridge, DSI and two CSI2 interfaces, audio codec, two CANFD ports, micro SD
> card slot, USB PD supply, USB 3.0 ports, M.2 Key-M slot for NVMe SSD, debug
> UART and JTAG.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Not all parts, but for my related part only

Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

One concern from my side is

> +	/* Page 31 / FAN */
> +	fan: pwm-fan {
> +		pinctrl-0 = <&irq4_pins>;
> +		pinctrl-names = "default";
> +		compatible = "pwm-fan";
> +		#cooling-cells = <2>;
> +		cooling-levels = <0 50 100 150 200 255>;
> +		pwms = <&pwm0 0 50000>;
> +		pulses-per-revolution = <2>;
> +		interrupts-extended = <&intc_ex 4 IRQ_TYPE_EDGE_FALLING>;
> +		/* No FAN connected by default. */
> +		status = "disabled";
> +	};

Indeed "base kit" doesn't have FAN, but "complete kit" will have, and
official page/site will recommend to buy and use it because the board will
be very hot. Default "enable" is better idea, IMO.
But it is not a big deal for now. Additional patch instead of v2 is OK for me.

Thank you for your help !!

Best regards
---
Kuninori Morimoto

