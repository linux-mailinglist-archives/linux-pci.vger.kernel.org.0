Return-Path: <linux-pci+bounces-27950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C0AABBA8F
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 12:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEF61884617
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 10:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B071DED52;
	Mon, 19 May 2025 10:05:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E2F1A2396;
	Mon, 19 May 2025 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649101; cv=fail; b=KyhWNKudoHR161A8Gr7NrGktRaMIWMOy+a3mujGAH37zIr0DjabHFoo+rQDUE4Q/Kl7mpyoT9w+o2HYK9uPIT99tr+VdAyj8epUN0VvURkqhZm7RbdCTXPW49y5a4132IsTFW5gcw5Fd7ndMPYkuZFTbzy//LZ137dlhWPYktYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649101; c=relaxed/simple;
	bh=Dwz9E+RLq7C0csgFxrI68CqsiDgKC+N+Q0kjt8PDuzQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cWQaJdC4g0FzyZlo1zk94MyBybKv1FHqVO9/317XbzbB9sScZHRv2w4BK1pEyup7o+ovbVaOFEvxoCI23zY2ekM0U4gY9xEwXiybyHlJKaySqikttbOzLboLABEnmeTBBiaC1dQkvvy0HtS/ABW/MAjD4cEdphLyeGTHjnUum2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J5cUeo006762;
	Mon, 19 May 2025 03:04:53 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46psykheuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 03:04:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtJDQCnAwh2cXrTOIMx1s02sXqwyMhVWECVjgts7eTcyMmX1erpmf8nMANEvF8IwxEEZE9lYKOg2eFZotXmBais701CJEzwp+qiKD811QtVTFTgWt4raVMmk7zOCBaD9yBjh3qd76bV/kSGcFjvfftRQxWnZQO8gzcMh03fKOtVeJxlS0ou7yqzlwgB0UFrnOPNi7gp24Xy9Ba/fVSlrCbV/H9A1hUakG8VWuZO2/ajhDA6ISHlnUepzrySeIlIUGaL95b4f0OuAPhseufg+L7t4/QJ+X9G92BxgNTiSHyUm1q7UNbJ514FXohu4q1BKVb7/3pMyzhz5KEZ0qfwfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iT/yaMNY4bvGuPKDaSAReEGun/HcX23AY89c6IKWVGk=;
 b=ohHduH/YSeyQFDU/3LwpDdt1UXvAUT1v0dD1mLgpkl10C7rStCgLqqRhB0jO6Ov/D+xkR0b+7xi0VherhxDqKMiIxnyxvYOyIVOtacGwLsQaEM7JdG/2j9dxbCpaMKYE+vVhoBHC9ZzshQBH1oCLIc3dpdsLO+bT8p0cDDll2bhd53oYCn+BCd6T6rOM6zcUGY4uX2g6jEjQxwXsreTmYTYA8mfckwUDVCjX+l1drTqBxWyrDdGhvPRvzLGdfRP/JQdNVbH2GgqYhOmBVOwSLLBfsVo8bhlD7P5jYaGY+9cb/88uv3amoW49BB7GBhP4Qbq7/BfxOyXR5LkPsp5oSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by PH3PPF73E424DB7.namprd11.prod.outlook.com (2603:10b6:518:1::d2e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 10:04:48 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%3]) with mapi id 15.20.8699.019; Mon, 19 May 2025
 10:04:48 +0000
Message-ID: <def9c0b6-88e0-4311-ae70-2da97f3cd6a1@windriver.com>
Date: Mon, 19 May 2025 18:04:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] PCI: Forcefully set the PCI_REASSIGN_ALL_BUS flag
 for Marvell CN96XX/CN10XXX boards
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Vidya Sagar <vidyas@nvidia.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kevin Hao <kexin.hao@windriver.com>
References: <20250324090108.965229-1-Bo.Sun.CN@windriver.com>
 <20250324090108.965229-2-Bo.Sun.CN@windriver.com>
 <5cxpg4biddw2lrz5vpebovckgb6qkhayxkmniz4nnxms76qovg@fhc3pzbyznyp>
