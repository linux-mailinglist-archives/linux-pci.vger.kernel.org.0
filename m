Return-Path: <linux-pci+bounces-4288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1DE86D859
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 01:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B4F1F234F7
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 00:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2671FAB;
	Fri,  1 Mar 2024 00:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dGI0D3UP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8BD23A7
	for <linux-pci@vger.kernel.org>; Fri,  1 Mar 2024 00:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709253207; cv=fail; b=alzBPH99brEhCJOIB6iWuLblxN4mr2+NxTNZ5kz5onWM4g54aRKbI8b46eD2Mr81f3D+57o3m9guJsFsOiPNiBjnMNXhxAAVe/f6AFzp2QD47Nf1oydxJYVo4H9rzZ5g4YjUJm654fw0cBurZ8pIdqE+nVFtOVD1A9zSULvuWis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709253207; c=relaxed/simple;
	bh=1dMosh754EzPP3yI84CLdu33eH4+sxhpC3G1LwIXqRA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lCcFj9scpsHkkHmhLz9zq3C7BXEMIRhQV+6cu7cUeMkgy8HAreBOxxsszSGwIfHYS6iw7zcLNRIhr3J3djjLpyrymaGAUrwjNEKTcoTU37co6/TaYeo0GXEh22M5SjM/khNLz8wxCKH98R1HUwHTQcgCz+4J9Uss3zk8W723kWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dGI0D3UP; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709253206; x=1740789206;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1dMosh754EzPP3yI84CLdu33eH4+sxhpC3G1LwIXqRA=;
  b=dGI0D3UPpmt3AitMxMZcIB+wvjTASX2pc9KlMUBk4ABF82XOHlZSP+CD
   yal+hPOtSoH0V9oAzU5onof/HUL0SBGvkydLICDWrebcojznY7YjoSqRt
   l4W/khADwBax9e58qmBhfus25YY9J9CBB9TQQ2P7oTNwXKtPSfUtxFt1y
   AN0rImFUmF1JHqLujtcb8PssCVUCatxBiKgp60/wel45Cmlx/f8DVRNO3
   s219tghRN7aY3+AR+OVtOU8n73+DbiB8u9xV4nqc8tXDLPPcu57aJh2T5
   F6gY7cCKTwawX6gqO47cpihxjuUfRaHakQwGSlT3cHICTUWXSEXuHUYkH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3886535"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3886535"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 16:33:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="31200264"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 16:33:25 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 16:33:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 16:33:24 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 16:33:23 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 16:33:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nySQWavGYtorKAn7nZqSwB2b6VDj432tq06FmUmQornvPXTTrKiaADtVSRH8hsJc+x/i0R9X0FNroOsrR4OP1xsyMQLmpfZ/VSXjUawkTc7KniATKbcXZofsWwa+mVX2baprGJ2ZIj9Kev8OOORm+eoVBIVQdTecMIuHTDDmgY/WynqBhyNyCWkvpmdd+DtpDNvC6BQ96GUNTF8UaKH93pTFdkAJPUFnG/dhVu4fE4XQSuXdbtXs5mtYlSzYGmtfUn0ixptVneoXcQHF/MRASLl5Pa51HmPpwvGA4sl7cFQJTKCWIrrDn3f/hnvjD4N90T7FxGaggzi0FZb3XpYbNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gZVeCmA2qKx8qIkIsqm2o1CbC6Wjz0jc7scQW9Ddzg=;
 b=jutJr5y0Y0SR+WDqQc5KyqT7U5sW16yAdSkWiQXeY6pmNGg7RqDmjktbwbHjRMH2TBpFuzAjswsHNHcARb+eHfpGTUD+dd1mQdAYoJFIENs3KxVTIKxfeiMe43I2iA8mbXt+VhO93VwwQ2fCjcn6NlJlpF3j3qV5SP5T3PWdgfMiCZHgEjmoTJOiY6pgxB/7gI1SgIBW/Zx+mc0Gdzg42+f5Lkw3QMhe+HJbm1yO0SEbYnY2K3U0yPsAxUkxkApu5N8vtSY89od5VT3sEHfKLvKwAUMoxDMrqoGVpVXZOduhKErxv9psI8WrleSWXCzzgQ1gegowWOwmwkj43KhWWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB7045.namprd11.prod.outlook.com (2603:10b6:510:217::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Fri, 1 Mar
 2024 00:32:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Fri, 1 Mar 2024
 00:32:53 +0000
Date: Thu, 29 Feb 2024 16:32:51 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Zhi Wang <zhiw@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Wu Hao <hao.wu@intel.com>, Yilun Xu
	<yilun.xu@intel.com>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <zhiwang@kernel.org>, <gdhanuskodi@nvidia.com>,
	<cjia@nvidia.com>, <acurrid@nvidia.com>
Subject: Re: [RFC PATCH 5/5] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <65e122333bedd_1138c72942b@dwillia2-xfh.jf.intel.com.notmuch>
References: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
 <170660665391.224441.13963835575448844460.stgit@dwillia2-xfh.jf.intel.com>
 <20240226133708.00005e8e.zhiw@nvidia.com>
 <65dd828e928d5_1138c7294b2@dwillia2-xfh.jf.intel.com.notmuch>
 <20240227215322.00001f46.zhiw@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240227215322.00001f46.zhiw@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:303:8e::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 078b2a75-4052-4aa2-316b-08dc39872216
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kR22T+kZYBcEfUam1Li41/12dQxtA98Q4pLSo4WU4thCfB1ebn/VVIhA2RkOjHefkE6X4KWOVSLfnIC7hcp/LDqXd2nk3swR7b+YvYD2mh6yPyg62escyyawehWslY7FjfL51H3arVsJZMj4KmcMOvFVvbWheNJQG5Tm6aQbBOWLmpfgbI21kyW17s4I1ksIZZfWCX47tZtfpS3ONdbekzSuBmlOaWxN/YdvM81ii2Mx9T6c4SXUq7zWKOCGDlzF1kUklbhmTPyvyzfYK8RC3RVMdATqxQiulTk7TiADdGe1tI09M9ukfLWOJOTnxYFsYO9mqnRpB0hy7xbmQPvQl8Z+adYYfgretTXiTDRT3CrpfSdsdtvHVmLRE7L+iQaTgWYRrfmtOE4tA7nLGIp+NpVF57fRmVtRNgGMvAjPess+XaJw4qhJ2V05iRHTdESz671kBcYpkJQka+3dzaJpSwNwIbzXvWc2gqW/SP9q4PrxffIC4A0UQrxWt3Q0+dakbiO7jM4VJHyiQUMwXWZBl8Q2RiwUMlr/9cL2kxzdU2mFwJdVOwNcVJFXMgTANwScYitetMMfBuJhJ4wyhheKUsjdO+bS5THwKYFO/sATIpo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N/IhFCbhvQm6UUJiF51X5Wg0IVtR8zMl2inbyxkaxc6V6YLKlIlyLyK8Oy4Z?=
 =?us-ascii?Q?oM+u/JxBecm5jlDc6yEIEEmHvoEYbmIXPAkdkx9hhALByhHYxRFT+1ASZgh9?=
 =?us-ascii?Q?lwdZ410FABY4bV+McrOy02URO/TRQ5fzUGYyfo5i5ktO47VQVk5FE9+nCDVK?=
 =?us-ascii?Q?Dt9vXES5755j0dTDNMJJIxHxT84DOzammWcomD4Q7DEl89Rx8t8sG78+w1jR?=
 =?us-ascii?Q?FheSX/8b19OfxcLTHwA8MCi0RUkmRGUXDZF4FDVFX5DiXeoUifuPHDfkS8G7?=
 =?us-ascii?Q?AwY+zR2mepiC2ofodS52isKHa+c0WWpf7SBpvx71H83nZOXzLNUcvIPxKLVq?=
 =?us-ascii?Q?RAlrgLu60AMhHCSDf2Xxlo/YFZhcAhPKoa1lZXH+VOH0pBRhoafuZ5ABl9u/?=
 =?us-ascii?Q?xt7p6kJJBKs5aj9UWLlfcm6xGZHzEhCWEW2q2uLE/kp7WAq+qvC8NX3edlD3?=
 =?us-ascii?Q?0VUbePtxhPJ6fLC0y1OQ13rgwgA/Y/aMmh+I16RFY7PA9gJ12rUorvnyN6eB?=
 =?us-ascii?Q?MJ+H4RJkS0gDH4oAXsInCXfL8DmK+r9wbTWKriBLj8d4G3ALNvPpDUshc6xv?=
 =?us-ascii?Q?rqaWDY7GyEyq8cMFZSiM8q6yuVzKllUOAnzb7TZGdtJcEufdPDPPSRDekcju?=
 =?us-ascii?Q?C03Tv4GxyyrJ0q8Afca2CEhjEsrp3l6vioJnasJ5o9N7V9zSHxNuoUKwYSle?=
 =?us-ascii?Q?JH3lBqi/s4T3Er3i1JFxqm9GjMnAkjNrXEHgs2RWUUDkEoVs6pN4EaGj5CyW?=
 =?us-ascii?Q?btVi7CfyC7GJspeYAY5wKZOFwaoSoZJKSjYP7NpSnFhYXHVFCK4B1Yjj/9Xt?=
 =?us-ascii?Q?VmGVElnf0bxnfvXlSoaqTaRlKxGThW84R2FVucArbx9cFFAb316fh+lu9rdK?=
 =?us-ascii?Q?9VKuGh66KTnD9isDztwsKB27hHNx6h1PfY+RHbvRzr1XQ+buiapd2qXZ/E/p?=
 =?us-ascii?Q?sgz74wJNDIJtiLFV7elIlmLmwgOckM79BY+TZjx6Ww2rzfC6/TWOre7hDPRb?=
 =?us-ascii?Q?gpzecKw91wgddJjON3DEZ36lf9N1s1itBHYXwax0IT9Wy9BSKoW8xUlTnJD0?=
 =?us-ascii?Q?5MVN51XFlIS2fDwQq9kbvwWGQTM++MDzjMjTxB9doQmBJhunT0npLkX2Wgil?=
 =?us-ascii?Q?LOT5yrSwH/onBuK0yoe+vDD0ztNsWK+EEy/qqRygi+ZSbuzbdcBN7MIYbaID?=
 =?us-ascii?Q?biTqFkLScuSnSENQ7iyU+GGu5MrpbnPXq5l4IsSgT8rF2k3dtLCfjMg/Y47T?=
 =?us-ascii?Q?t+eejzznRs3Tm+26rVLx190WbD1Ya6xNDKOxz0OCRsXXXSVxKVobDVrvJZDz?=
 =?us-ascii?Q?Calb2CTg0rnv1iNbClvQ+G1a4NNy0QN1SanAVX1DmSv5YRXmPpx0OUD+6Cis?=
 =?us-ascii?Q?YKvQn98tQFQD8IbwH/UDXZRVOOwIEQiIHIJW+B8tNkTcKl3fd2v9lX0l1erS?=
 =?us-ascii?Q?jsiOdyOoIDIvG/dZa/KjxnMpHbMFuUNiJrSnJLnDu/XGYTtTidY4P/B/q9CX?=
 =?us-ascii?Q?CAYCTjsZxwYUUrVXBBihkiQ+SmM0nGEvBohr/2FXnUYOrv0wQJFPZUqp4RUb?=
 =?us-ascii?Q?1aKgtYVsXRFdDkiZ7iEXUc+qe7AV9zpldPw8g+FTjVUJSVvY0CWTrvZ0yVfK?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 078b2a75-4052-4aa2-316b-08dc39872216
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 00:32:53.6957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RaOkKpxjnY1oOdijTyVwFnbgkfjO0hhY50ITw93iQPYwRRRZDhg8nVA/Za78fbPV7jESLY4u2hQgNu3n7PfDtpq91fzEz87A+Xgl6LlLLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7045
X-OriginatorOrg: intel.com

Zhi Wang wrote:
> On Mon, 26 Feb 2024 22:34:54 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Zhi Wang wrote:
> > [..]
> > > Hey Dan,
> > > 
> > > 1) What is the expectation of using the device connect and
> > > disconnect in the guest-driven secure I/O enlightenment?
> > 
> > "Connect" is state of the link that can be automatically maintained
> > over events like reset and error recovery. The guest is responsible
> > for Bind / Unbind.
> > 
> > Now, the host can optionally "Connect" in response to a "Bind" event,
> > but it is not clear that such a mechanism is needed. It likely is
> > going to depend on how error handling is implemented, and whether an
> > event that causes disconnect can be recovered. We may get there, but
> > likely not in the initial phases of the implementation.
> > 
> > > In the last device security meeting, you said the sysfs interface
> > > was mostly for higher level software stacks, like virt-manager. I
> > > was wondering what would be the picture looks like when coping these
> > > statement with the guest-driven model. Are we expecting the device
> > > connect triggered by QEMU when extracting the guest request from the
> > > secure channel in this case?
> > 
> > I think it is simplest for now if "Connect" is a pre-requisite for
> > guest-triggered "Bind".
> >
> 
> Thanks so much for the reply. 
> 
> IIUC, it means a guest assumes the device is in "connect" state when
> noticing a TDI, and it has the awareness that the "connect" state will
> be taken care by host until it needs to step in error recovery?
> 
> I am more thinking of how device driver talks with the PCI core.
> 
> +static int pci_tsm_connect(struct pci_dev *pdev)
> +{
> +	struct pci_tsm_req *req __free(req_free) = NULL;
> +
> +	/* opportunistic state checks to skip allocating a request */
> +	if (pdev->tsm->state >= PCI_TSM_CONNECT)
> +		return 0;
> +
> 
> As this patch is triggered by userspace through sysfs, I am wondering
> would it be a good idea to let the device driver step in around the
> device connect/disconnect flow in the future? as a device might needs to
> be switched to different states before it is ready to handle SPDM and
> IDE.

This capability needs a definite use case for the kernel to onboard the
complexity, and notifiers in general increase the maintenance burden.
This PCI/TSM proposal is that "connect" can happen independent of any
driver being loaded. If a driver wants to trigger reconnect after it
loads it can, but it is not clear why it would need to get its fingers
into the "connect" process itself. I.e. I would hope that at maximum an
endpoint driver just needs to see the results of "connect", or trigger
reconnect, not intercept the connect flow.

If the connect state is treated like a link state then it is reasonable
to expect that the PCI core restores the link after reset. If that is
the case then the driver's mechanism to trigger reconnect is to call
pci_reset_function() which implicitly handles reconnecting the device.

> Maybe the PCI core (pci_tsm_{connect, disconnect, error_handling}())
> should broadcast the event through a notifier when checking the connect
> state. An example kernel user of that notifier can forward the event to
> the userspace as udev events via PF_NETLINK.

Drivers can already register for ->reset_prepare() and ->reset_done()
notifiers. It would be great to not need to invent new notification
infrastructure, at least without an exceedingly good reason.

> > the attestation information needs to have multiple validation entry
> > points for userspace, PCI core, and endpoint drivers to each have a
> > chance to deploy some attestation policy. Some of these questions
> > will need have common answers developed between the native CMA
> > implementation and the TSM implementation since CMA needs to solve
> > some of ABI issues of making measurements available to attestation
> > agents.
> > 
> > At Plumbers I had been thinking "golden measurements" injected into
> > the kernel ahead of interface validation gives the kernel the most
> > autonomy, but questions about measurement nonce and other concerns
> > tempered my thinking there. Plenty to still talk about and navigate.
> 
> Yes. We had been discussing that a lot. :) I also carefully watched the
> playback of LPC Confidential MC, quite a lot nice discussions. Out
> of curiosity, were folks think eBPF a good fit or an overkill here? :)

Probably too early to settle that, we are still trying to figure out how
to log native measurements [1] and the logging mechanism [2]. eBPF only
comes after memcmp() is deemed insufficient, but even memcmp() needs to
plumb the measurements through an attestation mechanism.

[1]: http://lore.kernel.org/r/20240222154529.GA9465@wunner.de
[2]: http://lore.kernel.org/r/20240128212532.2754325-1-sameo@rivosinc.com

