Return-Path: <linux-pci+bounces-27904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3BEABA690
	for <lists+linux-pci@lfdr.de>; Sat, 17 May 2025 01:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D04650569F
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 23:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB25280001;
	Fri, 16 May 2025 23:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JLH73uGx"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F5722DA15;
	Fri, 16 May 2025 23:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747438084; cv=fail; b=BiVCzM4fll2z1Szj0UFIo9AxjgoSqm630gfDjnTvlomSIvOZwq5i8iJ7C9IvirMAnzaR5utVjIUoEjGswxHmPVBD9QPwLr6zUAfDA0Xg8//Jg5hP05scdVmEzLpeSmZTOoULRtRb+A2pmqgWWKwRn+1nvuPVo/GJgxmHFGZDmvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747438084; c=relaxed/simple;
	bh=eoyAD8GceONlTEVpuDmkK4y+iGHFGROU9pFVqm9M750=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CCA0oV9PTa1NOn8fhJh7ud+qMG8lpN5/JogkzFWCtzdvwyjl2Gu/zVz+7d0aQiAof0a0u5VMGZn9fINodn/WJIVyRDxAKw0UVKyOa1E5s5iomWgPqOGIboL3RwuXWtRTRqKH1f0H+/Fuit0BS8iSvUkWPvdYgRNXDBNfM3QmqQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JLH73uGx; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqJ5xggpfbmfTN5I2Z7kwhj+ACATZOfi/oEWk6QhEvM3TrXcP6raSZQ5VMEdXGkzTTtd+AEETR3DoRnl1/HWSk1l+kGK57deohA1KxWFDOtvSB0RU7JjhiTb/iOJTojDZ1b1JmYeDUZDUxNCEb7LS6PaWX4Uhw18emVlk/vRGt1u4zlrvFBrXKAwAbBqsCF0hUS2FchrhM4v8pdcAiuGecJh0vA7AdNmzKzssN3Ft6yvOx8n3TzfYVbiuxQmu2s03y/eqlCnu6BF0fhnmlPuEkMxStw4ox5dYaDlZ50gu02V/DNZ7NhyfARn7+raNKsb7CtyrWfyyGECGbqKz1pm+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fD6jE+ZwAM/nOYqac7nACoSsWJRTQChhdh35CJamac0=;
 b=keN0cDbQypuqS9DEH9x5WnhhMfxzNz1ujUw5hCeuk/e0ZY3LTKfAKbnJFc6QgI/+K7VD3cKUBkxeTN6SsP4SqGmGnu9ydxgHnseF6iZv8ou3SiEsIckg7ucPOAj4Y8+uEexHLvGafRS89hSH3xLoOUxz0pxHV8irq6Swgqsfc2sQPY+1NCPfvzz0V7mcfiDVzBe1VtWFcWZDrrSMkpzy5oeH6fmZA9UQHb7LsdrX1P3GLfdn27DIDfWnFW8wQ7Fj5/NVieN3Q9Kq8AHga0goYwN1cXHav99iBpkxu0pkErokpSdo8G6UGypaVzFRqKzfAui7J0kBYI1dBGr5oxzqeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD6jE+ZwAM/nOYqac7nACoSsWJRTQChhdh35CJamac0=;
 b=JLH73uGx37wW0GUmmTmthb89EFuK6BD42aRFEAxn68O/d0eREcrZbS91n73ugVFsrhfNnKOPRoLtVcofZDK2EfS63LKfwISEWAcNilfoZALBUeAQR72PTg/f4yBUbMkwpCLdNxCpn/y6IFYCAFZ8LFBJtkGl8QdiOi3F9qjXnXlZzRAEa5WQZ7PAc++Z1yxoZs0Qnp9H15bdbRLndemoPPN8PbJlh8NcO6ZLBCkaunFnth57WJLxYm019MJEhRiVuklOu5VQhdnuqR4HO4j437eDNrQQV4F7NIs72eawFFn8Uosizbgg1sEoFKEF3s4ny4MBnYXCyYjvk581PmSX9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11)
 by DM4PR12MB6208.namprd12.prod.outlook.com (2603:10b6:8:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 23:28:00 +0000
Received: from DM6PR12MB4186.namprd12.prod.outlook.com
 ([fe80::af59:1fd0:6ccf:2086]) by DM6PR12MB4186.namprd12.prod.outlook.com
 ([fe80::af59:1fd0:6ccf:2086%4]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 23:28:00 +0000
Message-ID: <e9e64144-dbfb-4e42-94de-96ba1e24946b@nvidia.com>
Date: Fri, 16 May 2025 16:27:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 rc] iommu: Skip PASID validation for devices without
 PASID capability
To: Joerg Roedel <joro@8bytes.org>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
 jgg@nvidia.com, yi.l.liu@intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 stable@vger.kernel.org
References: <20250505211524.1001511-1-tdave@nvidia.com>
 <aCbfBqVu1C9Jtk7F@8bytes.org>
Content-Language: en-US
From: Tushar Dave <tdave@nvidia.com>
In-Reply-To: <aCbfBqVu1C9Jtk7F@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR02CA0031.namprd02.prod.outlook.com
 (2603:10b6:510:2da::7) To DM6PR12MB4186.namprd12.prod.outlook.com
 (2603:10b6:5:21b::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4186:EE_|DM4PR12MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: aee6f378-4bbd-49e5-3db7-08dd94d14b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azN3V1I4dWR5YXVtbFVHL3oyZ01URFpkUUJpVjRkS25JQXUzSXN6Zk4wNjNV?=
 =?utf-8?B?M2txdjI1OTNCTWJ0WFZmMlBYbWgvZ0FKMTFadWFkMWxrQkVNWUVzeFNJWXIx?=
 =?utf-8?B?M1MyTyszT0ZTZExDZUlUVzhZSUNWdXhsRmk4dnZheVViWG9lR0tqdFpCaTh1?=
 =?utf-8?B?RmZnMHMzMmEyZXhQcW1Kd0hyaHM1TWw3d0VuTWRRN1BGYzZSdktQYU9oSHIy?=
 =?utf-8?B?QzdnbVlVK1lLbGI4eks0UEQzMGR0cTk0Vm1sWjlneTlUc2tCdTVRTWxJUU5a?=
 =?utf-8?B?bG5DL1ErczdtbE5oOFpjV3dNaUtJUUEwcklJK0RMbFM1UXpQSVRiSkQ3eVox?=
 =?utf-8?B?TStvTDMzbTRTVFh6dXcrT3FsamM0WlhFNXQ0dmxCUFFsbWFmT0kySWV0UHlW?=
 =?utf-8?B?WVNCelRtaDhZRjdET3Z2cXIwa1pJVWZUOHByb1B1ZVFkeGlmUEFGSDUrTlFN?=
 =?utf-8?B?WmswNDJjaVc4dWJsWW9aYkZlYmttSlRzdk5MY3RpSFJlWGdRMVJod3FXOXJX?=
 =?utf-8?B?U1JnbGxlR0NOYzJPYUlIM3VNa3poeWJLcmhGcytKVlovV1ZlR1VzNWc1MEpT?=
 =?utf-8?B?S2theEhvNFhNcTJ1cUkvOGEwaC9LVlB5dkNJMDVSLzg3dUw2OHQzcWpGekZt?=
 =?utf-8?B?cHFKZzBFWVh3Z0dvU08rZUpOTTNIYlZNMWV6NEV6bHByU0JJVURIbXNXS3Br?=
 =?utf-8?B?NzllTk41QXB0Nk9UVnNaUVRKWDlrb0NXMmtDb0UvMWdiaDlpaThBWTdDTitS?=
 =?utf-8?B?WGcraUxGYkg4MDFHZWozWFhRUjB4dnFQdGlIUUVWVG84d080MHQ2NENkaXpp?=
 =?utf-8?B?aXdGemZEcDRHd1FYUXdTT3lOTGFWVXhCNGVidXZCZjhHVlVKa2ZxQW9YWUtF?=
 =?utf-8?B?Q0gySE5aZGxVZ0Q5TXcvQld1amk1YzNIamNOY2NEZTFkQ0E3d2hYWHBIUFNO?=
 =?utf-8?B?cS8rT3IwRDd2U0pwdDR6ZnVLRDJ4TGx3NTBpc29XMkFYMFNSYjh0QkZKTFBz?=
 =?utf-8?B?RGdHS2ZsakM3VUlMZlVveFc4R1dsbUc5cEdSNys1dThpcGVLWk45R28zdHA2?=
 =?utf-8?B?dFptaXNSTmpWNGVLZTBKdVRIb2lKTVVzS1BoZnFORUM4QW9KWmt1SHJWbEpv?=
 =?utf-8?B?QkE4MFpiQVVJY28veXJORlcxSTRFWkl4ZXZrS2kwRWI3VGNZajJtNnlHTjZB?=
 =?utf-8?B?Y2ZHNGxWTGxGcDNTSzlIbkxFdUE5TCtheWc2VjVyc0VEQk8vVDFpcm4zMVJh?=
 =?utf-8?B?TFVNTVJGdnNmVEd0TG9XS0xsb0xQNy9ucEY3bjlTTUVSaVBGdnZKcmFnV1hT?=
 =?utf-8?B?Sy9iSElRZ0UwZ0UxMGw2cmNmbWlaSFlka1ppRHhhVTJZZUtIS0xicWxzSEJr?=
 =?utf-8?B?czFCNlA3ZHFYRGVsZit5cTRVM240cVVYUnE3SFFBdG10QXZzZ2pKd3hIV2xn?=
 =?utf-8?B?SHBoZzM2aFBCZ2RFbnpCdnVtWkhxdU1xdnlZbEkwSklDWG1VOHdVVyt4K1dO?=
 =?utf-8?B?enowdEZDQnF0MUJXQmlua3ZxODA3cjZRME9vaTk3UmEvWVNNcGdEYWlsWjA5?=
 =?utf-8?B?bjdXT0NuZFIzZGd6WExsZ2UrUytiRVdXUGlMajE0bEorQmJ6SDZyUFI4OWFm?=
 =?utf-8?B?U0tYK0szRmFldVcxa3JpaTVGVWZZMjJwQ0F0OG9KRG5hMDlwbnJMeEdiS2s2?=
 =?utf-8?B?UmdKdGNSenIyZ3lsUDlCV1VTcHlCNUVYUDI4TUdwalkvUENHNldTMGt5WTZt?=
 =?utf-8?B?ZWw1cEpUVFNMdGg5MXJId3JtbVZrN1FLSmZBaEpuRWsxaXdqMVpEeGovaExx?=
 =?utf-8?B?a005K0tpZ1p0aE9kTStBOWgxd3JsTXgwOHhTTjVSUUdWWG9FSDZpQ0FNMi9I?=
 =?utf-8?B?UDFtTUNxZEFtUkp4eEFtUm1ZSFhuRzJtRTgxbkZ0UXNXL09WVjRaWnNwMnFK?=
 =?utf-8?Q?8DtMwaCBYho=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4186.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHpiNzd2UTRVL2FwVGpWTHlHakhHYVBhc2dlVkhnQ3BoUnFrRFdqdGRENzlt?=
 =?utf-8?B?dHRrc0Zsd2YxYWVwaVdEOERiSGcvMytPMHEvODZidHNoU0x3NGJEMmxCam51?=
 =?utf-8?B?VlkxUm9aNTMrbzVnNEdCd204THJkY0RxMmlnandWOXFmYitmUk1BSmR2cXB0?=
 =?utf-8?B?WXFhd2IxZEFHUWVlRWVrUUZsWmVWbDlqU0lES3RpSUZhZWJvYWZwZk02MGRx?=
 =?utf-8?B?M0VJY2xTc2Q2cGVud2VTa2RTSHpEcWQvcm43Z29sMmpYYmFMMDlIVjJSNjFy?=
 =?utf-8?B?NmJESm54R0hVSzJZc1RGaEgrMHdXZzNzRmdFZnUvelN4Rm1oNUE3MjNrTVpn?=
 =?utf-8?B?SkhrOXJTbzlqZ3RWYVRhaXZMNXJqNTBOTU9oNVByTXJQVUI4RXk1MHI4dWZF?=
 =?utf-8?B?MTd3T0N6elIwK01aSUxleDBubDNHekV1ZzE0ZnkrcFNNTjg3K1kvNEdvdmhj?=
 =?utf-8?B?MnVIRFRXQzVVWUY0a3B3WDA0R21qVmQzSUlyUlRwY3dzTTdFVU1VbmFBbkNS?=
 =?utf-8?B?NHhyWHU3Ymo0ekF0azFUSGdwTWNPeDNVV1FENGZHY3NIKzczWExzN1lpM3Uw?=
 =?utf-8?B?VFpEbFJFYVZmMTFxYnhwcnlZQ3UzMzJRYXFxSE0vOXltT1R4K1V1ZkdoWElZ?=
 =?utf-8?B?cmxzRS92UUNYNHkrb3RkU2hIWXRxd00rbFNKeVl5L0VsZHBJUS9ldDgyc0dG?=
 =?utf-8?B?YjFYZUJzSUlJQXliWnlkSmNOYjNSNnVhVURTa1h6QzZkN0RoS0tjVUFMZSts?=
 =?utf-8?B?R1l6Vmk5enJjeHZTQmlFSkpnTkZLalJOS3pFdVVkcnR4d0VQOEJUYXo5VktS?=
 =?utf-8?B?VXlkNWhWUmcxbEtQM09lZkVHNW1Ec3R5Mjdnb3dWSVB3MWRRaW9LNmY3L2xa?=
 =?utf-8?B?NTJValpicXZYQ0dDSStkOEtGZjVPc3VsL3RiSm9YaVJnSFZ5b1FDbWhrK2Fn?=
 =?utf-8?B?clM5U1FyMEY3QzFRNEZjWHM0RVovR1YvSm5RMmxoQ2FwaVNyelpGc2hvQVRP?=
 =?utf-8?B?a3NiWmJ4RllGZTcra2s0eVN6dHlROWxSVnM2RkxBM1hLZ1FiVExqamgvcm12?=
 =?utf-8?B?TXRDSU1hdVN3cDlYajZvNFpodzg1M2dRSzNwQW95RjZVSEY3S0Y3OVZIcnc4?=
 =?utf-8?B?YXo1emJxNjdaUWdBNWRjWnhrTVJ4b0g4TktLQndKWTRwQmRIT3BHMDZBV0FC?=
 =?utf-8?B?WHNyN3lDemJRSXg2cDhnSjBvYitMNGp6M0RzNGxyNFk5V3ZITm9xNVJlK1V2?=
 =?utf-8?B?NFljNmtUMjRuNC9EQlZNYjhMSWJvd0I0SlRmdVYycmdMMFVmb0I0dFZqdWkw?=
 =?utf-8?B?MXVjVEtEelZXeGNhRXBaWVNqdW91ZGNMT013UGZyZWFBUlk2TW5IaW8vUHZJ?=
 =?utf-8?B?ZzdkczM2VWZ4SnNNRXVZRm5OTjNPdkxwaHg5eGp3SFpaZTJkL3ZFN3JHakxX?=
 =?utf-8?B?QnMzc1FhbWpZOXpncEtKMFhHMXZLOWRhNjFHNjIvRlFLRGx5a3NXdkxBOXpH?=
 =?utf-8?B?Z0tzSnFRNisxeXBTTjFXdit1UDg2U3kxeTN0MkFUSXFrTDFVOUYzK3VhN3Ro?=
 =?utf-8?B?RHJXN1EvWDRnRFJNbGgzZXRtZVgwSHZlT3hGQXJXMnJYMWJnVzhBNDRLcTBF?=
 =?utf-8?B?UVFnbStNa1dPckRvbWN6N2NobzR0blRqVzlqSGRGZHdOOCsyTE05Y2Y0QXQ2?=
 =?utf-8?B?ZDNUY2g1VzFtM2t1eUVJOGdZbnU3SVBQOVNkVGEzMWpGaEZQcVZWcDJLenhJ?=
 =?utf-8?B?MitoampPRVFVOVk5NU1KVmwwWWROcEYrQm90cHdoWEp3YXoxSEJnZWtwOFZp?=
 =?utf-8?B?T2pQNTA3bTZ1Wkp0M25OT3d5Z3B2R3NuOFBiUmt0bVFEaVpSWFdkWStyUlZ0?=
 =?utf-8?B?TE9nSU0zZUNMdXptZkpLcWNrRDBNb2RCbStTWHlFaXBKRG4yYm4wR3FvNVpn?=
 =?utf-8?B?ZG1HSlpmOEM1a0tKRXJLU2h3R0RkNjhlY2NCaEhDemRXQXgzd0NxZzJVaSt0?=
 =?utf-8?B?c0V5QUJGS1o5cnR6NzJPTGFHVUNsUGU0WnBrQ3VrSTBJaWlwL3lzR0Z2dklI?=
 =?utf-8?B?TlJTNzZQcGl4M0FYNVp5VUxyUC9KWWcrcVJlWmV2NWtwSy8ycVNqWnh4SzVw?=
 =?utf-8?Q?1uU6nkDq8TjCauloI4/WBvS5f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee6f378-4bbd-49e5-3db7-08dd94d14b3e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4186.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 23:27:59.9878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pv+xi631kvtalr5nbqhd7VgRJQcL/SzS5OkPloHbjZWFHG/I6QL1PDRtdcmFSBwLi7zmgbpdJNXyKfMHYg3kuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6208



On 5/15/25 23:45, Joerg Roedel wrote:
> Hi Tushar,
> 
> On Mon, May 05, 2025 at 02:15:24PM -0700, Tushar Dave wrote:
>>   drivers/iommu/iommu.c | 27 +++++++++++++++++++--------
>>   1 file changed, 19 insertions(+), 8 deletions(-)
> 
> This doesn't apply to v6.15-rc6, can you please rebase and send a new
> version?

Joerg,

Yes, I will rebase and send v4.

Thanks.

-Tushar

> 
> Thanks,
> 
> 	Joerg
>>

