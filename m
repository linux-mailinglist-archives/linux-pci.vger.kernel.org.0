Return-Path: <linux-pci+bounces-29002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49127ACE4BE
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 21:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA663A37A7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 19:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD9F1FDE1E;
	Wed,  4 Jun 2025 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r0hUnCxX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214D41DC07D;
	Wed,  4 Jun 2025 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749064901; cv=fail; b=sPmtIzxhAxdZnFnZJ42mxWO4b2sO/cKiDcQ9SJzy1YL4bX7z+ix0JUHRUyQG/xqxgEivRDlZTGI7eVAz9ULCHS+G6s6gc+LBwsl3OWifOaTdpnBbytQJZg9z6gK4/UBrJddvSBkJGdWUXC4yacKW0ch7YLRJGiov31er7q+GgWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749064901; c=relaxed/simple;
	bh=2BetJEeh38F6a9rV3GKD9lQKMfTHrQ+xm5NJFrL9Zlk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ag/Vrc8vH1XckonYiBCDfSGvm/hvIUa8ntZGzihPb/0KEDJ+vldEeS3JM2880k3v9JBixJC+sjxyfI5uBTud43xUvcayB1EL+AGThfJa/MI5nxCSO/2V0NdPnQ/v94vpteT5KIbry1taDRWBJSL5mzP+eRmXEmraw9r9jTViJUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r0hUnCxX; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTV0sKowpL1aOMAtz8EZucMbQbpcROKMwEZkmVo99HusrfW800kJs2muc/IUigPv1Ty6vCHxLCuTPH+yL1XAA8sLwSK0wLdiCdRVYY2u5Y+cabctJ4/8Sz8E/6Ez0Y9S5i9FVVG8G4pASkIe064TduL1JXsN2M5ZMvj/rROgKirF5zsM7tUb4nWwS2PxXg1vlYlU5cmHQDYg5qHuoPevYa9o6PR+Twqd2iS+DSwNOVPOIzMdK7O5i0LwOiW3INtbPR4lxzy2fnhh1JuG2GAeszP9tSo+LueQIM9ndZbuVDWr2x1olAdH1skxPL/zUWFzofY1LjL4L8pxbU8wENSKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dS5T7AQ4wSn4RJgfX05GCCT0MMMILsvQFA8mSxtiPXg=;
 b=rzc0zsZK/gaDAzzOAehyn1UTTifimXfj3hN0uiuQwHDCoYP+RFtmwbDoTlDKdIKCYDAMBNzWXpaV3UtRrxhYdQUPeSXXkoXagKb2vaFtOW/2x4wQ2mWAaMWnzmco3fNhtsB7DuHkcE4N7e0+onAsBx/fN+8RWl4L+MBzitEyM7K0p4+QThPPVRm6rEluQJyjyfgCvqkgF3x24E9/V1OqNTi0hIuiJGxLvjz4rYXCocQE/tuxqhDV+cHd/qBgQIvaHYAf67AXZOjO5ZTxrzvnxDpIWBnkDMhlhyZV7AWJNYuvv8z6zgIoQpsWm+nMIwVqXEkpFypqNvIRj+Ap/QCSag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dS5T7AQ4wSn4RJgfX05GCCT0MMMILsvQFA8mSxtiPXg=;
 b=r0hUnCxXnz/7ZV46uWoDI/4TWnaYIAdeMDURf/sdAaisxrG9nuG4z3hxXxp6J6PXXt8brFdAjpJqY/rJKqN/qFJVORlIgP7Kuj7No7nXvyM2ABgoxnLHEWP+XTYmI3zMiDPb5gISDtY7b+wry2DdsT2BAmiFb1YR6w1ZsSqh7uY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Wed, 4 Jun
 2025 19:21:36 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 19:21:36 +0000
