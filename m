Return-Path: <linux-pci+bounces-12689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C6E96A6A2
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 20:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2741F255F1
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 18:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78F9192B69;
	Tue,  3 Sep 2024 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BBRe7a8/"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABD91922C9;
	Tue,  3 Sep 2024 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388358; cv=fail; b=OIXuH2FG9QElu5WztBxZuViIGt5Sl49vTwjldC8dvOg2CgeEnAAS2/h78/D6p3eRQcqKHH6moCd6xFr32s5vDHD+kKsV/6g0/qygCqAY7j5M5eV7J0kUszZ0v35o0LQ9NRuecz0NDVU/R0PBemL8esIHnAw6w7BfiN9pC4yYg0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388358; c=relaxed/simple;
	bh=Rc9MwDwotP+dwbXsWjzI4pwheI4eIHt1pjc0oJiHR5A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GWfGP9PoyU1o7c/xcKuvoVRjFahNewotbkrP6/HCYwlw0CCw6PTxUwPqnEoV1CUp94Bl/V6BWNkz/OmQOkNja55KW3IOptIyJbA3g7E+Hasp2Bw5pAD8chH+7RN9fJILe+5qw2osIOQOXcoMHyCmors3PrV9gwoC4aUiiLCYlFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BBRe7a8/; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7/tcvpP5IVU1N/pmMvXnob6HbO6Hix2cIpYW4Mv/fWLxJ5VCarD3FU7kgflBiWDQ1R6AeXetv0uOi45eO958if84IOdFnAw4NdyS84RtM0Zn40KucoVH9gK1eFH/+i5IklQEAFn/LwRiYbzSk7lribbvSDQ7yjGbH9AjwNBYsK5ugJq9hAWMfBrIxvaZ3LGEDk/47cIu/kQtK0YMbZsy8p4TmK0G6oqgbm3ewCgvhE8Rw3MxSFkVie4rGKl2XR1G8Fi0PqxxH9alwKEcPvtiJg6NxAqL9ZK88wQ1UbyYudvUbQLIqe7TRHQsY1/bHo+W+Fkt9Z1NdtpDzNPqqamyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+fwBsvFbtkD3SdGFdlwCvsuAIHDNZvLWnp7eBLj7cE=;
 b=cH+JpEMKSMtdGNsZvIdVYpNz0jLcB0SPm5SDHMk5YFktG8YATsCOtmXy3rhjJhDtDevk/U0FYhtW4HCIstRFesZICUwPuUmnOvZXbhvU0zV6f36rDCEohCJ7W0nO3hzh8S2RDgRcp5BsK5eFrQLrDopK6Gp8Oy6GJ35bmi7r2JNOdxughiOv6/O5uao8x5KKkqcePLxZuktVmyvZ2sKm3hlUSESSqL6Q/mQADZyOLT8m10Yx+Tkpgg9Sek3SBsBJyHfV9ue9vrgqrPQX+SXhbo8HdgccW6o0lTdJQw1Iw1GbsrvNATFD77EcRN8xagX23AC2pF+ODShPjAbpWTx8iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+fwBsvFbtkD3SdGFdlwCvsuAIHDNZvLWnp7eBLj7cE=;
 b=BBRe7a8/uiFr5eII3qkmhIJMCcBZiNrjllrHfi2T88kSjzurue3vS5QOg9d1ZR8LE/8ZeRgoQrI5/iztzy9rn4oE2b8hWzb/sIzNfRSuLnvFzs+PTDBKkgcfXqCazJ4wC7w5rAZ5Rwzhrn/rjxlP1dW5L1p5s/wQMdO+sX7OVYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 18:32:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 18:32:34 +0000
Message-ID: <525214d1-793e-412c-b3b2-b7e20645b9cf@amd.com>
Date: Tue, 3 Sep 2024 13:32:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in
 pci_dev_wait()
