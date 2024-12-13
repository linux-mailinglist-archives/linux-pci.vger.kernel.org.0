Return-Path: <linux-pci+bounces-18414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB8E9F1763
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 21:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05677166FC7
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 20:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BD91917D4;
	Fri, 13 Dec 2024 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E7U1ErGU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5086118B47D;
	Fri, 13 Dec 2024 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734121822; cv=fail; b=Z2CNC69O578rGdfUL1CYIAXS1c7nyyXP0Wfrg+pMDF4gQ/MJqk2vvEcnlK7pO5uZGo13MdhArj1Um3Xdl9Bl6l2PDvynEX2yKxXZ4ftd4m6IGHS9ociA+TQmDizd3msigdzD9OTkVExbIkVsll2sI0CHYdW1fBgSZFatYryZjlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734121822; c=relaxed/simple;
	bh=qwtrsnkAgbv+efZtuVnk2FNRAmqW9d9kS/vi3atIFD0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Gt/S4EtkpxuNQ9yPY0Arn64sY9kK6SxuqtZjAJ+IyRCMHr5hFDR2maMjcOOdta2QsG38OlCCPPac7L1bSAsP04MRSZ/VVyM63IP8ynuOmiMgUKZnEqNpcyHNw382MdfBt6hEMWp8k+KpiVRdNfvGinNJUDlmNLdGS2Ed14i0R74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E7U1ErGU; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+1M9wwM2LKGL5rubp1pc3FkMxvpRagz6MgIicKBFpMbY0f0LPyc3x1nqEjdBGHYG7dTbt12jg8e25XBqF8Wj6l85NA23F+dfn2hy9LNCZwyqQQSBwfBkDK7xLfeyy7I8BmnDEmj42N4vqqj8ZguIvTi56/JBE88uTuC9JRCLNfoz1CvPU9YQLCd35PAKrtLoua6rCtWADrql/fl5AyG3nJnjhEIEMAgCLVXNyQDfwldl+GUawptQZo7hfmLNVJ7aaqBLyrdWCcSfFmZTsq4wmfclnmjZBFqPrAs7lBaRYcYWD6o2dgEVX6UND/rBoN5VabcRim5lYLm5rg/jRGL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwKyY5uYgW4wH7WLAm8kK//o4/MqVZmUXzXHkwbe0HE=;
 b=N7iWKLaKYK5CeCuaI+wDZcmZ4V3hzGf3pWs5eGk2SwjS43n0ADei6+/rkijie3w1Mig1SFFPrSeNx2oSw5To5mPBDDfwKM6uj4Irtnff55JQ/Z+1m+kqkf7CL9n7jb+l+9EVXlH7QkD4t+a3Y5Guinp24WDcoRK1+RKc8kK3uwSCbJeVXxLO0xLIobZ2doDBrLx14v58awamlwc1yt4/D6TumLdQgWHuYHj6SFp+dryk7SikqrK2JFispu3WC5jKa0OdMAA43KlZRfsxzt6aDcgKP9LcDCS/inzVg47v/dDcgFxwSkSrtSte9ch5odI+B6XDNcETfIooOrhPTFSPtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwKyY5uYgW4wH7WLAm8kK//o4/MqVZmUXzXHkwbe0HE=;
 b=E7U1ErGUGwTt7bi7Q82GFFELVlP4yHN1JyzGfy/xaamwJmowbGPJGKM1m4+nffsw+yUq93z065bJrGnP7KoGTXbOOq7n/NcLACYw7SugG8f5I/hRp1XzFESMiGD/LKvkq5SuHwfhA3K0W8P6PoXjLM05CFtZ1f6RCGqCV34mdDLDiFnCqpSRcYHjYFkmvZ0LNBmbp2V+igqrRypsw5A/ShAliouSvtUqBimNBjvgOVCrBxsv+9rR+oW9NFLtx2lG+QALy8gp73wSqwvT5qt83SYcnC57Le9sxv5yZeCWRZQGlr9VqVyHG1BCHbYXTIPf7Lhe5L2N4g88xb61KklV8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 by IA0PR12MB8694.namprd12.prod.outlook.com (2603:10b6:208:488::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 20:30:16 +0000
Received: from PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a]) by PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a%6]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 20:30:16 +0000
From: Tushar Dave <tdave@nvidia.com>
To: corbet@lwn.net,
	bhelgaas@google.com,
	paulmck@kernel.org,
	akpm@linux-foundation.org,
	thuth@redhat.com,
	rostedt@goodmis.org,
	xiongwei.song@windriver.com,
	vidyas@nvidia.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: vsethi@nvidia.com,
	jgg@nvidia.com,
	sdonthineni@nvidia.com,
	Tushar Dave <tdave@nvidia.com>
