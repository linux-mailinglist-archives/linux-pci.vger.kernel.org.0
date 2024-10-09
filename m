Return-Path: <linux-pci+bounces-14100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7079971D6
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 18:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE1F1C21D7F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 16:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AB71DFDAB;
	Wed,  9 Oct 2024 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cHoDrcRK"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2051.outbound.protection.outlook.com [40.107.103.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5341DFDBF;
	Wed,  9 Oct 2024 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491790; cv=fail; b=SlD9GiPrT7v/mhWEmiaaVixTVki1JCkWr1gs9lK9hqCrjY/DbjYbxraVkQFkyCHuVk935Qjr1kxFpJnLALw2KqMtCww/Cfks7DfyBjKlcZS5hvIeP8wEskg5Ionpdwzk+S4ggRTafbpdpv49rjRnwAdJNJXlVv+Zze78uqLQHgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491790; c=relaxed/simple;
	bh=Emg1frd+Uf2RjjdZEnWklvcAeSh6H8kCU2qRoFWNSTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WgubNc+FtSR5wAY5Xs+W2rj8eN5PQlccQsAkEiPMgm8iLoLtRFO7Bdutfl6F10lJ/nTPIpGr6vMJN0k55vU4lr2UGxc8deNZMcO2UBpAqQhXb1ewsGz3ODDoCnNCYGXEfcS1NXFrQ3u0sMpJFEG+MH7lETpg0gQ0uV2dmEWD2Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cHoDrcRK; arc=fail smtp.client-ip=40.107.103.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNTBonDnyGelXq3u2QY+8rdrOR/ASJZPJlBTBvagRVUgggpr8uXMgVLt+/jtJPFiZYSgc7cY0ezq28SQOy5Ci2LHBrxTREUQjMQO+xOEJhpAGAhrWpjUySulbmx8roQkg8x33kO4A6JBGvH+O1nzmz9sdB904b5aYET1qhQR/2zgT8wVZu25oFxbYLsz7W4UYE9TJBRI0k3LzKZKPujdKLpFzZ4g7aJJl7m3u7NKIE/BrBXNqCeY8a4wXgxonRRJsa/B2K4VNd94uR1/Hg87cAcx0ThOXkUi5Hcy1vJiC/HGhdOfkc3cwVC+Equic07WrV5e0IL3JGMQdt7+mrXQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUVVwHmlFMTQ/bloJf1qbdf+dyiYNC5ijIzt2q4vQnw=;
 b=dXjEHVmOAc8As9d5AB7mYHAobUlqIdrfUqyudSo62Cy0S6jFzw9qjlbtebVcfPcPgcesCYKUyPEzdHD2hWFaTzJoHqJnN3VD8XwhO7GKMqBE/HpMJfd8wIzeMYXHXVsISSlMD20nz6JN5GfAYhxX82uHIdMt17j2aX0ogChbrTw+NB6Fe5QpIcuf0rHSfSXfJyPl9+/XewOywP6qeL7I0sldpi0VqOB9yFNMeQ61Gp+giZK6RrujqUwJzwnevVFQlSuJ+qvnI1UMJUlIpqlIs+mlOJhDndf8pMJGdfk1+HgbFy/ZZfmhL+DoR0jafKqlziqgRBFrHb5zi+SIJP+Mkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUVVwHmlFMTQ/bloJf1qbdf+dyiYNC5ijIzt2q4vQnw=;
 b=cHoDrcRKR4BrEXYBTIweKHQHZjJraBN67oTMuBpOp03WBtMw3yyczvBvxwk6C/PXAqEfGCtCCJyRD02uxNQUtSPwrGzh+exeEbGiA8iaNmmTCFOEsAYM0ZgJAuZxCsXYyTpQaLR2ZYdalPkl7WoGSPhdw91jHRlrGKgGfRbKvWPVLhuR01b0LR6b8at86KeiASoC9+Rd420AGdMKGklty8mQSI3atiZKlkPFJCTt5iDj392U5/HN2tiZlAoXXPxQmKAe5OKjGg1qQ22Dr4EgyXpdNNfJFl43aoPwTbKIbMUDrJebpNNif0Q/4pKZDA6XiQyqF8kUh2fvp8EVgh4Ckw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10345.eurprd04.prod.outlook.com (2603:10a6:102:425::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 16:36:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 16:36:24 +0000
Date: Wed, 9 Oct 2024 12:36:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, imx@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next 03/11] dt-bindings: net: add bindings for NETC
 blocks control