To: Bjorn Helgaas <helgaas@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Gary Li <Gary.Li@amd.com>, Mario Limonciello <superm1@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Mathias Nyman
 <mathias.nyman@intel.com>,
 "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 Daniel Drake <drake@endlessos.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240903182509.GA260253@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240903182509.GA260253@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0051.namprd02.prod.outlook.com
 (2603:10b6:a03:54::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ef0130e-1eef-46fa-f266-08dccc46c727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ampSS04wMzliMTFNWEVVaWQ0TTNaK05QTEtIWVQ3dCsxcWJLcDlTQnM3bkNR?=
 =?utf-8?B?MmFmcHF3ZmoyWkkxVTRyL3hmR3R2ZDVSWXVvZnBkTVlVcVdGNVBVRnZwOERH?=
 =?utf-8?B?VVNQb3Q2bkNkbk9GenJleVovUkVoNG1FWVFTcnZqKzdGNXozbE1pbEpMTlNG?=
 =?utf-8?B?SEs0bFkwQUR1ZjAxYmlCL2dPcHNzNTgwNTRzd1ArQmZHektDZDJRWUt6aTZz?=
 =?utf-8?B?bHhxMEpHRGFCZTh4R0UwQzhVQklheEM2K3ZhU1ViWGp3OWZvcEpRckVSMlJq?=
 =?utf-8?B?NGs2R2tjakJEcHIyLzNBTk8zSjZhY3ZINjZJdnN0YzNGbGJwRjd6TjZmK25E?=
 =?utf-8?B?V0ZKejZVQ2t5TVJQdVduZXpmcEhTbWp1eVhJeEwyUHFVRWJyb1VSeHlLaVdo?=
 =?utf-8?B?RHpMb3p1RVZNdVYwVll2MEovMndTOWtONXVVR2FhTEJNVWhlMEpJaThTR0I2?=
 =?utf-8?B?dmM4RVVEemZINnMza3NPUlY4TTJCb01pbEM4TUh4bkdJNFZKOWdRVThHK0Ur?=
 =?utf-8?B?bWo2RGtGUkVqUXR6TXhpQXVmYTU0cWN0MzdQNDNMU1MxZEZZUkF4SkU4Yzdm?=
 =?utf-8?B?aDN3eGl4UWJEN2p2dnRYMnhYWS90Q3dya2lDekRteXF5Y3VuOG5yU0hITTNh?=
 =?utf-8?B?VFY2RmMzcjhDazQvVW5aUUxBbmJWUTc3Rnc4SjhocTRmY2ZIOHpJRzNYQTdw?=
 =?utf-8?B?cnJrTTk1YkZBRFpYaVQvbjZxWGRNSWFrejJmSVl2Y0oveWd6d0EybHJGTW1l?=
 =?utf-8?B?OUFGZ1FLYzJWQTMvSVdRZm5zUU1vdVRDUjEyMWIzdmNqL3NvSkUzMUJnOWE3?=
 =?utf-8?B?RkVEemZDaGptUHdNcHNDZ0w0ZDYrV2l1VmdmQXdwcE53QUlBZ3hJN05SRW1N?=
 =?utf-8?B?b3kyUld3UnhuTy9XSklkeVVzdExrWUxhL21UM1FnaTJkM1hRQmZLZnBJS2tn?=
 =?utf-8?B?VEpLSnhacHFIWHFBYzE4dmZyOVQzd0lRY2gzNkx4NFM2Vk54TTV2VDZFQThC?=
 =?utf-8?B?T3M0c1hiOW95UnBwTW5reVFGQXU2dFNlNGRqMHBPVWlha0R2UmJoeFVHeXBn?=
 =?utf-8?B?N1l3MTFUT0tLQXVzUTVVVHdpSG9OVllaYnJiaGdzdkJmRkFCbGdKWFM5WVFp?=
 =?utf-8?B?NVN2eGplblF5QlZ6OUJ6Uzl3TjN3SkM0cjNxVDJRVG5VckJjVVhXekc4YTJk?=
 =?utf-8?B?eEZoZTYzTWlsQTZ5VEpaQVRnY2pINFlwdzB4MTVQQm5HVVJtckdLMnlNSGNx?=
 =?utf-8?B?V1MxdGpzQ21rUW9NREQvRU1IbnpuWSs3OW5LMytxMzdnb2tpVUY4eUU1QXhD?=
 =?utf-8?B?NndveVhPeWNMTnEzSEhJNEdTTDRCN1duSS9rZXdiZS91WE15WWxwRURPZDEy?=
 =?utf-8?B?MUlxWGdNeUljTStCcTg0Rm8xNk1IUkVjRWlycm1NQWFZbXhGR1cwUTVWdU55?=
 =?utf-8?B?R1QrZkNNSDZoL2pheVRGT2QvTXR6WWxGQmZSa2xuRjVsTDI5WEg5NFFDUFAz?=
 =?utf-8?B?djlIWFcwMHMzeXhxeXBRaG9NMjJLWlJkZ3pCNTZhUGtXa3lYR3A1cTgwZmVx?=
 =?utf-8?B?cFpRZUxNMlRkVjRvbXV1Z3U2U0t0WWQvU2JOUHVDVmVTUGZNQjdmNlVrdmtL?=
 =?utf-8?B?Z3o4RVV3TGJNeFc2b3IvRmRYVmNpM2VZeGFEV254MUpBREEzcWlrN0Q0VzF2?=
 =?utf-8?B?dnI2Y3F2bXZuNEh4cjZtUjZGUkpKYVQwcEc5dnNOM2tybk5jWHBQc1JTaWdN?=
 =?utf-8?B?OHBhMDA2cSszNldBcTVISkx1dXhEOXMyZ3ZZSTVyVi8wLzFWRjlSL1MwOFlK?=
 =?utf-8?B?c0d4amVWRWZVcDhBWEUwQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHA2OGRkNEZ6ay9OME9KWVpBN1grSlZDSHUxQlJVcW9UbmcrVllLaU1mWWRJ?=
 =?utf-8?B?MFdtVEFmK2RzY1J5dmVMYTk3enU3NytnTkEzNzFJSS9xOC9mL2N1aGVhQkh3?=
 =?utf-8?B?aUxrNnJ5ZUYrT29RV0pIeVFjVlgwUmlHUHlxbVhDUlhIODlYdmtNbW8xNDlC?=
 =?utf-8?B?OUhudzZQT0hNeFlYM2pabTJCam53THFaSUpzTU9KQUxycEVHcDFpVWRsaGNO?=
 =?utf-8?B?cWZPcmNSSzE1RVpxNE5iQlhPWkFiN0dpQ3hXcEVaV2xCamd2ejdPenRIekxU?=
 =?utf-8?B?Y0VTcENwWVMrTlhsa2IyOHAvbjVuUjNLSlRCa1lvK2J0YThLQUZnRWdiVE1p?=
 =?utf-8?B?bGVXd1orbXVXYnBBT3NSVVJGR0YzWlJVUmxibjZ2NzFxMC9Zcm1PSG1ORExx?=
 =?utf-8?B?akpCakEvUjNYemxheGF1MEJVYWtrS3pkRTVOajVUcjRRYS9CL3YrSjRVcGQy?=
 =?utf-8?B?Z0FnTGFPeTJJaGt1a2pseEZOZUliNWFqNjlHSW5NWUhqZ3kwaEJRLzFOY2ZK?=
 =?utf-8?B?V0pwUHlIQWZVekdXeUs2UUEycW9RZHJKV1VGSStYek8vQjdMOGFpcTJET3dl?=
 =?utf-8?B?OG1RL3B0b2JsaXF0Y0FwdnFVTm9DbVE4KzJPQTVTSTlaV25UOXE3UmdaR0Vu?=
 =?utf-8?B?bFliN1A4bWxpTytXbis2NGlmc0p0bzJQLzNHUUo0K1hGVGs3eS9hYzN4eC9j?=
 =?utf-8?B?MitMODNicCtqQjkrMkpmRTNwazcwWmxDSExDaFdHMno5Y3liSDlET3ZHWk9a?=
 =?utf-8?B?YVh0OERhYWNVM3pqMXBCMjdtOXhhUmltNFB2NTRrL2ZjY0FScXY3Vy8zRDAv?=
 =?utf-8?B?V3U0aW9ENXZyUEdxMDBxbkpTcm1GQnNTczNpMC9naURFZDVzNDVrcjMyRlY4?=
 =?utf-8?B?ZnEwajNIaE1oUUFyRjVncmo4WGhiQ2tuMHVzcGtoZlh3ZTNBdDVYckxqRkJs?=
 =?utf-8?B?SWZLeUl3Y3BmMGM5V0VaL2xmOCtwRXZndHdvSC9hdUF3MmRjRnZtU0JuUVE1?=
 =?utf-8?B?UFFkTzdSWC80dzA0OVVEelgyNlJQZmZZRHBVdTFaS2pXai8yeWN1bHJkTlJV?=
 =?utf-8?B?Wmk3VkVUREdhaXk2d24xcWZJN2NJNHNYc29rQ0hqU2JFVTQ5ZG95eVdjdzZ4?=
 =?utf-8?B?cW9kV2dwWTRPNi9yellXbStYT2hzTHkrYlprK2U2YU1hdjFkd0o3b1h4Q0JF?=
 =?utf-8?B?dWdLUFcyczBUajdFSkc2WGJZRm0vR1hpbGlTcGROMUNTS3VSK2lPeGo1RS92?=
 =?utf-8?B?UkducnppZ0tWdnpiUGkxUHhTUlU2S1BlMGhCbTJZbnJWcWFLTE9Ta2YyeDVV?=
 =?utf-8?B?aWFIT2Y5aFB4UjNRZFBVMHdWU2RJUmJhZjVLL2NPdEdXOHhUVFhaWHhJR09a?=
 =?utf-8?B?YlFSSERGZGh2V2xycE03bW5Id0tiRnhiaHFDV3BKV3c3dGdLajJGR0R4bVlq?=
 =?utf-8?B?b2lPTnFwMGNCOHB4MU9HQ2pDM01hTHBiYWdXSGRWOVpwcThOdkN1WGxEaFA4?=
 =?utf-8?B?aEw2SmJ4YWViaXRGNWlBc2g3SStQVzJ1WFQ0aWM1Sy9XSEdvVzQ5K0txeGFw?=
 =?utf-8?B?SnUzRzdWS2pCemdYZy8yRGVpZC9jdjA2RXdxQTNiODhGV1pDV3drRlI4VmpF?=
 =?utf-8?B?ZjBJSm1wWEhDYTBodGdsRlZkcGVVRzVVdTBIYm5HNFlWa282d2NUN2d1L3BL?=
 =?utf-8?B?MW9Ka21Bd3hkTDRiVVNCcTJ5QTFnZEErRk5HcDJLTXYwQi9BUUhBZDA2c1dz?=
 =?utf-8?B?UmFNKzMrUWlKeUJrbTBuU0djNjQ3RmtiNC9LaE45SmJ5M2V2WUl2THByYkJa?=
 =?utf-8?B?ejdTRkt4V2Z2TUF2d1VnSWFYY2FXNm9vVmFIRFFmYnV1V3BsazlGNmJoQWxH?=
 =?utf-8?B?ZUtEN0sxcGtWclFTd3Z4Q1pqT0gwVnRGTmh4SDF1R1AzbnYvckFaWlFkZFpl?=
 =?utf-8?B?ZGVyWUdwWnJranNZU2ZGNGdSTXNvdXhLY0ZHNU9IU1F3TkZQYzZNMndSNWJD?=
 =?utf-8?B?ZVpHS1RIOGhhMU9aZFU0TVBVUkRzRE1QdER0MTJlbEdHTXpLWTdBdEEzYzJB?=
 =?utf-8?B?bUNkeFlLN3ZVTUtyMWNlVmFRSnBpVVFWMHJXelVoZysyaTFjVkVmelJnTnRz?=
 =?utf-8?Q?ZN6Ve9ia8vgkplNzCpj0X51vo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef0130e-1eef-46fa-f266-08dccc46c727
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 18:32:34.2809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKhgfo0HmXYGTy5kg3gXsJxODfIaCjzOpbiNTq8TspjFUOlSVm+SY+ysFJFdVnFAdpJh8cZDlvgG3wl0LrBQkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505

On 9/3/2024 13:25, Bjorn Helgaas wrote:
> On Tue, Sep 03, 2024 at 12:31:00PM -0500, Mario Limonciello wrote:
>> On 9/3/2024 12:11, Bjorn Helgaas wrote:
>> ...
> 
>>>     8) The USB4 stack sees the device and assumes it is in D0, but it
>>>     seems to still be in D3cold.  What is this based on?  Is there a
>>>     config read that returns ~0 data when it shouldn't?
>>
>> Yes there is.  From earlier in the thread I have a [log] I shared.
>>
>> The message emitted is from ring_interrupt_active():
>>
>> "thunderbolt 0000:e5:00.5: interrupt for TX ring 0 is already enabled"
> 
> Right, that's in the cover letter, but I can't tell from this what the
> ioread32(ring->nhi->iobase + reg) returned.  It looks like this is an
> MMIO read of BAR 0, not a config read.
> 

Yeah.  I suppose another way to approach this problem is to make 
something else in the call chain poll PCI_PM_CTRL.

Polling at the start of nhi_runtime_resume() should also work.  For the 
"normal" scenario it would just be a single read to PCI_PM_CTRL.

Mika, thoughts?

