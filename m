Return-Path: <linux-pci+bounces-12761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C83596C22C
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 17:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BBC287B01
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 15:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8131DEFD8;
	Wed,  4 Sep 2024 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C9f3uBCl"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595881DEFC1;
	Wed,  4 Sep 2024 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463473; cv=fail; b=tTQmKpczva9X75NYlZcaoTHcObRicf9pIINi+PiUfYoIo8cHiDSnl4QM3gbn+XcceqzTqvjtYmbWEhERmCc1WanDc2D+FohxT3v7NXH88VIBQ4iwsYN8YqQo4P6Ub5igHFIv+eAAJZi7qV5gjCNbbY1sd6jQl0LWUIOCxExmxOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463473; c=relaxed/simple;
	bh=2adOlB9rrsV5qdXLkzkmGsI0liCimYeEZI87c+9mspM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IjqMcyIidS5ZWIzzAzXgr4POP+c8jh64HD1ijwpo236gVbpjOeq7bM+YZ4BEz7HaCzx9QD9D5rBQy00/VXfY9c/1TsrZWsvyRNHAVf6JJI8Vrdi28XHrpaOW3lUEe1zfo7NwF11ezqL9llxPEtNrdFKxo87Ej9ux+ld8UcmeRcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C9f3uBCl; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWQuDVdUHIioXg2iYE6XU25veqKc39cnvLnYNpkshU9nA4yPhnUEN4gPsmBA/vN8eZKYLfMkqYxwJGs3O0vBIsSAtkSKMqDwHhdKrQqa490c3qmPkTky5AH4r9U4Tb/wXn8XVOuYNZkZp0D2ZtgMfRwQ5NW07l13ZacDbFVrpUl1MGanEvATAuRDZgwTB2iWK8CWNFWqfElSN3rNTmtbTJVvCS4vIhoAbUMV4PK+2oc80TuIUAYgAA/BJocGMGUxzYARGh3vLHxrcHhIrqz1LZ6DGIQeXzRDBMzrNtV2v+GgRz+ocFA/6vrihafJXzgG67l/LXEC/AcYkYdp28QQ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMj2cKISqyYalHoh4x76bJMvkqm0S5WLVa8YhZPZFw4=;
 b=Ta4f0gA37eRIakgAc6ivH4QTZFNkVwIrmN558D/Xp2YskPCLfev9QAi15xgaKJNRsm648pDZr4CjeBNxNNMn0kbkXzrXSYzuNPXoPoYAP8jsdL5CihFaNS+f2M5Nbx3C7Ety5ygDRYE5l+kMMjZlK2A7ZAeMgqwZG7pqKn/vy2Hv8WdhtVOnB/k+5OnnTXz4lDm+GN5G5sBpJI4ZvJoOX4zVZd/zYR+iAARC+Vx7p1F2OJrXYw+mWlQTammDsCRleIKtlq9eldjJIrBbhhr1xCK//cLjjW6+uILxxxXGsAH8ZQniQB8ISfrZ90oZz6mETZBZfxxWmDa9/UMSbBrpKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMj2cKISqyYalHoh4x76bJMvkqm0S5WLVa8YhZPZFw4=;
 b=C9f3uBClYIc5YFn4dovlFMAoTY+o0bncZY96x6Wlol1poX7EzwSOGlMqgQFt+65UfOR0ROtcNWaSasvtSnDOLM52MNiy+y1xLeitBPtV6LbfXDd0n8gwJk6rG0Sg26BVwqw1MQ6sL1HeHExJsTOqQdYWFqYh3zgLOimGUMuSszM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 15:24:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 15:24:28 +0000
