Return-Path: <linux-pci+bounces-15868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A9A9BA500
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 10:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D911C2040F
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 09:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13490142633;
	Sun,  3 Nov 2024 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dOzJp+mw"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9C58614E;
	Sun,  3 Nov 2024 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730627408; cv=fail; b=N0Q1TH46vDsg+6BX6R1Pk9iN24nDc8ASv2gL0RtZ0OGBu12Ai5a+qcerVHGd2OLolSutpuhXFfW/GyqPqIIX/jNPXynBXdJjR8BR5I+Cvl+4l6YZmuaO6HE96kPD3HR58HmbSioTGdCh64dldxc+lhO3josu8GJ3U/YZTO2YEYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730627408; c=relaxed/simple;
	bh=yV6G2tasLKUakTtA6GjY14+jEjwal1f4qY8/XgmGWKo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NKcMKzC2j4E08ozm9TfzGn22vpGeb4mk3RmoDZO0bYhA0jX/QRCeejH6taTVBNv2rWr4jdDKYtC9PHCLcNs0WPZcvhCkNYVJl+IXiG0GHYc64LHlEeG56Xsga+Z1CDfIAVBjyO+SNUGlV+ZCj7V7amIdqnYYjGt1j95qjdGkKEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dOzJp+mw; arc=fail smtp.client-ip=40.107.20.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVTXqh1XMVwi1eijMrzhUH22aS/3j1/5yg8FTF3JfDlxYM+sviA8PEh5KPnKLAPz+qIN9e9WRUu5esqi/7ko8Z2B0ExeSUmYO2VeObZg7v/REd/ko/E093izhaeEE0hFFZjSa1SEZpllptl3H42m+4uNALKNuE7Zg/eAkmAhGMISWq5eYIfYGP+b5DF8nDO7QlJ5jsPoyJI65jaeBO6rAT6Il6iJvjP82GKxXacjEnCRA7Jq8PZC/T2RaBZGC3L8BlPEe+uxV9Hz1Cwkd+TuunRGsYHq4A9f5q7aF9DUB0TM34SZN0izoe2O13kmIpCrrAk3K+gLNzAOiUNL2HL6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BR2SfInFHY9B+gWDDTVfcuHH6i9pFcH6/L8TyfJ54uI=;
 b=VCrlgv0obFSEV7yWRkoGZwwKpPlTWL0pk2HZn9ewuPjlI8XykmTizB8dehYfrERrz5IIWEQFj5AC5wXQLnYb0vGYy4Qt/ly2OgXafLrE5Qo++hnHvI+r5DCBqcZk3JkkM4bumL61afgBzkW+dQ+xweScaK/iuBfDcypzZSjAah+RTVpNXygiqFHZzt76T0++l7D68Xu6a6hQ7jmUYV6rFuYFbjNLxPk/yw5uGEh9whUFCIg7Yfbx9wZVzUomUhc6+EnNYvoH4Wwa+owjgzDHOB5MqWU1d6167m8yA0sKOEhpbdooVubjsppUfHK+LkuldzpvT1RrqkH7Opr3z+7AOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BR2SfInFHY9B+gWDDTVfcuHH6i9pFcH6/L8TyfJ54uI=;
 b=dOzJp+mwkG8DHyXIDo7zWasjkO8qHgIIa7S6rWaT+Nz5PHtp0uCx5F++EXfK6+2hhgN8nkp4dS0HwIVfAvtJXbPAhbc3Xj/mLPdRqKq2E3EzsZ930CL7f5IyOw821GUGv4k5foxRSy49VIDRLmRx0XiThPvpJrzmXKXTBXJocBeUqxTnXTSNbM2wXpdVe2chbjGvUV25dEdnpe9X5krnMZE0CqaYPKAxCqCjIu4p4MKH9vPtAvzl+9tSDG/sF+BHClajs8nmCkbEU4O0p365p0OtlKsQqKhv8wj3VSoH/pwQcMfROrcD/tPAT6C3V+4znyN18bibpHAqTtGqdoV/Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3278.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:137::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.15; Sun, 3 Nov
 2024 09:50:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8137.014; Sun, 3 Nov 2024
 09:50:03 +0000
