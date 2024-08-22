Return-Path: <linux-pci+bounces-12025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8612095BA7B
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 17:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9A01F220B0
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 15:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6352C1CC160;
	Thu, 22 Aug 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fHda7+9I"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8B518EAB;
	Thu, 22 Aug 2024 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340594; cv=fail; b=ZCcXA/epPhrGhxI9mq66z5ElDm+JYZ4X130/6QB/MLuMxExQFM7GAF8VR2TrCqfsAUqnkl/B+fJZW/eUGMYZw+I3HB2056c33chbXjLEgmi1eDyUgKisaFctYTxSIy0S3y9nv4bPGIvhZiR46Sg5MbTg6WejtaCwWWechh40+Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340594; c=relaxed/simple;
	bh=lSrEBxJdK/RcVrxzd09kccvrbdqupGmiWvFdBsgqc6Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LMbwUPD3LGzhCQZTtNfZxqpbBuMw5XkqRA3ZpG6uZ70/GdqCjSLmOE2AgYqc1ufd7WKia8FF4QNptFEn7HYxomxbG7FVJY3Mg3pgXv2kQ1veXpZaV8IihLNRjWUW7CUHxZlF22y7wOLxi2JGhHgbfAvJSowtAthhS7p9wvVguHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fHda7+9I; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llNlh6ZVAX8HA4foKnt5OdrHJidzPkDABIuRSHxtOuARe+3MjqDHhGfpTLeb9+Y4f/q3POB+OLfF2ocv1WwLtjawHXlCrxzrzLx7XdokeZHJJ4kEAoPyk3L6mpJoE29K7fAVF/XXxOf0oFPQv7DUTeayavDqpuW/kjTuVBHTu0KbQnHLmVUmiWgWLLP9RPIBCsAZn4Tl0uT5XyPhFYoQsi0v34e9yLhU++MxaOvvJsY9LiHzqIqEfrBJtBe5XFOCJwNkYSxUMHcQtcaRFfXhYtyLAuJQxX6DLo2bezjrKjqjV12ERrwaGQjw5MQLVc0d9YF1CaZBexKG+Z+EEtZAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMGvqkPmjO4v+4lnlLIOU9DHS0rDrxS4znE1gOjtNjU=;
 b=sxMlb+YLrXDItbJChwzLvsMEpo69KBn39XZodW6Us072Sy1hTlGjAcJpLfx4S5PQ9JBqYP0oS+U1kNmAF+bJi3awDPc0EXgxuyEnSTZMv2QD5YqSe+/1RGILZ3sxKNl22bkTkS3w4+qS/LrgqYF8jNOl+s+x5q119jBaRqwZlL75xXibf46NoEJ/U5DVB/8o4KiG4cgw7FS3zEXmvRvKvWWQQoVxNlldTyFowLwS4yH3OXURsBgcF5Kaoe3WJs+50qWTg33bm6GChA9Chya1N3qROYEk5evAQoUGZyQommbZaXGlPIDe4akld0l+sWTep7+FLUm7iQqlurSBiCIVbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMGvqkPmjO4v+4lnlLIOU9DHS0rDrxS4znE1gOjtNjU=;
 b=fHda7+9I2IqIOiOeyT2MEUbLF+39tZKKB1GIgcY+jdBGuWqHn7Vw5Xlsaiu4PW9xBWN3IUAVSb/fbhP49RfkUI25/5XX3lCw8bRwf1hVyiFc/pB55u1lqL63Yw/RBOG9x/8Z0vszxg+HvGxZdZ8VwmTUNc35aQiFlAOmj5/yBe8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8404.namprd12.prod.outlook.com (2603:10b6:610:12d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.27; Thu, 22 Aug
 2024 15:29:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Thu, 22 Aug 2024
 15:29:46 +0000
Message-ID: <6da512d2-464d-40fa-9d05-02928246ddba@amd.com>
Date: Thu, 22 Aug 2024 10:29:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Detect and trust built-in Thunderbolt chips
To: Esther Shimanovich <eshimanovich@chromium.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: iommu@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240815-trust-tbt-fix-v3-1-6ba01865d54c@chromium.org>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240815-trust-tbt-fix-v3-1-6ba01865d54c@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:806:120::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f735c6-4ed7-4f7c-368f-08dcc2bf40cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVh1Z0Y4K0UyVzloeUpTNG4yMUJTT0w4QkI2VVRLOWN5NllsV2dMVFNXRmwr?=
 =?utf-8?B?V3dTNVZLOFp0M0RtUTdHWkczUjlKL3l3MzBJR3Z5VFpVWXVFbWJkRWdlcG05?=
 =?utf-8?B?dC96OWZ5Mys5WVhHaXhLZm9kclQ2cFd5N2tHYXhlTmFOZmU1L2I2UjlYS1Y4?=
 =?utf-8?B?QlZnNk05ZGoyc2ZScmNvL1Y1RGdMUEpTS09VRktiUFJmbEg3R1M3Kzh3WG5y?=
 =?utf-8?B?UnlxQ3RMYlQ4b0JKb2FKSG5VdzkzajhWVGtPWVQzZEJRZ1dSYUJlRzNnenhV?=
 =?utf-8?B?bGxFbkluaVNmTGxaSHNNRjAvZzRqeHQ3Q0NpdmFEcTRQWFVuRlE3TUp4ZEtT?=
 =?utf-8?B?cGZxY3o4S3dBM085U0FuTTVqOWpzNS9FTEdqdlVxVCt1TG5MY09IdDFNNEhn?=
 =?utf-8?B?eitFdXVhd1BPeEtZM2twL0kvbWNWUXVFVUEzeGVzTVpEdkZNblNLdHg5ekpZ?=
 =?utf-8?B?RWhNbGFLUm96M3J4SXNzdGhVZFZFUGp3ek1QNXlESTFBRS9ObUpZT21VMXQv?=
 =?utf-8?B?S3hmek1hRE9LaFYrcVZwMlpNZXFOc0NjcDR4QjNhdjRBTkwwMFk4cXBkRzJY?=
 =?utf-8?B?NkxqOTZkYjZXWlNlTkVGVjRjMlprcFphWEI5QlVnYXFjYlJvSEk2RFVWaUd4?=
 =?utf-8?B?NVRlbmhLR2FqUHluMTNKZGx0Rk05Q3lGSjRGR2pIdlArZmx5ZWlaN1AyaDcv?=
 =?utf-8?B?SExZQXB6SW10R2ErRDdFWmpsQXRSRnltUnVNVzQ0Ri9TdzRkWTRoZU9qWVFT?=
 =?utf-8?B?WGFENWdSOHU0bUsvd01TMDRIRDFhdk84a2ZWeUg1QmxqOENXSFhpN0dUMFNy?=
 =?utf-8?B?OWRuaEFYK0I2Y2s4b3hPeklEQVlLUzVXNGE4NkdDK2FuYXdBQUVrTUNHTzZL?=
 =?utf-8?B?czhHUUNLM3VoTEM2aVV5U1ZiUC9jb3VNM0xQR0h5WFhQN212bnVYaG9TNTA5?=
 =?utf-8?B?Rk5mVncvL2lLOTVBcngzV0g3T2FRdEQwQ2lhZ2RyUU5NL2pzUUFTTHNkNS90?=
 =?utf-8?B?SUFzRTI0S3lSZWdmY3pFWUpTekVaRkp5Z0tlakg4bHhLWFYvVGcyZDJvMHNL?=
 =?utf-8?B?N25Pa1BXRGVTYXZNZXB5RDU4UUVQYXJjRVdlRi8xaVBXY2pEKzV6L2UzUVMw?=
 =?utf-8?B?VFkxMi9FcEY3eUhLUHlFb255bjJWT2o4OHdwbnF4SjI0SmRwQS9sSW1pRmdH?=
 =?utf-8?B?ZEpsYis3KzhHR0dzeHZxZWdTZWJvamUraCtsdmtzZEthT0RrdnlNNC9QODMw?=
 =?utf-8?B?djZ5bmhHZGRtbzVFcnRVRzRjd2FwV0swNSsySHBBWDArV3hZalQ2ay9BQklF?=
 =?utf-8?B?NmQ4Rjdqb0R1Z29sUjVXRGdKKytORmpTb1hadWJkS3VkL0Z5Vm1jN2xzV1BX?=
 =?utf-8?B?bXRCQzFiT2oxRDJpTGRvSmd2UGxZWU1IdXg2UlZ0b1N1RnpVbTkzS0VBWVJK?=
 =?utf-8?B?aFNzYVVxWmF6aWRRUXM1RkZZaTlWMWN3aWsyR0F1ZUhlUDBJT216Vk5CWmda?=
 =?utf-8?B?aVFzT3Rhc2hrV1RpWGY3U2VYai9TSXBEbWpRYkk2R05SSWRBZ0VycXNPWllS?=
 =?utf-8?B?ZDFrSDQvVlJ4akplNXZaeFhJbWZHZXA4QkdXL2FSbXZpMHNHYmFGNlliNHZE?=
 =?utf-8?B?Ym90d3FORzNrSnNxNWllSnlMU0RFc2hMYVZPOXE5Nmk0d1JOMU50MjZSNVZm?=
 =?utf-8?B?OVhTUWpCSXZabC92a2NOZXVjVE1aMkJJKzNDYUYramJ2U0srL1p1bjROM3pS?=
 =?utf-8?Q?LA8+yRErXJsNy03V4iHom7xywKCxRK5zqokR6Fx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VERZN3RoR1NzWm9qdzlUWDRkTmI5RDl4NDJKNzcvUEkzeHEzNEpUaGVLR0xL?=
 =?utf-8?B?WFUzTjVhRSs0SStyTTZGZ3hLMTZYREVPWE14ZCtCVVdMSXlRWGkyL0xmZi9t?=
 =?utf-8?B?WExWdVd2YTJ0dXJ4Q3l5cjhWczUySmZzelF2VlBrY1k1UTdJOXpwakxOSS9G?=
 =?utf-8?B?YzlOL05DcnJGQ2VNaGs5M0dmc0szK1RtRFAwYnoycldoQzlKWVRGNnJEbFNR?=
 =?utf-8?B?WnZWK2VjdUdXbzBQVjVoV3ZDYzRwcmNUVGVrQjgxZFVDY09KTUJOc1cwcjZ0?=
 =?utf-8?B?YjV4WitMMTA4UFdmUnhUZmFQTEJJWDJidmVmNjN5OVc5WVZVK3hJaEJ2WXRi?=
 =?utf-8?B?aDJJdWtFbUcwK2ttd1Z6ZjlPY2orZDJ0N0dSZEFPNmRDRGRob1V3TlhXRmdI?=
 =?utf-8?B?WkRycVZNY0VCRktXWjk1S1FtU2lXNE9EWFQ2Q0xTNEZxdXk1d29wdTA3NjM2?=
 =?utf-8?B?a1c3MzNseVpqbW8rbkpoM3lBdGFTRXNFQnhNZDdkSWZXTTkweEZYTnlYbUZ1?=
 =?utf-8?B?cFAyd3hoRWJvL3JFL1FaTzdxVzZGU0FPY3RyM0hROTNTUnRFeW5SeWo3ZE9t?=
 =?utf-8?B?SHk5bEdMdmtBZWM1TXA2Y3dyb3ZmbnhSYysyem1Odmo2QVJsZXhXcUlqZktG?=
 =?utf-8?B?QjdjWVdLWVFTcVQ1SkdMM3BjK3k4Mm9DYnhWM0NhUEMyaXFIRU9VdGUyUEU1?=
 =?utf-8?B?OHdTTmtrZlZicUo0SWtwV25sWVc0Wi91cm51K3VuVlB4b205dU1tL01sLzJp?=
 =?utf-8?B?MGh1Wkk3WmlDMDBTNUROeExlS2xlaVBmRGk2YmRjRzJFSWJ1YU5LRnovMjRJ?=
 =?utf-8?B?UWNISTZDcXc3TjJTbmI3Vm9OdHRCUTZGalY4TFpKZmRRcFhlL0FPdjU4VjRN?=
 =?utf-8?B?V2RqOGJ3N2ZJckZmSVlGYi9yT1Z3czAwQW5FK0VyMWlIUzhIUFhvNjNqZkVr?=
 =?utf-8?B?bzRQclVWOTN5R085MzVqOHBXM1BtVnBreTc3MEl0Z2U3ZVlFMVVTMU1sZ2Ju?=
 =?utf-8?B?K1JIbEQwb001UXBGb3hKamFMcTZaazZXbkc5OXJxT1dzVHF4S1JvODJDOEV3?=
 =?utf-8?B?Vnd2RThiU1ZGMmZsTGl5c1VuKzZqbGlvK24rcERWdWdxVGg0eDRMVlUxRkps?=
 =?utf-8?B?MmZqT1VlaGZoNGx5cktjaXhhQ05paFpRRmxpMFhvZlU5cjdJcGhLdnpKaE9W?=
 =?utf-8?B?QmhxekdPeEpwZ1luWUpDMjVXV0YyMmhhdTg5U0pCSTZJbW05TzRRc2dhcC90?=
 =?utf-8?B?OUxuVTNqVGVGK3VtL0RKUWpVMXZlb1l0cGlkSVJTaktEczlZVDcveUE5bTZR?=
 =?utf-8?B?bDc1SjVBYjk4UFdjMTlvd1lmdTBWeXRJVkFLbWFLNzgrVnJzaGtlTDhpUklq?=
 =?utf-8?B?ZzJMalAzTEQ5cDBvNlYyRmg4RE5INnBGeG1KeE1YVTFQd0tDK0JONXpESWY4?=
 =?utf-8?B?citlTkJSNFpHNjZjWmhmTWFUVFUyR1AyYVdJdytpbWNtMk54VWRoUnp1VW16?=
 =?utf-8?B?bzJlZWtxUnF4a3J2UlVXN0tWeitISHNVYjNjT0VVQnJTY0VTYy95QWVRTEY5?=
 =?utf-8?B?Z2kyTXBMQzRyMTByczc4ZzBQMEllKzlhUE9vTWlland3VTV6MkVJRVdpVi9k?=
 =?utf-8?B?RnBWT2xNcVNGaDViWGxBRG1kQit1amZDZUhmVitmWldiSXlPTmg3ZU9keEgv?=
 =?utf-8?B?YXlTUTlPUEpoaTFmVVFmeFdFV2d2eUVITDByWmdYakVKVzZuWEdGSU9nNWJl?=
 =?utf-8?B?ejVSKzJLbVk0cHl5dzNkSUxHQnpKR2g5b2h4cUwvTWhoU2laWk95aFM3SHlq?=
 =?utf-8?B?czdkK2VQbGFiSElBeUV1Mi95K1pTeUx3Q2pJOGFaNUxRZ2lDS0NDaW1NUklj?=
 =?utf-8?B?bUFFUEIvQUFpNGEvK1ZyNGJRUXFPczlReFBJWVlxT29PZ0x5YXExUFVlMUU1?=
 =?utf-8?B?NGxvUU1GY05udm5WVU9NdHg0VUZoNVlZMUFkU3VCWWJuVGhNRWw4Vm5pM3VW?=
 =?utf-8?B?anJyUlk3Y25QbWRrMnNiZ0dTYitLRzk2UXM5SmNrbzdKNENZKzZSMFBTazFE?=
 =?utf-8?B?dG9KTEVoQjRKVGticXJ5K2JqclJqNy9TcFRLNXRUSDU3VkJUZVVQZTRqVGps?=
 =?utf-8?Q?tF55bCszTL8bqH6GRnvRIS3T9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f735c6-4ed7-4f7c-368f-08dcc2bf40cb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 15:29:46.2569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HcnUW2pNSSSieBPGUhNZNE6T8cmMk4Io9K/UVhjiH48uXLLWrzOZaZpLZHTFq8aORxRY7QM51VNo3zEXFccEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8404

On 8/15/2024 14:07, Esther Shimanovich wrote:
> Some computers with CPUs that lack Thunderbolt features use discrete
> Thunderbolt chips to add Thunderbolt functionality. These Thunderbolt
> chips are located within the chassis; between the root port labeled
> ExternalFacingPort and the USB-C port.
> 
> These Thunderbolt PCIe devices should be labeled as fixed and trusted,
> as they are built into the computer. Otherwise, security policies that
> rely on those flags may have unintended results, such as preventing
> USB-C ports from enumerating.
> 
> Detect the above scenario through the process of elimination.
> 
> 1) Integrated Thunderbolt host controllers already have Thunderbolt
>     implemented, so anything outside their external facing root port is
>     removable and untrusted.
> 
>     Detect them using the following properties:
> 
>       - Most integrated host controllers have the usb4-host-interface
>         ACPI property, as described here:
> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers
> 
>       - Integrated Thunderbolt PCIe root ports before Alder Lake do not
>         have the usb4-host-interface ACPI property. Identify those with
>         their PCI IDs instead.
> 
> 2) If a root port does not have integrated Thunderbolt capabilities, but
>     has the ExternalFacingPort ACPI property, that means the manufacturer
>     has opted to use a discrete Thunderbolt host controller that is
>     built into the computer.
> 
>     This host controller can be identified by virtue of being located
>     directly below an external-facing root port that lacks integrated
>     Thunderbolt. Label it as trusted and fixed.
> 
>     Everything downstream from it is untrusted and removable.
> 
> The ExternalFacingPort ACPI property is described here:
> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports
> 
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> While working with devices that have discrete Thunderbolt chips, I
> noticed that their internal TBT chips are inaccurately labeled as
> untrusted and removable.
> 
> I've observed that this issue impacts all computers with internal,
> discrete Intel JHL Thunderbolt chips, such as JHL6240, JHL6340, JHL6540,
> and JHL7540, across multiple device manufacturers such as Lenovo, Dell,
> and HP.
> 
> This affects the execution of any downstream security policy that
> relies on the "untrusted" or "removable" flags.
> 
> I initially submitted a quirk to resolve this, which was too small in
> scope, and after some discussion, Mika proposed a more thorough fix:
> https://lore.kernel.org/lkml/20240510052616.GC4162345@black.fi.intel.com
> I refactored it and am submitting as a new patch.

