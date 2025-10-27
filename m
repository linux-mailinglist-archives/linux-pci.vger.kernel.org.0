Return-Path: <linux-pci+bounces-39450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D242FC0F68C
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 17:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377FE4678E7
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 16:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757D3313E12;
	Mon, 27 Oct 2025 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LJQmNA3e"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2D1306B33;
	Mon, 27 Oct 2025 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582800; cv=fail; b=aWSq2kn162nZyLF7WJxUNLVjuS+Bqeh9twhIfJzBmi9Ts0jE5LDF9fCKQPRnDeUdOC55rsIXq24HpxSK9e0cuH05Vd1Dr21xzj3OaLlRwNUBJC6df2aQ7XBruxcoujoz2oWCT2kv9rW0V2JKQwqaiyK8KxpDJvAeY8wMegK/qSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582800; c=relaxed/simple;
	bh=x0m1j48qwtmC/lZ99S1uuQAiTo+7+BHGHQMRODaEJh4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aeT1STsizva3M3qq1CDc9Y7d2p4opwXRujqGjBEyA7GKI4bxGuc3zEaryy9ciW8Q5IaL+yi4YlpkSwPcHytFjfsiQvVuSeSGTL4Ep2LZuoYg2WgbdgLTOgZujmjvsKy1fJ1E9EGWggB631YA5lYCOmqKJ2eh4vtImESfByeyrsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LJQmNA3e; arc=fail smtp.client-ip=40.107.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TK7DBdnmEvispTAxGwNu/l/XdolLWizMxczXeol6tYMmOsqqY3Y0PY8CHiOzl8M2H3++BmabPolYvwDUDMa4AG4xjwWD4/ZgFrkBxJBnfUd8+z1ruwGtHMgwFehoRVlDzyjQfhLR54GDfbrIGeFYYRmHklm7meZ4JEhILP/hg5pHwsOdlr3Jx4gO4s51wZDgf2V8UuvP9mN9qT1A2CpBOTcuzRsV4mlP+9grt7HSMjkyxWGfbb18nMGk1AXrDI3H21ECVHfPc54qCJrSSZnAH4ay73sl4onLKbLlKYlI+fyRsh8T6ADumTVBocQ4wQFn1TXGLdUCYsWSuRgJFQ9zbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvUhG/yimNMJUOL3pKeL1uPLEz3soMBfiY2U0Wa7v04=;
 b=B93Se1cAey2Mu6ONzqozWRsEIcDp5tSGrq+B7WbMe5df+wsput6QJMBJaC+ba0LxrkFL3VvdA/Ek0yW05q0gpaVqvlEKunn6jlk+9zFCJe1bhba7BPKppGZbDQY1JK5u0c4z76cglDersvB1Jp6lcAhLtIolw/mncWkMy2jmiLzURqqaqcf0xkL+RpogPxUIXv3ZjdxxtyF4vkzc2g4SSPOjKkFl6YHHgmqOiQGYIp17ju5DsrM50j3aRNPWHcJvjLTpT+FjWCqHYrPqBLiOtWZR6P4akiCZrYtqVeGyZByszbRTJHQQy1D8YsXNMBroxu0CEIS9kp6thzsWUjMGkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvUhG/yimNMJUOL3pKeL1uPLEz3soMBfiY2U0Wa7v04=;
 b=LJQmNA3exqoCiab99A1+upwybS2yM8vDvEB4wREE5dgD0L/83uG3nWuccVvnA7XkEi5WZGjvI5X/Nbrlpaug0SB7ClGQHC08m/NAsUyXWuDfA1m7sTW9GMObaaaLz0Ufm+zmtcxK6x2DEhTWmNrqbg46k4hfCOrYlnNckUPQhnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH1PPF16C2BD7B0.namprd12.prod.outlook.com (2603:10b6:61f:fc00::607) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 16:33:12 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9253.011; Mon, 27 Oct 2025
 16:33:12 +0000
Message-ID: <b697a3f9-5e14-465b-ba68-a8910d88912d@amd.com>
Date: Mon, 27 Oct 2025 16:33:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 15/25] cxl/pci: Map CXL Endpoint Port and CXL Switch
 Port RAS registers
