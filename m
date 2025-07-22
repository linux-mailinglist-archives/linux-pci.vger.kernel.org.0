Return-Path: <linux-pci+bounces-32701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61724B0D121
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 07:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F515173188
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 05:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEDE2877FF;
	Tue, 22 Jul 2025 05:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E1QnBxNP"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE171DFD86;
	Tue, 22 Jul 2025 05:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753161443; cv=fail; b=GkaPlciFR8CrRAHfMF9V6bvUK2QaJgppLFdhQwSyQy21pl7kUnct9TDXWyq2ldWDufF0HMNYoRrkNF2CVKD4noPoM7qa+4rzC8AR+ru1XU6vQfHzyPRDihDDDHNM8n+ypbQXZc1sCJrFOW43S4m28575vNvXm/KmltDiFY1/iCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753161443; c=relaxed/simple;
	bh=nSl0zfdf/qtwcuod6+xOI4QT2Yqdw2C0Kk38OEoedx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hxC7RhGbnMXFyOutWDVxwyNUzNkQINPM5l2TEpBBz6DMWuhi4tnpOxLlIDJB2LmKXZYhCEIHfw5xcwjCkS7MDLOzlCkn6hEbS6i+f3WdAaTdOqAftug/eB4/h0rTnANh36Z5VilZg4hI8OyOBe0j3OfzMxP9RbFNpLNpiXgu98Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E1QnBxNP; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxlEdF+resZn/g5bf0NWm4a3P2DYToX2Jk4SMeobwLt42lV3KghWvsCgmBtuPteveAqLMZQ89MUtm4Nl44WYmI0tKThBmAR8sMl834YbdpqBo0FB8BGRyZdzCNONznKuOOIBdPHpIWZp7Su/XdDCDrd/zMCMoJ7YuPaATgmVOIm7T4Skpaf3ctJgWiJXgah+mCo0IgSc0vRLnz+ouIASPSbtUCzn+Pf/JC0Ow0kNb8P6uBiB2yMSofAqVrqygkKia6knXDRj19xm0ZQzoAylRm+kh5d2bIwG6pTUSPcrbKQVB0ZsUKqW++LZcOULhaHxiX9a4bhQKRLp6xLWgxT85Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLH+0+WuPvtg27T21iKWGZ2bowfz8mjGMgDr5EVeWiU=;
 b=oczCfAfv+2ONS3fJKLhvdjhVx4CtU2pDJ68RZVf81HwxX8CVQWt74a11cid33FMExtfv7CRowvFHAf9gr6GkRpRNT28RUKA+CHAiu/7JOn4ISFLU/FEBgpTXRaXIlJRHNtMMGKizY876/MpKUsc010ZbZ0FTzh3B2I2y82EwvqYBYORMROphdPhK5AYu40tXYwvnmMTR+hpJ0LyUaUd5Q2U9MA1ILvaJuAZWo3rFKjbnh9qyjqui6cMo1lsKS92/YaY7c4uAFbYn5jQGINMK3dgz/lOvk0mo9NfktaWLSeDmDotwg6A4Z2BcwTqqoTRmrv+zT4XtJSo+xcmCqCThOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLH+0+WuPvtg27T21iKWGZ2bowfz8mjGMgDr5EVeWiU=;
 b=E1QnBxNPOO6izOPIUR4pT5+Q/jq42s7oaHTn0TCkYtKDqhZe8Myc42VqXA5M0wz/yRDg6WdBgTeQ3QHaIQmehHGAvF61KGZzzRq7NGYGzRzZH8LLdp5bTQOFSa6r6/WZlOpxNRsvlRhTUQeQz1DO3Szqis5d7EYKkdNoApKdTV61CJdvYNFgc21LlSk9my54qvSfLdyirWz+aPArQP45Z6GiMEYmPYfsvVsIbglw4xBW/9JbESEQ/KPJlvzGdwa9QR6wt+mJ3d3WFnU5FfNSDjPN2PhwhW9+AZQ96JArO8SuSkQn54omy34uI0lwkHf2PiF8hei+dDfnL5fn/UbxAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Tue, 22 Jul
 2025 05:17:16 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 05:17:16 +0000
Date: Tue, 22 Jul 2025 15:17:09 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	John Hubbard <jhubbard@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: Update PCI binding safety comments and add
 inline compiler hint
