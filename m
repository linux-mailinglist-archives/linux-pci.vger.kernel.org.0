Return-Path: <linux-pci+bounces-31297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 165CEAF6062
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 19:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352DF1C45C84
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 17:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F20309A6F;
	Wed,  2 Jul 2025 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JMFdyo+9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C542F50B7;
	Wed,  2 Jul 2025 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751478705; cv=fail; b=Tf9CHsLVQxncr721JH/TZeTw/g6KjvkyVaz90pq5VmUNGt5wt6HlO7mDOuLMJ72We0MrNqorYfY3Zh0riwyzDyo4HNreqTUESYlBO7pw9+vifgRnqKCtRVkOAQ57i0HLOwlpgX1u8NvPwYt9iryqSbUaSqBuiLjmiBvu7qYJZ74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751478705; c=relaxed/simple;
	bh=uOow8jDuqPGdkY9vW3q7eonHfudc8N2LWRoi6npMusY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ThmJ1f7qRP5FG7HbP3wrZbK0U5hSEhuAoSDPOB5ZuyDTX6vJUvFpeBLx2uLhsVzr/X5beTqdyrvm79OLY1VZ7V+3pSZdfRWBuzZbAj3lc8lQMrHWVlWw9WTVsI7olRH51tQ9/wXlojGa8/iI1GqNNlNntoQU12ltnKa7kH42/pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JMFdyo+9; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Li0FElrJZa3rHo/i2B/Dk5qqHS612DN4KeaGAjOxEfXL4EQFaszWMCL63lkBUBVKPaVSdEs5iulGlePtOns99MwqwqwGKC3toi9w3iWTfKa60os/w9SEGlRe4YoeOkftVi53WQdLXYZTejDuUBPxZRdvPAy7yu3NZUbvDNEV7TnQp15/E4JEoKaOQb2r29PQ9veypUqMJI0+H7jS9ySUyQUFLmQ+pm5MWj0p5JrDmIpvynHrgDj/+kzVTnF15uU46DTDUXIRJNl7Ho+QK/wbxklQ+LaqJhIPTOqOKLxN/qTbwgLvj9G6RCffyQVsqkOcvWa8lE8/MLo2Xds3cXKhDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gieLlPGOkhLIjkgnaQkQJh+zfFWMo3vO4aZiso9jarE=;
 b=ttIlGhUpu/C5OPO0y7+ekZcZP/L7YFO51D6q5D4tWv/14wJJKV90II6bPn8hVp8IWMsIYV+hxx3uMv66HmDRrF5EzKaHACv3UqsZ+9CqpAqqB/JQ4IvaARHY5Juil/GazxLnuDjVtxeSvX1niTE1fUaRlMSJhHmueyv7NeeyikNqA2TVelLwxM+87uAFvLtMg4GHE6RURIobe3AEQjZ155kf+vk0rjqavnqEqxNkdzDdrOlIoya9/wCEkkteB4I73ZG3R7AYshquY4cMPrKrPdtRecZNJTccvVLCpZpQD6kOZyMUcTaZ/HZj9hcKMfvhSR+4G3KJc2LLUJ8QxGRSuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gieLlPGOkhLIjkgnaQkQJh+zfFWMo3vO4aZiso9jarE=;
 b=JMFdyo+9pi1/kqDTS4IYCeYrGa6Ly6f+PedZS1urQRUKj9kCMBqTV6Rx0EhB4OvWhS8Sy13edAOdke7J+VpncmqqJ16h1NVoUgrzrIC9yaxu5c447hVEfgRtcGUHPewCZJpDWfHZ8wsSOfF7IvjzDIPApNhMgsG0qlcW5o7nZjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB8180.namprd12.prod.outlook.com (2603:10b6:510:2b6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.19; Wed, 2 Jul 2025 17:51:39 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 17:51:38 +0000
Message-ID: <36d9e485-26db-4ceb-b57b-47483c3be7b6@amd.com>
Date: Wed, 2 Jul 2025 12:51:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/17] PCI/AER: Dequeue forwarded CXL error
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-7-terry.bowman@amd.com>
 <20250627120050.00001461@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250627120050.00001461@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0217.namprd04.prod.outlook.com
 (2603:10b6:806:127::12) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: e075d302-bbd3-4f88-9443-08ddb99117e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFNoYi8xNlRkN1VKcHZXUWUzaXJQbUpXMHprdmRWaTFTcFZrbGVsdjM5UDFs?=
 =?utf-8?B?dk9CYlEzMHJlamJCS0k3cTF0NzVMTGVIVEdCdENsWVJ4TFcybUdnWXk3L1BZ?=
 =?utf-8?B?dTdleFk4TUhDZUxCSlYyeDBkRXN3NkdnQVNlTlY5SzRGdWNUbjE1V1FaRmor?=
 =?utf-8?B?T2VDU0MxekxyMURMbnBxbzFHUURLUTI3RGR6THUyVFgwcXBQYkQ5Q01OVWpx?=
 =?utf-8?B?VUM0MUpHWGpNSU82bFBGdTVEQWQ3aWdIcXhVdlZBYVl6TlVhYUgyRGFsaTBR?=
 =?utf-8?B?S3lRaFM0bkV3SDRHN1E0Y0N4REJBTmlqaGNnUVBXWEdvUU43ekhxUW5QY1d1?=
 =?utf-8?B?U0txcEhDcEoyN1NyRElMUDUrdXREMW9Ib3BTM01vejdFZ1p1eFZIeUJvWm9D?=
 =?utf-8?B?OXNzNFZueTlpQVIrM3kzWVdMU01uY2RQb0E3b3gzNDArQ0FGd3NaT1RNUEwv?=
 =?utf-8?B?RFZZcFp3MUljT2RyTFY3MlVaaDVmRGhFOWlLazVWL1AzVGw1bUNxZTFOeThn?=
 =?utf-8?B?Sm9pRlZoRDNJU3VDckFObDRQMm8vZC9MYndNZjcwck1WUHdVOVlKa2ZWL2FF?=
 =?utf-8?B?b3dKOEFIbUhwK2JTSjZOTkc3a3JOWHRiaWIzdnpYUXFrWFM3UzZ2ZnRhVzg1?=
 =?utf-8?B?UlFuL1AzWVUxY2ZoYXN3Tk8zSFpVT3dVU2FWcWF0U2NqNnFXdWdGK1hBRnBR?=
 =?utf-8?B?UDRNRkNUdGtTOWo4bHJBYXlpc0JKbUVCTFRibnRGVVNES1Fpa0E3KzAxcG1R?=
 =?utf-8?B?L2xrdHRTUlVRT0JBNkZMQzBicUkzVzVOWXBjUEhJVjhITVl1NERDdWtoeFJK?=
 =?utf-8?B?RFdrN1NIWUJOWDJ5MXFEQmpaaE9wSHhQVlpCUkNHaVFhSHBLSlRtMjhFcFdm?=
 =?utf-8?B?SHI3d0lmUWVWbXlucVNDVEdLT0w1UjJ2QzVsTGJLU1pjOE1yYU9XRlZVdzFS?=
 =?utf-8?B?RXNBSFBZT1F5b1FjajVvRXFNVmp2alhwWC9jaGlEei9tWkM3MktjWVNrb0VF?=
 =?utf-8?B?SDNNMzdhNHE2cTdnSjZmaHc1OU5kbHIwYnU2VjB6UnhJckNjSmYrTllJNnc4?=
 =?utf-8?B?T3RLS29FRURlamJMOVFqQnNyM3FLRGhhS0QxSXZCb1lrYWJNbVhBMnROeXNa?=
 =?utf-8?B?eFc5anFPb2duYk1hR1c4N080OXdSSXArZGVSRXJFaHdnYkRuUzFYY25WQ3hR?=
 =?utf-8?B?TnhDZFlDR1FlcnBOcG4xVXAzaTNzTzFNK1hQdWxzajRjWHZySzdiSVN3ZGNW?=
 =?utf-8?B?Um1IaWFtSmNYT1ZFenZkZkVqWm5XRGhhZ3ZWdzRQcUJhZmNHMzlISFI1T1RT?=
 =?utf-8?B?cGFERkpBcWtZdjhGR0ZCdjZ0QjF2VVJVQ0dyV3ByNFFDeEVtd0MrcUJqbjNT?=
 =?utf-8?B?TzlpTEhYYjJLbmt2V0x4NUFNUDNpRTdibUJnOFZtZmNDRndocTdKbUIwWnVM?=
 =?utf-8?B?ODNkdU5QTHpQaEk1MDVNM25wVDBkaTludm1oYzVzLzZDQjFWWXB3QS85S1Ji?=
 =?utf-8?B?QXpXUmhibmF3aS9uajg0L0lhZHZsYTlxMHg2TXhrcUtnQjh6SmlYOERJWFZS?=
 =?utf-8?B?TnAyYVNSa3JxMW9ZTVN1bmc4NTJlRVRwNTFMcml1UE1SRDVjUnRnTWxueURq?=
 =?utf-8?B?UFEzU1dTK3Ewbk5vaUhSa0xQNTdFVlRxU3dNaUx0cEEwbkpXT29FMVpJbzFs?=
 =?utf-8?B?QWhvL0dmVU1QRHVGb28xQ3V4MDJSVk5vWjBxT3oxVE1tM2lHaDRYMlBaMVdP?=
 =?utf-8?B?UXkrZVBIekJwd0JGK2ROalZ6MEN6UzVwZjNHY2ZlOGFZcGdDckIvL3MyMW0z?=
 =?utf-8?B?U2czMEE2bE9YZjRvQ3V0N0hvS1NmYzVYOTViZktnM0FZbHVpOXJ0ZjJiUTRy?=
 =?utf-8?B?bzc3VEJPelZqRXEvNjhkUE41UzRmb2FVZnVaa2pDY0srZWF3c3gvZUVXZ2RI?=
 =?utf-8?Q?YWr6UaWOq/0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDE2RDlVTHBsWjRNd2k3U0ZBVGoyOU12UVh2WW1xdVVJYmdOSmwvU3JDY0d3?=
 =?utf-8?B?c0FJZWNHY3MwTmFjWGRYV3ZFVTVhRS9iQ1haSzFCVmhRNzV1bnRnK0JubEx6?=
 =?utf-8?B?VmRESFh4eEhlK1FsSXJNaHBieDRnWXg1R1JZa3dLQkJTOGlBUnhjRFlGK1Fq?=
 =?utf-8?B?RGpqTUFaQ1JWdzR4WHJoUjV0eDBJa2dTNVpwc1A3bXF0d0JPT0traHhhNUNv?=
 =?utf-8?B?cHRuSTZxeGtxbmxjd1BWRXN5OXluVnlIbVFMcTJWdzE1ZUJ1SlludVRhUmw0?=
 =?utf-8?B?aVkvalY3SExNZ0NWcUxNdVBvYmt0Ulord0tKNTBzZlZZSlUvZDlkVTRNaEZn?=
 =?utf-8?B?MTl2RkVMTGgwVmdHbU5KaVdkRDNJWXBoblpiOG0vYlBTZS84ak9JeXMydXY0?=
 =?utf-8?B?TlFTaHFzWnVCcUlsOWRzRWJVZWE1bGg5WEhBemdmaDQ5VFNGYVlqNUxFQU1h?=
 =?utf-8?B?SzdpSkU3NWxiSUx5dDZNbmRTL05jYXgvVmhFSFJneWlPQ1IrUE1PQ1pBVGxk?=
 =?utf-8?B?UTVOUm05Nk1tTjNSZjhPRUZyOGdhM3YramdFMVk2czRwMDlMMkNRTWIwMTls?=
 =?utf-8?B?b3JCbmt1RG5LajRKVVBBNFdSVmdZcGNadG9WTzZpYXhUOG9kZ2U1czdSUnZV?=
 =?utf-8?B?QVloeFdHUEhEMGNwdGJPZkJGbmFmcW9hN21nVndLTG8vWWd2aWEzNWM1UzJS?=
 =?utf-8?B?YXg4T3hHWnhNaFR1SUI4VEFUbTJnRk5jVmsrR3hqMDFvTDFmazB6T1o2NGo0?=
 =?utf-8?B?c1UzNm9pZTh6TCtEMS91L2FnMGZwcDZBakNuWjg2VC9KdmNPZTNLeDFjMHhJ?=
 =?utf-8?B?SnNQNEd2OFZSdWNzU1QrbUZYbzdkYWJ6dHBqTWxBWVpwSlVheTEraHJIT2tV?=
 =?utf-8?B?T0FHdTBWWEx6K2VtWmJWbUxSbmY4cVZGNUhuc0NQZERUS29lMXhHaXgzYVhC?=
 =?utf-8?B?bW1yMXpOSmVHSEY0WlFXSUF2UHh1YXloTFJzZUE0UjdXcHlxZjJLR3M5Q0NN?=
 =?utf-8?B?TFAyckIvUUV4QTNxcEZTcks1Tm1veWpxQzV2Z3IzVkQzT2d5MEJ6a0RCTWJw?=
 =?utf-8?B?dUsvRlBzcjJJNDRiejBVOHRoYWpmbnFBNWNwcHpPWFVvSnNibWd1NEZWdGt1?=
 =?utf-8?B?amQvN0Y0SHNtaUlqc0RVamlMZHZTeFhBci94V05qUExpdTZkdjdSRmR3TnVB?=
 =?utf-8?B?eVlXVS9jVEpsd0ZuSjFOd0RrTFJaYXlzcHV4SDRDd0xxSVZadHdPSW9pNnZG?=
 =?utf-8?B?V3JTM3JaL3VUeXJYeVRsTDUyWmxuc29aOWFaYVI4Wm1SNXh3UFRGb1dXSHha?=
 =?utf-8?B?RE9rMVFUOUo3OWJZQ0hHb202bXR5VmFuVWh3ZDJnRno5SFEvajJkNjg1aXBu?=
 =?utf-8?B?elV5MzkwOEl5ZVJ2TWdmUmtnOUJsNjVvczdESDVpVHlRcDlycEh4TEZvOE5M?=
 =?utf-8?B?RHhXNE9pK01wZHgxLzYzY1pjYW9FMDdjYVduQ1kzY0RXVlZmZDN2UzluN3hq?=
 =?utf-8?B?VGRmWG9Yd3NCanFqNmhLUTlPU05iWTNEUVVKcXZpa1RuWitESDJHSmdkY1h6?=
 =?utf-8?B?aE9wVmpTZURxdnZiNzJXNGRBQVRiTmx6YWl3QXNWcEZBUG00M1Q0TWE4Uis4?=
 =?utf-8?B?NFZMcjNIK1IzdjQ1a09jYU5GZEdzcHNGQ3BmdzR6bWg0b1JBSWV2MG9UODI5?=
 =?utf-8?B?c2VQVFgzN2pVTER5K3pFTHBzSWJwTVVwanNSZDBPa3lyU05tWXZETERkRzAy?=
 =?utf-8?B?ZHNXbENubHJlSkdLUEpORWthWkNacVQrbWJkQmNpNE4wVVZRS3FOK1EySURD?=
 =?utf-8?B?Tk1RcnB4UmI5UFB4T01jZ2twT0pFVVI4RmhacGovbzlyTFU1VVRpU0wrNDE4?=
 =?utf-8?B?Zi9HdlpqWjFHK1NMVmUvUUZIdkdGSTdxOGxOeG80YUplUlJYckhMdXNoZ2xI?=
 =?utf-8?B?Y3hqQkFHTlR1TmR5TE1YOXhvTHRNMUJuU09DZU9DN09lT3NGcHhjNWZwZ0hs?=
 =?utf-8?B?Ujc0NXRqdDRIOFFQcVg0ZUd5b1JGNzRZMEwxZG50Zk9uUDZmQ0MvTitiMHNH?=
 =?utf-8?B?dlc3TkhtTkMrbHJBRGFMUnhhZEhScUptQVp5MUF2Mml4YlVPc25PalNqMXNo?=
 =?utf-8?Q?Qrw3dA1oohlHQMwVy10cxZHtr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e075d302-bbd3-4f88-9443-08ddb99117e7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 17:51:38.7707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUSGoFbSyfFOASrYTi0iHeaRFim7vMyEEZ7u+4lVse8bEvti1Mc7mwJSoMu7I1GpP/LJ9CKxnkoKuzG8vJSnNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8180