Message-ID: <d00a0448-dd2b-453d-863f-914909f76abc@amd.com>
Date: Wed, 4 Jun 2025 14:21:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/16] CXL/AER: Introduce kfifo for forwarding CXL
 errors
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: PradeepVineshReddy.Kodamati@amd.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, bp@alien8.de,
 ming.li@zohomail.com, shiju.jose@huawei.com,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-4-terry.bowman@amd.com>
 <aD_hQ7sKu-s7Yxiq@stanley.mountain>
 <1f719cfd-2c2b-4431-a370-290a865b0bf2@amd.com>
 <aECBR79lhlj7SPUV@stanley.mountain>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <aECBR79lhlj7SPUV@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::41) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: d06d957f-e5d8-4527-20b2-08dda39d05f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0pVSWRPU3BxanhrTndhTng1OW12eFRPdXN4Y0FRWkFNTGYrMHkyU0s4OHY5?=
 =?utf-8?B?RTJ1UVYrTDc2M05MZXlRcER1eWNLSjM3Uk1qWWtzZnlsK2tRMVFwRDhtNVVE?=
 =?utf-8?B?a21RMzVOcnc4d0todDM4dFZwSnhpaHc3SFRpU3Vrb0FsbFAwbk52bVBDQldi?=
 =?utf-8?B?bUswTVRZUXlOTTRUZG50NXMyalJuWXVVY1pZcVl4TkxiVFd4bWZDbmJSSkI1?=
 =?utf-8?B?eU5pL0Z0SWIrZG5mbWRaQThjWkFiVlgzenR2UjJ2NjZRM2VZdDhOMERzeE1n?=
 =?utf-8?B?eW1xcGVBbmVDNlRKV2Nucy9VemNBSzRHVkZRR2tFdmgrSzFYUFhYU3NZRE9k?=
 =?utf-8?B?TmtGcXhzc0w3VkhKUXM3ZGI1TjFuSGRac2RHc1RhYVcvM1E0dXRTeVY5VnNL?=
 =?utf-8?B?S2xYVGtDZDFXL2YwQ2pTU3BsYmMyK0llcEFiRTRIN08veFpweXMwa2FxOTRY?=
 =?utf-8?B?UVZsYjlmN2ovb1RqNXlJTlp0aXQxSFhSMVhhRGtoT1ZwcGJDSjNXSENyekI4?=
 =?utf-8?B?eGJ2dVpvZ2tQNjkrcE13WjlzTGtoRzNFOXlRRFhiTzE2dXkyemYrSFBQN2Nl?=
 =?utf-8?B?cjVKSnM0ZW12V3JPOW9wdDdUMWdEZWI5ZU13bUlDWnJCOGl6N01oTCtaQ1pP?=
 =?utf-8?B?d0lIaVpvUzZEVVBNTFZraTgzaU43SG5CRjVSYUN2bFA2WkpRVC9SaENUamww?=
 =?utf-8?B?WWxTMTZmSjlNYjZLNGdCNWdCY3VzWnpaZ0lPZ1RYeXlhY0IyZzVsWXVwdi9p?=
 =?utf-8?B?RGdkdW1ZSyt5VnZuTkx1UXRUdE1sVFlBV0RoM21pMzNMUFppa2tPU1pUclYr?=
 =?utf-8?B?WThlMEZ1b01nem4rUTJZWGtaSHgwOTV4RVlIKzRuOXMzdGVZWGJ4dVRreTdu?=
 =?utf-8?B?YjlIN3k4eUFTQVZ1aU1HYXJtL0FwNEN5ZFVtOE81bGNJQUtMb0M3VmZBQTNo?=
 =?utf-8?B?SGVzV0RaNmdiNGhsT08xTGl5blk0V2tMTURLYjA0c2dLNUU5Z3ptRThNalVU?=
 =?utf-8?B?b3dmYkRRTS9KTjNaTmtHSythTkJaRzZPQUhJQS92ekNiZ1JQVGlCbHFBNnYx?=
 =?utf-8?B?Q2dYa2s0ZWhoaFB3bCt1N2dYakNVN0k5TU95Yko1NjIwSE9yNVFZcG9uQ0pL?=
 =?utf-8?B?OUxXNkpQWVovWHhtNGptZkZOUERVLzJlbVBJMURxUUthQVUyL0ZkdTI3Szh2?=
 =?utf-8?B?eXJ5VzFIRXFubUNlSVFqalhrRkNqYXRheEFRR2MrSW40RUM3UlZWYk9OOG5h?=
 =?utf-8?B?WU13VVZhM1d3cTZLSjVaS2RZcHE0ckVDTG9iNFMrREozSGt5Z1doZ0ZJaFVF?=
 =?utf-8?B?c2QvWldBUFJibURIZUV2dUJTdThwZVVMVVVvd2tCMnBmK3kvekJKdmpjM0Qx?=
 =?utf-8?B?MlNsenVxakpiYlJuR2VKa2RTRVNVNDhYL0NiYmVGNisrWnV4Q0pVUFNPTkpH?=
 =?utf-8?B?QitsWTdKWENHYmlEZm52cUhXbWNWbzloL2wyRnovTTBwRWM3RFI2VExrV1lS?=
 =?utf-8?B?cDkxckJpUkZOYjNHNUprc0dlRHBRMmNjQkw2K1QzSFN3c3BXSVcxNW9xSVMw?=
 =?utf-8?B?enVoNUwvZTl1ZjdaUFRzTlpZMG1hNFM0cmsrNkxpKzdqQXdlRkRIemlEL0c2?=
 =?utf-8?B?SHl2ZHcwdEhZZTZOTW1uUGxieWhOZlNhR1N1MzhVYTYwMDZyOXdkTDB4MndL?=
 =?utf-8?B?WW9GMmtOYUU0a3NYaG5DS1hQVUNhRjJoc2xwYUhKYzQzTXk3d1N3MHlxTzMx?=
 =?utf-8?B?TWNWZlp1RmwyQm9Hc0NZRjcyWnluMTdCVjVFS0FQVjZZRkd0UDlPeUtqN25W?=
 =?utf-8?B?QUlVeDJkQ2c0RTAzbGJSblRRT1AvUGMrdFlGVWowMlZEYXo0Yk1pcVNJTnZ2?=
 =?utf-8?B?RVkyUjJPNDFmbzRGeGt6ZjMrVS9jZGN4b2NNZDF6ZE04VVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGlOdkdyeGFJdVBTckRxMWdMYkVuc1VTd3JzUVdZdk5PMGk5NFcvYkhWd3Ux?=
 =?utf-8?B?WVlJUzNKRUwrTzN3NExEV1VkTUR3UWlSbEVmdGdnaUJMeThlZkhoWE52NWVp?=
 =?utf-8?B?TXNzQ3VOZ1A0OUMvdU9xa2NEL0xIdktnb3Uwc0pQcnlGSW5QK2k4TS9yazBp?=
 =?utf-8?B?ekNscm8zeUhaaVN6VzVVTTRCRVRpQkNCanJ4VlB1SzFGT3gzemFIV3Rrd2hJ?=
 =?utf-8?B?WTYxTEdqVEJtU1JXMitHMDdjcDlvVnRBYm4wSkV2RUN6Vk5BaVgreDZUS2U4?=
 =?utf-8?B?djBwUXgwK0poNXVrcTBBMmRFWXlMT1pHTnR4NnEreFJiSUZIb0dMdEZIY0di?=
 =?utf-8?B?cnNmRElkYk1qRU13UTJYWHg2NkxFSlpOeXNZVk1JNTVQSFBqbnpxSTNXY1Qz?=
 =?utf-8?B?RDRIL2FoRGMzMzJxU1VpcjFzOXRhVTE5WjVkbklpT2xmNERNTSt2SXBzUEtG?=
 =?utf-8?B?RDRwV000VlBDb3oyMDgyeHlKY0pZa24vdlVrVS9PY1JvUStGY2NWdlBFTit6?=
 =?utf-8?B?bVpJbE1UY1BnU1hDQnpvS0xSOXB6MWxwRExXOFZFYUxWTmxCM3ZsaTIrMlVE?=
 =?utf-8?B?T2U4M1MxNFlMVTdtaEFhWEFYV3ZlTll6WlJlVmh6VHFXSTZEa3BoWndRZTdp?=
 =?utf-8?B?d3NycmZLbzY0S2w3NkFrekkyS3VlNnlSazdRR3BXbnRWMXVaTkdHbVN0UEJa?=
 =?utf-8?B?QU14b0JsWEVPZE5pOXkyMFUzRTB5Tm52NTZyODlORnNIOTlCL0Y3WGRwbStu?=
 =?utf-8?B?MWJ6ajEwSWcvSXhaTGNwMnBPZ2E2Y0x1Qko2RCs4RGlUTVBKdDZ4T1UvOWVq?=
 =?utf-8?B?OTQ4Vy9FRUxFRDNoeEFLbnVTYVlHeXAvUDQ1OGRuWGhJYzRGYTd2RVpENjNY?=
 =?utf-8?B?UnNRZDk2WVMzZm5jMXBEbzM3dDNqYS9VRHhQcmVESFV0ZlVUNis2ZEQ0NDRa?=
 =?utf-8?B?SUhZaS9SQ3NFUHNEVkdUWmMwYjhRYVJMZVJSSEpBQzZveVZ6SW5uOHhJcXgw?=
 =?utf-8?B?cVZERDFpVlVJeDFVVHJuUDQ3dEh3ZTVvd2pteTRHeVZjV0JYdndhemVMWFlE?=
 =?utf-8?B?VHpUcjlYS04wUXdIOVJuSnEvcU05SmI4ZUkrSGQ5cGYzSHNqVzhWaTgxUzh2?=
 =?utf-8?B?bGptZUxvYjNWbjUxYzA4LzJlYnZ4YmNkRnBBVzZTSHRhb2RjZDUxR1J0TDgy?=
 =?utf-8?B?U0xMWGpLclpvUnZEa1lsemtVWmpzSitWRFJ4NjFJejBLU052OTZ6UURLMjlI?=
 =?utf-8?B?YWJRRlBxTTZncXA4TzBqcEFLWW1RSktoLzI4eVBBNkFibktUSmg2ZWNsV0pY?=
 =?utf-8?B?WitqOERaYjhuV3BGM09WZGhHMzdzTGltTVhBSFNOQld0eHNTeUZZTDZBTkhI?=
 =?utf-8?B?Y0VFTnRPZThybnFnQXJSQVhudkdpMVg4Y2Iyck5VMTNsUkszaTd1NDhLZE0w?=
 =?utf-8?B?QW4wdHpSVnVmSFFYY1JoOFpYL005VXovemlzRy95S1g3NStLSm5POXRIUExF?=
 =?utf-8?B?cEh0cHVDMWlyMzJQNEo2T0ZCNnZkRUc1ZCtxQWFET2ZsMU03VFF0b2l6NjNE?=
 =?utf-8?B?WXp6YW1sQStxWVpHbFdxamxHcGhxc0NhWmVCNGcyTVdaRVBWc25CeEtMaFJV?=
 =?utf-8?B?U0ppYStWQ29ZYVk1YzZ1b0t3N3I2eTl3QjBCZTdHUHFlVnBZQzB2NEpiQUp2?=
 =?utf-8?B?cFhBbFlaN0pVM0JrV3JPcmhRaVdQYkdjQUc3b3k2UXl4MmFxYThJazJBT3pZ?=
 =?utf-8?B?dzE5ZENwYlFROXlpazZkUHlOTjZIMVFpaVVsZEF0NjNnL0QrTVM0R2E5UVUv?=
 =?utf-8?B?bVJHTnU0T01IRFlZd3pSNmltR3pHbkh5Z1hWbzV5d3ZwWUdWb2x6WlJtUmk1?=
 =?utf-8?B?UmVHdHBzT1NwdFVMOC9JT0NwbzJTQkE1ZmczVkcrZVZBZll1OUN0bjdXT3A3?=
 =?utf-8?B?bytzKzBKYXlXQitXK1hqc3RTWTQ2OFhqTDROczYyaXQ0dVp1eDJqdndGbGM4?=
 =?utf-8?B?enVpNW1zYmFlYmNsQXJiNXBzaVU1WFVMTGwxLzA5N01yWlFtS2VvdXR4dnk4?=
 =?utf-8?B?WGdjNEIxMC9WL3FSRXNuejB4aXg5bC9mTnFYVStNYldhTk5ZYWFIYW1Yc0c5?=
 =?utf-8?Q?T/YeyYOjO6LqPBNzsP/smoAUW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06d957f-e5d8-4527-20b2-08dda39d05f0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:21:36.3142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijuK3qUUcrCo9TxjsWo9AIS0wfxeygT727C74Hi6GytJ2v5Ss4LuccSk35prPuVpTXiDXeQHXLEJ//0+RLBgow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699



