Return-Path: <linux-pci+bounces-15637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015099B687F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 16:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871101F22832
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 15:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4D01F4711;
	Wed, 30 Oct 2024 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R7BNLjgv"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5B6213127;
	Wed, 30 Oct 2024 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303706; cv=fail; b=qohKmVWeYqag32VW7EITjjs5rSemCFe66U+qPnt+Yw7jCtEkc3gGcijJL+Xo2fJHm8wTpk7kOjui5mb8KPIMLUIFYik2buUOJYs/6rdIAE809IW2HOuagjdWzbova5cRyz2kvWcGLXsuBi6b+4gNMgAgW2iIncGfqDoanPZBm+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303706; c=relaxed/simple;
	bh=YIVNe6razYrj9YqkkPk7GX+Ygagy4PRE5p43Kc/HOek=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xi3K1pScGMtG9M7Y1+F2qdcqAjNp53VgPdXjCcD9lFtvweqs8A8UDd8g8TKBxCipBsSR0Vu5pF/aJdHefpC10nhvz4jgLfm5Hgbo7eRvUlzIPlOqxnhLt2Eg7WrfqXbciFMiv8lYr3jo2Lt0zYCctL+oaWIGaN8qOMqvPR5G1SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R7BNLjgv; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6NfaWIgtIRVUiyBPNVagIFBhjBwipBnpLA53h77CBIEAFcOPQRKGTRAWNMxrHJqkJ8ne+RKVrfviz16zAqb7Knoa5609Rg1f3tLh5cpVF6uL2eC+Lw8f13GDxzsfsCjFHDu2MIwhy6EgSsu+JPVX9UYKNBYWZFR5TBg+AuRPh78RCUGg17o9lfh+k91D4Lz/T/sUe+kxne5rsujOLSa2/mV6c2JCZbO8Az/j+dA9EorTG0obxKShxD2NzI+99rmAmjpU/PJGRNJfahov9CoblETcDuD7KXC3UR9Vicdc2Erhu7760rta/KT/wQSC+KcZsDlDK9ybo236RCgGIz5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIVNe6razYrj9YqkkPk7GX+Ygagy4PRE5p43Kc/HOek=;
 b=nDPiY2RP6Tt1RRAhT/p+CvDNHQ8IklqMMRwVta+oM05/wjsVDQsgyevTOo/BbHJkRvSC/7Qrvb0sDTMtgMxMwxfPCtpTELZm/JCVAIIFd59lnWHsstAEGkYCo8aIwr5S3rfeUTx8calfxavVPDWpSix266ReaNdzIPP9a3NKGIkw6ufC2agA0cQXMdtpB3vB/6H5hNZkga75vnevwedBhTbEnOjnWOVXUCsLXwZ0R15B5oVikDZQJ7ni1NJJIkaq0OObWr2scc0cD/L3Z9VvH4brIyeGEW7s7gZeTpciGkbE+IG4g2mI/Cak0gmcB8kvdzRVOu+ENoXOL3Ol4OWHVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIVNe6razYrj9YqkkPk7GX+Ygagy4PRE5p43Kc/HOek=;
 b=R7BNLjgvGfnX7UCYtvfTWkkcRkCJRK7VMBPdojPxNg76U6RKBBfUI4IecXyyJsUXBt9kIJZ/pZXZbZTamCsJp/7EIr2MY6yEQzvOLazFz5+KLxzKA3a6yA6sgusbmQvTwH6eNx7z2c0e2DoZlyMstnmlVTglPr2cJKsijhGC0Qg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.27; Wed, 30 Oct 2024 15:55:01 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 15:55:01 +0000
