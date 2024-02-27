Return-Path: <linux-pci+bounces-4142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79775869DAE
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 18:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52841F26AFB
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 17:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA911448C7;
	Tue, 27 Feb 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KoNnq2XM"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3E24CB4B;
	Tue, 27 Feb 2024 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054939; cv=fail; b=lDq1uDoA3R65B5lv5mAUWPhfmB0We8vuFVe1DNPrM69oFxzN4USaDCyvbHLzA6vjHMJ/DKQqMEtaH5ICr5IXdHQBD/+0Bt2jryX3IhLExyC6dp5Wsh2cWw8GXNT0SELC8ib1msybtB4BKTdh1mzqEK1ymKF4qQkqkiV59bZuj/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054939; c=relaxed/simple;
	bh=ULzxpz1XWj628ZiUzClZGZP4OJNXGceyfw1pFt/ZySM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UqbIGujuRRdwxSG6TT1yrehXmaK3UmDwJxJbERmHcwUyOecn34Q7NQKbbOfjFtOFA1yubMJruqgfdHP7q+AKisLROfrLRwlgjiyKMipX43OxninuPv1k5s+47b6KXTNz+oydzt0N2ixcK9mG6/afTpVd1RCYYNhPYGnC74mWyHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KoNnq2XM; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaKIzywupAKZGZYrqHX823HPhileXnOn8duwWFzL/hxkWpyESnP9oDVSR7I4kOUgT/WaTDfoJhDeNiQEFDtnKOOBPjBoFu5Npd883JvxrNNT8baAZm2rvdaiPA1rWAqfa/GqZpnH4NgPtbxofMHVPM9BSWHIeuCivt/G8WAszklSZLknfKUx5CttWD8zXDsUh6PpG1mnKzzVJKnyY5HQhZNt2hXo89aVFNlb50AkSVvil+Sk33PPE/2kCpFkF9pZPZbCyHrF2/VhVYUMLZgSTQxUgGv31/ytnIayn5M26boyfAZR0e3bXcORJfm1WQSzSjwqGwZeMRaUktG3PvhYvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEMWhv3Azer5tvN85bI6IxnywFzvglQ34dZSXB7diqk=;
 b=fO13cv7/HAzq+IALseBfLGD7SrrvlSlWtFgXEQVIDCS6O//ZxFub5zJbiDy1Jl8+oqpUfslX2L3FuztsIma+v5oOs63KpL4ISfkzj/rG2bEyzr9/5qAQdg3DuJ+sDIglmsvkdmSATlm6qQm8XfFsdXfR+tM0E/Vjua8Q44g4Pc/Lnqelb8Ff/LQ26yG01kTJIAfLtSOQvyaGJxbodFX0Y/LQR7QnVkPAj1Yiy1eRC4BYfX3YvtTRskanz5WOxMacVCSSgSXvN6dXgVFk3PAIw8SByoldPbkbOKF2dktMdqCFoZzMiXEJ75rCIIz977/1c2jLTB6zlushAVZ8cUgWUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEMWhv3Azer5tvN85bI6IxnywFzvglQ34dZSXB7diqk=;
 b=KoNnq2XMvA+V/UMkWjhQEw9sA1XvTaHWQnm7BLaGn/GADMbISbBfqDFexyMK8RLXBJvuTAr2IucVZKHRH2y8zvOsstS5OagU9LPZeIptS0W5gfXphGiIX8+xy5pgDvd/ZhNWUJASz2tyE3fkIkjLCI2VCRuMYHo/EhMSXrOf75A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Tue, 27 Feb
 2024 17:28:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 17:28:54 +0000
Date: Tue, 27 Feb 2024 12:28:41 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v8 06/10] PCI: dwc: ep: Call dw_pcie_ep_init_registers()
 API directly from all glue drivers