Message-ID: <2bf715fb-509b-4b00-a28d-1cc83c0bb588@amd.com>
Date: Wed, 4 Sep 2024 10:24:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in
 pci_dev_wait()
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Gary Li <Gary.Li@amd.com>,
 Mario Limonciello <superm1@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 Daniel Drake <drake@endlessos.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240903182509.GA260253@bhelgaas>
 <525214d1-793e-412c-b3b2-b7e20645b9cf@amd.com>
 <20240904120545.GF1532424@black.fi.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240904120545.GF1532424@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0188.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV8PR12MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e50e00-2bf4-47b6-aed6-08dcccf5aaa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QktMR0g2TDlHM0xyU2dLaml5SDBUcEVmcmJmcjF1cTZyNDM5cERDMUlvWnhI?=
 =?utf-8?B?djVHQzN6YXpCaXBwZDBrVHYzT1Z4YlRKclBoL0lmbEdRa1pFTTA1L0tZV0xB?=
 =?utf-8?B?aUhBbjU0eGkwby81OWRuWXR2eUIzYlRWcmV3d0xIRWJpZUNraUFLc2k1Wi82?=
 =?utf-8?B?WVdpYkFIVW93UEhyaDlBbVV5UkdLZnZMNzJYTitRZTM3d3RYSk5OVElYS0ht?=
 =?utf-8?B?WHpaS1loeHlpekdxMmtLNVhhVjRxSVpIaTJhTUJUelFybDJMWVBNOWh2REMz?=
 =?utf-8?B?NUtwV1hkbXM2c3pSNTJ5YWZJcktHaVdoNDJjS3BZOThWY3Ntd0luanEycHZN?=
 =?utf-8?B?NFNwOTVXeVYzcjlOTm1lK3VnS3dsTkh3ZndsajN0YXdwWENpdUNPQXJtNjZo?=
 =?utf-8?B?cjFPenhxekdjcmc0VlAyVldJZ0hza3o0L2V2WUxBMFhnQmtBa3l3RXNqNHYx?=
 =?utf-8?B?QktuaENoVmZEZW9QQUcxamYxSTRIQWVxMVp4UllwYWR4T2tMOWRUZTAwZXIr?=
 =?utf-8?B?aGJXZmRNSmJqR2VyMXU3cEQzSTEzVERNaDNTTHdZbDYxV0ZVUXFYT1BkSE1Y?=
 =?utf-8?B?UzVlejB0MnVFVG5BYkVFMW4zUGVteXBpRDVRWjFiOU1ySStlcXJSRUtMVmFz?=
 =?utf-8?B?azRVZ05ZS2Z4UEozcFlRSXZpTXdDOGJVbFZDMzZaUEtNQ1BGMysvbUhSY00r?=
 =?utf-8?B?UUwzU01JczlRMUhaYXlnc0JpS3V2Z21RUVEwd20zbnNvaU50TjNvU2QrNEs5?=
 =?utf-8?B?dFVsNzVmYkhSMDdLZUx0Yytmc2V0NU43anpPNEpuT2RvQzVrNlROUm5yTDBw?=
 =?utf-8?B?eUd1c2kzWGUzN0E4ejJyYlBWSVJvQkxLU01ZU1U3MkQyQzJjQzZ1dGRQZkp2?=
 =?utf-8?B?T1ZMV3ZleklUNGJDRnoydVNLOHVWcjg5OTRsWFFrT0h2ekxUeDllL0daelBn?=
 =?utf-8?B?a01Zem9qeGwvVkp2SXZQdEEwRzFUa25kV2lIcWlNSUNrQi9WVkNIdWNXRnBl?=
 =?utf-8?B?MEluWklkUjBWMzZULy9MSVF1VGh3Y3M0RGFoQll0VHB4WEFNckNWelM0aXRV?=
 =?utf-8?B?RnpSODlkeG16MXM0ZUh6c3gwUWpBczduMG92ZEJDUTdsanpWam84ZGwvWGZa?=
 =?utf-8?B?ZFQwOXhVWklOV2FzVENHK0xGRmNCSTUxUXFOa0V0Z0lqTDVWNHh1ZXNPb3pv?=
 =?utf-8?B?WEZyLzlTaFQyRnVIRWxTclQxbzUyalEvWUpOZkdlSW1MbDR3SHl1c3dMcUp6?=
 =?utf-8?B?eGx4aE5VUTc2Qm5WZTA3UkZiZFU4N0VNcHB0M2Z6ckQzaEdzcWlFZDNFeTRK?=
 =?utf-8?B?RUZJcFdjK2c3U3krKy9tUkMyV3R6b2hkNTg5cFB2MzdhMjVBYXh5NDBjTkpM?=
 =?utf-8?B?NFIvdGJuS1JkTXBNbTJ0eXE2U3BuTFFUWkdMS3M4R0xRemF4L1FHSnhndTYy?=
 =?utf-8?B?TjJjRzdoSkppcm1CZ2plZDN2cDFXSnN0TndYWVpiOFV1WWJGcU9QOWQ3V0VD?=
 =?utf-8?B?SXNaS2lHVXdPVzdzVWk3eUNyTmhuL3I0SnFucUROeEZsOXR0SEVEb3RNeEE1?=
 =?utf-8?B?RkFXM1drWkM3cFp6RENpZHV4V3E2Vjk5MU8xTjdRYnFYZXRDQzVKOHB4VkpO?=
 =?utf-8?B?UnFWMGF6KzBNS2V2NUxVVHdKbHMvb1BxWklxSjdsdER6Z3d6YmhrcFdmWGRQ?=
 =?utf-8?B?alFycjJXcTZDd1MrWW1CRXQvM3ZwUCttbVlkVmw2YlY3OGtGR1NGRkR5b0gy?=
 =?utf-8?B?QWJtaFNoaHlPcVNqWXN6bG9vUmEzbmNmbHJyNS9UeFFRWFZRY0VjMzFVbms4?=
 =?utf-8?B?eXpsUjFUQ3AzWGZTK3BtQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3A0Q1loT3BmVDhmVW1PSzV6Rkhlem1JVXUyUFlYMWhIaml3V2h2VXUrZnBQ?=
 =?utf-8?B?d0FPVm5uUmRpbDJLSHFsK1htYzNjV1c4UXpDR3Y0QW4yNkNwMDkxbDJSOXQ2?=
 =?utf-8?B?MUg1VjRkNytvWGJWamcvZmdwVHpQTmxIVXJNaWhHcXNINHdOS1B4YWpiUzZS?=
 =?utf-8?B?eWJvWW5TWEhhL1B5WTVvYzIzSjBFSDZaanNiVTc0Q3lkUVhIOHljQnMxbmNz?=
 =?utf-8?B?SGxJREU3Z0ZrN280UmkrZkhmMDZRajZhT280ZnYxSHpFLzJGbEtBMXcrVGFr?=
 =?utf-8?B?bG15MjRWbUVEaGErMnE5Mys4TXVuSGg2YzNQVW1FK2FhOXlBMUQ4NC9OU09o?=
 =?utf-8?B?K21KUUNmMmJvQmJDZExvQk4wL2c0ekVDcjIwZHZMUlpsZ2xyZjlvNVpjZWZq?=
 =?utf-8?B?cEs1ZXVGSjY2WDZvZHVLMGptQlB5OW5qb3ZoeGcwKzJsUlNnZEJ3eUVMVnF0?=
 =?utf-8?B?STlOVWZZL0xtQ2FJUjNwWmh4K1NVQmRkVFVRSXR6ekU1WE1uYk5lVVZNVzVV?=
 =?utf-8?B?TTZRbnVaT2FjaS8ydGZIdGZ2TVBkQmtXTENlT2F2QTRQN2orSnZhY0NUbUlZ?=
 =?utf-8?B?ZEFjcExLdU5lekZ6REF2OGUxSlJFUHZaaW05b1F0aTNIbFFaR2xLaGdoaWVw?=
 =?utf-8?B?b1hQSThROC9oWEFnby9zQjBYd25Xa1Z5UFd4bmFpTHhHdG1NMWNDZ3dEN2Q0?=
 =?utf-8?B?QnNyZjVicXVpRmxOUmdEcmZsSnZiWFIwSmpkV1BFZkNWQUgwcUpIZllaS2tJ?=
 =?utf-8?B?UEFtK3FLS29kSElTazg1bmNBaTUySjVSWnhtTFlFOFdLSDluY3pPRkM5QVhF?=
 =?utf-8?B?Q1lCUEFlODEwaFRITkgzYWhiOWI2MGt4Sk5Fd1VteHE4OXBRWFgxZFF1TXBp?=
 =?utf-8?B?ZCthdHBlVVBQT1EyU1lPVjc1TVVxQi9FRDVqZ2F0akJ0dURBV1ZwRERlWnlH?=
 =?utf-8?B?dlE1UlEzK1ppeGZFR3dESzQzWWprVUtIVkNtazBPNGZ3RkVFamFSbGdlMGJr?=
 =?utf-8?B?MlYrZWloa1h2VllIeEE3Tm54UEV2RmJ2K2JWckwzTklOcHI3VTVOQ1d2MlQz?=
 =?utf-8?B?UnZvbEdPUnk4VENLZEY5RFJMVlhHNisvcU9vL1Qxa1BzRUd6YStjZnhkZG9O?=
 =?utf-8?B?VVVxSUxXSkR1dHhqQXdZMG1CR0lJY3YrWUYrR3BjNGNYUjFtajNZMWtiTHM1?=
 =?utf-8?B?bmhFcWJOVXdRbmFpR3dxUmJSWHFHY2FzNFl4L0hpTk9QbHZtU2hpY0ROcEd3?=
 =?utf-8?B?SjhxNEVxYWNLK1ZicWRDaS9VQnRaU2JGTlorWEp0d0FNY3NVNStOV3BFamhh?=
 =?utf-8?B?TGRWaTVMWEN3NTI1TDlzR2JBL2c4ZjI3YmsxK0U3MUY5b1FJV254WU0yN2xp?=
 =?utf-8?B?dkx5Wi9rUk9BcTlqa0tTT2xYNWVGbHFNbFhNUElvSHZaWURMQk5NeGs1RDEy?=
 =?utf-8?B?Y3FqR1hPQVNxcFZMR3VYYmV2ODJrRWEydUVsVlZHSkxLQUh1ZU95RG12OEc0?=
 =?utf-8?B?clQ1NURlK21FcFQvZmNCcFBOOEtTOW1ZejJCTi9UZGhkQVdQOFJnVHFtMW9G?=
 =?utf-8?B?UjhvT3QwSTdjRkU5Z3RrTVBSc1BKWFM2NHlod1FDVUVnOGhjMzAvVllqakJP?=
 =?utf-8?B?c0ljNE9aVTBGR1d4Vk1nZlNOMjVTV1dRNEh3VHlNU2hnWllEYmhCSGE4V3My?=
 =?utf-8?B?UlB6aGNCQk1odml2TUZ5NEVuMG1LaGRUNGRnYktKZ2pIbU5EL253dTVTK0Ur?=
 =?utf-8?B?ZUoxZzhhai9wNkFxd0RhaEJ3WWloSVdaTUdRUE5SVGtKS0ptMlRvdld3MDls?=
 =?utf-8?B?MlB1WVB1S05tL1BJd3VaSFNxTDVFbHI3ZmRuamxUWGxwM2Rpc0tEWi8yYm9k?=
 =?utf-8?B?dllFaSs0S2dKUVltOUV6TjQxU2pabWlFODlWeE1kclJiNXo0Nkh0SnlPUTJ4?=
 =?utf-8?B?N2dEUTRKU1RQSFJrQW9OblVNRWEzZXFCWlNMZElGUzhQNE93V3huVkxjeUND?=
 =?utf-8?B?azVpcEVIYjh5T1MzWTlNc1Y5ekJ6TjdyNHZtdlFDQW1PMVFYU2NTV2xidzB2?=
 =?utf-8?B?amM5OWxQbHpJcXIvWWpIaHEvUHVkYldBL3ZSOHU1cHBKVk4xbnc5b0Y0TGRs?=
 =?utf-8?Q?PvyYdibSeEF6sfetH4hmAX0fr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e50e00-2bf4-47b6-aed6-08dcccf5aaa5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:24:28.3648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+YiY+rpLzrzyh08F9Jb/quaD4nxrG3wpSy6LepYG1ZW2uq4yeXu28imxi6/GywisNYVcuxANJS8NrNbA43cyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9207

