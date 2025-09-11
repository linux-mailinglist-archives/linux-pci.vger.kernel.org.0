Return-Path: <linux-pci+bounces-35916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 998F7B5359C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 16:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B957FAA39EE
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 14:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45FF340DA7;
	Thu, 11 Sep 2025 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xeyLeQdk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0F333EB06;
	Thu, 11 Sep 2025 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601246; cv=fail; b=DD101atjF8lzadThdQfblQgKebtn9f/XRif93RPo6gqbhoIcowwZMc1iYCni1RMM9kWcDKwuPoftuGL/P5WEsLx9NXSyaOq5G6NidpGxZ70CWPOvuohjnnrEJ3J6/hgqB3RtzrK2gPNwgx19u+CJ4ma1Dl+UJeR4CZJky42GZX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601246; c=relaxed/simple;
	bh=T5kSPIFNK+gbRb56VxWsiGjrgJjqqRU6pG5JDspFrNY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c+pAo2nRj1egvqxdtN0EyIEOiA5lS8PmFmy8c/kLA4MbiAxKJWm4StIovC05AH5RbNQxxKRHlKBYifYuno7wziC0kivl5r5u0I/QxDOY8CGjdkbln+iAwbmkEqvQnYDHjwBIrj955KG56Q59GxG/ExVXYZ130JrH1lJ1Mblc6tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xeyLeQdk; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvwQ0/qIL04ayRwX9vzOfEf+xJ7/hZ3AItkBL0ObX3Sk6bf0tsrSTAwR+OuCBzy7HHjYTidgrDYvwNy//vBbEtSdL+P+90Tb6VzSWv3jvGR9PpGiDTMdY32AB1kCubIrb8Oel7du/D+oHuOOFJDcyhgEzdUlv9OrHgDNIhD76YZomLpv5dzzeJ4OAncaxlMeaByr7swalNxG8LOz3M7Irp+M9MEpqHQNxStsu3yraHt6o21AHcwpbhQU5eCqSpIdn2xpF83sviUOHAaeqMeIMzuW1EeZiLBVQTcGhaNcoQ7NMwqSwQGR47Iw0MApKNTCg50Eev45JXPhhF8l11nSTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Xbe2CinGFh9vHSZIvHIXV+9Cfr+qrkqGo1meBPEt7A=;
 b=Ah6w1UFlvJQMTG35zMJSwRqWsbl8Ie8tHkWuHkk92qbPw6vn48xgZNtPZ/+x9ITNnckR/12MCr1Zpdko7WcuIT+6LPrGN0U0LrhyVNze0NLrNygVixW9wBclVe5v1J3kuXNY+Zct9241cbpKEGs7V0Nrxl0I7ExkotPl77qKBHponY3NPTT4rupKj6mRxbrbegbJRsOYQjCbSw4l/7dyckf0855AsidUBpiOx9zmlUzOa8i4imlIPPMKGUmZb3q9EGPGV4Q/fi9T0qdCQuJ88Cerbu+AZIc3iGTUCVPZkz7oYofP4xG3SLcwsU3dOlT+PfJSuTqNmbo4D/7JwBbwFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Xbe2CinGFh9vHSZIvHIXV+9Cfr+qrkqGo1meBPEt7A=;
 b=xeyLeQdku9qHxf4zbD4MZwpGC4XDNLDZ0WpK2NpHn74U0kbgWACN5DWOgTE0SgVwGXDEmCAkS8tX3MCrP/xOrVybPnItnXTGXuMqJx+548cNa4dQVTZenR/qvZRo26SeR/yNbXs2X7yTlOVthLHnz7rFRT4yZLXnIYzkLFA+uyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CY5PR12MB6528.namprd12.prod.outlook.com (2603:10b6:930:43::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Thu, 11 Sep 2025 14:33:59 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 14:33:58 +0000
Message-ID: <39c70b76-c109-48d8-ba4f-ef7535f7ddca@amd.com>
Date: Thu, 11 Sep 2025 09:33:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 18/23] PCI/AER: Dequeue forwarded CXL error
To: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-19-terry.bowman@amd.com>
 <2312cd83-9faa-458b-9960-72760c769101@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <2312cd83-9faa-458b-9960-72760c769101@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR04CA0103.namprd04.prod.outlook.com
 (2603:10b6:805:f2::44) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CY5PR12MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6d7ed1-18ca-4a0f-ef45-08ddf1403e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azlCYkR4UlRDMVV4WUErMmFSMVdBT2ZXaDExZmQ5azhmTzFCN2lpSWVtSFFU?=
 =?utf-8?B?YURJQWNFOGY5azcwbGJHSnRnaEhjaTd5cVhOQlR0dzBrTHoxN3JYMTY0RVFM?=
 =?utf-8?B?UkZDcStYajBKMlpreFN3ai82YXhsVEk3WjRrM0djclBDeFpZMWVPMExoRFZE?=
 =?utf-8?B?VjNVamxzMmZ2MU1acXh1ZHlsNldKaDYzRmdWbWNjOUJ1Um1XSUF5WFQwWlcr?=
 =?utf-8?B?amdPK05aUGNKVzdFQVFhZXJqUCtWemJzdnZkaG1Od1ZaVzZvVUJEeGVkOWN2?=
 =?utf-8?B?djRoTnc5eEpTaGh1d21ZNHZENWo2b0trT1FBVjZpOXYyM29VVTJ6U2pWQzI4?=
 =?utf-8?B?SGN1MXorekQ3SzdSQU0wNCtTRFpPaCsvQ2Urc1U0VEorNkpQTTVRTzM2L0Jm?=
 =?utf-8?B?QkZRVjdzbEZKSTIvaVA4QkY5ZVN5KzFpdGNQN2laQXlpN3JjUXhrYjVWcS90?=
 =?utf-8?B?d29ic2lQNDFvMUVJWkZKSkM0cERXY2N0YjFBRFNCVzBqWGFLTEhUWVowejJk?=
 =?utf-8?B?bVkwWkZUNmk5SW54TFZOYnNqQ1JIM01Vdi90Q1M4Q2RVajR2ZVAxSm1nTWla?=
 =?utf-8?B?L3RGRHJSV2V6SXJkM2xsR2dkdmhNcWZSMlIvNUVNOWM2SlJhcmRUOE9yUkd0?=
 =?utf-8?B?cW93c3B3ejM4RFJBWjVIc2VicXFuaTFDY0JWcU5QckJqMmxWRldQRW9ITDFD?=
 =?utf-8?B?Z1lsM2JBeWk1c1A5dW9EUThncXorU2NmdXlqZWhVMUM2OHFsdExhYldBcy8r?=
 =?utf-8?B?YURzMVljVkNwU0lLU21PeUhMeU5kbW1ZdWcyQlU3TTBpUUhvVjY1NXlUOElu?=
 =?utf-8?B?QTBnc25KS2liRHBxU2NJU3RNSGhoMzlmTXhKL2lWUHc4QmE3bnVadWJUUWta?=
 =?utf-8?B?SjNROFlUUG4rNkltZVprdDlCS2w5aUJZWEdpN1pqc3VnQUY4VGV6SnB6Z0JU?=
 =?utf-8?B?YnlsZlJ2VStWcW5ZTzQzV1F6bU80b0lGWG5MUUFYZWVMTUx0Q2JyVUJWZ3Ni?=
 =?utf-8?B?SGVVREpMampXWlNCT3NGSFlMOFlUS01oNzV3MGwyNlBBY3RldXZKV3JxS2do?=
 =?utf-8?B?bHY3R0JWcGthTkZBd0lhZ1ZpaTFDajVxV04rZDVzTkU1SStJa0lYMUYvM2th?=
 =?utf-8?B?K21IQlM5MENUS3dBblRBK2FmZ09GSCs5dW1Db1FMQlVWbDZLMGFnRkpmMGNF?=
 =?utf-8?B?TG5WdlVTeG5TL1dZVC8zRithbUVEZjRVVjBBK2cyanppeFliNFBvdlpBN3Rx?=
 =?utf-8?B?QU4xc0h2djhGMTVsM1pPZTEyZzl5cXEzNnNwT0NIcUlvcTByU2c1bEp3Tjgv?=
 =?utf-8?B?V01tZGxUUCszeWNXTHRrUnRtVW8xR0ZzN21YdmVGS2c0OXJqOTN0cDU3Tlk4?=
 =?utf-8?B?VzlHOXM0YVBwTS8zU0NranJTYXZKcGlpQ2xyeWZVQTBqMld1TDN2UWdDQ0dv?=
 =?utf-8?B?Mmo0OXNSaWxEM09Ia3hUaFBqckdIaEZ5RTZXSXN4b3lPTlZkSXBTK0w4VmRJ?=
 =?utf-8?B?UmZDbjZHUm02QmJDZ1FoRFhQeDJDZjNwdWRGNkt6UFNHYU9hNlhPd0J2RGdJ?=
 =?utf-8?B?M2JVSXZiYlpFNWdZK1RlMU5EenU5QTFyTWVHc2RaUzd0TWJBRllSS2NzYyth?=
 =?utf-8?B?VFA5Qm91c2lnSWd1V2FVTXQ4QXlKQ1FPNDdzb0hsa3FaQS9kOENYTVhod05S?=
 =?utf-8?B?NVVKeERndzZyN3JZbmFTOVhEL1U4NFc2Ty9SUEpUdW5Db0poZFF2Yk42Y2Zw?=
 =?utf-8?B?cTk2d1dwVjJPRUk0RjFURkYxS1pvRW1NbkJtMWc0UUJ1bzNzM1ZwM2FucENB?=
 =?utf-8?B?ak1rc2dEVUFveU5rbmhOeW9kOGJ2b05CU2MrTHpjekJ0OFVDWXZHQjFiOE82?=
 =?utf-8?B?M0V2TlJaV2VnWGFqZCs1cXUrUUt2VVVNNWVIY09VNEQ5T2lLL2h2aisrSUI1?=
 =?utf-8?B?NnhmMnVrT3JRbG9kTE5pVWpDK0d6OGEyZFoxeEFyRysvWEZEU1JJZFk3SUMr?=
 =?utf-8?B?eHgwNmx6NzdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WU9wYnBQSFZRN2V1L0xCTzZIaE1FNTJWM3hFSkR6clQ5SThEYm85eTUrS3Qx?=
 =?utf-8?B?WklmZDJjaHdtemRLTGN6OHNLazh1UHh6OE9RbHRLQWUrRWttVGd4M2htT0w0?=
 =?utf-8?B?RjM3ZDR5VEpiSlFtZ1FpUENzQm5ETmVSc3NHYXVHV0NlSEV1YllpUFNucUgv?=
 =?utf-8?B?TTI4QUJCNFcyVzFCNG9XaHJ5NEpia1phNDZFR3FxTXhCOWpLUjlYcGg2TElU?=
 =?utf-8?B?U3lodTZHTDRDYkFWY1JnTWlsY0lKUU9oVjhNc3J4N0tUd1dSK01SVjd2OG8w?=
 =?utf-8?B?RXA5Qm9YblNFYUQybk1qQWFOZE92V0Z0TXo2VDZSNWtpRzBVYkRIaFUvenZ4?=
 =?utf-8?B?NFF2ZGZRSEFZSVo2cWcySWlTWURXeTB2SGJjOWlLN2NPQWU5QWVqdTdDd0kx?=
 =?utf-8?B?bEFRV0ZDRnkzSTJCeko0TzRVa20xcDRyMk1wd1dZVTNNa0NWOGRMeXFQTXdk?=
 =?utf-8?B?UHIxTkVzSnZiM1VSKzVWL2p0MThockZ6bEJtRmwxdjY2RWdXZGRzQUZRNnJE?=
 =?utf-8?B?RHE4VFBnZkN6WXJWT3Q5YzlUTnZJTTVoZnlYNFAvYXNqTUdGSkg1ckoyV29L?=
 =?utf-8?B?cUc5bloreGxnQjVQZVdtZm1uUktWYTliK0hzWThQOHQxVTAzTDNRQy92Zk5P?=
 =?utf-8?B?ZkY5Q1JDL0Q3SDVkRjJLbjJibzRzOGpsOWNyaUI0SVdzK0l6bGM3eFZkV0pO?=
 =?utf-8?B?LzJ4dTJrM2t5Q1RlK1J2ajJGTGpmTmo4V0VVUkxvTkNLSzFhUDhJZ1plOUhD?=
 =?utf-8?B?QytSYTZlQy9iNTZqanA2U2VGNWRoV0EvaW5QenVjd0NBeDZwN2F5aGZyb0hT?=
 =?utf-8?B?b0dsTHVrOUZJcHNpWDRPeXhJRzVxSEk0R1dzYTBZL1ZtcFdjSEkvQ3BXelRB?=
 =?utf-8?B?SlBNUGhTS3JXWHFYUnE2ZkFjc3F4Yjl2Z2pqKzhlbGFDV3IxZUVsRVBHQlU0?=
 =?utf-8?B?aWpuZ2NjSXFZWG9ybGtSTG1aTHdDWk4zY0VMY0F1UklsV3daell4bjlLS3li?=
 =?utf-8?B?SDI0QkUzdC9keXpRaDBqVU84YXpjWXdIY0RoWE51OEo0dWthZ1kvYnVKUzBG?=
 =?utf-8?B?OVRJMjc0N3lmSnlWMERGdUF3QitQSjU3RWozUU5DS2owemQ4WURkbEhBYk1K?=
 =?utf-8?B?ZGZjc0gyb2pIcVppa1RqcGhRQzVRQ2F4N2g1N1B0dlBSc0ZYNkdXTENzMEh3?=
 =?utf-8?B?RHFYK0ZobDJQWkxQcTRWZUV2Z2FkV0JReGhtZHk0MllMdyt3OHJ3RngxTk9X?=
 =?utf-8?B?a0hMbW0rNmlmSVhOL3RDTXpncXhFU1g4Qmk2alR6T2FIc1pldUo5MzF6alho?=
 =?utf-8?B?bTNQaEVOVWxVK2VDdmM2NllOWjdhellwYjl2UEMyWmJHblhSdm9ScjBHRDZ2?=
 =?utf-8?B?VFpOblhwZFZWKyt2dFZYdVZmN2JzSjIyQy82eTA1RGo0Rmo4eGYzK3VkZGMz?=
 =?utf-8?B?YlZmQ1Q2RHRsYi9GbmR5WVRxM3pVRTVBZWFKK0hod2J2SU5UMDRseE5kNFJ3?=
 =?utf-8?B?aDlrcTRoVlVsd0FPakY2VGtER1JqTE13Q1J4QTc4SGJVZFpDS3pVT0crK1Ju?=
 =?utf-8?B?WEdBT25oTGxuLzBvZ2dMR3Zac0I3enJTS1ZlZUxJQXR4WHZHYk1jc2ozWVBP?=
 =?utf-8?B?QTYrWEVlREFvd1lRWVVTNlFUNjEyTDhrWVZOS1drZWJUM0p0SU1zVERIcmlM?=
 =?utf-8?B?dTdEUm1CRjk4TmI0eVVxN1BkOGZtcW9kWS9QTXE3a2VmKzFqMEZ4YU9xN1Vu?=
 =?utf-8?B?cjhsTS83bXZoSjloejJqeWhaU21pMVVCRk5wRHBaRFJnS1BJQmhlUUw1SXkr?=
 =?utf-8?B?MEt0TThHT0hvZWJpOStLT3lvRU1SN09tdkpHZEJLdldGNDJ0ZnIvQ3dZVVZp?=
 =?utf-8?B?N2o3Wmdid0doQzlZVVZUM0VTSDhYZGZrQ0t2TnNFYjZsbGZrRXNjazA2OURV?=
 =?utf-8?B?YXhFZ0VudkUwYzBxODd0ZXhSUWtiNi9TOVhDZE5QeFFHYldkc1BobjQ0WTJj?=
 =?utf-8?B?K09iUU0zTVpsdlVuTUlDV215MTdaSXgyQ3hMOTRKdlZHbWsxQmhMTWVCVWJr?=
 =?utf-8?B?ckc1U0F4QStCQTFDOUFPRGd2WjZFOEhhY3R4OFIrTU9WbW9vNEloUmE0cHhj?=
 =?utf-8?Q?5mAdRs4OrHXELpW4K5YK0dLsK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6d7ed1-18ca-4a0f-ef45-08ddf1403e8b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:33:58.8415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4h4rZJJs0vOxY66sFrcFD3YI+HIhDDnzP4E3XQfbbYat3ZF4qpH4Wg5WlYnr6QOtd1f0Dbpa6uQu8/x6PGiJ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6528