Message-ID: <Zd4bybN0malf5uBe@lizhi-Precision-Tower-5810>
References: <20240224-pci-dbi-rework-v8-0-64c7fd0cfe64@linaro.org>
 <20240224-pci-dbi-rework-v8-6-64c7fd0cfe64@linaro.org>
 <ZdzEoXwU42rFCF/W@lizhi-Precision-Tower-5810>
 <20240227122141.GN2587@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227122141.GN2587@thinkpad>
X-ClientProxiedBy: SJ0PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: bfbf783c-31d6-420b-37a4-08dc37b99244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	glg+a7W/oZaK3HSWZ3NrmkF9TlSuznE4thb8Z45Rn4GcGzgw0SZt6gY1n1csrGhEwzLkXvvJzTSOV8wuIA6SPHpwefL03MjL/9xCvbFhRf1LqMpdzFVUOXze7iylkgHguMwEsxLuk5K7FIgV2BYwE9GBySuOikAHikX0TjN9PPLS90pLAsXDRpw60y7Wc8w3ewwgqab3iZdPmwHzQ0pezU1VrxcSowGnoJidJAnVPlTrsltApbrekJN13JWK27WjMn2z3mp9GIFAOOwqRIQJwRrg2JzbxGcQhXEhQwnnMyZzKarb+kVq8LDgFzuj8Uz6KvjQ+QSsdaH4TzLpbfTAPvA6Sly+uoKpAxZtrGEtvhjPub9wHIrvTtpslztnIKE9YhqcuDK+Cxv0fTVnYnhVqL4vQwC/M+Kuwc+Ty7E4zXCd1Yam6syW+98iCWsdt3a7A3kI+eLjjUA7TkneQE3/Mab07wZmcSr6Dbei492SqX/BgUoIV62bKBKMMTipNn+WwVuU7A2z1aPntjXT2rb+E0syMaAiGNgcED+bXB1RWUere5c9F4fyaMPoq+TdQNmGBkp1kOPa/xl8GGjSbARUUsAg5rM6xGCR6CK3TJrNOzL2dgWJ3DsKJeufp4bMhOmbqUpxJkCN5VbrO05U4cpof1raYDkZHDcIfz0qtHpXZpQU9Uv4x6AnaPSY14yijpyZ3UurnmDz2KIXlkRCNLJjYQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVBXblIyVmJXbVdyQTdiR1ljVWZ2cE5obW9NZWNqcnhObWxnYlc3bnNRcEE1?=
 =?utf-8?B?VFhJNDNPTU10WDVoMVRHMENubDB3T3NDS0d3NTNzOTdmZTN4cjFRY0dNeGh2?=
 =?utf-8?B?b2ZaQ2lqRlhXYmNVOFI1ekNOT1N1MUZEU3NNemdSdHRLZGh6aUYwOVI0Nzh6?=
 =?utf-8?B?Ui9EenFwM1VDWlFXbXd6QXduME9KcnNKQUhORzRiZzhBcVdzYms2ZWhIQkp5?=
 =?utf-8?B?dlprMnBOODRtOTdhZG5yU1ZEbWluVzltK0JRbjkwYm5BY1RXVnZITW5qclR4?=
 =?utf-8?B?REdrdDdqY1FMbEtFTHJwUlNHVXNRSzdxZWNQSGphZUNkbmhFNEQxMURKcHB1?=
 =?utf-8?B?YndvZkkzUUdBaWZWKzRzWWo0dmxOdFh4SHNDWFhyZU9ZUUp2RjkxaURIWVJz?=
 =?utf-8?B?WllaanlGdWs0ZWZacUx6SUNGWEZUckY1M3hmNVpBdFlUdGR3TFJaYU03OG9O?=
 =?utf-8?B?MGpIb1pHdnAxbDVtc04rZnZFZ2lJcVExUlF2VVdJRW9JRDBJVmR0OE9BdU43?=
 =?utf-8?B?cXNZRkFVcXJzclRVSzhqN0puam1FRG9ZK3FHak92Tk9pQU0yalpQYmxuanl4?=
 =?utf-8?B?cW42WHIzVVZ4M2d3ODk1aVptQXZiaXRQSEhBMnNRa1hETmcrMURZVCtTRDVE?=
 =?utf-8?B?RGp2eHBtMTREVnJ3MmVGL1FKOU9aRitsUnJncHFVTkdxMGRsZUpxNVdPT3Rv?=
 =?utf-8?B?QW9iUnp0d1hlN1hyU1dVRzN1ellMR213Z1Q0dEhSdlUwZ2lvc1dMMGVUZElT?=
 =?utf-8?B?WkpDYldXbFJPSCs1V0F1MkxhZCthYVE2cmVsU2hqMll3UksvTE9UOVBRY1VI?=
 =?utf-8?B?SDluV0pneDRvbzVTN1puSTh2cFdlS0dpeWRKTEo1QXY4VVNpbU9GWW8wVXBl?=
 =?utf-8?B?OExLTkpIUE14SFdRWHR2ZWpIY01nNmNpOXFvSFZ1U3BpVVlnbzNwdFFoY2g2?=
 =?utf-8?B?RkdiWUtGU3NnRllVdWN3dnZadTJHUjFVcWNHVVhJb0FWZ0x2NXpzMzQxaU1E?=
 =?utf-8?B?TGtXUHpudUFkQmgxUzNuODRsck9Nb3RuMk1oL3BtVXRFSklwQ3ZlY2FCQ2FH?=
 =?utf-8?B?NHhsM09OL3hPWU9zVmFLWWhxYzNUQ0h0SVh3RDNpSmtJLzNWZWx1T1JLdXpz?=
 =?utf-8?B?YlEvRi9Lb3hRK096ZmZXQmhUSkFCb3RSOUErU2MxV21yMitnSkZBbjcvZTly?=
 =?utf-8?B?WVlzQWh0SnlBUnRJQWFlaDVZbFJ2cWgvWCtKbjNZODg0cHd1RHFwck01MXFv?=
 =?utf-8?B?cWNwNzQ1VisrRG5Ed2phd3l3NFljUnRsWHBGQUxVZTIvY1dkeExnQ2NHbThx?=
 =?utf-8?B?NGtWMnZra0xsY3p6bXRGSVVRaXg1bENIWWorQkcrN2t5YXV0WC9HL1ZTbEly?=
 =?utf-8?B?MHpEdlhKbnFZVHZHZUl2QXVQcDhFVlVLRm5VaUUxT1dTMEVsV2JkYmxTMFE2?=
 =?utf-8?B?M3NmSS9neEZwWGhpZGVLQWFUeXpDSzZEdWRNc0NGZFJZU2xLdjg2bm0za2dv?=
 =?utf-8?B?ZW5VcEM2UWcwQ0FUeWF6enE1UVhxSWFjUHNVRHZNak5Hd1JCNU96UXV6Y1g3?=
 =?utf-8?B?OHFsempTMy9qYllBQTNBdFNLaE5wSmI4NE5laWpRT0x2enpBOGxtVTNIVGZ0?=
 =?utf-8?B?Rk85cFovMmtIR0FxVDFzNjROMFRYK283TjFqb3psaFd0UTFFVFdSaG9OelNK?=
 =?utf-8?B?clZ4NWtscUwwUFFSV1RHRlhsM2I0M3J4TDZNUTlSUUJVYmU4ak9sd1QyOFpj?=
 =?utf-8?B?SFlvM2JxZmlEQVpyL0lkT2JWaWVQWmdTWGtvSWZaVDVVSHB0WWgzV21GY29X?=
 =?utf-8?B?U3lLampuMjFTQVNXLzhxekwyODJNTFhrZmJLeFZUUVlpSU94amdaYjRvUGto?=
 =?utf-8?B?NGppMSs2T1c3MU5zYThjaFdnck9DMkIzTVcydjZDenVlbUVXUU0wOU1uMmpx?=
 =?utf-8?B?aGtWcDdNUjBFSFhpVVpocEwrdlpMWWR1TlNweGR1VENzVGpxc2xib1hEeXUw?=
 =?utf-8?B?dzFrekpjWGtLeVJTT08wVHA1S2RPVWZkKzJISDliRmdqSkcvczNxRmgrUE1y?=
 =?utf-8?B?MkVjeTB0THYwRDdVSUJRcEhyZjRrejVoZmpZbUEvcnpKS00zVnhGc0M2dFEy?=
 =?utf-8?Q?jQCXtXTpfcfnkY0QrruwF6ial?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbf783c-31d6-420b-37a4-08dc37b99244
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 17:28:54.3548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJalJliG2TQRThLbSuFCYhqLuHwyJtQs3OsEhLsSf/Ph3zA6mkGoGcipf0rtce/nvAu5HiJt9sQ2eCxK3zEhQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9185

