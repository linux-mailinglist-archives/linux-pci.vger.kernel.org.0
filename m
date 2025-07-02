Return-Path: <linux-pci+bounces-31290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E09CCAF5E69
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 18:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D37D3A4DF6
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 16:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6382E7BBC;
	Wed,  2 Jul 2025 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S4Dxwpsc"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCDB2E041A;
	Wed,  2 Jul 2025 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751473288; cv=fail; b=Xcb+cIJfS3o2hZKpZPXH5cSFKjz5q3EPr+EU2nbxhe943Ydv1uUa1fX6iXNbilHj0H4UrEHExNJiZI/wLZ3PcGGiRMiIdUJAz8hkCAm9wxq5QsXWPPZqGeHwdmtGkj+I/e4ibGJdgJJi9TOPqbFWIrOKgDN0c2mZLm5Q5DRcGMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751473288; c=relaxed/simple;
	bh=8cOLWW63T7GnyzFVLV00KPkW5g9VTYtMSNwVpuAsgNg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=meWKOMaXEtPn5UjGFFyN6804ra+Ea4UMchSUIPgm5TQwGlYV5cQ7Y/FTfARb6xdtecM+X1V+UToJNlZADwxYHyGrUVQshV5G3f+h3WQyKDVo+yBPOv3oF36xSavUavEbsUF7m+fLC6hMQsnbyQyF87pij/oxnfdjWmFhDqiwm/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S4Dxwpsc; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccefG7YBVSGArCzj9UgZjhbPdf6ozXIEANzCQ5emh0LA/jbaHWm/Xwb/IxBNXfteFy+jMWQAbPkZEpQOU8qdGZVB6yhAt7kK+J4mU+vx5i29z5bKK4HUHM++crb6XTQfWXr6hHU0bPrmJ9lnjiXWFnUjAOMOHKiZe6+HS4GsmNbfj+A/FhkWlKP0MncpvewSG1w58EjpBaD8+6PiYRI8gplfrqOgyocUZHrdCjfeBLPmMU2FflMJfBlRASHvwJ0yFyO/6VgdiKTzzKWtZgU2VehYS1JnxxyhIzDL8Ta2UzJy9Kra9eOayeETIV62ed31PDJ/6u4KN8hUqmJ+XfzofA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqQum7av72v6ImZQLbogovoQ5lfPQFBsPyFjuGoIScw=;
 b=oVilmKoKDm1y4bfI88MR56yd+Iei1NKIuAvExovl655jswn+DrsejKY2qZKrrKD57TAipo3PikjLCseHaAtJnCBMFt5sIjwnXo1H2IWy95Z3N7PWct/6I5/FQ8vsEF+RVXnEoEIj6LLMRH4L30v9KcMKsDexAA+spbwDjh0H+uXPexcpf7PGpv7FZP3AadGf3lLNlFolxyiv8D7YYNg6Z2ZozbQP/8bWePs/U+bQlfDxMN5mpz9E13JBC8NpOGBeZ7HTLalspMiUTu8E7atfBsbbAzGn4qSLRNKTQa/I91+DW1/o37O1YVMOvKbLT2m9zE2jf//MSgq1Z4G0XEg7ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqQum7av72v6ImZQLbogovoQ5lfPQFBsPyFjuGoIScw=;
 b=S4DxwpscazAPL1DKoNn28twOhuJf7y4ws0JMWqCRpQxU+Mvkp7EDL/Fdxkeczlkw+KyrUNWQM5Kkt8alMBSPanFH8E9MpXjCX2Nf6QLP+XgbKnTuWpKx7xLEup8h8s1xhN6LBvfZKoQMxf3sLz6R7WGQsQXYbkp3GfNHhhgf/NY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ2PR12MB8954.namprd12.prod.outlook.com (2603:10b6:a03:541::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.25; Wed, 2 Jul 2025 16:21:24 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 16:21:24 +0000
Message-ID: <a76be312-9f27-491a-99d2-79815ed98d3e@amd.com>
Date: Wed, 2 Jul 2025 11:21:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/17] CXL/AER: Introduce kfifo for forwarding CXL
 errors
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
 <20250626224252.1415009-6-terry.bowman@amd.com>
 <20250627112429.00007155@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250627112429.00007155@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR16CA0067.namprd16.prod.outlook.com
 (2603:10b6:805:ca::44) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ2PR12MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c6a17c2-a97f-46cd-bdb1-08ddb9847d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djZDMFpaSU51b29iN3BwY2k5cDJMUHFLSS9XR0Z4NEExV2ZRU0M0YlJ3VGdR?=
 =?utf-8?B?N0tGcjRkSDNwdmNWeTYwb29sOFJMOEtBdUNVQUhZdjRKU0ZNWEZYMVJYeXpo?=
 =?utf-8?B?dWVTR2tUVHc0WWNsVm0vV3AzNEIwamJQb3RtNmtTUWlaR0ZmcmhUN0Y2WUhB?=
 =?utf-8?B?VkJwY3NocWNlRGQ5UVprNGgrOEVneUV0WUJCU2xqOGVXWFBJUnp0T2ZGaGJl?=
 =?utf-8?B?bHJ2Rm5Xc2w5ald2YXZQRm5Ha3JKdDdFYXJvc2F5RkQ0T1dFbnhnOFpjZ2pi?=
 =?utf-8?B?UCtLN2VLbEFQVTllOW40ZTA0U0QxQ3hHMGhJdnlJN25oRm9RT0JOVUtqSFhl?=
 =?utf-8?B?MXhDdUVhRzc1c1lMVy8ydUZtREJ1dXRwakl0dEVMb1czSWRrZVlmRndlRUNE?=
 =?utf-8?B?VFpjUUhWODFyUWJEM0I4YThXT2VCKzUrQnA1YlowZGYzemlUOEdjaDBTTDFE?=
 =?utf-8?B?THhlS0tSV2ZEL2JYYzU3cEhjQjlkZkFPb0REUWFobWhaa3dKdlNXNTY3a1B6?=
 =?utf-8?B?dDFhSkJTWWNKUWE3d3prNUVrdW9FaVJnNzJLQmFDMm9WOGNGU2E2MGpnWENJ?=
 =?utf-8?B?WDMrYUNtVkMzNVZXQ0tvdHYxL3ErTVpQd21mMnJuZFVFaEZ1WlpTeVBuUnNV?=
 =?utf-8?B?L1VOV1BGNDN4dUgxT0I4WHdxbVZIYTRaa3gyVGtmYmZjRE1qNWFRMVFpd29k?=
 =?utf-8?B?T0V2N1ZjZ0dNbzBQZDFoYnh4a3hiSWt6YnI5Z3BTWjg0aVNDUzh5N1M1VGJR?=
 =?utf-8?B?UVVjZGU0RnZlczVmbXhrVXo2UGlPTXc0ZmRXb0hKRUJmUW53VldjSGJCUkZq?=
 =?utf-8?B?VHpMMGFhUG82K3NhNzQ0SjNtdnV1Z25TdDVxbnE0dGdObEhjcjg2d0JsT2U3?=
 =?utf-8?B?SDhydzRsYUpqZ0IxWkVoSmd4aERSazIxMlNEYXh1Y3MycmQramFGcGUwbHlF?=
 =?utf-8?B?WnI1RkVtcEx4QnFzVlYrUEJoVlFxcnVvUW4yc2VKd2FaQTcvTFh2R0Q4U0RH?=
 =?utf-8?B?QnJBdXR0eFppaXhSQVhDeEl2bFArNkxjL1M1bXJtWjNjZFd3dlFHMmVmZVQv?=
 =?utf-8?B?dWZYRXpWNWxsUFVrVlI5Qm1SNTBuTTNVQi84eldlOTZvVzEwdk9USC9pNlJq?=
 =?utf-8?B?UERNV3J1a2dqbTZyQ0lCTUF6aXdjZjEzQ3VZeDlwLytPaVVtcGVielZyaVFT?=
 =?utf-8?B?MFFFRkJ0YzAzclN0cUNJWXpaTzVYellzbTdjbXVUWG1nRUZYMHB2M3M2TUhW?=
 =?utf-8?B?SVNsSVpaOXhkeVg2RlJxYW1oY0lnTDlrRGg4UXp4c0ZwcCsyODdNZWRrS0Z0?=
 =?utf-8?B?MjVTMWMxZ2R5YWF0SjdxaWplbVV2MGs0Nk9keDZBVTRBeURYRjJNMDFOSjVv?=
 =?utf-8?B?V21ITEVOdGUzclI0TmhacGplbkFnMCtPa2FzeWptbjhoSWFRb2JkdkRNNWxY?=
 =?utf-8?B?UFFOcHpvbGdzR0JHQ2NLdDZhTTdscmhhN2VpMTJsK0tST093ZjlKdjhtWVVa?=
 =?utf-8?B?WjhOY1JFbk90Um10MTc2RFZpb3poellqdmhldTZISUg2QkxrQWkvM0pESmhN?=
 =?utf-8?B?MXo0TFVpdFZBRzV6K0VMcldTcU5BMEpBV0dMRjZNLzlPN1Y1QnRsMzVwM1BQ?=
 =?utf-8?B?YXdCR0g5dUNtTW1KMCtsNGVjazYwRXJWeDFibCtQL0RLRjBWdHpBV0FSSU9a?=
 =?utf-8?B?elhTWEJpOUJMeDgwejd1MHpOdFgzNXdNa25pMis3emlGVkhBcjBCR2syeTBI?=
 =?utf-8?B?dVFudE5aMjV2eC9aQlF0YTZuRytjakU3bEtxdGFMYTM5YnFHZDNSTjEwSWxv?=
 =?utf-8?B?a1NKWU5LZlptU2o4bzFLOVV3Y3JmN0htMVBPSUxickNvZy95dlcvMk9EV2NK?=
 =?utf-8?B?cjBXS2FTL1FkUkNnN2hQSXlCeTNNYXFLWG4ybnJHcW1VUldOeHpyR0RyczNl?=
 =?utf-8?Q?hznJq53zcLQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejd6SlYzR2lpL2Zjek9VcE1EUkZ6ZXVnWG1jSHJIaHkzbGlvVS9OYmNBZmdq?=
 =?utf-8?B?aXZ5cXJOTWdvOE5zN1pPQ0FBa3hSMU93bGlmY3FVVEV5RXlodUZmbXFaOHZ0?=
 =?utf-8?B?YmlhMUgxWnkvUVovZXZtc2NJSVB5NlJ0cnZnUFpOSS9mUGJWTnlGTXRJdE9x?=
 =?utf-8?B?NDdOTkVhK2M2TTNZc21YcHRlQXl3Z1V4aEJiaHdBNEh2dFMxNjBZRUlJOVdR?=
 =?utf-8?B?VGxsWmU2Z3NNMWpDckFmaCtrZEV5Vks4ZXNQck5GNGR4N0xxczZuV25uV2xD?=
 =?utf-8?B?NytGTXJrOU1aL1ZreGRHOHl3TmJYbXNwNGRiTFRVNTV6UHRXRC9DYkZaemVD?=
 =?utf-8?B?SjJYU2xCUXAvWmtmSGMyUkpEU3Q3KzU1MUJjSTlPVGJXRCsyQktCelhsMEdK?=
 =?utf-8?B?bitjK2EzQXpGN0FXSTF3MzNuK1F6WDhVNHNQOXhCYmJPV003clZhM2hFT1pW?=
 =?utf-8?B?MmMveU1jcmtiNlU0U3UvYVFIMzNjbFRIZzhCL2tnSFBoU0VPK001SEhCanhQ?=
 =?utf-8?B?Sm1jWmpBRFlKa2pTYWwrSUk3Y3RSSEtWU1ZBRk1zaGF3Ky8xODdSODZSQndR?=
 =?utf-8?B?dHNpQTdRbnllQVc2MVpHOFhCd0VUNjZMalFKalgvbCtvSEY4eDU0SCtMYlZu?=
 =?utf-8?B?dXJVMVEzS1VHVUcxYkFGYUFhY3g1UjJ1UEw0cmJBbE0yckszUlA1alBrbVBj?=
 =?utf-8?B?V0pGTVZYTEdQTGNINlYwQjlud3RUcXFPQkJMT2V6TThWNWtCa1dweDN2K0l2?=
 =?utf-8?B?Wi8zNkxPYXEvWUpNejZLMTJhQW9wOHAwVVMwV3k1cnlTeXN6RlpyNzBKWkFE?=
 =?utf-8?B?N0gvTVVvRWNmMnh2SVltUVhOcG1WU1FmdGF3ZnhoaDZPcTJmNHpaSzk2NmFW?=
 =?utf-8?B?cFVQUUpuTFNUcXJKd2JSNmE2Y3BMQjFmTSszdHJSQWpqaU9iNFZ0OE5HQUhF?=
 =?utf-8?B?U3lNQ3p2c0xURkRWWXQ3VWpiZWVtcWxZSUpuUzQwWFVTTUo0ZmNFcHIrR0xw?=
 =?utf-8?B?SEduOFRYUFNWT0pCbFgrUjJYT0lmbVNrMXR6Q0RFTVZxYUt4N2JvMWpsS1B4?=
 =?utf-8?B?SkhrNEUrRHJnTkRFSW9FaTFGSS85MzJES1VVeTVLVFFOUTZZTXh4b2RJSFJP?=
 =?utf-8?B?WUI2SHRLYTgwckpkdDE4Skpna0tjNkdNZ1hYazcwNG45WmUrR3F4eWZjaHhF?=
 =?utf-8?B?MzVHL3BPOG4weGNXWlB4bHlINkF3bjNINThabG4wOC9EdUY3S3czOXFkK1ZZ?=
 =?utf-8?B?dWhkZnpFR0FKc1ljQjBBZ3M4NnJuWU85Y3JuK2dJRG9uRWVIVVlDa25LOXFo?=
 =?utf-8?B?ai9HN1B5ZUxtQStmZHUrN05oK1gvS0xmZHRXK0ROV1ozMmpBSTA2N3J4Y0J5?=
 =?utf-8?B?SHEra3dNa3VZN2hXWXFldy9uRUJ0ZENueGJsekF1eTZvTTl5VU1BNThRcWFU?=
 =?utf-8?B?U2VyczVYUzZWQ3RIRjR6d2dNTDh0SXlZaW45YnpRNUxMbFdOWW9uSnhYUVRL?=
 =?utf-8?B?OEFlc2NJV1lrUzdwYnRIZHc3WXZyTytIWkZaU09EUVlOTTRySG9PbCs3ajRL?=
 =?utf-8?B?NlI4a1hVMWtZOVA4bWgxUmlmTUVQWUpsSExTeFhEeGRRN0lXUEtwU0dsZTFm?=
 =?utf-8?B?bUFmQzE3b2hNWmp4RWJ1ZXRaaTdUdWs3N1czVzFhclpMZmxzZXVvdDk1RWVo?=
 =?utf-8?B?Q1R6S3J4V2xhVXFkVHJHcFZxSDYxMlJMZ3lMY1dmZEg1QkhrSzVOZ0VLRXNk?=
 =?utf-8?B?cStmdHJFdk9ISWxhbnhBaXNhdmgwYUdhY3NsSm1QRVg3VnpIaGhCVUZLNlM0?=
 =?utf-8?B?MmZSYUM3bElJa3IzM2dmaGw5cERaOFFJWkN2TllxUzRhdGdxQXpieGQ1bjdC?=
 =?utf-8?B?QXpiZjY3bWY3cVQydytKc1g4Qlgwc000Z0JWTGRvbnd1c2JGbkFBL2lnUFk4?=
 =?utf-8?B?REhueS9STFRvZGNGa0l4OWlxUnd0YThJWkFIaHBvRlV2QTg0S1RNMHA1U1ZH?=
 =?utf-8?B?Y3NVaVloQkZBaFgzUXFCUmJ0Qmx0aFZsRE1mWGZoTXJ3TDBRTWhaK01aaTZk?=
 =?utf-8?B?RWE3SThlVEpPV0R1TDFGd0RpUnp2R1VHVEkzdElqYmZjNFhaS0FxUFJEekNa?=
 =?utf-8?Q?oyRoj1ixIN877HKAQWwaB8WRh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6a17c2-a97f-46cd-bdb1-08ddb9847d40
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 16:21:24.7872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2ZeprrEpCxRxdy8r0sW9JBOIjHAg2rSyYuNJtNWRoOd/ugRfPtIzn41exoPuUsFK1+PLXmLmyDHZjDABZZ6Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8954