Message-ID: <4fa5b5f5-6e76-4d3f-b3b4-1e977b7d3c4a@siemens.com>
Date: Sun, 3 Nov 2024 10:50:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] PCI: keystone: Add support for PVU-based DMA
 isolation on AM654
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <cover.1725901439.git.jan.kiszka@siemens.com>
 <f6ea60ec075e981a9b587b42baec33649e3f3918.1725901439.git.jan.kiszka@siemens.com>
 <3d7abd75-68a2-4232-ad8c-e874c10df1ae@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <3d7abd75-68a2-4232-ad8c-e874c10df1ae@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3278:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e776285-81ae-4932-dfe9-08dcfbece38d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzNsWWlBeXdZcG1UUUdaYWE4bXdpUmxXT1lReDNOUG1pR2hKOFlvU05sWlVi?=
 =?utf-8?B?V3lZNFUvVVdSOTd0dDRwMmJCYWNDeXp4dnd2NjhZZFEvcjcyajhaQ09zWGtE?=
 =?utf-8?B?T2pnWklNWE9RY1F1eTFNYlpkWGNBNTVaRHIxbTRmV3ZxL1M2T1Bad0JzbXR1?=
 =?utf-8?B?aUFNU21OenZDbS9IRjVpWThoSStlc2ltcjFvWldSVWRxRXVUTDRsQVlxSmEv?=
 =?utf-8?B?WFVCVVozMkJ2VW51VFVTTVdjVXZ4UWo5YzNKZWY1Mnc3WXNuczdQRWRTRmk0?=
 =?utf-8?B?UUpCRmN3aWdQQ2ppK1lvaFpGc280UE8rR2dqQnlqZU0rVHJuWFJYMWxHVjZM?=
 =?utf-8?B?MTdSdTJYNlhaZzFITVpCZnQ0ZFRBcHZGUWJDQmhuUnM2MUZRcjkxWFVPYU9R?=
 =?utf-8?B?ZlVyc2NzYjVrZDVOYU9EVUQvR0JxMXA1cVBUQlh1c2N5M2dXdGY3ZG5VVnZV?=
 =?utf-8?B?cllHT1BEdGcxWmlZOGNaaEtwSGQ2K2RsWmtFMDk1TzFXZGZVQ2tXb1g4ZmxP?=
 =?utf-8?B?cGw3eitEZHpEVHBOZWZsc2tOOGZuWjFRaDE0QlJOLzdrT3RXNm1tQ242RFdt?=
 =?utf-8?B?eWpnMDVGN2paSHc0bTU5eWZ4Z3MwdHc0ZFBYUXcrVm9vaGh1U2Nmd1p2S0V6?=
 =?utf-8?B?blEwN1E2S2xFYm96ZHBIaUtpTUxsdkxadG05eEtaeFlaNzVPVkZXWjNmUWlP?=
 =?utf-8?B?K05tVTdzVVZKbWFHMXhrcyszU3N6TTVZWVdtVC9UWXhTWHZERWRqdHdDVll2?=
 =?utf-8?B?TFJhTTllY042dnFJYjhYT0k0NjVSNkN0ekNSYlhiUmNyRmw1U2VvWUlZczdn?=
 =?utf-8?B?b3BpR0FPTGlDWmJkK0szZkhqcW5qY0FZYTltSWJkMytsa1RPYmhJOEVYR3N3?=
 =?utf-8?B?UlVQUUpOZzVNRmxxQkw3S0NBWHB3TDhPd3RaeEE0a1BSTVh5TmRKTVh6YnAv?=
 =?utf-8?B?YStNYkl4Tzd2d1dnR1ZrSzhNV0VZczZra3RTYy9LT1EzbGhjL01xTG9iNUk5?=
 =?utf-8?B?MlFiLzFzb1pzS0V2NWIxL2xmbXFaZG1WVGlsdHZhMDZEb042aTNxa1JGM3d4?=
 =?utf-8?B?SVoweEl0bXpNZzUzektGSnV3WlRRcXlNcFdvd3JUa05lYmNzdzlETUFNQ1pp?=
 =?utf-8?B?Z0ZsTFpzdXhxVFRkN1VOMG9wYUNETFN3Z2UvenVmSkZtRnhqU1cwQ3pSeDJP?=
 =?utf-8?B?UXZKNXdKWk4zN3IzZTRhbmlDMFVWS1JPRENHb1NwOFRBd2w4aU5sM3hOQ1FW?=
 =?utf-8?B?ajFWK2RXSFZsT3RHY2puLzlnQ1BsQmM5TzNobkRLbjJVMmhFUVJrb01DYUJl?=
 =?utf-8?B?Sk1GQ004VjlXM2lwc1NFcVIxTUNjYkppWlI0dTd1L1FWRTNPNzVxL256WjdB?=
 =?utf-8?B?R2NIcGtnVHdsV0xJb0RMWXZkTUpRRGdNejFML1BXdFNab2UveXZoeTkxWkI1?=
 =?utf-8?B?TkUwTGZ2YkU5QjdUSlpxQnJpVStkRUpKSFdyTGdsSGFOMG51QkhUODFQQUVz?=
 =?utf-8?B?UlkvZVh3RkVVdVJkSDR1YzM4ME9NeTVKZXBpNVNPaE5YT1V6UmVBcTREWHlx?=
 =?utf-8?B?a1RvWTlxbzljU3c1Z1hGZ1J4VndJYWh1Q2dZbm1PcGdaK2hrK0N3OWx4NUJK?=
 =?utf-8?B?MkJlWWlKOTQyRHNNQnVEVitRQ2NCQVdCWS94RW5lcy9LdEJIWjZLT1JvblVo?=
 =?utf-8?B?SWl1NjhIMkVnWnNSd3ZWTzR0TnNmYi9FTlFsK2pPQk9aVzZHcXpuSUJHWDNj?=
 =?utf-8?Q?Z5FcquFxBKJ4+bUHuSqKhPE9/3D/XbT6wYeec4n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ujd3blZ1ZWYvd29RT25SK1FiTXV4WTN4QVIxVC9jQ0kyWjJ1RTlXNWZ3VDRz?=
 =?utf-8?B?QmpwN3NZdlJINE1GdjFwTXNvR01XZzJJZm81V2RpTHVCMHkvOWtSNDZDNWIw?=
 =?utf-8?B?Ym1Ob29oNkxjdVY5WkRHa2VIWUhrWHlzbEVmTFMzNVpOREZ6QkRva3dWS2w3?=
 =?utf-8?B?RE9hUzBlZVdxMFpqUjB6UmVqQ1RKb0NDS0hUWjFHb2ZQRUt1NUlDaUZESU9p?=
 =?utf-8?B?WTBVZkNUbXZhcmxlbmdLK2JhMFdtU0dscE9jc2ZYdzUwcThSUDlsNmxCTkt5?=
 =?utf-8?B?YjRIRGgzWWJ5R1VLd2tLRDhHdjFuMGp4Z0orZnpJRU5GM2pmYUc3REZjd0RI?=
 =?utf-8?B?SlErVDdGbDh6RVhiZHRCYXdCWS9mTTViSkd4WjV6dkl5Uk1RdlYyQXBLL3Ba?=
 =?utf-8?B?OFpyeGtmVjhtMWY3c2FYTkFpeHIrVE1SR2lob3J1Rnd6S2liaitJbzZ3RzZz?=
 =?utf-8?B?OFpGc29JaEpQMk1INk1xYW1aamIyWnZUNVcwaXkxVFVDQ3Q2UlFJL01UTEJR?=
 =?utf-8?B?T09Ma0kxc29odkpYZnZGelRIN1N0cVVpOUN5MkhOTXZ1NExQaUlCWDM4VHJx?=
 =?utf-8?B?TnlPUU5HTmpBeUJHR21Kb2dCRDMzb21JbzFjTTRaemY3cFY0bHZ5MC9WTWZZ?=
 =?utf-8?B?YkdRZGQ4STFKeGlMQ0ZHSWc1SVlnM3BiSGkyMk1ibFc2YmZDZ3ZicVh2WVpr?=
 =?utf-8?B?K3NzRjZZaXg5dkV2YkdoK0hTTGpBVVcwaVZieGJoa2V4ZVBBNVdrZUNEUkQy?=
 =?utf-8?B?a1M1UUkwODFKYTlpeFZaWWpFRFFrYi9EMEJUemplQmdlK2ZiYWUyanJXNUxL?=
 =?utf-8?B?NE1NcGY4c0hnSmE1bXZLZnpCTTVVbjRsZ3pNdjBRQmprVEhDUjVDMlJiWFJN?=
 =?utf-8?B?MTNBNFMwUUl2WjR1WDRUb3U5YkhWa0VGUExmT3dQU3NZYzZVdk5tQTRvRW9Q?=
 =?utf-8?B?LzBZYTRJeSs2NVRJUXJvc0tXWjFRN1U4UzVWNXJMcGlYcGZqa3ZTNkVNN2JT?=
 =?utf-8?B?SGZlTjJBdW1tY3BiT0lWM2hzeE40QXlwM3gwaXk5OVR0NUhHZlJHYjNvNk1F?=
 =?utf-8?B?NnJ6WVNVQ3luOGtucmZTZSt3dDN2NWtRcDNWbnJxZllnMkxTamlPb2VvYU5Z?=
 =?utf-8?B?cThEWVNPMlFhU1c0c01wcHBWWnQ0K0d0QVBIblhENFI5QVdWendmUkxMa2NS?=
 =?utf-8?B?YTV6TFh6WnluVG40S000bDJrd0pCbytWcjJ5bDlYWC9SODM4UGRuMnRRUm5H?=
 =?utf-8?B?UkFqTkpNTVQ2RW5FL1U4aGJqL010V3RyaERiMFZZc1BsbTl1cHAwblI0Nm5E?=
 =?utf-8?B?WU9SZkF3YnNBTWF4dXNUVWhqN1NockRRMjVLNC9CSFI2ZFFpY01PbjhFV0xt?=
 =?utf-8?B?Ly81Tzd2eTg0YVBJcDlWUFlRa2pXZmxxcmFEay9qcXgraXpYWXE4Y0pIcWFU?=
 =?utf-8?B?VkZvT0taSk85YVJMVmRVQ2JFdW9YbnRodTdYOUJpcWhzb3M3aGE5cTJ5b3A0?=
 =?utf-8?B?c3ZVbXNJMHV3UmhhOVg3dEJWek44M0h2NWhndDF0RXo3M0lFempzQ2FXYTF3?=
 =?utf-8?B?M1I1M1Ezbm14eWlleEVua2hndVFGOXBScklWTEk1QnVvTGFzTFBtMHZGRisr?=
 =?utf-8?B?djlTaXpkMDlBZ2xxc0czaHJWY2xHZTZYVEZjOFIrM1dXQVJiT1lBd1hlNUZp?=
 =?utf-8?B?TWdUYkhacFpEUVBKdjlUc3NOV1dEMmNFVTljN0EzYmR3WTRUQWdBYit6VW4x?=
 =?utf-8?B?VHRKUXNWdTQzNmRtY3JEU1drU1hRNkdPa1NhQTUrWGIzTVdrb1ZSbWVDUmJY?=
 =?utf-8?B?OEVxUllMakFvNUtTL2R2ZzZpem5MamFQU0I3Vy9BV0dqQVlBN1JZcisrbHVw?=
 =?utf-8?B?M2djMlFXTnM5bE9ZWE5GTm1oUkkzcnZZbVdqZlFZUUx0eDZEV3lWazhFNUlk?=
 =?utf-8?B?MVEyK21nUXIzWklZdjA3NFEvaWl3Zjh2OGNCOHphVzQyMFV5aWt1TFVyNEMr?=
 =?utf-8?B?TjhZK2ZEL1NpUVpBVGV3amcvU0ZVcDk5RzlLdFJad0Yxb09FR0Y1OGFkamlU?=
 =?utf-8?B?dFk4aWtncWlKR3hHT1B5OFNId1hrd3ZMZlVPRzU5ZlJSVVlVSVVNRlUwcmlQ?=
 =?utf-8?Q?4nHAhwD28gCjqi6N4uCih66rl?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e776285-81ae-4932-dfe9-08dcfbece38d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2024 09:50:02.9865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bpdW8i91i74RCOuoLJyWtbxUEOW6ICTLnh9kbftvEWgHbEki1uCirsAG1xtW8qB7uuyH5MEC31Jnosjk9z2gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3278

