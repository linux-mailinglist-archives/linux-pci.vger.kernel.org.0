Return-Path: <linux-pci+bounces-7140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD928BD844
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 01:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FA828297C
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 23:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14DC15CD7D;
	Mon,  6 May 2024 23:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJ0WNTFS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244B15CD7C;
	Mon,  6 May 2024 23:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715039267; cv=fail; b=hTJrl9jvWWwERs6FZrH37BIu/QR1eYhWR8kVJQB3Y6ERFnVg1NuoGqYaaNxQ2Cz2/1ZU4XlI29f+XHF4ONQQg5gt6QwRnk6z9CP+MjhdkljtCmwkMlVoi7/64GiLciJXLWLd01f74xT4aERRLQhoszO8B4bRrlOF9IWbShk1bvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715039267; c=relaxed/simple;
	bh=hsuLy81vm5TRlO4swPWtZkq2iD0RCjpBllkeLqzXDBg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I5TobWk4PrGNRvP1gqHR2FLm1/NrEF8l27+B66aN34Sq0yQtgGjJK3mSQM/bf1rONMn8r7Ig1DljbO8vMhVAbXsihsKelGAwtAOXqltp+Fw+l86bOiDfCSq/lmdW3SPz7nqBc+ngcAAGIDhnrJ8Ivvs5uiSGL47c6QnSistuDF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJ0WNTFS; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715039266; x=1746575266;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hsuLy81vm5TRlO4swPWtZkq2iD0RCjpBllkeLqzXDBg=;
  b=IJ0WNTFSSPbSzfOzZCQUF+PCC1FPfm5HmBIDC+6+ugiqejc/6miQLcnA
   1SB5vCdRXSvRsBNt+w9FElb9hdLtYajE3GqDb0eWLRRnVwPm+hAHRmhqN
   UCIrC+1eNzXg1OkkV39vtcOZERujNL1mvmzw0fVl3LJxXt8f5Ek2/vx2y
   O4mvVOoK/0Tzvrf+j6okXbnhYqO0C+wfoh8YopyrHO/45Yq7ncAwHBFST
   J202OLFei8FcdaXZcv5354pm3gecF6IUwFBNNd+a7PaF9aDYpvLjC41Eq
   nia1MvznR4VhYzhc5NCVdNx91annMsLsv4iTV1e/RY9LjQkp32Yaq/Bwg
   A==;
X-CSE-ConnectionGUID: YjK5jhg/RgW2xGYhpdloYA==
X-CSE-MsgGUID: 8zrn8USZRrm8HLG0nA56ww==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10643979"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="10643979"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 16:47:45 -0700
X-CSE-ConnectionGUID: dACXeJFMSEiGHma4qMqb/A==
X-CSE-MsgGUID: zGpD2Fz5SJKmyt8AkR3P7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="33126490"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 May 2024 16:47:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 16:47:44 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 16:47:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 16:47:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 16:47:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqnhZrXEF0je0k5W9vhW0L3dYW0OBn+p2xLQS/ACklWq9JKCyO877GH+0WounXOykPPjZ+EpU4NQW5WQVhbC7iOeoiS6Ahz8NWJ45HcJ/sVseGErYtXeNuAyFzGzECfvD/XIx2xQTyusKnvvi4FzwzDy+qEWKu5XJH0JP7lpIQIVR4ebZAZrDZP3ivTKYSoFDgY3kALO2SjvJiEp0b+PhOWS0WI1E6YPD7zATqqtEajtI8NkgkWye0ePsbDc9gmAFj8d2FNTQKtaL7Vyy//7X4/htSB4+oqzIyJKntInjZuU91rj9hKsGBOQ9UEj1xgTYUHqCizBzk/89+f90635fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VN5Gei8qOpWlo+1YuI4z7Wwx2fZsLqGXeF8lhR23IOE=;
 b=PkbQRp4NmToagx2Ud0AvVxWyPYFeDaZ6Cmdl3hIoegUxMVRDF5J7L4eHxb3CuGhycYpXOOsJQfx55GPKGvUpry1GwIxYeKX0JalTRFl30gfjJVZ+L7Dx3k7jj/yX2kCyu+jk+DdJsaWfcuiJYqlhZukcQW58Ng29ge3vFG+E31pOrkG/XtSwA7vXCnCuldZXieopGSNxUprA2045CYHZLS0ePL3IjYY9S97qHACIWMWLmVITvBJ9PUWpD3mS3lhwd5RvkXndl8Dpk+E2KSgXji8rxNibTloVToe6mQzqTpKY+L9E9bjxg0sJb44r55APaNU+eW6+KTeYiEMp7Trh8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB5967.namprd11.prod.outlook.com (2603:10b6:8:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 23:47:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 23:47:40 +0000
Date: Mon, 6 May 2024 16:47:37 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Adam Manzanares <a.manzanares@samsung.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "gourry.memverge@gmail.com"
	<gourry.memverge@gmail.com>, "wj28.lee@gmail.com" <wj28.lee@gmail.com>,
	"rientjes@google.com" <rientjes@google.com>, "ruansy.fnst@fujitsu.com"
	<ruansy.fnst@fujitsu.com>, "shradha.t@samsung.com" <shradha.t@samsung.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>, Jim Harris <jim.harris@samsung.com>,
	"mhocko@suse.com" <mhocko@suse.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] CXL Development Discussions
