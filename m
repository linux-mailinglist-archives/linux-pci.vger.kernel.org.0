Return-Path: <linux-pci+bounces-40940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707B7C4FFEA
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 23:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6AD43A819F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 22:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ACB1D90DF;
	Tue, 11 Nov 2025 22:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hoLOBGC3"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478FE26461F;
	Tue, 11 Nov 2025 22:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901302; cv=fail; b=Qih9lXM84M6pwsVYHbd8ZnFejM0KPgzqBQNPCXbfj+Jkrq88GoroNVBsWAbJk6rwNE6Y1OmJNhjlqm5aJ2lZaTBszghDCBfltblszC994NykNSrGt0x9SCyMt65uaSk/KhRuJoHQTilSxwZKAeteCsQQQlZYXQpMsHW8a11l0vY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901302; c=relaxed/simple;
	bh=Zmkwg6gX1PhXTRgyndYFZiLuk/zS7VgeM+b8+G9Rdqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZCf+iXU/DETmAZ0IQ2R+zbK9JRNcm4BNhyO/7fH/l1ySlazaE3S4rncAzpWADOLratOuydkSME8HonNiIMCLghkV/LHImmbx3NM5QrKl6mDzUvdzFmHH8qYiF2e5+jZ/IS6SxgD6nd6YHZMxgn1GVfis1ZYlY48cJ7kb3DWLitE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hoLOBGC3; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMG33/+hH7XWACdBsazsjRcBngLM0HFv5BCZ9MVzjWe+kD7STuEm062e3fVtXteirXPFLdqy3LRrrf0gfK8ZJsTV8RwSCp/zk2AvbDccGHqo5WJTgfgkDzpAdyD8I8BKUCpNr5zmT3/KUjSDGwGswllQGFr1gEeRWOy/5m34L3JG0rtWSYdTb/Afqlou9Ua7GaWKB5+pI0NuluWnoBkvoPEu8bzlVfiq5tXdeJGWJv0G5l2saqfKeUhsVxt97VVyUQTPh3nCeGd48if6PDCF1SH0Bhr3gNZ8iG4/PveW8a/Zt+F1AyVgnVwNsrKken/FD8panfjua8cdT8PxGV1J7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VH9qf1mpp3mH3CO9iSVlauOYNt8Kk6SkBZx1ajZXmMs=;
 b=ZbYuayC/uTVZpuZzrQyOG573dI5yG+TiSZlHKr7NIWhwvXtkB9TSKfjrWjrlslVoF3qlnlgC/T6mnbrTzjnV63UhBm31d/pJYNb43CvQamfUw7twMSByORC+IegCVJrktoKUftFc+OZEBxIlBv/V+MK6nsuFdj2VQf00Ab+RfMgI12Qw7POJ2IvcCAT1SDDywTssTQ3IEnPN+xr8oiixn8XKHeWiAY3TpNJbIqnnOUbOpd2dT75Tt+oQB5ZKBSaM/7fXv9Xyt3ieOJp8Ns6iv+pSAnN24HJU2nfpl5MDC/JJctiCYUwYj0ZdxQ1VVL1JFx/tyrKO/Bj78jiBP0PHMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH9qf1mpp3mH3CO9iSVlauOYNt8Kk6SkBZx1ajZXmMs=;
 b=hoLOBGC35u2szkvQLvaPdvD7qKv6KXjR+Kr/nO4WRCNAgce+zuSI3zyy1z+ROZjP3gRSwTLz/EBCOveL7UYqekL1CvGT3WSfhCu4M1ncHxg83dmm2ele9CSWL0gUWahOe0Wy1uGuPtmuzZ7B6igTkwFmfGwSLGmKukYbe2+YZN0d9S89DfYZxsNaLaOnTpz2zvS6/xccG9D5WNwWhG+9qyb1jGi29NLofAgIid/ERK3mOhB4h8DtpTtWrys9YHyh/HVlEmbrk0CqHL6vn836MvXbjM/4wSOHI4yZ0TCg9QtIHZ4dCngxxICuK/OLmuwSmTOgrxXLjkqVKc5QTn2CTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB11599.eurprd04.prod.outlook.com (2603:10a6:10:60f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Tue, 11 Nov
 2025 22:48:17 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 22:48:17 +0000
Date: Tue, 11 Nov 2025 17:48:07 -0500
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
Subject: Re: [PATCH 1/4] PCI: dwc: Advertise L1 PM Substates only if driver
 requests it
Message-ID: <aRO9J9ybdseyExYK@lizhi-Precision-Tower-5810>
References: <20251111221621.2208606-1-helgaas@kernel.org>
 <20251111221621.2208606-2-helgaas@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111221621.2208606-2-helgaas@kernel.org>
X-ClientProxiedBy: PH7PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:510:33d::30) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB11599:EE_
X-MS-Office365-Filtering-Correlation-Id: b85104a5-cac9-4352-a656-08de2174674d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H+ZJ4iJhfx8iV0mP9/RQSoNzaZAJ2GyE2tml+pWTSTdS34CLWz6b/FSdHMo0?=
 =?us-ascii?Q?7HomzBWRbE9H+goOOuznoGsIU50w5cmwJpTgLLaaPWo9ph0PzvAocVKYZC60?=
 =?us-ascii?Q?14LikrbCbplDshv2YxN4BUMXZ+3fuRGzgyhCPZ7nZ8QKkWj9RWKqyJOyevJg?=
 =?us-ascii?Q?bh9EyM5KU27aQq/Ok3GluosyKjkKerS4xc/Ay9peDeCFxYVucXPpisZI1/EF?=
 =?us-ascii?Q?/zRyZk8d4ruP2mZsGRcutXuSSSjjuY/wdhWNaw3FbgFgt+Pzru3UJIG32qU6?=
 =?us-ascii?Q?x3ifum3vXdhYLhPUilVs9TwuSZnwSGv7z9UwPPk2/HcOAUR3J1jo32MMwdq+?=
 =?us-ascii?Q?9ozOld4Cc/8g0cY3AKKkHFoLunb3lySSsn+TV471Ld4l4Xwcv27DAnj+q52x?=
 =?us-ascii?Q?1I7lfcEJseA+cBhyo28Z15kgk9uppE29NAzeK1JLVsJHedk9qaiq1txbsBiI?=
 =?us-ascii?Q?LaojMIRJ9xan3YD0bCdq3tObyscdtsdCky0ThygKbHAO7R7n/QBPclvf0Zqv?=
 =?us-ascii?Q?WZ7ORyUwArwG211ZrGp9W2OnrZxUkKr5hZ7Etc5ktf7i05UhF3kuDHIawIxq?=
 =?us-ascii?Q?MfdN5DwX9WmALvhXH1ZsbDEu1NWNIExxI2xIa9g5nSASRXMQcLjNq5/EU/sS?=
 =?us-ascii?Q?kUS9L6EuGZVKQWNrqg7h/hzmC7GEf4DsYSCEgpmAk3hfDsBhhGCrZ6voRl6G?=
 =?us-ascii?Q?u5WvrIY3AO0Y4b6ZJKiqlNWumzaT8qc79Qj6GFG7PHx6b3XJq8zJa9z0KcGr?=
 =?us-ascii?Q?cYvTuEGxOtwXqxrJOvRjzPeQEf+IENAgt8oL2KiudIaid/4+7OoTsvj9kdht?=
 =?us-ascii?Q?lp6GvQD3IBuYZSVbNlUfbqKhw5stHvTafnVNV5XU0tDnYV5tuD1VS4TCzGLs?=
 =?us-ascii?Q?CUfd6dVMu9vugdNYfzurc17GDGmV4byOKKvam/ZXHKPftf3I6gL4YQI1wlNG?=
 =?us-ascii?Q?GGNpJLdvUb7XgO7KTlt6kO13w148NRvR34Hc0Cqz3NzhSCTiAzBAHFencOyZ?=
 =?us-ascii?Q?zLsqwzTFspH7mb+r1YV66wh4K4zPBdtwbLjuSG7K0S4hLYAq58uCCIAaSQJO?=
 =?us-ascii?Q?Zh3XtiygcWBQy1C8iV+HdW1qpvUG5BwnwvOcPg2Qwy/46WNDVnpzxDIrFMx3?=
 =?us-ascii?Q?eMP9kYoFQ8GbfMYrhaxRwLN0tA/+FZJSBe4/xRzV47a+D9lFUY5OkIRVXMp3?=
 =?us-ascii?Q?y/WX4fsG+vqlhTStoowAd953DL9XtBjUI8fASxSNXwyNh0K5A6MIuwJtsdTl?=
 =?us-ascii?Q?fcxdaUJsNKVQhRORz9ijaBuT6BX4Y8pFP8Pvozzj4TyO/sJ/y8go19OmKzA3?=
 =?us-ascii?Q?XnrydUrxuhpDBAOoOvp13XbRqQ7r3rlVRsRky9nvzvyLfvbEQ/vu/VQECVKw?=
 =?us-ascii?Q?nqEi6gBwJ61sqPZE7cUv6a+NP3Bw9Gv6W7F8WOZEVlY2gZNsogkiyCDzc9PF?=
 =?us-ascii?Q?UOn1F6Dl4xLXuSJNpWR57/SVLO+tqgFooj4QgKW5qvS/deJGCO+38Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Eg4KHE/GlMJB+YIGIm4lg1qcfI8Vxqf55qsxWcJ/FFN5ufVOVqgu2jmvEM22?=
 =?us-ascii?Q?2Io8B2/1qB46B5pygoTtbopLMGBySNONzcckbKwBU1+YoHNToQtxAePTnLtf?=
 =?us-ascii?Q?IOAOPEfTxBTli7eDb4+RksRBFg52ZjbZR61dcNuAZq0VgwjnT5f1IREmWi1R?=
 =?us-ascii?Q?GWLkbhALPyslnNZvyYK10Yo4S0jL330r5TlbcJaA3qWPSJN5RKp7MdUH1uBK?=
 =?us-ascii?Q?DCaNtulI4NaHclpN0DV5etBJ56se0+KQo/EwholISxjRz2p/f/uu7yaYfZCL?=
 =?us-ascii?Q?oNnmDEoix3m7BVd5GStgr1qXc4lYrVc74scoqHmdAKyO+OOSypKnBh1RjabN?=
 =?us-ascii?Q?0EtbaJ4DLxko29PfQ5nwIQw61EktYdzxmxJNI6tGmkFIzQj1BGIAmfLPfIhs?=
 =?us-ascii?Q?FnmNItIhvFpnQD7gLg+HlgUgJJ0jzhXP9b9HOGuiYI3xGZlOlU8S+YTl/06h?=
 =?us-ascii?Q?UtFxEi5P9qPg5MyUoRl49L/scfQR6QR//Kditb4KbNyAWQhhPY5YBfMey0iq?=
 =?us-ascii?Q?PRej1L7DPpUKYNSmM/oeYrblNjxU7/mpGnEXKUiRBmZFSnshJsoH7Hw1ZGGS?=
 =?us-ascii?Q?cwfu6YvocDUaPFNVRDIExyMekzzPzW+8wvx++IS3eQvqPaetkXUc5q2TZeH8?=
 =?us-ascii?Q?0bloEd/BYJzt80numye7lEeFoAdJHVzK40Ln07aNlVI5BtHXMgYWroTFHaFi?=
 =?us-ascii?Q?zhMAmdutaTRD5lTPmmeITQDIUvzg3eb+2Q2XwcJvKdfmyEHn+1BLkuGCkoFg?=
 =?us-ascii?Q?u26XoS/jpNmCsyJ2bfGiQo0+HQABglnXSrlaIHzgI4uNOthARdmMh+TPt22j?=
 =?us-ascii?Q?1SGQbcfjIn+a12JSsjsp4iY5zLTHSszlm4oKNJGv9fqBJpkvYIzgu7jZdGie?=
 =?us-ascii?Q?Zd4avS45Q+xIArWotlmD6lB6rpiLAp0RK1Mk4wflAHfhjkaSpYk2JGa+Fmt/?=
 =?us-ascii?Q?zGkMWDF0AXO6u0wmvadSBhqQeHXrecIj5GvZ0H9MF1/l4st1fiZ91n0FEj2j?=
 =?us-ascii?Q?ZGoV3wAxx5DnLYJee9iYXHQMqOQLG1VO9JUx+TZQsg2J06rLznjvReYUHkiF?=
 =?us-ascii?Q?JilKgPJtUBGVtmBhluJXoxziivylpl8iujjdP0efCPkd3o3WKABwSkj0FQF8?=
 =?us-ascii?Q?1IQaTNTyCIFgAAT3xsz1//IJW9qNlwM+lR1Ig/r33Ed4kysoTQAGc6x6eTyy?=
 =?us-ascii?Q?8Cc0JCMWydOH+cLzK6cEjjEwc4PpWokfcQLbg5ZcJjwRauEFCHMWtRJ0jrcz?=
 =?us-ascii?Q?B2JRNSwF9WqWmOF0ysOzG/nGvmUsQiK365ZJ9OKD002NGhOvtw7zbGiIbiLw?=
 =?us-ascii?Q?chimruhAqxoFvFckZB8ItrAbi5XIcHC2K+8yz/eHriWe/8Cu1nzXqvU+tNfE?=
 =?us-ascii?Q?/FfHdrfKXY42njaq5uiglXhFLt0jDIZhFbmE8X1qI++d+djLYoKuo42eHv42?=
 =?us-ascii?Q?vVw2Xg7+XfD8tGfXkLpGIfO7y/ga+bUyHxwHCMvykUzZRgWpqCjdMcaDcsFa?=
 =?us-ascii?Q?5nlysQ5qARiAc+K4Ej37Jme4RtBzbbDZ1V+Neryc/sKqvuM6n6RpzqkYg9La?=
 =?us-ascii?Q?jQgQdkhCgcJkIJrgx8I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85104a5-cac9-4352-a656-08de2174674d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 22:48:16.9318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3B6qfx8+XpgzmSwLZOGhsP8h/UOkgB+MQwcx/K5GndqhLroTSaMWbl4ituPMwLfUFeu2Z6D7qHkEPe50HVbuyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11599

On Tue, Nov 11, 2025 at 04:16:08PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> L1 PM Substates require the CLKREF# signal and may also require
> device-specific support.  If CLKREF# is not supported or driver support is
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
> driver sets "dw_pcie.l1ss_support" to indicate that it knows CLKREF# is
> present and any device-specific configuration has been done.
>
> Set "dw_pcie.l1ss_support" in tegra194 (if DT includes the
> "supports-clkreq' property) and qcom (for 2.7.0 controllers) so they can
> continue to use L1 Substates.
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
...
>
> +void dw_pcie_config_l1ss(struct dw_pcie *pci)
> +{
> +	u16 l1ss;
> +	u32 l1ss_cap;
> +
> +	if (!pci->l1ss_support)

I think when l1ss_support true, need return.
when l1ss_support false, need clean PCI_L1SS_CAP.

Do your logic reverise?

Frank

> +		return;
> +
> +	l1ss = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> +	if (!l1ss)
> +		return;
> +
> +	/*
> +	 * Unless the driver claims "l1ss_support", don't advertise L1 PM
> +	 * Substates because they require CLKREF# and possibly other
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
> index e995f692a1ec..8d14b1fe2280 100644
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
> +void dw_pcie_config_l1ss(struct dw_pcie *pci);
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

