Return-Path: <linux-pci+bounces-25265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1107BA7B198
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 23:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6987D1884F74
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 21:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045ED74059;
	Thu,  3 Apr 2025 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NrQbevuy"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013058.outbound.protection.outlook.com [40.107.162.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5896C2E62BB
	for <linux-pci@vger.kernel.org>; Thu,  3 Apr 2025 21:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743716739; cv=fail; b=c0b82QVBJrb0C8NKXhg1coL7hn/HA59p1U9DoNASfDlUbkUSG5Z97WiyafpnRZt+GCWvIVZl/Kw/BfpLWaIYTEFWePEamWJB3/A6sgpHZopNfHIJS8J4PJsKd11J3yFgs2tT6Z+8Cp/NHPkKczDI40RxNHSnu9KYSSknm6xzbb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743716739; c=relaxed/simple;
	bh=B26nA6s512CsgMWFIAv9UcNJrEjJ4EN3fyMR7epkRnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sOrPX7qR2vvZ2gLEFj3ZdBSELWxhaYGcYrp548UNgT5D/w1OyEnUgwY5TX6B+cNyPzpeEEmrrY2VBVMw/c6wQBrSe6E1u6ul6dyIitC9myM+aUs2Z088YAaajLmEh/O57xVby6g5PkQ+5XBBcio4g3q8kVS8XRh+rxZfNNLUczQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NrQbevuy; arc=fail smtp.client-ip=40.107.162.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUOzio5/HVLbZDrLhvFFDOUKq5RoDzz/D48S6fWZaUF87yXhr8GvrFYPSlOh5P8swXUy90IsUzz2wAzwowqIi79LymeWk75QSZ9FvPHjDaWI6VqdXxbBZu63IqSW2zaRICqGglydYQbbiOn1rpLrEJEggTbVjlOwWNU2EGhHLOFshuiEXtZPY5oqEXwNU2gENf24JDN52b7E+7Mmd8HOVTioYCJ8v0kQmHTU2NxKJMOdj/DpGylTS4EBaS1qMqGSMxHixnKaR/bx1GCzAKArcZfx21no9mYDDVLNx3jtxkOLm8Kx1Bg7sZXW25aUQtg7vfPpzqsDLQzkd6syhETf5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B26nA6s512CsgMWFIAv9UcNJrEjJ4EN3fyMR7epkRnA=;
 b=V5JcpIJCwq1RCF5YD8JoK6JzM5vUp/UHX3mfp4ufL3hPnMPIJUbLb3BcBGbrG2APA0Uz3qt2vycxV5hVQdh9iyNEn97gjdOZ3zmz+EmLlqSTLAAxL+1WYI5LFpEPzua0GYOoYCVtzjRziMCRcA5dD069qXr/DmZdtfenZQ/6SW69sNQ191dXsbdukFkksTbTzFMQABc05usvceW8RzJygCu6qyRENu9J0kFtCy/Nv3h879MXV160fWxf88UYbM71IJihRwAnZx0a1im2EnfihTozOS0VOH9nLdfZHjg6zarZ0jurrkcYbeMS3nqSCzEh0N/paMy7eoPtgQAAIxiwwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B26nA6s512CsgMWFIAv9UcNJrEjJ4EN3fyMR7epkRnA=;
 b=NrQbevuyTJ9lvEzqSTTnBJcJVdXQq2ZcANvtgEhNyYYdtlDWvqHuYKvSriDepUf4DLNC523puLZ4CImFx4WG+vJmTekIn8gwKgvzSVJRxJufoR6r8graLrMUpCmd0owu0Pgwws/OtfIx717xpg4P2SqOdiBBHGuciAACm1sQl2zrPNd2LzUQDIHOJnSPjGOgu5+PFGhuwLdFW7NOP7L0MckiaHimU46JAIEIg02ZfCg633EVah4EnwOTY6WhAtaafO9Qp64bs6UymelNZY2BcR4Ef9GXDP5CHRcRkMzXWDAJKz3UQ3lJYsmvFGxSHNcGcYH0/q0tLSXZBR4Ojj9ePQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Thu, 3 Apr
 2025 21:45:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8534.048; Thu, 3 Apr 2025
 21:45:34 +0000
Date: Thu, 3 Apr 2025 17:45:26 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, manivannan.sadhasivam@linaro.org,
	linux-pci@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH] misc: pci_endpoint_test: Defer IRQ allocation until
 ioctl(PCITEST_SET_IRQTYPE)
