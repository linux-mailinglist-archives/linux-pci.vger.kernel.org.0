Return-Path: <linux-pci+bounces-21755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F54A3A3ED
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 18:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518B31888211
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 17:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E0F26E648;
	Tue, 18 Feb 2025 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANGsRR4X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E2018C907;
	Tue, 18 Feb 2025 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898970; cv=fail; b=YiF8QNxWIw+MxMffl0izj2sR/Ni1o7rLAHAUx/Q+f3yZN8+hgsWzv7THidx4hXSvkM4SzdIbGbwtoxv3stOUNIWEW6Gxl/aXt/pHwEqcwCbzlbXiJkc9ljVWp5VR4NdsbjK7IGF10M9D8puf/ajWUnQzvDtqlwtO/HgIENEhRmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898970; c=relaxed/simple;
	bh=X5dZs95QE0ASSCxrExJHuK9eE40OiCHX9JBOAkEvutk=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZRdqH5XXOXcqVdXZ511SVbZyVhP+/fvP2yXOpI7AtG2r3SFKV0PYi87KS/Lu4ymOPCQGj2BYhoFl0jcTm2LbTBiNEAvMJZfZbuFpRmRp034AU78gPiO+rZStVbWiDHwFDfmgwELkGPIPnSmAOsHmyBL2cKBe1BKkSfjz4wucsuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ANGsRR4X; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739898968; x=1771434968;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=X5dZs95QE0ASSCxrExJHuK9eE40OiCHX9JBOAkEvutk=;
  b=ANGsRR4XFKnOWH/9UTvy16jQkV0Im/t64Fkbwjg9tsM4JSvSzQrv8DAF
   4e6EqiHSyfi6kHMPe3vOaK/b3PWDs1FbcpaTapOOdojU8PlU0yr6ZGwRc
   dhzTPlWNlhUQrDEB5jF2Bmver0LiEWq+dEHuSBzeok47lj2uNLMmUr1Js
   D4eAua/EY0oCt3sDp5xd0Rc5tEfmSn2yNJI5DvtEraLqYzUWmCl97/KVN
   sGzXaKbSz1Xm1l+UnMWER0rfwZPbH4CcN+97vbTjIFjCn1KUx/2qQwFie
   ZKcsD3Zx4q+So62RZ2pEuLv6gdaZafsJfvC4cnuTSfe8l9sz2wF+Kisaj
   Q==;
