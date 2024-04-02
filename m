Return-Path: <linux-pci+bounces-5567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9FB895B07
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 19:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7631C221FE
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 17:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5600F15AAA9;
	Tue,  2 Apr 2024 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwnIrJBb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6156159910;
	Tue,  2 Apr 2024 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079976; cv=fail; b=V3G3T69MPyVSiJ5h/YVCY5Y2mqxmpKeWRlhPROn6ZjkUTBvS1WmrtHtStlvhPrfzTpT08pqBlPkCOW1fr1cO0lSkLK0HAy3cujawUaw4j050kLDHHH3ZdTm7KKmzR1yni/S1KnuEqpG2lOv7/6EdQSkO31TBBxZpmjLSICEJKTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079976; c=relaxed/simple;
	bh=img3RGZNP3lYQE1obYMULMzQvIJD6dvv7AwaCPxKRfU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pb4Wg6EiwkMrivrD5fplKmMqyJrGgj85AQC9kwEzhh1bRc7q092ke/NTAkNIHLRRMqAuQbenaFL2W5ECWy5yKcnKESZ09ErB3yy8Ryi32lXY69bdUrx9LttiSry8yqJuJ3AXXarfoe80NIO/o4hvnKhy6/stHXMo50dLMnuhnyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwnIrJBb; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712079974; x=1743615974;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=img3RGZNP3lYQE1obYMULMzQvIJD6dvv7AwaCPxKRfU=;
  b=iwnIrJBbH1V9MzxwCWR1XLsj0Snw+qoLJ3QWG4Xbj7Y1bvgZsTKRuNKx
   VPHYCJqRr7ORouME3AC9HX6y+eObwcLNK9aiU7ZJ1b/QsFfQu1GX6sY2K
   XDuuR+KUQZKbfHNWvz4WCZ7N5+5oNMn4Js2DPBtGdtuIEE3vKSkQ84F7/
   7OZVjtwMgFJhZWBUsv0N91yR0X9DinhqjLc5Ky8m70NwUBqlowh3kgqP2
   iJt0I64lXr7CubBM60ITCLA/R/0FeNiB+9T05asiBptbsolURPlkZaMt2
   ZoCpqLfBsnUtut4fpSPCRSoCpviX1wmLTrn1nRs6Keaeij7PUP0In7UCM
   g==;