My apologies on my delayed response, I've been OOO a while.

I had a test with this patch on an AMD Phoenix system on top of 
6.11-rc4.  I am noticing that with it, it's now flagging an internal PCI 
host bridge as untrusted.  I added some extra debugging and it falls 
through to the last case of pcie_is_tunneled() where it returns true.

Here is the topology of the system:

-[0000:00]-+-00.0
            +-00.2
            +-01.0
            +-01.3-[01]----00.0
            +-02.0
            +-02.1-[02]----00.0
            +-02.4-[03]----00.0
            +-03.0
            +-03.1-[04-62]--
            +-04.0
            +-04.1-[63-c1]--
            +-08.0
            +-08.1-[c2]--+-00.0
            |            +-00.1
            |            +-00.2
            |            +-00.3
            |            +-00.4
            |            +-00.5
            |            +-00.6
            |            \-00.7
            +-08.2-[c3]--+-00.0
            |            \-00.1
            +-08.3-[c4]--+-00.0
            |            +-00.3
            |            +-00.4
            |            +-00.5
            |            \-00.6
            +-14.0
            +-14.3
            +-18.0
            +-18.1
            +-18.2
            +-18.3
            +-18.4
            +-18.5
            +-18.6
            \-18.7

Here are the details of all devices on the system:

