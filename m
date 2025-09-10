Return-Path: <linux-pci+bounces-35797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C9DB50D76
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 07:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D9A64E13F6
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 05:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3932248BD;
	Wed, 10 Sep 2025 05:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aN3z3cux"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5424C3D984
	for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2025 05:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757482553; cv=fail; b=BNcj2DHff9NZ8bGM1BBAdjB4DHMvFEMjKqYxVNxJrPMVNOMR+Nw84iZXmItWDkdABOJR+4eLl0C/qHyJu2lv3o0X0RbbjKjIoULO+nqC4wiPBia9h/ku/g2y9j0nIRUld91/iVJUeitMxxenbA7Wtys5o387IBfJtAkeWF2jEHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757482553; c=relaxed/simple;
	bh=6eMJp17+IuvyFFmVYkL1EDx+JUjkcqqBNjHSQZzESOw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=WLc5e7wbPyfB6xPR5CKXcS6eB/n4fjbHj/+D3bD4nbLSe2jCVzElIbHQrOXf9G1Cal55MVDM+sCgexitpZd208ngMQNJfLT8FpngTGO4jk1IElXFYPDKAOpIY4J4zFK4ph1XHz4gbo9hpJQ3K5Tc3DOUlXkOJcmSGG1oR2ImzEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aN3z3cux; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757482552; x=1789018552;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=6eMJp17+IuvyFFmVYkL1EDx+JUjkcqqBNjHSQZzESOw=;
  b=aN3z3cux7irOfnFhWnMusx8XL4zqeCfhOL2sOiQjyIJL6Q75kmGZfqNs
   5FPIUbhGx8V+5Bu65L9BE9QpIRgcw8cZeyOtFn1tJKMlUZgcOZuHPpDwN
   RGWPgNpk2udmMRdLp0RdMRxiZE6zxhqh/s1adjRxq4oaJG+GWUFt0HZAG
   0FnqfDHUfiKqUPmE6qDFVl/3j/ayfJGwNfGqzA/5lQVCfRnz0wLMBspz0
   2nITCF7vVHdmDEKWoHs4wjH+xpMGxSDVwwOgKrpPOw4+RNh4bTgIsN1Fr
   ODLV9iHw8Vj2/4EQM7EAkOdVx3SrFgGam3B60BPLqFghbbMmIY2W7ej4S
   w==;
