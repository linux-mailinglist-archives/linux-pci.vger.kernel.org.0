Return-Path: <linux-pci+bounces-13392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F156B97F1B3
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 22:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B1C2823CF
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 20:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7851A0B0D;
	Mon, 23 Sep 2024 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yfrBmF6n"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ACB1A0727;
	Mon, 23 Sep 2024 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727123254; cv=fail; b=Zt5+1knHc2CSEkjiz7872WSfhXCEUn8d46ZmUEjbYN5q4wjH2UCEk62BYOuxDRnihjHLJxIwKmSQaEtutkz8J8WtLM5FkoNdX587jmaj6f/CvI3hAQVgTKEF0qBKMxpq2jJ6m6roCg+POXz0tmHbbPaRriNYECPBVv+JsFEoXws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727123254; c=relaxed/simple;
	bh=iZZnUBOP4nsS56lzfinbrKBK+Ke57kegCRyhk7B6Z1I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tYcYpWkhcUjeiB975J3t7fzdjGvpkPNLzJ1UeIFxt/sgcBWqHl2RlYHD1Z6SF0Hu/5eW/fjUYyDX71t4LKUK7HC8OrmDNI+56AVqhyym4h0FD5dqDPZ58M4Jh0oMH9QeNFeua2W27G2yZZN+VoCzHmrJVKiVmJAY3WnmbjFAalk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yfrBmF6n; arc=fail smtp.client-ip=40.107.95.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZyWN0i/fJ2daI4Y8cLlRq7al8Zf630rBbUwIweZMzPXmLdEvqNXMEbWoXBy6IBMEh75F395y/A0z2Bp4o3L4cRF4CPxEN+XDqGcXJYdTdggxK+eG3/fSfTvAXSeXQ+sV74mwu0L7V+c/U2XYDlKRjXWoWb46tnG6M5bTk5OQGHOquVCxfk8SCGs8BqArL2INE0Zqs18zfzdZczTXeGGHL+/ZPo/eU8JGavcf0J3Ut5P0Zdj1FUC0T/2vwnmLEvRDkXrWRa5nKAupnvwzep9q+hpIYk+RPWrEBelEwDhZL99z4QZq/sRiHoVHxTfxSyb02U4th5RPJARbjRl5Z+D7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51ztSRbIjShQLNfWtkzryiqD0zg1CdXPPGjmIH7rcho=;
 b=JZdNSPjJzbw6jqbMee/YM3UJuy0XG6mixqTConnQROVm/Nrvb4OvfCj436w+OnuOcUHPDszx/RQdPR6G+6Oewp8a8DiJ3uEfgKNmvJfxfTjDFoKE7fzVN+oFg3SFH/IodOqwbeuXAO1dmz48sCEl/GnScg/VKAWqiS1TwD5Jpggc9c5HYOa2Qz3Z9MJA6U7qT0z5iSsvd1USRHx2L627osCZrSd0ObwgLxD00kpNw+Np2coFVvkMRjSq1w5iBF+LRyunTFEKq3Rm5HOtWYYATgD1g1Yjd37ruRYkpoMAIDdOREBrLz3HIiKNe1BGDY+bPuGHoZg1EIaQrliI7AbD9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51ztSRbIjShQLNfWtkzryiqD0zg1CdXPPGjmIH7rcho=;
 b=yfrBmF6n9B3/9oSRgFpqKVWAD+dj8gD4NEse5R5q2bV/PKkF72KULAZJIIgsG0QXJM9fgToG3NpECFUtaT2fjX2AHc3yassw9/k7QItshGnQiee0b3E/zqGOK0A7Ik2/vHb1VtkPb+KHNL2O0r/obaCC/Lu5xtY/yl4Vo2hTri0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 20:27:29 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%3]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 20:27:29 +0000
Message-ID: <87111ebf-9cfd-4e14-9c03-05aa65330070@amd.com>
Date: Mon, 23 Sep 2024 15:27:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 1/5] PCI: Add TLP Processing Hints (TPH) support
To: Alejandro Lucero Palau <alucerop@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jonathan.Cameron@Huawei.com, helgaas@kernel.org, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com,
 lukas@wunner.de, paul.e.luse@intel.com, jing2.liu@intel.com
References: <20240916205103.3882081-1-wei.huang2@amd.com>
 <20240916205103.3882081-2-wei.huang2@amd.com>
 <a660f2be-55a2-eca3-bfb3-aa69993f86e5@amd.com>