Message-ID: <64ecef65-6935-4e97-b028-fd11369b14ab@amd.com>
Date: Wed, 30 Oct 2024 10:54:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] cxl/pci: Change find_cxl_ports() to non-static
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241025210305.27499-1-terry.bowman@amd.com>
 <20241025210305.27499-9-terry.bowman@amd.com>
 <20241030154536.00006f9a@Huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20241030154536.00006f9a@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0158.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::13) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DM6PR12MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: 6854e8c1-6fd6-4394-9a9b-08dcf8fb3663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTlMMThhYWRQVGRLSHllR0Mva2tCUW1aSll1TDJ6U04vaTdobHdtTHgxVlJO?=
 =?utf-8?B?NThHNlBBN0pVcWo4ODBqVFNob1B1NjdUMGVQVGpBTVJaZE9UV1JNUUFldkUw?=
 =?utf-8?B?WUtGTmJWR3NGeVp1R1FHRDYzQURrblZKZ3NlbXNLby9IVDVoNXcxVThycE9E?=
 =?utf-8?B?bGdxMWI1SlR3dkp3ZVlwWU5CVHc0enlXUVcyNlZ5SFRLNEhPdFFqUFlIaVBC?=
 =?utf-8?B?NUZHYWdEeXVxd2xQR2FHM0Y0R2gwSVppN3hrTncvL2ZlWnVVZ3VWTHRSczU5?=
 =?utf-8?B?cWhFZldoaXNjZ0NBcG1zdmhvOWpBNXVCL3FPdE45WDUrQ3gveU9icGtsUXZn?=
 =?utf-8?B?Tm15bnFxTll0dlFGRStDc0x6MUk1aFdDWjZqTlJGUWgvN1BoNEZocHVUZXVB?=
 =?utf-8?B?bEV4WGZpMzJudGw0Y0dBRlg4QW0xd2tadit3anhMYnMxblFmUVlvOEtVb1ND?=
 =?utf-8?B?VUd4ZzhTZEp5ZlZUMDNVU0I2R0NMSlhKb0dGMnJPVzNSYTdHUktjU3FNQVhK?=
 =?utf-8?B?M1FJVUlRcjNyS1VSVjUrNGg5eFZkUERWV1lTN09KZ0lld25IV3hxL1QzZHE2?=
 =?utf-8?B?SW5lVFM2bUZDdnlJd2JVRDVPQWJmSERGZXpuYk5CYU8reGdwTVdUWDFhWG1w?=
 =?utf-8?B?RGNubzhmNEg2VThCNEg2NFUxRTFaRWQ4am9zVS9SZ1RhZFZzTGdnWDg4QUJz?=
 =?utf-8?B?bUNyZ1pnbmQrYnRSbkh6b0M3Q3ZEZHkyd1NDL2E0R25GcTdqaTdLUkE1WXd5?=
 =?utf-8?B?cW1ZcStkc01PNjdIWWhic0JLMndHVDF4bmJmdHhxalRuNkd0V0VrRDRPOE5i?=
 =?utf-8?B?aTM3OXRCUEZmdVovc2tSRU41TmcrRzNIT0JnYVZWQW42VVZuUE83dmdiNmJs?=
 =?utf-8?B?UTh2aENTWTVsekZ5Yi9ZaENPYS9QWXZNeHUxRGNCQk5nMklPY3BEQngyeUIx?=
 =?utf-8?B?UlRSam1RUHJlbHVLS3psZ0x2SXNXTHBSMmxxRG83ZUZtRVAvSDVtMHdSVW9k?=
 =?utf-8?B?K2t5ZXEyK3hxaW83S2VDNHNNcEpaeUJKVXJpWGFJNTc1VzZTZDU2c3ZTRlBX?=
 =?utf-8?B?bmFKbnlGNnQzT284ZGpOa3Fab3dRN0duZHd0emE1OUhkSXRyQVlBNEJ5dWRU?=
 =?utf-8?B?RXpnUHgzdmlTYUxleXhocmw3QUFVV3dnMzJqa2dkalFWZE9URldpd1VLaGkv?=
 =?utf-8?B?NTVHQm1zRlRNdXhvYUhDTmVvUnNhQzZjSTN6Q1V0czJ1ZHBnVklPN1hicGtx?=
 =?utf-8?B?SUh3czZULzV0MTlPVHJiZlhoR28zYk9KTkROUmhpQ05WQ2w4QXpYR3Rad2RW?=
 =?utf-8?B?b1AySXp6bnFyVWNzRGFMZEt5Sk1xc0ZSMTdjalAzUElVTk0wZll2eWZYUzB0?=
 =?utf-8?B?NXZZbXZ6akJIY1ZRcUpWUkpJamY3L1pQeWdxZzZLQ3lYYzNDeTVhQUdGaFVi?=
 =?utf-8?B?Q1BDTkkxQ2FFSnpBWmUzZDVVUXRZdjkyN1EwWkNHMk5yLzZNSXBJZjJrVFhJ?=
 =?utf-8?B?VklTZk9XdHNqQXd3QWF5Q3pESE5CYW1IYTRndVJWeHJ2NXp1THZHUTVNZ1U3?=
 =?utf-8?B?anQ2Z1pmTmhwQ05BOGxDRm50dEQ5RWxkdkQ0NXk2RjFwbk1WcWJjZjhmak4r?=
 =?utf-8?B?UUVBQzNzcUkzWm9McXljQzlTdU90aS9BVUcvMG9IRmY4b3JPSk9OeDhRS3ow?=
 =?utf-8?B?ODloSHZaeDBLMWJGMUo3UEUvdzBXV2t2TUYzc1FzM1JlUGhTR3ViN1dVSFdT?=
 =?utf-8?Q?Den2c60SgX6KrXbbLlyu/8JYUx9M2naLDT9pThE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmc5UGRMaDhPTytiRzRUU3NkY0N6aFFFNThXdTh4Y3M3Y0ozTWNsRTJvMG5s?=
 =?utf-8?B?eGtHVFRqRzRrUFJrbUlJbzdJTWJRUmo2aklSNXlrS3ZQL2hLNTZCdytlU3dQ?=
 =?utf-8?B?SHVDb3dVTzYraDhLaXNYUVNySVNMWmVvR05SU3pZNWpGdWlmaER1Zk9LS0pK?=
 =?utf-8?B?a0s3N2lLVkRjaVg5NU5CMUMwd2RJdzJxcnhNVkNrUmhGQ05kWDZjMmxNKyt6?=
 =?utf-8?B?eUZBdkg3aHpaUHowc1krWndDK0JZdlkxTzFQV3NBYVRxZHVxcUJ4YzB3L0Fy?=
 =?utf-8?B?ZzhqdDZ5ME9mV1FtZVdSSkIxODc0MTFuV2JLUW5sY2dlSG9INUNOMXpCWVhS?=
 =?utf-8?B?ZEU2QjFLSHByS084QWtaaC9tSkFXY0ZoTFBTZm9IS2hBN0k5NzdpUk9nM2lo?=
 =?utf-8?B?RThzSHFwOVZqaWsybXZUUi9xWWxVT3dNNGVlTFdkTjFrN0xnRG1pRlFzM2dN?=
 =?utf-8?B?M1BRY1VRVjFQT2k2bWl2cE9NZlRkQlJTcFZndlQrUlpjUDd3RjdTVHpWSG5Z?=
 =?utf-8?B?dlRKMHZsWE1pVHNyVklsM3p3cWlqUFBxSzVCMnpPelZ2YVVuRnpremRBTnZM?=
 =?utf-8?B?dkJwNTdrNytwOWVmeHRpOFJJdzl2RGhHMGl6emJqSjdmVjVBYzZTRnJvL0Fv?=
 =?utf-8?B?N0pGYzhEeW0vOWhXdUZqejRHNUJJNmF4OUxWeXhTNkc5QlpaV3RXa3NXZDkx?=
 =?utf-8?B?eksvMXZsOVlNUTdFajBJUXR3Ulhpc1JLMzc1aTRTaWV2cG1XQ2NFY09RcWVs?=
 =?utf-8?B?UVB0RWdvdlVuV21LQTA3c0tqZUorTWExOTJuRVh6YXd2Z3VsSDhkdTFBeGZS?=
 =?utf-8?B?cHYzU0YvUldpcXpYcWxiZDY0Y0tyOFlXUlg1MmFXT1V0enA0Mm1tYU92cXNs?=
 =?utf-8?B?emU3cnZnd3ZlNWduRXJnbVpuTzJhdnRlcU4xcEZhL1V0dmVta3cvNk9Jd0NZ?=
 =?utf-8?B?dWN6dmsyczZKc2FyODZUQm04Y3BEeXNta0R5UjEra0Rjek9XMzNBbnd4YUJO?=
 =?utf-8?B?RzFLaWg4Ri9vMTg4K3U1QnF5QlFKUHpwMHBnRlBsT2dNTDBEM1RIem5WSkNm?=
 =?utf-8?B?MHA2d3VIc0RGY25rYzIwa3Z6bVc1TzVldFFiSDgvV285aUJWdlh5RHZGVkFm?=
 =?utf-8?B?ZkJqems3WEh4YURhRklPbjA0SUp4NUQ0WW5WYitpZ2NrbVVIbEFNeXFnT2Ix?=
 =?utf-8?B?bG1MZGswd2o4U3JRUnhlbXdPb3JpdTlrdU4wbVZDRzJKL2Y4SlNrMW1UMlZs?=
 =?utf-8?B?WkhYdk0rQTI5QXc1V3Y5YTdjWHJmYnV1VlI3Yk1NTWVpblAvTEVIcktlVllR?=
 =?utf-8?B?MVltY3YwOGMvOFF3dW11WE9MeVJCL2pwK1NUMUpxR1doNkxnRU1lZENKV1ky?=
 =?utf-8?B?QUtURUFES2FLZllzbEFEeFFTVzZ1Nzcvb0RycW9JbS9wbVNrZllrSm9jem1N?=
 =?utf-8?B?MDAwbExQZjkzU0xqVC9qZTc3MG1LUVRlVlZtd1JFcjlMS3E5OXA0ZHJmWjZy?=
 =?utf-8?B?SFh1U3R3Yi9TRUJmM1lQSGdHbUx3L25nSWhFaFUrZnYvdzRMOEptak9lYXhO?=
 =?utf-8?B?R2xVNlNXbzZ3Skp1RDFFNmIvMFJXekNRYlJ5TWg0U1UyOHJ1dFVRYVBhdUF0?=
 =?utf-8?B?Qm9yUFV1NG5zWXhzNnFGUjdjQ25kRUV1VmxqT090eFpkOFhjZHVGcEhxZU5P?=
 =?utf-8?B?ZFZJWFlmR0w2alJZWU52TDJFcmxnTjMxSWI2ZWFpbWlGeEJ5RktvUmFyaVVw?=
 =?utf-8?B?UEFWUlp4OG5YY1lTbXNGN3pvaVE1UEFVMEMvK3BaSDVCa2svTmdEbXYrQ3VP?=
 =?utf-8?B?REl1MkRKUlFLTzl4djUrZEtuY0NSdFRuNU50RnYxQS9Ram1SRW9hbXhRYUJn?=
 =?utf-8?B?amhDR0FOQUN5WnQwdTRjajBSQVVuMVd3RnNTeE5JcUR6N3ZLWk1GWjBzT2gx?=
 =?utf-8?B?QVR5NWJOYVJMUXZHY3ZMVVM4SGh1U0gwdkw0WkVWcG41ZWRqcEZkakx1b2xw?=
 =?utf-8?B?VGNzR1ZjcVV1dUdWUGtrSkR4cGlHRngvRTNld3FCSGg2bzZCNWUwU0Q5eE94?=
 =?utf-8?B?TnlxeFdNajlPblNnbWNrZGFQWTIvZGkrdUFUaENWUXMyRk1IcGVha0VhcU1z?=
 =?utf-8?Q?SSekR5ygSxXJEJNj0uuZKhTTG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6854e8c1-6fd6-4394-9a9b-08dcf8fb3663
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 15:55:01.4517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IChpJz42pw2JLALaAoY+UR0xWQ1XY2UWObBEsCNtSsqZxxlWC3x/HWs/uV/5jeoI6sJGLmZvVxS5/Bj13AV9Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234

Hi Jonathan,

I added comments below.

On 10/30/2024 10:45 AM, Jonathan Cameron wrote:
> On Fri, 25 Oct 2024 16:02:59 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
> Typo in title. Shouldn't be plural ports.

I'll remove the plural. Thanks.

>> CXL PCIe port protocol error support will be added in the future. This
>> requires searching for a CXL PCIe port device in the CXL topology as
>> provided by find_cxl_port(). But, find_cxl_port() is defined static
>> and as a result is not callable outside of this source file.
>>
>> Update the find_cxl_port() declaration to be non-static.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Doesn't hugely matter but I'd do this later in the series as it's
> not used until patch 12 (I think) and by then reviewers may have forgotten what
> it is for.
>
> Fine otherwise,
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks. I will move this patch to later.

Regards,
Terry


