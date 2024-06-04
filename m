Return-Path: <linux-pci+bounces-8260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D738FBB1F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 20:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC0F1C2091A
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 18:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E2D148853;
	Tue,  4 Jun 2024 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJ6llvBx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C087B18635;
	Tue,  4 Jun 2024 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524072; cv=fail; b=R8pP8ZCp7l4L4S3Pygc9LOxCVQYVusQ3bV2V5n+Jea7n3lpIJExLi0jaND0uAUL66Upph+eraNRRbiKC3CC49Xf6YYV0jXULRa015LajsodTNrgnIdDpjrgIUMDZkUAGA6hZKvnQcHSY9QD0ULSSn7op4ohUrMumSR+waSO0sZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524072; c=relaxed/simple;
	bh=TQYjePugP+IAeeJz172TuPM9XuHWr6bkLno4A3mp/qM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jCIuZ5A+3tLX6yCcLvX9OMxC/t4KvGacTpclhb3uHmMQ+tTGFOxmW4taW/PK0qHj+UKRFLdNxAfmBe1CytGlqpCH1UXKHPNlGmumTd2nfArSGHRxK9m8eQ1RwZvLfxMGwQzCHAAlnyRy2UQsMo+ZiyOclr6Ho1hRrjPc4Q6c2qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJ6llvBx; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717524071; x=1749060071;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TQYjePugP+IAeeJz172TuPM9XuHWr6bkLno4A3mp/qM=;
  b=CJ6llvBx+C9Z5fjltQfma6JfHhzGzwglTqNZY7/F0J/pUhDpl84t/xhi
   TKsp2PpqqOOciRX/hM7AAcktiEe7R1BGnHW+oihtw/BW6yzLJ/0iFVc7D
   n1Re+Or1oaPekQIncy3i5FyhfYOCpa9XsDDeFzTq3UWdK/62U+KoFjeI+
   km/iCGi4pvjrVad0ACFhW+2lK6m6s+6XiTwGyaaSgZinz2OEW5I2G05Hg
   DrfvD+wSZfdUs+Ix9nvgaXNppzVvb9nckrByY75dvaSI3Abb2P7teA+aP
   IN9ODYoJqnxiTro3VtDD4X5s45Iay72IYQdbaIo7kMA1CgwGrNdoRyJhI
   Q==;
X-CSE-ConnectionGUID: MFoYKDLPTOyyA/o9+TMYMA==
X-CSE-MsgGUID: 4ViTvQCnQd6qMbM7XPPlcA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13930038"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="13930038"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 11:01:08 -0700
X-CSE-ConnectionGUID: oHaeQYPZTcu3dlKFHHhxpg==
X-CSE-MsgGUID: EAqtyuzuTZeYWRtXR9+kFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37316072"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 11:01:08 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 11:01:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 11:01:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 11:01:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvh+GTJf3Ts5JwkcDDu3wFsVQPdtgpqNGuZv7iMOVLPtusUKu0ixvs9Ko1/+oTSNSNUWT3ZExJelRvEi++DtTEQq7zOoNoDQT2eMjza5vlb6qqif4aM8xxP0SF340zHOwSSkDD/KbXumlQlVARjFHwv6FnFcCXFjGUlJrTvPOs69xhPrPExrlte60aPFUV03UvG/AX8mDL6w3lX9lLqGg71GXoOsRYzj3L4iAzJC6NdeA++sxNmFWlX8zaEkCettSqTSU1hysiY5EkOthDYQK4o1KPsDbefZ/E7I2suUtngY5ypW0Fde925OLJ+Pg21JtOVYf3GHdzd1UHxx6kgStQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0QNSjXuoIWpA9rtlfFLP+V4RQVgUAjEJ5WFdmPO32c=;
 b=R9t9Xqn0PyLZy859Me1JtY45aGa/WnSsQaei5Q9aUniWOyOiKvvL5mfIQK6KMPsvQTzfM7hBZDTBd3jWqgBhv6R9Dj/bAL2WnzmBr6+Em9kfpPf4Ig/vFQU6SKswFb3AjyCu4ckoNv9Sh/61NAmGZDdHScJeME5JHB8HNYqPY+iX1n4I7lVmZTZ4QltYozPZJibOQROj07OcsJ8ZggvXKea8yhV0ARDgyY23u9Tr3PI5uo/XMwBozSRr5JF+dO25+90kYKT5l3Bja9HssXzMkeN0YBCgwLV/3kDiWf494TgnaTBXDpI+IbsUANzE0H3WwOSAeVuyXtBQ5rDBD2EPTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by IA1PR11MB7853.namprd11.prod.outlook.com (2603:10b6:208:3f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Tue, 4 Jun
 2024 18:01:02 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::6e1a:9fd8:2300:d3f9]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::6e1a:9fd8:2300:d3f9%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 18:01:02 +0000
