Return-Path: <linux-pci+bounces-35931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9933B53B4A
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 20:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95127170C25
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 18:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B0824DD13;
	Thu, 11 Sep 2025 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x1JJXXJ8"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216E947F4A;
	Thu, 11 Sep 2025 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757614745; cv=fail; b=Fxx9nBUcPZqPeThAPfH+kJ0Cz98crOtIgFiQg/iiT2quj6i/odv7xkI1u4S+FK5PU45QMr5Jg+/tD5ggjuNnuzs5u46DbjFkxJQ4afvJeIzSZkGwAhZgzEdL6ePnHO9MwrYK7q5VGvxv32C3r5/0moM7Ts3SOWBrK5hMSuz/2/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757614745; c=relaxed/simple;
	bh=vor7kAXW0i1xpQBteEDMgyedU9A/uvZguOV27zOrqX4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=clJARua2SminHcBFZJyVzi2d0x7J87S5q3TvciCMOX3V06CVjPlgUeHSBAPcIoMyFpH4RUYAnV+VPzaEZtCl66tuR/AmTqOAmtXk3eViN0yaI2a+6ZDoecNlOq4i6Vgu+IUvHoXwVwA7HbogBGrdWjDDCMb0YsCyWS0Cdm+/iJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x1JJXXJ8; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xscU4JrlB5fxfSrWLQdoEpWWutLJ76k0ivlH/PLNb2IbL5qXjDVDthoHVRUOwpXsib0cQzTszP5DGlM98IYCRcJ64qPxkOAchZvZBPz8yDXVhoBnHSBcKmhcDZVsZd5t+tOPfFbEhBj6cx7WNlskprQNt400jmd8E1GfsE7TVK8z/QL5suE0TdxAKxhqJ+EFXvbZv9XF3ro6gXiuniZHQFRzvLmPU5O+GoNsRiigwK9DTdhMxOz4t7GWzxZpNVmdT8MjVLc/InFWHl+9Q7IXY7kzWwoCC+rOovJfWq49iLpkhX+gotRF8R9E9glHggUEzZX3g3e7JhQykZBVHXn3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sIID+5/OUZqHVUkB3eQY7ymW+e6GWmmkthqw4L+j3w=;
 b=r1Gr3ymK5fyBwEDM0meJZ9s3tQKA7HSyHKXAvAsPTc7wk2bopOEnWYGXegLryoayVyGRCx0mEDi6GUxzVDneJMfMJ+5QLPGQPspz4wT3ao+paJlwQMnRJsN8S6Vgfi2M/iuABZK2U9SSTsjeRhFBLl9vdYl+E4guzjA/H0Fy4hvslS85mF5ixI6di4S9hWTaYSn+9CebSDhyxT7jR9G8jFGydnrv7KxwE9mNey4KXMGj5pfOoEv1CDSM1NcvIXzBKoRheDWudbzQ6SsoVqsBtcRdVnGm5XelMU8uBQJd3w/WGvMlGf3IaxgR6g6Zvt8ECpCMLbzDUfevEQP8S9mQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sIID+5/OUZqHVUkB3eQY7ymW+e6GWmmkthqw4L+j3w=;
 b=x1JJXXJ8zH8IPaA8QynQP1rGoTTdCa2Fgt0Fu9ZJrhqc4Pv7yEpp84LtSS5SaAMR97an26pc1PvwBiKhpdI94egCmrGLwhfjs4OLBu8ftgoGiH4cEQK8perYcCNPHMuaqwrPlX7MV9GEuqxRtV4D/WfeJI5eJyJxTkwWVTEQXl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 18:19:01 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 18:19:00 +0000
