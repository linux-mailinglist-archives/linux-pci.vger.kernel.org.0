Return-Path: <linux-pci+bounces-15344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA52C9B0A65
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 18:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9652815E7
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 16:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2646F1F80DC;
	Fri, 25 Oct 2024 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IRI/p4FT"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2023F189916;
	Fri, 25 Oct 2024 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875384; cv=fail; b=lqKbjvSNTzHNav1YTZXewiiaBVsDv4mCVh9L2YIwbVRUhaPH0ezidiPHyOc1eFA6/J1Ih5SVWAVoAI19WzJYA7TWSGm3jfekBWon5ayEsGPh72jk5JyojcTh/O967LNKY9K4LIwmlvlMdcB4MSnbi6nMmzeQauXla/XbXpvZPx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875384; c=relaxed/simple;
	bh=5eU6MTDgFeXhHi3PkzkzFNQ5mpxszG4G3wsTfqJGt0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s6d01uctynYImLHncZeyxHxRclU9uovO2DFcf2KlRvxbOjv2bbqqnK9HYZMPFXMLxrYyhves6sGE6t1+7pgGldAIt2JQT9W/AICybj74cKZIna0fSujdKA/YNgI9WB6lutJ2E+QpgnO9w8eLPKf5l59NXUfIVE9kC5yL+67p6GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IRI/p4FT; arc=fail smtp.client-ip=40.107.105.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpwNkgDizdA27NTD37h31Uf/aI/gDLsa72F2zTk2WJovTr3XrQM1ybLFJC/rLA6D6ghbSjp6reUJVH+Wln5ZK/Tk+6XRXw3Cx3eZTSf/3obLn4BpcWbZRubyEj94N3Rsq7f9Z/R/bYXyDJ0XnLn/+eRnX8Hpnan2N2LCb+QMe3OSguAU7JMnQ9RiMgcIdmpkc+Jr6JhXFIEmVjgfJE5kNvth8IGxgnkMEb7tdKcUXxQBDP/p/BgPxDa3RmDQc12qFBgi4+WGt3hBJqVDcxHaEQNqhOCfAndt8Y5Pd+i8GdcLthfHbqQXHx8/hIaaaRepvq/+RCgW5WherZe9Qg4VSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSW5W+CdHaCkksyN2F2L3vLmYm6lth6AXN9Df+Wkyy0=;
 b=TIcqYEBRr5TX8l6COVcSs2NucourW7AON5lDK3lpyD3fLkkNWNPPsSh0s8m38MuVxuIUOrPpA026lBCNofHTtmFU0hrZqF7YGyFrs1a8omNY923W9kpZ7u/viPc9Zq5KfxxskwjR/Rs01xHyJaJKv55zhrZwJjCIfUWA+pEw7ZsVyHXOvkJZUlWLVKCA03tFxO41PwKSCqKbwgz86QDdVFdbRO3C7lRCVRWOGVemufXXDvPipwuoI+ybJSj/cB4X7z/HviiNWyl1i7FWbbQheF35AW0YTn7+xOsfDL2+OHfe3Q733FktYXAQHRhi8IsWe+/CgapMhpkMlRcFuoLRlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSW5W+CdHaCkksyN2F2L3vLmYm6lth6AXN9Df+Wkyy0=;
 b=IRI/p4FTVBXOKkN00Lr9XfmGbdvfqClhntfu5f5YC8euB/B4gEHTqNx+xMFFRWvG0gj4qAk6frOp1zL1d9F84RRchZwHZ5yJp48fcLkdLxbV6SXKoUVBvCsW580sipOrH31WvtirC6CywhM/ZidmpMHrGQxzQtenu8bZfMCY/kfC5OL0Q1AvJDiNKM2UsglX2/QxtQjPiMFJy+l8XP+m3zCKPea3CehLsEvhA6jYRZmjo44euXOOp95FE8O78BGTUZcIT6G+3EN1Z8GcPancO+b5wNKZhWB6ltTqYCtZVDZ2MyBtWXCnkjH4v/UHz/GMZHoUN1Ty9Lc5xAvYhtK/5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10507.eurprd04.prod.outlook.com (2603:10a6:102:41a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 16:56:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Fri, 25 Oct 2024
 16:56:17 +0000
Date: Fri, 25 Oct 2024 12:56:07 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v5 2/3] PCI: dwc: Using parent_bus_addr in of_range to
 eliminate cpu_addr_fixup()
