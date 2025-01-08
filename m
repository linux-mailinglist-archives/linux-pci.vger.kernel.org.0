Return-Path: <linux-pci+bounces-19485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2B5A050D8
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 03:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63469168B5C
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 02:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689D9185B6D;
	Wed,  8 Jan 2025 02:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c3Z/m+7+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B9017FAC2;
	Wed,  8 Jan 2025 02:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736303573; cv=fail; b=RHwwxAuSZaJKXe6xfqREfI0rGRwo6cP3DPuHPF7fjQwP17nXBRj6HI1O53BRSN5sRbKZriH6wQ+TZMFu9w1lUOcrINY699qEGQakUy3SRkDu5Tma4BFOKqFM6fSiYGLJuMxEXFZgBLSXGB7aaEogGZtG7J5bFSt22fgbThDRv+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736303573; c=relaxed/simple;
	bh=+teNtb2N3Gg2dvdOMfM+hV4muhO6eZnP8twX4i1Rbl0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XFBaknon0eTLmC2+By7a3nQmU9D06Y59UUqGMIexlwCiVfN8gUfrQWJWxboMbmuBiDnX7C/6Di7ttxumDeKT+gMgqg3qlXRUUuQ2k3Y0XhwjFzbc6vhuln4NzBINwXcaIhlA1U07iyWpjunEDOJAivzILeS0RYUghuTt4RXeloY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c3Z/m+7+; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1F4RxMj3hBbSfkPK8vPNjQurcPtfbYsBuLfaPog/btGngq6aGW+ERosIpFLn1338n4m2BF9yRBK52oFub7kngOLONOgjTKFB8RfsnsNgwPSl/w+hV3iddLGDVaIeuQ6arZP7NJQaX3kDjCeJyZRVyuuZs05StYJlt4nBAKYW4Jo+wiYcU/BEK3jdJkpKw0tRcaxgPaW62m0hnHwioC//1TK4T7AIOWS6NsWKDp5M3byiNo0CjDBr1+KwCijrym5yjbfgYXtVhn//gEy0CE2B3suJLIkq/uWNPo2wI5WDqQPS8fim20/Wnr+NCFDgTSVNHflSgAgfa1iVP3SJVYHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HVi4DovPBivfq/Fh49vY8QKUnINS5uZp3iQRKk1X1Y=;
 b=uO1yHoEAUMMW7WVmNMfrjui63qRiNXihWLwnCnR4/WKZXJpT+d5XZu185Sw9NGTZNk6Mwo9o2yRHYevzrAd1gtZDByYIWOCT6JsO7GI+rHZnL/XFAcFYDuWvyxQfAwa4WKk2jPMx+e/lN1rGB++BeFo3iIQI1+rnGR+MzDlfCisYCYiDfp1OeYVlutIwCuikPa7ra+2uCudLsx6SsESvi2bQYYaM/fLrbSy86vT5zWS7TyzwdJRQDxngZXfKxf1W0o0/i2e7MeWyBvt/ojf1ATJiIbWxdrt4pQnoxWUROqBq2rgiE7le6APLQ/YEIK5nWBXGwG8sOT6ibljuvLV6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HVi4DovPBivfq/Fh49vY8QKUnINS5uZp3iQRKk1X1Y=;
 b=c3Z/m+7+i8pR+E9DM3n1U2XwlPN8tbSAh3S3+jB8WMr9SXaFCsQrWn94C2zUct6Bfcr2mY+mW55l9jmYMYDb9bUc0ag8YVIaZeX4iP/3p1D1qeNzdUwGX0cmwSYr5FufppSk31+v6qi/wCq3ZzBhHXa5g/Q/PnQuBtZfP58A+OjpSDqtyLPtbWtC+wwaWt35hVmzOz83LbUFL4rm89JgR1cvWai4X3cUh1DlfcCSIoZi91YFh7pLnLM/o5hCgokUhxmz6wPRjsmmLzyjv6HqKToPDR7Ma+QcUkgaX3mwRY58oofkQrY8UusW8pXqasdg2GppuYrKiHEq2TCe/Lh3XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Wed, 8 Jan
 2025 02:32:45 +0000
