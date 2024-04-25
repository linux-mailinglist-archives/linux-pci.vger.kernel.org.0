Return-Path: <linux-pci+bounces-6684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2738B2D97
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 01:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F391F21CF7
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 23:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F4E15665E;
	Thu, 25 Apr 2024 23:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ck9wXd55"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7762599
	for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2024 23:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714087948; cv=fail; b=kIOt2BY1ddGyLX1Ck0oNkeIJuJvpj6Fnd6jCf7XBzMMWzQM8bNjFBCwjRS9/SEVDHg43aBzkYjoDHfC2uk3y4eKrM1u0plosF3oqf6nHaUa/2e+p08gBg4s76UhnciLwJfs/RHiBU0Rbi/3NYmogyQp3Fe6Xv0VKCeT/i0VJ86g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714087948; c=relaxed/simple;
	bh=60RHTf3bugL0oyCuQyld2RrwxzHHkCptb+whbdIdHCE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YSYXTXjZwB+PuXb1YO5gN12ncvu4aYbUHATdjnfGQcNJxh+c/Lq6hVPnD+K7FQHCzxL2EslTT7ounZjPXj7bO6eF3iXIbViv2TMZL5dxANYYwjNz42uWsUQtkbzF/U9P4iD8DUbIjORXmhLb5a/FA0aDPsRvOXGnxarS19UOv/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ck9wXd55; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714087947; x=1745623947;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=60RHTf3bugL0oyCuQyld2RrwxzHHkCptb+whbdIdHCE=;
  b=ck9wXd55y+Czzw12PhrLOHMaHtdWShY34DwzgdnrS+wwqUqwK/2ecmsB
   PwiIxh2DPew8qaV55d/Y++3D1zsNeHpUrKxYJQSfpFpHc/GeLt4XdRQs0
   xR0U90I8KYkE1ZdVxvb/yUHGMU3vlcupPw13wi21DYjqbKlLO9MmfuQj9
   89XF5BMzlQp9dN46cujh8Y8F9lwspaTBdXK9XyAEZXZVae9C5uEeYOG2/
   6XJW7jsArpEGeLjM1lmNeT8nEhZv7QmqOc5wfrrwXi/x4O/ca2mQjAB0D
   qqJg60pzeNVLSUvdCiau7tW7XQa/AF6gPjpqfxM64RHmtBBSzRf9pzzeN
   w==;
