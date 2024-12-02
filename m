Return-Path: <linux-pci+bounces-17507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42329DFBCE
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 09:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A628B206B5
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 08:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8271F943D;
	Mon,  2 Dec 2024 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dP0bGTi4"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544761D6DDC;
	Mon,  2 Dec 2024 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733127830; cv=fail; b=iZRbjP59AnycwzbfUWzyTYwOiSIgm3xKZGL/WEGqiZzJABGKOZukuAIU8YMLgX/tztO7JU7Ob7709aFtEk/P95JOSHaVoAZkZ8HD5Mi/Zg1HtbrB9cVwtMwRwr3x+ROZXZEICtBJrO6cUQoapShLLqgiSNk8guY5/tfEZ4ax/Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733127830; c=relaxed/simple;
	bh=7vAT7KF8G+ZfOdYA81G4HNBhaFrCad3gwLNFAlrf6uQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nDY/2XvPQvXzojyBmZ0XcsM54ojV18jy6U+4Gp9G3nfAaRkCT/3VVsjxfhKXJQsSgM38W5edljoXE9W3vqnW15bJpCSDljHYmkNe01V+blolPYe4rNEp9g086JrniWP7xYAzV+ibJd0E5VFOJjD8FTG3VGuK+/7wFT+s8yTI/KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dP0bGTi4; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzwIewIUCULP62uvPwqw6BXMNFixvbO0l5s//E50sCakgnEd8HNtgv7NqkToQoVsYqKYVwn/dhrnQfIwX8Leg+DHiRr9StXWZz4GhioISAX5uGElR1oIopEHC3/QSwTCgmqYkMXEfXtLo9GFO2k0uDndsqSv+0qAS3Rxe0yY/wAsYWrQntX2wJxeI9WwN0YJF4bN1B5kgzURr8ZG+iA0gPTOs3oRtzd7teLZIdg3U5M+IsyfTTMWeLX9eUFMwE/T+rdi1NKPbOdTafNIYS5lS67f25U94mDENl4T37jedDq/961D5CsIppTQgPSMKdJLBxJl3ZJ7VgfBKoy48PAyaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vAT7KF8G+ZfOdYA81G4HNBhaFrCad3gwLNFAlrf6uQ=;
 b=jAvAgsfEv+kep4TSHbTcou/FbYaAsWM+6LBtJsSkFqk+j0amG69wFMpFMk5evD3r32VWhJI7WMF69/OK7fTpx4Qo9Bo7n50baRkfGJ7CQelD48ea0+Q3WQTYBDTInPsX1JzWfZaUNmQgrUZ84K61WxEXxWh6p7HcBg++RFaYx2BbAruxOzoXMOEjcyHHZS5peq0hr2pN5SSJh3GlKcrrrnjzSxn2MfZTwBN3W93RdOVOWCgb+0fh2egLov/B6kFiiFhlTELHGEnoqKkC69biOmPkUhUmsDlDncZRSqVssbT9J+nQMF3FF0aXRoA3Y3r4M8Qs2lSCXW57Gir6cvQpEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vAT7KF8G+ZfOdYA81G4HNBhaFrCad3gwLNFAlrf6uQ=;
 b=dP0bGTi4fRnVJozz1u9eRcea8cn8RlwMqNtNYusWJbH5KQivM5NE9zTGeiPU5VXb4L8TbDdZ72Ib/G/RchPH1qXl0P5KVtQzYtTio4+r/gNyPr3QL5bDK+oqJD2qIvh3+rXJB3ClymYENCd5dugb0cixYbX+haYDs/qLx/5a7es=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by LV2PR12MB5943.namprd12.prod.outlook.com (2603:10b6:408:170::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 2 Dec
 2024 08:23:45 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%6]) with mapi id 15.20.8207.014; Mon, 2 Dec 2024
 08:23:45 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "Simek, Michal"
	<michal.simek@amd.com>, "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH 1/2] dt-bindings: PCI: amd-mdb: Add YAML schemas for AMD
 Versal2 MDB PCIe Root Port Bridge
