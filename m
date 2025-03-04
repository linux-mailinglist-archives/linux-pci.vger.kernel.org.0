Return-Path: <linux-pci+bounces-22803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7459BA4D103
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 02:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029A83B0BA6
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 01:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1D613B29B;
	Tue,  4 Mar 2025 01:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jWyMqwMo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7EF1C68F
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 01:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051908; cv=fail; b=ptott2eduUvB0II2cr4q6tqkRmD+SEVO/NRGjwDI5ZhZ9kHZLaT1pWNyo5Pt/eeSJ0NGd2Ze2NJbYF5pvPW+2qfORY8xVolv8h3Zs19vLDtq16eew8ZClf6dIZFa+RsQ7ss0Q/7DAGxw3XE76At9sLd90lRNZWZn9eB+0ciFhlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051908; c=relaxed/simple;
	bh=odbiFUNXJUPmz7dcc1zellHJg8/s2ylEC9TgOkhB/uc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=INQqdjRRfZWVY1N0eHZWGI+zGpe3EllC0y+jTgn/XveDcxfhrrNbDvD4FhWmTdFmeWAHSwxj/IE1PoCp6MPASNgMMNxGxkEGh71CgOBwyOjf2GeMtRN0/BVGUh4urmWjCvKQkN0Q9oN9T7Fgr7J4CIpBka/e1MpGoPIky134bBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jWyMqwMo; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQaIowBdV6++sOaHzjz3MO3xyFlX9xk0szNpNeB1GhzMrfHaPS5THnb0fJxZZyplfdClWBjU7K5SwaPz5A4OQ8RJ0Cx/tjf3t3nLTSEYar2L1DWmlyw/cWW8+0aWo2+qAOR1MJgtfJ2qtaxX7casV4M/hhrTo9eXHCbwQNMV1ye3PW3vvb509Dz0raScgBDhSuSt+sFO6vSr21VDMBxhlH7rxmixpFfouOcIk1R+ZUUA9s+SYscxTpTuKUCxd2nN+k7xNeZziF1HARsWHY5ffKAdYFJRfSHU55EcBicrzQpiKxSuA8SR4XrMTsW33RLM+Ucn+qQWl00xOyaWcdIRiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiwwY4KfTWqsYMSN4IK8u3nEm7yVQ/5sbQhVY3oZS+0=;
 b=dS3ec5HpdXiNRfYIkFW18meUMovSiKfsMeOnCST4MyFEvuMAAPZdy72cMTorSnZNxyBIQc9aPr1teVeKdShDgKVw4jF9MBqJK6KaFfXkfaJaO8/cud23rBwfcW/v21DLpC9P+NoGH3EmqRwb4qwLbQOi2GD5OnLMp/OALQQ2wUvngVb8p0m7YsCyYIK8LVhWKmR3RnALtVqqBB2t8FYGmYJGLCeEdJu8O+qOahcigWn7TFs4oSC4tkf3kbs1ML1j28nSB7dp9D3JnICtdVnywLI7++Puf42Cqlv5p0mZvkwTQVTmGi5n0aoxHlotgMjrUv9MHlnOMrTt9djeMX6lPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiwwY4KfTWqsYMSN4IK8u3nEm7yVQ/5sbQhVY3oZS+0=;
 b=jWyMqwMosqDKMatYAOTRleiZmwwEjBLfn83xbccMw613738mmZN+b/N5SgPxHW3z8VYFcYpb1Xsr57H9X7sT1YHINF3T3zoWl5TXgacErPA7S8NeLFR1ZNnzlt8LBBUk56jk1HV53nYD+HqEIhfkJiFFffqEXwYRkabSb232Bsg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 01:31:44 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%3]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 01:31:44 +0000
Message-ID: <bd5d59bc-6a60-47fa-b7f3-da3272309740@amd.com>
Date: Tue, 4 Mar 2025 12:31:32 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>,
 Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-coco@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
 Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