On 6/4/2025 12:24 PM, Dan Carpenter wrote:
> On Wed, Jun 04, 2025 at 09:37:02AM -0500, Bowman, Terry wrote:
>>
>> On 6/4/2025 1:01 AM, Dan Carpenter wrote:
>>> On Tue, Jun 03, 2025 at 12:22:26PM -0500, Terry Bowman wrote:
>>>> +static struct work_struct cxl_prot_err_work;
>>>> +static DECLARE_WORK(cxl_prot_err_work, cxl_prot_err_work_fn);
>>>> +
>>>>  int cxl_ras_init(void)
>>>>  {
>>>> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
>>>> +	int rc;
>>>> +
>>>> +	rc = cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
>>>> +	if (rc)
>>>> +		pr_err("Failed to register CPER AER kfifo (%x)", rc);
>>> This shouldn't return rc;?
>> This was implemented to allow for native CXL handling initialization even if
>> FW-first (CPER) initialization fails. This can be changed to return rc.
> No no.  I'm fine with it either way so long as it's deliberate.  But
> maybe add a comment if we can continue.
>
> 	rc = cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> 	if (rc) {
> 		pr_err("Failed to register CPER AER kfifo (%x)", rc);
> 		/* Continuing regardless.  Thanks. */
> 	}
>
> 	rc = cxl_register_prot_err_work(&cxl_prot_err_work);
>
> regards,
> dan carpenter
>
Good idea. I made the change as you recommended.

Terry

