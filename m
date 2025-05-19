Return-Path: <linux-pci+bounces-27952-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4D3ABBAF7
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 12:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FD8C7AE5CE
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 10:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B11A274651;
	Mon, 19 May 2025 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wglk4x9u"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1242749FA
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650027; cv=fail; b=dZIzds+1cwkOeLj99G0J2nMpxDGA/Sck5HF1D350wnuOaK8WYvBfGRvvi0eoZ1HktjsM99sDcv65+4mrTFKlXtAWxniJSg0LLaH6/wwtyyz2xKU4pRoS+e4oaWGuaTwOIco9eGxKco4TYzQ9lj8k8S1NpUocSzuui43LUU33+7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650027; c=relaxed/simple;
	bh=CIxAlYvp1EavBOshrSbbVHhzcDJfjEkjgjs4+UhEuJg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dyl0ONx++C9MCGO+DyEE5byEc2LPVJWA6NBjjOUWXVBqCoIADcYnDjU+gH+3saje2wYj5XtusEXB5U50/if3vrwDrLQZTCFsWhZ1tWCbVQ5zv6IQlmV8of8iYiJBmtCODY/eaP/Hdd3jo5X9uK2euLJjCfx88KnCVoKorCdIWRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wglk4x9u; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTQb274JNTQPm6tDwYsAo5vdPcPvfXDigFgzJKeAOWu8tQo5vRhiLPm60VDch8T9ODTJfuhSyrQCFjXc9IxkUU0kuKihK3eTFPBm73VXZh5vQEswhxh7rzlqNWKFIN0qaI3bRweqVXWsRBJlgOiatCKnKkkktt+2ertTFqEIIjuDSskXmnsrsxkxJZbhFn9RV4gNQrUjS9PZ1tAVvJIBUzPRQu0F/NZhpd+yyV1eA0OCaNA1zFdos0Fcu9bZPqd4YVo6zhI1LbTqcbo0byFW5lPl+320lLZ/YTiRLXVTAw7zD9R2TfNAiFx/KVRJ91vTwprvsQUW8ppcCA2t6iQSJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1Qr/I2600GtYiXqpYS1qni7H6gxeN9chBjEftsLps8=;
 b=whixebWE6MH4l3QMehIvZmUlPJ+DHOd/uS+a7h6TIL4k0cNOHayvE56UInJVi21VJTk2UMp3KUiBg6Zhiz2pENRghr2B+RoSsfvVdHX5/AczAOXz5nSIfbSauSvC8Vqj/wLucd+SQHAsqNcnYaavxQ4ZmwfhxNmU6BetxiDxfgY9u3YdBvLy0xEeTbXvhqr1ke8H9fnBYyEf6ickM1OL3+4wLGLnfHBBrkxP5IhB3of225/jeX6nW8Sq7IccXR2KDnzctFp3G0005s4Z441kL7mVZneKKTyh8PoOkqOgXPVTyg0DJKzdBbI8nD1W/aSQbhtblWN0OqFkxHY27bcM0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1Qr/I2600GtYiXqpYS1qni7H6gxeN9chBjEftsLps8=;
 b=wglk4x9ue6Qy2qVeU7s7Z7aGIhArgM2tpW+Jy0oF3BhrQHuTFe8onXCg6KY7+Horx29wHCFUmwUysKsXmyYurpPQpMDxi8D7PopZ8bqPMjWtypzkZzS7JWS1Vhu/jHO3yqPeqTaW/v5B/FhIvxO8G6qAZ4CRR19WUQTmAOhgqEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CY5PR12MB6622.namprd12.prod.outlook.com (2603:10b6:930:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Mon, 19 May
 2025 10:20:21 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 10:20:21 +0000
Message-ID: <363a3220-e43c-4965-b138-b85f09a5907b@amd.com>
Date: Mon, 19 May 2025 20:20:18 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 13/13] PCI/TSM: Add Guest TSM Support
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, lukas@wunner.de, aneesh.kumar@kernel.org,
 suzuki.poulose@arm.com, sameo@rivosinc.com, jgg@nvidia.com, zhiw@nvidia.com,
 Xu Yilun <yilun.xu@linux.intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-14-dan.j.williams@intel.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250516054732.2055093-14-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0099.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:204::8) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CY5PR12MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: 6696ec06-60a5-43d3-c8c5-08dd96bec2ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1EyeE5zQWkvYnlYcXpETDZzdFkzTlFmQzVySGgzVGR0clpSSlVYdTBhRG9Q?=
 =?utf-8?B?b3kwbGpGaG82Z1Z2Z0V4bGQ3NW9FWmdRdUFWN0dMWWdCc0RCRGxYL3RxcnJi?=
 =?utf-8?B?YjZQNEh5TDRlZHJkMUhQQis0blJRNTFzSjRTUXE3cHc0cXRkWHN6N050dThv?=
 =?utf-8?B?a05jZThnSlBlSDd6ZHd3WUE1UWl6WXFtNGRlTC9pOFlFeGlJVUd6RU42YmR4?=
 =?utf-8?B?b3hOU08vY3pnaWFkTkNpNkhNRzhsdFZpNGZpOUR3SzdxbkVTTzl5M2Zrb1Mw?=
 =?utf-8?B?bEFsL2s3Q204ZVBGZDdnYWZTdGdXM0JLaUFZS29VZzgyVXp6OG9DQkFqUGhN?=
 =?utf-8?B?S3ZmUVdsdVlENUxrcCtaNzlPejFOZURVQk1aaE5wZ1NzSU90bWVuWkNSWGNl?=
 =?utf-8?B?eFpXTTlqWWRkRTBqNUNyb3JUczQrOWlySmJvV0Vkc0hvTWRrSzA0ZVVlL1Nn?=
 =?utf-8?B?VHgzRndVczExTng4UHZwNTAvWWNDd1VRd090RjN5ckZXYzJ4dTUwM202ajFN?=
 =?utf-8?B?VGpqWVg4Q2xHdGZidjVka2dPMUh6UXJnMnB3aUVBdGY0WHg1M3ZCWlhLQTVh?=
 =?utf-8?B?T0tiSWdVQzVvaDZJVVJTR0dXM3VreWhnMitnK1Q5Y0U1SVBTbm16azhyYjYy?=
 =?utf-8?B?WGZOaFA0TWUwYUxFeU9rcnY5Y3ZEUnJSS2pqTkwwYW1ELzkxYTZRNzZyLzFZ?=
 =?utf-8?B?ZWtSeFZjSUFRYU15Kzl4dXM3cTQ4OWZSTnRpamhxajN1T0loQTdIVGxrdENV?=
 =?utf-8?B?V3JrM2tXTWdZbDZIclhoSGYxeXQvRVN5Rk5Qb3hyRkJTVkdibXhKY1NEV3BO?=
 =?utf-8?B?bTlGUFp3VDk1UjBrdjBRdmpSNlV2YXk5Q2hvZDYwYkdBYzJvbktMOHBUdUZC?=
 =?utf-8?B?RWxMTW13UW1nbFhHQmgvWjFpdTJHLzFZTXJWSVU5eXlZY25LaFQ2WGpNYytD?=
 =?utf-8?B?Tm5BNHN0MjVXcUsweCtLaHE4cTd3OUpEcE9XTzJoMUNRTWloekdlejd3Z0xU?=
 =?utf-8?B?NGQ1VWZGN3o5ck40ak9GQVpQQmJUVk03bDF0eVB4RW1BMzB4dURSNTgyZmVa?=
 =?utf-8?B?SlRBUk1CS3hwRnJicEJpUEMxUlUrUTM0dEpkSW13S0dTb3JUMHNieDgxbk1s?=
 =?utf-8?B?clhLWmkrWGZoOEV0bjVqRFJyUUhhTU1KQXRFV1hiMkJvYVFPMVA2L2xlemI3?=
 =?utf-8?B?dXpEajFqYmZGS0tuelhYQklZdG5jVmM1eW1QM0NheDRMUkJ5ODlXMWxRRXVP?=
 =?utf-8?B?L2dHUTFUWmhlQXk3YmVrVlVXVDd1L0J1TU01ZFJPd0VNL2NGU09qZUo5aktH?=
 =?utf-8?B?YmFrcXR5YU01NWhXVXlkUjRMa3pHNDk4Y29uRFIxYnJhY1pnZllQZmlIY21v?=
 =?utf-8?B?WngzajhlMGZoaU5hVkNsRE5nakJsY3pBOGZwYVpMNi9iREE5UXFLbnFOYWhi?=
 =?utf-8?B?VXpnVmVRbTJObm9mUWV5VllTeWduZ3l3NGQvVXdaR3VlQVIxbUtiaGxkWjhU?=
 =?utf-8?B?Wk5pVWIxbG0wL1JQMU01YmJ1TmJOdFZYZTA2UEI2aEJ6blBHdHBxK1UycGxh?=
 =?utf-8?B?bkNrb3JhdzkzOXdOTk9KbjRtd25ySEp2d2dMTHo5bkgrNG1lQWxWZW1BSzhV?=
 =?utf-8?B?ZFNZOWl3VFk1UWpKbEZuZE1KV0RWbFVHMk9Td0NHLzI0cEg3aXdUUXJ4SWI3?=
 =?utf-8?B?V0lNSEw2ZDFCQUV2OW90ZnVjNnkzdWgzNVhiWGF1d3BBTHlua2FvQTYvZmdS?=
 =?utf-8?B?YytvaVJyVkkrYTVneUY4VGdZUTIzMmk4cE5xNEpJdTE0Y3E2SFMwNjRVKzBF?=
 =?utf-8?B?ZEFpYU5YRkl0V3hWdTZmdktJajg4Rk5DbnFZMndhbUNKTWJHYkJVRjg1dDlG?=
 =?utf-8?B?emwySlVBdUJSLzR6MGZCb3hnZzduZFptQk8wV3hsSWxESjZjdjNHenlzc2lH?=
 =?utf-8?Q?+5caCOzGiKk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHRSMFF0Q2VtdUJGQUV2S1VnZVVFaFBBNytUanpZTS9ZWE9IY29SdGhxakdG?=
 =?utf-8?B?N21LdHhvWUlZZTZ6RU1uVEg0ak41NnNWKzdLZi82YmpvM2U1RjdMQ09mTTdt?=
 =?utf-8?B?QmtRbExYTkZ0Wlh3Rll5eDRzN3BTb1d0em10SG9CSEkvaXAvYzR6TDZzcXRl?=
 =?utf-8?B?bnozOHZDdVR1dVNPTFo4WkNXUGNtU1BBblZncFB6clc1ZmZtbVF2TEMwNkpR?=
 =?utf-8?B?M2NrMVdxNFVhYWRxdk5ub3QvUXJMZUtESnFKMjJ0UzBlT09UM2RRS3ZCNzF2?=
 =?utf-8?B?Y01jZDZvR3ZvK0xzVzlTNlV4dW5Ea240aUFZenYxSTZUVW9CRHpRYzhCVlFH?=
 =?utf-8?B?eE00aTNmUEc1QkwweFM0WGwzYjMycU1PY3U4aFdwRE9QVS9RYndXdTlOOVN4?=
 =?utf-8?B?S2wzTkFndnNqcXRvVkFNcE55OVpKb3A1Q2pPMWVuMHJ5TkpuNUxIclZNT0tu?=
 =?utf-8?B?c28rOXJxd3RZK0kwRlVSU1VsWmVrV1VmSXFJK0o3alBHQ29aTmNjNUxuSXZm?=
 =?utf-8?B?LzRVdUxSd1hkSUlPbU5wQ3paR3VremZ6dG1henphWEgxZG9KNWF3cjlsSW80?=
 =?utf-8?B?eG5GVTNyeUpiQVZJYWZveXNhc0EzUGtjR1Q1SUlEbXc2cHl5TFVGWm9kNHVF?=
 =?utf-8?B?Yk1qdC9MOE1Pbk1kYyt4UktON01ma1BQbS9lK0pCZUtCZmtjS2x5cEpPcThm?=
 =?utf-8?B?M1IxbUNkcTVJR3AycW53RHR3eTlmSTRYYXIreVM4b3NkV1cvWjc5YXJkSWUx?=
 =?utf-8?B?cHk0T3paZExiZW5GT3NKWHZmMC9DWjJZQTE5c1IyRGJFbXVwcXBWcndIVXNI?=
 =?utf-8?B?VE4rQW5pL0QwWW5NQUo0RzRWTTROOGJGUjQrVGdHWFdpUXBqZnVRelc1RkVm?=
 =?utf-8?B?ZTg4dVA1eXk5V2FOZzMyYnVFVng2anlFZjg1amxCWlRnSmxoNm4wa3hzREpO?=
 =?utf-8?B?NnNWNzUrU3ExTVZSaHVJZnpDSXIrRmNvOHBSNWdYL0lQanQ3bWxGanR4ME9F?=
 =?utf-8?B?UVhoZFMxeXdJS3EwQW5KM2w4bGVJRndwZnJlOGcvK3QwWnJWalc2VEVWelNt?=
 =?utf-8?B?alVZL1N0UUNhR0hkUUsreGthRmVXR0xxV3JCQzZqb2dGNUlRR2MxU3VhaFVq?=
 =?utf-8?B?aUtpK0syamExWUtHMnM0OFJIRkZGUUY4WVhOeXFMRjdYd2N1UXZNZmI2U2o1?=
 =?utf-8?B?dVpaQnRySWdGVnZmekdNbzlTdGQ3L3hxK1FzdllndTBEcDhpWjNGZjhMckRn?=
 =?utf-8?B?SWxkeWc5M05jSjVPYnJ5NEFodzl3VWc1SnpmZTUvN2VFOWREOUwwWFpVS0hY?=
 =?utf-8?B?dkVQdFZ5Q3pYaEZxT28weWgzSTFRenFLYkc2QzZjaWU3K09NUURyMVNQVm5C?=
 =?utf-8?B?MEwyY1U3azNSSGI1cjVUbWxKNHFWTHVLWjRUelA3NzhTN3RBcnhLTEYwQUZt?=
 =?utf-8?B?aHZvQjZyckROVFV2aXZpcTVjNDlNY3B1YnZaS3ZQa3RuL2oyWDZjbk9xcFg2?=
 =?utf-8?B?NjFRWll4VDVyeCtjWnBIUjMwUkZjTWhDaGRwU0dCcWdtbkp6blJuSXpiT3Q5?=
 =?utf-8?B?OGlndGdyUVlIL1ZTNlVSMXZ0bjFPVmJOTHQ0c04xQi9jOTBHd0JuNGFNODVS?=
 =?utf-8?B?UURIVnNSTXpFY2RBWVJEZ1Yzc0hZMnZJR0l5eWcxU250TXFCWXo0WXpWYm43?=
 =?utf-8?B?amM4WGNKSXlIaUkvajMzTVhIU2FNNURRYkFFeU91RDRGNTBmVm1UblVsNFBC?=
 =?utf-8?B?amUzSlZacnRmK0RDYjEzWlhTR09oT3JQRERpbUJYOFplcTNDcWpycnJEVUdH?=
 =?utf-8?B?WWdiS3pJdU9aQXl4R1dUd216R1o3RWJaWTdQbjlyRkRZTDBwbUZZUFJ6QTBN?=
 =?utf-8?B?ZnFEck9Lc3JKOHU2Sm8rMTVwdGQxTlpuaHNKdDN1d3I0Ti9LNHBYcVE2amcr?=
 =?utf-8?B?ZDc5Z3dUenlIVUxTN2phNmh0eTRFR1ZLYzRhQ2xPMzBEVWd2MDZqRkQ3ZnhI?=
 =?utf-8?B?Qkh6eE5LcHRBdnhLa2JrdmhOTEp6cW8zaEg3MWxqOGF1L0lqSCtGN3ZYQ001?=
 =?utf-8?B?STRIWU9IOGxvN0ZtM0lQaERwQlBENzR2eGdHSzFPZXVwSzJ0ZGc5MkFSODZ1?=
 =?utf-8?Q?XhKaHxUTVE8o79GxeuxGaM6Kg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6696ec06-60a5-43d3-c8c5-08dd96bec2ea
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 10:20:21.8027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czsH8C52Qy9RBV0NvaL/A7BQ63zywCMuA9X2hTZqPG8+90+MMgy204pJpz9/p8tAUNGTAwzh9C/DyU3SBn3aKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6622



