Return-Path: <linux-pci+bounces-22269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E3DA43027
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 23:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2BB171197
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 22:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB461FBCB9;
	Mon, 24 Feb 2025 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQgx6tkp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6D62571B2
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 22:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740436308; cv=fail; b=UorGqJAi6yjZY0IAjawikRVHRt3FUBBtmtk+8i05IsvlcBD6cfrrIzHry3ZeZ90+F5Llp/LrDDwjES/KHy0lVNltHABuPfFu4UK8ymOgo2uIHjgJxHLracxAD9v1ONNWGRm0HGZn7pOl/V87s5Usk53tMhoDkJybTKLjGwQVrzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740436308; c=relaxed/simple;
	bh=ea2rynpN4kjyZGc746WxGq7NXC/fTmOQlluxT/Fv8GM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NEMEhVxAzT24nzylxKUg4xPH/eje5oryL0QxHoekHIoabeD39OUvM+t5FgQc0tfFlqNDAot9MrYosksjbuLOTmdGobxWJV4l32KNdoS0aPfezVBkkGsLugAupg0GPwFcRLGY6wtMLjWpvQ0wCuCaPyMWKS30jxWOz2tcqAh+MZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQgx6tkp; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740436307; x=1771972307;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ea2rynpN4kjyZGc746WxGq7NXC/fTmOQlluxT/Fv8GM=;
  b=AQgx6tkpuTHYKbLIUSFN2YiXHQy94B9z97QDR1o1D5Ts77T5Kq/KGzBJ
   bmx/IpPo14jauLc76wIqsRgOfN2ODDo8VTp81OiRmPsnPNLapi6k8P8Th
   n3mri/gxi1mRRqFnJrsj/Pt+3RMcp/OHNZWuSzGRJtTykDjuoDHY788vr
   9kP3pxsVdEzCvrm0a59XfAscVtKUkf9OHay3RufsykkM6ZtCZw+jWp1Jn
   FUcbDkSQVM7+5wr05G+O1Sp7+jWOaQ55rOvwu9MIdXGLxA9nxo3m86nSm
   r/EGTJZM6ksRT2BgkUVxdKSDU/S4UFY3XWLSVTbcq6VYtd8KjIM17cUFN
   g==;
