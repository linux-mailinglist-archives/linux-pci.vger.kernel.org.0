Return-Path: <linux-pci+bounces-36063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D78ADB5589A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 23:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A49567371
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 21:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A3A230BDF;
	Fri, 12 Sep 2025 21:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FnhBmorZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B764C81;
	Fri, 12 Sep 2025 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757713621; cv=fail; b=OKoQ3MxPUUC9ICHo0VAIQOg/3UH/FhQEvESnfxVYulpP1Ln08/XSXJbczCWfMSsIUTyBV0dvec1EAzNyh6CSTBPyvmYnHFU16oB3n5Sk9xdGTuXgWfwY70aqRjz8HiUDM4haER5PgEgj+eM6uO4Tj21S6DbPE+lVZLJ0gjGyFN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757713621; c=relaxed/simple;
	bh=s7IBDErDs8JUf3qQBYr+0IvwFQkqKnTAJymxZidCyxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Utc4NNvrC/PrYvT+aYs/OrlQJFP+N0yQPA11lH2CAyZh3ulmy/pAmfgHCNNM8gIU7Bye50a2FVf0RUjvHypuauN5b1VfRbUnrjj1YQl4eHhBjtB1aoHfMMC4vfbBj9q1qeVMJRKVcyGY2KDLbw3ODgW+UtmnaqBVw0xUktBCQaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FnhBmorZ; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7MnQiLWEwXYv6twkdkXVbE/nPZEONpDa9ed6NfImqWrkbn+xPBb0XvSiKc8u8hhlRmfc1zjlAYCVyoC7j/OB650xRzDIheT4oCGZhy0NU+rahuD18uX/8f3Jqr9vZjR5Jyu9cBlEKhtHerdPZdtl4HZQNCBkOM6BNSOLRN4QR23xHz0034pYEO05hugOkluDfJnbq4qmO0CqVZEvvpSHdvTCpUvUREU41ycKwddl+m2Hzti/duqOTvj+rgwfZN+7l4v4TqLYeoUAHFaPJy/rRUfQ8B+W6d7pj7vKz5QF7nSWUdXbcZGPzG1WgdGkwkzZuIL3Uelm2eyANvB9egMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VS8mlZtx3Rt0+5zMekxrquqv3fVr7hlxm6pBgfTQ/5g=;
 b=POanmEbevTUzZacdpasoVLi27PKhG86JqiUWr38P7l91ISAQ3mfhDFo+THzYlpDchgqCivcxStoJqQjK+xAwvP1StLf7PsrslgWNBdh+XxGVOWHghfNimUvmcQel/kS4ptym+vPkXJVuzk/zLw8jYSKGQxBV40ple4XWUqbWtsOggwb0S139JRGNhawNKdbAo/Y9Qx3M1xaUd8QMVyUe9OKTqZtv59JxwIPicxgAH/EUjCDJEHcKkPS3X9Q83T6KcXx5ckr4e3if5UUfcGFA060DmD5EuNLbFDOt9+0SnPkyNpKecGy7PlZHYGNU/4ZZASX8Gzn9Ee/h6T/u+7PUng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VS8mlZtx3Rt0+5zMekxrquqv3fVr7hlxm6pBgfTQ/5g=;
 b=FnhBmorZEuK7AIfYpfe1MQaNXJkijJS3KZib+PZdXOb69+rV++BQqk3XyDzf1eUMavuA9reN9OHClLfT9jtUGpuKf+r1fPhxAqDj6Y2fhQCtohyGDEeYVCe39clDJFcGBvgmeHEWoYlQnZFyo5ioMd1mjSBQTRSl4x5AOpEY2nQ+8sCNtjgd1VVMdJy6IzrHJptbIZgW8IJZuJRTY4LXIo/TdE1SUYgJrl06qLHk54QYXeaYbBS6AQOf3sJVatx98Pz6/4HN2vxWqZ0/zIdVBfbvTYKq9MdOdRaIwdICQHNOaCSleWsvJWuqIFToY0hbGERw7QWoT87WG1BLVvuoDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PAXPR04MB8815.eurprd04.prod.outlook.com (2603:10a6:102:20e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Fri, 12 Sep
 2025 21:46:50 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9115.015; Fri, 12 Sep 2025
 21:46:50 +0000
Date: Fri, 12 Sep 2025 17:46:43 -0400
From: Frank Li <Frank.li@nxp.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH 1/2] PCI: endpoint: Enhance pci_epf_alloc_space() and
 rename to pci_epf_set_inbound_space()