Thread-Topic: [PATCH 1/2] dt-bindings: PCI: amd-mdb: Add YAML schemas for AMD
 Versal2 MDB PCIe Root Port Bridge
Thread-Index: AQHbQMO9dKIOYUVRykyHGLADchVgbLLMTMoAgAZYKTA=
Date: Mon, 2 Dec 2024 08:23:45 +0000
Message-ID:
 <SN7PR12MB72017A95DFE6F4B2EF09123B8B352@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20241127115804.2046576-1-thippeswamy.havalige@amd.com>
 <20241127115804.2046576-2-thippeswamy.havalige@amd.com>
 <3xbfuwqxwflmnonziwgnt4rmdlquqmpyrvzzqvvogv6j64y3as@zuppsixhsd52>
In-Reply-To: <3xbfuwqxwflmnonziwgnt4rmdlquqmpyrvzzqvvogv6j64y3as@zuppsixhsd52>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|LV2PR12MB5943:EE_
x-ms-office365-filtering-correlation-id: ca4efaf8-0cbb-4365-bd04-08dd12aaa37a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a3FBbDFkV3djM2Fib1pucGx2Ny9MU205dmtyYmJudHFadStLblYybzdEVW9C?=
 =?utf-8?B?Rk8vSmpZRXdySmhPR0VXUEV6YjNTbVJhQXFPK01ObWY4SENjaVhlRUFRY3lT?=
 =?utf-8?B?Q3gzcTRyK1lrVDZXT2h4azMxb1lDN3hHWGxVRXFvZXpYc08xQ3Q5eDZ3Ylo3?=
 =?utf-8?B?aEJNdzFDaWZPa3FvL2hGZ1VHSTZxTEN6UjFmeC9NWGMyaWRjR2NKTXhqMzRX?=
 =?utf-8?B?VWUzTFBBdkFVaWpGMzlrdmxHSzBoVFBXb2NHeS9TVlFRODFxd0VoNWZBWVhs?=
 =?utf-8?B?bVo2V0lKdWo0aTRNcjR4NEoxMTMxNStVOGRHUVV0cVNtbGNraVZ4aitMUHd2?=
 =?utf-8?B?VGhmTTRhcnBjN2o3N0gzcWFRNFRBWDRkQmdSOEcwOVlabHlFKzRTMWx4U0Vt?=
 =?utf-8?B?SFE5dUdxQ2FwWWt6bjNTSWFwSVM3S1p3Z013dzhCNDM3OG1aSDRZdzVGdlN5?=
 =?utf-8?B?TXJqUXRxaGMzcUc1dXkxZzhwSTU5b3Jzby9hUk1MRFZFem1PU09uVVRVUEJk?=
 =?utf-8?B?L3N4WjZBNkFNTmcwSmFTeFp0VFpEMSthZVRhSWtDNWdJdEhNZ1FPcU9SaVA3?=
 =?utf-8?B?OTl5WHZWd2FaaWFPc2cxYTNyQTc5MVpVYlNMRTJFVjJLdEt5RHNvU1lCVEVh?=
 =?utf-8?B?SlBmQ2VDZlZlc3NmQnJYUy91TGl0cmlGK2JobVNJc0FIOTZRK0l1M3lxZlha?=
 =?utf-8?B?Um02K1lnZlRRN3dSV05Wd01yU2xzSHRlS3pTaUk4d1ZURzNwNldpUjZCWitw?=
 =?utf-8?B?QmxHVURva3FRYithUlQ3TzllMjZkdnd6RHdjOVc0ZGhRcVZ4bTlFMnVtQkhI?=
 =?utf-8?B?MnZOVWN3aitZZE54akdVQnN1bDVGZ3dweWtUemhlTFY5TGJEVzNLbTYzdXhF?=
 =?utf-8?B?eXFZdW9pRHdmd2hMdytWQWdmbU5Jb2pXSjRIdXJsMkhzN0VQdDJCdFZlMmxo?=
 =?utf-8?B?NDFOMTN1dFBoRklBVlRxSHhiR2xQUWQrbEdzRkxlTmQ2SFZpaXdyblpHQ3or?=
 =?utf-8?B?cTdkRUo2UkhOUUU1QWVpZUpFWDFGYzlaR0RMZnpuS1RrVFpSY3ZNQ1h4U252?=
 =?utf-8?B?WmVJYUxTZ0dhdjJGNnR1MFRLOHZTL3d5TU4wMldsdVZyM0hMdjZjd091SXJn?=
 =?utf-8?B?VFJjTkIrYUFoUnRFZzJyVTVnS3RqNmN2U2s2SW4wZFpQME9mODlFa1Q4Wnp1?=
 =?utf-8?B?ZU5uZllBbVVzQVBsbTNLT3NqNUpaeUJyaWU0cHI3c3VZcEhCU0JGejFlN2J1?=
 =?utf-8?B?YUMwTmJCd3EyY3RYMG55dkpwVnVmRjJFUzU3RndIK1JVaVhJdGRFc2dVQzBE?=
 =?utf-8?B?YWIzSWRFYVpIZWMrOThMTllPNjJ2bHVGVHdaakxESGVINGtRRlowRkUyNnNv?=
 =?utf-8?B?K1pVNDViRlBEYjZWWnMyLyt0d0J5K25WZ3dRZS82QXdqaW5QYWFFbTRpb2hi?=
 =?utf-8?B?ZUhOQ0lZNCtaU0l6SVFFWXAzVFJsOWlzYWRQQ3FYOGtSK3hscGlKWm5xWCtt?=
 =?utf-8?B?NTJGR0NzelhhRnBQdDE0L2dBblVwSjR4SjdyTGlPUko5bnFQVEVLNzlpUFBp?=
 =?utf-8?B?bzA4U0Z5L1pnNlQ5UEFSVHd3aG12YWU3ZmxQbVNxUWpXOE0wRWE3TnNNUk9N?=
 =?utf-8?B?dmNVUXllZkdvSlBjSnViY1ZnV3c1a3ByMTYwUExCTWR2emMyVDUzSzFyTXdN?=
 =?utf-8?B?L2JrMkhralhZWUVtdFJwS0pTaFhzTkhjbkV3QS9LUDFDMzBmNTFlRTJNNHBa?=
 =?utf-8?B?R1dGSE9tWnNsaVlQQ0N3SkJ4OFVwQWtLQ0g0YlBaT1hNZjVuT2dsWG9mRW5Y?=
 =?utf-8?Q?1/nd60XlV7GK0S/ouk6EZfq8Qy0aRexubUDCw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDZ6cXlxVlJ4dXYvTnVRbkw5cUM3OHk4eTIyWno1dFB0Z0RITUoySldveWF5?=
 =?utf-8?B?S3ArKzcxS0JTTXpkdjc4aGoxcGwrM2lUWEVWcm52NllNODkraUtienFOVDhp?=
 =?utf-8?B?SkgzTmVzNWtDK0xNWnRZeUZraU5iR0wxWldmR1VNQVJyV1k5U2k5NXBseFpK?=
 =?utf-8?B?MWVEVnczRTkzM1FOSTI0SVBsRVlXLzI1Z0I4MGUwQWV5cWJUYVFyUHM2RlVO?=
 =?utf-8?B?R1paUXF0cjBXc2hZMFg2T3Baejh4enJFbnI1dXJqQSt5b2hKV05pdVpQaUUr?=
 =?utf-8?B?U2l1QmZPcUFpTkJXTUxTUnZyMGdJc2NVUG93ZWJCTHMzd0w2d3lmYXR6d3BT?=
 =?utf-8?B?QzBaZHo5T0xXTjhaN210cXJoaU5TT1V6dFRYZGJDeEM2bzNRc0R6anF2OGky?=
 =?utf-8?B?VTJQbW16aTgyMWRmaGt4TUxXODlnamhSSFFOWDJ4dmN6S05IU0tHUmpvWWtL?=
 =?utf-8?B?UFNtZnBwYzJkUzhDNDJ5bCtPWUNZNzkyNUROVWwzeUlTbnJxUVFoM1NLZjVt?=
 =?utf-8?B?YmpuVGx2RTJGZUZWS0dPbGU5bThDd1l1TTJ2aXowanJFNWRmdmJMbUFKa1U4?=
 =?utf-8?B?NldDTUVSZUFvRXFTRHdHVG9DTVVpNnZCREdPbGM4dFQ0WmNiUE95QWZVZmNK?=
 =?utf-8?B?TW5IaDQ1UmxJcGVKV2R1cVlSR2NPckZVVjJmd3MwZ3dwQkZEM2Z4MFhZOHJP?=
 =?utf-8?B?R080VWtLZ0l0SGlRNzUwZWlSeitiVmI1WDQ1MnJmc0R4WFlLSDlwRGRLZjk3?=
 =?utf-8?B?clI1bXNtZWs3c1hzWit4QXVBRStMRGtXU3FrS1J2eEdvS0lWVTZ2b1Y1WDlH?=
 =?utf-8?B?UVZUNHlCTUJQZExQMFB1ekN0aDdNRDd1S3R3RHNJTFNWajhYN2lZeVdBczFq?=
 =?utf-8?B?S3BUMll5VUw0YmcxYWt0ZVBFb1ZZL2J1d1BBOFl4YkZ6WDhvaXFVZHN1Qklr?=
 =?utf-8?B?U3JyVlpPTWl6STBIUXlsSmNZb1BXcm9xVkowTnMxWENUSmMvM2JNZHFCaGRo?=
 =?utf-8?B?WEE3a2ZvOUdoa3FjM0kyWkRLZHp4dDZEUEYrdFovbGJNcUxiY1BBK2RYVU9p?=
 =?utf-8?B?OHFZNEdtL2JYQWtnVEhVVkd4dFBKbHJOSnJDUnR0alFOb1N2UlQ2Yjg3ZWNo?=
 =?utf-8?B?dzkyV1BXbzYvYXpmK1p1MTlJMXNmWkZZcllVbVVaVUxlWmxFMkZybVpyZW1Y?=
 =?utf-8?B?UDluWWI2SUJGWHVoNkwyZ1RveE5uYlRYQXU5cDZGbnBpWGhya1ovSHR5eHVh?=
 =?utf-8?B?VkZuWmZSYjNIYUgrL01xM2h0WGRXWCtUR3I3NUd2bU4rdmFjQXNNaUl3bkFZ?=
 =?utf-8?B?L3EwTFdLdy9Gai9lbWI3VjVLR042TlhRdmVXcHNGQVBFOVNrejg2NzdJTUht?=
 =?utf-8?B?Zy9DVVAvc1d4VUhOS21GbzV4ejFHK0ZsTGt3ZGpRSUwvd3RGTHJhdzI1K2M5?=
 =?utf-8?B?MmJ4enVGUEx2dWhhZ205Mkx3RW9FeEk2MUpuNThKLzRwUkNmTHZsbmo1U0hK?=
 =?utf-8?B?S0EwTFJBYXUzOTcxVWthWENHQXpCZFVBZ0Q1MlZKcjVJTzkvOTBDbll2dmI5?=
 =?utf-8?B?OWxwaFBoZVJZbmdIamU3TlFFNVZHUHpXMkNDYzB5cjBFQzRUUEVWVzdSMFpT?=
 =?utf-8?B?cFRYNDNwUW5qdU4yUzduRGJmN0hnT3g3Wno5N3Bub0VzbDQ0anhZYzNuQjJW?=
 =?utf-8?B?YUxtK01pNWJMY2ZLNng4Qm9FTEdCM292UWtVQmtNMnZtU0VSbU0yMWRPUGho?=
 =?utf-8?B?eUlPMDJyZlpWUzRnY2ZENzd1b0QyRTVFTkZQVXdEUXZLZ1A5NW5nOW9mVDhL?=
 =?utf-8?B?L1p3NVh0OGZHRmFlZjhIT2RJRlRLNmJ0WTI0N0xTYVc0V3NOSEtHRHZEa3Jz?=
 =?utf-8?B?c2RkVHRiM0NSUmNSR3RLK0x2WnJsaDI4Z0FNRVcyL09FZDFndjJYU3UzNUJs?=
 =?utf-8?B?dXdybFVuUDdEdFFxWlQrU1NZRDZiRlpGVmZ2cGh5M2JRTURndlNwOGRXZXhN?=
 =?utf-8?B?NDBJS2luZFZvQmhuMHgwSmdVTVFjdTljRUV2RGVrT3VIdDdnanYxdlRTVVZ2?=
 =?utf-8?B?OVR3dlFQTmhENEZuQzBOVmgrRHhwbnZVL0kwa055OFJhcHhsL0Y2TnNTWmJR?=
 =?utf-8?Q?HgWw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4efaf8-0cbb-4365-bd04-08dd12aaa37a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 08:23:45.2919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BGx64RFWV1uqcQSC8I/sM2/sjsFGmNpmuUxYo+OmdEEdWb9sT8LSrqf1pImE/Q++Zr42A0GSqe5EzRn3WE88nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBOb3ZlbWJlciAyOCwgMjAyNCAxMjo1OSBQTQ0KPiBUbzogSGF2YWxpZ2UsIFRoaXBw
