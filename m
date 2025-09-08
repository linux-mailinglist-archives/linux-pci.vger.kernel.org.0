Return-Path: <linux-pci+bounces-35633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA5EB48429
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 08:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C134E3C1DFF
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 06:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111CF231845;
	Mon,  8 Sep 2025 06:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hg5dw+p3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3D82367CC
	for <linux-pci@vger.kernel.org>; Mon,  8 Sep 2025 06:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757312732; cv=fail; b=RkCDidGa8K5jhGzztc0O4u4tCoceHRei72WruPQe5rWMF90T0zF9CGoxxMUbAz59/n6D9HawShV9ILxNBHh04LfZYY0I35tvyAxd2tke2VaSsQeikkOp6hHR4uFIkHT4GIGUSuszQA9a/UrirowBpbdD+5L21q+Mq88sbYE6nw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757312732; c=relaxed/simple;
	bh=uLmRZMc9b+ryZdrG583vmW63lUZ0kBPhLEAMMtJdp5E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rvDClEI8YEyBWqrmWoPVQkKh02SkGQR5FRaG9DH6rWSDCzcXhk8A3Q+DY/51DHDURFpe5calA1DFWfmktkar62W+6ysPSmweClLzXFe9pDDE1dZDZaaH0aWTYy2FobKyBW1z/XGkT8O9MDTPNu+LY6Zad1Do7OKG6IwOHllSd6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hg5dw+p3; arc=fail smtp.client-ip=40.107.101.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxidMaqRs+8vswzLgTonnXWeS0dG9l2IGht9hBri00Z0ZY77O1gdsKtJdF1MmUCRyiBSW+Tk+QZ5OV4NeBgrqM7jc9vQFBfMAcbUlCgyaE/m7+t05jtpia4SqPaiCPv0VEaqZ/0H8LE9F4JS+O9CzLDL8UeidPDXoniVxDxdJ+MyFrAVSjkVJHQMXqFLl80wLjR6PUB3CBCNCQ1g4mtKDescKSqVK1kCKGBPnLBlSA8Y0TJcy2QYtxirgxraHwEB2OBDG5ySyDJ1sEUjrh6SChYlyUBxFmWEhg2nGL8ldn+PxCZndhmirMclQxQz7ugp5+o/EG4cHsCZsVWiq2AWQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8y8SnVs81pUJ1pbLS0V7RrCYDik+mnNSoj+zX9ck3A=;
 b=Mawi0RUEVeJ2Y6irJDRDgKz8W/f3uo2YUite52MznEJJU3FDWlIHDjAxW0EUZmEQ0JGjczN5ykKdK3QW2hvH2AvvzEzIXL7MfIoKR91ozT0UIuERCSkdONfTho4IcIyW5S0UNwxThcIYWoh6d13f8vzhfDVw9Pc1oUPKAWkSb8g8CZRd1TpCbwU1PAn1mJ9LigxWvRFd5Q+GUxxsPNb03HbwsoqyivKN5HtxVLIB0GCbcRZ/QHfAg0AngiJIauFtgUjoFec6UoQtGff0LU2a+NOMpJz7TGoXvghWbDJXBO5vVimtpVF6ZIir+K2WweIukZ99uscXjIH/cTzWOS2E2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8y8SnVs81pUJ1pbLS0V7RrCYDik+mnNSoj+zX9ck3A=;
 b=hg5dw+p3sCliBYF5lDdS5byoqoSDcr5LbHuFhFTy2JFK0besO+jHTxU5delIiW0bNEfvxsmcVJHL31zUqyD20VpMYwr4Hlo189Oq/++t1qWECW00YsX5VAitLr1i6Pe6R+Q829kgC8X6DOJpS31+rTn5OvRzTj0JaU0O8IJ52E0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by IA4PR12MB9836.namprd12.prod.outlook.com (2603:10b6:208:5d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 06:25:28 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 06:25:27 +0000
Message-ID: <58ed4f53-5620-4faa-8276-cf73c93b84cb@amd.com>
Date: Mon, 8 Sep 2025 16:25:21 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 07/10] PCI/IDE: Add IDE establishment helpers
To: dan.j.williams@intel.com, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aneesh.kumar@kernel.org,
 gregkh@linuxfoundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-8-dan.j.williams@intel.com>
 <eeca3820-01dd-4abc-a437-cf46dc718ab6@amd.com>
 <6608a45f-b789-48c9-9418-5d6c2956975f@amd.com>
 <68ba3f725b284_75e3100a5@dwillia2-mobl4.notmuch>
 <14144093-c3e3-49a1-96d3-acd527cfe32a@amd.com>
 <68bb95a07043f_75db100bf@dwillia2-mobl4.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <68bb95a07043f_75db100bf@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0134.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:209::19) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|IA4PR12MB9836:EE_
