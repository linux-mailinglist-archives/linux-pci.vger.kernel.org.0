Return-Path: <linux-pci+bounces-35297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4267B3F1E4
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 03:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6FB4814B1
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 01:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C9A2DECBF;
	Tue,  2 Sep 2025 01:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RxqTDxwO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A704D2DF142
	for <linux-pci@vger.kernel.org>; Tue,  2 Sep 2025 01:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756776587; cv=fail; b=a3wxqy1df/pVX8FG2R6tGJg7R6TLPbjhzTPu91OCXlcieut277W2qbwoYA+dTmrU/8iET+KuE6o1htMk6JYo7RCYvEDNJRQr6r1njrUC65sYL0WPdh/yanYermKF5NoBSRuLNtA67apt8LgHmYnMAD21CKspOxPGaMTOB4HLNBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756776587; c=relaxed/simple;
	bh=QR71TqTO1YGrJfHiaz452tLi3eX6W7Gn6ha2Z9GxjrE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dX1kQA7K1lqyXk+v1KwkDY+VcOXPHr1twAzv3nkGN77u/J+FVXJOAT7LhxDSrNAi2t4oMI6nBhgcU3axLX5DMI9zUd263VpkUWi02dYW/5mFoDzPtX1Umamv1/FhPKof4vynofhtOg2NLkn9PUUXzEaR/nyAeDAGtoKBPl7RYmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RxqTDxwO; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfFgNABBXfMb3w7lE0H9uib2jKZIzmyWb2QPQ4WIFFdQp0C17cOnbWUZDCt9eeRoHpu66IFGNVsW3+3aQp+f6O2QtI43xFi81/hwRnfn0BQAVr1gyc1haOE6lpgE5gh+OKdqgQ5hB/wGmttLSH+47of7PXeTcvBFc8sQw3YVjSlHelOv5OANpnpj3/p5UcC9Mu+9VEP6Ba2+osSrkv1YMH0EKtAajJFM6sp8z7JR3jKzuRlRcRnCtfsCwtap6YjMPhQ6DtQQb/sWYlFHcnhvnfQ8D8AQr1sGuM0tW+fPcbom2IpGvwVE0nSb4rKOxzsmVH6Z/PT8S6uTB7QxchCJOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrkJqQ4U4hgOVFLTywhTZVwXy/jI0Lm9cn5yw4SKXPc=;
 b=HsSVa7UbbMglW+7IRry/vwD6bww/Ft5p9hDn2Z9atj/pJRgGXkHLllTXEu3ZutU2SFwqr7VMjHpOkFwfMLCsu9ItA/wbwYYwji5eSASpkbsui2by86EOsYb1r3AuBExWnZfoIeLAolAndtIpVp7Hs5xWjZ9DNWahhOwuzrQiyNxNlpJw5ms3gutwqLEqYih8HwD247vDQXgREZsdQ3HbwmPaCVMm1x2UEhOU74vBAuImixS1SeDJunDOnZ74sEeUuw7i53ihEZSOIn87LLbnrJc9OnPb81xC51FL+xLuDUpGRqHJVEZ3AB9MyK81DvS7KljCDnU5sBRAxTo2/7JL9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrkJqQ4U4hgOVFLTywhTZVwXy/jI0Lm9cn5yw4SKXPc=;
 b=RxqTDxwOMS7Pr8JK6BlGX2MvTCrdHiI6T5yZmOkTHibu1vpNlS/WhJ5RtsMtAZGkNmBa/AiJyOidfBqFqEUsWXJV9p1G38UlKzQSiywC6f47wcj5ksGhDHeieCzXa5U5cmniyOkxqw5yWz7zyNCH1UgCHJ+uOs9fG7qMcOSGu5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20)
 by CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 01:29:41 +0000
