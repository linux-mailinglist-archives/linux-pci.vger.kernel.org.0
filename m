Return-Path: <linux-pci+bounces-15031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 235929AB4BD
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 19:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A1EBB22283
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 17:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4636D1BC061;
	Tue, 22 Oct 2024 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PlkiwAy+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD21B654C;
	Tue, 22 Oct 2024 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616953; cv=fail; b=j62DgDZXHWoiVrtUs8o66en0PEICLt4Ykt90Er6Z0Pn53X56b3TenqF+CyweKe69fiJq3NIuw03e1LLlqOwDKxRbtuZGCqv3neD7dDFu7EZHEHuog2L1oIu2zDdyod3Gc/7RC0CLj+bPfF/QqW3yVsXbarJE3YMrmIEvLABNYXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616953; c=relaxed/simple;
	bh=vqKJutB7/qxkbTOvWNA1e6NYM3gYakMGTKp6jHZ/EPs=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fg36Wjvb8BsKCzEiLZrdeZeY1C2+OugbCzulEsdZt6JQrvjLMFsdRjHMCHxxLGZernGW/uA16uO9O1VOCd+2fssuo+XgM2cH4Q9PH+lM1Mk5pEuDwnTCXFfUBKWIg/dfQVwXsETBw0gk5lhEtR3Z1GIFy95asqmtOfou+nnbafY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PlkiwAy+; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729616952; x=1761152952;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=vqKJutB7/qxkbTOvWNA1e6NYM3gYakMGTKp6jHZ/EPs=;
  b=PlkiwAy+6aiJUorrvdaipozLtB1b15NuNF8ZZWJPKUUULVBRBYrorn0B
   d9cBitPVYs3rzyPoH4skCixPhMT00fuRtJtVXYUYly4JA4GBsq/eo2vOx
   2UcplUxU+QWNKS2jz+zIjKQleRCYxuRymNuSisW/1gt0jLjmW+UCk7Brq
   IKFCQPx7JRhdPXQdHX5Hs6NuZChlzDU7QiE8E+mwQFBkWVOVxxZlrqz5p
   w6TO+k1L1Zp5++Le/L6uJSpUL5Am9cS/8eHM+yBxWqMIpZBOg6SkSDBaN
   3yEKa+rUtW7KsWSDJFV9iVFlWVh3inuYK1ltKFytmV8c+xekCrjroi8ei
   Q==;
