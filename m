Return-Path: <linux-pci+bounces-40185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0C8C2EB81
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 02:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B28F34C5C6
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 01:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4BB217F56;
	Tue,  4 Nov 2025 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="OlXDsj+n"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011054.outbound.protection.outlook.com [40.107.74.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB2D1FC110;
	Tue,  4 Nov 2025 01:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762218843; cv=fail; b=e+BSvyeRFU7nHNxty2tF8Ut6w1newhRVugEzzZI7YzmK1Kbqbrj3GWRyjeCT94Fyr3KFsXHb++Q8AYw1HHO/Nk9WoT+R8pAY3v0OUw/HarjHAnMj7+endjTDbARSwtc5+YV3Gzt5WMFdWxUsd2yjMAPTpyc/suTXJ7Cze05hNvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762218843; c=relaxed/simple;
	bh=vXPPtZqZLzUL9clc5LEKgqCEi4MzwMn6deri05slHqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ElfUITyte4jirNn6KUlxqRKkn4Kh13COEihUrwynwtHKbljKg045bfbtPhWZEmN8HqXNAKY2iCifii528fhX7j2amekCKeJOwdJuY2AG6jJUJMvsRTmw0lMkr1NEhAgfHQk6G6++uZoJswvBxUGRpE+dRcP9JFHwVpJdVp//zdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=OlXDsj+n; arc=fail smtp.client-ip=40.107.74.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3AFILBh8pkilC5D9GDfc26eb6hhBvNsug2oVxbahxlTfZcZphw6oTgbkwZecOL9/nBYboNtE+mApZObOYVWw1MZr2OjFvIXRrsGJyt1UEjiVDNQOekjIKKEcE5wClheXO5PNUdrWTF7W+WJdCMt1t/eogpJJfFN0ZmvAp0Xi9n4tqcAlgPdqkV3AEakLYGHLqlqngfjeP59hg1roOq0v2JvQdkFgB+dP0Swd1l2gp+JLsQSoLiRIbfc6fhFhYewaxcZnNpTnm5piUHoEzx2MvcQVMx90C+H1h0ihJvMJmATdDrHgoSNr2m8yfEsSFh3g2Lv+thmH2fbihJdS60ZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9KfuVBT09xQXeEiLloqV77kgT9ei5NtJBXxangU/AY=;
 b=JexVw1FMEFXAsJ7YxBkFMseh8O76B6C7TGbia5W56Ea04v9fLhYA4Y+8JCqzjnZBz8AV/S4i1wT3d48hhbt7vm98KcbYrw3yGLcIEiSRbWp8DJIMz2FwIT6tBUb35+sYLA3PP46XNpKdrQ2uwd9gdrjs7LL1TolJLX9TtAtA6rJeb+x/R6fwMY3/iiemZhFojfnTxiwieMYOOOXa/XGoRWIotTAVcUH2qT/l7W6Riuix89bxHxCK7mQkxMGGvgzsihvW7y0g7qOpCNSp7/b+zPBOuGYIRsUoTkyiDjZenduBnXGCdyI7fcxYLjgyE7rtFJojpIbLlfl37NLbhKnkWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9KfuVBT09xQXeEiLloqV77kgT9ei5NtJBXxangU/AY=;
 b=OlXDsj+nE9o5CgYCphm1JyNOaocaUpbEGsuyUvlc+RuuCbeJ/573sW/Ppy8psQy0KWqmpMECqUjW+Lda1CSqTFq1kFm9lqeWjbnUro5K56AkthjZyZ59YcDx81G1IJ7qL5RdVXOnec1SEjZ3pxzIiP1FA8MWCaEWNdvk50uW32s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TY1P286MB3390.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 01:13:58 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 01:13:58 +0000
Date: Tue, 4 Nov 2025 10:13:56 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, 
	jbrunet@baylibre.com, lpieralisi@kernel.org, yebin10@huawei.com, 
	geert+renesas@glider.be, arnd@arndb.de
Subject: Re: [PATCH v2 6/6] PCI: endpoint: pci-epf-vntb: manage ntb_dev
 lifetime and fix vpci bus teardown
Message-ID: <tzr54an2wvrnf5vnhwkbafwgnik5evcssa2wskx5txhxtgqh6v@wy7dri5muaex>
References: <20251029080321.807943-1-den@valinux.co.jp>
 <20251029080321.807943-7-den@valinux.co.jp>
 <aQJGlOIJBY+44Q0v@lizhi-Precision-Tower-5810>
 <5qafrtm7qzjcrl5p3j6lovahjaspkehzgjjyvyzchms6dbzksw@hb7hm5uopvh3>
 <aQUTduGoQoUC+Upo@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQUTduGoQoUC+Upo@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0147.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::10) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TY1P286MB3390:EE_
