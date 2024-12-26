Return-Path: <linux-pci+bounces-19062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C4D9FCC17
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2024 18:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF051882B70
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2024 17:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEB084D0F;
	Thu, 26 Dec 2024 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vDpOJS5j"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D763242AAB;
	Thu, 26 Dec 2024 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735232477; cv=fail; b=Azx/Ss4wDztzE+B7Lm0N5e3UopAKqomLYr6DrWweunDkSgFBRWVLJfEx9T4AkOF7muqhorWhHT64ir/qS/cVCle9vyq9qUU0nY3Vx9+NTkhJlPd5NS7qxJsRUJ4NYPD5YqJyPLoOfen7Bh+fNxPYB5LmlvOPx8pROdcjYMv2sGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735232477; c=relaxed/simple;
	bh=REywnVAezDu1rUP4+rd1Gjc+IZwI4hu8RyhkFHLrDV8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QHRy9mLlp+NwwAqqhR5l/PSb1+bZD5QX1T/mw8E7AlS5qCmk51norw84w/KhadDwACnCbpBYbdkCZjeEQVYLplVtYz3xDT14WRAnOTMmc5w9rAlh7b5mjHxYazItei6tqXnNQaL/TE2XRGf+SJ2IYgpIK6dC/rOy7EeisJx3P0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vDpOJS5j; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pu76hdbGXx4EYIiFePUhgKNQ3I+yz40OdFBuSmi+ARZSVXhTKRRMBPP/oQTa7dTdOdj0ye/aCjOu8pJzYkOfUL1quPiGfyfPb3qVyuDMD3F/CS/Z9fS67Axu6nhjgJvBefCnCN2QCOtz7okNywsMfM32bXCQd91dxQSR9smLakB6EjalRbq16dpeucqZGZbeqg43nZgC+ZTR0c8sJffQvT9GRQK6+SlSNHAkDjGvgSXrdEg7JvVFPMW7D84p7MWGeCpzjGjDogIPi89VhYFl9cKVNsRjvxN7r9loi8CXaD41Ajj5fwjFpitvcUHB2JNHiCm3mVUnKDagTkZq65bRTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/APJtDwPoVY769TMdKk2ijzaHhKYd5/MpYcD9tabJl8=;
 b=RQNqoQ5tsS9tI9wZnKfoPdsDg5xRVFAZ+ZWwHmlWwPsnP/sGncC2yBllT14B3zwWZyUhuGIuP7OmO6O1JxfZjRo7jI+JmmM0GoHiS6gIBmIhYqIZfGVI12XWimO/56m5Uvvj5S3IM4WuCFCLCTd8YnjqAeBXplu7DV/BgKbVjbvZIX7inE6JOG1jZw66MuJuUAmtTAbwgFM3f+Cp894kF+p6+2XVsrRR8p/p1gOA0c0oC0OLn0BLc0E90Lztw1CWvwNLfS3VfBNfyD05Vr6I3fbzi6qKP1uJrtZuvWgLvsEBvFS9kUzbLKje23oLiE6UTI3O1OY9jzS+N5jXXgbavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/APJtDwPoVY769TMdKk2ijzaHhKYd5/MpYcD9tabJl8=;
 b=vDpOJS5jBBPOTaeuhqrdcIen9bbuk0mkmGMaxSfhovL9B6LmVsXO2IVa0xQO/XBP/NV8aYnWNepbCDu9LRYsZ4mkF4igw/bx03oh/ARgkVpTihoQkLaVG9M86H0dedsc91M6UMaLW56Sw0S0HW2JgoUl8oCLTJrNl4CaMiI6q80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.14; Thu, 26 Dec 2024 17:01:08 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8293.000; Thu, 26 Dec 2024
 17:01:08 +0000
