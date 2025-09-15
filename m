Return-Path: <linux-pci+bounces-36171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F4CB57FD6
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 17:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBE94C461B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 15:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70DB33EB1C;
	Mon, 15 Sep 2025 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cbDi7Dyt"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A109327A2E;
	Mon, 15 Sep 2025 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948479; cv=fail; b=QiifNe5hs9k6j1lXNGdHH3pNWAoOHlAN/UIOd4hm2nxEkFlPRg0orQixS13kYQha35sGtwkg2ESs2Z+13Yo3giF0buXH9AFeBaEE6OUEbIJiJ2JAUx8u57uJY+igJA7MQfDFing9wc7ZKfJIkya7zG3s/QZRgBluS1m5fM6KPus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948479; c=relaxed/simple;
	bh=gOpPHM+bJ3/jsuDbHy9M5FQiqrJ2dSr7zwarVhP0dgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pjKwPb7nMvPlip7ZL26V0TSiOirTf3kld9hzdPb4aJfjVK0fnj0b/9ftRTNaSs6WH8Yd7PXMlSjo0RI4KGPSq0zQjJK9pn/KcgV/T0ImtjbiV6yZ28R5ZBoCOx09OdrVohGQ8vmLKXB9rMgeFkWCAQ+Q5Dc/4JQJq8YBsolUZB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cbDi7Dyt; arc=fail smtp.client-ip=40.107.159.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cX+mQwvfJLMlQWhHO9IUWPN01y3cdhYh4usas0BrY+oEXCZXtHh/tg38tN91D16/6HBZ8svRfslSWuxGA6siIpn/U5C9TZQ/x1K+pzv1KCQh+aQEC+4KJ7A3N88oHkgRrZ1pspLlFJws9hfer/On9EuLNFVbRF/KJEmil1y1Wz1j4mXhrds3jWJgjpo7ySKkyGqzg3tQfJOBKrwWNN7kdNKZWP7Ojarq0saHfutNIDDs0Su76rcdawHNgshKZ108XHZYkBb0cw5WQjvMC1vNDP53iLJWrxzse5Ymv9xA6eKG6U/iZHqQGcYreBQDS7Ed8XX+FP7YxAQlL51v9i3dYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkO81HH1W7nXhMU2FHD1KXR29ebD5nUA+sFMiQmVC/Q=;
 b=RUSbHl1JQTR2ttj6aBH4th397s2P4rcFT6hTdR3hiedBrejkEXzvVgCIGDlBSRtmSqpzHbrEJz/WQjIKNwoybyFj2b5Bvh8HeK3SAwKmjmU3n7WLMqc3/Id5KiOVVxFtbTBCSyauq5RLxYmm5VwWVwlzmJVzBDHkK76bfc1NyLZNSZndZEG0/J/FWaaO5NQoL6JB8nVpAwLfmCjiEc91/V9xJC1ob3AvJvsb8jWf4s0PBKP6ChwNf+E1obPfaBOuAPwESLksDAaHtLp6KSKk9TydTD6bCCL/M7HqZstTbp/MPfKUU6tuTocJfG/pQn7htnaEWRw5ytsZZHWn7WqNJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkO81HH1W7nXhMU2FHD1KXR29ebD5nUA+sFMiQmVC/Q=;
 b=cbDi7Dyt6pg7v3MOmZq7s1fOkmERt66FTV1sZgebE169+H234JoBImlhtThrbWlVPf0qpOswYgE8wj4CgOgrjp0URWT2/kq2zb7e3ETQQYjXnPxtxj4wZLCndODdv0Gd+cjLfiLq1oyKWm4a0IbH/8bEfzYanU0SXNioo2GShOtQ3Mt5yE9ID8zHGj1ucW/IaDyehy+3Ig/CgwSlcYT00opSGJvaZ6FM+ionxfAp9sim5l5PWnRH2qRrkumHwib3aLh2CH+kvCvF57qVOHZES1ibSu77HLZxzvCypipa8GbTDsDnerqjrYAehZUkZbjwJyWizI/6OeXiI5iVj69bAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AM0PR04MB6931.eurprd04.prod.outlook.com (2603:10a6:208:17e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Mon, 15 Sep
 2025 15:01:13 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9137.010; Mon, 15 Sep 2025
 15:01:11 +0000
Date: Mon, 15 Sep 2025 11:01:03 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH 1/2] PCI: endpoint: Enhance pci_epf_alloc_space() and
 rename to pci_epf_set_inbound_space()
