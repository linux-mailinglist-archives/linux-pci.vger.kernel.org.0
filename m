Return-Path: <linux-pci+bounces-16073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895009BD61A
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 20:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203B3283AB1
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 19:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778D5212F07;
	Tue,  5 Nov 2024 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KiV+JxCj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6A31CF295;
	Tue,  5 Nov 2024 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730836013; cv=fail; b=V50Xg8A89gpib4ahYsyuZHs/qG6LJQh8OyDfyIIqH04Ldhcs6XNeC4zyOcJ1ftmeZyDZCt5pM1m+NAkoOlZN7UeFgJKZQyiRYASLnWRLoL4stIlOwTcISCGmI1tFujrZATmBrqTrrihliEoOUV48/MoiXokR/18+pEwr+g4tv50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730836013; c=relaxed/simple;
	bh=XyueZLjt5vUK3g75867v2nEpVDUP7WLa+8CBbrE5wMU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Smru0mSlomIRjhx/40WDMLOx2NHskAjBsqfdHTgNMrKDPM0Sy7dp6iqu47GLEODxUfgZOFdih58YEK7jMgvGH+ZmOsKhx0mT0ns7wAQ8w3o3aeipy2dO4JnvXEJKL2gW70jilNpbRTQl61ggQdzq5DPuiKQScDWnLeugpSSYn2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KiV+JxCj; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGrWIQ7b/Jm26rJkY0DilixSvx7293FdsLNxXcFUINVg4dAh8V7Wfe8HU7wlpuSfyX/DjLQb7KTcmiV7+ahKFI9bkh2GKoUHLnvIa/L1t+JTsp36VV78XM2cXaD3dliEKZjshXRdQjXwrP1G6HSI+UW511ZtpSdxNrtdpg7oKOh8L69w1ANWAe6vYAT67HkhHpwgttKTIoNuvHeZt2P8pcyaBnz4Czjd/OKlAFBycyKC4Aaaefq67HW8nnl4dY9iijKWsH2r2fRpSEBP7RiV+yEGQIf34BTDGfgVmqG/BEKve9o/0tcr7WgCVpAcZQRSt1kPqKUiaoDa+HoZOOh7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4zVR+bJc8nN+q/hXbIiqegQjWRSafemps5TCgkDbOw=;
 b=segxhrT2to4HpGX+6Fsh/4zhcR/Ygt1bvH4fYTb51auZKubrEklj8+QrBRus+gzYv3PQ2NWBCHL2CW6lrXVDnZksDVdJubGi0FC8lmPbY8EoySqHAdwhC1tKF7p6/6TbCd41FpV+mmP3laZJqCZJaNBiFiD8LXMsGJ5lQr7Kfq47jw3aDRcZKN68BAqi2RszRNUIfXwTyVyHwhQKo5wHt/417gQJei7nFjY0dhk7gKJGZ1GGubtMsK5ACan9kXJ6bAi83/+sCOCpL2WUFUbnRZUjBFDekz4kQBK1Pv1pPul+V8gdGN24AFVy3cgR8/kaj4tDg+YNj8MwSW4FqwY6Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4zVR+bJc8nN+q/hXbIiqegQjWRSafemps5TCgkDbOw=;
 b=KiV+JxCjP1b2kTDX3684WsiQFCjrYBGueqVt56PJJmzdMbvUPO308QZjlUlTlwPp72zcbBD/yJX6Qcd2IA8mUOsRpAQj4Vq1eUnmGcRf+4rDhJcUS7bbG1ixaVANpKV42rqGKqen3Y0XD63ahLWEYk7BfUs+dKzXJ5HMmzvwhVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6357.namprd12.prod.outlook.com (2603:10b6:8:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Tue, 5 Nov
 2024 19:46:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 19:46:48 +0000
Message-ID: <2b539169-8acd-40c6-9261-47c0252df91a@amd.com>
Date: Tue, 5 Nov 2024 13:46:46 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] x86/amd_smn: Add support for debugfs access to SMN
 registers
