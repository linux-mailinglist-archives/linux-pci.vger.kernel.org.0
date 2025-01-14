Return-Path: <linux-pci+bounces-19759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB34A111E4
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 21:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5373C188AA48
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 20:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F141FCD03;
	Tue, 14 Jan 2025 20:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e8LjVNSO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D60146590;
	Tue, 14 Jan 2025 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886502; cv=fail; b=fDZruuTZ+CAw0h2zJNMefxpx49+c7aBYSrjXyXgcu23zGbVhCpWVLI4Cq4edONANMVFdsKJ33JlGa1uHls++cs0XzrKUJDdKtzV3clnkOB3NwADEM1EcqLo91LHpuf61l+cgmWG1PwLYNLsciFOVOuEruzYVUfG+6brebIY1sxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886502; c=relaxed/simple;
	bh=K/vY0wiiCUCOTsGZjuxyGRErPY8Qjj4cqSmTiwdEyOo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WwoGYi0GyTiaFkC72eHnHtr06WN2kWlwDdGZgLjVwuiLJfXiXdmDq+W2w6eLfiEDUyM2kSPVcmwcuhvR8aJ8MwoWKPUKCBRT0amyzXwL0GhbD5PKCZlv1y4pDE7Lk4F8J6w8zRFcFV5myRl7+lDS+CpP3MJModPAa8Vr7hSQvL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e8LjVNSO; arc=fail smtp.client-ip=40.107.102.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xheDRqivkkUGbG3Da+RsdBrtMQt/UcKnMivGZKm+UPKec0BoRYJhWHbyBO7/KQrWUFv6/XYIdaCcDvY1rXcimaMbjkkTNQOL/kWH6CdyH0LiIzqNoSmimIWr9+XEZb52pwhqmRfdRCDUxsNEP+icCzYJEe3rlCosE+wFyPnxsNuEvfb5ZwkkKB4hAWc7VQd0dyOwNW9UPwUqv1YxREkF+P54TmL27oIWz+17Op6i71Kzp6Ysb9b4T4fUvR313ZzSfkGriKaFPk5d0ft7oY0EVvkGJnHBdr0If8pNmG/fVatqX2m/zzOyXGZQG79IoOnnqa9Cdwix49zehsjPcxTYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/vY0wiiCUCOTsGZjuxyGRErPY8Qjj4cqSmTiwdEyOo=;
 b=w+0jcMiaBIO98/pCXJZB0/gDDduHVKNNsUrhhGbO/KHIGE4Yjk9l11XLU25QXQ/B6bbQE3AdyUoGuGcyK/eeMSj/G4qeBz01q4U6Vgk1NPtEXJVZQ20vcJcPg58TeFFeTxVBmBc3t2OvdPIZMfcWnIF/FjrGRG6DZwuEUDNFqWpOu/dcWcjPKVOyftT3dWcvB+gGCDr2Nvj/bJITedIhLGI7Xf7WGEDIBtYPtwUi78spTazOpE3qfL2oBXFl2QQhGTR6749l4nRXTyM5Tos5bqxi88dyXexXdMUtgCKJokGeON2PGpk047Nu8BfqI/Pw4YMsAqSb0HyDlWclwZmzMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/vY0wiiCUCOTsGZjuxyGRErPY8Qjj4cqSmTiwdEyOo=;
 b=e8LjVNSO0fZ5UVmCwfE/POSw0jivIA0+wepkwrC9U1v9EAMIBWxEZKUSBlwc6DggCUQ2mUZxmXOjA5vb4k0yrtrPFxXRzDqzu1CYEVEByL5AyczRh2297M9gqyEUIMin59EYItwGbFKDaH/5XR5XDFTLHX+k3T1SDCL7K78eu+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 IA0PR12MB8975.namprd12.prod.outlook.com (2603:10b6:208:48f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 20:28:17 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 20:28:16 +0000
Message-ID: <eba67f31-57cd-49b1-b062-c56fce306a47@amd.com>
Date: Tue, 14 Jan 2025 14:28:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/16] PCI/AER: Add CXL PCIe Port uncorrectable error
 recovery in AER service driver
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com, alucerop@amd.com,
 terry.bowman@amd.com
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-8-terry.bowman@amd.com>
 <20250114113347.00006865@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250114113347.00006865@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:806:121::28) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|IA0PR12MB8975:EE_
