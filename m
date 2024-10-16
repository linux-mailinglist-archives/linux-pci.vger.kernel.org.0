Return-Path: <linux-pci+bounces-14678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE659A108E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 19:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942601C215C7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 17:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9F018891F;
	Wed, 16 Oct 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q7HHwGBd"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C375188580;
	Wed, 16 Oct 2024 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729099456; cv=fail; b=MvIbSn+bKUtTPvX76sRGQVubVmHI4W4C2xa8N6F6ZWo4sztar+iTs0srGe90BDveISDHyyABsE+BJidhg+8kocVFZQoHdmHSAELDNSei4L7KZjDc49ckV56urBK7u+rXfvjayP/IWGwD4zKpFwz4SYlyu/QhYC4hgQYndDQ7JAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729099456; c=relaxed/simple;
	bh=ZiwBC9Jqars+05Ij7F3Ox65N43dQo8zT9ZDhSDul0M8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XqfQhOfcH6mT+ZH8z0dTjddpE3YrmUSGaVFvEzYfr7HqYt7dLmcHDKvgp8C8hlslci3z6qWK1vWE/gvAhsubadT7njbec/p2hgQJiaI9cb6evbplhrGODpYxLW+kPsHbEuSVOnPrrwfOu6gpyfYBofUJT5hMy2g+SW6hmDYIqlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q7HHwGBd; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSLGWvUKcdnIYuG4jY+Mb4yJIKIz5I/3Za0UxNj32ww6LUiOlR/74jq9sFtRof5sQQ7bu/gA2828dtKvF+xWxyVgugmQcI6v22jYewl2wYTlvrmirdUEZ68ihx0jSAoMuzAgpCSzbXhBltCkrMXA1dhSQ9Dh7SOFY9prKzQpYaD2SkP/UpBuHWvyXPdZ0u0LFolbZCqC7gsMjEvHf9zE0VxCruF/qroRq20HV7GVUjaNKBKrySBMxZCDMCDrktvApue1GE5W9/MvWpbvRIEdRXhW4Y1QRLBClYzHONZgTHvhjJRzNe7NEefxZ05Uf9OV6viRatFljzzuGa3a7PTJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhC2oiZ3zBA3nNrm+3swFZ3kIVCvnc7X4qvDlRqcj4U=;
 b=K+/6OzO0p1l6SbAB4UIhTaNf3Q7iGfiJDUXR0wO46MAD3Vdx+VPkxFQH9B9ses8Wtjwq2iYZeP2slDc8ugg2Gp+jtXtdJCRKrelCALE9pWBtXIJ16VdG+ofpJCiEnoZr7wZ7yd5L9H4NlnKBAtQex7MmNdag75+SsNvaxdLUPw5HfmW9m2sP9FfI1EEyFLM39AAINu8m5Tfj5sW3g+ZNZI8DsYmcRcstvFTi9Fkr245kTivlNaiZJMpDyBlcEE+bFnpUzO5k1MgOWHeNHjSCNTUQv7+aA7+330bo/xFiqrm8bB2VUz9puVm92svqEOb9y16jvQ5HnnjlKNE0csz8NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhC2oiZ3zBA3nNrm+3swFZ3kIVCvnc7X4qvDlRqcj4U=;
 b=q7HHwGBdBJirvqaK5yNEt5JP3fyB1kUWea0my21qzXf0iagZbSCzcGClwHTdC8hP3Z6OnQq8+wNmYs5SGTAAsCEoQ1PbbWTIeQBJLNEC/8CJP9SMpcjGQnHIHbZTkT9xzNeQ9vJGJJuGDzlLvtxbPPgSJpDbvttXjzIwqE4L5g4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.19; Wed, 16 Oct 2024 17:24:06 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%6]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 17:24:06 +0000
