Return-Path: <linux-pci+bounces-40719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 273B4C47D63
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 17:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 778CB4F480B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 16:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923A8279918;
	Mon, 10 Nov 2025 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R2vtZnv4"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011069.outbound.protection.outlook.com [40.107.130.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611FF276041;
	Mon, 10 Nov 2025 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790864; cv=fail; b=e02icaykjkDK5P3NwTgJhMhEMOKsVabjObgiZqMXHrJRi54ZvtHBCxuKDocteD0hd5O8sZjFyg+m6Y2onLKDRKqRaVEy9C7fFrJDxyvaUzbRHmThPS0WtT8pKUb4wZOTNs8aVZtthwbRaL+pye64y2r9LkRN1rKf91EY3F6Onfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790864; c=relaxed/simple;
	bh=kAjgJ8iAGUpjJRu6H3Vr+pACEEixxxRtm5+veS74b1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=andi5HFzPcnkoOiVGexAM30+vDPNcsSMJMUNtM6IfvDEvLG12YX7Rd8F3gTqsLXMGGKvjWWtXYgVc6qHpEzcJk1V7FCvwKekVoCE+kauERCloZ51vbwWmeI/9CDhcHdR4L1FbbxPM1sKKD/g9xUfD49nq58P4ygEu3tufjH7qr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R2vtZnv4; arc=fail smtp.client-ip=40.107.130.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAvpJy2JJLuwxP/7mbTWe8XvqUaJrqZHKGO0VHxhxoY4OTgQqZkg+mYMsaGJIGSJV/MxZAjROizEUfOTS7kHhs7KIsZ498Ik1Wap40RyW9bc8oKedg+RdojEwqE6Sh6JzABuy4633HSaf+R+dnn6tuD/odIYhAvFA4um0jko0wWzt1cpeMLI2BjomqQd8huobE+NrEjn9XcHELDmQj2h4NVWy2GVsYIY5OL6hFOjjDjOZYkp9Ax1ott3rcz1zgoTNbJgb7LGsHzQddglAbKPJ4Dizo1/GibY+3Y3wWSJMBEKZWJH0VuYQzYOjVcR/5RtJ9e3Cyb9Nwa0oOLcDBHRPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oG0VVc/WOY2F2AQbB0otwwx/lTubQtnxKxuWqo12GRw=;
 b=RcRMCrMa6HkpCUOiurV6DGTC7rduHeD73WgF7Vx3W/0rkABm1Q8wjidljV+/Bw4GCBaQoAbE3UM75rSNo7WyWKjDAGanDwXpHq4Kd024Nwme4CFj7tykQ0EBq1bZL6+BOD4/AvPUkvKbhWK32cxldgEG+aChbVESEcKcC2FkHKx76ti4X83u3q9Rz1s2sbk7WXDJ2OwVSSVy3srO6vDD0rLDS7D0s91MxETOJXEk5y/cplmFkPN81I5eI52Fxmdfg+CW1KEEvXTHsZvpa1MEurmjWSPAXAG2YhL3S1OvqKypJugM1Ra+v6SSj6gAthWCl/CaNoHBrPS5vaEXwWAM0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oG0VVc/WOY2F2AQbB0otwwx/lTubQtnxKxuWqo12GRw=;
 b=R2vtZnv4IY8FGtqhDQtT80gw4nKe7GYTtFtRrwo8LdiMAcbkJhWl6fPgL7dyKLEqS9iobeXex9LDq/VgBFEGVOtxQ1ilx9duSqvQFAfJwi+wGT990WcGJQqrX5AQZvLfpxF3ZYH+ge7stoj1EctLp64xdTW0u/VuBJqXHZIdxDNXalgnqxQuDFUFoZwzX84QwlHmQo2d6YwrUp3r09yHL0jzDT/lY8u479nKQBDCtIIv1xNkvgOJXUW6ByhEUEJhckltVxO5eZBRE30n6pqnGuoNNjx+CY468Ce5jfaboDgDjrcoLWHiEskbYLt68oL5q5J1XDd5ffwUTZ45dB3MvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA1PR04MB10604.eurprd04.prod.outlook.com (2603:10a6:102:48e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 16:07:00 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 16:06:54 +0000
Date: Mon, 10 Nov 2025 11:06:46 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>,
	Zhang Qilong <zhangqilong3@huawei.com>, Dhruva Gole <d-gole@ti.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v1 1/3] PM: runtime: Wrapper macros for
 ACQUIRE()/ACQUIRE_ERR()
