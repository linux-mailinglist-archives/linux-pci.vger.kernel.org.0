Return-Path: <linux-pci+bounces-11156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2478E945717
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 06:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C0A1F242DE
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 04:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548971C2A3;
	Fri,  2 Aug 2024 04:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iQHT6o+K"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E04D3D68;
	Fri,  2 Aug 2024 04:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722572971; cv=fail; b=Wpsq0zBtkGssl2ar0R+LDynfptdkXhDkrPBBzvAXAgC44m+kbgQcaMbUpAiU6ZdC0KbDXR7LgcMNkSvmJDAF799EpjfYuFYYFl5QM4q3CNtD2NlCeu+R12N/l+FS/SPuwbz/TdembNe0Pnh/xSF5bGQPqTLaLJuxDKrjq1X3U2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722572971; c=relaxed/simple;
	bh=NY1Pwm9QbiC/2ugtpxf1Anf6cvR9+QA/BcLCICxQ8FI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aewDtAETpwPhVjwEpAQHQBKqXzNsFEThcir/87n1p+7D76uWSJylk2pHMcw7Xvwd1G0lUXOf+6hEYWrR727emuywJ1PXcn9paHzSQMjtsqcRxZPFOUwQQdAIVIabvFq0k9zrvLPVKByjxOXn4IEokqGyVkbZCWPYmI/gDBCLK2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iQHT6o+K; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YA0j7lH//fDlfhMhUdjJ7ZArbemIIouAmID5QheTSAb6V2M96NYrtNaR+iveRKywLXm5FIJCMdha8x1xsFcTpswcWwd6cpGsjk1Wx9mTzgENcbMuy4zeW/BNcmOKN8EVdgKcAR0zH9xp5qsCRu9rn04ZeUU5hlGbgaEvZzMkwitWJ+PfyRMCHhLgAcJgE2ZsUW8rHoZYuAO1wAkgBKUadAg+4XVnrR58YMBY5pDF3UApRLm4U/ZalDhklbXM03+rrOhVTd/T4XeMaKyR/+rRUOvvS/DFCEuLQrJ0uvDy7uBRemphbD34xCIvJPS+1KcKRQRX+IxXW+75idSXJCfFNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS9+W2UpWh+oOtM49TSwhlLUAN3qsDvQvd8XDcDwPxQ=;
 b=frXKgGrXOqTCHH/5+sCAbvVTMXHRMoiFE8vIyOj5O1k1M/JZddWJGFoyEvWiGdECP9H8gjlp8QM8qb6McqCo3RBz0zyl5fMwn8h0RGunVJvZX18QdzT5qAZlryA9Spv9zp8J4zXnf4E/XGANgxhu5zSW/Wb7ekt/6xrunZbuHvKC7hCaiqYkUtoehq0Een9cMvkT/9zIkWjgcpAaoG9PF0mBkRv0P8jhleUIva426M1nYWcxH/XbRZ1DeBcqBcA0J13uaxi8HhPl1L+hDC0hJuSfVxYEPz6wJMGKUKMYx23r3zS+3v1SjizP1ETLE0zUzGP+vpEDqZJP0KLI9oAWxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS9+W2UpWh+oOtM49TSwhlLUAN3qsDvQvd8XDcDwPxQ=;
 b=iQHT6o+KdnbmMVYyUOA+DQNLDT5sK17ql6gAKKLMz23mdBF0PSN3oLhgdMZXcJpnurqjXtPpXDSWT2j20gmmv/CXr453+Co0H1xVH/pdLoyKr5CiiZGUWYxhxIv5H+5kILIxfucO0acg2uQKy297BagX1bS14yKZ8/ivybL4MiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by SJ1PR12MB6076.namprd12.prod.outlook.com (2603:10b6:a03:45d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 04:29:27 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%4]) with mapi id 15.20.7828.023; Fri, 2 Aug 2024
 04:29:26 +0000
Message-ID: <65f25d99-bf27-4521-944e-7ebfe3447a14@amd.com>
Date: Thu, 1 Aug 2024 23:29:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 04/10] PCI/TPH: Add pci=nostmode to force No ST Mode
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alex.williamson@redhat.com, gospo@broadcom.com, michael.chan@broadcom.com,
 ajit.khaparde@broadcom.com, somnath.kotur@broadcom.com,
 andrew.gospodarek@broadcom.com, manoj.panicker2@amd.com,
 Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev, horms@kernel.org,
 bagasdotme@gmail.com, bhelgaas@google.com