00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:14e8]
00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Device [1022:14e9]
00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:14ea]
00:01.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:14ee]
00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:14ea]
00:02.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:14ee]
00:02.4 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:14ee]
00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:14ea]
00:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 19h 
USB4/Thunderbolt PCIe tunnel [1022:14ef]
00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:14ea]
00:04.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 19h 
USB4/Thunderbolt PCIe tunnel [1022:14ef]
00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:14ea]
00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:14eb]
00:08.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:14eb]
00:08.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:14eb]
00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus 
Controller [1022:790b] (rev 71)
00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC 
Bridge [1022:790e] (rev 51)
00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:14f0]
00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:14f1]
00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:14f2]
00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:14f3]
00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:14f4]
00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:14f5]
00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:14f6]
00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:14f7]
01:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. 
RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller 
[10ec:8168] (rev 1c)
02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5261 
PCI Express Card Reader [10ec:5261] (rev 01)
03:00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co 
Ltd NVMe SSD Controller PM9A1/PM9A3/980PRO [144d:a80a]
c2:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. 
[AMD/ATI] Phoenix1 [1002:15bf] (rev 03)
c2:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] 
Rembrandt Radeon High Definition Audio Controller [1002:1640]
c2:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] 
Family 19h (Model 74h) CCP/PSP 3.0 Device [1022:15c7]
c2:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:15b9]
c2:00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:15ba]
c2:00.5 Multimedia controller [0480]: Advanced Micro Devices, Inc. [AMD] 
ACP/ACP3X/ACP6x Audio Coprocessor [1022:15e2] (rev 63)
c2:00.6 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] Family 
17h/19h HD Audio Controller [1022:15e3]
c2:00.7 Signal processing controller [1180]: Advanced Micro Devices, 
Inc. [AMD] Device [1022:164a]
c3:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, 
Inc. [AMD] Device [1022:14ec]
c3:00.1 Signal processing controller [1180]: Advanced Micro Devices, 
Inc. [AMD] AMD IPU Device [1022:1502]
c4:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, 
Inc. [AMD] Device [1022:14ec]
c4:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:15c0]
c4:00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:15c1]
c4:00.5 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Pink 
Sardine USB4/Thunderbolt NHI controller #1 [1022:1668]
c4:00.6 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Pink 
Sardine USB4/Thunderbolt NHI controller #2 [1022:1669]