Message-ID: <ZxvNp3v6UofC8QK2@lizhi-Precision-Tower-5810>
References: <20241015-pci_fixup_addr-v5-0-ced556c85270@nxp.com>
 <20241015-pci_fixup_addr-v5-2-ced556c85270@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241015-pci_fixup_addr-v5-2-ced556c85270@nxp.com>
X-ClientProxiedBy: BYAPR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::19) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10507:EE_
X-MS-Office365-Filtering-Correlation-Id: 8855f9bd-2bfd-4234-68c1-08dcf515f0f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXZXRTZ6K1hLY0Ztb1I4Q2xJNVNCTVBrdkNzcE9TQU8rQmNpS3llSGxaTHBy?=
 =?utf-8?B?U3RnNGxHNFM2UFhpY281MzZWYWRUMXkwRDdNVUxRM0xPYndWOFAwOWs4MWRK?=
 =?utf-8?B?K2IxbVRxSXBCUDQydG1PeUV3dlFkeWU5Zlg0aVJFUi9sSTBMaXNtcUdVUEdm?=
 =?utf-8?B?a2VoNlJxZHROZG5TajRMemt2Wk8rVDFlZ2R4dkdEWDN2Q05hQyt3TmNTQWJ3?=
 =?utf-8?B?bFVrRWpDMnlycGxIa3hhV0g0MENOOUJXb0oyaEhVZlNNeGJnWm5SZ3R0MndH?=
 =?utf-8?B?YTE4S2ZQbDlLeHVkaFFNdktRenp1ZkVtMTBaeEhmZlM3enYybHBoRGlvY0w0?=
 =?utf-8?B?Ym9nbjA2VjhYOFZHSUpRNmQyaFptUWNWWGFMcU9VTTJyWldVVVBGY2trdmx3?=
 =?utf-8?B?VWluRi9odjJscU1Pa3hLNDFGSTNtcW81c2plaXJqZ0VJUnVrOU9wRm5wUXNV?=
 =?utf-8?B?aXlpai9rUFhnVmllVndoZVN2U1YzRkpORU9WdHp5Nm0yRy80V3pUdHFiR2Ex?=
 =?utf-8?B?cUM5aU1ISmVSVEg1NDVkYU9ldWRXOXpqM1lNTFQ4Qi9mTFhFKzVkODJ1UXQv?=
 =?utf-8?B?NjFHZmg2TkFnKzJMaWl0V1dLZng0OFhvMFlLekJKV2Y2bDRWZHUybDUrNDgr?=
 =?utf-8?B?QVdWM0VzZWF3ZmxCakRvRStLaW81VWNWbi9UTVdWMldLajlnRkxodmhZNEo4?=
 =?utf-8?B?eDJHZldtZXNlU1QvcE9wMzdkZFovRGdkL3pvZHR6WEFNMlRUWVJGUXV4Nml0?=
 =?utf-8?B?bXJEZXcrc05WdXlwMGRSTG43VkwzenNpZzdZMElnWjRKa290MEg3K1VUaUh0?=
 =?utf-8?B?ajJsejI0MlJZbm1yNXIyWHJheVNRYXM5b0dpUzVoSUZ0ci9iT1B5cjQxRFdF?=
 =?utf-8?B?U0FWa3RmcjFWYjhLZVU5c21PS0ZlaVRJRnRzUEF1THJlQUlpQzNWcXVDZzVW?=
 =?utf-8?B?VTlzbmdDZ3NzTkhXVXUvdlJWQ0VZcTVnMGJRdjhYNXpVOE1hSWJWUlVlMGh0?=
 =?utf-8?B?VzFwOW51bm1yTHNPbXRvaTBVdUxyMUhORzk3elJlMzlrdWJHTDBFY0VSU2lv?=
 =?utf-8?B?QlpVU0gxTmdaQjU0UmxSTVRoVlUwbEtoelJoZzVOejRpMHZsZlFsL2hOSStM?=
 =?utf-8?B?YUwyNlB3TjhGT2w5SkJUU1hFMVlHNzlGNzVYUEFHVWlKNzd0TkZkNjMrOVYr?=
 =?utf-8?B?V3pDY2V4Wk02M0VMd25yWEJVWmFkVmNWeHZYL0ttVEdNckxZcXJVSCtmODJ4?=
 =?utf-8?B?OWt5SlJVRE5KejNNYThQVjIyazl1VzdoQ2s1OTUvNkFqeWU5SWNwSVdpODIv?=
 =?utf-8?B?cURzSkoxNjVEa0c0OXJhWlhEbHlMdzlxRHFTMTEzUkl0YzBOak9OSzAvSTZU?=
 =?utf-8?B?OWE4VzdDVSt0L0pnUjBNamdGdjN2YlIzaFpDOWR0RmlVekw3MkVQbU91ZXNX?=
 =?utf-8?B?MHpGaEdEQWdVS0lkS0wyY0lQbk1jRWZNWkFIVW80bGhRejhmUDJwLytWOXpI?=
 =?utf-8?B?R2szbVZVQUxOaml5RFd5a1FnTjVxQktrQTd4bEtkZldNU3BjdjdnRWNUMDdh?=
 =?utf-8?B?ZHNxeTNFMngxYklLdFFreDl2WFRpQlBMejNmRTFKbUIydGV4TlozUU1DbGhp?=
 =?utf-8?B?OTI5QW9EQlpkVXdYZCthV1huWGd2ek43a3VkUXZEUTVlYzd1TDc5Q1I3ZmNX?=
 =?utf-8?B?VWdKVDlWOU1LMEFvMGZLR0hsQnUrQ0oweEs3Y1EyekFYeHNDUURhQm1oL25t?=
 =?utf-8?B?MlYxUEJFeE50SDk5NG80YUVmZ1RHWlkzYVlyT285SkpQUmRqaUVSeVNBQUNP?=
 =?utf-8?B?ZkRwSURvdEFSODZ0Um5vRFVZb1ROYmcwNmR6WndxcnNudzRUNU5EdE9CV2lM?=
 =?utf-8?Q?EnbRSOrneobRB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2tNWENIZjYrdHV4NC91SGJpeU5Qd044U29EMGNCTG5lRTdobnpLUE5GNnZw?=
 =?utf-8?B?QjNIeUVTN2VLOVJKQjYyc2ErTUpvcGdFRHJRZlY0T1VYMjJ0MlhRendGa3Zm?=
 =?utf-8?B?MFRBUzhCeS9FOWNiTFk4eVIrMmhYSDFFS0ZPWTBKTUI2L0EzNmtYRjRiRWM3?=
 =?utf-8?B?VkRzdGRXQW9LTGpvRzRSVWlEWVlXRnhhR0lOek1WZHBjWFF2UU1Gcnd6em5u?=
 =?utf-8?B?QXZUOXl3YWFsdnN4RWx0c2QxU0dDQ2FPRkw3SEJlNWRJNktwSlVBUlE0cCtp?=
 =?utf-8?B?NlB2bEFuUE5NTXRkY1MzYWovRTFtWkwxM3BQMi9uMktDSHUzKzhhZ2JQVy82?=
 =?utf-8?B?ZkFyNnRNdmQwWDEyMGV4SGx4d2N6MHRPQmdaeC93OGZQYzY2eTNSMHVlelFZ?=
 =?utf-8?B?WmZGODNtZXp6VzhMYXN5NWRaUDg2YnZDcFl6KytwTm8xazNHQjFQdGZKUTVZ?=
 =?utf-8?B?cVJJM0x2bVpoZW1UYWZ2RjNCNmcyRUsxNXpjRTVBY0xjSnpkUDBkYzIvZGV6?=
 =?utf-8?B?c20zNlJzbGZ1U0R2dFJkOENvQ3Y0UWFVdk85UlNBSm1KOTJaMnp1dGplQ2M5?=
 =?utf-8?B?WnFqSmVYdVkxRTUxK3pXSkthWEFYZThTQ1gwenE0N0lIb3lGbE9uWkg0ckVi?=
 =?utf-8?B?b2s4UmxsT3UwWkNVaW5ZUWRzdno5VWFiUlZ0em9EeWx2bmltVXJWZUVVR2N1?=
 =?utf-8?B?M0dLK3pCYmRUc21jSGZnMDBRb2FPV052czN6L1p1WVFHU3ZnTFkza1ZTWXlV?=
 =?utf-8?B?bG5UZ05DUGg3WlRLbDhIYzdXT3VuT28wcnp6SGpZNHV6eC9KVnZJUi9xRFBo?=
 =?utf-8?B?WU5KWFBFQ0JvalVPcG0zQ085TE0yZEZVUjNlVTAvYXY3TjNYNmNuUU9BQlNK?=
 =?utf-8?B?R0p6UmMxenJWci9xS0t0YnIycHhha1QzWG5XNVYvQlZlM25QMVkyOUJuU2pp?=
 =?utf-8?B?M1Y4VXBJUmlqamVxY2t3VkordjJEKzdmWFQ0VVA3eUdRM25IMm82S1loSWl5?=
 =?utf-8?B?QmwrclovM2tQdFF1UklUREk3SExPUHczTHhYd0pRVDZUNzZZZjlrM3Z5d2ww?=
 =?utf-8?B?cjBtUnFpNkFFUlN6VzY5SjMyQ05uMlJzUEJ2OURQb2RwaWl6TWxzVVpyZy81?=
 =?utf-8?B?TTlqVWtZemdJZ2U4OUJuMDFvYnRydURqeGUxWlZpRmJwYlphN09MRDNOWWdM?=
 =?utf-8?B?UWg1aE5iWDgvejZRN0pwbGF4djJ6VWd3c1pUdUJabktkRTB6ZmExM2NpOWlT?=
 =?utf-8?B?di83cUJxZnEyY2RQS21aR01ZVXRsMTl3K3JxSlVVVHVSOVJBenpaeDRTL0ww?=
 =?utf-8?B?R015RERIclg5VFQ1UjY3YmdwV1BvMzZjQUtidWsrekwySWN2ZTBYSDMxd2V4?=
 =?utf-8?B?THE5UHNNMHRveHJKWGlqdEtUbENzV05KTVZxamdHTE16OEIxZm01NVVvRTdp?=
 =?utf-8?B?UnBPS21GMGJIb1lhYjJKdWFRM0Y2ODdiVWQyZzl1Q0ZJWXppdzUzTTdEQ09o?=
 =?utf-8?B?SFp4TWJBWUY5TDN5dWJPa3UweFNwUUZzQUVzK21uVG9ZUktFL0VoRE1MTnc3?=
 =?utf-8?B?MWJlUUQxQ3F1bHFicEVCWCtWendtbnh4clN6ZEJBZVNHSTJFcElycUk4UXFD?=
 =?utf-8?B?KzE5MUdpZHlyR1QrVWh3cGswa3ZER2FDRzR3RkYxZEx5d0I2eGxKRlZNQ3Fo?=
 =?utf-8?B?NTRNeXgxbS9UWXU5OTRsaExBWFZuazdyRnhCU1U2OTc1OFFBN2pNTGhGUlUw?=
 =?utf-8?B?Vzd5RzI4OUgxZ1JqcERJQUhUYzZoMnZMaUg5WGpNYzlMamRqenJQNVJCaHg4?=
 =?utf-8?B?K1FsZEhnM2FWcVhEczlkdHk3OUtPRGRVbkw2WUFhdlFVZVlMdWFVQXc2Skpl?=
 =?utf-8?B?WllRU2JYdnQ3Z2FoZng4WTdVcXcrNUI5S3pZQkZ5YlJVV2dWcSt3SmFldnBR?=
 =?utf-8?B?U3NnWVVtWkkvT0QrWkk4RzBqUVFXOXZxQXJIdDZicDM5MWZob3c1VDM3MmFH?=
 =?utf-8?B?NlpweUY2UnducGRJbjBMRTRmeTZocDBSdWZJZjIyTVBpcmNjdUI4WGQ0N2wv?=
 =?utf-8?B?Z3JLQ2VCbXhESnhuMFZuT3RkWC91NTZScnZaZ2prY3hURzFhL3BLNDdlbXNB?=
 =?utf-8?Q?ziyfolgMv2If/RWO9/S5MaGqI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8855f9bd-2bfd-4234-68c1-08dcf515f0f5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 16:56:17.1036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0L+qi8EIK5jzclFHo4zxVu3UIFcxIiU0BbkgL2ySUJ3Ulhm6zKVN0l0+h9BRd9fTsU38f/DbLjSSCAQx4XXUDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10507

