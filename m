Return-Path: <linux-pci+bounces-37283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23219BAE140
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 18:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AAE41944DE3
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 16:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F36F24169F;
	Tue, 30 Sep 2025 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QgGA3Bdt"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6642343B6;
	Tue, 30 Sep 2025 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759250634; cv=fail; b=GTzPaa9FTHdT/wR4cSlEsQS2LjM5087nNuFVQ2jD9pkOCsYCGTT+7bFLBh7YWvV7pXuTUJfPbLD5mheoM5PVuICUtGc7ZynWb25BSL2+3viNjWZcYSOUv0JdqAN9lP3oYy3wCiqsz3eFgc47GOPSY+/gEY0ERSmN2A7E8qzouLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759250634; c=relaxed/simple;
	bh=Fi0NXsOgFrXLvGFmYGGn7NnhXxB+R5Zo+ilJVPiDoIY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aIlz2jUfINs3dlciGplW6D46MgHYS6vsb5oizKDf98xNh5WiQGrknd/pMHAekCVMOg4VB/z95XyByymlzqs/j29rmqes1geWlp/IfYSk71dKY6LBhK0/1yKUdq6mRWdvmCG9BjfRsJCyfsiADHWiwQZ2H3ms9CHJPw5sDlSHzw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QgGA3Bdt; arc=fail smtp.client-ip=40.93.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrXxULM+2XKm3InplgkcoBF/Eg2wB3axnIxFNMI0ezcp790i3UIsF2Azv7V+HIP+0L78ti6664+QvxsLalCUW3atR1pYcevij9Y+0qUlF7EoIFbwB578x58MSOe4+2briGtWK66AozdU0UmElx0j7PirUHQgAKJVS76XUNT0pOglAiYOHwmDcH+JG1nPnSE+u7esIy/t+hL9s3/J3F02+IWE+cA2YIkCheBwKpuxLYKfFtFq/bKwYa0EjUZ5fy7o/mrYA99Dppjaag7NEm55aHevaKS+5SYUe4dVGrRsEbe0cT/+mIBjUYcmB7OCUFMGH+xyKT9y0i3DYMTQEL/W4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIqGsgax4lEW4rcOT2B729v3Cijj8obJBI1Ska8Vp4s=;
 b=FZ41jKUluNrt2HJGkHmagrRYDJz1QhMMQ9yBqUSu3BmZnR9W1ryv4XUTdJGbl1XmqbnkFZWjOoEX+sinaD39l7Vw4VU/TjveCpME7sozCywHj9BLJfEKN4YiQ6c7Y95/scWz+8NFqEwzEE6uLXKngr5o4HmhT0jOzwjfijYxRTzMc6Lgrjn50XLIyPPaRPlArdjuLcaOMzWeGXu2kJcY76V6Y46MnVyWhCC2itn+icqUkNP9RsHddaG3dAXack0fm8mkJ+G02WgHCPhj21neGYPoJDh7gMWDh61h6Mml7ObKDbkymH0ceJnRNvQxAg4MFgdfiOymz2iQBTy8NLiM2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIqGsgax4lEW4rcOT2B729v3Cijj8obJBI1Ska8Vp4s=;
 b=QgGA3Bdtp4rS5bR0oB/FG1FAIi1agtYrRl/gT7XFVUAdbGVNKiDVHmUxAmS8iNXHxMPgTKGUHnFQ3ATQA/T6aCLxFWTggtsGBHm19z+rbWpEQYQzsEGDdlbh9ps7lYTQFqQJWeH06dzkOcMLC+SK3eGEsIzF0f5OP6zSz4Y44/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by CYYPR12MB8963.namprd12.prod.outlook.com (2603:10b6:930:c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 16:43:49 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 16:43:48 +0000
Message-ID: <20351ea0-4bb7-4b5e-b097-42ef145dea68@amd.com>
Date: Tue, 30 Sep 2025 11:43:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 23/25] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
To: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-24-terry.bowman@amd.com>
 <d3d3ab84-8cdd-4386-82dd-de8149159985@intel.com>
 <a2b5d6f0-7f6a-4ac3-b302-73fb3c1a92b2@amd.com>
 <5706b8ca-6046-4f96-a93b-8dd677494352@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <5706b8ca-6046-4f96-a93b-8dd677494352@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR16CA0045.namprd16.prod.outlook.com
 (2603:10b6:805:ca::22) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|CYYPR12MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d4d374b-88b5-4ae3-8d17-08de004087ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emFEYUJaaXJPN1dTK1dLRnhydWJlRk5EL3FoaTNkREx3cnR0MjRTbXRkSzNL?=
 =?utf-8?B?Vyt1WGsyYVRHTk41MlRJelFHeDlJT2xjZUdKNlluOHJGQndIUHd5Y2FBQjFX?=
 =?utf-8?B?c1R6RXcrNGpkei9OQ2FweEVnWHRod1djaWxhc2dGY1FPRWpwMTB0d3hyY0c0?=
 =?utf-8?B?K29pNWh1MXc0TWZhM25zUC9xS25WUkt2NGhuZmVCbGlEbFpmZDArb2Q2UjFV?=
 =?utf-8?B?UmNJWHBNQlZ1UlVjbk5waHIyYUw3MC8zbmpCamtidGFQaS9IeGxrYU1SaG9I?=
 =?utf-8?B?dVFtRlh3VG91Sm1nMzNid1lDTkphQXpQTXFnWVZybFBmNjRtOGVNTXFKcTdO?=
 =?utf-8?B?NVRPODZZdFBhemZlM3J2Q201MG1uNU9wS2VWS1pBOVIyaWh2Q1V5enpLTjg2?=
 =?utf-8?B?OU9OYzRiaFR0N0FKSGl3VkZFVEtJbDMwOEpNRUl6TDdsVytlVUc4U0dIbys2?=
 =?utf-8?B?OWFuWncrU21Ec2JKU24rbEUyZUs0TzdFSEh3ZjVIS2VFWEEydzBCNlo4UlRh?=
 =?utf-8?B?THB5RmFxZWhYNllubTkzNmxPejlmMTlrUU5QSjNVWlc1YkswYjJKZG0wdnc3?=
 =?utf-8?B?WE5uZjUzK1dldC83N01Vc3hYSk8xTU80QXVxV3NlYzdjUThsVHBTZmxTVFlq?=
 =?utf-8?B?TGl1WGdjdUVkVTJUMmVhbW13U0VCWHIxWnNUTlpGWW9MM09ZVVZDMXRZVzMy?=
 =?utf-8?B?bHFNZnRQa0JDbC9JOXRhb3FQd1ZYOTN1d3d5NVRJSHMzK3UyNTA2em13cWVC?=
 =?utf-8?B?cWZUcXR5S1RCVEFvbmxJYSt2TlpvN0ZZd3Q0RWpGN1BJd1BUeXVMcHI3YytT?=
 =?utf-8?B?TjEwWDEyemlhR1dSRUw1VU43SEIzRXZla2JHUklLK0FCVXpOUFZQUVJBQ1JE?=
 =?utf-8?B?enp3ZUJzYWNDRHp5MTlBVGhCcjgyTVdoM2JsSU94TUI2dFU3YUlRYTNqTEhz?=
 =?utf-8?B?dXdvdENKeWFFam5peHlNWjU5MjRyODE0SC8rVmxxWW1pOFY0Z2cvMkRsa3hH?=
 =?utf-8?B?a2VyK1FxemNOOGNlOFhCS3NFRXJZbWNuVDlhRVBtaFhoTHYvZTFrUzdwaVRE?=
 =?utf-8?B?YzNoTlJqOEVFQmd5QWk3aDVRNGZ6NlE4bUNIUXQ1cFU4NTVpVFh0R0IzRzF3?=
 =?utf-8?B?T1BTWTVjc3ExdHRsVDdqYlJtSXBpNXZiclJ6M1Rja1J3cGlERjBoZVZ6Tk5M?=
 =?utf-8?B?VW5iSUcybE5aZnROR01nSFV2RkJ2RTd2VTI4RjZaTVVLYWcxQzJNOUc2OUgw?=
 =?utf-8?B?T3NwbzRGUmw1SkpZTDJPMkM5Um9hell5bUlQenQxbGROWUF2dlNja0pvUnV1?=
 =?utf-8?B?L3Mzc252SUZwdGViQmx4NVBYalJacnBjck5BWHlMbXlrdkZReUhNc2dUUERM?=
 =?utf-8?B?cDhkOWJEbjR5R3pxTHdYOGdpeHJzdDA2aDBaeklxQWFaWWFBUWpQKzNERnVD?=
 =?utf-8?B?ZlFxYWtUTXpuN283OGtBTmVEa002cExTTk5ZWlBuYWpkZE5OY0NySzRmMURC?=
 =?utf-8?B?dHVrYTA5OVphRXNpcVc0TVdwYktiN3JPclF6Y1U1OUtQejBOdk5iZjBWUk1G?=
 =?utf-8?B?WFhva1QrZm80eEU2YUMyWjN1RjkvOHA4RFkyRFhyWDZDejNQbnk5R2Q4Nm1B?=
 =?utf-8?B?Q3pWMXV0SWI3Vys5NFNoek9objR1MWp0YWt0bmdUWGt5TnN5SUNKS1ZvU1Zo?=
 =?utf-8?B?ZGYwWWJ6YkxteE9JZmpKU24xSVgxZjNISmpoNkFBdDVXSmNWb25yZVZXUU5N?=
 =?utf-8?B?UDhscS9va0NaVVJ2ODdjTVBCdUd0OUlUMnVIZzNBTmM5TS8rWEZoT2lBdjZw?=
 =?utf-8?B?eVdjY1RWUk5JTjVuMHFVS1pFbXBhcTVwaDRxbTd2L2o0L1lyNGJieE9vZVc4?=
 =?utf-8?B?cXhNbFl5eHRBdS9pQWkwRW15NzBncUs0N3pJQk9KMkRkU3RrV2QrWWxJTXhL?=
 =?utf-8?B?ckJEbEp0UFllVU9COE5IVmJIdDE0N3E1UGtLQ2VBdlBvSGRnclNDeEgxY1B5?=
 =?utf-8?Q?PBbNAnBm4oxMVUIfcYs4PtS4djMfRY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzAvaDQ5dHdaMVdHOTBlS1FIbjByenNoZjBjVmZKUkt6K3Y4U3FoVmlyMzZK?=
 =?utf-8?B?L2QvMnYyb1NGUmlSeFdEN29yeHlRRFV6UFRsMTBiUThYdGFkWUlWR29BSVZH?=
 =?utf-8?B?NkFOd1pJdlJ4aFhaUE80Q1Uya0JJUE0va3RDUzJ0enc2eWg5a3pvL3BUWlM5?=
 =?utf-8?B?alRNdHh1SGZOall6VlkzUFRYVWtXNmNoSjZlRGJZWG51bVhWWFhRRGkzUnFv?=
 =?utf-8?B?NVdwRm56T3o0Wmh5REsvWTRLWmZyQmQ4YnA3RlI3MTJyVUZON1EwTlRxeGM0?=
 =?utf-8?B?eW1VS0xMS0ZwZkFPYkNLM0R3VkIvOG8zY2VKYzJmTjBGeDVrL2Z2RE04VTBL?=
 =?utf-8?B?NW14bndrdUVVZjlyeVdnTHFyK1RDTUpFODVtN0MzMHZ3c1RQS2pXYWhnMThN?=
 =?utf-8?B?YjhudHhwdjhaMXBWRW56d2JPM0x4VWpzT3JOTW50YTBnS3pFb2VjbVQrbzNR?=
 =?utf-8?B?bnpRZTlXZDFyN3VHV2JMeTFRZmMyZmdmOU5WL0xsWUFKNjhwUmFXckg2UnRz?=
 =?utf-8?B?WDNUQXNYS3c1QnZKL3NyVHQ0MVRmN0xyNUxnWUlLbUxnS0drTGRyUDhLY3ZJ?=
 =?utf-8?B?K2U0QjFlYWtuUExEUlBMRStRc0ppRVkrLyt6c0NCWDhBcVNrc2pvMmRDMlVB?=
 =?utf-8?B?WWJrNXcxaEJCcXAwQURhMmhoNmRTeGUxSHJFZ0NuYUhuck9aTXRuemVFQzdL?=
 =?utf-8?B?R2RGS3lXZm1hYW13c1BabW1wRkgyV2JPeVpLOHc1V21lS2VKQXlSUGRnUm95?=
 =?utf-8?B?eXNyWFlYbDVnakEzMmtCZk9FTVNqb2lRUHBycVlxbFl2RWpjVjFSZzNYVkJP?=
 =?utf-8?B?cUFLQzhGRGxYWVliSXRTMnNvOWY2SHNubmt2bzhOZjduTWVKcGxmbS9lbHh3?=
 =?utf-8?B?WTloUDhvQjY5NUhJaTU1T00ycWpOclhoWWJ4VnkrT3lCQmNGMzY5aUZnWXZ5?=
 =?utf-8?B?TmhXekRyWDcvTjNodDQ3VXJNQXZKSi91b1YvVkcrZ2s5K1J6QWtJRGlhRzQ0?=
 =?utf-8?B?K2Y4N1JWa2pyem94aE9lS28wbUpQb1FCZ2wyajB3Q283OFN4akZia3Q5Zm81?=
 =?utf-8?B?ZTd1Qm41YUZiR1l6QVpTb3JETFN3bFpzV0lVdG5EdnN1eldnbGtqMjlVNHhJ?=
 =?utf-8?B?djRXdDc0ZXFjTVBBRmovdXVzNmQ2bU5PTGUrYVlSRjlRbEJhaG1kMGdINTBr?=
 =?utf-8?B?aHUxT3B5cnQ3YXVvM1BDOXJiMEhSazdIWFdlS3dnVjlPNWVIcE8xb0k2NmVJ?=
 =?utf-8?B?UExQM2hBWXg0a1ZabkN3YzA2ZHpnV0RINittNDVaMjdlWkdVWFBSbklGYTAx?=
 =?utf-8?B?K28rbmFYR3JMQkxnN2lWS3pMR2FuSlYyQTRhNm82cmFjYzRDZlVVeVVIY05y?=
 =?utf-8?B?ZytrS0czS0Mzbkt1ekFMc2pTdW1OVkxOLys1em5NUUtWV2l3b0tsaGVhWFU0?=
 =?utf-8?B?V2Q2allPMldGSUxWYnlWN3B6eUZrZjBnOFBzSnpDNzNlYmxDQVJJQkI4ejd2?=
 =?utf-8?B?M3ZPN0Q1Y0VmYzgrTU5uU3FrZ1p4ZjYwc01iL0FKa3FnZmZ0aFVJalBNRWlO?=
 =?utf-8?B?eld4SmtaeXpTVU4zRVhOclR1eHp3VnJiYUJrZVFld1dVaStPYjBGMHMxUTVT?=
 =?utf-8?B?Ri8zTmxVTS9jek1VVkdWZFp5dDJ5Qk9kaFJ5aHlXajl6Wmt2TjZVd1VaYjdC?=
 =?utf-8?B?dmwwZmdOVVpNV1BwWUhzYWRlZVVCMDR0UXpjbTFaYkZYbFQvMlp1c2Nnd3I2?=
 =?utf-8?B?SU4zeldwelZhekgwcVZhTmNxQVBseFhOaWFidVNNcWY1MG9WTk43OEtBZ3JJ?=
 =?utf-8?B?UVdPRVZ4a3hCV0l6Nmx5K29HdkNhQzh1VlZ1WGJvTUdqRUFCRWk0b0pGazNq?=
 =?utf-8?B?aHF5d1lNck1mbTFDZ3BHeUFEdm9VVVdwNHNFbk1pZ1VZMGkrT21sSnBLeEJF?=
 =?utf-8?B?Z2dPZk1VbnRiNlRCajVCdmZteklHWk04L1p0b0lOVlovRmZVeHQwVFRoTlAv?=
 =?utf-8?B?TjVWQ0ppZ1VheXJna0k3TytId1BnTkZmRU1FOXUvdVRNVzBkNFNXcWRWdXNS?=
 =?utf-8?B?amF2bjFtTUZRMUM3T0VXK3J5REJVYlhoWE42a3RlTktHKzRVZVdnZmlKTXZv?=
 =?utf-8?Q?x8C08wKzeqNzxkHlkuDV5Rq1M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4d374b-88b5-4ae3-8d17-08de004087ac
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 16:43:48.8760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d02mb69RZ/LcqR8LIAyTCf57fWiNMwd5bUB/Vzz7mI/L4c/jfcLrTt4sZUVlInuIX+/ZivfqS9Nbvpm4G0urgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8963



