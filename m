Return-Path: <linux-pci+bounces-41546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 605D5C6BD82
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 23:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F4734E17D8
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 22:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0B72F6180;
	Tue, 18 Nov 2025 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iK1eSRHA"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013030.outbound.protection.outlook.com [52.101.72.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27F62E0922;
	Tue, 18 Nov 2025 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763504452; cv=fail; b=DBYDCcApcqXUT/7AHrmpaj1EDpp+aZsGQnRCQV0TCC/Z214EZMLaDHSDq5v/4+m9mjFtggXh6sAznc3eFtAYFB90o/RPN5UblyIifBd5nUKcnOnNEZaoDKgG624JDyNc3rQP0MJaVVk8q37IBbt1o4P77NtGSESGRz1BjOsonCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763504452; c=relaxed/simple;
	bh=R3FHBjXbFKVWTnX4jBT79ncz3KSL6cYyuvS7EtY6lxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UkpGNmYS7tUyNi1nPfj2GgbR3b1hOEr43m7Gf9S3YHjUtAYcd9rFpRCty9JxRZYC/M59RjjXQ8mpDERQn54QCzKsz2lOI7apwg4YSpuM+VU5/KIdjgPYe9eM22L+uQHa8fNMG6mQcDIoWVLt4F/cINLTDizkPHdqmKOuVBkrlU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iK1eSRHA; arc=fail smtp.client-ip=52.101.72.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKADVJC2Z+KQSV2jSo3VXSK1Yi2tMLGbNREG11IG03hjrFZUh/LLlo6G08FBNd8fJprxRdIoERDBCd6eoSAnx5B3N/CG5gHl9WCeA2oCBkMnXbilc7m+s/npar+pjCRTFkoKrNBKNEfpbLoSp4MfDkRBtt4dkZOos/MYr/4dfa3TbCb3v4gOHTSh3YRK1Tht5WSBDM3E/cx7Ce0feYFZ1Kwe5p20in+B1u7yKhyXdndc5i/ihGLO2ktsAFXUVcDESeaSppRmVEj8bf6TiLHCrZkd2s87rAfLwVkxJZ1Bj8OrOYYXuv3KRnkXL3LjNvd0zacl5L6jfmTdY7b/bGc+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHOEvHUPcJHh+ClDJwxyDR77gmCsGy5OdMPMXhA3oOE=;
 b=y+fTgF5oesJU3wcaRy25BPSYgtfSH+RwJTqKpwFUeO5Gq8XEUIw0y3PfsYLtnhMNpoVhPt392Is2dH55tsaOGNGAmxPLeIQx0mLamiDBK/b6fzz5cqpDCmzpnC5K/3FMAKqrk0XacVAbFDKBNEE2yPF8E+t86V5XzwEYEFJUs7dQSu2ZKNfRe7n6bet2vzg5JMfRfChrejqt2/yZtE6Vj22mB/W7DMDPddxHH5R5QracI2sdRzs2clwEUxkCsrkc5q+Tjdx/iV9+1UgPOhBFfK70j16MPbX96o3hP4hAVbLwefdohGrF4/kVgQTwygQNqn3Z/XIRFv4ACgDpV2irdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHOEvHUPcJHh+ClDJwxyDR77gmCsGy5OdMPMXhA3oOE=;
 b=iK1eSRHA0x3OaAM7LXb4IthTQa+z6wvbgzSkgVw/+P8dHeDwEcCcmnoxUjKaQMSjY0AY1OsHeoxLumgFyRUOddUUj733TU7L8dMeGUZIwBH6U92iBqfxxr9jXv7JVCfaTukufd3bZVSQudrcWVOMIUok6sZpNMnvF7Df8KlDrjHEv7ktNQW0GTWB4pVxh3jP2IEBTJ1uq5b7DEavOGmHE+R8RoHYeQUA/4egc4+PGKBmLRjPqc+oGGF88MVIDgZnfTuu38rDDCi/c7b4vNoxoudLE1U07IaZkbHc+4pZmCZw2pxepAZtDPaxwHWapLErOMF1KRYmC3O8Xq9ll04S3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by VI0PR04MB11991.eurprd04.prod.outlook.com (2603:10a6:800:307::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 22:20:46 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 22:20:46 +0000
Date: Tue, 18 Nov 2025 17:20:36 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Hans Zhang <hans.zhang@cixtech.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@pengutronix.de,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/4] PCI: dwc: Advertise L1 PM Substates only if
 driver requests it