Message-ID: <0e3baee1-0909-489c-b6a1-1d64e988e16b@amd.com>
Date: Thu, 11 Sep 2025 13:18:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/23] CXL/AER: Update PCI class code check to use
 FIELD_GET()
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-11-terry.bowman@amd.com>
 <20250829170320.000010a3@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250829170320.000010a3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:806:130::26) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 3975ea18-a83c-46cd-e741-08ddf15fae58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEszazZacFNTaVZWTnNZeTVsWE1oTkRpejl2dHU0UUlLdmp4QlNSWG9HSkpk?=
 =?utf-8?B?QjRQMVFWSUQwY0Q3R1RBZkkyek5XZEROYnN6QWg2K00ybGFTSnIyNHVmQlNB?=
 =?utf-8?B?a3ArYzhGdktEOTFOOUlwT25VK2M5MEN3Ylh0SWlPT3k1aWRJSFpvcFJPcG44?=
 =?utf-8?B?Zi9RSzVEcDNtOHY1VkRraDllN2tmaEo4c1VoOFNxeFlQUW5sWjdtbXFjL1Bx?=
 =?utf-8?B?M0c3eHVTQkZoTEc4cWFXLzNFQTAvdnJqR1RkL1lCZnNPZjlqZUk1RlU0VVZ1?=
 =?utf-8?B?MWozUDltMHA4YTlHNktSV25lTkMyM0FNeUEzRVplcnNJSUpqb2UyaFpuV0tv?=
 =?utf-8?B?L0NmQ3oyeGYvZnNJb0NLMC9hT29GSGFoRUNpOHdvUUZLR1pMcVlBTzZCd3hT?=
 =?utf-8?B?M084UWdrSURrakJmYXVGaEgwSWcza3pyTFQ4dEordC9Lcmx3MndTamVTRW1X?=
 =?utf-8?B?TVR5WXRoMGtVeEp2OXlTSFNVRU9UTlBQTWxDdHZvVFF4WVhxVlR5enQxaWdh?=
 =?utf-8?B?V0o4SU5MK0ltc0VhV2xmYXVSK3ZkcFdNdkJQY2wzcEh1bEZpRXlPQkM4cHJ2?=
 =?utf-8?B?MlcvUXYvUjBlZXlSWVV0VUs2ZjJXK2JDWWMzL2hrOGFUc3Q4dTA5V3puTkhQ?=
 =?utf-8?B?NG9jNTBCclZWdXB5SE1Zek9WdExZdSs5K1dTdlpEVmNoOFdpbHRWK2tQN3FC?=
 =?utf-8?B?cDhxOEwzMnd2cHpoeVE4aHg1QS9wUmphWkhZcUoyeWErZWtDS2laWElXRUJZ?=
 =?utf-8?B?MHFLMHhNVmxhUEdPS29XVGxiaG5hczlTcWM1ZjVMSEZ4NDBNdTl4TXdFdEEv?=
 =?utf-8?B?cmprM3pxNW9Cdk1YRW8rQWxUYW9Vd2ZHeFg1SFcwb0xnZzd4TnRPc284NERl?=
 =?utf-8?B?WThHWVZ0S0NaVkNHeWJCbmkxVVdML2wxM0grVHdZOWg4ZEFqdGZiY0pJN3cy?=
 =?utf-8?B?L1VGYlprV0dJR213ZWZ2ZldydlR4d3FMeEFOQkFQZzNsUmRqT216V0JDRno4?=
 =?utf-8?B?ZEVEZ000L05lWFF0KzRDZTBMV0c3UndlTUJCUVJqaTNjNi9OTDNOU2VIMkht?=
 =?utf-8?B?Y3VMZ2FuUjdIL3F3VlhVVDYvWkk5Tnl3cTcwWmJ5L0U3dmtqN0lNTTYwNlBh?=
 =?utf-8?B?bFdKQTlwQ0prYXdWMHdpTExIZzdtbEJKK3NXWVY4UjRLVytzcWRWdEpWeDcv?=
 =?utf-8?B?b2FPVFhiRGR1V0cwV2hxdGtmMk5PS2paY3BEZGdSVzZObUNaTms5ZitISE12?=
 =?utf-8?B?bENuMHFIMHJlOENwYzNITm93S0E0UStqTFZ1Qm81ZExtbmszcnlNcFdyYktV?=
 =?utf-8?B?VU1Qczc0U0xGVmJTd21RTEhvU3IxYW9SZU9BUjZpcFlEMmxnVWdnMGhEVERE?=
 =?utf-8?B?ZmFLeUptVHdOTWVzVnpsT0ZHcCs3ZFY2MDVGYkdFUXZPUFRCUEZDVUxiSTJj?=
 =?utf-8?B?aW1uTGFWR0VQcVFybFhvaUxIRit5WlBwNkhUZ1VLSmdmQzBNR3pYN1hBU2Vj?=
 =?utf-8?B?OWxCVU9TdWhEVm51TFo3R3pEbzVibTg2SllsRUg4VlV6emtYeWVSdU5NMWZX?=
 =?utf-8?B?ZlRIOTQyaTdNWVppWVBueHBtUkh3VmQ5L0dlVzhjcVVURTFOVC9Od1B5WWR4?=
 =?utf-8?B?QjZQczM4RXRJQjNkL3RnSE5ydkJsUmJ4QVkxekxZSEd6bEhoN0xEd1dqK2RV?=
 =?utf-8?B?WkgzeEhFWldmeWxpQ1hqaFI0eEhyTVU5ejVkbElNb2ZoM3luYnAvRVJVb2lu?=
 =?utf-8?B?K2hIZzY3TDgzZW9YeCs2ZkM0bnVORHpkaFNmZm14V0QydlZONVBySzN5ZytD?=
 =?utf-8?B?WGlVeUEzeCtuN29sblludTY3QnpZTThaWEg4LzRnZURzL3J4N1Z3RzFxRm5K?=
 =?utf-8?B?YjduL3JZUEk0TGRQK0x4Rko2NVlRN0tCQkpGRkwwVmdzSFlJUG5JWXVMRjlj?=
 =?utf-8?Q?xT48CvF8OSk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c293RFBoS0d1YzNtdS81K2xyOE83dDk1SnNoVU5wWFc5Sk5xbzZRa1VOV1hz?=
 =?utf-8?B?Uks3NjBXWTFFOTVFSURVbHJ3TTNKS0lQUUhVTHJKeUhpU3RZNTc3eGh6aWNv?=
 =?utf-8?B?UTdiZS9BVC9GUGpMUmFwTFMvUmdRa0ZCS24wcGNsaHhNNVl6ZHlVdnozT2Fm?=
 =?utf-8?B?bFp2THNrZFVscTVMZFR5U2Y1UGFxN0Vkbm9QUnZKUHdhOFNYaEVRYlk0bDRN?=
 =?utf-8?B?SHRtNjdydVp5eWU4TmZ6RmdwWUI4d0ZaNnExQWx1WFViMTNzQ1o0azdZRWI5?=
 =?utf-8?B?ZTBUNXBkVDI2M0x0YTQvV3A4Qk43bUtYVDNJYzE1RWFZSTB3T2I0ckcwMjNs?=
 =?utf-8?B?cGxmMzl5YVdZVHo3VDhtam9MUHZHcmsxTmdvaFVaT2MxTk9zWG9ZQW43cXJY?=
 =?utf-8?B?N3B4MkduSEFsUW5UK1ZLT0hyN2ExZzd2QTI3NEhMNk5tOHAySG90OWVaYTRu?=
 =?utf-8?B?NURwb3I1OE1aZmpROVZuTWFrTHR5SGRmUGN5QXFUbVA2WDZqejR2TGpHWVlN?=
 =?utf-8?B?SmJRL3FiY2xWVVg2VXNpMHE2TUJhQ1VaZS94bFNnT0NtNVZqMExva2trUnI2?=
 =?utf-8?B?MEFYakhSNmI3bzVIclBPaWhsckdCWlBDQnVuOXJqdnNwc2t4ZlFuVmNkQXh0?=
 =?utf-8?B?WGgyeEV4czBPU1EyeWpVcFZKelRhbFlyT2dMaURmVi9Kd1lRTzF3aytuR2Nx?=
 =?utf-8?B?K0gxNXc5LzY0THEyOGtFRHh2WDlmSlhTTGpCVFUzRlRjUDZkVVdWN1N6Rmg2?=
 =?utf-8?B?UVJpc0R6cDJYbjNnZWpFa2RjcXR5THJqNUNWT3VjV3A2NmRaOFltTzZLUWJY?=
 =?utf-8?B?QTlxb3k4akl5L1NBVUx6OTJGdk1CcXM2WWtoZXNBS2xoektyQjhyYlJrWGht?=
 =?utf-8?B?cE4xOThZanlhWURzejRobWVBc001VzZmcFBZM1Jwa1pJZTZwWlhEVFd0cFVK?=
 =?utf-8?B?dWQ5dlFTYzlHb0pma2VCWE1hSTFjLzc0VGQxM3BKTFFGb0Exdk03SjJJeU9Y?=
 =?utf-8?B?NEhSc3ZheUVPckwxelcwcHBDekRXZDl0VHRNMmRBVEFhTm9lQUVZNFBDVFN4?=
 =?utf-8?B?enJVVUxiaUxRK1lDN2tmcDJsTUYwU0NiWXhianh2NUVwME5mMjA0ZUJCTzlr?=
 =?utf-8?B?a0FISGptTzhYWW1ySlFSRVduc1YyVmE5NW9PRlJwVW81V2lKamhRMkZaL0J0?=
 =?utf-8?B?WUk1SGdENGRWa1JhaFV3QzZuNFVOVTJRSS9jOEdQeHBnVU12a1FqQ2pmRk1o?=
 =?utf-8?B?N1BZNmQxQVpCRGRCSTdmNFRuNTdqVnU5emxJSCtiME5jYitvZUUyYTY4dW52?=
 =?utf-8?B?cmdiQ0ZrczZDTVI2cDZQMnNyakpWMWhnUVUzVUE5Q2pCM2FiSmNIdEhJaTdL?=
 =?utf-8?B?RmVSMFk2YjFqK1kzb3NkT1crOU9YRlM5dGNEYWhMSnVaU0lNb0xrRy8rUXFl?=
 =?utf-8?B?ampGMGFFaHNTazNPVFAyOCtkVUNOZ1RnekJZWjNOTzFGbUp5WUFDWFlwcGFq?=
 =?utf-8?B?UFRWdDRrcFRhTGRnOWJHUytyZWRBc2xqenlGOEtIN29lT1Zvc2dtNGFSR0lW?=
 =?utf-8?B?TjZWSiszUnZqeTlKM3BEVHN1bmZoUHkyTDBRbFVjc3lRSlJvZnYrM2d3Yk8v?=
 =?utf-8?B?aWVURGY2ZU1XdmJYMXVqM3ArUjkxRmVDTFBqVjVEWlNvem1lM1l0MnROeCtL?=
 =?utf-8?B?amhLaFJ4RlA1Zzg2RWNIdlhtR2labjZTY09GV2pxK0RidUx5VWVXWVpKblE5?=
 =?utf-8?B?Q2RmTmYrRHYway9EZjB4YU9RdVdaWWVGK0RNaG1idExpSVpZbUpPMWJxd1E3?=
 =?utf-8?B?a2M5Y1V6WTZTQjdZU1VYSC91aDZEV3UwSEpTYXVmYnJxQTJGR3kwYW1XbUlN?=
 =?utf-8?B?K2lQTTB3TjR2bHpUSFE1OEYyNzJMTkJoMXhnRjhoSE1lZG4yTWxOcG5pNDVn?=
 =?utf-8?B?cmc0R0V6WDQ0VVZXcm54QUxsSUxySE1rQlJSakExMStXUytoTDlGaUlqM2hH?=
 =?utf-8?B?RFZIdW9iZm1ncnBWbWkyclhoS3VCTEE2TW5mcjVtMUU2aE9jZlViU2NXOVlq?=
 =?utf-8?B?OXlGNWdRN2FuQ1JoUWVRTUY2ZmFOeXU0MXR2Y0IyMlNHUGlvL3RTVkhkeE9Q?=
 =?utf-8?Q?QmjlS5kNWaGADOYhsDVjBHKTE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3975ea18-a83c-46cd-e741-08ddf15fae58
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 18:19:00.7852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPsPIXayndPZHTjqzPQiC2ooXGZB33zF08Qpur68xEQhoBIyKI5rmlwt4crenhwRtBCbCfg56KbA3lLgB1T4cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491



