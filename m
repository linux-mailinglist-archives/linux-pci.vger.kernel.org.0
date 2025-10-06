Return-Path: <linux-pci+bounces-37638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F19BBF8AF
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 23:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF86189D035
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 21:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5899126136D;
	Mon,  6 Oct 2025 21:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aF3v7gfv"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4881A83F7;
	Mon,  6 Oct 2025 21:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759784881; cv=fail; b=nIkQQ2GnPG+0wGYbbtfK6OFMSro1+7flJX2gy23hLmaTHBBBjbAsg2/OAnavMW173vmsBmgdM4TpPpl5/zWPOcppjabwUXYPctuABdFfEjB5zqxX95BImU5ziktaPYefIvhdeUonb5OTOWzHjF9hqOE4f8LQvWTGsDw6NrHu+PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759784881; c=relaxed/simple;
	bh=Yq/7Kn0naHw5JjggI6K3cLwkj7QCmnHl4R/1rgL9h64=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CDtxpgPOYz/g25Wervh0DcGOtqVLv+lE+fYWbpW98QM8/jVnNzWIgt0Dd5WZ1w6hKSNJ62oLtuwfvfn3VGGsig9xl8Kjjf+n+au5+PfZ8I4vUA6wUM8fR2qI29CKewxrPD/cE/Iu6zeu5YYiKjslmmynk8+5i0xZ5sOauDlXwKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aF3v7gfv; arc=fail smtp.client-ip=52.101.85.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnppgZNEQm6tqOzZfePV/+9YrYqr86hQepPpBautDigj6J9+FDNRGlW147JzCS97BqjafSH2De7Wvf9LYeGNShi454R5HSv28YI1u3sKdolwiCb0xPGslBblEhAtlHs9MkI+U6OsLgQ8QAuBeJelt7IsvOLYJOMx8njUNZA3pV8RUXLaFsOssaGTmS2wadxeT7DNfz85Egt4iF/z7OwmmsspxPgqyNOBs5paIHUhFd1W00Z3t+NAtDxsazfgbE8JiSNXwDxKbZu88ncyaPcJJVm7On9+Qw11Hytl7fVdM0kkgPUSgjuVOy1cIlSsLZOVj5pETo787R4hazu3Lk8vCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b37nS/p6FOq4YoixKxKrkIIPLf9PW+VJdKYmx+MWxHc=;
 b=pz31CS3tPnReNbAoq+MpD1p0ZxCIG8D9mjfqdZm1RAoRvhm3ChgpqvVn38ZWtICa7t3HgkIQleiooJHVEqmlu6xN+ctbvvENVAvVc0He28ZD6RwOXhfysESCzoZV06HJoL9SFZT6cCYETSwjnVcZ5QpKsTcYMebZ4G7h2ugzY1nxEm/yfRNcYMNwVXUBxJlz2fLs6XsGBTAaXgFV8Qt0zIkdDTuAIzNlEaDpAKkiIZt37e0fgvhKsUnxa6OL4MNu6obMI3nl2pVpcn0aFJlXhTEzu7UhbTa0TPg01v+FH39iRA8V5jBQqt0wkN0MnotmcTYi4DaHhNWFvOk3jQyzPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b37nS/p6FOq4YoixKxKrkIIPLf9PW+VJdKYmx+MWxHc=;
 b=aF3v7gfvMMwn6tK7RHAKU41gl38tQAPgvSRIAG36Y79Zy6dXSB6WE4fkNnWbc3fLAlIZ/q3W7mE233dwefGTilc7Vg3aSn7fFnTDR7HCOExcajDxDfr9wnKWZ8aG7sStikxxRCsySeFb7FoCnFxCSjo1Y8wtYs4CP3u0QIueMNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.18; Mon, 6 Oct
 2025 21:07:51 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 21:07:51 +0000
