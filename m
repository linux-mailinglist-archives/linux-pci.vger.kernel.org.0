Return-Path: <linux-pci+bounces-8122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F134C8D65DF
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 17:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A410228A5D5
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771EA7710B;
	Fri, 31 May 2024 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVtjnQup"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B9B1C687;
	Fri, 31 May 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717169811; cv=fail; b=iXM8JrbRH9Y7UDM+KybdghVxXrM3ns133qH9JtRtcAbHCEux55zVluRh2EkqK+tnldVVlCYc5teyc7et4sP4PlhFSXjo/Um5tX8kauEGSEddLMU4pjiZeC806adVvCwktn/pa39vuhmrMp3wc+SvX0uAlkr5ubpizLVbg3vhNzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717169811; c=relaxed/simple;
	bh=OpRvW8oRJ+mJy1ltRWSv8M6fq3pXvCYN06Tn+TfcepI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YKlnWwNB9Alv9aLkOm7ulqNzS3MkjWzxf++hzgFxYEZMGR2sudlKNJ+p0A39JORvjM3TPxOt+CvIcriAK68F3HyIhXPX/YtaELzZDP2S/sRyzvAEtnBOooRxoKWItWKxBqzTGFk+IKijcBVyx/SNjSG6Ua08Sb+aB7IZ09uNf3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVtjnQup; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717169811; x=1748705811;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OpRvW8oRJ+mJy1ltRWSv8M6fq3pXvCYN06Tn+TfcepI=;
  b=kVtjnQupFtKM10biwNxI9CEURRK+BJP3IdpfUN0lAtO/GDCvf+sAYRZz
   YFjw5J/Y3SevzliTn8sI48R4K7DQJ+kyNWWJ6GZsTilhrrj6V9vsWeycQ
   7Cg6jPWXwFhK/DW9FIewYGOntaIhFpMgRjvpBvPLWmOR6nqjPeBKeyYk5
   2k2tQCA2au4QTJKeh1dpu6pn8lvhaEk4Hj+mqqkQTMNkcK3r3KJ/gMRPA
   CVAdwtqQY2qey6ktjFlIk5K6SrEIX8i+7ZHi2wgOb4wHBGGEyiJcRpZuZ
   qUzGgfxChSkKljPqBIH+OK9I0LoNCGgOayGuNx2umkjfllheX/oY8PlAZ
   g==;