On 6/27/2025 6:00 AM, Jonathan Cameron wrote:
> On Thu, 26 Jun 2025 17:42:41 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> The AER driver is now designed to forward CXL protocol errors to the CXL
>> driver. Update the CXL driver with functionality to dequeue the forwarded
>> CXL error from the kfifo. Also, update the CXL driver to begin the protocol
>> error handling processing using the work received from the FIFO.
>>
>> Introduce function cxl_proto_err_work_fn() to dequeue work forwarded by the
> After earlier update it already exists, you are just filling it in here.
> So reword this.
Ok.
>> AER service driver. This will begin the CXL protocol error processing with
>> a call to cxl_handle_proto_error().
>>
>> Update cxl/core/native_ras.c by adding cxl_rch_handle_error_iter() that was
>> previously in the AER driver. Add check that Endpoint is bound to a CXL
>> driver.
>>
>> Introduce logic to take the SBDF values from 'struct cxl_proto_error_info'
>> and use in discovering the erring PCI device. The call to pci_get_domain_bus_and_slot()
>> will return a reference counted 'struct pci_dev *'. This will serve as
>> reference count to prevent releasing the CXL Endpoint's mapped RAS while
>> handling the error. Use scope base __free() to put the reference count.
>> This will change when adding support for CXL port devices in the future.
>>
>> Implement cxl_handle_proto_error() to differentiate between Restricted CXL
>> Host (RCH) protocol errors and CXL virtual host (VH) protocol errors. RCH
>> errors will be processed with a call to walk the associated Root Complex
>> Event Collector's (RCEC) secondary bus looking for the Root Complex
>> Integrated Endpoint (RCiEP) to handle the RCH error. Export pcie_walk_rcec()
>> so the CXL driver can walk the RCEC's downstream bus, searching for the
>> RCiEP.
> I'd drop the RCiEP description beyond saying 'handle it as before'
> as I think there is no major change in this.
Ok.
>> VH correctable error (CE) processing will call the CXL CE handler. VH
>> uncorrectable errors (UCE) will call cxl_do_recovery(), implemented as a
>> stub for now and to be updated in future patch. Export pci_aer_clean_fatal_status()
>> and pci_clean_device_status() used to clean up AER status after handling.
>>
>> Maintain the locking logic found in the original AER driver. Replace the
>> existing device_lock() in cxl_rch_handle_error_iter() to use guard(device)
>> lock for maintainability.
> This change is fine, but it is an AND change in a patch doing quite a few other
> things.  So do it in a trivial precursor patch.  Look at the other things in this
> description and see if they can be factored out too so that the guts of this
> patch are much easier to spot.
>