Message-ID: <31bd945c-b1b5-4899-b089-bc7f5b2e5e65@amd.com>
Date: Mon, 6 Oct 2025 16:07:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 17/25] cxl/pci: Introduce CXL Endpoint protocol error
 handlers
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-18-terry.bowman@amd.com>
 <161e558a-11ae-4b57-ad4f-7736e23da1c0@amd.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <161e558a-11ae-4b57-ad4f-7736e23da1c0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0190.namprd13.prod.outlook.com
 (2603:10b6:208:2be::15) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|PH7PR12MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c33284-ba49-4347-9a20-08de051c693b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnZmM0VTM00rWVllRzFPMzBselQzUnNDRVpDakdRYWswRVc1cWRTNUJxUUVS?=
 =?utf-8?B?U2J0Wm9qMERlTUIzTW9tUysrSi9CNTNOQm1nZVI0QnBMVTZOVllSRzg4c2Rt?=
 =?utf-8?B?SzNNY0FONmZFYlR6OEVidFZnUGZXeGFxZHlPRGRRaVVQVGdtTVZzQzNGQTR1?=
 =?utf-8?B?aUkrL2VaOGZMU1VNbEY1VGI4UkJJSFNNd1dtbzBOb3JWVkJ1VVR5cGF4MHN5?=
 =?utf-8?B?dXMwY2lpME5BS3VUTXRTbnIwek1vQ1VhTzN1OGdlL2pyeFh4UEg4cFlXSVZD?=
 =?utf-8?B?KzBiL3FudWdwWHo3MFVaQnFtK0RmRTQrRklnMUJIUk5DUDM2WXNJVm5HbnE0?=
 =?utf-8?B?NkU5NW54OWlrVUNUUkRBVzVKUUpBRkVxK0plSlpQRDJIa2M1VlNOUmZUTW5h?=
 =?utf-8?B?YVNpeGlMN0ZzN0NqMWhGd0xYZUVPZXU1a1MxdkZBRFNqQU9HcS9XbFd6eXRp?=
 =?utf-8?B?V3pqd0IzVFUzRkhic1BXeitYQ000dkorZXEzOXp5V0ppTmJMbExJNVFEcnUw?=
 =?utf-8?B?SHhaY0ZhMnVDcDRIbTBJb0t0SUZJd29TZmcvNmhJZ3hDZXMzWGhsWHNyL2Fl?=
 =?utf-8?B?S0tGUkJjZ2h6ZU82ZjJKMDY3aC9YNHFnWE1Zdm1vdGR0SFZ0czR1VVZ2b3Fm?=
 =?utf-8?B?WGdWUkM2SHRlSU5vQzQ5NkhNS0o2a2piQ0c1ODk3QTBZVWFWQmNEWm00VUtV?=
 =?utf-8?B?dUg3amhybWlQNmZaWVNQVWNGRGsxUEZLeitNdWFyRXZDb1c2V1RxVXNHbG1z?=
 =?utf-8?B?TDRuZExDT2hLbnNLRC8wOWxWdDdPVUEwZVJ2eFNwdm8zUGJ1cFFGaWJidm1v?=
 =?utf-8?B?UjNsK2kyaGlwRnVSVlZLZzh6bkgyWUpEUnVmSFVGZmdpVk44aU5JeFVjVHZ5?=
 =?utf-8?B?eDNaT2IrMFJDL2FoQ25yeWc4L3RiVmtiNVNWYkRZSHZ1U0dCY0NsMittemdp?=
 =?utf-8?B?T3dPODJ2YVBEcGdSUE5aNVlTODBkTmI1TVpHcm1CQ1IvNEdQTUlxendNRnFw?=
 =?utf-8?B?d2UxZExzL3FBSkJ4UjZxVWlicVVET0tEV0NaSkxnVUdodGpQZTY3QzF5VjB1?=
 =?utf-8?B?cDMzY2tUT0JnNnM1d3I0bkxJakVrSDFsMEtmVVlxY0dNeldTTWx0b2lLdDZC?=
 =?utf-8?B?NTd2YmJaNGw3eE9rQVljMEptWUpPejhELzdTd0FvYlFGUDlkNHJyY0hjWDZK?=
 =?utf-8?B?dE1McURkNWVHUDRtczcvcU1wSzZQdld5QmdqSUJnK0hTQUE1RklGN2dtN2RT?=
 =?utf-8?B?ZUgyeVI0WlJNNy8xK1phLzFDbXM1YWltMGJPa25uSk9OdlJGQkdGbDZLdU5I?=
 =?utf-8?B?d0FBdVZwVllxQjc1SjVoTW9YMmFWdUZlRnp1Y0RvTDM4QUp6bjZieUN6Uk1I?=
 =?utf-8?B?NmVjT1ZvZTJwVmN0bUx2aUNlYmFsd0xLWUxsbk42OE5QTHY4L1JYR1VvSzB2?=
 =?utf-8?B?Vzg5YWthMERSK05sSzRIMHkwQnc4S3RGdFpORXVyYzdIZDZtNHR0K05FN29k?=
 =?utf-8?B?WFJpTVBOL1FqNlJxZ3B2eE8wcEw2S1RlMXE5amsvRnp0L2V0STk5VEorYzhQ?=
 =?utf-8?B?WHR2S1hRZmZhREZSNktjTndFUGg1c24vdXhCV3NWNmowMUd1WkNXV2ZWSVBk?=
 =?utf-8?B?MFQ2REJMR2dvdEVIaXdPNjJhbllNWmNBMFRORlRaclJ2WXc0VFcrdkhkK0x6?=
 =?utf-8?B?Q0pvOURPMkdFK0xhY0J5Nm5mZWZQemYzR2UrQnFrdC8yS29xY0tBcTJ4emp6?=
 =?utf-8?B?bTZ4MlJabU5zWkwxYTNERTg3MUlOR0VKUkNNVzFHN1Y3cGllRHpjY3hJYk9u?=
 =?utf-8?B?L00vSFZQZjBjRTduTWJ1eUk2WDZmakxVbWRQR2J2QmxXVWR5c3RxM0VWdDJk?=
 =?utf-8?B?ZmhzTWpWQkRHOHdxVlJCbnhWRVV2TDBKakRDcUJYTmxhYUEyODVSSkFBNW8y?=
 =?utf-8?Q?sFWgAUfgKWQmXZ8Y61cMTG++Y/lfvYlO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVhFOWNXWXp1UFdSTnBJSGFTMUt0cTVrcVB6MXM4YkFuYTBrV3IvckFtSktF?=
 =?utf-8?B?clRWWjlWSW90eWwrbHBTY01wS1Z4YWZXdmY4RlIra01OUTVvZlpTeXpNdk5L?=
 =?utf-8?B?VFNZQzdETDc3M2RjcUN3VXc2WlZZK1ZoR0Ixazg5aS9Wb3R3dGdwNjl3UjZv?=
 =?utf-8?B?Y0JVZ3hTeXYzbDJBZEVvaGZiL0N1d3ArU0hJdmd1Q203LzdxdkRoY1h2UTVP?=
 =?utf-8?B?eFZGcGk0bnc1N3diZ0pZYUVYRVk4ekp1S1VnQlg2MytiVkx6YTk2RXF0Z0F2?=
 =?utf-8?B?eTVSc09OMWx0ZVIyeGRDdWdtd3QyL3Bad3p2ZmRBNGZHZ1BNOTE5UVd1L09q?=
 =?utf-8?B?S080S0lKMTFHQ3dsaXBDdnIxRU1uSi93Uk1DWjkvS0pvV2dOR1doTHpRYVla?=
 =?utf-8?B?Q1RiUEJySzQwUEdRUVp5WkR6V3BkT2RhRWhTVlBJS2RCNmhtVmRXRDh4Q1Ev?=
 =?utf-8?B?RmJvZlhVZ3pvaDduUHd5MTVZRit0T21VUjdWTGxGUUQrZ3ZOMHZnbGdISXox?=
 =?utf-8?B?ZkloeGtpNFBabFZpa1BGQ1JQNzBGNE5pRzI0QTI5RCtMUm1zR3Z2NGRleXNi?=
 =?utf-8?B?ZFhhcVltMWZXY3FMYjVIckw1WkJ1ME9aWVV6SGdPM2dOUFNFU1NQNlZNa2NI?=
 =?utf-8?B?bE1Nb2pWTktaWnJJZFArRWtjeTBlaEczbFVTdXJDNndKa0JTTER4UVZsaXRJ?=
 =?utf-8?B?aFUrcUtQSS8zaitLSHloZVR2ZWM2bkYxS0RNY0RJYVdEK01RM05tNXBQNTN3?=
 =?utf-8?B?SlI4SHorY0ZRYVAzeU11TFpLMUxEZjhzbmJFSzNYY2xUVE95OUVTcEN5Yk40?=
 =?utf-8?B?aFl6VVBkMDVieW9ZZ1BaZDlaU0xUUndkZSs2NkZmQlFGVFUxVkEwanlxUFl0?=
 =?utf-8?B?YldFNnl3Z1UxVnNoSjQxSzlxd3NsdHNuSWVsWFNSNnp3QVk5c200N2o4aEtu?=
 =?utf-8?B?SnpYdmZkcm82VVVLQVhNN0kzREhyTEhmZ25KSUVzTVVHZjhkRjMrUVM5WFZh?=
 =?utf-8?B?MXlFc0lZNkhxOGFLZ0RiNjJ1bGh1N1NkbTFHTHlWeEttTldid21IUk5LeGZq?=
 =?utf-8?B?L0lEeSt3UmR6RlNhS3V2MUpQSXd2WnJWdFJrUFJaOUVrS1dTT1hBYUJKb29i?=
 =?utf-8?B?Q1FMS0IrdDhZRXhSRnRFOUJoTDV5QnYzN2ZpeENJbndReXY1NGVhT29teTFR?=
 =?utf-8?B?ZlUwbEFTRVZFNjRiZVkzTGJUaDFLeDArR2dXRzE3L3krUGZBWlpoanJBM3FH?=
 =?utf-8?B?VE1HVmpHRFdsZTFja0lLZGQ5S2o0RWNrSHk3ekRIV1BtN2F2UjRjRW5uUWNL?=
 =?utf-8?B?YzNYU0kvbEs3NUpIVmtmYk1vdHBma0hKM1IwZzByR0UrL1BkSTNPWnhuN3Z2?=
 =?utf-8?B?QjlJWEQ0cnNjOFZLKzBVV05GUlhSV2dYU3dxaHM3WFZraEx0dkV0NmRKVW1j?=
 =?utf-8?B?ZTZkNUVlZlRZUmVwNm5KeXFRN1BvNFhyYS94T2xBdUxxOTQ4MzZkSWQ4WjJU?=
 =?utf-8?B?QkVYcWE1ZXpxUXJoU0d0bE04cFZmaXJvdStleTRLUXZUV0p2M3hhb1BKYkEr?=
 =?utf-8?B?RXVCTklVaERhZnhtUHMwMndNMGwrZjlodVRreFh2VlpZTTIvTkxsV2dDSy93?=
 =?utf-8?B?dU1sLzlQL2pScTB4R1orV0V6NkNoR2ppbndpeWt0R3VTRFltTklwbVdZdERt?=
 =?utf-8?B?NEM4c3lvMTNER1V0VDhKN0xqOWRwb0R4MENsODZxWWNPRGM5UUJRUmJaMm1w?=
 =?utf-8?B?Y0IwYlY0cU1MNFhzdU1yZG1sWGlTWGFud3hZTjZxYXUwN242NG9QMUYzOWZN?=
 =?utf-8?B?cExxeG1SeE02c1FudjQydlFHazBPMVhHNkxsYTdRVno4WURnMiszUGZmOWtz?=
 =?utf-8?B?THAyM29mWllMWllNa2dCM25WUFNDZ1BIWVFvREJXd3U1RWp3ekxiQWRkY05I?=
 =?utf-8?B?T01xZmcrbG44Y0hRME9meHYxWnlQZE1RaWc4MVZMcEFZZWVycWZNbnpYeEZN?=
 =?utf-8?B?cjBXTXZOMjN3dGM4WXBESkl5dHowSHBNZ0ZxT1JvNDdiQVlQWTJVZ0ZNWUZu?=
 =?utf-8?B?UytIWjd1cHpibzZTOXZncmZqMlVDNkRjZEVTdTQ0MVYyRjJvbGpJMktTaEgr?=
 =?utf-8?Q?VnPl8MalBCKyYAQHLFQofVRrO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c33284-ba49-4347-9a20-08de051c693b
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 21:07:51.7627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57vdVqGqlGyrAKysVhUiq/MElr4+kOm/QYhZR1RBPXDEv1l0IFAu7NiQwSyLJTnPmuB02oJiXE6Yf9QmBZK2ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976