Message-ID: <66396c1938726_2f63a29443@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <CGME20240506192712uscas1p225316f79bb69f979b647d2a06a00a25f@uscas1p2.samsung.com>
 <9bf86b97-319f-4f58-b658-1fe3ed0b1993@nmtadam.samsung>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9bf86b97-319f-4f58-b658-1fe3ed0b1993@nmtadam.samsung>
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
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f7e2e6-b343-4ff5-2e68-08dc6e26ea73
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005|921011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X0kSU/CZWsm5f6CsvKNd9i3CDHZfqbIkYdHP/sqn6mZI4ssZciVMVG/dWP9R?=
 =?us-ascii?Q?Xn+gyQSbXZsEtHMkA0yg78OCxN216AOrqFlva+JXqKkZIZaixDKgZofSbS37?=
 =?us-ascii?Q?B/3298/ctNfaSWB4W39b5PW99PT1XKh4N/G7HQ/FxV5WxWwqO3fmUYXKltKr?=
 =?us-ascii?Q?xdZ+c8+CNYpcFJPTj+u1TPYOlkb76wwMj9Q363TyD6QZKMaGv7rhl/rZ1uOL?=
 =?us-ascii?Q?fFq8dPZnNC2JeQGqi14MIWBdVt9bkMEkE2E4RR8ipNFUuM0IDjP+Tw5wnHKc?=
 =?us-ascii?Q?a+6OaarTeYIzI+pl2yBd9JEl0eESjvDJtrET0Z9aqbtwJBUByefURtTk2nz3?=
 =?us-ascii?Q?XAgezA9ifHGd5RmxZSaHXKZAk+IN4+eL65kS28vH/O6gRLb4A5aB2bmP0Uoi?=
 =?us-ascii?Q?3G3wGkKFdWtK4EMmlLxFoFNZFlAjsA6W9ln/gG7Nt7v76N7+hHWipeVnQ1kT?=
 =?us-ascii?Q?vyUEkjC56YH/UDz3B4GS6Zzyb9STkPPLbeO4MTMp0tGaA8g87PQ9Mq44l+4K?=
 =?us-ascii?Q?GybybOd+K7Z/WkDspyBF+B6/0XzK14VG0WGWNiU+jL8hqf0mobc/IWIdHqcb?=
 =?us-ascii?Q?RIpImDUm/cSftm4A1sOCCT1RjLYNosfwyU2czv/1eJUCjBs1Zg/omZEseZe6?=
 =?us-ascii?Q?Q5T28Fl530dtqdTt10CvaZ7fsAeAE4MjDHNmoTNnARAX9AOu4Ls0oPWEFA0G?=
 =?us-ascii?Q?yz1hotSjD4sRo59DiwFCUfqCOEIfV4tmXiFUETOysBlBX+2aPNEmyTr8fVl3?=
 =?us-ascii?Q?PIOcTYdnSq0D2Q/FWYiCJFnNWvAWt284BmZHomWfwywsNbE4YusDrrGWhR/4?=
 =?us-ascii?Q?I38KmEP0sueuI3qcxqNJoUY3wRWUr6ZpQTzbU4uofepNDLJ5cD+8ITwvj/vX?=
 =?us-ascii?Q?niYtxzkqIHBW4ZlyqmvD3SAzf7pt658eG0muEKV9MpXxK6gwBkAAVlZ3Jo1t?=
 =?us-ascii?Q?7QzVB5AD3aNLr0r3Ftqq6Vl/n5+cLmZ00dvuL97U8Itl++twUa+Lgu/R0+UW?=
 =?us-ascii?Q?RkJnE4zhLRrkZFLqrNzsxVskQ0CHnvGlsELe2t7LhmmwBc7JAcnG8jcqnbhn?=
 =?us-ascii?Q?eS/ZFaYmvVVTzcvrNcrF5KOQu1PzT2lIEPbZpSJoGtO/Ox3foTjbeiymcEOT?=
 =?us-ascii?Q?7HYoSZoG7K+3cdTekWpkX6hftmOxUXNuIqBNYN1EKPMdJ+XDaI5x9Vbp15OM?=
 =?us-ascii?Q?+HYncx27Yz7ju9zeGoSaHOTdMSA5RoWyey5Fc+AumWrUGWt0GZPwlMVwXXyY?=
 =?us-ascii?Q?l742GG0oSoJhntVg+1CSYB/s5TxiXouLgedjdnHSEg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MxT/z2w+xlXSnG+lQX0b+XkV26jZTrQlSZHG4dultJvq97hpW693hYA+NvaG?=
 =?us-ascii?Q?57RtKNsFoapjbF1TkTC4IFiPItEpfhqvh3J1Xelm/fx/6FITA15rGt4ZD78j?=
 =?us-ascii?Q?djLkZ/F7ChDxrH+jznZv19lQyRm4TVsnIKj+T6yUydifeZE4PYog5UVa8VNA?=
 =?us-ascii?Q?GC/gGO6P0IsJkvkuvqMp5uSmr2zbU5enIfYR+DWau4sXQZ4ogwcEMm8FqUQ2?=
 =?us-ascii?Q?0IUuP87TRDPiGcvD73apO8ZRvwCKfnMw+5v/KMwTzgDkxlTVsytud/F+MC+O?=
 =?us-ascii?Q?qzextuKxYuh2TOKXKMjJdckux7HiBVsSonESCS+88w4GKeI34SpahuC40+bd?=
 =?us-ascii?Q?szp/RkSvQWiLSusGMNfUDilBoA+XuHJrRMWZX1iVvJUwThrnh6xFtZ07Df0F?=
 =?us-ascii?Q?Cz1P1i0utt87pK9deeM4W/RDvzxes2DJlkKVS+lmsR8ltnFrluwioFolSysS?=
 =?us-ascii?Q?Alb9HnjEKbi/vhmw/+kZ7FbYJVf5T5AmKLr5KeNZqxSDYibCrUBpZnV+TyxB?=
 =?us-ascii?Q?L7zrpGCjdj63X5LX/KxH0xV4B4pzXaxi3VvsFSeZTX/7OqoMx+YILU/sqDme?=
 =?us-ascii?Q?XMw9Cce16I9JE4ia6EZwSwaCpWHVquqlBK03PLkaAjOHB8jTEwdFx+SsvcbZ?=
 =?us-ascii?Q?LNlFFvNtLnaPmceYS1K4haStch8gpsAFGlL3crX77uYoajq5p7LmgxO60IZd?=
 =?us-ascii?Q?4Kde66rh3hWjdkcDUf01Q0gmBr8DjuFW6mez7+ck6/dU0/8WsBuXeqmFIT07?=
 =?us-ascii?Q?VHCZUT4E1Rfp298Iq40G1RaBt3Vp5M+f2vdgcTzDmqFKN69Zd3YnJ+HRs7ee?=
 =?us-ascii?Q?9Jhpjta01+RZThlTxqlTwb4bOO9um366iptRWgbvtd0pTAHIqVxxKXjXoqsx?=
 =?us-ascii?Q?FE0lzipo1FkM2c2+semZIOGNFt+lZEU62qdRMQWMPZRVHGlqqxxxFBjj7FeW?=
 =?us-ascii?Q?FSlKLC6+CT1RiDZSGSEyb2TPJK+enm16y1q6Z9r1C84SsrRC/hP095Wuhzh7?=
 =?us-ascii?Q?G2FYzKeNwPJAG+fTi954tRFH76gLito02M82VuNsVaXBvWFJXOD94XtOQkk6?=
 =?us-ascii?Q?M04WE67tITptIt/S7jry5ExclTrjvPSasIwtYTlMfdjiCnux9/AgJ80EWYcD?=
 =?us-ascii?Q?URccWPoswonF+pqj6NrDoRCIPoHietHec4ZFXCL+GvWSTSTb5IYfrVo18KJF?=
 =?us-ascii?Q?Wgpd3EUyciRWRISUKpNFtMidfXN8HfOpRZwxdXpgQaXJCDSyA41OxPMemuSB?=
 =?us-ascii?Q?OK9xgUvxk7P7xkUvZRLJh375DMu0EfuEMnjDDoOTxFSkukkb5e7gYagcpueF?=
 =?us-ascii?Q?ek/kCrvm7aYVfukj5pv2BEqWuMGhTFOCcl0FCH7XTXBh6mXRu4U6JLY/NONE?=
 =?us-ascii?Q?CpvppM6GjSIMe1Yp9kGi7z0+Lar0Zn1WKQd2z2gjGCg2wUndHzGJT0oI0AsY?=
 =?us-ascii?Q?Q61W6RmRh60OBtJw101w2wU0RTlatppzDulvZEX7hZWzlMtpEwQCCdk8OuYP?=
 =?us-ascii?Q?XBZwwZuM55oaWvdj5dlMSwmehjEw/uiz9IlcplWiRE4PEKWVyPVTPka6rJIW?=
 =?us-ascii?Q?37AtWYvNQAiSaXj8IuBjOFbUJtcl4dDQHM1NBpkNKelBULSNmbK5zWue44hS?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f7e2e6-b343-4ff5-2e68-08dc6e26ea73
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 23:47:40.3306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFifjOU0Y21yKq4wNavuSVUMWrIxNit0Eunuw1bisz49JA7P5tRYmZ0ksNle5qScp5fXHoJR677c5tSasZkcKQPZF+z/sYWcp3gp3B7TSvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
X-OriginatorOrg: intel.com

