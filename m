Return-Path: <linux-pci+bounces-8928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2890790DBE7
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 20:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB54A2836F5
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 18:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D232C157A41;
	Tue, 18 Jun 2024 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Rtj8SvJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C311147773;
	Tue, 18 Jun 2024 18:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718736699; cv=fail; b=C2r66+7QCoeckNK/HpvhfgdC2e/jBt/QWAH2R9Aa1O9IzhZiz39BKENtwznBgv3KMpVTCMrqO6YD8Wv/kId7G9UaAiT7sSDGXLolT3IOfgLrYJix4UW18NeRjqw463cZlU5DEOgyQuFM1Mx0y1qxTDrMWMtlP+oA1uwEFej5LCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718736699; c=relaxed/simple;
	bh=jjTxPR90Ckw8ze+b04Jo4MWsawALpO/NEgpBYUnqdfA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=C3pff+xck5gQFazKPtyFFbfC6EUO/P53jI2mb2EtxfzbXLQg+TYHBn3sbilkmEb3g5fRC+CcAZXPNnGuHtOfWllJl3BYEyJkQj5sMscxkMhm2TVS5RKPJsySZEep31Z8skpXe/AcRXPbeh3PHmzapFN33/DZoZw0D24f7S+dRJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Rtj8SvJ; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpUUjHfHMG+eOxcifhHvFcYrHXGRL++DlddVF50W1poIgi/Jf2o9l51FPSxPo/EoM6rmTNs4JJ0LLzZrG16N5XHQ5U4RrmutOizRA6bvH5g0iY1Wpxyou1ap19ATpgb8b5Rp/RRPbRA4o4F4oh2qOb+rJlk2j+HyDlDqB6FN7bdo/vreeCclG3DFHf52X4ShKc611LBjyse4s7yGE0OQRqsNqGTAqvFMvdsCdOlO6hBQwb3V2Qho7UX+53kZHxrIfxW1I/p6KyoG9iNVTOvU6YVW9mcKKyO8qm3Ig/l31P2oQd/L9WfEYmr51VTN1luVc20sL3LyDn+8FEY7Q3cT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okgzQiQBuMU7KvjgfIGOrHB9Fd3fOLQnRSZEmlJxdBs=;
 b=dCd7l23pwQBmbzdOQKW1f18cfcL9NTqarZNGP27sn/ekF9+RrmI1TIAu4x/iEEIiYONbox170iEZ0VYSZi5zQTdR26xH5SjoMxtOnB99IqOJrVLKfO7XOVFcqjmusgZwsN1jtNxV/ZWyi4HLbEwYDloOCP73X6iNJt7cWcBieO5rr14MJQoqF0fd/ng8GKNP78LChrFfM42sYIKOvyTjZ8tZ1maHfR79tXAJ9QuaXuFhgk0jOtgRYjp2213gkQImEK/TS18GiUqi9B7PxhNaiZOSpQP4NeQ6+6dXln0d5aK51DQVHCMABdAUXqXiM2HyK2dYaH347lDtOM+pP+l+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okgzQiQBuMU7KvjgfIGOrHB9Fd3fOLQnRSZEmlJxdBs=;
 b=5Rtj8SvJSJICJ/+uEKBZQDGC/BKx2rY4xCnKqu6B5i/03M9a0CtKJmaZwl6PZ/vphCm6n2KX2e1vuS3eeyDCs3HkcyvT2c6S3G0q9KKO4JN4W8BmAtV7gbM/Fw37FD1Bg3YGVn/RPaCvaYe0HRzrjgP/mHzr3U4CkaD2hpp4KcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 18:51:33 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 18:51:33 +0000
Subject: Re: [PATCH v2] PCI: pciehp: Clear LBMS on hot-remove to prevent link
 speed reduction
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>,
 Yazen Ghannam <yazen.ghannam@amd.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Bowman Terry <terry.bowman@amd.com>, Hagan Billy <billy.hagan@amd.com>,
 Simon Guinot <simon.guinot@seagate.com>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20240617231841.GA1232294@bhelgaas>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <27be113e-3e33-b969-c1e3-c5e82d1b8b7f@amd.com>
