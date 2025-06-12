Return-Path: <linux-pci+bounces-29553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1937AAD73F7
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 16:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911E3188A8DE
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 14:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FD22288C6;
	Thu, 12 Jun 2025 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EgdmlUd5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE32246327;
	Thu, 12 Jun 2025 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738567; cv=fail; b=Vm+4ZdKckOgwX3L8nMtiZpgFhjSKaU6tp9AYezdhDOD/CyDjaW6eCG6KtS4pJj+emwYPfYinQCV1Uorrn5SyilGD6RKOgm3e14XDLVN3+HSTeD3+hZF3cgLrmoExnpYhsxb3UVJ82cMDp6fdAiHbZfK3ilT0MllTlY7EXMxheTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738567; c=relaxed/simple;
	bh=up6oFsGAZ4dfCf5KHK8s3VUyGWPP2hlDWdILYJdLgfE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b2toCk65Th09MO6u9H56kkHSEBOTFq5vZQkHMMbzWO7tyOyNjE5xXQSQNqcclwFEsd2mtKvFzHcXGycVFxg8FWhXwe29VBw9cAV9+Dm1TOD/JcCrkwbmc5psrvUs8INQEDt54scE8j0eVCMhIiyFPXWI8Yo8QWgex38fiKKYy3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EgdmlUd5; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suG+uILsU5Dj2jMXbxC3197lzBH2cecsXjbFruANvsF1P7jiDqtgiVWGDQ6X5SC8ukppM+zw7Ho9K5h+eOztqE+N9cwgq2zIFGeKH6kGDvuZH6Lkioh/v/s5z27e6NrrJTfc/TqGxX+qJi9mUKZb5pzLWE52dLbcLGVdHhka3pqQTT5vgcrHj+O66t8nRWLTNrHqji1UrtU0DGWyhQ4E6wl6Y1t2Hzlp3P1XOU/WZaQuky/Ldqsr6zh6Cs3p7ARLkodYYde556BcmDHHEfpG7S18uXv3ynihcDVmqn0Ntx+HIzKcVez1V4MMHGfJij7PtzXrAPTlnv/xhMy6yY2uvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkA7WinusA2dBCUP9EIuKmCzzzKQos7UeM0Ct7flSEg=;
 b=OzWG6xzBzi8+K7olJo9OZhpm8jSeeCMpYip+jm66/V15UWP0ZdYy0hMVfyWdpOKkJOj6N5pv2sBDDJ3fWCCAUDzGiGoYNZyMY1CwGOLmz4MeZgsC/cgaRurqLcAR36+xF9LUIxF+/SR5Ve8GGRLzOiX5QahfrVgllHgWfwWZps9iwM5TDG0qn6q6aiiEcelTHgasY7NwH/WBddcG5xQkdWrd5DnP1pNuZRE7Zw5Klt64cE9OwNcdgovLo1FgwVm8C6Tk4/CjwqZ6Rd9RhIII72rQt6pLKPuE16OeqrXuiLd2QGg48G00eE1DecDGmWyOY2w6FNcvcqV6ZR+dBl793g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkA7WinusA2dBCUP9EIuKmCzzzKQos7UeM0Ct7flSEg=;
 b=EgdmlUd5fZlsBZ9mfH2ddP4zSKNYxyUhsiT6OZ4tRL4Bj1c7W2bVlfIHJ/0tWlTpktZ4NzCqVvQiWKGvwmKTwOpRPWz1J6juZxrvYjDKaul2qP48aR6sDQkOwd+9TErNZ3GXIgPlAUqDGzt755FcgqBz518/Eq/3dFmYrOEuWIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS4PR12MB9820.namprd12.prod.outlook.com (2603:10b6:8:2a7::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.19; Thu, 12 Jun 2025 14:29:23 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 14:29:23 +0000
Message-ID: <110a5a5c-6842-4d1d-ae7e-22ffd0111641@amd.com>
Date: Thu, 12 Jun 2025 09:29:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/16] CXL/AER: Introduce kfifo for forwarding CXL
 errors
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: PradeepVineshReddy.Kodamati@amd.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 bp@alien8.de, ming.li@zohomail.com, shiju.jose@huawei.com,
 dan.carpenter@linaro.org, Smita.KoralahalliChannabasappa@amd.com,
 kobayashi.da-06@fujitsu.com, rrichter@amd.com, peterz@infradead.org,
 fabio.m.de.francesco@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 yazen.ghannam@amd.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-4-terry.bowman@amd.com>
 <20250612120436.00005af5@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250612120436.00005af5@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::6) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS4PR12MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: c0466853-95d8-4036-c6d5-08dda9bd868c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1FzYnR6aDZWRGJ0YmR0eWI3aVc2K2NxTm4xS0p1Rnc3dXF0Qlp0OS9ndysw?=
 =?utf-8?B?RzNYcTR3czhPUFhxQkF2ZGZEdTdkWHQ3WXhNRVA1VGFvS3Roa3Y5NlN6U1RW?=
 =?utf-8?B?TFhJRHRKa3d0bHJ2VmUyUUxjdDY2cEdtVTBNQkwrZ2xQUkFzOWRKdmdCTnly?=
 =?utf-8?B?WllvMUxiS21USDh4R1BqV2J2bTVnY0JYWmRnYWE4QnBkNWhhQzZKeWk5cDdL?=
 =?utf-8?B?eHp6UUlCUDlEUUx4UG8xOHJiSFd0T0RSTFN2TWt0S3B5VEhXK0FzN0NvektP?=
 =?utf-8?B?clBtdVZZN2swcWlSOW5ETmdodXFrcVIyN0JuTXhPOWU1SjA1SlRIVDBpaG1z?=
 =?utf-8?B?M1pUR1NtQmNIRy9Ud21WTjNhTWtHT1RXNjhHbzFsNklVV2RJbGdFNkpzZ052?=
 =?utf-8?B?L0p0TXVsTjRLVi8yNjNhZFp4ZUk2UTlzT2lxVmVMT21JNTJ6M2h0bzNmSnhv?=
 =?utf-8?B?K2RPMTNVYUhFOWNlVkVnN2QxbFhNNU1nL3h5VzB0OGRBemsxZUJoajNWaHQr?=
 =?utf-8?B?VW03VU1KdG5kcEVXNE9FUUd0Tlh0RzJRbGxWNkdkcHgvYUtuN21CTWt0RHdz?=
 =?utf-8?B?aWpsbnNIRGJqQVoyTnpUczdRUExsZnJGaWZUbTEzRENtUks4eTQwbEd6dTdq?=
 =?utf-8?B?a3E5MDdqOG9vNEk3SUhvNlYwdHBZbCtiL0hLajhocmhZc1BPV0RDVXkvQ3cv?=
 =?utf-8?B?ZEpwVDI3QTNiMnNMVHMrbGFXdGhaam83OFc4bUZKbEZRNkdjUVMzSVpCZ1RJ?=
 =?utf-8?B?MXZkVUFXaHdlSXRwUzd6RTFSWi9yNWg5YkIwbnB5emErQkxXZU9IN0hXZkha?=
 =?utf-8?B?WHNEQmNueUpTM0dkMlFaTnF0aGRvcmZVaE9ZeVBVMU9abEoyNWdlUmp1U0dk?=
 =?utf-8?B?Ryt4N3hMeStQOWdLZnhYUFdzRityZTgySDZwclhHbkF0eEJVRWFyRDlHb0lk?=
 =?utf-8?B?dkRVU0cvNlZ1TjI0OWFBVkJLYk1yeGxoczFWUmwwT0ZySndwQVNmelB1Wk00?=
 =?utf-8?B?enZ0QnlVWjNqRkJXWEhQbkVoQjJrbk9xZjZSbFczVmVvd3pXK01SMjhPbWQ0?=
 =?utf-8?B?NlpzckVsSEduaXFWSmxVOFVrb0N5Y3JjbUs0MXpMaml1Zmw2SnhtVDdqR3ly?=
 =?utf-8?B?WWpicnIvaHluUTJsdmxBUzRLaHRoSG9FMW1Ma2FnRWoxaXlWUUVCMDY0aEFo?=
 =?utf-8?B?OVNaeGwrMjZDbDVoc0xFK0MvWkR3N3M1TFpVYU5SRXhvVVN5S0R6U1RXK001?=
 =?utf-8?B?Um0ramFMcGZDWGl1eG1INWV6aFRUS1pVeTNLamgrd0pjejNxUjRDMFBVOWNo?=
 =?utf-8?B?OWhROTMxckVXYUVJZ01mTmhOUk1hRlRDZ0NoNlpjNHZJL0VXZjR3MGFYdlRE?=
 =?utf-8?B?bkQvdVJRNURkZGwxdDFlNUk5Wlo1VytRaDR6Z0xPSWtYZGRTbWhjZWw0czB5?=
 =?utf-8?B?Z0JuZWJiM1ZEQkJURzdkbk5QY1ZZaU8rRlZVaXdkaWdkL3ZjemVod3pNSmI3?=
 =?utf-8?B?cVQyQjV5N2lEcVBhdWIrU3dvR0dueE1WeTkyYUFGKzI1SWVBQVVkU3JXTlpU?=
 =?utf-8?B?RC9Ja2hHZFNTZ2lGUFdlYnZncmFERmhkdGlvUzF5QkNkcENjalNiUTcrRFla?=
 =?utf-8?B?UTVoTWRvcjhicGRIWk45RktnRU1STlVUMU1ZWCtRNjlQQ2hHZ0ovK3pMblZD?=
 =?utf-8?B?d1F6UEV5UWFlY3p1WjBDVCswaG1tVVlQeS9OdnJia3lrQmZ0T1lsTWFuTlNw?=
 =?utf-8?B?TGt3Y2Y5djNDQzlBWm1DazEvcVowdzMyL0ZsVnlLUjdCZklWZmpqYVFaeG5n?=
 =?utf-8?B?MENSQzEvdmJiRkpEczlvcGYvZytDSUVxUnFtWDBCRlBCcXR4cEd0cWtoMnc1?=
 =?utf-8?B?VXZLRFdYM1BySVdmZFVSd3d2WDAvQTc5S3djT1RlWFBsWDBtNG8zaWJwbjZ2?=
 =?utf-8?Q?CzglcMKQY/4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V082YmxYbXFudnlKLzhFTHZ4bCtZYSt1QWVmYU9kR1FUTURMUHFhV0hlNkNZ?=
 =?utf-8?B?VVVQMkFUZk9hTVhUZk0yYWdHWUFkU21wYWdSZThqMTNlckRUMUZFVHo5L0lq?=
 =?utf-8?B?ZEdmUk44VmlxMTR0WVAwNysvZFRITGEzaFRhSDVld1ZUMWJTQTRHWFlxUWpv?=
 =?utf-8?B?VTd2bXk1VVB5UTdESWVrUTdsc2YxOWVaVUpHVzlyOUtXUGF2ZGZhaCtsVE5G?=
 =?utf-8?B?YkVMd3NqWlViWWZRd2ZIRjFMR2h3VHhUWnFabk4wM1RGMnk0Zmo2VXhuN2c0?=
 =?utf-8?B?eWgyWTBMcElUK2NyenY5eUVyaFJsSmF6azFaQ0QyU2Qva3NiSGt0R0FacmZx?=
 =?utf-8?B?a3p4Z24xSGQwZXNabzViRXNNcTNyS1UwM0t4cHdjc2MrdUlybHFQbUhNMXFp?=
 =?utf-8?B?UDJKMEh6eUlZb0pDS2xJN0Z4R1dYa3BPcERjMFE0ekxWYWdEbDJiM2pNY3BC?=
 =?utf-8?B?eVpxUGc0TER0UlY4TXRkNHh3d3hya1Z0Wjgvdk1wbVlueXlUbDZHVEFJd2Jv?=
 =?utf-8?B?SFRxNXZmc1c3V2Npd2s4V2FadXpINkY3MlBKRmg1Y1dYU09yUWNlZzJVWFpQ?=
 =?utf-8?B?eHcxSXBQbUVHMFRySFlyWndWVHI4cVY2YUE1aXdlQ0o4RDQ0Zjh6STMrYjdn?=
 =?utf-8?B?bDlWZjd6Tk1vV3p3c0N1dCtKaUxhWEw4di9nSmRiUGtyV0NkS2lIdDJ5Ujls?=
 =?utf-8?B?bjZRSDJidnpESW5wNkMrWkxxRjBmUElsZFF0bzgwK2dXMldFeUNVdlZMMWI3?=
 =?utf-8?B?THdjQWFRdjdGUXdydEp1STc5b3crakwzN0RjQWdrYmc3SlBlT0s2dkVPT2w5?=
 =?utf-8?B?akZIV2ZwWEwwZEd3ZTFxa2tYQzNpaHZDa2xPNjRpNEtTMXUrVXRHWkhGN1p3?=
 =?utf-8?B?Q29GMXAwL1FOWjA5Ni9ZSWMrWGVjODRmR1BUbUpldU5NNXRFTFJqLzJFQkUr?=
 =?utf-8?B?Y00wbEtKTzQ4RDhEbml3Z0NwTEFyblQ4ZXdVNE5MdjdIeVB1M1N2WGJFNnJF?=
 =?utf-8?B?TkVqSGJVcUJsYyt5bWJWekk1UDJhZFYwRG5zbGtxYTdIVVdPcUsrQUpjUmt6?=
 =?utf-8?B?Q3czMUlMODdrZDdTeHVzUHltVE9ua1hCdjBMNXJ0SE5yYlU5SmdzWWlHd0NW?=
 =?utf-8?B?ZGgzODFoOEFaNmJVbVN6NHhtRm1TaWIzUHBxcXliaDZCeFF3bSszOHRzTXRM?=
 =?utf-8?B?K2RHODRETytvbTlvSmxHU25wbGphT2ZNZmtJTVBQQm5acFVuOVVSck9jV25W?=
 =?utf-8?B?MDdndFNnS0FQNmVuZTRyR3ZCNnQ1TFRIdk8rWnhvZmdvN1IyY2JkdU9tRTMz?=
 =?utf-8?B?RDV2OHFhRGpIVUM1VkR4d295T3ErdU1Ia2ptMS9SVUJPbHljSmZ3ekdETEdn?=
 =?utf-8?B?T3U2ekg2blhJejdDMUtwMFJTYy9LcStYOEtkdmYzOThzNEFtZEtZZ3Jkclpp?=
 =?utf-8?B?R1c1WiswOHpscnUyWVBPRGZZY2NCY1dnQStzaVg3alZlNEd0SmZWWHd3SjU0?=
 =?utf-8?B?YnlDZ2ZHOGNoeDRUZUZFYzNPbjN2b3ZuaXNwQ1MxZjdsNU5RdXJidFViTGNW?=
 =?utf-8?B?SGdxRDRBQWhUb2FaVjR4ZjcvM2gvd0hrYmV6YS9Gelh4d3djWHVZR1c3NGln?=
 =?utf-8?B?YWs2SFQyMFI4eFIzOUpKVUdoNm1oMGZmSlNnRnk2NmVtQStJM3hyNjlDUXhl?=
 =?utf-8?B?Y2U3eEJab3NlQzBUd245SDd2MGJkSWJQWFc3bjR1RmZnZmRSSk91b3Uya1ZQ?=
 =?utf-8?B?b2ZjZTNHcFBPczZGTExGem8yK2V5WXA3TGFNQVMwS3ZPSzVYeFRXM0Y5TU91?=
 =?utf-8?B?MFlKWEJVaCtkbG90bFQ0Q1ZvU0k1TmJQYVBMVUZSWUVDb1gyK0pRZ1Jnem1M?=
 =?utf-8?B?WlIvY3loQWlya1ZHbXZ5Qm16MjJ1SnA4K2FCNFNLTkZPTFlrYkdYOTlxdVVu?=
 =?utf-8?B?NlVVZnVIZTVPUzJTNG5COU9ZVVU2N2wxVTRKOTV5UWxIZDYvbHlVQTIrVC9W?=
 =?utf-8?B?cjFHYldvSmZkeHViTUhjYUJMWkxYNWhYMlV3am9jdzgwT01oekt1QVUwbENy?=
 =?utf-8?B?ZzZ1Mlg2cGwzOGs3MTU3K0hwRXpMd1Y0eWpNUHhna09GOFhvUHhVdHVjSnRU?=
 =?utf-8?Q?r0JY7094hxwSdA2B6wwh9SuqT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0466853-95d8-4036-c6d5-08dda9bd868c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 14:29:23.2008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSwe/rt8yhKr2brvgOfCj8Z8evyLqPISe/hwdObi86otE2Y/gQspIzy33IGURYoPT/KfIJQ18vmOi6zSBpE0Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9820