Adam Manzanares wrote:
> Hello all,
> 
> I would like to have a discussion with the CXL development community about
> current outstanding issues and also invite developers interested in RAS and
> memory tiering to participate.

Thanks for putting this together Adam!

> The first topic I believe we should discuss is how we can ensure as a group
> that we are prioritizing upstream work. On a recent upstream CXL development
> discussion call there was a call to review more work. I apologize for not
> grabbing the link, but I believe Dave Jiang is leveraging patchwork and this
> link should be shared with others so we can help get more reviews where needed.

Dave already replied here but one thing I will add is help keeping an
eye out for things that should be in queue. Likely a good way to
do that is send a note along with a review so both get reflected in the
tracking.

> The second topic I would like to discuss is how we integrate RAS features that
> have similar equivalents in the kernel. A CXL device can provide info about 
> memory media errors in a similar fashion to memory controllers that have EDAC
> support. Discussions have been put on the list and I would like to hear thoughts
> from the community about where this should go [1]. On the same topic CXL has 
> port level RAS features and the PCIe DW series touched on this issue  [2]

If I could uplevel this a bit there are multiple efforts in memory RAS
that likely want to figure out a cohesive story, or at least make
conscious decisions about implementation divergence. Some related work
that caught my eye:

* AMD M1300 specific poison handling that sounds similar to CXL List
  Poison facility:
  http://lore.kernel.org/r/20240214033516.1344948-3-yazen.ghannam@amd.com