Message-ID: <Z+8BdkOja+WyNst6@lizhi-Precision-Tower-5810>
References: <20250402085659.4033434-2-cassel@kernel.org>
 <Z+2XjBd1wQezRlNv@lizhi-Precision-Tower-5810>
 <1AB85045-9BBE-47B8-9643-487D82E28877@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1AB85045-9BBE-47B8-9643-487D82E28877@kernel.org>
X-ClientProxiedBy: PH0PR07CA0054.namprd07.prod.outlook.com
 (2603:10b6:510:e::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d0f2e9-2fee-4734-efc0-08dd72f8dcfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8IPiwCVS/UeTumLtlThjYKB+Tnj7xpVB7SdLJFK/sZYvbzHDlcq4erMvOdGr?=
 =?us-ascii?Q?XfLhXvRuBJpUuk0MtzEG/MaFVUkraLJcY/0rjvqpjMJkVGfe2k+xsgBt9Nbv?=
 =?us-ascii?Q?IRPtfFOEkztZN0pu+u0wG0VMuYVdUA8fqx2HK3lO9RMTPB9T+3O/DNxVrfQH?=
 =?us-ascii?Q?lq3ia1xNxb0foacQ7vDatgAm5p7FpAV7CRaUP1HHWpKmZAuKPU9jfL6cSEnv?=
 =?us-ascii?Q?NiBsI7JC4F5/0aEfA8zfc/aZFs36Zo1uu1lhpZXo4TTA13xXurTYB+4pkNoE?=
 =?us-ascii?Q?guJSuRAl6HJjTADuUo0FXU31qsLkRw9HyCDwQ99Ties2AzgbpVUsT30sN3Z0?=
 =?us-ascii?Q?LAY9h9OBiXEl2MCJr6FEFpuCEQUpokewuxyAVAqWswI6j3r6fM/lokpVMK8N?=
 =?us-ascii?Q?wI9NqIRtFBShxfEW0vqEFYLHlLFNzjtrttHcbqW0wc8v77MDEoMciJeZ/ETI?=
 =?us-ascii?Q?l6M06xKf3yUNi3DMRijTD3fnjPExPjSmt/eG2kWDfsN9uCfHuA7RaeNnz6Ki?=
 =?us-ascii?Q?mMO3wYFohmQR/BAzqWnbC2Cad6LhY/6tYQSVxxCqXZs3xTANhTN3jdtrJr9w?=
 =?us-ascii?Q?yimnwngit8SrEWfe3T+tCGV1oMy/FTpse/vNFbETp6M8at6iyeCyvX/E3eBY?=
 =?us-ascii?Q?OtEPf2klNgzpYRvz5IA1vyihLsUJG/c1pXiPJ2FsUDXFRGk/kDeZ/0FaOyqY?=
 =?us-ascii?Q?ZK/5m50Jw/W1zsl1XcNz1fPMzUsZrhk1vy38MYNEOctpE6QeffvZZDJREw2z?=
 =?us-ascii?Q?8/+7ItHrEWBV3moOB3XlxLiPQez56Js0WXtK3hfk8BC+bGG7HhIiKXPTjF8C?=
 =?us-ascii?Q?jNbDNo9S5jvXkiKJTWsYg2jCIIvSoxLlERdiuizWTAOjtlRXk+uHF21aCLQz?=
 =?us-ascii?Q?grbQvlxn39T4DS2R4O73wBOgQ9TuOloWCY1Pjw/IOio9PyCzsN69dS3X2VXl?=
 =?us-ascii?Q?Jxl6VvZZJgsTwOawNQbhyHS5hzqFGPq6I7F1iRhDx7QkZ7eMT3KUzQPN4ggm?=
 =?us-ascii?Q?x7xNjOrrxz2uKY1r8mUQoLmJbGclOgTPL03p5LIXn5fUIixbVb9bfMPVJvut?=
 =?us-ascii?Q?7hKCRuYiUi+lpdmVfIACTzRX/pf1AzE2JQPd6Wkaf2zSX4d+Wr5RU6dVW/wf?=
 =?us-ascii?Q?5s74In6jrRJVjshVH9WXoPDnkZDkw4O3tkp1DwGqYacy9byB4RXrYzPk857M?=
 =?us-ascii?Q?lxOxrJBY+UEX149j9b/zPUhhdA39aJ2ZJ/ostpq/ATjuWkotgf6IGpsDZsYU?=
 =?us-ascii?Q?wtLejAqvqPHX7ST+L5LwTzmPZZfYV4N98o3MJ4tRktveEUFO46TSRv/DsHdG?=
 =?us-ascii?Q?a2sUZBmJKtjZvOIal3FIJvhm4E5pdBUBS9cv8CncbQm1kJEDoJTB4vdO7a5n?=
 =?us-ascii?Q?SLurUhuihl8CFnL7yIlRRPE2sX2tdPkCbqAWZmWMbLxXbJp5gQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SS151Nypf+vVDoY8UD91Qx+Qw/JxbqeXH+UKn6RSN6z8GxOOwasWfv3Fbazs?=
 =?us-ascii?Q?mKusgpTPrbfpe2ciSlTVTxvYBbhd+6iwMd2/a7jlw70EyxMALF3bicA2zOoT?=
 =?us-ascii?Q?j9FDOwBJ7zytdmbMcaupjkb5g5LnW7F5Ok+VN6CATIBisnEZ2Z0rRsRyJXDf?=
 =?us-ascii?Q?KS4elN0z+OkT6F0tJhYnPQIi3qY4iZjbhgg40CTlyOxXoe/70y+LxNR0k558?=
 =?us-ascii?Q?6x1g/kI+UMob7f25iWQ6vhx/KuB7ZEOjjX3Uj1J7y6AHbN8ReSPmPWkTg+Zj?=
 =?us-ascii?Q?vFZIS8amDVr+iYwomwHAPlVocOCqXhpHd3+QsMIWlcKhLhFl5/yGCAtHyB9I?=
 =?us-ascii?Q?8BW5M309VY16Pz2S92LHpx5F+gCgAdG/XkBgcpMNUlTxukynP7D3TX1vkjoL?=
 =?us-ascii?Q?WPZBzy7q3SZ8dp22TibWe4ePEkyW+nBTsTUNo/Qr3Pr0xC2+XpnMTgTjMS0f?=
 =?us-ascii?Q?XiYHOn1hitO+z+FLEGEAsZT5cGQKFURdD/rZbypWT+r2ugJ7lHEe6a0+hxuH?=
 =?us-ascii?Q?3LxYlsAfjE8s5IFQjmJx5X2fHlRY9gCs3SuMJmqT56lnlQeKYYascdK7S0rk?=
 =?us-ascii?Q?TKOSxOM0c1syvzguyE7reLvjRZ7ZDmUUTQYz6mmm+ptil9VGt4Q98E48pqvb?=
 =?us-ascii?Q?WEp9ZxOpGs9vubdPpKg4BaRyGPLqWNAhyoFkQOAE0VMuQJgubIl/P6Lms9lZ?=
 =?us-ascii?Q?2SeirJ69QcNhyxU7ANehovOz7iEIPH5xkB/4CwKiXvg7J7Mx9+M/0HJvORGr?=
 =?us-ascii?Q?gXmns60U1A/oB7sSb8clZ9iHfP9lrv05zzqueOn5TVoTw+uTMemEewd/VZKm?=
 =?us-ascii?Q?BAcB2mHXHuO8sDW8fZt40aaOsuLc+zmauNxtZJFeZUPCJqsJyVobNIOa9E9X?=
 =?us-ascii?Q?Hd6VMmcQIubjVQz33g8PLHqpgqwfDDGkRcXfBPl/fTdGOp0Z6ySRPt3R9qWJ?=
 =?us-ascii?Q?+1Kzymz4+CExP+UQhBEFRQhlwiNKr84u2nfRWyZB4MY27wFXYu8AfhHD9fH7?=
 =?us-ascii?Q?HxGSNd4nJ2vNjJLg0IZHLK48alQ02Jwu6f8sZLAKHkHKoS8aq+97YFmjZRyu?=
 =?us-ascii?Q?kcrjhbBe9VeJrVWEzrzdaenFeD7J3jUPnXvJVkzwZ3UOSQ6EPYDJ7wme1DvB?=
 =?us-ascii?Q?Iad8AMJl5yCsWX/wNCuiZlc1yvhg+TUnz2j7wySyfAU1EWHxVJKyy445MjYe?=
 =?us-ascii?Q?gjhVXELcNTyCqJQinCa1kdHrFaFMrmbV1c7MkAg6qUunPy2gGwny4kIv+Tvx?=
 =?us-ascii?Q?7MNOwrPgsLwXJjiTYluK0RqZ5Rw1AWAnf53Un0IM+N7y9Z4SSSUPDm9hH+yy?=
 =?us-ascii?Q?m7JCLw7kQMHSrAlLqe0BIDlYT5EXDV4Su6MhDsiXrBt/kK/5hdjKdyrf/If+?=
 =?us-ascii?Q?CFuWZeaQuSpqpse0p7jCzTOzRZnsmsKZVJBZDY4e4/MmPYjzT5JOUS30z2zt?=
 =?us-ascii?Q?MGyuPkanGoqyHdMLQbyJq+rdGQfjfSzR6VHJj5A44aHp7dvWpTxeUtHuqJDX?=
 =?us-ascii?Q?11w7HCyyy5TOTtE86cVr0sqgxyVyV2BAsJZ7TLBFRPRiCDaz/398QjFoAOww?=
 =?us-ascii?Q?vC0k+PFauyoY3tBqUqdxnZ5evUkSo2M/oZybvrFJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d0f2e9-2fee-4734-efc0-08dd72f8dcfc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 21:45:34.4429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUMo2TLQkvgTCsJtNfLQRlfYvr3rsO1qGNzU2d2lDavGRO3bAmHB7qZYUcoRfo1eUKtEUOhXKS36Ui5h0BKRAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7930

On Thu, Apr 03, 2025 at 12:44:28AM +0200, Niklas Cassel wrote:
>
>
> On 2 April 2025 22:01:16 CEST, Frank Li <Frank.li@nxp.com> wrote:
> >On Wed, Apr 02, 2025 at 10:57:00AM +0200, Niklas Cassel wrote:
> >> Commit a402006d48a9 ("misc: pci_endpoint_test: Remove global 'irq_type'
> >> and 'no_msi'") changed so that the default IRQ vector requested by
> >> pci_endpoint_test_probe() was no longer the module param 'irq_type',
> >> but instead test->irq_type. test->irq_type is by default
> >> IRQ_TYPE_UNDEFINED (until someone calls ioctl(PCITEST_SET_IRQTYPE)).
> >>
> >> However, the commit also changed so that after initializing test->irq_type
> >> to IRQ_TYPE_UNDEFINED, it also overrides it with driver_data->irq_type, if
> >> the PCI device and vendor ID provides driver_data.
> >>
> >> This causes a regression for PCI device and vendor IDs that do not provide
> >> driver_data, and the driver now fails to probe on such platforms.
> >>
> >> Considering that the pci endpoint selftests and the old pcitest always
> >> call ioctl(PCITEST_SET_IRQTYPE)
> >
> >Maybe my pcitest is too old. "pcitest -r" have not call ioctl(PCITEST_SET_IRQTYPE).
> >I need run "pcitest -i 1" firstly. It'd better remove pcitest information
> >because pcitest already was removed from git tree. and now pcitest always
> >show NOT OKAY.
>
> If you are on an old version, the return value from the ioctls have been inverted by Mani:
>
> https://github.com/torvalds/linux/commit/f26d37ee9bda938e968d0e11ba1f8f1588b2a135
>
> But you should use the pci endpoint selftest, or the pcitest.sh shell script.
>
> Both the pci endpoint selftest and the pcitest.sh shell script always do ioctl(PCITEST_SET_IRQTYPE) before doing a read/write/copy test.
>
> Like you said, pcitest and the matching pcitest.sh shell script have been removed, so I suggest using the selftest.
>
>
> >
> >> before performing any test that requires
> >> IRQs, simply remove the allocation of IRQs in pci_endpoint_test_probe(),
> >> and defer it until ioctl(PCITEST_SET_IRQTYPE) has been called.
> >>
> >> A positive side effect of this is that even if the endpoint controller has
> >> issues with IRQs, the user can do still do all the tests/ioctls() that do
> >> not require working IRQs, e.g. PCITEST_BAR and PCITEST_BARS.
> >>
> >> This also means that we can remove the now unused irq_type from
> >> driver_data. The irq_type will always be the one configured by the user
> >> using ioctl(PCITEST_SET_IRQTYPE). (A user that does not know, or care
> >> which irq_type that is used, can use PCITEST_IRQ_TYPE_AUTO. This has
> >> superseded the need for a default irq_type in driver_data.)
> >
> >But you remove "irq_type" at driver_data, does it means PCITEST_IRQ_TYPE_AUTO
> >will not be supported?
>
> It is supported by the selftest.
> It is not supported by pcitest since it has been removed from the tree.
>
> driver_data was just specifying the default IRQ type, but that IRQ type was always overriden using ioctl(PCITEST_SET_IRQTYPE) before a read/write/copy/test by the pcitest.sh shell script and the selftest, so the IRQ type in driver_data was quite pointless.

Okay,

Reviewed-and-tested-by: Frank Li <Frank.Li@nxp.com>

>
>
> Kind regards,
> Niklas