On 9/4/2024 07:05, Mika Westerberg wrote:
> Hi,
> 
> On Tue, Sep 03, 2024 at 01:32:30PM -0500, Mario Limonciello wrote:
>> On 9/3/2024 13:25, Bjorn Helgaas wrote:
>>> On Tue, Sep 03, 2024 at 12:31:00PM -0500, Mario Limonciello wrote:
>>>> On 9/3/2024 12:11, Bjorn Helgaas wrote:
>>>> ...
>>>
>>>>>      8) The USB4 stack sees the device and assumes it is in D0, but it
>>>>>      seems to still be in D3cold.  What is this based on?  Is there a
>>>>>      config read that returns ~0 data when it shouldn't?
>>>>
>>>> Yes there is.  From earlier in the thread I have a [log] I shared.
>>>>
>>>> The message emitted is from ring_interrupt_active():
>>>>
>>>> "thunderbolt 0000:e5:00.5: interrupt for TX ring 0 is already enabled"
>>>
>>> Right, that's in the cover letter, but I can't tell from this what the
>>> ioread32(ring->nhi->iobase + reg) returned.  It looks like this is an
>>> MMIO read of BAR 0, not a config read.
>>>
>>
>> Yeah.  I suppose another way to approach this problem is to make something
>> else in the call chain poll PCI_PM_CTRL.
>>
>> Polling at the start of nhi_runtime_resume() should also work.  For the
>> "normal" scenario it would just be a single read to PCI_PM_CTRL.
>>
>> Mika, thoughts?

