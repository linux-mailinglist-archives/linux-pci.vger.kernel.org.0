Return-Path: <linux-pci+bounces-10126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1650692DC92
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 01:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953BF1F271A9
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 23:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7B71527A7;
	Wed, 10 Jul 2024 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UrEKVL+1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EA0152798;
	Wed, 10 Jul 2024 23:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653798; cv=fail; b=uhjCEc4F8RT557V21Y9bLfe296Vpegd3DJMW7p0L+0UyakHKoV+Tsir+tWcFAyGfHfSnKm3JrCN050hI9ooxvCKglhOlEfeLUG1nkILKwKq6L+eSG6shoJ7UfWaW2QIUVx4uIIJhmMiTB0XJYl4w+wd2qh8aReV33XW9eFZnvc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653798; c=relaxed/simple;
	bh=RoxqLoOez/2RYpm6o+5bBXrZ4jizD7p5IPqWzq8+AzI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gKKzNgOiWNiGZjteTKTQxuINXh75fkaNnowemWNLfCtyOxsci4zaMfO6ISuFLvnWTePTtgxFul/e/FInKlJDOTAa/DAjGPT/mubXLNkrTKiEyKfYVtfw7eEgjra0H1h0fZzOZLx60NUOIBckVlXpCJdH7Hsy3Goko6fdbp4iGXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UrEKVL+1; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720653797; x=1752189797;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RoxqLoOez/2RYpm6o+5bBXrZ4jizD7p5IPqWzq8+AzI=;
  b=UrEKVL+1nJY0rAnT7GfxTQJ3FAwUfg/X3MpVmaRq8GrIBzrr0ETXfJnS
   RmRp1g1emGfpaHMj5SgiNgByX15rbjMKNkYHY1U0YBmn+7FBYdNjN7t8v
   M7HPCtfQa+k7JZQi1XXThacyUXZ47ib/e7IScEXHasd7Co/ByxUFA8nBL
   dt1Nm7jHNmhZdRal/q2J+Mrz2U1XdocWETzeS0Lx/6H7jB8sUFU4Vtfqv
   P9wUmkMcmxHRSGMMnFJ4mA+40dBblItXnCcjb0okXr7ZQD5rkua1D7uAs
   xVv4IQ0DtN+BESwkMfExIWkLZ1N7Gkj8RRb/3AS3gRTk40yIZUZGVBbzT
   g==;
