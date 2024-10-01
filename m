Return-Path: <linux-pci+bounces-13696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D78B98C616
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 21:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F9128264B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 19:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF571CCEFD;
	Tue,  1 Oct 2024 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="or1vRM1l"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D801CDA11;
	Tue,  1 Oct 2024 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727811188; cv=fail; b=ocVn9sxfwa4XtuTOpjipsdwKANpgzfF5ATCczpCf+DNxw4sr+C8faseNOVN8vOBJbBHAHZsfybCohA10jAvt+xQ2FesNlwF2fggKK7AKEd1/3HGcFy/A+HNxk+NlIc93HXOGRlfHlUuAhGzKnxY2+3y/1uvP9OtydddXKbF77Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727811188; c=relaxed/simple;
	bh=ggmwaKM/pPGkvXKM5kxW1eTLv19teJP08FRY8HJM3lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AT7p9hngIOSLGlqW+CVWSwFwda1czZGXpiGuENxSWg0YMDF45r53bBHt8ss9lHeZKBao4kJo9+AieSti+TY63tSKYp4JlRirm7dWFPRbG8n25Mik4ivf9BSWovUOvK/oHycELSIpU9je34tc9yv/fOzSS8DhJjJcBsduUJLH31w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=or1vRM1l; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUxMXZuHhjAkWipURiJydEia5kqoQztTpnKf1hQivzLrBzy0OjxnPZjMeARFmhByMLznPrx0kRknykT7GMW/O2EDQOpJs+WvcNbvKGq/boER1ZedfEoBbgJotICOWfX++wkpku0AGLwhAk5rSj47v94aLd+maNNSuBY1/boFU/LUznWbNrb4zCeCyWQNUol6+TqzVQXpSuGEfFoy9zWEXjrtaBuCKIZfRLN7cWC2LZLhFPX/nKUP76InXUAZBLxMvCps0+u1rGzRVg6GV6pTCPJYkHYPgAd7ZESwmsxAX4ibM/SPceFKWnqc3PY4dUxKGPmNyWSTL94VgLcwyPWJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KG0SGIXmnAFdVCUYabmJtLYAhrQ454RmmTSbecBWVc=;
 b=RO81Djaz6rs3LQ2vgXE5hexQuGRHky4ON4yj/Js9U6DSdDv44oGShdYF8yW9zsZPN5eJDvPvFj2XCR4yJSjQ9uFUGT0jBOgG86tYZAndaftdY2pwPKBLel5anY5UKFd8rqRHOC38OltlBPKDG1uZiy1Xi94J7HbA8vD/Tlw5Pzn85rbAOWvqnKVFvPpjiozbkzKUFhTm3jhK2mYoEyvxLfOzwcVsjUin5L62oGTPG9+AlM07BfTgDl0v3/tAFGEMCETP5V1YbOqVSWH1/fZ7l1DLufBnkYK8p6qnKUrSSgLEXMx3Cw7lzUIY5qUqYtP+BBVPqwfAjnEho+A7KMxHgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KG0SGIXmnAFdVCUYabmJtLYAhrQ454RmmTSbecBWVc=;
 b=or1vRM1lbf20IH33a/H8K0IObOEwDrmzErZrH22Q8Flf1qq6NfKaURjfnSarAxINHZ0YV1C+45R9/wEfXEokoDpb5evgk8oSYi9abaqH32SvqtvjD8QDtQuapz7IeRTjTuKao+DMcPUNW/kLSjsE3KGCvFii40xL7z6tA9jZyMBskbFljhAn3zGuDafUtLWJPhE4hYoI4aw2KUtSqjqXt6kZeaoKz0lClsoR+h7LJheleavTP/Rt6zjMLC71RRr2KqDQNZj+wN7uiXx00C8otYoUPBwXutcly+DquX8RTZzTY6sub8opCKKlzyqaPtxFiXlLf3AQKTLlGm6WM1WVJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 19:33:01 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 19:33:01 +0000