Message-ID: <bwbern2t7k5fcj6zxze6bjpasu3t26n6dmfptlmhbhd7qmligs@3fgwifsw7qai>
References: <20250710022415.923972-1-apopple@nvidia.com>
 <DB87TX9Y5018.N1WDM8XRN74K@kernel.org>
 <DB9BF6WK8KMH.1RQOOMYBL6UAO@kernel.org>
 <DB9FUEJUOH3L.14CYPZ8YQT52E@kernel.org>
 <DB9H6HEF9CKG.2SAPXM8F9KOO3@kernel.org>
 <DB9IQAU4WPSP.XZL4ZDPT59KU@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9IQAU4WPSP.XZL4ZDPT59KU@kernel.org>
X-ClientProxiedBy: ME3PR01CA0062.ausprd01.prod.outlook.com
 (2603:10c6:220:1c2::12) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a272828-19cd-4682-7ddc-08ddc8df05aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YYUtVuVbtlPyOFxUDCI7+F7kUy8Fak9dLcci0vkFGMu3kFlN0gfIzOUSqxmL?=
 =?us-ascii?Q?MKIGZ+ky5vwxtaxdBqHss7fiEUp5GgAN4d1nzCb4iQnIILJBUB63AsaFNyhM?=
 =?us-ascii?Q?um+tdGkPhlieyxGDh0ZbJOrmEnmfXaEnT4RBaLL6/pejZXDSFZHIYDqNSIH4?=
 =?us-ascii?Q?jmTw39ZvZNaxOaqk6FiAQ9Et4acfTOnOElPlBL+46+4a3DeQb8K2dwhMpgpP?=
 =?us-ascii?Q?9elEZCEXNyXFnwFxU3JoWAbw6WkRqWuEilreJ6s6dndF2MnOZBH4PBJbQwBv?=
 =?us-ascii?Q?PXa9VUZK1q6BXnftflO0Y3NyqhxhSjXUWOm5zVz1RWOp4Q0n9lIUimX0h2Ly?=
 =?us-ascii?Q?vVsvoS/beu1eBlS+PNk+4XYuHFxpGX9E3+k/dYhUi6A36caPIvida7xSx7pc?=
 =?us-ascii?Q?OthSt0BulrTsJQnXvPCIzZuh30liJTyjGTloVlbLOE+FLgyl9hVYLuST5eBK?=
 =?us-ascii?Q?g33HE/1niPay5DiP8IrsbqaFIyCB5L29az1+uEoMj1bzhgAr5ePOqPsjbOUC?=
 =?us-ascii?Q?nx0sQgfVAqBVsdiRbqcv7nK0InjA+1I4H4ejeuEZERckObSW62FDRqXPJyFC?=
 =?us-ascii?Q?5qk5TDgbVn6vYi98880hWJcPo0yNtwms/8vlELpeLxbi5z6OTYTuoN86+6nw?=
 =?us-ascii?Q?4rf6ngXwKcmUiqQF0SLGoKJrdvVENE6jkJK7uYcAMJt/F2IS28jePuUEZRiD?=
 =?us-ascii?Q?zGNBZmR7vfIgFGzllmrQD+t8H4VpAwUkQfs+632e7dqBcR9Ti+MjqL9QJ96P?=
 =?us-ascii?Q?0APCcvaL28tLKj8xOKwxa5I4XLQDfR9p0BrroTwtDatvkelEp1io5O9BjSDr?=
 =?us-ascii?Q?CsikNes0+pM36Hs7DVfMlyIhJrSMwmnQoffDM1kgBSQgKAai3eVoeV4x/r8l?=
 =?us-ascii?Q?i42UiTVulGmgTaqeFYjpMDyBUI0kbW8jGdQyMZq4S8WuzQZvFsAmqmyTdAaO?=
 =?us-ascii?Q?QgjQEJBwFGRntoFkcmgqFNQwZyNm+HdpFQ7m/u0WxruH0cbeg3xWF6A63ZZP?=
 =?us-ascii?Q?2mTNZAtouLSWDnnE+ItWewYAtyhAOU6kLnnoC1fi97Krcl/AExdFtIZtSBKL?=
 =?us-ascii?Q?fhiox5NAKSyF7nA/YCS9Nhjgo3jk736lx4Q8Ws1UpFxuYtgjCKJCgWlIDl0w?=
 =?us-ascii?Q?SHZroVqNjrfvpc4DsmHwGRVndmP17i9ZJgXQHv23uKqZip1rrexUirDS9bv+?=
 =?us-ascii?Q?NteKo0O8t7a90s170trjycGCOBXLuRFIduISTTMrtAgKrnSIVFIkZe+a43YQ?=
 =?us-ascii?Q?U6yH7M/SRUAw3WTzcEVyuCZI8JuPybNpqtgH/w0ViNtkoFScVzRbgbV1zb/S?=
 =?us-ascii?Q?/GNj+XlaTZ9R5ZAmhRF95+B6ypojCPSCFD6NvUhaMpT8kvyILVqgKAi2RtDf?=
 =?us-ascii?Q?E73D9rNBPV2qZBcDmKMAmNmjerKkkFUErHtb1708VGblarUAJpUXOhEnXPFK?=
 =?us-ascii?Q?3sBxDki78PI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SKX7WlyHHZTLCB8i34Ce9jHKUePQcfscKjUaqGgNE5CqdDqoIFgl30XwHmkA?=
 =?us-ascii?Q?ZVGiQa4iZlS+LpeiBZMW9zIgI+Po1iQ2++yWA9Yu1H+3UBy6fTbV8Gi34jMb?=
 =?us-ascii?Q?EqIw8MUQydNbXZNbZF/y4BRIybS2iZrVHd0/mmk/Hdw8p/RkfFzOTB9UzmWH?=
 =?us-ascii?Q?QHmGK1cebd1xh7D744CO7lNaRoIFGBlQXCSIOAbNlNxXG4r8U1rs3qzWYxJY?=
 =?us-ascii?Q?KuDFy4bszdRghl0qvS0NTDhfqrYvY6zE5Ps6RD1gqWoH1Z6ngcJjJ2PnOrBC?=
 =?us-ascii?Q?+z3u6VEodHnASQlWAe5YIzEiaPSMI+F5LAFPJ0FWdyU8ZOMdfL4AN0Pd9iQ1?=
 =?us-ascii?Q?dJE/Dbcu/aDsQFT3QQp/HERiBYP3lujrzjns++4JWC/dGYxwDtlZCwljGgpJ?=
 =?us-ascii?Q?xNrmhxNTpQiXamJpcmECbPysZATbu7V4aBdgoI+ATx/Y7S+bk++JHIhxNccG?=
 =?us-ascii?Q?YNQzw6LdRKhXCYxvRNQiHgRXwv1gqpKfAMiG+qRYAV0JG+dT9F01g4bJ66Zb?=
 =?us-ascii?Q?QYoxCM5hT8T1LNJ9Ren972UTLRi2eZpbUrtaYhb62PhhH/emnqOnbQJ9Iroo?=
 =?us-ascii?Q?EfzFzMhc+eMhC+R6XInrroEG8ipnsrqPMRAdeF88nOcbSBXYFJkdzEXxgWpv?=
 =?us-ascii?Q?jclBTWymb7vLbQHqZivNKCeuPJhEIgFnx0yOK/ClD4lLSWrKqgQMCpUIJCAq?=
 =?us-ascii?Q?h9CUaIxq/QhT2FwQcJWVvh3GwQmwrEY+J8vyuXlWhJVY1pJY2Bh+ckXo8O4b?=
 =?us-ascii?Q?vcOPcDITpgetg5vgDImhCFTcJhP4YDcAlDc17CdQOZ65Tvc4b6M2nIQ70c3a?=
 =?us-ascii?Q?a6vH/xWwGBKaT+K5Qesj8CKBlCusKzgRud4BpNP/90hIroNiGSUAtAT9ofOF?=
 =?us-ascii?Q?xceOMRqu+jmLsPMHDbAAM3ul7H9NHBf8PVvPCz0U4Niod1/JtyaYIHahCAAn?=
 =?us-ascii?Q?EWb4mJAXmVuBtyl1yuFKkN5xrcabbmuqZVFu/dMMel1CoHkhikX3utviHrRB?=
 =?us-ascii?Q?9wEWFpnei9WGGxKeoZ3Jvwf2ra9q9pkrcTkOF6AaiMz/cYX2n0guthyKi+8t?=
 =?us-ascii?Q?xOLKazSCEtU7ScJwSl/zxroFBRiJqGwnc2DF+cxcRAfqIIFyAmAGIj7adeQl?=
 =?us-ascii?Q?ROJ8DXQWbhtRl+sMYcrOxigA7raeZEUqYgkUslGKaucoU1eMLV/aUupQK9zx?=
 =?us-ascii?Q?wMH0U/q9VvS6l/C7RMdntxrHR+RkQFewvoKRXN/PwcZACN5nPL7GOA63wAcp?=
 =?us-ascii?Q?keiLcCzLvKlCN0lWIHoZodkSfKPADBrY9GvYgz6yIQcA1QTSUbL33tFwHlTT?=
 =?us-ascii?Q?vwD+lrZBupCG4G7TDKXjJtmEUmZTyUf9NFCuuTdsTAAI+6hzs3P5SbPdIxAn?=
 =?us-ascii?Q?FREUJKyb60qQC579xcZc5pjdRJxmb7TwT50HgqX2YuJ/+DeG4royhtGU1S8h?=
 =?us-ascii?Q?uy/XHT8AB9PhyWzoOMrDSW/Tc5WtOPpreQy+MtXvUqKICCLJnThg1M5zxDpN?=
 =?us-ascii?Q?MA0J4zAG4fRwyzYKUNYIaEKGSrKm/SYTOnUB4PGcO5ggA5lSYF12KsGQOCeO?=
 =?us-ascii?Q?khMOBiCfteaPAAKciqFjhXRyEBqqhyyhQ9vu0Y2t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a272828-19cd-4682-7ddc-08ddc8df05aa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 05:17:15.9356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgM9A5+MXVHS38VOWsl5jlgItTvLTj+gm/L9lxTG2uNJdjJ/5UvSUqo0Df5KOOVLK1ojybSZsogI5wPS/tYrHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368