X-CSE-ConnectionGUID: lAdjROwoQCqU1fkYOnjAaQ==
X-CSE-MsgGUID: 4E85v+LLQCetmD8DU3oyqQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="32308891"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="32308891"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 16:32:27 -0700
X-CSE-ConnectionGUID: rRz8M498SAe2FN3yi6iRqA==
X-CSE-MsgGUID: ONO7Pvw5RcyX0Cfv/+1OGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="25308510"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 16:32:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 16:32:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 16:32:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 16:32:25 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 16:32:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lhq8K30FIAn5+d/2fOKLS15AAkFkbXLrSkNY29emH+prHNzxV2Yt1OFbCCV9PWtM3ysSkiXMWTGi96fvv0z5vRBAB8WNi2J83Dny8CIdTf9+Waj2MU5Af64P3aFzlSv/5L44faJjPvjyAgUFzTKV4gorUNYpVMjb7LqMN6PV4mNN64SeStFoin+5jJbGyTMurjaSuyvTvX6lm7+37udVr3gpa1n/DVgAyS4p+WH0jHfZMf/Z9V+B9/naTdnDSwzrDyhW+jskHI2+HO9n95AZ8U4A3txomOZQcITmFFvQxZKJj7eU3jK4pFKAUest3ah4yffFd81X9WZB/GWLJ+n7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6uM2i1qoLToN0LZYCb8apcgj4h5uSIjDrzFYfnlJ3o=;
 b=XH0vz1WGe6FT4wIQD590SdNrepplOgbV2YHKXHrV5tfMQT3Nx4bbPLUGQnMKTMuASdRETJtHJQrRVidq+ihg0LdTkVymJl/w/m3y5+fsFVZto3gdfmfaG2jsbYlBJAiGQxTUF+4qGRLISJ87EnnfRkjf9PUOLVx73vncyB1XlUXdR6eNuvY9FybBeK8FIC3vdXrpWo1PTBZzZ4h0jZVK+OMSVPxJ8wmVbE5F508vSN6pUCrNR5hZlvPzaeyZZL3LFK03D0LFPYHC3GCXma39YKvwIU/LRtOJtwNd2FNli+aMSgQaZbXh06wa+H1+1a8lGzJeVhZRwGactxvqkrDSHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by PH7PR11MB6700.namprd11.prod.outlook.com (2603:10b6:510:1ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Thu, 25 Apr
 2024 23:32:22 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 23:32:22 +0000
Message-ID: <51c5f46e-5649-4ab4-9828-5711dd06ee5d@intel.com>
Date: Thu, 25 Apr 2024 16:32:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: PCI: add vmd documentation
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, "Kai-Heng
 Feng" <kai.heng.feng@canonical.com>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20240425223219.GA546005@bhelgaas>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20240425223219.GA546005@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0079.namprd04.prod.outlook.com
 (2603:10b6:303:6b::24) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|PH7PR11MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 12bc78f7-f616-4686-9bcf-08dc657ff510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTBwUlNjY252RE9WZWVrcURYckxTTzFZUUVQOGY5Wi9aczRoTVBXdzJsZVh6?=
 =?utf-8?B?SytFWFZ4WGRpVzJSMFZ1R2ZlODVpNXFYR25xZllGejc2ZUZ2ZkdzR3kwRksw?=
 =?utf-8?B?L0RKamlUYStONE8wMGxQbFBJTHc0aGJJa25RYStGV3MzNkpMd0ZKV0lEWHFt?=
 =?utf-8?B?ekxkZVMvRUoyK1JWcWRMeXJhUGRIM0xqQSt6T2hGVEVzYVNDM3JIR2laaUFG?=
 =?utf-8?B?eTF1RzNmak9FSTc4aVdkQzl4czVCQmcyOXlRRXNrbkg1WkpyOHROcDhlcGhj?=
 =?utf-8?B?ZEY3UmJFM2dHbzRGazJ5aGpnbGFRRUlTMU91NDhpQUNGMHV3aHBTbXIzOEpj?=
 =?utf-8?B?d0M3Vk1EcHJPNkNFVEJsOGhOOTVjUFlDU0FVZ0w4K3RtaGpidFRtVmU0ZlZR?=
 =?utf-8?B?aXIzdGpQZEtMRnd4ODN3YjZqZWI2T1pYRUkvOG5xZGhIMXExVld6NXcrZkNj?=
 =?utf-8?B?ZU01MHo2RW5HM3V5TFlQdGNjSjhZWVo4VG55OFZnbmpOV2NUZjRtWTYzQzM5?=
 =?utf-8?B?dEd3YjFuVVNSZW55c1VzbFo0TnVvTlV3L2sydkp6c2ZwVGwrWkk1bDU5bjIx?=
 =?utf-8?B?ck52MXh2bmlhc3JKTTdDWll6eWU5RE1RLzFkNDNubksxTTh2bjdaQ0FZRFZN?=
 =?utf-8?B?UkJ2WUhLRFM0K09qdEczbTQrMkg0aUxmS3htOGl2RFIzUFdaMWIySGRmeXFN?=
 =?utf-8?B?RjNXSzVKTUM1Z0RvMGt0eFdEalBsWHBxL2MvZDBhR0VQVno5UnpJc0ZPekVK?=
 =?utf-8?B?M2NpaEJrTDRwdTdXb0duaHBGMExyMDA1WGg0ZFlORHNia1Z1bnVYajkzUExs?=
 =?utf-8?B?NVA0WU1KZENRQWpJeDJoVUtXNDlrcExJb3U2V2U0WkhxdzZoTUxuY24rb1Bo?=
 =?utf-8?B?Wk1ndHRQVnM4Y0NTKzRLY3ZTckxEQ3ppVC81dkV5Q2tZU29ZUUR0SDlmMUxZ?=
 =?utf-8?B?Q0RoVHZyc1IrYTRWRXFIWUk3RlJwZ053TysvV3ZVcG5kSjFwVjFRTnpaN1hV?=
 =?utf-8?B?UFFEcjAyVExOZi9IbXhBbFFSaU56MzNDZi8xYlFsa0N6c2NRS1lLLys2M0FV?=
 =?utf-8?B?MDRGcGFBUW83aEhublZ6aVNtV1I5U09TREJNTlp2WjNyN21mQjA3ZytYTk9j?=
 =?utf-8?B?K0FCV1NCV29MUDFCcnNtOEZQRlVpeFlvbTRvMHY2YXZTNnBMSm9jQzVXN1NG?=
 =?utf-8?B?N2JMNTIrcnNpeGsyenA4OUZxTTR4S3FqRWRoQWRYV0I5WHAydlZwbXpKZ2NE?=
 =?utf-8?B?clJLVGk2cktmVTlFK25JREh2dXF1aGx5TGhZQjdvZnFhKzNRdTFudVQzcDFR?=
 =?utf-8?B?MUtSSzd0ajZuR0FOSjdnaHpHUnZVUVBRZGdjb1JGSGNLaXIzUEM4bzNSc2Nl?=
 =?utf-8?B?anlhcG10L0VROTlVbWJ4aE9haW9XdFdNNTB2aGkyMVFvQkJBTlVnTG5qa3ky?=
 =?utf-8?B?WDZVbnJaTHRNeXBKdTF1SjhYQVM0SldVMzhLUXBMNkJ3eEhoUzJRWnNaZGlF?=
 =?utf-8?B?b1NaM3pPRlhvN2dmKzZRNWtTSGlGb1Ria2pyNEFkRTJJYldxZjJ2dlZ5VDlx?=
 =?utf-8?B?dGtGTHBpMjJxOWVOc2pYaHFxWVRNTndicFdWSUpiRDJOM2N4RTFqWU1MeUk0?=
 =?utf-8?B?ZmpVUHFvYkNBNllmZXcxb1VrRnFPZ0szSFAxblByUnZRaUF0OGY2T2tHQjk0?=
 =?utf-8?B?YXdNY1krV3ZwTUMxM3NhRHNpdmNtWnZPUjFvS1JXVlVZcUwybGxxbjF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEZ6SWNveFdnaGtKT2Y2eVdVSExpNnN6MEdWZW5lSmUwWDdteGh1cEdnRkF3?=
 =?utf-8?B?TWxxcjR5RmFXa05wMmthbWFxdDlkbElDT0pBdjkvdVc0c0tseUUrNk9pb0Jj?=
 =?utf-8?B?WGZGd1VLRWlrZE9leXJqVWJiaHRZL0tHODdKSVpEbzE2VmFuKzNJbEx5bHVZ?=
 =?utf-8?B?bXRhbVA1VURNRWErNStCQU1FbFUxQlBMZE5GNy9JWnBzb095bTkwTUJabXpJ?=
 =?utf-8?B?dERkdUMrWHVpOUFjNmZkVnVuRXhLNFJkaVYzSUZWYnNwWWdzOFVBTUpLeUtN?=
 =?utf-8?B?cnR5OEhFVU5RRjBYTDJQNE03UzlwOGxleGc3ckU4ZXhCQThNYjhRcTB0MkJX?=
 =?utf-8?B?RUpCK3QrdlUxTW5ZdEtOc1pGWmxvaVcrMUs0USt4TTI3MFI0czcxUG9Kb1lR?=
 =?utf-8?B?dWNhd2xQckRQVFFvdzdBSTVObGMweWE5a3BVY0ZTRTFsdHJoaDduMWRkWVlH?=
 =?utf-8?B?UnVsTWNTd3JIQ2txdGppZi9uYnk5L1pDb0FsMTBJUitZWmJXU290NmF6Ylc2?=
 =?utf-8?B?aHlxV05jQ1NpRlBKT21KdE5JdlRmSVdSWVhzRlN6WHliZ2I4MmVDUjFrT21m?=
 =?utf-8?B?emYyMEo4OStyMnpkOVEvQXk5RGVZT1BUS05Yd3Z0ZGhRaUREYTJaWHRFa2NC?=
 =?utf-8?B?TmVpVTZOLzNLUWdZZUlOYUt2Tk5hOFEwaFZHWGFaRFU4WTZZcSsrTXpmYkdL?=
 =?utf-8?B?ZkxiRHFITTN1TW9HbUNvUWZzclFRaXBHVWpXK1pza01IbUMxVXF3Q3BqTE93?=
 =?utf-8?B?U3JHRWhUeGxOZVlQS0xBVnBqRFAwUHNva1hrbXZpTUc3dC8rSUh0QmgwSGUr?=
 =?utf-8?B?Zy9IeUp2SmhMMVI0TlhWdElRZ1FpVHdGZ2NaOUl3aEZVQm5rVFpTOXEzenFu?=
 =?utf-8?B?SWNxMDJHQ3E0bXFyZXJldTdlRU05RWc5Skg5KzZNQjJBdSthcnlUSmpuVDU1?=
 =?utf-8?B?R0VnUlJUbTF0UWUwKzV6NVlEdkFtVkFCS2wrVFdaa2NnR2EvcDk3blVSNmx3?=
 =?utf-8?B?NEI4Ti9sYmxmTmpyWTVnSCtZN2JlZTFCZUkwS2U1ZGIzVy91Mkd5U3VuTGxu?=
 =?utf-8?B?MXl6aXB4RzdaWXo1NEtIWlpMMHJwcmlOamZUUmVGOXUyaEJ3Z1dOaW1waFpp?=
 =?utf-8?B?eGdPclFiRmJmR0FESEF1QlUvZjFBNmdFMG5zWjFOTTBYMmRraDgzY09TdU00?=
 =?utf-8?B?bzlBU01DS0tkUlJrVjJiQm0waGhoUjBDdENucEd0MTJxQUdTSlZhZXBscWYy?=
 =?utf-8?B?RSs5K3BKaWRKQ0JabU4rcmxCa0EyZDNvWkM0VUdJa3QvT2owaE9KYXRReGRP?=
 =?utf-8?B?NXgwR1pUQUd0bS9QWW1VN3l5Z1c3QmswTFJ1ZzFHdm8rQVQ5VWNRTEF3Z0hr?=
 =?utf-8?B?M1Q3c0pBODVPQzZ4bUV0TmtkcVhDY1FHSGYxVFUydnVYOFFoYWwvSVNJMlBs?=
 =?utf-8?B?Ti9WS3psUEZkK0I3ZjZ4bk1KWXQ1STcvRmRRV3gwVmtLdFUyKzkwMlVXL255?=
 =?utf-8?B?Q0RLUFkxdm11TjVvc1RENDgvKzRpQWxhVEtGbWEzNDFUQUpvY3YyV210TFJl?=
 =?utf-8?B?LzhoTkZOTnd6YnJCUkYrejZnNHJxWlpFcElPRjZaRzdxN3NjZmdoQkd3L3Zr?=
 =?utf-8?B?ak5xVFM2NkdvNjZPbEdJMWZkRFUyQVp6WVBXbzJTcG9kYXlUNS9yaUJtSTBl?=
 =?utf-8?B?NjRMY2F3M3ZFVnNiSWROdHNGUDZnZkYxTkdzM2tWTFpjdmpkNXpUSW9HKzhx?=
 =?utf-8?B?bVlxM1VNMU1XTWdrbWkxVXI5enBmY3JRT3crS1I3bEVvblQ4L1VIUkRmWGE0?=
 =?utf-8?B?Z01aU2Qwc0h3YzFNbnJnemhkWDBEazBET1NvbUQyb2JVSVpGOGNURnBLNVRh?=
 =?utf-8?B?WmpidEZxTUhGTnMrOTJiTDZBMENZL1B2SHF1bXhhSzA5ck5kVXl1ZVFqQzNR?=
 =?utf-8?B?dFVrRVp1cGhLUXJVekl4MjJFc0tvNEJKM0NrM0V3OXBGU1BVNmpsSmVQd2FK?=
 =?utf-8?B?UjZyOGUzUkdBNUpGeW1qdnFVQTE1d055UFVuWkRRQUFRejdmUVB2UXRibC9i?=
 =?utf-8?B?MFNTQUxEV096b0h6Qi9ONFdaR0JlcnpsUkVUWjhra1JMa240V3ZNSGlqV3Nt?=
 =?utf-8?B?K0p2MHoyOTRPbE5nOW1pc09KR1ZES1Bpa3JTazRLRlk2S3BVZWpNMkgwM25W?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bc78f7-f616-4686-9bcf-08dc657ff510
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 23:32:22.7382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32+OoGWs3UyVdeCzbDaXrjy6MPtlmFgdkVljZpWRcY/VIiBqnh87CS05XgdrWsSWlcoeskV3+MpyjWOfWUIXFLa5PgFdeqKr3Jx4wtewk5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6700
X-OriginatorOrg: intel.com

On 4/25/2024 3:32 PM, Bjorn Helgaas wrote:
> On Thu, Apr 25, 2024 at 02:43:07PM -0700, Paul M Stillwell Jr wrote:
>> On 4/25/2024 10:24 AM, Bjorn Helgaas wrote:
>>> On Wed, Apr 24, 2024 at 02:29:16PM -0700, Paul M Stillwell Jr wrote:
>>>> On 4/23/2024 5:47 PM, Bjorn Helgaas wrote:
>> ...
> 
>>>>> _OSC is the only mechanism for negotiating ownership of these
>>>>> features, and PCI Firmware r3.3, sec 4.5.1, is pretty clear that _OSC
>>>>> only applies to the hierarchy originated by the PNP0A03/PNP0A08 host
>>>>> bridge that contains the _OSC method.  AFAICT, there's no
>>>>> global/device-specific thing here.
>>>>>
>>>>> The BIOS may have a single user-visible setting, and it may apply that
>>>>> setting to all host bridge _OSC methods, but that's just part of the
>>>>> BIOS UI, not part of the firmware/OS interface.
>>>>
>>>> Fair, but we are still left with the question of how to set the _OSC bits
>>>> for the VMD bridge. This would normally happen using ACPI AFAICT and we
>>>> don't have that for the devices behind VMD.
>>>
>>> In the absence of a mechanism for negotiating ownership, e.g., an ACPI
>>> host bridge device for the hierarchy, the OS owns all the PCIe
>>> features.
>>
>> I'm new to this space so I don't know what it means for the OS to
>> own the features. In other words, how would the vmd driver figure
>> out what features are supported?
> 
> There are three things that go into this:
> 
>    - Does the OS support the feature, e.g., is CONFIG_PCIEAER enabled?
> 
>    - Has the platform granted permission to the OS to use the feature,
>      either explicitly via _OSC or implicitly because there's no
>      mechanism to negotiate ownership?
> 
>    - Does the device advertise the feature, e.g., does it have an AER
>      Capability?
> 
> If all three are true, Linux enables the feature.
> 
> I think vmd has implicit ownership of all features because there is no
> ACPI host bridge device for the VMD domain, and (IMO) that means there
> is no way to negotiate ownership in that domain.
> 
> So the VMD domain starts with all the native_* bits set, meaning Linux
> owns the features.  If the vmd driver doesn't want some feature to be
> used, it could clear the native_* bit for it.
> 
> I don't think vmd should unilaterally claim ownership of features by
> *setting* native_* bits because that will lead to conflicts with
> firmware.
> 

This is the crux of the problem IMO. I'm happy to set the native_* bits 
using some knowledge about what the firmware wants, but we don't have a 
mechanism to do it AFAICT. I think that's what commit 04b12ef163d1 
("PCI: vmd: Honor ACPI _OSC on PCIe features") was trying to do: use a 
domain that ACPI had run on and negotiated features and apply them to 
the vmd domain.

Using the 3 criteria you described above, could we do this for the 
hotplug feature for VMD:

1. Use IS_ENABLED(CONFIG_<whatever hotplug setting we need>) to check to 
see if the hotplug feature is enabled

2. We know that for VMD we want hotplug enabled so that is the implicit 
permission

3. Look at the root ports below VMD and see if hotplug capability is set

If 1 & 3 are true, then we set the native_* bits for hotplug (we can 
look for surprise hotplug as well in the capability to set the 
native_shpc_hotplug bit corrrectly) to 1. This feels like it would solve 
the problem of "what if there is a hotplug issue on the platform" 
because the user would have disabled hotplug for VMD and the root ports 
below it would have the capability turned off.

In theory we could do this same thing for all the features, but we don't 
know what the firmware wants for features other than hotplug (because we 
implicitly know that vmd wants hotplug). I feel like 04b12ef163d1 is a 
good compromise for the other features, but I hear your issues with it.

I'm happy to "do the right thing" for the other features, I just can't 
figure out what that thing is :)

