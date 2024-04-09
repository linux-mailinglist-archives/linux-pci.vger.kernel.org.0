Return-Path: <linux-pci+bounces-5920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586D989D42A
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 10:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A380AB24212
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 08:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E4F7E57F;
	Tue,  9 Apr 2024 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kvoe1xRP"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2115.outbound.protection.outlook.com [40.107.220.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BAE56454;
	Tue,  9 Apr 2024 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651160; cv=fail; b=M+jtGkl2rqZY8zLKYHdpqo+24BE/9FEf95cr9bPDI/7SFMlBzdro/HnlzFAejzCm7WGCNcb0m8S60WQLJWJmnO9oE9olUC0iHK+IkhrZ5COp3Lffzlo1WxBDF6M9LANn+jSt8GP8wUOCUXwte7tswlSuQ8AW23+QE0uEyLCmuH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651160; c=relaxed/simple;
	bh=xMZUHm3GFMsv+Mp8CLQbCvcOTTpcz8uggVke0Fu3QvY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EwFG3tlozP+iJ6OVpOMrvpTRDv5CAmAANDaWfrpnBNyy+Hq+s/ARCJ8tRhd29hlBFL5aHZ9uR/rLy09DKzSHzSJEaeEOYpVQspE2+nQrei2LenR2wC6OQDEe6dTLKUdQ725l4/z1/oFd3xf9H3kVLKWYesxy8VHHdyM2Dvz7YAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kvoe1xRP; arc=fail smtp.client-ip=40.107.220.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xs/3Hxk8Uud+KPOTm8tmIuBcHibFZeegesJA4aFCP0+0ugYkwJO/iKAFyM53WZK+8C4PH4w7M2BGysPIxkbWoVCoHGggVuP6WIUo3yk8Pee9F1YlbWH4qlOoHzwmz6JXrkgJo2G3R9pfLC71owxpeQvdIiwrTC3mRcvQZOUt+vlCHWHNbGlDOQvfSoXu1XCVX+iGd2801SMEqGe382Wv5QB8uZsZGyIYsygX4F2UbaoD6m4vrZ8W7FHg/CgOUrUn7KWwGX+VtqqKI9MUz4/UJKTqmgJ/o+wF3TM/CPWQgaHYsECMOzl2joExatKEOYbHlI06s6heYNEAIA6iWc5HsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACFsbx+A8IiYYmnLmek1nGSNzkH6uiy5AzzFOyqbKJg=;
 b=gXyMWCJaX8Ely3oSANtOM/HC9lfZ3rsm7QwBASmRImpCuWwIMsTvUW4DzOUGTuQ0ZmNQIceyS67Z2ZDIsLmgJb1iLpY+m2vv7eUcz777jmA2Ib3QnbIyqHSb5zN2PGMTuxqqYuxxC6L1CDZReVKN1DxgB+GKKWF8z51r4XncbuQCnwETZ4AIRBU+j1tknt3rCW/1XqVyETOuMRSQbpzaM6pHDo9FjHHVyI6QL0z46H44zSIuNQz8I4xqG+tEAoXdOJnnLMWNgkRrEbPFmTDKCRBZ8b7SeL/xZr/tjS7Uce32S+TZniZmjLEk4icA7hpHkuqdZb0PyOyf2uOcXj5BVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACFsbx+A8IiYYmnLmek1nGSNzkH6uiy5AzzFOyqbKJg=;
 b=Kvoe1xRPUJ51rFMArQ7X5OEIu4+GFtGIeMs/xBTnlOgSrFc5plppeRcb+wxMvH6uCHRyf+/dVryFpnc3XYG2/kxFnliYR79SY72Q1a+ms7DsnUedIbpnORgxrprvjfKVjyvUZDOOdJE8rAxu1xXdfKt2TzvOVsORmeZ8CaAuCN0=
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CH3PR12MB8904.namprd12.prod.outlook.com (2603:10b6:610:167::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 08:25:56 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::ed15:6173:2f14:f539]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::ed15:6173:2f14:f539%5]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 08:25:56 +0000
Message-ID: <56a5734a-076c-4274-9d54-7da8a11fce89@amd.com>
Date: Tue, 9 Apr 2024 18:25:48 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH kernel v3] PCI/DOE: Support discovery version 2
Content-Language: en-US
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Lukas Wunner <lukas@wunner.de>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Sathyanarayanan Kuppuswamy Natarajan <sathyanarayanan.nkuppuswamy@gmail.com>
References: <20240307022006.3657433-1-aik@amd.com>
 <32ac2ee6-26b1-4f37-bd88-db1ef2a31267@linux.intel.com>
 <16120a31-c3d6-48a8-9355-7b063e28d242@amd.com>
 <CAC41dw9x8H2m=YB66+PA-GwiVkpCyT0PobdWvFXLHpAsQOE0ew@mail.gmail.com>
 <8d542410-d8e1-4243-939c-6ce7743a66f1@amd.com>
 <8d076ed4-5c3c-499a-bca0-9bd51d5454cc@linux.intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <8d076ed4-5c3c-499a-bca0-9bd51d5454cc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5P282CA0087.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:201::20) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CH3PR12MB8904:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ajSUsMRe1/Lpvlzm+OVHJqRLCsFWecSZGhFFzAubW01G8xsq1Ghr8YSPgNHyVJPmMidcwrx4fiCwbkbwuorf0OmHDxGDYCsa4VcyoX4IFlFdUA3D1YEFEMwAkv6cdOLABZoDsC53IPcr1r8Dw6A1VBQ7IY/ZPp1GO7gFfjRtKqxrJcQzGSwpGP+KY+BR4iFyLZRWtwCOd2Wd0OPA0CS2PTIwKEhYEArhPEOEIZn0EwqpV70VHmSQHJb8VqUBdXuTobqPKhbLBU14Kh99PfyDmVwopziOJPkxp8WnZZczX4uWoZ88vqdl4yKNMC8cR+t51Sez3f/c+5Rf7CMjs+vXnUM+Z9emOmRgFY2QwaIlOAeLISd1bAltkStjGIC/Mu0WpkzXQqPJz2IIH10ykPK+ovkpKN72NLPN2SOx+WxJg4suCccRjbvHqSteWK1xUuN1u8ZRyNd9ChuKRkaUy+wCB4Y84d0LihG6UndjeEoP/rCu6NjF3pNW0m80jqTJ1OXtLNr2SZrXU+NF0+zjm01AccSAn2UIZbmKXitbOR2VJYWJ75uiTujLS4PrIwsQKz40eMpUYYGE3LmKBj1TVxj4usl3wfbRvBAXMymEbROgs/0b/RmZBwqBSzeL+D0+O+AOUxfi8LZAW1rZ5jEqc3zI8ncJxHiSxUlyIO7MWDt7GKU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGdacHpGRU9YNVJ0OXg1OUc4cTlld093Z2o4bnRWem1GYjNzUS9odkpYcGtp?=
 =?utf-8?B?WUw0MnNIWVZBd2Z4ckZJU2xrNjhJUkRMNXpNbVpXUGRwaFF4NUl1cHNWV1NB?=
 =?utf-8?B?QTZCd3BIZGs2cktQK3dJWE5PeFNNYmxuSEhoeWd4UnNOM2lMOTZWZ1F1VkZT?=
 =?utf-8?B?SnBkQ0w5UExuZjFXZzR6WW54bWZuL1QzaFFuK010THZxNmZTV0swRVY5MXow?=
 =?utf-8?B?bnBaMmV2RTBEeFJ2eks3STZNa3BjcSsvK25pMEpqVkxDc2hNRHNJaXVmdisz?=
 =?utf-8?B?a0JtTGd5dW9JMHYyS0VSNUlzL2VQNGF6Q0s2N2N1dTVCTmxxZTNwRnh6SlVV?=
 =?utf-8?B?b04wK0pSNnBndDBoTVU4dTlPQitTbXZJdFQxYm1oamJsK3NWRVJjS0I2NzZM?=
 =?utf-8?B?MzlHWnhiMVphSkV6VmJveUN1QUUzSzJNcktHZkk3RklMZkovbzdSbkZPUGtr?=
 =?utf-8?B?SDEzaUN1UlZld0JGcWhqUnVuTlZVSXhIbWw5bVRMUktCOTcwcjNSazlwbXFF?=
 =?utf-8?B?d1FqREEzSWw2NVRzWTVOdXR6Wng0bGNUeFFyaGNjNjFQbkd2RkhPNjNQcGNV?=
 =?utf-8?B?b1hxcS9TdHpGblA2aUVGR1lvb1dtM0tpRUxsTC9ROFQzKzhFa3J5R2RMZWVm?=
 =?utf-8?B?R0VuVklTNGpxOC9WWnFwVFhzVlo5MU1nbm9GRk54MndCdmROcnpFZ0o4NlV6?=
 =?utf-8?B?KzhhRGVVM0NBRkJJbi9ETHFnUWNCZ0J0bWQ0cGttV1BsZ2RkOFU4R1ltMWQ4?=
 =?utf-8?B?b2czTTZOOXpkUlZlV0U0V3YzZDU2TWs3eTRUTHBwNThCdGdVSkVKVEl6QTBZ?=
 =?utf-8?B?QVhFUDhNNURGZkZmSHNrU2pTZlYyQ0V5aWU2UkhHanRVNHA4K1F3cTFiSmxY?=
 =?utf-8?B?RHVTenl5Z2FnTWVSZ1F2Q1ZNNzUvQk0vRE85UzJxaDRRUVBySERnU2JXY0Uv?=
 =?utf-8?B?UTIzdmRHbFNIVVZPRWpDU2oyb2Y5TE10Y2poaEM1YmNnNHNQNGVHbnFmUWN0?=
 =?utf-8?B?dkdwSkErMFBxdWVEc2lhY08xR2FHTUVMZDR6VmE4YVlla0V6bFhtQ0ticW1i?=
 =?utf-8?B?SGxHZ3lwWGRSL0NRSzJmekU3Smh5ekE4VnBIZERzcGYxcUV1eHl2aVpsQ0lI?=
 =?utf-8?B?NFN6TlB2NXZFRytlcHBxQWZQcnZaQzVQRDlzekZMVXZuWkx6SnVwUnp0dnpp?=
 =?utf-8?B?NjR4Mjl5V1ZrNkVpOUNRWXBMS1dhOHJuTS91V2Q0clBUZms3YUxaY2txMFVs?=
 =?utf-8?B?S2RYQjZ5Nk5ZeDBmZElhaXZmZTZ1NjRXb1U2SFV0ZCs2SXFjUDNPc2lYQTBz?=
 =?utf-8?B?QU05UUJoTmlpeFVoSHBmUDhibTZhSkROUXg4cVpQZXRuUnMveUtPUnZFeHRW?=
 =?utf-8?B?M2FDTXJMK0REU3pJRXZkS0xHTmJkb1ZVUmRaVDcwRXdTQmdVTUt3VTNPY3M2?=
 =?utf-8?B?NklWeU40ekZ6RkNUcldKZmNGUGFSOFVTUXFqS0VkMWxUUm9PT3Z5QzkwUG1z?=
 =?utf-8?B?cmVZb2ZvazZmNG5UZ3BPTDNCVGFrUG5kaXEwd1JmeEFjL2k1UHVndXBROUpz?=
 =?utf-8?B?ZjNRN0E1eWZZVThXR1lWeDNVY2k1bktDRnFFMjhpQndDZHpZS2ZCa2xia0Jo?=
 =?utf-8?B?L0ZwMXY5aWprblJtRW54aDFqUnVyZlNab3NBYTRPTDh3dW1DRlFPd0RWTHp0?=
 =?utf-8?B?YitkTVJ5elF5d012RzdiYUswVFdsZG5Mc2tsejJ6ZG4rbVhVc1JwTU52dlNy?=
 =?utf-8?B?L2p1WEtZcGMwSVAvaVVTS1hXdDBzSlBVREVkVld1YXFxYWpkSmxxNXcxWUdX?=
 =?utf-8?B?ZFN0RC9CVjVUQWh6REgyTm1EcGo4cmtQWjFQMUlESU5vN2xhVGpwYUFJS2hY?=
 =?utf-8?B?NU5DK0RrazErcTROQ2dEMi8xMTBwdkVPQnNqcGRTejV0cEI5MUE2Q21XYTIz?=
 =?utf-8?B?dThsWE1yczVpOWZ4U2o4bEtsY0phYldzSXJlb08yWi9BdE5WN0wxTTBKNVBD?=
 =?utf-8?B?QktJZWhFZ1dlYXBvaXcrSk9DMzRRQm83M290cDhiUGIzdlZ5V3FIOUhGQk0r?=
 =?utf-8?B?K2xTWHJBbVlxWVdleVIwWmtxb1Mxam9jWmFvM0RHaTA0VU5rcUNyL2kxdWUr?=
 =?utf-8?Q?/2PpTtQn69MeJT4WTuNK9jneB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54565b2f-eb1a-4cc0-b253-08dc586ead71
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 08:25:56.2813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTMx2EHW6IRUGlvLohkBh1A2k+1fDhxbo5NCnV/HcKAB/wn1hbuuCS/BRfeHfsGT82qdydBAhpRALFRMwZoCyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8904