Date: Tue, 1 Oct 2024 16:33:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Vidya Sagar <vidyas@nvidia.com>, corbet@lwn.net, bhelgaas@google.com,
	galshalom@nvidia.com, leonro@nvidia.com, treding@nvidia.com,
	jonathanh@nvidia.com, mmoshrefjava@nvidia.com, shahafs@nvidia.com,
	vsethi@nvidia.com, sdonthineni@nvidia.com, jan@nvidia.com,
	tdave@nvidia.com, linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com,
	vliaskovitis@suse.com
Subject: Re: [PATCH V4] PCI: Extend ACS configurability
Message-ID: <20241001193300.GJ1365916@nvidia.com>
References: <20240523063528.199908-1-vidyas@nvidia.com>
 <20240625153150.159310-1-vidyas@nvidia.com>
 <e89107da-ac99-4d3a-9527-a4df9986e120@kernel.org>
 <3cbd6ddb-1984-4055-9d29-297b4633fc41@kernel.org>
 <b8fa3062-48ec-4de7-b314-2ff959775ecc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8fa3062-48ec-4de7-b314-2ff959775ecc@kernel.org>
X-ClientProxiedBy: BN9PR03CA0866.namprd03.prod.outlook.com
 (2603:10b6:408:13d::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f40b37-0281-40e5-65fa-08dce24fdcbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjlWUDBEMDA3amM3a1c3dldvMU9kYU8zcXI4cWRzT3FmQkh0Y3lUMVJRck8w?=
 =?utf-8?B?eC9QL2JBR2lhcXVZS3dZUURPMGN6M09wa01FaURlVHliTmdOZGFoSlNiTFlw?=
 =?utf-8?B?ckJJaElFOUg3Q3o0N2tTZ0o3L3BxakI3M1JiUStoblNES0xDSTl4OUo0MGR5?=
 =?utf-8?B?MUlqbW95QjRhMGphNGwwblJVa3A2dzlERkFJK3pxa09qUFNWMkZRczdqUUhl?=
 =?utf-8?B?ZThWRHdiSWtNbE80UytpM2F1bzNoekFrTXpiMEVrUTN4ME0wWE5ldTQxeit5?=
 =?utf-8?B?Q3JhM0NoNWtXdER3dDZiUUtDTUIwVm4wNGtmaVI3ZFcyM2s2aHV2MGFqYmQw?=
 =?utf-8?B?MGt3dVh4UEtWZ2xOQkhkQ2F6dFJrOXFNQXJHa0c1cVlXeTN2MnlKV1lVeXY0?=
 =?utf-8?B?ZFpTek43cXhZZk1SYmlaSzl1RUhwb0tCV2R5Y1VHT0VIbzlYcUNmTWxlNkhZ?=
 =?utf-8?B?c1dtTTBrcXdFSVF1Y21aeGFiTE5ZaWorWTYvYUkrVG5NbFJEVmtvbjc4SFBo?=
 =?utf-8?B?YU9WeEVyOFc2TXJDYTZ1VUx2M2s2cXZtVVZHOFA2c0FkRXRucnQxT1dhQTVo?=
 =?utf-8?B?NU9wT1oyNGFTTnJ0MFpwUm0xRHN3dEdNSlpYcEpVSkdIdVRlaUZFNFFBWlYr?=
 =?utf-8?B?c0RVMFBXejFpdUFBd0FSd1dTRmNiQUdyR1hqYWtGR0xmMkhRWjZHbTZGcCtm?=
 =?utf-8?B?Tmo5UTg2clhidEJxNzlGeFVTNTBPRFpNNXhRR1puVVJja3N0bENZK1V2SDE3?=
 =?utf-8?B?Zy9TUkVta0k1eE9rRVpyWkg4Ym9SRzdUQmVxdjlPbVZDWFlYNFZQbGpLbjk5?=
 =?utf-8?B?YXRtYzZScWVsR050bmFLRHZ4T3pWb3ZWUmF4dHdKY2xkaTRpMk50bi8rSHFM?=
 =?utf-8?B?RFJlbDVZcU1HbEZGaWkyZzFsN2dMS3ArTFdnL2ZqNERJc2JzalZIZVJPWjBK?=
 =?utf-8?B?ck5ObS9jVkRKUnlqeHQ2MjZZZitnQ0ZNK0ROckJwR2p4Zmkwbnd6YmQ3VXR3?=
 =?utf-8?B?VSttZG9uZmhZYmNxOHp3UlQ0am5KQWpwSG9UZ0tCMkNaR3dPd3VlSWdRcjdI?=
 =?utf-8?B?MDdNSDVTN1hjazB4a3dENXIyNVBJZ2pFUG1rZ2c5UFYyZXYydkE3QVZDMmp5?=
 =?utf-8?B?UjlZZHF3NzVrQy9CVjZNMUwrKytic2R4N0Zzcmt0TmE4TXc1V1JBWVJjWmlj?=
 =?utf-8?B?bEJLVmM0Sm9LNmRGYndrVnZEUTNHZkdkRTRBMnJ1QUN1c1VlTFpoYjNqVmZv?=
 =?utf-8?B?anJVRnpRSEs2dU0zYjZMZFdabVMvMUtja2tNdDJiZGxwOWwveXdFMDR5dDlV?=
 =?utf-8?B?enZLNnMvdklud2p1S2ZmNVFUQ3FXbDlCZ3N6UmFLNW40bDAxVUU5dEVsWDBD?=
 =?utf-8?B?NFdUZ21PWHF1eldTWWwzZnNTMmlocXFSVisvQ04zMnRxZkxPK0xIaG1mVWNo?=
 =?utf-8?B?ZW1lUHBiVGFVTTducUJTM3NBbEZJV0ExZkQ2OUk2ZG0ydHE1YnY3TVR2aHdW?=
 =?utf-8?B?NUp1QWRLaXFudDJOVDNPbXNlb3M0TkpoRTdndUhhY3FyLy9VdXFVVHRKdzJY?=
 =?utf-8?B?MFN1NXUyZXZqRHYydmVDeEswMXJHZXlPS05Ib0VUYzh1OUt2R3VoZVRMSTRx?=
 =?utf-8?B?ZjlMSXdPNzhTVnQ4VVRWeSt0cDBHUHlYd1RaaEo4V2JWTnZPSHloUjd3R1FC?=
 =?utf-8?B?dU9rMk1DR3ZYNXpGZldqZmNUTTBtWjd4UGFaaDdueGVpNHlkcFduNHV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlNOOEd2UmpySnhoQUJNV3dRQmZUTi9qRnNVeEdpcmI1S3NQdWVVdXpCY2R6?=
 =?utf-8?B?d0xpdGRRdEdOOTRQME9sTWJMcmpCUXA0ejUwd2J2UWhWblR1amxsams4M2kx?=
 =?utf-8?B?Y2Q2VmR6dDlvR0FreGpZc1FyZXp1UU1QU2lNVlp0N1dQTGRXdWN3ZEo0L2F0?=
 =?utf-8?B?WUxYb3l3VkFZS0tJV2NxbVRjRS9uVDRscEY5MGxITzR0RzBlbTF5UytMT1VZ?=
 =?utf-8?B?YlhNU1BzOXRkUkdFeUJXZ2lPK2lmQ1Ard2ZPYWhkTGVMaDdnZHNrU3NsQ3RW?=
 =?utf-8?B?dmxUM2lJYW1lVW9mSVlSSXZaSGYwYnVVM2RIZVBLdzdqRmVZaHBuRXo0bnMz?=
 =?utf-8?B?TVlTRG8vMEtXY21XOGZVMi90aVFlS1hIUytzdDg0alNFOW9ienpVa0Fjekww?=
 =?utf-8?B?eUlnbDcvZEk1ejZmcHhrd0x1Nndnb09JTjdIV0VCSWZlUVljdEYwczFBQjJN?=
 =?utf-8?B?ejRHTk5DbHNqQ0RPU1EwcVEzM3ZwbGZ2U1dtUEFSWnpNN2xOUEx4bHJ4dXhB?=
 =?utf-8?B?Slg4TEUzMGtOQUNPaDdyNjVSM0NBczBYbUNRY1QzMkRYVHdzVjc5akNqTTcr?=
 =?utf-8?B?eHZCTjRVelh5ZmdPenNvTEwvODZNei9hMVoxNzkrK0JqSHA1ZVNJRlZSN2pP?=
 =?utf-8?B?YTdDNjFoWFF1SXZ0Zk1naVB3VlFUL2xVS3I5WVU0ZGJqY3htaXVJWDViZmNm?=
 =?utf-8?B?dUx4amllZktHUjN5V0t2N25wVVBKTVNQV0lKVWFaVWVld3ZxK05RVGozVlZs?=
 =?utf-8?B?a2dtK1JsZTFycitNU1htc0RpVVBBSTJ4VGwrRkZCcFdpOEprQnZXOW41aGFw?=
 =?utf-8?B?eDNCVmhEVjZsM2E0OVJDbDdRT3BkckU0YytKeWZJRUJ3LzRvUnpIdWZ2NU9E?=
 =?utf-8?B?NEdjQzhoSUhjNURwU2JXd01Ib1FJODF5VG1jOVdabWVvNTFZN0Qyd25wVjRI?=
 =?utf-8?B?YjNRdlgrbTBqQ05HQXFkNTQ5UmtKczNZY253Nnp1UFBhbk5jbVhQdXFWMDRW?=
 =?utf-8?B?NGo0VnYzODRWTGRsOFcxdnhTV1JQWE5kYWdyZEJ0czNYVzBaSlMvMG1hMjBt?=
 =?utf-8?B?T0FOQ2JGV1J4cUJLa2UwaGJQUko2a0lHWGJWeENLTXpheDdoRVZidlhYM0xt?=
 =?utf-8?B?VHl1dmtpYVFSVi9KdWdpK00zeE0veXFrOHEyanpGUDVmclU5NjA2M1QycC8r?=
 =?utf-8?B?ZlVZWTYzUzRiaFFlZWE1b3l6UHZJYWtPWDNNRlVWbmtvZU5vTXVpd0VMYnNu?=
 =?utf-8?B?Z0tra0M3THlqSHlhZEx0Z1VFaFk5OW9iTzVtWEk0NWF2UG1lUkpaY3A5OHpZ?=
 =?utf-8?B?OEpRdzYxbW02NnZSeFZocG5SRHhqN1ZydHlxcm50V2VaeGF3TjV0YjdKcUln?=
 =?utf-8?B?NHR0TFZnZStHOWVCYXY5QkNVWmlkOXRNVkpPWk5UMkU3MDRURWp4SlBFVXV4?=
 =?utf-8?B?SmdvRTZwK2JrSnRTVHBCbUovclhmTnY0QmIrSmhrZFVucHJIT0tNUk9xZlBE?=
 =?utf-8?B?d0srZTIzR2FwblVUbDcwcTIvTEZ2bEdJQWFOdkgrV2F0S0twY0NVekdwdmRk?=
 =?utf-8?B?UytBbEJUaEMxc1lrcUF4bmh3NnlNdzlvVHd4eEdPa3YxbWRHRkZULy91Z2tm?=
 =?utf-8?B?NENZVFRwTmhmK05DekpzZmMzN3gxS1pYRFNFdWJqZXluY3ZnZkp5ZWo3ZFVV?=
 =?utf-8?B?TTBFYUxIRGFIWkNaV1RpNFQ5YmJaOSswcjA3ekxsOHJVK3UwcHIyUUlXb1Q0?=
 =?utf-8?B?U0NuSk5wTWFXYVBKMjRmL3NMT1hRZGZBUjVTdDB0dUhBVWFBMGl5N2svdGJs?=
 =?utf-8?B?dWx5d2ZvWHhldjg2Vkp2L1dZYnJyQkpqT24zL0dXaGRVd3pkZDl4THJYTzJ6?=
 =?utf-8?B?elVaNk5qankxeVdWc1FYQ0tieVVMdmJVcEN2dW5BL1pSVVh1eWpaL0E2OVdi?=
 =?utf-8?B?UGtOdHJjQmZsZ3hsaTNrOGlreG5vR1hnMENhZzVwN09yaWx0L3pWMzlvYzZx?=
 =?utf-8?B?MFRLMklLTnAyMFg5dE1qRXBZQWs4cUFFVUlBWmxmWFRqbkVMT3g4MDZTUlQz?=
 =?utf-8?B?dXBsbnVpQ0phNUxWdTJmMTN0SE9SNGZ2aUdtdGJFdCs3UFJRR3lLWVZXYW5M?=
 =?utf-8?Q?4v08=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f40b37-0281-40e5-65fa-08dce24fdcbf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 19:33:01.5997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ga52OlPqYyLJuGIin3yAlFzQ9AEQmgM74v7HG6K5H7X7lcNsN/7uGemSoixz92A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016

On Wed, Sep 25, 2024 at 07:49:59AM +0200, Jiri Slaby wrote:
> On 25. 09. 24, 7:29, Jiri Slaby wrote:
> > On 25. 09. 24, 7:06, Jiri Slaby wrote:
> > > > @@ -1047,23 +1066,33 @@ static void pci_std_enable_acs(struct
> > > > pci_dev *dev)
> > > >    */
> > > >   static void pci_enable_acs(struct pci_dev *dev)
> > > >   {
> > > > -    if (!pci_acs_enable)
> > > > -        goto disable_acs_redir;
> > > > +    struct pci_acs caps;
> > > > +    int pos;
> > > > +
> > > > +    pos = dev->acs_cap;
> > > > +    if (!pos)
> > > > +        return;
> 
> Ignore the previous post.
> 
> The bridge has no ACS (see lspci below). So it used to be enabled by
> pci_quirk_enable_intel_pch_acs() by another registers. 

Er, Ok, so it overrides the whole thing with
pci_dev_specific_acs_enabled() too..

> I am not sure how to fix this as we cannot have "caps" from these quirks, so
> that whole idea of __pci_config_acs() is nonworking for these quirks.

We just need to allow the quirk to run before we try to do anything
with the cap, which has probably always been a NOP anyhow.

Maybe like this?

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7d85c04fbba2ae..225a6cd2e9ca3b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1067,8 +1067,15 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 static void pci_enable_acs(struct pci_dev *dev)
 {
 	struct pci_acs caps;
+	bool enable_acs = false;
 	int pos;
 
+	/* If an iommu is present we start with kernel default caps */
+	if (pci_acs_enable) {
+		if (pci_dev_specific_enable_acs(dev))
+			enable_acs = true;
+	}
+
 	pos = dev->acs_cap;
 	if (!pos)
 		return;
@@ -1077,11 +1084,8 @@ static void pci_enable_acs(struct pci_dev *dev)
 	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &caps.ctrl);
 	caps.fw_ctrl = caps.ctrl;
 
-	/* If an iommu is present we start with kernel default caps */
-	if (pci_acs_enable) {
-		if (pci_dev_specific_enable_acs(dev))
-			pci_std_enable_acs(dev, &caps);
-	}
+	if (enable_acs)
+		pci_std_enable_acs(dev, &caps);
 
 	/*
 	 * Always apply caps from the command line, even if there is no iommu.