On 6/27/2025 5:24 AM, Jonathan Cameron wrote:
> On Thu, 26 Jun 2025 17:42:40 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> CXL error handling will soon be moved from the AER driver into the CXL
>> driver. This requires a notification mechanism for the AER driver to share
>> the AER interrupt with the CXL driver. The notification will be used
>> as an indication for the CXL drivers to handle and log the CXL RAS errors.
>>
>> First, introduce cxl/core/native_ras.c to contain changes for the CXL
>> driver's RAS native handling. This as an alternative to dropping the
>> changes into existing cxl/core/ras.c file with purpose to avoid #ifdefs.
>> Introduce CXL Kconfig CXL_NATIVE_RAS, dependent on PCIEAER_CXL, to
>> conditionally compile the new file.
>>
>> Add a kfifo work queue to be used by the AER driver and CXL driver. The AER
>> driver will be the sole kfifo producer adding work and the cxl_core will be
>> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
>>
>> Add CXL work queue handler registration functions in the AER driver. Export
>> the functions allowing CXL driver to access. Implement registration
>> functions for the CXL driver to assign or clear the work handler function.
>>
>> Introduce 'struct cxl_proto_err_info' to serve as the kfifo work data. This
>> will contain the erring device's PCI SBDF details used to rediscover the
>> device after the CXL driver dequeues the kfifo work. The device rediscovery
>> will be introduced along with the CXL handling in future patches.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Hi Terry,
>
> Whilst it obviously makes patch preparation a bit more time consuming
> for series like this with many patches it can be useful to add a brief
> change log to the individual patches as well as the cover letter.
> That helps reviewers figure out where they need to look again.
>
> A few trivial things inline.
>
> With those fixed up
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>
> Jonathan

