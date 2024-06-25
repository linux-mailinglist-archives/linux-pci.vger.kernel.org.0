Return-Path: <linux-pci+bounces-9239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA11916AC8
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 16:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6BA9B22EDB
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 14:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BE316C866;
	Tue, 25 Jun 2024 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ajCnlu3Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C953016C6A7;
	Tue, 25 Jun 2024 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326463; cv=fail; b=Jy9498WUfd+0JvozMwyy4BTQz8NLqB5H3DqEM3NXSp2n++g3bOoTr/7fx/e5TFcJTVjpo2LpfGGd37FW1KbqtvQgAffczGhsOFg/v+5rNJDJoGR6/2zKpjAJ9bqXcPVvLv3fVIUZu7cHDlVFFyrKbt/dYQVC1IdAnGN9TFMKp4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326463; c=relaxed/simple;
	bh=UFZh0zCJ1m6yWRr7YVATwRh27YPvHXV2IGl1H2yEGyA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=lUtamcoMMurzU0LReWzG2qcmITEhfL0IZujGwTFKDFzbvvQvn/WV+iRLBv7KM/IBYcLOY6Y0ebe3e+l4TXQWKV5kmAF+9am4blpKxzEzGFBqfP8ohmXVN+AHLG61EjJgQJ+rEVDV2erbnWTQ7Z4ZTth8CVVVAhQIcHD1xcTPqws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ajCnlu3Z; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719326462; x=1750862462;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UFZh0zCJ1m6yWRr7YVATwRh27YPvHXV2IGl1H2yEGyA=;
  b=ajCnlu3ZeVHOfHH5wv/VDKWGk+N3wPkyf6mFwdKHrzwt8TJef9olI7z+
   IbOmQTZfP6xJv9XqhPmOwEyWsnn2VsWVeXffsFUeyoiNruB7UjZavRRgq
   /mLUMFGEnA+o497kqrKUWDnuJRNxZfNR7qaTw5x/zlTSuoAQH2GP6qMED
   nCudorQPnLadQaD/JEpYttsrenW3/k01M83U9eHGDQo0H/uDJoMLkm05p
   Unkcu3w+D4mayjn9rpRBMFckn14bo9cHerJmdL7Bv/mpJJj4p3o4r/Qgy
   /qJfy3UXd9uc/0CBus299urqmzq7FnodRyHbL0+2kMbILEczg83P9sgt+
   w==;