Subject: [PATCH 1/1] PCI: Fix Extend ACS configurability
Date: Fri, 13 Dec 2024 12:29:42 -0800
Message-Id: <20241213202942.44585-1-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:303:8d::10) To PH7PR12MB6657.namprd12.prod.outlook.com
 (2603:10b6:510:1fe::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6657:EE_|IA0PR12MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f7e638-b169-488b-b201-08dd1bb4f45e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFdQa0NDQ3M1TVVZK1VqUWpyT3VMSXR5Q25HdWwvK2RncFJpNzdkaDFDdElF?=
 =?utf-8?B?Q0phMEJSNWNmaFpxOTBiMWtXU0lvZjZyY0tyU1hBMDN4NWM4TE9ZN3BXVEJO?=
 =?utf-8?B?RFBuSzlFclByS3U4ZlR2NENPK21ZNVpNRXdnRm9HTUovaXZUSGVtckovaTRj?=
 =?utf-8?B?UlA2WHIrN0pGVk9wZ0NITy8xUDFyR1JBcHhlN2NpVEN6cmRwSWRQT1pVdTBs?=
 =?utf-8?B?WlVNMUtQU0hzZ2tGWjQ0SStIU2dhd2FwUDl2V040YUlhVDdQa0g3NVVybHMv?=
 =?utf-8?B?bEJjNGNDSUhTay9Kdm0xUHdNQmlXK1NLc01Sb3NqRXdaOTdTNi9wMG1QM0tB?=
 =?utf-8?B?ZzdodzZvc2VUdDNacERRUjl4cmtSSGFvOENHb05oUDNWRVJCWkdISFNZY2Z0?=
 =?utf-8?B?OHhSZE9maHozTEs0d0tYcWNkTWRJWVlocnV3SmVEWEJ5L1ZnMjBQSExaZk9v?=
 =?utf-8?B?a2g2R2FsZHBxeEduMG1yNHVUS3RhQzF5NHJpdmt3cnlSNmp4eWM4T01YaC9Y?=
 =?utf-8?B?RERmTlpJSFU2TzBpS0hpUDhpSDJSZzQrMEZlbXFIYWdMd1doTlBhbmptVzk1?=
 =?utf-8?B?ZTJ5d05hNVovQkoyd3dNUjc2WkE1MmFjOFpHb0NZQS9Xa1ZUd3dDMjUzVjFJ?=
 =?utf-8?B?ZHNibm1Ha0RBaHdBTDFsdVdnVUo0V0RpaDdWcng3WWhPa2JxU2dzOVEvdTJr?=
 =?utf-8?B?Z1g2SkRZUytBbnU3YkgzTGJIMFVZRWlJSzBmR2JwSmJ6QnA1a1NwOE83d3F4?=
 =?utf-8?B?QkFscUNnK3lyWndZZWZFMnJpbWVadlRsei9MSEhvZnBWTkkvVzJTUkRzWU4y?=
 =?utf-8?B?a3NIaHFtK0JESGVrV3NvZ0ppVFFLNzBOU2p4VFpKV3JYZ2ZaMngyQytnMWEy?=
 =?utf-8?B?bkJrSGNLWG5jb1JWUkFkNXpBdi9XN05mSXozU2xjU04vNHNXNXVZL3dBZlVl?=
 =?utf-8?B?RytVVStSZmt3SnlqaVBidm8xUUhLMFUzR3g3RlNFSy9uNzkyTFI5c09kOEhQ?=
 =?utf-8?B?Ym5JemZVUnNJUnJGVmo3MnlDbE5TUG53RmFlc3oxREtYQWE5SE5UUFpDRnRZ?=
 =?utf-8?B?VmJyWGExbzZSS1lRVXFPalQxTXRobFV5MXJIV25QVXE0Sjl3UURQRnlrWmJS?=
 =?utf-8?B?YjVaZVdobEdWekVCZUlPRENBazVNNEpDSVpmOEVaUlJTVEJJbFNIT2E5MmtH?=
 =?utf-8?B?elBxdnN1dEsyZWV1dW83cFNycER4Yk80Q1oxb2duM0JDdktKMVIzOWg0K0xl?=
 =?utf-8?B?L3hyaHFFT0VjMDE3QTJnb3lBYW9kSFlFMnZWM0JmS2NNdmovRFlUMHQwOWlx?=
 =?utf-8?B?a3ZqZmprTnhxRnpxMGZ5SHNIMHdaOThOMEVMVEwzZ2c2ZlNFQkZZS2hqZ0g4?=
 =?utf-8?B?dXhDUjRTdmhHSkpXK3pWWHpXdnVHdkpCUU8yTTVrUnFWSlVBSExEcjR6Q1Iv?=
 =?utf-8?B?RU9LaW9YRVJVQXA3RkM5SlQ3WlZqZzd3NnF4NEdBLy9sR0pUL2JQREFDSTZ3?=
 =?utf-8?B?ZHNyeVlwUnU4MzBQT3dqVFpwYUV3VW5ENzFzVFpHaUtMcWN3TUM0UnJLZ1ow?=
 =?utf-8?B?UDg5SnFoT0tUT3c2WC9ObXEwMGM4YUhoZ1Z5QmhDUnZDUlhnTzYvQmpadkpl?=
 =?utf-8?B?MWRzVkY5YVJLZ0hZSW42M3V3VHVYRWdiQWRReGcrL0pDSjFmRzM0TVlQajN2?=
 =?utf-8?B?YTY4WVhuZVJkUldabjBIRVZ4eEJEUEIrVGFTRjVuVUpWUzlsOWRnK21zTjNL?=
 =?utf-8?B?ZWF1RCtqU2h4dlZUVVVTSWJ2UVZpSkVSWi9mYnFJUUxtZ2ZMUVpMOHF0ZHlJ?=
 =?utf-8?B?bXZZdEsvLzlScTlCNXF3YTFoeDJmZXBaTkZPdmdrTWw4dDE3dVZlMjYxYklz?=
 =?utf-8?Q?02ImUd/DBkAgH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDhwYm9NTHhlVDNoS1B2UjdVekFkRlMyckRMRE0yMkdIQk5nU21GYUlWcy9T?=
 =?utf-8?B?OStQZjJIYXR0Z0lHajI3aXl3VUJ5U09LamZLLytIYThnM3dlU3hlQ3FzbE9W?=
 =?utf-8?B?OS9GV0NoOFBoZTBjc2lGMU9ZYWNYbjFxYkFZc2lNZ202L2lOT2VHYmpIaHI3?=
 =?utf-8?B?RTUzWEVoL015a1VXVG1qSWN5bDRmeVpNTXVZRUlnRW1SWVlENHpaUk4ydDVF?=
 =?utf-8?B?a1plSGtTVExxcmliMTE0OWg4S3NYdG1XellqQWtJcnYwcWJvVW4wN01uOExI?=
 =?utf-8?B?c0VpL0dYcmdLdVZDZkdxUFNabDVDSjFrRUpNOVdpQmlDODV4a0pKVUZVN3Bu?=
 =?utf-8?B?bmhWYUxPWkUzR2tjQ211c25Uenlab3dmSmFFZzNtMVZhekhwWXRaM3ROengr?=
 =?utf-8?B?OE8xbXpBVWZab3ZEelBxdDcyTnpFbWQveUdGdmx3aTVrSVlGSnpqMGNZUHQ5?=
 =?utf-8?B?TFNVTlZBYUlyZUhUb3I0YmZLUnhmSlU2RDdkU3RVQTRJc1FCci85YmRDMGdz?=
 =?utf-8?B?eTBBdWEvOHFaQ1dHbE1ReEYyNVYrUjhyTDFubXRzY04zVGQvVmpHbmIyYm9F?=
 =?utf-8?B?TEdNajNjTnpFNEFuR2pvbEdmWWcycExtc1lPMm13OCt1U0NwR3NNNnAxSDE4?=
 =?utf-8?B?ZlN0SndPSVJnQlEycDFzR2xGQUsvK0ExU1NGUUtUVFhZWFhSTWxqZGR5djNz?=
 =?utf-8?B?c2txKzlBZEI2QWlzcU1vU096RmFwajBkYkwrd0c2WlFmbE90dDg3eWJGTXds?=
 =?utf-8?B?Ty9JTXhkT1NXdTBDU0VadlhHMjh3WCtUSXpnNk84Y1dRMnpDY2M2c1JxZmJ0?=
 =?utf-8?B?V1ZxWE5ISFZCUnloR3l5WU9QM0toNlZ1YW9TWDZYc3MwT0Z4dGxUbDBSVmZW?=
 =?utf-8?B?dmtWeG03VThGN0JQWkp5SkRMSXJtQnQ1K2JVMTNGNUk3MXY1cG4zQVVjSXRI?=
 =?utf-8?B?Y1BEaVNMV0E2NzQxcjdYT1p0SGV5ZkF4MnJiaTZoU3U1YXpvTHZsUWQ3K1gr?=
 =?utf-8?B?ZE5IMXZXQm9IUThmRzBTU2tEMzdsMlVjeEVRVFhJZXlmS2ZTbklzYnRYZTE1?=
 =?utf-8?B?d0p4RkgvbWtYYVBNU3dpMWtQZXlZUXVlczN4dlRjNFlsSzdFdWdsZjdrd1VG?=
 =?utf-8?B?bDlVZGhEU1JoY1FlYzIrT0NYd085bmdRK0lZdjhNY0Uvd0JEN3ltNVRXdWRR?=
 =?utf-8?B?U1h3akRtVWlnUXVQZWFYSlUra29HNnp0L09SbWZnQmRuTE1lamcwMm0xSjJM?=
 =?utf-8?B?cnRYRGxrb0pCNG1YaS9iZTZvWVFPMEJBTjFvSGdhdElFMkdSNFBUb1g4TVA3?=
 =?utf-8?B?WXF4ckNkdkdxc0lRR0drNFVpcDJuWHdUNjVibDJHN2pHbFJnRWhkdlhXYkRy?=
 =?utf-8?B?Y2VOQnJPWkhXZngrSEYyajNKSy9mOTEwaTVOemFvSU1hNXpRcmpUZjVmT2wv?=
 =?utf-8?B?VjI3bWdmSjZveFhoSkxHRVl4L05pWlQ2TWo0RnBoYzBIN2wwZjFiYVpqSGVi?=
 =?utf-8?B?Ukg2NGJjMWJ3c3VNZjdzb3pCWEZEUi9jazhQT2tpcHVKN0VlakRlc29lRG1Y?=
 =?utf-8?B?Z1NZN05nV1V5TFcrTGtsbzF4bFBDR3NFMk55U0RybVFvbmd5eC96Z2k1V1E4?=
 =?utf-8?B?Zmtjdks0czlBV1pmTkU1UTdYand5R0RrS1N5clMxVngwMDVPNXpibEVWNGtm?=
 =?utf-8?B?V05PaWxYTUQwVHAwOGpySGRqVVJwZXdaVlY2c2ljcXhVQnFaQWRjclhSSk1H?=
 =?utf-8?B?SnVKa0lKREQ5eVpCVlZNaXZEVUF1T2VxaFRJaG8rd1pVU3dGclZ1ckpHR3FY?=
 =?utf-8?B?dWJ3UGduVkc4YUhxZ0tqZEw4a0RsVGRtTFhFaHoyT1E0UE80LzlwK2lSMzRK?=
 =?utf-8?B?cjJFbW4wVS9BUklMeDgxVXpBeEwwR2t0QlR3c3RTVEFacEZFbnpHalJzSDBr?=
 =?utf-8?B?MTlrWWsybE41VWV4YWk4ZHdUNUpRY0duRzJBSXVsSmwrelBBVEMvZ1J3b3Mx?=
 =?utf-8?B?azh1ZzNlSkh6WXJYTEhMTm9DQVViQ0ZHcCtFNmw0cTJXZVFwSlZXL1VYM2lx?=
 =?utf-8?B?NzZQQ2txcUZ2MFNKck9uRHhIc25Gb3gzQWxYVjJYZTVFb0V1VklYTHdXRW9s?=
 =?utf-8?Q?c34j7+xqinWt3oa2W2fHorWE6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f7e638-b169-488b-b201-08dd1bb4f45e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 20:30:16.5867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbFqqdH0PcwQnGsZj2HfyrjJ4sCKKt4qUQf3TLnpc3Nk5CSLS3kY51miY4nYvhQPoEo3T9jKD0bHwSu5TILYOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8694

Commit 47c8846a49ba ("PCI: Extend ACS configurability") introduced a
bug that fails to configure ACS ctrl for multiple PCI devices. It
affects both 'config_acs' and 'disable_acs_redir'.

For example, using 'config_acs' to configure ACS ctrl for multiple BDFs
fails:

[    0.000000] Kernel command line: pci=config_acs=1111011@0020:02:00.0;101xxxx@0039:00:00.0 "dyndbg=file drivers/pci/pci.c +p" earlycon
[   12.349875] PCI: Can't parse ACS command line parameter
[   19.629314] pci 0020:02:00.0: ACS mask  = 0x007f
[   19.629315] pci 0020:02:00.0: ACS flags = 0x007b
[   19.629316] pci 0020:02:00.0: Configured ACS to 0x007b

After this fix:

[    0.000000] Kernel command line: pci=config_acs=1111011@0020:02:00.0;101xxxx@0039:00:00.0 "dyndbg=file drivers/pci/pci.c +p" earlycon
[   19.583814] pci 0020:02:00.0: ACS mask  = 0x007f
[   19.588532] pci 0020:02:00.0: ACS flags = 0x007b
[   19.593249] pci 0020:02:00.0: ACS control = 0x001d
[   19.598143] pci 0020:02:00.0: Configured ACS to 0x007b
[   24.088699] pci 0039:00:00.0: ACS mask  = 0x0070
[   24.093416] pci 0039:00:00.0: ACS flags = 0x0050
[   24.098136] pci 0039:00:00.0: ACS control = 0x001d
[   24.103031] pci 0039:00:00.0: Configured ACS to 0x005d

For example, using 'disable_acs_redire' fails to clear all three ACS P2P
redir bits:

[    0.000000] Kernel command line: pci=disable_acs_redir=0020:02:00.0;0030:02:00.0;0039:00:00.0 "dyndbg=file drivers/pci/pci.c +p" earlycon
[   19.615860] pci 0020:02:00.0: ACS mask  = 0x002c
[   19.615862] pci 0020:02:00.0: ACS flags = 0xffd3
[   19.615863] pci 0020:02:00.0: Configured ACS to 0xfffb
[   22.332683] pci 0030:02:00.0: ACS mask  = 0x002c
[   22.332685] pci 0030:02:00.0: ACS flags = 0xffd3
[   22.332686] pci 0030:02:00.0: Configured ACS to 0xffdf
[   24.110278] pci 0039:00:00.0: ACS mask  = 0x002c
[   24.110281] pci 0039:00:00.0: ACS flags = 0xffd3
[   24.110283] pci 0039:00:00.0: Configured ACS to 0xffd3

After this fix:

[    0.000000] Kernel command line: pci=disable_acs_redir=0020:02:00.0;0030:02:00.0;0039:00:00.0 "dyndbg=file drivers/pci/pci.c +p" earlycon
[   19.597909] pci 0020:02:00.0: ACS mask  = 0x002c
[   19.597910] pci 0020:02:00.0: ACS flags = 0xffd3
[   19.597911] pci 0020:02:00.0: ACS control = 0x007f
[   19.597911] pci 0020:02:00.0: Configured ACS to 0x0053
[   22.314124] pci 0030:02:00.0: ACS mask  = 0x002c
[   22.314126] pci 0030:02:00.0: ACS flags = 0xffd3
[   22.314127] pci 0030:02:00.0: ACS control = 0x005f
[   22.314128] pci 0030:02:00.0: Configured ACS to 0x0053
[   24.091711] pci 0039:00:00.0: ACS mask  = 0x002c
[   24.091712] pci 0039:00:00.0: ACS flags = 0xffd3
[   24.091714] pci 0039:00:00.0: ACS control = 0x001d
[   24.091715] pci 0039:00:00.0: Configured ACS to 0x0011

Fixes: 47c8846a49ba ("PCI: Extend ACS configurability")
Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 11 +++++------
 drivers/pci/pci.c                               | 16 +++++++++-------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dc663c0ca670..fc1c37910d1c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4654,11 +4654,10 @@
 				Format:
 				<ACS flags>@<pci_dev>[; ...]
 				Specify one or more PCI devices (in the format
-				specified above) optionally prepended with flags
-				and separated by semicolons. The respective
-				capabilities will be enabled, disabled or
-				unchanged based on what is specified in
-				flags.
+				specified above) prepended with flags and separated
+				by semicolons. The respective capabilities will be
+				enabled, disabled or unchanged based on what is
+				specified in flags.
 
 				ACS Flags is defined as follows:
 				  bit-0 : ACS Source Validation
