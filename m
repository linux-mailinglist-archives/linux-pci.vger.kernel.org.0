Return-Path: <linux-pci+bounces-21066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20748A2E6DD
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 09:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C657B3A54BA
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 08:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D575199E80;
	Mon, 10 Feb 2025 08:50:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072021C1F02;
	Mon, 10 Feb 2025 08:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739177404; cv=fail; b=cwLNI42YkW42TEeAxXouGy7yNUednkfe6FS2Ck9F8Ju5HVsw5p13BcKdsz1XtwBoebx33qzl5ohjxiuEyQJ0BUT5Gy3eS5on0EaEb/Fw0P5kcj+V6dPIkhWImfcqBOLRda4DswGiHxCXICGjSj7c4MdgAihII9pASM/fsYyQXlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739177404; c=relaxed/simple;
	bh=qnQCVbas+j5ByRc844VZevRoYLxWxlfLcXG2CT86kRc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dEIx4135sMCjDdVRCPexZahOaHtAU88EAataqiMTocId2UPQIKwGDkziyYZXxG0feA8CYpOE0hreXWdHi8XO9FnR5HSBde1ebr5bGhP1yleo74plkCzNBfam1I/DEBsYkTFF7M1IuN3i2HMvavlYkKiGJvHne05SQyO5XwZl2GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A7rG8r029750;
	Mon, 10 Feb 2025 08:49:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 44nvg0srfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 08:49:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaKxktclxb7U+LzsRjENrTgsVwXK0l1HmMJ5Qufu1T22kJz6lN+LyJQlhOZLdSjb2a7VmSpkQCENJg4NeqD5UgNFCCoPAEPAX5xoOZs+q9qhQXzWBRuroruDMfu+gBk07TE/VJmsVBjRipK51lZFSqPOFxSRwi1zfwSs25AhaH9l1iSVbe7ovggY7IcwJ3Bm5oafiqKSsE+jGgBH4BbcU9QZyXT+PTMjmwQFecLr5abOu8J56N7o1cMA9PTYDr+Cq80+EN5Cjwt/CCr06qImd6xnn7zDyKFHapIFFAvKiEkntrFqX7HB1URulZ2xW4eWHNJaakvqHHYoIZhsHUOaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4G60WYg991mQvMgEQZ3JtzbWfWKVMSL1WbouzWWb2A=;
 b=kc1XptH5J1x8H0fM2zqQVmjw/5zAJxR/XvfgnyV5TuwP4EnGNxpNVtT0tQ2E8jH9/FzNGMmmeZ4aNu3BjV6JwMhvS8ARHwsixTfHlvfbcGB3HqdnoBpfyEhbmZ2Wc3flPhmb6tTQG/EUrcZwwlJpgSbWQxFYb9VLUNC1jwMY9eUtGH90kAGuTl95gnGab7XAOTlA39a9AKFjkm1byikVqW5yVyUT1Fd/z+Lta7QqDpzW2Hu5AwsROVfMeOgeyCMVXgTKpcm9IRvhJ+fNEoaId7AMFWJNX7/sWnb/NJ/tcf1MSejGo5a3hIuPQ6PTtpY3KBpgykjY9C7ZVqxP7caMAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by PH7PR11MB6378.namprd11.prod.outlook.com (2603:10b6:510:1fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 08:49:26 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 08:49:26 +0000
Message-ID: <6b8e73b7-668a-4832-ac51-b7da58fe1060@windriver.com>
Date: Mon, 10 Feb 2025 16:49:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: controller: Restore PCI_REASSIGN_ALL_BUS when
 PCI_PROBE_ONLY is enabled
To: Kexin.Hao@windriver.com
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>
References: <20250117082428.129353-1-Bo.Sun.CN@windriver.com>
Content-Language: en-US
From: Bo Sun <Bo.Sun.CN@windriver.com>
In-Reply-To: <20250117082428.129353-1-Bo.Sun.CN@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0146.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::26) To SJ0PR11MB5866.namprd11.prod.outlook.com
 (2603:10b6:a03:429::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5866:EE_|PH7PR11MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f92046-eb48-4600-e49b-08dd49afd2da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THBYZUIycktSVVpQMEpJS3lJeGlyWDZXR0dpbFUzQW9KWUdaYTR0SGRoWHFu?=
 =?utf-8?B?MEJKRnl5QTdQbDZ5RU0wemVabFJUVU93SGtxdHcyZkpnQUFaTXQwSFFFNDls?=
 =?utf-8?B?MnZzam9GOFo1SUJ4Y2lNenpDck1sYzE3NGVPTFdvc0pObE5FU2MyQVFtSjlG?=
 =?utf-8?B?d1hNNjFwTGNZMkNIMWVWK29hNUVHSzRVYzdzUGU1NzY3UTc2YjZIUUdPUFhu?=
 =?utf-8?B?ZkRaSUx5MGV5UE5hc2owa09vV1ptYUZhNndnK0k0T0V2Zy9KNEtudm5MN1hE?=
 =?utf-8?B?L1pZUEZIN2hUR0VmUEtWS0ZsZXo5S0xTZ3Fkbm5KdmNYY3BocXBuZGJKbjVB?=
 =?utf-8?B?RWt1bGxLTkFDVFRCekp0MlpqOHJSWXZTUGxLQThqd3dGa0YrT2RIMVBEMjRv?=
 =?utf-8?B?aTZKRUVhOW9oM2hJNGxORWVwOVNEMCtFa2t0UHVlbklCb0N4YjhUcFNrWFJn?=
 =?utf-8?B?eWdOSU5hR3N6WEVFRmd2MnNNM3lheEU2UE9zZWdORUtsTHBnMzhOaTh3cTVn?=
 =?utf-8?B?M0ZLVTlXbC85NUxNdFVtMzVsYkw5cE5ZSWhkdzJna05US0VEZUVtRlpyRHU0?=
 =?utf-8?B?NTNlb055TVJoVDJvMWhPMG1qVzBiRWVEbVYrV3locEdnZXlaNmhBZWRZcFgr?=
 =?utf-8?B?Mkp3Z3FDc3FneEdsRERMZzVid2VOdTl3NzVhNERNdnZUVWpLQVAybEtuKzJy?=
 =?utf-8?B?amMrZld1dDJQVmJyZEI1eHR4dEEzUk03OHpSaW04UnAzdUlBVjIvNGlHbFBu?=
 =?utf-8?B?L1ZLSVVHVXRWZlN2QWNpVHZxSURISlRHa25FaWJRNklqYWFVMmtkTkVMMEhF?=
 =?utf-8?B?enNFTXRlMnlacFd1M3d2QUZRU28xZEJraVh0eUV0ZU45OExGMWZGdkloTnE3?=
 =?utf-8?B?emlWamFNTUJ6eGwzSnNqZnhYYXRxQlZjaWdPSHZLYStFWHE3c3ZMZlpjVTZ5?=
 =?utf-8?B?eE9TRXBVQ1FLY3lobUx5QW1kTGYvU3kwOEhUTU5tT2NFZDgvMGZXdlIrOFNS?=
 =?utf-8?B?cVk2OGhzWWMxNzYxU0VLNGt0QWRNYVJoQ2NQZEtnaHpSb2JwMnVOMG0zaGhi?=
 =?utf-8?B?MEo3ZlBDQ2c5QzJWUWxlVUZNd2hMQXpDVUZEVnZlVWU4Z1ArOFJKV2F6dFNy?=
 =?utf-8?B?T3hUaE1JSnN6c2srUFVqMnB3UThzbzJGRzhqQlZQMGdvL3NWSjV2cHZYKzZk?=
 =?utf-8?B?NUZnSjVxR2dJV3RqejZKaklSejN4QWY0aGxYbWxyY2NtanBHcWxpR2dlcUJs?=
 =?utf-8?B?TDQrVWN5TFpvOXduK3M2dVBtMGFBem91YloyY2FjR3JDTVdLSXRReHhubXp3?=
 =?utf-8?B?NGNka1NobzJzYnhKaGhkRlhVb3ZCd1FBT09zVXNiRzExTWpUQUp5K2tub2tm?=
 =?utf-8?B?WWNlczU0bXpMbmkzN0QxNmE1dElvYkZaRWUzNjA4MkFnYklWMEtoN0pnSWNv?=
 =?utf-8?B?WmYrTEhkWElsMGorcG1KcElrd203c2JVR2dQUndIRkhuRXpjaktiMGgwT2Va?=
 =?utf-8?B?S3VBVk9hL3JyVTlUUWRUQVNYcXZ6LzRkQmpFUEExME5XQTVhUjRoRHFPR2tj?=
 =?utf-8?B?N2ZLeGR1M082SXg2NEVKOXE4dDN1RFF0VWdHb1Z4RENuMjR3M3VKS2ZYQ3FL?=
 =?utf-8?B?T0FiVFF0cHVOT3pEU0g2Ylp0L1RCR2ZZRnRXLzNFQUxCb3dzeXhPNnN1bWpJ?=
 =?utf-8?B?Vmp4b2FVcGVyZ2lSUHJ0Q3YxNEpOMXN6VHhOWUwzaklBK0h0WVd4clFMWHk5?=
 =?utf-8?B?VzZIS3FiWkJ5eFpXcWJ0NWhzNjlqbjVGU1VCYlAxd0RRSHArMlkzdzBWWVIx?=
 =?utf-8?B?UUtJbmsySVBMSTREVGFNVmdKY0h0VDNzUkU4QzgrMkFza0RhQ3NSQW9nb2pF?=
 =?utf-8?Q?HHzYZEB2C44xo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3ljbnBvN1JmdmhFd2NSMHFOakdMM21OdlFmM3NWK0pYUDllU0phSDFpL3dr?=
 =?utf-8?B?L3NncU9pQkM3ZlFORTFnK2FFN21uT01Ob2E4Rm5oYTBlWHVPRGFSdzVKV3Zm?=
 =?utf-8?B?UmswODhsQ01GemJpQ3U4S2ljdDZTb0FRSzliQ082bFRZTXZCak0vS2R6TWdi?=
 =?utf-8?B?Z2JVNGs0Zi9LRUVBZGwzaFN6SmtDK1VSSG5tRFdNdWRuR2lzcWx1ZnI5cW1r?=
 =?utf-8?B?S2hBblk5QUYyU1BFZER6TEJEMTMrWlhCSzBVL05BMDEzK0RpcHBjU1JsblJF?=
 =?utf-8?B?bXBUempyZCszdSt5Yjl1WCs4WWRFbXkwUFJHaXVjS0NQcEloZ3dIQzc1dXVC?=
 =?utf-8?B?ajgzQy8yOUFMUHFGYkcvUjdUWVozTDBuaEFtUndKclR4ZjVGbHZvK01ZMTZ1?=
 =?utf-8?B?MitydGdFTHlkVVVnclVSUVQ5YzYzUkFFOVZSSE9yaVJYQU81akQvaGtpaUpB?=
 =?utf-8?B?QWxuRXUyTiswMGtSVWtxdTFpOUg4Y1AyWGVZUTJPdGswOXZaTXVGNis3R0xR?=
 =?utf-8?B?Y1pqb0VsY1pITjNRc0NjUm9sMXRRd3NsUnVybytOd3d0OXhvc2t6Q3Z0K2V4?=
 =?utf-8?B?STdTNVFScTN6Z3NPd1BIcDhmNmdsMEtXV2Z6R01tZ3pMS2Y1RE9xMFNmRmV4?=
 =?utf-8?B?TVIxbDFQZUV1cVF5dXJadkM4QW85TGNQTlJscWdaT3oxdWx2Y3RDcitLUjJr?=
 =?utf-8?B?cFZYNEZmKzBNa3ZwV3k4YWFld2hUWFlTRTZkSVpqcDRxN1V5bXRwTFpuekdI?=
 =?utf-8?B?akQ1bk5qZkZwQW1TTzlRZWpRaVBJVDFyTnY5a0duSkpQeWJNYUxWSDdaOFBs?=
 =?utf-8?B?Mk55azNNUGVYNzl6TXd4Q01KQVJwK1lXc3o5R2xUVTJuUU5heTRtU1F6TGNS?=
 =?utf-8?B?MXZQemJONEo0WTBPUXYwWWpXK1d4UnBtS09pZEdJVWFjWVJmMmw3VlU3alFV?=
 =?utf-8?B?dEswcWpKZmFxQ2NQYVBYQlM3VzR1Wm9maXUzKzFkMW5nVW9RbnVXQkJuRzJk?=
 =?utf-8?B?WTk3bE9VdXF2N24rbDUyakFEd09oeTFyWll0cjdrY1hGUVE3eUl4YWNJNElU?=
 =?utf-8?B?RFVHMDdBVTZrTS9LeUFrNGZFWldzUGZPakRZTXZ6a3JQdDY5U2RZVm1lR01r?=
 =?utf-8?B?Mms3ck9CNlY5NmdncUtROVdncVcxTGNrSWt2ZFR6TDNCbUM2QTVib1NzbXVR?=
 =?utf-8?B?Y0tVeERLampueTE3VDlhb0RraDZpZDFSYWRrNm1NUStkdlprbXhxRkt2cHFn?=
 =?utf-8?B?QzMzdTIrSjRYREtnOXl1RTVscHF2aFhOVDVEWWtMMU92VWluc0xob0RVRXFK?=
 =?utf-8?B?aXZ0eVNpUlNwUStHOGtLSUpDRzZ0a3hRU1dITGxYb0t5WWdnUDNrS201ekZs?=
 =?utf-8?B?UjNpTmdXSVkrOVI2NU9FZ1FXT3dCYnJKbW0yR05BblBXWHFWOXpZcXJibXV2?=
 =?utf-8?B?YzM1eGRBL0NKZFpSLzNSRk01YzcyYUJzZzBmR2pvbE1WY0dNcUJKazdhV2xs?=
 =?utf-8?B?aEFrSmdGTWsrSWp4SWxFeUEvMmw2Sng2eWp1V0RHWE1rMFRGM0JGL3lVVXRu?=
 =?utf-8?B?OGp0b05NUW84ajluVXZ0cTNhbDIzWlRBRXNPZEp2cDcva0tYWG92WHYyNC9Q?=
 =?utf-8?B?aVduL2R6d2E2dW94aTR6RW5XWlFxbHk1TitvRytMVW9SVlo4MjVpcVhVM0F5?=
 =?utf-8?B?L1Bkb21zSjhKOFRZNnVvWGRwK3hva1B1aEZzb3VKTGFtSGNzVXVHQnZNNk5y?=
 =?utf-8?B?YlMrQXo4Rkh1WDJNOS8xL3VNMTdWZjJjY29leStlMEpnUHltbW5IMmtNak16?=
 =?utf-8?B?Y1IxN2U5YWVxTFluS0wva1pmV3VFUG5hSzZla1VlWXczTlBVT0xvMXBGaXEr?=
 =?utf-8?B?aGxhR2dyYVU3T1FUR3ZMVXRPN2RGZm9vRGIyL0FqZ1JTNU1lM1VyTEpnTlEw?=
 =?utf-8?B?YU1FMnlPYjZKMCtVYWhRQ29lcVBSeXd0SGtVaXV5RVpaOVNHdzR2NjEyOXlS?=
 =?utf-8?B?MkdPRFFWM2lIc2o4SENxSjNrajlkL3I0cGJmcHBqNEh2UjhyQ2NXU1RlTEVh?=
 =?utf-8?B?eVpJTGVkK3hBc3FOcG8yZFFRemV5dk5BUVZaWjVDZEFrbGVueTNqSUQwQ3BT?=
 =?utf-8?B?SWMxSTVFUkdvbSs0OTY3M29kREJXYWJZcEtoY3h3bHVoMWhoVWVkczhheDRx?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f92046-eb48-4600-e49b-08dd49afd2da
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 08:49:26.5467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeK2ICF3weMmWHsE2eU+EPz0CT83mq6+B42B3wACHKTwp/3W5p16p97D2jqXMD4pjUaXidgciLtLtkBP66IxKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6378
X-Proofpoint-GUID: ooG9kipDn7MndmcHZGUacdi2_I8W6hul
X-Authority-Analysis: v=2.4 cv=UPwnHDfy c=1 sm=1 tr=0 ts=67a9bd9d cx=c_pps a=1mby/iHf9ieL9308fKykyA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=bRTqI5nwn0kA:10
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=1qlVYSn2M3m1R7bIfZ8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zY0JdQc1-4EAyPf5TuXT:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: ooG9kipDn7MndmcHZGUacdi2_I8W6hul
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_04,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2501170000
 definitions=main-2502100073

On 1/17/25 16:24, Bo Sun wrote:
> On our Marvell OCTEON CN96XX board, we observed the following panic on
> the latest kernel:
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
> Mem abort info:
>    ESR = 0x0000000096000005
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x05: level 1 translation fault
> Data abort info:
>    ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [0000000000000080] user address but active_mm is swapper
> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 9 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc7-00149-g9bffa1ad25b8 #1
> Hardware name: Marvell OcteonTX CN96XX board (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : of_pci_add_properties+0x278/0x4c8
> lr : of_pci_add_properties+0x258/0x4c8
> sp : ffff8000822ef9b0
> x29: ffff8000822ef9b0 x28: ffff000106dd8000 x27: ffff800081bc3b30
> x26: ffff800081540118 x25: ffff8000813d2be0 x24: 0000000000000000
> x23: ffff00010528a800 x22: ffff000107c50000 x21: ffff0001039c2630
> x20: ffff0001039c2630 x19: 0000000000000000 x18: ffffffffffffffff
> x17: 00000000a49c1b85 x16: 0000000084c07b58 x15: ffff000103a10f98
> x14: ffffffffffffffff x13: ffff000103a10f96 x12: 0000000000000003
> x11: 0101010101010101 x10: 000000000000002c x9 : ffff800080ca7acc
> x8 : ffff0001038fd900 x7 : 0000000000000000 x6 : 0000000000696370
> x5 : 0000000000000000 x4 : 0000000000000002 x3 : ffff8000822efa40
> x2 : ffff800081341000 x1 : ffff000107c50000 x0 : 0000000000000000
> Call trace:
>   of_pci_add_properties+0x278/0x4c8 (P)
>   of_pci_make_dev_node+0xe0/0x158
>   pci_bus_add_device+0x158/0x210
>   pci_bus_add_devices+0x40/0x98
>   pci_host_probe+0x94/0x118
>   pci_host_common_probe+0x120/0x1a0
>   platform_probe+0x70/0xf0
>   really_probe+0xb4/0x2a8
>   __driver_probe_device+0x80/0x140
>   driver_probe_device+0x48/0x170
>   __driver_attach+0x9c/0x1b0
>   bus_for_each_dev+0x7c/0xe8
>   driver_attach+0x2c/0x40
>   bus_add_driver+0xec/0x218
>   driver_register+0x68/0x138
>   __platform_driver_register+0x2c/0x40
>   gen_pci_driver_init+0x24/0x38
>   do_one_initcall+0x4c/0x278
>   kernel_init_freeable+0x1f4/0x3d0
>   kernel_init+0x28/0x1f0
>   ret_from_fork+0x10/0x20
> Code: aa1603e1 f0005522 d2800044 91000042 (f94040a0)
> 
> This regression was introduced by commit 7246a4520b4b ("PCI: Use
> preserve_config in place of pci_flags"). On our board, the 002:00:07.0
> bridge is misconfigured by the bootloader. Both its secondary and
> subordinate bus numbers are initialized to 0, while its fixed secondary
> bus number is set to 8. However, bus number 8 is also assigned to another
> bridge (0002:00:0f.0). Although this is a bootloader issue, before the
> change in commit 7246a4520b4b, the PCI_REASSIGN_ALL_BUS flag was
> set by default when PCI_PROBE_ONLY was enabled, ensuing that all the
> bus number for these bridges were reassigned, avoiding any conflicts.
> 
> After the change introduced in commit 7246a4520b4b, the bus numbers
> assigned by the bootloader are reused by all other bridges, except
> the misconfigured 002:00:07.0 bridge. The kernel attempt to reconfigure
> 002:00:07.0 by reusing the fixed secondary bus number 8 assigned by
> bootloader. However, since a pci_bus has already been allocated for
> bus 8 due to the probe of 0002:00:0f.0, no new pci_bus allocated for
> 002:00:07.0. This results in a pci bridge device without a pci_bus
> attached (pdev->subordinate == NULL). Consequently, accessing
> pdev->subordinate in of_pci_prop_bus_range() leads to a NULL pointer
> dereference.
> 
> To summarize, we need to restore the PCI_REASSIGN_ALL_BUS flag when
> PCI_PROBE_ONLY is enabled in order to work around issue like the one
> described above.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7246a4520b4b ("PCI: Use preserve_config in place of pci_flags")
> Signed-off-by: Bo Sun <Bo.Sun.CN@windriver.com>
> ---
>   drivers/pci/controller/pci-host-common.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index cf5f59a745b3..615923acbc3e 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -73,6 +73,10 @@ int pci_host_common_probe(struct platform_device *pdev)
>   	if (IS_ERR(cfg))
>   		return PTR_ERR(cfg);
>   
> +	/* Do not reassign resources if probe only */
> +	if (!pci_has_flag(PCI_PROBE_ONLY))
> +		pci_add_flags(PCI_REASSIGN_ALL_BUS);
> +
>   	bridge->sysdata = cfg;
>   	bridge->ops = (struct pci_ops *)&ops->pci_ops;
>   	bridge->msi_domain = true;

Dear All,

I hope this message finds you well.

I’m writing to follow up on this patch. I understand the community may 
be busy with numerous tasks, but I wanted to check if there has been any 
feedback or progress on reviewing the patch. As the issue remains 
unresolved, I just wanted to ensure my submission was received and is 
being considered.

Thank you for your time and consideration.


Best regards,
Bo