Received: from PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a]) by PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a%6]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 02:32:44 +0000
Message-ID: <c9aeb7a0-5fef-49a5-9ebb-c0e7f3b0fd3e@nvidia.com>
Date: Tue, 7 Jan 2025 18:32:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PCI: Fix Extend ACS configurability
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: corbet@lwn.net, bhelgaas@google.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, vidyas@nvidia.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, vsethi@nvidia.com,
 sdonthineni@nvidia.com
References: <20241213202942.44585-1-tdave@nvidia.com>
 <20250102184009.GD5556@nvidia.com>
 <2676cf6e-d9eb-4a34-be5e-29824458f92f@nvidia.com>
 <20250107001015.GM5556@nvidia.com>
Content-Language: en-US
From: Tushar Dave <tdave@nvidia.com>
In-Reply-To: <20250107001015.GM5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:303:16d::35) To PH7PR12MB6657.namprd12.prod.outlook.com
 (2603:10b6:510:1fe::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6657:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eaed9e4-813f-40c1-75e6-08dd2f8cbb76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dklwTmNKdGJHdzVlMG1qN2pKNlVONFFpb2U5WW5TMFVMR3JkNTJzMjUyNFp1?=
 =?utf-8?B?ZEJDTzI5TnNLWDdpTUhobXFqa3J3T0hJd2d6MzNxMnhzZEtYdHIrWis3cVdM?=
 =?utf-8?B?NjBDNVg5Tlo0eVhQVVpYWVZBVzMwOUZtZ0RFVWRiQ1dBSUNvUEJ6TkcxQzk5?=
 =?utf-8?B?Y0lDeG5QLy9SNysrU2Y1TFIvMDVPanZGZG9JMzU1RE5rRzRscXl5WlludkY1?=
 =?utf-8?B?dnFoNENmTWIya2NBa1h0aDN2YWQzZzJob1c4MTdtNUNLOTFseDQ2R2gwaHU4?=
 =?utf-8?B?clRneTRQNFZZc1l6bDJsU0EvQms5SjlPUHZyZmcxWCtmNFJnV2c0bHNSdUYv?=
 =?utf-8?B?czhPelcvMkZoN3g1TTg4SVJ5RUlBYlN5cFJ5VWpLS1NEdFg2WlFmTXFnQWRI?=
 =?utf-8?B?MFZlNThqQ3hnamcxaGdnN2k1aEtSSG4zUjVFLzViZUdnem5zeWVOK05jWDdF?=
 =?utf-8?B?Z2EwajViRStCa1cxZlo2MGFwMW5jbnU4bmVkbnlCQ3hnOXppK3U5VEVlK1Fs?=
 =?utf-8?B?dk5SRjBxT1RzSzZiYnZ2azZUaUN3Vys2WE5xb3R5VVhNaEdNUnFWT0lFNm1t?=
 =?utf-8?B?a2ZSNy92eTVXOStHeEl3WnlFWE45UzRMOExPNVh6UW9taTFYS3FxUVRvbmw4?=
 =?utf-8?B?cS9kSjQ2aUdHa3o5ZEFsNm11VnV4Zng2S3RMMEVBckZjRWZQdS84YkhOaTBP?=
 =?utf-8?B?Nm10R2lDck14ZE0yTHE3dmNBVXZtbGl4Zk5Obk8reU5QZnFKaExzNVMzN21I?=
 =?utf-8?B?N3QybTlOS0lseU01UlF6WTA0aGordktISzRuME1RSExxUHFYdGlFUThuRE1J?=
 =?utf-8?B?ZndDL09yaHZqSmdmSXR0OW41eDdOeDRCNGlHUEltNTl0YnRYYnJlWE5Ba2Uw?=
 =?utf-8?B?V1d1aCszaUUwS3AxcnRzRzlnc2RObmdHOHJNeUZyTVJqdnNNOEdxckRLRlFD?=
 =?utf-8?B?b2FueFJuNHltVExTNElLYWdjcmUyeXB4MjhwVVBySGlhMHFESUIvenNHNGNV?=
 =?utf-8?B?SzRiUlZwRWd0T2lNUm1jVG05b1ZpTjRLbkFaVHY5amk1aHVnV0ROdm9vSVBO?=
 =?utf-8?B?WGJoMjJUUFFRa3p2SjFEVGFibU5qMDg5RUM3V0xNcSt2YzVXcWZ3eStpdFRx?=
 =?utf-8?B?eGx1aExSMTVhM2l4OTdYVVNTc0pIZmVZc0E1Vnc5d1I2ZXZ5b3piaVVIaWxj?=
 =?utf-8?B?eGxPdERwVUFtdGtPdFJwdmtyVGczWExCTHIzelpYSUNsbHN4cnRwZkpYSlN4?=
 =?utf-8?B?TTlaVHdHVUhDNWFwSGsrOTVtNHU2WGRuZW1xYkN4WXZFcThwZ0FkOWxNbkxX?=
 =?utf-8?B?UlNWMWxtSi9lYnlxQUhWSk5jR04vMlhIaDA0dDQzYTJyU2tVdjkvVWcwSlR0?=
 =?utf-8?B?TVNIMGNaZHRIdVFRY2VlMVZZbWtnSFRMV0YwaTRFcUNnNE9QV3NRTXZyMmk3?=
 =?utf-8?B?YjhLK01qbk1VcmNtNUU1dmFDYWNzVjBzcUwrMnc5OVRqUmZEUzB5L1Fxd1Fy?=
 =?utf-8?B?UGdjbDhPY2xUQzE0ZzFpOUZ1cnZrVlFaOHVkS1lzNTgrWXZTU0dOMmtjWnRY?=
 =?utf-8?B?NjRmZGV6VS9WckE0MzBvL3NVSUN2MWhDUVBXelRjN1JDV2RCTzkzNEtEMDNI?=
 =?utf-8?B?ajlYMVpOdXhEc2F6VGNaZWJrQlRxOHVNYkU5bit2Z2ZTY2VFRk81NEtkZ09N?=
 =?utf-8?B?SFlPb1FER0RuV0dmWnhGWFloaU9XN2VDd05GQTBTWDNHL0t5QUN3ZiszT0Ev?=
 =?utf-8?B?UExjakRPbkErZ0s5MWVxMmM5UHA3QTB5a2ZIcmlROTh4TlkvdXBQZ2xVL1FK?=
 =?utf-8?B?SndMbTNBeHdNWmNnakVEanZFRnlEcU1RbHBid2VML2NlSlJHNUNsYlZIR21T?=
 =?utf-8?Q?3hERxypevLjjX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnBxMEhRZUtNZyt3aDA3NWdiemdEejh1M0xMK1dKMFlIQ3FrNlFzOVFkdmpR?=
 =?utf-8?B?R2c1b2pScnlrUG1vYVFWMzRaN3pYSU1tclQrVi9SZWVibnNrNnBDak5aK2wz?=
 =?utf-8?B?MWxrcFRlbkZNSWpZSjY4UG51T2FMd280TURDWG8zWFFXMkJiaDhHM1BldUpJ?=
 =?utf-8?B?a2sybHFFTUZCcUJJRklQV1NLYk55L2YrTkJTbjBoZmYvRG1VN1FQbjhuSkJn?=
 =?utf-8?B?NmpvVStvcWZXNlk3dXN2NnFmdnYwOVFlM3hEa1I1TnBvVk9NNEtYaDdUNzlj?=
 =?utf-8?B?ZFdzTGNwc3dFM3ZqNUdJallPOWpYZ21rdWtFZ0hra2R5bGJORFVPTVNGWDFJ?=
 =?utf-8?B?cDNRZ1Nycml1dDFablZvL05FZE8zemZ0U2NXRU11a1p3SDBZMnh5RFc2bS95?=
 =?utf-8?B?SW1FYTdNSWlsOWF0T0Jpb1lUb2I4WHYyclZmbVdEM2VCQWtSZ1NDOWo3ZnZD?=
 =?utf-8?B?a2FTR0NQSEdnYktPdFpOaDZPeFFnVlowS0VwMzkwc1p6bG43cVNJS2R3YWJW?=
 =?utf-8?B?VzVXdXd5NkRIc1hqVjFLZWprV09jSDJaeDhYaGxJNWg4ZnZSK0p4bDhWbWdh?=
 =?utf-8?B?OXhENU10WjRGcCtFVXRLaTFsbzk0YzlNNGx3WkU0MW1taDJXbTdhNlozcHly?=
 =?utf-8?B?VVdERE1ESmh1Qk0zM3NXd1VRR0IxMktFZXl2TEF3YW1PUHRNQWVxOFdwZklZ?=
 =?utf-8?B?RmxnOVBDQzg2L2tydTBvcWJWcWt1djJ6dk9TY0VYQmxlamhmVHVNd1lZdEZQ?=
 =?utf-8?B?bmdpZ1hlejhUUlc4WFhvcjRpR2gzNXN4YmZFQjJ3YUxwT2Z1UXhna1FEL3dE?=
 =?utf-8?B?MTFHRnpsNExsYmtFd1BRRzg2TncwSHZESGl0ZnZ3c25sT3F6cDJjT2p4Y3dy?=
 =?utf-8?B?ejhnZjdNQXJHYmFHeHQzTVRlRHhHdWIwWE9NRjVwR1dEM1Y0WjZjUG1hRXI2?=
 =?utf-8?B?R0haSlJzZkxCQmxzbTd3SWRyOE81Nkw0YTFiQ21yeTVUQjQ4c08wWVNUdzRT?=
 =?utf-8?B?V3N0dGQvek9tSnpqcmJzSG94NGlEVldqNW84QmZTUXQwMFJtYTNmZko0WFRG?=
 =?utf-8?B?b0hReG93OStKUjVZdTg1VnNRN2JyK3JqNVU3OU9HZ3UxS0pwa041L21iMmZi?=
 =?utf-8?B?ZTJROHZKTlNhcUV5a1g5M1FxNEp2Qkx5d0NHRmM0T2FsbnNKOWprcUhHOEdY?=
 =?utf-8?B?SkJZb3JMYmVMSXBST1g2RmxFTFpROURtZ3ZrSkdzY2NENFdEOHh3bUpPSkZ5?=
 =?utf-8?B?Skl4QkRuZWZONE1IL3BSSGoyUlJ1cnBTeFpxM0UyYmdqcWpRT1d5cFRrbGdO?=
 =?utf-8?B?VG9PWkVJd3VMbmVzK0phZUFQOGFsd0NPZm5JRGpXemVKSW03ZmFDK3V5U3Y4?=
 =?utf-8?B?bGVJek1ycW0wM2ZGTzdWei9rZGdmdVM2RDBPWXFLTXp1c2RSM1EyR3ZKRXJZ?=
 =?utf-8?B?cWUwdU9ySmp1bWMwRS9hTHp1dUVzQWJWbnpsdWh4YVkxQWJrZWFpUVY3NStW?=
 =?utf-8?B?TXo0S0VLRDB4YVNrZDlLL0FRaG9zOFpacjZmdlFsSWd2Q0JHQXRyWm44OEJG?=
 =?utf-8?B?bHdEWGNYOU43d1RwcEp4MU9IR2Y0ZnRHNHRFVnF4TTlWSkd1ZkRhUytKTGVw?=
 =?utf-8?B?MkFmQVRiN3duV2Q3N3BTeE9wbzEwNnRsYXpyeDlMQ0JycDhnWW5QQnBtdGF4?=
 =?utf-8?B?RkNSWFVua2oyUVRmTVk4cEFUeFFSUGc0Qm5TTURaZ0V6Y3pFQTk2cW5kZzI4?=
 =?utf-8?B?czgzWkp1TmI3QTM3VnFvUUdoeUJJUXFVSVVUbFBGMjNhbUtjWVN0MjdsMFNH?=
 =?utf-8?B?SXlQWU5hbjlwbm1CdHBYK1lvQ1RnUmxtWElxcTd4ekRUMjlXM1dFYlZFWkhi?=
 =?utf-8?B?SGhHZUlIMk1wNmpKODY3Nmd4WGFTbGZWZnFmZXV3KzB3QWxiUVFEbkdZYnRR?=
 =?utf-8?B?eVExOGdEeFdObzNuMnZ2RG5IU3IwMWNpbncwTGsxQVNRMCtQM09BaTQxUlBk?=
 =?utf-8?B?NnhWdGRrUnUzQlgzWWYvRlJiQXBlR3JndHZiT3hDZ09UWFZ3QlpJSm93TVJk?=
 =?utf-8?B?WUNmQjlQNnQ1K2JwVVBSUUdwOVZocXlmc3ZrSEd0TTN1TGpjYUt5cFRiRDMx?=
 =?utf-8?Q?VeDL5IZ9biipVOwPSF1Aqe1x7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eaed9e4-813f-40c1-75e6-08dd2f8cbb76
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 02:32:44.5121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYQSPNilYqk7pG3CPbrq+VKrRrhMdLOPUQQ8LIAmr0kM0e8yn0WW2fpz+zlQ7ClPX9GL3lI0jJKFQzuT4tW5Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995



On 1/6/25 16:10, Jason Gunthorpe wrote:
> On Mon, Jan 06, 2025 at 12:34:00PM -0800, Tushar Dave wrote:
> 
>>>> @@ -1028,10 +1031,10 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>>>>    	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
>>>>    	pci_dbg(dev, "ACS flags = %#06x\n", flags);
>>>> +	pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
>>>> -	/* If mask is 0 then we copy the bit from the firmware setting. */
>>>> -	caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
>>>> -	caps->ctrl |= flags;
>>>> +	caps->ctrl &= ~mask;
>>>> +	caps->ctrl |= (flags & mask);
>>>
>>> And why delete fw_ctrl? Doesn't that break the unchanged
>>> functionality?
>>
>> No, it does not break the unchanged functionality. I removed it because it
>> is not needed after my fix.
> 
> I mean, the whole hunk above is not needed, right? Or at least I don't
> see how it relates to your commit message..

Without the above hunk, there are cases where ACS flags do not get set 
correctly. Here is the example test case without above hunk in my patch (IOW 
keeping fw_ctrl changes as it is like original code plus pci_dbg to print debug 
info)


Kernel command line: pci=config_acs=xxx1010@pci:15b3:1979;1111@pci:10de:22b1

	pci 0000:02:00.0: ACS mask  = 0x000f
	pci 0000:02:00.0: ACS flags = 0x000a
	pci 0000:02:00.0: ACS control = 0x007f
	pci 0000:02:00.0: ACS fw_ctrl = 0x007f
	pci 0000:02:00.0: Configured ACS to 0x007f
	...
	..
	.
	pci 0039:00:00.0: ACS mask  = 0x000f
	pci 0039:00:00.0: ACS flags = 0x000f
	pci 0039:00:00.0: ACS control = 0x001d
	pci 0039:00:00.0: ACS fw_ctrl = 0x0000
	pci 0039:00:00.0: Configured ACS to 0x001f

As seen in the above output, ACS bits for BDF 0000:02:00.0 did not get set as 
expected. ACS ctrl for BDF 0000:02:00.0 should be 0x7a and not 0x7f.

> 
>> If it helps, using 'config_acs' the code only allows to configures the lower
>> 7 bits of ACS ctrl for the specified PCI device(s).
>> The bits other than the lower 7 bits of ACS ctrl remain unchanged.
>> The bits specified with 'x' or 'X' that are within the 7 lower bits remain
>> unchanged. Trying to configure bits other than lower 7 bits generates an
>> error message "Invalid ACS flags specified"
> 
> But the fw_ctrl was how the x behavior was supposed to be implemented,
> IIRC there were cases where you could not just rely on caps->ctrl as
> something prior had alreaded changed it.

I read your comment in https://lore.kernel.org/all/20240508131427.GH4650@nvidia.com/

Looking at the current code, the sequence begin with function 'pci_enable_acs()' 
that reads PCI_ACS_CTRL into caps->ctrl and invoke the below three functions 
that prepares caps->ctrl before writing to ACS CTRL reg.

	i.e.
	pci_std_enable_acs()
	__pci_config_acs(dev, &caps,disable_acs_redir_param,...)
	__pci_config_acs(dev, &caps, config_acs_param, 0, 0)

Here kernel command line takes precedence over 'pci_std_enable_acs()'.
'config_acs' takes precedence over 'disable_acs_redir'. IOW, if config_acs param 
is used then it takes the final control over what value is getting written to 
ACS CTRL reg and that is how it should be, no?

> 
> What about your fix to the mask changes this reasoning? If nothing
> then it should be its own patch with its own explanation..

Sure. As soon as we are align I'll take care of it.

> 
> Jason