X-MS-Office365-Filtering-Correlation-Id: 8555ae88-2804-4500-2f99-08de1b3f6df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hllNlq70yB+OMTCQdgm8NDRK85mGXiIDoAPUQoeKZK4t2SJqdu87n6Z6mB5R?=
 =?us-ascii?Q?o6OWdUI/fZPI7jQnQBdOzM2oYYJY55fI17wVlJloKWN8lYhe6zHJzal+J+Vg?=
 =?us-ascii?Q?gjuG4wmhaH4VXjeY4O4ZJSF3NzOwDTJUzrdGDqS1TPi8CRRPw7m64jVMSUtB?=
 =?us-ascii?Q?yoK6rtPT1mLjNBPHePEV9ZIgHHO0AKFVq1XyQqzV+ANfA5bm1pGrYDl2w1X5?=
 =?us-ascii?Q?7MPVhqPZ2Hw/3FBMvoXJP9JwTQr5wq2J1ammeolVpn0xchXVYUp2jTGDHDJH?=
 =?us-ascii?Q?qqHQRhYaq/OPIjgdEgl4ZVFfnTDSsQVnT+Ao04o4abEAhkWO47B1rj4hHld2?=
 =?us-ascii?Q?AUZFRTbY6NXC7h/0UVv6azQUvQfIVjsO3rXI+DyukWUOXoFFw8kBb1YZKU/E?=
 =?us-ascii?Q?sVSiFvYNNWRaI7WK3iMgH1ifYF73Ctb3DecKFH4JBLTidYAmLIFUEbPIu8bF?=
 =?us-ascii?Q?2mGD5H9ONHO5ybJRtN41/1vE1sY8mwT8tu3kuBmcQSL7DyRTyVaqudv6FSlP?=
 =?us-ascii?Q?5sqPPgjIS7OsJscEmVn6v22NYG9fpW63R5jXrQxcAOvwqVn4+n0eWmgplVuu?=
 =?us-ascii?Q?uu5WrNxuIMCmR1eTD3DTg9Mn50YDfNGtavxXwTQMSIvJ9TpH97m14wStufhh?=
 =?us-ascii?Q?n+vjFRcoUe+fkZJxnVPhT3PuVqLqYeR17MWrxWZcE1fm6yLg30/VGG+jNGx/?=
 =?us-ascii?Q?/zRyvHNgZ6Y/6ZuV1R3X5L6R9W2IgClxex7bhJ/fY9E9Nbg5c6ms2cR8Fcv/?=
 =?us-ascii?Q?pijjf85KJj7h2LUI1IHan8YM4FIH2+JO001vZhRpJRDiSjrx1WdrZmD5gl52?=
 =?us-ascii?Q?dP9rYQg0EHrlY0J6CPxrSLkt1dUb4CzPVdQQpW5NP0DN8zr6mim6rW5oyZwf?=
 =?us-ascii?Q?RLHL0Voabs+qosCI3ewf0nDOB34FTIvJTinmP7eArgrvU/2ZVuHL/rqggY5r?=
 =?us-ascii?Q?TiWbwnhYD1FVkHvK9UtQ3DYK8KBZxLW8PqJzhQzffmdpmxKaIigOslBSpzpr?=
 =?us-ascii?Q?XG5h3LOnalzVbszyXQGb6HZV3CwJpimCriAXFCymqJegiTAb4bNtr8S+/UFg?=
 =?us-ascii?Q?0Et6nA6yKsNVauOatMxDCdx9uDtjxld5ExIoOjFskFnQh3QslAg67n49Qqm9?=
 =?us-ascii?Q?tI+hLUiJNkxGpd3Pz9NR4U4cntDhG9LUTN2O0kFJyl62FwfqfIo+i8JI5OgD?=
 =?us-ascii?Q?2dzSjNPqdmfGDtrgVi3TKpiT25Jla8JzqQC7zu2TyDVXgDACa6BLQ3BYlGhR?=
 =?us-ascii?Q?QLvQXkL9ywwdQP7JJzTK7cV+fodv4BA/EhYVsxEiYIlXI9/PxFniKOaHzCgo?=
 =?us-ascii?Q?8uJQmzHdhd6VKKzke8X8HE/rU1F25XQx9UMhyupn9C1annyAzghGFhODMRxv?=
 =?us-ascii?Q?B1hr39Jz7J2dL+SHhhcLjvSnhqlFIMJCeqxL3jSI66f0wQqGSTWMwAREekZo?=
 =?us-ascii?Q?4URu01kqMMjo2PQwSu+CIj2rf3zWmOAp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FWSklgoKgUwYiTLOaKuk15Nj9BZZ9D+kknR1/GBSKSpXdPXAwF21xsm6FgkN?=
 =?us-ascii?Q?+BbBcK8qcu5G3vJwSKhyRcJF8AdaR+h675cNH1X+LyrL3SSUJw7SJyX1tgyh?=
 =?us-ascii?Q?lIw1U78dzZIv9Jsmok7OYb70Eh7f4KRU4YKJ/WLYACoVZ9CNE0lF9k7PzbWG?=
 =?us-ascii?Q?mYq6N3N3HicxedNjQw3K8s316qa4qmT1eP+uNjS3fGwlMd3VVEjDbY0yYHSs?=
 =?us-ascii?Q?l/iITi9sO+v4SXcgW3sg4oiwVZykYKIplWqt1E3uprgs8Qtv/wyx9lZGKokB?=
 =?us-ascii?Q?IP6mSO6vpKP7h/6Mh1IbB3bDIY1WIpLZWdIlUEoYj5AxfDm+Id+ySldudxHK?=
 =?us-ascii?Q?s9kjIMDtEdd8NgjjAdpm96gl14zYnRD6zgIRKT+QwCos3j8DiX4FfXkcNUOV?=
 =?us-ascii?Q?z7vJiPNFTMCUOahZj+REHeUkEPjre3lXWCvU3LCg3jocfUqWEtHqX1r2CvJf?=
 =?us-ascii?Q?sh5w3qGEY8IclnB+Tv1l+b7zNpdAR4FNTDSwTJXM8pjXj88T/IaOZ5xRIhlL?=
 =?us-ascii?Q?E2Quz42ez1tJ+AfUFwglDqnyPA9ZFWgc8clwywKjGvBST6rumDgqNZF1rNYU?=
 =?us-ascii?Q?zPzKi5/v53u1nhKjNmA9iqANA4gfW8ulPuFD2qf07soYTtARfD3gZplTL86U?=
 =?us-ascii?Q?t/PHzkPZU8eAeuDG9ARXW9yTiRDvhXCo/2wvk4sOLc8r9spj7MirpZ9HuwLO?=
 =?us-ascii?Q?vAlLDq7C4kKF6O59ZEuR/J06HQJO6+HXn6zac+p6jp3Uyn41uEoPoyYqOxOs?=
 =?us-ascii?Q?Ci5tgi68dkAfRktbDkcOm+wn63vmxueU+DR9oxOvJhID4FCXpeyGLW9Jh/1L?=
 =?us-ascii?Q?Aao1JhCLBBuPhXDkIVPZ2uZ+sUr16CggNAabyKUrg/IcTy/GehlaFgjl466q?=
 =?us-ascii?Q?JocPGLs2Yfo8w/z2PTH8syttlWe2LW1yU3zQTgAPd2xxngV3xXiA5FRIgcd9?=
 =?us-ascii?Q?fi/5qiCemdLBNWFU5Etkwhkl0iFaGv6PZGhD2BFUSUPOPgnknGHofPrbBdAt?=
 =?us-ascii?Q?Wo1IDf0dKd2KzzXasatdZsyTj0o4V0YyDZ0u/ifxsOgEdTO+CM7yCIP4JyIz?=
 =?us-ascii?Q?HIr3lGbXBk26oGzux9W7DwaGggPqVjs0zE76GSpAn5cPmqZ94WaCX+R8UZm7?=
 =?us-ascii?Q?gHzjvV57HlvNEfF7ZXNy1TvTkArhiPqS1evrFzpRKQNaNHKMV3t7LXqjijDT?=
 =?us-ascii?Q?/NEIE0P9RDbNv5x8HBuEgIFKJ8eHFrzyMzwRfZHEV8OfhieZPcrb0YesqXL1?=
 =?us-ascii?Q?twt4XSf7jg7XKjDNZxEmo8yJ7ymPU7YuaMaAtdBJiiZObjSLGIOiCX6SV3Em?=
 =?us-ascii?Q?mKLlsDUiv8I+zMrQBjtIwz9ncLOU5vQD3DGtb3+7VpC8kR1GoUHQILKJmf5K?=
 =?us-ascii?Q?FOMD/ZozOkjqUz4JeF93KlFG+46qOQ7age/Os46m2idek30EK3XCCue0+SH3?=
 =?us-ascii?Q?ZBjTmYivxYRhkSEN5XYCwG05jyln8RpkHTHVbeaY9hrgntfLF4rms6mJjTSr?=
 =?us-ascii?Q?KnbOjTxBj4Ye3qk9pPcw/F5THUHvGWGP9nXBuQeJGZq+vxFhgD36mnjedSdf?=
 =?us-ascii?Q?82A3JeN9oPXoHU5HiK+0gUqYdUHjrb4D47LSG0fCEBi/hb8JeZXUExTrTGLp?=
 =?us-ascii?Q?VRjWXlBueNgPQ+FEcu33xRw=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8555ae88-2804-4500-2f99-08de1b3f6df1
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 01:13:58.0613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/n8YK9zdRe/w04PwulL3TUJx2bpzcTVjRAiVvb4DtmzZpqMuAguls8J4tZrBNgtRf/8h81bRcorC8R0khXsqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P286MB3390