X-CSE-ConnectionGUID: lKwzPx08Rsqg+yzfYWH+GA==
X-CSE-MsgGUID: P70EtjgEQX+5MdqxQnkPWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18631890"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="18631890"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 10:46:13 -0700
X-CSE-ConnectionGUID: Zhz7IAOdRYqhA09VhBZbow==
X-CSE-MsgGUID: lpC1awaqTZ6wcb0xRiCIFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="22885735"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2024 10:46:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 10:46:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 10:46:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 10:46:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9MyfrIHLErp6l4qVs1AYpSx6PP8Rn3KwhxCl7cDPbzub3GlkLCtoiC8+WbYTQhLps9dKzFiJd1ufKr9ND9mey/zMRguUHwfd2cETK4Z0e+09vJPQetDnroKy86uQ2yhz7D38mvEjj7aBjcwHln4vwpIkswyx4O+jKxH6Wzjx180t7yuptiNDQb27wH+lCKAVyAkE4GEQNQPjaXy7iCQiZsAE/ocU1eoLZS/OsQt1OLoPSFZm6v+qGdgBt5MOF2uNvK+ghByBDT8GlYGlTI4jTSUmnuayjvcEH7nOqGvhtwjQhClt1tbpVFtNND1pIOBQxHzk31vH1FcULtD+hmGcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uc85oLS4AeFQlUSdFt5NGS0HPiRhW0eDdAfU5xi5tXg=;
 b=Z/4/gfgoYrESCYb5gAi75leE0MZWB+iBydak3AK81G4gVQcesMZhJQDHr7qGuxc1psu3WgiEeOyAD7HHkRGECHKHk7Iy7Kmt9YEliqT41m4hSgA0FKT9HjlQLPnGPnkn1CBQl9cCZVzuecNcl0tPMk+5yIctm/+7MDFvUjI6kI4RiJR+A9f678j9DeqWBEsrfUpBoqHW2ty2H8l3pEjoU8kOxapR7z9zFUxBhdKYhqwYrfzmrCc8i6Zok/jaxFsR3wr7AuOAlHkLKGDiethuEhg/rPuQScoJPiJkR0SpUC1au1u469bC/YcHy/kf29jRRDy/dQo5TM3WsBXpbGGtnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6908.namprd11.prod.outlook.com (2603:10b6:510:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 17:46:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Tue, 2 Apr 2024
 17:46:10 +0000
Date: Tue, 2 Apr 2024 10:46:08 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <bhelgaas@google.com>,
	<lukas@wunner.de>
Subject: Re: [PATCH v2 1/3] PCI: Add check for CXL Secondary Bus Reset
Message-ID: <660c44604f0a3_19e029497@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <6605bef53c82b_1fb31e29481@dwillia2-xfh.jf.intel.com.notmuch>
 <20240402172323.GA1818777@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240402172323.GA1818777@bhelgaas>
X-ClientProxiedBy: MW4PR04CA0287.namprd04.prod.outlook.com
 (2603:10b6:303:89::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6908:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +twLL4DZYtuEVHOqeAiUmRg3NVHJnPQmxCQ/MZYIDwvVQF/qokLJETMs+RRaM5AhIPc+CjwFjgo43gF9NtxZ8LVnw6quCSq7FVvioYWOxaR7uuHhz8GLjp2zeTr5lQzAbuiUS1z0ZLU4mYxT4glwjsE6waW2ce0AeU/slpknGENscR74WfFTqPXpGYfXzg1ssCk4HT7Zw5epw6P9UiJd44Q9c3ysrX0gAMNlzb52m7h7s0N6U6xn2rJ8Dt433ud2DlPFkxZFawzTf0JlaxKwJfQnVHtZkW+1buxFuNYMLDh5CikfE0UJyZWg0RMiYknHr8f25l5/sTtemkD0A0RfoqZTaIE5rMLgfY72eL7s7ni16VwSFQ4qHpY0Kz4qP/MGrdNNoJyfAnE89FT96ur6OodimbspG9V/X/cN/3vgh4FwiAwxtUY/yj5nwi7j24SAEbzWb+clXbL4ncIdYf6snk6akc8t+ttd4DplsBZYAuy626dkCizZJjlHEmYkUVLIPFrXS6Ckakunz0V4fWJHRKeJIsrPcAbRdIqKSq7mW+wMmrmb065RfhyuW3ZDa5DkMTDxjAocGEapjAhjQcOxL3lajzsI/EUNeNfPcmwHeelKr+cCfBYUE3hTKK0VMOPt83j0AO0KsUh8WIe3jLqwCOxB+6Kz6maFJWyd+8Nn5PM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5b24xoR5Lj8+4+hWNx3BKy3ef1eEa8HFwLjEcEej+BAjrRxZX7x6zpR2wQEx?=
 =?us-ascii?Q?0j69uVBVLZBlJLgI/9njTNdbr/li5uWkOe4MFn/awbNmshAYifoDLs3BkFLr?=
 =?us-ascii?Q?784rTjowPRIlBr2qPwZdUMOBopIm5sMm+e2vmKa/Dmyn8jFYqzyUHH7lE+WH?=
 =?us-ascii?Q?WgTgNId9r/0JZpt5yW9nT3uluIBZl6LHVkZRL8yajg8EBO9RJcU4tvHlFhHp?=
 =?us-ascii?Q?SmubvOsd5NjrZ3TtA1ZVzqHyR65LpLIv5Zp7rBjyYX9nAkheYHGA4JWP/Po+?=
 =?us-ascii?Q?sVsDHy+XqMU8sxiFmetrOO6IRWcsf/tHCZiJZvPxR47I0fghfybldmPK16c3?=
 =?us-ascii?Q?AKbtCZVulw6kB/twjcrlA3hdKDCeGUT64JPsDfQyiyGzKE/o3FPFRJlgg4Ru?=
 =?us-ascii?Q?3Uny4B3HG0ilUv7UxbF9q6OkFxbVWKnBHv5kxAPNolP9eiZw7gfF3WGhVf2n?=
 =?us-ascii?Q?QVeuoPhnvNsnepfkQS027fEZepfackyQYrbYaUa20bPB+7cnk44fbrBs8LR3?=
 =?us-ascii?Q?Ai97bOQvMtxhQAAq+HMPc/yQ3HcDWsfW+1M4mNAIaWWylvAO5fUteVlbgAhP?=
 =?us-ascii?Q?dv4PNqa5+FAJezG0tJ4xtlRy81XGoFmBm2p4yPmH+3hrTn4XpuJgYY/sTZIY?=
 =?us-ascii?Q?Bcu/56O9FLwVtmKv38qFt9vvhtkuH8YSXLtCuf7UH1+ii4eNvr3NE9u6zTMq?=
 =?us-ascii?Q?ncfE4ucWLJTD2zy8o+hyG4a5cQCXNGemfpkrX/3mlUqOpE7isy+kgD+F5/Vu?=
 =?us-ascii?Q?ltFU0Q7fcMGItUNvv/7wqeQY/NklTyWzNiwF2V6fs09njBaOS1sv7sW5SLdi?=
 =?us-ascii?Q?1m0yCaOEYRTVfAvzhMyEAW5Fwr3lCAXRGrwhd4hfj7x6d6CKLjZyE6zhA2tE?=
 =?us-ascii?Q?3YOhCX51mk3rqxYwBNW2s4JnJwKcnCpZCS7sb8cKySy+sZXx0PnG9NoVzZj8?=
 =?us-ascii?Q?s6j0Nriny85hAdVROg6vf9WjSWEkzXWT23EQKpKXNHIyKuDz+GotjY6x//cJ?=
 =?us-ascii?Q?6i6KMl1BGoAQP9EmE1QHWiQuEa2tAQp3eK/3LYRDFUTx5c4D9bwWifvpFWZs?=
 =?us-ascii?Q?4jL4IphjQ3j1fl9nFO7eS6B3B6vi5hGLO/efafmTOq/JI2vj78BFu8gg4Lxx?=
 =?us-ascii?Q?f0UscAcW23d+ECkGPnaU6Fv7h4UJwlwCudg0+szKXTLo0GsZcpJWNwUmWpcu?=
 =?us-ascii?Q?TA9K/FRZwRZFYDpzOvVZyQgXr53qp/Ka4QTkKrhLy2kkByb2+DgnHuNHJBQz?=
 =?us-ascii?Q?/9KZQBxixuwXNAfx4iTUlORfkYjt+cN3EcTwAAN8z53oa/dUDjfachlNeM+F?=
 =?us-ascii?Q?ndOVkktPCQU/gTSXqsdTMjD8BRtDQc+LmxJO2kikuq0sb+8Z49ONmEPSciCf?=
 =?us-ascii?Q?6sa8GWYOzKE+rgTrILq0Z5GDVDiyyMtObD6rt7K+nKBZaFHtbREhEy47LTjx?=
 =?us-ascii?Q?txXm1Qt7N1mOlDCiktBUJP0PEuA6O9uxNv8k/s9uFeVZmHzWEv9FNQrL1X1t?=
 =?us-ascii?Q?s3vVS2j2TJpvB8BqTKy/BNrSMplOflkNVZh7RI/q1kBM0EJJNe3GdIO/DXxb?=
 =?us-ascii?Q?7XSljZl3D3OqymTLwJYLugq2RLprWA2AItBMKuWwpvPc0jLFGUFohekVdZC6?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1e62f0-60a6-46bf-6f37-08dc533cc85c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 17:46:10.6140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LxY7rwJKLedXrDScG3irVfOM7AgHMcJvprteHZmgwJTsuA+HL6w055XW4DKudtXbS3+wmlEHCAYlTyG34voFhxwyZor/2uhYbe7RtKEf9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6908
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
[..]
> FWIW, I pinged administration@pcisig.com and got the response that
> "1E98h is not a VID in our system, but 1E98 has already been reserved
> by CXL."
> 
> I wish there were a clearer public statement of this reservation, but
> I interpret the response to mean that CXL is not a "Vendor", maybe due
> to some strict definition of "Vendor," but that PCI-SIG will not
> assign 0x1e98 to any other vendor.
> 
> So IMO we should add "#define PCI_VENDOR_ID_CXL 0x1e98" so that if we
> ever *do* see such an assignment, we'll be more likely to flag it as
> an issue.

Agree.