Date: Tue, 18 Jun 2024 11:51:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20240617231841.GA1232294@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0147.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::32) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: b56582c6-661d-4946-58a8-08dc8fc7ac80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1E2S0YwaVRDL05lSS9uVkpacWdObFlRNlZvQm8zZGd2aUIxNGU0UkZDTGRS?=
 =?utf-8?B?TEF0UGJlcFJMeHBoSnIwWGZwVXBxWlk0bnZkblpLT3A4TEVFUVBmTzVkMkps?=
 =?utf-8?B?YkFmTWZ2UitJdCtSdzRqcjgrRmdCcythVld0cjBld082dUR4SHNtZ2l0WlBa?=
 =?utf-8?B?ZWZ5UHJoUVNXNnhWQU5UdnF4MkZrRzIrTisvSHNFQkFCNE10T1ViNUlXUHJY?=
 =?utf-8?B?alc1Qm1IUkwvMkRDZ1Jxekl0cG1rTjlwVXMxZ2RuMWoyMzU3cHFzaU0vVlVP?=
 =?utf-8?B?YXdycTlDK2tuM3BmK3JhMmEyNk5WYmYrM2RyeUxVUTJmY0Vzb05Ba3FEZmtU?=
 =?utf-8?B?QjJjYWlqMUVvYndnZkFkNlFvSmxuMHNaczFsSTRKTXBpU3BoT2RzWmdoK0Fh?=
 =?utf-8?B?KytJZ1YwaTNFSmxlVnc2bDNGVnZpN2pia1VtWEh3N2JhZnRERUZQbXVFVWla?=
 =?utf-8?B?eDIxeVZ1eGxDOEsrMzgrWnJkT0h5RS84S0ovS0R6NnRIM0lFVUhKaXpsbmJO?=
 =?utf-8?B?OU5TRnpJWkNsZ0p5VnEzc1JSTnN3U0c3dGJxellFRS9HQmRtWjBTWnVDbFNa?=
 =?utf-8?B?aHZxT2k1T2owV1c4aS8rUG50bnNGUCswN3dnZVhra0FDZHRKdHk2d1lyZmRj?=
 =?utf-8?B?a1hNeTFuaGxZZ0xyOG16V1Fzb1pFSmNoSUExTU95Um9MVDVmcGE5RU5VMTRJ?=
 =?utf-8?B?V1RYQzFON1F6UmNoMXZvbnZFbTFpdWFlTzN5QkZ4MmhVc0EySkJOckJLcHVy?=
 =?utf-8?B?VHFrOG55amJPTXh0Ym5ObENCWnVVcFBtb2JDWURnL1E2dE1iTnQzTVVhMW54?=
 =?utf-8?B?c1FyRU00NHdzS1RwYkhNaG9uRjJ0SXU5blhOZm9tVkQvN2tLUjZvQ0NGdHpr?=
 =?utf-8?B?YjNsNmo4d1Y2c2pTenpPTXY1S1RHM2hQeTJocnRJT3NKdmxkeXZlWGtDbGdw?=
 =?utf-8?B?dE1OUzJUNHFpQnFpU3ZPYlphZkdhYWVJRXJpRkd1bnQxeEhEVlNkMUxnMVVh?=
 =?utf-8?B?cHFUMTh0dmt4b3VJc1VIUWpGbHBDSkNGYkFOY3B1KzR0bzJPMFpGTlJJTEhT?=
 =?utf-8?B?Z1ZRejhKRzhyWTNySm02ZmJUUVBTQ3FnUVJjQ05mUEpXS3ErbzF6bjhlN0Z4?=
 =?utf-8?B?dkQvWnZHbTR1VnpTMSszOW5rVWIzVTVaeXVlMlFCaHBWbnd4UXZtT3M1aWFa?=
 =?utf-8?B?U2FWREd4YWNKcGxtSTJ5Q1BodDdqSHduV1NsaUk0UGNkenVCZnIxby9xQkZW?=
 =?utf-8?B?aTRhRDZISWtVaWYzd2c0b1NQcGUzSkkxZXkzVUxYRmFtU0NWeXplYjY5bXNR?=
 =?utf-8?B?cDRySXJMUWoxbUNUTXdIREtLUjVpczdYM1NWbVN2c3lmSXZ1SStHb3hQV1Vl?=
 =?utf-8?B?ZTNGd28yeHJBbWI4dExJa2J5M002bHJyM1RuUmE2ZzJuK3YreEptQ05TMDJI?=
 =?utf-8?B?cnMrY09MOG5KaUMva3hSK3pqZHNISVFiWDVCVDltdDRIMVhoZUJsY21Dd3Q4?=
 =?utf-8?B?Z1hRNWdCdnA2Zmh0OTV1WCsvRFRVSDdKYnd6eEtwQmFTVG5IM1k4V3ZJeWI5?=
 =?utf-8?B?UHhlTEdzaGRoZC9QVEFvVXVCVCt0MEZxZ2hQdGpra2JGT1luRGM0a284dDNz?=
 =?utf-8?B?cDRISGRyTkhjWjRDcy9ESDZRb2hveDVsZ2pQVE9UUzk5djR5QVhBaC9VUjl6?=
 =?utf-8?B?NXdMUi9sVk1QL2dNNFdneExKWDhuTEVQcDZqK05McFJXVjR5dmsvL2tnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OSszbExhZUdJSFFab1lsTU5hUEQxcDNud3FOcTFpY3E2R2dzYlFud2Q2eHZD?=
 =?utf-8?B?M0ZzaFJOUzM0T0NnZFBNOTFLaStVMjUrQlI0VTgvV3lnZ3FodnpQZXZWMk5m?=
 =?utf-8?B?SHRubENFV1ZYUzRuYzYvamxsZjcvU1RjTUlXUkJEZ3JiN0JqcC8xQmtZWW51?=
 =?utf-8?B?cHpmWFpVQ0Z0UFcyUmhnTFgvc3FOWTZYdDhMSTRLOVB1cGVUeUJpR3ZvanRi?=
 =?utf-8?B?RjNrZk0wWGsrVGtubmlBeDQxTWhyVjk4aDZFTFBWZXFWOGNRc3A2eGFielpR?=
 =?utf-8?B?bTB5ZFpOdXY4a1F1aW1JL25OaHJLcGtvZ1ZhU0V4S2ppa2hSNm5vQ3M2MXV0?=
 =?utf-8?B?a2RCNk1VbFh0UTkzOGdXYjl5dmlPcFk3VSt5UjhMbE9LVmtKQWs2cmcvU1VH?=
 =?utf-8?B?M1JnOFMxcDVQb3B2bnVUNUFSTFpOOXg1S2lsMDEvMytxdzFwWWFISG1LQlpt?=
 =?utf-8?B?bUJ2NXBjUHI4ck9XKzg5WWRVSzRWbUxCUS9waHdKSmppcDNrT29Ta3hNZlZn?=
 =?utf-8?B?US9RZHlWZUJ0Z3NiSEdtWHNhbG1BWnZFMTVDSWRMMzBLOWNVUWN3a3JCemdV?=
 =?utf-8?B?Y2gxNWFDay9lUXFNbms1RW44dDFnL1A5MmdoY0p2Z21HUlkramVkUXpJSk1V?=
 =?utf-8?B?Y1UrOHBMWkZvVUhqcUVFNlRCeGdQZENJamZVWTRBQ21RK0c5UE9qNkYyeU4z?=
 =?utf-8?B?bElGV2Nra1FNbWxGUnFjbmlXK2xibWNDU1gyMzdiL2V4amh0U2lJVnk0RUpp?=
 =?utf-8?B?ZU9YRDNMVVY5eG1IaUZaYmROb1lsWWRhNkRpWFgrR1NkYjFxREMrSkJndzFB?=
 =?utf-8?B?emtqQnRhOXlIeDZNWVZHaUdZYmt4QndpeWN1SHM4T1QyQ2hiekhwMTNkOWx5?=
 =?utf-8?B?WWdkc0U1d1lnQ0NWL1AwSFhMSFExUGNFTG85UXdBcjhFNjZKWmpYVjV3UDdu?=
 =?utf-8?B?WTdKOHZjaVhRclZqbHc5YTNaaTAxUXVVcXJyV1pEMmtHaG04bG1vMmFGaS8v?=
 =?utf-8?B?RkwvY3BNME55a25mbkJob2ZvYUdCVU5nUDJsbmhkVXBrUC9KYjhZVm9WR2lu?=
 =?utf-8?B?NGZmQ2puTDVBTmxDNmlydUh2NDZkdk9haE1UR2F6dnUwVlNoUGNDakRsVU9Y?=
 =?utf-8?B?NjFTaHlBNHBXeERhdEZRTjVWQnY3OVkzejVmREpRTXdubEZEdUtudFJOeDVl?=
 =?utf-8?B?SG9MMGVPKzJMZ1diaXVlM1NaTUxNN2k4VExOTG13QSs3VWZKNzM3Qnd6cDlM?=
 =?utf-8?B?bEpxOXc4K2RTK210NlRKSmY2cVVyQ3BmbHhBdmdSMkhJeEQzanVHQWFPaGZH?=
 =?utf-8?B?c2c5VVBiVEdvd0s4dlV4K2Vta0N0L21rK3RhNmszTjhUdzVEYWo0azhzYXhq?=
 =?utf-8?B?MHlwUXROTFVGdHRjYW0zVytPQ0h0cXpDVWlMR0dtL2tEVGgzeEZUTzhUNGoy?=
 =?utf-8?B?VmhxSWJRa0FrZ2I1Y0gvMDgyOWhRMlQvMEQzZVdlNGRUcWFLQWRiTmdyU1lH?=
 =?utf-8?B?TnZ1RmwxaHFtT2Z6Tit4MmcwL2lRNGo0MUhsV0JQQXJxeUNWQmhYMkVUVWFL?=
 =?utf-8?B?OG9iRVFDU0tsMk5CSlBkU0N1T01TR1RxYzVLNnN2bjQzK2tmdldlTGR0cy9w?=
 =?utf-8?B?bXA5OTY0Njk5dFFLMkpsOW1qcmhNTjNwbGdsbjQ4YVhmbGlwM2xWVis2dW8z?=
 =?utf-8?B?M2xlTmNzWm9EczVWYXBwMUNaV3lybTQrcVh3Q2JCNG0xTUhpMkhNR2UyTVlw?=
 =?utf-8?B?Y1dsdTdac1NFUGFpdzhlNS90WU9RWkpVU2hNYVB6T0Q4UVI3QnBBNUt6R21s?=
 =?utf-8?B?UENYem51Q01ZRXVXUXcwd1ZnT0pOVEluTWdyYTJRR0F3TUVNdTB2dnM2LzFU?=
 =?utf-8?B?Wkc0NW8vUjNhMzgvb1EyL1NaYTFuU1ZBZjhHTnhncjBGN0FPM0tiaDJKNkNt?=
 =?utf-8?B?M2U1bEhJTVYreDdabTZYVWlXcmxsYXlGbCtncUJBeUg4bVEvdlpFTlhmNmI2?=
 =?utf-8?B?c3FPdGdqWlFIZVpTREhhc2o3a0xIcHJVYVFVMlpXTjRTTGVTdng0eHZKYmlx?=
 =?utf-8?B?cjNURk5pa25IWlF3NGJIdllmUjR2V0RXUThmMFdWVW9hbEQ2clRHZGcwNzFh?=
 =?utf-8?Q?y24zBglu5rFQ/bl3gY+WKzyE3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b56582c6-661d-4946-58a8-08dc8fc7ac80
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 18:51:33.6735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sw39WeAhXSiUFGivNhBCWVvgaTR8f4u6kpjHfXVPHMX3SdRG1yVGs6U/5FUyWMQJn0iqMyUSsfofQhCZKQg0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213

