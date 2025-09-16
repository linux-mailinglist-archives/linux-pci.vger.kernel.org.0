Return-Path: <linux-pci+bounces-36268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED23B59BE6
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 17:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0C53BD2C8
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 15:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2C0320A02;
	Tue, 16 Sep 2025 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uNzQisZE"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012054.outbound.protection.outlook.com [40.107.200.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E222D94BF;
	Tue, 16 Sep 2025 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035901; cv=fail; b=YWQX/lSL/ZkLdxJFd8/4xBwbITBpeJ951ldj0nvvl43W6hvGXMST9AFsRST3IWSIDnl+CxxOsH2qaJInrrDnH7BKx5CUI0C3stSr2MYybcyeeDIxZxu77U26lLNHa3wNzkmjQNlVxaWv+FBII4AFc+8dcEM7Emmx1lrkI+IU0ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035901; c=relaxed/simple;
	bh=06BoxcVnUuTGbOucTypfGaHkI5JwgQqPXu3E5wyZGGg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HrxphxbiB2jL4hrP/hoBotUK+QoV6+9LzK9fO0n6OZIiXS+u0f90TrJ2RQBl3P/MFrrD9+lGYLyst1p0OXKPR9afIeiLdvmTKNHc0C6C914EHq3jOKvhiRXY9oAw/MDPwf8LjX9IRsoiowtKalq6HqK0P8E58fePmq7ftiwJeMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uNzQisZE; arc=fail smtp.client-ip=40.107.200.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahs1/jhnMTD2oqtj/uTAHiYxvMvah/sSL8LxJ1cmyV4GprZG2flkfg4+2QLvLQaQAJXBmxS1DT+fLJBWxyNJlCQwlhBYHroOeaycN+XvJNZwgW0G0zgxBP11NNm5quP1uuRZfgg+ylp6sxxeE54BzodPLj9yLoyOpSSYIgTdpQDvu9+W93f5HXTAOH+wAIWIooK/mvAjK1z7ofcU6cK7t+7QgzS+0q9IRDNcvz9xy43J1LHr9DSuQu8lm9KPAFEU5w0ziBLrlKdABaoeXVJeqr7KZb4Vm6WiQtsP0ePvN10a5zozMJK+12lUm7n9ro2vW960YF8S8bTWlCnVFoorIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhRzzSD5n2yo8t9VEbV1n5Ps+fJz2KWxs8SJJHUJE+8=;
 b=q3EVEAcOCTrxHu7cg5g8Ig2o7SLTiVMd//aHCl1ATR/KLjqWOgCNF/WVwPoocxv8EhbLr82uv2sYZYhEsULwlbBW3oGVxuryuEo7HvSWrnmDiSP2JP2Kx/0fsFZt8Xx5s97684n5x6+8qbO/f+KrPnipZ8Cs6n1xgrD6Rr+wUeFeSV0mtd2Y7IFHWzWiZmV+9kFPvYNH1gHr5ZxCS1qkLtIgNdYQ77u9WXnuTXW+t+PtT3Lix6necTy57pu7+ALg7ixgrRP3NPL0kqyNeOEX1VtSaEICN0bNewg/ZKlTaal6XiC0oNjERsLzJya4aRj6lTFl+IbxSsESj1dospkvyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhRzzSD5n2yo8t9VEbV1n5Ps+fJz2KWxs8SJJHUJE+8=;
 b=uNzQisZE9jg0UwQd1DSBTvK2jUg7TRVLTlnsNwCtPpUGuVlKDfg4yXq5XSYk60Eoy3ABL8z8tJ/MM+79BtjqxCJenlUdA/Crldy/33Dl+A6kcvG+rGVG/XpJ2imgPMzUMOXwndI8FBGWhOip7tu8v4fL8Fr8qC4eYLVFAloG/kw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 LV8PR12MB9111.namprd12.prod.outlook.com (2603:10b6:408:189::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 15:18:15 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 15:18:15 +0000
Message-ID: <cb23df9f-d7a0-4cc1-93e2-acd9b7845b43@amd.com>
Date: Tue, 16 Sep 2025 10:18:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 18/23] PCI/AER: Dequeue forwarded CXL error
To: Lukas Wunner <lukas@wunner.de>, Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-19-terry.bowman@amd.com>
 <2312cd83-9faa-458b-9960-72760c769101@intel.com> <aLFSUQq20b0EAT8H@wunner.de>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <aLFSUQq20b0EAT8H@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:805:66::32) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|LV8PR12MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e95664-968a-4539-3623-08ddf53441d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUl5V0RYWkZzK295U2hCZXpZQlRKYjRCSmUrN2N2TGpnT3duOTNnVVRURnI3?=
 =?utf-8?B?eVUyQmpiakRDYU1WVnZqNzNJbFpIRVdqcHdXVTQ4ZUpwbDJHSXNRSGpNbzhl?=
 =?utf-8?B?SnRpMTF6Wjl2QTFCQXYxMGNNUmRKd1U1K2ZpT0ROcHB1c1psQ20xUS83SXg2?=
 =?utf-8?B?UW9TczhHL1BXYzhuUDlvRitrSmExL0VnMCt6TjRFVmxpODJhNVJzK1lKeFRN?=
 =?utf-8?B?NjRiMlBYN1Z2anFsVHdNM0FMQWJNMGhZTEtnS0hQeWdjcjRMM3l6UjJjODAx?=
 =?utf-8?B?cnlqK3YreUZUMWlBeHVBNHg3STltVitnZzU5Wk1SMlhpaWN4bmVuTjBsTDFo?=
 =?utf-8?B?WVQvTUtZeCtnRzZpSlh3bys5K2t6UWJHZU1wcExxSlVVUEJqUEgyd2wyTGVU?=
 =?utf-8?B?Yi9oWlR4QS9qbkdGU1ZtNFk5M2doL0VrR1EvMjd4SXZvR0RvVWNaZEVWaGpr?=
 =?utf-8?B?SC9RWDNBM1lRZkVyZzRtTzM3UjBibWJTb3NHVXRoOG9Xb0JUVE5RL1NPUkpT?=
 =?utf-8?B?ZkNlZDhtcVdrM21hY2ZNMGM5emRkdnRhVEZSeFFiRWRUSEtiNkQwTjFRZ3VV?=
 =?utf-8?B?d0JUNjAwK2E0dDJDSzd5Z1FrL3MwbGo3M09yYXVzRXJXYjZFclNXVFlUdFpn?=
 =?utf-8?B?amNsV0FSbU54V2xHOEZHeTM1a1Q0aE9wQXJHN0pGZ0NFUUx6U25MRDZtRlRI?=
 =?utf-8?B?SmdCUHdDeWM4ajN1MmtyRzBoYUw2QmtEczJ6dWkyczhpa2E0OC92VUsvRkxR?=
 =?utf-8?B?akRPVE01OVM2TW9uYXhQeWpqL1l2Q3A5RzA3NWQxcjZyK0MyY2M5cHJydTNj?=
 =?utf-8?B?RXZYUmhIUTN3TjVNZ2tyY09NR3RicG9GTE0xNFdRbjNrbFlyVG9FWVRZSjBr?=
 =?utf-8?B?VmhQMlRMZFlUZUhjRGJTdnZkTStvcnpPYktkcm0zLzUvbGZkQTdUbjkzdHR5?=
 =?utf-8?B?dmxFL3ErTS8yUnhCeklweFp4WVM0RTBXZ1BGR1N5M3YzdGpMaFhpQnNwZU9v?=
 =?utf-8?B?Y0JNZHRqU0RuaVVTSEY2amJQYmZRTkJIaEZRWVF4RjRMVmY0RnlzcFVvTTRL?=
 =?utf-8?B?UWlta09oWmtsSitnSkhNSndkdWtOa3hlbGpSQkRyWFc5TTlRQktBNXNGSnZm?=
 =?utf-8?B?WVBXbGJvOTVwUHlOclZZOXFPQWRSRHhoSERpSGRmdGcxc1lzK0IrSHNid2Zm?=
 =?utf-8?B?YzhDZ0xjNXNmMWIra1RhMFg2aEJhN3VkSkNGTXVHd3ozaFpXWkk5R3dIMlJn?=
 =?utf-8?B?QjNmenl5L3oySGxGMm0rclJ5Y0F2Qis5cmptMmNxV25QaU94VEVrdXMrZmk0?=
 =?utf-8?B?cXNORUhWdVdGN0FFS0ZuRDdvZjZ2K2NUYUZrVnR4WXcrb1VaU20wcmIveDda?=
 =?utf-8?B?Q2tkMjlrZEJvaDFra0ZmUUh5MXV1NUhOZmhtd0I0MldNYktsWVhOT1Rqd2V4?=
 =?utf-8?B?TEZwSmZIbHVrV05IbGhQTW1vZWhESU5NL1pTZUdYUElIT1lPRWY2dTNnUjRp?=
 =?utf-8?B?TjRjazBFajJGQzM5dFVuL1IxdGlpRjN5NDZKNlBjVk9LZHI4L2sxOHM2enFh?=
 =?utf-8?B?UHlCODhtWEFETitLNEwwQktsMlc4UjVGaisrTVZnVXQ0amlGdjJQT1A5TUk1?=
 =?utf-8?B?U29adFptT3ZOc2xvUTlodXZ4ZzFpRVpNZlRIOG9reGc3ay9IMUU1U1VrV2E5?=
 =?utf-8?B?VHhiU0lISDhQTlo3d0dvK3hPWHZVbnhrVExzaE1CV3Qvcm41NlVWSmNDcDBj?=
 =?utf-8?B?VFBXOTZnYU95SnViK1hvRllreGlpU3Nhbm9Rek1sK2VNQ0lCclEzQ3dLU1ZY?=
 =?utf-8?B?TGt1V3Y3SGR1TXZ0VDBjR3pQUVdVazlNbTYxbDhRQ3ltNGo4dXoxSG5IZkNI?=
 =?utf-8?B?OUV5M2xVUUdxT1NQNHVzQVZIZ1Q5R1pmb2tvemVjdmpCbmNFZFEzS0JydHgw?=
 =?utf-8?Q?pZfOHKKNKSw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3RTdTRNTU9aNUd4SUtNak9YLzQ4WDEzRVQ4TUczNUxjRzF2bG01OVdBQlhK?=
 =?utf-8?B?N0FVd28wSkxJczJHOTAyWk1PLzZ2eUk1ZllGSmFuQ2JSRnFsMk1SSG00cXVY?=
 =?utf-8?B?Y29hUEkxeURPTGRySTZnRXZFMVRodURVOVM1ZGluT1I2dEdxendrTDJvMy9r?=
 =?utf-8?B?MVROUkRJY0JUSGQ1U0NSQnZ0OW13eXB2aGJGVjdEQk5jU1RWSHM0KzBjQ1gw?=
 =?utf-8?B?dGdQTzBTWnc4c0JueWs3R2xUR01LYVgyS1gydHhxU0ZNbmUrWW1Wckx0R3NH?=
 =?utf-8?B?b0hWT0hzT2dHRTY5VVFBVFZ1WUR5Rk9NaGo5Uk00cFVzM1A4Ry83TnNQbXd5?=
 =?utf-8?B?cTNoc0xYYjlmbDEvcllFVHJPT0NiNW9oUFVCTzVxaHFsek5hOFRhVUxEWk5P?=
 =?utf-8?B?R1RaRTNGdW1NMzVJc2VyZFlRaExpeXE3M3JldUlVRm5aaHZxSXNabGpRaFJE?=
 =?utf-8?B?U2l0bWlHU2dQSW40b3EyQkhNL0VEdmFydWRvUUdrU2RwREVEMW5rRjBsMlg2?=
 =?utf-8?B?T2tSMUIrOWpyN0tyYkd6M25YQUt3R3ZRSHlQVGZicEcvWFFYZGJSUVJ2RGlK?=
 =?utf-8?B?V2IreXkyTmVXYUpWZTlmbis1a3orck52R2MzejlKeENUTnJkZVJSZHdmbFpw?=
 =?utf-8?B?cHNzWUVyK1E5RHVPN0dteURMWTEyMUFoZFZaYmx3OFloaGRWVllZaTNvL0pK?=
 =?utf-8?B?Z1krakp6T1U2clJmRDNZbHlUYk1uckVRK2tSaUFBdENLK25xdUY5Q0Z2V1RS?=
 =?utf-8?B?NDRYUm5zUFBBNG51YkRtRE5mOWxNUXJRYUV0bUhFZ0tUVHc1ZlhzQnljQUNY?=
 =?utf-8?B?VHZqUkNWTHdqaTFjUmNXek5ueFNvQklSWHM4TVo4OWs1ZnpkQVdZRXdzNklr?=
 =?utf-8?B?RWcyTktFdHowQVZSU25JZUZXRzJxQVpBekpWbGxZK3Npb3hUSkdjWGNRdHJI?=
 =?utf-8?B?Ry9CeUtxb1RLVDVNakVIblFRbi96bUxaRjN6LzNicVhCbkptV3VaQzUzejds?=
 =?utf-8?B?TWNrSVJ2Rk9IY002cW4va1lLOXo0YmJ5WkpPRUlmRjRNd3JxVnkyMTFmdVc3?=
 =?utf-8?B?ZUVFRGtlN2xUNXZIckhONUt4NW5icm81SUwxZkpZSXlvYnZZS3l4ZUVKckhW?=
 =?utf-8?B?eFdaQ203TFYxa21YbVM2QUFaWHZKSkd0a0dyek1JY1hsaU95Q1RIT3NFeDJ2?=
 =?utf-8?B?ZFlEdFQ0bUgrWW1pL2Fqa25OSDJTclpyRG9hQ1BFQXZvakw4OEZJUmp1WmVM?=
 =?utf-8?B?YlN3a3h2UXZOUVRhaERuRmNXcGFmTWliUzhJQkYvMStGNFdyQzNXREpHZFlZ?=
 =?utf-8?B?bHNKbWVYdm5USmFXc1RTV3d2RGc5K1Q0R2tGUGVwRlU0eFhUVTlZN1o4OFNG?=
 =?utf-8?B?YTA5K3NkaUVmQ3BJOWxpNTRvTHRGSFMwYUZveWhrVUZ0K0pjMWpnUXhLejZF?=
 =?utf-8?B?SzBLd05hMVRRWW9PcjFMWmtjcThNL3pMMmJ3QldXdWw0U0krUmNZNFRuUXJs?=
 =?utf-8?B?NVcwWFI0Mi9qMktZYU1aUGJRUHY3SW1qQTdDZUlzRG9LZjRvOW5rdVY3MW1y?=
 =?utf-8?B?bGRnQlF0RHYrYlArVDJXcHJUWkFqUGYxdzRwWVFBdkJ1VVozb3Izc25QLy9u?=
 =?utf-8?B?elBwNHQxZkFsZi85S1lyWTh2SGUyMk1DT1Nhemp2WHJvUWVxUHNTdGo5RFND?=
 =?utf-8?B?ZHJaUHV2RWtqbmRmTytzSG9BYnNwb1A0cE0xRWo1WGRhRnZXZ0RHVm9UY3Q1?=
 =?utf-8?B?SEltVFVmK2NRUHNXZWdVM3NvRVlaeU1WTk1RbFdNSVY5djV0RTZwK2tIU1ND?=
 =?utf-8?B?eWFieEZlMnc1Q0lwcjRZM0lpUE5uNndXZjM5TUJ4R2JmaWRuU2NuVEY5ZGt2?=
 =?utf-8?B?SHdvV0Nad3dOcFlWNlhEN0xPcWlJcGdFNDA2S2hLend4b0hteEtoWVZCYUtO?=
 =?utf-8?B?cFMzdk5EVnpMVlJ4ZWxZUzRMbVlDblpBcHUyUWI0UWtrVVYvUmFmTXUvbmRH?=
 =?utf-8?B?WWVub1htc1RmMFdOUkNTeHZpNDlvcGpWWVhrbm8wRGJiL1NKaXNrMys3dm9l?=
 =?utf-8?B?UzF2MUxkS3hmcFI1L0dtYWUxNGI3c2QyVFZTSDZBK0piZTVWL0RvT0hhNWds?=
 =?utf-8?Q?VYC3ibmN5xILBhfjBogxXSyRD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e95664-968a-4539-3623-08ddf53441d9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 15:18:15.2042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2Nrr5MYWbGj4UOd/fh1OrDYsRJ8iXwzCr8qgxxNu0ARPVzbm4KMIYH0xQlCjI98U8BXGmaC61VFPggLo0pz3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9111