X-MS-Office365-Filtering-Correlation-Id: a1db2828-2aac-40fd-2219-08ddeea08072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkxBMXpmRmVFdmJSS09UbmNJYWw2bURjcVc0MU5pNkRtdTVHSFdXMEdvRFUr?=
 =?utf-8?B?MjVBcVhnNVEwZXRKMDNtR09FVmVES0xkc05xa3prMU1FdTdob3VYUU9MV21r?=
 =?utf-8?B?b3VTMnpQZlFLeEhVVGpOUkdPcm1PRFU2Qm5UcEs2TXFxbHNMMW5ZaVBuK2pP?=
 =?utf-8?B?RE5KZXJtMVFFaThiSWQ3RDkrVUJhUGZnWVhhczREUHV1S25SS04zNHBDanVU?=
 =?utf-8?B?QVUra1ZVOEF5NVovK1BlNkhmQmRTRGV0S3ZvTXcvWGpsZzMxV3ZhQzNDVm5L?=
 =?utf-8?B?a0FrU0dnbFdWRzZrYm8vOVVkWkRxL1B1WVk1MGFRMzhTWVhGQnNJUlNhbjZN?=
 =?utf-8?B?WmZmVm5LR2FRTHpSN3JQV1Y2WmM0NHQxQW5qZW1qY21CcGZIUlUvZnRTQ1pu?=
 =?utf-8?B?ZVJBaXVWR290UUZuMWI3emhmWTRFZ1h5djM2VTM3NlJaRGxkcnpRMVlxZ3BM?=
 =?utf-8?B?S0UwSVd5Rk1TMnAwR2FSTzRHTlBmSEszeDhuT3JLM05YTkJGdXY4RzVRdGJD?=
 =?utf-8?B?OXo1MFJFdnVralRtTCtwbEdHY002RDBMenlDQWNTeWNYMUtRNTJ5dmNHN1Ey?=
 =?utf-8?B?RWR1blIrU29IVm9Qcm51cEhLNzEzWFQ3QTdJVVU4c01ub2RyaEVuVTlNK0lI?=
 =?utf-8?B?Q1FWWStVdzJsRllFZXF0aXFzdllEZG5vMXZkaUdiaXFBQ1ZSSmRVSWYvN3h1?=
 =?utf-8?B?UVg5WFM1dXNXMzlwRHp5TFBDRnB3YklwUUcwZEpLWW5VQXJPc3NhaGR6L2NG?=
 =?utf-8?B?MzltZWxjd2NyWFBTcWxsY3R5SVdGamQ1c3ZYQloveUpuQ0w0Z0cvTmVSMmk0?=
 =?utf-8?B?cFY3b0U4UTFINDlwWWVLQXJpMWxGeXE4K09WNG9EZWtoQitTWmgxangybWFP?=
 =?utf-8?B?M09VamtWVXM5cUtjKzNOL2d5aFEyM0R0Z1NoOUZVVlM1K3hiU2E0SDk3WVVR?=
 =?utf-8?B?K1Mzd0R0SjYwRTNsM1N1QzVhNFIyR2JPMklHMCtpNkVKVS9jYklCNmRNWGpT?=
 =?utf-8?B?MFFXdnNKYXZ1Q3dWUHlFenFTb0k5OUpsZVNvUFMvRXVkeTNFdjUyMUp1ODgz?=
 =?utf-8?B?ejBmMHQ4dndJTUNZd3RvbS9MTDFFZlRuaXNHK3IwcmYxbGpubW5ScHNHS3pR?=
 =?utf-8?B?TGlFeDI5WTJodHFJYlRlOVU3WDZVTkgrZG91b3N4Q0c2andhTm5QM1JGb1V0?=
 =?utf-8?B?Zy9rakk4Ylhtem1NcEk0VUxicUxiOXBLWVpDMEphMXRkYklCSmhXeW1odis4?=
 =?utf-8?B?aW9rWnVhYTVySHRFZFg2NGdHWk9tcTNrdGpieXFmWTJrazJvMXgwUk9jSWV0?=
 =?utf-8?B?b1RTc0cxSzZKZ00zb3ZUZFhRZFhUMGpNQlFOUUdHbmU0MHFZQkpiWmxUbGhJ?=
 =?utf-8?B?YUdEcmlMOHJoLy9Kb3BaVW5kZXluNlhtT2Fnd2xBLzZtZUdXZitzQ2U3bVll?=
 =?utf-8?B?Y3kwbzJVNWYvSlp3dllkS0k1bWFtRDRDRTc1SWI4ZGVIdHBWb1g1U1dlZU1D?=
 =?utf-8?B?Q3MzOXNwYVhSTlBrd1VQb3RQNTBaenp5L0twdkU2UzJWUFFjcFVoTm1OS3hV?=
 =?utf-8?B?VXg2RXhidmRDT1ZkUFNoYk5PMWwwUThSdllubGhRVXZNY25wMWNVcWR6V1NJ?=
 =?utf-8?B?NTRRUHlJcjhVNnorRGlOQk5IT2o0MlpUd2FTaTFJWnUwREhhMTVmY0g0UWZi?=
 =?utf-8?B?UEZQN2xPSmxYWG55OTgxckd5cXFpS0dDRXhILzRxUFB6YlNOaktsM0E0ekg0?=
 =?utf-8?B?WWpLMWg5MDhDYi9FUmV1TnBSRTVWZitDUys1WVpNbjEvMDd6cndCNUtmZnVq?=
 =?utf-8?B?Q09oeXEwNUZSU2MzaXZrYm42VDRKbFVSM0M5NTV2UmkwaFI1SGd2b1ZmRlhV?=
 =?utf-8?B?T0diaW1CUzlkU0RBRTUzMGQzS1huRXhZZ2ZCNWd6TGNHRjI4Rmw1aUtEOWFK?=
 =?utf-8?Q?haTeqnj+jlo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVBzTkZrUGV4a01SQ0pId05LakViVDNxY2JPMmo2ZGd6dTR6Q0g2L0RhTmUy?=
 =?utf-8?B?dFI4NXZvelI5Q2RCZVVadVRQZHRMU2lPYUhnMWExdi9XakFFL2lzZEE4OTFQ?=
 =?utf-8?B?c3NuV1l0RE1MWngxanpzaHlBaGZoUEg5TlN4MjN1eUJoMU1TT1R3ZW11Zzlx?=
 =?utf-8?B?OHhEdm8ySi8xdXIvaFJlQVhCeHRMZXZRaG93cjRTZFFNa1ROTmxYdDJoOStz?=
 =?utf-8?B?YTR2aTNyK1JGRTM5QkRTQlJYRlFTak9XNW9ZWVM4QmxNTnpUNUkyaDhleXJV?=
 =?utf-8?B?SEt2cHl3TmlsblRzVkZ1c0NxclIxVENvN3QxTWdhYmpINnVGVE5YeXRSQUZD?=
 =?utf-8?B?QW9acTRwME1YWDRLTzdCYm5DVzExa0lmMWJOUDNPaTcyRDR1dCtVWnFjTkg4?=
 =?utf-8?B?bXgxeC90TmdqOU1IR21YR3kwNjBTMXNPaWFhME5qeWluQ0xreG5JSEZiWFl5?=
 =?utf-8?B?MEJoSHlsU0VGcUpLc2Z6SEtSTkxYc0R5dC9KUXRCVGhJWnNWQVA1TDJhVXVt?=
 =?utf-8?B?d1VmdHhDWGlWM2RCWUFDUm5vb1p3YkszdktIZndlUVprVkx0RjJjZTFsaHRH?=
 =?utf-8?B?aDBqalFUZm5kZCt0alRzbWlSc3huRExmVE5tdWlvb3orWUZSNkpTcWdzWVlO?=
 =?utf-8?B?OWhoT3NBOFZFOGd6Z3EzOENoMldvbThxeHJxcTVGTTVLNGVab1R5Vi9yYUFJ?=
 =?utf-8?B?NVJrWHpMSTU2cnY4VDQ2ZmpSSERoVmxZbmdJcFVqK0pvZkJLQUVoTk5pWGpK?=
 =?utf-8?B?RGE2UDRiWFlJYVNqakNWUjRpNFBZMGhGemUrY21qVDdMUHIyeC9WZlpVczg2?=
 =?utf-8?B?T1U3Z1Vjckx1dDlCaGUzb0FxWDd2clBxRWsvenBXNVhiVVBCWm8vQitrNXI3?=
 =?utf-8?B?aXJpTVVvK0FKNEkrcjFQRUlRaC9uUEVvMlpkeTJqNUtBRUJ0YktoWmRPU3RB?=
 =?utf-8?B?Y0Q2ZjlyMGRLQTg0a2x6TzByOWFVMTlTakNJK3Y4bXdOcEhXVmdLY2NaMjFU?=
 =?utf-8?B?TmttOG90UDdBQnhZQVBJclFVQW0vR1g0bytMZ2lMY0JTMGlRTHlPNnArb1lo?=
 =?utf-8?B?dE55eHoxMGczV0pmWk1sVTkxakc4azlQV0FNeTVCZWN3KzZudFRwVjRNZjB5?=
 =?utf-8?B?N21mOXVzdGhoNlpUS2w3V2RLUFhMRTUwWnpiVTQ3UW1BMmZsN25QSXlsYUh5?=
 =?utf-8?B?YXZ0V0JMVXBKVE8vVGtuSTJZUnA5Y3RLaVhTQU12RmdyZ1Q0Rm9NNlpGUFc3?=
 =?utf-8?B?UVpTd1VGem5PaFdhdDJIZ0NtMlRkdHdXeEl2K1lPdzB2SGtjd0lpL3JReDBk?=
 =?utf-8?B?VGt3aERDYTRQVTMzTHJFMGZnMWxBS0dzZXdOc2M1RnEwTXB6QWtLUjczVWpz?=
 =?utf-8?B?ZXNleFZhbFMzYkdJcHh2ekJjOGYrdkhHYzcvTXJYNFZZQncwbGdYbWpBRGhp?=
 =?utf-8?B?YmhZbmM2WjlFdG9VblhoZFZVQ1V4YmNLaEJJYk95TThKc2RyQURrQmtEbHhW?=
 =?utf-8?B?WFJ2QU1CSTd6dnNpYXJPbEFOZUJvL2gxYVJ3SWVDc2wrTUxibzNaNnhCUTF2?=
 =?utf-8?B?aDRCNzhQbXB4eXdRNjc5cWkxRkRtZG5hMzIwRjRmLzJtVEtvTDRleTFUQVU3?=
 =?utf-8?B?RVNJV1JHS0t1U0VGb1NYSVltY3ZpamNaQis4UTF5cTJzRHRrWU1uWEs0RzJV?=
 =?utf-8?B?TFJzcWxGUE12eHhkWjA4Vk9hTDhrbHQ4NU1KSWw1dkxqTzJ6RkZ6T1JaclB6?=
 =?utf-8?B?M01RWmlBVG0xaXN6eVRCaEk3eEl5Tkp2MGZSd2ZVNVk2aGpqdzdudmNFaDVi?=
 =?utf-8?B?OVNiWldjYkd3NEtkb2krTXpES0o2SWhpNVM0ZHZXVS9vR05aK292ODR0SDkr?=
 =?utf-8?B?NXFRTHcySEt3Q2VLR0d4UEZhOUJ1Q0k0eEU2USs3VExHM093SW5YSVR5WTlq?=
 =?utf-8?B?REFzdEZ1ak84MkphQUQ5QlR5d0ppblk1K1B2MHFYU2FlTlVwZzJVcXFYL25p?=
 =?utf-8?B?UWJJT2cyZXAyTnd3TGlnaWpCQWFIYmV5QzlHaUZpclpSeHg1dWtpaitjT3ZM?=
 =?utf-8?B?NTQ2eGJZZGhlNmRVSFcxYk5zYnU2UThzM2pSTXJUTGNFVXdTK0NjRm82VUZB?=
 =?utf-8?Q?T30TTjO6YhJ+mXRsbRipmNJCP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1db2828-2aac-40fd-2219-08ddeea08072
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 06:25:27.7728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gk+GPg1BXHlX3RDdnL1dTvVgKBnR20qRUNf48zcmrdu6i/l/JtN9DDPJKmVcjjBVnluPOfEnk0ySSQ+xemhOPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9836