On 6/17/2024 4:18 PM, Bjorn Helgaas wrote:
> On Mon, Jun 17, 2024 at 03:51:57PM -0700, Smita Koralahalli wrote:
>> Hi Bjorn,
>>
>> On 6/17/2024 1:09 PM, Bjorn Helgaas wrote:
>>> On Thu, May 16, 2024 at 08:47:48PM +0000, Smita Koralahalli wrote:
>>>> Clear Link Bandwidth Management Status (LBMS) if set, on a hot-remove
>>>> event.
>>>>
>>>> The hot-remove event could result in target link speed reduction if LBMS
>>>> is set, due to a delay in Presence Detect State Change (PDSC) happening
>>>> after a Data Link Layer State Change event (DLLSC).
>>>>
>>>> In reality, PDSC and DLLSC events rarely come in simultaneously. Delay in
>>>> PDSC can sometimes be too late and the slot could have already been
>>>> powered down just by a DLLSC event. And the delayed PDSC could falsely be
>>>> interpreted as an interrupt raised to turn the slot on. This false process
>>>> of powering the slot on, without a link forces the kernel to retrain the
>>>> link if LBMS is set, to a lower speed to restablish the link thereby
>>>> bringing down the link speeds [2].
>>>
>>> Not sure we need PDSC and DLLSC details to justify clearing LBMS if it
>>> has no meaning for an empty slot?
>>
>> I'm trying to also answer your below question here..
>>
>>> I guess the slot is empty, so retraining
>>> is meaningless and will always fail.  Maybe avoiding it avoids a
>>> delay?  Is the benefit that we get rid of the message and a delay?"
>>
>> The benefit of this patch is to "avoid link speed drops" on a hot remove
>> event if LBMS is set and DLLLA is clear. But I'm not trying to solve delay
>> issues here..
>>
>> I included the PDSC and DLLSC details as they are the cause for link speed
>> drops on a remove event. On an empty slot, DLLLA is cleared and LBMS may or
>> may not be set. And, we see cases of link speed drops here, if PDSC happens
>> on an empty slot.
>>
>> We know for the fact that slot becomes empty if either of the events PDSC or
>> DLLSC occur. Also, either of them do not wait for the other to bring down
>> the device and mark the slot as "empty". That is the reason I was also
>> thinking of waiting on both events PDSC and DLLSC to bring down the device
>> as I mentioned in my comments in V1. We could eliminate link speed drops by
>> taking this approach as well. But then we had to address cases where PDSC is
>> hardwired to zero.
>>
>> On our AMD systems, we expect to see both events on an hot-remove event.
>> But, mostly we see DLLSC happening first, which does the job of marking the
>> slot empty. Now, if the PDSC event is delayed way too much and if it occurs
>> after the slot becomes empty, kernel misinterprets PDSC as the signal to
>> re-initialize the slot and this is the sequence of steps the kernel takes:
>>
>> pciehp_handle_presence_or_link_change()
>>    pciehp_enable_slot()
>>      __pciehp_enable_slot()
>>          board_added
>>            pciehp_check_link_status()
>>              pcie_wait_for_link()
>>                pcie_wait_for_link_delay()
>>                  pcie_failed_link_retrain()
>>
>> while doing so, it hits the case of DLLLA clear and LBMS set and brings down
>> the speeds.
> 
> So I guess LBMS currently remains set after a device has been removed,
> so the slot is empty, and later when a device is hot-added, *that*
> device sees a lower-than expected link speed?