To: Borislav Petkov <bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
 john.allen@amd.com, bhelgaas@google.com, Shyam-sundar.S-k@amd.com,
 richard.gong@amd.com, jdelvare@suse.com, linux@roeck-us.net,
 clemens@ladisch.de, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, naveenkrishna.chatradhi@amd.com,
 carlos.bilbao.osdev@gmail.com
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-17-yazen.ghannam@amd.com>
 <20241105192124.GXZypwNJ26qqahcpOZ@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241105192124.GXZypwNJ26qqahcpOZ@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:805:66::41) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0fa17e-7a87-4701-029e-08dcfdd2964f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlNrTS9hRkNjZkovdERveVFPN09iZFVvYjlNOCtCbW1Id3ptMWRvN0NVZEkw?=
 =?utf-8?B?Y0hweFVDRGhuVmxFVVI1TGI2NVlrVlBmL1VtbkRrbDFLYmliRG9DMWRkU0hp?=
 =?utf-8?B?R0NxQ25GNC9oc01xT2MzbXdQcklLMWlHeHBnU3lJRVZsb0tqZHFOSWZxUnZT?=
 =?utf-8?B?dlFpSzNaMmtVY2x6U2ZvS0hhUG5acVRrd0xja28xWVhlaVQ3SUEwSDcyVlA0?=
 =?utf-8?B?dXd2MVV3akxsbTFDWXhIcjJzTTR4SkFTcHRZdDVYNXVoV0FFNlY5ajdCd3ND?=
 =?utf-8?B?NlNOYkR0aDRJRVJVbkZNZzZIZDJ4eXpkdWZES2gyV1kwTEorSG01VTRXa1FV?=
 =?utf-8?B?SllnSWxDT1JsMFdDZGFOTms5bHBpQ3UzbVpXV0lzbC9CRGJFQjZZdDVrbHB0?=
 =?utf-8?B?eDROYlVYRTYyTWNrWWdFbkJ0VjJvSUxzbkVhSWg0VThSUGhKdkRzTDVRdDVs?=
 =?utf-8?B?OE04NVNvL2c2OW1YcTRpZ3krdGhNUUtuNURWaEFXRkYrQXVVM0Y4SkZSSEk2?=
 =?utf-8?B?Rk1sYk1EYjVaN2Zqc2psb1k0T3V3TXpVck45d3d3TWRuYUFRWjBibUdzWlIy?=
 =?utf-8?B?clpOZ1NjQlBJOXp6QjJkajl1SlVhUjBhK1VQVXBUbjNBUTFXOWJacThGS0Fa?=
 =?utf-8?B?TnZ4RWN4OUF6eWt4S0N1ZlQycS8wVjltZ2hSMFpBMUttck83bERMcTR2RjMr?=
 =?utf-8?B?UkM3bHZIY09KM1N1VnhMVjlidnJFSDA1SERjZ0huL3VNd0prYm9oMkFXTWhn?=
 =?utf-8?B?Vk1Lc3R2TURvZzBNRzlZb09UdlNTdVIxRDBLNnVMbG4rMUhmWXg4c1RibUdE?=
 =?utf-8?B?cUdyWndpb2FnVDZPUEZZSFNQb0JIT3c4VU5KQXZBelNxelJVbjFMbEtSVURI?=
 =?utf-8?B?SzBCRFB5eFN6SjNZRUhiNXFTNXJndjF2SUdra0hObzY1SWlRWERoUU1uWWtE?=
 =?utf-8?B?eW5uNnozM3pIUDBMUDlHNWloUUxleE1EbHE5QTh1TDNtYVVuTmpxdlgramIx?=
 =?utf-8?B?c0daMDR0anE2UVkzU0orYmEyU1EvY3NzSG9QcTg0QVJuVGtveTRIbGtiYldD?=
 =?utf-8?B?S1N4WWFqYXVGUG12MXRMeXdkZ0pROGhTZU5hWEpXOHgwbGdnNzl1bXNEa3o2?=
 =?utf-8?B?R2JFZXlSYnFkaGJvSU9sVDZxYmJCUjlSUjlDT2VFL09aUzBXMU5xVGxHSjNC?=
 =?utf-8?B?aEhDekk5NldQbXV3UmxIbS9oU3dVWldITkJEUFBnMXdhS3h6SkNVc1Vtd3hD?=
 =?utf-8?B?MDRmWllsbXRWQld2YUppb3dZalBOcG9hdkRZanNWOEtJZmJnTjRNR3ZJbkpx?=
 =?utf-8?B?TzhEa1VCQXM2TC83RVpZV1RtWndEM0VrRnlWQkZSQ3M0T1dPZG8yb01kN0Yy?=
 =?utf-8?B?SWdobVhpOGd2U0VUOW4yQ2c5bDd3RFJSa3VUSDlBWGVTRXFsZE5aZS9jajd3?=
 =?utf-8?B?c09YUU1uYkVEblNPZVN6dmhxQUo2cVBRUjdMSFdCY2cwQmpRRThXVllrSkFl?=
 =?utf-8?B?Q1RqakQwWGcrZHNacDgrd1BLb1hxbXhEV0NSTmFuSkc0aXBHRUc2QzVIbTdY?=
 =?utf-8?B?MWxnYWFJVk1qSG83bHlzV0tNbk1XRHhLVnV6QXpXRlBqM2Q0ZjBhczR2Y2dv?=
 =?utf-8?B?dXJpQk4rUERWeFFGUDRXeHBHY1BjSjMweXZKQVYzNnRGODV2YVpWOG9ZU0FJ?=
 =?utf-8?B?Z0haMGlMbG9BYnArYyszMlJKVlk1ZnZtYm5LR2VXclZuTTdoMTFhRFUzd25o?=
 =?utf-8?Q?+jgiaPh+qJY1KY9w+ih3OhV1EGbKr4BGQ64ZaNh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkdTcnhRbGQvekh6RkdwMGZGUTRZVGRkbktURjYvcEpZalNOWkU5OCtCRDVU?=
 =?utf-8?B?c2NXaVJremxXdm1UQ0RFeGlMVFRxWk5aejBKb0llVEcybG1jditvV1lqSUxp?=
 =?utf-8?B?elNaSjVZUnFyaVRmYnNLMUlaVnJsODUzWSsrSC9yd1FIWW8zMVBQUUJDaHZt?=
 =?utf-8?B?TVdSbkRzUDZGWnhrUE5qV1BnTHJCMDRyQytZVGdURVl0Tm4xVnVqNDN3ZEg3?=
 =?utf-8?B?ekZpdzFiem1IaUNPRXVRNmRkMGRybUdJRWFXM0Nnc1hQeURPWkt6UVo1dkM2?=
 =?utf-8?B?eVg1WFppNTEvYnIzRXlaT1ZMd2tod3JQdDJDU2lkN0dkWDNBbTdhdjBaZHdD?=
 =?utf-8?B?UVh6RUIrSEFYaWl1R0k4aXV6Z0tERHRhUWVoazVkenkrRzhhRjJPMksyUXJ6?=
 =?utf-8?B?ZVo5SVZpNDBDa2VKdFF0VGs3bWdQalV2anlEcDVJUllHRjJqQUdMN0RBeTBw?=
 =?utf-8?B?bUtjNFZWdGNoc0pNc0VJMUpyTDkxTzdlWWJwSFBmRGhJeTJjb0RMRkhtcFNN?=
 =?utf-8?B?TkRDbWNxcUJTZGppakVzV3JBUEhZS0VNTWtFcjNyRFBXb3FuR0dJaktHYWF1?=
 =?utf-8?B?QWJ5RjBKdWVTSlBhc2VBUVY2aVJ4c2lZWlBsd0IvT09EZWF1eXFmK0RzbVEv?=
 =?utf-8?B?YXcxL0gvV2Q2cjF5bzlpUklRZFBDaE9nS0ZYOFh6NEw0cXlkOGxxMGVMa2JS?=
 =?utf-8?B?eHZiWHNZZDd2clprb0wxOWo2aVlnUTl0Z1YwYjFSTHc2dGhVZDdhc2xsWFpv?=
 =?utf-8?B?bkJKN1VjWlVYTm4wclhrYzhSNUd4NGFMMm90WkpyMkR2NkhxWTlBaUdhSnlJ?=
 =?utf-8?B?QnlZdEJhVzhIV1R5ZGtkMVVRSGRUanVvQksyQjR3bHA3T2ovdnFoUGgraHFa?=
 =?utf-8?B?cXJiOEVKUWZJRlRQQ0MvREtDamYyV05EUUJidFZVRFhRMmNvU2tTNDRzdXVy?=
 =?utf-8?B?ck9BZ2Urc2FydCt3cWJKYXlNRW1uWCtxTkdvdlUwdmdYdkFacFdzQjRQakp5?=
 =?utf-8?B?bVFJQW16TERJTkdQQldxeGZUVktKMnBNdkZJSjdrUHdLbFpBVW5Xcy8vVDdO?=
 =?utf-8?B?d21xZ3hTREpheFNRQStmM3pDTUhrZWZKSzI0cHRsdTBib1VvblB3eTVIcHo2?=
 =?utf-8?B?TFdDa3lYTWZlMWR1d2dxNlpBQ2ZyZEpoY3BzV2V1bUxOazJ3cy9TUGM5dHJY?=
 =?utf-8?B?YUFzWUw2bU5qR1B4V1pOTFM2RnhoVlpudHRFVGQ3U1pmY2lKNGc5b3poVCtp?=
 =?utf-8?B?c3dRc1lCTzdHMVlucjgwQzF6L1VCVlZNS2VjSEc0WUZhWFFEYXdFYTRhVWRF?=
 =?utf-8?B?RTlZOW5vMHlUemRUT01MenlGbjEzZ09VQjVtRHNxbFpUc0ZFMzU0VFJXRjVI?=
 =?utf-8?B?RGhTQTdXNmMxWU5QL3lqaTdaZStrMGpqT0NYaE0rOC9hbm00S3JyVHJIYXQ3?=
 =?utf-8?B?VW5NWVlxZngwOEppOVBXWjlmZ2Y1WUJQc1hWTStPR2xDUHN3bVpxYyswUGYr?=
 =?utf-8?B?OExyeXNSdmlzRzN1QVowTklBblRMS3RCU3JrY01pNG85Mk9ZY25DMkRNY0hm?=
 =?utf-8?B?TzAvWGdLa2drclNGV2I2VUcxdUpwcUVjUnJ3UFRwTk9VL3d0dGJFak9LWTlU?=
 =?utf-8?B?eWl5cW16YjhENmIzMjRHWFR5ZzRJSElyUkt3dnJUQ2xkTTlBaHRrUU5adlJU?=
 =?utf-8?B?RDJOL0xienkxa25XbWlGWDRzY3BublJBb2hZc1FrVkRhYWhpREQvVDhKVFFr?=
 =?utf-8?B?b01UVkdrb3RkZUduazJrRXZCbVBqdW50dmNNUlVrL1BmMWsxVlBVWjgxd2Rv?=
 =?utf-8?B?RmdzTHI1MmR5NVdrVG1iaWs1TjM2blFrUWY4Zm9VMkJ3Zi9PT1p0VjMrQllT?=
 =?utf-8?B?Njc1bk5iT0I2eGYza2Vnc000NWJCSUZkcjdJemVwZ1JoTnZiQkp5TjJlOHUy?=
 =?utf-8?B?bC9PVCtzZFRnOHo3bFdabWJEdG9PY3pHWWRtT3ZXV0lDMXp2RkJFSlZ1QTdI?=
 =?utf-8?B?V1B3TTVGRGZTMEJRRGxBeTNhQ0R0b01scVlCTFI2U2pSMmY0NGhWT2F3ck1K?=
 =?utf-8?B?cVk1TnNodGlJc0I0K2M2eGRLd3BWbjBaOGxtSVMvODBRaVdQT2NQbjVBZmF5?=
 =?utf-8?Q?ImsLFffnbaA2zoU41mCvzwSGb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0fa17e-7a87-4701-029e-08dcfdd2964f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 19:46:48.8494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdrdpK7ZRtIImEp4w+Z+rU3Sc5/flTbHZ8IwDjD+ERpXl53yqfjY+RPXmOx6GaReip0yDuuU8bDzGeDcWLj/YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6357