X-MS-Office365-Filtering-Correlation-Id: b027a03a-3a01-46b2-8ac4-08dd34d9fa0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFVaUXpObForbnIzMmxGZjdOb24yc09SUEd1U2FTeEZnQTVvRnNjbGdhN0Zi?=
 =?utf-8?B?dzVjZkNXLzlYZWtkaHpPUWYxaGZSRDRTT3N3dWFablRVRWxpOUw0c1d4Znhx?=
 =?utf-8?B?aXM0TzZieTJBYlRYYnRZczh3RTlXQ2U0RnJOb3EvZG1BVkpsSTdGS3k2Y2hS?=
 =?utf-8?B?clpBS3M4eHcrMFU0d0dsaFhtTGU1RjFNRlhWc09YR1J4TnlTa3Iwb05SRUt1?=
 =?utf-8?B?c2ZWa3lKZDNCRm5LcEc3SGVBaG1GSGJFamx4cmR0K0ViS0RvYjV0MGp4OStJ?=
 =?utf-8?B?eXo1MzBVZlFydGZyMW9mSW1TWW1ySU5xMTgrbUVCSGJUSGdvaFg1bDU1VFFL?=
 =?utf-8?B?Q0hrVjFIeWdZQW45Z082MmpuWVo0VE5oRlA4WVBROG4yWUtLYXErM1g5SEVZ?=
 =?utf-8?B?Vnp2dDJhdENwOUdtWHBxeUFOL296SkNWZHBuUUpuM3Y5a3RjR3J2WnQ1ZThB?=
 =?utf-8?B?UDJxU3BibS9rZjJjVkhGWlc2SWFPZXE0STB3QnNLUVpHUDV0Q3h3dW1oL3Ba?=
 =?utf-8?B?NVlrdStZSEN4WUxFU2JHZ0lrOFpLL3FWVjRRSkkvbW9rM0x1UDNHZXB2M1RH?=
 =?utf-8?B?bWdFY25CRG5KTkJTdms3VEIvNnNVYWZLTWFRSXZ5bEY1VnhjU1Z6enNTc1Vn?=
 =?utf-8?B?bVRWUWVpRFhPa3RPVGZXNHZQQUVlQTJucGs5ZXdRTTAvWW01bG5wWE5peXNR?=
 =?utf-8?B?cTlTWFJzbnBWTGNzbGFBNk91M1FrNmgrdXk3a3NPU0ROOVl5TnRGMzg3aWxo?=
 =?utf-8?B?SlJDWmJVM056RHB4V3dZZXN3Vm0vUnBhYzVIdG54TlkyRkFBNTVaRUVJa2dl?=
 =?utf-8?B?d2JlVlVPR05wMjZXa0xPckZCbEZka05pV2xMbXp1eXMyYWg2Rm51T0E1NVJv?=
 =?utf-8?B?bkMvRTBTdFNobFQrd1ZnZjRFd1NVc0lzRGdmSC9jVE9abXZzU3RTRHFkSjRq?=
 =?utf-8?B?ZjNQRWx0WWNlalB6Wmt0NStQL1RNUXhHMHBiNzRnSU1EUWFZOXlpUStUVE5w?=
 =?utf-8?B?RnIxb2Nta0s4YU9CQ0ZyU20vWE5MYWE1dEZwdmgrdFVpSTF4cW8rbEdTb1dL?=
 =?utf-8?B?TUhLOWp6UFhQNDVmeWpoSE9wMVJEL1FxWFdLZHNhM2RjR1NBamsvbzV2WVNX?=
 =?utf-8?B?MFlVRWJDTHNOdksweVBQam95dUdpSDh2ZmZCVENPUi9lN2l1QXRQNW1UcDFG?=
 =?utf-8?B?aG5mcGhZMUJ4WmFwaE5TN3FMbmpEbDg0Q0dENlVzQSszZ21TZERiWEpCQ1lv?=
 =?utf-8?B?Rmw2VWlJVGtkTmlScDBFZURWUndpeExZRXRSNi9tYkpnOUUyN1gyZEFaakNl?=
 =?utf-8?B?RUFYOHAycFY1TkIrNnBmbUl2TGo1UHVOVkRKNGd3bFdydTJOc0FMR0pSYVBt?=
 =?utf-8?B?dHIyNGhubUVna2tsZVA4QnIvL2pMK3RTUWpRS2gyVTdCWE5zTGg5NkV3Nml2?=
 =?utf-8?B?dVhjU0xxcE5LUGNzb3V2NXJ4UWRRYlpuZmtOUzlpaDV4cnJZNHkxNjAyZldU?=
 =?utf-8?B?d00zbml1ZzFsc1Fad0ZydFFFMEYycHlMWVVPMXJUelUrWGhzbHR6bElBRHhY?=
 =?utf-8?B?UkZMNEduNk44aitOVVBWQXUrNXp1YndFMHdxa0pkSHhMczBLRXVNcmNFOGFj?=
 =?utf-8?B?dHovbkNVTUJtZ2hwTlNWVmh6OGl4bjNDVStGZnlYeUNjbHdMR0VlTEIyZjVi?=
 =?utf-8?B?WEExNXlRb0QzQ3BCV1RtSXJYRHNDdktSRmEvamZJL3QybFVGVDJScU9LZ3lW?=
 =?utf-8?B?T2ozc3RFWUJTb3BsVHJ2QmpSOUYxMlVPMmVsaHN0VDUyR1NyY3ZXSndkZmU4?=
 =?utf-8?B?VktrdlFpUzQxY0FTUnc0SDRzNHJhdFhVeDcwNlpFeTU2SlNaMkNDdGJrRVBW?=
 =?utf-8?Q?ufJcxfF/rRKbh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1MyNTVLYjdSY0lrV0I0bUZxOVo0UDgvL1BCd1JYQU8yV0UvT0QyNXgyVHZ0?=
 =?utf-8?B?ekx6cHFTbE5hNy9YSElSQk42cDZFVW55cUJWaWVrTWUveGNuOFBWM2ZXSlFC?=
 =?utf-8?B?ZnBZSU1hVlpaa2srOUNQQ0wzbXR0Mk9rSEh5NFg1alRsS2hLSWF0Yi9oY01z?=
 =?utf-8?B?VXphT3B1a0tQOHpzR2lHcVhEN2MrdUxheSszT1NITzIvSVF4Mmd0eEszRERE?=
 =?utf-8?B?S2JPR2dMNGhXamFMUFR4N05Wc0MwYmJISDBpRDZpeHJ0T0tvazJadHplRitu?=
 =?utf-8?B?b1JDY3BtWU41UWhxZUtJV1BLZHV5U2ViU1REVnJ2OFM0OTNjUXRzSWwyUDYx?=
 =?utf-8?B?dHZTaUJYbDU1RWNDSDJhaUsyZGF4cm9md0xYZDdsRllXdlB1aW84bXppdVp1?=
 =?utf-8?B?VkFzc0tkdi83VTl2NjlSaEdrSFNackNlQ2owQWh0TnlTVEYzUk9WamlnbHRO?=
 =?utf-8?B?ejdxTlFReEQxc2ttaW1maXBkQ05jTVZVZFAyNDBVSTZCZmplNDhtZmppM1N5?=
 =?utf-8?B?ZGdTOGZjNkhDZUVXUkp4dVJ1cVNhS0s4MjNhdzFFd2s4emtpQkVHNGJ5TTdz?=
 =?utf-8?B?UmZ5alNjVmtCRHVRZklPMVg0VFJnRU8xNTFQMGVvVllnVjcxMFYvQ1pQdTRU?=
 =?utf-8?B?ekRvRVJiMzdXMlRVVkdJNXlGTCtheDVTZ3JpR1hUL3ZtYUE4LzRFSnRRMXZ5?=
 =?utf-8?B?UHFkOThoZmx3NGxOQ3F1VkhpRGF2S1VhbU5HQjNqblkzVEN5KzNjams1R0oz?=
 =?utf-8?B?eisrSDVJS045Y0hqaTZqQW9hdktWWnJIdGx3dTNyYzRHUStwUGQvb2JMNTBS?=
 =?utf-8?B?K2w2ZFFjSGU4cTVNQllEQWZIVUdOc1pJcTFtbDNMQ015UWw2eE9uaGtUdHY1?=
 =?utf-8?B?RkhzK0Yvd2xXblgrWndLN3FXQ21Pd0NUcktGU2QrVUpPeVhReTZxdUd1SzRy?=
 =?utf-8?B?VTlPbnl6dlBET2trcmRuQVozZFJyZXJ5WGhvQ0kvY2Q4SVVSSm1BZDNHMzVV?=
 =?utf-8?B?UGlqREdPODdNd2JEZzF5TDNhRjdRYkt2YnlpNkg0NXpybmFPdVFUZzNnRDBG?=
 =?utf-8?B?a21Dd3FTMzI5SDVQc0hyN0RsKy8ybm5lVklYenlBTGFRVjEzYy95OHlyQjEz?=
 =?utf-8?B?ZlVwaTkwSEpyWENtUFhFMm1rYzV2NS9CanRwZ0tscTdQVUhqMVllRXJiOVlV?=
 =?utf-8?B?ekY5MFJWTXlJVTdMMFBERFBxSWxMNmR4YkpIMnJ5cUhVU0cxZnNnbkhxMHRt?=
 =?utf-8?B?Y0hKVHdYR2oxcWNoMTBZRGt1bWR1c0UvYnpBdVJQVGpoS2xhdUJQUllsNFVh?=
 =?utf-8?B?Ynk0VHhoQnJyOUhoZ3RTTThyRkVKNDA5V0pNWmVmZS9JYWppczFuZzlSMFlT?=
 =?utf-8?B?V2VHdzhQa0NwWC9kNGNXcGl2SGVmL3h6cmhCbWp6clJjak1CZHZtMXU1YStj?=
 =?utf-8?B?UkRER1ZUY2ZYd0FEM1hPd2NBRW1LZXBRY3lFUzdOR0tyVFZCTWlVM2Q0NU9a?=
 =?utf-8?B?K2ZZdGs3Qk5kQ0E1enJ2dXBBd2xHRktDeE5aRjNmYU5LaCsyaHBQTUpjSXhu?=
 =?utf-8?B?R25jWmkzZ0JrZjM1SmgzdFNZamNEQ2ovZGEyc1djVVU5Sk10T3hQdEZDUGRC?=
 =?utf-8?B?V3Qvb0tXd05pYitaWmJXQXNKUWE5dHNhazRaRWd3L0szZW0zbTIxMXRES1pH?=
 =?utf-8?B?SlZtSTd3cmZpN1NwS21RU1pzYW9oSytDOE5VRlE3YUI3UnZxUnJXL1RZcnZt?=
 =?utf-8?B?UXQwcFRiZVFLazBGaDRpcmUyZ0RLWWExdHVaSnR6K3pid1BackU1dk5WN0lv?=
 =?utf-8?B?RFhHcENvdWVlSnFWQnE1WWxYbHBTY05ORlBwT0dKdjhDcTZMaStlWW9LNk1Z?=
 =?utf-8?B?RTRHZXVBYXNSMzFVQjZJYTlqaGErRm9VK1V2cHJSL1RNT2l4UGNMQ1pEV2FK?=
 =?utf-8?B?bmxVK01HS1hXV0syelA3UWFVUDB4dTVGMkZPRTJUTlJIWEYxMGwxTWdqWlBR?=
 =?utf-8?B?eGl0VWVqY1dGTGt4dlc3dUF3Y1lENVdMMWd2QVpDL1BYb3ZXazNLMG5LdnUr?=
 =?utf-8?B?UDA2TFNRVU1saEc3V3o2TTJoRHNZRE9UTDRUOG9NYVU2VndxV2FzdTkzYnFT?=
 =?utf-8?Q?D6ysxDu0ph0MRy/xVsj8ERISU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b027a03a-3a01-46b2-8ac4-08dd34d9fa0c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 20:28:16.5697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m72JWnv+RQVXN3hsIt7fllUyb1TYo0FNRCpmhdo4t5qyBmmBRoGY8wfwbxJGXEHcEdwdbnks4B2cZpwUMCH5bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8975