Message-ID: <aMSUww5/oLKWKer6@lizhi-Precision-Tower-5810>
References: <20250815-vntb_msi_doorbell-v1-0-32df6c4bf96c@nxp.com>
 <20250815-vntb_msi_doorbell-v1-1-32df6c4bf96c@nxp.com>
 <1624f0d5-4ee9-496d-b51e-0ad3ac1c00b9@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624f0d5-4ee9-496d-b51e-0ad3ac1c00b9@oracle.com>
X-ClientProxiedBy: PH8PR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:510:23c::9) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PAXPR04MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b924431-9ab6-4ea1-71dc-08ddf245e164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uPlIofkueF2JpQrDfwzi/nCzIRrhVLaQNmV5wA69Vlwdybom1MWevgtrtH9x?=
 =?us-ascii?Q?pRaitw40TnBm16DOXRH2TcqT9rwY6brVvTRCCX/lX3D5CGUVJL114BZDQtg0?=
 =?us-ascii?Q?MC3N4l4MdjMeGK01Qkjbpy5iseQiGkY2YkuNr5Qrrwy3g+3uMxSznJxpG6Ty?=
 =?us-ascii?Q?MXI0qKGa8EDNvlezbCLQiJVyBHQouP/VkHbGsFYSVjbvAzdExKCNEfmjawkS?=
 =?us-ascii?Q?S1fi6VR946UnH1+HyvbJj57Ii0w3N22BOli8tFoDMDY8gSC1sGOhLeEkUpMk?=
 =?us-ascii?Q?5PF0beeSO+SdvmG3oSCymP8En6v95dtSEoCw9DwhKlt7Cei+0mHn5kiTLhN5?=
 =?us-ascii?Q?zNdXdnTo+qXzbGd0FY4XlcvxF7q7WtrOJzI8RNaCgzlJkJ8Ud7/emq97bEfM?=
 =?us-ascii?Q?hbhOTVG20v4Kx8DzRf8wttBhS4BBudKa4OWOrVYBoGQhNhbalskIq+MvLxRy?=
 =?us-ascii?Q?MnqbGLW70Vl0AEWVMaN4H+0bPl5gl7yTn0uV6juxDe+IYFyM7NcA12owbUIy?=
 =?us-ascii?Q?8HQA8vyVgKLoekLK/r4VhWp+l/HOdZzPl+YbxUrA6QKw8hblVf+Qbhw2wA5v?=
 =?us-ascii?Q?gteIM6ZuPGoWX0fmYl3s7Sx2DlqLHN41acqDKyIJLxb95G0EtNoObdtjW7R4?=
 =?us-ascii?Q?oKJBBCaQJPSigzQ83vBfkFyBAywkte8ieR5ZH4mOHoCD3PD1wcMcskFCG5eB?=
 =?us-ascii?Q?z0zkYywsxJZlukS9m5myMkGHCPMV5Q6ohfcJqbkYhBQ1BnyZD9Mw/87OJye6?=
 =?us-ascii?Q?EFN7H8NpSHw5ZbtqySf351bTqDhEzE/3jVZJBsskp2ZXokz2nfPQ7xe+aJkd?=
 =?us-ascii?Q?xzEKvCkkmfuDJMJNBk3m5rbLpjcrHW9EEZaT42FX18Sz2518ZQGQWvyD+sjP?=
 =?us-ascii?Q?tFCbudxnKCHHOmwCVNNr4JDURRGL9UAzHtMA0mv58rsjhs3tzL+8l8uT4Eov?=
 =?us-ascii?Q?FLzoEfjb1UIBgqPT5bZbqEPp3NiPZJJ0klpw7fWi3Xo4op7qLE/Lbr8te5fr?=
 =?us-ascii?Q?V3s7e0OWrPsfJvEd0WtCln1DFAd3rEJRzym4Qeq1UWJ0qAs+GO8iY0tVDFfC?=
 =?us-ascii?Q?kJPWGprgZ1nZeyOqV2k4AelCD8ixSqJmWoMXcnrVvSNvcw97lSlSm64FY7LQ?=
 =?us-ascii?Q?7CdO8HDNwsziPMjTnJ6h32VI3l6QfGbmtu5EDJ7+wsB7jl6pQO4JP0wwIRFU?=
 =?us-ascii?Q?SZCwOqgM+V9BY4UvvFlPLEPdKhWv1PQds5mpICtIqXIk3Qd3Vwy1v9Q6EKkL?=
 =?us-ascii?Q?Ko6Kg1CkwrFPrT4euxHazsEmiZSLMzEQMzi3TYwqQcWI1gYjR8xaXx1yDqfp?=
 =?us-ascii?Q?IIArrA7anTFLVNtI6oW0FfTEBQSYQYcJqh+IbeErf7oT+LuywZEXaVuuYRWU?=
 =?us-ascii?Q?RYLStxSQAkmV34FAoPTWKjunR1lQ7l4U5uMZPbRtcbqXojwbM5195IyOVNkc?=
 =?us-ascii?Q?07luZMhaQVgfsxl+D+w314ZNgeOmVld3j87sSPwlBCR0CXRQ8PpyVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nbq8+VwplSv0D86ITsLr/dZkvgmpjtNKXDQKJw11wWj9l2KI98SDSh19p8XI?=
 =?us-ascii?Q?KrP32x7kBe+mzdRAMTiahD0TQS4bMkK66Ye4TqHQJU+4enzGKNP0/g6T2xH+?=
 =?us-ascii?Q?10Lk8u5BgSJhcTTpwHFl/vcYmpO6ZBNDBTwSrHNqj8Xuu8ao1phD/LkQGJV4?=
 =?us-ascii?Q?iyio7+vYxnSQqR9BDLM1KVP1JmeBYfKWI6Lt/1q7SEBlBofPGdMkVY2E6rcD?=
 =?us-ascii?Q?uwPjvORWk11bU0Dy5g8z0NTjnQPr7Lv4oSFZAA7sFH7pppFkfnluVcsD8QFr?=
 =?us-ascii?Q?LabLbtY1kTFV9GYPXu28Nz45iw+2NwYlKPLLTm7tbfMM2Y8JQvtuouN4sVrd?=
 =?us-ascii?Q?0bNMlOnMv0hIuMnMyObxlcDPKGqd4JDHLWgIoDV9QFZchodkuzLqDenWuNtv?=
 =?us-ascii?Q?gaPmypwqT0DaJ4HA4UlJB/afayYh/F91Zwy6wLCbbW9pjvUMKujlto9QrjIc?=
 =?us-ascii?Q?sTerUamTkDi2jLXZVFwJiqTt9HXRGNPFaY6Gg5PDI4xRGSNczZ/5H2Xcryx5?=
 =?us-ascii?Q?mMsjIcdQN7CcG8EReVetu+auIQFFkA91CbnNAxRKk8zndi4TXXWql8iEtc1w?=
 =?us-ascii?Q?7lDE1DW7xYt7LyusCx0zB/swZXEOei5I2P4+Srij4wBwVLNC9rDXnn8UAPwV?=
 =?us-ascii?Q?gVUE8T+/YBAtK773R1IXziQ5oCXAuG+YqrbtGpBrB6yyousj/2Xy0SbEWhxo?=
 =?us-ascii?Q?Y8Xwv16MPRC4wri7/CdaSwExRPtkxFMCXUPLIAm25PRoiLo6kO7sCstbmmoi?=
 =?us-ascii?Q?z4/06h/J6wyQmnMii5rnTUz0A4PxoBZGezzZ24WDwF7+zPtfjB4zSW5Pgvta?=
 =?us-ascii?Q?6uVa7GsFUoyBYa4lNRUbiL9ejBIdviRsnqAO44HTZiXvW3CUw5MpBqxkpXdI?=
 =?us-ascii?Q?rH3rqwtwdbcHCZE18NwI9d0PyGqoq+QGfZnEIQ/+ucShHC8nUjSLgD6G6kmx?=
 =?us-ascii?Q?wgV+5Yo+AGoIGhVVg471h/Ubspk+iGhfYiEBnht0c0fSu+xdupf7W/3RkQgI?=
 =?us-ascii?Q?3gxsDVUgNmcgcuRRLdx8r4FPiCujWFwFgNT7oMix5Ms4ZSwhnKPvAqhGHZdU?=
 =?us-ascii?Q?ea+4Gi6NlcLH+mWvu2fAfYqenBnXY62KpFAnDEK+QFFe2sA/q7QiQwxwMcpm?=
 =?us-ascii?Q?1Q3qXBQR3+066ceOaZTjmjl9rDQOtoDv+A37Wc0SOy7Rhru3b3WDNmUln9mu?=
 =?us-ascii?Q?pEE/jblcq8EEBAy29x9B77SbShYjva3HbJiMgYUtu/oCyYVOUo+pL5nnfChz?=
 =?us-ascii?Q?vEEEqp0lMQEXQIzGdD9OOfz1mGtQx8vjiBzCjWEIAg+sRBZfcdyGm8bcBpyO?=
 =?us-ascii?Q?numzIGZzkNTa5gu90yROdFfPnd4qlRfNuHbtdV4yqPBc284P4gBmDfK0l+QD?=
 =?us-ascii?Q?iuGONue2aAxoqo0oID27yWarfLbra4I8o96U7rf0riURqK6attORNe+1t0hI?=
 =?us-ascii?Q?UKnHrpXGUdtfZx8q5vdLjW0ifAcJ2n4Hl6hdHUJvQGrJ4pWgCTsGdFihZ+8/?=
 =?us-ascii?Q?nc7UmQ4C742Ag9lTDVt+jpSnpMvNuqn+8krKw/qlw1IG5BYovPqcQrV9dvCq?=
 =?us-ascii?Q?3OcVw5ITgTNNbfj58mp5Xoqrz0T7NPoUmIBEsTVd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b924431-9ab6-4ea1-71dc-08ddf245e164
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 21:46:50.7447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYtzfpbNahMYd5Zay6x1807+G6e++DL7kz0WWgStXvNdYWK1ZoYGD6MsXrlsevGwnna5D1PDMXc2lrAaV4vN0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8815