We did this experiment to throw code to poll PCI_PM_CTRL at the start of 
nhi_runtime_resume() but this also fails.  From that I would hypothesize 
the device transitioned to D0uninitialized sometime in the middle of 
pci_pm_runtime_resume() before the call to pm->runtime_resume(dev);

> 
> I'm starting to wonder if we are looking at the correct place ;-) This
> reminds me that our PCIe SV people recently reported a couple of Linux
> related issues which they recommended to fix, and these are on my list
> but I'll share them because maybe they are related?

Thanks for sharing those.  We had a try with them but sorry to say no 
improvements to the issue at hand.

> 
> First problem, and actually a PCI spec violation, is that Linux does not
> clear Bus Master, MMIO and IO space enables when it programs the device
> to D3 on runtime suspend path. It does so on system sleep path though.
> Something like below (untested) should do that:
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f412ef73a6e4..79a566376301 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1332,6 +1332,7 @@ static int pci_pm_runtime_suspend(struct device *dev)
>   
>   	if (!pci_dev->state_saved) {
>   		pci_save_state(pci_dev);
> +		pci_pm_default_suspend(pci_dev);
>   		pci_finish_runtime_suspend(pci_dev);
>   	}
>   
> 
> The second thing is that Thunderbolt driver, for historical reasons,
> leaves the MSI enabled when entering D3. This too might be related. I
> think we can unconditionally disable it so below hack should do that
> (untested as well). I wonder if you could try if any of these or both
> can help here? Both of these issues can result unwanted events during D3
> entry as far as I understand.
> 
> diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
> index dc1f456736dc..73b815fbbceb 100644
> --- a/drivers/thunderbolt/ctl.c
> +++ b/drivers/thunderbolt/ctl.c
> @@ -659,12 +659,11 @@ struct tb_ctl *tb_ctl_alloc(struct tb_nhi *nhi, int index, int timeout_msec,
>   	if (!ctl->frame_pool)
>   		goto err;
>   
> -	ctl->tx = tb_ring_alloc_tx(nhi, 0, 10, RING_FLAG_NO_SUSPEND);
> +	ctl->tx = tb_ring_alloc_tx(nhi, 0, 10, 0);
>   	if (!ctl->tx)
>   		goto err;
>   
> -	ctl->rx = tb_ring_alloc_rx(nhi, 0, 10, RING_FLAG_NO_SUSPEND, 0, 0xffff,
> -				   0xffff, NULL, NULL);
> +	ctl->rx = tb_ring_alloc_rx(nhi, 0, 10, 0, 0, 0xffff, 0xffff, NULL, NULL);
>   	if (!ctl->rx)
>   		goto err;
>   


