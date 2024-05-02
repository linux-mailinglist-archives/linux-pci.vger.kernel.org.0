Return-Path: <linux-pci+bounces-7022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CE88BA088
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 20:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E591C229AF
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 18:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775F0173343;
	Thu,  2 May 2024 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BptcOiMg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7181017334F;
	Thu,  2 May 2024 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714674572; cv=fail; b=ZNuhCCbdBM9ZhaB0vumzVIBN2hP1dTDRSnXGJqV0CLlCUpHm5CvKoYuDAefinoHqkdsRw6ZQ31Nm/vEioUenBPTe+ZH6LGT133UVzwV+8r4Um2bbtEy+N25KiXZgDEtqPukQGTi9K946UludOakNRAyUKiFgqJIkc0Raux/fFu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714674572; c=relaxed/simple;
	bh=a8YDPLfjLIYqfBuK+bOKJShTHBhcV49HUuOC+4oC6wI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=js5hhigWO75uIeD7NW/+84q8a15rf3SsnPgKcHQt+A5vlVOvK/DLrRqEHwX3MJrxlSdeIN3sKlZPvGwLTSyixHka4yQizc3/wmAYMMRngxceGI1afBCtE8l3s6rjcGm0fPOhC1XhYyjQoBY6lG4KBMiUFDcUGm5aqofo9z1xIko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BptcOiMg; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714674571; x=1746210571;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=a8YDPLfjLIYqfBuK+bOKJShTHBhcV49HUuOC+4oC6wI=;
  b=BptcOiMgoBtDLdaZQ52/wHyRNpEkEEKWw+bOOEjFC9e7R0dVh9IiJuTW
   jwTQ65JlW01GHwOYZrSheP2FGD+zQB7/WWf2hwtWsfXhZt3IuUT+1Q4kh
   yxIHowhIJWu3TO91gYjRMFIPEEZFhPt3s0Liord5ouw9+mTezqdNhobZd
   nSXCW7ZdB48YxKF3gBddGSYnmfGMExRPuNHVw7niHFMcFiOByoBmPfyGr
   ODuLWsgTkPENAEECV+ZGo1NsF7MeLp+iuW29J6k5zW9iD60cG9Glj+BTe
   reLM6VBGzdCk44XvbAdMjkhC7RCyv+nCHEBnHpEsXX/YorNfGsoNSSesC
   g==;