On Tue, Feb 27, 2024 at 05:51:41PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Feb 26, 2024 at 12:04:33PM -0500, Frank Li wrote:
> > On Sat, Feb 24, 2024 at 12:24:12PM +0530, Manivannan Sadhasivam wrote:
> > > Currently, dw_pcie_ep_init_registers() API is directly called by the glue
> > > drivers requiring active refclk from host. But for the other drivers, it is
> > > getting called implicitly by dw_pcie_ep_init(). This is due to the fact
> > > that this API initializes DWC EP specific registers and that requires an
> > > active refclk (either from host or generated locally by endpoint itsef).
> > > 
> > > But, this causes a discrepancy among the glue drivers. So to avoid this
> > > confusion, let's call this API directly from all glue drivers irrespective
> > > of refclk dependency. Only difference here is that the drivers requiring
> > > refclk from host will call this API only after the refclk is received and
> > > other drivers without refclk dependency will call this API right after
> > > dw_pcie_ep_init().
> > > 
> > > This change will also allow us to remove the "core_init_notifier" flag in
> > > the later commits.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/pci/controller/dwc/pci-dra7xx.c           |  7 +++++++
> > >  drivers/pci/controller/dwc/pci-imx6.c             |  8 ++++++++
> > >  drivers/pci/controller/dwc/pci-keystone.c         |  9 +++++++++
> > >  drivers/pci/controller/dwc/pci-layerscape-ep.c    |  7 +++++++
> > >  drivers/pci/controller/dwc/pcie-designware-ep.c   | 22 ----------------------
> > >  drivers/pci/controller/dwc/pcie-designware-plat.c |  9 +++++++++
> > >  drivers/pci/controller/dwc/pcie-rcar-gen4.c       | 12 +++++++++++-
> > >  drivers/pci/controller/dwc/pcie-uniphier-ep.c     | 13 ++++++++++++-
> > >  8 files changed, 63 insertions(+), 24 deletions(-)
> 
> [...]
> 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > index ed1f2afd830a..278bdc9b2269 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -729,7 +729,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >  	struct device *dev = pci->dev;
> > >  	struct platform_device *pdev = to_platform_device(dev);
> > >  	struct device_node *np = dev->of_node;
> > > -	const struct pci_epc_features *epc_features;
> > >  
> > >  	INIT_LIST_HEAD(&ep->func_list);
> > >  
> > > @@ -775,29 +774,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >  		goto err_exit_epc_mem;
> > >  	}
> > >  
> > > -	if (ep->ops->get_features) {
> > > -		epc_features = ep->ops->get_features(ep);
> > > -		if (epc_features->core_init_notifier)
> > > -			return 0;
> > > -	}
> > 
> > why remove this check?
> > 
> 
> There is no point in keeping this check since we are removing the call to
> dw_pcie_ep_init_registers() below. But I should've described this change in the
> commit message.

Sperated patch will be helpful. This clean up does not related with other
change.

Frank

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