References: <9f151a74-cc5c-4a7c-8304-1714159e4b2c@amd.com>
 <6d50f215-93c4-49a5-9ee2-f9775b740f92@amd.com>
 <Z32H2Tzd1UHCQEt5@yilunxu-OptiPlex-7050>
 <d71dd5c5-4c20-4e8e-abaa-fe2cdea4f3b2@amd.com>
 <Z4A/g5Yyu4Whncuu@yilunxu-OptiPlex-7050>
 <a11c82c3-b5fb-48d9-8c95-047ac4503dc6@amd.com>
 <67bd098f4dcd1_1a7729449@dwillia2-xfh.jf.intel.com.notmuch>
 <cf2f615d-2a28-45ec-8bb9-563c2a5bde73@amd.com>
 <67c11ed38ff8_1a7729458@dwillia2-xfh.jf.intel.com.notmuch>
 <8c091787-9275-40db-9167-af270dc5bb8e@amd.com>
 <67c6501494901_1a7f2941b@dwillia2-xfh.jf.intel.com.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <67c6501494901_1a7f2941b@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0036.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::15) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a2b44a-6343-48bd-7a82-08dd5abc527b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aE9kWE1Eck9qU1h6Y3UxWVlCUjFiMC9aNWJla0VCeThid0JZZHpLaFNqemdV?=
 =?utf-8?B?ZDEwRlF4MS8vUU9EaWdZdVpSUS9ldTVGUEZLQnpKdUNONExQamtiWlc1eU03?=
 =?utf-8?B?Y0NndDNwT29XK1FMSnlFKzJFZXpReFJzNDVSd05xblp1aDNzQ2x5RFNZbC9C?=
 =?utf-8?B?Y25BMkxnOUhtMDM5Nkg2SGQwSjB0dnBDL2d3S3JkbExrdUxDU0dUOFlUckxx?=
 =?utf-8?B?YkJWK2NLRzFYN1VNK0ZkQTdMYzZQVitUTHBNMEpUOUFWOWN0Q0lyWFFMZ1Ew?=
 =?utf-8?B?VHB2bEpIdmJ4b2tkNGdoWndmOEw2NXI4blZiOTB1WFphenFnUTVoaWg0b1l1?=
 =?utf-8?B?MzhMN3B2MFVQbTd6cmRVMHBnd1l0VUd4aFp4Umk3TXQvbGNYVDR6Ui92dVFx?=
 =?utf-8?B?WEdIYm8ycGMrQ3FLaXhFVkVSekVMaUlrd1d6V1BjTzlzNjhVcUhtTWNJQytn?=
 =?utf-8?B?cWdKYVk5MVBHdWlRWGFtVlNZQ1pYcExpajVvL1I5OXBNbUx2QmdaQmZMY3ZF?=
 =?utf-8?B?KzV5MFk3Q24rVFI5RnlCL1VHdGlZTVluZWhkU2JyYm44U3lWY0Y4ZWdmeFRr?=
 =?utf-8?B?eEErNVhYako3ZTRvSmlVSzA3eUFPWEZzNjRGS3NHc2tmZXlCUG11T1Rsb0Z4?=
 =?utf-8?B?WVRYZzFCSEtXdVUyOGxUNy93ZDdRR3A3NDV5L2dhODk4QWZ4NFZsN2FwTGJu?=
 =?utf-8?B?UXZta3N4cXVRZnBhZnBWNTdadExucEpCb1ZIQkVORXdaeWdQSm9vTThoV09l?=
 =?utf-8?B?a0QvVjN5aWdrd3NOKzBlc1Q4d2hOcWxpN2dDT1FOMVJyektscWhPSkg3RmFk?=
 =?utf-8?B?RmpXQTllMWw3TUViWDZ5K0JiTnE4MTkwQ2NaU0dOajk0RUU5OFhBb2pCekx5?=
 =?utf-8?B?c3NkcjNSZ3ZiOXhkejA0Zm5BOVo1eUgxMGt6VEtWRW5RRDZjTVY0dk1NQVZz?=
 =?utf-8?B?MTlmNWFFT3ZValpMbWlTdFZiRGNNZGlZazFnOC82SW5JTTh6WlZtWTBqUmFR?=
 =?utf-8?B?WlpadjN3K2JGNUcxdnp6MEUrNklmU3JiZEpLMkxkVVlGdVZxV1M0VEhaT2g0?=
 =?utf-8?B?L2tWc3kvOFRKOTZnbTN0NTNoRGhBUE9SN2gvZ1VyeFcwL2RSaDBCK0pXNklN?=
 =?utf-8?B?cENRUGE3d1dXak5GMEV2WFp3YzdBU2NvMkpsMjlmRmgzRGtUcmFTMXZhbjFK?=
 =?utf-8?B?SHF4YkUwMUpNZXd2RW5vUkVIN09WZUhNdkVITlpXV2ZFYmhROEE4Ynh3aTNF?=
 =?utf-8?B?MlQ1M3ZHN0Ezb2ZqN1BWSWRxZkZSRkNINFhxMjlBbmd5ay9ENGhmZXZYVlBI?=
 =?utf-8?B?TlVYcmtJRzVWcUNJL2V3ODRFTERIa2FKKzZjTWp3cXhjek1sNi95dXJvR3Zh?=
 =?utf-8?B?WVVvL05oSVZMQVRxM1A0em5KQVVEcWx5QzdqMS9jSi9jTElQRFRWbFZycFd3?=
 =?utf-8?B?RzZFa0N3ZXVid0sxNGV5M2hFSG5raXZDVmhWTlA1V3pha0l6U25ZRTEvL2ZM?=
 =?utf-8?B?aDRObzB1NHloSUlBaHk5VDhSZnlqeitkVTh2WE55VWdvdjVuMTNMQnVMcGgy?=
 =?utf-8?B?dWZTdy8zaEpTK0NBa0lPRmJZT3ladzVCTlo2MFoxNEw2UGhDQWxKd2dyUUJM?=
 =?utf-8?B?Um9jRngydlhiMU1WcGk0MFp4QzBsMS9JcFhaSUxhKzVPUm5aaEd3SEhlYWlW?=
 =?utf-8?B?V0ZiREpwZkNkcnhRZHRFdzM5M0czT1MzK2grREkrYUQ4aCthMFhZWTlzdnJO?=
 =?utf-8?B?NFVuTHhrSjdKUExhQ2xkcno5OTVBNXN0V01IdUJyYzkzejYzNDNxZDYza2lm?=
 =?utf-8?B?cjFreXhYdDFQdzJITnlFbWdLQnJleFNFUWw5S1U4SEJiVXd1L1RGTnRHNjlq?=
 =?utf-8?Q?dyAAHvDwRLzg5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDIrUmpRSHhpcHRYb21RSjcyZDRwQzNSNGhydWFnSHdTa01IWFdtT0ZXTWg3?=
 =?utf-8?B?ZGQyRm1FK2NHWW1SKzhDcnc4THUwejk3QkVqSmZFemUvS0w0YTNSOWxKQWdX?=
 =?utf-8?B?N1VHOUNnU0FwenRGVUlybmlPTzMxUDBzM3lzVCtrUVZMU2JaeVpibCtBUklI?=
 =?utf-8?B?czV6K1R0MDBHa0ZIZDF3UGNoQTJkbkxMK2d2aUF6bGFPYm4xTUJ5RVFleVRF?=
 =?utf-8?B?eUZVaUt3dnFyM29WbHVwYnZOeXdvQ1N3T2dKS3VQdVRTVE1TUlRlR0twVVVL?=
 =?utf-8?B?VTljN1d0Z25BQ1pvNVdSZ3RzMTNBY2N3YnQvRGhLN3l3ZGkxWlZXVVBHMWZv?=
 =?utf-8?B?SlVLSzNtUjRuVnR2eHhTYWE1NnppcFpiNGM2cjlQamlxRk9sREUwM1RJc3RS?=
 =?utf-8?B?YmRlcXlmMU4vOXBJUEdQZ3JQWFJyR0IzMlpUaXFzYW9EQmgrWnJTMjZlaGlz?=
 =?utf-8?B?eVlESVRJRm5vSnFKR1lnVElmclZOSncwS1hrU0s2TXlQOTQwYVlsWTM4dnJD?=
 =?utf-8?B?eTEwcERvbEd4RHoweUJ5Q1l0T095MWpKRlpSb2UwYzN4cWxyN1AvZnBiUVN0?=
 =?utf-8?B?VXRweENHMUtZL0pHa2VDQ3AzbDRidkNwWnRGV0YvaElBNEIvam1JTmF5L01U?=
 =?utf-8?B?QVZ1SjFFUzk3ZGtWZDMrSjlHSjNOcVpGZlBic1MwVkF5RmVZQk9MV3UzS2NB?=
 =?utf-8?B?OVBYQTFKaXBtM2FWRmRYWmc3U2hYTXQ4OFVldWcvTi9xWGg3Vm15aXRZOFlq?=
 =?utf-8?B?Rm5uZUJFK2ZZY2VNQkgxQ0RJdGZZcFRHSVV5R2dWQms3bFJiWU5XRlJqcmQ4?=
 =?utf-8?B?WlVtcXVId3U5NlRtdW1YK04waFRzTGR6VTJYRHJNQWx6bEtkK3B6MFBVRDlN?=
 =?utf-8?B?Y2ZNdTZmMFpDanl4VTNnb0U2bDUrSmwvSTRIMVVVdk5CSXBlUWVqcVF6bEFC?=
 =?utf-8?B?eVptQVFYZmNxeEFlSWxzeVNSaE1rejJiODFCTVZPdnNrL0tRcG5lY2ZYMVR6?=
 =?utf-8?B?Z1VjdkhyeGJEMDZOU0s4MTFDZjNTUGJMR0lUUWZ3UGdTenE5bDdtWjJnamNS?=
 =?utf-8?B?M3hzQ2hhbUliZ240a01UdHFCcVk2d01QR1RCVzU0NFQxeG91UTNKZk1mZktY?=
 =?utf-8?B?WGlKVTJBbTJuRVJaZGduSzhnd21hMUt5WXBKa2U4dHFIcjZ0T1ZnaStnZ3NQ?=
 =?utf-8?B?RUlJQ3Q0R0Z5MFhhdXN6MS82Z0lldmh2anNOVjdJV0xPUThGcXlpdTl1SUlY?=
 =?utf-8?B?Vm45bC8veXBrQzRvRmFUMUxBeEpZOU5MYnZEVExGdzdxOTNVTlVCWGJxQ2Mw?=
 =?utf-8?B?OFlheXpuN2QvcG03MVFhVzl4UzllRlkvbjFNelRrdWJacTY2RnlkNHJQQWtm?=
 =?utf-8?B?eGR0RW8zbGdZOGxSZEsvRytCckthd0JHYkVHOW44cTFDNVpEZHlHaE52b3d1?=
 =?utf-8?B?bjI1UWxZdTBQcnE3QjNobFg5RVoyNUk3RGNZU0diZjJxUlFnK2Fsb1dPNmZm?=
 =?utf-8?B?MGg2UytPS3pJRzRIUVJEYTlVTnJGYURDTTJFUUQrT1d2MFF4cTMveTRTOVEy?=
 =?utf-8?B?Nk94eTErZklYWnQvNk5uQnYrejFPazF0eFZPdEhEaFFoR2NQNUdYR21XTVNw?=
 =?utf-8?B?MnF6VkcyWVVuK1ZJeXowTyt1ZnhSNVRab0Z1UHNjT1VHMEd3TVF0MWdYTjNh?=
 =?utf-8?B?VjFMeCtIY2dxc3lycjZMTmV6QXl3ekZhTWEyeVpTSEZTaXliVHJoamVGNm9l?=
 =?utf-8?B?Q2pCQ0g0aHNXNVYrUzJZelQ3M2dweDZ2V1VsNDlqR2xEczlxRWR1c1NLTkZw?=
 =?utf-8?B?YXY1UHdvcG1aOXFLZVM4cmdRVEh6WmhkTllhSUFmeVRncmdpczJINlgyOTY0?=
 =?utf-8?B?QklxWGFWSUdZZjR2WjN0azg4djB1aUVvQnZ6R2p4UmEzRDhxaEswVEMrM1pU?=
 =?utf-8?B?dDEraVk2MHduMEZoY0cvUkpSYi8zdnBHSDV3K2hwc0pMclJ4Y0dQZmtTbWZy?=
 =?utf-8?B?bU5GeW1xdnRpTk04dEc1YkJDR05BbWxBeXh2aFN5eHN5eWF2UVhjTTVFS2NZ?=
 =?utf-8?B?RjFuNmJuM1dlWi9GL3JsSG9OYVIyOStzenpKbWppOExxWm5rb3pnVVc2dDVZ?=
 =?utf-8?Q?rNGg/23kaTtxVyYDccAFcXoV7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a2b44a-6343-48bd-7a82-08dd5abc527b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 01:31:44.3999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IcA8pnmVmUbw0xRn438msxJfsP7niWiWXHOpv1SmQK6BB12rR+3KjMmP0Vo2xSid9l8G+oLG1ad+IAlWgumbhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917



