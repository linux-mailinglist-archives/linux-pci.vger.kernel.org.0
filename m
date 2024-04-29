Return-Path: <linux-pci+bounces-6805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFBF8B612F
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 20:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4902AB211BE
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 18:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C90486655;
	Mon, 29 Apr 2024 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQ0bFiDG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BD4129E9E;
	Mon, 29 Apr 2024 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714415721; cv=fail; b=qTN8e36YA53xoa9yR2lDeEvOpJRu5lWrZ+ald4ETf8kgYWI1n+jnx/yaFEyjufTEFLB+jUmYsndejCcNNjZWdSk9GO/hd6R3/f2AYU+t1sKpjZ5gysrI0RWibtXhlMPwZ3oP0UAxhcXGVce7oii2prdcSclzELr5SosQLdAyqpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714415721; c=relaxed/simple;
	bh=NH0bEQ6zTyHdcempvDtqopfqsdbT6+EtrD9tO1EKMQM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OUIdGPqwTTNYh1KIobkIvK6FlWWo+Z4ClwAyO+hfUrsa8CauB2PNrOKMzC5YdiQLqHZoBeUaioSJIXZHow9Lumb7EmRKlgmkCiRJWTWVnnEEPzlnTiyMMJCm2mVgoKx8FHGUSm2fHCZzyWw/RJrALbXd9W1rhVcy7vEghrzkeMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LQ0bFiDG; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714415720; x=1745951720;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=NH0bEQ6zTyHdcempvDtqopfqsdbT6+EtrD9tO1EKMQM=;
  b=LQ0bFiDGPDGbo77mwLCWqPILDxq985dqoxnJlAKjTRMWiYxIJW4FpFup
   81FUhpqe9toXBOrtMWNcu5GCYvV+Vwh6mzIKqh99XmaM49J47ZnIvphvL
   YuaGI1J598vKrPc9ipuqO/tqTZAmb58d9CUXS/tAKDUFJ0aEXecc52tO1
   cWsGa6SXOMCFjPHdh7nWngVqeVwUiipQP1uYzanpEnY6N0RVAOsd4XfMc
   wSJB3/s1eeHfhEl2JBVtBMCC4/s7ku+8TCXjEtQlAR0LHr9vroK7vZSFq
   q4J9Y77JsLu8u648FTDkyAufss/nxwS3IGO4mFYhcTx57vsWZ2UhVoocv
   A==;