Message-ID: <ZwaxAb+IQnM3IcI9@lizhi-Precision-Tower-5810>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009095116.147412-4-wei.fang@nxp.com>
X-ClientProxiedBy: SA9PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:806:a7::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10345:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a9c7ac8-3223-4dd0-cf7b-08dce88083ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kxLbfFyo7DiRY1YyLM4oYB+SFvK8GekhrxjxQfGjgHB0phd5vNcTb/mYNsuF?=
 =?us-ascii?Q?rgzgdIANiFIcK6NtQpoVbUMq+z2Qim1rK4w5s4VvSKzAlERODAC46xuOCAEP?=
 =?us-ascii?Q?2mmjdFTWqiCTfJ/T/J7fsbwi4NGu2PY8CsEMnVcadLz5DKXIEuBSuZhXtPe9?=
 =?us-ascii?Q?rHnaP/5tQml3A6BUeyvWKvxa8b5VHsXTSirgvqQTWqOlOaAp5hCVKvHcGTut?=
 =?us-ascii?Q?gv72FVLUHOFLFEGD457lz0HIYO9pxRH67x96XIeVeHNh+MjMJ4rWAlXQocEF?=
 =?us-ascii?Q?KOtFONxpJiNRAbGHKJfMOG3+Laxi5eA4fRQz3Bv0ccUIL7MFBwVqbmqwJQt6?=
 =?us-ascii?Q?C6tP9tu+4ab5la98eIe4/oQb6GR+Q8ikBjIB7qwH2zioG+pLkm5HB2MLWD9C?=
 =?us-ascii?Q?OKhMFx2U0WOY9jjeDf+NJwut0dmW3BTj5s5zW7afkJx51q8Ts31gurAA4IM8?=
 =?us-ascii?Q?6dCJSMCt6q5z7dfgOFr/ZhfRJssd9J7gdCDsl6ReElZfMGD4Q6Ne1Ajf1tzn?=
 =?us-ascii?Q?Ry8IJb/D/OpO3Fb2axHD02P9fVQivMUCHPxltc8SgElK2tvnqe/AzzpnmzkW?=
 =?us-ascii?Q?8jNY6FG1HAgMYcyrQ1kADU5CySJ3rkjqlg6GyJVhkXiQdJHQdqPxhPAHKL1/?=
 =?us-ascii?Q?64BDVOsME//kXLRBkEp7Btz3ODUwLTE5rb8ndZXdvQQYPQWegUSmQWeCex/O?=
 =?us-ascii?Q?jtNLjy9r9dnCZURjRuz1jeEFPXbACJxwiRUaCHkymSPzfc7+KCsqlYdBuW/X?=
 =?us-ascii?Q?z6XN02PNMqXtLOWe4frGWFJsnaeEj77caGLOXSU1UzuDtaaqKp+VrPx/PC5c?=
 =?us-ascii?Q?8M/NvOCAyvxR+kjp1309Bm0dVZzDLaJqM4uZ0jXsO7UC0Qacuv7ZcgCJUY/j?=
 =?us-ascii?Q?Q6e57UpCm4AottA9nIFk4THc2UieBvFkjmuNQyQvB/XfZbqDweq85IRylEzu?=
 =?us-ascii?Q?3GmT5y2ypBWdcpbDd9xENQnKoLF0WSMr7wsHTbvYoZAczAksF5JLQ7Ww92sX?=
 =?us-ascii?Q?NEa/vS5ZAy7yYct5GfPE/RCiaAkAM8PSqoouYpyZPNkIqOk3I8wOZ/9V9WCU?=
 =?us-ascii?Q?3hZ7OFhcU5EV1sYkbSj8dSE9mw/WXjdIzTOE/mfYyXBg6kniVwGieUCTv9KE?=
 =?us-ascii?Q?UpilqTiFZBSeCahw0L8G/5pB9mxHDoDx+VGMrR/OCWQNC+aHnV73+DMEoMIm?=
 =?us-ascii?Q?M57KPWgKjWw8BEysTzSNNDkH9NPAKPsEg/dAJdnRF5d3J3CBDGmwLzDwMPHG?=
 =?us-ascii?Q?gDSIwWVvXlAMkEW4SOQrvfjasYwYpefXXP78keQq5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LajkqaDuse2HaSUowG3nmXtTHI7V3y/ww5AiflyFfTckWe8Rp6gHIL8JS6Ch?=
 =?us-ascii?Q?9huvjHLwcvHlM2/0j6VyE8ctAHfxt3ffcdPTJhFKriV+4kE1CUW3B/1McDUl?=
 =?us-ascii?Q?sUkSoRMiybNHc6gktxo2L/f5854RtZKoA1SftBvYM7p966Miax2ZkHypH+Bo?=
 =?us-ascii?Q?K4DCey3uZPhxQmj2f21qSU3yiZYx/9nhkG8Li8xEBhLBQoPwXycQ+BVqUaLh?=
 =?us-ascii?Q?2sDXoDPBQkdfIHDexda3iGcQ34NzeyBesSB+kUpSCMXVG0PWf28Hn4oDKew+?=
 =?us-ascii?Q?3yD6MtIufopCXZSkVOxohoKA4NF8ajVoZoZOfopVOGj6/RfNiP939bBGO93q?=
 =?us-ascii?Q?HZU9A3j10g9AZt1VfnI9/Nu2jLHSUuggbAzlPbBB0ok0/qBQSkijWcKWuOue?=
 =?us-ascii?Q?vFSqr7L0nFzcgc1M7ULCHdCD1Z5a4B+gxs+T8EfLQmVDj8qZqDJnuRetSJrT?=
 =?us-ascii?Q?JVknz1GPZ2t7+IRlY1tfH2PREKV4Ip5m0/4+UZnb2IPk7qbGG+/x8wZd/q9g?=
 =?us-ascii?Q?HmVoGejq4gLR4i/3nwvya7sP0oeCEuG3OQqbn12XpR/U1L2xD4/cGOxONnk3?=
 =?us-ascii?Q?Y/2zUbOO/4R9yYgE6SPZXh/5dO8neKYHkkxAqXpHtcE7GdMl92NCfTYoJGOU?=
 =?us-ascii?Q?d25Zd+Mo56+++N7zJo8/lT3XhVHgt47PjjwZw8BnjHkmqSYGxekp3Xn7dOUB?=
 =?us-ascii?Q?/rOHkIZ3i6IXofnho5qOlkvRxtjpZtRUA4CxlnBChiWWoKgVjdAvlDabS4Cx?=
 =?us-ascii?Q?IeXqPq0sR3J9BIDRnL6LeEjDRR4xUknBdTifukc24PiIETp/cmwHhqyV3Ku+?=
 =?us-ascii?Q?hRPDImxeBqvanPLPTTeyTKGVhO323XtEaNPCW2oSSo+F0N7alTqIC64Soy24?=
 =?us-ascii?Q?Ht35rynFmEuIgO2+qQLLuc425ugtUlA0iaN0VlOFNF8tRTwQsqZ+biO2X9TX?=
 =?us-ascii?Q?H8PHTWiBUz4Tdo1U7385QB/8cBQOsB+UPp4kCwjnbEl+O04Wiv2/yTSYx+V1?=
 =?us-ascii?Q?Mjl46wM8V8k9YS0hjNOCDl14xnHZCPoiVGoURNfHO+gaR4spO2JsTKo9YU5j?=
 =?us-ascii?Q?wtXZH8KiEBoUcd8GVDGy+r7dLXvIVBHdqD8xMBB+YVIrD1Ute9TLE8hOsIjr?=
 =?us-ascii?Q?v2whfjVdb0uAjqp+mLDzlE9zdsVFMug68aBKs4wxIRbUrQ5l/a7qxXgR++GC?=
 =?us-ascii?Q?0P6z9n+43cqMPFRbmEcTboOQ8DbDWeIq+M08/vmY5VGG0JQQMvUaHiTnxNU5?=
 =?us-ascii?Q?4RQCLFnCVec1lkE5ikpAYcDuK3m9U0xZI+2CPqNVG1xv95TyQNC3eBDWxGrp?=
 =?us-ascii?Q?9hjW78fNZuT0QSMd/Vx1SRrUue2fCa5uG9xYCBHmPyMJVLQg3DhKUQyfqBAO?=
 =?us-ascii?Q?NZO9r8i/qGOCh5Nss58NbB/TguTXLX4XB+9QZSrjaC0HDFXp47+LlZm4va+H?=
 =?us-ascii?Q?MQxlsVFvSgNCep3t/xHlPtkFlSSexN7AiYfrdryrTc3Lyq7DC4e3vbujksmH?=
 =?us-ascii?Q?Dvh/HhgL/lzN/ZwP43ephOXyIRVfGT56w7dqZ2vKRZBdufDt/ZIr87h3Z2eP?=
 =?us-ascii?Q?+Kz2Z0IpRhq0IYzQ1hE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9c7ac8-3223-4dd0-cf7b-08dce88083ba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:36:24.4778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDGbB5nHRzEZ6H3U+xYfPJlm6ixdUZthvUuHTl8oLxf7J+er4ep/4sR3LEjmVSMWmMN4elRq+qQ97ZeJPO/ftA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10345

