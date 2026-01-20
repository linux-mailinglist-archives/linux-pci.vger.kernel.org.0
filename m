Return-Path: <linux-pci+bounces-45279-lists+linux-pci=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pci@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KME3KqnPb2kTMwAAu9opvQ
	(envelope-from <linux-pci+bounces-45279-lists+linux-pci=lfdr.de@vger.kernel.org>)
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 19:55:37 +0100
X-Original-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E730249DEB
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 19:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B04A60D3C3
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 15:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86262FD69F;
	Tue, 20 Jan 2026 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RHT0EzJG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE62B665;
	Tue, 20 Jan 2026 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923464; cv=fail; b=i11IBrJbHP2rUx8dTRr+Q4JixxwtnPmrySnzhdmhd9Zlk5aXrqNsAVYGGKJKeZayXqQael+toz3ECtvPWLbTsDwqmE6+XqDE6I3/VGLfgvFf1uAgDXH7SRajtByFmZBYHinoYbL4aYFx8zVbJrG5F83u42valRHio0hBnX38p2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923464; c=relaxed/simple;
	bh=vDm8OAm7QUAgOdXtGfLsq8HQrck3TZWuPJpolht+/aQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n4qC2bfxa3k6Zu6f59h5XAFNGRtdlLO0GnnVAeRuZKxPjxoAk+2U9Rw7vjhsPRb++y3RnKac9PgqlE30IVdRXuQ/F5/Vcq0ZgXgdhZb/scGoHwDD6ey1ipaRMVl+Hfe+pyTkiAc5WBQh9nXx7I0qDh/DfbQKUEtDR2T5tcGaXu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RHT0EzJG; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768923462; x=1800459462;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vDm8OAm7QUAgOdXtGfLsq8HQrck3TZWuPJpolht+/aQ=;
  b=RHT0EzJGeUs/CM1mXo4CP9eaFr//6YfwLviCobuy//3yW2AgGCua6vsX
   Ab0vHQq8WMy0jkiS7O9HimDMkOsmfCUR6BFuKZ0JNIsKBfNN4RGH/RlhP
   4TF9rYSzqCCQ4OB9Qn8IF3GcLYYLwy9QD5voxtWurbsv5+vaD/zYymu54
   /pUhRw+JVC9T+vXrPIOuzWkdMTJmYrdcnpVs29a0mXZ9Gg1q+33mnL7Vo
   J8Fnx0V1i6x0ObeLSnid/oqnS8CqsuGlT3ReY8YHY7yLP7SN+Vf17AgZX
   u3As0YHWjRvFaYALEGA5XKyhLNijDMWuZJt0dmghDVg0VSreZL4EvjL2N
   A==;
X-CSE-ConnectionGUID: ICGbGHAKRYGyluISAdreYg==
X-CSE-MsgGUID: MkOLWVu7Q0SI4CMmILSWMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="69149024"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="69149024"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 07:37:42 -0800
X-CSE-ConnectionGUID: n4Uf7/TBRZ65aTvA1luWAw==
X-CSE-MsgGUID: cjtismL9SbWKlDSqk+j18w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="205767006"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 07:37:42 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 07:37:41 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 07:37:41 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.8) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 07:37:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtG8pmygGWmKRM7k+1ft8w2FoX583kkOR4Ibxc4a9XBFBXOvo6OLvd9h+GuKh1GVUhFu/khb3iv3k8ADGO2KMAOFDjLAlAdAkSOQDcDeWk0POY6IEfYVpAaLf2Xe5a8iDQZ9wHdGYOztgCYzye4kX7CW1tQCIoHQAJD82bsVMjEXLvSaWf16JPMOuzdmwHqMkE36bkVyf81nVv955morsvgwpoUyNTPmDcbEPz0V1+3FNA4a2D8Uuhi0uOrRk/GCxS2dPwm3af2gZmd7m4TPu83gGs0Xwlfz9Q3rpoE+A/yJzH+WGbdSUpfydTdjFQl7HKv746PAR2oAFICOt4a0mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qesBo/uThQjy2UqNI4NfZScTUSpH3I/4uhcwi426VU4=;
 b=ib5FEeoEkC/k1b0AB0KLEtNxVIv/CQXURNONpNlTL8KRMoD6RmYbn67Im55wJ+2KFVJpv6WLp7bF7vDpuY0CSxsHjMMVUU7bXvNpPsSnfb1sONHFWNwjDtc8lzX9l8CNLrcAG6IQ+lMEIhL9jxzq09Lq7zqhgYkS2OW/w5EPTGBc2MffC70KiIWq0mCC5HorWtYam6IqyNyKRkejHx32zYMVTcibWctvUWvxKdTifUhBES0sbtNxqEk5b0dTLXoJ2xbRiu/WtaQskp3fe9epe3yGNpblSXsFtANTedf4K//d95dOaJvSX9y0otiN7Iz1w0a8YCzdlh3OAFEcAiBCVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by SA2PR11MB4793.namprd11.prod.outlook.com (2603:10b6:806:fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Tue, 20 Jan
 2026 15:37:39 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::1451:ad37:6612:37fb]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::1451:ad37:6612:37fb%4]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 15:37:39 +0000