Message-ID: <c1885394-9edf-47a7-a4f8-1e456ba52316@intel.com>
Date: Tue, 4 Jun 2024 11:00:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: vmd: Create domain symlink before
 pci_bus_add_devices()
To: Jiwei Sun <sjiwei@163.com>, <nirmal.patel@linux.intel.com>,
	<jonathan.derrick@linux.dev>
CC: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sunjw10@lenovo.com>, <ahuang12@lenovo.com>
References: <20240604135153.9182-1-sjiwei@163.com>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20240604135153.9182-1-sjiwei@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::14) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|IA1PR11MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: e03c148a-e009-4808-33e3-08dc84c04c26
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTlQUndCWW92UlV6L01nc1ExeTRCVmJKN1BEdzRMQVo1U09JQnZxeGhPY1VY?=
 =?utf-8?B?aCtEbTNNdUttbEtpQUtkQmQ0bHpXbGN2M2Y5ZWRpeDJScHpZOTJFVGJ1dHY0?=
 =?utf-8?B?VHNIS3k5aVBmSTVCRjVmQlhrKzhPUWQwS0k0VHBqUmlRRzBhY3ZrNzJpMmJH?=
 =?utf-8?B?aGxwYWt2eHoxK1hQZFhjbGpoNWFVMjBnSUtuVGFGVDBIVlpWVDdFWmluMXhQ?=
 =?utf-8?B?QXFNUklLYUpIZkwvSUtoL2ZxRHAyN3N4eDFTdlBITWJxazVycENMWlJydzZk?=
 =?utf-8?B?UkdqaW5SS25vSmhNYmUzdHVoTU1IRHo5QVV0eDJIaE9pUUx0alMxRkRlZTE2?=
 =?utf-8?B?V2RrSWNFcHZEOStXQ2dPRVFpRmh2Qkp0eWZoZ0d1ZGplYnplYU1XVlNKWm9K?=
 =?utf-8?B?eHltekprclNWNHV4L1k1emN0MVJ1dExRSUI0RExhdjk2em83L1VJbnRaa2NK?=
 =?utf-8?B?Yi95YjZpU1UrN096eGlhWGdMTjk4TnhuRE1XdTJYdUhuU3cyQnliN3p5d2tR?=
 =?utf-8?B?QWQvRDdTWjAwemIyTFQwSHNLV0RFMmU3QjM0YmdqZFhjZ3ZjRGtrU0x1ckQ0?=
 =?utf-8?B?dHZOdUpDZmdtZCtxSXdYOTFRclhtV1VGR3FIMXJFSEJEbkEzQWsvaEU2SUY1?=
 =?utf-8?B?cHFZYmNWL2J3OXY0bTNjSU1lN0tTSDBIRXpJeEp4ZWh1cmRpOFRaYVpmV2VL?=
 =?utf-8?B?MFZKQ1lGRjJPeGtIaEhSMVlNZ2FLSy9CN2ZlcUpjODdMVXdKT29zckdPU2ZV?=
 =?utf-8?B?KzI1Q3ZqdkM5L1N5SXRPQlhzeVRNdjJ0UUFrd0R4emFxc3FWQ1hNdUVyc1V5?=
 =?utf-8?B?Q1FmK0ZVSG05bkZzejlDNm81aHNGMk5UVFlTZ1Ryc205OS9Wekh5ZEkvRVVH?=
 =?utf-8?B?MU5WMHZaaG9HMWNJc0dCSyt5WEVPWm51OXROR0Eva2RuV1RCQmFzYW1sNThN?=
 =?utf-8?B?S3d3dzlWQkNyeDhwZGVJcmpzb0xOVzR0c3B2TjhENVE0cXAxZGlyMlEyQ200?=
 =?utf-8?B?bHVrUkRYODBvZnpkb3h1UlF1dFhrMFVqc051SXpzbEQvTmtxaC9mdWNMc21H?=
 =?utf-8?B?SUxoUWRjRE5QcHNwaEt4NkVjT3VPSmYwMlh0bTJKcnd6aHpWcjlPR1o5cTFv?=
 =?utf-8?B?aFNrQlV3Y1QrWHRuaFltNkNDTURMOCtpVW1ZK1VYNWI1ZTRWSytqZEVySmMv?=
 =?utf-8?B?b0VEQmthaGRQeW5rQTU1NDA2UWg2QmRmVVZMQktZcEpqU25HR09tUUtjeVVs?=
 =?utf-8?B?eDI0M2wxa2xwZVExTDMzVmVYRTUxRlVwMjN0REIvSkZZNXZEeC9TL3hTSmQ3?=
 =?utf-8?B?RlZvcXJLSWhwRWhTano2WDVOYWJFN1cyYWo0empzSDN1bVVjc2k1ajVabFBz?=
 =?utf-8?B?VTZvWUNlNFh2SWdYdHhWdzM3QnMyT1A5OHAxUzQycVhBTGhvdzVjSExPUUpu?=
 =?utf-8?B?NCs2RVJ3NGtGLzdvR2hoUUMxQzd4SW5NMGZlRU5tdmJKRmR4Y3VzZ2dLZXZn?=
 =?utf-8?B?eUJVQmVvU1NwWVhJRVQxMGpmTVhCYmQ5K0lpTU5LMnF0NWVGc3lGU0R2bkRq?=
 =?utf-8?B?SE1OVlNnVjFRSmxRL3FEUHN6QXNNTWVLWWZCTVVkMUwyK0dhRnNJOEd4cGlh?=
 =?utf-8?B?OTlVc0p1SVZZb2FWdjZSNTBIZTBBSUdhZlJpNll0OFVVQmRoem4xeGlqc1Er?=
 =?utf-8?B?N3JEN1E3bk9PZ0xqKzhuNXdmeGs0Qjh0WWRjSUlBeFhNa092V0w0UWNnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUIwUE92Y1lnK3N4TDZLbkExYWJEc3BwcVd1aXQwaFRPL2liSS8xNUpDaC9r?=
 =?utf-8?B?SGFOQlQzR0d5bnNTSlNUT2R4bkkzN1ZPeTBiV3d5SHJEcjBsVkNGWVFJbkdY?=
 =?utf-8?B?N3VWVERpRTVjaGtSSzlGMnBIU2ZORmg0cnBocDl4SzFaY0YyS1B2Z1R5OCtF?=
 =?utf-8?B?elA3SjhFaFRwbkFmTnd4YkVjV0dIbjFmbjNKSG1FM1dpNk1yK095ZnNQeTRO?=
 =?utf-8?B?TnNZQk9qUUN2NTYzdkpqa2p0QWhzWHpETlNCa3pKdmQvMnlucit1ZTl0UG1k?=
 =?utf-8?B?dkgyaFM4dFZERjdGWGFaTzlmSlhqUnErL3JFOHVMSGpiN2lDMlJlMUlKL0l0?=
 =?utf-8?B?SFY3VVRZU1FGQUxCaEtUN05EMFY2UkRyMVlJYm5TeDlUWU5URnhISGtXNy80?=
 =?utf-8?B?cXhEcTRIR0wxMW5OYjAyUXZqWUtzZ3lmM01CZHNFUm96UjlTSHlOa1lNaTlz?=
 =?utf-8?B?dGU2bElHSjJYZlBXTDdPSVFmK1RXbmZ6K01VMDJybHJvOGRoWEFQWHQ5NzJF?=
 =?utf-8?B?ZTMxbHBvZlc5MUdVbXNQUGNXamtKNkg4YmVjNDZjZnJiaFVVdTVHUi9wRVJX?=
 =?utf-8?B?dDJqZXN3RWtpeWFVYk92LzVFbG4ycEYvbnFXTzdkZmo3b0JHRHlnOGx1OE1Q?=
 =?utf-8?B?MnJ2ZmJ1bElmMXh1L2xGR01NOEprMmswZ2ZPOXlCLy9ucWYvUU1KM1FQYzZo?=
 =?utf-8?B?VDJMVGd3REdIUEh5L24wdmFvSHpaZnVSNFpoY0FGMFZHMHhhUzJuVDk3alll?=
 =?utf-8?B?YkIvdmNwbExnOURFNGFCSUE1amZvckhwNWFaQVNuMXUxdFFING54Sng4ZjBl?=
 =?utf-8?B?bDdwdDkxcnVoTS8zT3FOMStLMXF3Q0RBOVJIUXFRUmFtR3VzQ0x3ZmFRU0ZH?=
 =?utf-8?B?SnAvYXhMMDJyYnhwSENxMm81V1kzSDBiS0V6dnZCWlhscDFFajREaUoyeXRH?=
 =?utf-8?B?SW1ZbzZsNGRzVXJRT2w1NDBZTHk5UlhNOVF2WDdScGUxc1FDL3ZpMnZsclBB?=
 =?utf-8?B?TktTWnZKM2pBUkV6SVczc2FWaEFDT0FNMjNBdTdhcFRsTmlJcmxIODI2Sk5k?=
 =?utf-8?B?NVJONWI1OVFnVCtTK09MUDhwVHRVS2ZiMGtGS05Ba3dBbWwvMFBRSFBmOCtE?=
 =?utf-8?B?NUY5Um5vbk9yNlV6R2FJVXNDcXBLM3k0ay9IZzhoYTdRN1lGM1NZRVBxRTVJ?=
 =?utf-8?B?NG14RTJNbXNKNi9SNDBrL2s0QnJCbFRqVTYzMVJ6U3JMTkRzMS91ZmcySXND?=
 =?utf-8?B?NGp6TTFXeTNsK01PdEdiYnVHZlQrd0preEFpcVJJb1pVN05QakFweUM5WVRF?=
 =?utf-8?B?UDdVSldvUGJKemNHdVJvY0RMZ0w1Y3VYRHdxRG9ZV0doS3I1UUYyYUxoWEg4?=
 =?utf-8?B?NzY5a3pNUHZnZTFzdWY4K0ZTRmNHWlYydXJqc1l1M0o3b1RXdC9hbGZDeFhB?=
 =?utf-8?B?aFh3WGpVNGxJY2JnNUd3OTAydzdvODlvTEorT0NCb3ZtWC92QWcxdkFPOXI2?=
 =?utf-8?B?eWNKWkhqazRLcS9ucXVHOWxsckhKeTViaXo4Y1lxZWxqTzhqbXVtTjZwZG5W?=
 =?utf-8?B?aFp1NDI3WVVnR2Vaa0tDb3NhdkxsVENlWVFNMUlxT2c5L1ZoTXJySzJnZjEv?=
 =?utf-8?B?WnBpK3NKSlM4enZGeGVraEQwY0ZiaFA2S2Y2KzEzUVdpMktSTmtaeG0rYWUr?=
 =?utf-8?B?TTFZeFJ5eCt2WFpoWXhOZ1VvTmZGM29MQ0o1TmQ4OXA1NVdGL01wTWk5bVZZ?=
 =?utf-8?B?TFQ4bzVXT1NkbGdxclRHdy9nQkp3eDlzb2hQUktpTUYzcmlOc0JPWlk1WDRi?=
 =?utf-8?B?Y0IySWVsOWtJVHZOR1VaamxpQ0ZlVWN2Mk4zdFF5RGJtTGcxaVJoR01hMFFu?=
 =?utf-8?B?L0ZYcjROZnEwLzgyMkhCM3p4ejI5VVZScUszdmd6ZDN4VVZyNDNmMDZDWk93?=
 =?utf-8?B?WVE3UTZIeWdpbGZyUTZ3bk9EWjl0em5oYVhkaTBrY0RVb2l1dEpPWTkwVWZR?=
 =?utf-8?B?L1lCTTRzSmxlanRRcStaR2hvWU1TQUlKZXhBbmxwaWs1NndnYXBWTmU4NVFs?=
 =?utf-8?B?clhGWFp0ajlnYWJVLzNUc0s2OTlvdFJaSll0Z2I3UlJ1UTJPTi9OTnYvMzJJ?=
 =?utf-8?B?Zi9RTW00ckgwa1NTdjhKM1ZFYysyRFpoS2pkZzBLYUpnNUpzUGlOMVZ1Y053?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e03c148a-e009-4808-33e3-08dc84c04c26
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 18:01:02.8114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5R2htJvoz7BWOvBKi2mUC+w1rG+7eijoxR3eVkp5/7sJnww6qzZAaDAfk2Jf9bRmV4tkL6f+bLQepdi1/jtheO5EOVjMbSJWEkaJa9shXEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7853
X-OriginatorOrg: intel.com