On 4/3/25 11:57, Dan Williams wrote:
> Alexey Kardashevskiy wrote:
> [..]
>>> Otherwise, at pci_ide_stream_setup() time I expect that the core would
>>> need to do something gross like check the incoming Stream ID and walk
>>> all idle streams to make sure they are not aliasing that ID.
>>
>> This is what PCIe spec suggests doing now imho.
> 
> Ok, I am about to send out v2, let's follow on to that with an
> implementation that simply sets all idle stream indexes to Stream ID
> 255. Then, catch cases where the low-level TSM driver tries to use ID
> 255. This is on the assumption that most implementations will allocate
> starting from zero.
> 
>>>>>> And then what are we doing to do when we start adding link streams? I
>>>>>> suggest decoupling pci_ide::stream_id from stream_id in sel_ide_offset()
>>>>>> (which is more like selective_stream_index) from the start.
>>>>>
>>>>> Setting aside that I agree with you that Stream index be separated from
>>>>> from Stream ID, what would motivate Linux to consider setting up Link
>>>>> Stream IDE?
>>>>>
>>>>> One of the operational criticisms of Link IDE is that it requires adding
>>>>> more points of failure into the TCB where a compromised switch can snoop
>>>>> traffic. It also adds more Keys and their associated maintainenace
>>>>> overhead. So, before we start planning ahead for Link IDE and Selective
>>>>> Stream IDE to co-exist in the implementation, I think we need a clear
>>>>> use case that demonstrates Link IDE is going to graduate from the
>>>>> specification into practical deployments.
>>>>
>>>> Probably for things like CXL which connect directly to the soc? I do not
>>>> really know, I only touch link streams because of that only device which
>>>> is like to see the light of the day though.
>>>
>>> CXL TSP is a wholly separate operation model and it expects that CXL
>>> devices, and more specifically CXL memory, are inside the TCB before the
>>> OS boots. So there is no current need for Linux to consider Link IDE for
>>> CXL.
>>
>> Link IDE or any IDE? I know very little about CXL but some of those
>> device types are not just simple fast memory but also do read/write
>> from/to that memory so they cannot rely on CPU memory encryption and IDE
>> makes sense for those (especially Link IDE as there are no bridges, or
>> are there?). Thanks,
> 
> So there are 2 use cases CXL.cache and CXL.mem, and of CXL.mem there is
> general memory expansion and accelerator memory. Most of the devices in
> the market and the sole focus of the CXL TSP (TEE Security Protocol)
> specification is how to get CXL.mem from general memory expansion
> devices (Type-3) into the TCB. From the spec:


(self educating now)
So CXL.io is not a thing, or not going to support TSP?
Wiki mentions IO registers and DMA, not relevant here why? Thanks,


> 
>      "This CXL security content scope focuses on features that are needed for
>       confidential computing utilizing CXL Type 3 memory expander devices"
> 
> The TSP definition specifies that CXL.mem memory is brought into the TCB
> by pre-OS software.
> 
> It goes on to say, "Transport security is optional for TSP", i.e. IDE is
> optional. If you have initiator based memory encryption then you do not
> also need encryption on the transport.
> 
> So, IDE is optional and any optional IDE establishment will be by pre-OS
> software. There is nothing I can see from CXL-land threatening to make
> the Linux IDE implementation care about Link IDE.


-- 
Alexey


