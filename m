Return-Path: <linux-pci+bounces-9975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D9E92AF48
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 07:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B22B20FF7
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 05:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CD712D1FD;
	Tue,  9 Jul 2024 05:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ut6NsRFx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F1F839E4;
	Tue,  9 Jul 2024 05:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720501801; cv=fail; b=PgBTQt37dGGzDIK0jS9eqCW7QdPYmwA6BfQc8cOG1gj8w1b2eAPfXaPM7aI+QGpIQ6/1Yi+K+APFS/u2+p0NPs3pXQNTTJPUZVcYYDGImLSJYTkNHabtyXQj0PgO1riRTb5noCNS4GTSTZuY/GxhYiNQQqZRyYK82LJsp8ldep4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720501801; c=relaxed/simple;
	bh=tvt7LQBro+OpU1RAoY6TWyJFz6DW0J37tfZPw/+orlE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iWsjoCUQpOywraiFe18boeHuLkf7W6uq7jgvGMU1wJCli4+5GO157SReYlkz7ZNofbYnVy+PgjliyMUJaskLHAxr6UDsWNLxG/OEihf/Ezxaky78FEtwGmmbqp7/WERgtxNgei0+/Tc3vRMOvIwLizI4++ihibeHNIJmzCdp8l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ut6NsRFx; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720501798; x=1752037798;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tvt7LQBro+OpU1RAoY6TWyJFz6DW0J37tfZPw/+orlE=;
  b=Ut6NsRFxYV+ZH0AsID9/AxKYcHRZ0EeS8gaaxth9Z0+mpZ8FUxyqgwQQ
   Uhp7QnCAk3KL1U3sJIN5HGZNqclFj7OJ1eHWYB/b7VnXCGyTiNnpKVrZB
   982c+GTDXIOQ4UFFgdj8emB/Tjx/tTSFFB3aZTVGpPJFJahjuhVGOkkNc
   holtJ5NcFHcijUrVwiyPk1De425ARwl7j4f34BdMNSSCDg9t1zSCX8AbU
   qxkbxBfmVrNWFUAlRdLGe39mF/7RNBPlCtTTUO1dAuDKmhpR8K2lS5Xfj
   kZZ574IgsUbMcMBGVurFI81IURG6Q2Avhk1FKIIT7z6j01UuJhLFgoqpr
   w==;