On 8/28/2025 7:43 PM, Dave Jiang wrote:
>
> On 8/26/25 6:35 PM, Terry Bowman wrote:
>> The AER driver is now designed to forward CXL protocol errors to the CXL
> I would rephrase it to:
> The AER driver enqueues the CXL protocol error info to the created kfifo for the CXL driver to consume.
>  
>> driver. Update the CXL driver with functionality to dequeue the forwarded
>> CXL error from the kfifo. Also, update the CXL driver to begin the protocol
>> error handling processing using the work received from the FIFO.
>>
>> Update function cxl_proto_err_work_fn() to dequeue work forwarded by the
>> AER service driver. This will begin the CXL protocol error processing with
>> a call to cxl_handle_proto_error().
>>
>> Introduce logic to take the SBDF values from 'struct cxl_proto_error_info'
>> and use in discovering the erring PCI device. The call to pci_get_domain_bus_and_slot()
>> will return a reference counted 'struct pci_dev *'. This will serve as
>> reference count to prevent releasing the CXL Endpoint's mapped RAS while
>> handling the error. Use scope base __free() to put the reference count.
>> This will change when adding support for CXL port devices in the future.
>>
>> Implement cxl_handle_proto_error() to differentiate between Restricted CXL
>> Host (RCH) protocol errors and CXL virtual host (VH) protocol errors.
>> Maintain the existing RCH handling. Export the AER driver's pcie_walk_rcec()
>> allowing the CXL driver to walk the RCEC's secondary bus.
>>
>> VH correctable error (CE) processing will call the CXL CE handler. VH
>> uncorrectable errors (UCE) will call cxl_do_recovery(), implemented as a
>> stub for now and to be updated in future patch. Export pci_aer_clean_fatal_status()
>> and pci_clean_device_status() used to clean up AER status after handling.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> ---
>> Changes in v10->v11:
>> - Reword patch commit message to remove RCiEP details (Jonathan)
>> - Add #include <linux/bitfield.h> (Terry)
>> - is_cxl_rcd() - Fix short comment message wrap  (Jonathan)
>> - is_cxl_rcd() - Combine return calls into 1  (Jonathan)
>> - cxl_handle_proto_error() - Move comment earlier  (Jonathan)
>> - Usse FIELD_GET() in discovering class code (Jonathan)
>> - Remove BDF from cxl_proto_err_work_data. Use 'struct pci_dev *' (Dan)
>> ---
>>  drivers/cxl/core/ras.c  | 68 ++++++++++++++++++++++++++++++++++-------
>>  drivers/pci/pci.c       |  1 +
>>  drivers/pci/pci.h       |  7 -----
>>  drivers/pci/pcie/aer.c  |  1 +
>>  drivers/pci/pcie/rcec.c |  1 +
>>  include/linux/aer.h     |  2 ++
>>  include/linux/pci.h     | 10 ++++++
>>  7 files changed, 72 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index b285448c2d9c..a2e95c49f965 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -118,17 +118,6 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>>  }
>>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>>  
>> -int cxl_ras_init(void)
>> -{
>> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
>> -}
>> -
>> -void cxl_ras_exit(void)
>> -{
>> -	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>> -	cancel_work_sync(&cxl_cper_prot_err_work);
>> -}
>> -
>>  static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
>>  static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base);
>>  
>> @@ -331,6 +320,10 @@ void cxl_endpoint_port_init_ras(struct cxl_port *ep)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
>>  
>> +static void cxl_do_recovery(struct device *dev)
>> +{
>> +}
>> +
>>  static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>  {
>>  	void __iomem *addr;
>> @@ -472,3 +465,56 @@ pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
>>  	return rc;
>>  }
>>  EXPORT_SYMBOL_NS_GPL(pci_error_detected, "CXL");
>> +
>> +static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
>> +{
>> +	struct pci_dev *pdev = err_info->pdev;
>> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> So this function is called from the workqueue thread to consume data from the kfifo right? Do we need to take the device lock of the pdev to ensure that a driver is bound to the device before we attempt to retrieve the data? And do we also need to verify that the driver bound is the cxl_pci driver (and not something like vfio_pci)? Otherwise I think assuming the drv data is cxl_dev_state may cause crash.
>
> DJ

Yes, this is called in the worker thread context. I added the pdev device locks
later in cxl_report_error_detected() for the UCE case. I found it necessary to 
put in this function and not in cxl_handle_proto_error() (here) because of the 
traversing logic in the UCE handling flow where it needs to be locked but only
exactly once. I didn't add for the CE because I wasn't certain a CE error was 
enough reason to add a device lock. 

The UCE flow is:

cxl_handle_proto_error()
--> cxl_do_recovery()
----> cxl_handle_proto_error() <--- Added device lock here because of topo traversing/iteration


I tried adding a function checking for cxl_pci driver but ran into circular dependency 
because the driver is defined in cxl_pci but called from cxl_core. I will revisit
this again but need some ideas how to make that work as I expect it will require 
some code moving. 

Terry

>> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>> +	struct device *host_dev __free(put_device) = get_device(&cxlmd->dev);
>> +> +	if (err_info->severity == AER_CORRECTABLE) {
>> +		int aer = pdev->aer_cap;
>> +
>> +		if (aer)
>> +			pci_clear_and_set_config_dword(pdev,
>> +						       aer + PCI_ERR_COR_STATUS,
>> +						       0, PCI_ERR_COR_INTERNAL);
>> +
>> +		cxl_cor_error_detected(&cxlmd->dev);
>> +
>> +		pcie_clear_device_status(pdev);
>> +	} else {
>> +		cxl_do_recovery(&cxlmd->dev);
>> +	}
>> +}
>> +
>> +static void cxl_proto_err_work_fn(struct work_struct *work)
>> +{
>> +	struct cxl_proto_err_work_data wd;
>> +
>> +	while (cxl_proto_err_kfifo_get(&wd))
>> +		cxl_handle_proto_error(&wd);
>> +}
>> +
>> +static struct work_struct cxl_proto_err_work;
>> +static DECLARE_WORK(cxl_proto_err_work, cxl_proto_err_work_fn);
>> +
>> +int cxl_ras_init(void)
>> +{
>> +	if (cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work))
>> +		pr_err("Failed to initialize CXL RAS CPER\n");
>> +
>> +	cxl_register_proto_err_work(&cxl_proto_err_work);
>> +
>> +	return 0;
>> +}
>> +
>> +void cxl_ras_exit(void)
>> +{
>> +	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>> +	cancel_work_sync(&cxl_cper_prot_err_work);
>> +
>> +	cxl_unregister_proto_err_work();
>> +	cancel_work_sync(&cxl_proto_err_work);
>> +}
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index d775ed37a79b..2c9827690cb3 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -2328,6 +2328,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>>  }
>> +EXPORT_SYMBOL_NS_GPL(pcie_clear_device_status, "CXL");
>>  #endif
>>  
>>  /**
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index cfa75903dd3f..69ff7c2d214f 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -671,16 +671,10 @@ static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
>>  void pci_rcec_init(struct pci_dev *dev);
>>  void pci_rcec_exit(struct pci_dev *dev);
>>  void pcie_link_rcec(struct pci_dev *rcec);
>> -void pcie_walk_rcec(struct pci_dev *rcec,
>> -		    int (*cb)(struct pci_dev *, void *),
>> -		    void *userdata);
>>  #else
>>  static inline void pci_rcec_init(struct pci_dev *dev) { }
>>  static inline void pci_rcec_exit(struct pci_dev *dev) { }
>>  static inline void pcie_link_rcec(struct pci_dev *rcec) { }
>> -static inline void pcie_walk_rcec(struct pci_dev *rcec,
>> -				  int (*cb)(struct pci_dev *, void *),
>> -				  void *userdata) { }
>>  #endif
>>  
>>  #ifdef CONFIG_PCI_ATS
>> @@ -1022,7 +1016,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
>>  static inline void pci_no_aer(void) { }
>>  static inline void pci_aer_init(struct pci_dev *d) { }
>>  static inline void pci_aer_exit(struct pci_dev *d) { }
>> -static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>>  static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
>>  static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
>>  static inline void pci_save_aer_state(struct pci_dev *dev) { }
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 627d89ccea9c..45abe1622316 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -288,6 +288,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>>  	if (status)
>>  		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>>  }
>> +EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
>>  
>>  /**
>>   * pci_aer_raw_clear_status - Clear AER error registers.
>> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
>> index d0bcd141ac9c..fb6cf6449a1d 100644
>> --- a/drivers/pci/pcie/rcec.c
>> +++ b/drivers/pci/pcie/rcec.c
>> @@ -145,6 +145,7 @@ void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
>>  
>>  	walk_rcec(walk_rcec_helper, &rcec_data);
>>  }
>> +EXPORT_SYMBOL_NS_GPL(pcie_walk_rcec, "CXL");
>>  
>>  void pci_rcec_init(struct pci_dev *dev)
>>  {
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index f8eb32805957..1f79f0be4bf7 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -66,12 +66,14 @@ struct cxl_proto_err_work_data {
>>  
>>  #if defined(CONFIG_PCIEAER)
>>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>> +void pci_aer_clear_fatal_status(struct pci_dev *dev);
>>  int pcie_aer_is_native(struct pci_dev *dev);
>>  #else
>>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>  {
>>  	return -EINVAL;
>>  }
>> +static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>  #endif
>>  
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 3dcab36c437f..3407d687459d 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1804,6 +1804,9 @@ extern bool pcie_ports_native;
>>  
>>  int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>>  			  bool use_lt);
>> +void pcie_walk_rcec(struct pci_dev *rcec,
>> +		    int (*cb)(struct pci_dev *, void *),
>> +		    void *userdata);
>>  #else
>>  #define pcie_ports_disabled	true
>>  #define pcie_ports_native	false
>> @@ -1814,8 +1817,15 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
>>  {
>>  	return -EOPNOTSUPP;
>>  }
>> +
>> +static inline void pcie_walk_rcec(struct pci_dev *rcec,
>> +				  int (*cb)(struct pci_dev *, void *),
>> +				  void *userdata) { }
>> +
>>  #endif
>>  
>> +void pcie_clear_device_status(struct pci_dev *dev);
>> +
>>  #define PCIE_LINK_STATE_L0S		(BIT(0) | BIT(1)) /* Upstr/dwnstr L0s */
>>  #define PCIE_LINK_STATE_L1		BIT(2)	/* L1 state */
>>  #define PCIE_LINK_STATE_L1_1		BIT(3)	/* ASPM L1.1 state */


