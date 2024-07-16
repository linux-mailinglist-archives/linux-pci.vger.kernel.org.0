Return-Path: <linux-pci+bounces-10343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D905931E88
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 03:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19313B21C1C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 01:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8B8568A;
	Tue, 16 Jul 2024 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Etal6kU4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B64A32;
	Tue, 16 Jul 2024 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721093734; cv=fail; b=ZTNnEc0JUpMd1/vQgVHXirC5d8uw/Pg+uiV8cuysXCDXVRFJjOLqGgHwa/s7bf6otu1sgJv3M34drUODSnKz01DYmSayOQu9jFs6/ArqXxlr/+yqtFCnVo4wguR6yA8KEpOgp+/0lXa+acGhla8cfYuDRrDjWx7yLR/ajj3reYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721093734; c=relaxed/simple;
	bh=SEhL2pqX0ZyUHcIhFVUiwo6r54fR0WouFsTDCdXPg1A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MgjSgIVi7u8jQcoeNFDCU3sR9JSA2Z8NvLE9GqzLDUUnr4dUQoycF6nz0187RkPd+Rcf16PfvlGqsgX4bFdrpVUpYyUd/l+tfeDeU8wn1vnpJ2Ds1wgHJdKW9uKJrM32Bsqj43UiPrqRJiiAcAg1boo6bWL0Sb3kPKIolFqbm5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Etal6kU4; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721093733; x=1752629733;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SEhL2pqX0ZyUHcIhFVUiwo6r54fR0WouFsTDCdXPg1A=;
  b=Etal6kU4KOvXcLCl2hAuSh4NkRyRbGGvJzmHkfrEN1+bc+Jk1/CIidbN
   2HMPV8Q3PvoUVIL3xZjuXKvw5ZOB+sdvgsD39HbnDhNLCpWTeG+eE7dzu
   tpcepl88ohH9ng5W+2GDow+uGOA7VUvChB7scWFGk9PlsZ3rp9utspdOk
   EFnxKtfBYiufMS6kfAt0/Ye73HEOTxKdJqOtQmVoJszq6ulkW5zwvjl4Q
   Wr3Y25MOQE6YD0AQdK92gFX6RTG+UoCipBFDElTBeRDyEunKfIY+2ZgSV
   +/sG8y9HoGR/QKxnTPBogUO/AiY8zZt0u60hKgG4NTH0mQlPVpJfT0Ux4
   Q==;