Message-ID: <aRzxNMJ+byxZiF3i@lizhi-Precision-Tower-5810>
References: <20251118214312.2598220-1-helgaas@kernel.org>
 <20251118214312.2598220-2-helgaas@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118214312.2598220-2-helgaas@kernel.org>
X-ClientProxiedBy: PH8P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::12) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|VI0PR04MB11991:EE_
X-MS-Office365-Filtering-Correlation-Id: 41173596-5125-4f65-6fe1-08de26f0b8a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0F1pFDkE5xzKvpurjqwrGy3+ue8TN47Sn88YgjsiP6oua1tQxEnezwZd7RmS?=
 =?us-ascii?Q?gvYnjPuIWyFsXxuILxNcqV95VWPxJVB9WHLJbDHIZZidqma4of8doxmD/3n5?=
 =?us-ascii?Q?vAusIsZa8wSZKB40mTNK60FUA4G9+E8k/3z0Js0M5+QQ4AVY0EM6R6LfTD9X?=
 =?us-ascii?Q?szVTd05ysrvV8354+vQ5oLQAMMtZCOWeW7bplYNnxXo3j9SDtfIx88ZYzlR7?=
 =?us-ascii?Q?u/vVVU+GSPjYysjymG01aSGpp5Gb7fSyqDfuymQGrzELfZMIq9RsPUTwBa/H?=
 =?us-ascii?Q?cgwQWakUl1bHwqkHyhmUIujfNpD0vvN86Lm1Q2fnT5WRwSCQmrd3pkyrjDWJ?=
 =?us-ascii?Q?NMkDaNGjSHSox2RQYH2gApSGohGyKBpy8xLd4nwHmwC4AjTh/rX98sXHIrRK?=
 =?us-ascii?Q?I4JGldeu0oWuOA20ftR2PZOBsr5dI++o7FQ7zwJHxtF5Eok5Mqo5xeBZdQ9s?=
 =?us-ascii?Q?kpimV4uDMrjqb36ND9Yu9QjEN4aq6AO0p419HRMPkB1/HXWrI9ufx3jUVWLz?=
 =?us-ascii?Q?s5Sq5eKDswH3asqMQ9GjpnxVBEUSI0ALwApxI0+ps+8SS6zkc6PexEGrzBE1?=
 =?us-ascii?Q?NQauqyZZNAtEwAHxrr+P6xMxtIbM5agOUKhb/QwuQ1BaJyvU7swT+AyKHFc4?=
 =?us-ascii?Q?EIJaWNNO3ZwaPVeWLcFDFnjuVHgyfTbFauYBXD301g8RkXm4Xod9MoNciNBs?=
 =?us-ascii?Q?azAa1NAp4tH7DWf93UZMtcGfzUh47FT7UUF1eh4sq9w0sGbO4lWjozjz7O83?=
 =?us-ascii?Q?6+GGrYNXBySHzYMtUTX4ouni68YZnj4yAY7NAHkIQoklqH5S+39XGWQMeMrQ?=
 =?us-ascii?Q?2+Cvgh1ty5J8dmvm+HiKcb4AH4Mo5/y4mGsQXi2AvmG/La7+i+wEfnNdASph?=
 =?us-ascii?Q?7zvFL64efd1H7P4CxnjiZaIJpnP4f1MDdlI0Z84A+HWGmaEeuKLgJ4/dZ8HI?=
 =?us-ascii?Q?qdP0m1bWx8BdaVT9zuAz6iVHcxLd5oOH9Hpnf+ZQ1pkJF+mTWRne7Idd3jeS?=
 =?us-ascii?Q?dAmd0HBkSCZX5bVJzK58m2v4SAydVZKSKPg72zl0sbI4e3+ae/Ip3gLqpt7D?=
 =?us-ascii?Q?WFooFtT7azjlD8bxDDblCrFpOQEjWI1y3RlupHceprT7YRNKwpdf0D8k3nUA?=
 =?us-ascii?Q?+NWhyHRIiVo9NFjvtTHGd66OKRiVbY0hUOcJGWBjgEmCTmJ7xT3LQpP2Eaeo?=
 =?us-ascii?Q?Eobut4ux/2TMVRqEE1UCHj/Bo+1329fsCKpzLkhwDEnuCsdFhFz5Mk8HcP+j?=
 =?us-ascii?Q?ajAeezk4PeDcIS8rj67mLXxvaAOMh7Z216rpmJXcOFA3Cvk3wjNT+jYkjF/8?=
 =?us-ascii?Q?T/wMIybj+utW9Jb/IFZmexdSK5KjcNKhpJs4FPd1kqqc0EiDQJ4/xzrTlnb6?=
 =?us-ascii?Q?i/MIQwHyK/WKVGXq/0rqy0OrEYNp3EBoSz9EtjlycPjthU4QTHJ5dlRum4QP?=
 =?us-ascii?Q?KzyZNytTvumlngIY9vnONHu+8z41O4Yq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2uhNJqTARQGoS4w2NBSVP3KVqW12h8C6IV3o+j35j7abowkkOdse5nObV7Vr?=
 =?us-ascii?Q?3jX5UAFjHGjMFcc09BF2fIGsSlp12uru1goRecQR1RYAoyvGim7I9eacVdpb?=
 =?us-ascii?Q?zXmi64wrhYXrbkPZ0IyfpLlhfCSKDZ5Mt0kwZVXAH+du7G1r+VAdvKvmZtgr?=
 =?us-ascii?Q?2ceLnOGyLEYV8GRumj566wMnoTvo5cki4FQ16M2ktgtE2nL9xa34/5tEz30W?=
 =?us-ascii?Q?LwGxtG9q7bQcHemtcWk1wAgrlBEereJEuFx7b/LTveRKBf6eaxfLOcAqet9X?=
 =?us-ascii?Q?sqIuhS6y42p1hSr1JAM4zVnQDXfetIOrcQCz4ZvIFShQcGe/oM1yujw0G5RQ?=
 =?us-ascii?Q?1Y2Idtl/syPvzBHZjQScUelyQst7B/K2y7eTokAwLmQfnVvL9UY5+GARr0rB?=
 =?us-ascii?Q?FicuSmzdXOUE3iPoc7e2z/Qdww9khFRk5ef3c71dRXNLGwm9oytDD6Skmmk1?=
 =?us-ascii?Q?TuXPLpJQzkVeVrfI8OblzbybgiuISgu2H47wkgoiwA6XLm4J9KU8DytVgPXV?=
 =?us-ascii?Q?szqRBkKFWvuLN3b86xQ0tEXp30QDLa0uWNIWgJVUuoufKSObXBsQx1Fo1C5I?=
 =?us-ascii?Q?FO9gzAg06wj70pSqAxyFID73A/DZ4VDfFktBuVSDGBtUtGUvTIsWYihxfhoU?=
 =?us-ascii?Q?YlQ5Ma8qSnxB2IuwBPCakbavEc9QHey8Ef0Y5R2Z6/1zDMBRpdAhO8otSatX?=
 =?us-ascii?Q?x5bw35wjCi9MCf1WvhmiRtaNsqnXULNCWzOozTpsB9Ey9S+xOuJ2MeYh8TDg?=
 =?us-ascii?Q?xDi0QXhKb77Z0TSVST7+bVVZjBly6JTSTf6i/8oVfg9eGHeMDhcrVwrxLJAU?=
 =?us-ascii?Q?MULkc/d4VwEaH5vF+eqISkfT1qEeHHK3UANBRJDQVj77Kgr51PYqTzDhbNuK?=
 =?us-ascii?Q?Hug1sqcj7tHOYXJ5m+P2fYD77kOkTzFrJevfqJp2+KXtSQZLi2ZXzywXJ6/d?=
 =?us-ascii?Q?FA4eUiLhGHZM1zWJ+qsv1KtldB9x6p7UW+/zjuiBHcB3d/mjV0YPp8YuSzRu?=
 =?us-ascii?Q?GpCoMY2R6AqPuUtsIcOgTDTlL7JNl30xmm9KqUz8sJbnJBA6yvew2JnAJTsx?=
 =?us-ascii?Q?JxqmEtUghsN1h26kRBtcJAHxpazxTwa4LJmB75GAwrvOR3UZS19T3msbf/b4?=
 =?us-ascii?Q?jF8XqHYVwULkyvNU5MRPZErd1uWtRDPZeqV3U6iKoFYtu4TgtZWNZuIFZvo5?=
 =?us-ascii?Q?8lUq71uZHuQsY9LX0EznRV1XxB4YQ9RHTPeugysO+sImQi55AjX7lPr2KVtE?=
 =?us-ascii?Q?UAVokt4zP8CHrdjhL1uHY4f1sSdBYUcH/fWS62PkfKkHqQ6SEWl3hcRYXVWa?=
 =?us-ascii?Q?urbpwKlgNSao0kMWTROR9hq30TA5eXoP6z4zRUijurMhalKQC4n8mX4/o7SB?=
 =?us-ascii?Q?kFSKTD5n+5af+vAlU/dRKKGC18VTAxqp99IwyeP8AeE8C1MsSJ8CN6MTsykZ?=
 =?us-ascii?Q?eJLONJchLnDL65trjPgz5FvJp1O9eiiqsJu7dzcqwaC8Kqz0faTvY5+ol3fF?=
 =?us-ascii?Q?91owjgFSt+I2NKy1GnzIJ3fqF/eFW3hm+eltC6EYVsfd517b0fZv5toWxM5y?=
 =?us-ascii?Q?Mx0zOt97fR7zEnJ7pXEir8Nmr56LRfRA3GZmaV/a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41173596-5125-4f65-6fe1-08de26f0b8a0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 22:20:46.6376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lO7q7eiUuKce/hf2jkOdKVhXu1mvnT0S+ka0eXt2ZAyo6tDcrSwJ/61SLiJ7P9w+sdSA5hjIyGEmeNmAEdgngw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11991

