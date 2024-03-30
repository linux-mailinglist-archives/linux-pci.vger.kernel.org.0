Return-Path: <linux-pci+bounces-5430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEECC8928B2
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 02:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53526B2242C
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 01:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44321ECC;
	Sat, 30 Mar 2024 01:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JyJlDmdH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6596915A5;
	Sat, 30 Mar 2024 01:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711761331; cv=fail; b=rBB4UbU50M6aQa+2IVJxACvxaEuJS9g6mHmxtlcUjb4FDD4jC+QBDyYfnqbiqooUiKgCZ5brZu6cmJEpkCjgDJIo6onbf8BUTQpKbEfpmV3hyOhHJWXSLc8nChUdOajpgYASgV+fZ3Lc8c50ruujlDfuqZUd+dSdsJjyAVxyc1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711761331; c=relaxed/simple;
	bh=N3uth7Zd5RGGR/NOnC8hb1vonqQwdjkHVahrbeIdNro=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YBWPOw5kWxGQhh+Pk5Gslj17I2uu8Xew3VuzemBVi2aWudjd9w6rrD9JzNEzwKn0K7NhWpfHzopKyEwiXg1T6WFSNeLIS3U2IPksiqX5hm4d4PyJKN5FYAXA6aRq6SvRXozh+laJva49qk//lJfBDNOiq6vKc6/fnY+hjdBykac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JyJlDmdH; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711761329; x=1743297329;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=N3uth7Zd5RGGR/NOnC8hb1vonqQwdjkHVahrbeIdNro=;
  b=JyJlDmdHkFgTRvpCG8rYk6HH3HwbFPVxoyCy0tCqgTqfO2u0OsUIKqO3
   K/QXULeLKw3f5TPJSp3F65+A/J+swOlz2PS3kpblmf1Dqp5ZrvbIZ+RLo
   aBGq8nDs+WrhC86U+cjDEIXmU1p2MoMW2zjWeSBbzfrs2LK1lYixzZNEq
   EB5vkntZ8ZJMN736or1FzU92fLaDK2do4r4if7PIhhRESA53SskPxbOHG
   Xg07dfaJR863cOY98jvSovPRZ8KxF0qyQq8gbGQxFijmtLQKfGrM6d5ZC
   2rfT1jfi3D39qt5/Hm4cCwYctFIfqAVjYTp1lWqD2NkrSSB3Xakhjr46O
   w==;
X-CSE-ConnectionGUID: 3vWZpbtcTw2RpZ4fc2QU+g==
X-CSE-MsgGUID: JTpdJH3LTOq0VLjtq2tmgA==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="7550427"
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="7550427"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 18:15:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="48323217"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Mar 2024 18:15:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 18:15:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Mar 2024 18:15:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 18:15:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GamE7m52T9cTzjyW0xwtsviDDsYmJFu1zveTnftIcy07g1CPLXx2iNpqzHEOdAdr9s275uz+fhRY+P4EM8CKm+YP/nEb+ekffWnPlPH/ja4yMjDdd9XKBn4HypRYsgbkXnOntrnMg+GcxY73aWLu0nD2aeIvP2mmTF/J+DzNJ16WGykut3f6GBrbjJRmXOPZ67JxC1b8FbOLwvvq1zC3VgP7+LQ5EQDDSu1N+YVgyIi3T25shaWXHtVxYEJF3hxcL2AMC99y1KKfASYlmm+vLUOANu9rUOMyaywCRnQPfHOhSJ+oYV/TUtxNoNypumj/2adfznjYLNhey/8HuEcFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ka2IsREiwpP6b0bqNjrwo2etSimU23cOQ9u87lWoVM=;
 b=gXzpuCOtF+1k24W49pLQuyoohMur1aKsVuQ2IXz99/4lsT2Ctpv23z1C2RsQQqCe/wrvv4WDlYQfrrKSTaiLejMo8pxo2kfupsOha5Llld8Y/T+nW+JdwSfSmu1f6pRLzUU6sR2v/ellohKCQs2TuuOAwNbJrhec2vdSnVC2+Uq3esD6KM+Jnlhu3rT29wzY2VShq5Hq+1k6Cjj/Gt+5ta/yA8bo9ZJCJbGCFsZFuWztgf3ubl9tOt3GcgK1dTetjXWQtyD9jER4enIf2zG37/vNkxG+ObII7KDd/gv7UnQnUGLckhdTkc3on7gPqyx+RtijVIphfh3/Qin5DDyVQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6735.namprd11.prod.outlook.com (2603:10b6:806:25e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Sat, 30 Mar
 2024 01:15:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Sat, 30 Mar 2024
 01:15:26 +0000
Date: Fri, 29 Mar 2024 18:15:23 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>, "Kobayashi,Daisuke"
	<kobayashi.da-06@fujitsu.com>
CC: <linux-cxl@vger.kernel.org>, <y-goto@fujitsu.com>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 3/3] Add function to display cxl1.1 device link status
Message-ID: <660767abc418d_19e0294c7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
 <20240312080559.14904-4-kobayashi.da-06@fujitsu.com>
 <mj+md-20240329.221545.11188.nikam@ucw.cz>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mj+md-20240329.221545.11188.nikam@ucw.cz>