X-CSE-ConnectionGUID: vS7p6wVVTtu6EbBmKk5ESw==
X-CSE-MsgGUID: sXcURi6ZS/ONmcqLnRbn6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40452502"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="40452502"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 14:31:46 -0800
X-CSE-ConnectionGUID: /dLo2FR7SlKtdA27SFu92w==
X-CSE-MsgGUID: sO1WdNYcS7Ww43zAur40/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="116692077"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Feb 2025 14:31:45 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 24 Feb 2025 14:31:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 24 Feb 2025 14:31:44 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 14:31:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5PXPnZREY0B72687CKB2QYIFCqg0CEmRjFIbMFOQyHE89CkiPXX1Rgkf/O8T8I66tyJKJ/EWChCg+mFQgQH5UcecIWsI0ura9KdGOd3ye+y7HKy4twyyK6IwbaGPDstkMDoj3tSXOzJ1xWLDHNuqjgw7fmOO7M/Z0sjuZ3VV7ArSnxibTt1nfoHkrcc8adTyy7McmRdUt1zopEv3bBf5SmqehvQ1XYMTTTBi0GkSYzUR12M88jO9wbIrqaQOt5h3Kjj+JRtMhKjwGyDNnnxsH4GjfghWrW2d0eLxBTtC+4C/kpCWic+UolWuWoGLxQinRY3QMh6hY39bDEBtMT/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRBysIt6bsBpaUfA/estCbZbHHTbSDVP/Pxf1JknZDM=;
 b=SjpXkoYD4xKPOHplc64HA1T8eNIkTl7yIzlqyRZsKwbHPpcgU5icDePED0pJsMo99mapLdO9u9q9zaokS/6WI06X+K8ibOPLjpjL0AgUnJjDZPp5JXr8DRoDWx5keEy/QA0Dvudezp5bX3xI9yXUEQ3ZeSriBnPQ3gMgX1DS3+PsBSYd9+Ird345cAc4UbFqaCOlBL+lwt2KW4BAN/fht7WM5vpYLp0ZQdSLTVoDnKynVihrxX7z0iOwAS5Tv+0iR3f+MHnk4iXEaVwB7s6+vVsIWd7TpxeRlWb5+/bfbUusj84YZFmE71VP/vaJ2WOWNfQsKwDYzAgDfKtggrqaFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6660.namprd11.prod.outlook.com (2603:10b6:510:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 22:31:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 22:31:28 +0000
Date: Mon, 24 Feb 2025 14:31:25 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Xu Yilun
	<yilun.xu@linux.intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, "Samuel
 Ortiz" <sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <67bcf33d4a495_1c530f29476@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <yq5ay10oz0kz.fsf@kernel.org>
 <Z32MUFBIyp0IKyzC@yilunxu-OptiPlex-7050>
 <yq5aplkuu7g6.fsf@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <yq5aplkuu7g6.fsf@kernel.org>
X-ClientProxiedBy: MW4PR04CA0248.namprd04.prod.outlook.com
 (2603:10b6:303:88::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: 900e9759-8e2b-48c0-dd55-08dd5522fa98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tYmctb8Wc6aAThaoT+mtebicugfhzSjK2Ub7h49aMU8j43FFn15l/6KIaFTE?=
 =?us-ascii?Q?CV5Wud58NkopWHn8ACchcIE9XZHj1zRl57Oyi32+Hbgvl74rFWb+a4qXq9eV?=
 =?us-ascii?Q?EPFKaFbSH5gT+4WvCWoJFvoilQ+nZOWSwLUI2fV3CM5hQODWxzjK4LPO+Vb7?=
 =?us-ascii?Q?sItUI0AcLRFWeX7z0LPDd0/UAxFYxT3rDz8rf8x6cUpDkqJsYXZCpWGbG77U?=
 =?us-ascii?Q?dmDtfpDb9c2Di/nF9a4EUa8KOKjGxEmYRuTO3IinVK4nD1jlPpNCdZw2nXHP?=
 =?us-ascii?Q?Bd5tyeVqAw7KPNjK0pZleNxaisvjEsQ7h5w4Mp3FdKzbRZ+ZWhszLMo+OiDp?=
 =?us-ascii?Q?zXJC599CUOmpbaeJM6ugwSNtpyjuUKKZJ318dnIsbnIAzwADyDxAPqduB6/Z?=
 =?us-ascii?Q?mVhrfS/7GixhPETpc3ENzlhkF1Yr025Pn8PsfxI7losptCfWXOF8vSG4NyrW?=
 =?us-ascii?Q?sVTiHTuF/Kl2rftRxk2OUDZudT8nxAEZb42PB7Ujml+tz3nO+ATqriJbAKv0?=
 =?us-ascii?Q?0bml8LXyJrHIh/XmC4H1eAmxYFCCYNwwL3xdhZOu0MnUvxlcUp2prfgb69TI?=
 =?us-ascii?Q?IDr6Y5G0aSTpmhb+SWwpJDhXmrxw05XUnIclSXdia9NRvfWDUZk4fLSQWP5v?=
 =?us-ascii?Q?9f0QkB00Pa7Jh0ikTomcQj1kFM5+ggoytt6onh0golp5qt4AozJVSWLnRCkm?=
 =?us-ascii?Q?+CTTOl9BW8WxR5VqhOR8rEQ7AOA9AnyNfsL7ztHZ4OkW+9M23AfRHZ+CkZIl?=
 =?us-ascii?Q?WI9qAvtWVF+dR4avOnATAq4rW6YWzXjDS8aKBH3+g19GVDAmCPW4MqvQHb/F?=
 =?us-ascii?Q?r5xRtpjFWx19GghJnC/BSkPpebnQZ9rbvwHTVlwXiGP9YtfUNfTPQVTczBTn?=
 =?us-ascii?Q?oidB0c+uL+YOQKiTKPc3lSoRJjQVI4m9T4U2W/rRnYqYPXk+oVUquo2YLU5Q?=
 =?us-ascii?Q?6cDB9yeDPi+3jNJ8kA+DcLkLyS5a6JKKuHViui9APu/BA4GCUk188AJiXQGQ?=
 =?us-ascii?Q?1wDeHNzTF5NyGIzhn23X/+NPbOlzco97ukPsGHOQHnVgOzTyv7nW3EaZhVm8?=
 =?us-ascii?Q?IbqrzIg7XHZMzrk4zRoREAEan2mY9L3qv/tRgAnU2rj3LOfUK6wjvBZxpi89?=
 =?us-ascii?Q?qmm1BT2BEaYOKsdRwcLxBOWkJcSLricm6jwtxRFdMEzaveSakC3LpjpbifYA?=
 =?us-ascii?Q?2o+zrQpz1pQCp42TATmWARcCfWIX5Ze7/S+YpZ7e+QADEEaqVLeLreWu4ZZd?=
 =?us-ascii?Q?fh5uEf7YG29rZnqnIzWeEnnjWtm0I8KGJuN7yufsYnnMqVtxlQiqO3NLiyvo?=
 =?us-ascii?Q?1rCe70DkcOrho9PlR6xTYEbcFeseoWGfnJuSmes8xrmGdvvvoNaHn9nncpf6?=
 =?us-ascii?Q?0vYUInbLynpamgJhv7XKUSkIvDR7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WPGhX02UEuxDI4Q7LhuE4Il558us2RZ6liXpsUtwch3GV1fskl4zJvKPup1T?=
 =?us-ascii?Q?GSmoFkleRgfHnU8DyEPOviJ+yIJ1L3YlHrPcERLlEiUzEM9NIVOY6yY3b3CW?=
 =?us-ascii?Q?wt/imRN2u1iBiUsycU1C7E41O16C5gM7dH32OrzoYRmRS4p3h1KPuYqYY+Ht?=
 =?us-ascii?Q?sOmfztCgIu8xwKb2eo48X/F9uFseXu0+OUI7eSNfMJ84scSdWE51qUKwYVnl?=
 =?us-ascii?Q?mKMPJfi33QHJjOTei07lS0jqGjEXqB+mlDDXor/gyeMThBjxsT1XArwjv1M9?=
 =?us-ascii?Q?M2wBGm4w+HFToppbiU5m+vyGoSh0DWpEnWYTCofd+3lsO4hw9Ca16xYExVoy?=
 =?us-ascii?Q?mH4Ysoi/yfszz+IWfDQq9ps2z38jt/jJcIuETC/bTyN11aNb5tu86JUDIrR6?=
 =?us-ascii?Q?4x5dGU39RvqrjqUfua9GlveBHERc2VGyxRP/TALo31JaqlaK1RcOvsSW2qEZ?=
 =?us-ascii?Q?Xu2mH1NoLVsOKnD+pvGETAT2d2+QYzIaKQmCJ/a2F0maLJmfKbeYIQk3hKvA?=
 =?us-ascii?Q?sbQN321h0BJI4h9uLW90ypCL17qCcTtCT6FZO9SIWvV2psX7qvUMotb52rfz?=
 =?us-ascii?Q?o3cqHwGL1PG7rZajVaMZmZRpKblTedQQVEx9pvOAJ2BCU+59BxmuLI2hlLCj?=
 =?us-ascii?Q?ssCXmiZSY3fGo13cUNthg04y0v02BO6nxAXoUchpZlhEmsCn9YtuWruuztDn?=
 =?us-ascii?Q?UNGWQIUuvg3BKGMRyAKSx2QbrC5DP4UZGvAknvbOSKU2D+CXK/PmWtTS+/eC?=
 =?us-ascii?Q?a2cfCymccwNYwx604A62+jEsiZ6RjEmnZ7j8JsUVkFo9g03K3vYQIo5xfPtT?=
 =?us-ascii?Q?O3iE6GMPNLJqAuPZ/6HsGMSkbfquluiDp3ImaeYUhnszSmvNUdeWM2BZSNI5?=
 =?us-ascii?Q?84J28T77vgwvxY/wqSOWXuypenN/PE5Ci9iY+mgH1jKGGazNr9qlbs9Kdv67?=
 =?us-ascii?Q?d+Apul8zyFqk1Q8FT1Dbdw0nVCkBbC8ZNlC23OTv8WcBaRlUwXI4VDVDE63y?=
 =?us-ascii?Q?Agb/0l/QPuW3dBlVZ/JZ6XXAQck093tUhgUoY7xBvtzulhDCYotZRkP0HCw+?=
 =?us-ascii?Q?KVgyeKNRwxyFSpYBx8ZwveWgkvDy50ghxrDqVyrv+INI2mSNJoHNGY3r04n4?=
 =?us-ascii?Q?wi2jImXaMFFDzXnqStpEoFdCIwKTyeAAD2xAwMpR0MAdBpkEruCKRY8hTNhm?=
 =?us-ascii?Q?wnmEIfxxAxZ3XkljIwU5cxgFIsEU4CvGVNkQkt9HPuRS9cG2C1HP8TAYPOME?=
 =?us-ascii?Q?xXY+X6vChr1WDORYiA6O0/uTUCPHZg+Tw1rFmuo4/uvO85pA2x3DmI5AQlxc?=
 =?us-ascii?Q?PSgP4BLNtuEV0uAwUrSgsGhQKDRs5Tgdlaw4vT8vSmTHyuxamnCkEC6rMY0B?=
 =?us-ascii?Q?vQvZ4mLWnDXgt833hjAtHd82JgGvmhDkdBViOhbBlgovmBZ4Fc56JlrFPNHF?=
 =?us-ascii?Q?2G0K6ncTuMXb/QTyRsGf9htUVNakrzvcEAX1XiSZsEelr4bYylnlejory25J?=
 =?us-ascii?Q?J2of5suuNZIKw2wgb3WhE43qBofnpo089bTR8TMdPkQerO2DnN66tbtMgyNu?=
 =?us-ascii?Q?lLVQGc8fJgZs/GseT9AKAJuOls7bSMr4DSlEJeVBtlOXiHh/EUEb2C6aSisW?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 900e9759-8e2b-48c0-dd55-08dd5522fa98
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 22:31:27.9257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wY+aF7yiEPzKCW/3tvdNZkP0xdM1sK5NtdTVgLjYvxPVzxK49lH3k97KPzbLIG6ZPw4upP0536gUnvvK/zVjBhYmBz8yY2ZiSitJVErr1dM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6660
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
> Xu Yilun <yilun.xu@linux.intel.com> writes:
> 
> > On Tue, Dec 10, 2024 at 08:49:40AM +0530, Aneesh Kumar K.V wrote:
> >> 
> >> Hi Dan,
> >> 
> >> Dan Williams <dan.j.williams@intel.com> writes:
> >> > +int pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide,
> >> > +			 enum pci_ide_flags flags)
> >> > +{
> >> > +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> >> > +	struct pci_dev *rp = pcie_find_root_port(pdev);
> >> > +	int mem = 0, rc;
> >> > +
> >> > +	if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
> >> > +		pci_err(pdev, "Setup fail: Invalid stream id: %d\n", ide->stream_id);
> >> > +		return -ENXIO;
> >> > +	}
> >> > +
> >> > +	if (test_and_set_bit_lock(ide->stream_id, hb->ide_stream_ids)) {
> >> > +		pci_err(pdev, "Setup fail: Busy stream id: %d\n",
> >> > +			ide->stream_id);
> >> > +		return -EBUSY;
> >> > +	}
> >> > +
> >> 
> >> Considering we are using the hostbridge ide_stream_ids bitmap, why is
> >> the stream_id allocation not generic? ie, any reason why a stream id alloc
> >> like below will not work?
> >
> > Should be illustrating in commit log.
> >
> > "The other design detail for TSM-coordinated IDE establishment is that
> > the TSM manages allocation of stream-ids, this is why the stream_id is
> > passed in to pci_ide_stream_setup()."
> >
> > This is true for Intel TDX.
> >
> 
> IIUC ide->stream_id is going to be set by SVE or TDX backend. But then
> we also expect the below.
> 
> 	if (test_and_set_bit_lock(ide->stream_id, hb->ide_stream_ids)) {
> 		pci_err(pdev, "Setup fail: Busy stream id: %d\n",

This is an after-the-fact "trust but verify" sanity check. It is making
sure that the Linux-view and TSM-view of the Stream ID space stays in
sync. 

> Hence the confusion why the stream-id cannot be allocated by the generic
> TSM module as below

...again, because Linux has no way to convey which Stream ID to use to
the TSM.

