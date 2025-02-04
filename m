Return-Path: <linux-pci+bounces-20712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E91A27CAB
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 21:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B543A2262
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 20:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384D8217645;
	Tue,  4 Feb 2025 20:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sHj12KwZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A6A204589;
	Tue,  4 Feb 2025 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738700325; cv=fail; b=PRzjJtOarE7LYtHHr2Ik8tEWKH+Vs5CH9cCpi/fqEut1LxEdQYEXlAwHDoo+WmsQzFzaGe+uuLJo8eSHG+6SJXAAwsnydqmmdmtZBxMNGuD6OBZW6zpPgc76Z9Ysfw7BE0AVibdF9nTpjVDLoZ9dyJhxW4X1lAdbDsaT+l4TLW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738700325; c=relaxed/simple;
	bh=czVKff8J5suTilHyFOsZy+zAhY5NPMiIpT4GuxFdeqI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b61yiR7Tkk5MzbO3pIu/C0CvXgYg7TTQWcKhTyOsWzJgMp7pQEAnIE20xKeX/HobmqjTrWpb2ho5iX524JIjeIf/SQ2tSWI126QJOFHFiGPoJaAzFuITDhJOv3jPa4SCYPELmPXPsH8p/7Z9Ga2cdl1SsLMVf9nHPHILNV5RIsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sHj12KwZ; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=do+ETnIO7fMSAdMxE0WNGUHc5jIb8oTDeNfyyrA/QSpFlHUarMlOxC//OFsYnoA3pBUR7UY+4lh4qMJjHS+NrMrTkojA0VsDAvh5FafDT5gNLHQdSnEV0D2p2Xau9mpb4iEb3MZrFBHMdV2Tv/1935cCxp8nBxfGMh5CK8voojsJffhE9sLCaORhhWlSeXk6fmNo8Z19LEZTms8q8nDuu6nj7amzKRRg3TSnZ6U/ntoMdYAmrjAokMCcvKwYuj+CKH4FrhrgW3omjSbl5L8+lTcHaLdVJceW7EGSnQIZMIMTEg4G2Mjw4UTbEQ27scBA6e7Z1OC1POZcGUSZXsuIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UzByzBXnEShrmklwImkAuDYRwOiXd9j3UHZOpY7I1Q=;
 b=mXaaQV4iRFuXsBT1n61pCjGoDcMevB4qWzJMJhKqevTRma0M7+f4OmFs9IKZERtM43unzJzsmKslx55egBEvll2uK/DOTiNg9hNJGDjqX9l+5TNhMdd6vit2TVXcOyZo5jXFOkwO1RKm4dR8xmDWv+QByYv4Tx2VvPWWdGKehb1BoXJYoQeJvZ1+C1S3qH2Dp9Ge4CHFW1TzGp3V/ZgEg9+PYA243SkmZn54wSbhIGuzcRmg28/8NBaC3u0jUkzexdqjmCP/tw4tBhIsRnCqw+gd4kiNWiAn1FrqpLslBeKFap71A1ULBx1Ofyzx4mPHz+cX6rtlCsoe/fQ8mAtiFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UzByzBXnEShrmklwImkAuDYRwOiXd9j3UHZOpY7I1Q=;
 b=sHj12KwZxEVgTTNENcNol+LwzoU93ydZqVr3BFuzttiMEUgKmInnY4ny2LNIex4hA3VRilk1V99wyHLntiE3Ylvtb0N+bK8pJgU7+L1njihzoRFlLMcqaDVt5otIdI2P8uRDO6kvwh6hJjgonf+FUMAlhB2a1l0y9w6yP5iLIuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by DM4PR12MB5842.namprd12.prod.outlook.com (2603:10b6:8:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Tue, 4 Feb
 2025 20:18:39 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%3]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 20:18:39 +0000
Message-ID: <f6b34f2e-31c9-4997-abfe-38d7e774b4fa@amd.com>
Date: Tue, 4 Feb 2025 14:18:36 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 2/5] PCI/TPH: Add Steering Tag support
To: Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jonathan.Cameron@Huawei.com, helgaas@kernel.org, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com,
 lukas@wunner.de, paul.e.luse@intel.com, jing2.liu@intel.com
References: <20241002165954.128085-1-wei.huang2@amd.com>
 <20241002165954.128085-3-wei.huang2@amd.com>
 <a373416b-bf00-4cf7-9b46-bd95599d114c@arm.com>