Message-ID: <aMgqLy6oIrzVV7JO@lizhi-Precision-Tower-5810>
References: <20250815-vntb_msi_doorbell-v1-0-32df6c4bf96c@nxp.com>
 <20250815-vntb_msi_doorbell-v1-1-32df6c4bf96c@nxp.com>
 <udt2t2c43nw5de5q5vu2etknbnhrr3m5mqjk72nuyiurk46kbp@e47e5kvk2m22>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <udt2t2c43nw5de5q5vu2etknbnhrr3m5mqjk72nuyiurk46kbp@e47e5kvk2m22>
X-ClientProxiedBy: SJ0PR13CA0101.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::16) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AM0PR04MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: 549b2933-0b89-4209-4395-08ddf468b510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZSt1cGsrM0hDTG1ybFNLK0Z5OE14eVB4VXg5VDZobkhyRENOL1pBZXp6WFpp?=
 =?utf-8?B?dmg0ZlVGSlVoUGVScnEvN1ppbEUzakpNd3o5VWxCRitEY3RHK1p6TTFobXFk?=
 =?utf-8?B?dWUrOEpNR3VpUzQ3SW14RmJicndJMmE1V2ZsUjB6QThweVJJczN6d1JyV1h1?=
 =?utf-8?B?K1l6c21BcTVXT3lqZlBsaDMwelhBOHlQOThMSVV6RWR4VWE2R1R6VzNMQkRq?=
 =?utf-8?B?Wm16YitEZDdudnJ5WjNIMGJ0cW9iVEFoU1E1U0hYTHp4TG8xWlREOGpiczRq?=
 =?utf-8?B?VjhLSEg0eUwyQWVkZFIzRUtjSkNqSEs1c212TG1aMVRDVzV2UG9MbXRhenlG?=
 =?utf-8?B?ais1Y1RuWE9NZFJUU1V1Nzc0U3psVFBiQUFKbVVqR1llNnNITWRTNXdWZHpG?=
 =?utf-8?B?Y3dmNkVjRndyeHRsaHhkVnlRUm5SY1dNb2lhQWR5SFBWTEdZcjZoMk9rNEYz?=
 =?utf-8?B?WE1mRmpYY0xPNGRqZGZGUGdXWlRCbzFRbC96ZUNha0xLL1FlSmluSEdkOG0z?=
 =?utf-8?B?NXRhZzhyMk1Zb21vTVl4NnpzY01CRGVXY0hOaExmMy90Tm1uNGczOG02QWxP?=
 =?utf-8?B?anpBeEJWQUZuSnQyV2VocWNTRlhHS2R1VXc4M1pYQWJrVkpmN3FxT1duS05F?=
 =?utf-8?B?cGNmcFFKV2pBS09aVk5hUy8zODhFbklDSzV3N2dRZ0d5UnhzYWNTblJ3cHFa?=
 =?utf-8?B?ZVNlaEswdW82L2dDTEx2Zlg3WTVWSitMRVRSVUxseWNKNWRLSHpla2Fla0s5?=
 =?utf-8?B?c3o5aVhZVWdpTWhwN0RUZXU2V0NHMkt2akJzUmo3SjRyMHliRnpjczY4NHBo?=
 =?utf-8?B?cmpnQ2xrNFhNWllCZXhiQVFCVkxCTE40MzVSdWZXa2NjYUp5T2grRUpldUkr?=
 =?utf-8?B?YzdMdmlNZEJCOXZUTnU3a05TeWFRV09TaHg4bmVhYUVVeHhlUnBSQm4vY2dX?=
 =?utf-8?B?WU4vYnFyRmw3SGtwNTZadEdaMjFjOHBBTFY3N3IxcG14R0tNZnFpRnAwbEJx?=
 =?utf-8?B?bERQeVdPZzI1cHVFdVIxeWp6VXBWTTVCQmVRQ2pRU1NKWlc0cndhcWJZaTNL?=
 =?utf-8?B?eEt6UyttWGgxNlVOaUUwL2tSRnMzZHovMm0wUkN3a1VFeUdUa1RtZzJpYWY2?=
 =?utf-8?B?R255bk5HTVdKT2NIZStEQzRiVXZhUHdRa0NSMFlKdklQTFh5YkhjbGVYOU8z?=
 =?utf-8?B?Mk5ZYy96cm5oazVOQ2UxdUZJc1NtMW1WVHBrNmkwUzZsak4xVllFR3pLTEdh?=
 =?utf-8?B?cGpiOTkyai92VjNOMHA1b01Ibmg2bkZ2Wkd0MWZWU1ZhL2EvN0M1aGgyUklt?=
 =?utf-8?B?US8vZk4vczlNbXN3amNzVFBLUitOaVFNUGJNWUsveElpTysza0krb1VwYUdD?=
 =?utf-8?B?ZnhrKzF6UXRMdjdTUExIVXJEQTBKcHRkeDZtVHI2dnQ2TXNUa3NBWEpDbmpl?=
 =?utf-8?B?TWo5dHIyMmVRUGlER2Rlb2h2UGRURk1BNXBGRkhFUWw5VVBveUQweVZiQlRZ?=
 =?utf-8?B?ZjJVbU9QdmxMVmdTSm0zWDI1OFdZZUR4UUU2YWJlcmlVYlR3YlFWcEhEalRB?=
 =?utf-8?B?SXUvZWEvR1d4dFhnVW9NUzFDQmFGY3VWYjdyQnlSa3RjR3pqOXlWYlhRejJr?=
 =?utf-8?B?TWlZWDJaVW5DdloxYzZ6b0Jxc1ZiRG5scm85bEkvaW5JRDV1Vm1ReEt3Rmdi?=
 =?utf-8?B?S0hQOG1OKy9tOTM2WlBlNGs4SEZBOW9FLzR6YUdNdkppUStSbVgzS3UxREhy?=
 =?utf-8?B?VTVmbDFsNFdOdHlGSjE0ZmVUN29EdEZpVXVHa05LbmdCejlFL3VNMVcyY1lq?=
 =?utf-8?B?bkh2ZmtvMGJvY0RtdzAzblBzQnlzQzJTMTlmWGQ0eTlUQ1JyMXJwS3U5L1g5?=
 =?utf-8?B?Q3psNmpKYkkvSWVuSWxkeVcvczJtei9yQ2MwZjk4WE9DSVFCWXVhZXo1c011?=
 =?utf-8?B?YmlwVWNHbit4V0czVDZBU1FsMDdyYkFxZVVWVy8rSTRHL3o4RXZmS3l1NDBE?=
 =?utf-8?B?SkVNcUhreGRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1VTNzRRSGFTdjdSUys4RFVyR3VpSE1ZWmdIOU5DZ2pFKzdyQ3Y4ejl2RGdl?=
 =?utf-8?B?VnRwSDNvWG9tNmdtU2NhU2lRb21ZTHhvYWwzWS83S1ZlcXdXaHlIK0FDa3Yy?=
 =?utf-8?B?RXZkcEFzbE1BcDdsVTFHY1FHOHBHYzdrQXBuOFc3anorWGRBNCtKanFnbnJs?=
 =?utf-8?B?MFRhZTFDd3dnUnZlUXlLb0ZkWlRROTluUE1LZjhrVU5ZcXVLYWlzbk1JU2g5?=
 =?utf-8?B?Rlc3SzFaRk1kUHd0T3dWVmpvR2ZadktNNHpiZzZVcksreHJDWTJIVFVqdnda?=
 =?utf-8?B?VzJ4UnpwVXhqbXU4MDBOSGdwb085UFZTanp1aXlxWTN6UUtGQTIwWHBVYjVs?=
 =?utf-8?B?UFpQNVJnUHo1NWdLNlV4N3ZNUGtFOWluNDl1YUh3MjQ5cEQ2TTZTckdBVFVJ?=
 =?utf-8?B?UkNQRk5WQWY5eFV0eDVzd1ZEWkxjaE9TSGJOS1BTWWgvbEcvd05HUFpKQnJL?=
 =?utf-8?B?OERxU0VmTVZmUzJHK0kySmdkLzBDUS9PT1N6OVZoekRZRVkxODRVd0o0NnBF?=
 =?utf-8?B?SU93VzJ6TS9qbmtSS2gzMHRJTHltQlJ5ZERpV0ZQc0NsQWRhOFdSdWovOCtF?=
 =?utf-8?B?dW0zYjhkMXNVd3EzcVlyZHJMWjJTZ2JrUDc4QTNmRzc5d3lxTXNhbDdpZEY1?=
 =?utf-8?B?bVM5dUk2UTZNRGU1VFlicHNqY3d2OUJRc0FQQm4veVJpMmZGeEJ1cVAwSUtO?=
 =?utf-8?B?dXRBL0hwQ2RqSmJmVDhMb1dxRUJVNDBhaFhPNEFNb01wZTYwRUovZC9xM1Fs?=
 =?utf-8?B?UTZ0RTdWelByS0VkT3FxaU0waWhxVkUzVS82TFlHZ3hCbXFHYkVqdlBhR3pz?=
 =?utf-8?B?UUJTZnVuTEMzbk8yWlY3YnVxRTdFaUVhVjMvdCtSc0RaTVZyQVFUREpxczVt?=
 =?utf-8?B?Vis4Z0NOakJZL0czbm1BbDUxQ25kT0NTNmZkaHRWZDJ5U2IwRHAxdXFDRjVQ?=
 =?utf-8?B?YW1QT3prU0toVG1ydUJMQkxSa2dpRCtGdjJVclNsQlk5R1hPYXZmM01vQ1VR?=
 =?utf-8?B?OXhObnRLN1RRRVFmbmNpRjdjaVY1WW9GM0RoY3B3MTNaVFlINFVOTHVnbGVN?=
 =?utf-8?B?blkydE52b093L1Y1VlI4YnNHWXVramd6d0orbzk3VG9wZFJMaWxCVHRYQ2Zn?=
 =?utf-8?B?ZnFMVlZIdUF1bCtQYVIxa1ZsYW1aUW1DZFAyOGs3ZkZrRnlrZXF4RXk3ZUFN?=
 =?utf-8?B?UFVTT2JYZ2pWSytEc1NtTHZJTjkzOVFiY01FTzhBMWpVRy8yZ3ZocjVJTkdF?=
 =?utf-8?B?QmdwZTlsSVoyQzZLUHJIWWt3L3lCcTZFY01lOWt5d0FWc2xaZE5TSDM4K25V?=
 =?utf-8?B?czJFbkVMZHRvYno4VVVVY3NHT0pheGVUN3ErWkxOODF3cmtWNjhYU243RmFt?=
 =?utf-8?B?Qit3d042SThtWmJQaGJOOW9nbWJXZGdldWpDRkNyL0wzUU9peFhxcmk5ZWxC?=
 =?utf-8?B?a0lmTWFDNzZnTzRDUGcwKzJZYXZ4SnFVQ3dsM292ZGZtQkxKQnlMZUhEckVZ?=
 =?utf-8?B?RDlqQ3hRaXZlSVp6TEV2VVpCS0g3QjFXM2JnV1FwMGVybXI0U3orZWpndllx?=
 =?utf-8?B?amppaTFoelQwYkZ3OUFsSnIxZzVyTkptc0ErU2ZSTmhwQk5LRkZiSHVhRzBk?=
 =?utf-8?B?M2FncEU3NHJqeWRTZlplYmpZOXptODVQQ1RWZlhvalNjRmxiVWFXdS9BRlNI?=
 =?utf-8?B?aHdndmFWZ1NBbnJxNk80VkRuQ2t2b0Vxa3BXSnpwdnlQOHQ0SUFVZ0dNVXFz?=
 =?utf-8?B?TGJMRDIxbjFLeFFRM3JuTjY3VGVOZHJxRUIzZktRRVZ3MFhwMGQrYmxPS1R1?=
 =?utf-8?B?YmRSbU54cFF3WGx3bEFQWktRSDRqTTV5OXNLUlM4WW1obytpM0JzVU9kZVFm?=
 =?utf-8?B?SXdaVHhFZ3R1bnJiTG0yWjEyNlhmZXFtL3RpMkNiL1lIdFNaV0VUZUExQVlY?=
 =?utf-8?B?R0hldG5ZNmFLZkZLbWNFTWlLT3V1TFFUQWdhTzcvblpxUTJTNmxRUGpIeStG?=
 =?utf-8?B?bFh0S2xMWEYrdm84cVRQbkJ0NHlPdnN4WEZWajgzZGY5ZFJEOFQxQm9peTB0?=
 =?utf-8?B?YURNRnlXYjhNdTJid3BNZHJKcVpUSjBrMWdIWnhsbUlid2k0TUUxUEZFTjli?=
 =?utf-8?Q?A6GY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549b2933-0b89-4209-4395-08ddf468b510
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 15:01:10.9853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tl459DG2kLhcBImDFDMirIdLiY1LOeLeGiMYswIWg8Cw8QLuEvfg4KJdKZEjllcEAVVNQyw9NYRQqgv3IKkJmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6931