On Tue, Nov 18, 2025 at 03:42:15PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> L1 PM Substates require the CLKREQ# signal and may also require
> device-specific support.  If CLKREQ# is not supported or driver support is
> lacking, enabling L1.1 or L1.2 may cause errors when accessing devices,
> e.g.,
>
>   nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
>
> If the kernel is built with CONFIG_PCIEASPM_POWER_SUPERSAVE=y or users
> enable L1.x via sysfs, users may trip over these errors even if L1
> Substates haven't been enabled by firmware or the driver.
>
> To prevent such errors, disable advertising the L1 PM Substates unless the
> driver sets "dw_pcie.l1ss_support" to indicate that it knows CLKREQ# is
> present and any device-specific configuration has been done.
>
> Set "dw_pcie.l1ss_support" in tegra194 (if DT includes the
> "supports-clkreq' property) and qcom (for cfg_2_7_0, cfg_1_9_0, cfg_1_34_0,
> and cfg_sc8280xp controllers) so they can continue to use L1 Substates.
>
> Based on Niklas's patch:
> https://patch.msgid.link/20251017163252.598812-2-cassel@kernel.org
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   |  2 ++
>  .../pci/controller/dwc/pcie-designware-host.c |  2 ++
>  drivers/pci/controller/dwc/pcie-designware.c  | 24 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  |  2 ++
>  drivers/pci/controller/dwc/pcie-qcom.c        |  2 ++
>  drivers/pci/controller/dwc/pcie-tegra194.c    |  3 +++
>  6 files changed, 35 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 7f2112c2fb21..ad6c0fd67a65 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -966,6 +966,8 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
>  	if (ep->ops->init)
>  		ep->ops->init(ep);
>
> +	dw_pcie_hide_unsupported_l1ss(pci);
> +