From: Wei Huang <wei.huang2@amd.com>
Content-Language: en-US
In-Reply-To: <a373416b-bf00-4cf7-9b46-bd95599d114c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::33) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|DM4PR12MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: c60959ad-a838-492f-b864-08dd45591cf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0NTU09ZUkhDSmxMVVJhNVk5MmtoMHhiL2twSW9NdHZTSld0Q3lBazU2RUVX?=
 =?utf-8?B?UldFR2U1S0dKbUdqNDBYNFNHcEFkNm5KR3ZSajBjSFRIa294RDh0VWp0SHhH?=
 =?utf-8?B?RzhQUXUvMDJWclN0VnBCcTlIOUdCaHc4NFJFWTNseFVQQmxRUmN5RTBuZUU5?=
 =?utf-8?B?WHB2eEQ0em5JRlV5MlZWQVgrMGxGVGp1SDdqYkRqL3ZuYUxIUk9sYWs4OXFk?=
 =?utf-8?B?OHQvNFlHUVgraGhvQU5GNGdDd0g4L0tsUWUzbHdLT0NuaWtSOTNQVFEySjgy?=
 =?utf-8?B?ZWYwSEt3K0J6cUVTY0tTT3k4clJ5UWZuOFRRT0ljckZqU2xYZXhsRERQa3Uz?=
 =?utf-8?B?N1JMM29QWDNqcWVpZFhld05NUTA4WlJEMUtiRk1oQkYzU1lHNVlKdGxQbVQ3?=
 =?utf-8?B?WkZpNytndEtRNDFhSGxqYVZFRnUySDdQdVBwNHJuUVliMzlzdW1lY1N2alQx?=
 =?utf-8?B?UFhLN0RDb0s3d2dWdTc3cmV2aEdMRHNQdVhuK1pJS2VNTmQzTnNEcU16TU5G?=
 =?utf-8?B?ZEdxeEZYUCt5eSttUURjTHdkOFRjMWZTdytwK3ZOaldKcWZPT0tVcGVUOTMx?=
 =?utf-8?B?REFjcGZMdWhQdVFvOUdseVh3N3Q5ZmQzQUdCWHpkcmZzMzdPdENwLzdTNFNB?=
 =?utf-8?B?Qk5SandOQjZxdXBlMlU5UlVKRmU5aVliOGtRY0kwaG5VWDBpWTZTYWdqR1pa?=
 =?utf-8?B?TTE3MjRDelovL2JCRHgreUdMTDFUMVViK1RyYkU2bjgxTVdDejlxbzM4Yml1?=
 =?utf-8?B?OC9aY2pXa0IvNTBoZWxiMTVmc3VNMVRid3VEUndiZEF5a3FiR0E0RXhRaHJO?=
 =?utf-8?B?TmprT2pPYmNrOWxVYWgwZ3ZxaDRLNUk4SUwxS0xqa0lzSWJDMVMyd0hvZ0F0?=
 =?utf-8?B?S2RWS0Z0bnpqTTY4MDVXYlV5ck1GclBrNUtMUWJSanFIcG9WV1FLaFBxNFdU?=
 =?utf-8?B?TkYwWFpFWUM2RW5OS2R4S28zdWVmZk9nQ2o3ZjZjUGtqbEpKQ3Q5TXNycUJM?=
 =?utf-8?B?dSt5Q3ZaZXpWKzB5bDQzbWxjT21FZHhseGlDbGlsOElvN1Fudk9rS29saW9X?=
 =?utf-8?B?eitmbnZoRVBIMTJSc2xZdGZSVmNJR3FsQ2kyUTN4R25UUmtzUGEvdHY4UUVH?=
 =?utf-8?B?b0pVcTlEWFRkaVNlRzBWY0ZsdUNua3V5ZlpUS1lpWXJycDVQVTlDaXFSbHds?=
 =?utf-8?B?ZjJnYWM2WkVPVmJKQnh5ZzZxeVF2eWRieDB3LzBiZUl1SC9SakcwNWZXUTIz?=
 =?utf-8?B?SzV5cmMyR3ZlRTJPMC9uQ2lMc0JMdi95Uzd1TitRYTE3UGxtT0JmRmVlUU9s?=
 =?utf-8?B?YTFqaXV2Wm5zQTB3V3B5REhRVzdWdVc1bDA5ZWQ3T2tYMmlreXZjT2E3aTNL?=
 =?utf-8?B?b05LMSthdHE0OHdvd0Y1NlZROE95QklMTEVwVVlPeWQ3TysxdzNBb1dJWEZR?=
 =?utf-8?B?b2FiL21ldjF3ZlMrUk50a1JJZC9rMzNUTm1SOStNQUpTY29EQzdDNFZVZENl?=
 =?utf-8?B?YzRwcG1tQmZNWmpHTDhoblNyWlg3QmZOMW5WTUd6U3BHOEh0eUFveUZ4b0FH?=
 =?utf-8?B?SnkvNC9EeWdMaGtUeFZRQ3lMckVMRG00VXExenpEeFVBeElvZG5lZnZEUWo0?=
 =?utf-8?B?UC9CWGdrVFZORHp5ajlPU1FFZ3Q5Ym9rV3BMcmJGbHhqdVc1dGdOdmx4Z1Va?=
 =?utf-8?B?M0p4QWh2S2JTRVhTaFBJb2RSUUtKaEFsbjNYcG9uUGREeWZvejBvbXBJa2lV?=
 =?utf-8?B?Vnp5YlMvTWtla0JwQ0s3S3ptSkFRWHBzN2hjeUxpV1JaL1JqTWIrYUk2cnBO?=
 =?utf-8?B?czVtK3RvSlRiWk1qQmdXTkplM2JlcU5WanRSbjJwZnQzMFNhaEkraEpoT0NT?=
 =?utf-8?Q?NGV4ckgLKLxVT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWQyTGNaMFNROEFhak9FS3BqVXpRV1h5dzVDWEJWaVdSTksrNXhLK0lKTDIw?=
 =?utf-8?B?dnJQb00rRDhsL1plV3JuSmlneWZFQ1hsTk5UMmF3UnpvaDYydmlYdk81ZkVQ?=
 =?utf-8?B?QWcrZlI4WWFLLy9NRC9YbWN3T3RMQllURC8zRXVIaFZQME9RbURxNGMyOHpZ?=
 =?utf-8?B?ODdxUmM5Y2ZSNEJKTnc3RTZ5UVg3WklYWVByV0hLL245WUI4eEVldHh4V2hU?=
 =?utf-8?B?ckg0OUtVdGNSeXJGK2J6T29lSVFibWVtdGQyR2NPb29PK3Q2M2ZuanF1dkZI?=
 =?utf-8?B?ZUZXdE5LcjJJalZRSGdPc0xma0ovQlZiTllIQjNtWVgzWGxrTU9XMmxvb0d2?=
 =?utf-8?B?THFPdkRhZk5qUU5oZmVKeVlzVnNwaHdtWUU1QXRaSUhTMllUNFZlV1VwMEhj?=
 =?utf-8?B?Wlo3YU9SUXgwSmdSYUhISTFHakF1Y09yV1podnhPNUJOK0d5ejRzRlBuZVVK?=
 =?utf-8?B?MUFtdy9obXhnall6czhJRjgyeHpMeEkrckVJRXRwdzA2S3RKcHQwSUNuU214?=
 =?utf-8?B?RnVOcTlyTEpnOTZKYldoT3pNVkFrZ2VkYmVvWDJDMklmVkoxUTFLTmVYZ3Na?=
 =?utf-8?B?NlZERmlHMGJNWDJkeFp2N2puYzBLOFkvRytnRkRndkhsSnlMQVAvRXd2NmdM?=
 =?utf-8?B?a243V0ZSQjdoM25MbmJrLzBnQS91K2pIU08zcXowUEQxTzFpZk9FdXVjcTU3?=
 =?utf-8?B?RmlsWlhLcWZRUlJrWXh0SE1pVG9iamZlTHdrYUpSMUU4MnVJZmlGeWpWakw1?=
 =?utf-8?B?VmpoNGhWdCtGeFR0bXFMRTVSS05QWExhcmF6NWhDbEpKUHZ5bU5Jb0RxbUNE?=
 =?utf-8?B?WnA3aVZKSHp5cGtvNnNUNUpTRVVmaWpHSEVkSldrVHY1dUlGRjEzOWhUek0y?=
 =?utf-8?B?SnprVWlUSE9TQ2pya1ZhMFE3c0kzYys1ZjF5T0d3cVlZWkkrM0o3d1pvamZq?=
 =?utf-8?B?OG1TSWVHNHl3MUplMUdxcFM3dFdwZld3L2dlWVdUcHlTNTdKNGRqOXoyZDFH?=
 =?utf-8?B?c0wrYUhqNjhKdDRTdzVzNEJMVG5EQVc4R09NRHlKUElZSHB4ZWJKSjc1Q3Z5?=
 =?utf-8?B?WVdJM1VpL1NaeG5abDk2SlQwWUg0VXpUTXp0eFdDajBhVmRqZlFnZGphcCtu?=
 =?utf-8?B?OWRqUE1uVFBqamtYU2VSNG1RRnZFcEw2MkxLcVcxMTVoQlB1bUhCRTJTWUVs?=
 =?utf-8?B?aDhsTHhabjVERnNWR2JuSUpET0hrck52VmFHWWNkN1d3L3JRT3ZSUitxQ1Yy?=
 =?utf-8?B?VFR6RG8zOWkrZW5BZWxORGZmYVk2RytEbithT2ltazlCVWxpR3RrM0RORGwx?=
 =?utf-8?B?OWVBL1hZSzYxamIvSmlLdUNJYm9EeEFNR0svd0VRMS8xVFcvRVlzdHBNcks2?=
 =?utf-8?B?QXNPd29ZUUV0TnV2bmtjQm45SVVqekNVZGEweHJnYTh3WUNTK21Fd0YyNTBw?=
 =?utf-8?B?anRleEVjN1NONk1CYllrbDBhN3YzZXdLOTlpS3QxVkdBYUUxWnJEV015RGxu?=
 =?utf-8?B?TnFjTmYrb3ArNVJQa21JYXNZWUNwNjZGTCsrUTJaL0FJVDRQckRWS2FjM0h5?=
 =?utf-8?B?a2ZhSUlZNGxwZGpTWHVOSGlNU3BZR011M1ErVXBzWk53NXpCbzk5bm9PcWJ2?=
 =?utf-8?B?dlJCbjBZTHN5QjhnbzU0SEFzRkdTVlpTdzcyaUExenF0Z1RGd0RoSWxHNGR0?=
 =?utf-8?B?dEFteGVyKytRR09IWThpTnFNSnFERDJGek4vRVp3T29JdDBuS2hGUDU3TWRx?=
 =?utf-8?B?SVNOaGIybldnaWY4d3VweGQwMkN1WHZXdkt4VlpVRG5sdUFmbmxjUXZwUnhu?=
 =?utf-8?B?OFlCSFd3ck8xTnorTlhqeFZJZVkwRTlZNDg2NDNSMW01TDlmWnR6dW5VcWZK?=
 =?utf-8?B?V3dzOUtJY0piVlZZT1VBYVlJVnFMc2RNcmRIVXJiVCt0enljdGhPN1hleHdM?=
 =?utf-8?B?MXROMm9PamFxdFNvU05FZW9xbDA5djJ5ZG82cE55OWoyUjI3MENuajFCdzBK?=
 =?utf-8?B?NFBPUXIzTWdBVEZwaFYvS1R6UVJjLytxcWtySjJBdGMwMzhSa1JhVkRCdHpV?=
 =?utf-8?B?dG9OMlVoVCtmQ05UNGlsaGphRVM5K09hVWpsM2orUzZjQ0JmMjYrV3JZNWty?=
 =?utf-8?Q?aPFSPTpXVTyrF0IViDlm6JeJr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60959ad-a838-492f-b864-08dd45591cf8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 20:18:39.8407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuQqLMau8Hi3SHUmKebC3RLWi5LqMUu3YbBCiGLW+gW6T7/YWewHAqmpID0M1CIE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5842



On 2/4/25 12:33 PM, Robin Murphy wrote:
> On 2024-10-02 5:59 pm, Wei Huang wrote:
> [...]
>> +
>> +	if (err) {
>> +		pcie_disable_tph(pdev);
>> +		return err;
>> +	}
>> +
>> +	set_ctrl_reg_req_en(pdev, pdev->tph_mode);
> 
> Just looking at this code in mainline, and I don't trust my
> understanding quite enough to send a patch myself, but doesn't this want
> to be pdev->tph_req_type, rather than tph_mode?

Yeah, you are right - this is supposed to be pdev->tph_req_type instead 
of tph_mode. We disable TPH first by clearing (zero) the "TPH Requester 
Enable" field and needs to set it back using tph_req_type.

Do you want to send in a fix? I can ACK it. Thanks for spotting it.

-Wei

> 
> Thanks,
> Robin.
> 

