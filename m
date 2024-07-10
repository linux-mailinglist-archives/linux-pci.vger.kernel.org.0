Return-Path: <linux-pci+bounces-10110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F98492DB3B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 23:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DF82817D1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 21:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D61512CD88;
	Wed, 10 Jul 2024 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aQQHZz90"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED6A3AC0C;
	Wed, 10 Jul 2024 21:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720648098; cv=fail; b=Z8mfCQjs+Ln67+noMvzJ/MnsVcCZr7WjQx5H3RFfxOFul0tb3y8qbh1/Vnxoa/v+x2cVSabMgP+a4dPJQr4AgmoqKTvplUjoV+Rh3bYwonsasVBTjGELEQ80XjgQmW/z07VCcMXK2reDZlOKcuO/MZtog1PfB5ouxVA0yqyWh3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720648098; c=relaxed/simple;
	bh=THHPy/NRU3Fio7MMKu3FYUoHX4+k/g+v8Bf/FQO/tDQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e1xTQrxhhOAYcns5ph9ZLhHSR62c9iiOksJpzvvAmM4N5lPgezz3Ll/IGGGj+xJe5uaW+LBmPI9n2OUlFuZPmaSi6tMBuPRDO3F1dPLzHgtTE/23/V/GkiflcrPvLe8xMg00PNynULYfjeVHvBmky4Zy5VDa3vUXF0X71Ei3j8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aQQHZz90; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1mPCyrtghsAU1THaOCkm2YXf6vrSM4237YMW+R0dkDFug6EYehC908OJfYDw7qQjNJDcg+IpIXhxEl7ZEDRr8Xk9mI4SyCcNVSocenTgxvxE7s2rozi7B16Xq0IjZushy+kb6sF2ky/NXS0WIGuNt+jOX58f6cuhu/eWpfPNpIeX1iUYsOBF7vYc1YN18jb5fdzx1tAPZfEH3aoXJWAz1xuPNcBGvuxiCBGZ9O8qj2fr6aT8fHfP8U493dr5uLETn5rAR4YVE6EM7UjeC9oI7t2Z+kW87g3Bl9rEIhSYNTYAtiuYh4pTN1ylonCvkLt+vu9FR47TEgsgY1o9zPSmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYpHhsJ6c532lI06ZMhzgbcIwlvFbNDleG5BJzFurQk=;
 b=eKzyEYRKWOMhQ11eLeLwO/oVBq05ec+o8Tq0IXbgufrx5bjWc2ni1DDA03tHDezAYzkKgkgKZUdoUUd5SCtB32ntPcdr+GV0l539Vnpi7RgTQB0zPxZIIwlmO/NjULEc3EVzQMD8BmVygYxJ4PkE4jL/XwiBQUU9iKvcV2NHSEegFbwgb7wcW4WxVNxBkummzmW7OPDNYOElcFlk5jEe343si9u7kmyvAtvZE7XZIaxSRg0wXa/9Tszpmu2P8qCqAkbSRZe4YKyapdvXHjuj1qAj8K0pQIQ4FxLnhgbeG9Tmv+UCR3gwzmvIgabqv2Kw96SE1CYlWKQP1q6lS6mmJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYpHhsJ6c532lI06ZMhzgbcIwlvFbNDleG5BJzFurQk=;
 b=aQQHZz90wIvqisC6kW312sPwznYsjzpP8eIN7euAaJW2vNPPk0R6Niw9PWRotKTz0bL5lVOvTm2JW7WBoaTq39dC8agAd9RseQEnZ1XrhU+d1d29ZjbsKPvaOJoZiwb0UUjI/gbuvwupOtFV7gY6WPuEHY0Zaod2Lu5OwOI7j2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH0PR12MB7887.namprd12.prod.outlook.com (2603:10b6:510:26d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.36; Wed, 10 Jul 2024 21:48:12 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%7]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 21:48:12 +0000
Message-ID: <8bf0d1c9-632e-458b-9b78-0faeea0472f8@amd.com>
Date: Wed, 10 Jul 2024 16:48:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/9] PCI/AER: Update AER driver to call root port and
 downstream port UCE handlers