On 10/3/2025 3:12 PM, Cheatham, Benjamin wrote:
> On 9/25/2025 5:34 PM, Terry Bowman wrote:
>> CXL Endpoint protocol errors are currently handled using PCI error
>> handlers. The CXL Endpoint requires CXL specific handling in the case of
>> uncorrectable error (UCE) handling not provided by the PCI handlers.
>>
>> Add CXL specific handlers for CXL Endpoints. Rename the existing
>> cxl_error_handlers to be pci_error_handlers to more correctly indicate
>> the error type and follow naming consistency.
>>
>> The PCI handlers will be called if the CXL device is not trained for
>> alternate protocol (CXL). Update the CXL Endpoint PCI handlers to call the
>> CXL UCE handlers.
>>
>> The existing EP UCE handler includes checks for various results. These are
>> no longer needed because CXL UCE recovery will not be attempted. Implement
>> cxl_handle_ras() to return PCI_ERS_RESULT_NONE or PCI_ERS_RESULT_PANIC. The
>> CXL UCE handler is called by cxl_do_recovery() that acts on the return
>> value. In the case of the PCI handler path, call panic() if the result is
>> PCI_ERS_RESULT_PANIC.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> ---
>>
>> Changes in v11->v12:
>> - None
>>
>> Changes in v10->v11:
>> - cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
>> - cxl_error_detected() - Remove extra line (Shiju)
>> - Changes moved to core/ras.c (Terry)
>> - cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
>> - Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
>> - Move #include "pci.h from cxl.h to core.h (Terry)
>> - Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)
>> ---
>>  drivers/cxl/core/core.h |  17 +++++++
>>  drivers/cxl/core/ras.c  | 110 +++++++++++++++++++---------------------
>>  drivers/cxl/cxlpci.h    |  15 ------
>>  drivers/cxl/pci.c       |   9 ++--
>>  4 files changed, 75 insertions(+), 76 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 8c51a2631716..74c64d458f12 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -6,6 +6,7 @@
>>  
>>  #include <cxl/mailbox.h>
>>  #include <linux/rwsem.h>
>> +#include <linux/pci.h>
>>  
>>  extern const struct device_type cxl_nvdimm_bridge_type;
>>  extern const struct device_type cxl_nvdimm_type;
>> @@ -150,6 +151,11 @@ void cxl_ras_exit(void);
>>  void cxl_switch_port_init_ras(struct cxl_port *port);
>>  void cxl_endpoint_port_init_ras(struct cxl_port *ep);
>>  void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>> +pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
>> +				    pci_channel_state_t error);
>> +void pci_cor_error_detected(struct pci_dev *pdev);
>> +void cxl_cor_error_detected(struct device *dev);
>> +pci_ers_result_t cxl_error_detected(struct device *dev);
>>  #else
>>  static inline int cxl_ras_init(void)
>>  {
>> @@ -163,6 +169,17 @@ static inline void cxl_switch_port_init_ras(struct cxl_port *port) { }
>>  static inline void cxl_endpoint_port_init_ras(struct cxl_port *ep) { }
>>  static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>>  						struct device *host) { }
>> +static inline pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
>> +						  pci_channel_state_t error)
>> +{
>> +	return PCI_ERS_RESULT_NONE;
>> +}
>> +static inline void pci_cor_error_detected(struct pci_dev *pdev) { }
>> +static inline void cxl_cor_error_detected(struct device *dev) { }
>> +static inline pci_ers_result_t cxl_error_detected(struct device *dev)
>> +{
>> +	return PCI_ERS_RESULT_NONE;
> My understanding is this only occurs for uncorrectable errors, so should this be upgraded to
> a PCI_ERS_RESULT_PANIC? If uncorrectable errors == system panic, I would expect that to be the
> case even if we don't have the code to handle the error built.
>
> I guess it's really a question of how safe you want to be. Is it ok to let uncorrectable errors
> propagate when the support is missing, or do we always panic regardless of handling code?

Here the CONFIG_CXL_RAS Kconfig is disabled and these function stubs allow the linker to complete
the build.PCI_ERS_RESULT_PANIC isn't returned because it implies handling but handling is 
disabled through unset CONFIG_CXL_RAS. If CONFIG_CXL_RAS is disabled then the interrupts
and CXL RAS logic should be disabled.

>> +}
>>  #endif // CONFIG_CXL_RAS
>>  
>>  int cxl_gpf_port_setup(struct cxl_dport *dport);
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 14a434bd68f0..39472d82d586 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -129,7 +129,7 @@ void cxl_ras_exit(void)
>>  }
>>  
>>  static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base);
>> -static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
>> +static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
>>  
>>  #ifdef CONFIG_CXL_RCH_RAS
>>  static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>> @@ -371,7 +371,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>>   * Log the state of the RAS status registers and prepare them to log the
>>   * next error status. Return 1 if reset needed.
>>   */
>> -static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>> +static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>  {
>>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>>  	void __iomem *addr;
>> @@ -380,13 +380,13 @@ static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_bas
>>  
>>  	if (!ras_base) {
>>  		dev_warn_once(dev, "CXL RAS register block is not mapped");
>> -		return false;
>> +		return PCI_ERS_RESULT_NONE;
> Same idea as above. I would assume since we can't tell the severity of the error we would
> just treat it as the worst case scenario.
>
The RAS UCE status needs to be read and verified as UCE before handling with a panic.

Terry



