Return-Path: <linux-pci+bounces-21283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F61A31FA4
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 08:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2461619DD
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 07:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F941F8BCA;
	Wed, 12 Feb 2025 07:08:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F17D1E9B04;
	Wed, 12 Feb 2025 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739344113; cv=fail; b=YRsWghxr4+oKUcvy3JMllZo27Te3Wbtpv9QdGGBhs+dK1SDZz2QIwrxb5s1MlT2os+84yH4Bq6eeuVS7831w6DCHSo+GmnU/0Izg0XN/hnjtizCrSRMQIm0ktaOUc8RApkxOcSFI0LE+fjBjwrp2WSOQ1WVbn7iBCGbmwgLewlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739344113; c=relaxed/simple;
	bh=cF6R59nO0n6+4/lJpNt3BG+3Fjhen8hwjyeQApsrqsc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SZcOnJMt06KaZ0TlR1Szhfiw6hJy//pYUa57TMgKm6oS3rhGU/wO2SuJbMFQYkZJe9kf78haEj8G4SGlZfJmvgTa40jGVrw9BfxEPif3kdbNCuLFH5Qs83CcEmQw2mGekjNuZhmqO7E7G6JTuMLFbd7u1lvSlOTAsIP3uYvCMm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C5cuRx025996;
	Wed, 12 Feb 2025 07:08:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 44rnpbg25g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 07:08:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RM6VMi+2Wco9SDmzdNze/YGqNKxd1k/9QbETIUR3dUgLB9PlUIVCwIp9XWuFRcks3k4ySMfx9eJSP449phjqs21Svak+aEW0R0Kd6x4EiXtz59CbpbCEJYCZeTm/J4evL/KiX4Gsg6V7/limTscOg7djuuIQJi9kCTCnzGS9MbiFt6Zi1x+0fNwBDqbmoR/kS0NG2rSEKU+Vvmbu9OTJLLVXAjsRDh7hD+Pz5Ucix2jXx0P9s2ldXRlbobK8msKLqwl0SEi3hClxQtKFlqpaHqpcXGDDDP8Drs7BMCO/OhBdgt/rxJ3nMgLxzZ+O8J/R73fGJ1Y8GxjgXCYUGOajcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSf6c60hi5BjlxdNyiEH9R8PIjfNhKV/Y2v7VXycWPU=;
 b=UG5Bf1PMRFg9B29EaV2zxEAoZs2EynnlH7CNDcIx1MYVIUrczHtp356D2W12hOj6K4Z5Bo5hAqWY+bAXDmGsA+wgg2rvdQpAxt3eRJyjjZU2GEb258Yqte35uZp7OlNtEmd7phVFUA+j6AO8bIcEy/uvWaNM2nzuNbcME/JMsWDF3y6q3mciwnqATpC31HNBf/SYFezVRFN11TPdXgve2hviN4Wjv/6rOA8BEfC2HEyJMpI7Z7PDH+EpafOK0M3XH515g49tUv+IRcuY5GnFKp6WnnOBTIcMs9Fg25Lb3OtD0qhfvlI8GEPIocHVxkq3ESnBSY3wjx0biH3QiV2rog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by PH0PR11MB4952.namprd11.prod.outlook.com (2603:10b6:510:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 07:08:04 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 07:08:04 +0000
Message-ID: <df5d3c54-d436-43bb-8b40-665c020d6bb5@windriver.com>
Date: Wed, 12 Feb 2025 15:07:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: controller: Restore PCI_REASSIGN_ALL_BUS when
 PCI_PROBE_ONLY is enabled
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Kexin.Hao@windriver.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>
References: <20250117082428.129353-1-Bo.Sun.CN@windriver.com>
 <20250210103707.c5ubeaowk7xwt6p5@thinkpad>
Content-Language: en-US
From: Bo Sun <Bo.Sun.CN@windriver.com>
In-Reply-To: <20250210103707.c5ubeaowk7xwt6p5@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0020.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::13) To SJ0PR11MB5866.namprd11.prod.outlook.com
 (2603:10b6:a03:429::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5866:EE_|PH0PR11MB4952:EE_
X-MS-Office365-Filtering-Correlation-Id: 47471fb2-1967-41e1-09c6-08dd4b33fe8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmxHTUp1ZGtRS3FIZnlIQk1WaXl6cWtZRkhkWlFjRXNGWTlNbHBTcHFHS1N6?=
 =?utf-8?B?Mm1abDlrR29obTV3aUN5RmpLdVhDeWtMODlocDJGZWJqczhaanFRKy81b3JM?=
 =?utf-8?B?dEVSN1kwQzRhcFJYSzlYU1U3UElQMkprVC8zQjIwaWo3dmtGck1HSllDQll6?=
 =?utf-8?B?eCtBLy9JZk1PMnV1VjFmNnpXTUxZL2lFdDVGYkhMWEt1YmlUbkpXK0RPaTN1?=
 =?utf-8?B?Y3NVY21KbDd2VDFkSFFJbnJkT2luTVQ2cHNFbG1zdzlGUllneGlrZEhMRTRz?=
 =?utf-8?B?M1BOTUVYM1JFSmxIMHFsSnIwYyszQzB0L3Z0UWNXRmdDT2Nwb0dLTENHWEtQ?=
 =?utf-8?B?Vk1VQWJZUWFlckRSdU80ZU1TNXBqUFVQZ2dqcDNjTkgzd3NwQ1BLaU9mU09M?=
 =?utf-8?B?bUZwOUtudFNpZUNUMEtnbGtRMStCaDhKNCtaKzFiTTBCWnJMM1UwZmJySUkr?=
 =?utf-8?B?WDNNNW9jQ1d4N3RTVmJnRUVEdDNsU3JXaFc5WWVxWTdTbWZJNEFsVkVoTXdh?=
 =?utf-8?B?aFZ4YkFnc2QyUGRYRWUwNkxZY09Fbzkyb2hCYklDWVFjSWVWaVNMSEMrYjNj?=
 =?utf-8?B?Y2lETlNDdUR4clBHbUVIUnQ2VWF6OXphTng2ZFJybnNVUUhiSG1OTEs2TUpY?=
 =?utf-8?B?QUVhVi9CRmY2VWFnTjJ6Nk5ha1pHWkMvQW1xZTduVkhqZWtqaVpkbUZPcUpN?=
 =?utf-8?B?VUZIQmtReEFLak5lRnppNGhPaVJKVEtyVWtZRWFJd1g4bzZDTkgwS04zb2li?=
 =?utf-8?B?QlBWMnRTWVluYnVMT0t1NmJVQjVBcE5yUDlack9yNXVHRmRFYk5NaGxEYnMy?=
 =?utf-8?B?QXFTc0wxTGZISTFHQzZvU0FQVGlJOVhNemZ0TDZLd2ZTWGIrcG9KRDdWamND?=
 =?utf-8?B?b28vd2crNzNiZDFyM0ZDVnMzbFR5cTJKdDBvdm5HUDhEOURXekxUb1lGSVBN?=
 =?utf-8?B?NUV5bVkvNnpiMFFOakxGelN0QnJHSmltREdPSlNDeU9MekJNUDBHaHVkcGc2?=
 =?utf-8?B?bFJpRzhxV2toekhZQzY5UlNQWVVBWWVDT1Y1MEFSQ0VTNG11eHlpdlJENTUz?=
 =?utf-8?B?R2JrWDFva2N1TTYvS3NxTGdkVVlTVDluM0lvVGRGeEpnTTRNMFJWZ0p6WXI1?=
 =?utf-8?B?NkVVcjMxMTUyRHFkeFJXY1pSNml2L2dhTnIrRWFBNWE0NkRXa3NnTHZNSElk?=
 =?utf-8?B?ZEZHK25yYXFsZUFFRVNmN3k2ckhPTk00WVE3Zk50V1BMUWZNY3orR2RsWnB5?=
 =?utf-8?B?T1RDbmp3bWJZMmwxVmFYY04vNG1CUkFKczh1Y2hndko2K2NsU2ExdjJOT2R0?=
 =?utf-8?B?NkdyY3dQUTMvQTFSQUZSNE1vT2crNFhHd1RGMXFpSlpabm5FZ2hPd01UUUdG?=
 =?utf-8?B?UlFjYjcrbDgrWEd6cVFkN05kZDJmSzFQQVFrTkJhSFIwU3p0MkZQNkJmbUpm?=
 =?utf-8?B?eXNIZEczVU03QkNBUFg1WElnMlh3UDUvdm5JME9xVHppc2tsRHdCTnpLU1lr?=
 =?utf-8?B?bHZpQ3NYblhHL0tQN2pTcXJKTmpHV2RJcFkvTXJUeHN2TjFjMVkvZDU4cHBS?=
 =?utf-8?B?dWI3NjVMcDNvK29RVm9oaTVBSlNvZHJnbE9DODdFQmozd0RhR0RpR0dvVFc0?=
 =?utf-8?B?amJxRlB2VkV4V3ZSeG9hamF6YTMwVXRNdHo0NHkwQ2xDQUVQc2tBUDhaN013?=
 =?utf-8?B?WGdiYjE1NHkrN0JHS3E2MDk2Uzlsa05KNUwxdFREUHNHWnM2K214alBvQVRB?=
 =?utf-8?B?c01OUG9yTk4xSkpnNUlzR0lPWGdrRFRpWE5XbEkvTlE3OW9jVVBhVDZ5Zkhw?=
 =?utf-8?B?dFg4WVR5TUFnQnNmay9WR3ZwS0JkVHJ5L0dLblN6aVMxN2JVZE1QaW9vaWtT?=
 =?utf-8?Q?fWiU6xryoKfRO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVF4OVJrdlphTjVIdm0rYjQrelJOQ1FwU0FjN0greXRXbVV5RmYySmNocTRv?=
 =?utf-8?B?Wm5pZER3ZVBzemJsUGRRV0xuaU1tY0lmZ2h2Um5XR0t0U1U0NUYzVkVsSXBZ?=
 =?utf-8?B?TEsrcVRIRjZpeVVGQnNzRGVzTHVzYVRUMWZTQ1hCdDZuTkg5R0NCWFFxU2Nv?=
 =?utf-8?B?U250Q3lUcCs5cDJZV0JDQmRaZDVmdjRwVGp1RjlXNkh1S3d4V1o3NHI0ZGxJ?=
 =?utf-8?B?QlZUUFdoR1hyeDF5NU1VZnBzUklxN3Z3SG1nbm9TK01CRktlcERDbTkydWND?=
 =?utf-8?B?RE1oTEh2VjJkK0s3WnRlV3hJaUMzVmF1Y1hmTlBaSjJKaERPbWFhR3dyM0xt?=
 =?utf-8?B?QTRzUm9RWjR5RW9qam5SSk5BTWRBenUxckxJdCt5bnlXQVdtMEEzM2NSWmpF?=
 =?utf-8?B?bWdnWEZ6TDFMczkvZGl5SjZVWEU0aitTVTBuK3Q3MHE3MlpsNDBUY1VRQmdB?=
 =?utf-8?B?bVdSbStyQ1hKaHV6cE1zUS8rekhQczRGNlNSSUdpYzhQM3hmeTFiT0VSMWd3?=
 =?utf-8?B?TFZUSFlzUHJvVFRYeDBHNGNoR01KNE5WUlVYQ2d4Vm9USDBCNEhRc1Fna2NH?=
 =?utf-8?B?ci9DenFNektzc0pVM25CdkRhOWJXRmtqYWRvL2lUZ2lNbGE5VUcrRVVNR0lm?=
 =?utf-8?B?NW1lT3oxa3BjUE41ZGoxUDM5dm4waldzYUNQc1pzOERtcFFlaVFYT3NreHVV?=
 =?utf-8?B?VEFYR25COWpHSXp5Z3krNlBSTUsxclRDelBuSnFZLzMwZHVKTGNES0dCd0Vp?=
 =?utf-8?B?bE1kWVgvZmx4bkl1em4zWExzNytVWENBNEhWQ3ZldGd1bFA0T2ZOVFFHdW8y?=
 =?utf-8?B?S01BeHpDNHhMeWFuVXZ2cmxDM2RhWnM0Tk8vck0rNUdJTjV4K0VubFc2QXVH?=
 =?utf-8?B?OVpYWDgwQ2ZocE9lZU1qTFdtUzd2RTF5U0EvZjhyMGIrbDVubUtPNGJmL3Jl?=
 =?utf-8?B?NUJCNnNTSXV1M2RvUmVabFdHQWtPRXduSkhiV2l2SThHRXBad3daNFRmL3Vv?=
 =?utf-8?B?UWpNT04yZW5VV1lqUktUT0g1Tm1BYUR0UThHVFZXUFNxYS83TXZjZXNNRFVY?=
 =?utf-8?B?cGNmcFpJd0FteWwrMElrWlMwcDhUVFRNZzg3ZmwrY2paNnRhdkwzVE5KME1Q?=
 =?utf-8?B?OVdmUkRoOW16TVV3VDRkSFRjT2pGRHVWZlpFWXQvRDBRUlJYR2JRVGplNEZ6?=
 =?utf-8?B?NXRnNGRlK090WGZzWGxMZnVyRGFtVnpNa2JydWV0NTlnZk8xWS9lVkdqOThi?=
 =?utf-8?B?V29GLzdTQlRjaHNESVJSbDhyUTR1UHo5d2M0eitrQ0Y5cm1Ta1h4aW82M2Vj?=
 =?utf-8?B?cFh0bHBmbkpWSWFtaGpWQzJEY3RjN293b3daYWdYc1FtWWJ1NXRRVVU2cUxt?=
 =?utf-8?B?d2twa0hydDY2MldSZCs4aWpWS0VjRlFZK2Y2bXRaaVZDRzNLZmRzalE1b1ZN?=
 =?utf-8?B?QWZvWXFWc1dUazlSNE5jSWpkSkFPWHAxeWNmYnBaM2xNWjRHSzdLV2MyOGFP?=
 =?utf-8?B?UDVVVGdKeHFJRENYUlJiZ3V2UGFCcFBGMlZwUlplUkViQVJBSis0dmI2TU1P?=
 =?utf-8?B?dlh2VCthNVArN3dYN2NrZ05PSG9pTnNKTi9yVmdkMTQ0Z1lEb1pUOUhDT3JK?=
 =?utf-8?B?MmlyQkZMbnN4YkJ3U1RBVmlWZHNmVmtLQ1ZDekhlQmJRbVVOTVVTL09rcVpy?=
 =?utf-8?B?UWhwS2YzS2FlMDRNc2xpKzhFSDFKQmFaUHNFck8yTmNMT2xSU3Q3OS8vWXNC?=
 =?utf-8?B?SWxGbW1GYTJGTmVHNkpvZXRLblN2ZkdFTTBpeXNqbzNIWDMrbUo5ZmU2R2Mr?=
 =?utf-8?B?My9Yay9UNmMzVjhxN20rZnA0ck9Fb0lDY1pORW5kcHVUUkVrVjhWdENuelI5?=
 =?utf-8?B?c291Qmp5czhXeVp4SHBSWWU4L2RyNkRiRHFxQ3dZUEFKM21HRWVmZ3ZLaFdU?=
 =?utf-8?B?U1NPWUtUNmppcUVQLzBVRmFtK2pqaHQ0TEFhWHlHR2JIOEhoM3JsWGMrNy82?=
 =?utf-8?B?MWZoVHJuK0F2VmNnTDAwS2tjTUxyOE9uNWVGQmdUU3UybHI5cTVTNktKSDdV?=
 =?utf-8?B?b0lxVm1uc0JTRG11ZjdCRzhjTktnem52TGUzem4wbUkyb1RFU3ZlampwU2tx?=
 =?utf-8?B?VlR6bUd0OUJuSS93QzZ4QmRFbVlpcW5qMVNOQWkzcjAxUnNuTzVTNmZRdGpE?=
 =?utf-8?B?T0E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47471fb2-1967-41e1-09c6-08dd4b33fe8c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 07:08:04.3726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VjbHgw8Mv/Rec2segU2GLATgnKl7oK2aWHlmAJSnyCYAUUx3fTWTrSxtWil9qQVXXRRqiPShFW945lb97u5fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4952
X-Authority-Analysis: v=2.4 cv=B4lD0PtM c=1 sm=1 tr=0 ts=67ac48d8 cx=c_pps a=t4e0UQJdoJrPmzgCWb9hsw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=bRTqI5nwn0kA:10
 a=qnaFxyUXEHPenSUatCIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Jr5zYVFPNdUguEt5kDAm32siJJqqOOpH
X-Proofpoint-GUID: Jr5zYVFPNdUguEt5kDAm32siJJqqOOpH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_02,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2501170000
 definitions=main-2502120054

On 2/10/25 18:37, Manivannan Sadhasivam wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> On Fri, Jan 17, 2025 at 04:24:14PM +0800, Bo Sun wrote:
>> On our Marvell OCTEON CN96XX board, we observed the following panic on
>> the latest kernel:
>> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
>> Mem abort info:
>>    ESR = 0x0000000096000005
>>    EC = 0x25: DABT (current EL), IL = 32 bits
>>    SET = 0, FnV = 0
>>    EA = 0, S1PTW = 0
>>    FSC = 0x05: level 1 translation fault
>> Data abort info:
>>    ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>>    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> [0000000000000080] user address but active_mm is swapper
>> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
>> Modules linked in:
>> CPU: 9 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc7-00149-g9bffa1ad25b8 #1
>> Hardware name: Marvell OcteonTX CN96XX board (DT)
>> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> pc : of_pci_add_properties+0x278/0x4c8
>> lr : of_pci_add_properties+0x258/0x4c8
>> sp : ffff8000822ef9b0
>> x29: ffff8000822ef9b0 x28: ffff000106dd8000 x27: ffff800081bc3b30
>> x26: ffff800081540118 x25: ffff8000813d2be0 x24: 0000000000000000
>> x23: ffff00010528a800 x22: ffff000107c50000 x21: ffff0001039c2630
>> x20: ffff0001039c2630 x19: 0000000000000000 x18: ffffffffffffffff
>> x17: 00000000a49c1b85 x16: 0000000084c07b58 x15: ffff000103a10f98
>> x14: ffffffffffffffff x13: ffff000103a10f96 x12: 0000000000000003
>> x11: 0101010101010101 x10: 000000000000002c x9 : ffff800080ca7acc
>> x8 : ffff0001038fd900 x7 : 0000000000000000 x6 : 0000000000696370
>> x5 : 0000000000000000 x4 : 0000000000000002 x3 : ffff8000822efa40
>> x2 : ffff800081341000 x1 : ffff000107c50000 x0 : 0000000000000000
>> Call trace:
>>   of_pci_add_properties+0x278/0x4c8 (P)
>>   of_pci_make_dev_node+0xe0/0x158
>>   pci_bus_add_device+0x158/0x210
>>   pci_bus_add_devices+0x40/0x98
>>   pci_host_probe+0x94/0x118
>>   pci_host_common_probe+0x120/0x1a0
>>   platform_probe+0x70/0xf0
>>   really_probe+0xb4/0x2a8
>>   __driver_probe_device+0x80/0x140
>>   driver_probe_device+0x48/0x170
>>   __driver_attach+0x9c/0x1b0
>>   bus_for_each_dev+0x7c/0xe8
>>   driver_attach+0x2c/0x40
>>   bus_add_driver+0xec/0x218
>>   driver_register+0x68/0x138
>>   __platform_driver_register+0x2c/0x40
>>   gen_pci_driver_init+0x24/0x38
>>   do_one_initcall+0x4c/0x278
>>   kernel_init_freeable+0x1f4/0x3d0
>>   kernel_init+0x28/0x1f0
>>   ret_from_fork+0x10/0x20
>> Code: aa1603e1 f0005522 d2800044 91000042 (f94040a0)
>>
>> This regression was introduced by commit 7246a4520b4b ("PCI: Use
>> preserve_config in place of pci_flags"). On our board, the 002:00:07.0
>> bridge is misconfigured by the bootloader. Both its secondary and
>> subordinate bus numbers are initialized to 0, while its fixed secondary
>> bus number is set to 8.
> 
> What do you mean by 'fixed secondary bus number'?
> 

The 'fixed secondary bus number' refers to the value returned by the
function pci_ea_fixed_busnrs(), which reads the fixed Secondary and
Subordinate bus numbers from the EA (Extended Attributes) capability, if
present. In the code at drivers/pci/probe.c, line 1439, we have the
following:

		/* Read bus numbers from EA Capability (if present) */
		fixed_buses = pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
		if (fixed_buses)
			next_busnr = fixed_sec;
		else
			next_busnr = max + 1;

>> However, bus number 8 is also assigned to another
>> bridge (0002:00:0f.0). Although this is a bootloader issue, before the
>> change in commit 7246a4520b4b, the PCI_REASSIGN_ALL_BUS flag was
>> set by default when PCI_PROBE_ONLY was enabled, ensuing that all the
>> bus number for these bridges were reassigned, avoiding any conflicts.
>>
> 
> Isn't the opposite? PCI_REASSIGN_ALL_BUS was only added if the PCI_PROBE_ONLY
> flag was not set:
> 
>          /* Do not reassign resources if probe only */
>          if (!pci_has_flag(PCI_PROBE_ONLY))
>                  pci_add_flags(PCI_REASSIGN_ALL_BUS);
> 

Yes, you are correct. It’s a typo; it should be "when PCI_PROBE_ONLY was 
not enabled." I will fix this in v2.

> 
>> After the change introduced in commit 7246a4520b4b, the bus numbers
>> assigned by the bootloader are reused by all other bridges, except
>> the misconfigured 002:00:07.0 bridge. The kernel attempt to reconfigure
>> 002:00:07.0 by reusing the fixed secondary bus number 8 assigned by
>> bootloader. However, since a pci_bus has already been allocated for
>> bus 8 due to the probe of 0002:00:0f.0, no new pci_bus allocated for
>> 002:00:07.0.
> 
> How come 0002:00:0f.0 is enumerated before 0002:00:07.0 in a depth first manner?
> 

The device 0002:00:07.0 is actually enumerated before 0002:00:0f.0, but 
it appears misconfigured. The kernel attempts to reconfigure it during 
initialization, which is where the issue arises.

>> This results in a pci bridge device without a pci_bus
>> attached (pdev->subordinate == NULL). Consequently, accessing
>> pdev->subordinate in of_pci_prop_bus_range() leads to a NULL pointer
>> dereference.
>>
> 
> Looks like it is a bug to let a bridge proceed without 'pdev->subordinate'
> assigned.
> 
> - Mani
> 

Yes, you are correct.

> --
> மணிவண்ணன் சதாசிவம்


