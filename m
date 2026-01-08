Return-Path: <linux-pci+bounces-44249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CCED00FB2
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 05:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1D68301FFA9
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 04:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C5D1A9FAF;
	Thu,  8 Jan 2026 04:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="CCMcxLR7"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021093.outbound.protection.outlook.com [40.107.74.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C28218EB1;
	Thu,  8 Jan 2026 04:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767847167; cv=fail; b=HylEM37R08WWA3eg4Z8DbRhtLFP4K85Zf3SfVNdJL8KIrk5txgoqBUZXjrGQm4bFAUpew69Tjj/3DHMolZqY6Pkhq4Lhd5m3iNohTNYCH+RdimNNrtiG8+uM34JxvtR5E8s9vy4hLrnp9CrdE1/fBC3Npfs0qW+N3Fn8Vn8uhh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767847167; c=relaxed/simple;
	bh=VyUclDNI2v+/Hd3X3j8763ZeHfaZ1R0GRNWeaP57GTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C7j+l9r66rjGweJoxpgTpDll0ZSlTdFs1dW+Fazg7IVu68tsxozqdL0bG1atMeZWQNvEk0x6DEZ4XpsA8mYnhcmJ0k7HqJCb3lBtnNTjzMj0WI5Sb6ZZxtpk2JCjHci9nYj9RYUr2XDphX8zLFlWsQcZ5jxPaGkqn+/AmCbmDi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=CCMcxLR7; arc=fail smtp.client-ip=40.107.74.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZICUaZYEirQyvk//XGRRADbGEBEsUtDBbZhGj2Wsw2RvBZVvmfkVPDMy7tvjUBQ75Dsxx6oXENv9DCHFG8Hvfl150q3W/TAcCv6KdpgDHCelPVOqzsshaPsLQp4DvG+AZNvRsofjP3rSy0A8kDHeinoJ2zF8WD+tVC83Lua1p/QFMkU9pUV7IuxHaNQ4q4DDNf6ndU1jCp/Si/GtEh9ecxNDoH+XJJBbh7LNz+rGh/S2UjhVjcvqpbtwHmNLQw1zMdqwaFo5B9pCN2z6Unam9dA9/88loXxge4RQI0BD4BMIAUsEAJcMzpyX0g/VdixfXWuCTSdTxsJXqL3P6YzlxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDvoKYX8XjdfmzXRWOPncq1zeUVPtrv3CdKUAgVkX74=;
 b=cKyguaWovFi4Np5+He8hZpo/58ZszyxaAmR7m0giWaKjLl1EiJCQPRyVu4DVC9q2KOZO8JDSpbwcr5GN8fGJHBjwRoXsCYkSSXq9h4Q2Hf5Dhmli9j1bV9odJIfu0p+SvuXi5XqHbi5+ObSsnYgK4LUSyxfcT584BaqSzT0C2V8uu2I9NBeGFa8unhR83hYiD+VRbD8HoQr8Sz0fe0NZKhaYQ6bK/Zb2PyJl0Ypr6ZiXdM98jTVCtbMvYHP1Qw64ij5VbQgfHqV+vE4fcnwoQSbazt7CI7u5es9zP0DRVrudC44vJDfZIApthGmTAgwj8+BKqo2+vd6A2sDZ5Mvaow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDvoKYX8XjdfmzXRWOPncq1zeUVPtrv3CdKUAgVkX74=;
 b=CCMcxLR75cmW75JBDfTIuclVrI2A0D/ZHwmUUNZmBlangt75fNi1+Vfl2ZcSQh3UWc8iZbM8J1YbZW28dgnJCu5wQGDfFXX7hl+M7hvt0sD47haYdmu8tNKBNCldWNiXojUaXjze/dSB9EAaKwpdZFajqmNYWU5tTtbqkxY8qLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB7681.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 04:39:22 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 04:39:22 +0000
Date: Thu, 8 Jan 2026 13:39:21 +0900
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, cassel@kernel.org
Cc: Frank.Li@nxp.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: dwc: ep: Support BAR subrange inbound
 mapping via Address Match Mode iATU
Message-ID: <natqqpolepdpgz3itofdsoiabhmn6bhdig5l45qnov4j2lo7le@5f2cik3tezcs>
References: <20260108024829.2255501-1-den@valinux.co.jp>
 <20260108024829.2255501-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108024829.2255501-3-den@valinux.co.jp>
X-ClientProxiedBy: TYXPR01CA0056.jpnprd01.prod.outlook.com
 (2603:1096:403:a::26) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b01e43e-2dd0-4ecb-4998-08de4e6fe4f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IEJ8REebsS/oJDn5PKBlR9yWKnLUGV30qXoYxsEp/qlBWS8FN6Bw8PBvSC88?=
 =?us-ascii?Q?xu5WKF9kdOZnU5dn/igMFAIgsi9wJFpYB41NHzIlc8GblghE8l27Q61VZPyf?=
 =?us-ascii?Q?SiEQBSJBYyLwnrwcgvDrVGxNmfdBu7T+AMAlEkp2abO9D8U3+0ob6o6Df7eB?=
 =?us-ascii?Q?tyMMyoPSooT8juabRy9f/1CtzrOdzd25qpAO0esvQPEZsOHSF27PvbrcA0Em?=
 =?us-ascii?Q?ksAMdUGVuqgHSS40psLdYRFBmvMveisTA++EVPR9R/UiC84/E0M8Zg27Gdu9?=
 =?us-ascii?Q?HlO9yPQ2NFv/lUJT6nD8WOq2huL6Zhem2FasF5aVIHBl5ks6HSP+HQE7X+ud?=
 =?us-ascii?Q?CEk3hbX/0uMtlF6BQQMuh5/Cmkro6Z05DuUzZSiIvUHW9FJPofIPlStGrfSU?=
 =?us-ascii?Q?K210RooultARjRSe1twlvPYumxgtBDftQ0I+0ImtRK6X2INyED3yq1ZO+Oju?=
 =?us-ascii?Q?YRi6puIPe3fYDRuqHtU9CtuN2y1MtqgvPLNIS83qr2XBSKU/yrkanP/ypKc8?=
 =?us-ascii?Q?/TSSGCCVYVLr53SDdtZfmEOadw7Tvba3OWktg5Q9fKEmgEmSpLVVGURZo+s7?=
 =?us-ascii?Q?giPSzcnjiq04elGlGJHD6QmYH/hwC6IlDXNLTfZDISw8VUTk5lBw5Zx0oa1a?=
 =?us-ascii?Q?UNwIsgUnxjvaTR9ptDdSDXErhcyTu5csdIFYFRcfd9P5pbAU/1CEkOQZ/u8r?=
 =?us-ascii?Q?6SxmVBwOR/6eytzJKfte5xTLK++HFdmUgR2tPUvC98oY8/iJdKY0W9PZgBLn?=
 =?us-ascii?Q?30xBW/Ht/wEXb4ao8kXZHLxZdnzQ/iaZAvQYoTpQkd/j+mVJWVHDgxu6Vta7?=
 =?us-ascii?Q?jykSemeyTUJsw7H0TrQPIncozuQxs6lEMTARagLhl0wCBhoZOEZwLOyAqsUI?=
 =?us-ascii?Q?4wbT7TEXMhesHyTeHBm9BddmOsyUf0fqODbJWJkLZgFeCm179qW4X7+oIl6B?=
 =?us-ascii?Q?/kZJup6APIrIACiE4vSdzK7g1yyIggrx2DWRUv2s6Y1GCGo/0Dimk1+DB1Lm?=
 =?us-ascii?Q?9D1UsWcu9If8Io5O3V+LbJgJ5I923h/DDzKUCjdcn6/jzXlNFtp3tzKp5kd8?=
 =?us-ascii?Q?oKi3S6ukMh8K6LTRJ5UFHxJh+ZzOxfF+F/rh8MryBXFbEwhnQM5sQa64xDIC?=
 =?us-ascii?Q?Gahf3vk1CL1Bd+E0O1f66RuENSIgOGbwY0H/gMVVGr8XRqx2cO9QGi5A6q8B?=
 =?us-ascii?Q?c3yJXJSAdMxxnytaql+DGepc4OTyeZKBqWbZIF0G6dmQGcNQmMzox5C/zCqw?=
 =?us-ascii?Q?nrrBZbLr4CwDrJmIwqtkjg8ttP1ysVJA5G1+63XdLnckNx5/FMQm+QOS2Vdy?=
 =?us-ascii?Q?mHNfDJklBH0PlVPyd+ebDwoJNPpabBvSRdqDqjuyRh2DxOxY6k2/HidLqDvK?=
 =?us-ascii?Q?ipwVZ4zJaCx7n/p8iEiEe9R9lFiXjbkJk4JU5JtCcQMEGeV9A+EeoiN8Ztci?=
 =?us-ascii?Q?V4Uvxt2gphwvnkOvY87W0/M/gVT0cAM+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x/KWY8uavJnmfm2a4erI3JNKaN36LEbMXUGKruHfyJTt7dX/4nKouhuJUMWa?=
 =?us-ascii?Q?4hov+mr7/W6f5pLtQfyrDvm+5ZAjHbCCMtxT9xIGEHbeeJeB3TVXQbuxuojS?=
 =?us-ascii?Q?mt2/9asUy0+kbR2pM7py52wslq7w9ny/U7bOK49V/yYMWPLF7WybND9KqS/M?=
 =?us-ascii?Q?85g0othytv+blitry30wKZVv4yux5B8TvPZ7RBO/+4lldSxt64GPMRwxZH2L?=
 =?us-ascii?Q?uAanGA18hO0aq5tMcOvATSJ/DVQucjCD0gJygzVh4b8zfkDPacYHf6ZQZEnQ?=
 =?us-ascii?Q?z6Q6dYU2w70kdtgSSeNbfMRe0TX3Pis6EP0lpEbagcBFc8eeI+Gz0rrH+dZ4?=
 =?us-ascii?Q?mAZ7LeYdIr+y6MY8Ts5IiD0v+HPYmfWcxvoAU1gfrpm2wpxsUAQvFS/hywTv?=
 =?us-ascii?Q?eu4mOWmDK/NxPyZXwGroIJi34Do9CjBD+73TYWn+3ZVYX/PQRnIforxZ86/y?=
 =?us-ascii?Q?JbYfH8iiNSX847eDx6HK0OvNeFv5FotL/875hDLGdu9L6bcR1Ny8zqiI8Mn/?=
 =?us-ascii?Q?ROkPnaMtCO/dlFm8efeBMYtJbKt7QzUPXbpqcYoAbm7wM0Hm8MJBeEvlyFXe?=
 =?us-ascii?Q?0narSTsZ7/k/SwL4lHnQi2h/Q7HfRxSuajaNpcG7Fy3GhJcvMWZ0BlzVzivQ?=
 =?us-ascii?Q?Blc6OUqmNidASowIbwFrSVL9DGYERcPMj4VIuXRu9uhNXoAaB5gSrpUJ76vQ?=
 =?us-ascii?Q?fYPx7qBOfEafC6Fz5+YurBYByk8w6cEzTu9SKIK54VuXfN1Ck1dJDQOwmkhK?=
 =?us-ascii?Q?FwqwKBB+nLDkHv9llL97r3VkfohXLiZESS4RsZSB4Gu7WTX1r/FzF1dUM3VV?=
 =?us-ascii?Q?+wz3ejmEV+i2j+bkhTeSX7POedn4kAMNRytKvQFdtYYAYHvw0XZHhk0J1QkR?=
 =?us-ascii?Q?q2CtTmrrIK2GaSFjPPNLn0idCrK6mGXv2egO7MSmZC1th9WbVRcM8rqWRWsc?=
 =?us-ascii?Q?PLtVMVAJuucSpqvgcKNjLF3X2QeAHNWVpw7o70Q11Co5uoNW9h7vJ9u/3N9H?=
 =?us-ascii?Q?vNj06Nf29CfpE9CjQaHXvvfhUxhz0NADbPz8jmzcWX5vGrijT5fKOraJTYnr?=
 =?us-ascii?Q?jv9G9wKw8cpw0L1uPo/j6UUMmRca6emYA2//kYtsAQB9Qd6EpNFWKy5Sjy55?=
 =?us-ascii?Q?lGU/VzamTpz0EgvxxqBS28hiS70Gl1tES9g925MpCAtDv3jNo2I69Gg8zxNv?=
 =?us-ascii?Q?OXffnR8VoOQK1pMO7vZZS98bjG2tP6RG7K8wrT8iUZbpHJCP4l4tExvVJjpc?=
 =?us-ascii?Q?ffzfhMVGic8cugc8IdEjFP0lJNuhbYBcCJL0PgRcXXzSTHt0sFBirgRSVHF7?=
 =?us-ascii?Q?I7gCC1GwSHfEUAug/te32w5HkACtl9vV5/UQMsl3aw/APGJN2E1pqUCgBvOQ?=
 =?us-ascii?Q?5dgTovOkIyglAtU2XiffmVRXb/K8QPOPqzgJa4Yr8gYQGUyYo7nSGw5fasqZ?=
 =?us-ascii?Q?+xUwJj4p3I92dZOb1PDXt20Dnj5MGVRIG+YDOejBBlGhA3kqPv/OVDPxZf7z?=
 =?us-ascii?Q?GYFcpM/gZmTNCPKPwSsjq5PJl7ZhAT4x9PXjD8iV0BUzoSyoHghUXCwEunse?=
 =?us-ascii?Q?7f+nSvEmLlz94tAoQvgMqpxlUb5eIyn7AA+OU2z8fkAKcfvytI47khHEy2nz?=
 =?us-ascii?Q?xPcgOGZDLSWN96oQtXCy+1Q3xc1JVomx7pSO415EzKPppITS41ALdw/MjKkO?=
 =?us-ascii?Q?PFdtL8r9Cp56r7S3dIfF+fGaVPVTQLaiOiOsEVrgWartHakGWzGguDhjXZsX?=
 =?us-ascii?Q?Z4BVPJgz1/vZsJssjCxMChKiCqttFrY9R60zbo094dPNIvv70q5N?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b01e43e-2dd0-4ecb-4998-08de4e6fe4f6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:39:22.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++cN9HEFZ/UBQYDkRGTtSyhtVW8/Q3A9yYWCdlj6kYTIr3qCQfBGI7HdIITpla0oSt4UH7pzyEorTG0AgIP84w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7681

On Thu, Jan 08, 2026 at 11:48:29AM +0900, Koichiro Den wrote:
> Extend dw_pcie_ep_set_bar() to support inbound mappings for BAR
> subranges using Address Match Mode IB iATU.
> 
> Rename the existing BAR-match helper into dw_pcie_ep_ib_atu_bar() and
> introduce dw_pcie_ep_ib_atu_addr() for Address Match Mode. When
> use_submap is set, read the assigned BAR base address and program one
> inbound iATU window per subrange. Validate the submap array before
> programming:
> - each subrange is aligned to pci->region_align
> - subranges cover the whole BAR (no gaps and no overlaps)
> - subranges are sorted in ascending order by offset
> 
> Track Address Match Mode mappings and tear them down on clear_bar() and
> on set_bar() error paths to avoid leaving half-programmed state or
> untranslated BAR holes.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 234 +++++++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h  |   2 +
>  2 files changed, 225 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 1195d401df19..a830c91a5849 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -8,8 +8,10 @@
>  
>  #include <linux/align.h>
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/sort.h>

I forgot to drop these two includes. Apologies for the noise.

Koichiro

>  
>  #include "pcie-designware.h"
>  #include <linux/pci-epc.h>
> @@ -139,9 +141,10 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	return 0;
>  }
>  
> -static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
> -				  dma_addr_t parent_bus_addr, enum pci_barno bar,
> -				  size_t size)
> +/* Bar Match Mode inbound iATU mapping */
> +static int dw_pcie_ep_ib_atu_bar(struct dw_pcie_ep *ep, u8 func_no, int type,
> +				 dma_addr_t parent_bus_addr, enum pci_barno bar,
> +				 size_t size)
>  {
>  	int ret;
>  	u32 free_win;
> @@ -174,6 +177,208 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
>  	return 0;
>  }
>  
> +/* Inbound mapping bookkeeping for Address Match Mode */
> +struct dw_pcie_ib_map {
> +	struct list_head	list;
> +	enum pci_barno		bar;
> +	u64			pci_addr;
> +	u64			parent_bus_addr;
> +	u64			size;
> +	u32			index;
> +};
> +
> +static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, enum pci_barno bar)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct dw_pcie_ib_map *m, *tmp;
> +	struct device *dev = pci->dev;
> +	u32 atu_index;
> +
> +	/* Tear down the BAR Match Mode mapping, if any. */
> +	if (ep->bar_to_atu[bar]) {
> +		atu_index = ep->bar_to_atu[bar] - 1;
> +		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
> +		clear_bit(atu_index, ep->ib_window_map);
> +		ep->bar_to_atu[bar] = 0;
> +	}
> +
> +	/* Tear down all Address Match Mode mappings, if any. */
> +	guard(spinlock_irqsave)(&ep->ib_map_lock);
> +	list_for_each_entry_safe(m, tmp, &ep->ib_map_list, list) {
> +		if (m->bar != bar)
> +			continue;
> +		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, m->index);
> +		clear_bit(m->index, ep->ib_window_map);
> +		list_del(&m->list);
> +		devm_kfree(dev, m);
> +	}
> +}
> +
> +static u64 dw_pcie_ep_read_bar_assigned(struct dw_pcie_ep *ep, u8 func_no,
> +					enum pci_barno bar, int flags)
> +{
> +	u32 reg = PCI_BASE_ADDRESS_0 + (4 * bar);
> +	u32 lo, hi;
> +	u64 addr;
> +
> +	lo = dw_pcie_ep_readl_dbi(ep, func_no, reg);
> +
> +	if (flags & PCI_BASE_ADDRESS_SPACE)
> +		return lo & PCI_BASE_ADDRESS_IO_MASK;
> +
> +	addr = lo & PCI_BASE_ADDRESS_MEM_MASK;
> +	if (!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
> +		return addr;
> +
> +	hi = dw_pcie_ep_readl_dbi(ep, func_no, reg + 4);
> +	return addr | ((u64)hi << 32);
> +}
> +
> +static int dw_pcie_ep_validate_submap(struct dw_pcie_ep *ep,
> +				      const struct pci_epf_bar_submap *submap,
> +				      unsigned int num_submap, size_t bar_size)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	u32 align = pci->region_align;
> +	size_t expected = 0;
> +	size_t size, off;
> +	unsigned int i;
> +
> +	if (!align || !IS_ALIGNED(bar_size, align))
> +		return -EINVAL;
> +
> +	/*
> +	 * The array is expected to be sorted by offset before calling this
> +	 * helper. With sorted entries, we can enforce a strict, gapless
> +	 * decomposition of the BAR:
> +	 *  - each entry has a non-zero size
> +	 *  - offset/size/phys_addr are aligned to pci->region_align
> +	 *  - each entry lies within the BAR range
> +	 *  - entries are contiguous (no overlaps, no holes)
> +	 *  - the entries exactly cover the whole BAR
> +	 *
> +	 * Note: dw_pcie_prog_inbound_atu() also checks alignment for
> +	 * offset/phys_addr, but validating up-front avoids partially
> +	 * programming iATU windows in vain.
> +	 */
> +	for (i = 0; i < num_submap; i++) {
> +		off = submap[i].offset;
> +		size = submap[i].size;
> +
> +		if (!size)
> +			return -EINVAL;
> +
> +		if (!IS_ALIGNED(size, align) || !IS_ALIGNED(off, align))
> +			return -EINVAL;
> +
> +		if (!IS_ALIGNED(submap[i].phys_addr, align))
> +			return -EINVAL;
> +
> +		if (off > bar_size || size > bar_size - off)
> +			return -EINVAL;
> +
> +		/* Enforce contiguity (no overlaps, no holes). */
> +		if (off != expected)
> +			return -EINVAL;
> +
> +		expected += size;
> +	}
> +	if (expected != bar_size)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/* Address Match Mode inbound iATU mapping */
> +static int dw_pcie_ep_ib_atu_addr(struct dw_pcie_ep *ep, u8 func_no, int type,
> +				  const struct pci_epf_bar *epf_bar)
> +{
> +	const struct pci_epf_bar_submap *submap = epf_bar->submap;
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar = epf_bar->barno;
> +	struct device *dev = pci->dev;
> +	u64 pci_addr, parent_bus_addr;
> +	struct dw_pcie_ib_map *new;
> +	u64 size, off, base;
> +	unsigned long flags;
> +	int free_win, ret;
> +	unsigned int i;
> +
> +	if (!epf_bar->num_submap || !submap || !epf_bar->size)
> +		return -EINVAL;
> +
> +	ret = dw_pcie_ep_validate_submap(ep, submap, epf_bar->num_submap,
> +					 epf_bar->size);
> +	if (ret)
> +		return ret;
> +
> +	base = dw_pcie_ep_read_bar_assigned(ep, func_no, bar, epf_bar->flags);
> +	if (!base) {
> +		dev_err(dev,
> +			"BAR%u not assigned, cannot set up sub-range mappings\n",
> +			bar);
> +		return -EINVAL;
> +	}
> +
> +	/* Tear down any existing mappings before (re)programming. */
> +	dw_pcie_ep_clear_ib_maps(ep, bar);
> +
> +	for (i = 0; i < epf_bar->num_submap; i++) {
> +		off = submap[i].offset;
> +		size = submap[i].size;
> +		parent_bus_addr = submap[i].phys_addr;
> +
> +		if (off > (~0ULL) - base) {
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +
> +		pci_addr = base + off;
> +
> +		new = devm_kzalloc(dev, sizeof(*new), GFP_KERNEL);
> +		if (!new) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		spin_lock_irqsave(&ep->ib_map_lock, flags);
> +
> +		free_win = find_first_zero_bit(ep->ib_window_map,
> +					       pci->num_ib_windows);
> +		if (free_win >= pci->num_ib_windows) {
> +			spin_unlock_irqrestore(&ep->ib_map_lock, flags);
> +			devm_kfree(dev, new);
> +			ret = -ENOSPC;
> +			goto err;
> +		}
> +		set_bit(free_win, ep->ib_window_map);
> +
> +		new->bar = bar;
> +		new->index = free_win;
> +		new->pci_addr = pci_addr;
> +		new->parent_bus_addr = parent_bus_addr;
> +		new->size = size;
> +		list_add_tail(&new->list, &ep->ib_map_list);
> +
> +		spin_unlock_irqrestore(&ep->ib_map_lock, flags);
> +
> +		ret = dw_pcie_prog_inbound_atu(pci, free_win, type,
> +					       parent_bus_addr, pci_addr, size);
> +		if (ret) {
> +			spin_lock_irqsave(&ep->ib_map_lock, flags);
> +			list_del(&new->list);
> +			clear_bit(free_win, ep->ib_window_map);
> +			spin_unlock_irqrestore(&ep->ib_map_lock, flags);
> +			devm_kfree(dev, new);
> +			goto err;
> +		}
> +	}
> +	return 0;
> +err:
> +	dw_pcie_ep_clear_ib_maps(ep, bar);
> +	return ret;
> +}
> +
>  static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
>  				   struct dw_pcie_ob_atu_cfg *atu)
>  {
> @@ -204,17 +409,15 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar = epf_bar->barno;
> -	u32 atu_index = ep->bar_to_atu[bar] - 1;
>  
> -	if (!ep->bar_to_atu[bar])
> +	if (!ep->epf_bar[bar])
>  		return;
>  
>  	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
>  
> -	dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
> -	clear_bit(atu_index, ep->ib_window_map);
> +	dw_pcie_ep_clear_ib_maps(ep, bar);
> +
>  	ep->epf_bar[bar] = NULL;
> -	ep->bar_to_atu[bar] = 0;
>  }
>  
>  static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie *pci,
> @@ -408,10 +611,17 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	else
>  		type = PCIE_ATU_TYPE_IO;
>  
> -	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar,
> -				     size);
> -	if (ret)
> +	if (epf_bar->use_submap)
> +		ret = dw_pcie_ep_ib_atu_addr(ep, func_no, type, epf_bar);
> +	else
> +		ret = dw_pcie_ep_ib_atu_bar(ep, func_no, type,
> +					    epf_bar->phys_addr, bar, size);
> +
> +	if (ret) {
> +		if (epf_bar->use_submap)
> +			dw_pcie_ep_clear_bar(epc, func_no, vfunc_no, epf_bar);
>  		return ret;
> +	}
>  
>  	ep->epf_bar[bar] = epf_bar;
>  
> @@ -1120,6 +1330,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	struct device *dev = pci->dev;
>  
>  	INIT_LIST_HEAD(&ep->func_list);
> +	INIT_LIST_HEAD(&ep->ib_map_list);
> +	spin_lock_init(&ep->ib_map_lock);
>  	ep->msi_iatu_mapped = false;
>  	ep->msi_msg_addr = 0;
>  	ep->msi_map_size = 0;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index f87c67a7a482..1ebe8a9ee139 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -479,6 +479,8 @@ struct dw_pcie_ep {
>  	phys_addr_t		*outbound_addr;
>  	unsigned long		*ib_window_map;
>  	unsigned long		*ob_window_map;
> +	struct list_head	ib_map_list;
> +	spinlock_t		ib_map_lock;
>  	void __iomem		*msi_mem;
>  	phys_addr_t		msi_mem_phys;
>  	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
> -- 
> 2.51.0
> 

