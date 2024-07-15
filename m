Return-Path: <linux-pci+bounces-10317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BCD931C0B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 22:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BA3283296
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 20:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1402E13D260;
	Mon, 15 Jul 2024 20:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P4v66wUm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B1D13C816;
	Mon, 15 Jul 2024 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075809; cv=fail; b=sdUvBqwyTKkP95qug+pXVez81cTxJ9u8Gm9MJAS1M/gPV6ejIfvMcBC+RVPPu5UCXxrCqhXWAcmnSW0ow2kuTJTVgY0wX8YiADNYdeuTNy2OI9HMl0Wgk3y+EfaHHHpOX6xgukNQ9uOLlkGoAZf659+k8VRq5JYmp58RjJXUTJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075809; c=relaxed/simple;
	bh=HmCs5BvVoKHCGutv6kKCIrNnO7VvmkuRf6XgczLQ38E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kpCDkIfxNMEjSNiIoQpi0AqbAumkiLkYB8sFiHePrt0TSyc/Zy0/iqGkdMcQCmWoSRvB3zox4Adj99PUo3S7CRE/NEB8/ga6LdzuPGpLkTP8uF/XQEtPpIq6R8VShWUuL8KfrqE2+N1hNdZT5Qev5BwU9Hi7m0OujAMMuC/Ag5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P4v66wUm; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721075807; x=1752611807;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HmCs5BvVoKHCGutv6kKCIrNnO7VvmkuRf6XgczLQ38E=;
  b=P4v66wUmNqDdTcJwXGzrLCuw71IpPVqRNy+J9DFEFlCR0DhXowzYdZCy
   3PekRcp4yrRIO1RUb7VMaenT1Y1Q1qzRwCz7/vuhDFnKc0W6OJQP/xUqS
   z5WgqBqdneeT+vNPlRq6LYAu+95iDHB+wmRn7XXexSu9ykJpog+55NGIM
   JXn5SkQ4Vdfti3gWbfWzlCBv3U7UVS3Y+k1g724rML8M/qjOXM8NghmLi
   5wY9zb8w1vzDO5pE33ZztJvr0c1eXKfNatreMpl2mx9YGe07meoJkuZMV
   3r0lNbnVoq0GD5VRU5SIACjnLc5pPoYVJH+X0Ubfqoqj4mxPEGQ6hsgrO
   A==;
