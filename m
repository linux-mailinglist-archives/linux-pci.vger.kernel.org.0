Return-Path: <linux-pci+bounces-21227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCD6A316CE
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 21:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7DEF7A200A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D9F26158B;
	Tue, 11 Feb 2025 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZwDRYL9B"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B91D89E5;
	Tue, 11 Feb 2025 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739306431; cv=fail; b=k0HPhEepE4qVKY3XaL5PDUqlEzsiQ9PS/RHYf+VuakEmnoV/easkaAJ4R/e0ce+a+nWyLWEK5Po5+N382rcufsopQtaTq9ogJYMiJIoVxovR2r9VWfrgJZOFH/AGUtthezM3CpNtrOekGng+6/lFPcgqvBcBLLPKBxNlZpJjyDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739306431; c=relaxed/simple;
	bh=X1tj/LlPt9WTTHwo10IGwegAH+e8tjjW5CKfVt/M+yE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JK/Nw8G+2m5THci8vQG0YWoxJAXB5qEh9Te67TWvFTjmxmSvmKREUfijQ3+ilW9tWsD67o1P0rFyNh2kf4JZV0aqMXMgTNCotx84Ivv04e6DJYzipEkvS1g6FdG6ma+Znlz1GjTj5UEHJel+TpfHd0LTl9La88/q2khlgT6UeNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZwDRYL9B; arc=fail smtp.client-ip=40.107.101.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHXkq2V7lvuiclTM9oRK402QMz6AnVKZDQ2e2MEJ7ohjvm9VX5meEreoDz3dBpwTqkZ4KXthnPKoZ9ljGIjs2Ior7QMe+Q1M37fKJuU50/pfSux5gZUc19CYth/GdSn6i5jZ/PqbyTjA9cW0HrdwIs8TOJnRJQZ8wvLO5RPRBBlHDo6wynuG4WlIRVJlEpHbLIn7Rer7eUeu7TxpGabNQgUV2Q33is0Biaokg3f58TM5r8skWeQx0LQhmP9Lh4s5L24R+f4+tbXIlYZK/VXHz952hApLeyFzV660nNmS5yVawYkZrLx2ojhv+a1iin4RyffRcHnN5e00J/UUvtdtQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8A5Z6rr/+o2MFpOBuAa8f1cNx9ExbI4wHvkWGdhnXM=;
 b=MRN4Cqg4fpf2KwVVq8Xr0s5q4y8EB24h2r8IY84nlQgQshePacFofQO5Bra00h9TfZSzUm1amdEjdYzbrNdUjVFf/x/NPzh2K1G99eQ1u4gw4Ckrw3DSRkiqXvd+X4wIDq8N6JEzZWYB3z1pJ6KtW05vQMdygyHd4kC2vQXWbjugPRvjvEppgGshfrHgwDIkfUSHicD2AqC+v9DF3lprfjbCAyiEnBJk6iy7/D+E3WmoedMjx8oJscZx/a0cXC69UKuFogozmk6GQSpR04bFeJ4bR8MoFx6q9LFEH6uuYEYc18uophbqI44lbcMBzpwQ/AumTgLLyS7CIA9i3m2tAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8A5Z6rr/+o2MFpOBuAa8f1cNx9ExbI4wHvkWGdhnXM=;
 b=ZwDRYL9B5b/Y5b1CafLZyDF4EqWQ63lH+vAXLsvIqKO9cYdw6K4d2Req1M7gDhAdrYv7LszPVuaNWY1VOu5zRHZBWu3Vevz/3y1L1S/FgJtFhQNqWT7ISvzknkG/O1bDf2m5etqn3gmSCEtdqwzc2a53DSEkOlaMQFpvD257Pws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ2PR12MB8740.namprd12.prod.outlook.com (2603:10b6:a03:53f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.17; Tue, 11 Feb
 2025 20:40:26 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Tue, 11 Feb 2025
 20:40:26 +0000
Message-ID: <17b51b94-1375-47bd-84fd-b9ca1c4c3b45@amd.com>
Date: Tue, 11 Feb 2025 14:40:22 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/17] PCI/AER: Enable internal errors for CXL Upstream
 and Downstream Switch Ports
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211202523.GA53686@bhelgaas>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250211202523.GA53686@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0064.namprd13.prod.outlook.com
 (2603:10b6:806:23::9) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ2PR12MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ab9747-c7f3-441f-d1a8-08dd4adc5034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjI4NFdpcVJVMGFzZlZUOU9kTDBRNy9XOVFnaUtYT3VmTzhEdzRZZmZ3UFZD?=
 =?utf-8?B?dFExK1dvN1BMS3JUNDdOWFlGTFN0bGFzZXhBbEE1VU1SRXcwdy8ybkROcVNI?=
 =?utf-8?B?WjV1bk1XYXlGQWgzcXdSOUs1WHFraHJnVmxEK2NiOG1OS05Yb2swNHhYYWVj?=
 =?utf-8?B?Tkt5cWNET1ZPRkQ0T0dNMXV5UWxUeG9mR3dUcWZ1ajhOQ3dTeE91eGxTbmVW?=
 =?utf-8?B?Z0FTNTZqbHd3bUlsS3RzS3RzN2JoVCtUd1BPUDV4eHRldmsvSDVTUFBVWGcx?=
 =?utf-8?B?ZytTMW1Gc25jckxtdTNDVERDVHRXZW5Idm80WUlGZ01UVFcrSE4wZjJ3ZUpS?=
 =?utf-8?B?K21vMGhvRWcvREhUYS9FeUJ4bkswdEVGNGYycVJzWm53cUFxK1FiTEVFYnZL?=
 =?utf-8?B?VmxSZS9lWWVTc20zcEZLcTVKTzhZY1NMczdWMkYxenJlaWxrdkRlS1hqaXFL?=
 =?utf-8?B?c3NvYWtBUVNnb3lPeG9RdzU5SzNSWWN3TTl3OVJhMEpPWTRoZjBmWHRQWGdF?=
 =?utf-8?B?QkVNclc3TUhVcy9mYlpna21HcmYxSEVRdytYaTJtb0F2VVNETVpGbk5EK1NH?=
 =?utf-8?B?SytFR2crTTJ5R1lVNjl3dFJzMmFRUmZYaWJwRUNXNFpobUVIa3NocXpFME9z?=
 =?utf-8?B?OWNyYjIwSE1jNE4vTEplSnd0cW41T1lvMExaak5mK1lQTGpRckUrNXVRQ25C?=
 =?utf-8?B?Z0pyVWEwU0krMVY0SHFXRVlKRk14b2Q4d3FHdFVMZmtYYmZ6dmlJSmc1Wm1J?=
 =?utf-8?B?N0x0dXV2Q083ckEvSnZQa1pVaTZ0WHIrc0xRdHFYa09rMmR1bytJM2p3UzQy?=
 =?utf-8?B?LzRmQXNlSG1EQUJvSGY2ei8vajJHZnB1dUVJNThRWS9ibm5xY0VnVEhDYWxZ?=
 =?utf-8?B?TVJnc3ZFbFFXaUUyZ0hFQmVNYXNpMlRVeVFuc0QxbUpzSngzaTNrVkU0Z2NP?=
 =?utf-8?B?SVBJSnU4M0l6cElhZjhidXFTVXhadGN3N0dOT05kTWx4SzFpcFJhYVN2WHZI?=
 =?utf-8?B?WENsaXpVeUpJOVpHN0l5cm45WGZKNkY4M2R1KzlPN3l4dURpL3JQbCtPcUtJ?=
 =?utf-8?B?dzFhUTNiY1hMTzZwaStaOHAzeEJ6dGxkUFR2cjIyZ1RuOFNrNStwcXYwS05S?=
 =?utf-8?B?YXBpK20rdk1RR1NlajgzT0JmRWR0Ly93QWFKSXF0QTJrdDZpYzJuMmZSb3gw?=
 =?utf-8?B?T0dnak5ocDFkeVFWVm4reTg0UDlFbFRZZXBLcStRNVExM1NIRGtYNWVJU0p1?=
 =?utf-8?B?aEsvQlF5bzlTTjY1WVk5L1N1ek9vQXBhOTJXUUVUNWhDc0xMSWs3M0piMlFF?=
 =?utf-8?B?Z1ZLSE1uc1F0dnFoVnNlQWZSNTVwV001b29WT2g0SkJicm9TdTZQMC9iUW9C?=
 =?utf-8?B?cUhhZDFUY2pab3dMNW52dDFRbGFMVDI4WkNML3dCdWd5SisvMjEzSzVBOFpZ?=
 =?utf-8?B?OW55enhzV2owTFN3VE9TcnExczgzT3BxNDdEck5Gc0k5dm9SVnUvMnZaWkNW?=
 =?utf-8?B?TFBXb3M2elA1UWcwdUJMSldLYktxSkVEd2ZLejV1UEQyT00zRndzTWh1MkNH?=
 =?utf-8?B?aUpnQmp0cjhLSkJWMTdRRzlTQm1DbkJucUNDK1h1cHFKMmgzYmN5elRpOEYx?=
 =?utf-8?B?WXpYUU5OajVwU2x3WGVWdDVVTC8rb09HWE9QS0U3cVhOcnIzR0F5OG1ORk1k?=
 =?utf-8?B?UFd3MjliN0Z1QVVaK2VCUTBJOHJkaWNnWjNGS3d1UDRuUVhPVlBIVHBNMmRU?=
 =?utf-8?B?cDFPMDJVSjdCbXFYZXc1V2FXSEovU2NnN0xBTEhLb01KTlU1cWZ6eGdFOEt4?=
 =?utf-8?B?alhKWkh1eE5WVUo1cW5BL3JsSnk0ek9KV1hjbFd1S3RHbDR5cG00UlkxaVFp?=
 =?utf-8?Q?vQiuOffVfD5WN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2NEWHY1Q0Q2d2ZOTHBPdmJjTW5iNk52QzlFVVJZeEdDSXd2RzN2b1Z5NmNX?=
 =?utf-8?B?akNNcUVIdFZXMnd6Y0xmaUVvQVdxZXBhWVVxVkdweVB6czJFTWkxaVR6ZGFF?=
 =?utf-8?B?K1ZBVklxRjczNFFWbGRQK05ucUF5QUVFNi94eGVGYkxoYnBVVmtJL3FUT0lK?=
 =?utf-8?B?UDdEU0VhR040eDF2Z1dPaHUzMGZZN09xcDR6R05sUGwvaDU3blFyWUlZdEM1?=
 =?utf-8?B?TWRNQ0ZWS1Judyt5dzc4aXIxN0hZSUJxSUJXTy9CeDV3KzMzb1VMYklwU1V4?=
 =?utf-8?B?QURoWHdKVUZ5d3VFMzRlL3hxak1VVFREckJpMjROVC9FQi9RQnNGdnNML0ZS?=
 =?utf-8?B?TDNBSXBteWlqc3M1cFN0MnZvSllUcndORDdVakhEV0J2YkVZVU95OGwxdFZx?=
 =?utf-8?B?aFpCdThDd2IrZm4yZlYvWG5rM2FVTzkxYmhGTmF5QnBoMkZIekNFOUIvcElI?=
 =?utf-8?B?azV1YUlQWFF1bG9Dc3RsUVk4WnNVVTRMa0dTYVpWMVk5MjdzcnhaNSt4REI4?=
 =?utf-8?B?cVZ4ZW9HNXh1bVhlMVYyaVhFMGpEME5VU3F6VUlJdWlodWpiZWpveStWUFpR?=
 =?utf-8?B?TlorSTExcUIvNHBLMENmUkhxckV0dEFza0czY3YrUDU3Zlc5WGc2UjFncHFC?=
 =?utf-8?B?YXNjM3BLZC9BY21FQUZMaW5KWUFzWk01OWtOTkpHcTBydkxjNi9DdHozK0w4?=
 =?utf-8?B?WmRnNE1zZzJOT0VrSktxNnV2dVY0TTNUSUdPSnRWR29HUDljNkRYQ0UrSnNV?=
 =?utf-8?B?NkhhYzQ2blErZ0UwSHh5YU14N3hnYVRSdlZaMVUrZklXMUpIeXIrWG8rdW1q?=
 =?utf-8?B?Z0ZRNzN4OWRvQ2lCYWI4ekhZaUdISHByNDlVUkU0b2N2UXVERDZVRHQ1UUxE?=
 =?utf-8?B?SXdMZERrQzlURyttandZWGt0clJBOTZNVXJJTjY3b1BhdXJ2Q2dBbTYxMUF5?=
 =?utf-8?B?WjdFeHJjVTRmS1h1UHRZUHhnSnhyK01HeVJmclVkRk5mUSthWUM1R3Vobmsr?=
 =?utf-8?B?d2s3VUxnQTUxNDdFTWEyNmlZcll5aTBBdGl0bndwQzV3QXo3SEVFYVVXbmpK?=
 =?utf-8?B?aVhyM1d1eDJ3bThpOGZNblUrRDNCTG1EUm5mMHdKajIycDY1cEFOTEpCbTlN?=
 =?utf-8?B?NGtaOUZPblNBMVRwUWJZdXZvakozZDRvQmZXOE02OGxyUTNxRnpNMFF2QWpO?=
 =?utf-8?B?Y3A4aWpUenVrTTBPRmRTbHFpTHhXZTRBczNIWTIreWJXZzk5QjZLSWgveVJR?=
 =?utf-8?B?SHRRbzFFUlJIT3pDOXJNcHEySmNTUU0xS0l6Y3lCTEZKcGlFMXhGckRuWVhm?=
 =?utf-8?B?cC9vaDFmVHNKNnc0elZJcWtlekl6S2xubU1GYWxDanNTVlByUmRZSFZ4aGR3?=
 =?utf-8?B?SWRiQVk2TS9kRWRvdzUyYkx3ZHl2VzR1b1pWZ0FjMlRyUitqbXlBVmo2bGxS?=
 =?utf-8?B?dlN6SlcxMk9zeGl1ZXRiZTI5djMrUkh2bWRQOUNyR2pQZE9uTGRZYjUrZXdJ?=
 =?utf-8?B?aXkrc3FWTEtrM3JXcEQ4Qjd1Rm9yZjNQQlV4aG1EbTJYRzJ4TUV3enVVSzd3?=
 =?utf-8?B?WE9kWnE5K3UvMlNLRk5mOFMzVWdUNWNTb2hCbk9sUFV1YUFIQkxTSjhsNVBw?=
 =?utf-8?B?NjVSZWtXKzlrUHRxYTlwQkY1cVhWeHEwb2dzL0FWbGdDODRNd1cxNGpkamxj?=
 =?utf-8?B?MmU5MEtCTVQ4a3VRY2Y0VFRwNmg4SUhVR05OeGlJdHB4aHVUZ0tzSHIzUXJx?=
 =?utf-8?B?YVZsNmhNVnZiRFpYaUxnRUR0OWwxL1hKS1NUMTcrVC9QWmtINFVPMEh6c040?=
 =?utf-8?B?MXoxTnNCbTBNTlovOWx1S3U3d0dyVHpvTHE3ay85YWNpQXBlK0ZzWUNYUGU5?=
 =?utf-8?B?UGVCeDNneUxnV3JhSGI3VkFHNjRTYzNNVkhtV1VhRU9kdzNNcXJCVDlKdEIy?=
 =?utf-8?B?RkRpVDhveDJ2bG54cktZN3luc1RMMTZVNW4rbnpZM21tRDhRSEpxUlc4c21q?=
 =?utf-8?B?MHhMQVZjNVpSbHJ0SGlsMnBLMUdOczJGUmdpb1ZjbWxCb3JYQXQyM1FaVDRx?=
 =?utf-8?B?bURIT1lNRFRxV09rbW9hRjZTdzI1V09MK2k0YW5LNlNnS0lhYnJ4RU5DZ00x?=
 =?utf-8?Q?P7bngRKQlXcJrP3zpgw5zb2kp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ab9747-c7f3-441f-d1a8-08dd4adc5034
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 20:40:25.8151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8yeWcivKJ3GBbud9r9I+fU5jrciUUSVhLMzvhTKrN8kjdu2CiBVRg6ZRq+d0oH1ygkO139etEmLMJ8UkDoEZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8740