Hi Jonathan,

Do you have an example you can point me to with a change log in the
individual patch? I want to make certain I change correctly.

 
>
>> ---
>>  drivers/cxl/Kconfig           | 14 ++++++++
>>  drivers/cxl/core/Makefile     |  1 +
>>  drivers/cxl/core/core.h       |  8 +++++
>>  drivers/cxl/core/native_ras.c | 26 +++++++++++++++
>>  drivers/cxl/core/port.c       |  2 ++
>>  drivers/cxl/core/ras.c        |  1 +
>>  drivers/cxl/cxlpci.h          |  1 +
>>  drivers/pci/pci.h             |  4 +++
>>  drivers/pci/pcie/aer.c        |  7 ++--
>>  drivers/pci/pcie/cxl_aer.c    | 60 +++++++++++++++++++++++++++++++++++
>>  include/linux/aer.h           | 31 ++++++++++++++++++
>>  11 files changed, 153 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/cxl/core/native_ras.c
>
>>  static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 54e219b0049e..6f1396ef7b77 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -4,6 +4,7 @@
>>  #define __CXL_PCI_H__
>>  #include <linux/pci.h>
>>  #include "cxl.h"
>> +#include "linux/aer.h"
> Why?  There are no changes in this header other than the include and the changes
> to linux/aer.h are new stuff so I can't see how it becomes necessary if it
> wasn't before.
>
> Might well have always been missing and should have been here. If so separate
> patch to tidy that up.
You're correct, this can be removed and added later.