On Wed, Oct 09, 2024 at 05:51:08PM +0800, Wei Fang wrote:
> Add bindings for NXP NETC blocks control.

Can you add short descript about blocks control? You can copy below
description.

>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  .../bindings/net/nxp,netc-blk-ctrl.yaml       | 107 ++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
>
> diff --git a/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
> new file mode 100644
> index 000000000000..7d20ed1e722c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/nxp,netc-blk-ctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NETC Blocks Control
> +
> +description:
> +  Usually, NETC has 2 blocks of 64KB registers, integrated endpoint register
> +  block (IERB) and privileged register block (PRB). IERB is used for pre-boot
> +  initialization for all NETC devices, such as ENETC, Timer, EMIDO and so on.
> +  And PRB controls global reset and global error handling for NETC. Moreover,
> +  for the i.MX platform, there is also a NETCMIX block for link configuration,
> +  such as MII protocol, PCS protocol, etc.
> +
> +maintainers:
> +  - Wei Fang <wei.fang@nxp.com>
> +  - Clark Wang <xiaoning.wang@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,imx95-netc-blk-ctrl
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 3
> +
> +  reg-names:
> +    minItems: 2
> +    items:
> +      - const: ierb
> +      - const: prb
> +      - const: netcmix
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
> +
> +  ranges: true
> +
> +  clocks:
> +    items:
> +      - description: NETC system clock
> +
> +  clock-names:
> +    items:
> +      - const: ipg_clk
> +
> +  power-domains:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^pcie@[0-9a-f]+$":
> +    $ref: /schemas/pci/host-generic-pci.yaml#
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +  - reg
> +  - reg-names
> +  - ranges
> +
> +unevaluatedProperties: false