Yes, when PDSC is fired after the slot is empty (i.e when DLLLA is clear).

Thanks
Smita

> 
>> The issue of PDSC and DLLSC never occurring simultaneously was a known thing
>> from before and it wasn't breaking anything functionally as the kernel would
>> just exit with the message: "No link" at pciehp_check_link_status().
>>
>> However, Commit a89c82249c37 ("PCI: Work around PCIe link training
>> failures") introduced link speed downgrades to re-establish links if LBMS is
>> set, and DLLLA is clear. This caused the devices to operate at 2.5GT/s after
>> they were plugged-in which were previously operating at higher speeds before
>> hot-remove.
>>
>>>> According to PCIe r6.2 sec 7.5.3.8 [1], it is derived that, LBMS cannot
>>>> be set for an unconnected link and if set, it serves the purpose of
>>>> indicating that there is actually a device down an inactive link.
>>>
>>> I see that r6.2 added an implementation note about DLLSC, but I'm not
>>> a hardware person and can't follow the implication about a device
>>> present down an inactive link.
>>>
>>> I guess it must be related to the fact that LBMS indicates either
>>> completion of link retraining or a change in link speed or width
>>> (which would imply presence of a downstream device).  But in both
>>> cases I assume the link would be active.
>>>
>>> But IIUC LBMS is set by hardware but never cleared by hardware, so if
>>> we remove a device and power off the slot, it doesn't seem like LBMS
>>> could be telling us anything useful (what could we do in response to
>>> LBMS when the slot is empty?), so it makes sense to me to clear it.
>>>
>>> It seems like pciehp_unconfigure_device() does sort of PCI core and
>>> driver-related things and possibly could be something shared by all
>>> hotplug drivers, while remove_board() does things more specific to the
>>> hotplug model (pciehp, shpchp, etc).
>>>
>>>   From that perspective, clearing LBMS might fit better in
>>> remove_board().  In that case, I wonder whether it should be done
>>> after turning off slot power?  This patch clears is *before* turning
>>> off the power, so I wonder if hardware could possibly set it again
>>> before the poweroff?
>>
>> Yeah by talking to HW people I realized that HW could interfere possibly
>> anytime to set LBMS when the slot power is on. Will change it to include in
>> remove_board().
>>
>>>> However, hardware could have already set LBMS when the device was
>>>> connected to the port i.e when the state was DL_Up or DL_Active. Some
>>>> hardwares would have even attempted retrain going into recovery mode,
>>>> just before transitioning to DL_Down.
>>>>
>>>> Thus the set LBMS is never cleared and might force software to cause link
>>>> speed drops when there is no link [2].
>>>>
>>>> Dmesg before:
>>>> 	pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
>>>> 	pcieport 0000:20:01.1: pciehp: Slot(59): Card present
>>>> 	pcieport 0000:20:01.1: broken device, retraining non-functional downstream link at 2.5GT/s
>>>> 	pcieport 0000:20:01.1: retraining failed
>>>> 	pcieport 0000:20:01.1: pciehp: Slot(59): No link
>>>>
>>>> Dmesg after:
>>>> 	pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
>>>> 	pcieport 0000:20:01.1: pciehp: Slot(59): Card present
>>>> 	pcieport 0000:20:01.1: pciehp: Slot(59): No link
>>>
>>> I'm a little confused about the problem being solved here.  Obviously
>>> the message is extraneous.  I guess the slot is empty, so retraining
>>> is meaningless and will always fail.  Maybe avoiding it avoids a
>>> delay?  Is the benefit that we get rid of the message and a delay?
>>>
>>>> [1] PCI Express Base Specification Revision 6.2, Jan 25 2024.
>>>>       https://members.pcisig.com/wg/PCI-SIG/document/20590
>>>> [2] Commit a89c82249c37 ("PCI: Work around PCIe link training failures")
>>>>
>>>> Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
>>>
>>> Lukas asked about this; did you confirm that it is related?  Asking
>>> because the Fixes tag may cause this to be backported along with
>>> a89c82249c37.
>>
>> Yeah, without this patch we won't see link speed drops.
>>
>> Thanks,
>> Smita
>>
>>>
>>>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>>>> ---
>>>> Link to v1:
>>>> https://lore.kernel.org/all/20240424033339.250385-1-Smita.KoralahalliChannabasappa@amd.com/
>>>>
>>>> v2:
>>>> 	Cleared LBMS unconditionally. (Ilpo)
>>>> 	Added Fixes Tag. (Lukas)
>>>> ---
>>>>    drivers/pci/hotplug/pciehp_pci.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
>>>> index ad12515a4a12..dae73a8932ef 100644
>>>> --- a/drivers/pci/hotplug/pciehp_pci.c
>>>> +++ b/drivers/pci/hotplug/pciehp_pci.c
>>>> @@ -134,4 +134,7 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
>>>>    	}
>>>>    	pci_unlock_rescan_remove();
>>>> +
>>>> +	pcie_capability_write_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
>>>> +				   PCI_EXP_LNKSTA_LBMS);
>>>>    }
>>>> -- 
>>>> 2.17.1
>>>>