On 8/29/2025 2:10 AM, Lukas Wunner wrote:
> On Thu, Aug 28, 2025 at 05:43:31PM -0700, Dave Jiang wrote:
>> On 8/26/25 6:35 PM, Terry Bowman wrote:
>>> +static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
>>> +{
>>> +	struct pci_dev *pdev = err_info->pdev;
>>> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> So this function is called from the workqueue thread to consume data
>> from the kfifo right? Do we need to take the device lock of the pdev
>> to ensure that a driver is bound to the device before we attempt to
>> retrieve the data? And do we also need to verify that the driver bound
>> is the cxl_pci driver (and not something like vfio_pci)? Otherwise I
>> think assuming the drv data is cxl_dev_state may cause crash.
> In v10 of this series, there used to be a cxl_pci_drv_bound() function
> to verify that the cxl_pci_driver is bound and not some other driver.
> That function was called from cxl_rch_handle_error_iter().
>
> It seems this is gone in v11?
>
> Thanks,
>
> Lukas
Hi Lukas,

Yes, this was removed due to a build issue. I am adding back with the fix.

You mentioned cxl_rch_handle_error_iter() above and I want to clarify my 
understanding that this is not needed in the RCH case. RCH handling includes 
traversal to find the first downstream PCI EP and calls the EP's 
pci_driver::err_handlers callbacks. These are part of pci_driver and therefore 
don't need the driver check as they will work for any bound pci_driver. 

The check is needed for VH EP CE and non-fatal UCE because they are handled 
by CXL error callbacks defined in the cxl_core/cxl_pci modules and not in the 
pci_driver::err_handlers.

Terry