X-CSE-ConnectionGUID: x2o65SFDSM+ZrBByLk81LA==
X-CSE-MsgGUID: IKopFzhQQhuwTbJBi4epmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="21395535"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="21395535"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 13:36:46 -0700
X-CSE-ConnectionGUID: 22yGHXVlT6+Q8uC83KGANA==
X-CSE-MsgGUID: E9QzMCfeQhqliWQtO5Bi+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="87244770"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 13:36:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 13:36:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 13:36:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 13:36:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 13:36:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSG1xgJcK6R+cSKXzdnSe0vYMtBPxI6OGxuqjxiMjyyHgzlQdGEDsZnAn7CODI/0bK6dxsez5J7cOLDIQmT1HsuNq4QlbpfEDqSCv7nbS0yCws4wVgknQggtUGuU/zaFehv8dar++7/wVA18bjMAXwsnyMtkkhaN2zeUSbjvyxdCaMkVwV+VFVGBIceXWJ31/IMbsIuceha6a1YNuiHWo8rlrhFiPPe5e0f5ImoJDJ5pEh9MQPryaCDmOH1+EmusWKf+5gdiaSMODYY9AIQEJHiSTK1LENkSfYvEIOd1Lrk0CEHL4kDBBFVt0n8Wa9Zhvqe/VDzQahDg3De+n7oIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eo/MCvkGiG5SkFw71y2+YDR9aCaEAjmvGVACl9HTrdw=;
 b=ZaCNV72Ulau02xFVVzk3E3SbqdOPbzbm31F9wI/1s5llp4KecNkNfg5da4Q7OrqTjPpwUW4PAkkgu+3Av4H15kjkNiPl/lQ0TeBVuPrmtYSL81ArQ1+OpY2RTjhx3ZbTDK8FFNKxk0AP4K1cO5RZGcez1sPGLMtpnAZ3yPB9CDtunmp1ApZADUYC1/6lDMPgJjGdc2yRcBQETkgWUKkJm5S594yLA+X6HpPVTrtR0bpK7/A5yfG4C+Yjbm2RSBE6DYCEk7e612jSprie6dC1JhAj27oN2y39ubp9lKY1/vLt+cJUuLz2/FlZP/XkF16NPLJGOMmyHakfm2vaa0oIhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5263.namprd11.prod.outlook.com (2603:10b6:5:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 20:36:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 20:36:37 +0000
Date: Mon, 15 Jul 2024 13:36:32 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Kees Cook <kees@kernel.org>
CC: Lukas Wunner <lukas@wunner.de>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bjorn Helgaas
	<helgaas@kernel.org>, David Howells <dhowells@redhat.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David
 Woodhouse <dwmw2@infradead.org>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linuxarm@huawei.com>, David Box <david.e.box@intel.com>, "Li, Ming"
	<ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair
 Francis <alistair.francis@wdc.com>, Wilfred Mallawa
	<wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, "Alexey
 Kardashevskiy" <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>,
	Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Peter Gonda
	<pgonda@google.com>, Jerome Glisse <jglisse@google.com>, "Sean
 Christopherson" <seanjc@google.com>, Alexander Graf <graf@amazon.com>,
	"Samuel Ortiz" <sameo@rivosinc.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
Message-ID: <66958850db394_8f74d2942b@dwillia2-xfh.jf.intel.com.notmuch>
References: <Zo_zivacyWmBuQcM@wunner.de>
 <66901b646bd44_1a7742941d@dwillia2-xfh.jf.intel.com.notmuch>
 <ZpOPgcXU6eNqEB7M@wunner.de>
 <202407151005.15C1D4C5E8@keescook>
 <20240715181252.GU1482543@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240715181252.GU1482543@nvidia.com>
X-ClientProxiedBy: MW3PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:303:2a::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5263:EE_
X-MS-Office365-Filtering-Correlation-Id: 16bfceb5-f0c3-48ff-0564-08dca50dd31d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A0OY9o69yx9D19EeT7bMtm4fepIxDuMeSd9EL1sh9t2n+NNKEAoIYFGt5N01?=
 =?us-ascii?Q?mRnfMuoOcdeYzU8Ur9fTpEhqvjwEwJZAdcJwQgxxb8DHlOdZJY2b1C/YIRir?=
 =?us-ascii?Q?Mrgx+tDReb5JwJh5oXtLazAGcX12GrhBlyonkZDiezouKkhSonBpjI9lOcbE?=
 =?us-ascii?Q?lhYzWiGeSvLVp9QX2joNwEXgIqs3VfzfdMQgCCRdeshC8rHFuUnKckBKAoww?=
 =?us-ascii?Q?5vL39yrG7Ogb9NBcsq1CrC1Lf4zxSzL7K1WVYEk+Cq7iF4g/I01LBkeyhyNw?=
 =?us-ascii?Q?3OBNj+f8uPDetzy9wWCnPvy9IEEKrvLWh/mTcdOVPcIIwtEDdvsOqfcffSSn?=
 =?us-ascii?Q?uiNepB0W6FvaIqQ7/eIYWVyU3t/jGIHBcAsVnRTm8KPnf/4HONRqhq3xz/Sr?=
 =?us-ascii?Q?Y2elLf90wc9GNv3c/802G9HqyfdpgwwAXCzhnx2zCNejOh+TI7xgXEZuyfMc?=
 =?us-ascii?Q?+ZDi6fCY/sLmWVbEmycK3CU1RMFdY770Ean7XD7EFgulXtZLjqd7bbUtcmLi?=
 =?us-ascii?Q?r17aTXhiFV/NKsUCXCryhDG6Bi2h4JmOKeRnNKNCRhVl/PzIEMjmGZbZHm70?=
 =?us-ascii?Q?Ur1vzw/hZR36XWWWveV4qs5kMJSyJEET8uBGkanTjRMFtnBYFOaIUrJm48cg?=
 =?us-ascii?Q?VVfluHEg3lgtW5kfKXUUFRPtDr5BajF8Ianw5HAtAsFuFUgm1n+W8176HNgd?=
 =?us-ascii?Q?kbk4pVyIH8N+4L2yM+EXWJ13O4Q76FrOp1ebQBPd9Ub3co5/oNTrCuITNgMq?=
 =?us-ascii?Q?s21XtH0tn3lMVzo7ajp2WeusFFSmwceiVapGcjNiUjArZWaEW9aT9otj4GND?=
 =?us-ascii?Q?GXjx5xFO6YnFOwNIAdmgS/mUBoJX+f1gg1OY+5IHHd6RCY5sL37zkS1JIQZW?=
 =?us-ascii?Q?5QJCBExdJFcrJLeHTkob7XE8tbWtWnnHs3szKBAkg2kLGhP/FZlliCHqcM1/?=
 =?us-ascii?Q?cX8P+XsFMGAX4C6J9D5h1ZF+aMNDc/sFgTdX5/5JAxCf6GRFtRboBm4hvc7p?=
 =?us-ascii?Q?cC0/bSIO9dUa+IuqjN+j/A7ePp3D2PhJVsKcuAAYHJdYAZrPocEsh3lL7CO3?=
 =?us-ascii?Q?EDvgqyLLGoDi3zI76q8lcj4VbbzIyGaRGJWXsVvzL3yoVAwByYCGjuze9hN/?=
 =?us-ascii?Q?Tmnm4OJmvr2bD0bPd4Dd6xwhrb08vk3JpdRj4BHtgE+Y2E/69BqQC+woTOF9?=
 =?us-ascii?Q?qrMxTpr9jxOCFGtjaoZ/Qi/jEnAq7otKaQGCVAkFbnQmRtdJAG8rsNP2TTV9?=
 =?us-ascii?Q?hSaTzP+Ulyj9hk3s46rcE2NsmxlwLOpNgT5uyGyFecYrCvnU/a1lW8b63fT4?=
 =?us-ascii?Q?Scm4HZMNTTmnLOita2gJ3dqLd7/aEc9ujIOH9T5erTt1Yw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JgvKLPIlTXaM9RYPygqL0cSkjp8jvEKGW5ATCSeQ9/bcv9Y57txcGPBVcPfV?=
 =?us-ascii?Q?GrpC2Y+nQJxxvhOci5O+55iWCGHW+edep4sfXh/XHQbMpx7lS3MFEaHmLctH?=
 =?us-ascii?Q?fxukkRIq6WsvM8Sy6CUfBpZvEyVuvhND8FJfKQY6Q/8j3I1uiIf37vmsiro4?=
 =?us-ascii?Q?vuXAquBmnzSDI7FkUrEb3QpewFE5Pa2LGUJLsOMygJdcjDAcF9BVPnE39Mw0?=
 =?us-ascii?Q?hEjtbuJn21Fksshsge8F38DDGq6QKUaSIRX7M3nbVWrUyejDoJl/fzFzjZp+?=
 =?us-ascii?Q?OI4CKX+w9UqDDLxhrzgKAIcDbNBmdjom61thHfhI8KhoeTPww/uMOHj4VgL3?=
 =?us-ascii?Q?AmgxQgoI/vT6VWcoulJjjCovHIaCUKKSsan5q695Z/ob+zFl5BaSzeoAPz7Q?=
 =?us-ascii?Q?pVdr2EIOofF4eazkN/XelxglPh+/MfT8thTMrvXxfAQ3FbL8cnQoy/fMjdrj?=
 =?us-ascii?Q?lKjmoMChcQAyJ7rHRVXOEcoestT60zU70xMD2qgba/kU97ZLWOC2I2yz2vLx?=
 =?us-ascii?Q?IomvfzZhAn/E9pAmZsXAs5DUii3J/QqaDAygBdh/opTNgYCN30ylEyybuOcV?=
 =?us-ascii?Q?Ztk2UmXIGu1/wVSA8Ns0btPFg1se8wZWKIsyBikONt0rf04MDwdaNU7ISyuH?=
 =?us-ascii?Q?BJsU6sMTx7hOMm3Z53So21QTaXcDpDodfEVjtHS2XFsiwrRb7bfvWcKJazYe?=
 =?us-ascii?Q?rtulM0ErWUgPxBBx5hnBXL0ZN4lgqmCNqNHkkFt+Yw3ZqQXQHXKLBLrF5euy?=
 =?us-ascii?Q?mfvDRoKTM/kaw1jmy0BSoOFFXW1R9ryEBFw7NYxtzcGGx2Cy5Qf9x/f669Ey?=
 =?us-ascii?Q?3XjMWguJzrAI+xDn70K5Hi2VcR26f6xGjiTpGFIqL3Uj4YE8+SbwNR9uuOw/?=
 =?us-ascii?Q?GLg+HCj6nQkMGw6pifjGKkuhbx9LkX/TNFCMQp4TdvmDf0vk2ALucQKstUce?=
 =?us-ascii?Q?Q5oNguFzvupDwlErU4DbeBp44r+4BSSRyG0tHfsZJIJJRAhje4z5sArp2EBN?=
 =?us-ascii?Q?7LpR+siI/JpIyMV4BLB+W7BEBLDq30wejahZUTKWPQ3+uiqvN0neOTpseWpz?=
 =?us-ascii?Q?ds7VP5zotZFS2QyTY3/tv+aYZIbXDXWvH/kcBgZDK3Gw+xtVMknJSW/N/+s6?=
 =?us-ascii?Q?1OP3gQox/hzbg6qwlRJEtLq3uXGxGy8m7iWT2/iovGwfEBV2ibvn32zACviQ?=
 =?us-ascii?Q?TQBr+WcCcTuCPnCtXM51VOPXm2dRkzCuQeOEYf/Hv1MYAQFFpfvEXKCKAck4?=
 =?us-ascii?Q?cOzVG3Bnnz0i41MJG5TfG9qkDcpjD4uIad2tfHkS66AZ+06Qsgtw1O9CIKkR?=
 =?us-ascii?Q?0jo6a2zC6UJ3HGyWmzUTJvtIJjnJHyXpYVxDUBrCpr45a2PZu8rhIC5gIRSv?=
 =?us-ascii?Q?sDeP/7ru14DycUOtaTCN234A4+ktXpfQb/t0zmy63zdjwgOHCZXQN6BNVRxz?=
 =?us-ascii?Q?KcDQVt//QVI1HwhSvss7It68CbZhxKj3pEVLCP/KF4HUny7oqojhcp9mXcoq?=
 =?us-ascii?Q?ihNYJNcIW7pBa4Bj9HtdtDhqNnr1ptvcNYkBZ4nJvi0ro7g+8EA6v3M4Lr5r?=
 =?us-ascii?Q?zk7ybqT8LIBpyPDq0WMcy3lNRARmkiLWTVXBR35gclgYX6G0CWihne4ipNJx?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16bfceb5-f0c3-48ff-0564-08dca50dd31d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 20:36:37.6124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGt3BOCwGo69M6JojaAnOkorqR/ALuIoE7gAJAEDSTlJAxiPky2IdrpT/KeSNAip/j4zcDiZbhVrLWYqA2sERlwf3YIgfcv4wecq0gbZW2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5263
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Mon, Jul 15, 2024 at 10:21:48AM -0700, Kees Cook wrote:
> 
> > Anyway, following the threat model, it doesn't seem like half measures
> > make any sense. If the threat model is "we cannot trust bus members" and
> > authentication is being used to establish trust, then anything else must
> > be explicitly excluded. If this can only be done via the described
> > firewalling, then that really does seem to be the right choice.
> 
> There is supposed to be a state machine here, devices start up at VM
> time 0 unable to DMA to secure guest memory under any conditions. This
> property must be enforced by the trusted platform.
> 
> Further the trusted plaform is supposed to prevent "replacement"
> attacks, so once the VM says it trusts a device it cannot be replaced
> with something else.
>  
> When the guest decides it would like the device to reach secure memory
> the trusted platform is part of making that happen.
> 
> From a kernel and lifecycle perspective we need a bunch of new options
> for PCI devices that should be triggered after userspace has had a
> look at the device.
> 
>  - A device is just forbidden from anything using it
>  - A device used only with untrusted memory
>  - A device is usable with trusted memory
> 
> IMHO this determination needs to be made before the device driver is
> bound.

Yes, and it depends on the device. Some devices should be filtered
early, some devices need to be operated against untrusted memory just
to get to the point where they can complete the acceptance flow into the
TCB.

The motivation for the security policy is "there is trusted memory to
protect". Absent trusted memory, the status quo for the device-driver
model applies.

> The kernel will self-accept a bunch of platform devices, but something
> like the boot volume's device will need something to go look and
> approve it.
> 
> Today the kernel self-approves untrusted devices, but this is perhaps
> not a great idea in the long run.

Right, I think the capability to "forbid devices to protect trusted
memory" can one day be deployed in the absence of any trusted memory to
protect. I am just not convinced that needs to be the task on day1 to
assert "mere authentication exists, all devices are malicious now even
in the absence of trusted memory".