>>  
>>  #define CXL_MEMORY_PROGIF	0x10
>>  
>
>> diff --git a/drivers/pci/pcie/cxl_aer.c b/drivers/pci/pcie/cxl_aer.c
>> index b2ea14f70055..846ab55d747c 100644
>> --- a/drivers/pci/pcie/cxl_aer.c
>> +++ b/drivers/pci/pcie/cxl_aer.c
>>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>  {
>>  	struct aer_err_info *info = (struct aer_err_info *)data;
>> @@ -136,3 +152,47 @@ void cxl_rch_enable_rcec(struct pci_dev *rcec)
>>  	pci_info(rcec, "CXL: Internal errors unmasked");
>>  }
>>  
>> +static DEFINE_KFIFO(cxl_proto_err_fifo, struct cxl_proto_err_work_data,
>> +		    CXL_ERROR_SOURCES_MAX);
>> +static DEFINE_SPINLOCK(cxl_proto_err_fifo_lock);
>> +struct work_struct *cxl_proto_err_work;
> I'm not seeing a declaration for this in the headers, so can it be static?
>
> This is made a little more confusing as in this patch we have both
> a structure called cxl_proto_err_work and a pointer to it with exactly the
> same name.  Maybe rename this so it's subtly different.  cxl_protocol_err_work
> or something silly like that just to make reviewers life a tiny bit easier!
Yes, I'll make 'static' and rename to be cxl_protocol_err_work.

>> +
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 02940be66324..24c3d9e18ad5 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -10,6 +10,7 @@
>>  
>>  #include <linux/errno.h>
>>  #include <linux/types.h>
>> +#include <linux/workqueue_types.h>
>>  
>>  #define AER_NONFATAL			0
>>  #define AER_FATAL			1
>> @@ -53,6 +54,26 @@ struct aer_capability_regs {
>>  	u16 uncor_err_source;
>>  };
>>  
>> +/**
>> + * struct cxl_proto_err_info - Error information used in CXL error handling
>> + * @severity: AER severity
>> + * @function: Device's PCI function
> Run kernel-doc over the files and fix errors / warning.
> Missed updating this to devfn which it would have shouted about.
I haven't used kernel-doc, obviously. :) Ill add that to the list of checks before sending. Thanks.

-Terry

>> + * @device: Device's PCI device
>> + * @bus: Device's PCI bus
>> + * @segment: Device's PCI segment
>> + */
>> +struct cxl_proto_error_info {
>> +	int severity;
>> +
>> +	u8 devfn;
>> +	u8 bus;
>> +	u16 segment;
>> +};