On 8/29/2025 11:03 AM, Jonathan Cameron wrote:
> On Tue, 26 Aug 2025 20:35:25 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> Update the AER driver's is_cxl_mem_dev() to use FIELD_GET() while checking
>> for a CXL Endpoint class code.
>>
>> Introduce a genmask bitmask for checking PCI class codes and locate in
>> include/uapi/linux/pci_regs.h.
>>
>> Update the function documentation to reference the latest CXL
>> specification.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> In general I like this change, but maybe we should make a broader use of
> it even in this introductory patch.  E.g. use FIELD_PREP()
> in cxl_mem_pci_tbl() and perhaps add a define for the mask
> of the programming interface as well?
>
> Maybe use it in pci_ids.h (which raises the question of whether
> it's in the right place) for PCI_CLASS_BRIDGE_PCI_NORMAL / SUBTRACTIVE
> and the various USB definitions that include the programming interface.
>
> Perhaps wider use is something for a follow up, but nice to at least
> use it everywhere relevant in the CXL code to make the justification stronger
> from the start.
I will add a TODO item to the list at a lower priority for replacing FIELD_GET with FIELD_PREP here.
>> ---
>> Changes in v10->v11:
>> - Add #include <linux/bitfield.h> to cxl_ras.c
> I think you missed and hit wrong file!

Yup, thanks.
>> - Removed line wrapping at "(CXL 3.2, 8.1.12.1)".
>> ---
>>  drivers/pci/pcie/aer.c        | 1 +
>>  drivers/pci/pcie/rch_aer.c    | 6 +++---
>>  include/uapi/linux/pci_regs.h | 2 ++
>>  3 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 1b5f5b0cdc4f..ed1de9256898 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -30,6 +30,7 @@
>>  #include <linux/kfifo.h>
>>  #include <linux/ratelimit.h>
>>  #include <linux/slab.h>
>> +#include <linux/bitfield.h>
> This seems unrelated as no use of new stuff in here.
> Also, looks from what I can see here to be alphabetical order.
>
bitfield.h provides FIELD_GET() added below.

Terry
> .
>>  #include <acpi/apei.h>
>>  #include <acpi/ghes.h>
>>  #include <ras/ras_event.h>
>> diff --git a/drivers/pci/pcie/rch_aer.c b/drivers/pci/pcie/rch_aer.c
>> index bfe071eebf67..c3e2d4cbe8cc 100644
>> --- a/drivers/pci/pcie/rch_aer.c
>> +++ b/drivers/pci/pcie/rch_aer.c
>> @@ -17,10 +17,10 @@ static bool is_cxl_mem_dev(struct pci_dev *dev)
>>  		return false;
>>  
>>  	/*
>> -	 * CXL Memory Devices must have the 502h class code set (CXL
>> -	 * 3.0, 8.1.12.1).
>> +	 * CXL Memory Devices must have the 502h class code set
>> +	 * (CXL 3.2, 8.1.12.1).
>>  	 */
>> -	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
>> +	if (FIELD_GET(PCI_CLASS_CODE_MASK, dev->class) != PCI_CLASS_MEMORY_CXL)
>>  		return false;
>>  
>>  	return true;
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index 252c06402b13..c7b635f6cf36 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -73,6 +73,8 @@
>>  #define PCI_CLASS_PROG		0x09	/* Reg. Level Programming Interface */
>>  #define PCI_CLASS_DEVICE	0x0a	/* Device class */
>>  
>> +#define PCI_CLASS_CODE_MASK     __GENMASK(23, 8)
>> +
>>  #define PCI_CACHE_LINE_SIZE	0x0c	/* 8 bits */
>>  #define PCI_LATENCY_TIMER	0x0d	/* 8 bits */
>>  #define PCI_HEADER_TYPE		0x0e	/* 8 bits */