Message-ID: <aRINlvX2GpW3Ue94@lizhi-Precision-Tower-5810>
References: <13883374.uLZWGnKmhe@rafael.j.wysocki>
 <10752302.nUPlyArG6x@rafael.j.wysocki>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10752302.nUPlyArG6x@rafael.j.wysocki>
X-ClientProxiedBy: PH7P220CA0063.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::30) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA1PR04MB10604:EE_
X-MS-Office365-Filtering-Correlation-Id: 0374e114-a394-4c4c-0fc4-08de20732a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xxNzcj01xQ96dn4SGtkLaFAoQe+RKYzDqKEoDMN/ttBPogvHgD1CtphhlSEw?=
 =?us-ascii?Q?lOt++YBv2bTtpcdxCUO21h6PtmiMtFpMbPq2uxhDVhiZ1SKKCnMmcmdyWDuY?=
 =?us-ascii?Q?twl8qOgst5S5yxG2ggzPEXW3QMZ+UYyE2clwTTqqYK4MaLpogGWHBh2rJlWZ?=
 =?us-ascii?Q?Zbj1nBtAcEwapysiVYdnczbJmqpRKuhC4hGeUCI1ntRJaS/9qWSeCRxWbT/P?=
 =?us-ascii?Q?Sl1eJE5+sgwAQEjtVpCkQX55jngmzdxcgiK7rSXGDPA1AyHDGqrbBS4cbw4X?=
 =?us-ascii?Q?jfxDuw523b2eWcp1sw05dwvS9AZQ60Fr4JRhbSyQzKCJsvRJXhGbtEMc27f3?=
 =?us-ascii?Q?eq7tSQfD4P1sEjKJwvxgQ+RX9PpDPVWTFlICL0TZE03ChK702R/6RdHe4ACJ?=
 =?us-ascii?Q?qYYp7GytKoiDiOBe0aDfTfvQpGXHCS/pYGtGS6AAf7c/Fo9RNBL6dFIKSV/a?=
 =?us-ascii?Q?xYkGEr69F6pKc9rb1IhDUWrWJmidoL8tv2R57eYGObAQAd5hDmi+8rdeZfik?=
 =?us-ascii?Q?ky3gA2pW/zdlktvoz3WxaX1Y9paM+xgjFDrn0RwslX/2P8cgQ/K5JPXsFFtg?=
 =?us-ascii?Q?6IfF/sj5IQ1XkALA/HvckCSNdpOsGXID5mWKSzD66ejUHZobJwFd6TANya/C?=
 =?us-ascii?Q?ImbOSCzPF/qm0D9io6IJbHvzsPm+W5SdFEWslc7Da2dTwOf0luwKDPYK6g4g?=
 =?us-ascii?Q?DgOjPnp2X2+jmlDz7CnaEiyYZy1Z/MJAyPpbnf9Ke/PBDOWfH0y4M9/+jsdg?=
 =?us-ascii?Q?hEUPlVlCF++GJoq0hUy9Ku5UbQD5pPxnX3qeBcellMv+l3mPmnUX99Fr/pnz?=
 =?us-ascii?Q?KytV1K+pDauGMVHBC4mdArppFlhuBRQgNer4sAqN7uN6CallnMRd9BUY8aMF?=
 =?us-ascii?Q?n6hR4USJO4MHx6TeTJwDOvxZNZGwoltkLThPlMvn+eVpDT8wi1fcUrYefoyA?=
 =?us-ascii?Q?oZTC6+Iw293l/h7WxVvAS6wBKz8uMpfrzGYzSDceUTcplgRIXwdk3vLezTre?=
 =?us-ascii?Q?N3DOeJIHU+RuKJSn/WJy5R62a3n70JpHPdSbdADVbFwfCbYUftMj58uBGnW/?=
 =?us-ascii?Q?WVBmq2s7ERGnk1XSiNft2op2P86gpA07PrubNLg0GriEnGEozEg7EPUPaKA8?=
 =?us-ascii?Q?p3z69MW0wBjwqAMs/I6lTJIk3eVpUnvat3caZPEDNrAQ96pCEaA2oTXeXe2y?=
 =?us-ascii?Q?jHFwTklOmS41BQmnutpQzbdRc5dLNJYmZ8liLCzDmvtMkedhh5Hj/lmvD0bv?=
 =?us-ascii?Q?ze0hlPpOgNY3odmtaV9LA1E5qMZje2TPlXExvsqzsrOUlQIAkM1DnslSPf4o?=
 =?us-ascii?Q?czksnRVJ6KlMRdnTMnru7YXdkRIOgmV8B9jyo3NwXLrqBN5zF7HC6WAekCp+?=
 =?us-ascii?Q?34XjfF78y8dRz4B3uR1kSEL2GcdTNvX1daUQ+LgbLO8DXDDboiVRJ7Sneosc?=
 =?us-ascii?Q?ip75bm89CDSZ4QLKbrJfh9tOQHQQG11UjdLcANWf2fNcsVJQe3uKXCHNtsKe?=
 =?us-ascii?Q?WMoa3Np0JjdF9bn0kTNgknsrtUGKo6mcH+7E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qix5ct3cxT+DxkyU6a2XqzSGYDKyhGCuLBg+CX44ydgVS81aYKCdeoHc49OP?=
 =?us-ascii?Q?mLXet50gAxc4dQfUm8XgKPFFmu95PpU+GUUuyfOq0YI7h5hBXr5mPQvkJ4dv?=
 =?us-ascii?Q?sB5iw0saNvgzeVP1xOBXcdecJAXtuymUd3QLmPK0l8ReSvvv6YtcGp4Jfmr4?=
 =?us-ascii?Q?dOziht5xu7YRHNtuqYuV+4TnPVlXStGNXJWyLZ3S4LertSDyrYvHSfYfRw81?=
 =?us-ascii?Q?arvX3t9nTLWPPu3mWRvnECNe9k7sC08HgZk1BPJIL/nigaVmsyQWERvvrxHJ?=
 =?us-ascii?Q?6vj10/FekNvr1CASewXskYgS3By/pfrt2JSfr3gUKZuZlz4aEkRHARFpBsru?=
 =?us-ascii?Q?BLc/iC+aVU3IH7B0Cu05B1+ocSQUJOz/mz0abx0tj1zpBmx/ukZL3De+RM4u?=
 =?us-ascii?Q?EEsWTRE22NTMe7P5tAfz151K4VuAUq3j9L3pzKNRidio39E7F6vmsrIfgzD9?=
 =?us-ascii?Q?dBhmEUY+YrFnrCZVJR/NURDHjMNNh3g31r2e0KZz4mBRuvXRwPKUvQ0oLBDx?=
 =?us-ascii?Q?ygbBuTUbXIObn7oKuG2Co8lSLnUTVbVa3ryxIJD/pWbtCjfgBtBqubvxDK3l?=
 =?us-ascii?Q?nvbiXoSqJWuvx6WNBh08BAXl4ZVolDT6Qf443LINPLnTy5DfiRHQKbDdnPcy?=
 =?us-ascii?Q?PNBlVgRDKQAKAmU0a7Q2Z5DdP1eka33A+S759IOGeF/iXME/dmpw+9t5IPip?=
 =?us-ascii?Q?XBLiGR2IYbBPwfhJQtyOW5A9SGFSvRi4Otbok5Jg+UutwgKqSsvfpUgN4Z1q?=
 =?us-ascii?Q?wh9pAnL2mK7saCEe91Hek+0qNU4O/xEA+6NzT67iiVStfGGMR/kTLAT2GW1X?=
 =?us-ascii?Q?4H0ETTYCFvVEYqqFdmaXyoXTfJqlrpzsEYEYhzlra4mKILaxwiRwj3U0hJls?=
 =?us-ascii?Q?nkJUge4GybvA9uSBBqTdaI+d8VHQu030bZpnxGzBtHStFVOJvdC+hCecvgzK?=
 =?us-ascii?Q?soXcNENKQwRsPhOTbFahMZWviBI6RD3JJ/giNX/fHM3NzdJdXNNjAKBxm6E2?=
 =?us-ascii?Q?70GyjynbkIQWJMD8nfFBPTXTSsN3CSu93ze7hZeJJbBdJQYr1Jo0V9/eswra?=
 =?us-ascii?Q?UKtGZtjvtv5FMxeQ6Z/deSv8iGsO+3mV2DIPWTrMB4dRLl/xr7vAMm6y44x5?=
 =?us-ascii?Q?msh4laavKvvZLKENwyFKXjYoMqz50BoTWq3D9rc9JSA0KEL0t7ZYwqcYdNHS?=
 =?us-ascii?Q?abD71hKgcFEGqa8r9xCselBsukv0/eCfO4THjk3g5jQbrIJBeeDOH1V1dPPF?=
 =?us-ascii?Q?zHycs6eUMG+RelEsXvEimQzOmGFQKrvP9QCsdUE39OHJ39rpmmgb4o+C4eAs?=
 =?us-ascii?Q?Q9ljHbsbpYnH69P2gXjtuhHDfraX8/S19ViybBcf/b9gkgMJNjQenXIR4C7L?=
 =?us-ascii?Q?HUtN41N3fbIQwOK1sa4Mz+U0s5FYPym7Y47U08wAH3TcqXGhkVDL1hNErnBg?=
 =?us-ascii?Q?fjUPVRekZ2zenJGVWYdBavMgQjfH4fZIS1iAZZevPgM2Act8GuJjZaDqzHwj?=
 =?us-ascii?Q?bP4VTp4DDFNpBldpmpsKD4sZklaJyH5pQmhA5bM1tkRkBrOVZIG3eMWDx7V0?=
 =?us-ascii?Q?E8bnUe/pF1lzNygIuLx1AXNo3rdWciLbx1Rs3RtO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0374e114-a394-4c4c-0fc4-08de20732a3c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 16:06:53.8190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZSyjnD9fndht4OVXwB3ajgEkY/KwGrvd6GF0LHVZW+06xr+RxmNqy0sqXkZqGK63E1+j2TVArvwnDNd0Q5o4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10604