Message-ID: <32cfd1ab-9d65-4856-a7b3-c88bf5c0b728@amd.com>
Date: Wed, 16 Oct 2024 12:24:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] cxl/pci: Enable internal CE/UCE interrupts for CXL
 PCIe port devices
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, smita.koralahallichannabasappa@amd.com
References: <20241008221657.1130181-1-terry.bowman@amd.com>
 <20241008221657.1130181-16-terry.bowman@amd.com>
 <20241016182110.00003455@Huawei.com>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20241016182110.00003455@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0112.namprd11.prod.outlook.com
 (2603:10b6:806:d1::27) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 85972e66-b004-4a27-355d-08dcee075698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WS9JQ3lmejVxZUFpS0JUVlBuckxaYlFmKzZ5bUVFeU5lSldQV2V2UVFMenJY?=
 =?utf-8?B?aW5UVlczOXNEVWtMRWVOQjlzRXVZb1B0US9NdThtQUZhK1I3WlBPZWMrVjRD?=
 =?utf-8?B?UlluZ1N4Tllkd3QxOHdQQWVTRjN6VGl0bUJnZEJpSTlnK0hFS1NVSkE4Y0Nz?=
 =?utf-8?B?WmJzNm9tNHd3a1FzYWtKdFBQMXBNMElQNVViSEJEQlc4WER6QkNtVnRPTVJl?=
 =?utf-8?B?SkZRQlFpMjBsd3c5MWNNRkJrdUJIeHZKdERiTUxIZm1wMEwwNDlmZzZQcFUw?=
 =?utf-8?B?LzBYaEVvK0RIRytmalF1SlQzZEtHUzNNbzJVMk1DSmo2eEtGNytoRGkwZkhG?=
 =?utf-8?B?MjF0UlY0Z2xGa1Bidk1mcWszK3BXQjBtd09KNDZMSk5tYlA5a0l6NUJYUmpH?=
 =?utf-8?B?S1RyVGJDYTJ4MmhpMWFYaUxnREJGNkJaRWl6aXRpblJKRzZuOWJUMzM5R3hv?=
 =?utf-8?B?TnNjcllGUHBaUGtCT0Z2Q3NkZ20vaitreWo1NFhQenBsU25hVnNFUmhYOS93?=
 =?utf-8?B?M2daRWlLQWRqK1BVWUljb0MxbnI1WkV5VFlyaFZ6RE54ZlFTOU9zbFp2Nk80?=
 =?utf-8?B?eEl5QmIvdDc0WnNCL3dJamJsTkUvUjMzdDZXRWFNWG9Hd2FlRStNclUrbEI0?=
 =?utf-8?B?Yi9JREdqeEZoVFI1cTJRM2orVGwzSDFpWHBVSFFGZGxBdU51RWZmRWJ4b3Fs?=
 =?utf-8?B?cFZ1eDR4ek5qZk1OUzdpbHlnNmdJV1lQSWxwdU54Q2hPVlFVZ2pvNWMwMUly?=
 =?utf-8?B?N0tlNW96Q1pDVkNGNjJoVWQzRnJLbWhGNjUrbVQxcEM4aDJBWG5UYlZwWW0x?=
 =?utf-8?B?c2xOVFhPRG5pOWxHaEh4ajBBcDhsZmxydU5KU2FMT1JNMWI2UVBjNjI4UGtx?=
 =?utf-8?B?MFhYbG90UkYreStiQ3N4OC9zZThUdHJXM0JScStqSWVLMkJXUnlOVitoRldT?=
 =?utf-8?B?dVoxZVRFbXVwSk1KTjRUUzdQUGdhYUNJaFVpYUhRQXNLcWxFaHFtMm05ZjNh?=
 =?utf-8?B?aHF2RDZWUlZCd09saFFVMEtwQmVIcjZQMlJhM1hhaVVPMk8yRnRnQjJkSFJT?=
 =?utf-8?B?d01DRktsU2Z4QkkzbVlSanlIajhCb09hTUprVTA1MmVBazEwZUVONTNNMStZ?=
 =?utf-8?B?bU9ZZE1SVnB3MjE1Y1JSeVZFMjh2amJaRmFRK2RLOGxSN3Rtdzc5K0ZmQysz?=
 =?utf-8?B?RHdsNm1uWmdKcE41VjFLODQ0Q1d2OTBTME1taWkrV3oxY0tjK3gvSGFzeUxv?=
 =?utf-8?B?QWNzMXlZdEp4eFZDVGRTTVRZbVRVSjg3TVhCdVlMVitaMzFaM2ZMWVo5K2ZP?=
 =?utf-8?B?elJ1QkxwNkNjQjQ2alo1NlRWVUkyVWJZVy9yTWxQS2ZXSWVERmRUajAwMHlI?=
 =?utf-8?B?eUxKa08wODZYT2ExNkgrNUFqWGl3RFN4WElHOUVseWcvNEJtUzJhaDZMOHpn?=
 =?utf-8?B?Y3kwZmo5cG1lWndiWmNJbGZxNFdaQUoybUtuUFR4bU5TTnoxM0VWTFFCLzVY?=
 =?utf-8?B?cXc0UEY3L28vV1BvM3IySzBVamFEQTdFOVdHdnhSU1lIZmxLWlZuaGN1ekJZ?=
 =?utf-8?B?bmxzL3FFdEVTRTM5SkZmRkV2b3VXU0ZGUlhYVGV2N3VNOWs2WFczNVgxZWpF?=
 =?utf-8?B?cXlFQ2lkUzArdGRBR0E0b0MxVlBBUDF0bXcvYml3c2FIUGhqNTlnNlhJN2hi?=
 =?utf-8?B?VVZHZ3FLRXB1MHVsOS9SNFpRbDRDRzlpYjBMV1pXWUNMSjVSeGVmbHNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U09OdjBZR3ErOGF1VUhhMXVtKzRyRTlxUFl3YWhXb2VJbEtmODAxM1JJaU5l?=
 =?utf-8?B?L0xEVWxpSnI1MWxLUUxlaWtoODQ2SUtTMTVjRG1wVHZLZ3J3L2NJem9jMHFS?=
 =?utf-8?B?WHBwUTI0bDh0TlVoSFN1UnNvVEthdXpzODVkNnNJQWc5aFNDLzk4RTdRR1g4?=
 =?utf-8?B?R0VTQXZpbE8zWloyQ09POThneVc4eThtSzA2dnNyOTZ4dmpuZFRCU21uZHN3?=
 =?utf-8?B?N3N1L2lZYzVxNDhIRmM2VGlnRk8wcUlORUhRazk0eDBSWmd5NkFERnhKZTR6?=
 =?utf-8?B?QjJKeThlRm9mVlYzNkcvQVErRHlVVVIzejNjNFJUOWpISmI1YTMvRDJKK1NL?=
 =?utf-8?B?d1RGOVRDNVpXMDhTR2dOZmdZMXozaGFZSFhEMVFzYXA0QllUenBKQWdRdUNS?=
 =?utf-8?B?OU5ia3YvZVhrQXYvQ1dLV1VSUzhYSWpUeHNaSEExSi9YVEZUem81Y08yZ0lp?=
 =?utf-8?B?Yk5oVDAvTi9zR21WVjhuTWJsZkVPc1o4bGFmYjRxSHNIMjB1VHROaEdxSUxk?=
 =?utf-8?B?NUJ4UHgvQm1sUGhnRWIyNUdPQWNsbjJnTUlrKzdwZjRpQndmR0tyNjZFV1h0?=
 =?utf-8?B?Sy9JMklxZlZSVEYvN0hWMTdHUjZxUWY4SkNjTkppWHhjcWI1RVZORGxxOU1r?=
 =?utf-8?B?ZHdjYml1aTJ4QjZvNkxYY2t6RUFOcWRNSmVJdG0yOGo2SjhaWVRiV0U4RVBw?=
 =?utf-8?B?UnJtTUpGcmZlcW9SUHo4UTRrN2kvbWxIQzZBcmIzczJlbmtjTWFGQXd1NkVD?=
 =?utf-8?B?RWZRY0ZzRCtnZ1lQQ2pmOENRSWtqMktRUHVKeUc5RmxwY2toZFhjQi93WXBJ?=
 =?utf-8?B?ZWZrWDk0dmdLUXZVbGltcCtVV2Jvbm9QL2htcE10RDlKZW5PMzVVeWpndk83?=
 =?utf-8?B?MFdYMzRQdGppSEViU01ScS9qNklKUEpOSGV6RmNlYjZ5V3ExK1JmaW9jMnU4?=
 =?utf-8?B?dFgvYWxud1lJRmlGM2dvNnpEREFQSGo2MUE3V2orTnAwdHJOMjdMRklWSGdi?=
 =?utf-8?B?dHdUSk1qT2FLWnBKd1YvVUgzYWlZU0k4cjJjNm14bFZreUlSREFYdkxvcU4y?=
 =?utf-8?B?bXJxS3R3b1lycnVnTGdQUEZQRXFodXJXTzBSbFN4emlHOFBwd3ZBMWZ1QjhW?=
 =?utf-8?B?RXlIREFFcUx1TmUxT2c3SEZOSm50cDg5UG16dTBJRWMrS3RSL2pIMDkxTko4?=
 =?utf-8?B?MFhQY29QUE52TlpxQlNoWC8rMUcxMkJSYk1pYm1BS0FyemEyRHlXWGpTcWtY?=
 =?utf-8?B?ZEJxUWV3WGNaNi9qUzFhT1hHSm9sN0lzYWZZcytkSlU4MVpYR1hqUTJiSUZZ?=
 =?utf-8?B?Q1QxeXBMUDJ4UW1rbHloTXBRSU1LalhvRzVWa1ZyaFNjSWhYdHFLbjYwMXZy?=
 =?utf-8?B?VjVJSWdNZmFEOFdJdjFRNmVNNkh1eUtYd0ZGZ04zMmpjYUhWbHdva1lOaW54?=
 =?utf-8?B?QUVaWWNxeUF3bFM5enhvNE45cXhqOVgrYUdQN09MbnFrSmtrbCtoY0hmejhQ?=
 =?utf-8?B?TDEwbkF2SFdYNy9LbmtwU3QxMmdwU2hIZjRSTUlmZ3YxS0NHVkxSYUIvQ05q?=
 =?utf-8?B?WTUxbnRpdlVhTjVzMTkwdEcrZUpuTUMzYTEwamc3d2gvZGF2MzJ5cVNFa3Bw?=
 =?utf-8?B?SXBsMlQ2ZGRITTVjNTlmcGx2YlNRS0d6OUJrcGM3djIvN3Y1YmZXcTFVS0Zh?=
 =?utf-8?B?M1hNYUxDM0Vsc1N1SSs4S3FpOVo3Vy9LbVhxcitQVTNTUStWbGh2bG1Qdkl5?=
 =?utf-8?B?WDE0MTFheHVGbTc0V0tXNS9nUlpQdVRRVVhrSHFCeUdXc3lIcjJmajUyVWFZ?=
 =?utf-8?B?OVd1aGl1TGVRTkpnYVdXbGhzbHUvZTkrblNISmV3TkxXTTBYandQM09xQXhh?=
 =?utf-8?B?VnFhRlgxWGR3d2UrYS9GM0l5R0Q3MlBJNk13NEFNSDhFTklEQzhib2dhZ3lV?=
 =?utf-8?B?Y0J5TTJkcnhEZllxUVk4QVpPYmZNMElNUWFxRHNLck9LelBNSThFTXg1cjJF?=
 =?utf-8?B?ZFA5LzJXdGlLMzROTFh4dXNsN09FUXdFcVJnUFFGUXQvdFdnaDFYNnUxQVVk?=
 =?utf-8?B?bXhqYTE3U0FPZ1FiRk1jalNRVzB0aUN4Zlk1bWZQcFBSZkZ3emlaM2dBVTNV?=
 =?utf-8?Q?uNgpVklZ0lb7AOyimPvBCjxCJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85972e66-b004-4a27-355d-08dcee075698
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:24:06.6443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8P99J2wQJWyoT9YlAVO+wKYQP40SCS01l2SxI6th+3VR3Qp9wGYS1L0ppAYyxxdDIyF+qAeKRAjm/qrFspJoDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921

Hi Jonathan,

On 10/16/24 12:21, Jonathan Cameron wrote:
> On Tue, 8 Oct 2024 17:16:57 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> The AER service drivers and CXL drivers are updated to handle PCIe
>> port protocol errors. But, the PCIe AER correctable and uncorrectable
>> internal errors are mask disabled for the PCIe port devices.
>>
>> Enable the AER internal errors for CXL PCIe port devices.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> A while back I thought we had a discussion about just enabling these
> for all devices and seeing if anyone screamed?
> 
> I'd love to do that rather than carefully enabling them for CXL devices
> only ;)
> 
> If not, this looks fine to me.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

These last 2 patches will be removed for v2. This is not necessary.
Internal AER errors for root ports and RCECs handling are already enabled 
by the AER driver. 

Regards,
Terry

