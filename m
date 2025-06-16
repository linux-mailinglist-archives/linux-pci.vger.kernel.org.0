Return-Path: <linux-pci+bounces-29874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B984ADB4ED
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 17:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2CDC7A068A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 15:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A472BEFF9;
	Mon, 16 Jun 2025 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R0ZXBQHj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBE21F0995
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750086356; cv=fail; b=QD4p4Pjs//D/Vd+m+5CT/wXQm4JvT1oaH77EWr6XDPS7WY+XqKbVP7UjvA1hRHRRBRz+vv0CQVlm0bPlXMEx5RMVINjqFWCnQdJ6+M8Z3XbAvLu0VfQqEP144VYEU2DCwLchPj1zgZvvr6DIYKbQJ3MKMq03U8yX6eFZzDIfv0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750086356; c=relaxed/simple;
	bh=hyV+plnM/DZaeMFbMMKjQH+zLiM7s8SEmjGLfH/Re7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TzRAdBIBFyl/6e4R9vLCHdbMf37l2dIvGZXi+3tLrmmv0Gq1gKq9QPNCTdSwnhrIftiGEqHJgQTTkG05ApGC42C6dymQQC54EG+bsyuxG2/0f0paQkjyWuEWJeNZcb93tNa8+l/bn5f27XTGxa0hINiyxPuU9ruL0XWWSPO754o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R0ZXBQHj; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvNu++8PNeoopZyRfhQzG4DSfH5c66cVUqZ/rE5MYNvYVt2zEjqsH+zR9o8onndNrk42C6b2IUgaLEsEqoGLoV2gkSCFzlEKhT2Hiz8whj9oZaKlApSvAuy0l/T7sOxo1hvcr6bNVdcAmdfefEoLcJ4aurIcZJ/c4Kb0goO1f7HXxapJ7oosCHf0A/Icd2lWT2bxoQAklXtc36za2yoKZptvbytTC5qip9/+UM9ZEmcg3dkraLHlwZwED3XODH95xUZ7+foEDcvlOU57svL5JvBBK8Jhsus+APgfJ7Pt2ibmOFYT6Mrt32PhVUByBEIWRiJ29pabYtukh1JeY07ecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvBOxUcce1v31RhkkgHAhl+QTd+LGVfdteRuXzzKht8=;
 b=kp3aFL3sWdAQM13zyoC9o70pPAELy88x21uCWpNqEw0SFGgQ4pQfe8aj/NYNgZCyXvSIdLY12KkGmc5xJAexxozLK8eghLbdAa5YUagTsJMp9pdo5tfRvzarQgKDPEfngxqw+WtMTs+q6Z/Kqnp91X73XAunxYBJMol8/bFQmJyy4IJ4gcfq1JdFn1LYeQqxar4lzStc8+DI3x2G4g3Bl+L99VgPdbCT4EYYdqAU568X5G57zDWppJyNbsmPc+lnaal4UXDLrpbHWU5B5TzBl3D2gW8EYHagN8uX2K4/YlQLnVcUZlwqBwvGUuX1ALhgRF8vDCJx0/IsM2wsnJFs3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvBOxUcce1v31RhkkgHAhl+QTd+LGVfdteRuXzzKht8=;
 b=R0ZXBQHjPtM3u9AZQJG+4p+gSYSL0HRKtAirrfqRyDUHwTuhVdEppfmrVnNaAA14MNmDi+d2mpIm9oK4MSaBJ9vRjVo6kwGZ2+WQx3FbFErfRn8M8RDmbhXY8KBjCg5lf3X0WNuha9/cOZv3jL4bnBBWV8bPi1+B8GICM54XmnmkfubViMQn5bnYlpwtRMhm6sIgAUc1fjplKNfh+cWBr9gV/aT+E3WEii+5H50ca5gQ+qMbrZ1miD01sutkcdW6E8oo4s653+CiZL0W48UdW1k9ZlaFT9rf9dHe6/gQNoA0Qgx7SZ7Q2n9ynWXKwN3zf8nJqMK/WlRv/gr7s0n1RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8)
 by CY5PR12MB6276.namprd12.prod.outlook.com (2603:10b6:930:f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 15:05:52 +0000
Received: from IA0PR12MB8422.namprd12.prod.outlook.com
 ([fe80::50d8:c62d:5338:5650]) by IA0PR12MB8422.namprd12.prod.outlook.com
 ([fe80::50d8:c62d:5338:5650%5]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 15:05:52 +0000
Date: Mon, 16 Jun 2025 10:05:48 -0500
From: Daniel Dadap <ddadap@nvidia.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mario Limonciello <superm1@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mario.limonciello@amd.com, bhelgaas@google.com,
	Thomas Zimmermann <tzimmermann@suse.de>, linux-pci@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH] PCI/VGA: Look at all PCI display devices in VGA arbiter
Message-ID: <aFAyzETfBySFRhQC@ddadap-lakeline.nvidia.com>
References: <20250613203130.GA974345@bhelgaas>
 <5ae2fa88-7144-4dd3-9ac6-58f155b2bc36@kernel.org>
 <aEycaB9Hq5ZLMVaO@ddadap-lakeline.nvidia.com>
 <aE0fFIxCmauAHtNM@wunner.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aE0fFIxCmauAHtNM@wunner.de>
X-ClientProxiedBy: SJ0PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::10) To IA0PR12MB8422.namprd12.prod.outlook.com
 (2603:10b6:208:3de::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8422:EE_|CY5PR12MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: ef83145b-c143-4d00-f3b0-08ddace74905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?52+1koqq4BWFe4lmRLfJiXcs92UDvDpyKATtrQ/w5fdFw+i3aJx0XFTLXVao?=
 =?us-ascii?Q?gnncNGoqu6WZ1RhlGlm6UatdaAei9Sa3GJ8tZy0Ek5MGejMXsj2APvUMLXZf?=
 =?us-ascii?Q?moWx9DpTt4GXMClk1RYPWDgbxUkuXJOgg4p/8gpjdBXWndCCy1DKuk+l9DOc?=
 =?us-ascii?Q?3lEIk7FPpLjzp9cvj8Bay9Ar2IHNrfSG71ZqqMWpjGozKMZiq1LYmvS/WxVG?=
 =?us-ascii?Q?Bc98ff6mTguuvjjcdfIMwtIwz98xEKj6JsNc9nUjHq1hj0/NMHOeFwv72ADF?=
 =?us-ascii?Q?pthjicysT1jK13oYs1b7ctT5hDuh8VVrGgRiNN6dbRJZSVB/TOT91Iwz2VFN?=
 =?us-ascii?Q?K5lRWFahKq+tO3DEAAHGEQumxaE+ztHrkRQjJkQWXhlyC74HKs1ul+dwrwr5?=
 =?us-ascii?Q?u7W3ZmUwEQQx84aSxftzKNEOQ8dDzvRIjspNPKIWSVpJ9rZldD5pEw9aMbWj?=
 =?us-ascii?Q?ThAOkfSTijwq7qIsjpW5pOS/e/2x3CueffFu4kko+dU2P9Qyd82ug1n/R0uD?=
 =?us-ascii?Q?VN+04S3SZDYwev6Du+BCOTyUdr+etgT+sGr4S11MUmZQgiixfhZmUj7W3O3U?=
 =?us-ascii?Q?RsOgdj2RVHe14cXndd/JE0p0OTGFwKKgtvQU+q67U9ajxD0bMo9Im5j+YDl3?=
 =?us-ascii?Q?5Di0Cmx6JEA+7Qvz+6acZjf3FlXuE4Wk42haQrT+LE36GvXO0PuynXK1E9TK?=
 =?us-ascii?Q?JitRxM+xqsB9815PenMyNLxwQhkW5soMv/wmasbnCCB0/kFLaQuqdusML2V2?=
 =?us-ascii?Q?yR4JCkTlaCkOtF3jMix5NNmrP/mgpbfqBbx/xHxbUIa+juKPNic9hJ/ZI92S?=
 =?us-ascii?Q?W/eGmUvITCQTF8Yg//vZpqASX397i9EpmgmcgrdBKy14mSdrTtmKi6c7KY+Y?=
 =?us-ascii?Q?v456ld+DBoHCQen8va8gHIsIZdPfzbkaJt7Jn5QiA5xQyPGdaUgsDRw6SfdO?=
 =?us-ascii?Q?kFShoSbSZbcLyrrHJ5WEdrvH+HwvmFYJYivNxcHI+aJCzCdrBQKtWKQM9Sgw?=
 =?us-ascii?Q?ecKqvfKQKSkahlytyjcVotgAH1UYd2VxvRVlvEhAAy/5IY8nYFTeua01g0qk?=
 =?us-ascii?Q?56kDyILsYX/oEI+6+p3iPJidQwVoIlOGMLefuurXUQ34I9IGKc3n/VTN4Iai?=
 =?us-ascii?Q?7/Iol3zD5c3ZWDgvckJ3rhwOXcmUI3dwqUF8fuQPewViKTdmVLIOIsD0xx2G?=
 =?us-ascii?Q?uFv7ku3LYmDsHp4nsCIi6UsiKmiifV//TNOdZR0zW6JZLu64hqaacHxFE2KB?=
 =?us-ascii?Q?xk9CDETfBszJV8HXWYsY4Vo4dPyIb2IPLKlAWpVOipBPJlBptScA65rIPukl?=
 =?us-ascii?Q?mYcA93HUZb7HjDgm80eE7q4G+82QSLJoaem9YRTP6/fVr699VcU23S3zyjOw?=
 =?us-ascii?Q?/aw7GNyZqtymvtOvr5rqoz/nzgZ5p6MqhCzAu94KvsY3/ZLWWzCDI+P8KD+k?=
 =?us-ascii?Q?toV4XH/oMWE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N/FFAIuHgpK3g6M6Z4+cnPDJJD8yO7+JArrnpqzDPMJ6FPIq0cRdOyFAI/Lp?=
 =?us-ascii?Q?O4nfrwq9gKKxXQLOlD0xW/vEOrUqOG1+VPW99Pfc/FIHugkEL13YpX/m3OUW?=
 =?us-ascii?Q?GGabxmqanUF+Z3WmSkbJEbtj7UhtZtGfAGEDlV14NUIVpANyM0hlhZhu88WT?=
 =?us-ascii?Q?I+rvPTiy3bgAgMCpZJBb3w9B8yFSx2ld0iZiGlDhC65joAZG3f8/2soX0Xy8?=
 =?us-ascii?Q?iRjHKbOQYHt82DZ7z/I5B9qAblbepg9ucpXIuMPgpt0m/yLHonF9NK8Kupaf?=
 =?us-ascii?Q?t/FgOCUvgay1kLHiL7UGaCZ0+mohXTeNkHQk1qk9ODeHagu6iyUZ5V75x6fX?=
 =?us-ascii?Q?wsdkB21M3H/t8Ao9Vq91HUOn170C/NGUjcRwf43JqGHtmz+ewdXpaZiTui0p?=
 =?us-ascii?Q?pnNM7Vi6a6U8tQG9nXmCAne+ZjFUKm81ujXOW+OrF5jtX1HEwr34bDAFuCb5?=
 =?us-ascii?Q?UUHQoC46HZR8pkbqy+TIP4ynEcP56phlgGYng8/snXaVgsFstruQGRW497QW?=
 =?us-ascii?Q?vbOikqPXI78wJnIS7UIiEJUzLag1+GsBQbv2cwmXuHAtd9rGAawxG3pfaxTI?=
 =?us-ascii?Q?izNYuS+0YwZgHMWxItbwUjFEUv7JDpvZZvTE3pfpPEEZQaZXgd5hdOk4ZbF1?=
 =?us-ascii?Q?f5RrLPZlnZ4x/5AJStlc0bbjW8tT6d3OffSOKlPzC6yhrOSUDyLlh/B8dNtY?=
 =?us-ascii?Q?ma3eR694Q4zPEy7tyalAT9FdsfEHBB0p5K8pRuk3SrlOty2TSmrykhMeCO82?=
 =?us-ascii?Q?kauk8p7opKqIPfPkH49A3DKA5k1q7kN3VJdpC2BixLaTGTjIt6LKrtNDXSb4?=
 =?us-ascii?Q?q513tiN1UIbbD5tBfAo4buaT+bQge6Rg5m97F1GDBk5pnwQf9QHOne/JRgK3?=
 =?us-ascii?Q?S8tvA5TtSFsrUQIwUnVKcv/A5tFcaowohwZdNXxTT8SUNvrbo0M6WLqUD2jR?=
 =?us-ascii?Q?EPBPUdiLx7SkLmMAEDTq+8XQInf9ti4i1HrdciN3AujpQiVHwuwpnY66EURG?=
 =?us-ascii?Q?9aeNCwL4wjXvYeigf01ZCcanuA7TBG0E1PsY/JZ9G+7rMtYFlM1Re0sWb1XW?=
 =?us-ascii?Q?mxgqsD3jqYi2ckyzcF16bHU7B5yBPuEJEiG0VsyNvoS3D4cg6J4cIhtke4Dd?=
 =?us-ascii?Q?S//tAhLNPhEhstX0WlD71I+5icqx9RypF82EE59o52m3pidsSFw4g57HlC1s?=
 =?us-ascii?Q?IUhcWjk+6kmFHgI7LYIchDA6lL1EhWt96RTsY0IepETM2D8GVHpW/Ani9794?=
 =?us-ascii?Q?CR8atOsl0gooMbNxD60iq80toVRYdnxGuAPVBSyWE5FbIBnMbqYR0/EPCOSU?=
 =?us-ascii?Q?KzowOvWbVAsBIQ4tHPWyXa23k97JGwT8dehu8aeq2pKl+/q4IPTbx82BaFql?=
 =?us-ascii?Q?7+SAgj3u+CzORPktryYCsurtV3fQft6GYeLkl5BRVx/rwJvL6jUymj4Mmmmj?=
 =?us-ascii?Q?5VJKZGlZgLZDAnJsLz0d1aQk3rYiOp5NLvY1W9XVMAtuhH5INgb62Cf20TdG?=
 =?us-ascii?Q?QxLqXmtReqwCglUQfAXqb1e3migjDAdR9e2LEbJJvAxejnJZpmkSD+cl+JEj?=
 =?us-ascii?Q?p1CF32+5HL8xPbJG0UjiSRAMR0jnCq7eLq0EqVBq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef83145b-c143-4d00-f3b0-08ddace74905
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8422.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 15:05:52.1929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UeuHrX4Nhx4vhFYYCg6PWmjg674allxabwL9TxcO/Fy1xn1jJOdXKmNyntPyakUBdluV+vUplqsqwKfoyAm2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6276

On Sat, Jun 14, 2025 at 09:04:52AM +0200, Lukas Wunner wrote:
> On Fri, Jun 13, 2025 at 04:47:20PM -0500, Daniel Dadap wrote:
> > Ideally we'd be able to actually query which GPU is connected to the panel
> > at the time we're making this determination, but I don't think there's a
> > uniform way to do this at the moment. Selecting the integrated GPU seems
> > like a reasonable heuristic, since I'm not aware of any systems where the
> > internal panel defaults to dGPU connection, since that would defeat the
> > purpose of having a hybrid GPU system in the first place
> 
> Intel-based dual-GPU MacBook Pros boot with the panel switched to the
> dGPU by default.  This is done for Windows compatibility because Apple
> never bothered to implement dynamic GPU switching on Windows.
> 
> The boot firmware can be told to switch the panel to the iGPU via an
> EFI variable, but that's not something the kernel can or should depend on.
> 
> MacBook Pros introduced since 2013/2014 hide the iGPU if the panel is
> switched to the dGPU on boot, but the kernel is now unhiding it since
> 71e49eccdca6.
> 
> I don't pretend to fully understand the consequences of the proposed
> patch, just want to highlight the regression potential on Apple machines
> and probably others.

This is good to know. Is vga_switcheroo initialized by the time the code
in this patch runs? If so, maybe we should query switcheroo to determine
the GPU which is connected to the panel and favor that one, then fall
back to the "iGPU is probably right" heuristic otherwise.

> 
> Thanks,
> 
> Lukas