On 2/11/2025 2:25 PM, Bjorn Helgaas wrote:
> On Tue, Feb 11, 2025 at 01:24:43PM -0600, Terry Bowman wrote:
>> The AER service driver enables PCIe Uncorrectable Internal Errors (UIE) and
>> Correctable Internal errors (CIE) for CXL Root Ports. The UIE and CIE are
>> used in reporting CXL Protocol Errors. The same UIE/CIE enablement is
>> needed for CXL Upstream Switch Ports and CXL Downstream Switch Ports
>> inorder to notify the associated Root Port and OS.[1]
>>
>> Export the AER service driver's pci_aer_unmask_internal_errors() function
>> to CXL namespace.
>>
>> Remove the function's dependency on the CONFIG_PCIEAER_CXL kernel config
>> because it is now an exported function.
>>
>> Call pci_aer_unmask_internal_errors() during RAS initialization in:
>> cxl_uport_init_ras_reporting() and cxl_dport_init_ras_reporting().
>>
>> [1] PCIe Base Spec r6.2-1.0, 6.2.3.2.2 Masking Individual Errors
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> I'd say this is really a CXL-centric change, given that
> pci_aer_unmask_internal_errors() is only used for CXL and it's
> exported in the CXL namespace.  So I would use
>
>   cxl/pci: ...
>
> in the subject.