Content-Language: en-US
From: Bo Sun <Bo.Sun.CN@windriver.com>
In-Reply-To: <5cxpg4biddw2lrz5vpebovckgb6qkhayxkmniz4nnxms76qovg@fhc3pzbyznyp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::10) To SJ0PR11MB5866.namprd11.prod.outlook.com
 (2603:10b6:a03:429::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5866:EE_|PH3PPF73E424DB7:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d3addf6-2340-4260-2aa9-08dd96bc96a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFlpK0xVTDZ2MjRYT203TkpyVGl0dmczWFQydGRocmtIR2FNVW1kV1RwbTZY?=
 =?utf-8?B?OHF4SFhFNnhmRmtxMUVEUDZrUDh5MUN5SW9EeTNBVW9vWEt4Um12Nmo1Wkxk?=
 =?utf-8?B?VTNSTXZZQ0lzY2FOMlhlSVJabDN2MXhpamZZNDVUNDNRck1zVDhsMEpkWUZU?=
 =?utf-8?B?S2dEZlczc2Y0aDlDU05IVmtudnlFQXF3c1hodjk5YjZqU1QrSVZMWm1wMlA4?=
 =?utf-8?B?Nk9yWG13ZXJ1Uy81NFhXTEU3VTNkSEdud0x2OFdxU3ptZm8zSlVHbGlSUzcy?=
 =?utf-8?B?eEN3eU5vNGd1SWJxRjhEc2V5NGNFQlZRS3BxOXEvOW9TSUIyamJ3SjBDZ2Zv?=
 =?utf-8?B?akpaTXF3OFpwVmtVdHN2K2VkM1ZrSXZnT2xoUUkyUy9FVEV6K09iclU1UHkv?=
 =?utf-8?B?ajJZTjJWU0JWbEkxL0FWbEVnK0VmRWFFQ0FqRDlUdjgxSjNDSG9GSnVMNHpM?=
 =?utf-8?B?enRlVHJFb1JkZUQ5ZmVqdzhsZ1hIdFB0cmFBTXlKSkxGMUZBZ1pqdlBtSlRm?=
 =?utf-8?B?dzFzclJiZExCTXViemg3cUZXU0FDQlgzSXpFWEtRV1hURUxLeDFmY1VIQUZ0?=
 =?utf-8?B?ZDFkeDJjNUs1WGg5TTljbkNTTkN2cndXMnk3Y1c2OGowM0RwTEFwNC9mT29z?=
 =?utf-8?B?UGRQSEFPVVlJU0NiYm9peTh3dkVvWWxSS2FBcnFIM0pJU3M3S2lma2lKVVBk?=
 =?utf-8?B?WlNZYnFPcmp1TDlOc0lCdThZcW9kTzNyOEgzYVpyenRKZkJCd3ZBcVBZbjR2?=
 =?utf-8?B?VEhTUnVvYUZlYStUNytXNkJHZ01lekJwMi9QVTlwQ0NrWDk1QkhSMHk2Smd3?=
 =?utf-8?B?QnBaMlcrbjg2UHV6L05sKzZUZ3BVall5YndXVmJ4SDJvanVaRDJyYW9pc0Nt?=
 =?utf-8?B?dWNzVVV2d0RaVUpFTWVXb0JqK2hVY1lHOEs4cWp6RHlDcTB3OVQzKzVxU1Vv?=
 =?utf-8?B?RGdqcHpBZGlPaWFTamI0TGRZaXJMQjBxY2U5dGIvQkpUSndyMEh3NU1Dck1L?=
 =?utf-8?B?QUVXT2NINDhzbFEySTRVTGhrR2ZNNkRIbDg2ZWhUckZBY04zNUp2RThxcVpn?=
 =?utf-8?B?SlFTWmlpZWQ1cS9kWnBsVEkwUXVmSWJOQ1czRVc5VlpWMUpEV0dmaDNpUUlD?=
 =?utf-8?B?SnQ3N0ZNZ0h3TFZsZWJ6VGJWRTVkT0RWUENlU09VMHJWWGZqaG1uYnZicEVp?=
 =?utf-8?B?djNib3A0bzdsZ3M2RDR2MGpNaEE0d2VmejRPKzhRK084ZzNKVFAyTXI2dWE0?=
 =?utf-8?B?VnJhTEs0L3p3TVFtc3RuNVNOVitFUTRNeG9LWGpTZWZGUjRmMlJPUzUwQWt4?=
 =?utf-8?B?LzdpSU1Ra010KzJCblZNTjU0RkVianhuMWVMRGhOMjJabTFjYVJGMmdnQkRR?=
 =?utf-8?B?anRCYkwwZ2N6K05rVWVzTWdoaEQrZU9NZVF0NTNhQUtORDIvRnpST0hOVDNr?=
 =?utf-8?B?NURLNm1nQUZ6TDR6WStFaEkzTTh4Ym1va3RaRktmekN2N2dST2ZIeEIvenV3?=
 =?utf-8?B?ZGdBNDd2OEtweEZ1RDBmbE9xbGJBSDlaVEwweFQvVWlOMFcxNDU5STF5aTJY?=
 =?utf-8?B?c2JGT1N1N3YwS2IwNjRqS1ljTE1Od016WjJ4NUk5amNNTXY1a1pxb3BjaEND?=
 =?utf-8?B?bHFua2lCSlRnekpGMTJvOHJIZUtNazFJdVJkOEh2ZmxuS0ZNZXJ1U0hNbE4w?=
 =?utf-8?B?N1ljYUNxUHZBTC94L2NRL1UxZnJzOC9NU3IyM2U3WHI3ckhIaFkwaDRCV0J5?=
 =?utf-8?B?bUErYWlmYS9lZm1PV1Z5bk55c2FZeDhqT3d1Q2dabGJSMUcrbW9MeHI5YTB6?=
 =?utf-8?B?bE1MRDV6dGhib0o3Q284NnBjQlNwak14Q2oyM2FONjBMVUdxRGJBenBRRDNF?=
 =?utf-8?B?alV6eTRHUWw2K3BYT0ZzVWl0cnZTWU1rcGpseFhhQWJJa0lmYXNJRFpoUWg0?=
 =?utf-8?Q?u6/Lq9653YU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODVuWGlwS2dZT29jVVpMaE1vUkpHUVlha3cycGFVTmhvVDFwdVA1ditnc1dF?=
 =?utf-8?B?dWpMQjNROTJiNllQMDFWbnlrQWc2ek5ZOXMvK3FsOTlncHY5eVNlVGttZ1I5?=
 =?utf-8?B?N2lhUllIWVltQ1kwYTU4ZUxNVEk3SFhlUGd4TXVNbFluSmRNbUpDQk5lMCt4?=
 =?utf-8?B?Y3pVMjF5RHQwam5nNUFrU214R0xuRU9na3YrR3hkOFlOcWVSNmYrY05mZ2c5?=
 =?utf-8?B?YVd5MTcwN3dlR25CY2FqbndobTAyenR2d3lpdnlxbit4djFEZkx3WWpQYjlh?=
 =?utf-8?B?alMwbng0TEF3amNNbVQyengrQTFmNk11OGJsREYxZklCQ2MzcFN0RHRtb3Q1?=
 =?utf-8?B?aHN2Z3FtMVZuOTJSZkIwNHNpQmFWTlNFdGRTR2JDTHkxV3E2aFNGZit1NFdk?=
 =?utf-8?B?Q0Nyb2N0MG5FSGVwUE5Wb212NldiREtqY1pmNytzZmJFMC9FVlIxM3N4aXN4?=
 =?utf-8?B?SjFUR0dwK1o1TzAzKzlFbVhXc0IzSjBaMnkxN0dpUTVNem9BRUlwMlMxTFVr?=
 =?utf-8?B?SFZ6eFJZSW4ySFltT0dsYkJWZjcvT1BHRWRMTm8wWDErNWtNM3crSjFmRjNq?=
 =?utf-8?B?cFBkbUdNaWxzZjJTUDJZb25uY0pkTVZLWDlqUCsvSVdKNS9wVm5aenltd1Q5?=
 =?utf-8?B?SHVlSmtYN3phaDMwU0szcnlBZTE5WnVDMVN1aWV5L2lMcm5jOFJESk85WWNX?=
 =?utf-8?B?aE9FeVRVQjYxMXJrV2VIOVVjQndGNGZJWndteTdkK3ZRRE9PQTVIT0gzeTVs?=
 =?utf-8?B?NFFTS2pjYzJ3SGlUbVBiaDdVZjJGcXRFYnk4cG9abWFvTytqTFc2czUyMTRq?=
 =?utf-8?B?YXE4VFZoZXlRdjRyc0taQ3B1N1VzejFyS0hZYWFMWGN5MHBjUWR6WGZ5Vk1n?=
 =?utf-8?B?L2VIQTUxWllHN1p3UUp5ZmFCQ0I2dXB4dnJreFN6YmlGanZ6ODZMczJjaXhI?=
 =?utf-8?B?Rm5SUzVxVmdBUVhvMmtmZzdJNjBmT0VvbUF5YytzS090MW0rRkw2dXYrejho?=
 =?utf-8?B?SEhyZEVJaHJ1bjJVUHhzVVRaUzdCTklDa05pUUlnM2dxN2tBUXg0cjJNc2Nr?=
 =?utf-8?B?VU5qVXZmOVAxYU10NXErdWEwUlM1WVBDb004Ym90bU1UM041aDdGZkE1dU0w?=
 =?utf-8?B?UHMzcmRIaUdwL2ZLUEFPN3M0RXp2QnVadVppOUZyWVZ5RFI1S1gzbnZpSkRj?=
 =?utf-8?B?S2JRMzR2ZWc2R2NiUzFISlBWNVVybThyMjlibnpaNlhCSWZLelJJd1RQWmc3?=
 =?utf-8?B?elRlNHhyWXVYZW9mVEIxQkhKQ0dWaGZzSVdJcHlLay9qTlowYlY1QjgyWCs2?=
 =?utf-8?B?VWExYWxKWFBsSnBHRmROUkMvczI3UzBoRU5OaVZOKzlrQTMySURvK3FTTEps?=
 =?utf-8?B?SzN2ZnkrTDlsZGhDc29kQ2lMUDZIWHIyaE9QZ0FqWW54alh0c2NoMGJVOGxq?=
 =?utf-8?B?SlpsdThESUN1R2JkbTdCNXdkOERLSXZBOEFzZ0RBTkJvRWc2ZlpxRFRDc0tu?=
 =?utf-8?B?N0pnTEJFNGt5U0JxN2pTcmZ2bDlyaU1vak5pUUNHcHdUc0RGWEFUT1l6Z2k0?=
 =?utf-8?B?Z09ldE1DSEZMQUllaE94UHpBMStMcEJMTW5NUEs4L3RpazlVRlhQckRFVHJU?=
 =?utf-8?B?OHM2TTJuaGsrSXNuYU1zMkRlN0xsVmlkNm5NK3Q0OXR2NjZkQUpSaEhBYlFk?=
 =?utf-8?B?TTgzRTQ1Y2hYNXR3QVRiVnAzYXlNckY0UkFuRnJCMGwzZVJOWWlDTzFkWnlY?=
 =?utf-8?B?TnBXYm52ZzZza0dXTHVpeE9tS1Vpd3lQWVJwSEVwWE5KYWJLL1FuZWd0TjJx?=
 =?utf-8?B?eERzYnR1MzNTai9HZzZXNUkwcG10d09YUWJVWWNEdHZjQ2xhQ0luRGpkNk56?=
 =?utf-8?B?TzNIaXlWM0R6cWNDMS9aOEJ1OVhMbHVTS0llKzR0MXBRak0zQlFFbVc1aTVX?=
 =?utf-8?B?TVFsK0VhWWJvV1N3R0Z4RnBwb0FDVjZZTWdLWTdHYW5yN0R6UXo2SitHam1y?=
 =?utf-8?B?VUk0SDVGZGpJUi83YnNERWhiMlg1VkdGaVZUUHBCeE5OdDNDK2x3Mk9PbXhX?=
 =?utf-8?B?dDc2TTI0dEdBUE1jNjhsVEtvdnc3WURGaXVma1JxUkE2YlB3bEd0enRRSmNI?=
 =?utf-8?B?TFUyc2prL0FJNHd3S0hnRlZXSExqNDVCNjljOXdETUJsWWNBNmc5YmF0UCtZ?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3addf6-2340-4260-2aa9-08dd96bc96a5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 10:04:48.3120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4HMqU3c5L0gDmHQkXPEYSfnIvvPcZTospwIq6gVu8oPaLn5Su6z70mAWukAVhP1nLD8iUNPAluuf8+AsEcm0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF73E424DB7
X-Authority-Analysis: v=2.4 cv=a8kw9VSF c=1 sm=1 tr=0 ts=682b0244 cx=c_pps a=1OKfMEbEQU8cdntNuaz5dg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=KKAkSRfTAAAA:8 a=QxOqiKONpWog53bRl6MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 4EPlV1sOVfqUwdmJoOPfx_cx7wSxaX-1
X-Proofpoint-ORIG-GUID: 4EPlV1sOVfqUwdmJoOPfx_cx7wSxaX-1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA5NSBTYWx0ZWRfX1Bj+6m9Z+k4J WCdNkU3M2p3pC1Si1ZcnSg2dFhrXF1TLbngByZ6dOR4WFMxHBXHVsOrUqDKoKQfOZ77Nct2bah4 wDgnVIcRypDVqi74rr9fLinoDiXkRDUkGI6MkYOi+HgaBE3sR+23Nr73tpWc7gdzAnzlX3Bcc/w
 BXlTXjeGyhQo68xS+N4LxZtCE57v9HRjYwzB8IJ3rAkgsvhYxlXDwQy+uzzZ4jjz5t4mRA7Eeca wsMqEmBOnIkWHACzfTM7p16EUqWqwG+PJTRtZjITDMclkJZX0xebAGUpQ3E1NY0sXVoaRLo3Uf9 iRSyhQUgEYFIUgd/Fu5i3oS/YCWLomCpgcbabSZXmQse1X05BdrG9lxsAcWFxSji65nTEr4so7B
 08lnQUDRjLvOsQHS+2+anZsu146FSoxID+h3JvCUcDdQ4TKjniQfNQEDZg4xaU55CqnQXNwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505190095

On 3/28/25 00:37, Manivannan Sadhasivam wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> On Mon, Mar 24, 2025 at 05:01:07PM +0800, Bo Sun wrote:
>> On our Marvell OCTEON CN96XX board, we observed the following panic on
>> the latest kernel:
>> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
>> CPU: 22 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc6 #20
>> Hardware name: Marvell OcteonTX CN96XX board (DT)
>> pc : of_pci_add_properties+0x278/0x4c8
>> Call trace:
>>   of_pci_add_properties+0x278/0x4c8 (P)
>>   of_pci_make_dev_node+0xe0/0x158
>>   pci_bus_add_device+0x158/0x228
>>   pci_bus_add_devices+0x40/0x98
>>   pci_host_probe+0x94/0x118
>>   pci_host_common_probe+0x130/0x1b0
>>   platform_probe+0x70/0xf0
>>
>> The dmesg logs indicated that the PCI bridge was scanning with an invalid bus range:
>>   pci-host-generic 878020000000.pci: PCI host bridge to bus 0002:00
>>   pci_bus 0002:00: root bus resource [bus 00-ff]
>>   pci 0002:00:00.0: scanning [bus f9-f9] behind bridge, pass 0
>>   pci 0002:00:01.0: scanning [bus fa-fa] behind bridge, pass 0
>>   pci 0002:00:02.0: scanning [bus fb-fb] behind bridge, pass 0
>>   pci 0002:00:03.0: scanning [bus fc-fc] behind bridge, pass 0
>>   pci 0002:00:04.0: scanning [bus fd-fd] behind bridge, pass 0
>>   pci 0002:00:05.0: scanning [bus fe-fe] behind bridge, pass 0
>>   pci 0002:00:06.0: scanning [bus ff-ff] behind bridge, pass 0
>>   pci 0002:00:07.0: scanning [bus 00-00] behind bridge, pass 0
>>   pci 0002:00:07.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>>   pci 0002:00:08.0: scanning [bus 01-01] behind bridge, pass 0
>>   pci 0002:00:09.0: scanning [bus 02-02] behind bridge, pass 0
>>   pci 0002:00:0a.0: scanning [bus 03-03] behind bridge, pass 0
>>   pci 0002:00:0b.0: scanning [bus 04-04] behind bridge, pass 0
>>   pci 0002:00:0c.0: scanning [bus 05-05] behind bridge, pass 0
>>   pci 0002:00:0d.0: scanning [bus 06-06] behind bridge, pass 0
>>   pci 0002:00:0e.0: scanning [bus 07-07] behind bridge, pass 0
>>   pci 0002:00:0f.0: scanning [bus 08-08] behind bridge, pass 0
>>
>> This regression was introduced by commit 7246a4520b4b ("PCI: Use
>> preserve_config in place of pci_flags"). On our board, the 0002:00:07.0
>> bridge is misconfigured by the bootloader. Both its secondary and
>> subordinate bus numbers are initialized to 0, while its fixed secondary
>> bus number is set to 8. However, bus number 8 is also assigned to another
>> bridge (0002:00:0f.0). Although this is a bootloader issue, before the
>> change in commit 7246a4520b4b, the PCI_REASSIGN_ALL_BUS flag was set
>> by default when PCI_PROBE_ONLY was not enabled, ensuing that all the
>> bus number for these bridges were reassigned, avoiding any conflicts.
>>
>> After the change introduced in commit 7246a4520b4b, the bus numbers
>> the misconfigured 0002:00:07.0 bridge. The kernel attempt to reconfigure
>> 0002:00:07.0 by reusing the fixed secondary bus number 8 assigned by
>> bootloader. However, since a pci_bus has already been allocated for
>> bus 8 due to the probe of 0002:00:0f.0, no new pci_bus allocated for
>> 0002:00:07.0. This results in a pci bridge device without a pci_bus
>> attached (pdev->subordinate == NULL). Consequently, accessing
>> pdev->subordinate in of_pci_prop_bus_range() leads to a NULL pointer
>> dereference.
>>
>> To summarize, we need to set the PCI_REASSIGN_ALL_BUS flag when
>> PCI_PROBE_ONLY is not enabled in order to work around issue like the
>> one described above.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 7246a4520b4b ("PCI: Use preserve_config in place of pci_flags")
>> Signed-off-by: Bo Sun <Bo.Sun.CN@windriver.com>
> 
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Hello all,

First, I'd like to thank Mani for the Acked-by.

I'm writing to kindly follow up, as I haven’t seen it merged yet, and I 
wanted to check in on its status.

The issue the patch addresses is still reproducible on the latest 
mainline kernel, so I believe it's still relevant.


Thanks,
Bo

> 
> - Mani
> 
>> ---
>> Changes in v3:
>>   - Make 'PCI_REASSIGN_ALL_BUS' unconditional, as suggested by Mani.
>>   - Update comment as requested by Mani.
>>
>>   drivers/pci/quirks.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 82b21e34c545..787a5e75cd80 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -6181,6 +6181,19 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
>>
>> +/*
>> + * Quirk for Marvell CN96XX/CN10XXX boards:
>> + *
>> + * Adds PCI_REASSIGN_ALL_BUS to force bus number reassignment to
>> + * avoid conflicts caused by bootloader misconfigured PCI bridges.
>> + */
>> +static void quirk_marvell_cn96xx_cn10xxx_reassign_all_busnr(struct pci_dev *dev)
>> +{
>> +     pci_add_flags(PCI_REASSIGN_ALL_BUS);
>> +}
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_CAVIUM, 0xa002,
>> +                      quirk_marvell_cn96xx_cn10xxx_reassign_all_busnr);
>> +
>>   #ifdef CONFIG_PCIEASPM
>>   /*
>>    * Several Intel DG2 graphics devices advertise that they can only tolerate
>> --
>> 2.49.0
>>
> 
> --
> மணிவண்ணன் சதாசிவம்