Content-Language: en-US
To: "Bowman, Terry" <terry.bowman@amd.com>, Dave Jiang
 <dave.jiang@intel.com>, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-16-terry.bowman@amd.com>
 <883ee74a-0f11-414e-be62-1d5bdbfb1edd@intel.com>
 <2f5d7017-d49c-4358-b12c-0cd00b229f2c@amd.com>
 <c34dcf08-7a2c-4e78-b2b9-c9851cf6ab98@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <c34dcf08-7a2c-4e78-b2b9-c9851cf6ab98@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0514.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::21) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH1PPF16C2BD7B0:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9ab3ed-1385-47f8-1c41-08de15768529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFlWYTE0bUNjTWZZRFJiem56eW9WWHNWRkFBWmdFVjFLU2RDb3F4OHpwYkhS?=
 =?utf-8?B?SDRndktMY3dXQ1YvOUIvZTJrWVdKV2Q1UkVCWndpSVE3SlVMTG5na0JlZ1dY?=
 =?utf-8?B?NTMzWHVJUlRVbjczUUZYSUtQS2lKL3R4WG9lK0Q5SlJMV2djS0poL2NBWDVz?=
 =?utf-8?B?V092S1lSTXZGaXFqUHVEbmhyV3pCdlh6WTBGNkhvMUQ2enVwS2p6SUQrN2JK?=
 =?utf-8?B?bVRDRnZ3TXpyTXcyZFdCM1FmaEdYMnFTWVc2amVnclMzWGN0QU9DWDQ4Q3Uz?=
 =?utf-8?B?bFh5c0tXeHFRTUpJZDNWamNhOXBwVzZkQWFGeXFNdW9OeVZiZitZOWdOL1li?=
 =?utf-8?B?QTlNWTJUMWdweUJnWkJCaTIwRWhRemNudGJzVk1wZTRVTkpVRDZaQXVGeWtB?=
 =?utf-8?B?d3BWbW84WUxrYnBXSnJVQ2tJclBiL1VxMlN2UUZrRFYwVXZOOThUN2VKaE53?=
 =?utf-8?B?dGsyRXNNaENaeEFiS1VxQWppeGdVSzI0SVd1OFZlSEM0R2pDVE5ZeWYxOFY1?=
 =?utf-8?B?ZDBtcGVQVlFpamJrN1lpMEM0UEYvbWxDNG1VM3hQRVZZbTdPVW1BRzIyaFBj?=
 =?utf-8?B?bDBIekNiL002UHlyOGV1ZjBCemNGZE8vRERrSHdUU0lwQlhPNnM1VkgrQWpS?=
 =?utf-8?B?SHhWVXVnaStmN0N6RUdmOHB2MktHL3p6Z2NiNHhXNVRHcjQ0Q3lxclRhZDl5?=
 =?utf-8?B?RDNIK2FlMlZoVDAwdysvNVFwN1c0QS9iSnBnTzNad0p6bXlrS0VTbVJkVW4y?=
 =?utf-8?B?Ny9QNitpZmxCN1BLNjUrdGowUkVVU1hlelhMdFhFbElqZDFrbmhVREVNMlNX?=
 =?utf-8?B?bXYwcnA4Y0d6RDFOQW9URk9PdVA4MG9LSWRMa2Z2SlRLeXUxZkZzMEVmSVVB?=
 =?utf-8?B?bXJHU2R5OE5DUXpZVlZ1QWROeHhWdlFUOUo1a0xxeXc5Z2xiM0Nrc0djTWpU?=
 =?utf-8?B?VTZWVjh1ei83MSt2Q2tnUGhtYmdiNEVGVW1Zbm5jUWFkb0JkRVpqdmxOMG5F?=
 =?utf-8?B?SFVncHVzaWIrTFJiUWNJSEJZekRMNXU2QU0wMzE1dnZ5WlFPbVFhazRBeUx5?=
 =?utf-8?B?NHZBbVk5UDFiUThXVmtpSlA4a0srSFp4WmZ3NzJkcHFHOWh0VlV5bVdIVDk3?=
 =?utf-8?B?ZEtQcmpWeFo0dFFoR2pJbGluTnJJWXJscWg5TlZpaUhFbTNUb0IvQ1VoeFcw?=
 =?utf-8?B?cGFRZS9nR2h0TXQ4M294UFR5RFhTanFlcFR6M280Y1VjY3l0MUl1bHdFT2ZR?=
 =?utf-8?B?SDhzN0RmNDVnY2ppVjBZMVZlL2JOaE5lWmhmc2dSNlAwTFlPWTBEd2EwS3hG?=
 =?utf-8?B?SG9KYURnVFZTZ25YS3MwK25FZWtlVVhBRDIrWmMwMjJ4QWNoREQ3S3RTTllv?=
 =?utf-8?B?V1hoTFZyTCtSUkVsRFdGbUVsVStHTjdIUmNsbHRlQVhWZU5wUjU2R3JkWFFz?=
 =?utf-8?B?S2xvMzFlbGw2cWx2TDlyY3FBVDExaG9CTE9vRmIvRnpTNTJLcmp6cmhVRDZx?=
 =?utf-8?B?WWJ2MnMySEpRRWNtSUZxNG9taFYxYVloZHpnY0I1TER3VGg1Mkcyc2cvOUxV?=
 =?utf-8?B?NzFFVmJLTkZSR1diYkVqdUZYZlBrc1BZRjI4TDJyWEQveHE5VXpXYWdIVXZ2?=
 =?utf-8?B?d2tsZXRtc21SeEMrN0RWMzZFb0U0eVJsY1k5MnFFVHBsdEtiYjNUejFEVU9S?=
 =?utf-8?B?UTR3Q3BRRUpzZWtRTWZjVjdENUlXUmo0TDM2aTMxdjlxbS90bklaRWlQRnFH?=
 =?utf-8?B?cnFSb1lQdzMycXRoWXJ4bjgwZkxiSkZVV2Y2RFZaK0JEQWUyaXYzU1hTNXRU?=
 =?utf-8?B?bWt6U2RuNFlEL2hMWXpGbCtkZlU3Rzg3alBMRTFRZUVsMmQ2TDBadURza3M4?=
 =?utf-8?B?Sk8xY24wWHZoYWlPbnN3S1pjLzdLaXlJbFpPUS9kLzlvb0tJQlZoTVVEcGor?=
 =?utf-8?B?amVxV2ErQjBVQmhtTDZOeGhYOVNCb05uSklBa0p1emlvdlB0b1FxQkg5Mnc5?=
 =?utf-8?Q?Q76o0JKecvUwOTmddFSCV7FAeZoqbE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3JzaGQ0S1M0NUoyMlIwZ3phK0prUys3bm5ZVkJrM3hxa1VxdnBJd29yRVB4?=
 =?utf-8?B?b21jOHkxOUlPN3JSeWVMKzNGdXBVTEhKdUZkdjRORVNMa0FqSk5McDh0a3lw?=
 =?utf-8?B?TTljMUNhV0V6MWRBMkFBU2VkYmNjQnVZbVlic2hYazM4eTNYREhUZ05qN1RM?=
 =?utf-8?B?Zjh6N2E5UFArazRDREZBV3h5TElBSEQyTXRESmZlajN2c0tiVXFaRkNYSlkr?=
 =?utf-8?B?Zll3Si9PTTI1RldjYWQ4ZCt4cDBZN0VCN3RsVkwzdEhGNlEreG4vTUNDRWpx?=
 =?utf-8?B?S3R1bm5UNExVWVZUZUw1SEh5OFp6OWpXaUdWUkUrNCtNVFg4QUNtRGx3R3p1?=
 =?utf-8?B?VFN3NVJZM0hPUDd3SzRadlduS3I4d3I3eHdZR08zR3Q5V2hmNC9aVndpRE9M?=
 =?utf-8?B?ZWtPbDFkZFRpeUpkSVB1SkQ2Z3B1ZTd0VXozbnljZlZwOFkwaHRZb3VGcVRW?=
 =?utf-8?B?alZDS1JacUNmQnlaNWpDb0pZbXBaQmlhTjd2dXhKdlRveTBnTlAzcEZ5RFhE?=
 =?utf-8?B?UlhBTXlKamtwOTJxcVFkeUlLZkhGVVB2c3pmZlBndjBabm4zcFQ1T2hseXlu?=
 =?utf-8?B?ZFo0RHM5VzNkZ3R0UW91TmY1Tkk0Y0JDR21FMWJYN2dLWnlqNVM3T0xjTE5t?=
 =?utf-8?B?WTlMRWh0NUhsRDZpWThKa0hwRERCbVNUYjZ5UERmODF1SEl3MWFEYytsTms2?=
 =?utf-8?B?WHhYdlZkOU1RNHU4OHhHNW1aenVmMUJvdVB3U2lvODJKUHZOUGxWMnZ6ZE5p?=
 =?utf-8?B?ZG9lZjNHM1YwbDBmb3Q5Y1Q3S1ZlWkRwY3ZRYThsdEg0RXk2VnlPdEFLbjBv?=
 =?utf-8?B?OUU5dVIxTVQydUhjZHFrQ0Q0SWc1K3I5U2w1MmN3RUF0MjNCNERjNFZNOTQw?=
 =?utf-8?B?aVhPcG1LZUo3cUw4WnF4S0laSC9CeElZdWh4WGRBZmZrd3lsWk5Mb1g5R0FP?=
 =?utf-8?B?YlgrMEhrbVZWM0NJY0tRQXlsT3JZa1h0WUNPKzBYZXhqRTE2Uk02MzZva1dV?=
 =?utf-8?B?S1duWEpVUHpKOEttWXpQei84MUpJdndEL3ZWdmRiZk5wc09WT3dBOWN1L1Zh?=
 =?utf-8?B?RWNUOUl3K0gzbGxsdGMxeklUZkdKMTlINmdpWSswYVJuc2d4ck9ZdE9MQm9a?=
 =?utf-8?B?N2grVWhVS0ROQXNlbUFIblRJSGhmVEIrR3VnWk1LTm13SUUrSm4yZ0VpSnJS?=
 =?utf-8?B?VThLb3B4SGlMeTBQSk5hbVovREMxS0xMR282TGJXeWZlWHJIeVlxQjJsNDVn?=
 =?utf-8?B?azRQWnFaYTdlR3BFbTA0TmFyY1JMbEhKdGVtbVVjeUhaVVQ4Tk81TFFITmxu?=
 =?utf-8?B?bnVVYllpZW1nTUdQNmxiRGwvRVdBWU91K0lQMzNtSDBOWExucEdoMVQrOWtM?=
 =?utf-8?B?elNBVk14SElidDFlbDU2czJRVGhjZ01EdC8rRjVYQmRRZG5RT3lwQlcxcnJy?=
 =?utf-8?B?STYwY25EMFJuSjVrN0RZMGQxMm9MTlNMcXZWWHFMU1J1QjF4Z3RDUk5xWWw1?=
 =?utf-8?B?Umovd1hXVG5XQjZzWW9BcVdlczI4RE4vK24yTnA4RVp3K2puYmVYN0dEOW9z?=
 =?utf-8?B?VmZFREYzd2V6WDdKMUc3eDhFT0hLNzB1eU1LOThyeTFoY2RYT1ZZZ00zbVJI?=
 =?utf-8?B?aTRweTQ5L3QxWWcrSFlRbWxrYWx0QUdGZ3JGVHBMWUVQWlBXUjVrNTJWTzlE?=
 =?utf-8?B?NmU3cko5ZXdXZnkweUdjOXA2QkkzRkRZL3pTdW5hNHpSQjBvOFUvZEp0S0RM?=
 =?utf-8?B?TnV4czcxNFlsdmY4NU5kKzU3Skk0MUozZlovL2k2WE53emRPckkxMWtOdEIy?=
 =?utf-8?B?NDBtNVdGQUJoZVpwc0NQQVI5Mlp6NHRPQkFqdUhlNTZmbHRsZGtreWwwUUV6?=
 =?utf-8?B?Y1E1aU5OaDFHRWZaV21PTDlNaGNONFAySmFzYmMzTGh2ZTlSMHB3YlBvSVNJ?=
 =?utf-8?B?OVlIT1JUYzNabWR3UDJTYmVrU1FyTStITnc0a2pnVHdaYVZzMTBadE9TQ1oy?=
 =?utf-8?B?NzdOVVlWclJxSjZSelgvRDBXOE96VERUL3Y5NnBsc2lNa2laamZxZkJSMysy?=
 =?utf-8?B?ckcvenoxcnJWK3M3eVB1MG1uUkxRVWhLdmIvRzI1dWJtT3lLUTR4YnU5K0xq?=
 =?utf-8?Q?o+YFhvLziVE3WZxLKd7WPTLkH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9ab3ed-1385-47f8-1c41-08de15768529
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 16:33:12.0779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8Xv6TI98SsrBXyKUmJ+Tm1W6YOje5uGH7kLb2hp6NYqg04RCd7Sh7iIciWa1DdPpitYRDDupnPkkCjANBpq+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF16C2BD7B0