Content-Language: en-US
To: nifan.cxl@gmail.com
Cc: Dan Williams <dan.j.williams@intel.com>, ira.weiny@intel.com,
 dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 ming4.li@intel.com, vishal.l.verma@intel.com, jim.harris@samsung.com,
 ilpo.jarvinen@linux.intel.com, ardb@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yazen.Ghannam@amd.com, Robert.Richter@amd.com,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-2-terry.bowman@amd.com>
 <6675d1cc5d08_57ac294d5@dwillia2-xfh.jf.intel.com.notmuch>
 <ecc5fbd0-52e1-443f-8e5a-2546328319b2@amd.com>
 <668ef3a2.050a0220.96a0c.4f5c@mx.google.com>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <668ef3a2.050a0220.96a0c.4f5c@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:806:a7::20) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH0PR12MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: 560662d6-c45e-44d2-5e8a-08dca129fedf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHZRcUtWODVyMXRuQW83ODQ5dmx5amxETVRIWEw4NlNwYWF6bFp5VDR6eHFW?=
 =?utf-8?B?RS9JZTR0MUpLVkdJdERramdEdlpLM1cwcjJmUmtQTlRVYWxtQ1hoeUMxZWRT?=
 =?utf-8?B?SjhKaHJWRXJhT3EvWEZCWFBkT3BLOGlzLzZNMHgzOTNTTG5xbzlVZk15aVZN?=
 =?utf-8?B?YkhKbG9NS1BncUkxS0pSdWFKRGQvQVJ4ZUJJMm8yQkxqUFV5Umc3bEQxalhZ?=
 =?utf-8?B?VUZuY09RMU1TVW9sSXBpL3ZCdmx6anFtVjNjdGlNVURqc05lNTAyT1ZUMUdm?=
 =?utf-8?B?cnFmTXlNbEVDS3hqVWNzc1ZsVDhxMUk3Vzg2UnR6ZFp4cU5IeURBZU5DY1FN?=
 =?utf-8?B?M0lWZy9sWW1pY0dTYWQyZzhnb3BQWkU5dDhSTTZKTm1kUXNUMWhVYWtkUlpk?=
 =?utf-8?B?ajRJZk14M3NBWVFhNzNVeHpxODkwd2FsQXQ4ajFaakNkWXV6d1pWWUN3OUM3?=
 =?utf-8?B?MUdwNGlXK1BaUnROd1p2Z0xCYkR6VmpHSVU4bEVqdjhDdzJQRTQrZk1kWkxJ?=
 =?utf-8?B?NmNVRnhSQWR0ZlZrR1BuMVczZEVTd1FiMUcwMEcvSlFtT0NXcHV0bjAwTnpj?=
 =?utf-8?B?eEw3M3Y1VHVCc2lqQVB4MWxxM3lQL3dSclVDU0lGNXFITFhVRzFwUVBSQmJm?=
 =?utf-8?B?K2pmMC9KR3R4eTYydVpMUU9yZUdHalh5TzFWcHhDVG9yemNxVktGZUtscU5T?=
 =?utf-8?B?bnZ5VURIdEJVSkExcjA3YmNPNzllT08vVnFRMWRLZlQrQm85MmxLVG9hOCs3?=
 =?utf-8?B?OGg0TFhVcW5WbWlIL1lvY2VWMk13UzBEd3dFTG5IODAzRjljck1iZjViaUds?=
 =?utf-8?B?MCtMQUNwTUltUDlGMHU1NS9zZ0F4T2dCd1ltR0xIa3IzMHU5TXRxbWVILy9K?=
 =?utf-8?B?bStHK0ErTDBENnZQT2U2RWpMSXAzK3p0UkQ5MGJBcWZwRWlkRGRnTTI3WlpU?=
 =?utf-8?B?V1FBbTJiNmtJcUZaM2ZBZ1kwZnBXRW1MSDdLc3RNVjJHOUpxSm1kdFUrTTlZ?=
 =?utf-8?B?QnBvaXMxRlpYSS9UVjVRWUpIbERCVlQ4c1o4a3JZM1N6TEMycWg1WXlzU1BI?=
 =?utf-8?B?MVhjeWU1YTVoWlpHUjJzcWJDQkhZRWRKZ2t0aXk3dHNoSWdsakhtcVQzSWJw?=
 =?utf-8?B?bWlBWlMzR3RiUFJVbHo1bTFBWFVnVkV3NUQ4TlBacFJoWkNmaytLaVVxaTVT?=
 =?utf-8?B?MnJLMXB6WHBYZEJPMnhJeUxoWmpwbmtrUndEdDF6czhRVHRlS1J1Z1gxMFV1?=
 =?utf-8?B?NTFtOFcrOG9wN2J3dnNJVElMUzVxM1ZzZzVlbFVkL01xUkFmNTVpdzBIZWhN?=
 =?utf-8?B?QWRXdmE4TUZDM2M3YkJhL2c0RmNtVHUzZ0p1TTZrM25mRlRnNkNoZE83S0Yw?=
 =?utf-8?B?cC9HbWpOWVBMQjF4ekpuY1NCTFZNSTEvYXRPa1RkdC9nZ3hWaFFmS0R4d2xF?=
 =?utf-8?B?eDhzQUVRR0NVc3JaUkZXdEUrTFIwUlNnRU1uNjFJT3FiVThqbitoZnhYYVVL?=
 =?utf-8?B?dEZteURVYzhHb3JHWnV3QnA5L05KNmJHQ3hoZkgyeUt6bnNxRlBzR0Vkdjhw?=
 =?utf-8?B?RjM0NlF5TXZYaFNxWWFENG0yMFhuWXA3NXlMS1pIQUNPRCttWk5qSHpxMFk5?=
 =?utf-8?B?aVNLaVpYS0dJWTRCZEhZZjMzRjB2bVc4OXl0YytIbWVNU0ZNdFljNFh4VWRu?=
 =?utf-8?B?dmRtdTRQeEtaVC81YUxkUDU5aEZadnR3dGlDMGlyY3NYOCtHdXBTYStPM0lD?=
 =?utf-8?Q?Az3lPI3cPVnGzHMjs0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTdQZVJNbjhZem9PYmVyRlRMdXM2QVp6aTZIdmN4OWoyd3RqY2xNbkJpWXhF?=
 =?utf-8?B?SDIrS25LUkFtR0JZd3pBMHNuTEhKMi9QbDBNbzdGcE5BamJkdU1zbnRqcVBn?=
 =?utf-8?B?SUdjT1V6OVdSWnl3TzMrRE04Q3grUU54RkNFdXZwa3RoeDFpbmpaYUNCVHlU?=
 =?utf-8?B?ZzhhUkdhWWpTV2xMb0dacWdKWmRzN3lFSVg0S0dEY2RtdVZXbXBaUDZTUUx3?=
 =?utf-8?B?WUJaeGJyUm8zeDBOTDV3Y28vUUZmM3JCUHE5elJyRlVNMFZkMWVSdlRiQ1Bj?=
 =?utf-8?B?MGtIU2VSK1k1aS9BckpPazNDQ3RVcFNoTWxybXBZMU1Pd2NtUUtCRlhLZlZH?=
 =?utf-8?B?THFHZDVuM0xMNVlOdzBrNHZONlN5Y2tOYVh3QWQweTdDZHU0UDFONWUrZzJp?=
 =?utf-8?B?R0pmWU5RU2VCNy9ScTB4c0RMTm1lSG1YZi8rMksvcFJVRkF1N1cvRDdWWHI3?=
 =?utf-8?B?SUNmeUk1OWt0ZFR6OStpa0hEbERLWjR0Vnk4N3R3NmlYYkFFNmhOajF6VHNR?=
 =?utf-8?B?TWFHV3lnMHBaWGNLRUdBcmhMWVBZT0w1UzBLb1RCVnVXVjJpR3ZjRXhYY3NV?=
 =?utf-8?B?dE0wTUk0UHBuaGtzdGE4Tk0ybW9qL1paK1R3MWIxQUFvb21FK1NRVHF4cU9Q?=
 =?utf-8?B?aVpRdDdQK0ZQdEtUSmorck1ZVVVIek1PdHVRVXlBMTVkYWEwc2QrZTFpa1lU?=
 =?utf-8?B?NzFXTlpjV1VDOURlSjZVTnNkSjExV1YwYWx5cEpkb2s0U2d2NnZ3U2EzYWYy?=
 =?utf-8?B?clZoUFpQY1lNcTdrdzVpRGpMNExYNFhPMGI4YlpHSFpIRlJkSGZkV2ttM2tC?=
 =?utf-8?B?VkljQlViUEFtRHhReDFid2tIM21WcTQ2bGpkbVNwZjVxWFM1UkdNR0JST0hS?=
 =?utf-8?B?M0RURDY2WkY2MjdtY1NteW5Sb0tORkNCVTg0LzIxN24valRET21QM0d3OTk1?=
 =?utf-8?B?M0szK1dCNzBDMUhNTmFmWlROM29SRDdNV2NIZytvdHliMUdQMjdZVTN4WFgw?=
 =?utf-8?B?a2FyZ0twcnJ2dGZzOUhHa3FCVFRjSG1NdGc3ZHloNzFJTjdQQkFDN0RhQ0tG?=
 =?utf-8?B?aUwxZklOczMvaEpGcDhkNGYrWkxROUJDbXVpMndCQjNWajUwOU05VzgvWVdu?=
 =?utf-8?B?dm1CWkNRaVB2SlVsVTRjdGp4VWNQM0xja05ZUU5VV3pjOTloRGdrOGg3cUVz?=
 =?utf-8?B?SkU1ajI4OEtMY0xEb1ZxTnlDek03akFHWVJJZUg1NGxZelA0WEhwdVRlSVFB?=
 =?utf-8?B?VGVEclRjZUM0eXViYjVHcDFKMTN1dVlHUUhpdDB3MldndVJaVmZOenMwNnMw?=
 =?utf-8?B?VnZVWGlUaHNZTEtXcTBqN2lqcVhuc0FYaXh0c21mRDlQbkpRSlg4N1hmVFky?=
 =?utf-8?B?NEpQTEVod1MzOGRrUUJjV2Y5L21pN2xMRjJ2dFZsckxhQ1BnYWRUWGI2SHNU?=
 =?utf-8?B?T3VqYnMwN3U1dzI5Mi9RMGdCZzIvVnJYb2JRb0oyMFg2YkpncEFLb3VoT3hm?=
 =?utf-8?B?ZXR1anZkV1ZmS2s3ZC91U0JMclBnMmpqUytFVHBpYWtzZU42Y1I1ZzJFK0d3?=
 =?utf-8?B?L2V3VGJnRFdDakViMzlsRzFabER5MWdxTFlRNmx0bkN1TmgrNmtpdjBEbE5j?=
 =?utf-8?B?Z3JBaHlRbnY2UDU2NCsvYVE5Y3ByaWt5S20yZGlvWGM1T2syWStId0Exc0hh?=
 =?utf-8?B?NWVKRkhKZE4zTFJwTWlIU3pyMW12YTNRa3Bsejh2REl5VVdTNnBQcVJ5TUoy?=
 =?utf-8?B?TDl5RnVSNGRMY24yVUI5YXFnK2ZidFJXY3ZNZmFrZHpBenVqbzB5bXA2TURr?=
 =?utf-8?B?bjJveG9nL3ZOK3dTclc0Q1Q3S1dTemlSRTJ6WTlyQS90ZUpPOXhnSC9EdGZK?=
 =?utf-8?B?VEhEZU5JNkhuODhxK3dybERYSjNRdjE4b1lOMnZMd0x5N1M2dUpDNC9YK2dx?=
 =?utf-8?B?SVRmaXVSakdnK1FlazBRSE9sa09RMUtyRnpyOTQyRlpmcFNaMkwyMHlGaFVy?=
 =?utf-8?B?ZFN4Uk5VNkE0WWQwbjY0OSs0MGsrbStFK0RZY0xXNVlMY0Z0MjNYb0YxOUJU?=
 =?utf-8?B?T3QrR3hzUC9pQnpmZkpxY2FlSWt4MkpWUkF2OEpkcExkUjNaT01UZjluTFkx?=
 =?utf-8?Q?Ka8/NX99kpwwDlUQxZ00Mxs9Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560662d6-c45e-44d2-5e8a-08dca129fedf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 21:48:12.2649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkxbhgmvW7MzIdoB3kZabfn7meH4Sf7HLwLikVcuSQ4M/YWw9NigyAJbkx32nXaN7PVoV8ptLg8sGgKDSPtZOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7887

