Return-Path: <linux-pci+bounces-39956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 183E8C26C9E
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 20:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36BE04F13F6
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 19:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8857A3002A2;
	Fri, 31 Oct 2025 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AvS+T/dF"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD9A2F261D;
	Fri, 31 Oct 2025 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939461; cv=fail; b=Jb3je/Ak0CeFZ50SlA4t6TY59vdKK6LS6C0l8qNPFWdOTOR9F+pN7I4aoDELE0Xd2OtBjB8cD8fSOTL+kluGlfMOhPBeYzg5mcFDpcnEsTiywivkI+JFillznd7DlLA6/tW+jT45kGPBe0MhsNHZ8cYPpmY/TmlnhPSvjxEKSUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939461; c=relaxed/simple;
	bh=TPzC1kHIb78yRRWHzJT5ge8Ak0yaOIy5RvxHTooQXOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ooQULIArggnkZHQGM7py+0Gp7vmUg/exjOG4TXRvCL6s8xQ1cOCBY2A/ko2evA5aJOqC5sfksuWiVg0I1jG11G1bLL1+oJLyIkLYpXHJrgz2Rzrev8tAnS/5w0uSAsTTvWpv8LSxP0GcMR+EIdxJzyh/cuMX5bIrt3+U6C2my2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AvS+T/dF; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zg0zxdbVkeBHVArOEPmHgXHvOX1hQ0qHZ+K5+4WFGYtezu1aHBrYbtOy6EhiIcQO/l/6p8DkpCEvdmnrV96hyjgl4E4OoUPs4z2p6dmiaPmG8ADaYQu2ieoF6MHIdSnygk6c3r1tQV2W9EorfgqFmKxyhrSqBqGJHNqPHTAuUnELikYxRL+xGtFuR8t+i9U2qqBptlP1OoENJcpwGpQhgGgsHZajaAcA4RlqsA9459BKMhGanrNQ3HW0YQEg4BCVSMmzKMynjUVJKZa/k4fklZH+hjlC1iH5pkH9ZS+NXgLZTspgf0A8F2FvWupfNSx3BECqNDlVlxZ9nJs06icvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvGJG4PiIDltCsQzkHypmVOu2+dlRV5ZAy9i4CyJeaY=;
 b=TWEMuwihfbjIaCVao7fbera6EolSLUPIeRegv5zeemVTK15cA+Ja7mDuzfQROANT3jBySL6KU0DEYEYGmsR7G/SwwIijF6enflmQY1Mhp5mDeEY6jqQK8Og3H6SfrNfnv4kWgKp63H6B8IJi5Pi+jPw7wvpBx17RuzA9BYzWQNrB8NLxYkIVMDLaczlOwGhBVp7isVbkKafhnEdMMbDZ4BvP3kmYRH+j8HXUjk35zHK14SGmF0pQHLV8yG03EEqzFt1C1WA8h6AE3QJsuoAkkR45J21EslAxPwIPaMu9eSDdMWXPUYJJ20FdNXdK3tLqGG1/SxpVjAyR8OVA4n1Nuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvGJG4PiIDltCsQzkHypmVOu2+dlRV5ZAy9i4CyJeaY=;
 b=AvS+T/dFQzLmOmwU0knmjJuiJRjeNx2FcHReL+n/PgR6J082FwuK2iLvkTNyifD/d/Qm86MOJ2jDjVyB8uNWPou2qfTXBPM+4ucuxFr+/F/sOtNWdV4CKeEmneKQv7LBFd8TOulVSSkHwpvBAxJlnQOoSOClHJeyNqtbn6e0+uk+HmCGOVHLDt6u8Z163tBtmZLHGHNimSoN/2hdE5XzCGijKOvWPyvTLir4K+uZUduZK3U8C5dwvgpVD9greE+3gH0iFS4L6MYLNI1TEThDUcA52ousKgh7t4b1iMEItFmuaT4EVbfP1+HYyuV3y4g9620syO5iPPGhWKkV6dYeJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU0PR04MB9468.eurprd04.prod.outlook.com (2603:10a6:10:35c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 19:37:35 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:37:35 +0000
Date: Fri, 31 Oct 2025 15:37:24 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/11] arm64: dts: imx95-19x19-evk: Add
 supports-clkreq property to PCIe M.2 port