On 6/4/2024 6:51 AM, Jiwei Sun wrote:
> From: Jiwei Sun <sunjw10@lenovo.com>
> 
> During booting into the kernel, the following error message appears:
> 
>    (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: Unable to get real path for '/sys/bus/pci/drivers/vmd/0000:c7:00.5/domain/device''
>    (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: /dev/nvme1n1 is not attached to Intel(R) RAID controller.'
>    (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: No OROM/EFI properties for /dev/nvme1n1'
>    (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: no RAID superblock on /dev/nvme1n1.'
>    (udev-worker)[2149]: nvme1n1: Process '/sbin/mdadm -I /dev/nvme1n1' failed with exit code 1.
> 
> This symptom prevents the OS from booting successfully.
> 
> After a NVMe disk is probed/added by the nvme driver, the udevd executes
> some rule scripts by invoking mdadm command to detect if there is a
> mdraid associated with this NVMe disk. The mdadm determines if one
> NVMe devce is connected to a particular VMD domain by checking the
> domain symlink. Here is the root cause:
> 
> Thread A                   Thread B             Thread mdadm
> vmd_enable_domain
>    pci_bus_add_devices
>      __driver_probe_device
>       ...
>       work_on_cpu
>         schedule_work_on
>         : wakeup Thread B
>                             nvme_probe
>                             : wakeup scan_work
>                               to scan nvme disk
>                               and add nvme disk
>                               then wakeup udevd
>                                                  : udevd executes
>                                                    mdadm command
>         flush_work                               main
>         : wait for nvme_probe done                ...
>      __driver_probe_device                        find_driver_devices
>      : probe next nvme device                     : 1) Detect the domain
>      ...                                            symlink; 2) Find the
>      ...                                            domain symlink from
>      ...                                            vmd sysfs; 3) The
>      ...                                            domain symlink is not
>      ...                                            created yet, failed
>    sysfs_create_link
>    : create domain symlink
> 
> sysfs_create_link() is invoked at the end of vmd_enable_domain().
> However, this implementation introduces a timing issue, where mdadm
> might fail to retrieve the vmd symlink path because the symlink has not
> been created yet.
> 
> Fix the issue by creating VMD domain symlinks before invoking
> pci_bus_add_devices().
> 
> Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
> Suggested-by: Adrian Huang <ahuang12@lenovo.com>
> ---
> v2 changes:
>   - Add "()" after function names in subject and commit log
>   - Move sysfs_create_link() after vmd_attach_resources()
> 
> ---
>   drivers/pci/controller/vmd.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 87b7856f375a..d0e33e798bb9 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -925,6 +925,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>   		dev_set_msi_domain(&vmd->bus->dev,
>   				   dev_get_msi_domain(&vmd->dev->dev));
>   
> +	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
> +			       "domain"), "Can't create symlink to domain\n");
> +

I think you should move the sysfs_remove_link() line in vmd_remove() 
down as well.

Paul

>   	vmd_acpi_begin();
>   
>   	pci_scan_child_bus(vmd->bus);
> @@ -964,9 +967,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>   	pci_bus_add_devices(vmd->bus);
>   
>   	vmd_acpi_end();
> -
> -	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
> -			       "domain"), "Can't create symlink to domain\n");
>   	return 0;
>   }
>   