From: Wei Huang <wei.huang2@amd.com>
Content-Language: en-US
In-Reply-To: <a660f2be-55a2-eca3-bfb3-aa69993f86e5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::14) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: da3f9f60-040f-4811-9d5b-08dcdc0e250f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MU53NHJMTlBaK3F5QVVYVTJQdWl0blJLSVR2VmpHbXllZWFHSUJBMDlaM2tp?=
 =?utf-8?B?aWRiMXdEc09ocDBRclAzQU4yZWZPVmhXdkwxMW5JR09TWlVJZ2c0b3JEeUps?=
 =?utf-8?B?QjE2MmJXMmtPRU1wazBRd0E5RDVCQ2xlSUpZVWFWaUR3Ly9wenZrZy83d0pP?=
 =?utf-8?B?cXFEcmZ6T3RjOU1GMm1ubUMwd3AxMGtncVAyRGhUUlQyTGZ4dHA5bGtJZ3c4?=
 =?utf-8?B?UkIwT3dxUVdlR004elR1VHVpL1JkS0FZdzh0QmxOYXRYOHBIQkNxZzhhZmtn?=
 =?utf-8?B?WGYvNUo0UEtGL2lyVGVaMXRVMVNrRGkvT2ZPeEVBdnlrVTVaMkxrR1hyaEI1?=
 =?utf-8?B?UE9YM0pDUHpHYmpDb0RKenJqYWlzMjNGdnc5eVRTY3hKYmNEbUtkQmsxN0I5?=
 =?utf-8?B?aytHUVhkVFkrejJOb21nOGJVUGJwQTRjZjd2aFc1VkRseUQwaEJmdmVUd1Jm?=
 =?utf-8?B?M0xST2hhSGRBNFV5cXVxK1RUQVpROVNHRU9tK1BGYWJlMzh2aTM5R3IzQ3l6?=
 =?utf-8?B?R1RVejZsNHRiQ1A0VDBjL2xCa09qL00vK05xc2gvUFJNVXFxRnBHKzhzMUY0?=
 =?utf-8?B?dmFPS1oyTlhKTW8wNkRzTUlkaEZKejBDMmFwZG5RKzZ5OXJQaVkxRVlFS2Jo?=
 =?utf-8?B?VWxFZjNkWksvNkw2MkFLNHRaM2EyNXdiU2lCOEV3dUhuZURITkF3ZXY4QkxH?=
 =?utf-8?B?eVM2UlA4cnFSMDUvdWNDNFlpbXM1M0swWDlPYXljeEhEMmEvZUZjTHpGUEk3?=
 =?utf-8?B?T0V5eDJoaUpKZFdUTlJGb1MrRmVmaXdPUFNFd29TUkFPUTV5Q29ZVk15cjhx?=
 =?utf-8?B?WUVpSHlQNG9hNHdMaEwyTjB0c1lzQ3RtMjd3clZqaHBBNjZaODJ6QzJySFdQ?=
 =?utf-8?B?Vzk1dVRzTTZBZXorcjlRWTBWckVpQ1JWMmlDdFBHMzNvdStvVjBHOWlIZWZu?=
 =?utf-8?B?SUptTkRGeHFmY1owY3EyY3pEWEpsblk5TXhSTlZnMjhKOFdwOHZQTDBmaTR6?=
 =?utf-8?B?MFpsaWcvZ2ZVMUpKa2FUK0JjdlR5NzZSWmJmUEZYb1FORHk4ZHMwWWNpRXIv?=
 =?utf-8?B?SkJXNE8zMTNkcERFbkNDeDM4N0JaSWJCWk85SUxvNThiVGhIbVE5WHZHdXZN?=
 =?utf-8?B?U243UXBJT0k4dDhwSDFSL0JnK3puSW83K3VadlpKL1ptTEpMWVlFSGluS29G?=
 =?utf-8?B?dEE3YzJMV3ZXWXVxWnJyUGFSbXNvMXlGd2YrZGNYbnM5Vm9keVQ2cUNTVjJH?=
 =?utf-8?B?aXZLd05LemVhQkdPNmpiMmhSc2xpc3lqSmk1cjNBSFQwbTlDUjBPRG9qa3RW?=
 =?utf-8?B?dXNnazd0TEFsZ2xIdEJtUkI5NWNHNWZPWnMyK1VoL2hxbE5vYkNSbEh0NVBF?=
 =?utf-8?B?OTFKeDJFM2ZrVGtvc01kN3RhWWpGS0hDTXlwQ2g3RUovS0ZzRFB1ZmlibTly?=
 =?utf-8?B?WFhXemhIa3FTaHlnYlc1UFdSeXp4RVN1WVU2TWRENHhGekttMjVQUStzWUxC?=
 =?utf-8?B?L1doUGc1R0oyK25uQnFCWUJteDFXMHB5QTUxVXM5bytYbG9HY09td2VBVTZJ?=
 =?utf-8?B?VWh0OHRPVlllazRjSGJET0ZlRHF0VXA2RnlhcGFONWNWRmtGY2loT1JjZ29X?=
 =?utf-8?B?Z2RETFU3Mi9LcFJNTjR1UEVBMTYveS8wRzNjYjZhSW9xYWtZK04zd1FCVGpn?=
 =?utf-8?B?ZEI3OEdaZmpBaVpFcm1aeWExTWhCVmpjRHltMS9PS3ZtYlZrQTZlV3RBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzRvSnIyRFlwWnBvL25PM25UZXR6L0p2NmJqK284dDVEY1JqZ3BHczNpaGpj?=
 =?utf-8?B?YUcyTVhKanJCRFlYOXJGR2c2cG5kNkdEdWdMYjRuNS9RYzN3SVRENVlXdlM3?=
 =?utf-8?B?S1V5ZWNnY0NnQzdwN0QvNlhMQXBxMzlWYUVjUFlTcW9XSzNRSXNqSXFKK2lL?=
 =?utf-8?B?cndkUVI5R3crZzEwa3lSTXZaY3kra2VBaFJrUWVReHUrR1VQNmFLSG1oc0ZZ?=
 =?utf-8?B?VVM1YS9BbkVZa1VUaFRHYUVnc3F3RmduMUx3M2swdmgrSjZPNDdraUQ4ZTJJ?=
 =?utf-8?B?Z0JsNGxJaEpKQ1RHdmJ3a1RuWkU0Zld2N2ZxR3crS2Z2Y0x6YmNtME9PWVJ4?=
 =?utf-8?B?SVNITTFLZFhvbUMwdHlwSS9ZeGVFYitVYVJ4eTZkNjcxMUVreTZTU3VzbXho?=
 =?utf-8?B?dXRqTXZCaW1ZMWhMRHlSbytkQThGVmZlRk12WXUycE43VEFrK1N5RlM3YVhW?=
 =?utf-8?B?R2VTQmwzUnE2Rmttb0YzY1ZDMkNTRlNObXJJTmhwenZiczV5WmRQajd0UThP?=
 =?utf-8?B?VDM0SFRjakJmeS9GUnc0WjcvT3Z4dlZwNGkrQWRUVjZCUWhrK3o2RGlkVEwz?=
 =?utf-8?B?OEcxZFlEZGpPZHVjZVNOeGhsL0dhbWlBL3Q4UEtVM2V2ZTdrdDdqMHVnZjd6?=
 =?utf-8?B?S2lkV0xwbk9ab3RlcXhZOUNsOHNRNHk4aStodjZZeVRZWUFaR055bERZb3pL?=
 =?utf-8?B?THVRNmdwVlA0dW9kR2Y3WHZHNVprSzJFRUsvSHBOVnZ5UURWdDQzL3RTR3hq?=
 =?utf-8?B?Ulc2aGhuYmlzOFZMZlpyeXpYK3BjL3Q5YjBrTVd1aTNrTkcvRlpQTDFnWnJD?=
 =?utf-8?B?YVhMcnhyN1hFZUQwc3FkQkVGY3doNjQ4ZDV5bWFibmhZTVFmWWd4RlF5cG5U?=
 =?utf-8?B?SUJXUGVwVFQySlhRSnJQUzZ0SlA5c3BIYi9XWC9JT0RqY3orczVtVjVpWU81?=
 =?utf-8?B?S2YvZVkvVGFhbmhnZUVnYVRmVUVJZGRHQ3BKYXMyMGo3VXVPb1QzV3YyZnR6?=
 =?utf-8?B?RHF2OTRUMEwxaDEwdWZPWk44MHVSUEpYR0UyaU42YUVrQTJ4ZnF3dUZTY05F?=
 =?utf-8?B?angyRU1zS09EdmtUZ1N4dVRmcVd5RG5YQmRzSnkzbWFzMkNHTGQwVkZCdmJi?=
 =?utf-8?B?WVRzNmYrTDJMNXdwRm8xd3ZSWk9yWXNNWlE1K0NLbnZKQmFwNW5ORTQ3RjdG?=
 =?utf-8?B?SXJTSFlWQ2duaUhsMXM1cXh3dHF3VStTY3lnM3IxQUM4bkkyVFZiYWRySU9M?=
 =?utf-8?B?a0hlWDhYM3lQSDYyUkVlNE1sNzdYRElxODBaelNzalBpTEc0M3I1NEcyOFFC?=
 =?utf-8?B?RkJWWnFveWM3dlhoT1M0SlJueGRQWFE5bTk1OGlwdlQ1ZW40ZS9UUEpZaUxS?=
 =?utf-8?B?SnJWOU1BZVpyUXJEQmg3dG16Mm90allLWTZESFl3QjNmTHYrYSs1cm5iUUJI?=
 =?utf-8?B?THByQitJN0RyNzVjWE9lUzhtOVlka2llUnhxYlpLanh0ZFYyRzBZOGgySDZE?=
 =?utf-8?B?dWlGUExUUVpLbEFET3gvKzAzSUFuWEFHVlEzN29SdXVZVXZQVlU5LzBhQ1A5?=
 =?utf-8?B?cUtJaTJmWXVGTm1LbTBHOFJEREJDU1hLakV6ejJjdnhFM1h1bVUwVk5Uc0w3?=
 =?utf-8?B?MXdWTU80aGhRdnBUN1p2dEJONVZ1YnNkT0dBVFZWcGlRVDExNGtrRXV1Z0hn?=
 =?utf-8?B?QzlRZDgrQlJQYlNoWi9VU2hYeVM4emN2Mm5NV2gzRG00V0FiOC9TZFlGQVBM?=
 =?utf-8?B?Mmxic3JwWHhlLy9MWDZSSUYzUHUxaVpKTk55Vm1ac2pUaFVSYjNZU2xuMVEx?=
 =?utf-8?B?REVOOXh1alN4OG1HOFRRT0tyTXRKUkR2RXZRdHhCNGdjZ2h0NThFbU9EU0hQ?=
 =?utf-8?B?OVJ0RDZIVkNrTnB6NnJQK3ZoUEZPZ2hxMkRyS1ZzZlNqc3JrbTRTUzBDWlhB?=
 =?utf-8?B?Tk9UOTlLRzZEUWhzM3g0STFTQ2htaVZROEZ3L3BxSlJnb2t0SFFUQkVKa3BM?=
 =?utf-8?B?TFpreE1QUCtNaVNmZTRNYkdMMHRncmZqNjU4ZmZVQ1dRRlZ0di91K3FmNCt4?=
 =?utf-8?B?K0xnV0pqZWh4cUIxMnBteFNVeVQ4bk5hWjU4bkFLS05HaFhnU1BjMVpUS2wy?=
 =?utf-8?Q?VqPNug68zw3Hg5ilDNpfJrIB6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3f9f60-040f-4811-9d5b-08dcdc0e250f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 20:27:29.0477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llb+h4XwbosX2XWXoOn76L71LydsFeappYL/kbnm0Zt+zjiJgyWbMYru9vN4Rvnc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630