On Fri, Nov 07, 2025 at 07:39:55PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Add several wrapper macros for ACQUIRE()/ACQUIRE_ERR() and runtime PM
> usage counter guards introduced recently: pm_runtime_active_try,
> pm_runtime_active_auto_try, pm_runtime_active_try_enabled, and
> pm_runtime_active_auto_try_enabled.
>
> The new macros are simpler and should be more straightforward to use.
> Moreover, they do not expose internal details that are not strictly
> related to the code using the macros.
>
> For example, they can be used for rewriting a piece of code like below:
>
>         ACQUIRE(pm_runtime_active_try, pm)(dev);
>         if ((ret = ACQUIRE_ERR(pm_runtime_active_try, &pm)))
>                 return ret;
>
> in the following way:
>
>         PM_RUNTIME_ACQUIRE(dev);
>         if ((ret = PM_RUNTIME_ACQUIRE_ERR))

Personally, I feel like PM_RUNTIME_ACQUIRE_ERR hide too much informaiton.

There are not clear connection between PM_RUNTIME_ACQUIRE and
PM_RUNTIME_ACQUIRE_ERR. but previous code, the 'pm' is good connector.

Frank
>                 return ret;
>
> If the original code does not care about the specific error code
> returned when attempting to resume the device:
>
>         ACQUIRE(pm_runtime_active_try, pm)(dev);
>         if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
>                 return -ENXIO;
>
> it may be changed like this:
>
>         PM_RUNTIME_ACQUIRE(dev);
>         if (PM_RUNTIME_ACQUIRE_ERR)
>                 return -ENXIO;
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  include/linux/pm_runtime.h |   55 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -637,6 +637,61 @@ DEFINE_GUARD_COND(pm_runtime_active_auto
>  DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
>  		  pm_runtime_resume_and_get(_T), _RET == 0)
>
> +/*
> + * ACQUIRE() wrapper macros for the guards defined above.
> + *
> + * The tagged __PM_RUNTIME_ACQUIRE*() variants are for the cases in which two or
> + * more of these macros are used in the same scope and the tags are necessary to
> + * distinguish the internal guard variables from each other. Don't do that
> + * unless you have to. No, really. If they are needed, using simple tags is
> + * recommended (for example, individual digits or letters).
> + *
> + * The simpler PM_RUNTIME_ACQUIRE*() variants are wrappers around the
> + * corresponding __PM_RUNTIME_ACQUIRE*() that use the underline character
> + * as a (special) tag.  They should be suitable for the vast majority of use
> + * cases.
> + *
> + * Don't mix up PM_RUNTIME_ACQUIRE*() with __PM_RUNTIME_ACQUIRE*() even though
> + * that may work.
> + */
> +#define __PM_RUNTIME_ACQUIRE(dev, tag)	\
> +	ACQUIRE(pm_runtime_active_try, _pm_runtime_guard_var_##tag)(dev)
> +
> +#define PM_RUNTIME_ACQUIRE(dev)	\
> +	__PM_RUNTIME_ACQUIRE(dev, _)
> +
> +#define __PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, tag)	\
> +	ACQUIRE(pm_runtime_active_auto_try, _pm_runtime_guard_var_##tag)(dev)
> +
> +#define PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev)	\
> +	__PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, _)
> +
> +#define __PM_RUNTIME_ACQUIRE_ENABLED(dev, tag)	\
> +	ACQUIRE(pm_runtime_active_try_enabled, _pm_runtime_guard_var_##tag)(dev)
> +
> +#define PM_RUNTIME_ACQUIRE_ENABLED(dev)	\
> +	__PM_RUNTIME_ACQUIRE_ENABLED(dev, _)
> +
> +#define __PM_RUNTIME_ACQUIRE_ENABLED_AUTOSUSPEND(dev, tag)	\
> +	ACQUIRE(pm_runtime_active_auto_try_enabled, _pm_runtime_guard_var_##tag)(dev)
> +
> +#define PM_RUNTIME_ACQUIRE_ENABLED_AUTOSUSPEND(dev)	\
> +	__PM_RUNTIME_ACQUIRE_ENABLED_AUTOSUSPEND(dev, _)
> +
> +/*
> + * ACQUIRE_ERR() wrapper macros for guard pm_runtime_active.
> + *
> + * Always check __PM_RUNTIME_ACQUIRE_ERR() with a matching tag after using one
> + * of the tagged __PM_RUNTIME_ACQUIRE*() macros defined above (yes, it can be
> + * used with any of them) and avoid accessing the given device if it is nonzero.
> + * Analogously, always check PM_RUNTIME_ACQUIRE_ERR after using any of the
> + * simpler PM_RUNTIME_ACQUIRE*() macros.
> + */
> +#define __PM_RUNTIME_ACQUIRE_ERR(tag)	\
> +	ACQUIRE_ERR(pm_runtime_active, &_pm_runtime_guard_var_##tag)
> +
> +#define PM_RUNTIME_ACQUIRE_ERR	__PM_RUNTIME_ACQUIRE_ERR(_)
> +
>  /**
>   * pm_runtime_put_sync - Drop device usage counter and run "idle check" if 0.
>   * @dev: Target device.
>
>
>