On 6/12/2025 6:04 AM, Jonathan Cameron wrote:
> On Tue, 3 Jun 2025 12:22:26 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> CXL error handling will soon be moved from the AER driver into the CXL
>> driver. This requires a notification mechanism for the AER driver to share
>> the AER interrupt with the CXL driver. The notification will be used
>> as an indication for the CXL drivers to handle and log the CXL RAS errors.
>>
>> Add a kfifo work queue to be used by the AER driver and CXL driver. The AER
>> driver will be the sole kfifo producer adding work and the cxl_core will be
>> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
>>
>> Add CXL work queue handler registration functions in the AER driver. Export
>> the functions allowing CXL driver to access. Implement registration
>> functions for the CXL driver to assign or clear the work handler function.
>>
>> Introduce function cxl_create_prot_err_info() and 'struct cxl_prot_err_info'.
>> Implement cxl_create_prot_err_info() to populate a 'struct cxl_prot_err_info'
>> instance with the AER severity and the erring device's PCI SBDF. The SBDF
>> details will be used to rediscover the erring device after the CXL driver
>> dequeues the kfifo work. The device rediscovery will be introduced along
>> with the CXL handling in future patches.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Hi Terry,
>
> A few trivial bits of feedback.  I didn't find anything substantial that
> hasn't already been covered by others.
>
> Jonathan
>
>> ---
>>  drivers/cxl/core/ras.c |  31 +++++++++-
>>  drivers/cxl/cxlpci.h   |   1 +
>>  drivers/pci/pcie/aer.c | 132 ++++++++++++++++++++++++++++-------------
>>  include/linux/aer.h    |  36 +++++++++++
>>  4 files changed, 157 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 485a831695c7..d35525e79e04 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -5,6 +5,7 @@
>>  
>>  void cxl_ras_exit(void)
>>  {
>>  	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>>  	cancel_work_sync(&cxl_cper_prot_err_work);
>> +
>> +	cxl_unregister_prot_err_work();
>> +	cancel_work_sync(&cxl_prot_err_work);
>>  }
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index adb4b1123b9b..5350fa5be784 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> +static int cxl_create_prot_error_info(struct pci_dev *pdev,
>> +				      struct aer_err_info *aer_err_info,
>> +				      struct cxl_prot_error_info *cxl_err_info)
>> +{
>> +	cxl_err_info->severity = aer_err_info->severity;
>> +
>> +	cxl_err_info->function = PCI_FUNC(pdev->devfn);
>> +	cxl_err_info->device = PCI_SLOT(pdev->devfn);
>> +	cxl_err_info->bus = pdev->bus->number;
>> +	cxl_err_info->segment = pci_domain_nr(pdev->bus);
> Maybe 
> 	*cxl_err_info = (struct cxl_prot_error_info) {
> 		.severity = aer_err_info->severity,
> 		.function = PCI_FUNC(pdev->devfn),
> 		.device = PCI_SLOT(pdev->devfn),
> 		.bus = pdev->bus_number,
> 		.segment = pci_domain_nr(dev->nbus),
> 	};
>
Ok. And I'll take your other recommendation from patch [4/16] to not split devfn.
> Or if it isn't going to get more use later, just put that assignment in
> forward_cxl_error as this helper doesn't seem to add a huge amount of
> value wrt to code reability.
>
Good idea. This function started out doing more work but has been simplified that
it no longer needs be in a helper function.

>> +
>> +	return 0;
>> +}
>> +
>> +static void forward_cxl_error(struct pci_dev *pdev, struct aer_err_info *aer_err_info)
>> +{
>> +	struct cxl_prot_err_work_data wd;
>> +	struct cxl_prot_error_info *cxl_err_info = &wd.err_info;
>> +
>> +	cxl_create_prot_error_info(pdev, aer_err_info, cxl_err_info);
> 	cxl_create_prot_error_info(pdev, aer_err_info, &wd.err_info);
>
> Ignore if this gets more complicated in a later patch but for now I don't
> see the local variable adding any value. If anything it slightly obscures
> how this gets used via wd in the next line.  However given the code is short
> that is fairly obvious either way.
>
> Or as above
> 	wd.error_info = (struct cxl_prot_error_info) {
> 		.severity = ...
> 	};
Ok. I'll let you know if it doesn't work. ;)
>> +
>> +	if (!kfifo_put(&cxl_prot_err_fifo, wd)) {
>> +		dev_err_ratelimited(&pdev->dev, "CXL kfifo overflow\n");
>> +		return;
>> +	}
>> +
>> +	schedule_work(cxl_prot_err_work);
>> +}
>> +
>>  #else
>>  static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
>>  static inline void cxl_rch_handle_error(struct pci_dev *dev,
>>  					struct aer_err_info *info) { }
>> +static inline void forward_cxl_error(struct pci_dev *dev,
>> +				    struct aer_err_info *info) { }
> Is this aligned right - looks one space short?
>
>> +static inline bool handles_cxl_errors(struct pci_dev *dev)
>> +{
>> +	return false;
>> +}
>> +static bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return 0; };
> wrap choices for the two stubs are a bit odd.   The first one is actually shorter
> if not wrapped than the second one is that you chose not to wrap.
> My slightly preference would be to wrap them both as the fist one.
>
Thanks for pointing out. Fortunately, this (and above alignment note) is moved into a new file
pci/pcie/cxl_aer.c in the next revision and no longer requires this source file #ifdef.

-Terry

>>  #endif
>