X-CSE-ConnectionGUID: 7z3TNs7iTFq5aYMThAxDxw==
X-CSE-MsgGUID: AplJKeaDS02LZ+h7j3fknw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18700934"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18700934"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 18:35:32 -0700
X-CSE-ConnectionGUID: uQ+XBCeqRV2rVmPBMmqPtQ==
X-CSE-MsgGUID: j8MH5K4fTwq3NS7qQQ90eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49910461"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 18:35:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 18:35:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 18:35:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 18:35:30 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 18:35:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkxXkMNnzfco+wc3bgjeJDMbqntJNWN1vHTTs8ydhgDacG1h81sIQMfeL9ThhWxutnLr7PSCrYfj+Di+42D2KgEkMepp9KBAP+c8H9v4U6Kg71iIofHgQgTK252FGh2cjkoSwUE7VJ7D9+x6u5LneXZN5PTsnVkOpJcA7Tn5RHyTsyPeCVfwyKHB7IQ7pVR5gELdLKOBwxZucNPM7E596CZ/nYlYZ4XbHV2u6tEfxaHx6RF5KbbZ4jqiM3/JvoiO8TLKuhXnnhOp8AwRhHqgy5BDvmkTOlvY2azqxibwvD7EmuEWWfB5HZCM8j49yqzJhX7pvYvueGWRCToWUgJMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZV3yjCKUZ5QEwspxsFTOBNQELfBXrghDlqK5Siqolk=;
 b=iThgGu0mkSJuGvyrlWyp6w/1TLpFAJYfHW+kOrUWv2dmz4TzHnarhgHqurCI5qxPmOwPIRcvi3djUAHHJGgchTdYOiiB9PqqXDb+nTdyAzVWuad3gLx2zJJTAU310yDhrzbK8Ir2o9IUlNsxjh+I4mkpzIEV3cV/gsUXOeVOBSCiRiSOrf7r2rfLdSDeHk5HqlW1eXe/s6fttBnWpk0ZiP/cCYK30MK4caTV0LlVkfMrkCkNzydiUhabQ3uBr2q4f0mnLLgHlJfIynURs0WeKlgeQs9knhHqZB7p+XmL8/lR/OQSqWBw9hEmBPGOVgK/FilIgzkzIyDcxv8baXeAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4653.namprd11.prod.outlook.com (2603:10b6:806:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 01:35:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 01:35:27 +0000
Date: Mon, 15 Jul 2024 18:35:23 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
CC: Kees Cook <kees@kernel.org>, Lukas Wunner <lukas@wunner.de>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>,
	David Howells <dhowells@redhat.com>, Herbert Xu
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
Message-ID: <6695ce5b8cc6a_8f74d29447@dwillia2-xfh.jf.intel.com.notmuch>
References: <66901b646bd44_1a7742941d@dwillia2-xfh.jf.intel.com.notmuch>
 <ZpOPgcXU6eNqEB7M@wunner.de>
 <202407151005.15C1D4C5E8@keescook>
 <20240715181252.GU1482543@nvidia.com>
 <66958850db394_8f74d2942b@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715220206.GV1482543@nvidia.com>
 <6695a7b4a1c14_1bc83294c1@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715232149.GY1482543@nvidia.com>
 <6695b29d204e4_8f74d294f8@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715235510.GA1482543@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240715235510.GA1482543@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:303:dc::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4653:EE_
X-MS-Office365-Filtering-Correlation-Id: 21867277-2e7c-4183-a177-08dca537925a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nXEPNBmYWLrcUpMvQ7TGPT0VzoCvlXrAeoIM2exr4hHbcFsjqIYuQw72dUwR?=
 =?us-ascii?Q?F/BqWzFNGMzsFj8/tp32JTH6vv9j1+ZeCor9ydHS8r4KCzj82TV78Kagw0rJ?=
 =?us-ascii?Q?CZMFSgX0B33YPOyTW/CDVZ5GepKKSULPDNMCvWB5/n6hrkbqvuELQyLcPwrU?=
 =?us-ascii?Q?wxe/qgCAThzH8vCWDxIPh7VpwcPAaoR0eht3CFRETr/uWsTgU0O10CwSant0?=
 =?us-ascii?Q?ofuxuZt6s9F43QGLKtPhX6Q0XVmPojby4lriFoXds4IPfX+4O9EFb7utFnDl?=
 =?us-ascii?Q?7Y8jBSyZ4XmpwlKGY5QJZecHZoJ/AtOZd1e3HF5HTGRxFUNbTzsn4tv42jRf?=
 =?us-ascii?Q?x6uU8s5+JKNHIYNVubFrxMn5D7JnhDNqTOExkXEsc8zoYKRrIwcNmjnaLoDG?=
 =?us-ascii?Q?HpJ2juwtJbXk0/U4OO4rZtPCZeqnHUXvee8W75QDex17UeId02cGYtm+zcsn?=
 =?us-ascii?Q?EqzCfgQuMbmzkoZ3uEdVqOG0IKg1doLvysDgRL1GAA+QLm6uk2u9pmebtM70?=
 =?us-ascii?Q?5R1l7Mkvepm0sf5dAtGUd68otynaAXgvQHHBq6dgGtIexJxxqvLd5RpZStOi?=
 =?us-ascii?Q?BnNQWpZ09YQrxlQJLUDK9spCHsBgfSEpj77KOZjrEKLN6PjleUdNhwpfIlj8?=
 =?us-ascii?Q?Qc0LkvGygYDX9V/uONFEyOdRkgsa4JZeYlziM3BB6M6wOgLODQIsICA7vssq?=
 =?us-ascii?Q?a+eHE/IGQfUUW2uvRsmOzeBPDMtgHntzHsSNLVbVW7DMDENJs1GQLmTu6F/4?=
 =?us-ascii?Q?uyv20Q4Ief9UPfYKhbxlHjJGkvVZ20hrF8x0Q9fyA1yuC1/ZEolZ0juZkDEU?=
 =?us-ascii?Q?SrjO2syeVfqrbtk2ZOUFrVnoxOhPTZ+RVAot13UdchrsNE5YxbM9Kgy4rmj+?=
 =?us-ascii?Q?f22oTQS6L6W+o1+Rrs/5XyslT6wUdx+5Mjs89DEFTuXxY1pSmXQSEIITR8g7?=
 =?us-ascii?Q?+1xJd7x//Qblvkk/ybzlg87jCPnrCgJGKU8zT52iNNg38rL/+z0hpSo77D3z?=
 =?us-ascii?Q?29VVEt7l8s+RIKvxedBIvC1SM/GiqEf8jJh9lCLC6918lywuyg5AYbWjwDF2?=
 =?us-ascii?Q?/Ne204qQ8+gsexGMraIBjmChXVmsc4kB33Q7UOWmF9LSXQdPkIVJ0fRfr5ja?=
 =?us-ascii?Q?MUXxijO6XnGxwH/zN04DOff7FzObjfMJzczxyC8bfqaWXc6qFi7f00pxUqdM?=
 =?us-ascii?Q?q4KiBazmLpgGUN6h39fscodNV/LTZ9NSGYIgIXc79oyQ5vnStX3ihIaK0lEs?=
 =?us-ascii?Q?9EcvMvvKMCFfbCgVPtg8dtWeX3+oFUO9OYumVgQeD8XjKqOKuwPMs4r6gjGH?=
 =?us-ascii?Q?z4HFp9n3QeVZQLiNihH6erWOO9Sf9i3Ts5qIZj5qHcTnAg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3DU+XExeR0XzlCleUbo+FCgdoebi3CJChVkZ4jttvtElYiS9XFxXaYAluXGd?=
 =?us-ascii?Q?CL1sfQ7wuNWbScBAMp4v8Xtzpo75Y03cl0ZrtC0IDbUs+6Awbj3U82XhwMCe?=
 =?us-ascii?Q?4wtDMh9jPcQ158Cnos17wbQqLzFH05nKTkJHBg09rL2ZaIespJe1k2TU3WBl?=
 =?us-ascii?Q?sIiSjA8tjPev8XYiExtsKe3mHWFB1qnXUr+7qf8oMZbbykxI70QzzhPanJ4f?=
 =?us-ascii?Q?Y/ruW8MYvYSD/ALaZjiEg8NO9kGeeMIup1gI4srMDDc96andaGyrWH9gKVS6?=
 =?us-ascii?Q?QS0CIWcWgtlq6INKiFysl5lG6ReoS6I3bSll7AGvGSSSzPTHLG3cxuXk7fl/?=
 =?us-ascii?Q?atIhxiwWu2lLaTYycvRpnJaM/JS1dbKhfUFYGDO3QFf66T59azXZ8i5Ur6xk?=
 =?us-ascii?Q?V13ZADFHKhXltCsV1WXIf622RJXmfkoI6Sd7yzh0kT49qWndD7Z81q6MqL4s?=
 =?us-ascii?Q?PZENPl2IND86UXMrqUPRZ2IRG2PsynC+Gf7ygDqHOD68GldtiDqixHvSEThn?=
 =?us-ascii?Q?E1fqXbQ6t0SxbrmAvwIJ9SEwaN2t2iXj/kZL/kgw3TnD2WZb7qGmp+R4lPQ+?=
 =?us-ascii?Q?hSJameUQNzqrXIe8ej7k4b+7YiroQ/url7pEtmu1xNmvubEZaJHXFKYmRLY8?=
 =?us-ascii?Q?6T+uJFlTrJR0FqK8y6qNUm/djW3dgWsJUN+cxxv+TOjT7crRT+54PS5dm/2r?=
 =?us-ascii?Q?uGZ1GlhH71yV0f6Yw3UMBTzJm2/BOm75HSnA86UFHJwzOfgusYvHUjhcb+F5?=
 =?us-ascii?Q?wDFdm6EsGefNqeXjaleiKHybDG/ipfJpRU4Pdl1+MRSP9W3kCAK/n4GDJQy8?=
 =?us-ascii?Q?gqfaFXxlVLVOIrrrIUFAZX+cXy5DaDWdzDZpX3dfii/r3hpu75Zcb0JijSb9?=
 =?us-ascii?Q?qTU0e/+AKpEOzHaPLbjCgt/8rqm2d2BUYIcSprjW7l1s4I4uXV5oToPrPenY?=
 =?us-ascii?Q?zI7JMVpt+9tTpSzzg40I7a9QFrE7wNkgqeNuCT+h6VkskEArHvUM10HhlidS?=
 =?us-ascii?Q?lr9HMcAnMksIsPosOkL7KuhZtb9f/LWMJI7dw8PxJrpE5wLX1TQeS1oFQDw3?=
 =?us-ascii?Q?DoSiqQ+pXtHEDhgDxihCY34aW+1G+KzSO8tuiUkrJdFaubIA4IaIU+6vC480?=
 =?us-ascii?Q?9qbmMM/CjukLoIlbPlFSANWVaEwYZsEkcKcLXJ1G7bq6yxA2thE8X3LhxUAf?=
 =?us-ascii?Q?10TbIuQaeC3SwVncmysTkz12pPT4bTIbBOFdURJRmi6CpdxQcG4657FlOiyn?=
 =?us-ascii?Q?g5wnqQQi5UAT+qWCcdeIaILSQ597OQzkkSYmFRt+PWCuN+UJqCg4Cm7ZnIKq?=
 =?us-ascii?Q?8aI4YjaslM/ukQRQKtNpfAdWUAaMc9Artk+1kNw9tB/Z8ShDoDBDZQzo6j96?=
 =?us-ascii?Q?021Ii1DmZHEl9zL/V1wU70iMn/GKGO2ceW1cChr+/0NltMQxsqPqPHWf7JG7?=
 =?us-ascii?Q?WWUO+JnSqjtiFuAvEG6OaXpn/zSWfgk4EB975uqUseffHtvNOXz2X+CzlHwH?=
 =?us-ascii?Q?ifLXvXXidFWzT3qt4Rxp5kScbR1s2M92xQ2kEeYbk2Q1yCrY2aXhJ4gs6nrJ?=
 =?us-ascii?Q?H2umynnxATPaYsDOQ92gnusjgAfCoQZPAdPjnLmJ9AYmdyseUNCKahAwakth?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21867277-2e7c-4183-a177-08dca537925a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 01:35:27.7859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqewHhNSf8vffkKEuhoidDz1Y3PgJ1xh8HcxmLD564Y7RmuhmYaaKwvyUuqJgdoeCims7KV2D5H5NP0R4Wm8to8GlkI0suxpn6xV/kyZkIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4653
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Mon, Jul 15, 2024 at 04:37:01PM -0700, Dan Williams wrote:
> > > So from a Linux VM perspective we have a PCI device with an IOMMU,
> > > except that IOMMU flips into IDENTITY if T=0 is used.
> > > 
> > > From a driver model and DMA API this is totally nutzo :)
> > > 
> > > Being able to flip from trusted/untrusted and keep IOMMU/DMA/etc
> > > unaffected requires that the vIOMMU can always walk the same IO page
> > > tables stored in trusted VM memory, regardless if the device sends a
> > > T=0/1 TLP.
> > 
> > "Keep IOMMU/DMA/etc unaffected" is the hard part.
> 
> Yes, but that is not just "unaffected" but it is implying that there
> is state in the VM's iommu layer too. If T=0 goes to a different
> translation then the DMA API must change behavior while a driver is
> bound, which is not something we do today.
> 
> > Implementations that want something more complicated than that, like
> > interleave T=0 and T=1 traffic, need to demonstrate how that is possible
> > given the iommufd maintainer declares it, *checks notes*, "totally
> > nutzo".
> 
> Oh we can make the iommufd side work out, it is the VM's kernel that
> is going to be trouble :)
> 
> Even in the simpler case of no-interleave but the same driver will
> start with T=0 and change to T=1 is pretty complex:
> 
>  dma_addr1 = dma_map()   <== Must return a bypass address because T=0
>  goto_t_1()              <== Now dma_addr1 stops being usable
>  dma_addr2 = dma_map()   <== Must return a translated address through the vIOMMU
>  dma_unmap(dma_addr1)    <== Well now you've done it. Your kernel explodes.
> 
> Maybe the "violance" is we have to unbind the PCI driver and rebind it
> to get the goto_t_1() effect..
> 
> Changing the underlying behavior of the DMA API "in flight" while a
> driver is bound seems really dangerous.

Agree.

> My point is if we start baking in the assumption that drivers can do
> things like the above without addressing how the VIOMMU integration
> works we are going to have a *huge mess* to try and introduce VIOMMU
> down the road.
> 
> I'd be happy if V1 forbade the above entirely.

Yes, I think the requirement to go through rebind to cross the
untrusted/trusted boundary gives enough simplification to get started.

It also occurs to me that complex devices / drivers that really want
mixed T=0 and T=1 traffic from one PF can ingest the complexity without
burdening the Linux DMA API and IOMMU layers. Provide 2 assignable VFs
instead of 1 and do software driver-to-driver communication between
those trusted and untrusted drivers.