On 9/30/2025 11:13 AM, Dave Jiang wrote:
>
> On 9/30/25 7:38 AM, Bowman, Terry wrote:
>>
>> On 9/29/2025 7:26 PM, Dave Jiang wrote:
>>> On 9/25/25 3:34 PM, Terry Bowman wrote:
>>>> Populate the cxl_do_recovery() function with uncorrectable protocol error (UCE)
>>>> handling. Follow similar design as found in PCIe error driver,
>>>> pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs
>>>> as fatal with a kernel panic. This is to prevent corruption on CXL memory.
>>>>
>>>> Introduce cxl_walk_port(). Make this analogous to pci_walk_bridge() but walking
>>>> CXL ports instead. This will iterate through the CXL topology from the
>>>> erroring device through the downstream CXL Ports and Endpoints.
>>>>
>>>> Export pci_aer_clear_fatal_status() for CXL to use if a UCE is not found.
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>>
>>>> ---
>>>>
>>>> Changes in v11->v12:
>>>> - Cleaned up port discovery in cxl_do_recovery() (Dave)
>>>> - Added PCI_EXP_TYPE_RC_END to type check in cxl_report_error_detected()
>>>>
>>>> Changes in v10->v11:
>>>> - pci_ers_merge_results() - Move to earlier patch
>>>> ---
>>>>  drivers/cxl/core/ras.c | 111 +++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 111 insertions(+)
>>>>
>>>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>>>> index 7e8d63c32d72..45f92defca64 100644
>>>> --- a/drivers/cxl/core/ras.c
>>>> +++ b/drivers/cxl/core/ras.c
>>>> @@ -443,8 +443,119 @@ void cxl_endpoint_port_init_ras(struct cxl_port *ep)
>>>>  }
>>>>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
>>>>  
>>>> +static int cxl_report_error_detected(struct device *dev, void *data)
>>>> +{
>>>> +	struct pci_dev *pdev = to_pci_dev(dev);
>>>> +	pci_ers_result_t vote, *result = data;
>>>> +
>>>> +	guard(device)(dev);
>>>> +
>>>> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
>>>> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)) {
>>>> +		if (!cxl_pci_drv_bound(pdev))
>>>> +			return 0;
>>>> +
>>>> +		vote = cxl_error_detected(dev);
>>>> +	} else {
>>>> +		vote = cxl_port_error_detected(dev);
>>>> +	}
>>>> +
>>>> +	*result = pci_ers_merge_result(*result, vote);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int match_port_by_parent_dport(struct device *dev, const void *dport_dev)
>>>> +{
>>>> +	struct cxl_port *port;
>>>> +
>>>> +	if (!is_cxl_port(dev))
>>>> +		return 0;
>>>> +
>>>> +	port = to_cxl_port(dev);
>>>> +
>>>> +	return port->parent_dport->dport_dev == dport_dev;
>>>> +}
>>>> +
>>>> +static void cxl_walk_port(struct device *port_dev,
>>>> +			  int (*cb)(struct device *, void *),
>>>> +			  void *userdata)
>>>> +{
>>>> +	struct cxl_dport *dport = NULL;
>>>> +	struct cxl_port *port;
>>>> +	unsigned long index;
>>>> +
>>>> +	if (!port_dev)
>>>> +		return;
>>>> +
>>>> +	port = to_cxl_port(port_dev);
>>>> +	if (port->uport_dev && dev_is_pci(port->uport_dev))
>>>> +		cb(port->uport_dev, userdata);
>>> Could use some comments on what is being walked. Also an explanation of what is happening here would be good.
>> Ok
>>> If this is an endpoint port, this would be the PCI endpoint device.
>>> If it's a switch port, then this is the upstream port.
>>> If it's a root port, this is skipped.
>>>
>>>> +
>>>> +	xa_for_each(&port->dports, index, dport)
>>>> +	{
>>>> +		struct device *child_port_dev __free(put_device) =
>>>> +			bus_find_device(&cxl_bus_type, &port->dev, dport->dport_dev,
>>>> +					match_port_by_parent_dport);
>>>> +
>>>> +		cb(dport->dport_dev, userdata);
>>> This is going through all the downstream ports
>>>> +
>>>> +		cxl_walk_port(child_port_dev, cxl_report_error_detected, userdata);
>>>> +	}
>>>> +
>>>> +	if (is_cxl_endpoint(port))
>>>> +		cb(port->uport_dev->parent, userdata);
>>> And this is the downstream parent port of the endpoint device
>>>
>>> Why not move this before the xa_for_each() and return early? endpoint ports don't have dports, no need to even try to run that block above.
>> Sure, I'll change that.
>>> So in the current implementation,
>>> 1. Endpoint. It checks the device, and then it checks the downstream parent port for errors. Is checking the parent dport necessary?
>>> 2. Switch. It checks the upstream port, then it checks all the downstream ports for errors.
>>> 3. Root port. It checks all the downstream ports for errors.
>>> Is this the correct understanding of what this function does?
>> Yes. The ordering is different as you pointed out. I can move the endpoint 
>> check earlier with an early return. 
> As the endpoint, what is the reason the check the parent dport? Pardon my ignorance.

There is none. An endpoint port will not have downstream ports.  

>>>> +}
>>>> +
>>>>  static void cxl_do_recovery(struct device *dev)
>>>>  {
>>>> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>>>> +	struct pci_dev *pdev = to_pci_dev(dev);
>>>> +	struct cxl_port *port = NULL;
>>>> +
>>>> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>>>> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
>>>> +		struct cxl_dport *dport;
>>>> +		struct cxl_port *rp_port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
>>>> +
>>>> +		port = rp_port;
>>>> +
>>>> +	} else	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
>>>> +		struct cxl_port *us_port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
>>>> +
>>>> +		port = us_port;
>>>> +
>>>> +	} else	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
>>>> +		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)) {
>>>> +		struct cxl_dev_state *cxlds;
>>>> +
>>>> +		if (!cxl_pci_drv_bound(pdev))
>>>> +			return;
>>> Need to have the pci dev lock before checking driver bound.
>>> DJ
>> Ok, I'll try to add that into cxl_pci_drv_bound(). Terry
> Do you need the lock beyond just checking the driver data? Maybe do it outside cxl_pci_drv_bound(). I would have an assert in the function though to ensure lock is held when calling this function.

Ok, good idea.

Terry
> DJ
>>>> +
>>>> +		cxlds = pci_get_drvdata(pdev);
>>>> +		port = cxlds->cxlmd->endpoint;
>>>> +	}
>>>> +
>>>> +	if (!port) {
>>>> +		dev_err(dev, "Failed to find the CXL device\n");
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	cxl_walk_port(&port->dev, cxl_report_error_detected, &status);
>>>> +	if (status == PCI_ERS_RESULT_PANIC)
>>>> +		panic("CXL cachemem error.");
>>>> +
>>>> +	/*
>>>> +	 * If we have native control of AER, clear error status in the device
>>>> +	 * that detected the error.  If the platform retained control of AER,
>>>> +	 * it is responsible for clearing this status.  In that case, the
>>>> +	 * signaling device may not even be visible to the OS.
>>>> +	 */
>>>> +	if (cxl_error_is_native(pdev)) {
>>>> +		pcie_clear_device_status(pdev);
>>>> +		pci_aer_clear_nonfatal_status(pdev);
>>>> +		pci_aer_clear_fatal_status(pdev);
>>>> +	}
>>>>  }
>>>>  
>>>>  static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>