Hi Fan,

On 7/10/24 15:48, nifan.cxl@gmail.com wrote:
> On Mon, Jun 24, 2024 at 12:56:29PM -0500, Terry Bowman wrote:
>> Hi Dan,
>>
>> I added a response below.
>>
>> On 6/21/24 14:17, Dan Williams wrote:
>>> Terry Bowman wrote:
>>>> The AER service driver does not currently call a handler for AER
>>>> uncorrectable errors (UCE) detected in root ports or downstream
>>>> ports. This is not needed in most cases because common PCIe port
>>>> functionality is handled by portdrv service drivers.
>>>>
>>>> CXL root ports include CXL specific RAS registers that need logging
>>>> before starting do_recovery() in the UCE case.
>>>>
>>>> Update the AER service driver to call the UCE handler for root ports
>>>> and downstream ports. These PCIe port devices are bound to the portdrv
>>>> driver that includes a CE and UCE handler to be called.
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>> Cc: linux-pci@vger.kernel.org
>>>> ---
>>>>  drivers/pci/pcie/err.c | 20 ++++++++++++++++++++
>>>>  1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>>>> index 705893b5f7b0..a4db474b2be5 100644
>>>> --- a/drivers/pci/pcie/err.c
>>>> +++ b/drivers/pci/pcie/err.c
>>>> @@ -203,6 +203,26 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>>>  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>>>>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>>>>  
>>>> +	/*
>>>> +	 * PCIe ports may include functionality beyond the standard
>>>> +	 * extended port capabilities. This may present a need to log and
>>>> +	 * handle errors not addressed in this driver. Examples are CXL
>>>> +	 * root ports and CXL downstream switch ports using AER UIE to
>>>> +	 * indicate CXL UCE RAS protocol errors.
>>>> +	 */
>>>> +	if (type == PCI_EXP_TYPE_ROOT_PORT ||
>>>> +	    type == PCI_EXP_TYPE_DOWNSTREAM) {
>>>> +		struct pci_driver *pdrv = dev->driver;
>>>> +
>>>> +		if (pdrv && pdrv->err_handler &&
>>>> +		    pdrv->err_handler->error_detected) {
>>>> +			const struct pci_error_handlers *err_handler;
>>>> +
>>>> +			err_handler = pdrv->err_handler;
>>>> +			status = err_handler->error_detected(dev, state);
>>>> +		}
>>>> +	}
>>>> +
>>>
>>> Would not a more appropriate place for this be pci_walk_bridge() where
>>> the ->subordinate == NULL and these type-check cases are unified?
>>
>> It does. I can take a look at moving that.
> 
> Has that already been handled in pci_walk_bridge?
> 
> The function pci_walk_bridge() will call report_error_detected, where
> the err handler will be called. 
> https://elixir.bootlin.com/linux/v6.10-rc6/source/drivers/pci/pcie/err.c#L80
> 
> Fan
> 

You would think so but the UCE handler was not called in my testing for the PCIe 
ports (RP,USP,DSP). The pci_walk_bridge() function has 2 cases:
- If there is a subordinate/secondary bus then the callback is called for
those downstream devices but not the port itself.
- If there is no subordinate/secondary bus then the callback is invoked for the 
port itself.

The function header comment may explain it better:
/**                                                                                                                                                                                                                
 * pci_walk_bridge - walk bridges potentially AER affected                                                                                                                                                         
 * @bridge:     bridge which may be a Port, an RCEC, or an RCiEP                                                                                                                                                   
 * @cb:         callback to be called for each device found                                                                                                                                                        
 * @userdata:   arbitrary pointer to be passed to callback                                                                                                                                                         
 *                                                             
 * If the device provided is a bridge, walk the subordinate bus, including                                                                                                                                         
 * any bridged devices on buses under this bus.  Call the provided callback                                                                                                                                        
 * on each device found.                                                                                                                                                                                           
 *                                                                                                                                                                                                                 
 * If the device provided has no subordinate bus, e.g., an RCEC or RCiEP,                                                                                                                                          
 * call the callback on the device itself. 
 */

Regards,
Terry

>>
>> Regards,
>> Terry

