Return-Path: <linux-pci+bounces-16796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF74F9C91CC
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 19:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4A528602F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 18:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27866198E81;
	Thu, 14 Nov 2024 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5MfqO/U+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C00F1990CE;
	Thu, 14 Nov 2024 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609684; cv=fail; b=R9fGqhpJgXJRWe74V1Z0X30lUSL6aswszAfyXgxW8wjUUohDJE5nKg8NCqJnN/2r56LrVlTvuQjSsD7h0k+sHwEOcruRu7/MlGRGr5uBLVIz57lmPOlKiap1a1zer6EvnYFXaDW+JPhg5mqIvzdFjYj+zqElB+H5z2dLAwrBkoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609684; c=relaxed/simple;
	bh=sIq9pxsZBwL36xD4RDxWd33ASm3gGnJBgY22Ee2bZos=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gFVDGQpvYIAcoDx69iXUyp6A0eLiV0zQAyINooRkQFNq510iTSUKymapaN4zjxqZCxqJEmSQhp93JfHoLqtUM7J2Bv0/aTkoE9hbUbBxIRIIo6CFPIRP+H3XitZ90zpIXatQSqlSpreCHqA/kYAdT5R/CbHdS9GeWm29hAinRS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5MfqO/U+; arc=fail smtp.client-ip=40.107.212.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5Zto49SOgbM3Z4dpjez10JigDP7XyvMC1G8iU8CyazFbIIKzXgvHuxVtlBHwgdWKtiosKPcSjCI2n8sawjWZIMIJYAhsPt8b/9hImnyXQYwXWRnrrstfdOfRFoAzI3yHeskZNnKgUMMKidlEm2CsOTXyHTn7LrddJwXKu7COtqZMF289al7BzWcZneOuZ/bOX/IGTYoIcNep+e+BLrnnMllxYESOvnm4ITX8sZA1mpn6cLiqRRX1RZVGlEiDSfSxXtWTOWw8FqucsCNjff4CY97r/K+4QNDjAxinDmXLu4SZjNEaFGPAp7G3Z+0fnIM6qRdNhAxoal+FWRuc7ZdCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DB46RZeKV/W8/uaQjaw/XZKscdxIN8AZN3c3vKkonXU=;
 b=TzvFrJiR3jKmHfYuM6KOHPB6wOrmaU7fgVofF/T1pIhoaoLqY9svU1byg+Pg3BFTHYSWG2o/9+fYxb/NE/LzVpHRcQxwBRT1YTL07yztNhYQ+TQar5bTv7/VSsesFqWUQ+Dn6K46P/1cbDNv6Tm5YvYsxUu73Hl25tOEGDTplyN8Rn+OxLIhZHB59TNxk9tKX6YjHoAxGpYRpE3c5PFnOoEeAH5c1au6QExi6uYYuVmQdr8ug4TnYkrvWoF/BqU6gl6QdUpLFlHgQAIKAuJKsJhAJ21bpAiC5560H+28umCjhYkZaM+tRNBIH0yu3t2fX9aWN4AuZfTnDh30kjwdMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DB46RZeKV/W8/uaQjaw/XZKscdxIN8AZN3c3vKkonXU=;
 b=5MfqO/U+HMUgH2sWitHRZl/m2DSePI9pa2C0IM5B+NFOqK0zpgLZdjf58Q4fSW+bHEjfTS6bIuSw3BRgye5PSKMy4CbLVvVNCc8BJg7jyU4WElbyh5K+QCYL0uA44NoIYf5Ew2IvPIKCCULEfVXMfSlO2MXxoa6UhDOwcaYq3N0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18)
 by IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 18:41:17 +0000