Received: from LV3PR12MB9213.namprd12.prod.outlook.com
 ([fe80::dcd3:4b39:8a3a:869a]) by LV3PR12MB9213.namprd12.prod.outlook.com
 ([fe80::dcd3:4b39:8a3a:869a%6]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 01:29:41 +0000
Message-ID: <eeca3820-01dd-4abc-a437-cf46dc718ab6@amd.com>
Date: Tue, 2 Sep 2025 11:29:35 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 07/10] PCI/IDE: Add IDE establishment helpers
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aneesh.kumar@kernel.org,
 gregkh@linuxfoundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-8-dan.j.williams@intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20250827035126.1356683-8-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYCP282CA0014.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::26) To LV3PR12MB9213.namprd12.prod.outlook.com
 (2603:10b6:408:1a6::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9213:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f2ed03-c5ae-4623-07f0-08dde9c0302d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djZCSkR3S0FxQmluMWhRdi9tWG1Jdzl1RG1NbmpwbHh0S3M0SXVPOStRRzVq?=
 =?utf-8?B?K0N5NkFxSkgwQm11RjZjSnl3T3FnSUdpQnpuckJxRDllZ1NUK2J2R0FWOEQ1?=
 =?utf-8?B?eW5HNzF0WG9tODZ4aVdlQThtZkYxdEJ0bGxSZnZpQk85MVp0bUZYRHhjMGtn?=
 =?utf-8?B?WVdudzE3U1Qyc0JBZVFKMWwxNVAyN2dGSkQzZGdVRWZKQ1ZSMkRpL21yb0o4?=
 =?utf-8?B?NUd0RjVpbldGNkJxelZxYzJieHVORlFtQzNkUTZnbGc4QkNvQ0tUUTVTazJF?=
 =?utf-8?B?eWhaZmwxV00wRS9hYnJPMldrZ2V4UWRUbVJiL0xPRTV2d0k1UFh2Q1Y3cXRV?=
 =?utf-8?B?K2w5OXBrVXpteHJ1aDBYaUZuNDg1WUNYNGpqbTVpQ1VBV0gzVVp5QXk0YzFW?=
 =?utf-8?B?TnFWWEFnbHJFUi9OZFR1U2szZUlnY3lXS1VoSzAxaHBrcUtBQ0lrL0doR3Ex?=
 =?utf-8?B?bVAxNVBqMjl6UVlJYUlSVzJUWTFKUkdqTklQdi9FR2gvTHZodXI4VHB4VmJS?=
 =?utf-8?B?aEs1cS93VEhTYjlqb1lJVnUyb2NVb0tnOSs2KzYwTTA0M0R2UWdMN210NGNs?=
 =?utf-8?B?SWR2UmdZang5RHQxZmlpNHNpVDdvQWc3WUVGSngrUlhmMnA5UElRWENWU1Vn?=
 =?utf-8?B?LzVrUkw4V1Q5WnA2Tnhmem5aVDRDZ2hZNTVDbFlTdU03SlJ6ck0reXdsUGJu?=
 =?utf-8?B?cEFpR3hieWpaTHQ5eGZMYWFPMEUyeUlVa3pSdU14TEc4cGd6T3VWTk1KWHRY?=
 =?utf-8?B?VWpUc1FMcGhKNDJzOHkwMVFCbkhsdm9pclV4Y3A3RllLZGo1NVFVaTJGRVNM?=
 =?utf-8?B?VCtJUkJ6VTVyWWpJYWtQYkdaaGhReDAxNmxCT0syRHNWK1lQd2tLRVdtTzli?=
 =?utf-8?B?NkdtMUlDWUQzSEhFVDJ6V2wzcHdWeW1MWlhtcWRKQzRQbnd1RTVkbnRSUWdo?=
 =?utf-8?B?OVpUY1I3aXd4THRXMkFYa1FmWU9xaVNTUGs3Wkc3YitYRDloMzRFUXdsbkd0?=
 =?utf-8?B?Q0hCSk1Uek9IT3BSSFkvckE2NjRpeEw0Z2c3MGRqbDRQbFIwOGVKMTVYRWRp?=
 =?utf-8?B?eE14SW1WZTVBQXgvcWhERGVXTEtJaU9kQkNQREVVTE1SSTJraXdMaDlORjVH?=
 =?utf-8?B?bkpRQjVWMGFpaWRhMGg2MTJ3bFJCbmJoNUVmbzhKb0VrQ0RLTjVYOGhBZmtG?=
 =?utf-8?B?VU95cVlJU0lEdU0yQlM5b3dNOWxOYkw2VFptZE11ZjJtbTRjVkttaWgxcmhN?=
 =?utf-8?B?MGxnRmhpdE1DMHJpOEtsUXpvVEQ1TDBRRnNhMjZrbHl5Zkt0R2FOZVRoRWhQ?=
 =?utf-8?B?cllWMUFITFBDeWdZR1pxMjU0Z1dwZHF5dlNPVWljYzZheFRDZEQreXNCWGJr?=
 =?utf-8?B?NXNHdlBFcE9aRmZwMzJtcThzMHhNOW8zUkZtMGlQZzk2OHJCT3dtS1o4ZjdP?=
 =?utf-8?B?SUJkU3gzTVlIK09xUFJjQS9RbHlDNE5mSjFpNzU5dnJZWEJZZlJxQ2hnQ2lJ?=
 =?utf-8?B?NDRLRGd5VXI0SzZIclNJRm1VNkMrV3BZVEJjcmZ4aE56MnE0cHdVY1FrcmNo?=
 =?utf-8?B?SFVwdzAwUk05bkw3RnBQWWF5RUV1YkxpWE1MNjBUclA4TTVncnhWT3B0YU1Z?=
 =?utf-8?B?NW1aZmY3Vys3Zy9HT09oUFdkRHphbFZRcFM4V29Ganl5UzVWcHVhTTZ5Z1RS?=
 =?utf-8?B?QkVTVkhOdHRDNXR5dWJRaDZMQTh3YWhNdkVmVTVaTmtVMFU4M1dFS2U0RUZz?=
 =?utf-8?B?YlVXVW8zLzlEMVVocERUSUprM280dkJmdGdlZ1YwR2VXMmdRQVFUM2R1eUxE?=
 =?utf-8?B?eUEyK0dFRHk1aHlRR1p6TktsRkVic29oZFFEOHJEMFpjSE5jSER5bWtpL1pQ?=
 =?utf-8?B?blBsbGlYcGVDUEkraVQ2ZWZRWlVEdGFjYTZYTGdtd28ySGpuWG1FMVBKemhB?=
 =?utf-8?Q?9ckriI45t5A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9213.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzZpb1JLbkdEUHBkc2xwSWlMcElqUGtxZHRNZ1dKOWZiZEo1Y0tRSkJhV0ND?=
 =?utf-8?B?UG9mdENrOCs5YlA4bG0wODJEQUJBRDdFbGJ2Q0dIazgzQzBEVVJITHZkKzR5?=
 =?utf-8?B?YWdWaDNJSXYxTG5ucDJWVzBpQzVHQWpDK3VqYTNrOFFtNjFhTGlKT1NMMCtX?=
 =?utf-8?B?cWdWb01jSFU5aiszdDdOODJ0VE1UWFd6ZWpLd3UwbXVHclJCVzhUOVl4SVhG?=
 =?utf-8?B?TjlOMVNLbXBpZm5UTVVveVJkdk5YemJJNjVURVhQRGpHYXl2WVhENGVaVENZ?=
 =?utf-8?B?OVl5RFVwZHlFVW0vNzM5ZmRmNG1rcEEzV0oxT2tEc1JYSGJxeUMramxaMzV6?=
 =?utf-8?B?b05LVlQ3ckFjTG4rNVFwbisxOEVJTEN0a2pPVXR4ZkdITGJ3S3Y4aldKNjEw?=
 =?utf-8?B?R1JsOWpYTjYvMEtGSjRPcjdDNzN4WExzak81Smg3K0lKT0kvZ1o5cWp4eHBq?=
 =?utf-8?B?KzR6OGFpRHIydmtnZFRLc2UrNTJZekFzdHNwUkZOQTJYMndrYzJzVTJraHZQ?=
 =?utf-8?B?K0NKMnJzZG1CV0xPVmZGbm9LVDY5V0NvV2lVNXo5Q3NCMmRyY3N4aDdHL1Nq?=
 =?utf-8?B?aFFrNE50eDhLbmYxSndvRkJvVkgydUkvYVJkTmpObytFRVluMHZzRGxNM0RG?=
 =?utf-8?B?SHVidmg2eW1RODk2cUQwK2tuVDV0c3dVWU9JVys0MXNPd0MwU0pMZ3VoZlda?=
 =?utf-8?B?UkJFd3dmWWc2YUxmcldTVmhoN29BbVdVTis0MXBIaUlNSzArZnAzcTNFWk9s?=
 =?utf-8?B?cVFWZTVqNEY2VnE1YUo0bmlCbEJkcGtQQWtvQzQrS1oxQkV6cU1KVUdRd1hs?=
 =?utf-8?B?Y3dMdUpwYk5KZ2pqSGdRd2N1QXF2b3J3dWZSWHQwUlg5c0tqQVdwS0JBMVZ4?=
 =?utf-8?B?cFlWR3pjV3ZnK0lsSG9xeXQvcDl0elJrZjRWVDRsQVlMOVNEeGh6ZEVrM2RE?=
 =?utf-8?B?dkJhVUNQZzJYTGNKY2lxT212aStwKzF1UTdqa2llYktPK1lsZHc1UERzOW00?=
 =?utf-8?B?emVTL0M5STIxWXJoLy9CM0Q5bW1nVndmMnVwSEE2dW00a1haZWhRYllJM0x2?=
 =?utf-8?B?T21vV2p6VVJCcDA2NmovZEZUYWdFUTZENkMwMmpISzY0bE16a2hvREhxUzdT?=
 =?utf-8?B?R2hkSXdNOEppTkdES3BCZnlNZHBPR2hvVXVCMEZqUFJkY3l1alRmRjFhdmFM?=
 =?utf-8?B?bnZiak5VWjFaQzkrY2VFNTF4OXNrRnl3YjAyZ2NxMVZvSTZkbzdmeUFCbURk?=
 =?utf-8?B?WXoraVNFWUxVb2RrK2R0OUhZQXhWZ0ljYWNIblc4VGNkSGp0R0d5djV2Rjhi?=
 =?utf-8?B?SFJ6MVQxYlVmOXpZK05hMUg0bGpHL3VEMlBjZjJaS3ZIWDVTemF6bHVnNTRx?=
 =?utf-8?B?V2ZEUkFIcldianptdWFJZzl6WEhtTGZvWUxHK3NrNUdML2lEWloxeVczNFJC?=
 =?utf-8?B?bHlXbGhURW1QOEVIYXROTDJPUUgrcUhCVjVzMG9UVmJxckFWT29QYlpFZC80?=
 =?utf-8?B?bHVoL1g5Mk1IdGxBNWtVd2xjY2pKbDRJRHpLN3V0Vk5EM3lGZ2pxWXBSbHVo?=
 =?utf-8?B?VHFMa25jNDZDOVBPMVZBRS8ya2RZS1BCdlZqSEZvTTRCbDZHZVlscGptejk0?=
 =?utf-8?B?eEZLbXZHMVU0RVBpRW1QODA5dmJYanhvc0Rnd0tkZlYvMFdTWXJsVyt3R1FW?=
 =?utf-8?B?YS9laCtnZWpwQWFkNXFIdzFYVUtyZFUvQXErSkdMdFN2c1VvSHZYVStsTE1o?=
 =?utf-8?B?NkVFNHVCQUZvNmJuQWlwa2ZTaXNUbE1uN1ZXU3hoUnlkWFl3SWRLMiswTTVD?=
 =?utf-8?B?cDNtalZiaTFSbVo2STNSblNsZGJYNHlycXdVbzJ3T3I3RW0vRFZkM2pMYklO?=
 =?utf-8?B?eWxnSzNYdGV1cGdnTnV4emhHcDJXZW5PNitaS3NIamVDeVZDTW9WU2xLSTJt?=
 =?utf-8?B?NTRpS2g2UDRYbW5aZkd0aVRnNVZrMTBXdlI0NDQ0SFRRLzZyTVZMR0p4c0w1?=
 =?utf-8?B?dHdmOUR3eVZOSkZoQ0UvbWp6SHVGcEhsV1FFTjA1R2JJa2Zwc0pBTDZoUGtj?=
 =?utf-8?B?VjFoYW9FSlJmKzJEYVZvVTZvbGVCT3l1UHVnWUZQVGcxaGxlTm1oc0tINnlD?=
 =?utf-8?Q?8oK1h4gnAoS7cVJqddqOnRABU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f2ed03-c5ae-4623-07f0-08dde9c0302d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9213.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 01:29:41.3049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqrsLqQkWi3mycT7HZLArwVN4/CzI70VyrDAxuHhskQiQFcSbcDW5BMxlUM+UQ2vM8sWaKOcKWZ0tM89+/RKyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279



On 27/8/25 13:51, Dan Williams wrote:
> There are two components to establishing an encrypted link, provisioning
> the stream in Partner Port config-space, and programming the keys into
> the link layer via IDE_KM (IDE Key Management). This new library,
> drivers/pci/ide.c, enables the former. IDE_KM, via a TSM low-level
> driver, is saved for later.
> 
> With the platform TSM implementations of SEV-TIO and TDX Connect in mind
> this library abstracts small differences in those implementations. For
> example, TDX Connect handles Root Port register setup while SEV-TIO
> expects System Software to update the Root Port registers. This is the
> rationale for fine-grained 'setup' + 'enable' verbs.
> 
> The other design detail for TSM-coordinated IDE establishment is that
> the TSM may manage allocation of Stream IDs, this is why the Stream ID
> value is passed in to pci_ide_stream_setup().
> 
> The flow is:
> 
> pci_ide_stream_alloc():
>      Allocate a Selective IDE Stream Register Block in each Partner Port
>      (Endpoint + Root Port), and reserve a host bridge / platform stream
>      slot. Gather Partner Port specific stream settings like Requester ID.
> 
> pci_ide_stream_register():
>      Publish the stream in sysfs after allocating a Stream ID. In the TSM
>      case the TSM allocates the Stream ID for the Partner Port pair.
> 
> pci_ide_stream_setup():
>      Program the stream settings to a Partner Port. Caller is responsible
>      for optionally calling this for the Root Port as well if the TSM
>      implementation requires it.
> 
> pci_ide_stream_enable():
>      Try to run the stream after IDE_KM.
> 
> In support of system administrators auditing where platform, Root Port,
> and Endpoint IDE stream resources are being spent, the allocated stream
> is reflected as a symlink from the host bridge to the endpoint with the
> name:
> 
>      stream%d.%d.%d
> 
> Where the tuple of integers reflects the allocated platform, Root Port,
> and Endpoint stream index (Selective IDE Stream Register Block) values.
> 
> Thanks to Wu Hao for a draft implementation of this infrastructure.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   .../ABI/testing/sysfs-devices-pci-host-bridge |  14 +
>   drivers/pci/ide.c                             | 427 ++++++++++++++++++
>   include/linux/pci-ide.h                       |  70 +++
>   include/linux/pci.h                           |   6 +
>   4 files changed, 517 insertions(+)
>   create mode 100644 include/linux/pci-ide.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> index 8c3a652799f1..2c66e5bb2bf8 100644
> --- a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> +++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> @@ -17,3 +17,17 @@ Description:
>   		PNP0A08 (/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00). See
>   		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
>   		format.
> +
> +What:		pciDDDD:BB/streamH.R.E
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		(RO) When a platform has established a secure connection, PCIe
> +		IDE, between two Partner Ports, this symlink appears. A stream
> +		consumes a Stream ID slot in each of the Host bridge (H), Root
> +		Port (R) and Endpoint (E).  The link points to the Endpoint PCI
> +		device in the Selective IDE Stream pairing. Specifically, "R"
> +		and "E" represent the assigned Selective IDE Stream Register
> +		Block in the Root Port and Endpoint, and "H" represents a
> +		platform specific pool of stream resources shared by the Root
> +		Ports in a host bridge. See /sys/devices/pciDDDD:BB entry for
> +		details about the DDDD:BB format.
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index 05ab8c18b768..4f5aa42e05ef 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -5,8 +5,12 @@
>   
>   #define dev_fmt(fmt) "PCI/IDE: " fmt
>   #include <linux/bitfield.h>
> +#include <linux/bitops.h>
>   #include <linux/pci.h>
> +#include <linux/pci-ide.h>
>   #include <linux/pci_regs.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
>   
>   #include "pci.h"
>   
> @@ -23,6 +27,13 @@ static int __sel_ide_offset(u16 ide_cap, u8 nr_link_ide, u8 stream_index,
>   	return offset + stream_index * PCI_IDE_SEL_BLOCK_SIZE(nr_ide_mem);
>   }
>   
> +static int sel_ide_offset(struct pci_dev *pdev,
> +			  struct pci_ide_partner *settings)
> +{
> +	return __sel_ide_offset(pdev->ide_cap, pdev->nr_link_ide,
> +				settings->stream_index, pdev->nr_ide_mem);
> +}
> +
>   void pci_ide_init(struct pci_dev *pdev)
>   {
>   	u8 nr_link_ide, nr_ide_mem, nr_streams;
> @@ -88,5 +99,421 @@ void pci_ide_init(struct pci_dev *pdev)
>   
>   	pdev->ide_cap = ide_cap;
>   	pdev->nr_link_ide = nr_link_ide;
> +	pdev->nr_sel_ide = nr_streams;
>   	pdev->nr_ide_mem = nr_ide_mem;
>   }
> +
> +struct stream_index {
> +	unsigned long *map;
> +	u8 max, stream_index;
> +};
> +
> +static void free_stream_index(struct stream_index *stream)
> +{
> +	clear_bit_unlock(stream->stream_index, stream->map);
> +}
> +
> +DEFINE_FREE(free_stream, struct stream_index *, if (_T) free_stream_index(_T))
> +static struct stream_index *alloc_stream_index(unsigned long *map, u8 max,
> +					       struct stream_index *stream)
> +{
> +	if (!max)
> +		return NULL;
> +
> +	do {
> +		u8 stream_index = find_first_zero_bit(map, max);
> +
> +		if (stream_index == max)
> +			return NULL;
> +		if (!test_and_set_bit_lock(stream_index, map)) {
> +			*stream = (struct stream_index) {
> +				.map = map,
> +				.max = max,
> +				.stream_index = stream_index,
> +			};
> +			return stream;
> +		}
> +		/* collided with another stream acquisition */
> +	} while (1);
> +}
> +
> +/**
> + * pci_ide_stream_alloc() - Reserve stream indices and probe for settings
> + * @pdev: IDE capable PCIe Endpoint Physical Function
> + *
> + * Retrieve the Requester ID range of @pdev for programming its Root
> + * Port IDE RID Association registers, and conversely retrieve the
> + * Requester ID of the Root Port for programming @pdev's IDE RID
> + * Association registers.
> + *
> + * Allocate a Selective IDE Stream Register Block instance per port.
> + *
> + * Allocate a platform stream resource from the associated host bridge.
> + * Retrieve stream association parameters for Requester ID range and
> + * address range restrictions for the stream.
> + */
> +struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
> +{
> +	/* EP, RP, + HB Stream allocation */
> +	struct stream_index __stream[PCI_IDE_HB + 1];
> +	struct pci_host_bridge *hb;
> +	struct pci_dev *rp;
> +	int num_vf, rid_end;
> +
> +	if (!pci_is_pcie(pdev))
> +		return NULL;
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> +		return NULL;
> +
> +	if (!pdev->ide_cap)
> +		return NULL;
> +
> +	/*
> +	 * Catch buggy PCI platform initialization (missing
> +	 * pci_ide_init_nr_streams())
> +	 */
> +	hb = pci_find_host_bridge(pdev->bus);
> +	if (WARN_ON_ONCE(!hb->nr_ide_streams))
> +		return NULL;
> +
> +	struct pci_ide *ide __free(kfree) = kzalloc(sizeof(*ide), GFP_KERNEL);
> +	if (!ide)
> +		return NULL;
> +
> +	struct stream_index *hb_stream __free(free_stream) = alloc_stream_index(
> +		hb->ide_stream_map, hb->nr_ide_streams, &__stream[PCI_IDE_HB]);
> +	if (!hb_stream)
> +		return NULL;
> +
> +	rp = pcie_find_root_port(pdev);
> +	struct stream_index *rp_stream __free(free_stream) = alloc_stream_index(
> +		rp->ide_stream_map, rp->nr_sel_ide, &__stream[PCI_IDE_RP]);
> +	if (!rp_stream)
> +		return NULL;
> +
> +	struct stream_index *ep_stream __free(free_stream) = alloc_stream_index(
> +		pdev->ide_stream_map, pdev->nr_sel_ide, &__stream[PCI_IDE_EP]);
> +	if (!ep_stream)
> +		return NULL;
> +
> +	/* for SR-IOV case, cover all VFs */
> +	num_vf = pci_num_vf(pdev);
> +	if (num_vf)
> +		rid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf),
> +				    pci_iov_virtfn_devfn(pdev, num_vf));
> +	else
> +		rid_end = pci_dev_id(pdev);
> +
> +	*ide = (struct pci_ide) {
> +		.pdev = pdev,
> +		.partner = {
> +			[PCI_IDE_EP] = {
> +				.rid_start = pci_dev_id(rp),
> +				.rid_end = pci_dev_id(rp),
> +				.stream_index = no_free_ptr(ep_stream)->stream_index,
> +			},
> +			[PCI_IDE_RP] = {
> +				.rid_start = pci_dev_id(pdev),
> +				.rid_end = rid_end,
> +				.stream_index = no_free_ptr(rp_stream)->stream_index,
> +			},
> +		},
> +		.host_bridge_stream = no_free_ptr(hb_stream)->stream_index,
> +		.stream_id = -1,
> +	};
> +
> +	return_ptr(ide);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_alloc);
> +
> +/**
> + * pci_ide_stream_free() - unwind pci_ide_stream_alloc()
> + * @ide: idle IDE settings descriptor
> + *
> + * Free all of the stream index (register block) allocations acquired by
> + * pci_ide_stream_alloc(). The stream represented by @ide is assumed to
> + * be unregistered and not instantiated in any device.
> + */
> +void pci_ide_stream_free(struct pci_ide *ide)
> +{
> +	struct pci_dev *pdev = ide->pdev;
> +	struct pci_dev *rp = pcie_find_root_port(pdev);
> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +
> +	clear_bit_unlock(ide->partner[PCI_IDE_EP].stream_index,
> +			 pdev->ide_stream_map);
> +	clear_bit_unlock(ide->partner[PCI_IDE_RP].stream_index,
> +			 rp->ide_stream_map);
> +	clear_bit_unlock(ide->host_bridge_stream, hb->ide_stream_map);
> +	kfree(ide);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_free);
> +
> +/**
> + * pci_ide_stream_release() - unwind and release an @ide context
> + * @ide: partially or fully registered IDE settings descriptor
> + *
> + * In support of automatic cleanup of IDE setup routines perform IDE
> + * teardown in expected reverse order of setup and with respect to which
> + * aspects of IDE setup have successfully completed.
> + *
> + * Be careful that setup order mirrors this shutdown order. Otherwise,
> + * open code releasing the IDE context.
> + */
> +void pci_ide_stream_release(struct pci_ide *ide)
> +{
> +	struct pci_dev *pdev = ide->pdev;
> +	struct pci_dev *rp = pcie_find_root_port(pdev);
> +
> +	if (ide->partner[PCI_IDE_RP].enable)
> +		pci_ide_stream_disable(rp, ide);
> +
> +	if (ide->partner[PCI_IDE_EP].enable)
> +		pci_ide_stream_disable(pdev, ide);
> +
> +	if (ide->partner[PCI_IDE_RP].setup)
> +		pci_ide_stream_teardown(rp, ide);
> +
> +	if (ide->partner[PCI_IDE_EP].setup)
> +		pci_ide_stream_teardown(pdev, ide);
> +
> +	if (ide->name)
> +		pci_ide_stream_unregister(ide);
> +
> +	pci_ide_stream_free(ide);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_release);
> +
> +/**
> + * pci_ide_stream_register() - Prepare to activate an IDE Stream
> + * @ide: IDE settings descriptor
> + *
> + * After a Stream ID has been acquired for @ide, record the presence of
> + * the stream in sysfs. The expectation is that @ide is immutable while
> + * registered.
> + */
> +int pci_ide_stream_register(struct pci_ide *ide)
> +{
> +	struct pci_dev *pdev = ide->pdev;
> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +	u8 ep_stream, rp_stream;
> +	int rc;
> +
> +	if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
> +		pci_err(pdev, "Setup fail: Invalid Stream ID: %d\n", ide->stream_id);
> +		return -ENXIO;
> +	}
> +
> +	ep_stream = ide->partner[PCI_IDE_EP].stream_index;
> +	rp_stream = ide->partner[PCI_IDE_RP].stream_index;
> +	const char *name __free(kfree) = kasprintf(GFP_KERNEL, "stream%d.%d.%d",
> +						   ide->host_bridge_stream,
> +						   rp_stream, ep_stream);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, name);
> +	if (rc)
> +		return rc;
> +
> +	ide->name = no_free_ptr(name);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_register);
> +
> +/**
> + * pci_ide_stream_unregister() - unwind pci_ide_stream_register()
> + * @ide: idle IDE settings descriptor
> + *
> + * In preparation for freeing @ide, remove sysfs enumeration for the
> + * stream.
> + */
> +void pci_ide_stream_unregister(struct pci_ide *ide)
> +{
> +	struct pci_dev *pdev = ide->pdev;
> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +
> +	sysfs_remove_link(&hb->dev.kobj, ide->name);
> +	kfree(ide->name);
> +	ide->name = NULL;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_unregister);
> +
> +static int pci_ide_domain(struct pci_dev *pdev)
> +{
> +	if (pdev->fm_enabled)
> +		return pci_domain_nr(pdev->bus);
> +	return 0;
> +}
> +
> +struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	if (!pci_is_pcie(pdev)) {
> +		pci_warn_once(pdev, "not a PCIe device\n");
> +		return NULL;
> +	}
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ENDPOINT:
> +		if (pdev != ide->pdev) {
> +			pci_warn_once(pdev, "setup expected Endpoint: %s\n", pci_name(ide->pdev));
> +			return NULL;
> +		}
> +		return &ide->partner[PCI_IDE_EP];
> +	case PCI_EXP_TYPE_ROOT_PORT: {
> +		struct pci_dev *rp = pcie_find_root_port(ide->pdev);
> +
> +		if (pdev != rp) {
> +			pci_warn_once(pdev, "setup expected Root Port: %s\n",
> +				      pci_name(rp));
> +			return NULL;
> +		}
> +		return &ide->partner[PCI_IDE_RP];
> +	}
> +	default:
> +		pci_warn_once(pdev, "invalid device type\n");
> +		return NULL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_to_settings);
> +
> +static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide, int pos,
> +			    bool enable)
> +{
> +	u32 val = FIELD_PREP(PCI_IDE_SEL_CTL_ID, ide->stream_id) |
> +		  FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, pdev->ide_cfg) |