X-CSE-ConnectionGUID: MF2Vt8yHSXeLwfWLB80w1Q==
X-CSE-MsgGUID: MDGbdCj0SHa2b81hZg0byA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="28208715"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="28208715"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 09:16:07 -0800
X-CSE-ConnectionGUID: +lUZ/Rj2SqWFTszINWeubg==
X-CSE-MsgGUID: P87Vz7t+QBaDx8esEIqyOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="114190804"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2025 09:16:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Feb 2025 09:16:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 18 Feb 2025 09:16:06 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 09:16:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtGfRa9IZ1YhL/6lSiqYPsTcUrL2yp90DnBE6j+aTmClMuISLplA2d/farhTqz89J5xjl0FXTQxr4bzftbeUOxiRtBvjqdJYudjwXS4/LPR/uuDLA6jHedK1Mleu992Uw/lD27+K3J5bIQBVI2ks8BwfcDSDk3HTYCYCK+4nsOWTO7XcMhzFuKCx48fnLOhvn9gQqDDAl2XmZY2v3bUTaXNwjIeJu+gL8oDDzlMXiaDuK/Q58sWjSLFqBoee8l4MMeSQt0NsFa8iIdeQxK9MsMJcf9uLQ5cGEVj5+StxiLapu+UWS0o1T7LHLt26XronE7OZuJ1YKjga18PkJNdj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+10xjbz+sgNTKuxThtIyciyPgaIdysTx6xhiarKllKs=;
 b=U7oL5kZhtxlauGgi7xFtn/odmH8DeS5BPWHm5uik2YPG74NuF1Ppei9qu/YqQiS6G4zAD+Dek36C71KyjdvOd48zCh+phYfPdc0u5Vc0iJC6igIksliiKiEgLMiOtzn9jdhBPgKyQrrqYnhVGLbpjsrNXrGGJHe0uo6KT3EFQR/Lluy8XOTirqtGD2kLKK/64kQxDa1X6RieyVVxDgnweeNFGUJIiRiU02ULyU56izrUurXSJZXkTcJfVF/UXG7PyTQQRfB5HPaMQwdWjuEZTxwiddUx0c0o4WrAAIhzzSgxKVIaCsTMLK/TqQjw7lMazViit+Q67AgfxJ4R90ysYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6562.namprd11.prod.outlook.com (2603:10b6:510:1c1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Tue, 18 Feb
 2025 17:16:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 17:16:02 +0000
Date: Tue, 18 Feb 2025 09:15:58 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Bowman, Terry" <terry.bowman@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v7 12/17] cxl/pci: Add error handler for CXL PCIe Port
 RAS errors
Message-ID: <67b4c04e96439_2d2c29478@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-13-terry.bowman@amd.com>
 <67aea8002a005_2d1e29466@dwillia2-xfh.jf.intel.com.notmuch>
 <408f6acb-108b-4225-81ac-4f17a6486020@amd.com>
 <67afddbec62a8_2d2c294a4@dwillia2-xfh.jf.intel.com.notmuch>
 <4c42244a-cc6f-48cb-8013-012e5dc49b81@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4c42244a-cc6f-48cb-8013-012e5dc49b81@amd.com>
X-ClientProxiedBy: MW4PR04CA0065.namprd04.prod.outlook.com
 (2603:10b6:303:6b::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a4b405-fc06-4692-08e1-08dd503feb84
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t4P5fG/eFCldt81C00sk+4lcB8u+5UlbME7DsZ59AEuJJK9+jQ9cL+nfji++?=
 =?us-ascii?Q?froU9S3ao4kCRUQGWH8S+yRMjxTPNw1JQWoC9seFNpXYhQWDINTGOVPMnq4m?=
 =?us-ascii?Q?zs858BaPvCd1C85159tmqpVtDTvL40OYvK/4lT1E9bn4/KeUDzA4CBtu3yu+?=
 =?us-ascii?Q?ODwtjwtgh5KGDCRctvgUQNJE5kFy+CeIfWjfMvJ+TeHZomTbOgna9yZQPI8T?=
 =?us-ascii?Q?o/bwp0TPQjPlug+4/TtZZW/mPT8dS7sS+6YFPZMw25CwJmXw4GCdi3jDgGXl?=
 =?us-ascii?Q?FXPRE9KbZpoARNh36NdtX3fQHlUYWdh0zyCwWab1El5esQ0JSSUgB/vM9C72?=
 =?us-ascii?Q?jwJTAVtN8UNJSJ0lvzV1t7T7qRCuL8WDs+zWKrbbb8yEDWaQhaWEqCb18dwf?=
 =?us-ascii?Q?exB2loX5JzEmqCBix6W+BQ/6Lyf/LJp179rizv1b3JXG5X3nXTMGk6/28oXv?=
 =?us-ascii?Q?eZkXjJDMBXEOCWd/PBPi+X0W3j2I02adjYnIGaB1WaBzPEGdpP4/DlVls09+?=
 =?us-ascii?Q?3cmNytygfOUwoTu4YfPH2TpjUGkqaA/eSdNF3cXeRQ/8aO+HBnsAtGmp7js0?=
 =?us-ascii?Q?9QermkC7FLkFpVPV+ejlMF0WMSpzefOevaXpUkC78dGafp48kmNqcuvEgPiU?=
 =?us-ascii?Q?RfQ16atR0PsIf/e1ILHotLAjcBS3Ni7TlyG09lfPbOMxRjxuhN6VV7HjuH3s?=
 =?us-ascii?Q?tOQwZ5qwmquo3ZVfJCCg8rD5ozKEz2JB6xzg+8fQvhf9Zw1T5n4XvHUCVDKF?=
 =?us-ascii?Q?UZ3PpZB+/CGyj3Vc8WtgTbpALexYlBHqQNjm97+qQleK3vQhf96ThoIytbLT?=
 =?us-ascii?Q?QJ3CFufTTcUVQJ14WeRDYxcovGfUciSGFs0N7j00HPpAWXnkCdUs9Qcu3iS7?=
 =?us-ascii?Q?5FY0Wph1ynwOPkQ0mc3LaZBQU9jvEsA07kqrDlkBojveS1nIVEdcMB8EPAlQ?=
 =?us-ascii?Q?temy/8xgMOxzYC8iU9lX65YZJllH9R8r9xmsJw0ZDjU7L1EXXtkbZ3hl5y2w?=
 =?us-ascii?Q?sC100neq1icQU/cHI+56/lnbNDjKzoZZjmIdjIgEe44rmXp6d5poCGGkPzvE?=
 =?us-ascii?Q?kGwov7NZmHpYgamewPxHfwJORHcdQOHHxmnDTWb89vqD7MT621+LyHiEreml?=
 =?us-ascii?Q?EXsXpCyx/YSuvzrXmbhYssvKBVpBa0wQohxmDyc5zPX6AwpnHnc3CFEwT9Wj?=
 =?us-ascii?Q?Agqxfl+GCBhURORHC4veXdr/Hbtx+CeEIsmQfWsz16Hyj6s67fpIjHaLDt4L?=
 =?us-ascii?Q?tmUQl1AM7OX2+l2W+vqJQj2UYUP1keDy72YDntOyXm693l2m68dzEl9ZwzkL?=
 =?us-ascii?Q?mPo5MaZgi0x9Sh0M2YG2OuLMdrguLWMyCBKavjY4ZYk/tV0bqGB1h97OEzA2?=
 =?us-ascii?Q?CO6bYtxttpFCb+Cr9P5/R2q0hu9XvuJz5dCEzgAng+K5TLfV1/YJxN1EWKvn?=
 =?us-ascii?Q?pKkZ57m/fm4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3bTVr56Ytg+Q5xaFoV/bi/pZ4SCORRnUYxPFCxxmPVNsp0PwCsIwpg+BUcu+?=
 =?us-ascii?Q?IFRMU4Vqr1c++rauvfQ0kHCxloSj5a/jPrkZ/sDwRLFDFzHsKe8KIEmWuMJK?=
 =?us-ascii?Q?fXWQ3lTXIoP7Z5lmrQgX/1HmHJgT+mEBa9e/aV27k7pdq0NeTitl5P8GCTsm?=
 =?us-ascii?Q?1viaQ8HnuTX1Les0tmlEmeTXZoGMWXPKPwyCkGx8fsGXF1y4E6INrA2keY9p?=
 =?us-ascii?Q?nhtOg+pppPczU0u8/AgaoMOg6h1vHC6Tx063Xkeb14MKkwTpA2gxnbnUkO5H?=
 =?us-ascii?Q?LPF+ZjcIu4cDO3X6htXmnTO99WS7RPwV/B2Dg06Mli7heQ0EiEWv/kENB+lI?=
 =?us-ascii?Q?HUjyzyjhLpiduBOFhs/uqw0VeUqpsJD5lTULoWBjteYhkzMgsIQ+hLu+Wk7h?=
 =?us-ascii?Q?NMjdECq3hnplwjUc1N1mHYH11DgAxSm0vPn/U8E6OCCoIgPy0WHkOEwDazfr?=
 =?us-ascii?Q?toCaf7n+GWvOwwsn7meoyJJrdc47qxy+B6Pgpp2yGVPxd1Ti3gh/+tMLvnLO?=
 =?us-ascii?Q?Cdf5CfzDf28qUUE1epZBPye+jyyNYqiMgtQQc23zdDgX0XazwQUZ/ULEdMoz?=
 =?us-ascii?Q?sY28CQQmTk/GAn2LWBDHFF33luuyxQDk6FkjiwADdZk66aQMnDNpkzsfDVr9?=
 =?us-ascii?Q?G9PvmbsJnKGScmh02Pq+5svH7uL+T6oguljTZ3TQKlXDUQnwQtEDJfD24tbS?=
 =?us-ascii?Q?N4vxB5vo3OtmpxJJXTGbBqqBXtSvMbnzAlSmb0eI1Fi6X42nGXJSsRoxVnuK?=
 =?us-ascii?Q?JdRd+DnPMZK7Oklt06x6StGCpTRJkBCvEmQaF02XB8TEhbhcmcdTAUq8fj9C?=
 =?us-ascii?Q?A+zIGIHwgi+s/+KQW9QaiRg37kRnUK+3lJ/Ldc6f190LCQQEFKJrtWw6MRkL?=
 =?us-ascii?Q?XDQJqKins6vtok9AiLt4DAjNujS7ULFbHo1LK7O29h80vFXwFasiycx4WV6F?=
 =?us-ascii?Q?pQtdrO5lKm0CV3xg1jd3mMAc9xY3HcArj+NcLioTUaToEoso/vEbNsqH6GEV?=
 =?us-ascii?Q?oI83viPYg2v2esWBMOtx2z2aK7Y/X14ebCqA/qTqEJS9eFJJYFSDuEwzcryj?=
 =?us-ascii?Q?2mLHVbCFFAh5vFCEVMdZuVbfqwFaGIbIKUWsKb9OE5E2Bo2Zhcqt3A3JPOq8?=
 =?us-ascii?Q?QQaXKOCTtpBQMdec9/wQNpJL7yoHxH6iX7x3WWpoUNZyfFjtH4NxpaPV0Iv2?=
 =?us-ascii?Q?raQs0Zi28Fd1tiRa+PGO4vdHB7uwhcPoSfTs0KI9QnmUUkWjd7FI/jkMIPpd?=
 =?us-ascii?Q?UMVLICw0+WW9UGLPsz7w8+VrpidSSk50k6SbAk+G1tGZbCzg511hRt67lOZG?=
 =?us-ascii?Q?OeCRFGXwGr8Z8thbqqvdz6hLI8kFFyCYsh+neccltZ/lbHLltax4KElqLiCJ?=
 =?us-ascii?Q?ca+fsoQe/JI900kQXZaaR41IhmunVlhrpSBxU1Ie/47zRmOk4dZawQHxgIE2?=
 =?us-ascii?Q?HkjopDuNzOBdCRpNCY/EDXwVucO8FOD3XNwjzasvkTrsEIylH/T0BnYNovFS?=
 =?us-ascii?Q?2HTWAo1Cd9eY2SDfdZLNSdMnGuGe+cwGQIJb019Itg0T0b2w0Ak8+iHRcF5c?=
 =?us-ascii?Q?reyH0nTrEyiOOsdf8OVypc5NQ0MBa9vdn/nZD7SrPdEvDWUrDVImKutj5YOg?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a4b405-fc06-4692-08e1-08dd503feb84
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 17:16:02.2936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxKWqM+v6RqlUJuZGsh1CtkOgnCJXHDUV7c+pQIKorkSDq4Or3WYd9KVQacOBIMEzh9gDXMzDWKj8O1RvBFN0/XxUHM1lJcfotqJpG2+p20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6562
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
[..]
> >> Or, if you like I can start to add the CXL kfifo changes now.
> > I feel like there's enough examples of kfifo in error handling to make
> > this not too burdensome, but let me know if you disagree. Otherwise,
> > would need to spend the time to figure out how to keep the test
> > environment functioning (cxl-test depends on modular core builds).
> 
> Thanks for the feedback. Yes, there are several examples and Smita is using for
> FW-first as well. Correct me if I'm wrong but the goal in this case is
> for the FW-first and OS-first to use the same kfifo.

Not necessarily, the leaf handlers should unify around
cxl_do_recovery(), however you will notice that CPER PCIe AER events get
routed to the aer_recover_ring kfifo and native PCIe AER events get
collected by the aer_rpc.aer_fifo.  Both of those route to
pcie_do_recovery() on the backend.

The CXL kfifo is to allow the CXL subsystem to remain modular and only
minimally burden the PCIe AER flow with just enough logic to determine
"not a PCIe AER event".