X-CSE-ConnectionGUID: fsI9sE9wTgC+pM5ir19GwQ==
X-CSE-MsgGUID: Aj2lYfJZTPq10kJcQf5sLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="59003366"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="59003366"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 22:35:52 -0700
X-CSE-ConnectionGUID: oszjdb2rQ/KDBzanyAFbEg==
X-CSE-MsgGUID: eVHQ6HMjTZ2H83h5scCKnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="178491007"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 22:35:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 22:35:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 22:35:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.43)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 22:35:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rc/rmU51aqkB2ZrgD2kTYCG2EoswrG2Otp5PAJSOUEda3sFGwt+JZ551086wRqt1JLzpiv9Jvsiv5ovBDW+ltzpCDr4qfFL2d53uRXMKOWh/H04hNrheLHI6t+XJWqoUsv6w1ppjcmAZSIJ0v75JnAwwT4CGrO2hwtzi1ZDK7i+PNHGjpGQ+m62J1OIQW6IswBpDjYCQHVeg4JJCTt04MRzn4jprOKU+06Us1WO53XPpkLif8yUV+y0RdIUmnBJ+G1tOYVpKpDldl6TRaPT4FeMbMChm4COqXjX9LnSTlRK4RtrYUBB+RQoIGA/mSGOo4UJGIGXOkJ7m2X9H6TQ34w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gih8uZX71ETVcBdhAcn1t1u/NxMxOkEND1VUH3zo010=;
 b=aqXdiEhTAGm4RrUYtb5Hes5FdPwFdXigsBif3U9mlOw/dewL+ovCyz1xmPsqKRDfJ3/Lkos+6it9/AwkQCYtulsASAIc1XnlcSM7CKWuok9SE2LsEABFU/b/wQ4KBXYGa00vGBWLfYH1Nx6ptadPQR1L+nypiEuqbII5J51y/3BflkRvWh2g8gU87kBHcXdCAki+mqetOY3Qx/d3XKl3DN5pDadTXixKU67D9E5xdGhNrvTBadS7q0jdVbXaMuL/I9Qbul3DE4geEgA9m14EbZUhsH++Lh1dM1vgbZ9NmqSZvpkkGIVn7VGNnPTywoKVZehXoyE5hSLc+dks7YTIsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6524.namprd11.prod.outlook.com (2603:10b6:510:210::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:35:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 05:35:48 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 9 Sep 2025 22:35:54 -0700
To: Alexey Kardashevskiy <aik@amd.com>, <dan.j.williams@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>
Message-ID: <68c10e3ac7ba6_5addd10031@dwillia2-mobl4.notmuch>
In-Reply-To: <0f1f47f5-7855-42f3-9a89-54fec441d7b4@amd.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-3-dan.j.williams@intel.com>
 <e680335b-bd40-4311-aa13-58bc2b0b802c@amd.com>
 <68b0d30e2a18c_75db10050@dwillia2-mobl4.notmuch>
 <101dc0bb-d6d1-4f29-81fb-fb1ff78891ba@amd.com>
 <68b2640726bd8_75db1000@dwillia2-mobl4.notmuch>
 <6b07daa7-665d-404a-b5aa-c6053dead62c@amd.com>
 <0f1f47f5-7855-42f3-9a89-54fec441d7b4@amd.com>
Subject: Re: [PATCH 2/7] PCI/TSM: Add pci_tsm_guest_req() for managing TDIs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::36) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b123aa5-9885-446a-1909-08ddf02be5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2pudUpJb1RjNlg5VzJ5UGdQZFcyMTBBSHZGdXNpZFhpaFNzalY5UUFXREo0?=
 =?utf-8?B?am5xaXQxRWViWnJlZ3RlRW9WWWNhQ0FwUFZaWCt4MEVDYUFHSXZWQWVSUXlx?=
 =?utf-8?B?TndBZ1hlcDdISFNqNzBqdnJRUktoeE0vc1ltVURUQnZYekxpMjNkNXRzY2ZQ?=
 =?utf-8?B?SDlZdWEwUlRSeDZraVFpL1p3dWV0RzhmVVZlVlRCbUE4WTcwc09Qa3RIeUx3?=
 =?utf-8?B?aklIMW5UKzBDTzRHenBNZUxSVVNncFJ4ZkgycXNFdDdGQ3d6dUJxZC81Y0N6?=
 =?utf-8?B?eGRWaEFucktYVCtzcS9pL1ErWVpsK3pTaklsbTJadVhWd2J0eklxNmZFNnY2?=
 =?utf-8?B?ejM1eWdWQ1prd1lpalVDRDRhNU5UNmdjb0lNR1BRajREWURTM1FieEl6bmtr?=
 =?utf-8?B?M1owOFBLTlBEdVJFYWEySks2bUY4aGNWaFgyV0N2aUpHY21UM3RoaDExS09E?=
 =?utf-8?B?anBPb2tENE9Ob3NwczRxcWsxOUNtOWlyVEF5aDBRSnZ3ZDFSR0E5c0JCTVFx?=
 =?utf-8?B?VDJpcEp5aDM1V1lyeGF4ek9Ldk0wV2lnUDBkVkFuRFNORkxtaUFVTC85NW54?=
 =?utf-8?B?RnFXMkI1WmRCZmdHaVRSNjJrZnlvaHd0cy9jM1lLWTJFSldPKzlZUDIydjFE?=
 =?utf-8?B?MUd4KytUSUZSVW4yWUZCY3dUVFV3Qkg1RHFjSkJQbVpPZFlEWkx6ZHJWNmNZ?=
 =?utf-8?B?T0UvYWRHeFNJWE5KYnRIYzA2SEw5UXlLaG5PWno1NzFYNFQ5a2FhcWF3QlNX?=
 =?utf-8?B?azgzQWM0c0g3SGZ3ZUQ0NkI5ckw5VzVNYWFLb2c5b1hEVGlHZVNva2JoS0Vt?=
 =?utf-8?B?ZllKZWs1Tjg4NU5uSTRNdE9QNGRCQzNGZjUvYWc1QkIwVGdyWUhmVW1FMzIw?=
 =?utf-8?B?SUFxNVNHMC9KQ2RmMFRuYU1rZ2gvbjBDV0s5ZEZtU0ZhSStPM3VnNjVvVWRU?=
 =?utf-8?B?Zm91djY3M3FTRjVLS0FweHdsR1dpWTBmeTc4VXE1a05Oa1JWRVVad1FXV05W?=
 =?utf-8?B?MEUxbWtPaVE2WDdwUzlZakxqOGM0blZWRmRvNkY3cEhBdjlQQk5ZVzBEK0lW?=
 =?utf-8?B?TVdNZjBmTDlIRkcxdnQ4a2NVWmVLU1Y5aytKbTZVd1Fmc3dXNVJseHNxbWpv?=
 =?utf-8?B?K1hwVUU3aXVCcVFiMCtXb2RyR0FmeSs5Y0FGVllBeWUrOWpsT3hGdkd5ZmQw?=
 =?utf-8?B?b3EwcEZwM3pBR3VSdEJlcU02ME9iZzJwUkw0Y01QNElCL3BQM3o5TXA4N1Ra?=
 =?utf-8?B?aVRDcU5wWXRzUmh1bytqbUpkUlRzZFFKMjB5cjlKWko0VGQ1SnpYRjE0bTRp?=
 =?utf-8?B?MHh0ZVVZYmdQMWNXU1JjV2hRanVzbHB1TExNeERyTXl2VUU0MG05MlpRYVdt?=
 =?utf-8?B?RHhjZS9TdjJwUi81SFR5SnRtby8xK3k2N0IvR0ZLTEswWkRISGVNQi9PNGlI?=
 =?utf-8?B?V1l3c3UrdlMyK1JiMzgvaVN4UjhzN2RHTVJVZ3E3OTlxWElTS0JJdkRqVUZ5?=
 =?utf-8?B?S0ZsMzZFQWwzMDg3Z0h2dzhpeVN4R0Z6cnZuNTVNUkd4MnMyMU1LcGpXTHRG?=
 =?utf-8?B?b2ppNnFweEQyT1QyaTdCcGlDR0lvY0F4U2FIMGs4OEdmOWl3NEw4L2VYRGlC?=
 =?utf-8?B?LzZsVkhUQ0N2ajI3WEdFZ3RuL3gvMSt2KzFBM2pCVjVwQnkxZ2ZGTGcrR01H?=
 =?utf-8?B?SjNZcERsK3pVWjdWYjkxbFJTOFJCOHNReGt0SVIweGoyZVdrQkIvc3FuM0Zh?=
 =?utf-8?B?NFB5M3haTXppSjdIVnBZd1Bhdld2cGd6VngwK3Zha1lDbUxwNDhhL2ZORGVQ?=
 =?utf-8?B?cjJnejBUT1NFMjhKQUM2VWlkcFV0eUQzU2F4OUNCa1k5R0ZsZDdUazlobHlG?=
 =?utf-8?B?dklqNFNiL0NNMzNGMDh3MXppZzZhVkFnSHpkMDlFcDFuWHFGSW1Pb2ozZ1gy?=
 =?utf-8?Q?6UCtIVrP2H4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjdqNk13T21HS2tHMUs2V0REME41UDJrR3hoVlE2YTUxek1pcTJIdVRuZTZJ?=
 =?utf-8?B?UVZuRncrZWxFWHU2b3EwYmhRZ1Y1MEpRNm9ON0JoTGM0NllqSE9QaFJBMG5q?=
 =?utf-8?B?YWpEcWJCQ1pxWUJIb0JNK0RpckhyVy9JOWNmSWt6YW1HdTF5SXJjMFdvM21a?=
 =?utf-8?B?NWxYOGtPZ1lwaUEyellZVzc3azVwWTVYR2xNc0NNdW9oNS9ST0tCMTFzUmNm?=
 =?utf-8?B?UmFrVjY5QjA1VStZaTEwT0ZvdHVzcUlXL1YrbWc0aGFZWGJIOWYrZGxDbHpn?=
 =?utf-8?B?ZCtETXUrZXR5eHZXSHA5Q0tMTGs1SE91c2ZkZG5ocHBTZVZqUm5RV3FyWEZM?=
 =?utf-8?B?cEhxeksvY1FMcWxCTnBSZVVkMEtPelF2dlJwRzJkM21GbkFUdXVTT1pBQ3hE?=
 =?utf-8?B?cEdvd0FGS3lUbllHYlE0N01zcnRHQVJOV2IwazBSOHcwalQ3L2dialZsdHZJ?=
 =?utf-8?B?RFo2a2VOenFJNGVYN3E2RWgwbmRITU1DYUFEdU0yRkRJRTROVW9nVHRMTWwx?=
 =?utf-8?B?VXY1bFNPSHZicWV6MEFEMTdCbkNESnhPMkNEeEpFdXpHN2RnNGI5UjlKTGFx?=
 =?utf-8?B?QVZIeUlhZTlQME9ST3JEKytXSXB3OVZWa2ZGNEt1MWY1YjRVV3VTaTVvTkxm?=
 =?utf-8?B?aEd3WDVLM2pWUnR2NktKWU1sc09wWjVDL0l4dHV3Q3JjNVBNYitHMjR3Q2xt?=
 =?utf-8?B?R25VRU1YcUJFbzROVmlkRmp5WVhZcE8zb0ZNU24vaGczSWVSM0dHMzZTS3dy?=
 =?utf-8?B?a2Z6RkxaaitnUDBpR21hWXBpdE1pZVViOTllRGxUb2doR3BzV3lCaDBkS085?=
 =?utf-8?B?V04wd3c2WUtTZm1DbU5qS3hHNjhYQW1sR3RuRzR0R2o2UTI2dGZSSDVNUjVr?=
 =?utf-8?B?b2xhVGZQSVJQdU5CRDBlRG1BbzE3LzVrWWpHbDlqZzBJQUdzV1hrU2lpS0Er?=
 =?utf-8?B?UXBWY1RjYXVabjRXVThvSlRKOTNzc3JPZDA2cHZHNjdkamJOZ25PbFdkS3dP?=
 =?utf-8?B?bUc1ekZCUkNxbHdIZzBQZGI2TFJoRE5WLzY1ZmRKY1IyNk9lbmwrK3ZGclp6?=
 =?utf-8?B?MmhraXUzeitOTStaTTJYOEpNN1hSbmxyQ09xUCtGbnVZUEhQTFB1Y1lhZzFu?=
 =?utf-8?B?Z1dFOUVHL3Yva3VVdTRtR0ZyTjlTdWpnWXFrRXRlSFhVL0phalNyV21sMWI2?=
 =?utf-8?B?ejdtTHJlTU5IRFdOZHhINnlmd1pVelhLdmhUU2Z2YzlYaFBIY29mT2NHZWN6?=
 =?utf-8?B?eE9YSXZoSmxtQVRnbTVsZWtybnZHcnhwbG1YSE1yR2JtYjdnWldqSjhOTWY3?=
 =?utf-8?B?QVFpSVFNa2dkZHlVQk1RejM0YlBHVERWSERYQ1Mydjh0cWlQZUswanNwLzcx?=
 =?utf-8?B?R1lrc0RHUGtEOXl5MjFEcjhFMjBSNWFrVUh4Y3RScWw5NEd4bTNFMTRDQVU3?=
 =?utf-8?B?ZTBSenExWWMrbDlWTjF6V3FRVDROK2lETVhLaExHT0krN1pzRm1uQlN3d3E5?=
 =?utf-8?B?b0E2R3pUWmJGKzdKNFBMVHZ5VUQ1NzRFU2RqbkFKRm5JODBWaDVvQUpucWh5?=
 =?utf-8?B?Ynk0b2hpNmJ4MUJaNEovNVA2R3JjM0FTVTdFTmJIVTlPUkJMejdjQnpxSjND?=
 =?utf-8?B?RmRlWjRIN3ZSYzhrWDF4Rm13ZEJGSGQ3MWtuRUhPOVlPM3BCZU10dDJmNXc1?=
 =?utf-8?B?d0JHQmR4aVRIWElaRFltZU5GdTZzT0ZUVFJBMUIrVUZ6TEFTd3lNUVFYbkts?=
 =?utf-8?B?Ymh6WG9saGxZeTdTcDZ5amUvNExFMS9VVzZLblBOQ0lpbC9kc3REZlhZTTY1?=
 =?utf-8?B?UzhyU3VyalNhMzZsMHc0eXVRQ0I0YWRFbnk3RTRLZmxvZEFqbElrU3R6ay91?=
 =?utf-8?B?RjZiL0lDQmJ3Tjk5NXVLSzVWd3Jpb0xEbkpYY1lGMUdoRTdZKzJoaDB5MUUr?=
 =?utf-8?B?b1BKM01IRlV6cThvOGZJeGFlWVRxNEwvM1k4VWRGM1RtVzBpUkorNHFyWmFy?=
 =?utf-8?B?eEYyUkJRRW5rajI5cWhZVXFQZ0FnNjZCc042R2FST3BOVGMyME1jTk5tU1Ny?=
 =?utf-8?B?MVkyUUtKZEY3ZUgwR2w4SjBsS1lBSGhXT1lEWnN2OU1yTlZyWUVlNllYSlVW?=
 =?utf-8?B?NktyNG0yOTVmZFg2ZHYyUHZMWERVTk5DYUxBamJpc01iR3phVHhpQ0RhUUll?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b123aa5-9885-446a-1909-08ddf02be5ab
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:35:48.5500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMSpRDYaU9eXOfobgLVQUArcTRulBzTXyjBEukoBhimPnGzvCbNVHeSouJe7rXV8cexSQrUmmhl/3q7y6uUpoKZVDeMC7kyIJhudLapdZ08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6524
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> 
> 
> On 2/9/25 09:49, Alexey Kardashevskiy wrote:
> > 
> > 
> > On 30/8/25 12:37, dan.j.williams@intel.com wrote:
> >> Alexey Kardashevskiy wrote:
> >> [..]
> >>>>> We have pdev in pci_tdi, pci_tsm and pci_tsm_pf0 (via .base), using
> >>>>> these in pci_tsm_ops will document better which call is allowed on
> >>>>> what entity - DSM or TDI. Or may be ditch those back "pdev"
> >>>>> references?
> >>>>
> >>>> Not immediately understanding what change you want here. Do you want
> >>>> iommufd to track the pci_tdi?
> >>>
> >>> I'd like to either:
> >>>
> >>> - get rid of pdev back refs in pci_tsm/pci_tdi since we pass pci_dev
> >>> everywhere as if a pdev from pci_tsm/pci_tdi is used in, say, 1-2
> >>> places, then it is just cleaner to pass pdev to those places
> >>> explicitly
> >>
> >> Maybe if we see that that are unused then they are easy to delete later.
> > 
> > It is way easier to do now than later when it grows. I'll dig a bit.
> 
> So far it appears so that the only use for these backrefs is
> pci_tsm_ops's hooks which take pci_tsm/pci_tdi instead of pci_dev. So
> the backrefs are only needed because unbind()/remove() do not take
> pci_dev.
> 
> My problem with these backrefs is that for a new reader of the code
> it won't be immediately obvious whether we need
> pci_dev_get/pci_dev_put for those, are pci_tsm/pci_tdi ever detached
> from pci_dev, etc. Dunno, I won't be nak-ing of this though. Thanks,

Why would the new reader audit that the core is taking references on the
back pointers it provides?

The to_pci_tsm_pf0() object casting path has safety checks based on type
which can be inferred by walking the backref.