I agree. I'll revisit to try and simplify the amount of changes in this patch.

>> CE errors did not include locking in previous driver
>> implementation. Leave the updated CE handling path as-is.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> A few comments inline.
>
> Jonathan
>
>> ---
>>  drivers/cxl/core/native_ras.c | 87 +++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxlpci.h          |  1 +
>>  drivers/cxl/pci.c             |  6 +++
>>  drivers/pci/pci.c             |  1 +
>>  drivers/pci/pci.h             |  7 ---
>>  drivers/pci/pcie/aer.c        |  1 +
>>  drivers/pci/pcie/cxl_aer.c    | 41 -----------------
>>  drivers/pci/pcie/rcec.c       |  1 +
>>  include/linux/aer.h           |  2 +
>>  include/linux/pci.h           | 10 ++++
>>  10 files changed, 109 insertions(+), 48 deletions(-)
>>
>> diff --git a/drivers/cxl/core/native_ras.c b/drivers/cxl/core/native_ras.c
>> index 011815ddaae3..5bd79d5019e7 100644
>> --- a/drivers/cxl/core/native_ras.c
>> +++ b/drivers/cxl/core/native_ras.c
>> @@ -6,9 +6,96 @@
>>  #include <cxl/event.h>
>>  #include <cxlmem.h>
>>  #include <core/core.h>
>> +#include <cxlpci.h>
>> +
>> +static void cxl_do_recovery(struct pci_dev *pdev)
>> +{
>> +}
>> +
>> +static bool is_cxl_rcd(struct pci_dev *pdev)
>> +{
>> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)
>> +		return false;
>> +
>> +	/*
>> +	 * The capability, status, and control fields in Device 0,
>> +	 * Function 0 DVSEC control the CXL functionality of the
>> +	 * entire device (CXL 3.2, 8.1.3).
>> +	 */
>> +	if (pdev->devfn != PCI_DEVFN(0, 0))
>> +		return false;
>> +
>> +	/*
>> +	 * CXL Memory Devices must have the 502h class code set (CXL
> Short wrap.
Ok.
>> +	 * 3.2, 8.1.12.1).
>> +	 */
>> +	if (FIELD_GET(PCI_CLASS_CODE_MASK, pdev->class) != PCI_CLASS_MEMORY_CXL)
>> +		return false;
>> +
>> +	return true;
>
> If this isn't going to get more complex
>
> 	return FIELD_GET(...)
Good idea. I overlooked this.