Message-ID: <aQUP9GAZ4a9On8uj@lizhi-Precision-Tower-5810>
References: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
 <20251015030428.2980427-3-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015030428.2980427-3-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a03:505::10) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU0PR04MB9468:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a0aab81-dd9f-4ad5-88f3-08de18b4f0ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|366016|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z/FNsBHZgYCDB0Lulo2pLQaoAGAo0DInjwI6+2i3WE6xmjDZ7a3gkh1MQ2YQ?=
 =?us-ascii?Q?MwH/AcRn+COZTiToKK9AxqcDfEndJtHGO4WYctkNJ5tiSWU+IEMPb9rW8A7g?=
 =?us-ascii?Q?bXW2ztwZbZwQs0RNPWX/Q4sY52YPBC+fJtAAukCJIIO0gyxX0aW5vigcdQrY?=
 =?us-ascii?Q?uTbRO/MFgt6iB1pzBCs/B4zuv/E1CUzQjbifNVNq9gFkyrpilSdJwCFpTvvu?=
 =?us-ascii?Q?QFzz/huR+6mmUh9KFDVR7icI70BX+gescdKj94G4mXC6qLR+o9bKiP7Dex+u?=
 =?us-ascii?Q?t3yKtMqSbJyVUqIz/DfJ9wpZZuduZJQIykfIP3KoxayN5r8AEtaPNN/A5IqA?=
 =?us-ascii?Q?5mXR+SzCxdffCnM0P+eL3g3RHOox2RGyo68IfbATTpQYMb0Q5GOL24M0KcYo?=
 =?us-ascii?Q?7lhpV+PNmG4Waoeh0rYaO6V31XZdWimfnZ6UvFBjRAkra4TwOAVURWFhs8fP?=
 =?us-ascii?Q?ysF/LmcsK/tTf6K8gysghZJ8nz+8thnxF5kXKk/1LeXnpZQKgkAUgLZ0HdTf?=
 =?us-ascii?Q?4A1nVLOOj3Eb62O3EI9FRl7f1XqUgt82XFM91R2eP+/7Bj2UVeArlCJGZIhx?=
 =?us-ascii?Q?p5rNzS/jJu9f9MdX9zTq1cxzOOwEpSTZOoHN3ZbEsW2lffORnFlEiIIk0ZEh?=
 =?us-ascii?Q?32cgQ689Lc72EcRMNK1ANSsRMpHcno7EibBeCOxJmd0TzF4RiloW5IOGAzv4?=
 =?us-ascii?Q?I58PxKxH7EMrqV4qeKU99wRYH4LJqnIBV1fbZBVlYI/IulVdy4ISJ5uAOphq?=
 =?us-ascii?Q?nAxmz7WXJFpMbVTY2UH9czz4eid2+lmRXc74L9Kvfzt0qThmzHRAMx7G/6BL?=
 =?us-ascii?Q?vcIlyjBsm1aDdHA2csAPt9fiFAonnH9Zu5HwZ2mGPWrj/yB3gv+0zDfTbNCc?=
 =?us-ascii?Q?fuuyVeb55ou1TLBh/mmdtyQoohfXbv8Ll8UngX6kUZMEyoEa1Ex5R/C/4sd5?=
 =?us-ascii?Q?yw+N6nV7OsVkR+V9eLV3RwAaE3Wzz9a2f0nmYbrQRah2iXOi85RA4VLWbAsO?=
 =?us-ascii?Q?w7IzROlR0ykItuQ7Ciy7/v20VvhmfRpqc0P/7ldM1uPETNjib1tJzPtCxwP2?=
 =?us-ascii?Q?U3+J7baSqAWD2vBmmmGYRRPR+fnWMBIE5JtoCMJSoFnVmdvXlQfPnTkkEADv?=
 =?us-ascii?Q?IOZyUFjTlXbmpcyf8AoDRL72ngWYRvPpkqMrH7F6ds0OtmHWsVuMwLlrbKKV?=
 =?us-ascii?Q?BmPPEslnq0gO0sojrxW1MExl5bI0+/aghtt6VSPVdtYF7y+zUactu3dlWNbR?=
 =?us-ascii?Q?i8M8eUjse6NH+E63stflkw/pV82b6eaE6+2/30a6uidW9Lk9ju+2XKbrnfI7?=
 =?us-ascii?Q?yjhhs5cH7y1RKAnOxklfr1wTwovtkBOdjHsOUqsHeBDHKOin7oQRU5DDcudL?=
 =?us-ascii?Q?qS5KOFKz0gU7Ka33/oi60uyp7cqK2GwTYG3UzuyXDiAHOuaK0RdzxFlX+vK9?=
 =?us-ascii?Q?dQTVtx77Dcia698eXzNS4OygvDQg8sSsCbKcJgiUowbSAiKVDWEEO+m5Ssn8?=
 =?us-ascii?Q?ean+kcVdTZ8WU99k+UT4ZBKZ6AvD5kBT9bMg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rcpDuF/ZbJojGAdpCaj8Ai+G1cvt9c1uz3mbIJXC7LkKnX42cjdudeNgL8Z6?=
 =?us-ascii?Q?hYZUnM3Iac7fgxg9kmtHwo7Gy8Tf/NjpBq+xIvMy53U98/mQbhcS9o2qh0TO?=
 =?us-ascii?Q?T040+/WaFEDnk+oIG4fwXzc+SbFuxytGrVN/oam2Qbk6ZxeD3CgxaFD0qlih?=
 =?us-ascii?Q?io6YLlhOeoI/AvVYWBh795xBbr0ALch6mjcP9Y8ex13uocJXRDHpuGznuOhp?=
 =?us-ascii?Q?4PkFFuksakgo/YTrveIv0s+xA1xBqSgPBlmIe+tld4MlY0Yvp4XA1Ik4b8/9?=
 =?us-ascii?Q?cmk/vbPDN/BocDahpQTqdYAcgCJMUUcPHqcZX6HLnbhn8Gv2kh9en36QuB9R?=
 =?us-ascii?Q?q52HvDnAN5D210VY/GM2aH3NRzVWmySBiZ8JT8rxd81aqqKRkIz+Y5SBddmH?=
 =?us-ascii?Q?Se/mOYMGovc9DGi643VUjF4jtHeLRF8fDNvu5uV862StiF9qXWcA4EstrZCF?=
 =?us-ascii?Q?nwvDiCHY3bImBqyI94UCz+cYUQB5wW9mRUX+LjCCmAI9IKGGxJCNMaQ4tXwL?=
 =?us-ascii?Q?14oJcUiCMPwzj6ojDCVz/ZB65aKhWVYLA42ma5eQhg62EH+C1FaPOaRvCZMF?=
 =?us-ascii?Q?8uyFiJ2Mu9aMtRVanUQRlypEdpxz+gksp98wOnSame2gi7BsddCx0XuFkIWS?=
 =?us-ascii?Q?7po9L+0fPCfapoSnGqWB2ghPgZTyT95JP99gPOnWE0bz6mWnjKSZgzV9joh3?=
 =?us-ascii?Q?Pu0oXg7ECKt+t8rqEtyh7mYWri4hckGqSyIyuHZrw29hCXJq+uXdcY6Z7hEZ?=
 =?us-ascii?Q?EadmVA8Nq8hFOKr/Ed8/iL8RK4M01l64Fb0Ww51fTK9X7YKSN02G29W1okcV?=
 =?us-ascii?Q?s/dpCzqu5nL1FHP2V0j6DknOlFSSrOaLgbE8+EhttdvXeSU2bbRE4yzSR2n7?=
 =?us-ascii?Q?486bJ8M8XYcNgMenOeFesydYWFWxZ76bQxT8gtXHQecbSvo3CY+bflUGirhV?=
 =?us-ascii?Q?HiQRnTY0YZYDm40Od6YRNFXDioQ1z17rrhVUjxWeCY4oRjNKJQoF1OhTdiBk?=
 =?us-ascii?Q?2CUmT6NNmjpgw1tuEVd/eqYlHFAzost/EVN8k9TamQddCecHZA/Lkpb+gxSK?=
 =?us-ascii?Q?usX81U0u7fChBLLEWSqmKkIoQJDGQSPwcmnl2E1OwIPvu9wQcHzk49P4aKfa?=
 =?us-ascii?Q?tRoONiN3Bj5gTcFPInMkmA37oAExydySjUQr6d+uwGfllrNec62HpbY24bIx?=
 =?us-ascii?Q?JPYqfSrCclwHNxHPB0DsCTwCWpd1zBHeeUXQg7Eb/R+GWGfd50zpAAgRACY6?=
 =?us-ascii?Q?EF8lLbUrQjfgAbN0iAsJrrkLkLK0rb2uhZJ9KrHmiejGyF2psRsFWMsBsbU+?=
 =?us-ascii?Q?UMtidNOJQw/ofQmEik8wcktVJAiSOnZ4LPffsPeWZdD0B4CdfqHgIOjgB3Yh?=
 =?us-ascii?Q?uQgP+pXu2ZwJukfo/GcJaC9BfDhxXyKwrOUkI+derYrPrGxVEgV81s/a3P08?=
 =?us-ascii?Q?wHTU9tybRaVGcS++d7gFDIvYT6Xyt2GdtVoh4dAD08I5vPlMbajTPQy+dRfx?=
 =?us-ascii?Q?RqCEaeoalqRn02J8Tx7U7RChvM+drF1JSMG8XhR/ID8Bl8cPZLC2dhg2gSBo?=
 =?us-ascii?Q?9+wIHXVZ8yZLpZQ78pD9BmpethLeyLmqSlYfZq1q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0aab81-dd9f-4ad5-88f3-08de18b4f0ce
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:37:35.0373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvmfQFAMdTZUVez/BPyBPaqJ/7InxeUPd8z+9DWYPvkIFJ1eBWiRN/cnaR6mxJ3u52Tk4kdVVesMLDJJhEanSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9468

On Wed, Oct 15, 2025 at 11:04:19AM +0800, Richard Zhu wrote:
> According to PCIe r6.1, sec 5.5.1.
>
> The following rules define how the L1.1 and L1.2 substates are entered:
> Both the Upstream and Downstream Ports must monitor the logical state of
> the CLKREQ# signal.
>
> Typical implement is using open drain, which connect RC's clkreq# to
> EP's clkreq# together and pull up clkreq#.
>
> imx95-19x19-evk matches this requirement, so add supports-clkreq to
> allow PCIe device enter ASPM L1 Sub-State.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> index 9f968feccef67..0f470d3eb9af4 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> @@ -542,6 +542,7 @@ &pcie0 {
>  	pinctrl-names = "default";
>  	reset-gpio = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
>  	vpcie-supply = <&reg_pcie0>;
> +	supports-clkreq;
>  	status = "okay";
>  };
>
> --
> 2.37.1
>