X-CSE-ConnectionGUID: Y4Xy+Ru+SGOkDwL2uTOiig==
X-CSE-MsgGUID: Qm+VDFzfSd6JjaD7hKYkXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17867361"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="17867361"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 22:09:57 -0700
X-CSE-ConnectionGUID: nyRIpGPpTFWg33E/EO8tYg==
X-CSE-MsgGUID: Lj8sG6hNTguPOumN6Z6cpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="48148725"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 22:09:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 22:09:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 22:09:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 22:09:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 22:09:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBKnBRKNB01x0IiewMZOMS+JfP3MvAJv0P/UwFgPs6XBr4JvBU/AKyAVpVDgVpVfJyOj7SZS8yxGw+o69b6K5s34dmKVHPnODlu+DZDbsUEOB/yiHVdIMU3mXJWPZm64a+lHjBGSH4W2rc3MWt3y6VO/LQ3YnHtPqAM29wgpx0do+V4sIkyFgZEbiF+69O1++FQTrwzd5f5PRrTzOvqcrWXLBzcn8n6YDYGj5+rZGC/sNVtZ775yC2S/mAmS8914kM7dHb3yiiG3Rv+411npzW1nGzW61ISCkbmF3u3wPH220WvKkUccNRlfZAHMuRWP2v27jypobqkT/wxwX5C0Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zm9FLHOi3s1GUwD4v5lDk5v57TP468nayIMeYUEnuA=;
 b=N1WKxuJpa5jWM/d9VoYDLnc8h0x0uYB4UUyL+Us/vNQ76vrBV+nUVCG/q8X8tE6w3J4LvQR1mz2SXOoWKZe1uTaJ/y8fip5ynTzdPcSmxQVMU5jX9aKmT/nrj5x8ZPP+bUFEduZ8K0ThQfChKCEJ0qVLP2aV46vZBy5+q7FUmUeWiXNDJw1AyMXsGUE/6iyhJA3xfGQ9xTZT2lJZ/0lH6kcadAQDiJsIxS5jFcwMKCe91uSj8Amo+t5ClidTbV3iETZjmmyjEWZG1MyORKgOiyH7pirU5Jvdp4pOC7vAcgX7U+54fvJGmer8hp68Lwt2kweutA5R5lZ4cC1+E9V5tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6404.namprd11.prod.outlook.com (2603:10b6:510:1f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 05:09:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7741.027; Tue, 9 Jul 2024
 05:09:51 +0000
Date: Mon, 8 Jul 2024 22:09:47 -0700
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
	Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>, "Eric
 Biggers" <ebiggers@google.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 07/18] spdm: Introduce library to authenticate devices
Message-ID: <668cc61b230c4_102cc294c4@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1719771133.git.lukas@wunner.de>
 <bbbea6e1b7d27463243a0fcb871ad2953312fe3a.1719771133.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bbbea6e1b7d27463243a0fcb871ad2953312fe3a.1719771133.git.lukas@wunner.de>
X-ClientProxiedBy: MW4PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:303:b9::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd3f873-3e50-435c-800d-08dc9fd55cd5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ChUeBmYH5FBWv2qhatqYB51PWBd/CRO1Qbmrsm+yfKrARorgYosk9snywqok?=
 =?us-ascii?Q?49aF02KNHedNG51j0gd0iexCNaDHibd3nZHWYxhHK8eg8mfsOp2FFpV4Qtol?=
 =?us-ascii?Q?KZNCMhoMmm0x+exoG1QwMj0KxHY10vC+3RPiq7nbcxmjJTjySmmRf6Q0V+iW?=
 =?us-ascii?Q?65cASqN6CmpXNkowurfx9U6gBf32Efbm1BLtH4GZSJecV1ffXPvsHu/avwzN?=
 =?us-ascii?Q?zFLmxtQKQw9g4M9E7znU5Or2TjfstJHkc5QvSgLN4wGTFaI7unMC5PPh5fLR?=
 =?us-ascii?Q?QDtu/FgHfVkw+CcmMo39K+cgS59+ShyQKxAl3S2gu618D0w1x8bMwpOnqFcZ?=
 =?us-ascii?Q?Q7okAdol3WygzCnYFsFMcP5SqucdF8dZF1AdvMk8siMQUOZ6ytyObC00TgJi?=
 =?us-ascii?Q?6QpOuZ0DC0dXf6RJ5gwseUHVAgbUsWZjTXsF9c6zRxsLjOJ0KfHNhCgF+haU?=
 =?us-ascii?Q?r3QKFS2KilnTVuc5XtVWf5irthdyBAU2YHhRYnpNxdCzwdcSv5EHfsa9nO54?=
 =?us-ascii?Q?nIKfVpm37Hmm07pbRCeXB8WwyTrAWcMsFPTHI9w/QtgYvfp/bucU53NXqIP+?=
 =?us-ascii?Q?XRCuOUqwuZfUpoX6HngVAp6ak3IeSb0pDiAP93buGwbCoeJXKVw3LPP0M1HX?=
 =?us-ascii?Q?7X0jXx8k+pAClFqxj7NOLP+NQAO/5WduMZWxpjJA0aBZiV7YpxcDjrHkvy48?=
 =?us-ascii?Q?KYtaq0CV5bqxlhJNNDdbNrRNfJaJgFxCoi2cAHYsZDa3MkGhKcW+S4cpovRH?=
 =?us-ascii?Q?tiyT4m4l1zC85YDeYU5B3cFqdEkTl1Rjm695rCSEJbUI6QeHMQlfYZQa8lqB?=
 =?us-ascii?Q?O/F7fYeDY29UQe8IofagUUbQte+/8Jsd6T9f21YOifRCKqBYLLrPKIhTh8nD?=
 =?us-ascii?Q?i8kRwp7UyRp2Z1mk71dekjWurd4epbQkYfROtzLiZcUBWX2HntR2BtbzZyAw?=
 =?us-ascii?Q?k/GUN8dhcclbzzmyR1VOSDcUcL5S3OyejinPKLlx7VKl4rQMFg1miOR6xfPC?=
 =?us-ascii?Q?fMD8rixk1LM/R6fSEp6syn1xA1HAiHDEuIGQ3u/L06O3jV/sNCTlirPvgCr3?=
 =?us-ascii?Q?rcjzlevcJmOZ+1+/r8eeVzLjlrIwvhXsc44AeO9rc+XrxZBWY4me3faqS5Dt?=
 =?us-ascii?Q?Xe44B0oDLwSPTR/o5Kxi8xubXG1S9mfHjVFd+Sz5tva4F6m4ixIMPjJJWO/q?=
 =?us-ascii?Q?QEtgsJenNooRBxy5KdAZ0Yr6adw3UZZGBSK3BbEuK6pLSXE9ORIbjmoBpvtL?=
 =?us-ascii?Q?rnAVxq5NwpW2SRzvuOdbntQT3s4hOW1MeNCbfy8qnXdLXmEhx1hPSuOyGPc8?=
 =?us-ascii?Q?CI5qDlnE7bfPZYfS9BJ9p+ealJ/qtzT7YFPVQTyAUgllgxlkRY6oqFnaTRt2?=
 =?us-ascii?Q?Mp7DX44=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y/PkG62F8z1FqkyJD7orQ3ZPG/Mmp17rj0za9wqb43rMrSvMC/KOrgg+TrY2?=
 =?us-ascii?Q?8SakNGR3Bi1lism25VLoiPB/UDhXfEuasOBqCVKMF4TJjioveETbqLrnTxPU?=
 =?us-ascii?Q?DIptMQhHpg3J3cXOutvLxLvSG/3Fsa6Bv7Wnwi2Ae45Ts4/bNETIKdaHdCjz?=
 =?us-ascii?Q?jIBH3ebi1DvUJZ7hhJXttlhjZC+tkljJemDbkt+pA/Pd5EXQB92WJRTPL92f?=
 =?us-ascii?Q?aFQzI/lYIXXavqMemuOc0VWmRPO3rcKzUe/yKrRpJcDuKLq45Gf8gWA8I1Ys?=
 =?us-ascii?Q?DGJwEV+ciI//g99+tsfpfh74sy+0IGbLqLQfvDFC84doh8YZ4BvbRMqClxWE?=
 =?us-ascii?Q?ZkOvBRyC1UxtFyrCgz4OVWFAMPYIO6lsyN4Tfdat0wULQemYGrOCw2J5tOZa?=
 =?us-ascii?Q?NTVxc2b8ohu+BsDBRinStIhLpTEZXppS6mgNa1pl0ZNmZgNNAm5mh0Vp98Xl?=
 =?us-ascii?Q?E5we6VLqotglhnQpVdLQbEaehsnvCTkoKFwsUGNH7TuEn1oPRVsJzisSiiUS?=
 =?us-ascii?Q?cHNGAO8PUgVO0709RBeN4BGNDa8fofm1AS7beKjTFT3woG56u1HRr1LmMQNN?=
 =?us-ascii?Q?h1SGasaEl3LfF+/wGYDvscgzhS3gTwyLh6yTsLwQtrhYPMIJWw0RRarAafEY?=
 =?us-ascii?Q?6J+yGJMKBFnX2A+nS3yebv5kVFW9ktyjRDE/n+lPXyJ5LKVAPaPzPy5b2o9A?=
 =?us-ascii?Q?RrLFEHRjwqyYd7KD239I+ZZdOXJJOQAHmkgO38krpfHJp+jW9S4Q0fNM4RJO?=
 =?us-ascii?Q?AmqdSuwlYmEUantiWlO2sWuQHMCSvHQZKYk8Mq0QJ8PAHal+mY++4PLHcY8p?=
 =?us-ascii?Q?jl5o9cWI4ODj/fxnOLm7lMRmJ2eqpBtuwc75r+7XXtyjK6SHoxjebVWOy3Dw?=
 =?us-ascii?Q?xuFK62JMazJv0VydaXB+1Wnmo4S03kGm77pv2TOpwt6vyi3xI43B433PkXPq?=
 =?us-ascii?Q?lUT1vnmSAyo/kINRVlG67zcNqWjKw9K7mrog8URpX7F3f7vC/Io0VZhIjzY2?=
 =?us-ascii?Q?z1MxqGs5L3WqnNgSTKwPZREHRHJgCR0uIRookZ9Xbccco4Ljur4i4qmAd1M6?=
 =?us-ascii?Q?LBh3uH7nlTEsnLncPmQBU1hA5wWP3ux/c7uUp4c4IinfEzIygujysedp0Fhw?=
 =?us-ascii?Q?j8ZPvTBJWIiMVbyOOFNehxt8Kjl05NrK47qW479ER2//6FLD9KhmfuP2s9sn?=
 =?us-ascii?Q?imcnGpJ17psshg+9MKjLD0hqqrHTQGqyUFMyv/pvSKsK9dY2DbFccVIT45ck?=
 =?us-ascii?Q?VfBrvrtUr+UdZhrmUDvTxMMZ1tYzEEyRj0b1hDZeqtmEM1TPjdEvoAZp2Vc9?=
 =?us-ascii?Q?BaULs5nc5VM9waBvUFhL7+SgEb/hnp1rcZZkmvgOSnPVD2ry8eGMe5V2Vykn?=
 =?us-ascii?Q?G8rdpSroEuRRCp7HogphfSHX/HXj7qqZoliYfxdU9xRiEjHHLSCAM1hbiFAb?=
 =?us-ascii?Q?qHhms0Ldt1Sr6wabNzT+JLKKk9x6/AA6HwcpLMNER4QRpBYFxUYS8906mura?=
 =?us-ascii?Q?LX3jXP3P5bwEG0W+UHgX+goriuVJj8QjYffyMTKTtfGrqWiaKEeOqM9+vd0Y?=
 =?us-ascii?Q?miH2uMG3jX95CZiP8g45aUdguldKYQTvWjVZKzK7vALdKAXkMPJID02lybCX?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd3f873-3e50-435c-800d-08dc9fd55cd5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 05:09:51.6625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z52G26AY9VwbCUOMCl5zHtiUTN3Khx67krHD1OVJrJuqZ+o+NEH+0mOaFhQ71Lw0BjdxybFIuBas3EM59MrO6Zip1VeRZoNY6WTH+8bUw70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6404
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The Security Protocol and Data Model (SPDM) allows for device
> authentication, measurement, key exchange and encrypted sessions.
> 
> SPDM was conceived by the Distributed Management Task Force (DMTF).
> Its specification defines a request/response protocol spoken between
> host and attached devices over a variety of transports:
> 
>   https://www.dmtf.org/dsp/DSP0274
> 
> This implementation supports SPDM 1.0 through 1.3 (the latest version).
> It is designed to be transport-agnostic as the kernel already supports
> four different SPDM-capable transports:
> 
> * PCIe Data Object Exchange, which is a mailbox in PCI config space
>   (PCIe r6.2 sec 6.30, drivers/pci/doe.c)
> * Management Component Transport Protocol
>   (MCTP, Documentation/networking/mctp.rst)
> * TCP/IP (in draft stage)
>   https://www.dmtf.org/sites/default/files/standards/documents/DSP0287_1.0.0WIP99.pdf
> * SCSI and ATA (in draft stage)
>   "SECURITY PROTOCOL IN/OUT" and "TRUSTED SEND/RECEIVE" commands
> 
> Use cases for SPDM include, but are not limited to:
> 
> * PCIe Component Measurement and Authentication (PCIe r6.2 sec 6.31)
> * Compute Express Link (CXL r3.0 sec 14.11.6)
> * Open Compute Project (Attestation of System Components v1.0)
>   https://www.opencompute.org/documents/attestation-v1-0-20201104-pdf
> * Open Compute Project (Datacenter NVMe SSD Specification v2.0)
>   https://www.opencompute.org/documents/datacenter-nvme-ssd-specification-v2-0r21-pdf
> 
> The initial focus of this implementation is enabling PCIe CMA device
> authentication.  As such, only a subset of the SPDM specification is
> contained herein, namely the request/response sequence GET_VERSION,
> GET_CAPABILITIES, NEGOTIATE_ALGORITHMS, GET_DIGESTS, GET_CERTIFICATE
> and CHALLENGE.
> 
> This sequence first negotiates the SPDM protocol version, capabilities
> and algorithms with the device.  It then retrieves the up to eight
> certificate chains which may be provisioned on the device.  Finally it
> performs challenge-response authentication with the device using one of
> those eight certificate chains and the algorithms negotiated before.
> The challenge-response authentication comprises computing a hash over
> all exchanged messages to detect modification by a man-in-the-middle
> or media error.  The hash is then signed with the device's private key
> and the resulting signature is verified by the kernel using the device's
> public key from the certificate chain.  Nonces are included in the
> message sequence to protect against replay attacks.
> 
> A simple API is provided for subsystems wishing to authenticate devices:
> spdm_create(), spdm_authenticate() (can be called repeatedly for
> reauthentication) and spdm_destroy().  Certificates presented by devices
> are validated against an in-kernel keyring of trusted root certificates.
> A pointer to the keyring is passed to spdm_create().
> 
> The set of supported cryptographic algorithms is limited to those
> declared mandatory in PCIe r6.2 sec 6.31.3.  Adding more algorithms
> is straightforward as long as the crypto subsystem supports them.
> 
> Future commits will extend this implementation with support for
> measurement, key exchange and encrypted sessions.
> 
> So far, only the SPDM requester role is implemented.  Care was taken to
> allow for effortless addition of the responder role at a later stage.
> This could be needed for a PCIe host bridge operating in endpoint mode.
> The responder role will be able to reuse struct definitions and helpers
> such as spdm_create_combined_prefix().

Nice changelog.

> 
> Credits:  Jonathan wrote a proof-of-concept of this SPDM implementation.
> Lukas reworked it for upstream.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-developed-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  MAINTAINERS                 |  11 +
>  include/linux/spdm.h        |  33 ++
>  lib/Kconfig                 |  15 +
>  lib/Makefile                |   2 +
>  lib/spdm/Makefile           |  10 +
>  lib/spdm/core.c             | 425 ++++++++++++++++++++++
>  lib/spdm/req-authenticate.c | 704 ++++++++++++++++++++++++++++++++++++
>  lib/spdm/spdm.h             | 520 ++++++++++++++++++++++++++
>  8 files changed, 1720 insertions(+)
>  create mode 100644 include/linux/spdm.h
>  create mode 100644 lib/spdm/Makefile
>  create mode 100644 lib/spdm/core.c
>  create mode 100644 lib/spdm/req-authenticate.c
>  create mode 100644 lib/spdm/spdm.h

I only have some quibbles below, but the broad strokes look good to me.

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6c90161c7bf..dbe16eea8818 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20145,6 +20145,17 @@ M:	Security Officers <security@kernel.org>
>  S:	Supported
>  F:	Documentation/process/security-bugs.rst
>  
> +SECURITY PROTOCOL AND DATA MODEL (SPDM)
> +M:	Jonathan Cameron <jic23@kernel.org>
> +M:	Lukas Wunner <lukas@wunner.de>
> +L:	linux-coco@lists.linux.dev
> +L:	linux-cxl@vger.kernel.org
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git
> +F:	include/linux/spdm.h
> +F:	lib/spdm/
> +
>  SECURITY SUBSYSTEM
>  M:	Paul Moore <paul@paul-moore.com>
>  M:	James Morris <jmorris@namei.org>
> diff --git a/include/linux/spdm.h b/include/linux/spdm.h
> new file mode 100644
> index 000000000000..0da7340020c4
> --- /dev/null
> +++ b/include/linux/spdm.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * DMTF Security Protocol and Data Model (SPDM)
> + * https://www.dmtf.org/dsp/DSP0274
> + *
> + * Copyright (C) 2021-22 Huawei
> + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> + *
> + * Copyright (C) 2022-24 Intel Corporation
> + */
> +
> +#ifndef _SPDM_H_
> +#define _SPDM_H_
> +
> +#include <linux/types.h>
> +
> +struct key;
> +struct device;
> +struct spdm_state;
> +
> +typedef ssize_t (spdm_transport)(void *priv, struct device *dev,
> +				 const void *request, size_t request_sz,
> +				 void *response, size_t response_sz);
> +
> +struct spdm_state *spdm_create(struct device *dev, spdm_transport *transport,
> +			       void *transport_priv, u32 transport_sz,
> +			       struct key *keyring);
> +
> +int spdm_authenticate(struct spdm_state *spdm_state);
> +
> +void spdm_destroy(struct spdm_state *spdm_state);
> +
> +#endif
> diff --git a/lib/Kconfig b/lib/Kconfig
> index d33a268bc256..9011fa32af45 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -782,3 +782,18 @@ config POLYNOMIAL
>  
>  config FIRMWARE_TABLE
>  	bool
> +
> +config SPDM
> +	tristate
> +	select CRYPTO
> +	select KEYS
> +	select ASYMMETRIC_KEY_TYPE
> +	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +	select X509_CERTIFICATE_PARSER
> +	help
> +	  The Security Protocol and Data Model (SPDM) allows for device
> +	  authentication, measurement, key exchange and encrypted sessions.
> +
> +	  Crypto algorithms negotiated with SPDM are limited to those enabled
> +	  in .config.  Drivers selecting SPDM therefore need to also select
> +	  any algorithms they deem mandatory.
> diff --git a/lib/Makefile b/lib/Makefile
> index 3b1769045651..b2ef14d1fa71 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -301,6 +301,8 @@ obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
>  obj-$(CONFIG_ASN1) += asn1_decoder.o
>  obj-$(CONFIG_ASN1_ENCODER) += asn1_encoder.o
>  
> +obj-$(CONFIG_SPDM) += spdm/
> +
>  obj-$(CONFIG_FONT_SUPPORT) += fonts/
>  
>  hostprogs	:= gen_crc32table
> diff --git a/lib/spdm/Makefile b/lib/spdm/Makefile
> new file mode 100644
> index 000000000000..f579cc898dbc
> --- /dev/null
> +++ b/lib/spdm/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# DMTF Security Protocol and Data Model (SPDM)
> +# https://www.dmtf.org/dsp/DSP0274
> +#
> +# Copyright (C) 2024 Intel Corporation
> +
> +obj-$(CONFIG_SPDM) += spdm.o
> +
> +spdm-y := core.o req-authenticate.o
> diff --git a/lib/spdm/core.c b/lib/spdm/core.c
> new file mode 100644
> index 000000000000..f06402f6d127
> --- /dev/null
> +++ b/lib/spdm/core.c
> @@ -0,0 +1,425 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DMTF Security Protocol and Data Model (SPDM)
> + * https://www.dmtf.org/dsp/DSP0274
> + *
> + * Core routines for message exchange, message transcript,
> + * signature verification and session state lifecycle
> + *
> + * Copyright (C) 2021-22 Huawei
> + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> + *
> + * Copyright (C) 2022-24 Intel Corporation
> + */
> +
> +#include "spdm.h"
> +
> +#include <linux/dev_printk.h>
> +#include <linux/module.h>
> +
> +#include <crypto/hash.h>
> +#include <crypto/public_key.h>
> +
> +static int spdm_err(struct device *dev, struct spdm_error_rsp *rsp)

This approach to error singnaling looks unprecedented, and not in a good
way. I like the idea of a SPDM-error-code to errno converter, and
separate SPDM-error-code to error string, but not an SPDM-error-code to
errno conversion that has a log emitting side effect.

Would this not emit ambiguous messages like:

    cxl_pci 0000:35:00.0: Unexpected request

How does I know that error message is from CXL SPDM functionality and
not some other part of the driver?

What if the SPDM authentication is optional, how does the consumer of
this library avoid log spam? What about rate limiting?

Did you consider leaving all error logging to the caller?

I have less problem if these all become dev_dbg() or tracepoints, but
dev_err() seems awkward.

> +{
> +	switch (rsp->error_code) {
> +	case SPDM_INVALID_REQUEST:
> +		dev_err(dev, "Invalid request\n");
> +		return -EINVAL;
> +	case SPDM_INVALID_SESSION:
> +		if (rsp->version == 0x11) {
> +			dev_err(dev, "Invalid session %#x\n", rsp->error_data);
> +			return -EINVAL;
> +		}
> +		break;
> +	case SPDM_BUSY:
> +		dev_err(dev, "Busy\n");
> +		return -EBUSY;
> +	case SPDM_UNEXPECTED_REQUEST:
> +		dev_err(dev, "Unexpected request\n");
> +		return -EINVAL;
> +	case SPDM_UNSPECIFIED:
> +		dev_err(dev, "Unspecified error\n");
> +		return -EINVAL;
> +	case SPDM_DECRYPT_ERROR:
> +		dev_err(dev, "Decrypt error\n");
> +		return -EIO;
> +	case SPDM_UNSUPPORTED_REQUEST:
> +		dev_err(dev, "Unsupported request %#x\n", rsp->error_data);
> +		return -EINVAL;
> +	case SPDM_REQUEST_IN_FLIGHT:
> +		dev_err(dev, "Request in flight\n");
> +		return -EINVAL;
> +	case SPDM_INVALID_RESPONSE_CODE:
> +		dev_err(dev, "Invalid response code\n");
> +		return -EINVAL;
> +	case SPDM_SESSION_LIMIT_EXCEEDED:
> +		dev_err(dev, "Session limit exceeded\n");
> +		return -EBUSY;
> +	case SPDM_SESSION_REQUIRED:
> +		dev_err(dev, "Session required\n");
> +		return -EINVAL;
> +	case SPDM_RESET_REQUIRED:
> +		dev_err(dev, "Reset required\n");
> +		return -ECONNRESET;
> +	case SPDM_RESPONSE_TOO_LARGE:
> +		dev_err(dev, "Response too large\n");
> +		return -EINVAL;
> +	case SPDM_REQUEST_TOO_LARGE:
> +		dev_err(dev, "Request too large\n");
> +		return -EINVAL;
> +	case SPDM_LARGE_RESPONSE:
> +		dev_err(dev, "Large response\n");
> +		return -EMSGSIZE;
> +	case SPDM_MESSAGE_LOST:
> +		dev_err(dev, "Message lost\n");
> +		return -EIO;
> +	case SPDM_INVALID_POLICY:
> +		dev_err(dev, "Invalid policy\n");
> +		return -EINVAL;
> +	case SPDM_VERSION_MISMATCH:
> +		dev_err(dev, "Version mismatch\n");
> +		return -EINVAL;
> +	case SPDM_RESPONSE_NOT_READY:
> +		dev_err(dev, "Response not ready\n");
> +		return -EINPROGRESS;
> +	case SPDM_REQUEST_RESYNCH:
> +		dev_err(dev, "Request resynchronization\n");
> +		return -ECONNRESET;
> +	case SPDM_OPERATION_FAILED:
> +		dev_err(dev, "Operation failed\n");
> +		return -EINVAL;
> +	case SPDM_NO_PENDING_REQUESTS:
> +		return -ENOENT;
> +	case SPDM_VENDOR_DEFINED_ERROR:
> +		dev_err(dev, "Vendor defined error\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_err(dev, "Undefined error %#x\n", rsp->error_code);
> +	return -EINVAL;
> +}
> +
> +/**
> + * spdm_exchange() - Perform SPDM message exchange with device
> + *
> + * @spdm_state: SPDM session state
> + * @req: Request message
> + * @req_sz: Size of @req
> + * @rsp: Response message
> + * @rsp_sz: Size of @rsp
> + *
> + * Send the request @req to the device via the @transport in @spdm_state and
> + * receive the response into @rsp, respecting the maximum buffer size @rsp_sz.
> + * The request version is automatically populated.
> + *
> + * Return response size on success or a negative errno.  Response size may be
> + * less than @rsp_sz and the caller is responsible for checking that.  It may
> + * also be more than expected (though never more than @rsp_sz), e.g. if the
> + * transport receives only dword-sized chunks.
> + */
> +ssize_t spdm_exchange(struct spdm_state *spdm_state,
> +		      void *req, size_t req_sz, void *rsp, size_t rsp_sz)
> +{
> +	struct spdm_header *request = req;
> +	struct spdm_header *response = rsp;
> +	ssize_t rc, length;

What's the locking assumption with this public function? I see that the
internal to this file usages wrap it in the state lock. Should that
assumption be codified with a:

lockdep_assert_held(&spdm_state->lock)

?

Or can this function be marked static?

> +
> +	if (req_sz < sizeof(struct spdm_header) ||
> +	    rsp_sz < sizeof(struct spdm_header))
> +		return -EINVAL;
> +
> +	request->version = spdm_state->version;
> +
> +	rc = spdm_state->transport(spdm_state->transport_priv, spdm_state->dev,
> +				   req, req_sz, rsp, rsp_sz);
> +	if (rc < 0)
> +		return rc;
> +
> +	length = rc;
> +	if (length < sizeof(struct spdm_header))
> +		return length; /* Truncated response is handled by callers */
> +
> +	if (response->code == SPDM_ERROR)
> +		return spdm_err(spdm_state->dev, (struct spdm_error_rsp *)rsp);
> +
> +	if (response->code != (request->code & ~SPDM_REQ)) {
> +		dev_err(spdm_state->dev,
> +			"Response code %#x does not match request code %#x\n",
> +			response->code, request->code);
> +		return -EPROTO;
> +	}
> +
> +	return length;
> +}
> +
> +/**
> + * spdm_alloc_transcript() - Allocate transcript buffer
> + *
> + * @spdm_state: SPDM session state
> + *
> + * Allocate a buffer to accommodate the concatenation of all SPDM messages
> + * exchanged during an authentication sequence.  Used to verify the signature,
> + * as it is computed over the hashed transcript.
> + *
> + * Transcript size is initially one page.  It grows by additional pages as
> + * needed.  Minimum size of an authentication sequence is 1k (only one slot
> + * occupied, only one ECC P256 certificate in chain, SHA 256 hash selected).
> + * Maximum can be several MBytes.  Between 4k and 64k is probably typical.
> + *
> + * Return 0 on success or a negative errno.
> + */
> +int spdm_alloc_transcript(struct spdm_state *spdm_state)
> +{
> +	spdm_state->transcript = kvmalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!spdm_state->transcript)
> +		return -ENOMEM;
> +
> +	spdm_state->transcript_end = spdm_state->transcript;
> +	spdm_state->transcript_max = PAGE_SIZE;
> +
> +	return 0;
> +}
> +
> +/**
> + * spdm_free_transcript() - Free transcript buffer
> + *
> + * @spdm_state: SPDM session state
> + *
> + * Free the transcript buffer after performing authentication.  Reset the
> + * pointer to the current end of transcript as well as the allocation size.
> + */
> +void spdm_free_transcript(struct spdm_state *spdm_state)
> +{
> +	kvfree(spdm_state->transcript);
> +	spdm_state->transcript_end = NULL;
> +	spdm_state->transcript_max = 0;

Similar locking context with public functions concern, but also the
cleverness of why it is ok to not set ->transcript to NULL that really
only hold true if spdm_append_transcript() and and
spdm_free_transcript() are guaranteed to be serialized.

> +}
> +
> +/**
> + * spdm_append_transcript() - Append a message to transcript buffer
> + *
> + * @spdm_state: SPDM session state
> + * @msg: SPDM message
> + * @msg_sz: Size of @msg
> + *
> + * Append an SPDM message to the transcript after reception or transmission.
> + * Reallocate a larger transcript buffer if the message exceeds its current
> + * allocation size.
> + *
> + * If the message to be appended is known to fit into the allocation size,
> + * it may be directly received into or transmitted from the transcript buffer
> + * instead of calling this function:  Simply use the @transcript_end pointer in
> + * struct spdm_state as the position to store the message, then advance the
> + * pointer by the message size.
> + *
> + * Return 0 on success or a negative errno.
> + */
> +int spdm_append_transcript(struct spdm_state *spdm_state,
> +			   const void *msg, size_t msg_sz)
> +{
> +	size_t transcript_sz = spdm_state->transcript_end -
> +			       spdm_state->transcript;
> +
> +	if (transcript_sz + msg_sz > spdm_state->transcript_max) {
> +		size_t new_sz = round_up(transcript_sz + msg_sz, PAGE_SIZE);
> +		void *new = kvrealloc(spdm_state->transcript,
> +				      spdm_state->transcript_max,
> +				      new_sz, GFP_KERNEL);
> +		if (!new)
> +			return -ENOMEM;
> +
> +		spdm_state->transcript = new;
> +		spdm_state->transcript_end = new + transcript_sz;
> +		spdm_state->transcript_max = new_sz;
> +	}
> +
> +	memcpy(spdm_state->transcript_end, msg, msg_sz);
> +	spdm_state->transcript_end += msg_sz;
> +
> +	return 0;
> +}
> +
> +/**
> + * spdm_create_combined_prefix() - Create combined_spdm_prefix for a hash
> + *
> + * @version: SPDM version negotiated during GET_VERSION exchange
> + * @spdm_context: SPDM context of signature generation (or verification)
> + * @buf: Buffer to receive combined_spdm_prefix (100 bytes)
> + *
> + * From SPDM 1.2, a hash is prefixed with the SPDM version and context before
> + * a signature is generated (or verified) over the resulting concatenation
> + * (SPDM 1.2.0 section 15).  Create that prefix.
> + */
> +void spdm_create_combined_prefix(u8 version, const char *spdm_context,
> +				 void *buf)
> +{
> +	u8 major = FIELD_GET(0xf0, version);
> +	u8 minor = FIELD_GET(0x0f, version);
> +	size_t len = strlen(spdm_context);
> +	int rc, zero_pad;
> +
> +	rc = snprintf(buf, SPDM_PREFIX_SZ + 1,
> +		      "dmtf-spdm-v%hhx.%hhx.*dmtf-spdm-v%hhx.%hhx.*"
> +		      "dmtf-spdm-v%hhx.%hhx.*dmtf-spdm-v%hhx.%hhx.*",
> +		      major, minor, major, minor, major, minor, major, minor);
> +	WARN_ON(rc != SPDM_PREFIX_SZ);

Does this need a dynamic runtime check?

> +
> +	zero_pad = SPDM_COMBINED_PREFIX_SZ - SPDM_PREFIX_SZ - 1 - len;
> +	WARN_ON(zero_pad < 0);


Worth crashing the system here for panic_on_warn folks?

> +
> +	memset(buf + SPDM_PREFIX_SZ + 1, 0, zero_pad);
> +	memcpy(buf + SPDM_PREFIX_SZ + 1 + zero_pad, spdm_context, len);
> +}
> +
> +/**
> + * spdm_verify_signature() - Verify signature against leaf key
> + *
> + * @spdm_state: SPDM session state
> + * @spdm_context: SPDM context (used to create combined_spdm_prefix)
> + *
> + * Implementation of the abstract SPDMSignatureVerify() function described in
> + * SPDM 1.2.0 section 16:  Compute the hash over @spdm_state->transcript and
> + * verify that the signature at the end of the transcript was generated by
> + * @spdm_state->leaf_key.  Hashing the entire transcript allows detection
> + * of message modification by a man-in-the-middle or media error.
> + *
> + * Return 0 on success or a negative errno.
> + */
> +int spdm_verify_signature(struct spdm_state *spdm_state,
> +			  const char *spdm_context)
> +{
> +	struct public_key_signature sig = {
> +		.s = spdm_state->transcript_end - spdm_state->sig_len,
> +		.s_size = spdm_state->sig_len,
> +		.encoding = spdm_state->base_asym_enc,
> +		.hash_algo = spdm_state->base_hash_alg_name,
> +	};
> +	u8 *mhash __free(kfree) = NULL;
> +	u8 *m __free(kfree);
> +	int rc;
> +
> +	m = kmalloc(SPDM_COMBINED_PREFIX_SZ + spdm_state->hash_len, GFP_KERNEL);

I am not a fan of forward declared scoped-based resource management
variables [1], although PeterZ never responded to those suggestions.

[1]: http://lore.kernel.org/171175585714.2192972.12661675876300167762.stgit@dwillia2-xfh.jf.intel.com

> +	if (!m)
> +		return -ENOMEM;
> +
> +	/* Hash the transcript (sans trailing signature) */
> +	rc = crypto_shash_digest(spdm_state->desc, spdm_state->transcript,
> +				 (void *)sig.s - spdm_state->transcript,
> +				 m + SPDM_COMBINED_PREFIX_SZ);
> +	if (rc)
> +		return rc;
> +
> +	if (spdm_state->version <= 0x11) {
> +		/*
> +		 * SPDM 1.0 and 1.1 compute the signature only over the hash
> +		 * (SPDM 1.0.0 section 4.9.2.7).
> +		 */
> +		sig.digest = m + SPDM_COMBINED_PREFIX_SZ;
> +		sig.digest_size = spdm_state->hash_len;
> +	} else {
> +		/*
> +		 * From SPDM 1.2, the hash is prefixed with spdm_context before
> +		 * computing the signature over the resulting message M
> +		 * (SPDM 1.2.0 sec 15).
> +		 */
> +		spdm_create_combined_prefix(spdm_state->version, spdm_context,
> +					    m);
> +
> +		/*
> +		 * RSA and ECDSA algorithms require that M is hashed once more.
> +		 * EdDSA and SM2 algorithms omit that step.
> +		 * The switch statement prepares for their introduction.
> +		 */
> +		switch (spdm_state->base_asym_alg) {
> +		default:
> +			mhash = kmalloc(spdm_state->hash_len, GFP_KERNEL);
> +			if (!mhash)
> +				return -ENOMEM;
> +
> +			rc = crypto_shash_digest(spdm_state->desc, m,
> +				SPDM_COMBINED_PREFIX_SZ + spdm_state->hash_len,
> +				mhash);
> +			if (rc)
> +				return rc;
> +
> +			sig.digest = mhash;
> +			sig.digest_size = spdm_state->hash_len;
> +			break;
> +		}
> +	}
> +
> +	return public_key_verify_signature(spdm_state->leaf_key, &sig);
> +}
> +
> +/**
> + * spdm_reset() - Free cryptographic data structures
> + *
> + * @spdm_state: SPDM session state
> + *
> + * Free cryptographic data structures when an SPDM session is destroyed or
> + * when the device is reauthenticated.
> + */
> +void spdm_reset(struct spdm_state *spdm_state)
> +{
> +	public_key_free(spdm_state->leaf_key);
> +	spdm_state->leaf_key = NULL;
> +
> +	kfree(spdm_state->desc);
> +	spdm_state->desc = NULL;
> +
> +	crypto_free_shash(spdm_state->shash);
> +	spdm_state->shash = NULL;
> +}
> +
> +/**
> + * spdm_create() - Allocate SPDM session
> + *
> + * @dev: Responder device
> + * @transport: Transport function to perform one message exchange
> + * @transport_priv: Transport private data
> + * @transport_sz: Maximum message size the transport is capable of (in bytes)
> + * @keyring: Trusted root certificates
> + *
> + * Return a pointer to the allocated SPDM session state or NULL on error.
> + */
> +struct spdm_state *spdm_create(struct device *dev, spdm_transport *transport,
> +			       void *transport_priv, u32 transport_sz,
> +			       struct key *keyring)
> +{
> +	struct spdm_state *spdm_state = kzalloc(sizeof(*spdm_state), GFP_KERNEL);
> +
> +	if (!spdm_state)
> +		return NULL;
> +
> +	spdm_state->dev = dev;
> +	spdm_state->transport = transport;
> +	spdm_state->transport_priv = transport_priv;
> +	spdm_state->transport_sz = transport_sz;
> +	spdm_state->root_keyring = keyring;
> +
> +	mutex_init(&spdm_state->lock);
> +
> +	return spdm_state;
> +}
> +EXPORT_SYMBOL_GPL(spdm_create);
> +
> +/**
> + * spdm_destroy() - Destroy SPDM session
> + *
> + * @spdm_state: SPDM session state
> + */
> +void spdm_destroy(struct spdm_state *spdm_state)
> +{
> +	u8 slot;
> +
> +	for_each_set_bit(slot, &spdm_state->provisioned_slots, SPDM_SLOTS)
> +		kvfree(spdm_state->slot[slot]);
> +
> +	spdm_reset(spdm_state);
> +	mutex_destroy(&spdm_state->lock);
> +	kfree(spdm_state);
> +}
> +EXPORT_SYMBOL_GPL(spdm_destroy);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/lib/spdm/req-authenticate.c b/lib/spdm/req-authenticate.c
> new file mode 100644
> index 000000000000..51fdb88f519b
> --- /dev/null
> +++ b/lib/spdm/req-authenticate.c
[..]
> +/**
> + * spdm_authenticate() - Authenticate device
> + *
> + * @spdm_state: SPDM session state
> + *
> + * Authenticate a device through a sequence of GET_VERSION, GET_CAPABILITIES,
> + * NEGOTIATE_ALGORITHMS, GET_DIGESTS, GET_CERTIFICATE and CHALLENGE exchanges.
> + *
> + * Perform internal locking to serialize multiple concurrent invocations.
> + * Can be called repeatedly for reauthentication.
> + *
> + * Return 0 on success or a negative errno.  In particular, -EPROTONOSUPPORT
> + * indicates authentication is not supported by the device.
> + */
> +int spdm_authenticate(struct spdm_state *spdm_state)
> +{
> +	u8 slot;
> +	int rc;
> +
> +	mutex_lock(&spdm_state->lock);
> +	spdm_reset(spdm_state);
> +
> +	rc = spdm_alloc_transcript(spdm_state);
> +	if (rc)
> +		goto unlock;
> +
> +	rc = spdm_get_version(spdm_state);
> +	if (rc)
> +		goto unlock;
> +
> +	rc = spdm_get_capabilities(spdm_state);
> +	if (rc)
> +		goto unlock;
> +
> +	rc = spdm_negotiate_algs(spdm_state);
> +	if (rc)
> +		goto unlock;
> +
> +	rc = spdm_get_digests(spdm_state);
> +	if (rc)
> +		goto unlock;
> +
> +	for_each_set_bit(slot, &spdm_state->provisioned_slots, SPDM_SLOTS) {
> +		rc = spdm_get_certificate(spdm_state, slot);
> +		if (rc)
> +			goto unlock;
> +	}
> +
> +	for_each_set_bit(slot, &spdm_state->provisioned_slots, SPDM_SLOTS) {
> +		rc = spdm_validate_cert_chain(spdm_state, slot);
> +		if (rc == 0)
> +			break;
> +	}
> +	if (rc)
> +		goto unlock;
> +
> +	rc = spdm_challenge(spdm_state, slot);
> +
> +unlock:
> +	if (rc)
> +		spdm_reset(spdm_state);

The above looks like it is asking for an __spdm_authenticate helper.

int spdm_authenticate(struct spdm_state *spdm_state)
{
	guard(mutex)(&spdm_state->lock);
	rc = __spdm_authenticate(spdm_state);
	if (rc)
		spdm_reset(spdm_state);
	spdm_state->authenticated = !rc;
	spdm_free_transcript(spdm_state);
	return rc;
}

Otherwise, looks good to me.

