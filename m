Return-Path: <linux-pci+bounces-40296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31606C3315A
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 22:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A59A465EA1
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 21:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733262FBE0D;
	Tue,  4 Nov 2025 21:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mo//9e2h"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2F32FB093;
	Tue,  4 Nov 2025 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762291673; cv=fail; b=GzmCa1XWvj0XtOBsTfDOX1kibFhlwOVKEipgnGtI3lY2iKY3iXSUH/S+IHON5FFTcBm6zazMWXlHjNBBgEdymXn7Quv0wreNC0vGA+aI+m14lDWcZRKKPD+TRGxeVo+Tv3Xp8ouzUqNvpDZY1FKxDm/wzN2SnrUzwXUUN3aLHCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762291673; c=relaxed/simple;
	bh=217GpUNo4r9yccTUfyw7lQqq7D/2MtCd303kzIvnzm0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qw+s4RflGKmxAkQGZtnPRyPC0eWjXXJp+XuCQIXpPvjS8l296jxRUYpNxpAYonq+0nIzQs9trA1g0AHb7+uUyaVl7vxkcYdQ+T/by77PlQY39Mw8CcFwBfeBbBttcxBvi3wqWxBchGNJcNapsKvQOEnsOD2GAsGqtBt+XyUMGDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mo//9e2h; arc=fail smtp.client-ip=40.107.208.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhqNtgfzq3okITENNlxpKYBa0pfSLchIF8WhKmH3mk3ZogEeEnh19WFDbhjhzgcPuMF8XCpXKvPKOLDrjvm9Ac40rgV9PVusIRmFSOi1FLeclbdHaKPkeH7AeahHDXzeQUZynyyh5wzHa8nHi2JQ9Bp7aTgxzwwHTjG9mVjrcN+rdyUtmqR6Own9ARC1SpZu1psXyn8bmaBibP7siKEuWyb3eQFsmNk3eHh7QHDHZOoQ2oWN+P0f9GkAU5XM2uWcFldYSPDff06ddXj9OEb6UvWrqFcQqm7KuLtl6tYEu9VwgwkH65xfqHE/WxXhTEBNMecAtd5KoF6LABD86zJMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fL4sG5zZDjH8tykyIq6HUy2FaJrnTWlg1phm8CRkSQ=;
 b=IC/CasbP2N5ip08K2T6ABWwcYsug+jglLGljVup+5lyr6uacsHxQL1iCR7W3XETZn+mks4SeNqJoT4CtEY0+GzgbfKaq4jEyUspbQfOGg6xLipy4SSkmmZG/cPKOSA22B4vBKLfC1v5IuxCloO4OYcQlbdOhO/VdpP5pW5W5oNczCglEzRt0YUlfYrNYLKCj5D5XwKFxRt4IZnMbJHE0fu0FIEqD3aZw33vH6Aer5xf/84vtYe+HF4KFVLgBEKeweqfZwtb9Uv7GdZNiKo2sXdx7xGkTBlCFnPgPh9QA0QrdEOEJfPpTQJkicJ9V7bI5Caz6w2/Ua23xAcyFmxQrsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fL4sG5zZDjH8tykyIq6HUy2FaJrnTWlg1phm8CRkSQ=;
 b=mo//9e2hjOz8+iXxP3WtgDDfiBrJ/DC68zaFYhh5EMUOCe5apu6/ixSCGC8Bkr8A7nRQFvw49tQnDSGIxOqzdIkIHw0AqXQU/mZfjZATNNJLYzM+6EqFE4/nR02VILVKadfNyMuJQ8OcT1KNq02NpQMLHmYmCRjcrhA/bDzIIyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 21:27:48 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 21:27:48 +0000
Message-ID: <f09df618-987e-4051-b5a2-fd9d2cef18e2@amd.com>
Date: Tue, 4 Nov 2025 15:27:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v13 20/25] CXL/PCI: Introduce CXL Port protocol error
 handlers