On Fri, Jul 11, 2025 at 10:46:13PM +0200, Benno Lossin wrote:
> On Fri Jul 11, 2025 at 9:33 PM CEST, Danilo Krummrich wrote:
> > On Fri Jul 11, 2025 at 8:30 PM CEST, Benno Lossin wrote:
> >> On Fri Jul 11, 2025 at 5:02 PM CEST, Danilo Krummrich wrote:
> >>> On Thu Jul 10, 2025 at 10:01 AM CEST, Benno Lossin wrote:
> >>>> On Thu Jul 10, 2025 at 4:24 AM CEST, Alistair Popple wrote:
> >>>>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> >>>>> index 8435f8132e38..5c35a66a5251 100644
> >>>>> --- a/rust/kernel/pci.rs
> >>>>> +++ b/rust/kernel/pci.rs
> >>>>> @@ -371,14 +371,18 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
> >>>>>  
> >>>>>  impl Device {
> >>>>>      /// Returns the PCI vendor ID.
> >>>>> +    #[inline]
> >>>>>      pub fn vendor_id(&self) -> u16 {
> >>>>> -        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
> >>>>> +        // SAFETY: by its type invariant `self.as_raw` is always a valid pointer to a
> >>>>
> >>>> s/by its type invariant/by the type invariants of `Self`,/
> >>>> s/always//
> >>>>
> >>>> Also, which invariant does this refer to? The only one that I can see
> >>>> is:
> >>>>
> >>>>     /// A [`Device`] instance represents a valid `struct device` created by the C portion of the kernel.
> >>>>
> >>>> And this doesn't say anything about the validity of `self.as_raw()`...
> >>>
> >>> Hm...why not? If an instance of Self always represents a valid struct pci_dev,
> >>> then consequently self.as_raw() can only be a valid pointer to a struct pci_dev,
> >>> no?
> >>
> >> While it's true, you need to look into the implementation of `as_raw`.
> >> It could very well return a null pointer...
> >>
> >> This is where we can use a `Guarantee` on that function. But since it's
> >> not shorter than `.0.get()`, I would just remove it.
> >
> > We have 15 to 20 as_raw() methods of this kind in the tree. If this really needs
> > a `Guarantee` to be clean, we should probably fix it up in a treewide change.
> >
> > as_raw() is a common pattern and everyone knows what it does, `.0.get()` seems
> > much less obvious.

Coming from a C kernel programming background I agree `.as_raw()` is more
obvious than `.0.get()`. However now I'm confused ... what if anything needs
changing to get these two small patches merged?

Thanks.

 - Alistair

> Yeah I guess then we need to do the treewide change... I don't have the
> bandwidth for that, we can probably make this a good-first-issue.
> 
> ---
> Cheers,
> Benno