You have not ref to other yaml, use

additionalProperties: false

> +
> +examples:
> +  - |
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        netc_blk_ctrl: netc-blk-ctrl@4cde0000 {

needn't label netc_blk_ctrl.

> +            compatible = "nxp,imx95-netc-blk-ctrl";
> +            reg = <0x0 0x4cde0000 0x0 0x10000>,
> +                  <0x0 0x4cdf0000 0x0 0x10000>,
> +                  <0x0 0x4c81000c 0x0 0x18>;
> +            reg-names = "ierb", "prb", "netcmix";
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges;
> +            clocks = <&scmi_clk 98>;
> +            clock-names = "ipg_clk";
> +            power-domains = <&scmi_devpd 18>;
> +
> +            pcie_4cb00000: pcie@4cb00000 {

needn't label pcie_4cb00000.
> +                compatible = "pci-host-ecam-generic";
> +                reg = <0x0 0x4cb00000 0x0 0x100000>;
> +                #address-cells = <3>;
> +                #size-cells = <2>;
> +                device_type = "pci";
> +                bus-range = <0x1 0x1>;
> +                ranges = <0x82000000 0x0 0x4cce0000  0x0 0x4cce0000  0x0 0x20000
> +                          0xc2000000 0x0 0x4cd10000  0x0 0x4cd10000  0x0 0x10000>;
> +
> +                netc_emdio: mdio@0,0 {

needn't label netc_emdio.

Frank
> +                    compatible = "nxp,netc-emdio", "pci1131,ee00";
> +                    reg = <0x010000 0 0 0 0>;
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +                };
> +            };
> +        };
> +    };
> --
> 2.34.1
>