On 11/5/2024 13:21, Borislav Petkov wrote:
> On Wed, Oct 23, 2024 at 05:21:50PM +0000, Yazen Ghannam wrote:
>> +static ssize_t smn_value_write(struct file *file, const char __user *userbuf,
>> +			       size_t count, loff_t *ppos)
>> +{
>> +	u32 val;
>> +	int ret;
>> +
>> +	ret = kstrtouint_from_user(userbuf, count, 0, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> 
> That looks like a TAINT_CPU_OUT_OF_SPEC to me.

Makes sense.

> 
>> +	ret = amd_smn_write(debug_node, debug_address, val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return count;
>> +}
>> +
>> +DEFINE_SHOW_STORE_ATTRIBUTE(smn_node);
>> +DEFINE_SHOW_STORE_ATTRIBUTE(smn_address);
>> +DEFINE_SHOW_STORE_ATTRIBUTE(smn_value);
>> +
>>   static int amd_cache_roots(void)
>>   {
>>   	u16 node, num_nodes = amd_num_nodes();
>> @@ -180,6 +257,12 @@ static int __init amd_smn_init(void)
>>   	if (err)
>>   		return err;
>>   
>> +	debugfs_dir = debugfs_create_dir("amd_smn", arch_debugfs_dir);
>> +
>> +	debugfs_create_file("node",	0600, debugfs_dir, NULL, &smn_node_fops);
>> +	debugfs_create_file("address",	0600, debugfs_dir, NULL, &smn_address_fops);
>> +	debugfs_create_file("value",	0600, debugfs_dir, NULL, &smn_value_fops);
> 
> Can we pls stick this behind a module param which is off by default? I don't
> want that crap exposed even in debugfs, by default.
> 
> Thx.
> 

Why the worry about it being in debugfs by default?