X-CSE-ConnectionGUID: S8A9c/2vSBmnT6au3bGFiQ==
X-CSE-MsgGUID: QdFGXlO5RzOi4Y/SGaApsw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="20711079"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="20711079"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 11:35:18 -0700
X-CSE-ConnectionGUID: 6N3bu2OKTrmOW0pygiTd/g==
X-CSE-MsgGUID: IT5n2vVSTtOb5m7ESPk29A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="26069434"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 11:35:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 11:35:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 11:35:18 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 11:35:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqyoevXANgflkA0jj9nrNNf5ARF9dWZlp0kTZFJ1qlp3JNCFmCU6ihd1Kx+/iMFyilY8bAbXIL4tb7aOL+6IjTdkUQnUv/Bqk/hcjR8ceK6iWcdJ+6UCH/i9BFHCRJkxS5KyeBPAV/wZbGowQIEn+trNvDEf360+BK4eEj/l7Ze5fmZKMYAQjt+FqUPntfSDY+nlmZr4vzrsOvyBRKz/QyrhrGQENKlrxFEDif6KwQhhXUoYGuP1MXXG+37AbGw1BgwlTvx8XWgzc33rkKXRjnF9exuhJisqyl1MTPzZ5mzwesjJfAlJTM1fPFqIQG3XPlcPmp9LJwcHs7dF2NfdtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rliTP0s2AUs21j1tSpSEivn9q/zhCumoYSLWDyzsi4Y=;
 b=NGAZkJFBh0IzNyGLUPsGS8av5X5wOSZshpirkgsUeCPBq5FnbOKZ9hgfHxwal4QSLUQRXgze+4V8j6Ko6+VLkpSWQ9O2dOe4MStqqgkV8Vs+Wj7qo5AnvT5LvoMMuFO0/MjYpjFBGoD43K1W+lrkkz6AkxeXVueQhp3OhLcOEV31PWECq3n5fNtU17ikC22/I0UJ7N+tpbJlveJsGpGWRW8sGeQV111jyyDyXH6kplSBqiH0NAO3YMYW1n/ai3j8XgsyiGdP4ZJkIahc0lQ9Mt+FjEIVXhDfFvo2y4Ps0at+rrIK14nnJ792spXHMbQvMtuOQ3FkQKKBXz61HPkbOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7721.namprd11.prod.outlook.com (2603:10b6:610:12b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 18:35:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 18:35:15 +0000
Date: Mon, 29 Apr 2024 11:35:13 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, PJ Waskiewicz <ppwaskie@kernel.org>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup
 failure
Message-ID: <662fe860eb889_1487294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <ce49c67c24f57ffab166d688a1c9e3139733f412.camel@kernel.org>
 <20240429153138.GA681245@bhelgaas>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429153138.GA681245@bhelgaas>
X-ClientProxiedBy: MW4PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:303:b4::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c175be-cf80-41d4-c0c3-08dc687b1c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?dh4Wu8Tv/3owHJNppZ0O/Ce5uCdGEGe3gvd8OhrogTO5VygSWKrsatlLeP?=
 =?iso-8859-1?Q?g92M2aq21h5Ug16XAMJZcFNj+PLsIUJQZXqcyjtCtOsMtw6xqPpg9tlip+?=
 =?iso-8859-1?Q?/ZdKxI6d2ovUKpKchBOhPw/4llEX9UtqqVVisX1HK5oZGYlW16w20hmxir?=
 =?iso-8859-1?Q?8qKlIXObF+jPByZ+308qwqml/XnIORCJWSUluJTF/iajpuG8GESTPZfxXJ?=
 =?iso-8859-1?Q?/79nr7k2yaH/QFCer/h7PbG36kuCQ+I+sV6Tq50hKx2s1tNM6+AcqCoup0?=
 =?iso-8859-1?Q?AZeI4chXxXoaekNwMZrDf9Og+AXM1Vnvi6GLbSV20W+dYn/Krg/uzWwla7?=
 =?iso-8859-1?Q?XumD7GqCjJ+slYnjAnmrX3TZYa1BSUY87xy41sUjJ9yp66pI4kUqih8CuY?=
 =?iso-8859-1?Q?O2H079BRXCKle4PvdohHrZebOvSgxLpOvnUK7xm4Hi7v8VihDUsnyrAAYO?=
 =?iso-8859-1?Q?K0AjjdxCLm66EDN+FmRkgme7zV70WhU3y+1U7uV9xecTF3Yby/USQ/UTXR?=
 =?iso-8859-1?Q?Gq6FaKFEiI/zOrboakNLocHnI9fzuZ9DfkEKa1gFT+Ymh4+4jNNYpvDj9b?=
 =?iso-8859-1?Q?FHeVKhZ5/F9wkcUjVYLBoJ4xMZSIxUab1YJHQpdJ1OA6+rDXZ1FhPiMNey?=
 =?iso-8859-1?Q?N0GCDXJQ0KV21dDWZePc/JTRECnIO3GFvdJ1CWkHsxWdbTREDxw6ZknVyP?=
 =?iso-8859-1?Q?R+iGzIhNlPKjxwDdnqKw2XFmZc4Wg520kVcYUggX+G9kt94c0umPOFEsuX?=
 =?iso-8859-1?Q?Rgna3/xratMk8tq4M/BL4oYiFmprEV8aCFMTqnqk/Kyg1jOcc7liOVpbw7?=
 =?iso-8859-1?Q?O+WuUD04eVvGb6++pB0FwC7GAKKejF2XLRy0K/uUIStSUngrEnE+oltzsg?=
 =?iso-8859-1?Q?CdSkGzmq6GT1Z4IdUA7+2waWSdhZrnADsL0WQ5ET/hKRSqemSQ3PowGl0+?=
 =?iso-8859-1?Q?45zJr17AtwGY4o0AQDqtNy6rd+6UTeXmtF++s2KSMwFptQ+bztkMYONjiM?=
 =?iso-8859-1?Q?kJ4AYXe9po2AtH2tZdyZJZQk6m5qFiCQS/lZPhhfbyNdIzUrOnorkiGi9H?=
 =?iso-8859-1?Q?6Qx0ntxsjdTBR5NgN51/ezu6Gsw4pldy/jEsjuDEnkvDoD8aHHx2n5aXD7?=
 =?iso-8859-1?Q?pAcGJ6ZpoxO+MYSC1oDKqCsgg0SBnRY1kId5So2WTupUYQFTtvgVQ2FK6g?=
 =?iso-8859-1?Q?Ggypvw6EbBjTFkQW0Ou4lULszZkoSejhcDgN3OQdZuG/fbG2oJxxfAUCMN?=
 =?iso-8859-1?Q?b0TvCHymkepcHh8id3Pq3Plmp8wPTLurx7IbEEA8/uGfHI4lBBp12tLG4d?=
 =?iso-8859-1?Q?CAZcnJWYCOGuzFI+E5jeixNp9Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?qcbsXCv9/d+2QV3ejE4Yj7SI/fiZ4/UEF1TAXE39o59yolx2DW7bQjtjTu?=
 =?iso-8859-1?Q?A5qEcmwu8Euy0GR3URHdt31Mp3GCQhitJgTzrzchOIsd4+De4/Z/5zzj0T?=
 =?iso-8859-1?Q?CRK4BCP2X0SlYVOZHcfUmDca+t9k5TLP0ifW5QIyv0B2XmX0NfKZMecv0p?=
 =?iso-8859-1?Q?uAu+vg3XwFZJACoQb4S0Swbv6aMnY/cblX61oU60EUhlsIGuYRzvlW+OYS?=
 =?iso-8859-1?Q?rPUC1SJwslsoR4NZizKOBdhBZqJ90r8UJzMAdsX7V0vWfMpfv0Cfj3LPhQ?=
 =?iso-8859-1?Q?T2okU8FNm2PCYo816vpW7yD6ux9fIVSKn+FEaYx/jaYp4/oWxQiWGBLTUj?=
 =?iso-8859-1?Q?Gcs2Qo3/ztRkkuMnuWPTtyBaq1wdFijt4PXcLJlWekQEA75NoFXlkOs2F6?=
 =?iso-8859-1?Q?StyT0Yo8FALDt/evvAkNT9ZgSajxy8jS+9vAASjb2IazWWatqzoeegjjBK?=
 =?iso-8859-1?Q?IhfgB+bUXSzwOQAeoHpI6mOKr0RIi424lblJZd1o3/o2qbF+E/zU5Mv/eP?=
 =?iso-8859-1?Q?+zNj9C2fiqe1rTkGcn05ityWucTkVHtn/nT257pPAw6s1LxzaZgF8PunjK?=
 =?iso-8859-1?Q?QLg9TOnPeZ/ttOyqpX3UPlVKRYJAtYKZdLx1rBApBPhwARXY5nYRQTqkBa?=
 =?iso-8859-1?Q?i4SMDlDrUY3jcVxHeHYTCz77R9SFsvoBHA/3alsKpB3sOxa3F8SrU3HeAc?=
 =?iso-8859-1?Q?PeFAOHOxUCplAkoynRLMWpOd4HA15MQ2RJva/buAwBJV26sAx6hcQvlu1m?=
 =?iso-8859-1?Q?bX2fHmlfNhKYd5vL/UHSDufehAe09tAm2GhlNtnCU4UYu8S06ceg/qixDt?=
 =?iso-8859-1?Q?ygOnuIWdlqONZHVFxpO/ULbD8/3hT6tY0A2v1x7rkMYqWUtlx0i3yLjhZb?=
 =?iso-8859-1?Q?3/wu9RTgWbBIIBJfQvF2XZ/s4Z/DaTWt31voDYAKuy7fa9/RFWN2Qhm8tG?=
 =?iso-8859-1?Q?LCMo9xBStn/iL2GYJUVWn9yVp4SFcV3judIUKuFeWhjFzOvCzKyCjITciV?=
 =?iso-8859-1?Q?FgeeBFxv+JuCtdtUWEggXM5Cm8nlkqJ4r2x0N7JE8etLfkJKrF5sa3QwW2?=
 =?iso-8859-1?Q?hNtpxd2nPvdlluqRMxdydOG3pq1uTWo3Ajld4rdOTRa5tgj8+ISFWppJjS?=
 =?iso-8859-1?Q?6QOWY2BJ2PC/n7ZKxVZ486YS3SyA6275xZ7RDTHxBnMdsXTOON4UqI7mnX?=
 =?iso-8859-1?Q?dBgJJ+3KJPvpKYnaDtBvlQQJVANh3mR+30fsakzGrXE3ScQFSGrqOoqBX4?=
 =?iso-8859-1?Q?B+9riPgpUPuT8fk/mlfo72cLtlyGzITFRhwY+CWxdESAp8H7F96v4A4xQQ?=
 =?iso-8859-1?Q?09m7JYYz9PVM2LFAwweKE0d/KGD0Q83VvUYicLyOewpjujg5Q3jFY0fVLS?=
 =?iso-8859-1?Q?0EdbNTsfqAGCJcoNHnh8I7lNpPQgdlovU36w0IKJwzb51cwDh1qUxbut5i?=
 =?iso-8859-1?Q?MbMX7mVk+wSp5xIoxxboRhoXvOfY8AFcZ4hsG1oMgEnergM2R1o7L4vv2p?=
 =?iso-8859-1?Q?BYNRZ9sRGjVcFx0W1dX1Fos4K51eA9311rabfU2Fse8E2VUf4Ep3aiC1dU?=
 =?iso-8859-1?Q?3pHxm971VIq8h7girs6Wxj3PTYh36uT0hauGCv+8jzj0Dyb85f3r4D1VSF?=
 =?iso-8859-1?Q?MujZQ0JM/A4UbQeOC6m/VeyKqAbwx0edDsg4I7GIjew9/dJnexCkbaLg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c175be-cf80-41d4-c0c3-08dc687b1c9a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 18:35:15.1421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULT/5mcgLDWE3WwqoEBrWHsrrmVjjTVkgOzlHmxFudj9JITzpZTy+DCIJ/LZpxW1Azdb0n3na1nmpnofMq1in2QR9VmZ+t7MQq6ZDpV2sOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7721
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Sun, Apr 28, 2024 at 10:57:13PM -0700, PJ Waskiewicz wrote:
> > On Tue, 2024-04-09 at 08:22 -0500, Bjorn Helgaas wrote:
> > > On Sun, Apr 07, 2024 at 02:05:26PM -0700, ppwaskie@kernel.org wrote:
> > > > From: PJ Waskiewicz <ppwaskie@kernel.org>
> > > > 
> > > > Currently, Type 3 CXL devices (CXL.mem) can train using host CXL
> > > > drivers on Emerald Rapids systems.  However, on some production
> > > > systems from some vendors, a buggy BIOS exists that improperly
> > > > populates the ACPI => PCI mappings.
> > > 
> > > Can you be more specific about what this ACPI => PCI mapping is?
> > > If you already know what the problem is, I'm sure this is obvious,
> > > but otherwise it's not.
[..] 
> It's just a buggy BIOS that doesn't supply _UID for an ACPI0016
> object, so you can't locate the corresponding CEDT entry, right?

Correct, the problem is 100% contained to ACPI, and PCI is innocent. The
ACPI bug leads to failures to associate ACPI host-bridge objects with
CEDT.CHBS entries.

ACPI to PCI association is then typical pci_root lookup, i.e.:

        pci_root = acpi_pci_find_root(hb->handle);
        bridge = pci_root->bus->bridge;