On 6/9/25 12:00, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
> [..]
>>>>
>>>> Ah this is an actual problem, this is not right. The PCIe r6.1 spec says:
>>>>
>>>> "It is permitted, but strongly not recommended, to Set the Enable bit in the IDE Extended Capability
>>>> entry for a Stream prior to the completion of key programming for that Stream".
>>>
>>> This ordering is controlled by the TSM driver though...
>>
>> yes so pci_ide_stream_enable() should just do what it was asked -
>> enable the bit, the PCIe spec says the stream does not have to go to
>> the secure state right away.
> 
> That is reasonable, I will leave the error detection to the low-level
> TSM driver.

The helper should still return an (unique) error though as this path is "not recommended" and the TSM driver might want to print a warning if it is not for a known device which does "not recommended" thing.


>>>> And I have a device like that where the links goes secure after the last
>>>> key is SET_GO. So it is okay to return an error here but not ok to clear
>>>> the Enabled bit.
>>>
>>> ...can you not simply wait to call pci_ide_stream_enable() until after the
>>> SET_GO?
>> Nope, if they keys are programmed without the enabled bit set, the
>> stream never goes secure on this device.
>>
>> The way to think about it (an AMD hw engineer told me): devices do not
>> have extra memory to store all these keys before deciding which stream
>> they are for, they really (really) want to write the keys to the PHYs
>> (or whatever that hardware piece is called) as they come. And after
>> the device reset, say, both link stream #0 and selective stream #0
>> have the same streamid=0.
> 
> Ah, ok.
> 
>> Now, the devices need to know which stream it is - link or selective.
>> One way is: enable a stream beforehand and then the device will store
>> keys in that streams's slot. The other way is: wait till SET_GO but
>> before that every stream on the device needs an unique stream id
>> assigned to it.
>>
>> I even have this in my tree (to fight another device):
>>
>> https://github.com/AMDESE/linux-kvm/commit/ddd1f401665a4f0b6036330eea6662aec566986b
> 
> I recall we talked about this before, not liking the lack of tracking of
> these placeholder ids which would need to be adjusted later, and not
> understanding the need for uniqueness of idle ids.
> 
> It is also actively destructive to platform-firmware established IDE
> which is possible on Intel platforms and part of the specification of
> CXL TSP.
> 
> What about something like this (but I think it should be an incremental
> patch that details this class of hardware problem that requires system
> software to manage idle ids).


Yes, this one is better. Thanks,


-- 
Alexey