References: <20240723224408.GA779931@bhelgaas>
From: Wei Huang <wei.huang2@amd.com>
Content-Language: en-US
In-Reply-To: <20240723224408.GA779931@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0103.namprd11.prod.outlook.com
 (2603:10b6:806:d1::18) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|SJ1PR12MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: 952168f2-1b39-45ad-3dc9-08dcb2abb174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnBQcXk3cC81dHJsOEJpMW5FVVY3dlBxbnBWVkxSL2Q0UzBUM1ZVNDQ3bkFR?=
 =?utf-8?B?NXJZNWYzRDY4L0d5Umh5TlFpN0o1V1BHQ2dKSzRNTDBHMmRKOTY2MVlyWmpK?=
 =?utf-8?B?WkRFa0hDUklTaGYwSCs2Lzh6VncyYzNtQWpzdTNOb1YzQ1hab0tsOEpqQmha?=
 =?utf-8?B?MTJGd1Q1K3E5U2Ewekc2ckdzcDBJaFkvcm95RHN1d3BlelBUelhyczVpcmo3?=
 =?utf-8?B?QTQzZXVWaVducTRWbnNMVDQ5aEVuUGhYUzlaZkVob055cEpzNGZacVNIZGM5?=
 =?utf-8?B?Rkt4WmthS3I1aHBVVkhwaC84czRiTFYyejY0OTRkbFY3cDlOYVUrTkpFMUdV?=
 =?utf-8?B?aGdOL1NwZVEzOFM5M0VFTUtsT2xIeXlpakJ2MEZReUlPODFFckNFYndzbkRB?=
 =?utf-8?B?NEdLcjlRZ0dLcVJqMnhYWVBHOUNBVUlQY1ZXRG1mUzU1d3p4alkrLy9DN0tL?=
 =?utf-8?B?ekpKeEIrODFmVmVTWkVaV3pDQU9jREVwbVFUbjJrazFTVTJ1dTN4U1hwVzl4?=
 =?utf-8?B?WS9JVHNCbE8wY2NqRFZTRzFxa2RDRC9INE4rMkhBOXpzbWozb01CZllLRWkv?=
 =?utf-8?B?QXE0b2tmS0FmbTd4aFIrQWNaUTdYTXhLSWRNY3hZR2djVFJzdENZRkVLSzFC?=
 =?utf-8?B?QnV6TmdpaTdYbkhaTlJuTzF2VFpWTzVISng2Tm45cmhLRlF3bWplQUlndlFn?=
 =?utf-8?B?VlR1Rm5FTDRWSmppWXZGRkFyR3JNejZ5UmR4ZloxOVZKVUk4OVEvOGVxbzJB?=
 =?utf-8?B?MzRIYjdlUkRyZ1orWDlNMk4xNE80eTVxcElDRE5seDQxak4yS1pvdzRpcTZ3?=
 =?utf-8?B?c2hZQXIxRWs0VGV6TEVtT2h1Zlptc0ZJamZjaVZhUGgzK0YrL091R2JZNWJw?=
 =?utf-8?B?ZXhYUWdPZS9QYy9IYzB1QzdhMmdGQW81SWRjdmE2SFNMdzNTZUQxbktHUGF0?=
 =?utf-8?B?Tmp6eGNNY2dTVG14dFU2cXg1eld1TjBscVJRT3h0eXozazBRRkRMNllNc29a?=
 =?utf-8?B?NHJJbE9rZ2x2Y1o2cmN0cmZ4eU0xYTJQZDRHa3FVZ081eTVqbEkyMDNvWElK?=
 =?utf-8?B?b2xzMTM0eE1qMlFYczJLS0RSTDRYQjk0d3VqSjFtTStzeDZlTFl3bkJKUHA3?=
 =?utf-8?B?NzlOSi8xT29tWU9hVUFWZDQ0SzlIeFhOem9RU3oySGhIcGV6RCtOTFp4SjZW?=
 =?utf-8?B?WVE4amVGRXpTNnB6ZzY3OTM2WWxhbDlGZXczRjE2eko3RCtSaUltLzNObG00?=
 =?utf-8?B?eHJaL0tTS3ZrUlY3azVCTmFKYVRZa3pMU2duRktQOVY4WjJyQjQ1M3JUYlNQ?=
 =?utf-8?B?dXB4U1hjendXRk9DcGQ3OHBxaGtkcjdneU5XNkpyUDZXSEU2djQ1MklVYjVY?=
 =?utf-8?B?K0g3RVJyU25oeVIvM1RCdXBCdjRxWTI1ZWxHUTlnZU50b3A4Uk5Ed2ZWQUpR?=
 =?utf-8?B?ekJLQ3dIVkE1aWlmSFVzQTc4TUZsN1VwMWpsVVZIc3o0bEhqSml6MUVoMExk?=
 =?utf-8?B?c0gvTm4wM1NUVVcrbFkvdlpVUkY4ZEpwUU5NU0xBcFA1NXlWZFBqUmZBUnVX?=
 =?utf-8?B?UXV5RTRyQlRVakxTbFN6dTlXcG10Z0h1NWhpRS9tUEl1bmZ5b3lPdE1UYTF0?=
 =?utf-8?B?ZjFJRzN0amlkVGEvVnBTL255NUVrYVZtU3Q5TWZ1azl3bjBWL0RMbzdqdFBN?=
 =?utf-8?B?NmdJUzFRUDZEZEY2cEZ0VGNLYmJCM2VSZ0M5WFVQbC9iSFlsMSsvNHA2dy9w?=
 =?utf-8?B?SWtvemZuTlFXWFZ2MDFUQVFUZmFZb3oxRGJGb3ZFQTNvWFdXK0R1MEJ0S0hC?=
 =?utf-8?B?YTR0UVRSNzhwaFJWbEwxQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnR6ZkMwRG5wRnRpT2g3bXpMVXFhZ1ZRaVQ2S1JoYXY1UE1KODQzanJEM1lO?=
 =?utf-8?B?b1BqRFFWWXM1Ny9XWnB5UnBkZ2hrNzBRNlBYWCthbEQ4WW5DQzJoOHRGeUYz?=
 =?utf-8?B?cFpXMXU2cHlYMmdoUGRkY0JxMkIrYy8wVmpualNEeGVQR3NQY0V1QnlpOVc3?=
 =?utf-8?B?Q2NRd0FwTHVVUko3VTJoOENXMllHVmp6eS8wUFVnV3ZwbHAyd1dYZGt3dks0?=
 =?utf-8?B?Umw4MnN6YzlMRG1Xc0hUU1BpL1NDUGJPeWVUYnJrK1hMN0FqdzZwa3k1d2lC?=
 =?utf-8?B?bWxlTkVTZVA1MmVMVHFwWUNzTFB2TDZ4QVNoNnhQWko3QlhNT2FwQmh0VjE1?=
 =?utf-8?B?dUJKVGR2alpPV1JnVGF5Ryt6K2NJNWlLMHJ3RUk5R0w5UEx6MytRSUJnR0w2?=
 =?utf-8?B?ZzBmUVYxS1VnZWRIRVRhRVI2UFNscGFIUkhNVER3ZEZjUldZd3o1VW55anA3?=
 =?utf-8?B?VjgrUTdpY09HWFpwYW44T2VGRUxINFlIMjU1S0x2UWVuSVlVVmc4UzZpMENv?=
 =?utf-8?B?b3lzbkY1WmIweWxIazZKdVc2a3RaYVg5VnJvWmQ0VmRwdG5rN0JqN2RYaU8x?=
 =?utf-8?B?cjBMajJ3QXVkdCtVRHNROTVxdW1YWkxBRTF4NFhERXV6Znc4UXU4QTM2Z09G?=
 =?utf-8?B?N2JpYThNcndGSGs0ZU5QRzNOdGZRYnFKQ2hVNFpSWUduUEFjWjhmMjUxVVJm?=
 =?utf-8?B?VmRsNk5VVkFiQXVQMDNxZjR2MUR5WUw4Q0NoNlVIczdKckhneW9qRi9kaEpY?=
 =?utf-8?B?cCtTVWZqbEdSbjU0V3FiWWllRWcrRnNxenAwV2psWnMwZlllU2preW1HRG1F?=
 =?utf-8?B?M3pSKzJ6L1lpa2s5VGpyanZuODVFSWUwQjJLZ1RuRUU2UVJ6QWRHY3V2Yzcz?=
 =?utf-8?B?eW01dVFpbXJ0TEE2cGFxdGNyeHdPRXYxcGdReU5TQVFDNUpHWSt4MUppWEtv?=
 =?utf-8?B?VUJxZFdNeXFBeUp6V01rZHZicTJuU2dsMDQ5cTBHcVhMNnB4aHA3MEVPMm9K?=
 =?utf-8?B?TEY4b3ljQm1zcmpoMlRDenhwa1hOWDl2SU1NdlNMcnU2NUZ1UXEzdlJOL1ln?=
 =?utf-8?B?SURyOWhYUkNlMmtOUzNwQ2FVU1dxOXAzM2RQMmg5dHhDZ0NmMERsRTh0SFo1?=
 =?utf-8?B?TFBjdGR0d1Mwd0dhaHFKMUtuT01XYXNZU1N1b05EUEw5aWU3TGFIVU1FcDNJ?=
 =?utf-8?B?aGVRQS9Hd1AxbFBEL2h1NXZmRENwQWJEMXEwSVB4ZldkZU1lcDVrMlJVRXVK?=
 =?utf-8?B?dXF5blFnd1Z0VXdQbnRMcjhnbWp2WStSaWtmTHM5eTBiL21ZQVY0OFkzTGNu?=
 =?utf-8?B?WkVzL3VQRHlSNVNBd1pnYTFrWHBCVnFLL0lFYjA4YzNLMGV3ZGMrVzgrcnRL?=
 =?utf-8?B?K2IxUVRnTDZBZXR1K1hRVFl6R1YxbXFob01Jb3JXNkIrNmsxYnIyMVRmdUlv?=
 =?utf-8?B?QVhFcWFQWHZsa3F5bXNHOHBTekNPRUg5aWJzN2VkTzFaZ040eHllbVdRN0Vh?=
 =?utf-8?B?dExYVHN4cVNuT3hOUmFmcTk5MG5DcjcyZHoyZlZyaThDbTIvaytReU5rR1Y2?=
 =?utf-8?B?bjdHNWlaTnNWWGJMY0MrNkN2ZnhjVEJ5WlMyTnY1U1VMak15M21sSjFnQmdS?=
 =?utf-8?B?REJISEwxdmdBZm1zMkp5dVFzaWY5Z21QaU5TOXF6WmlMODMzS0VVbW5lblpR?=
 =?utf-8?B?K3BKZ0tLUGxzYkVFeXg3azNwYzJMeDNpNE5QZU83aGo0eWY1anVZbGR0SU1O?=
 =?utf-8?B?UDhxN0IzcU8xQnZRbXZEZWpCQzh4VEtHY3RnMTcxZ2pydmEyaDRmN3JrNVgz?=
 =?utf-8?B?SlJUOFg1cG9HNTZZdmkxNVB5dlNPaWpyWDVibFIwRHpCd3Vhb0NQL3JWRVNn?=
 =?utf-8?B?RDhFTWJkM1BERTQ5TFZWZWQ1M0YwRjllZER5bEhLeDgrYk1EL3AzaGpUOFZ1?=
 =?utf-8?B?a0ErN2R5bFBVR2t5cnNpaUREQTllanl0VEZyS0txRmdIUTlZeTNYdXpEaHRx?=
 =?utf-8?B?aXhFNm52aFJrM0ZzMXlqWmxlcUVBeUlzdTJmVERuSEcwbHllZVB2WkRBZ3gw?=
 =?utf-8?B?TDFoNzRQMitVRnVTWWJUVGZNQlJaaTd5dmRFU0duTGZ1UkJTSU0vNnRFUnlX?=
 =?utf-8?Q?owv2qWbc47MvX+DfhhGdnxtDq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952168f2-1b39-45ad-3dc9-08dcb2abb174
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 04:29:26.7594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uY+n6dTW0YT1UCZy3d8fdpaX2pFKjrpVToCnmbGx20xXf3y9RW+gTp/PkTr+D9Ab
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6076

On 7/23/24 17:44, Bjorn Helgaas wrote:
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -4656,6 +4656,7 @@
>>   		norid		[S390] ignore the RID field and force use of
>>   				one PCI domain per PCI function
>>   		notph		[PCIE] Do not use PCIe TPH
>> +		nostmode	[PCIE] Force TPH to use No ST Mode
> 
> Needs a little more context here about what this means.  Users won't
> know where to even look for "No ST Mode" unless they have a copy of
> the spec.
> 

I can certainly add more description to talk about "No ST Mode". Also, 
will "tph_nostmode" be better than "nostmode" in your opinion?