@@ -4673,7 +4672,7 @@
 				  '1' – force enabled
 				  'x' – unchanged
 				For example,
-				  pci=config_acs=10x
+				  pci=config_acs=10x@pci:0:0
 				would configure all devices that support
 				ACS to enable P2P Request Redirect, disable
 				Translation Blocking, and leave Source
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0b29ec6e8e5e..35ff21b014ac 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -951,12 +951,13 @@ static const char *config_acs_param;
 struct pci_acs {
 	u16 cap;
 	u16 ctrl;
-	u16 fw_ctrl;
 };
 
 static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
-			     const char *p, u16 mask, u16 flags)
+			     const char *p, const u16 acs_mask, const u16 acs_flags)
 {
+	u16 flags = acs_flags;
+	u16 mask = acs_mask;
 	char *delimit;
 	int ret = 0;
 
@@ -964,7 +965,7 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 		return;
 
 	while (*p) {
-		if (!mask) {
+		if (!acs_mask) {
 			/* Check for ACS flags */
 			delimit = strstr(p, "@");
 			if (delimit) {
@@ -972,6 +973,8 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 				u32 shift = 0;
 
 				end = delimit - p - 1;
+				mask = 0;
+				flags = 0;
 
 				while (end > -1) {
 					if (*(p + end) == '0') {
@@ -1028,10 +1031,10 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 
 	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
 	pci_dbg(dev, "ACS flags = %#06x\n", flags);
+	pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
 
-	/* If mask is 0 then we copy the bit from the firmware setting. */
-	caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
-	caps->ctrl |= flags;
+	caps->ctrl &= ~mask;
+	caps->ctrl |= (flags & mask);
 
 	pci_info(dev, "Configured ACS to %#06x\n", caps->ctrl);
 }
@@ -1082,7 +1085,6 @@ static void pci_enable_acs(struct pci_dev *dev)
 
 	pci_read_config_word(dev, pos + PCI_ACS_CAP, &caps.cap);
 	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &caps.ctrl);
-	caps.fw_ctrl = caps.ctrl;
 
 	if (enable_acs)
 		pci_std_enable_acs(dev, &caps);
-- 
2.34.1