ZXN3YW15IDx0aGlwcGVzd2FteS5oYXZhbGlnZUBhbWQuY29tPg0KPiBDYzogYmhlbGdhYXNAZ29v
Z2xlLmNvbTsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOyBrd0BsaW51eC5jb207DQo+IG1hbml2YW5u
YW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnOyByb2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVs
Lm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBqaW5nb29oYW4xQGdtYWlsLmNvbTsgU2ltZWssIE1pY2hhbA0KPiA8bWljaGFsLnNpbWVr
QGFtZC5jb20+OyBHb2dhZGEsIEJoYXJhdCBLdW1hcg0KPiA8YmhhcmF0Lmt1bWFyLmdvZ2FkYUBh
bWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IFBDSTogYW1k
LW1kYjogQWRkIFlBTUwgc2NoZW1hcyBmb3IgQU1EDQo+IFZlcnNhbDIgTURCIFBDSWUgUm9vdCBQ
b3J0IEJyaWRnZQ0KPiANCj4gT24gV2VkLCBOb3YgMjcsIDIwMjQgYXQgMDU6Mjg6MDNQTSArMDUz
MCwgVGhpcHBlc3dhbXkgSGF2YWxpZ2Ugd3JvdGU6DQo+ID4gQWRkIFlBTUwgZHRzY2hlbWFzIG9m
IEFNRCBWZXJzYWwyIE1EQiAoTXVsdGltZWRpYSBETUEgQnJpZGdlKSBQQ0llIFJvb3QNCj4gPiBQ
b3J0IEJyaWRnZSBkdCBiaW5kaW5nLg0KPiANCj4gQSBuaXQsIHN1YmplY3Q6IGRyb3Agc2Vjb25k
L2xhc3QsIHJlZHVuZGFudCAiWUFNTCBzY2hlbWFzIGZvciIuIFRoZQ0KPiAiZHQtYmluZGluZ3Mi
IHByZWZpeCBpcyBhbHJlYWR5IHN0YXRpbmcgdGhhdCB0aGVzZSBhcmUgc2NoZW1hcywgY2Fubm90
DQo+IGJlIGFueXRoaW5nIGVsc2UuDQo+IFNlZSBhbHNvOg0KPiBodHRwczovL2VsaXhpci5ib290
bGluLmNvbS9saW51eC92Ni43LQ0KPiByYzgvc291cmNlL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0I0wxOA0KVGhhbmtzIGZvciByZXZpZXcs
IGxsIHVwZGF0ZSBpbiBuZXh0IHBhdGNoLg0KPiANCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBUaGlwcGVzd2FteSBIYXZhbGlnZSA8dGhpcHBlc3dhbXkuaGF2YWxpZ2VAYW1kLmNvbT4NCj4g
PiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2FtZCxtZGItcGNpZS55YW1s
IHwgMTMyICsrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTMyIGluc2Vy
dGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9wY2kvYW1kLG1kYi1wY2llLnlhbWwNCj4gDQo+IE5vcGUsIHVzZSBjb21wYXRp
YmxlIGFzIGZpbGVuYW1lLg0KVGhhbmtzIGZvciByZXZpZXcsIGxsIHVwZGF0ZSBpbiBuZXh0IHBh
dGNoLg0KPiANCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcGNpL2FtZCxtZGItcGNpZS55YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3BjaS9hbWQsbWRiLXBjaWUueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAw
NjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5hZDllNDQ3ZTg3ZjINCj4gPiAtLS0gL2Rldi9u
dWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9hbWQs
bWRiLXBjaWUueWFtbA0KPiA+IEBAIC0wLDAgKzEsMTMyIEBADQo+ID4gKyMgU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiA+ICslWUFNTCAx
LjINCj4gPiArLS0tDQo+ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvcGNp
L2FtZCxtZGItcGNpZS55YW1sIw0KPiA+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcv
bWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPiArDQo+ID4gK3RpdGxlOiBBTUQgdmVyc2FsMiBN
REIoTXVsdGltZWRpYSBETUEgQnJpZGdlKSBIb3N0IENvbnRyb2xsZXIgZGV2aWNlIHRyZWUNCj4g
DQo+IERyb3AgImRldmljZSB0cmVlIi4gVGhpcyBpcyBhYm91dCBoYXJkd2FyZS4gQWxzbywgInZl
cnNhbDIiIG9yDQo+ICJWZXJzYWwyIj8gSnVzdCBrZWVwICpjb25zaXN0ZW50KiBpbiBhbGwgQU1E
IHBhdGNoc2V0cy4NClRoYW5rcyBmb3IgcmV2aWV3LCBsbCB1cGRhdGUgaW4gbmV4dCBwYXRjaC4N
Cj4gDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIFRoaXBwZXN3YW15IEhhdmFs
aWdlIDx0aGlwcGVzd2FteS5oYXZhbGlnZUBhbWQuY29tPg0KPiA+ICsNCj4gPiArcHJvcGVydGll
czoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgY29uc3Q6IGFtZCx2ZXJzYWwyLW1kYi1o
b3N0DQo+ID4gKw0KPiA+ICsgIHJlZzoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGRl
c2NyaXB0aW9uOiBNREIgUENJZSBjb250cm9sbGVyIDAgU0xDUg0KPiA+ICsgICAgICAtIGRlc2Ny
aXB0aW9uOiBjb25maWd1cmF0aW9uIHJlZ2lvbg0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBk
YXRhIGJ1cyBpbnRlcmZhY2UNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogYWRkcmVzcyB0cmFu
c2xhdGlvbiB1bml0IHJlZ2lzdGVyDQo+ID4gKw0KPiA+ICsgIHJlZy1uYW1lczoNCj4gPiArICAg
IGl0ZW1zOg0KPiA+ICsgICAgICAtIGNvbnN0OiBtZGJfcGNpZV9zbGNyDQo+ID4gKyAgICAgIC0g
Y29uc3Q6IGNvbmZpZw0KPiA+ICsgICAgICAtIGNvbnN0OiBkYmkNCj4gPiArICAgICAgLSBjb25z
dDogYXR1DQo+ID4gKw0KPiA+ICsgIHJhbmdlczoNCj4gPiArICAgIG1heEl0ZW1zOiAyDQo+ID4g
Kw0KPiA+ICsgIG1zaS1tYXA6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBi
dXMtcmFuZ2U6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICAiI2FkZHJlc3Mt
Y2VsbHMiOg0KPiA+ICsgICAgY29uc3Q6IDMNCj4gPiArDQo+ID4gKyAgIiNzaXplLWNlbGxzIjoN
Cj4gPiArICAgIGNvbnN0OiAyDQo+ID4gKw0KPiA+ICsgIGRldmljZV90eXBlOg0KPiA+ICsgICAg
Y29uc3Q6IHBjaQ0KPiANCj4gSSB0aGluayB5b3UgbWlzcyByZWZlcmVuY2luZyBzY2hlbWEuIFdo
eSBzdGFuZGFyZCBQQ0kgcHJvcGVydGllcyBhcmUNCj4gaGVyZT8NClRoYW5rcyBmb3IgcmV2aWV3
LCBsbCB1cGRhdGUgaW4gbmV4dCBwYXRjaC4NCj4gDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdHM6
DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBpbnRlcnJ1cHQtbWFwLW1hc2s6
DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBjb25zdDogMA0KPiA+ICsgICAgICAtIGNv
bnN0OiAwDQo+ID4gKyAgICAgIC0gY29uc3Q6IDANCj4gPiArICAgICAgLSBjb25zdDogNw0KPiA+
ICsNCj4gPiArICBpbnRlcnJ1cHQtbWFwOg0KPiA+ICsgICAgbWF4SXRlbXM6IDQNCj4gPiArDQo+
ID4gKyAgIiNpbnRlcnJ1cHQtY2VsbHMiOg0KPiA+ICsgICAgY29uc3Q6IDENCj4gPiArDQo+ID4g
KyAgaW50ZXJydXB0LWNvbnRyb2xsZXI6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogSW50ZXJydXB0
IGNvbnRyb2xsZXIgbm9kZSBmb3IgaGFuZGxpbmcgbGVnYWN5IFBDSSBpbnRlcnJ1cHRzLg0KPiAN
Cj4gV2h5IHRoZSBsZWdhY3kgaXMgbmVlZGVkPyBUaGlzIGlzIGEgbmV3IGJpbmRpbmcgYW5kIG5l
dyBkZXZpY2UuDQpUaGFua3MgZm9yIHJldmlldywgbGwgdXBkYXRlIGluIG5leHQgcGF0Y2guDQo+
IA0KPiA+ICsgICAgdHlwZTogb2JqZWN0DQo+ID4gKyAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAg
ICBpbnRlcnJ1cHQtY29udHJvbGxlcjogdHJ1ZQ0KPiA+ICsNCj4gPiArICAgICAgIiNhZGRyZXNz
LWNlbGxzIjoNCj4gPiArICAgICAgICBjb25zdDogMA0KPiA+ICsNCj4gPiArICAgICAgIiNpbnRl
cnJ1cHQtY2VsbHMiOg0KPiA+ICsgICAgICAgIGNvbnN0OiAxDQo+ID4gKw0KPiA+ICsgICAgcmVx
dWlyZWQ6DQo+ID4gKyAgICAgIC0gaW50ZXJydXB0LWNvbnRyb2xsZXINCj4gPiArICAgICAgLSAi
I2FkZHJlc3MtY2VsbHMiDQo+ID4gKyAgICAgIC0gIiNpbnRlcnJ1cHQtY2VsbHMiDQo+ID4gKw0K
PiA+ICsgICAgYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+ICtyZXF1aXJl
ZDoNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gcmVnLW5hbWVzDQo+ID4gKyAgLSBpbnRlcnJ1cHRz
DQo+ID4gKyAgLSBpbnRlcnJ1cHQtbWFwDQo+ID4gKyAgLSBpbnRlcnJ1cHQtbWFwLW1hc2sNCj4g
PiArICAtIG1zaS1tYXANCj4gPiArICAtIHJhbmdlcw0KPiA+ICsgIC0gIiNpbnRlcnJ1cHQtY2Vs
bHMiDQo+ID4gKyAgLSBpbnRlcnJ1cHQtY29udHJvbGxlcg0KPiA+ICsNCj4gPiArdW5ldmFsdWF0
ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPiANCj4gWW91IGRvIG5vdCBoYXZlIGFueSAkcmVmLCBzbyB0
aGlzIHdvdWxkIG5vdCBiZSBjb3JyZWN0LCBidXQgT1RPSCB0aGlzDQo+IHBvaW50cyBleGFjdGx5
IHRvIG1pc3NpbmcgJHJlZi4NClRoYW5rcyBmb3IgcmV2aWV3LCBsbCB1cGRhdGUgaW4gbmV4dCBw
YXRjaC4NCj4gDQo+ID4gKw0KPiA+ICtleGFtcGxlczoNCj4gPiArDQo+ID4gKyAgLSB8DQo+ID4g
KyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5o
Pg0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2ly
cS5oPg0KPiA+ICsNCj4gPiArICAgIHNvYyB7DQo+ID4gKyAgICAgICAgI2FkZHJlc3MtY2VsbHMg
PSA8Mj47DQo+ID4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gKyAgICAgICAgcGNp
QGVkOTMxMDAwIHsNCj4gPiArICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhbWQsdmVyc2FsMi1t
ZGItaG9zdCI7DQo+ID4gKyAgICAgICAgICAgIHJlZyA9IDwweDAgMHhlZDkzMTAwMCAweDAgMHgy
MDAwPiwNCj4gPiArICAgICAgICAgICAgICAgICAgPDB4MTAwMCAweDEwMDAwMCAweDAgMHhmZjAw
MDAwPiwNCj4gPiArICAgICAgICAgICAgICAgICAgPDB4MTAwMCAweDAgMHgwIDB4MTAwMDAwPiwN
Cj4gPiArICAgICAgICAgICAgICAgICAgPDB4MCAweGVkODYwMDAwIDB4MCAweDIwMDA+Ow0KPiA+
ICsgICAgICAgICAgICByZWctbmFtZXMgPSAibWRiX3BjaWVfc2xjciIsICJjb25maWciLCAiZGJp
IiwgImF0dSI7DQo+ID4gKyAgICAgICAgICAgIHJhbmdlcyA9IDwweDIwMDAwMDAgMHgwMCAweGE4
MDAwMDAwIDB4MDAgMHhhODAwMDAwMCAweDAwDQo+IDB4MTAwMDAwMDA+LA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICA8MHg0MzAwMDAwMCAweDExMDAgMHgwMCAweDExMDAgMHgwMCAweDAwIDB4
MTAwMDAwMD47DQo+ID4gKyAgICAgICAgICAgIGludGVycnVwdHMgPSA8MCAxOTggND47DQo+IA0K
PiBZb3UgaW5jbHVkZWQgaGVhZGVycyBzbyB1c2UgdGhlbS4NCj4gDQo+ID4gKyAgICAgICAgICAg
IGludGVycnVwdC1wYXJlbnQgPSA8JmdpYz47DQo+ID4gKyAgICAgICAgICAgIGludGVycnVwdC1t
YXAtbWFzayA9IDwwIDAgMCA3PjsNCj4gPiArICAgICAgICAgICAgaW50ZXJydXB0LW1hcCA9IDww
IDAgMCAxICZwY2llX2ludGNfMCAwPiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDwwIDAgMCAyICZwY2llX2ludGNfMCAxPiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDwwIDAgMCAzICZwY2llX2ludGNfMCAyPiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDwwIDAgMCA0ICZwY2llX2ludGNfMCAzPjsNCj4gPiArICAgICAgICAgICAgbXNpLW1h
cCA9IDwweDAgJmdpY19pdHMgMHgwMCAweDEwMDAwPjsNCj4gPiArICAgICAgICAgICAgI2FkZHJl
c3MtY2VsbHMgPSA8Mz47DQo+ID4gKyAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDI+Ow0KPiA+
ICsgICAgICAgICAgICAjaW50ZXJydXB0LWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICBk
ZXZpY2VfdHlwZSA9ICJwY2kiOw0KPiA+ICsgICAgICAgICAgICBwY2llX2ludGNfMDogaW50ZXJy
dXB0LWNvbnRyb2xsZXIgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxz
ID0gPDA+Ow0KPiANCj4gTWVzc2VkIGluZGVudGF0aW9uLg0KVGhhbmtzIGZvciByZXZpZXcsIGxs
IHVwZGF0ZSBpbiBuZXh0IHBhdGNoLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YN
Cg0KUmVnYXJkcywNClRoaXBwZXN3YW15IEgNCg0K