X-CSE-ConnectionGUID: P+HrU98BQgWsVKqWsKta6Q==
X-CSE-MsgGUID: v/sZms+iSPOjs4Gz91srkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="16798013"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="16798013"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 10:09:10 -0700
X-CSE-ConnectionGUID: NgH5Gb81S9mCuFqFtsIK2Q==
X-CSE-MsgGUID: haivYqcySJumRS+wlBCCwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="110716961"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 10:09:10 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 10:09:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 10:09:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 10:09:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6w6dyXJXX7y/HqSK1VblE1s6VoEYFv3z4I1IpX9ycGSCmZKNneAXZIvTMgq+NfJDyBONSzCdAOSsMvcspd2C+MGhBHwOkHSS69gwv7+Haw9u/DVmRcu6q3BKJhVUqsJ9FvfFA8Nbdq0D9DG7eCkAR30PoyQ4LMLktjHpLNYyLs1Rdgiit8VfpkQqK2/+khUQMTnmyrrngkXNBGkabLCJ7ZbtdWxhf0cIXuIUVEMU23ZW2A5GBwPJF+fmdtsI+niBM88tmURYFPyKU7wfMD3NWj+yxlynh5QphKCwAdnopBpSKbEg+FfD/LqOrkwY/bvRLaKIi0S36G6Ef0CImij3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTlWnNmzDOMadrcW1G/7nXtPuBmXQ4Hh79WsTBW1nyc=;
 b=eZS5Ci3Y6KwfToMhvDDdHd57N0NlpbT+bypi8QJ2Wj5OXKiBh3OXbE5nt1T1iUp+BI/L67WkPnqx5c1tKlJy/nyWhOgAkE/679UGZsAWXVYL8A5/1iFsMOQEQOw706dOG6D/rcRpln7smHYtibkPB2PUrH+ho1TPD5YunwEOJuQxtkaSPGcEt5JJ4LkpDKYyKFy66ev60E2RO9m/6UyHp6tnzY5bjawsD+Ll3oxL8kcql8SE7yw+dScYVtWXIx4c/rkGGl7GzoHDlMYmML3ZYT8Zjcas9sd6nHj5HJJQFrJSqvg0IDUKUQm9OU/eHtGiHcPy2uFko75ALApNI4ToeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8478.namprd11.prod.outlook.com (2603:10b6:510:308::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Tue, 22 Oct
 2024 17:09:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 17:09:06 +0000
Date: Tue, 22 Oct 2024 10:09:02 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Terry Bowman <Terry.Bowman@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <ming4.li@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <oohall@gmail.com>,
	<Benjamin.Cheatham@amd.com>, <rrichter@amd.com>, <nathan.fontenot@amd.com>,
	<smita.koralahallichannabasappa@amd.com>
Subject: Re: [PATCH 01/15] cxl/aer/pci: Add CXL PCIe port error handler
 callbacks in AER service driver
Message-ID: <6717dc2ec6c90_231229487@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
 <20241008221657.1130181-2-terry.bowman@amd.com>
 <671705b5bb95b_231229468@dwillia2-xfh.jf.intel.com.notmuch>
 <0cceca3d-f69e-4277-bc9f-2556fd212ebb@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0cceca3d-f69e-4277-bc9f-2556fd212ebb@amd.com>
X-ClientProxiedBy: MW4P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: 799f3210-2852-488c-2815-08dcf2bc3c38
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xr0kr0ByLXz5iK353ng3yr+FkloxHVqIuNuSq49F45UzlSYxomiuQUHVrK3k?=
 =?us-ascii?Q?JO3olArd8q53zkWPKh3OqoaG4+RKrplwsFlv/YX+jscA9KtuIyR4dCWufBJ2?=
 =?us-ascii?Q?lcdhp1G7eKC8q/ezxNmBLThEBeGMK0ij3oZ3gBIJBQEuf8unM9XcQTtBcZhO?=
 =?us-ascii?Q?rSVI57Ab4cGtiPv0wqfln7lF1wS9BwEzrAXkSBKVwEaJmZMokPbYZUUmZcpI?=
 =?us-ascii?Q?QLlRHKZHe9GM5dv1zDI7W0lb7J+CrnhpXuvLsXy+J+2VNjopRtX8AAvsgxdH?=
 =?us-ascii?Q?SXlQekrLyH72JbeSBKkOGGtm9EvfTqOvu8g25KA0RHH65Gwklyb279sDBG2n?=
 =?us-ascii?Q?vor2/dO4fjXYscLpBvWAWexqIjUNoqGYYHI7PZolPWtFekTmDeK/hqVrW7fT?=
 =?us-ascii?Q?Risyt31TEDGoljIII1UDL7xDuoGpBhNNhkI0jEnASvglFk0CEcMP3Cm1rTUd?=
 =?us-ascii?Q?5WkyGj13+881CzLdpudhn470ElIkFI4zuR8jGrVapOXFnSl09udB7+TYW/YC?=
 =?us-ascii?Q?WErUsQCypQpCVr8PlKobvJ04sedsx4bz4vlXWbaLtAKMrITZJOZIC4IM18zP?=
 =?us-ascii?Q?b9cTo2TBB4gGfbDf+e3iWz/UV5OYH5ptgbPmisKk8OZ7iU+YljkXop/n7WMD?=
 =?us-ascii?Q?4UvNQ6lZFKS0q+Rx6fiqfVqbZ5GrVaDdybAapLXXWz7Lsp03jKm6mH4pY4AN?=
 =?us-ascii?Q?ufCaPPajG62qD0SSsc55e1T667W/I57QLhfrdq1Xsorow1nKunln1vMz36Xw?=
 =?us-ascii?Q?1wV/F0KwrGmKCFRqDWlwZQiJ/I82r44nPWZHOnCRlH2WLPnrXoVI+/FDk1PO?=
 =?us-ascii?Q?HYVcVct37vaPGTt7D+2mqfY3eAAGYSH0sxHk+Wx16rjbx2d4yM77MZ5b3HRY?=
 =?us-ascii?Q?WOusHViH+NB6la5ketgTIZUnnSKNZ+G64BF2/EhrJqKtLFwGbDzgRL02WOif?=
 =?us-ascii?Q?sE6Sep869h8yH8CGTHlFW8WHGbkI6+PA0d/uX2Ja5E6sQUlw0UhI4Zqm4Hjn?=
 =?us-ascii?Q?LsJIOW36PDZt3l18X5ILF1TXhonM8qLgQ1rNUYifjeG4a5Zkw7ZFGwEFJOYa?=
 =?us-ascii?Q?EYLvWovzz/K9vMRtumWPZleQuHQzFX1W/ks40PtSm1ROHCLKsO2lyeZZZzKT?=
 =?us-ascii?Q?7XaXh8sUzQID4yigiRDKk3d/BOMwyHkhgXfGEB77OPUXPB4LFPMygLOPte0r?=
 =?us-ascii?Q?howKUqe9n+kr5zFAtEw+Ja6azQkfdeX9RPSKs8Il8CHWR71dq048Js57vLPE?=
 =?us-ascii?Q?ceO1FETcfG0GZiiTR+sgEG/kRFB15LwFcdxMlmpt8gAmtacj+ApA9FlUvAwh?=
 =?us-ascii?Q?BA4WB/myD7PPAnhrNUb/TCWU/m/lVAfLIWfoi7ZBsR35bWrMWCyRVZ+ypieo?=
 =?us-ascii?Q?4NJgYQk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8P+F34NBgeBvXb4OjYGwOd0hU8cGWyAAFkxYFfz5ilB+Urih/xC3p7bRpbhR?=
 =?us-ascii?Q?Hu4MmErKx8Fl3A7o0Qr88TpIu9TaVvUvqTpAiWaKDlkOzxji54na6Zgl5mSG?=
 =?us-ascii?Q?l95om80MvVNV0fKlH8iXHRicJgBxgEFxdjWHQIGtrWQ1SZVqiXpVHSp+k/5l?=
 =?us-ascii?Q?Vg7uJoAOdnxJdq+sh+tf7GG51z5L00lhKrNg/cGyXtfy5pcAYrBijNmAS+09?=
 =?us-ascii?Q?6clEROmh7HHKY/d4rzR1Iz9+IPoV9BIUWO9J+IfJO1LEeztvA/skPjljZCH1?=
 =?us-ascii?Q?QlVsr4zV5MOJzcfdc9Up8mxQhm664WskuVH0/0aHu3PzGlAUuo21dFc3MU9p?=
 =?us-ascii?Q?+xUjDxy69mTBF5AB/e2a5bbvkHaU19Kkzf4WcWilXuCRtqxUbvPnLe/2BwqX?=
 =?us-ascii?Q?TeRXU+bVr9D09mIkYdgpKF8FkP4cC1RON5744PLpkQM1sPyzpYFQypATxKc6?=
 =?us-ascii?Q?5Ce65KPhco57II8FPm8LcYZEDm7nNdpPcesb/dvR1qScpxWBcv2hcsoIzaf4?=
 =?us-ascii?Q?Euc5ucbww+lmfzZBSuKWSlELAS54F8a2Ov2sXRVC9O9CLif9pol48TCvol3c?=
 =?us-ascii?Q?/Sv7QAGoCQponUVqg7poS2+Qh3Twbg3WymfvEfhQQx7nkkuA1/xe6W+QmyQs?=
 =?us-ascii?Q?AJOkAF2vyNLBkbAdJDhzcO6nj9G+XD9+S9Jqoj0i4oWUsyzv1ry1wtNZoGAx?=
 =?us-ascii?Q?t7cZUfmhJo9iN93zarEs3tR66CjL67MO3C12hcYFiAa8zD2V7Oe08onExDv5?=
 =?us-ascii?Q?8ivg/qSnPrpCtRfK5/vxLp2r1knU5gHgxC1CLNHsl/+ytYfD8ALjqQFxjOX4?=
 =?us-ascii?Q?jqBnhK2A1rUpQiausFxrUEiL/KajPEsTf1rfpYepc4rOQltV6JXmYnVJvG6D?=
 =?us-ascii?Q?vLDjhD0eRO7ilTeym4V9cGNpYuu6qV618BFNY+w7nuoyaG4gLiOlFQIB6AFL?=
 =?us-ascii?Q?P4K7zbSrPefw3Q4HXYapKk3a4TB4IQPzm1vOcylVIOhsFV3cycBinahOXJc7?=
 =?us-ascii?Q?o0N35u6lHnYwtRoSzP+/iEL3zkQ7Q7DyI87kGADw0DuptbNqVZNE4J8wvTHK?=
 =?us-ascii?Q?+sth4WBdRI4wKtR9+WpwADPcgXAVvmP2EwU3d4iddGRBHdRlbvFputFoiXFu?=
 =?us-ascii?Q?wSz3BMfZ3XEQhptXZ0Y+mFAAkcI2tEiLo3iE2NU2Nz+guwGh/ktKU4G1NXtB?=
 =?us-ascii?Q?GKAeJHB6vnjDuTVX+nkNJybMIcVj3Tgqn49tRS5MvMFkiMxJcX1+9aJUK6d1?=
 =?us-ascii?Q?I2A7lYLRYhbKoSGwMwyZ39Bm1E/IpvLyfDeYtU6XHWqTbBlxbYHhJ9leuJ+6?=
 =?us-ascii?Q?q0pO9OCKUdT/ZhDyLYbaXpmo/sAcLlWrnTrmm7XvA/deppQJHtK2WqrlMXt9?=
 =?us-ascii?Q?1+9xUR+AkfTQHmv+/JXv1/pCSJtqYiMtdIVCGPkO/wC7RZymVhyqL90wWg9V?=
 =?us-ascii?Q?PIld34R+46f8YYNU7KzUEZ7ddPzbMSMPBdiCMBPH1ktMNvaETEGKiDxPxGov?=
 =?us-ascii?Q?R86sZ0d4Yv5VWT1YGjq9VLF3vo+8bLmzESUff7LkpZU2qxmLPCxymPG9Oatx?=
 =?us-ascii?Q?EkRDC0Q4B0fHKAevHv8dAXelzN8FHLlAIyAequgQvCkoTECmcr1bSl1jpyjE?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 799f3210-2852-488c-2815-08dcf2bc3c38
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 17:09:05.9788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IicArKgXzb1NsVE1A0c0j2c6Ds7hNIP922Wzup4TlHjBSGS11Oxw6PtPtocEG/X767PX9hA3cB7HwbID4V14hzGhOMJKtUsU37nvfTU4Sqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8478
X-OriginatorOrg: intel.com

Terry Bowman wrote:
[..]
> > diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> > index 6af5e0425872..42db26195bda 100644
> > --- a/drivers/pci/pcie/portdrv.c
> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -793,6 +793,7 @@ static struct pci_driver pcie_portdriver = {
> >         .shutdown       = pcie_portdrv_shutdown,
> >  
> >         .err_handler    = &pcie_portdrv_err_handler,
> > +       .cxl_err_handler = &cxl_portdrv_err_handler,
> >  
> >         .driver_managed_dma = true,
> 
> Ok. I'm thinking to add a definition for 'pci_dev::cxl_err_handler' of type 
> 'struct pci_error_handler'. 
> 
> 'struct pci_error_handler' contains a slot reset(), resume(), and mmio_enabled() fn 
> pointers that are used in PCIe recovery if available. The plan is for CXL devices to
> call panic for UCE fatal and non-fatal but it might be good to use the 
> 'struct pci_error_handler' type in case there are needs for the other handlers in 
> the future. It also makes the logic to access and use the error handlers common, 
> requiring less code.

Can you give an example where CXL can reuse 'struct pci_error_handlers`
infrastructure? The PCI error handlers are built around the idea that
operations can be paused and recovered, CXL operations assume near
constant device participation in CPU cache and memory coherency
protocol.

About the only reuse I can think of is cases where a CXL error could be
sent down the PCI error handler path, i.e. ones that would send a
'pci_channel_io_normal' notice to ->error_detected(). Otherwise,
pci_channel_state_t and pci_ers_result_t seem to be a poor fit for CXL
error handling.

