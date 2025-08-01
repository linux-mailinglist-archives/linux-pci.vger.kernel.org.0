Return-Path: <linux-pci+bounces-33316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A76BB188A5
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 23:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2C21C221FE
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 21:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C507F1E5B72;
	Fri,  1 Aug 2025 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZiNPeIf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1DE28D8F5;
	Fri,  1 Aug 2025 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754083203; cv=fail; b=myKDaPDa45JwoEtzYOLP5ObxUlwdeR5/VyPms9yihWX0yxBpmfMHFVtAQGpAJmO6f5aBId8jhrWJvzpAj4XI+0f16lcnVrjQ+CWvHPLxGvG4NsAAHnlq3zBEzj4GLjQMtbEH0BRQNx4mcW4MbFTtpZx+KW6U/0TJoZyUC8voXz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754083203; c=relaxed/simple;
	bh=JxGp6z+q+KN/YmKLr+h+s0ssb+NNLmryEEzRpuTQ9yY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=VtoCazbeJptI2a4P06ODVsA77Mml7hQxIQE5KqCFil9ebJe/MTxqS0j/lHdOd4CsSN+gvwfr2rXWFkwCNx8p24hvjAhFvAivDh1a6mBfOcbeKyzG/Jqcik39MQ9CtjWlidalhZxbG4h+A+1Azwu3k3bQcP8Hy2a7HQt5D6nXkDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZiNPeIf; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754083201; x=1785619201;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=JxGp6z+q+KN/YmKLr+h+s0ssb+NNLmryEEzRpuTQ9yY=;
  b=GZiNPeIfFkUh1mCBxBul+N5In26xyrW2vuf7yt/XZg1aveDS+EkFzDo1
   HEgtmnTy1zHl5ng1+smSjpxoxbmnyLB/5+qAMs2k/iKfbFXhpmEW1v1ZL
   HZYzTpoqwKh6fZKu/kIR5BpdbN7VgIUimcxyoKklj8vBzyWpPjUpV8ZiP
   6aBUVFq00eV4vQs9Ulw4qw1iQFvxRFaHewMO7Fk6FdyBSMO2ploVFixb6
   Z61I0ohiwnRhp8AXhFwnL9bHm1QkkNYPx/JIOvRZANbIU0cBx8QPEDHw6
   6+GffPbg+UiQ0MI3PTsyjoGjXgsHcdVu4h94a1PEqCvL0Fmx8lL2pkqmP
   w==;