Need call dw_pcie_dbi_ro_wr_en(pci) to access PCI_L1SS_CAP.

just ref below code

	/*
         * PTM responder capability can be disabled only after disabling
         * PTM root capability.
         */
        if (ptm_cap_base) {
                dw_pcie_dbi_ro_wr_en(pci);
                reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
                reg &= ~PCI_PTM_CAP_ROOT;
                dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);

                reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
                reg &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
                dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
                dw_pcie_dbi_ro_wr_dis(pci);
        }

Frank


>  	ptm_cap_base = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
>
>  	/*
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20c9333bcb1c..7abeb771e32d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1060,6 +1060,8 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
>  	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
>
> +	dw_pcie_hide_unsupported_l1ss(pci);
> +
>  	dw_pcie_config_presets(pp);
>  	/*
>  	 * If the platform provides its own child bus config accesses, it means
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index c644216995f6..6e6a0dac5b53 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -1081,6 +1081,30 @@ void dw_pcie_edma_remove(struct dw_pcie *pci)
>  	dw_edma_remove(&pci->edma);
>  }
>
> +void dw_pcie_hide_unsupported_l1ss(struct dw_pcie *pci)
> +{
> +	u16 l1ss;
> +	u32 l1ss_cap;
> +
> +	if (pci->l1ss_support)
> +		return;
> +
> +	l1ss = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> +	if (!l1ss)
> +		return;
> +
> +	/*
> +	 * Unless the driver claims "l1ss_support", don't advertise L1 PM
> +	 * Substates because they require CLKREQ# and possibly other
> +	 * device-specific configuration.
> +	 */
> +	l1ss_cap = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
> +	l1ss_cap &= ~(PCI_L1SS_CAP_PCIPM_L1_1 | PCI_L1SS_CAP_ASPM_L1_1 |
> +		      PCI_L1SS_CAP_PCIPM_L1_2 | PCI_L1SS_CAP_ASPM_L1_2 |
> +		      PCI_L1SS_CAP_L1_PM_SS);
> +	dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, l1ss_cap);
> +}
> +
>  void dw_pcie_setup(struct dw_pcie *pci)
>  {
>  	u32 val;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index e995f692a1ec..a68eea47d451 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -516,6 +516,7 @@ struct dw_pcie {
>  	int			max_link_speed;
>  	u8			n_fts[2];
>  	struct dw_edma_chip	edma;
> +	bool			l1ss_support;	/* L1 PM Substates support */
>  	struct clk_bulk_data	app_clks[DW_PCIE_NUM_APP_CLKS];
>  	struct clk_bulk_data	core_clks[DW_PCIE_NUM_CORE_CLKS];
>  	struct reset_control_bulk_data	app_rsts[DW_PCIE_NUM_APP_RSTS];
> @@ -573,6 +574,7 @@ int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
>  				int type, u64 parent_bus_addr,
>  				u8 bar, size_t size);
>  void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
> +void dw_pcie_hide_unsupported_l1ss(struct dw_pcie *pci);
>  void dw_pcie_setup(struct dw_pcie *pci);
>  void dw_pcie_iatu_detect(struct dw_pcie *pci);
>  int dw_pcie_edma_detect(struct dw_pcie *pci);
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 805edbbfe7eb..61c2f4e2f74d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1067,6 +1067,8 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  	val &= ~REQ_NOT_ENTR_L1;
>  	writel(val, pcie->parf + PARF_PM_CTRL);
>
> +	pci->l1ss_support = true;
> +
>  	val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
>  	val |= EN;
>  	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 10e74458e667..3934757baa30 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -703,6 +703,9 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
>  	val |= (pcie->aspm_pwr_on_t << 19);
>  	dw_pcie_writel_dbi(pci, pcie->cfg_link_cap_l1sub, val);
>
> +	if (pcie->supports_clkreq)
> +		pci->l1ss_support = true;
> +
>  	/* Program L0s and L1 entrance latencies */
>  	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
>  	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
> --
> 2.43.0
>