On Tue, Oct 15, 2024 at 03:17:18PM -0400, Frank Li wrote:
> parent_bus_addr in struct of_range can indicate address information just
> ahead of PCIe controller. Most system's bus fabric use 1:1 map between
> input and output address. but some hardware like i.MX8QXP doesn't use 1:1
> map. See below diagram:
>
>             ┌─────────┐                    ┌────────────┐
>  ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
>  │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
>  └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
>   CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
> 0x7ff8_0000─┼───┘  │  │             │   │  │            │
>             │      │  │             │   │  │            │   PCI Addr
> 0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
>             │         │             │      │            │    0
> 0x7000_0000─┼────────►├─────────┐   │      │            │
>             └─────────┘         │   └──────► CfgSpace  ─┼────────────►
>              BUS Fabric         │          │            │    0
>                                 │          │            │
>                                 └──────────► MemSpace  ─┼────────────►
>                         IA: 0x8000_0000    │            │  0x8000_0000
>                                            └────────────┘
>
> bus@5f000000 {
> 	compatible = "simple-bus";
> 	#address-cells = <1>;
> 	#size-cells = <1>;
> 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
>
> 	pcie@5f010000 {
> 		compatible = "fsl,imx8q-pcie";
> 		reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
> 		reg-names = "dbi", "config";
> 		#address-cells = <3>;
> 		#size-cells = <2>;
> 		device_type = "pci";
> 		bus-range = <0x00 0xff>;
> 		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
> 			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
> 	...
> 	};
> };
>
> Term internal address (IA) here means the address just before PCIe
> controller. After ATU use this IA instead CPU address, cpu_addr_fixup() can
> be removed.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Mani:
	Do you have chance to review dwc and imx6 part?