To: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-21-terry.bowman@amd.com>
 <5ed52253-a74d-4643-bdb6-a8d4852a9be7@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <5ed52253-a74d-4643-bdb6-a8d4852a9be7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR08CA0054.namprd08.prod.outlook.com
 (2603:10b6:4:60::43) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|SJ2PR12MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: 338fc6e0-c70d-4255-979d-08de1be900a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c05DamY4R0J5b0tydnB6cldGU0l0N0EraGl5RjJ5MGk3NEtXZUgzOGZPUXh2?=
 =?utf-8?B?c0l3ckdRMFhXN21ndWJ1cEFIUHUvcFNYbS94YnQ3RHZCWVJZWmE3TGJwcFZs?=
 =?utf-8?B?UnY5OS9xdnhOQWF6RkpDRmMvTmtlbXlYTlFwYnQ3WXJiTmZ4WDNFbllGNGg2?=
 =?utf-8?B?OFlMODJZNVpyRktDWENCalN5MUhjZXNzYkZob2s2dFVtR2t3bWxhZGl5UmdG?=
 =?utf-8?B?b1lWek9IQkNHOFJ5ZjAwZkR1RWFNNXJURjl5ZnRVcUJxZ0M0T1J3TnBIZ25T?=
 =?utf-8?B?dWpDaE1mYUo5V3QxRTRiQ1dpYmd6Z0ZqcVppQ1NGNDJBMUdOeUJDZWdGbWIv?=
 =?utf-8?B?NXJ0eW52ejd0SjU2YVhXd0h6dm00UzRyZDYxZUdJOFJ2d2s4dzBTeVduWEgr?=
 =?utf-8?B?MmFWSzJyT3hGS3BSR0xqTHVNY1ZPdk50aHdOc2Jrd1NUcGczR1pkeExjYU11?=
 =?utf-8?B?b3FkaUQrS0dwOW1wVis4YzFQTTJVZVRaTEJRMmZEQmx5RlM4OHVCMmhtZTdp?=
 =?utf-8?B?VTB3eHE5eUVZMnArU2pGK0xWSy8zNnZ1K3VNRm15b2srSjAzWFFmUXFNZUlY?=
 =?utf-8?B?L3ZwVTB2bWRiWldVOVltSUFIcEwzdWdicmwvRzJSbzRGeFFaS3dSb2czZ3NP?=
 =?utf-8?B?SFZJUVRuN1ZXV0ZZV1lLcURBcDlpS3BTRkRmNG4vNFlqWm5xam9mQUJmQmpq?=
 =?utf-8?B?N1RHb0I2c0ZTank2aGNHUWZuTmgrdXVLRjJzWUV2eTlaTzFUbVZaenFKZkVC?=
 =?utf-8?B?a2N5NG1GOG8vcFA5Zy9mVncyN1RpMkpEcWl2Z0pURy82UkN0NmdubmcwTDRt?=
 =?utf-8?B?d2xiaWhnT0Fjd3VPbzJxN1E5eUFtWHlCL0ZYV0R4OStoSnNHbCtQS0V6Z3pa?=
 =?utf-8?B?V3BOOGpjTkhyRkdROS9aWExFTGw2UjYxU05aRkhvdnV4WXEzZVRLS0lSd3BF?=
 =?utf-8?B?QnE4LzVZdDgzdVZ6WjJGdG0rNXFRaXFxODVGZVVSSDB4WmUrVTNIeHBrcVBz?=
 =?utf-8?B?V3gwaSttcTR6dHprSjRVUkxaeGRobGRFNlBUQUNEVXUyUGl4cHk2R0J3eVVX?=
 =?utf-8?B?MzI3bkMxYlI5NFBpTzVuQ3QzcndCZDFQSWtOQXVuK2tOS3QzNVhwbkZxYnhh?=
 =?utf-8?B?U05BajJSeGpobGV3c2s0czJuNGlZWHpwNTNWWjkvMTNhNXNJUXlIMGI4NGhu?=
 =?utf-8?B?UFM3WWFKVTZMYUhmdENGbVZ1S3hQbzY4MmdYVWFEUUpXUFltQUx4dGo1SnlZ?=
 =?utf-8?B?ZGhjaUtkOWx1aE9YUnhlNHUydGpTVFJDTC9KY25seE5KZkROMWtESHdKV1Ns?=
 =?utf-8?B?cnNLVjVDSUVhRnpFRUU3RXNoYVp1TUpTYVN5ZXA0NjEvcXhRbkNmYnVJVUJo?=
 =?utf-8?B?TVpCSnI1K2JqV2NoRFRpaFF2bjNyQkVXNzd5M00zY21MdDJPcDROeEN2bWdH?=
 =?utf-8?B?TVdVU3pLMmFyT0xzd1MyOUxGVmtNUXlKNDJCbURIUUxmZWRFcWZKMTBsM3hl?=
 =?utf-8?B?d21iTGRLeHExNDZHMDB0NWUzcFUySDJKa3FTbllqTVhPWG9telN5amhLOEdT?=
 =?utf-8?B?R2tUZlVZRm13YWp2V2JCK1Bta09DMVRwd25GWUdzblFQUnJqSW9CS2pGZUNq?=
 =?utf-8?B?dmtJai9lUitQdHlrV0ZMUGpQQlpGbzdnempSdUowUW9xdGFaNHpHKzRxbHJq?=
 =?utf-8?B?cGpNUGZMdWIzNXZkSjg3a0h3aTBDcVNlenk1Yy85ZHRqSmNvcEJQWlNDZ3Zs?=
 =?utf-8?B?M0g5RGRDa3FYM2g2TENKalBqWjZkRlh4NFAwSTBPblVZZWhxRnZDWkpWN0dz?=
 =?utf-8?B?TW9UWjJlcW9rc3ZDME93Nklud0J2aHFnamcyT3JJTmJhRWR4SkE0NXY3dWRZ?=
 =?utf-8?B?aERpelc3YzVrbjlqUEQ2QldLZlBkS1NOWHpESVgzV2pQSlUyRmlzL0ZRWTJo?=
 =?utf-8?B?cnNhT0xKZEpXV3dKblYxUkxSTFE1MHVTN1k2NTB4ZnM3Zjk2c29zRS83N0Nm?=
 =?utf-8?Q?/XoQAmvXTeWI7UXXqPdjnTkIg/z0Gg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVdZTmg3cDZxc0hla08wbjk4UkwraDhuc3FEMHRSQ1B6U0dRZm91eU83OHRw?=
 =?utf-8?B?RGtwU3U0UlFwUEhXOHVqSXJUclBGVXpDY2RGNnU1S3pCdVVYMGphaitPcm1P?=
 =?utf-8?B?SXp0UTIxYnBsMmlMbVh5TlVCWjA1M3IybWx3dWU2cjV3eVFLazBoKzJUNitH?=
 =?utf-8?B?V1hQUHF4Q3g4RFJhVHhWaEMxcUloeW10d1Z5aHZGMVN4aXpHSVl3SU83ZDNa?=
 =?utf-8?B?dDVpQnVVelNtYjRtcW5hMmJLQm9tcjFBcC9kUE90VHlGT29RdzlXTlNMTkFI?=
 =?utf-8?B?NW1RYUE2c3BvcHBxNFRXbUwxOHVMOEp5aWhHdFJDOUJmeFllKzlLVWorRnpU?=
 =?utf-8?B?czNxYkZoeGoxNlYwdHZ1dEZuQ2JVZWszSVQ3aXVnZlNaYWZqZmQ2ZStraGhj?=
 =?utf-8?B?TFliQ281QzdETktjMWh2Nm03VUphOGdnMmNpcTNoVmh3TElDWVdIYUU0SU5O?=
 =?utf-8?B?SU9lZlN2UG1iejZEVHdZRzJjaFpZWnJtL1Yxb1VoQnNUR3hGV3Q0K2I1VERn?=
 =?utf-8?B?eG9SVGxFc3kxa1A5cHMxZ2I3VzZqdGpiOUxvTEJDS1BoaDhJZ2lsYUpwMG10?=
 =?utf-8?B?UUpjc1NPaGRvK3RpRXczVk1YczJmRGxZZG96Y01GeE9rT3MxRURqWFQzTDlt?=
 =?utf-8?B?L003YzJEb0dZRjUvRE1KNWw3b0hteVZRZVpkTEZjMGp6L2xFcG5ETWJCOFNa?=
 =?utf-8?B?dGd3YmFEOWxkVnJjclliay9LK3BVY3dEM2xCVFNZaEdwTHdqNUdpR2xrWldC?=
 =?utf-8?B?OS9lcU5VNUpJcndWTUI0ZTVGQWowTVZjT3pLYXZUbVB2SlgxbkpxbjNVOUlz?=
 =?utf-8?B?dWhKZjFGelFKaUJEcHAxSVZZQ29vcXExeXczVzFmcWRpdDM4dzRzYVhweXZa?=
 =?utf-8?B?SlU1T1QrRzdzY3Z3aitzMkVJcGtVaDNYZll2bGdBUzYyVlViaTJnc0pUdm4r?=
 =?utf-8?B?N21tQmNRRHFxbnFEaW9CNytvUHgwcGEvVHdVMEYxbkpFRGtXVmlsWmdsUC8w?=
 =?utf-8?B?d2tVUmlwdVF3MWg5R2QwZEpMY0swUCtuWG1GU2NOaFE1WUZ3RHFWREVkYlJU?=
 =?utf-8?B?a2Q5RFpBV1dFSDM3cWJrZjhrUzg2aGdNcm8rQUFpallnTytLM3NQa1hEcDMy?=
 =?utf-8?B?dWo3dUI3NW5sOFR3L29HKy9ySjR4OVI5QVdyTHVMRDNmajJPd2pNaXBvZ3NR?=
 =?utf-8?B?Tlh6ZkZQdjhFaEFwcytGamF5aDEwNFVvTjJROEs3YURTRmZ6a1VmM1I3cC9F?=
 =?utf-8?B?bUxNanRPZHBHK1pLcWdWaEY0ZlRROG9KRGQ5aTV2dENGR2xOVUFGcTNWUGRq?=
 =?utf-8?B?OTJNdUFuQ1l4T3dBT0lPaDNwZlJycWtsd2dWOTlUUjNXYzlIeUJ5aDlnanpx?=
 =?utf-8?B?RVp2Sk5oR1hWUlNKQjA3ZFZTRzV3WkMvdCtxZDVaL0RLaHZ0V3d1ZjU5TGdD?=
 =?utf-8?B?cHlXb0djWVVTam1TYWFBTnJKTGEzcEVKc2hGejRtZ3h1aU9rMzFDYW95REpr?=
 =?utf-8?B?U2xGT3JhOXN2c2RkWWV1WllDQjg1SlFTNFN6alh4b2hOSzhNK1ZhWXRYZ3J1?=
 =?utf-8?B?VG1IWUNRV2I4cWNlcmwzZTNSSzJ2VUo2amo0TFZRZXRiUFk5dmRsQ09WMmp1?=
 =?utf-8?B?R0R6WUpEQ1E0cnR2VUFmdmNLN1ZLSWwzN3owOTZyRlJGMzVjZXMyNTlLS25W?=
 =?utf-8?B?T1doZDBxWTh6T01GcHNLaUorczhIQW1nZFE5RCt4cXIvUFpzM3ZYRFBIZlJi?=
 =?utf-8?B?UGt2Q2w1YmRxS0tOclFKUGRxUk5lRDhjZkdZeVNUZm5YRmEvNWpiMU14NU5x?=
 =?utf-8?B?RHJMWlFxbHVHaVlzOFBZYlNvdDEvaDVHMnRSd2V1ZUgyV0VvNUpkUE84ekw2?=
 =?utf-8?B?K0FLOGd3a0FWR29INUVIRFI2VEFMWDVZTzk0aUh5VHFtS2o1R2F4T1lrOHlB?=
 =?utf-8?B?aFlYNkQyUFlHR1VEMlh6SnBvTXVqWXJKNk13OFBLeXdoeG9aZkk2RXl3Vm54?=
 =?utf-8?B?SS9GU1BoQXFTeXRZbmJlZ1BoYlkycGViL1llS2xrSDdVVlJGdmhGblBCY1Ju?=
 =?utf-8?B?dkdWV0l1ei96WCtwaTJPTStzbDJ6SXl2MlFSZU43aXdFSWsxSHk4V20zWjdq?=
 =?utf-8?Q?jnbid6VXOCQwPf6mTAhaosEvx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338fc6e0-c70d-4255-979d-08de1be900a5
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 21:27:48.6869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dK6VzdXLinQowG1heIdjSMR/qzb7jECnzF/Q4oaR1XLyUuACI9F/V6EBcdWfJJOUYCqE4RTMBFH15u0y3O3xog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212