Here's the snippet from the kernel log with the patch in place.  You can 
see it flagged 00:02.0 as untrusted and removable, but it definitely isn't.

Aug 22 10:11:10 test-TBI1100B kernel: pci_bus 0000:02: scanning bus
Aug 22 10:11:10 test-TBI1100B kernel: pci 0000:02:00.0: marking as untrusted
Aug 22 10:11:10 test-TBI1100B kernel: pci 0000:02:00.0: marking as removable
Aug 22 10:11:10 test-TBI1100B kernel: pci 0000:02:00.0: [10ec:5261] type 
00 class 0xff0000 PCIe Endpoint
Aug 22 10:11:10 test-TBI1100B kernel: pci 0000:02:00.0: BAR 0 [mem 
0xb0c00000-0xb0c00fff]
Aug 22 10:11:10 test-TBI1100B kernel: pci 0000:02:00.0: supports D1 D2
Aug 22 10:11:10 test-TBI1100B kernel: pci 0000:02:00.0: PME# supported 
from D1 D2 D3hot D3cold
Aug 22 10:11:10 test-TBI1100B kernel: pci_bus 0000:02: fixups for bus
Aug 22 10:11:10 test-TBI1100B kernel: pci 0000:00:02.1: PCI bridge to 
[bus 02]
Aug 22 10:11:10 test-TBI1100B kernel: pci_bus 0000:02: bus scan 
returning with max=02