Frank

> ---
> Change from v4 to v5
> - remove confused 0x5f00_0000 range in sample dts.
> - reorder address at above diagram.
>
> Change from v3 to v4
> - none
>
> Change from v2 to v3
> - %s/cpu_untranslate_addr/parent_bus_addr/g
> - update diagram.
> - improve commit message.
>
> Change from v1 to v2
> - update because patch1 change get untranslate address method.
> - add using_dtbus_info in case break back compatibility for exited platform.
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 42 +++++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h      |  8 +++++
>  2 files changed, 50 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3e41865c72904..823ff42c2e2c9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -418,6 +418,34 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
>  	}
>  }
>
> +static int dw_pcie_get_untranslate_addr(struct dw_pcie *pci, resource_size_t pci_addr,
> +					resource_size_t *i_addr)
> +{
> +	struct device *dev = pci->dev;
> +	struct device_node *np = dev->of_node;
> +	struct of_range_parser parser;
> +	struct of_range range;
> +	int ret;
> +
> +	if (!pci->using_dtbus_info) {
> +		*i_addr = pci_addr;
> +		return 0;
> +	}
> +
> +	ret = of_range_parser_init(&parser, np);
> +	if (ret)
> +		return ret;
> +
> +	for_each_of_pci_range(&parser, &range) {
> +		if (pci_addr == range.bus_addr) {
> +			*i_addr = range.parent_bus_addr;
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -427,6 +455,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	struct resource_entry *win;
>  	struct pci_host_bridge *bridge;
>  	struct resource *res;
> +	int index;
>  	int ret;
>
>  	raw_spin_lock_init(&pp->lock);
> @@ -440,6 +469,13 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  		pp->cfg0_size = resource_size(res);
>  		pp->cfg0_base = res->start;
>
> +		if (pci->using_dtbus_info) {
> +			index = of_property_match_string(np, "reg-names", "config");
> +			if (index < 0)
> +				return -EINVAL;
> +			of_property_read_reg(np, index, &pp->cfg0_base, NULL);
> +		}
> +
>  		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
>  		if (IS_ERR(pp->va_cfg0_base))
>  			return PTR_ERR(pp->va_cfg0_base);
> @@ -462,6 +498,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  		pp->io_base = pci_pio_to_address(win->res->start);
>  	}
>
> +	if (dw_pcie_get_untranslate_addr(pci, pp->io_bus_addr, &pp->io_base))
> +		return -ENODEV;
> +
>  	/* Set default bus ops */
>  	bridge->ops = &dw_pcie_ops;
>  	bridge->child_ops = &dw_child_pcie_ops;
> @@ -733,6 +772,9 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  		atu.cpu_addr = entry->res->start;
>  		atu.pci_addr = entry->res->start - entry->offset;
>
> +		if (dw_pcie_get_untranslate_addr(pci, atu.pci_addr, &atu.cpu_addr))
> +			return -EINVAL;
> +
>  		/* Adjust iATU size if MSG TLP region was allocated before */
>  		if (pp->msg_res && pp->msg_res->parent == entry->res)
>  			atu.size = resource_size(entry->res) -
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 347ab74ac35aa..f8067393ad35a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -463,6 +463,14 @@ struct dw_pcie {
>  	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
>  	struct gpio_desc		*pe_rst;
>  	bool			suspended;
> +	/*
> +	 * Use device tree 'ranges' property of bus node instead using
> +	 * cpu_addr_fixup(). Some old platform dts 'ranges' in bus node may not
> +	 * reflect real hardware's behavior. In case break these platform back
> +	 * compatibility, add below flags. Set it true if dts already correct
> +	 * indicate bus fabric address convert.
> +	 */
> +	bool			using_dtbus_info;
>  };
>
>  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
>
> --
> 2.34.1
>