Yes, I'll change to cxl/pci. Thanks for reviewing.

Terry

>> ---
>>  drivers/cxl/core/pci.c | 2 ++
>>  drivers/pci/pcie/aer.c | 3 ++-
>>  include/linux/aer.h    | 1 +
>>  3 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 03ae21a944e0..36e686a31045 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -912,6 +912,7 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
>>  
>>  	cxl_assign_port_error_handlers(pdev);
>>  	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
>> +	pci_aer_unmask_internal_errors(pdev);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
>>  
>> @@ -959,6 +960,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>>  	cxl_assign_port_error_handlers(pdev);
>>  	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
>>  	put_device(&port->dev);
>> +	pci_aer_unmask_internal_errors(pdev);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>>  
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index ee38db08d005..8e3a60411610 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -948,7 +948,7 @@ static bool find_source_device(struct pci_dev *parent,
>>   * Note: AER must be enabled and supported by the device which must be
>>   * checked in advance, e.g. with pcie_aer_is_native().
>>   */
>> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>  {
>>  	int aer = dev->aer_cap;
>>  	u32 mask;
>> @@ -961,6 +961,7 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>  	mask &= ~PCI_ERR_COR_INTERNAL;
>>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>>  }
>> +EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
>>  
>>  static bool is_cxl_mem_dev(struct pci_dev *dev)
>>  {
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 947b63091902..a54545796edc 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -61,5 +61,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>  int cper_severity_to_aer(int cper_severity);
>>  void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>>  		       int severity, struct aer_capability_regs *aer_regs);
>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>>  #endif //_AER_H_
>>  
>> -- 
>> 2.34.1
>>