X-CSE-ConnectionGUID: s0wC+3EwS86Y7xqiNGE0jA==
X-CSE-MsgGUID: MdWQetTESHalNZ4NGYn7Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18142242"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="18142242"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 16:23:10 -0700
X-CSE-ConnectionGUID: Kf0RqAYdQzWlIjnJOo9Z+w==
X-CSE-MsgGUID: A/vZzjnZTdKHdagFChi9ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48256105"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jul 2024 16:23:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 16:23:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 16:23:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 16:23:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkH6NzilnLaxrT87pDVx/Z/Gc4IPEKtQ9MZGduR6E8UHGUhuyO2Q4sm2UIlr3JAgk/d7dn1xo3Jkk6x/KJkJS92yXlVCMiSIuiXKUBB+SIox4GYqi3dwm8LFr1T7MsutreLACAGio+R7KjF6h41slYTwka5RRviwGVyd8jb1jPJZ73CTyfYBBxBnaVCKHxAkHxb6rTTWEhKVukg6HX8n16aQs8xO8y9uqaMZDxf5HPkNFtNmy6KPOw4tL5C9p6DdWcdqRP+V7i+2UbpHxreyNs2O1h9UjMTu80aXnM5WnJplqITNFYCMSCgtKuZvy4r35La7mz1GQYNn+TxOaty7lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2Aop+tG3S7CJ1rBwmgrugxsNpES0n3WVm+/3QW/Eyc=;
 b=kCLTYYM0tOwK2+FQmxUKXUnhXslXhu8EguN2fhj7KSe3uO93BxuR1Do87++3yHLEU1l680p2I02j09V4jY+ctvAu1SapZgfmHFMl0it3muPcxisNBb3/cSMQIoI1XcXOfOOVSLQmNxVS6usqo4ltNxcpb1N84DCunx0Ib2JMViBC4wOTXWoYap27iFero33l75y+KXcg5toZwTINB2mfghWa1us0DJ0sqwITtb84f68C7N10MS2OulV42fyFRAfXwqn7t05J4MhN2FG7ZM5taRjT316HqDL3wzNAWjl64I5xmEPROqDuP8B/iOQi021i8CnMVV5JmufkgLXrCKUsGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7594.namprd11.prod.outlook.com (2603:10b6:510:268::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 23:23:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7741.027; Wed, 10 Jul 2024
 23:23:04 +0000
Date: Wed, 10 Jul 2024 16:23:00 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Lukas Wunner <lukas@wunner.de>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, "David
 Howells" <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, David Woodhouse
	<dwmw2@infradead.org>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>
CC: <linuxarm@huawei.com>, David Box <david.e.box@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, "Li, Ming" <ming4.li@intel.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Alistair Francis <alistair.francis@wdc.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Damien Le Moal
	<dlemoal@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Dhaval Giani
	<dhaval.giani@amd.com>, Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, "Jerome
 Glisse" <jglisse@google.com>, Sean Christopherson <seanjc@google.com>,
	Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>
Subject: Re: [PATCH v2 10/18] PCI/CMA: Reauthenticate devices on reset and
 resume
Message-ID: <668f17d4553_6de2294ba@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1719771133.git.lukas@wunner.de>
 <bd850e8257552d47433bdb2e10fa9b0a49659a4e.1719771133.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bd850e8257552d47433bdb2e10fa9b0a49659a4e.1719771133.git.lukas@wunner.de>
X-ClientProxiedBy: MW4PR04CA0123.namprd04.prod.outlook.com
 (2603:10b6:303:84::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e32c83-6b6c-43fd-86d0-08dca1373fa7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SaEDD+YN3q7jhybxc+TvtkXN1H+XcPgSsX3Py2XnfTwpT5KweRuGGMjGY3RG?=
 =?us-ascii?Q?vuPtPlBMuaYIyc+lO9pC9YrQ3ZCPhVxXd2mYYWsXFbOfXnaPmYmZDAwClNX2?=
 =?us-ascii?Q?B/PTOez3r+8Cxlqcgdke4sf/BVSa6lgjfpYLtr+ygcIdmOz46lmbwpvgJT+Z?=
 =?us-ascii?Q?FAiQeXdhbBeuiRd+wlfuGTwDckrUwnZ12tY5H0MvRgseUgWYgzVzrxH8NavY?=
 =?us-ascii?Q?6cVO16DkS7mrbmD6gR6UQ9IOx58/BDyPRRnmbyK6YmvsTAPDQLOR3oF0wCH7?=
 =?us-ascii?Q?O3PAiYOzSdlT4mbIt5CxAZuX65gIAUNAp05gN20A2MO7Mf5vgWFwUJ/bun7T?=
 =?us-ascii?Q?eIvgg1P/DBdvKKHAnfMcccyxB1stt86wWRX6h0iKNfd78OtLV2IwQRdSjzp0?=
 =?us-ascii?Q?V9NVI7VMI/fOUIWMtQutxyt22IoSdFkPfbYyqB1Er/7st0glBlXt1CzHLDwA?=
 =?us-ascii?Q?lsxZblPyB9Y5dDw2mg/E8i9pdKrhEyEZomjZ5xxY4OmK3Nr17nbK2TJaYmre?=
 =?us-ascii?Q?xf8cUWoVS2VsObweF/7t+oBcELMYQted/gHm2Dkcv4XKAx5nXJjvfWl/LJVj?=
 =?us-ascii?Q?3H7EXOMjd/gMxWZbQRWZS1Vted2k8f+jf+p+/CqV30qVeb3ccVgNZMynIMO0?=
 =?us-ascii?Q?9JZH8avpQschCESq4CYA18kj2ogkiR+yns43dHybknNbUa6Vuh1UF95G0Nsx?=
 =?us-ascii?Q?xllWoWhOBMF+zDdnxUAYPXvkx1b354VGVAbTvY+mW9uxsIOzDVh+ugQENkXZ?=
 =?us-ascii?Q?kFlFdcHLwS7/H/dO2gShUzFBB/pLV1U9cnqVp+/Q9Qhj6P2fZJ0imYaf7YEN?=
 =?us-ascii?Q?ZZ7RKeu/PTKj5PSGrOTIxKxo91xl3XTZNTkgDCp0m5bMppYSp4MPEaKeoR4/?=
 =?us-ascii?Q?MQ/+YZ4D4+Ycb2jraKq8mRfuGAm4+3WkVAJ1gmV0nf7JFnPU84h4asMbqzMu?=
 =?us-ascii?Q?Iiw+leulC2pZuyRC9GLA5klQORf1WH+7++g2I5g2IZWt1KvVJFDMnU1GjT4c?=
 =?us-ascii?Q?LxATrT8JsJdzC0vzIQToXdygCRMZ6A+KQDGYvsLCS34FM3s6l4zg04qo8CDX?=
 =?us-ascii?Q?hhk3JW1lIySxE/UOoR5//wFkjAlJCxoFLb+tvinHYUZkC5t7oZe6KZNNjIVm?=
 =?us-ascii?Q?KzRinBZqF1qeBYPqgHbeKQ4eHpbkKBB4slWk68akSFvB1GDedEYew7yULltE?=
 =?us-ascii?Q?ox/9RHKQvlsqY4sijiGR/NADuFAl+PMmZ3TKV2JkfNnwwz7Axr5YBpqvKlqq?=
 =?us-ascii?Q?NBCMGWJZ62UfbqH0UpPDmeLL3YoSPW+S4p4PXQqLCqzo88+wIKBu0FnBmgB6?=
 =?us-ascii?Q?fPIeVziE/0u5vW/EquNC3VPPYj9pb2ElDcSQ+JPV/yPTrsgJDcohOaNSblPK?=
 =?us-ascii?Q?h9O4ZA69og7KKmDN2NciJ9qULb/V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DEc2OFIdQwCyFfeKDHcC1zPaEKJPxGHZ7c8Ukk0GfUO8UIp2fMrcOIqGizxb?=
 =?us-ascii?Q?/K0XPoyBlElYnVILJ0NAgljkhIAu9enJRgwJ6uuppJngLRvXLJPQqLjD/cnu?=
 =?us-ascii?Q?KsGCozbjT9wTtxHk77vdeGoffrLUXqGrW0qqchWkWP0h08fgP1eswlxAOZij?=
 =?us-ascii?Q?27b6k7sndBPbegAV4Az/MIKbVHhYKoCGqlJEKtuDaW8iWdg64t72B/m81w9Y?=
 =?us-ascii?Q?IZ0mwgPRh58umIUf5u2IIGUQJYyQTAQVGHwgqwFlvJ+4t8ySnOlFPkG4jtk8?=
 =?us-ascii?Q?nEOSjDmNgAQ4FtESMJoDHzUMFxvRf4bD465CKMXrcplB8p2Vs0vxCKTmEtC1?=
 =?us-ascii?Q?bnkxCORcBd0LiLEmdbnd0FDUW8XMO23My7Q93DzfAWFSmVB2Ch5NE2mhVB5Z?=
 =?us-ascii?Q?NmoR3QFKP0aUc4rHjA5AZ+9PU4bkJ2pKXjdbXta4g8w7TR9d1BVi1G+R93qj?=
 =?us-ascii?Q?F1WVyM2wipHXfuPN5yD16VmHAUVIT0/EHc/fgBl/KXQSM/7/Cb87CsWHjXcf?=
 =?us-ascii?Q?t6D3aQSWx2N3L4N1tsf+uAXwp2mtcvQM/QD/AGpQk0lHDIb/w9MNf1N/3qyd?=
 =?us-ascii?Q?lrgj1bbHlFPe1wkH4ZlH/vPGr4atVezLW+m9xKe/sH9BcZenRGO82iZlaHH3?=
 =?us-ascii?Q?b+i/mZ+STXPXn+sdGFQkaVHgCl8A9LMfJH02c+uYDb/9sjgCtI55YF9Vwkxu?=
 =?us-ascii?Q?7Kzpm1moIKcJfRyACmNVZIfKJD1BC8sbXMU23dfYLQ0KjNV8t53qlv8xKShD?=
 =?us-ascii?Q?pqp2NgL4bDUTosXx6YmidP6CkJG37NtoMQg39FfaC8MeRrZEwAmJF65lYLud?=
 =?us-ascii?Q?mbKFFck7MaI+Kdarcpa0lD6TXjNwIWdodc0oL7mhyQQUwAVqv4p57tLQhj2Q?=
 =?us-ascii?Q?NqSCPj8eymyjF1n1CxxCPKs9IZwY4IRtDMxrVxe/5f1lZrW0jgUMehKozrJ8?=
 =?us-ascii?Q?J2CqeDWSt3nCsmjgC0UVjPSM/poBeAkOEZj3++NSMcnW3Yism0BYRTMh3zfT?=
 =?us-ascii?Q?t6lQM0bdB8Zzwlng9+W5ccMMMQB0oBuT5B5GuKzeEOXGa3vsMKSv+BGik3zE?=
 =?us-ascii?Q?qokyrgie4om7VCR0ByTG0oL7+Zpp+uVMXPCt1IOcIn1sL2QJHaJafP/m9e3F?=
 =?us-ascii?Q?Vk+bx+7wyq3BRH8UONq+cMbd2TRiwoqjj0ELDWweFB46PVF/03Yah3iEjib7?=
 =?us-ascii?Q?xOJW97GDhMEr9hYrXfVJjdT6ISLtHoZDqRhtu07cSbuUCMhocXr/pyQono1G?=
 =?us-ascii?Q?PWh2Vgs5jZtVfU+R5Xf8JVfIWRn5nrzNUbb8RwYPS2bFNMCr8/PFka7q4iej?=
 =?us-ascii?Q?Y4PTIbBSP/URY90ehFXZ7WtIlzLhV8yuH3aqUmjM7Dc/Q51D5Tqc4rssj9yx?=
 =?us-ascii?Q?Pu1YjKPS5/WGLnA4ZDvYIs3kJdCoi+Co4SEa9n513aY86/As76fSt5CIRL+Z?=
 =?us-ascii?Q?2FS5NodwrAb4Eg6o4AhtaZ+pMZnhLqTulUF+rzxHI+xNRVtYTToQE6TZOyDq?=
 =?us-ascii?Q?PR/nl7mI34MaWLinqGfJ+UgMQHkfyEq1CV2ttnABeioWnaLDrjLTfIapTOvO?=
 =?us-ascii?Q?zM6umPcV72qOMozjRl0y+33RXC5rIAOFw+u73wVn//Y1QBzy+yKeeihC5A3p?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e32c83-6b6c-43fd-86d0-08dca1373fa7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 23:23:04.4304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMFiqYW5CKq2cHMMf4A0rXL0UJm30axui1GGbVXyek87mnfpVc6hgQSHoLiaY0JzgymZcw2WLaVLl8liewqVa1SMPICCglog8GqkvlxFVgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7594
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> CMA-SPDM state is lost when a device undergoes a Conventional Reset.
> (But not a Function Level Reset, PCIe r6.2 sec 6.6.2.)  A D3cold to D0
> transition implies a Conventional Reset (PCIe r6.2 sec 5.8).
> 
> Thus, reauthenticate devices on resume from D3cold and on recovery from
> a Secondary Bus Reset or DPC-induced Hot Reset.
> 
> The requirement to reauthenticate devices on resume from system sleep
> (and in the future reestablish IDE encryption) is the reason why SPDM

TSM "connect" state also needs to be managed over reset, so stay tuned
for some collaboration here.

> needs to be in-kernel:  During ->resume_noirq, which is the first phase
> after system sleep, the PCI core walks down the hierarchy, puts each
> device in D0, restores its config space and invokes the driver's
> ->resume_noirq callback.  The driver is afforded the right to access the
> device already during this phase.

I agree that CMA should be in kernel, it's not clear that authentication
needs to be automatic, and certainly not in a way that a driver can not
opt-out of.

What if a use case cares about resume time latency?  What if a driver
knows that authentication is only needed later in the resume flow? Seems
presumptious for the core to assume it knows best when authentication
needs to happen.

At a minimum I think pci_cma_reauthenticate() should do something like:

/* not previously authenticated skip authentication */
if (!spdm_state->authenticated)
	return;

...so that spdm capable devices can opt-out of automatic reauthentication.