On 9/23/24 7:07 AM, Alejandro Lucero Palau wrote:
> 

...

>> +/**
>> + * pcie_enable_tph - Enable TPH support for device using a specific ST mode
>> + * @pdev: PCI device
>> + * @mode: ST mode to enable. Current supported modes include:
>> + *
>> + *   - PCI_TPH_ST_NS_MODE: NO ST Mode
>> + *   - PCI_TPH_ST_IV_MODE: Interrupt Vector Mode
>> + *   - PCI_TPH_ST_DS_MODE: Device Specific Mode
>> + *
>> + * Checks whether the mode is actually supported by the device before enabling
>> + * and returns an error if not. Additionally determines what types of requests,
>> + * TPH or extended TPH, can be issued by the device based on its TPH requester
>> + * capability and the Root Port's completer capability.
>> + *
>> + * Return: 0 on success, otherwise negative value (-errno)
>> + */
>> +int pcie_enable_tph(struct pci_dev *pdev, int mode)
>> +{
>> +	u32 reg;
>> +	u8 dev_modes;
>> +	u8 rp_req_type;
>> +
>> +	/* Honor "notph" kernel parameter */
>> +	if (pci_tph_disabled)
>> +		return -EINVAL;
>> +
>> +	if (!pdev->tph_cap)
>> +		return -EINVAL;
>> +
>> +	if (pdev->tph_enabled)
>> +		return -EBUSY;
>> +
>> +	/* Sanitize and check ST mode comptability */
>> +	mode &= PCI_TPH_CTRL_MODE_SEL_MASK;
>> +	dev_modes = get_st_modes(pdev);
>> +	if (!((1 << mode) & dev_modes))
> 
> 
> This is wrong. The mode definition is about the bit on and not about bit
> position. You got this right in v4 ...

This code is correct. In V5, I changed the "mode" parameter to the 
following values, as defined in TPH Ctrl register. These values are 
defined as bit positions:

PCI_TPH_ST_NS_MODE: NO ST Mode
PCI_TPH_ST_IV_MODE: Interrupt Vector Mode
PCI_TPH_ST_DS_MODE: Device Specific Mode

In V4, "mode" is defined as masks of TPH Cap register. I felt that V5 
looks more straightforward:

V4: pcie_enable_tph(dev, PCI_TPH_CAP_ST_IV)
vs.
V5: pcie_enable_tph(dev, PCI_TPH_ST_IV_MODE)

> 
> 
>> +		return -EINVAL;