X-ClientProxiedBy: MW4P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6735:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ej3u0qSEISx552aWAe0Nxu01Vi7aEIISSVjQpETDLEXdfHgnYOoNbJCndveVIW4Qb/wHcpZ+IZQDwvpCDJV+bp/d2MBXgHjnGUUA31jMwabufKIRleyJi6OquTy4GHIqhdMeM37hqOpTxQ3LENdSPObJ8rfd12TeM/tvJPZwtb6hHb1IbEt2BKyfzC7hnb+oqe13kbmaHsHr2bJpFJxhSFaNSL4/bHZURys2/EtmsQ+x5S7q1r8QY7xsT1/4SOuUHh51N//JRJRpIG9WZFZmckoHLSw9KEy6kR3eZqbCy+1HK4Q5I448cTUTD1XBgIChSku1BPjBeKpxnsBO7TkV8EF7I4Nzv1YyffTkvZ/YexcEqRjbnFxjq3dxRnJ/8jJU8+wJ2Vmi3ia6URAagXiRQ8K5G2COutw8cb6cNl52Px8D2t+TrmGPK8dSooKarRkhByZbZ+0I9dQI6sb2jahlto1OPV8gVvMOfQJ08ttANiD/0V9llnzjOCIy0sqpSZh/T3IFKqnemBKJYkp0x94GL+sKc+MV8iCAh+BLLMW9yFVQ6u+hX7xbO6PDW8qQ7ABXzvecqjq0W3AkdjAu/PaVzr3z2Am9i1F8h53yfczTGg1RZHxjCKdpnAlxdVwgVOoO4hTW0STlx0EO1qS5DGJaIfel0Emp38NZs/Fy/H4NTOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z24zckRjL3JxbW1wZjExYTIreXk2S2F2SU9neHpMS29lVjUwNDBHUVNFTFRI?=
 =?utf-8?B?d3A3TUhKZHFDSFJmUE0ySnllTkJjMnl4MVVaenFFRFdWN0wvazNnOTBtZXha?=
 =?utf-8?B?MHRrNjliTkpyaTFvOE5QYTlaam5wQksrWDRtdlVGbHVuK1dHemdpVDRiMUdR?=
 =?utf-8?B?SHI2QmVFMHU5Q0RWSDgvTFJSbFRUY2RlZnlkYkIzWVJaY2krWmZjRDZsaEZh?=
 =?utf-8?B?OUJCUkZNbmppb1Z6N3lsRGFYRzY4TUpRcHhhdmJEQmREU2hZMVdycTgxVFRh?=
 =?utf-8?B?Vi9sT2M0RTBlMUFISnVIYUZhWGVEdlNoWlFwaHB6Z0xabWdVQmUrbmxaZWhx?=
 =?utf-8?B?ekdFa3Uxek9IMzFiZ1lEMFhzcXF5K3FHWUtVdCtqelVOaktzZGI0SXA1RXEw?=
 =?utf-8?B?RXRWUU1QZ0hiOVZhWXpHUStnR3BSM0JzYjdKVnZOeHBISGR0U2h1d2k4ZmQ4?=
 =?utf-8?B?YXBIdGo2U08rcHdsMDNUMXFFU2gwb0x2MHFTM3VWSjZFZytVdVQ3ai9samhI?=
 =?utf-8?B?bURSbU9ON1dNc0ltS1VRWW0yVXhlUmVCQVB0TXRhVGVtdEY4YU5LMzN3d29B?=
 =?utf-8?B?QlhIMWh1V2N2UXBEcXdqaTdINFVoRkRDQ3NNbEl6elgxVlp6cUgyS3Ezd0hh?=
 =?utf-8?B?UXFJbnRKLzJXR3BhV3V3dGtaa0tGUXFPOE5Lb0FuYWZqNS9zMCtvSlpHN0VY?=
 =?utf-8?B?V1YxdSs2a2V2L0doeE04cDB5UVVDNGplUnQza1kza0FBdllicHd3c1pwS2ta?=
 =?utf-8?B?djh2VjFFTy9YVkNvaTQzV3FmcFowU09RRmxQRTlhZ0p0dmd1MG9tNFNYQjl6?=
 =?utf-8?B?NmRlS3dUSmlQWnhOTzlzV0N1TW9vMUJadkhhVzJaRW5TME9Mc0M3MitNR2JC?=
 =?utf-8?B?aUNtWGhRZkNneEk0Y1BWY2lZS1F1Z1Q2Z2lWejFZb28rd1hwM1dIbzFJUXBY?=
 =?utf-8?B?eFJneFpncVNjODZGTTJxM01wWE1ySnExUUFLUkM5S012Ni8vYjZYL3Fqbjht?=
 =?utf-8?B?U2x6OUxKWHF0WWxYNngwSGV2QW5BRFZST1VnaEpGZm5jYUo2SGl0WjRBQ2RY?=
 =?utf-8?B?UHhwYkNvWldqbDdVd2xiejlla1lsOVRpNnNSaFY0dHhLbCtQdStxNVl2V2ti?=
 =?utf-8?B?ekwvaHcrVGpzWGxiMjNmZk5reWFaNjhJV0JXTUd2T3ROOUhMZmh3ODhEaHBG?=
 =?utf-8?B?R2pJYjlRMmFmd1JxTmNDYU1pdzUzVjc1bFdPVklMZFFNUGJmdnNGRHRVZU1R?=
 =?utf-8?B?bjdmV3BrQi9uS1o1YW5kMHpzZnFGcGt5cXdFZmU5OERVTUVBVGs5RXdxM2hR?=
 =?utf-8?B?WDliM2wrNGcvazBmU2RzaUp4M2tZeExKY05NMzU3OUpoZEVQc3V3TkpnRWg2?=
 =?utf-8?B?SEp6OW1yTWdaSjVhWmxkTEh0ZFdvSjVIb0V5NTJESmRLdUMzNVFqYjRYb2RC?=
 =?utf-8?B?Qi9Ja2NJbVJxVnEvbnQzL0FlTHRUQU1GczB1RXBuczd5bGlOZ1czUVR6RGpz?=
 =?utf-8?B?L1RSaGVKUFpDeEpmN0RhQ0hsb1dHV0UvWHNGZ1BxODhqZC9JVnNLTitCdFIx?=
 =?utf-8?B?akF1bXc0c3ZVWGVSOEFsS3lsSUtGdDRBUDBxcjRJUEx3SEJiV2g0UkVyWTZx?=
 =?utf-8?B?UHFkamN3dURvdmlTQ1BVOXA0QVlSR242ZXllczV4VVhUUFdlVDE0cXhqMUVJ?=
 =?utf-8?B?RG02SVp0V1VKVU5jWlRobTJIMFZaUFFoQk9uMGNHeXpFbHhHcUY4UjI0YW1n?=
 =?utf-8?B?ZHV6SDdxUDJZam1KSzlsb1NHRkpHL0ZqbnFUWXNKdnNiNVBUb0xISytnM2FT?=
 =?utf-8?B?YjZQZEpOSmtldkxrSDVuSzRGWHRneFVMZzNsMSt5L0l2SUJWQ0xMUm5rWXNj?=
 =?utf-8?B?Yk8xMHhVZVRmRlZLdGNkOGRUVG00M3dYY3BPalkrTHE2TENmK0pNTkc4NWhK?=
 =?utf-8?B?TTRYaUl5clRGdFVvUnBkc29XQ2ZscHBQcnVZN0FDR1VJK1hvVEVDSDZVdW5N?=
 =?utf-8?B?ZXBOY1A3YWFHRnZ1R2dteG43N0pkNEMwQStGWDJ0TWNJSlVFbFp1Z3pWcjND?=
 =?utf-8?B?MUExMnllY3l4MytsZnBWK0FsaUNpbHJ6TERQc0tqVG9KazhqMlFrQmpSM1lh?=
 =?utf-8?B?aWhLQkMxM1dQa3IzbVQ1STgrS0RYWU43N3ZBeHpvbXVIcHlwTTYvUGtFd0Ry?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f804ab-701e-46ea-04fa-08dc5056e18d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2024 01:15:26.2609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqL7p1C8DDdzX5Z9hSTuvLzqqPm8Js7gdTUJzgblicaSVncw6HTVYQz0BpXmpOfbfAeNQzicv/sZc8pvypDIk+VDmz1xkt0VWmWNACWiuLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6735