On Fri, Oct 31, 2025 at 03:52:22PM -0400, Frank Li wrote:
> On Thu, Oct 30, 2025 at 11:20:22AM +0900, Koichiro Den wrote:
> > On Wed, Oct 29, 2025 at 12:53:40PM -0400, Frank Li wrote:
> > > On Wed, Oct 29, 2025 at 05:03:21PM +0900, Koichiro Den wrote:
> > > > Currently ntb_dev is embedded in epf_ntb, while configfs allows starting
> > > > or stopping controller and linking or unlinking functions as you want.
> > > > In fact, re-linking and re-starting is not possible with the embedded
> > > > design and leads to oopses.
> > > >
> > > > Allocate ntb_dev with devm and add a .remove callback to the pci driver
> > > > that calls ntb_unregister_device(). This allows a fresh device to be
> > > > created on the next .bind call.
> > > >
> > > > With these changes, the controller can now be stopped, a function
> > > > unlinked, configfs settings updated, and the controller re-linked and
> > > > restarted without rebooting the endpoint, as long as the underlying
> > > > pci_epc_ops .stop() operation is non-destructive, and .start() can
> > > > restore normal operations.
> > > >
> > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > ---
> > > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 66 +++++++++++++++----
> > > >  1 file changed, 52 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > index 750a246f79c9..3059ed85a955 100644
> > > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > @@ -118,7 +118,7 @@ struct epf_ntb_ctrl {
> > > >  } __packed;
> > > >
> > > >  struct epf_ntb {
> > > > -	struct ntb_dev ntb;
> > > > +	struct ntb_dev *ntb;
> > > >  	struct pci_epf *epf;
> > > >  	struct config_group group;
> > > >
> > > > @@ -144,10 +144,16 @@ struct epf_ntb {
> > > >  	void __iomem *vpci_mw_addr[MAX_MW];
> > > >
> > > >  	struct delayed_work cmd_handler;
> > > > +
> > > > +	struct pci_bus *vpci_bus;
> > > >  };
> > > >
> > > >  #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
> > > > -#define ntb_ndev(__ntb) container_of(__ntb, struct epf_ntb, ntb)
> > > > +
> > > > +static inline struct epf_ntb *ntb_ndev(struct ntb_dev *ntb)
> > > > +{
> > > > +	return (struct epf_ntb *)ntb->pdev->sysdata;
> > > > +}
> > > >
> > > >  static struct pci_epf_header epf_ntb_header = {
> > > >  	.vendorid	= PCI_ANY_ID,
> > > > @@ -173,7 +179,7 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
> > > >  	else
> > > >  		ntb->reg->link_status &= ~LINK_STATUS_UP;
> > > >
> > > > -	ntb_link_event(&ntb->ntb);
> > > > +	ntb_link_event(ntb->ntb);
> > > >  	return 0;
> > > >  }
> > > >
> > > > @@ -261,7 +267,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
> > > >  	for (i = 1; i < ntb->db_count; i++) {
> > > >  		if (ntb->epf_db[i]) {
> > > >  			ntb->db |= 1 << (i - 1);
> > > > -			ntb_db_event(&ntb->ntb, i);
> > > > +			ntb_db_event(ntb->ntb, i);
> > > >  			ntb->epf_db[i] = 0;
> > > >  		}
> > > >  	}
> > > > @@ -1097,12 +1103,24 @@ static int vpci_scan_bus(void *sysdata)
> > > >  {
> > > >  	struct pci_bus *vpci_bus;
> > > >  	struct epf_ntb *ndev = sysdata;
> > > > -
> > > > -	vpci_bus = pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
> > > > +	LIST_HEAD(resources);
> > > > +	static struct resource busn_res = {
> > > > +		.start = 0,
> > > > +		.end = 255,
> > > > +		.flags = IORESOURCE_BUS,
> > > > +	};
> > > > +
> > > > +	pci_add_resource(&resources, &ioport_resource);
> > > > +	pci_add_resource(&resources, &iomem_resource);
> > > > +	pci_add_resource(&resources, &busn_res);
> > > > +
> > > > +	vpci_bus = pci_scan_root_bus(&ndev->epf->epc->dev, ndev->vbus_number,
> > > > +				     &vpci_ops, sysdata, &resources);
> > >
> > > look this part is not belong to this patch. just change API
> > > pci_scan_bus() to pci_scan_root_bus()?
> >
> > To make things work symmetrically and avoid crashes (when unlinking),
> > pci_scan_bus() needed to be switched to pci_scan_root_bus() to set the
> > parent device, like no longer existing pci_scan_bus_parented(). Otherwise,
> > pci_epf_unbind()->epf_ntb_unbind()->pci_remove_root_bus()->pci_bus_release_domain_nr()
> > would crash.
> >
> > Perhaps I should've added an explanation for this in the git commit message?
> 
> Can you create new patch just convert pci_scan_bus() to pci_scan_root_bus()
> and explanation at this new patch's commit message.

Ok, I'll do so. Let me respin the series later (v3).
Thanks for the review.

-Koichiro

> 
> Frank
> 
> >
> > Thanks for reviewing.
> >
> > -Koichiro
> >
> > >
> > > Frank
> > >
> > > >  	if (!vpci_bus) {
> > > >  		pr_err("create pci bus failed\n");
> > > >  		return -EINVAL;
> > > >  	}
> > > > +	ndev->vpci_bus = vpci_bus;
> > > >
> > > >  	pci_bus_add_devices(vpci_bus);
> > > >
> > > > @@ -1147,7 +1165,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
> > > >  	int ret;
> > > >  	struct device *dev;
> > > >
> > > > -	dev = &ntb->ntb.dev;
> > > > +	dev = &ntb->ntb->dev;
> > > >  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
> > > >  	epf_bar = &ntb->epf->bar[barno];
> > > >  	epf_bar->phys_addr = addr;
> > > > @@ -1247,7 +1265,7 @@ static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
> > > >  	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
> > > >  				PCI_IRQ_MSI, interrupt_num + 1);
> > > >  	if (ret)
> > > > -		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
> > > > +		dev_err(&ntb->ntb->dev, "Failed to raise IRQ\n");
> > > >
> > > >  	return ret;
> > > >  }
> > > > @@ -1334,9 +1352,12 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > >  	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
> > > >  	struct device *dev = &pdev->dev;
> > > >
> > > > -	ndev->ntb.pdev = pdev;
> > > > -	ndev->ntb.topo = NTB_TOPO_NONE;
> > > > -	ndev->ntb.ops =  &vntb_epf_ops;
> > > > +	ndev->ntb = devm_kzalloc(dev, sizeof(*ndev->ntb), GFP_KERNEL);
> > > > +	if (!ndev->ntb)
> > > > +		return -ENOMEM;
> > > > +	ndev->ntb->pdev = pdev;
> > > > +	ndev->ntb->topo = NTB_TOPO_NONE;
> > > > +	ndev->ntb->ops = &vntb_epf_ops;
> > > >
> > > >  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > > >  	if (ret) {
> > > > @@ -1344,7 +1365,7 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > >  		return ret;
> > > >  	}
> > > >
> > > > -	ret = ntb_register_device(&ndev->ntb);
> > > > +	ret = ntb_register_device(ndev->ntb);
> > > >  	if (ret) {
> > > >  		dev_err(dev, "Failed to register NTB device\n");
> > > >  		return ret;
> > > > @@ -1354,6 +1375,17 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > >  	return 0;
> > > >  }
> > > >
> > > > +static void pci_vntb_remove(struct pci_dev *pdev)
> > > > +{
> > > > +	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
> > > > +
> > > > +	if (!ndev || !ndev->ntb)
> > > > +		return;
> > > > +
> > > > +	ntb_unregister_device(ndev->ntb);
> > > > +	ndev->ntb = NULL;
> > > > +}
> > > > +
> > > >  static struct pci_device_id pci_vntb_table[] = {
> > > >  	{
> > > >  		PCI_DEVICE(0xffff, 0xffff),
> > > > @@ -1365,6 +1397,7 @@ static struct pci_driver vntb_pci_driver = {
> > > >  	.name           = "pci-vntb",
> > > >  	.id_table       = pci_vntb_table,
> > > >  	.probe          = pci_vntb_probe,
> > > > +	.remove         = pci_vntb_remove,
> > > >  };
> > > >
> > > >  /* ============ PCIe EPF Driver Bind ====================*/
> > > > @@ -1447,10 +1480,15 @@ static void epf_ntb_unbind(struct pci_epf *epf)
> > > >  {
> > > >  	struct epf_ntb *ntb = epf_get_drvdata(epf);
> > > >
> > > > +	pci_unregister_driver(&vntb_pci_driver);
> > > > +
> > > > +	pci_lock_rescan_remove();
> > > > +	pci_stop_root_bus(ntb->vpci_bus);
> > > > +	pci_remove_root_bus(ntb->vpci_bus);
> > > > +	pci_unlock_rescan_remove();
> > > > +
> > > >  	epf_ntb_epc_cleanup(ntb);
> > > >  	epf_ntb_config_spad_bar_free(ntb);
> > > > -
> > > > -	pci_unregister_driver(&vntb_pci_driver);
> > > >  }
> > > >
> > > >  // EPF driver probe
> > > > --
> > > > 2.48.1
> > > >