On 03.11.24 07:15, Vignesh Raghavendra wrote:
> 
> 
> On 09/09/24 22:33, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The AM654 lacks an IOMMU, thus does not support isolating DMA requests
>> from untrusted PCI devices to selected memory regions this way. Use
>> static PVU-based protection instead. The PVU, when enabled, will only
>> accept DMA requests that address previously configured regions.
>>
>> Use the availability of a restricted-dma-pool memory region as trigger
>> and register it as valid DMA target with the PVU. In addition, enable
>> the mapping of requester IDs to VirtIDs in the PCI RC. Use only a single
>> VirtID so far, catching all devices. This may be extended later on.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>> CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> CC: "Krzysztof Wilczyński" <kw@linux.com>
>> CC: Bjorn Helgaas <bhelgaas@google.com>
>> CC: linux-pci@vger.kernel.org
>> ---
>>  drivers/pci/controller/dwc/pci-keystone.c | 108 ++++++++++++++++++++++
>>  1 file changed, 108 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>> index 2219b1a866fa..a5954cae6d5d 100644
>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/mfd/syscon.h>
>>  #include <linux/msi.h>
>>  #include <linux/of.h>
>> +#include <linux/of_address.h>
>>  #include <linux/of_irq.h>
>>  #include <linux/of_pci.h>
>>  #include <linux/phy/phy.h>
>> @@ -26,6 +27,7 @@
>>  #include <linux/regmap.h>
>>  #include <linux/resource.h>
>>  #include <linux/signal.h>
>> +#include <linux/ti-pvu.h>
>>  
>>  #include "../../pci.h"
>>  #include "pcie-designware.h"
>> @@ -111,6 +113,16 @@
>>  
>>  #define PCI_DEVICE_ID_TI_AM654X		0xb00c
>>  
>> +#define KS_PCI_VIRTID			0
>> +
>> +#define PCIE_VMAP_xP_CTRL		0x0
>> +#define PCIE_VMAP_xP_REQID		0x4
>> +#define PCIE_VMAP_xP_VIRTID		0x8
>> +
>> +#define PCIE_VMAP_xP_CTRL_EN		BIT(0)
>> +
>> +#define PCIE_VMAP_xP_VIRTID_VID_MASK	0xfff
>> +
>>  struct ks_pcie_of_data {
>>  	enum dw_pcie_device_mode mode;
>>  	const struct dw_pcie_host_ops *host_ops;
>> @@ -1125,6 +1137,96 @@ static const struct of_device_id ks_pcie_of_match[] = {
>>  	{ },
>>  };
>>  
>> +#ifdef CONFIG_TI_PVU
>> +static int ks_init_vmap(struct platform_device *pdev, const char *vmap_name)
>> +{
>> +	struct resource *res;
>> +	void __iomem *base;
>> +	u32 val;
>> +
> 
> Nit:
> 
> 	if (!IS_ENABLED(CONFIG_TI_PVU))
> 		return 0;
> 
> 
> this looks cleaner than #ifdef.. #else..#endif .
> 

Can be done, but it would move the stubbing to include/linux/ti-pvu.h
and ti_pvu_create_region and ti_pvu_remove_region.

Jan

> 
> Rest LGTM
> 
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, vmap_name);
>> +	base = devm_pci_remap_cfg_resource(&pdev->dev, res);
>> +	if (IS_ERR(base))
>> +		return PTR_ERR(base);
>> +
>> +	writel(0, base + PCIE_VMAP_xP_REQID);
>> +
>> +	val = readl(base + PCIE_VMAP_xP_VIRTID);
>> +	val &= ~PCIE_VMAP_xP_VIRTID_VID_MASK;
>> +	val |= KS_PCI_VIRTID;
>> +	writel(val, base + PCIE_VMAP_xP_VIRTID);
>> +
>> +	val = readl(base + PCIE_VMAP_xP_CTRL);
>> +	val |= PCIE_VMAP_xP_CTRL_EN;
>> +	writel(val, base + PCIE_VMAP_xP_CTRL);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ks_init_restricted_dma(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct of_phandle_iterator it;
>> +	struct resource phys;
>> +	int err;
>> +
>> +	/* Only process the first restricted dma pool, more are not allowed */
>> +	of_for_each_phandle(&it, err, dev->of_node, "memory-region",
>> +			    NULL, 0) {
>> +		if (of_device_is_compatible(it.node, "restricted-dma-pool"))
>> +			break;
>> +	}
>> +	if (err)
>> +		return err == -ENOENT ? 0 : err;
>> +
>> +	err = of_address_to_resource(it.node, 0, &phys);
>> +	if (err < 0) {
>> +		dev_err(dev, "failed to parse memory region %pOF: %d\n",
>> +			it.node, err);
>> +		return 0;
>> +	}
>> +
>> +	/* Map all incoming requests on low and high prio port to virtID 0 */
>> +	err = ks_init_vmap(pdev, "vmap_lp");
>> +	if (err)
>> +		return err;
>> +	err = ks_init_vmap(pdev, "vmap_hp");
>> +	if (err)
>> +		return err;
>> +
>> +	/*
>> +	 * Enforce DMA pool usage with the help of the PVU.
>> +	 * Any request outside will be dropped and raise an error at the PVU.
>> +	 */
>> +	return ti_pvu_create_region(KS_PCI_VIRTID, &phys);
>> +}
>> +
>> +static void ks_release_restricted_dma(struct platform_device *pdev)
>> +{
>> +	struct of_phandle_iterator it;
>> +	struct resource phys;
>> +	int err;
>> +
>> +	of_for_each_phandle(&it, err, pdev->dev.of_node, "memory-region",
>> +			    NULL, 0) {
>> +		if (of_device_is_compatible(it.node, "restricted-dma-pool") &&
>> +		    of_address_to_resource(it.node, 0, &phys) == 0) {
>> +			ti_pvu_remove_region(KS_PCI_VIRTID, &phys);
>> +			break;
>> +		}
>> +	}
>> +}
>> +#else
>> +static inline int ks_init_restricted_dma(struct platform_device *pdev)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline void ks_release_restricted_dma(struct platform_device *pdev)
>> +{
>> +}
>> +#endif
>> +
>>  static int ks_pcie_probe(struct platform_device *pdev)
>>  {
>>  	const struct dw_pcie_host_ops *host_ops;
>> @@ -1273,6 +1375,10 @@ static int ks_pcie_probe(struct platform_device *pdev)
>>  	if (ret < 0)
>>  		goto err_get_sync;
>>  
>> +	ret = ks_init_restricted_dma(pdev);
>> +	if (ret < 0)
>> +		goto err_get_sync;
>> +
>>  	switch (mode) {
>>  	case DW_PCIE_RC_TYPE:
>>  		if (!IS_ENABLED(CONFIG_PCI_KEYSTONE_HOST)) {
>> @@ -1354,6 +1460,8 @@ static void ks_pcie_remove(struct platform_device *pdev)
>>  	int num_lanes = ks_pcie->num_lanes;
>>  	struct device *dev = &pdev->dev;
>>  
>> +	ks_release_restricted_dma(pdev);
>> +
>>  	pm_runtime_put(dev);
>>  	pm_runtime_disable(dev);
>>  	ks_pcie_disable_phy(ks_pcie);
> 


-- 
Siemens AG, Technology
Linux Expert Center