X-OriginatorOrg: intel.com

Martin Mareš wrote:
[..]
> 
> This really is not the right place to read from sysfs. The libpci should provide
> a backend-indepenent interface for reading this information and the sysfs
> back-end (lib/sysfs.c) should provide one implementation of this interface.
> 
> I think that we can easily extend pci_fill_info() and add another PCI_FILL_xxx
> flag for CXL RCD properties, which will be available in struct pci_dev (beware
> that new fields have to be added _after_ all public fields to keep ABI compatibility).
> 
> > @@ -1445,6 +1515,9 @@ cap_express(struct device *d, int where, int cap)
> >    cap_express_dev(d, where, type);
> >    if (link)
> >      cap_express_link(d, where, type);
> > +  else if (type == PCI_EXP_TYPE_ROOT_INT_EP)
> > +    cap_express_link_rcd(d);
> > +   
> >    if (slot)
> >      cap_express_slot(d, where);
> >    if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_ROOT_EC)
> 
> Does it make sense to look up CXL RCD information for all PCIe devices of type
> PCI_EXP_TYPE_ROOT_INT_EP? Shouldn't it be done only for devices with the CXL
> capability?

I think so, would this fit more naturally in pci_scan_caps() with a new
scan for DVSEC caps ("PCI_EXT_CAP_ID_DVSEC" in Linux). However, isn't
the trouble that this needs a DVSEC scan for CXL to know it needs to go
back and fill in details that normally in appear in the base PCIe
capability scan?