On Fri, Aug 29, 2025 at 10:51:56PM +0530, ALOK TIWARI wrote:
>
>
> On 8/16/2025 3:50 AM, Frank Li wrote:
> > +int pci_epf_set_inbound_space(struct pci_epf *epf, size_t size,
> > +			      enum pci_barno bar,
> > +			      const struct pci_epc_features *epc_features,
> > +			      enum pci_epc_interface_type type,
> > +			      bool from_memory,
> > +			      dma_addr_t inbound_addr)
> >   {
> >   	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
> >   	size_t aligned_size, align = epc_features->align;
> > @@ -270,7 +276,32 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
> >   	dma_addr_t phys_addr;
> >   	struct pci_epc *epc;
> >   	struct device *dev;
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
> > +	 */
> > +	if (!from_memory) {
> > +		int pos;
> > +
> > +		for (pos = sizeof(dma_addr_t) - 1; pos > 0; pos--)
> > +			if ((up ^ inbound_addr) & BIT_ULL(pos))
> > +				break;
> > +
>
> sizeof(dma_addr_t) returns bytes, not bits.
> so 7..1 time loop in enough here ?

good find.

Frank
>
> > +		size = 1 << pos;
> > +	}
> >   	if (size < 128)
> >   		size = 128;
> > @@ -283,7 +314,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
> >   		if (size > bar_fixed_size) {
> >   			dev_err(&epf->dev,
> >   				"requested BAR size is larger than fixed size\n");
> > -			return NULL;
> > +			return -EINVAL;
> >   		}
> >   		size = bar_fixed_size;
> >   	} else {
> > @@ -308,13 +339,25 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
> >   	}
> >   	dev = epc->dev.parent;
> > -	space = dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KERNEL);
> > -	if (!space) {
> > -		dev_err(dev, "failed to allocate mem space\n");
> > -		return NULL;
> > +
> > +	if (from_memory) {
> > +		space = dma_alloc_coherent(dev, aligned_size,
> > +					   &phys_addr, GFP_KERNEL);
> > +		if (!space) {
> > +			dev_err(dev, "failed to allocate mem space\n");
> > +			return -ENOMEM;
> > +		}
> > +	}
> > +
> > +	epf_bar[bar].phys_addr = from_memory ?
> > +			phys_addr : ALIGN_DOWN(inbound_addr, aligned_size);
> > +
> > +	if (!from_memory && (epf_bar[bar].phys_addr + size < up)) {
> > +		dev_err(&epf->dev,
> > +			"Given bar can't fit required inbound memory region\n");
>
> consider bar -> BAR
>
> > +		return -EINVAL;
> >   	}
>
>
> Thanks,
> Alok