On 16/5/25 15:47, Dan Williams wrote:
> From: Xu Yilun <yilun.xu@linux.intel.com>
> 
> Enable PCI TSM/TSM core to support assigned device authentication in
> CoCo VM. The main changes are:
> 
>   - Add an ->accept() operation which also flags whether the TSM driver is
>     host or guest context.
>   - Re-purpose the 'connect' sysfs attribute in guest to lock down the
>     private configuration for the device.
>   - Add the 'accept' sysfs attribute for guest to accept the private
>     device into its TEE.
>   - Skip DOE setup/transfer for guest TSM managed devices.
> 
> All private capable assigned PCI devices (TDI) start as shared. CoCo VM
> should authenticate some of these devices and accept them in its TEE for
> private memory access. TSM supports this authentication in 3 steps:
> Connect, Attest and Accept.
> 
> On Connect, CoCo VM requires hypervisor to finish all private
> configurations to the device and put the device in TDISP CONFIG_LOCKED
> state. Please note this verb has different meaning from host context. On
> host, Connect means establish secure physical link (e.g. PCI IDE).
> 
> On Attest, CoCo VM retrieves evidence from device and decide if the
> device is good for accept. The CoCo VM kernel provides evidence,
> userspace decides if the evidence is good based on its own strategy.
> 
> On Accept, userspace has acknowledged the evidence and requires CoCo VM
> kernel to enable private MMIO & DMA access. Usually it ends up by put
> the device in TDISP RUN state.
> 
> Currently only implement Connect & Accept to enable a minimum flow for
> device shared <-> private conversion. There is no evidence retrieval
> interfaces, only to assume the device evidences are always good without
> attestation.
> 
> The shared -> private conversion:
> 
>    echo 1 > /sys/bus/pci/devices/<...>/tsm/connect
>    echo 1 > /sys/bus/pci/devices/<...>/tsm/accept
> 
> The private -> shared conversion:
> 
>    echo 0 > /sys/bus/pci/devices/<...>/tsm/connect
> 
> Since the device's MMIO & DMA are all blocked after Connect & before
> Accept, device drivers are not considered workable in this intermediate
> state. The Connect and Accept transitions only proceed while the driver is
> detached. Note this can be relaxed later with a callback to an enlightened
> driver to coordinate the transition, but for now, require detachment.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/pci/tsm.c       | 160 +++++++++++++++++++++++++++++++++++-----
>   include/linux/pci-tsm.h |  15 +++-
>   2 files changed, 152 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index 219e40c5d4e7..794de2f258c3 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -124,6 +124,29 @@ static int pci_tsm_disconnect(struct pci_dev *pdev)
>   	return 0;
>   }
>   
> +/*
> + * TDISP locked state temporarily makes the device inaccessible, do not
> + * surprise live attached drivers
> + */
> +static int __driver_idle_connect(struct pci_dev *pdev)