Message-ID: <23cafcfc-428b-41ac-83b6-9208b4030b2d@amd.com>
Date: Thu, 26 Dec 2024 11:01:05 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] cxl/pci: Add trace logging for CXL PCIe Port RAS
 errors
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 PradeepVineshReddy.Kodamati@amd.com, Li Ming <ming.li@zohomail.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
 <20241211234002.3728674-14-terry.bowman@amd.com>
 <20241224184605.00001e5f@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20241224184605.00001e5f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0113.namprd04.prod.outlook.com
 (2603:10b6:806:122::28) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ0PR12MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a5ebe62-6022-4e65-cbd1-08dd25cee45d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmhsR3FlZXlCVWFQbERFdWRqTmQ5WlhtMUlkTnF6VDZ3dW53dzFnWXhLMDlo?=
 =?utf-8?B?ZHFIcGZyV1ZMUmRnVFIxMkhBZHRyN2RlcGUrK1NHSXB5MjZ4ZnZSMEVkWERL?=
 =?utf-8?B?VVYvU3lYUTgxZ2Jja1BZaWdaYWJ1UEttemhJMzFiWHIraVZaUTkxTWxzM1ZI?=
 =?utf-8?B?djFUQ2hyMGJNU2JTczdLUUltbkNrdWhmMUU4V3czeDFqUXZQbkpjdkc3VFZt?=
 =?utf-8?B?Wm5GMWpldEtzeGdJR1E3MksrZjlDa0s5aFZGdVhCMzNOekpEYW9hancza1lw?=
 =?utf-8?B?bnNSaDRPS1B1NnNheGpyOWRZSEpMa3NUQTJVWXN2c1BlVWRScFBPZ3hqQmIy?=
 =?utf-8?B?R0EvU0ZqOCtFcytPVnp3VFp1NTc3OUpSUVhOOER4VE5vQUxmSVlqYmlUaXFQ?=
 =?utf-8?B?UHJ4dXk5aHV0WU0zYlNBS2IzUVBLcDM1TTlhM2plTXdKWWljYWdKdE55cjFY?=
 =?utf-8?B?M2d4RmlhUE5odWczakFWODVQdUYzYjlhU1dNWTRjWnZBR04zd0tOUFFCNkZm?=
 =?utf-8?B?dXdtZUg0TE5kZ25LNmFnYks4S1ZvYTRNb3lwdWpoTU12dDVOSFNGMlZ4MUdO?=
 =?utf-8?B?eFltTTNQK0t0RC9rT2VIY3hGTjYxUG04cVh6NytGMVlOQzhKajI1bHRNcktz?=
 =?utf-8?B?WHBZamVsalc2bmxIaFVBTlJoaTdSeGtsK3JXNzVqUEg3QlYzalBjVFZaNm9N?=
 =?utf-8?B?MUJZMHZudnpMZ1RYcldIT0tCMkZFM2hlY0xaUXJLejRtUVFJZmV2ck5xRG12?=
 =?utf-8?B?QXBrYkZtNStvZStGNTBaL2RPeGFpdmRuUUk2OU51MGo5aGZEYU5yQW5xd1hW?=
 =?utf-8?B?cmlqbzdJUmpLK3BsQTlZSksrS2kzWStVZmpjYlE5RVJ1S0kzSk5EVDM0L3Mx?=
 =?utf-8?B?Z2diT1dldWVrck0wQkNXcVlCNmdsWmZvNmgxeFlJc1BidTFVVlY4NktGSU8r?=
 =?utf-8?B?MTJsdEtGMDlRaE1BWlFjK3Y5V3VXK1ZzbHdyajE2bUhIdHI5NlFGZG16a1gz?=
 =?utf-8?B?ZzNCMkxreWMxRkxxR2ZEV0pDZlgvVUJPbUJYQmxrNUdwZW5BUGJZOENuZnhD?=
 =?utf-8?B?eGlaNEMxQVA0TWFENGIySnF5L01DMnZrWFozUHR0MWc3N0pmVk5mUThtSGdh?=
 =?utf-8?B?Y2FPSW9UYW5sQWZsb1pCUTQxODBkcnZON3dkdVQxM0JaeHV3TXFrWHBYSWo2?=
 =?utf-8?B?dWM0cmVBMVFXR25rQmxWM0VaeHJObG5USWNtZGE3WXpaMjY5R2tIQWNjM3NE?=
 =?utf-8?B?N25IMHdpOEI0czlKY3NUSlE3ODh3WjFKZFRtcnc4S25pSk9kc3FUWFZyRUs2?=
 =?utf-8?B?WDlveHNFWjlaMkM2YklBcGpMNERyVDZlQ1p1cTM4dThweFJYay9ZNHpqMTZP?=
 =?utf-8?B?cmtmTnEwU2RLdGNVU0NpRTZOaEhLK2dlOEI2MS9TdWo5OUVydlM5QkU2ZG05?=
 =?utf-8?B?by9ocjJROHIxTTRGU2xCZzh1aHV0di9mUzkwMGNSSjc2UUpiTFpPM3VCU24x?=
 =?utf-8?B?NHB5TDVMdVBkcmtxWFFSWEZoQVZtNjc1bm9BRlI4Vk0yL2FYcU8vQmV0MmNp?=
 =?utf-8?B?VFdXbVk3R2M1OU5JTmR1NThwc0NXVGg3ZWZNTUJhdnBvbDNJOU8vQytSRjZL?=
 =?utf-8?B?OW9qZElwUnhCcXNkRmtOeEdCN2Y0S0swY2F3eUttOEdlL3pzeFk5eThpb01X?=
 =?utf-8?B?bGdZbGRHVkh1c29takl3UzlVb2YyYy92MVVnVkdTU0IvZUtlRE93Zlg5MTFK?=
 =?utf-8?B?NGNldSt1Q1hodFNZTkJsUnYyN1hNOEdFNVg0ZFBIOXV1NEVzaTB0eE5iN1ZS?=
 =?utf-8?B?bDR6WklOWEk2SDdOUWdWWjRlOSt2RmVIWkFRQW5OSHhZYW9ITlI3NDRzbHZv?=
 =?utf-8?Q?Msokb2NavPAIM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXhzem5lNjhvbkJVbXBOaWs1Q2huRmJOd3NEZ3N6Vmx4NHBWWW9LYmM5OXpB?=
 =?utf-8?B?azVYcUlqMjY3TGY5RzVrQWRzdzBibzZPcUgvY0RRNjZHYk1VRjNlWWUwOXRF?=
 =?utf-8?B?bW5YZW1YZGxtTXNVczdMalZ6ZVZrcXhLOWF0Z1cxdEtranFlS1FXOE9DSGR0?=
 =?utf-8?B?NmdhVHFTYzE2RkV5Y0NBWVM1NFY1MnM5M29aZUtIS3E5eS95K1o4V2tkR0dz?=
 =?utf-8?B?VnQ3d3R3eTdUNW0zelVlaXo0eGhsNXB2NHd0V25jY2J2cFFqcUFXQzU5UDNW?=
 =?utf-8?B?MUQvcThIakNoenFXV0grc2VBczFncE15cko2NkhqTkdzNjdhNTROTThxT3h5?=
 =?utf-8?B?djFJaW5jWnQ5M2xxOXBYdUNUT1JvTEJtMGpSMjFDUThWeFp4U24yRG5HdDlv?=
 =?utf-8?B?dGNPU3VoZlJEL0NabjNmMUcrcXdmZk5DTUVSdGJLQk1MK2VZZ1U3ckx0Rmlw?=
 =?utf-8?B?b0xWY2hSNUxzMVhoVGxqVUJBZW9RN202QmJxMUtXU0VuajBZd3RqRTA0cWx0?=
 =?utf-8?B?Rll2UzQvbnBBbXlJbTR5c005MW9mSWtPQy9XYVd0Smcrci9LSkp6eVNiOVBT?=
 =?utf-8?B?R2ZVRmE3c0EzeThyYktDSG41TzhXNlpPcncwZkN5ellyckRFNk1jNldvWnZ3?=
 =?utf-8?B?VmgvYmI0a0UyS2EwOUl3K3pyNFVvcDhXTnlsN0dvMDhRbjcwUVJ6YkhtT0pw?=
 =?utf-8?B?TVJqZVNkL1RSRjkzaEpMMHl6bzFTdndYZVRTSHg3SDlMbnowMThPQ1I1MlZq?=
 =?utf-8?B?dXZVUUR0bHZkaVJrT040dCtJRzEzdTFzV2xITFl3cXdzekZFS0F0MU9RQzBj?=
 =?utf-8?B?VldlMDE5TEFMWThaTitGL09DNWxLNjFrRzg5Y2dRUE1UUHVJLzBCNStDdlNQ?=
 =?utf-8?B?WTZLUkVDa2crOVhwQzZWWGVsYWlrdWN2ZW1TNFRCajBGWmovU2htSjVITitw?=
 =?utf-8?B?YWcwanQzMHRweW5XdTFCRk5UamUrZzM0bXM0Q0ZlN29EKzZxZU5BNDdUOEhS?=
 =?utf-8?B?NmkwenpJK09mRGI5S0p4YWhFM0cyZXBIUXRDTU9FcnRVMHRkUDR3SUtBa2hJ?=
 =?utf-8?B?MjYyK3RxazRsdEl0MXoybXEydExLZHVGQTJQMElCT2VUM2NiRTFqTG9KM1dD?=
 =?utf-8?B?TFpGK0JqK0FmMG9CclFMdi9XZE1LSU1OMzJMSkhZS3JpZ3lkQ0VDeW9mQ08v?=
 =?utf-8?B?QUwrMk5MQ3VSb0tTVmVwNGorUHZKKzFNU2M3clhkNVRvc1E0cFRDMUVSeE4r?=
 =?utf-8?B?QmxLTXp0QWpSL1IwbmNuM3hpTnFMY1YxV1o4WnFqNU1pc2JDdmxvZUxBcXdp?=
 =?utf-8?B?K2diN3dRWVczZCs5cWpuUFp4V2N0ZzVBZ2wzU1l3MWNFM1FRcXhzVm1zRk10?=
 =?utf-8?B?QXprYVBIdWdCcWRwNVZVMFYyYzExWXo5b3RnZlpZaUgyUFZpdVh5R1NWaURY?=
 =?utf-8?B?ekhiVHc1K1M1cFZqdUk2ZFBya1RUN3J2WFB4SmMydk1SamZTbXFRZHNvZzVQ?=
 =?utf-8?B?d3VFQ2Y1ZmYzdVcyaVlVT2ZVeTNwUTk3aVNLemtiSjhMYS9VTVZyT0pIdVBp?=
 =?utf-8?B?U0JaVS9HalFTenh0dXBoNFRrcjlGVXlMNjdWMFNad0prSkpIM1NaZkxwYVZr?=
 =?utf-8?B?aWNyaWIveVN1dlMyaWsrbUlBanF3VDJPMFNjQVpDd1FRc3BNT1RLSytVQ2RQ?=
 =?utf-8?B?Z0VScndGeVU1Wm81S2p1MGhJSTdCWm56WFRhVkluS0hsTTFiaWxWUjhUOGZ6?=
 =?utf-8?B?QVFsQndQMEx2K2lzQ0hPK1JCK3lLclM5VGVWVGo5d2diNkpuanduSzl0OTdT?=
 =?utf-8?B?RVliWVlsS2xVaHZITE1rSC83ME16dzZUTkE5eWUxRTdMdEVtV2MzcFc5eEc4?=
 =?utf-8?B?ZnkySnMrMzlSYWRmVWkxNzNUNXNqV05XdlM2MW5zQ0s4UnZNRi9ZVE9IL2t3?=
 =?utf-8?B?REZqZGJ1TVQxcWR3dlR3QTRBYUt2aDh4OGY0OXpYZGZybHJZdkFPSjRsOCt2?=
 =?utf-8?B?OFZXZTZzVVFtazJ3ZU9BeFNOUElTZmtIN0VhN0FsWE9ubGN3eWtZOHlVSEpN?=
 =?utf-8?B?Z0Z4eFc4UHFOUmN1NUVTTk5zZFJVcSt1YUdaZHkzRml0Q2pqV21CZ1dIeXZP?=
 =?utf-8?Q?qO1AE+yEKBXHMUoBtU0nlclOj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5ebe62-6022-4e65-cbd1-08dd25cee45d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2024 17:01:08.3101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ld4ZD0sZeKxtKRwNe4rZdXau+oC30eMYk/bFsfMnRr5R9qk/ZVm6nCf8fHwJDSocyYjImj5IjF822bBVD9QEYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6733