X-CSE-ConnectionGUID: AHf3QnBzSIWEef4SU+9meg==
X-CSE-MsgGUID: Cz9JlamwQfavXpbGwZ2OGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13668094"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="13668094"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 08:36:50 -0700
X-CSE-ConnectionGUID: mKxxDjoERPqsnyV5NwNCug==
X-CSE-MsgGUID: RjAOV88lQe2m9wxcPhSWoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="67395014"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 May 2024 08:36:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 08:36:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 31 May 2024 08:36:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 31 May 2024 08:36:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hN2eEMahdhB3oP4zBEkPYyJiyeAM0KG7KtfUbbnX9YmsFVURIwCdOfc8mjhngt0gRYAi8Ly/gBfcYp9M4emzzsGuy8KBCrjFe/e7TeACBoTsasVCAT/lVbuKJKQaU+WkZrNZCrvWbfhzvruVufH0XqOA3KXVDsOxe6v33BxIWRR9IaXi9ubqNT6w4qfa94gvMvNx29AsP2Qb0GDZdwDnWDH1HmVmF2WcGwoMeeIzQn0ZJz4shi4MagcalNRaJaVl5Ubzyy8+SpdCLBlt7Q76EeZZsygNf/cs9d72ragbguxjCjMNs6ThIktB8RGH/+bhQZ/uykAd9Lk893sbzvnDPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aN6aIHuBMtzloYLNR/lsOmwfU4iScRxRXKyiOhLu3Bw=;
 b=Dus5K2qOIYLw0FewV5ipPzqsWajUE34TuRB/+iJpLAcX0gAIX8LMwYMb2QWxM16cUyvZkoo14YB4e3iNWkAbfjjQvhqyifIhPVGu+dZatvhu3c9HLlX6/M+GVOcvTwAOUg6aOkkyt3ILmct0iXVYvaMdHLJ3r8qPvkrR0UpC1dCWYltvNqVLPkd6dTFSMhEEVQZq2qmyWKzHLVHpUcfJ5FGA0w+hM8E8wVp3JHxkgW5i4E0UMBd8zKorQY6rYqcV78numi3KVV9LDLsfdYrijttP7FazCBVHgkpcbfNIuhYE5kzJNrGij4TYPYajcQwKVHITp7yxNZq9utbOWMYHOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5006.namprd11.prod.outlook.com (2603:10b6:a03:2db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Fri, 31 May
 2024 15:36:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7611.025; Fri, 31 May 2024
 15:36:45 +0000
Date: Fri, 31 May 2024 08:36:43 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Kalle Valo <kvalo@kernel.org>, Dan Williams <dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
	<regressions@lists.linux.dev>, Jeff Johnson <quic_jjohnson@quicinc.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [regression] BUG: KASAN: use-after-free in
 lockdep_register_key+0x755/0x8f0
Message-ID: <6659ee8b8dfd_166872941c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <87v82y6wvi.fsf@kernel.org>
 <87wmncwqxf.fsf@kernel.org>
 <87sexzx02f.fsf@kernel.org>
 <66582bee45da8_6ec329496@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <87jzjbwxin.fsf@kernel.org>
 <87frtzww57.fsf@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87frtzww57.fsf@kernel.org>
X-ClientProxiedBy: MW4PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:303:8e::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5006:EE_
X-MS-Office365-Filtering-Correlation-Id: d31ad289-4be7-4eb9-7812-08dc81877a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H+nsTYPZ4a7HS3vMmMGKEZul+F5gFxiPs0dbN0ysD6cMHjwaMxX6ah1m9gT7?=
 =?us-ascii?Q?j4TnUOQVJkBa0BwjlKfk5PT6gISPFzkNRtqrinaMxsBPNuK/MEtYFSOSW+Vd?=
 =?us-ascii?Q?6A0ooYAGGvsNu7FFydqSDhHOV+sjoC5fnl+WeZyx+VCHukIB1dMW480mxlAm?=
 =?us-ascii?Q?/phMWTrioQjHg5U5Cnh21CQWK++/71h+eTaZLNu8V5Zp31SER6ccVZjkkWq0?=
 =?us-ascii?Q?dpRpgdZth6F7VqtZyBSVgEaPaQzK00BLvBCl6GdHNjnMW1aODPXSjJBB5Q5j?=
 =?us-ascii?Q?ykKtBr4m8pFX147WSi6+2SoyBDSt7iOUi70jXA/4my/EWr7EpjJK4EoddQ0f?=
 =?us-ascii?Q?ihkREzsn9OfQoNFk9H39fXoL7aj3d4nSu3cWp2k8/K4mklfPurupPMVeaeZG?=
 =?us-ascii?Q?2PGLczGH4FmjugMiVS14zXkrmlPMi2DzMU6j6BStXDYVMAUOC8F5A8/oWJ2l?=
 =?us-ascii?Q?2BM20EGOpKstMPTxYEsTT79hebKb0OUfe+QyPPpqt311OzYh7jM1hCgJhtg0?=
 =?us-ascii?Q?nXgVOt8EoiX5+wQzrVSPUTIysdsll34AJgt1ipnH0CfPHKPIHaxI8bKqr356?=
 =?us-ascii?Q?nJYWf1JbwSOLocgvgRYCqsM4WFxR4vNgfjwo/6jh0xWTg+dHJk1e7w7eEQ6H?=
 =?us-ascii?Q?BL7L2Yq89hr9ottKBC5HeK1WSoHAcxjCTz9WW7852qJmGNBFTPJJ+Sm6Uo0x?=
 =?us-ascii?Q?ckPZFpM8rHrOkP1w8oIg6bgTpl2vZnXnf2crujfN+ucupL4foOW5jhVkHmSo?=
 =?us-ascii?Q?Qo4cFE/wshZcqxv+vfn/rGEK8hHm1WrHaZ3tsPjwoU+zyehtZIF8yMGJNg1T?=
 =?us-ascii?Q?dAWlNmAsrpZgcEQNw85qR09KUQYZRMLnvJVmJMZ0G/pEOrdYm1RCYVPSXeEa?=
 =?us-ascii?Q?HecfOwsqPglEAUbF5OPqdGlZLtWwSkc7T/q1j/gvfvtDko8SjcZ9zNjCdWXA?=
 =?us-ascii?Q?3cMMBMsGV9Rl00XH4QHK07Xf/wHazJHLRbZVXE02q6MAOc+sfQEDrzBSpT6C?=
 =?us-ascii?Q?mYTTp8x+9Ft9/vGqOiIagj6cfnS5ANuuqMM0RNouCY1UpOhryKMaeyYdEAAP?=
 =?us-ascii?Q?SLwpx8PbMABu8nm0L9w47ftZ/9VZA309j0tnSPQJdEAUsLTvkvi5vogI5Jx2?=
 =?us-ascii?Q?2qIUmJwFdTTgOd3CFyXf3jRZUui1lc3uNGF7E1gq8N1K1GU1Lv8A6yaywK7c?=
 =?us-ascii?Q?KHqmjcQhfKSOeijO5gG4doHX1175hPzErL+oH8HOCsBqfIWSanHezR5Qbjo?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a2k8ugtMistCSnacYxfVXRD/MW5AtknUrS3fURJ1htsIcWDAWG3gQtPMLzC3?=
 =?us-ascii?Q?JBXXklg+98iBMVRyfRG2/mavaK1qg4Fz+OpMLoykGWq218N6Nl78XqBmfJD5?=
 =?us-ascii?Q?SWYmu5H3XCIdNpjS7hJ65d+iGhs4Sx/rcmfUV/9e5DchRhCPoT2CT0bqR/4/?=
 =?us-ascii?Q?26AKqKg81LeNhw8LnnfVu5sUszl12HyuEU5GD8jv3OMaeSsG4w2fCNpBMhG8?=
 =?us-ascii?Q?Ti61TniYqlHsqQ1wDmI8NKymYbf2vAgz8E7jgjfw7E/dqW9TO7kl7N6xwhXC?=
 =?us-ascii?Q?9+dbOCvdBgikJOqOV8BCSo1v9ZJZA3dFIw94/YPr8YgPc79ax/EQfMddGTGH?=
 =?us-ascii?Q?OnbBX6kdjc+mNfjlLfEMaBrSqeFeOP9eJJ57Jsx+q71ED3dQI69QgsXWbQbd?=
 =?us-ascii?Q?Op0IVhUzDIhKx2ErXZ14YMqnH4s0mDiGwccVoQPHXiND0ESFD3B9u8xcH9mW?=
 =?us-ascii?Q?4V0wGqX09X/zYp71LYmeO8bcNTxMWXY27nxLGdcQv1XVaayih/0l1ddWt7fL?=
 =?us-ascii?Q?aun8fddpd2AbMliElY+UcUCyt5riz/kFqpslLOxqau5YVWCNiutUhElr0utg?=
 =?us-ascii?Q?hMq/8oAVbiJvTKI+IwnNn/ifmBk7no8xIwFqoamTHuPt3mhw/cUoj6mSPAyu?=
 =?us-ascii?Q?eu6Q8RRqFNHJHRFqIM9YABH5CcBi33GDUVczf3ugJPPW+OpcBKGexnZv1lBl?=
 =?us-ascii?Q?k4VoLKCJVCw5AXHH+GKc4VkmYbiCjwpH+yQ11KrI5U8ZNTlAzs34CaO1OAOQ?=
 =?us-ascii?Q?ZVL96MW4XGuArFzA5Jd1NwpjKs6lXsJCmz5WHQjISrWzwEmD6XpBW59jgp8A?=
 =?us-ascii?Q?+FgKrs5wQFd4UaCn4qcfCFCZsOufkdvZUgKHCTVkYyePT25rj5RxaYKzyGV8?=
 =?us-ascii?Q?yGqHPdxo0FdMIaezOi9ebcm5X0we2iiyNsKkb8rSKfLxdmQBNrvBPwZR1+bt?=
 =?us-ascii?Q?9pAgg/boMJNMHBr+6K6W7AkhurAwFmuvvalua0K6dhywjlQKMYkiYJJ08Y9l?=
 =?us-ascii?Q?82QzhYlsN/lduo9Ir4Da1LXYWYL4vHI86G9oJfIjqoVL5/K/Q4VWVkRPVyTD?=
 =?us-ascii?Q?wShC0DN96X3ogw6kaKG7WyxVbKhfvSFx/+2hOxl1y0Kzl7Ghyuw96fj/RQ+S?=
 =?us-ascii?Q?o20BdBl4B8lXiHxuCYshYswpWDliocbxmZYtMzqkF6yNd0CHCs2YjcZg1CUd?=
 =?us-ascii?Q?oikF2hzST3SDDXLTbhaboFy9R9EADLNXq8wMH7VD3ok5pxS6ATPh7v0wZRPM?=
 =?us-ascii?Q?rN+VQAOSkvkPL1O7UsVvvtavLzFqR8tumz0yVBbVl/xs+9+/ke0iKI2uZ2iq?=
 =?us-ascii?Q?NGRQKQOjUKA9GgFozosNrgCUQ/WwsgG4zUqwkNYME/+uu25NBRsI1IjjzqHv?=
 =?us-ascii?Q?3sbu3GzXUcceAMXiWTvXvj5XRYSnmcbqvCJWbenQS4R04MQIPU+UrZvaYeeq?=
 =?us-ascii?Q?FtUwQCavsTt+1ZFOjkrFo64zSb/HQaAmQOUy62rXDkg19o1ZurceHLjKnH6v?=
 =?us-ascii?Q?RdNKHGklTkz8K5yrufz8V6Bflp1F27J1Savw9Xn/El4/ct6cl0js53z5Ugl9?=
 =?us-ascii?Q?3fukjThPbgsKw0TSAev6X3vIsqxE4B5cX0cdebFLCbkMYBMX1TRr4qTTUqIn?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d31ad289-4be7-4eb9-7812-08dc81877a88
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 15:36:45.7355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hc+5G/VQjnoqFbpdiKo+7fHJztMQkzNHqiOXhxfDDxyJ06OdDeb2yc/X2KhVhRjcM/YXVHb2xW/bVYQ1wSX90HejR0+1OPmAllaQBDE3mQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5006
X-OriginatorOrg: intel.com

Kalle Valo wrote:
[..]
> >> The proposed fix for that is here:
> >>
> >> http://lore.kernel.org/r/66560aa9dbedb_195e294b0@dwillia2-mobl3.amr.corp.intel.com.notmuch
> >
> > I get "Not Found" from that link, is there a typo?
> 
> I found this fix from for-linus branch:
> 
> # PCI: Fix missing lockdep annotation for pci_cfg_access_trylock()for-linus
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=for-linus&id=f941b9182c54a885a9d5d4cfd97af66873c98560
> 
> But at least that doesn't fix my crash.

Sorry for the broken link I mistakenly used a message-id from an
internal thread with the intel.com reporter. However, it is moot now
because the new direction is to revert the lockdep infrastructure:

https://lore.kernel.org/r/171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com

(that link works...)