Do not need "__"...

> +{
> +	guard(device)(&pdev->dev);
> +	if (pdev->dev.driver)
> +		return -EBUSY;

> +	return tsm_ops->connect(pdev);
> +}
> +
> +/*
> + * When the registered ops support accept it indicates that this is a
> + * TVM-side (guest) TSM operations structure. In this mode ->connect()
> + * arranges for the TDI to enter TDISP LOCKED state, and ->accept()
> + * transitions the device to RUN state.
> + */
> +static bool tvm_mode(void)
> +{
> +	return !!tsm_ops->accept;

tsm_ops->accept != NULL


> +}
> +
>   static int pci_tsm_connect(struct pci_dev *pdev)
>   {
>   	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
> @@ -138,13 +161,47 @@ static int pci_tsm_connect(struct pci_dev *pdev)
>   	if (tsm->state >= PCI_TSM_CONNECT)
>   		return 0;
>   
> -	rc = tsm_ops->connect(pdev);
> +	if (tvm_mode())
> +		rc = __driver_idle_connect(pdev);

... or just open code it here?

> +	else
> +		rc = tsm_ops->connect(pdev);
>   	if (rc)
>   		return rc;
>   	tsm->state = PCI_TSM_CONNECT;
>   	return 0;
>   }
>   
> +static int pci_tsm_accept(struct pci_dev *pdev)
> +{
> +	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
> +	int rc;
> +
> +	struct mutex *lock __free(tsm_ops_unlock) = tsm_ops_lock(tsm);

Add an empty line.

> +	if (!lock)
> +		return -EINTR;
> +
> +	if (tsm->state < PCI_TSM_CONNECT)
> +		return -ENXIO;
> +	if (tsm->state >= PCI_TSM_ACCEPT)
> +		return 0;
> +
> +	/*
> +	 * "Accept" transitions a device to the run state, it is only suitable
> +	 * to make that transition from a known DMA-idle (no active mappings)
> +	 * state.  The "driver detached" state is a coarse way to assert that
> +	 * requirement.

And then the userspace will modprobe the driver, which will enable BME and MSE which in turn will render the ERROR state, what is the plan here?

> +	 */
> +	guard(device)(&pdev->dev);
> +	if (pdev->dev.driver)
> +		return -EBUSY;
> +
> +	rc = tsm_ops->accept(pdev);
> +	if (rc)
> +		return rc;
> +	tsm->state = PCI_TSM_ACCEPT;
> +	return 0;
> +}
> +
>   /* TODO: switch to ACQUIRE() and ACQUIRE_ERR() */
>   static struct rw_semaphore *tsm_read_lock(void)
>   {
> @@ -196,6 +253,61 @@ static ssize_t connect_show(struct device *dev, struct device_attribute *attr,
>   }
>   static DEVICE_ATTR_RW(connect);
>   
> +static ssize_t accept_store(struct device *dev, struct device_attribute *attr,
> +			    const char *buf, size_t len)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	bool accept;
> +	int rc;
> +
> +	rc = kstrtobool(buf, &accept);
> +	if (rc)
> +		return rc;
> +
> +	if (!accept)
> +		return -EINVAL;
> +
> +	struct rw_semaphore *lock __free(tsm_read_unlock) = tsm_read_lock();
> +	if (!lock)
> +		return -EINTR;
> +
> +	rc = pci_tsm_accept(pdev);
> +	if (rc)
> +		return rc;
> +
> +	return len;
> +}
> +
> +static ssize_t accept_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pci_tsm_pf0 *tsm;
> +
> +	struct rw_semaphore *lock __free(tsm_read_unlock) = tsm_read_lock();
> +	if (!lock)
> +		return -EINTR;
> +
> +	if (!pdev->tsm)
> +		return -ENXIO;
> +
> +	tsm = to_pci_tsm_pf0(pdev->tsm);
> +	return sysfs_emit(buf, "%d\n", tsm->state >= PCI_TSM_ACCEPT);
> +}
> +static DEVICE_ATTR_RW(accept);
> +
> +static umode_t pci_tsm_pf0_attr_visible(struct kobject *kobj,
> +					struct attribute *a, int n)
> +{
> +	if (!tvm_mode()) {
> +		/* Host context, filter out guest only attributes */
> +		if (a == &dev_attr_accept.attr)
> +			return 0;
> +	}
> +
> +	return a->mode;
> +}
> +
>   static bool pci_tsm_pf0_group_visible(struct kobject *kobj)
>   {
>   	struct device *dev = kobj_to_dev(kobj);
> @@ -205,10 +317,11 @@ static bool pci_tsm_pf0_group_visible(struct kobject *kobj)
>   		return true;
>   	return false;
>   }
> -DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_tsm_pf0);
> +DEFINE_SYSFS_GROUP_VISIBLE(pci_tsm_pf0);
>   
>   static struct attribute *pci_tsm_pf0_attrs[] = {
>   	&dev_attr_connect.attr,
> +	&dev_attr_accept.attr,
>   	NULL
>   };
>   
> @@ -322,11 +435,15 @@ EXPORT_SYMBOL_GPL(pci_tsm_initialize);
>   int pci_tsm_pf0_initialize(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm)
>   {
>   	mutex_init(&tsm->lock);
> -	tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
> -					   PCI_DOE_PROTO_CMA);
> -	if (!tsm->doe_mb) {
> -		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
> -		return -ENODEV;
> +
> +	/* Assigned pci device in guest won't have IDE and DOE exposed. */
> +	if (!tvm_mode()) {
> +		tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
> +						   PCI_DOE_PROTO_CMA);
> +		if (!tsm->doe_mb) {
> +			pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
> +			return -ENODEV;
> +		}
>   	}
>   
>   	tsm->state = PCI_TSM_INIT;
> @@ -483,7 +600,7 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
>   {
>   	struct pci_tsm_pf0 *tsm;
>   
> -	if (!pdev->tsm || !is_pci_tsm_pf0(pdev))
> +	if (!pdev->tsm || !is_pci_tsm_pf0(pdev) || tvm_mode())
>   		return -ENXIO;
>   
>   	tsm = to_pci_tsm_pf0(pdev->tsm);
> @@ -495,8 +612,8 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
>   }
>   EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
>   
> -/* lookup the 'DSM' pf0 for @pdev */
> -static struct pci_dev *tsm_pf0_get(struct pci_dev *pdev)
> +/* lookup the Device Security Manager (DSM) pf0 for @pdev */
> +static struct pci_dev *dsm_dev_get(struct pci_dev *pdev)
>   {
>   	struct pci_dev *uport_pf0;
>   
> @@ -558,11 +675,11 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
>   	if (!pdev->tsm)
>   		return -EINVAL;
>   
> -	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
> -	if (!pf0_dev)
> +	struct pci_dev *dsm_dev __free(pci_dev_put) = dsm_dev_get(pdev);
> +	if (!dsm_dev)
>   		return -EINVAL;

A bunch of changes like this one belong to 12/13.

>   
> -	struct mutex *ops_lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
> +	struct mutex *ops_lock __free(tdi_ops_unlock) = tdi_ops_lock(dsm_dev);
>   	if (IS_ERR(ops_lock))
>   		return PTR_ERR(ops_lock);
>   
> @@ -573,10 +690,13 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
>   			return -EBUSY;
>   	}
>   
> -	tdi = tsm_ops->bind(pdev, pf0_dev, kvm, tdi_id);
> +	tdi = tsm_ops->bind(pdev, dsm_dev, kvm, tdi_id);
>   	if (!tdi)
>   		return -ENXIO;
>   
> +	tdi->pdev = pdev;
> +	tdi->dsm_dev = dsm_dev;
> +	tdi->kvm = kvm;
>   	pdev->tsm->tdi = tdi;
>   
>   	return 0;
> @@ -592,11 +712,11 @@ static int __pci_tsm_unbind(struct pci_dev *pdev)
>   	if (!pdev->tsm)
>   		return -EINVAL;
>   
> -	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
> -	if (!pf0_dev)
> +	struct pci_dev *dsm_dev __free(pci_dev_put) = dsm_dev_get(pdev);
> +	if (!dsm_dev)
>   		return -EINVAL;
>   
> -	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
> +	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(dsm_dev);
>   	if (IS_ERR(lock))
>   		return PTR_ERR(lock);
>   
> @@ -641,11 +761,11 @@ int pci_tsm_guest_req(struct pci_dev *pdev, struct pci_tsm_guest_req_info *info)
>   	if (!pdev->tsm)
>   		return -ENODEV;
>   
> -	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
> -	if (!pf0_dev)
> +	struct pci_dev *dsm_dev __free(pci_dev_put) = dsm_dev_get(pdev);
> +	if (!dsm_dev)
>   		return -EINVAL;
>   
> -	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
> +	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(dsm_dev);
>   	if (IS_ERR(lock))
>   		return -ENODEV;
>   
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index 2328037ae4d1..1920ca591a42 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
> @@ -11,6 +11,7 @@ enum pci_tsm_state {
>   	PCI_TSM_ERR = -1,
>   	PCI_TSM_INIT,
>   	PCI_TSM_CONNECT,
> +	PCI_TSM_ACCEPT,
>   };
>   
>   /**
> @@ -32,12 +33,12 @@ enum pci_tsm_type {
>   /**
>    * struct pci_tdi - TDI context
>    * @pdev: host side representation of guest-side TDI
> - * @dsm: PF0 PCI device that can modify TDISP state for the TDI
> + * @dsm_dev: PF0 PCI device that can modify TDISP state for the TDI
>    * @kvm: TEE VM context of bound TDI
>    */
>   struct pci_tdi {
>   	struct pci_dev *pdev;
> -	struct pci_dev *dsm;
> +	struct pci_dev *dsm_dev;


Should be in 12/13.

>   	struct kvm *kvm;
>   };
>   
> @@ -69,7 +70,12 @@ struct pci_tsm_pf0 {
>   	struct pci_tsm tsm;
>   	enum pci_tsm_state state;
>   	struct mutex lock;
> -	struct pci_doe_mb *doe_mb;
> +	union {
> +		struct {	/* host pf0 tsm */
> +			struct pci_doe_mb *doe_mb;
> +		};
> +		/* To be added: guest tsm */
> +	};
>   };
>   
>   /* physical function0 and capable of 'connect' */
> @@ -135,6 +141,8 @@ struct pci_tsm_guest_req_info {
>    * @bind: establish a secure binding with the TVM
>    * @unbind: teardown the secure binding
>    * @guest_req: handle the vendor specific requests from TVM when bound
> + * @accept: TVM-only operation to confirm that system policy allows
> + *	    device to access private memory and be mapped with private mmio.
>    *
>    * @probe and @remove run in pci_tsm_rwsem held for write context. All
>    * other ops run under the @pdev->tsm->lock mutex and pci_tsm_rwsem held
> @@ -150,6 +158,7 @@ struct pci_tsm_ops {
>   	void (*unbind)(struct pci_tdi *tdi);
>   	int (*guest_req)(struct pci_dev *pdev,
>   			 struct pci_tsm_guest_req_info *info);
> +	int (*accept)(struct pci_dev *pdev);


When I posted my v1, I got several comments to not put host and guest callbacks together which makes sense (as only really "connect" and "status" are shared, and I am not sure I like dual use of "connect") and so did I in v2 and yet you are pushing for one struct for all? Thanks,



>   };
>   
>   enum pci_doe_proto {

-- 
Alexey