There was:
FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1) |

and now it is gone, why? And it is not in any change log, took me a while to find out what broke.

Thanks,


> +		  FIELD_PREP(PCI_IDE_SEL_CTL_TEE_LIMITED, pdev->ide_tee_limit) |
> +		  FIELD_PREP(PCI_IDE_SEL_CTL_EN, enable);
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
> +}
> +
> +/**
> + * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered IDE settings descriptor
> + *
> + * When @pdev is a PCI_EXP_TYPE_ENDPOINT then the PCI_IDE_EP partner
> + * settings are written to @pdev's Selective IDE Stream register block,
> + * and when @pdev is a PCI_EXP_TYPE_ROOT_PORT, the PCI_IDE_RP settings
> + * are selected.
> + */
> +void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	int pos;
> +	u32 val;
> +
> +	if (!settings)
> +		return;
> +
> +	pos = sel_ide_offset(pdev, settings);
> +
> +	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT, settings->rid_end);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
> +
> +	val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
> +	      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, settings->rid_start) |
> +	      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG, pci_ide_domain(pdev));
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
> +
> +	/*
> +	 * Setup control register early for devices that expect
> +	 * stream_id is set during key programming.
> +	 */
> +	set_ide_sel_ctl(pdev, ide, pos, false);
> +	settings->setup = 1;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
> +
> +/**
> + * pci_ide_stream_teardown() - disable the stream and clear all settings
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered IDE settings descriptor
> + *
> + * For stream destruction, zero all registers that may have been written
> + * by pci_ide_stream_setup(). Consider pci_ide_stream_disable() to leave
> + * settings in place while temporarily disabling the stream.
> + */
> +void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	int pos;
> +
> +	if (!settings)
> +		return;
> +
> +	pos = sel_ide_offset(pdev, settings);
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, 0);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, 0);
> +	settings->setup = 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_teardown);
> +
> +/**
> + * pci_ide_stream_enable() - enable a Selective IDE Stream
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered and setup IDE settings descriptor
> + *
> + * Activate the stream by writing to the Selective IDE Stream Control
> + * Register.
> + *
> + * Return: 0 if the stream successfully entered the "secure" state, and -ENXIO
> + * otherwise.
> + *
> + * Note that the state may go "insecure" at any point after returning 0, but
> + * those events are equivalent to a "link down" event and handled via
> + * asynchronous error reporting.
> + */
> +int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	int pos;
> +	u32 val;
> +
> +	if (!settings)
> +		return -ENXIO;
> +
> +	pos = sel_ide_offset(pdev, settings);
> +
> +	set_ide_sel_ctl(pdev, ide, pos, true);
> +
> +	pci_read_config_dword(pdev, pos + PCI_IDE_SEL_STS, &val);
> +	if (FIELD_GET(PCI_IDE_SEL_STS_STATE, val) !=
> +	    PCI_IDE_SEL_STS_STATE_SECURE) {
> +		set_ide_sel_ctl(pdev, ide, pos, false);
> +		return -ENXIO;
> +	}
> +
> +	settings->enable = 1;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_enable);
> +
> +/**
> + * pci_ide_stream_disable() - disable a Selective IDE Stream
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered and setup IDE settings descriptor
> + *
> + * Clear the Selective IDE Stream Control Register, but leave all other
> + * registers untouched.
> + */
> +void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	int pos;
> +
> +	if (!settings)
> +		return;
> +
> +	pos = sel_ide_offset(pdev, settings);
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
> +	settings->enable = 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_disable);
> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> new file mode 100644
> index 000000000000..cf1f7a10e8e0
> --- /dev/null
> +++ b/include/linux/pci-ide.h
> @@ -0,0 +1,70 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +
> +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
> +
> +#ifndef __PCI_IDE_H__
> +#define __PCI_IDE_H__
> +
> +enum pci_ide_partner_select {
> +	PCI_IDE_EP,
> +	PCI_IDE_RP,
> +	PCI_IDE_PARTNER_MAX,
> +	/*
> +	 * In addition to the resources in each partner port the
> +	 * platform / host-bridge additionally has a Stream ID pool that
> +	 * it shares across root ports. Let pci_ide_stream_alloc() use
> +	 * the alloc_stream_index() helper as endpoints and root ports.
> +	 */
> +	PCI_IDE_HB = PCI_IDE_PARTNER_MAX,
> +};
> +
> +/**
> + * struct pci_ide_partner - Per port pair Selective IDE Stream settings
> + * @rid_start: Partner Port Requester ID range start
> + * @rid_start: Partner Port Requester ID range end
> + * @stream_index: Selective IDE Stream Register Block selection
> + * @setup: flag to track whether to run pci_ide_stream_teardown() for this
> + *	   partner slot
> + * @enable: flag whether to run pci_ide_stream_disable() for this partner slot
> + */
> +struct pci_ide_partner {
> +	u16 rid_start;
> +	u16 rid_end;
> +	u8 stream_index;
> +	unsigned int setup:1;
> +	unsigned int enable:1;
> +};
> +
> +/**
> + * struct pci_ide - PCIe Selective IDE Stream descriptor
> + * @pdev: PCIe Endpoint in the pci_ide_partner pair
> + * @partner: per-partner settings
> + * @host_bridge_stream: track platform Stream ID
> + * @stream_id: unique Stream ID (within Partner Port pairing)
> + * @name: name of the established Selective IDE Stream in sysfs
> + *
> + * Negative @stream_id values indicate "uninitialized" on the
> + * expectation that with TSM established IDE the TSM owns the stream_id
> + * allocation.
> + */
> +struct pci_ide {
> +	struct pci_dev *pdev;
> +	struct pci_ide_partner partner[PCI_IDE_PARTNER_MAX];
> +	u8 host_bridge_stream;
> +	int stream_id;
> +	const char *name;
> +};
> +
> +struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide);
> +struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev);
> +void pci_ide_stream_free(struct pci_ide *ide);
> +int  pci_ide_stream_register(struct pci_ide *ide);
> +void pci_ide_stream_unregister(struct pci_ide *ide);
> +void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide);
> +void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide);
> +int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide);
> +void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide);
> +void pci_ide_stream_release(struct pci_ide *ide);
> +DEFINE_FREE(pci_ide_stream_release, struct pci_ide *, if (_T) pci_ide_stream_release(_T))
> +#endif /* __PCI_IDE_H__ */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d3880a4f175e..45360ba87538 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -544,6 +544,8 @@ struct pci_dev {
>   	u16		ide_cap;	/* Link Integrity & Data Encryption */
>   	u8		nr_ide_mem;	/* Address association resources for streams */
>   	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
> +	u8		nr_sel_ide;	/* Selective Stream count (register block allocator) */
> +	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
>   	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
>   	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
>   #endif
> @@ -613,6 +615,10 @@ struct pci_host_bridge {
>   	int		domain_nr;
>   	struct list_head windows;	/* resource_entry */
>   	struct list_head dma_ranges;	/* dma ranges resource list */
> +#ifdef CONFIG_PCI_IDE
> +	u8 nr_ide_streams; /* Max streams possibly active in @ide_stream_map */
> +	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
> +#endif
>   	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>   	int (*map_irq)(const struct pci_dev *, u8, u8);
>   	void (*release_fn)(struct pci_host_bridge *);

-- 
Alexey