I wonder if you want another case for pcie_switch_directly_under() of 
PCI_EXP_TYPE_PCIE_BRIDGE to help this perhaps?

> ---
> Changes in v3:
> - Incorporated minor edits suggested by Mika Westerberg.
> - Mika Westerberg tested patch (more details in v2 link)
> - Added "reviewed-by" and "tested-by" lines
> - Link to v2: https://lore.kernel.org/r/20240808-trust-tbt-fix-v2-1-2e34a05a9186@chromium.org
> 
> Changes in v2:
> - I clarified some comments, and made minor fixins
> - I also added a more detailed description of implementation into the
>    commit message
> - Added Cc recipients Mike recommended
> - Link to v1: https://lore.kernel.org/r/20240806-trust-tbt-fix-v1-1-73ae5f446d5a@chromium.org
> ---
>   drivers/pci/probe.c | 153 +++++++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 146 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b14b9876c030..308d5a0e5c51 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1629,25 +1629,160 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>   		dev->is_thunderbolt = 1;
>   }
>   
> +/*
> + * Checks if pdev is part of a PCIe switch that is directly below the
> + * specified bridge.
> + */
> +static bool pcie_switch_directly_under(struct pci_dev *bridge,
> +				       struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent = pci_upstream_bridge(pdev);
> +
> +	/* If the device doesn't have a parent, it's not under anything.*/
> +	if (!parent)
> +		return false;
> +
> +	/*
> +	 * If the device has a PCIe type, check if it is below the
> +	 * corresponding PCIe switch components (if applicable). Then check
> +	 * if its upstream port is directly beneath the specified bridge.
> +	 */
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_UPSTREAM:
> +		if (parent == bridge)
> +			return true;
> +		break;
> +
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
> +			parent = pci_upstream_bridge(parent);
> +			if (parent == bridge)
> +				return true;
> +		}
> +		break;
> +
> +	case PCI_EXP_TYPE_ENDPOINT:
> +		if (pci_pcie_type(parent) == PCI_EXP_TYPE_DOWNSTREAM) {
> +			parent = pci_upstream_bridge(parent);
> +			if (parent && pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
> +				parent = pci_upstream_bridge(parent);
> +				if (parent == bridge)
> +					return true;
> +			}
> +		}
> +		break;
> +	}
> +
> +	return false;
> +}
> +
> +static bool pcie_has_usb4_host_interface(struct pci_dev *pdev)
> +{
> +	struct fwnode_handle *fwnode;
> +
> +	/*
> +	 * For USB4, the tunneled PCIe root or downstream ports are marked
> +	 * with the "usb4-host-interface" ACPI property, so we look for
> +	 * that first. This should cover most cases.
> +	 */
> +	fwnode = fwnode_find_reference(dev_fwnode(&pdev->dev),
> +				       "usb4-host-interface", 0);
> +	if (!IS_ERR(fwnode)) {
> +		fwnode_handle_put(fwnode);
> +		return true;
> +	}
> +
> +	/*
> +	 * Any integrated Thunderbolt 3/4 PCIe root ports from Intel
> +	 * before Alder Lake do not have the "usb4-host-interface"
> +	 * property so we use their PCI IDs instead. All these are
> +	 * tunneled. This list is not expected to grow.
> +	 */
> +	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
> +		switch (pdev->device) {
> +		/* Ice Lake Thunderbolt 3 PCIe Root Ports */
> +		case 0x8a1d:
> +		case 0x8a1f:
> +		case 0x8a21:
> +		case 0x8a23:
> +		/* Tiger Lake-LP Thunderbolt 4 PCIe Root Ports */
> +		case 0x9a23:
> +		case 0x9a25:
> +		case 0x9a27:
> +		case 0x9a29:
> +		/* Tiger Lake-H Thunderbolt 4 PCIe Root Ports */
> +		case 0x9a2b:
> +		case 0x9a2d:
> +		case 0x9a2f:
> +		case 0x9a31:
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +static bool pcie_is_tunneled(struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent, *root;
> +
> +	parent = pci_upstream_bridge(pdev);
> +	/* If pdev doesn't have a parent, then there's no way it is tunneled.*/
> +	if (!parent)
> +		return false;
> +
> +	root = pcie_find_root_port(pdev);
> +	/* If pdev doesn't have a root, then there's no way it is tunneled.*/
> +	if (!root)
> +		return false;
> +
> +	/* Internal PCIe devices are not tunneled. */
> +	if (!root->external_facing)
> +		return false;
> +
> +	/* Anything directly behind a "usb4-host-interface" is tunneled. */
> +	if (pcie_has_usb4_host_interface(parent))
> +		return true;
> +
> +	/*
> +	 * Check if this is a discrete Thunderbolt/USB4 controller that is
> +	 * directly behind the non-USB4 PCIe Root Port marked as
> +	 * "ExternalFacingPort". Those are not behind a PCIe tunnel.
> +	 */
> +	if (pcie_switch_directly_under(root, pdev))
> +		return false;
> +
> +	/* PCIe devices after the discrete chip are tunneled. */
> +	return true;
> +}
> +
>   static void set_pcie_untrusted(struct pci_dev *dev)
>   {
> -	struct pci_dev *parent;
> +	struct pci_dev *parent = pci_upstream_bridge(dev);
>   
> +	if (!parent)
> +		return;
>   	/*
> -	 * If the upstream bridge is untrusted we treat this device
> +	 * If the upstream bridge is untrusted we treat this device as
>   	 * untrusted as well.
>   	 */
> -	parent = pci_upstream_bridge(dev);
> -	if (parent && (parent->untrusted || parent->external_facing))
> +	if (parent->untrusted)
>   		dev->untrusted = true;
> +
> +	if (pcie_is_tunneled(dev)) {
> +		pci_dbg(dev, "marking as untrusted\n");
> +		dev->untrusted = true;
> +	}
>   }
>   
>   static void pci_set_removable(struct pci_dev *dev)
>   {
>   	struct pci_dev *parent = pci_upstream_bridge(dev);
>   
> +	if (!parent)
> +		return;
>   	/*
> -	 * We (only) consider everything downstream from an external_facing
> +	 * We (only) consider everything tunneled below an external_facing
>   	 * device to be removable by the user. We're mainly concerned with
>   	 * consumer platforms with user accessible thunderbolt ports that are
>   	 * vulnerable to DMA attacks, and we expect those ports to be marked by
> @@ -1657,9 +1792,13 @@ static void pci_set_removable(struct pci_dev *dev)
>   	 * accessible to user / may not be removed by end user, and thus not
>   	 * exposed as "removable" to userspace.
>   	 */
> -	if (parent &&
> -	    (parent->external_facing || dev_is_removable(&parent->dev)))
> +	if (dev_is_removable(&parent->dev))
> +		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> +
> +	if (pcie_is_tunneled(dev)) {
> +		pci_dbg(dev, "marking as removable\n");
>   		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> +	}
>   }
>   
>   /**
> 
> ---
> base-commit: 3f386cb8ee9f04ff4be164ca7a1d0ef3f81f7374
> change-id: 20240806-trust-tbt-fix-5f337fd9ec8a
> 
> Best regards,