Ping? Is this going anywhere? Thanks,


On 14/3/24 17:49, Kuppuswamy Sathyanarayanan wrote:
> 
> On 3/13/24 5:59 PM, Alexey Kardashevskiy wrote:
>>
>>
>> On 7/3/24 17:22, Sathyanarayanan Kuppuswamy Natarajan wrote:
>>> On Wed, Mar 6, 2024 at 10:09 PM Alexey Kardashevskiy <aik@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 7/3/24 16:06, Kuppuswamy Sathyanarayanan wrote:
>>>>>
>>>>> On 3/6/24 6:20 PM, Alexey Kardashevskiy wrote:
>>>>>> PCIe r6.1, sec 6.30.1.1 defines a "DOE Discovery Version" field in
>>>>>> the DOE Discovery Request Data Object Contents (3rd DW) as:
>>>>>>
>>>>>> 15:8 DOE Discovery Version – must be 02h if the Capability Version in
>>>>>> the Data Object Exchange Extended Capability is 02h or greater.
>>>>>
>>>>> Does this change fix any functional issue? If yes, please add Fixes:
>>>>> tag and probably CC stable?
>>>>
>>>> The issue is that before this patch the DOE driver was following PCIe
>>>> r6.0 and it was not working on a device with DOE cap v2 added in r6.1.
>>>> Is it "fixes"?
>>>>
>>>
>>> Since you are enabling support for the newer spec version, I think it will not
>>> fall under bug fix. But it might be qualified for the stable branch.
>>> It depends on
>>> whether you want to support this device in older(stable) kernels.
>>
>>
>> I am going to need lot more stuff (TSM, IDE, TDISP) in addition to this but it is coming much later so there is no point in pushing this alone to older kernels. Thanks,
>>
>>
> Got it.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> 

-- 
Alexey