X-CSE-ConnectionGUID: myi3bzDuSwmhYoftrBgwdg==
X-CSE-MsgGUID: 3T3sx7mATeuhGwXb6JJUmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="55498187"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="55498187"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 14:20:00 -0700
X-CSE-ConnectionGUID: xlv+Vbv6REaSCuPhpVeeQQ==
X-CSE-MsgGUID: KVyKhPh2TayBSzffu6Ehdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="164005485"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 14:20:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 14:19:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 1 Aug 2025 14:19:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.57) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 14:19:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqHx7cmfIBwWlhIGDwguNqrB+/Oghf7sseQs0jS/PXxNiC+xtTPC82JF7YCCzjMGxrDAzgsFmLPSHKOpAGlDPt4KFWMEM4wnq1WI158QIaYVtsMJUBreBRA+FtefarcrlJ9FJ4meNxnbbbUerHGGAgn7MLC0xhqjXad0LEqWUnb6NRNmLqf3ggYPbk4kqdKo5ckg0i2hw330rWRqL+I0uNJUykB+S9h8QpAQOCfZMuW3Ik8MVdU61STQdNMSUEdsO20d3/ZuyTcLE0VSt9JeAoqH04hIJS8bmqzPBrYtodpAh00ZhFVda36zI5Xj9TC+W1mBB3ro6PxtHkJHpB+2iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5ZEhmyXhW6T7jioSuHD2gbc1fNenU9GgpD4tiqA2TI=;
 b=jCG/MHawRbhya+W6D8x0zkY16V+BLg0IDxUMfPFfKWcvx72ygnjjpJGQh6wI8m+AF01pR1VocyF0uzI+mL+tn0P+tG2lAoAnL24pPNit9lILNw/TCVXNBU77ZCmnE8OYCwmaYd2v1VZxsmH9JPX2AWwjCy/15ZnxBQI/7Y/2fquiESRCR8rkT7XmHhlAGL2Oyp4cBGlRFcfac5H50GVC9jp39luoIeWv16M7sTtfj+dDHVPfUQS/fAS2vNiTL74lUp4ZC14nTkIbhqPQ0/KI3ZL/r17CILjenHB1sTNbGBUzkn7l9EDtvPxlKIDfHRXIMCM0PsEmbHqRoWuw2JWqvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7432.namprd11.prod.outlook.com (2603:10b6:510:272::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 21:19:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8989.010; Fri, 1 Aug 2025
 21:19:56 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 1 Aug 2025 14:19:54 -0700
To: Jason Gunthorpe <jgg@ziepe.ca>, <dan.j.williams@intel.com>
CC: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	<linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	"Steven Price" <steven.price@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, "Marc Zyngier" <maz@kernel.org>, Will Deacon
	<will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Message-ID: <688d2f7ac39ce_cff9910024@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250801155104.GC26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <688c2155849a2_cff99100dd@dwillia2-xfh.jf.intel.com.notmuch>
 <20250801155104.GC26511@ziepe.ca>
Subject: Re: [RFC PATCH v1 00/38] ARM CCA Device Assignment support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f5d8a1-acfc-43f7-18c9-08ddd1412a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmFHQU1nTEpkMldzZ215amNmV25aN0h5dStnNWtMSHhSWHNoUG1vaHAvVVFS?=
 =?utf-8?B?ZEpVZ0kxWE45R29ycWs2OERVbjF1K3U5aGxtT25ZMjRKWTBzZzhWSVA1NEg0?=
 =?utf-8?B?Tk5YTm9KVmFHQjNVTG9ZU1VNNWpDMkl3UjRCQ1BFR3A5RDZ1cStwcGt5dHRT?=
 =?utf-8?B?Qm1VZHRBUEY0aG5BaTFqZUJTNVhFdTQ1QmRrOVdmQ2Y1VDFMeXZUY29pSGtK?=
 =?utf-8?B?TktaNjFmL2k2SUVtYklTSVE5YXVMbitBVEFvNHh2eW1aNXFQNWlSa3U3akdG?=
 =?utf-8?B?dDdESW1SWENYd0JqbTBMMlh6QUY2cWlFQktRNEUxcWF5MmZtb09sVHk4bGJF?=
 =?utf-8?B?RnZmZXlyMlJrMUFEbHhWZkFNMTZab0djbmpKbEJCSkZIbFpBaVZQZzNFcStP?=
 =?utf-8?B?T1FQSGxKVFlHakgzTWVTYkUxbUQ4VDAxTnorME1SWElMMXFiMDlNMXI1dHF2?=
 =?utf-8?B?aTJncnU5REp6YmpDa1Z1YnZjWmRXcE4xSmZpbG1iZnNPbGJiUHBiRWRKZ0o0?=
 =?utf-8?B?bUJkeGhTY2grS3ArT1pGMW5TSXNYekovRm44MEJjZ0d4NEdCSEdjQU5VeXF6?=
 =?utf-8?B?QVFacTBtQkJ2S01OVEdwb3BDY01qdklKRlhEcHJZK2JMWGdXeHcraVVKdnlU?=
 =?utf-8?B?WTQrVzBKSDZpMEFrWVhMc0QweXlRVFVPWEhYREY1aWZTSS9ncXhzK1hHNi82?=
 =?utf-8?B?L3FuY1Y1RUVCazAvNitHUUF6VTJGUWVaVTF6Z3FDelc3VU44YldSZnBGMDk5?=
 =?utf-8?B?a1JyVFMvY0Y2dEV6d3lOeFFBZktKMVI2Qmg0TVBuamRzQldzenNYNFZaeDhq?=
 =?utf-8?B?MXVXQ2RscVdDOUY2T3hSdmVzNHRHeVhkUk1ndCtWMTIzZVcvZFJpaUx3K0kr?=
 =?utf-8?B?RHNlQU12ZkZoY2Z0Ui9FSWFCbmlQbk9Qb0dRUStSOVZXZXRuWWxmU25JT1BR?=
 =?utf-8?B?eFFyS01qSlRXeUhTWGhiZTNsSkRVbG5ZQzJTTVhKdlcweHlEeHRER0xmdnBw?=
 =?utf-8?B?d2MwNVpYN0tUemd4emVHTEpLSFVybmdVY1BhTTBKRDNLa1haazdYcTRONnNR?=
 =?utf-8?B?SWd0aFUyMjdCdVJndGZXT0VBUzNTcWY5S0ZkMEtkai90ZHFTT3ZCVDQvWDF2?=
 =?utf-8?B?RFROOCtSRzZLeThKcmxZM3hsMkt6WEU1bTZla1pPcXZ0UEI4Vmtxd2h3a2Np?=
 =?utf-8?B?NVBMeEZxQTlQSFhNNzdpNElDdGFtaFVlYXN5RkQrOWtscFppZkEyZ2l0ZEhG?=
 =?utf-8?B?N0dzN2RKYWN2M3BhN1FkUk1qT1dqOEFBVW9XVlVFL2o0K0RJQUl6c0F5eGRm?=
 =?utf-8?B?Rm9iblczakVLV1hCb2I5bi9RQ2I3TzNZNjNBWmxaMndDWnVqVU94L3JxbW9M?=
 =?utf-8?B?czJjVG1qaXN6N1Y3UjRqWDJzQUdnRG1LcS90UHVIbXlFaTVTVVhBQU1DcGJK?=
 =?utf-8?B?RS9MbmthMGxueGo0cDduMTRza3g2ZWtzV21IQnZmZWlMMzRVeFZKTFdiUVlq?=
 =?utf-8?B?UERJVnd4VUVBNnFaMEtzWE9JN2JpeHd4bkVRNDZ4RzhGeGMzOW1pYTVKNmJQ?=
 =?utf-8?B?L29OMllXOGlPa3dsYkhoekhxZzdmQ3NaWXU0SUx2Lzg5WkMwWHppMUlWNnZK?=
 =?utf-8?B?M2YxV3I0MnNiRVNlZVdVYTV3MW42clVvSUhoZXR6eXA4R2FmdHBuaVpWWjB3?=
 =?utf-8?B?c0ZTcWU2ZitXZERSdDQvSUt4ZFRhWVVudmxzdTRjVlU4eDhVNmtjV2V0dUFH?=
 =?utf-8?B?TTRGcDMyaDBLMEpKblN4VDRTL2FoTDcvUkJGUDhmbnp6K2NnYUVhMFlRRXVO?=
 =?utf-8?B?bW4wNzdjaHFKcHJVMVNtQkhTelNIMFl1WjFGY1NyKzRZOTllUS9ia28wVlZS?=
 =?utf-8?Q?IqU9JVgUKQO/R?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE0rMENxSHhIZUhRaVdMak5vU1ZnUjJXakxiVFl5Mkp6d1pRNGFTVGMrbW5W?=
 =?utf-8?B?VmdoQ25OeHNZK3RyMzNwMVFFU2M5ZVFKb1g0YVJLR0V3ditFSUxSS0pQc085?=
 =?utf-8?B?VHpIR21DOWpMMlEzbUs5WmU1TzlWRWw4ZERWdjI4MWxKZjkyRFFiTGludjJs?=
 =?utf-8?B?UWFmNWVUdTFWMTdhT1MzREw2T1hhQ3lHR1RCU05kT28za3BPQnRyVzIzR2U0?=
 =?utf-8?B?TjdhNmpvejNaK1Z5cnN0Y3JvWml4VjhlSWxJTjFGVkN1dFlJMU0zcjJzdEhR?=
 =?utf-8?B?SkdPdUxQL0R2Q2JRTlFIdmxqZFJNQVFvTUtSY0ZVcXdvQ0tTdVlaNUNveVNn?=
 =?utf-8?B?RHNxcDlEY3ZrbjIwNlgrbzYwNkxBb1FvRXZ4N01uYStZSHhaSU8ydUQ0NlI4?=
 =?utf-8?B?ZEJvQnhsWVRBSnNzYTNhQzdiSWJ6bXlobGVyRk8rNUdCSk5NaG9BalM1M3Jj?=
 =?utf-8?B?Y2QwaTNmRXN4N052Z2RINitaT2c3Y0tPS2s3NzNhSkRKNjFNWlpISE9Odkcr?=
 =?utf-8?B?KzVFZ3pRQUFhb1FyN1haUitsM3NvU0xDRTZTWG9HOEFxZ2U4Z05tVmkwNlor?=
 =?utf-8?B?WStPUUkydVI0cVhuZCt5TFZtajliUFhraDNvQmNGa25mS2trenBZSjZEdjdZ?=
 =?utf-8?B?WVN6VHZPRDg0MGlZNENSSHROSmpsQlZZZHB1SlI0YWhpMUhBOER4Zy9YRkFh?=
 =?utf-8?B?eE9hM2IwdmR4VGJaRGVKZFQ5aFpmVktINC9GUFdrb1VSU0dVWlhibU9iWG9u?=
 =?utf-8?B?U09zQ0dYL01NVWY0WE9VbFRSQzYwZmhlYU9qNjJNTlJyR3dSU0xvcDhVSWUx?=
 =?utf-8?B?WHdQcS95aHZ3UVNWa3VjSXM2NnV6QUFHSmo5YUJOSkFtS004ZlFwSVNSSkd1?=
 =?utf-8?B?UEJ1M3dCZ2xkR1pxakU0L0V2RkQ0UFFhVFFtVXg0L2wxOEJ0bzI5T0U2TlNv?=
 =?utf-8?B?NHloMDlRSXdtL2V5V3ZpQWluVkVRU0xKOHpKT25iVjY2WUpHT2ROMkhNZlJQ?=
 =?utf-8?B?dG5LSWJncUlsZlRwQjNBUnRXdW5ZeWFVUEhwSGZzYnNDeDRlTzZLZmRUdWxh?=
 =?utf-8?B?bU45bWg4WkJyRzNlOUZ5d1ZPbS85S2UvM05KNk9TeklQSFBSQkFOd1pLZ3NM?=
 =?utf-8?B?a1g3dWlVbUpFMTFmempFTzhHT000RS9JSmZHNGxNYllFOHZGYkE0RCtMeUd3?=
 =?utf-8?B?WkhWVEdWdEU3TURQNVB5NnRpUjQ4QSswSkoyZi91YjVxMzN3VnNkQTU0cUJT?=
 =?utf-8?B?VnB6NFl4bVBPZk1UVHlGUjBSVEM1Y1pQb0k0dUlBUGtjN3hxV1UxcFE3RXFu?=
 =?utf-8?B?VE04djY4c0VjdlJlcnpvTDVUMnVDN2NYTmJvUUhHTXVHdURQSjUzVDZvRjZX?=
 =?utf-8?B?b0pzUXpVbStIRHdQTlNzNVV5NXNVMjRCa0ttc1RlOWxBbUllL0VaQkJ2bEY5?=
 =?utf-8?B?NmZqaEViZlNUWXRtcmF2Y0p5NGpQYmdGYTkvWk5jeEYzTkNzcTEzck9HNXpu?=
 =?utf-8?B?TXNHNmhPZEIyTUJEVXoyKzdpeER5K3BnNStUeGRWRkorNWdyZ1RLSVVVeC9w?=
 =?utf-8?B?Z3VTRTZ2eW9HMkg3aytYZjZsOUk3K0lZTzVuVFhZbVo5c0NQRzA1SzlmdlJ0?=
 =?utf-8?B?ZVNESnFyQVhlcFAvVzAxeC95dWpQRkVwVXZQWjhhYUF3V1IyV2VWWXFtbWdX?=
 =?utf-8?B?MFR3UFBJamhPMHRMdDJJY3U5R1FQeTZEdXN5bG1DZ2FjMFVMbUQyekNnNWZK?=
 =?utf-8?B?TTR4WWFiOEVYUjJXYVluQnhOZ0ZTZTQ5Skt6K0ZyM2VQTXZoelBlbmt4SmN6?=
 =?utf-8?B?RjRxVXFhUENmVzNYWXVWczZZV2J4NXZsTUhXWjJOY2Vtd1hkWU1RcnRhMm9U?=
 =?utf-8?B?WnV5bGRXWW4xc2UxcTVTT2FtMXorS1ZwQ0N0SDBHZzl6MTdEY0RtMTIzU2Nw?=
 =?utf-8?B?ZmRzVHhOSk05RVBhcFlBUmE1Y2dsL2gyVWRTZmcvT2pRaGxnMEdYVnNkQkVF?=
 =?utf-8?B?T2QzdE9MeUlVMzJiOC9pLzFDem5lSXovQWp0ZHB6RmRweTNLU2VpeHpneE1S?=
 =?utf-8?B?WTdjTTg0OGg2ckxaY1dlMTVFUk9zMkpxVDVtRFUwcWdDWXhDelNBN3p3NGlC?=
 =?utf-8?B?RG5UcWk2N3JMSWdON1gyTWwxM09HZ00wMVRhQlVic3FabkRDdlh6blloeWMr?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f5d8a1-acfc-43f7-18c9-08ddd1412a10
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 21:19:56.6822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usZySWxW0OKf778XTyb1vLnkISusCP/Vq93uMzyHSgA4jbXoHuf0MGmIxeqPhclQQ0DQYfuI33mwlD2yDa9yB+R6Fq10jpNoQBHv772+L40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7432
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Thu, Jul 31, 2025 at 07:07:17PM -0700, dan.j.williams@intel.com wrote:
> > Aneesh Kumar K.V (Arm) wrote:
> > > Host:
> > > step 1.
> > > echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
> > > echo vfio-pci > /sys/bus/pci/devices/${DEVICE}/driver_override
> > > echo ${DEVICE} > /sys/bus/pci/drivers_probe
> > > 
> > > step 2.
> > > echo 1 > /sys/bus/pci/devices/$DEVICE/tsm/connect
> > 
> > Just for my own understanding... presumably there is no ordering
> > constraint for ARM CCA between step1 and step2, right? I.e. The connect
> > state is independent of the bind state.
> > 
> > In the v4 PCI/TSM scheme the connect command is now:
> > 
> > echo $tsm_dev > /sys/bus/pci/devices/$DEVICE/tsm/connect
> 
> What does this do on the host? It seems to somehow prep it for VM
> assignment? Seems pretty strange this is here in sysfs and not part of
> creating the vPCI function in the VM through VFIO and iommufd?

vPCI is out of the picture at this phase.

On the host this establishes an SPDM session and sets up link encryption
(IDE) with the physical device. Leave VMs out of the picture, this
capability in isolation is a useful property. It addresses the similar
threat model that Intel Total Memory Encryption (TME) or AMD Secure
Memory Encryption (SME) go after, i.e. interposer on a physical link
capturing data in flight. 

With that established then one can go futher to do the full TDISP dance.

> Frankly, I'm nervous about making any uAPI whatsoever for the
> hypervisor side at this point. I don't think we have enough of the
> solution even in draft format. I'd really like your first merged TSM
> series to only have uAPI for the guest side where things are hopefully
> closer to complete.

Aligned. I am not comfortable merging any of this until we have that end
to end reliably stable for a kernel cycle or 2. The proposal is soak all
the vendor solutions together in tsm.git#staging.

Now, if the guest side graduates out of that staging before the host
side, I am ok with that.

> > > step 1:
> > > echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
> > > 
> > > step 2: Move the device to TDISP LOCK state
> > > echo 1 > /sys/bus/pci/devices/${DEVICE}/tsm/lock
> > 
> > Ok, so my stance has recently picked up some nuance here. As Jason
> > mentions here:
> > 
> > http://lore.kernel.org/20250410235008.GC63245@ziepe.ca
> > 
> > "However it works, it should be done before the driver is probed and
> > remain stable for the duration of the driver attachment. From the
> > iommu side the correct iommu domain, on the correct IOMMU instance to
> > handle the expected traffic should be setup as the DMA API's iommu
> > domain."
> 
> I think it is not just the dma api, but also the MMIO registers may
> move location (form shared to protected IPA space for
> example). Meaning any attached driver is completely wrecked.

True.

> > I agree with that up until the point where the implication is userspace
> > control of the UNLOCKED->LOCKED transition. That transition requires
> > enabling bus-mastering (BME), 
> 
> Why? That's sad. BME should be controlled by the VM driver not the
> TSM, and it should be set only when a VM driver is probed to the RUN
> state device?

To me it is an unfortunate PCI specification wrinkle that writing to the
command register drops the device from RUN to ERROR. So you can LOCK
without setting BME, but then no DMA.

> > and *then* locking the device. That means userspace is blindly
> > hoping that the device is in a state where it will remain quiet on the
> > bus between BME and LOCKED, and that the previous unbind left the device
> > in a state where it is prepared to be locked again.
> 
> Yes, but we broadly assume this already in Linux. Drivers assume their
> devices are quiet when they are bound the first time, we expect on
> unbinding a driver quiets the device before removing.
> 
> So broadly I think you can assume that a device with no driver is
> quiet regardless of BME.
> 
> > 2 potential ways to solve this, but open to other ideas:
> > 
> > - Userspace only picks the iommu domain context for the device not the
> >   lock state. Something like:
> > 
> >   private > /sys/bus/pci/devices/${DEVICE}/tsm/domain
> > 
> >   ...where the default is "shared" and from that point the device can
> >   not issue DMA until a driver attaches.  Driver controls
> >   UNLOCKED->LOCKED->RUN.
> 
> What? Gross, no way can we let userspace control such intimate details
> of the kernel. The kernel must auto set based on what T=x mode the
> device driver binds into.

Flummoxed. Any way this gets sliced, userspace is asking for "private
world attach" because it alone knows that this device is acceptable, and
devices need to arrive in "shared world attach" mode.

> > - Userspace is not involved in this transition and the dma mapping API
> >   is updated to allow a driver to switch the iommu domain at runtime,
> >   but only if the device has no outstanding mappings and the transition
> >   can only happen from ->probe() context. Driver controls joining
> >   secure-world-DMA and UNLOCKED->LOCKED->RUN.
> 
> I don't see why it is so complicated. The driver is unbound before it
> reaches T=1 so we expect the device to be quiet (bigger problems if
> not).  When the PCI core reaches T=1 it tells the DMA API to
> reconfigure things for the unbound struct device. Then we bind a
> driver as normal.
> 
> Driver controls nothing. All existing T=0 drivers "just work" with no
> source changes in T=1 mode. DMA API magically hides the bounce
> buffering. Surely this should be the baseline target functionality
> from a Linux perspective?

I started this project with "all existing T=0 drivers 'just work'" as a
goal and a virtue. I have been begrudgingly pulled away from it from the
slow drip of complexity it appears to push into the PCI core.

Now, I suspect the number of devices that are willing to spend gates and
firmware on TDISP capabilities in the near term is small. The "just
works" case is saved for either an L1 VMM to hide all this from an L2
guest, or a simplified TDISP specification that actually allows an OS
PCI core to handle these details in a standard way.

> So we should not have "driver controls" statements at all. Userspace
> prepares the PCI device, driver probes onto a T=1 environment and just
> works.

The concern is neither userspace nor the PCI core have everything it
needs to get the device to T=1. PCI core knows that the device is T=1
capable, but does not know how to preconfigure the device-specific lock
state, needs to wait for attestation. Userpace knows how to
attest/verify the device but really has no business running the device
outside of binding a driver, and can not rely on the PCI core to have
prepped the device's device-specific lock state.

Userspace might be able to bind a new driver that leaves the device in a
lockable state on unbind, but that is not "just works" that is,
"introduce a new concept of skinny TDISP setup drivers that leave
devices in LOCKED state on driver unbind, so that userspace can do the
work to verify the device and move it to RUN before loading the main
driver that expects the device arrives already running. Also, that main
driver needs to be careful not to trigger typically benign actions like
touch the command register to trip the device into ERROR state, or any
device-specific actions that trip ERROR state but would otherwise be
benign outside of TDISP."

If locking the device was just a toggle it would be possible. As far as
I can see it is a "prep+toggle" where "prep" needs a driver.

> > > step 3: Moves the device to TDISP RUN state
> > > echo 1 > /sys/bus/pci/devices/${DEVICE}/tsm/accept
> > 
> > This has the same concern from me about userspace being in control of
> > BME. It feels like a departure from typical expectations.  
> 
> It is, it is architecturally broken for BME to be controlled by the
> TSM. BME is controlled by the guest OS driver only.

Agree. That "accept" attribute does not belong with TSM. That is where
Aneesh has it in this RFC. "Accept" as an action is the combination of
device entered the LOCKED state in a configuration the verifier is
willing to accept and the mechanics of triggering the LOCKED->RUN
transition.

> IMHO if this is a real worry (and I don't think it is) then the right
> answer is for physical BME to be set on during locking, but VIRTUAL
> BME is left off. Virtual BME is created by the hypervisor/tsm by
> telling the IOMMU to block DMA.
> 
> The Guest OS should not participate in this broken design, the
> hypervisor can set pBME automatically when the lock request comes in,
> and the quality of vBME emulation is left up to the implementation,
> but the implementation must provide at least a NOP vBME once locked.

I can let go of the "BME without driver" worry, but that does nothing to
solve the "device specific configuration required before lock" problem.

> > Now, the nice thing about the scheme as proposed in this set is that
> > userspace has all the time in the world between "lock" and "accept" to
> > talk to a verifier.
> 
> Seems right to me. There should be NO trusted kernel driver bound
> until the verifier accepts the attestation. Anything else allows un
> accepted devices to attack the kernel drivers. Few kernel drivers
> today distrust their HW interfaces as hostile actors and security
> defend against them. Therefore we should be very reluctant to bind
> drivers to anything.
> 
> Arguably a CC secure kernel should have an allow list of audited
> secure drivers that can autoprobe and all other drivers must be
> approved by userspace in some way, either through T=1 and attestation
> or some customer-aware risk assumption.

Yes, today, where nothing is T=1 capable for an L1 guest*, the onus is
100% on the distribution, not the kernel. I.e. trim kernel config and
set modprobe policy to prevent unwanted drivers.

* For L2 there are proposals like this, where if you already trust your
  paravisor also pre-trust all the devices it tells you to trust.
[1]: http://lore.kernel.org/20250714221545.5615-1-romank@linux.microsoft.com

> From that principal the kernel should NOT auto probe drivers to T=0
> devices that can be made T=1. Userspace should handle attaching HW to
> such devices, and userspace can sequence whatever is required,
> including the attestation and verifying.

Agree, for PCI it would be simple to set a no-auto-probe policy for T=1
capable devices.

> Otherwise, if you say, have a TDISP capable mlx5 device and boot up
> the cVM in a comporomised host the host can probably completely hack
> your cVM by exploiting the mlx5 drivers's total trust in the HW
> interface while running in T=0 mode.
> 
> You must attest it and switch to T=1 before binding any driver if you
> care about mitigating this risk.

Yes, userspace must have a chance to say "no" before a driver attempts
to launch DMA to private memory after secrets have been deployed to the
TVM.

> > With the driver in control there would need to be something like a
> > usermodehelper to notify userspace that the device is in the locked
> > state and to go ahead and run the attestation while the driver waits*.
> 
> It doesn't make sense to require modification to all existing drivers
> in Linux!

I do not want to burden the PCI core with TDISP compatibility hacks and
workarounds if it turns out only a small handful of devices ever deploy
a first generation TDISP Device Security Manager (DSM). L1 aiding L2, or
TDISP simplicity improvements to allow the PCI core to handle this in a
non-broken way, are what I expect if secure device assignment takes off.

> The starting point must have the core code do this sequence
> for every driver. Once that is working we can talk about if other
> flows are needed.

Do you agree that "device-specific-prep+lock" is the problem to solve?

> > > step 4: Load the driver again.
> > > echo ${DEVICE} > /sys/bus/pci/drivers_probe
> > 
> > TIL drivers_probe
> > 
> > Maybe want to recommend:
> > 
> > echo ${DEVICE} > /sys/bus/pci/drivers/${DRIVER}/bind
> >
> > ...to users just in case there are multiple drivers loaded for the
> > device for the "shared" vs "private" case?
> 
> Generic userspace will have a hard time to know what the driver names
> are..
> 
> The driver_probe option looks good to me as the default.
> 
> I'm not sure how generic code can handle "multiple drivers".. Most
> devices will be able to work just fine with T=0 mode with bounce
> buffers so we should generally not encourage people to make completely
> different drivers for T=0/T=1 mode.
> 
> I think what is needed is some way for userspace to trigger the
> "locking configuration" you mentioned, that may need a special driver,
> but ONLY if the userspace is sequencing the device to T=1 mode. Not
> sure how to make that generic, but I think so long as userspace is
> explicitly controlling driver binding we can punt on that solution to
> the userspace project :)
> 
> The real nastyness is RAS - what do you do when the device falls out
> of RUN, the kernel driver should pretty much explode. But lots of
> people would like the kernel driver to stay alive and somehow we FLR,
> re-attest and "resume" the kernel driver without allowing any T=0
> risks. For instance you can keep your netdev and just see a lot of
> lost packets while the driver thrashes.

Ideally the RUN->ERROR->UNLOCKED->LOCKED->RUN recovery can fit into the
existing 'struct pci_error_handlers' regime in some farther out future.

It was a "fun" discovery to see that virtual AER injection does not
exist in QEMU (at least last time I checked) and assigned devices that
throw physical AER events just kill the VM.

> But I think we can start with the idea that such RAS failures have to
> reload the driver too and work on improvements. Realistically few
> drivers have the sort of RAS features to consume this anyhow and maybe
> we introduce some "enhanced" driver mode to opt-into down the road.

Hmm, having trouble not reading that back supporting my argument above:

Realistically few devices support TDISP lets require enhanced drivers to
opt-into TDISP for the time being.