>> +}
>> +
>> +static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
>> +{
>> +	struct cxl_proto_error_info *err_info = data;
>> +
>> +	guard(device)(&pdev->dev);
>> +
>> +	if (!is_cxl_rcd(pdev) || !cxl_pci_drv_bound(pdev))
>> +		return 0;
>> +
>> +	if (err_info->severity == AER_CORRECTABLE)
>> +		cxl_cor_error_detected(pdev);
>> +	else
>> +		cxl_error_detected(pdev, pci_channel_io_frozen);
>> +
>> +	return 1;
>> +}
>> +
>> +static void cxl_handle_proto_error(struct cxl_proto_error_info *err_info)
>> +{
>> +	struct pci_dev *pdev __free(pci_dev_put) =
>> +		pci_get_domain_bus_and_slot(err_info->segment,
>> +					    err_info->bus,
>> +					    err_info->devfn);
>> +
>> +	if (!pdev) {
>> +		pr_err("Failed to find the CXL device (SBDF=%x:%x:%x:%x)\n",
>> +		       err_info->segment, err_info->bus, PCI_SLOT(err_info->devfn),
>> +		       PCI_FUNC(err_info->devfn));
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Internal errors of an RCEC indicate an AER error in an
>> +	 * RCH's downstream port. Check and handle them in the CXL.mem
>> +	 * device driver.
> I don't think the reference here to the CXL.mem driver is that helpful
> given the code is immediate above. Maybe move the comment?
>
Ok.

- Terry

>> +	 */
>> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
>> +		return pcie_walk_rcec(pdev, cxl_rch_handle_error_iter, err_info);
>> +
>> +	if (err_info->severity == AER_CORRECTABLE) {
>> +		int aer = pdev->aer_cap;
>> +
>> +		if (aer)
>> +			pci_clear_and_set_config_dword(pdev,
>> +						       aer + PCI_ERR_COR_STATUS,
>> +						       0, PCI_ERR_COR_INTERNAL);
>> +
>> +		cxl_cor_error_detected(pdev);
>> +
>> +		pcie_clear_device_status(pdev);
>> +	} else {
>> +		cxl_do_recovery(pdev);
>> +	}
>> +}
>