Paul

>>> 04b12ef163d1 basically asserted "the platform knows about a hardware
>>> issue between VMD and this NVMe and avoided it by disabling AER in
>>> domain 0000; therefore we should also disable AER in the VMD domain."
>>>
>>> Your patch at
>>> https://lore.kernel.org/linux-pci/20240408183927.135-1-paul.m.stillwell.jr@intel.com/
>>> says "vmd users *always* want hotplug enabled."  What happens when a
>>> platform knows about a hotplug hardware issue and avoids it by
>>> disabling hotplug in domain 0000?
>>
>> I was thinking about this also and I could look at all the root ports
>> underneath vmd and see if hotplug is set for any of them. If it is then we
>> could set the native_*hotplug bits based on that.
> 
> No.  "Hotplug is set" means the device advertises the feature via
> config space, in this case, it has the Hot-Plug Capable bit in the
> PCIe Slot Capabilities set.  That just means the device has hardware
> support for the feature.
> 
> On ACPI systems, the OS can only use pciehp on the device if firmware
> has granted ownership to the OS via _OSC because the firmware may want
> to use the feature itself.  If both OS and firmware think they own the
> feature, they will conflict with each other.
> 
> If firmware retains owership of hotplug, it can field hotplug events
> itself and notify the OS via the ACPI hotplug mechanism.  The acpiphp
> driver handles those events for PCI.
> 
> Firmware may do this if it wants to work around hardware defects it
> knows about, or if it wants to do OS-independent logging (more
> applicable for AER), or if it wants to intercept hotplug events to do
> some kind of initialization, etc.
> 
> Bjorn