On Sat, Aug 30, 2025 at 08:16:33PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Aug 15, 2025 at 06:20:53PM GMT, Frank Li wrote:
> > Enhance pci_epf_alloc_space() to handle setting any physical address as
> > inbound memory space, such as an MSI message base address. The function
> > already accounts for different alignment requirements for different BARs,
> > so reuse this logic and rename the function to pci_epf_set_inbound_space().
> >
>
> I don't think combining both APIs is a good idea. One allocates space for
> inbound memory/populates epf_bar and another reuses existing memory/populates
> epf_bar. Combining both, logically makes little sense and another makes the code
> messy.
>
> If you want to reuse the alignment checks and epf_bar setting from
> pci_epf_alloc_space(), then create a separate helper(s) out of it and call from
> both APIs.
>
> > Make pci_epf_alloc_space() inline and call pci_epf_set_inbound_space() with
> > from_space set to true to maintain compatibility.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > ---
> >  drivers/pci/endpoint/pci-epf-core.c | 69 ++++++++++++++++++++++++++++++-------
> >  include/linux/pci-epc.h             |  5 ---
> >  include/linux/pci-epf.h             | 35 ++++++++++++++++---
> >  3 files changed, 87 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > index d54e18872aefc07c655c94c104a347328ff7a432..5b802b1ea3e28a32e38f4ab6a649cb97a2f29b95 100644
> > --- a/drivers/pci/endpoint/pci-epf-core.c
> > +++ b/drivers/pci/endpoint/pci-epf-core.c
> > @@ -249,20 +249,26 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
> >  EXPORT_SYMBOL_GPL(pci_epf_free_space);
> >
> >  /**
> > - * pci_epf_alloc_space() - allocate memory for the PCI EPF register space
> > + * pci_epf_set_inbound_space() - set memory for the PCI EPF inbound address space
> >   * @epf: the EPF device to whom allocate the memory
> >   * @size: the size of the memory that has to be allocated
> >   * @bar: the BAR number corresponding to the allocated register space
> >   * @epc_features: the features provided by the EPC specific to this EPF
> >   * @type: Identifies if the allocation is for primary EPC or secondary EPC
> > + * @from_memory: allocate from system memory
> > + * @inbound_addr: Any physical address space such as MSI message address that
> > + *                work as inbound address space. from_memory need be false.
> >   *
> >   * Invoke to allocate memory for the PCI EPF register space.
> >   * Flag PCI_BASE_ADDRESS_MEM_TYPE_64 will automatically get set if the BAR
> >   * can only be a 64-bit BAR, or if the requested size is larger than 2 GB.
> >   */
> > -void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
> > -			  const struct pci_epc_features *epc_features,
> > -			  enum pci_epc_interface_type type)
> > +int pci_epf_set_inbound_space(struct pci_epf *epf, size_t size,
> > +			      enum pci_barno bar,
> > +			      const struct pci_epc_features *epc_features,
> > +			      enum pci_epc_interface_type type,
> > +			      bool from_memory,
> > +			      dma_addr_t inbound_addr)
> >  {
> >  	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
> >  	size_t aligned_size, align = epc_features->align;
> > @@ -270,7 +276,32 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
> >  	dma_addr_t phys_addr;
> >  	struct pci_epc *epc;
> >  	struct device *dev;
> > -	void *space;
> > +	void *space = NULL;
> > +	dma_addr_t up;
> > +
> > +	up = inbound_addr + size - 1;
> > +
> > +	/*
> > +	 *  Bits:            15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
> > +	 *  Inbound_addr:    U  U  U  U  U  U  0 X X X X X X X X X
> > +	 *  Up:              U  U  U  U  U  U  1 X X X X X X X X X
> > +	 *
> > +	 *  U means address bits have not change in Range [Inbound_Addr, Up]
> > +	 *  X means bit 0 or 1.
> > +	 *
> > +	 *  Inbound_addr^Up  0  0  0  0  0  0  1 X X X X X X X X X
> > +	 *  Find first bit 1 pos from MSB, 2 ^ pos windows will cover
> > +	 *  [Inbound_Addr, Up] range.
>
> On what basis this size calculation is used?

Use to bar's base address and size. pci require size is 2^n
If set mmio space 0x1040..0x10a0 space, bar should be start from 0x1000,
size is at least 0x100 to cove 0x1040..0x10a0 space.

Frank

>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