On 10/24/25 20:40, Bowman, Terry wrote:
>
> On 10/24/2025 5:25 AM, Alejandro Lucero Palau wrote:
>> On 9/26/25 22:10, Dave Jiang wrote:
>>> On 9/25/25 3:34 PM, Terry Bowman wrote:
>>>> CXL Endpoint (EP) Ports may include Root Ports (RP) or Downstream Switch
>>>> Ports (DSP). CXL RPs and DSPs contain RAS registers that require memory
>>>> mapping to enable RAS logging. This initialization is currently missing and
>>>> must be added for CXL RPs and DSPs.
>>>>
>>>> Update cxl_dport_init_ras_reporting() to support RP and DSP RAS mapping.
>>>> Add alongside the existing Restricted CXL Host Downstream Port RAS mapping.
>>>>
>>>> Update cxl_endpoint_port_probe() to invoke cxl_dport_init_ras_reporting().
>>>> This will initiate the RAS mapping for CXL RPs and DSPs when each CXL EP is
>>>> created and added to the EP port.
>>>>
>>>> Make a call to cxl_port_setup_regs() in cxl_port_add(). This will probe the
>>>> Upstream Port's CXL capabilities' physical location to be used in mapping
>>>> the RAS registers.
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>>
>>>> ---
>>>>
>>>> Changes in v11->v12:
>>>> - Add check for dport_parent->rch before calling cxl_dport_init_ras_reporting().
>>>> RCH dports are initialized from cxl_dport_init_ras_reporting cxl_mem_probe().
>>>>
>>>> Changes in v10->v11:
>>>> - Use local pointer for readability in cxl_switch_port_init_ras() (Jonathan Cameron)
>>>> - Rename port to be ep in cxl_endpoint_port_init_ras() (Dave Jiang)
>>>> - Rename dport to be parent_dport in cxl_endpoint_port_init_ras()
>>>>     and cxl_switch_port_init_ras() (Dave Jiang)
>>>> - Port helper changes were in cxl/port.c, now in core/ras.c (Dave
>>>> Jiang)
>>>> ---
>>>>    drivers/cxl/core/core.h |  7 ++++++
>>>>    drivers/cxl/core/port.c |  1 +
>>>>    drivers/cxl/core/ras.c  | 48 +++++++++++++++++++++++++++++++++++++++++
>>>>    drivers/cxl/cxl.h       |  2 ++
>>>>    drivers/cxl/cxlpci.h    |  4 ----
>>>>    drivers/cxl/mem.c       |  4 +++-
>>>>    drivers/cxl/port.c      |  5 +++++
>>>>    7 files changed, 66 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>>>> index 9f4eb7e2feba..8c51a2631716 100644
>>>> --- a/drivers/cxl/core/core.h
>>>> +++ b/drivers/cxl/core/core.h
>>>> @@ -147,6 +147,9 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>>>>    #ifdef CONFIG_CXL_RAS
>>>>    int cxl_ras_init(void);
>>>>    void cxl_ras_exit(void);
>>>> +void cxl_switch_port_init_ras(struct cxl_port *port);
>>>> +void cxl_endpoint_port_init_ras(struct cxl_port *ep);
>>>> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>>>>    #else
>>>>    static inline int cxl_ras_init(void)
>>>>    {
>>>> @@ -156,6 +159,10 @@ static inline int cxl_ras_init(void)
>>>>    static inline void cxl_ras_exit(void)
>>>>    {
>>>>    }
>>>> +static inline void cxl_switch_port_init_ras(struct cxl_port *port) { }
>>>> +static inline void cxl_endpoint_port_init_ras(struct cxl_port *ep) { }
>>>> +static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>>>> +						struct device *host) { }
>>>>    #endif // CONFIG_CXL_RAS
>>>>    
>>>>    int cxl_gpf_port_setup(struct cxl_dport *dport);
>>>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>>>> index d5f71eb1ade8..bd4be046888a 100644
>>>> --- a/drivers/cxl/core/port.c
>>>> +++ b/drivers/cxl/core/port.c
>>>> @@ -870,6 +870,7 @@ static int cxl_port_add(struct cxl_port *port,
>>>>    			return rc;
>>>>    
>>>>    		port->component_reg_phys = component_reg_phys;
>>>> +		cxl_port_setup_regs(port, port->component_reg_phys);
>>> This was actually moved previously to delay the port register probe. It now happens when the first dport is discovered. See the end of __devm_cxl_add_dport().
>> FWIW (other people not going through my discovery path :-) ) Dave is
>> pointing out to his patchset for delaying port probing and now applied
>> to next.
>>
>>
>> Terry, any estimation of when your next version will be sent to the
>> list? My Type2 patchset is dependent on yours, so I'll be reviewing it
>> as soon as you do it.
>>
>>
>> Thank you
>>
> Hi Alejandro,
>
> It will be early next week.
>
> Terry