X-CSE-ConnectionGUID: 0qVNgKsuQvSQmM5HWFdLFw==
X-CSE-MsgGUID: k5+68vplQb+YlNEN+rCUSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="20231115"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="20231115"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 07:41:01 -0700
X-CSE-ConnectionGUID: l+OnnaqcTRyZK/pma0IUmg==
X-CSE-MsgGUID: KTVa6+lURyOG15dGYvG1TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="43779755"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 07:41:01 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 07:41:00 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 07:41:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 07:41:00 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 07:41:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocQIWBkeTVzpsr8IxeTaQQfeAT3kuPIxOaDs7ZrI2FbSFUywSTjjbOV9bATsUaM4ngKrmTlGKjjpNua6ZL7GTa52+I11tL84JdTF58HXnaT/sSj+bUAvnaqB5973cXzgsagxIMcGpEDY6mpo5YfWxUYWBcl427xFv+gkqH5iQ8BxsyBYJ/60vSXUOyZoOA2arEklczEhx9Vjd8R/+MdpctA0uOSHInecoyfb/l9lD9DJRc1YmKVtTa+igLTIS46m5QxMspFlif2FRZGjo6F8LXKwr7VFnZN/ycD2aC9Ppl+shBzu/HFvg09AeojHxNOIKABI10Z1fcycaxaIE42Daw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGJLH5qOyvi3lgY8x1ILGHD8IHFdjiVfnyKm9U99PVg=;
 b=Ggnpp6b3p6PsiuHi8KyHf4wArb0rCBoDWEscqmWwoHXosnHl37iYj+sqiMYQDXnnxWF/SZbot404sH0hLqaY3IIy3ByO1XEwHZLlamaW6ffCIv1hZd1H7YOHmJB6Juyy7Dav4GfvN3STfYafMGLPIMOUj0hkpSsdxhDXwcZwYhFmsbrs8bMxe1kuulMUYDR2eTEUTOhdROC87gg/obKmSKDECJ65mDsdZalK4kzqaBAdllvgCrY8xuB1cvNlEsfiOBfch4ePs2uCno0ZZo25plVuFI8q2NXwHmR7DljlO3ofqwyjk1TGtgnlzwkb49ncQYt3oD0DrHJl2MthOLXxDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN0PR11MB6109.namprd11.prod.outlook.com (2603:10b6:208:3cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Tue, 25 Jun
 2024 14:40:58 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 14:40:58 +0000
Date: Tue, 25 Jun 2024 22:40:48 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
	<anna-maria@linutronix.de>, <oliver.sang@intel.com>
Subject: [anna-maria-devel:devmsi-arm] [PCI/MSI]  5f632ae043:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202406252154.e6678312-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN0PR11MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 47afef47-d0c3-440e-d6c1-08dc9524d374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BacLj2RoqiHB5jo/PjuSXc+eIxCGij3kXushWOWKZ7rNYLz3cjm7fDhwhzda?=
 =?us-ascii?Q?kS1PO0D7kBHljud6/Rp9DcBkVWz96rLYQ7ghtkAt4XabTWOsV5ucJ8pQRetD?=
 =?us-ascii?Q?snPFsHmp/ZMLJMKktRtTqcGokk/LoZC1v7hNbnpVllz4UEW2bobMfNnmVaEA?=
 =?us-ascii?Q?DnWN8GkYt6frFg+AtIEIWCPxRwgIsPexRvU1plD8YbK+rwk56imnByL3Q4Hx?=
 =?us-ascii?Q?qXBM7U2M8snyfFHC24FeA2v0UCXC7LoDhqA4rSJkWr6ioefBIbm+hwO6LPm7?=
 =?us-ascii?Q?0g2MGVzqSprjjsuQ3JuDbqs41ptCkKEeekeQbeOPBm6QPNrDuiwDbVQuewcU?=
 =?us-ascii?Q?eAVEUOi/ICHdhWPstu1Kc6Th/6LSlZW88xUOz6vxYvZBDEzZFa1LXFcOzghE?=
 =?us-ascii?Q?nBlvdGafJVlF8SHsb2yP7RTt+3+cIHNEU5GoaRB+NxdHCTGeUW7mtQRCqd+b?=
 =?us-ascii?Q?1FL/ViOg0/VplzDH9WdeEroHB2NiV8N59ki7l2eTc6LzRxuAFS+iKyvYRu3C?=
 =?us-ascii?Q?nzC87U255QVMsLruaQLI5Ikwi0uFq1kNm2r3ok432UtB+3Go9Hj6VWC8V4Le?=
 =?us-ascii?Q?7leooyvNSKc1EIbTNPWxES3B/vFDx6DbB8KT2jZsPIqRG6tV+AYxq4+3gNxK?=
 =?us-ascii?Q?rXX6vUb2Oy4qF9zm5srSbYhyih3n6daJCyIdZgA/g+40YD6BPXtAPC8RAdfY?=
 =?us-ascii?Q?nwoDEUZOckfnfn2yRyQFJagTH8QboCJO1cB2LMWy7Nt0lIou/rpZRJ8FXzkb?=
 =?us-ascii?Q?Dk4IzZdYOl2Q64rSuxaDB70R6pfNSNg1GXqQFwK153h8vM+eg+k4gKZW0yOX?=
 =?us-ascii?Q?/4VXzad01EO1IOX40SF0kX5iY6R5QriYe/gz3eXgxDNi3JZbxNqTKY5hD+jm?=
 =?us-ascii?Q?sG1bgOJeNsWCM3CYiEaQwFsfUurPOCcMOYmNaTBWyISWARUKc13d0Msz394t?=
 =?us-ascii?Q?0yzZp7BHrdUBzx2fAPsYkFP7cRDxmKbuhwSCmTofw8+RxWB5llQ0Cfv84nxc?=
 =?us-ascii?Q?znSsGxLurN8OdGvxeDxYWbTDPOsFcVyJXJvZI8zml1pqSdBKkr2wVnk3JE19?=
 =?us-ascii?Q?WOajMQ4XiHFmvHTS3RyMI3TxhfWU/Fuy2ZjgX0dyX/EmL5GA9Skv3Ee4kg+Y?=
 =?us-ascii?Q?tRonGeeOKUF3oHPQxpDtoIC1KVYnZDKeVuezu4xzHaWbZ0jYfZixmtjfmqTd?=
 =?us-ascii?Q?eHD/7FEZGGwVX3tEms1Z3NyXfRnv3TUg/NKsqDvSq1YVTph4yYYRKEDW6G2T?=
 =?us-ascii?Q?owAKvKVtTLNvM24lAWpvqKVLmSxrse7DfqDMFZCCPw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ls/NpL9KCdieYUALlT0R8Noi2dQFCoM8l/fLYmuzoHsAw6XSq3oh9C54/o0a?=
 =?us-ascii?Q?0n63oHPjsQUze15Y1P5qKcA7oRXR/gB9PuP0cgvNNvufqfvWOa1eN2UhEfj/?=
 =?us-ascii?Q?7pruuQb95icbXfIfTJg0U7y6gIUHREe/USXvhK4MUo8KuKVu1GzFCX7TbsI3?=
 =?us-ascii?Q?/nGgy1VD8f/MjcrIyFc1XfWUGNDm0VT8DZ8inTRIbtT8l7t/5UXsCbjiX+FZ?=
 =?us-ascii?Q?AxmtjQj0ssnb73scxau09/xBjuiobbvLykIbpIIMMCaTqFC2hV7kpows7inp?=
 =?us-ascii?Q?OAQiDXQ0KvAfTwFl532waj8qdUjXX5Wf4tU5BgFjHp+2rCO5SnvLXA2Sd3KQ?=
 =?us-ascii?Q?WxerZeUeLMArHUH5tpo9znLKkwd0OqlaEDkKiua9SqDB+6n/T40lbcee6kMF?=
 =?us-ascii?Q?fgQ5W2trR2pjt8MbQyAcOt/N2TJhIxKa8tZTPdAPVoyinMItmqsv1m66NAlH?=
 =?us-ascii?Q?/ZDiFZ3AwgEMxHKhuZt5V1E2r2gv5aI/RFU5os6hFwpooxjcAd4hnZGwSTrV?=
 =?us-ascii?Q?VPYfjrNDC/ssaSyD7Vv09GHsJmaLnX5uDYIl9Cf0fZRXZ7nl++MbPpqH4wMq?=
 =?us-ascii?Q?inQUggMnq4CjunSQ3DVkE5uQODEzPbq5WQ0TLN/bcJPhNh+o+RIH1LFsVilt?=
 =?us-ascii?Q?ZvQkGU0nK7a345bpQ/KmqySlVak+C5uAc4l6adQFLvE7DwvmfYTsZU3DrGTL?=
 =?us-ascii?Q?0GE4BhXnF5kipDEEmuHrst1jgR8A/5N0SRotXHX1cztUT/OFyP8XBor1KQbJ?=
 =?us-ascii?Q?uAqGLVIFVwwD68wfGFfeFkwKewebRmI/UWRmzAM3UO3c3KMoWcUjkZgLJFVU?=
 =?us-ascii?Q?hoN2MiBWwqqXSpa3YeKByc9mRwgkluCfR2Drs9i7wSWiELrd6dQZds8fNh6r?=
 =?us-ascii?Q?P4PicpsB6BZ/RtFA/iv4gZGFJrfkKf/0oyHgd+vzHcci4EbaWt+PX06e1trb?=
 =?us-ascii?Q?lJYrZ9Nyjuz8yQxMK58m3Mcu9KSnbDnoYJe/PDwT+pBOjIWYksp26qDCBpf3?=
 =?us-ascii?Q?vv48JGD4q+tffH3IBYS3J1TooHwrXWvhNPhlT7/8ChfjBu3VQO2+7hwuVXGX?=
 =?us-ascii?Q?MhOtawHpzu1iGsGYNA2e6efnNDTzyI6poiDrrDuADbDYKx1nqxSMDkOkUHBk?=
 =?us-ascii?Q?C/2sKlxURZjXGv3r/PqLWqNjgoMoe/kgEJW4Y62/QpWRHEAwQPVdsG/om9X1?=
 =?us-ascii?Q?ymivPhOJPORJiqpfDWkqi5tueRwyf8UHpRLIt6UCt/PX6sFwdrx7cI4QwFOZ?=
 =?us-ascii?Q?4lZbcSVrjxAEVybAxN10vJXtvlVNbthsvrynw+sXTOUdpeA9j37irm6f5y2+?=
 =?us-ascii?Q?CpnU7CszXwU6JUHUteXVqjVrN8PgDMX2MuTvTG/u7vsJNVMxL9SAGMkvhbF5?=
 =?us-ascii?Q?npfExEMq6oRwqmWlDEQF2e3o0DDQf2Tp353ywCOgIsyMHBPnRXnon2Vh81yZ?=
 =?us-ascii?Q?Q9TRV3wEjA1A8A52JggnS2tOaZ/nP8Ubmwzd3KWAKTlY364V5lfeaeQ1WWAI?=
 =?us-ascii?Q?k/l+KjOpaV64YQjqxdxeo2uYVeNAbrVAFHVMzu+2HeN/FGNPkhHqUlO7/mIP?=
 =?us-ascii?Q?dTkA0E4fsxFamG25jndoMMBZ3W1sBtdRC5CMismEL96zm7cFuEfm6TlQYqcC?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47afef47-d0c3-440e-d6c1-08dc9524d374
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 14:40:58.2007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYQ0Io4CAHTbqcYhMpZWOlNvo7Q2Zu8VQ7OpU05WIt+pCW7mhJtcZFtLWwzPJqlAuCjX1cp5J1HXvZPDxo7oYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6109
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 5f632ae0439cdbfaaa26cc49f08680ad6e38846c ("PCI/MSI: Provide MSI_FLAG_PCI_MSI_MASK_PARENT")
https://git.kernel.org/cgit/linux/kernel/git/anna-maria/linux-devel.git devmsi-arm

in testcase: vm-scalability
version: vm-scalability-x86_64-6f4ef16-0_20240303
with following parameters:

	runtime: 300
	thp_enabled: always
	thp_defrag: always
	nr_task: 32
	nr_ssd: 1
	priority: 1
	test: swap-w-seq-mt
	cpufreq_governor: performance



compiler: gcc-13
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406252154.e6678312-oliver.sang@intel.com


[   12.206077][    T9] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   12.206995][    T9] #PF: supervisor instruction fetch in kernel mode
[   12.206995][    T9] #PF: error_code(0x0010) - not-present page
[   12.206995][    T9] PGD 0
[   12.206995][    T9] Oops: Oops: 0010 [#1] SMP NOPTI
[   12.206995][    T9] CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.10.0-rc3-00003-g5f632ae0439c #1
[   12.206995][    T9] Hardware name: Intel Corporation M50CYP2SB1U/M50CYP2SB1U, BIOS SE5C620.86B.01.01.0003.2104260124 04/26/2021
[   12.206995][    T9] Workqueue: events work_for_cpu_fn
[   12.206995][    T9] RIP: 0010:0x0
[ 12.206995][ T9] Code: Unable to access opcode bytes at 0xffffffffffffffd6.

Code starting with the faulting instruction
===========================================
[   12.206995][    T9] RSP: 0000:ffa0000000173b20 EFLAGS: 00010002
[   12.206995][    T9] RAX: 0000000000000000 RBX: ff1100010608da00 RCX: 0000000000000002
[   12.206995][    T9] RDX: ff1100010608fc30 RSI: 0000000000000080 RDI: ff11000104e0f680
[   12.206995][    T9] RBP: ff11000104edbb00 R08: 0000000000000002 R09: ffa0000000173a54
[   12.206995][    T9] R10: 0000000000000000 R11: ffffffff82031850 R12: 0000000000000000
[   12.206995][    T9] R13: ff11000104e1a300 R14: ff1100010608db60 R15: ff1100010608daa4
[   12.206995][    T9] FS:  0000000000000000(0000) GS:ff1100103e200000(0000) knlGS:0000000000000000
[   12.206995][    T9] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.206995][    T9] CR2: ffffffffffffffd6 CR3: 000000207de1c001 CR4: 0000000000771ef0
[   12.206995][    T9] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   12.206995][    T9] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   12.206995][    T9] PKRU: 55555554
[   12.206995][    T9] Call Trace:
[   12.206995][    T9]  <TASK>
[ 12.206995][ T9] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
[ 12.206995][ T9] ? page_fault_oops (arch/x86/mm/fault.c:715) 
[ 12.206995][ T9] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539) 
[ 12.206995][ T9] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[ 12.206995][ T9] ? __pfx_pci_conf1_read (arch/x86/pci/direct.c:23) 
[ 12.206995][ T9] pci_irq_unmask_msi (drivers/pci/msi/irqdomain.c:164 drivers/pci/msi/irqdomain.c:179) 
[ 12.206995][ T9] irq_enable (kernel/irq/chip.c:438 kernel/irq/chip.c:432 kernel/irq/chip.c:345) 
[ 12.206995][ T9] __irq_startup (kernel/irq/internals.h:241 kernel/irq/chip.c:180 kernel/irq/chip.c:250) 
[ 12.206995][ T9] irq_startup (kernel/irq/chip.c:269) 
[ 12.206995][ T9] __setup_irq (kernel/irq/manage.c:1810) 
[ 12.206995][ T9] request_threaded_irq (kernel/irq/manage.c:2211) 
[ 12.206995][ T9] pcie_pme_probe (include/linux/interrupt.h:171 drivers/pci/pcie/pme.c:350) 
[ 12.206995][ T9] pcie_port_probe_service (drivers/pci/pcie/portdrv.c:529) 
[ 12.206995][ T9] really_probe (drivers/base/dd.c:578 drivers/base/dd.c:656) 
[ 12.206995][ T9] ? __pfx___device_attach_driver (drivers/base/dd.c:920) 
[ 12.206995][ T9] __driver_probe_device (drivers/base/dd.c:798) 
[ 12.206995][ T9] driver_probe_device (drivers/base/dd.c:828) 
[ 12.206995][ T9] __device_attach_driver (drivers/base/dd.c:957) 
[ 12.206995][ T9] bus_for_each_drv (drivers/base/bus.c:457) 
[ 12.206995][ T9] __device_attach (drivers/base/dd.c:1028) 
[ 12.206995][ T9] bus_probe_device (drivers/base/bus.c:532) 
[ 12.206995][ T9] device_add (drivers/base/core.c:3728) 
[ 12.206995][ T9] pcie_portdrv_probe (drivers/pci/pcie/portdrv.c:311 drivers/pci/pcie/portdrv.c:364 drivers/pci/pcie/portdrv.c:696) 
[ 12.206995][ T9] local_pci_probe (drivers/pci/pci-driver.c:324) 
[ 12.206995][ T9] work_for_cpu_fn (kernel/workqueue.c:6670) 
[ 12.206995][ T9] process_one_work (kernel/workqueue.c:3231) 
[ 12.206995][ T9] worker_thread (kernel/workqueue.c:3306 (discriminator 2) kernel/workqueue.c:3393 (discriminator 2)) 
[ 12.206995][ T9] ? __pfx_worker_thread (kernel/workqueue.c:3339) 
[ 12.206995][ T9] ? __pfx_worker_thread (kernel/workqueue.c:3339) 
[ 12.206995][ T9] kthread (kernel/kthread.c:389) 
[ 12.206995][ T9] ? __pfx_kthread (kernel/kthread.c:342) 
[ 12.206995][ T9] ret_from_fork (arch/x86/kernel/process.c:147) 
[ 12.206995][ T9] ? __pfx_kthread (kernel/kthread.c:342) 
[ 12.206995][ T9] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[   12.206995][    T9]  </TASK>
[   12.206995][    T9] Modules linked in:
[   12.206995][    T9] CR2: 0000000000000000
[   12.206995][    T9] ---[ end trace 0000000000000000 ]---
[   12.206995][    T9] RIP: 0010:0x0
[ 12.206995][ T9] Code: Unable to access opcode bytes at 0xffffffffffffffd6.

Code starting with the faulting instruction
===========================================


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240625/202406252154.e6678312-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