On 12/24/2024 12:46 PM, Jonathan Cameron wrote:
> On Wed, 11 Dec 2024 17:40:00 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> The CXL drivers use kernel trace functions for logging endpoint and RCH
>> Downstream Port RAS errors. Similar functionality is required for CXL Root
>> Ports, CXL Downstream Switch Ports, and CXL Upstream Switch Ports.
>>
>> Introduce trace logging functions for both RAS correctable and
>> uncorrectable errors specific to CXL PCIe Ports. Additionally, update
>> the PCIe Port error handlers to invoke these new trace functions.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Trivial comment inline.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Thank you Jonathan.
>> ---
>>  drivers/cxl/core/pci.c   | 16 ++++++++++----
>>  drivers/cxl/core/trace.h | 47 ++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 59 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 52afaedf5171..3294ad5ff28f 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -661,10 +661,14 @@ static void __cxl_handle_cor_ras(struct device *dev,
>>  
>>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>>  	status = readl(addr);
>> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
>> +		return;
> I'd put a  blank line here.
Sure, I will add the blank line.

Regards,
Terry

>> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> +
>> +	if (is_cxl_memdev(dev))
>>  		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
>> -	}
>> +	else
>> +		trace_cxl_port_aer_correctable_error(dev, status);
>>  }
>>  
>>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
>> @@ -720,7 +724,11 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>>  	}
>>  
>>  	header_log_copy(ras_base, hl);
>> -	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
>> +	if (is_cxl_memdev(dev))
>> +		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
>> +	else
>> +		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
>> +
>>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>>  
>>  	return true;
>