Great.


Maybe it would be worth to consider if your patch 8, the one Type2 
support now relies on, could be applied along with Type2 work if that 
dependency ends up being the only thing remaining, and with your 
patchset requiring more cycles. I will raise this tomorrow, after 
knowing what Dan thinks about type2 patchset state.


Thank you


>>>>    	} else {
>>>>    		rc = dev_set_name(dev, "root%d", port->id);
>>>>    		if (rc)
>>>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>>>> index 97a5a5c3910f..14a434bd68f0 100644
>>>> --- a/drivers/cxl/core/ras.c
>>>> +++ b/drivers/cxl/core/ras.c
>>>> @@ -283,6 +283,54 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>>>>    }
>>>>    EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>>>>    
>>>> +static void cxl_uport_init_ras_reporting(struct cxl_port *port,
>>>> +					 struct device *host)
>>>> +{
>>>> +	struct cxl_register_map *map = &port->reg_map;
>>>> +
>>>> +	map->host = host;
>>>> +	if (cxl_map_component_regs(map, &port->uport_regs,
>>>> +				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
>>>> +		dev_dbg(&port->dev, "Failed to map RAS capability\n");
>>>> +}
>>>> +
>>>> +void cxl_switch_port_init_ras(struct cxl_port *port)
>>>> +{
>>>> +	struct cxl_dport *parent_dport = port->parent_dport;
>>>> +
>>>> +	if (is_cxl_root(to_cxl_port(port->dev.parent)))
>>>> +		return;
>>>> +
>>>> +	/* May have parent DSP or RP */
>>>> +	if (parent_dport && dev_is_pci(parent_dport->dport_dev) &&
>>>> +	    !parent_dport->rch) {
>>>> +		struct pci_dev *pdev = to_pci_dev(parent_dport->dport_dev);
>>>> +
>>>> +		if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>>>> +		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM))
>>>> +			cxl_dport_init_ras_reporting(parent_dport, &port->dev);
>>>> +	}
>>>> +
>>>> +	cxl_uport_init_ras_reporting(port, &port->dev);
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(cxl_switch_port_init_ras, "CXL");
>>>> +
>>>> +void cxl_endpoint_port_init_ras(struct cxl_port *ep)
>>>> +{
>>>> +	struct cxl_dport *parent_dport;
>>>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(ep->uport_dev);
>>>> +	struct cxl_port *parent_port __free(put_cxl_port) =
>>>> +		cxl_mem_find_port(cxlmd, &parent_dport);
>>>> +
>>>> +	if (!parent_dport || !dev_is_pci(parent_dport->dport_dev) || parent_dport->rch) {
>>>> +		dev_err(&ep->dev, "CXL port topology not found\n");
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	cxl_dport_init_ras_reporting(parent_dport, cxlmd->cxlds->dev);
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
>>>> +
>>>>    static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>>>    {
>>>>    	void __iomem *addr;
>>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>>> index 259ed4b676e1..b7654d40dc9e 100644
>>>> --- a/drivers/cxl/cxl.h
>>>> +++ b/drivers/cxl/cxl.h
>>>> @@ -599,6 +599,7 @@ struct cxl_dax_region {
>>>>     * @parent_dport: dport that points to this port in the parent
>>>>     * @decoder_ida: allocator for decoder ids
>>>>     * @reg_map: component and ras register mapping parameters
>>>> + * @uport_regs: mapped component registers
>>>>     * @nr_dports: number of entries in @dports
>>>>     * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>>>>     * @commit_end: cursor to track highest committed decoder for commit ordering
>>>> @@ -620,6 +621,7 @@ struct cxl_port {
>>>>    	struct cxl_dport *parent_dport;
>>>>    	struct ida decoder_ida;
>>>>    	struct cxl_register_map reg_map;
>>>> +	struct cxl_component_regs uport_regs;
>>>>    	int nr_dports;
>>>>    	int hdm_end;
>>>>    	int commit_end;
>>>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>>>> index 0c8b6ee7b6de..3882a089ae77 100644
>>>> --- a/drivers/cxl/cxlpci.h
>>>> +++ b/drivers/cxl/cxlpci.h
>>>> @@ -82,7 +82,6 @@ void read_cdat_data(struct cxl_port *port);
>>>>    void cxl_cor_error_detected(struct pci_dev *pdev);
>>>>    pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>>>    				    pci_channel_state_t state);
>>>> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>>>>    #else
>>>>    static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
>>>>    
>>>> @@ -91,9 +90,6 @@ static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>>>    {
>>>>    	return PCI_ERS_RESULT_NONE;
>>>>    }
>>>> -
>>>> -static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>>>> -						struct device *host) { }
>>>>    #endif
>>>>    
>>>>    #endif /* __CXL_PCI_H__ */
>>> I think this change broke cxl_test:
>>>
>>>     CC [M]  test/mem.o
>>> test/mock.c: In function ‘__wrap_cxl_dport_init_ras_reporting’:
>>> test/mock.c:266:17: error: implicit declaration of function ‘cxl_dport_init_ras_reporting’ [-Wimplicit-function-declaration]
>>>     266 |                 cxl_dport_init_ras_reporting(dport, host);
>>>         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>>
>>>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>>>> index 6e6777b7bafb..f7dc0ba8905d 100644
>>>> --- a/drivers/cxl/mem.c
>>>> +++ b/drivers/cxl/mem.c
>>>> @@ -7,6 +7,7 @@
>>>>    
>>>>    #include "cxlmem.h"
>>>>    #include "cxlpci.h"
>>>> +#include "core/core.h"
>>>>    
>>>>    /**
>>>>     * DOC: cxl mem
>>>> @@ -166,7 +167,8 @@ static int cxl_mem_probe(struct device *dev)
>>>>    	else
>>>>    		endpoint_parent = &parent_port->dev;
>>>>    
>>>> -	cxl_dport_init_ras_reporting(dport, dev);
>>>> +	if (dport->rch)
>>>> +		cxl_dport_init_ras_reporting(dport, dev);
>>>>    
>>>>    	scoped_guard(device, endpoint_parent) {
>>>>    		if (!endpoint_parent->driver) {
>>>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>>>> index 51c8f2f84717..2d12890b66fe 100644
>>>> --- a/drivers/cxl/port.c
>>>> +++ b/drivers/cxl/port.c
>>>> @@ -6,6 +6,7 @@
>>>>    
>>>>    #include "cxlmem.h"
>>>>    #include "cxlpci.h"
>>>> +#include "core/core.h"
>>>>    
>>>>    /**
>>>>     * DOC: cxl port
>>>> @@ -65,6 +66,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>>>>    	/* Cache the data early to ensure is_visible() works */
>>>>    	read_cdat_data(port);
>>>>    
>>>> +	cxl_switch_port_init_ras(port);
>>> This is probably not the right place to do it because you have no dports yet with the new delayed dport setup. I would init the uport when the register gets probed in __devm_cxl_add_dport(), and init the dport on per dport basis as they are discovered. So maybe in cxl_port_add_dport(). This is where the old dport stuff in the switch probe got moved to.
>>>
>>>> +
>>>>    	return 0;
>>>>    }
>>>>    
>>>> @@ -86,6 +89,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>>>>    	if (rc)
>>>>    		return rc;
>>>>    
>>>> +	cxl_endpoint_port_init_ras(port);
>>>> +
>>>>    	/*
>>>>    	 * Now that all endpoint decoders are successfully enumerated, try to
>>>>    	 * assemble regions from committed decoders