* Scrub subsystem that has both ACPI and CXL intercepts:
  http://lore.kernel.org/r/20240419164720.1765-1-shiju.jose@huawei.com

* Inconsistencies between firmware reported fatal errors and native
  error handling, compare:

  ghes_proc()::
        if (ghes_severity(estatus->error_severity) >= GHES_SEV_PANIC)
                __ghes_panic(ghes, estatus, buf_paddr, FIX_APEI_GHES_IRQ);

  ...vs:

  pcie_do_recovery()::
        /* TODO: Should kernel panic here? */
        pci_info(bridge, "device recovery failed\n");

  Also the inconsistencies between EXTLOG, GHES, BERT, and native error
  reporting.

> The third topic I would like to discuss is how we can get a set of common
> benchmarks for memory tiering evaluations. Our team has done some initial
> work in this space, but we want to hear more from end users about their 
> workloads of concern. There was a proposal related to this topic, but from what 
> I understand no meeting has been held [3]. 
> 
> The last topic that I believe is worth discussion is how do we come up with
> a baseline for testing. I am aware of 3 efforts that could be used cxl_test, 
> qemu, and uunit testing framework [4].

I think benchmarking for memory-tiering is orthogonal to patch
unit, function, and integration testing.

For testing I think it is an "all of the above plus hardware testing if
possible" situation. My hope is to get to a point where CXL patchwork
lights up "S/W/F" columns with backend tests similar to NETDEV
patchwork:

https://patchwork.kernel.org/project/netdevbpf/list/

There are some initial discussions about how to do this likely we can
grab some folks to discuss more.

I think Paul and Song would be useful to have for this discussion. Can
you recommend others that would be useful for this or other CXL
topics to help with timeslot conflict resolution?