X-CSE-ConnectionGUID: bFkpM4PdRdKNyyS8fNg1Fw==
X-CSE-MsgGUID: +fp4UoNOSSeoeMxY04HRgA==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10592818"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10592818"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 11:29:29 -0700
X-CSE-ConnectionGUID: 5ypDD+JrTJGveY88Wt7Nxg==
X-CSE-MsgGUID: e/wyre1lQ0iUelwPXbQpvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="50402163"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 May 2024 11:29:29 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 11:29:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 2 May 2024 11:29:28 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 11:29:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQLYhBK/kUxTM89XIWA0n3c9+yYCBZ2FPm1qqgwqyTzWFnVmgsN/FPLARwcaCKrS0iXWHKqx4aCgjAVRR8BJ4bvtUSDJ/uvy3mPBfoQrAlw2aNA5goEmIa+5kWGD5fIatParDgCO6RwrMUBLiOdx16LyyXWxtm9OQp9azJUKfPp3x7Eez1xu8+Mbf2eOqx4upVA3hnoWKc3Oy8YyDRPzNantVv5iR5pT10qLQUAFPFDVKiRuCMdmwl7KBQgKQCHnTZX3oQOTNtvBVqmruSlEWzynNtxE0zMtgubg84mH/TwLMk6zzCuFBnk/Ygj81xk2aWkYP2k95nXmgJLusyrscw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBtanEudekLj5SE0e/rPQaG5VCLxQHCppsp7OJXQ7aU=;
 b=KHeRRZaHQ85H2In0z1NCf89KyZtBV3X8QgssQ9zHxAXo/pOXpZur59DQGZfkuAVCL0iMSTSqNI7jPZweBT2/0p+MF5qNxWhfl9WV6L7aU4oKV77oMvjH4hI6S7CvRH3u7KDHY9kpJqyX/H5GNGd74Ygxa9TIGtXgwS9e9lozOjDtvIPDmdUsZj+qgf2UU+i1EpdgcWr2CgieIWcGUwP0mWhyMB9DhrCo3o0U5n5mG5IptAl+wN8JAb3ZIfXiu/K8mr2jZ4EXoHRkvRoTjs2uzKbpLRsltKQS+1PTdjFGyRlU6I997Kk0EQRulbL6sdeqlKLHUp3RBK81fuUQ3ccYrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7538.namprd11.prod.outlook.com (2603:10b6:806:32b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Thu, 2 May
 2024 18:29:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 18:29:25 +0000
Date: Thu, 2 May 2024 11:29:23 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: PJ Waskiewicz <ppwaskie@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup
 failure
Message-ID: <6633db83a13f1_1384629429@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <ce49c67c24f57ffab166d688a1c9e3139733f412.camel@kernel.org>
 <20240429153138.GA681245@bhelgaas>
 <662fe860eb889_1487294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <f5078550384a6b9be5a6d05415ea321332c7fb96.camel@kernel.org>
 <6632640bef65a_10c21294e3@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <6af0488a5d845028978f57e63f3706f8899465cf.camel@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6af0488a5d845028978f57e63f3706f8899465cf.camel@kernel.org>
X-ClientProxiedBy: MW3PR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:303:2a::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: fc65c641-6669-4bff-e2e9-08dc6ad5cb9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?G4qO8/TeLAfruETdn+I0GU1s59OZH2aJXeZA0L2nzKJfRmpqEGDPROI9ly?=
 =?iso-8859-1?Q?Ty3kUjdk01Y8guBOXeJb1FNBkhmUPRxhm9coVvu3SbAMjojSfp5+PxzyC+?=
 =?iso-8859-1?Q?+IgyCj8sEEMuT5IvFdfPwZcSQ+3AumLz73gCoHRjjs8bs3Z6+j5+V/D8d8?=
 =?iso-8859-1?Q?OKQjy3/xxHDxUqmuLj4vXGfrzLD+LOq+Cx6yRO7gS8Lc/tisbxRiGMGs3S?=
 =?iso-8859-1?Q?rm0degipRggC3J7euZjIv3hz+CUNXdx4YfXK6rfoa3bnsHubUtjoN2qDLm?=
 =?iso-8859-1?Q?E8mGHXUGgtIgG0C7f8Mz1VyEzSYebAk8zG+8JhPEW0rTN9B5ksuotX419f?=
 =?iso-8859-1?Q?KvT0IjRmolnWJzsX/MYSXV+RGbFO5o79u4ciWXgNmkeVagJp+0RsIRgE74?=
 =?iso-8859-1?Q?50ra94HlPTu25hhQ8fa/kfVfJ+v0McBLLptxud1a2B6+7dyDnpkadFTNW5?=
 =?iso-8859-1?Q?dN+Rd0hikO6poIaTeCvNiO119YV5BsHyWX1T+Q1VFvd5xP9WIA24hj5LQt?=
 =?iso-8859-1?Q?xlSP3fY5qu81kcH4baUsVTNSlAg9u5ECivhhFdwxZGpUxbHW/oHLIrR+3s?=
 =?iso-8859-1?Q?67aX33fGRWGfgfZyIMzRpG+XN47V0LQvPtP554s/Q7Xqe4gj/V2HQt4tNx?=
 =?iso-8859-1?Q?Xu2r0zARJ3xms++Ew4+GPFaf+kmJ9OCrlZbeV0d4YJep4/I5BcV+iWZP2T?=
 =?iso-8859-1?Q?mwblNd8XHAcwtf7SMqWjUsZCsh5poP5BzPW2pdE1oVgW+onSSBD4/iNcPb?=
 =?iso-8859-1?Q?aVGE0WmodIVRs8mUQtdJfjMY4U9CL0cq43MyVHDr/Hv18OGUmd7Dwz1IYw?=
 =?iso-8859-1?Q?kJTj6v+SfC1NG0cWtjo4hWRstVn4wqIdlSvsjypZg4wW8eKaeC5zl/HKcI?=
 =?iso-8859-1?Q?ytX/HJMPXJoq00hRSUlr7smrzdyLp/qEpjHSscu2CJOTBPokTJwBAAl+Bb?=
 =?iso-8859-1?Q?LNbYB5dTMlSkzvE4YnoS9tiJD9yYG9CvEDjv4+2DJqMP+v1JVF2psSsxgV?=
 =?iso-8859-1?Q?fNkNMUQ0fMeYoTzkeGNxQ2GILrAucE4iS7Vcr7aRKXlQVPKCs/CkOTxN2D?=
 =?iso-8859-1?Q?H8xq9zsQOxR7UUvhWzVc7JPps9pSZZrnq+u2kQ66jzqYg2p+J5rfrZv3aB?=
 =?iso-8859-1?Q?BLUqLGzKrqOMJoR6v6COGbF1cIDYaQcgt7+lp1vuN/EjIo9azeTcIBZW4q?=
 =?iso-8859-1?Q?ZAsbaGq/zumFZdC4n3Uy6UqXv6vNvTTgZaIHMWvtZiHTyfTPAkeSZxeG70?=
 =?iso-8859-1?Q?SCBQ/fipNLMjnGG88wvTFVHTCReLSLd23YEBA8gMhaFXZe4A08w/rLJTIt?=
 =?iso-8859-1?Q?5lNgMiw5Q8PdbI05p3zJeaACDQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?VT0bb/WJ3oo63hh23NwFJpn6qeTz4BWYDocUJmqwtSXY1D/CoJzHa4av/z?=
 =?iso-8859-1?Q?cueHm24A9xWgNoZyai6XGmnn3FmPGONQR/WkgKFbe9Cx1lsEKLuJoqoha3?=
 =?iso-8859-1?Q?6qq8jFbb4I/jQVFpxGRwJ6lfoyc2moBgQ8x8pDkgmfHp10ebVAO4oev3y9?=
 =?iso-8859-1?Q?2e1P6TBi4v/bPcQHRvtQfaVHYfUG/j5KQmI3NPo7VSKS/x34pm4HX8LFnk?=
 =?iso-8859-1?Q?gPiwC5XXb9/oX7ldKIrByfLQYTsiPx1UUu2cCSZqfKS6S+2ck2lCchkSHe?=
 =?iso-8859-1?Q?8DXubxOAfnmPWzQqBfiQBtYfPTuwhj8Bwcb/IKKOmeGuMDmL2dYozuJMi9?=
 =?iso-8859-1?Q?iIQ5Br3WOZ8knQk3hd/QUpMoVtGDEfZyLgE65D58T/aY1DOfY6Yh9JMF1A?=
 =?iso-8859-1?Q?FK++fPG7KIxdb91JRKYOHGEcnt+4igGJw7HpkVZC7w5TAMFZyiq+z1Rr7y?=
 =?iso-8859-1?Q?kMjOf1Azpwkn3mG90XhZfiUAbGlGLtiaLOA5eTWgBMVOoAiDT2frL9veHV?=
 =?iso-8859-1?Q?Z3jKNCDMxknxC3x7+h7rZQ1c8Vps+FwhYRYd6CKB+9O/zg9oBlwujQMakE?=
 =?iso-8859-1?Q?2WlBcb3oGc6QHWg2zbLctA5WqSmWtCab8+qbRV3UTfvNAYhEcEEiHdyFxO?=
 =?iso-8859-1?Q?cynGJgSKTxEhlx4whZYTjLe943T0Vt0sMwasMsilixrPLuWOePlDLJ4Ra+?=
 =?iso-8859-1?Q?4f4IMTtjNA7dZMBbpwaM5ZKtLBWATx1uTC1nTG6JDnju3eFnU64IyPLJWt?=
 =?iso-8859-1?Q?xrdmLt9GKpAKDeDG9cdNxxgbAPoWlKqfdj9F/VIMD+ProgQMOWiGUrBlIi?=
 =?iso-8859-1?Q?XLsplcG708BLnya9ju2Q994xG9HJKUq7wBQlaPFbVsO2lcUo3Feafzuufd?=
 =?iso-8859-1?Q?Qh4uBJ4eSoIGCjZ8BUWiuzaJb6JVHdtzqreX1Ot3/7COLuv/46De3Gi768?=
 =?iso-8859-1?Q?dDbmRRbQpvBSEJm82FPp9VdFHbmzzW/8aguR5ABCHM0Y5USPVuM6pfE/QI?=
 =?iso-8859-1?Q?xRZfXBa5YUyjbSaH7RjY75m0scEiZZt9If+pHrmTlotYcy5Hh4Af91W0r+?=
 =?iso-8859-1?Q?e1p7wXleW7Y7wv1dqiPN/Tyan+0ADRHoKEVVhrVP7cacf2GTHUGCo6gNTL?=
 =?iso-8859-1?Q?iUkVONQNn8Esmp3qs65p6bx1Or78xHCFKdaBbvnmmW4/fCQAQYRhvMu7IE?=
 =?iso-8859-1?Q?3lWX0YHfNzqD1eS+Pmi7FDwQeN1OBRgmpEFuQywYDSK0gXfqQYD4WcANLe?=
 =?iso-8859-1?Q?oQW6yGzdTbgu5Lg10MNViBExKxjoJLlX8s46i0IqVGu9wBoHb8dO6VwQ33?=
 =?iso-8859-1?Q?F/qjGhteL3qBcVaAT1Sb44sno++SE//k6ePXjkhsOSWv/1i4+qlThVy4rB?=
 =?iso-8859-1?Q?pKZRCuK77DusLFzxHg28GFph47wUfKYFIrsWne8LkRg8c50CabdCa1nSE6?=
 =?iso-8859-1?Q?5BbTfOxmRoE+BurNf5dK62eo5aBdHdNcw32mI5o28sIVGfF/I57RWsZ1/t?=
 =?iso-8859-1?Q?Nj8utDqJt+by8dH35nFjWETBmTu3vBZFWRRaF4asmWodLgtphx+Wg9ZsDn?=
 =?iso-8859-1?Q?N3drjdWiS2maCatxg3BWqkHuT8HT4cYCmslpVclPM6nLyuK+iVJDMacUEK?=
 =?iso-8859-1?Q?hyA6ThPwULpWFM2N+jyrhIoxa/nd1ookxEJyBPfkSkAznhNCQZlJI5dg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc65c641-6669-4bff-e2e9-08dc6ad5cb9b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 18:29:25.7365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCwYD6r2T7gRyEbGCbQjqq7J2cRCiolj8WsJsU7iXjK8dHvZDnNKXU75s4PT0h0RmDf+DdCeEnpexvp1T92NT1x93BaDVl0JaLkwgQt0B8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7538
X-OriginatorOrg: intel.com

PJ Waskiewicz wrote:
> On Wed, 2024-05-01 at 08:47 -0700, Dan Williams wrote:
> > PJ Waskiewicz wrote:
> > > Buggy BIOS, that above value resolves to CX02.  In fact, it
> > > *should* be
> > > 49.  This is very much a bug in the ACPI arena.
> > 
> > Ok, so back to this patch in question, my concern with upgrading:
> > 
> >     dev_err(dev, "unable to retrieve _UID\n");
> > 
> > ...to say "potentially buggy BIOS", is that same charge could be
> > levied
> > against all of the dev_warn() and dev_err() instances in
> > drivers/cxl/acpi.c. So, it's not clear to me that cxl_acpi driver
> > failures need to be more explicit.
> > 
> > Otherwise, pretty much any ACPI hiccup message in the kernel would be
> > candidate for claiming "BIOS is busted".
> 
> I really do like your patch you proposed a few weeks back.  I'm happy
> to pull that and test it if you'd like to move forward on that instead.

All that one did is annotate all cxl_acpi driver error messages with
"FW_BUG", if that's useful then yeah that patch [1] can be considered.

[1]: http://lore.kernel.org/r/6614575a1c15c_2583ad29476@dwillia2-xfh.jf.intel.com.notmuch