Received: from BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b]) by BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b%4]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 18:41:16 +0000
Message-ID: <7cfb4733-73a6-4a07-8afa-9c432f771bb0@amd.com>
Date: Thu, 14 Nov 2024 12:41:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/15] PCI/AER: Add CXL PCIe port correctable error
 support in AER service driver
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, ming4.li@intel.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-6-terry.bowman@amd.com> <ZzYo5hNkcIjKAZ4i@wunner.de>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <ZzYo5hNkcIjKAZ4i@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::8) To BL3PR12MB6380.namprd12.prod.outlook.com
 (2603:10b6:208:38d::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_|IA1PR12MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be75694-822a-4bdf-6fba-08dd04dbec47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXZaeEpEZVg2WTBueW1HcnZUUDhiVnhlRFNscEk4M3gwSllpZDRSek8vYnNB?=
 =?utf-8?B?MzdLc3VmVE9ySDYzS3F6Q0hzamdzNjgzbzI0cmc5dHZ1Tm84N3lQT2tNM1Ar?=
 =?utf-8?B?UW16aFNtMWxDMS9pSm8vM1dXMnU3TGg1VXFWLzJUSi9mNkkyRUdlbytjWGsr?=
 =?utf-8?B?Wkx3SmRCdjhncGRyYkw1S3VVbS95V2s2RzEzMytmZWVNVWh1TnlNMHY0R1Qy?=
 =?utf-8?B?VXJRM29FWVJEZm81YXpQb05tUGs0dTcrRUVsaWJFbHJUdzJTdGVJQnpNUlRT?=
 =?utf-8?B?MWZtUHliczBDb0VBby9lT1lLd2EycGZIU1BNQ1FINEd2VGpQdWZQdVJHMnZJ?=
 =?utf-8?B?YUI2N3NpaGl2RmI1Z0d2WXZoV2ptRElYWVQvVHhhQ1UvZkhjaWErMmpRY3gr?=
 =?utf-8?B?SU5BZlhNNFVrTU1NYmp2RTIzcFYvc1JNS0RIekRuWjIxNkppampYQk84THdo?=
 =?utf-8?B?NGFUQ2ZiZzVpUVdMK29zSkRBZ0praE9yWk1HZENoRm8wcFBhdEE0TlFVQWw1?=
 =?utf-8?B?cWpOMGFNVE55QXRpQkMyR3gxcmFvM1FtWFdJWjhkQ1hyUGtaSmtMM2FmdGRF?=
 =?utf-8?B?QUJyeVBqOFJMZTNmekw3SnNMR3J1K3JZVXgrMU5xd2dZcXc2WEhyUGVMR2lz?=
 =?utf-8?B?NDhJY0Y3K2l1NGNCcDhyNStTdndjWEgvR2xZbXR0NlZaRmVmbnRHZWhHeTIx?=
 =?utf-8?B?M0xFVVBJNW5SMGxmTnN1SHgyTTBZdUYvMXdlOUFBU0VudGwrVysweFNOMVRH?=
 =?utf-8?B?TXJiZzJlczRpcjgvbUxyd1BmZzE1TlJRR25Jd284OUJTTXJLNWZua1JGWXhF?=
 =?utf-8?B?SWd5b0tqYmloYU1tUjRORWxTWDdRenVOb2c2UFQyZW9hM3E3eXkyelRodWRq?=
 =?utf-8?B?KzQ1Rk94SlZkcHJJbytydFRHd2ZjcjM1RjA0bmNDQm9RaGpjMSt0R2tQaVBi?=
 =?utf-8?B?WUgrQzNMd21vRDhSZWtEMThLNUZPM3N2RXJGaUZGZzByakp0amNVMzllTDht?=
 =?utf-8?B?OHI3QXA5eUlrdHN0VlNhS25JTUQ2ZThyN3MwZ1hRdHZGY0cvYUk3cnZyK3Iv?=
 =?utf-8?B?bGJmRXo4aGdZdVE0NlhQSXl2TXNHdkZDRFpGclkxUjNyVS81NEljMFZscHBv?=
 =?utf-8?B?Y1VEZUFROE55TjkvUkFHWUw0YmFXNmtObmJjQVlOWmFkK1Q4ZFRYc25LbUh6?=
 =?utf-8?B?bTdaUkJOL2l0aDVDem5HekV5R3VoODI5VWVhU0I1TkxRRi9kVWdHZ3VYNkRS?=
 =?utf-8?B?K3M5Q3I3TjBOUy83TTNTUUl6emVzMFc1VUdsZVNlbzFPZ0hKU3B2UEtmVHhx?=
 =?utf-8?B?THJxb0RWdHN1eDFEOVhXdU82UnpWOFVyN1gvNWxLRHlwRm5DWGs5ajdNSkpj?=
 =?utf-8?B?d1hjVnlCM05DbXBCQTNodGV2RVhQckVESGRqZUZVMXp0QVJpdUh2TzlRcVA0?=
 =?utf-8?B?c2NrK3hMc2lxVEpzVXNzOWEwOVF4bXlWeDAzUE9WeVgrWFNSbDZ6YlV3V2lG?=
 =?utf-8?B?SmYxMEhXM1EzemVabXJOWlFOSnBNVlVFd0htcEFvNHNzZmplYk4rZDlTRzFs?=
 =?utf-8?B?a1AzQVkrcWlsWER4R0RTWTcveC82NE5Oc1JCUnFYZENJRTl6dmZ6dHE2aW1F?=
 =?utf-8?B?SEM0bDhiYTlJamJKTm16Ylp1bzdTK1d0Ymcxak9rTkVGVWcxY2lCU1dVV2h6?=
 =?utf-8?B?U0tZVjhNVjNsUEw0bXR3ZDNpOXJrQ1Rna2JkTWR4T2V5N1MxcndZWTJ2U1cw?=
 =?utf-8?Q?AcBHQ+Ttwz1OPwDKkC0HBiRzNAQV9FSlkNlI+US?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUREQUZBU0ZLRldqMGo3MnpZbnlzbUJrY2gwV2FLQ0dEb0t5VUQvV1F5c0k5?=
 =?utf-8?B?WklDR09ub29Qa3VDSklyQkQ4bUxsdkVsT09jeEV3dS9MTnRjYWxJaU1rKzZa?=
 =?utf-8?B?cU9mMkk4MHlkN29QQm5hOTI2TDN4WHhsN29OTlpLRzlQcTVtbm5CVTVJeXhm?=
 =?utf-8?B?TlRyWEc2ZGZ4OURSa3dOLzltVUdnN1g1MllGb3VFYmV5QXdpU2Q4MmNUaWxT?=
 =?utf-8?B?Y0swS2VLVFNSUlBWNFlmcXNIc2JsM0lLeWFEZUFRVGNDNGJ3TVZER3BsOVpM?=
 =?utf-8?B?V1BuSGZyL3BmU0Y1VzJ6ZStva21sU1cvRE9VOER5VEF6VlkwUnN6YVEzMVpm?=
 =?utf-8?B?VlBNMnIrOGd5bkVQZnUvUElEL2g4OWtYTkdscnp2ZUdsSVc5U2x6Rkx3Zi9G?=
 =?utf-8?B?cjVUc043UHFqWTdMcldPT0E2LzVUOUdZSjZOVGY3OWJLZlZOM2JGcTI0cFpL?=
 =?utf-8?B?Y2dyOEl1dFZidXVnam8wN1hCNHNZcE9tSHBZN0pnZlNPRGlqV2JnbHlFOVhM?=
 =?utf-8?B?SnNhNjM1NjN2cDFWNzNIb2tCR0ErMXc4RVA0VUpxdHo1THhOdUdmcG1hWXlr?=
 =?utf-8?B?RzNiTUpvNlNKNFNUSDFWVEE3ekhGOCtZdXY3a2xhUW0rMFVjc3BDcHdCU1pt?=
 =?utf-8?B?cnlXT091V0lIWmpWRFk4TmVNMURRNzV1YnFyR1g0Z2Uza0Z0QXd0OExpMU5Z?=
 =?utf-8?B?OFhDeW9RWFNoaTBTSDRja3E3bEtVc0dXdTBBcExOMDlicFJxeTdFRjNxajNU?=
 =?utf-8?B?M2N6NjhNUGlJdDQ1Ry9vQk9xc1FGV0svd1d2eEJ5YmorSXVhQ3E1Qyt1VVor?=
 =?utf-8?B?b2pxc0svaFpyT2ZpRitSTVhyc1ZvUThZSEZtNFgxWXJDazZhcG9yNkc5MFpu?=
 =?utf-8?B?TG9uU2VFM1NBTEhXSXllQ2FaZVdHMkR1cjVIbVd0Zlc3SlVEcVJsTEttV1NU?=
 =?utf-8?B?eTRrWE9Ycm03bHYrK1QrVTJhaTFxazhhQUVGeGlIZ0ZLM3N4SjF5bkhNbFpT?=
 =?utf-8?B?eC9Sb2RBUUF2R2drL0FIM1RHQk1pdHN4UDBXRzVkcUVGcmtRenFnY1J1R2pU?=
 =?utf-8?B?U1d5TS83MHNhTWFkc3M2d3k0RTMzbzhqMGE1YkJVWkQySEgxUWhjTWRyQjFZ?=
 =?utf-8?B?WVcxV1Z1UW82cHlmeVA0dXV5UGpRMUNHWWVZVVl1VVJtZnQ2VEh0S0xnQUZW?=
 =?utf-8?B?RmxEMzl5bVJqNWNPOWR2QjVCbDlxVDNjTFpMWWFvQVVHeTBuTXBMQVVaVEFx?=
 =?utf-8?B?YXQwNmtmZ3M3cE5odmpDbzY3dWFlNWkyTVFycWdjQ3FEOHoyT2NSVk9QUFJL?=
 =?utf-8?B?aUlpSTNYdDVPM2o4eDJtTk5aYVhqMFRUdzZtc20vaE1WczFJUWxjV24rc3RV?=
 =?utf-8?B?Y01Fa0YwaVlmblEyY05KbWZCWlY2T1BoMzRXOEJPMGd4alJFUEV2ZEdMRFRL?=
 =?utf-8?B?L3ZsaEtDQUpaeUNuVzRnYVNXaVZwTjhMR0lENkhPSDJSY01Udi8rQjh1RGRD?=
 =?utf-8?B?L3d5RVZjcC9URU9vT3c2V3Vsb295WmZnT2JuTzh5NXBQWHlDaW0zVGJCRjhD?=
 =?utf-8?B?OTJ4ZzNEYkF1bzhla3Fxa1J6dlZNMFh5UDhmVy9BZ29IQ0tTaEs4VStnQ3VM?=
 =?utf-8?B?T3Bya252ajZ1ZTdUenZtWExCcTNqK01oUzVhS282WlFMdDJjMy9LclZVNzVT?=
 =?utf-8?B?c2JhWCs1Q25QNnBzbm44aUVvMmhRRVlIZWJ4OU1kbHBkZUpnRjYwNHhQUVZn?=
 =?utf-8?B?VGVnVHhuSzcydGpEeFRMRjY1MGJGWTFCZWh2cDhEeVM0NjhFTGo0YXFzczEv?=
 =?utf-8?B?ZWpnWVhObGpSbnQ2OEgyekZYSVRaK0hCS3NCellWYXlOdWJHTm9tR1FPaGJG?=
 =?utf-8?B?dTZRckVKRWVwbGZUbmdXZjRTTEhMaHgrbUZ1MHc1SU04anEvNHQzeHB3bFh2?=
 =?utf-8?B?Y0FKRUVkMlBDME9ZVkR6NHhJSmJJRHljWXFUbjdVOHFOaWprVkFrZTN1ZW9r?=
 =?utf-8?B?L0FiYkFjZjg2alc3TkE2Um5LTjVwMytQdVp1dmZidlRQSDY4RisvSlhYcWZ1?=
 =?utf-8?B?YS9WVm5WVDBPbk9Pc2pYcHhEelNvakNsQmxCOUdTc2xNMHJoVnBMM1kvVnFE?=
 =?utf-8?Q?JpT2Taki3YdV0kJbhajjBP0tv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be75694-822a-4bdf-6fba-08dd04dbec47
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 18:41:16.7057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jv282yM/i98ukDgauCJawavJQEsa37pfORUeJpD4hZRQYvVhjOIGiCMNXMst703YZbFd/6cjXPhULfTHDmdFhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734

Hi Lukas,

I added comments below.

On 11/14/2024 10:44 AM, Lukas Wunner wrote:
> On Wed, Nov 13, 2024 at 03:54:19PM -0600, Terry Bowman wrote:
>> @@ -1115,8 +1131,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>  
>>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>>  {
>> -	cxl_handle_error(dev, info);
>> -	pci_aer_handle_error(dev, info);
>> +	if (is_internal_error(info) && handles_cxl_errors(dev))
>> +		cxl_handle_error(dev, info);
>> +	else
>> +		pci_aer_handle_error(dev, info);
>> +
>>  	pci_dev_put(dev);
>>  }
> If you just do this at the top of cxl_handle_error()...
>
> 	if (!is_internal_error(info))
> 		return;
>
> ...you avoid the need to move is_internal_error() around and the
> patch becomes simpler and easier to review.

If is_internal_error()==0, then pci_aer_handle_error() should be called to process the PCIe error. Your suggestion would require returning a value from cxl_handle_error(). And then more "if" logic would be required for the cxl_handle_error() return value. Should both is_internal_error() and handles_cxl_errors()be moved into cxl_handle_error()? Would give this:

 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
-	cxl_handle_error(dev, info);
-	pci_aer_handle_error(dev, info);
+	if (!cxl_handle_error(dev, info))
+		pci_aer_handle_error(dev, info);
+
 	pci_dev_put(dev);
 }

>
>> The AER service driver supports handling downstream port protocol errors in
>> restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
>> functionality for CXL PCIe ports operating in virtual hierarchy (VH)
>> mode.[1]
> This is somewhat minor but by convention, patches in the PCI subsystem
> adhere to spec language and capitalization, e.g. "Downstream Port"
> instead of "downstream port".  Makes it easier to connect the commit
> message or code comments to the spec.  So maybe you want to consider
> that if/when respinning.
>
> Thanks,
>
> Lukas
Thanks for pointing that out. I'll update as you suggest.

Regards,
Terry