On 1/14/2025 5:33 AM, Jonathan Cameron wrote:
> On Tue, 7 Jan 2025 08:38:43 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> Existing recovery procedure for PCIe uncorrectable errors (UCE) does not
>> apply to CXL devices. Recovery can not be used for CXL devices because of
>> potential corruption on what can be system memory. Also, current PCIe UCE
>> recovery, in the case of a Root Port (RP) or Downstream Switch Port (DSP),
>> does not begin at the RP/DSP but begins at the first downstream device.
>> This will miss handling CXL Protocol Errors in a CXL RP or DSP. A separate
>> CXL recovery is needed because of the different handling requirements
>>
>> Add a new function, cxl_do_recovery() using the following.
>>
>> Add cxl_walk_bridge() to iterate the detected error's sub-topology.
>> cxl_walk_bridge() is similar to pci_walk_bridge() but the CXL flavor
>> will begin iteration at the RP or DSP rather than beginning at the
>> first downstream device.
> I'm still holding out for making pci_walk_bridge() do the same and seeing
> what if anything breaks.

I can test AER fatal UCE on a PCIe device. Do you have any other ideas for specific
testing? A specific device or topology in mind ?

Regards,
Terry

> Other than that I'm fine with this patch.
>
>> Add cxl_report_error_detected() as an analog to report_error_detected().
>> It will call pci_driver::cxl_err_handlers for each iterated downstream
>> device. The pci_driver::cxl_err_handler's UCE handler returns a boolean
>> indicating if there was a UCE error detected during handling.
>>
>> cxl_do_recovery() uses the status from cxl_report_error_detected() to
>> determine how to proceed. Non-fatal CXL UCE errors will be treated as
>> fatal. If a UCE was present during handling then cxl_do_recovery()
>> will kernel panic.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>