Message-ID: <bd99f19b-39f8-40c1-825d-16e37c10c95b@intel.com>
Date: Tue, 20 Jan 2026 21:07:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/12] drm/xe/vrsr: Enable VRSR on default VGA boot
 device
To: "Shankar, Uma" <uma.shankar@intel.com>, Jani Nikula
	<jani.nikula@linux.intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Gupta, Anshuman"
	<anshuman.gupta@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "Gupta, Varun" <varun.gupta@intel.com>,
	"ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>, "Poosa,
 Karthik" <karthik.poosa@intel.com>, "Auld, Matthew" <matthew.auld@intel.com>,
	"Anirban, Sk" <sk.anirban@intel.com>, "Jadav, Raag" <raag.jadav@intel.com>
References: <20260113164200.1151788-14-badal.nilawar@intel.com>
 <20260113164200.1151788-20-badal.nilawar@intel.com>
 <64894565d5eace99fd65f290ee807dabaa2de04f@intel.com>
 <aWkG5cEapt_attfS@intel.com> <431ce6be-b083-4002-8dc1-4be8e557d07c@intel.com>
 <e522e352351d52da15c8a9d7f9332e48092f06d4@intel.com>
 <DM4PR11MB63604AB8E122613BF072DEFDF489A@DM4PR11MB6360.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <DM4PR11MB63604AB8E122613BF072DEFDF489A@DM4PR11MB6360.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::10) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|SA2PR11MB4793:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d7dd6a-82a4-4de0-ff68-08de5839d7ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEpjMzdpK1p3Qk85a0JMNTl5RnpSdVN4TUp0dFJLNERBdzJOQ0RyMU1oNCtZ?=
 =?utf-8?B?bjhZaHc5MkJtVkc3WXl4Z3RHd0c0ajlrM1BYT0pFenhMS0FMYWt4dVVBSW83?=
 =?utf-8?B?cnVCZnBMYXBCQmFyUXhjck1taXBvVnpnMm9DRmlzeTJ3Tjc2OGsybjZnSTZj?=
 =?utf-8?B?SjJoL0FKR0R6QWJzaE1yRXA4RkxIUUc0YXlyM1NUeVhIOHgxcmQ2bmErV0RT?=
 =?utf-8?B?SWNpMzNiMGo5R1Nta1h1YWYyay9GekdndWtkcDVURTlaK0h2RXNIa0gvaFdJ?=
 =?utf-8?B?c0ZXd21SNUZzblBVOFlHcit3SzFSMmpSYjBYWllhM1o0TTBUbFhGZVpjU3Bs?=
 =?utf-8?B?ZWprV0FxNXUxTFJnSE1JdWtNRXVMdUJ1Tkp6LzhsTTdnL1NJcnQ2MEFTZklD?=
 =?utf-8?B?N0hSa3pTSk53SGlyTlpTckFQRHRXSUJoOU0zQ2hNNWh1cWhURHNLL0lESU53?=
 =?utf-8?B?bVllUVg3OW5KbjhiYWU1dUZjQjA0QlJFRDBqQWtWN1orSVhqZkpKVnVMTkI1?=
 =?utf-8?B?S3NhTHF4WFZoNjZDUDZBNHMxcmVCa0NneWpkMmRyTFRoamlUNVgvM3RFbk8z?=
 =?utf-8?B?MUp5YzBwcktRK2ZMdXNxK29HdncyOEM3bG1ERFVzSzhEbWhUc0Rva0MwYlJP?=
 =?utf-8?B?Um4vSTVVUzY2cnRxMzhBZERJTVJOUE11OXVGVkpXTlpaWklEZTZrNzNmRHFK?=
 =?utf-8?B?ZzU3RTA5WkN3Rlc4SWNoeU92U3h3R01EdlpRQUJMa2pKUFJLS1lyQVUxYmJ5?=
 =?utf-8?B?amU0cEhMTHMzdUhSOUd3MFMvN0FGSDVpVURJVXN5WDI0YUpDQmFsK2pQeHMx?=
 =?utf-8?B?NmFySTluaCtGL3NuNXc0SXhYS2luamxnS2xNaTUvb0NBVHpnRWxZYWVsWGVO?=
 =?utf-8?B?Ym9vNWJBMlcwSVl2cWVVb1pSTkMyTjI1RTlIQ2tCTmJSdG5nOVp5R1E4SFBH?=
 =?utf-8?B?YjlMV2VKcEl2TmZsM3hIaElZZE5UVGFHa3h0WFVrcVRqYU1udGVGZzN0YlVT?=
 =?utf-8?B?MDA4N291b2xTdmwyc1FBSEJGQStETjFTWHV5Yk1mWGtDUE1TaGQyMXFBd2Yw?=
 =?utf-8?B?WHFvTXJEeEhCcEJVY0l1c1hGbnpOOFFhdEdIZVIrakhzOHg1TEUyQmFaNmt2?=
 =?utf-8?B?TVA5RWhFK005VzcrTjZNdENhcGhVbStaMTFTS0NVOStHa0MwUmVTY0hqZ3Vs?=
 =?utf-8?B?Z2ozY2RDMmF2YSt4d0JoMHF5M2JaSjhET0V6Z0RCdzJjdjFSSytYOWVxak9q?=
 =?utf-8?B?MG81V1B2Sy9yN2RRQWRnME9PMXJGdGxYUzdWdmlidEtpZFFIYUFTVHNubFY4?=
 =?utf-8?B?aHZtc3dUVUNySTNQSW13WVR5Q1dpQXViRUVUYzg3TXdWZUFkSkcxdHA0eUZ5?=
 =?utf-8?B?ZHlSZW1DbzFTclRVNHFnUm9weVBpamJBQ1E4YWdKL1V1VklGZWwzazFOVmhO?=
 =?utf-8?B?WENZd3RkWnZkeFVTdmVqM1AxNXJLalNQV1FKNmtMdzVCS1hRVTZ1UjUwUllC?=
 =?utf-8?B?WTNhdHpwaFNqelhYaE11ZUI1K1U1OEVXYXRwOUxYaUNqOC9Yb0tINmYvaHZk?=
 =?utf-8?B?WTN1R3QwZ1pCb3ZzWTV0TENlcFdCU1hVc25Ud3A4RndJeHl2dnZqaTFUOUZI?=
 =?utf-8?B?K0JIdU52VllrRzcveTVZdkhpa1dCdWgrZE5iRGRxM3dBbXlyT1cvQjAzNlJM?=
 =?utf-8?B?ZXJ6UWF0dDFuaktDZStFbmJMU0FWaFo1ME8yYWg5dXJLUnBGdm5EbGZ5ZktM?=
 =?utf-8?B?enRlR0h1akdTMlVxdDJLTUl5a0RRM0hXcjg0MWdsa2p3Zyt1OTk4ZHJKQkxp?=
 =?utf-8?B?VDFQdW1FdjZmdmgwelVXMlFyQUF4UXdQNnR3ck9pdytSM3pKSjlYclU0NFdw?=
 =?utf-8?B?NVdxZUdhZUVJVXhra1c4M3cyN3hPRzJGMU4wMnpIMXZ5d2xrUUd5UU1XeUZG?=
 =?utf-8?B?c0pjWnkwMjJ1VHdhbkNYY25hMVBZTnpwMGR6bkpVVUlMNjRqd09qbDBxb0ph?=
 =?utf-8?B?YkV1VkFCeEhvY3AweUxPVmR3SjlFWldZV0MvNHJjejBrRGkzbENHRkFNaWZw?=
 =?utf-8?B?VmcrVmRkZG1lb21MaDJSTGZVZU80RTRvcUxzTjVUUyswTTlkc05wQ1VEY1N3?=
 =?utf-8?Q?uqZg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW1yc1lJVlJqM0FBWW95OXhEVGNLL1FkbC9nVUdlWWJNWm5vZCtJczNBN2xh?=
 =?utf-8?B?N0hTdUxmWWNDVUpiZTFNcEF4R2E3RnQ1c0xQQWdtakFxcXh4Wm1vRzJLTjN2?=
 =?utf-8?B?dUwxaXhOU1JmWU1sTWFGTjVyc3FybE5SVVRGQU5VRk05ZG1JZjJrUzRERXVJ?=
 =?utf-8?B?NFJ2QjByRE90T01JU2dtcXRabUR6bjZpaFFzZytlRG82VXdoWnJXNVhiR2hK?=
 =?utf-8?B?R1RLWGpUb1ZPOXJnaHcxUVN2UVZlS2JzSTFVOFlZdThsK2VUTmFkZW9SV0Vm?=
 =?utf-8?B?QzN6UWlpNDNWd29IdDdsQnZ2QVIxcEdzclpWWWVKU2ZZTW41THl5bElMRW1P?=
 =?utf-8?B?VEtaY3VkV1VMR2hBaTRZZWVqYjY4YU1od09neHVUenJUR3c2R1g0dStxa0Y3?=
 =?utf-8?B?OHFBdmY1TWtUWEJDL05TQ0xVSlBxWk94Tkdjb2cySU1KeTEyaTdsaFAzZEpo?=
 =?utf-8?B?ZzQ1cURqTVdTZHRVSENJaW9tSWlJNjk2NzA2MFZJWHNwZ0E0MSswUWovUlZV?=
 =?utf-8?B?Qm1Ed3NFbmJTVXJ1Lzk4cHphWUNkbUtjTjNpaEMydWpUbEI1UHFRMk1WVDQ1?=
 =?utf-8?B?V0d2Y2NwOXhIMmNOOFFBNjAzOUdhUTE5QmVwQnpoWnFJLzBmL2ppUnN2czls?=
 =?utf-8?B?bFIwOUlkZUF1UXdxREc3eTdlWEFFNkJrZDRhazZINmRCd0IvTzVVekFNaUdX?=
 =?utf-8?B?SzFLOEFhSmg4a0ptVFI0d0N5YnpjWkllR083N1ZMNUk0aENPUWpMMlN3Q3dJ?=
 =?utf-8?B?YjY4WWUzT2lHRXdieVBtSlV3QkNJUnIyQ2JPNmdubGZ5QVY0b0NhNXNXZ0Fu?=
 =?utf-8?B?OSttY1V5dGlaeEZjbGRFdjBpZFNEWTBJSSt3NklMcmlPSFdmWjVrbFlsZUVH?=
 =?utf-8?B?c0lUWWttQ1l3a3pmcDB5bXVwNjF4VVlLKytUZ3pOMHMzQTF3MTl4alZqUnZo?=
 =?utf-8?B?MEYrLy9oYlIwQUVPNlN6SlJPZ0I2Qm1IaWwxcWZNUmcyVVRob1lVWE1uaWwv?=
 =?utf-8?B?ZFVPWFpKaWg3ajNBeW9wMjNoMnhaM0JqdU1EenB6YWJVOUxhc3FkS1hBUjRq?=
 =?utf-8?B?cDIzQVZCTHdmSURnRzJ4UWZMcXVob2l1NEpjQU5VRW9BRDh4VkJOMTBYNE1l?=
 =?utf-8?B?aE5BcnFOTHk5RnJNNnQ3ZkRJUzYrWFRNTE9IWExJUWFNSjF5S1N5Y2hKY0N3?=
 =?utf-8?B?Tmx0Vzl2eWhxeHdHYzY3c2FuVTRVeHJ1SFZOUnIrODZlbHQ2Qlh2cWhXYWYr?=
 =?utf-8?B?NE5mR25RNkc1QlVSZmFPWU9ncm1DbDhlT3pmdUE5NTlML01VWHlRZzI4RC8z?=
 =?utf-8?B?bnFGMWVwYU5PbmZFTjVobjBoM093VHBERkl1UG1pZGltemY4VXVmVllaa2tW?=
 =?utf-8?B?RXRBT2o0WHZodlR0YStmSDZyNWV1TUdpdWRMMno2SkVnNlRwOURKczAxdGpU?=
 =?utf-8?B?d24rY21VT3dpams2SWtJY0s2bnJ4QmtJMXQzbXJlME90WFMvcnNqT0tDK0RO?=
 =?utf-8?B?akJ2ZFRxOXVQZmNDY3AxVVd2VlVyakUrSkpvdGZSaEhCc1NuM0pSZmZDelJV?=
 =?utf-8?B?Uk5pT2paQXJORmwrRS8rOWgwNUxPSjVMYXZobXkrcUE2RkduenNhLzFraDRo?=
 =?utf-8?B?U2tQZndQWmhFUlpsWm52Y2g2THlyZEhqWWRSdWYrb1AyTEptQTE0WkczYXdt?=
 =?utf-8?B?dzlSL00yNHkwL2M5aEEzOXg4YmtrdG1HWEtGTHBPdE9UUmhVU2VCbS9SbzJZ?=
 =?utf-8?B?ZGlVdDJVdFBwY1NNVmRvRjNHR3dHbnFBelJHTWxhZENNWExDb2J3dml0OFV1?=
 =?utf-8?B?UUV6V3FpMWIrMWcwU2pYVE1xb1p6aGpya3BOTGFMOUJyN05qanZqUVh6TlNJ?=
 =?utf-8?B?eGxRS2hPVFhaSmxFc3gxeEViTXpSYVUwL243NTczRTQzSDNjUXZPMzQ4OW1y?=
 =?utf-8?B?NktQa1hGenUwbUNOYTk2WDV4dmppa3VXaVBVN1R1Umx0eHJjOXJMM2hvRXVo?=
 =?utf-8?B?TFNaNDBNaDJ5ck5zV2FJcEx1eGYzZURoc0pjK2VkcUU2SHlGbkIvVXdlY04r?=
 =?utf-8?B?U294UHlRWUQydUtzUy9xNTc4dU41aDFqQkhkbTVnRmdPNFNxUXR1V2FPZGt6?=
 =?utf-8?B?T01GRm9xa2ZZSDdmN1NrT1EvZEQyZ3ZqK1BuWGUzWlBxbGZXSG02d3pYaGw5?=
 =?utf-8?B?M0FyOGdFczNaR0pNN3lIQUpRL2FCQ3FpK1piSXNyQ1RTZ2FVZTluY0tqWFJj?=
 =?utf-8?B?ajJyTlI2Z0E5ZzZJaWd2b1c1c3J3MFN0QTI3VXV2aENSQlJkREVpamNoOUI0?=
 =?utf-8?B?UWxuaWoxcVRJOFd1Y0h5OTNDaDhGVEdlYTZXQkxUbmRhak9lUXB1UT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d7dd6a-82a4-4de0-ff68-08de5839d7ac
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:37:38.9727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rP8xYGvWNqdO9cV8bxK454i8WnxTGR/2A1V9HabqcEzLBJNLUe5woLyhIPvpBcdnS8WK+CkMpm/zWGuqi72Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4793
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-45279-lists,linux-pci=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,intel.com:email,intel.com:dkim,intel.com:mid,lists.freedesktop.org:email];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[badal.nilawar@intel.com,linux-pci@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pci];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E730249DEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 20-01-2026 20:12, Shankar, Uma wrote:
>
>> -----Original Message-----
>> From: Jani Nikula <jani.nikula@linux.intel.com>
>> Sent: Tuesday, January 20, 2026 7:14 PM
>> To: Nilawar, Badal <badal.nilawar@intel.com>; Vivi, Rodrigo
>> <rodrigo.vivi@intel.com>
>> Cc: intel-xe@lists.freedesktop.org; linux-acpi@vger.kernel.org; linux-
>> pci@vger.kernel.org; Gupta, Anshuman <anshuman.gupta@intel.com>;
>> rafael@kernel.org; lenb@kernel.org; bhelgaas@google.com;
>> ilpo.jarvinen@linux.intel.com; Gupta, Varun <varun.gupta@intel.com>;
>> ville.syrjala@linux.intel.com; Shankar, Uma <uma.shankar@intel.com>; Poosa,
>> Karthik <karthik.poosa@intel.com>; Auld, Matthew <matthew.auld@intel.com>;
>> Anirban, Sk <sk.anirban@intel.com>; Jadav, Raag <raag.jadav@intel.com>
>> Subject: Re: [PATCH v6 06/12] drm/xe/vrsr: Enable VRSR on default VGA boot
>> device
>>
>> On Tue, 20 Jan 2026, "Nilawar, Badal" <badal.nilawar@intel.com> wrote:
>>> On 15-01-2026 20:55, Rodrigo Vivi wrote:
>>>> On Thu, Jan 15, 2026 at 04:25:06PM +0200, Jani Nikula wrote:
>>>>> On Tue, 13 Jan 2026, Badal Nilawar <badal.nilawar@intel.com> wrote:
>>>>>> The VRSR feature is to enhance the display screen refresh
>>>>>> experience when the device exits from the D3cold state. Therefore,
>>>>>> apply the VRSR feature to the default VGA boot device and when a display
>> is connected.
>>>>> I don't understand how you get from the 1st sentence "therefore" the
>>>>> 2nd sentence. Please elaborate what you're trying to do here, and why.
>>>> On a scenario with multiple GPU, only one can use the aux power and
>>>> the feature itself was mainly designed for the display case - to
>>>> bring up display faster after the d3cold.
>>> This is to enhance screen refresh experience of primary display.
>> The way it's being added, it's just really oddly specific.
>>
>>>> But yes, the right explanation for the why needs to be here.
>>> I will rephrase the explanation.
>>>> Also, although unlikely, we never know what users can do out there,
>>>> and perhaps we will have someone with multiple cards and display
>>>> plugged in more than one?! We probably also need a global
>>>> counter/flag to avoid a second one to quick in.
>>>>
>>>> But we definitely need to prioritize the first one with display connected.
>>> At present there is no way to know which one is primary display that's
>>> why check is against default_vga_device.
>>>>> So we have xe_pci_probe() -> xe_pm_init() -> xe_pm_vrsr_init() ->
>>>>> xe_display_connected() -> intel_display_connected(), and that's the
>>>>> only path and point in time to check whether displays are connected.
>>>>> If not, the decision is "not VRSR capable", which is just a weird
>>>>> concusion to make. The *capability* does not depend on displays, does it?
>>>>>
>>>>> If you boot a device without a display, and then plug in a display,
>>>>> no VRSR for you?
>>>> yeap, it looks like the check is in the wrong place. It needs to be
>>>> checked when going to d3cold...
>>> Yes, VRSR will not be enabled if display is not connected at boot.
>> Why? And this needs to be properly explained in the commit message. The
>> current one isn't enough.
>>
>>> *capability* does not depend on display but VRSR use case is.
>> Please at least don't conflate the two. Don't determine capability based on whether
>> the conditions on the use case exist.
>>
>> Contrast with, I don't know, FBC. The platform will still have FBC capability even if
>> the conditions for enabling it aren't met.
> Yes right, I think display can be plugged later after boot as well. In this case also VRSR should be
> enabled.  This can be handled through the display hotplug path and VRSR can be enabled accordingly.
Sure will add handling in display hotplug path.
>
> Also elaborate the reasoning so the assumptions, limitations and design choices are clear and
> why certain trade offs are made are clarified.