On 11/4/2025 3:20 PM, Dave Jiang wrote:
>
> On 11/4/25 10:03 AM, Terry Bowman wrote:
>> Add CXL protocol error handlers for CXL Port devices (Root Ports,
>> Downstream Ports, and Upstream Ports). Implement cxl_port_cor_error_detected()
>> and cxl_port_error_detected() to handle correctable and uncorrectable errors
>> respectively.
>>
>> Introduce cxl_get_ras_base() to retrieve the cached RAS register base
>> address for a given CXL port. This function supports CXL Root Ports,
>> Downstream Ports, and Upstream Ports by returning their previously mapped
>> RAS register addresses.
>>
>> Add device lock assertions to protect against concurrent device or RAS
>> register removal during error handling. The port error handlers require
>> two device locks:
>>
>> 1. The port's CXL parent device - RAS registers are mapped using devm_*
>>    functions with the parent port as the host. Locking the parent prevents
>>    the RAS registers from being unmapped during error handling.
>>
>> 2. The PCI device (pdev->dev) - Locking prevents concurrent modifications
>>    to the PCI device structure during error handling.
>>
>> The lock assertions added here will be satisfied by device locks introduced
>> in a subsequent patch.
>>
>> Introduce get_pci_cxl_host_dev() to return the device responsible for
>> managing the RAS register mapping. This function increments the reference
>> count on the host device to prevent premature resource release during error
>> handling. The caller is responsible for decrementing the reference count.
>> For CXL endpoints, which manage resources without a separate host device,
>> this function returns NULL.
>>
>> Update the AER driver's is_cxl_error() to recognize CXL Port devices in
>> addition to CXL Endpoints, as both now have CXL-specific error handlers.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> ---
>>
>> Changes in v12->v13:
>> - Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
>>   patch (Terry)
>> - Remove EP case in cxl_get_ras_base(), not used. (Terry)
>> - Remove check for dport->dport_dev (Dave)
>> - Remove whitespace (Terry)
>>
>> Changes in v11->v12:
>> - Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
>>   pci_to_cxl_dev()
>> - Change cxl_error_detected() -> cxl_cor_error_detected()
>> - Remove NULL variable assignments
>> - Replace bus_find_device() with find_cxl_port_by_uport() for upstream
>>   port searches.
>>
>> Changes in v10->v11:
>> - None
>> ---
>>  drivers/cxl/core/core.h       | 10 +++++++
>>  drivers/cxl/core/port.c       |  7 ++---
>>  drivers/cxl/core/ras.c        | 49 +++++++++++++++++++++++++++++++++++
>>  drivers/pci/pcie/aer_cxl_vh.c |  5 +++-
>>  4 files changed, 67 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index b2c0ccd6803f..046ec65ed147 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -157,6 +157,8 @@ void cxl_cor_error_detected(struct device *dev);
>>  pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
>>  				    pci_channel_state_t error);
>>  void pci_cor_error_detected(struct pci_dev *pdev);
>> +pci_ers_result_t cxl_port_error_detected(struct device *dev);
>> +void cxl_port_cor_error_detected(struct device *dev);
>>  #else
>>  static inline int cxl_ras_init(void)
>>  {
>> @@ -176,6 +178,11 @@ static inline pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
>>  	return PCI_ERS_RESULT_NONE;
>>  }
>>  static inline void pci_cor_error_detected(struct pci_dev *pdev) { }
>> +static inline void cxl_port_cor_error_detected(struct device *dev) { }
>> +static inline pci_ers_result_t cxl_port_error_detected(struct device *dev)
>> +{
>> +	return PCI_ERS_RESULT_NONE;
>> +}
>>  #endif /* CONFIG_CXL_RAS */
>>  
>>  /* Restricted CXL Host specific RAS functions */
>> @@ -190,6 +197,9 @@ static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
>>  #endif /* CONFIG_CXL_RCH_RAS */
>>  
>>  int cxl_gpf_port_setup(struct cxl_dport *dport);
>> +struct cxl_port *find_cxl_port(struct device *dport_dev,
>> +			       struct cxl_dport **dport);
>> +struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev);
>>  
>>  struct cxl_hdm;
>>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index b70e1b505b5c..d060f864cf2e 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1360,8 +1360,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
>>  	return NULL;
>>  }
>>  
>> -static struct cxl_port *find_cxl_port(struct device *dport_dev,
>> -				      struct cxl_dport **dport)
>> +struct cxl_port *find_cxl_port(struct device *dport_dev,
>> +			       struct cxl_dport **dport)
>>  {
>>  	struct cxl_find_port_ctx ctx = {
>>  		.dport_dev = dport_dev,
>> @@ -1564,7 +1564,7 @@ static int match_port_by_uport(struct device *dev, const void *data)
>>   * Function takes a device reference on the port device. Caller should do a
>>   * put_device() when done.
>>   */
>> -static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>> +struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>>  {
>>  	struct device *dev;
>>  
>> @@ -1573,6 +1573,7 @@ static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>>  		return to_cxl_port(dev);
>>  	return NULL;
>>  }
>> +EXPORT_SYMBOL_NS_GPL(find_cxl_port_by_uport, "CXL");
>>  
>>  static int update_decoder_targets(struct device *dev, void *data)
>>  {
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index beb142054bda..142ca8794107 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -145,6 +145,39 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
>>  		dev_dbg(dev, "Failed to map RAS capability.\n");
>>  }
>>  
>> +static void __iomem *cxl_get_ras_base(struct device *dev)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +
>> +	switch (pci_pcie_type(pdev)) {
>> +	case PCI_EXP_TYPE_ROOT_PORT:
>> +	case PCI_EXP_TYPE_DOWNSTREAM:
>> +	{
>> +		struct cxl_dport *dport;
>> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
>> +
>> +		if (!dport) {
>> +			pci_err(pdev, "Failed to find the CXL device");
>> +			return NULL;
>> +		}
>> +		return dport->regs.ras;
> The RAS MMIO mapping is done via devm_cxl_iomap_block() and is a devres against the device. Without holding the device lock, the port driver can unbind and the address mapping may go away in the middle or before cxl_handle_cor_ras()/cxl_handle_ras() being called. I think you'll have to hold the port lock here and make sure that the port driver is bound before reading the RAS register? I think the dport ras should be covered under the port umbrella.
>
>> +	}
>> +	case PCI_EXP_TYPE_UPSTREAM:
>> +	{
>> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
>> +
>> +		if (!port) {
>> +			pci_err(pdev, "Failed to find the CXL device");
>> +			return NULL;
>> +		}
>> +		return port->uport_regs.ras;
> same here
>
> DJ> +	}


The cxl_port parent of the reported devices are locked previously. Locking is added in the CE case in the next patch.
and the UCE locking is in patch23. Locking logic is all made ASAP after after dequeueing.

Terry

>> +	}
>> +
>> +	dev_warn_once(dev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
>> +	return NULL;
>> +}
>> +
>>  /**
>>   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>>   * @dport: the cxl_dport that needs to be initialized
>> @@ -254,6 +287,22 @@ pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ra
>>  	return PCI_ERS_RESULT_PANIC;
>>  }
>>  
>> +void cxl_port_cor_error_detected(struct device *dev)
>> +{
>> +	void __iomem *ras_base = cxl_get_ras_base(dev);
>> +
>> +	cxl_handle_cor_ras(dev, 0, ras_base);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_port_cor_error_detected, "CXL");
>> +
>> +pci_ers_result_t cxl_port_error_detected(struct device *dev)
>> +{
>> +	void __iomem *ras_base = cxl_get_ras_base(dev);
>> +
>> +	return cxl_handle_ras(dev, 0, ras_base);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_port_error_detected, "CXL");
>> +
>>  void cxl_cor_error_detected(struct device *dev)
>>  {
>>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
>> index 5dbc81341dc4..25f9512b57f7 100644
>> --- a/drivers/pci/pcie/aer_cxl_vh.c
>> +++ b/drivers/pci/pcie/aer_cxl_vh.c
>> @@ -43,7 +43,10 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
>>  	if (!info || !info->is_cxl)
>>  		return false;
>>  
>> -	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
>> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
>> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
>> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM) &&
>> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM))
>>  		return false;
>>  
>>  	return is_internal_error(info);