Sure.

Thanks,
Badal

>
> Regards,
> Uma Shankar
>
>> BR,
>> Jani.
>>
>>
>>>>> More comments inline.
>>>>>
>>>>>> v2: Move generic display logic to i915/display (Jani)
>>>>>>
>>>>>> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
>>>>>> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/i915/display/intel_display.c | 22 ++++++++++++++++++++
>>>>>>    drivers/gpu/drm/i915/display/intel_display.h |  1 +
>>>>>>    drivers/gpu/drm/xe/display/xe_display.c      |  5 +++++
>>>>>>    drivers/gpu/drm/xe/display/xe_display.h      |  2 ++
>>>>>>    drivers/gpu/drm/xe/xe_pm.c                   |  5 +++++
>>>>>>    5 files changed, 35 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/i915/display/intel_display.c
>>>>>> b/drivers/gpu/drm/i915/display/intel_display.c
>>>>>> index 81b3a6692ca2..97c74272fb19 100644
>>>>>> --- a/drivers/gpu/drm/i915/display/intel_display.c
>>>>>> +++ b/drivers/gpu/drm/i915/display/intel_display.c
>>>>>> @@ -8426,3 +8426,25 @@ bool intel_scanout_needs_vtd_wa(struct
>> intel_display *display)
>>>>>>    {
>>>>>>    	return IS_DISPLAY_VER(display, 6, 11) &&
>> intel_display_vtd_active(display);
>>>>>>    }
>>>>>> +
>>>>>> +bool intel_display_connected(struct intel_display *display) {
>>>>>> +	struct drm_connector *list_connector;
>>>>>> +	struct drm_connector_list_iter iter;
>>>>>> +	bool ret = false;
>>>>>> +
>>>>>> +	mutex_lock(&display->drm->mode_config.mutex);
>>>>>> +	drm_connector_list_iter_begin(display->drm, &iter);
>>>>>> +
>>>>>> +	drm_for_each_connector_iter(list_connector, &iter) {
>>>>>> +		if (list_connector->status == connector_status_connected) {
>>>>>> +			ret = true;
>>>>>> +			break;
>>>>>> +		}
>>>>>> +	}
>>>>>> +
>>>>>> +	drm_connector_list_iter_end(&iter);
>>>>>> +	mutex_unlock(&display->drm->mode_config.mutex);
>>>>>> +
>>>>>> +	return ret;
>>>>>> +}
>>>>>> diff --git a/drivers/gpu/drm/i915/display/intel_display.h
>>>>>> b/drivers/gpu/drm/i915/display/intel_display.h
>>>>>> index f8e6e4e82722..20690aa59324 100644
>>>>>> --- a/drivers/gpu/drm/i915/display/intel_display.h
>>>>>> +++ b/drivers/gpu/drm/i915/display/intel_display.h
>>>>>> @@ -560,5 +560,6 @@ bool assert_port_valid(struct intel_display
>>>>>> *display, enum port port);
>>>>>>
>>>>>>    bool intel_scanout_needs_vtd_wa(struct intel_display *display);
>>>>>>    int intel_crtc_num_joined_pipes(const struct intel_crtc_state
>>>>>> *crtc_state);
>>>>>> +bool intel_display_connected(struct intel_display *display);
>>>>>>
>>>>>>    #endif
>>>>>> diff --git a/drivers/gpu/drm/xe/display/xe_display.c
>>>>>> b/drivers/gpu/drm/xe/display/xe_display.c
>>>>>> index f8a831b5dc7d..54ed39b257ad 100644
>>>>>> --- a/drivers/gpu/drm/xe/display/xe_display.c
>>>>>> +++ b/drivers/gpu/drm/xe/display/xe_display.c
>>>>>> @@ -64,6 +64,11 @@ bool xe_display_driver_probe_defer(struct pci_dev
>> *pdev)
>>>>>>    	return intel_display_driver_probe_defer(pdev);
>>>>>>    }
>>>>>>
>>>>>> +bool xe_display_connected(struct xe_device *xe) {
>>>>>> +	return intel_display_connected(xe->display);
>>>>>> +}
>>>>>> +
>>>>>>    /**
>>>>>>     * xe_display_driver_set_hooks - Add driver flags and hooks for display
>>>>>>     * @driver: DRM device driver
>>>>>> diff --git a/drivers/gpu/drm/xe/display/xe_display.h
>>>>>> b/drivers/gpu/drm/xe/display/xe_display.h
>>>>>> index 76db95c25f7e..11d4b09808e5 100644
>>>>>> --- a/drivers/gpu/drm/xe/display/xe_display.h
>>>>>> +++ b/drivers/gpu/drm/xe/display/xe_display.h
>>>>>> @@ -37,6 +37,7 @@ void xe_display_pm_resume(struct xe_device *xe);
>>>>>>    void xe_display_pm_runtime_suspend(struct xe_device *xe);
>>>>>>    void xe_display_pm_runtime_suspend_late(struct xe_device *xe);
>>>>>>    void xe_display_pm_runtime_resume(struct xe_device *xe);
>>>>>> +bool xe_display_connected(struct xe_device *xe);
>>>>>>
>>>>>>    #else
>>>>>>
>>>>>> @@ -67,5 +68,6 @@ static inline void
>> xe_display_pm_runtime_suspend(struct xe_device *xe) {}
>>>>>>    static inline void xe_display_pm_runtime_suspend_late(struct xe_device
>> *xe) {}
>>>>>>    static inline void xe_display_pm_runtime_resume(struct xe_device
>>>>>> *xe) {}
>>>>>>
>>>>>> +static inline bool xe_display_connected(struct xe_device *xe) {
>>>>>> +return false; }
>>>>> There was a blank line before #endif. Please keep it. Ditto
>>>>> throughout the series.
>>>>>
>>>>>>    #endif /* CONFIG_DRM_XE_DISPLAY */
>>>>>>    #endif /* _XE_DISPLAY_H_ */
>>>>>> diff --git a/drivers/gpu/drm/xe/xe_pm.c
>>>>>> b/drivers/gpu/drm/xe/xe_pm.c index 3fe673f0f87d..e7aa876ce9e0
>>>>>> 100644
>>>>>> --- a/drivers/gpu/drm/xe/xe_pm.c
>>>>>> +++ b/drivers/gpu/drm/xe/xe_pm.c
>>>>>> @@ -9,6 +9,7 @@
>>>>>>    #include <linux/fault-inject.h>
>>>>>>    #include <linux/pm_runtime.h>
>>>>>>    #include <linux/suspend.h>
>>>>>> +#include <linux/vgaarb.h>
>>>>>>
>>>>>>    #include <drm/drm_managed.h>
>>>>>>    #include <drm/ttm/ttm_placement.h> @@ -387,6 +388,7 @@ static int
>>>>>> pci_acpi_aux_power_setup(struct xe_device *xe)
>>>>>>
>>>>>>    static void xe_pm_vrsr_init(struct xe_device *xe)
>>>>>>    {
>>>>>> +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
>>>>>>    	int ret;
>>>>>>
>>>>>>    	if (!xe->info.has_vrsr)
>>>>>> @@ -395,6 +397,9 @@ static void xe_pm_vrsr_init(struct xe_device *xe)
>>>>>>    	if (!xe_pm_vrsr_capable(xe))
>>>>>>    		return;
>>>>>>
>>>>>> +	if (pdev != vga_default_device() || !xe_display_connected(xe))
>>>>> Simply considering the places in the kernel that call
>>>>> vga_default_device(), this just doesn't feel right.
>>>> I also don't understand why to check this vga default device...
>>> As previously mentioned, a check for the default VGA device was added
>>> to determine if this is the primary display.
>>>
>>> Thanks,
>>> Badal
>>>
>>>>> BR,
>>>>> Jani.
>>>>>
>>>>>
>>>>>> +		return;
>>>>>> +
>>>>>>    	/*
>>>>>>    	 * If the VRSR initialization fails, the device will proceed with the regular
>>>>>>    	 * D3cold flow
>>>>> --
>>>>> Jani Nikula, Intel
>> --
>> Jani Nikula, Intel

