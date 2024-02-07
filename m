Return-Path: <linux-pci+bounces-3212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D057584CF8A
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 18:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 352E3B294FD
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 17:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B3A823B9;
	Wed,  7 Feb 2024 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4jzZdyCN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDD2823C4;
	Wed,  7 Feb 2024 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325970; cv=fail; b=Z95btIsUngyy4Sb29oRWE8po2cw+e7ypgCtI177t+yXqjCAHvedv/WG4dqoiptTJ0mPW3EOTvYhOh7xGYhs8u5kUf+RDvJEcrcDhNDGbtkRlLieqN4zGO3kO+q4xD0jwObOqJzLLpgkYT8wEbr8qkZFRiCDt7xsOZliLwJZwdtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325970; c=relaxed/simple;
	bh=eiYN7Mya88wFCZfxsJ/bG0ITHYeDYHP8LLLOGgW6XY8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=fqaJzUhDeki3OGSYv6ooNgLOAQBCapuoXyfKp04FtwwFFTlMZPIQ9JSyPJvjQr76bm54wKnz+aODwUfnzbRxIcEk/EKnzjE7N7RjOPwBG7w3haHndnZ3leM+rp3NBZKtjbchgMCTvd+zQIeqB1kb8k6mkfthtT4dkq09Uzlsj5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4jzZdyCN; arc=fail smtp.client-ip=40.107.101.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8nW8nBtJdlAeBHF8WUpoS8V5gQpGueu2eylu+0jywuKTYX5Uy3E3LnG5zpmyTSEP6865VnUnO7mnmQw1IEuzIFL1G/jC6pLkebaMlm2iWP+iwteiYq9GixDQnWB6QArNMnmy5Y1m4cXdW7fAiPptVikdfpGD3fz0HeM6RoYlkKrZw/bQD2s2UGLRydSGKOyFNypysA8oVHMx7WxFThpQ1ang6ek5+K0ap3/RD7ibXQwkp6AizPXd0nfUiRtBrpqAgUDoP7Vy30CZaoDQvpvimEhcr423XSfKDm4koKriod6spX5u8FZCFj9Jnlcvtzf0DvmTe2Ff5s82PdrnzK51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WjPUlrYhWs2FIt10ubRHH9IWywhN30ZWe0YvmAK1zU=;
 b=EjMIBDSwgoatLlDOoStMKAslQGdvJF5WERSQmBTUBqmhfFSw59UsbDTTD2pViMniN6wYE0eqaYPNzRrbKdxX5BmIr7b54nwC04hpqyR4734xyOaGqeJE80C07BeIFSmSh1x6KhcdkhT1JDoxfE1YUuvMkzcnRlOaFxwD3n5KSNXv2g/rI2jIADGVYJvet/I4tjgnfVGxxw7V+XnA1QQqQEthw49heJpqQzeOzxrSBBU3Z8jWsOXyIxNE/6H1zJWEsnD1klvuIXLLpO4ajBBTVklr6glEhizHAjNLB1FJPijXzC5D61T6+X3QGlsm2JvQGu8tfR7N3BJoVulT7XFnPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WjPUlrYhWs2FIt10ubRHH9IWywhN30ZWe0YvmAK1zU=;
 b=4jzZdyCNdS3imagtjjletakduXhaS4U09ol7ue2Yhefc3UikSC8PBOP0oGVAreaWvI5YrUrsR+RSwF2Y/gptOOH8iaHDwc2JAUEq4fGWPB7HvTYmdW2qMJxS04wNdxaBEGXyn+3ZAlGHSSnBovreDritdLoYJp7EmRRlMyLCu/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 17:12:45 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::bdc7:f7b9:a4fc:b793]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::bdc7:f7b9:a4fc:b793%4]) with mapi id 15.20.7270.015; Wed, 7 Feb 2024
 17:12:44 +0000
Subject: Re: [PATCH v8] PCI/DPC: Ignore Surprise Down error on hot removal
To: =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>,
 Yazen Ghannam <yazen.ghannam@amd.com>
References: <20240207111256.110982-1-Smita.KoralahalliChannabasappa@amd.com>
 <ef39439f-e9ba-848d-8fef-73b446db15e5@linux.intel.com>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <dd2da83e-6749-dc85-77dc-24864ac9a887@amd.com>
Date: Wed, 7 Feb 2024 22:42:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <ef39439f-e9ba-848d-8fef-73b446db15e5@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::20) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: b78f65ea-97ea-470f-3906-08dc27ffffd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rEzdqt8cI6DV3VpLlVHPDlRpgmLPSYTnB1oJWoh15EjaS+ev1JBIcg+TmiZfo3fINJGtODvXONcGEn8iDlSoHmixXs193wIe5TRiG9f4iCqo2enjs+8FhH4Ufsl/4XAQ8vToVazME3CffAvZ5XSMoUWAVcYQVc/0M32s20F495LYqWhDNGhMA62b3fzuhvNEl1MaA9beDnTvgaiPIxMjX9/UCxRxi2dcZsBdwEECDYHqcxB8CeEmPOucHz0wr3+F2KePshOnhw+div5WOBS2FJ28rEdBBRZkkhJ9DspUe9E4aE+ND6HprYYW7UC6L5OlGQrmpl/EFJ30YH7/xFsJnqJndIJ/a3xwkhuqMB1DN6ilRZsw5OwZPiCg2fN1hjlAFHxDrOs+zZWKYGmcCkkLu8Aa+N6r6TN8Bt1JNbVKAaabeZb3hsqcE0WsZ/mfN+JJumKs00k7mS9UsuweD9aVlo0Zrnn13sYm54Zc5bviySQAvrzlPAKOEcZGfvlIodCipZSX8sjAjA2/trZ5P8BKWL/SRTHMhsTPEZodQ8f7wpPwcR2UaRjF0tTqT2+1TFUgNctqZFJUlr1Jd1NEUKwr07NbrDSJdcoLAzkdvBlP3H22oadOiKSaUbYcdJimsBpx3rlEps3IImqzBcyS9ZV5Xw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(376002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(53546011)(478600001)(6506007)(6666004)(86362001)(6486002)(966005)(36756003)(6916009)(54906003)(31696002)(66476007)(38100700002)(66946007)(66556008)(41300700001)(316002)(5660300002)(2906002)(31686004)(2616005)(6512007)(8936002)(8676002)(4326008)(83380400001)(26005)(66574015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlptQWxDb3RzTjJObkJoVEE2KzF4azl1M3gwNm5TUzBMdG1wWUZCcjE5c3da?=
 =?utf-8?B?NDBpU2xDRHlpWU1sK08xS0QyOGdNNThXeGF3MWMxMWtnWHJnZW1nUjNrUFhX?=
 =?utf-8?B?Q0xnU0d1bFIvSDU2c0s0YTJDaTkwU1Q1bWRlb0gzV0RMVlREODB5MjVPRE5y?=
 =?utf-8?B?czdWdjVxdjJpN3p0c3NqZHFXdHlpc1NQdFBDVkJPZXVidE1oWVU0cEF0anVE?=
 =?utf-8?B?UkVTaVNHS0V3b2VVN0hDYXpaNUFYZUVPT0NZdy9jMXVFb0Q1OHRET1FiaHFp?=
 =?utf-8?B?WlVTcGp2anl2LzhjMlY0VmNoTTdzS1BDM3NyeXJoWGVNdC9xMFUrbElOSmFI?=
 =?utf-8?B?d2pvcWVzY2FPR0l4bDVZK2xlOWJCS241YmY2UG5GdGF0MkNoQmRxQWJCSmEr?=
 =?utf-8?B?bFJXdFBBMUFTcTV5ck9OQXJockxyeVJJZm5OL0Jpa0xGdUwrazFvTFpiUDha?=
 =?utf-8?B?VXdYQko3SnlPWU4rN0RGblZ3ck9OL1R3cDFkLzVvMXphTFE5QnlxZ2JpRmpY?=
 =?utf-8?B?VVc5K3BLZnFuRy92NzBEaHpwczlRN1VYenA0Sm9NUndjRGRIK1FJbi9rZklO?=
 =?utf-8?B?VmRlVzlFelpackZXbkNHTmpZMS9yYVZSRE55ODFqczh0SDBDd21RWHlVOWM4?=
 =?utf-8?B?Z0NyUHkvSkRORUlkSVVCTDFsTytDUnU5TGVUUGtlb1hXUFYvaWhFSUVuRG52?=
 =?utf-8?B?MExHZ1hiQXovZE50RGJOdVQwb3VOM1VzVFJnd3RNcVdIeWgwNk01c2FPdmtW?=
 =?utf-8?B?M1lkOUl4Umh5UUNnNEE2S2o1OGhwNERkZmg4RWdlR3RSUUNucGJsQmZROXBs?=
 =?utf-8?B?Wk51ejkrcFhZaFNSaExySk4yTVQvS21lTUkyc1JsQkgrQzVoN0JxZnNwU2g5?=
 =?utf-8?B?ZHhtM2w4YnFOcFJRM3VpMXd2aGxqQU9Zamc1ZER4V2k1RUVwWktTUXJIYnAy?=
 =?utf-8?B?TVFjYVJPYkZ3RjRyK01qaWhWekNRUVNJbWIvWkdqRUJIVFhpcXpWSXA1cDFF?=
 =?utf-8?B?OTdMaEVrWFhIL1pMTFBONHFQbmwrcmNQTDJBYlpTMGplbnN6Ynh5UVFtN2ky?=
 =?utf-8?B?KzdieDNHUEhpTjNFQWxYMFA3WXQ0MXhtRFA4M3pSdUt6dTNKR3BHUkVjR00w?=
 =?utf-8?B?azVsd1VNblFNdnpuUCtTYVNDbVhUZ01PMEoydjdxUWFvV2RvOEhrQmcxLzJz?=
 =?utf-8?B?MzBwc2VQQWVkaGExdUdRWUsvT0JSdXlwV3ZuTXhyZVF1S1ZPUkdabzJqVEhZ?=
 =?utf-8?B?MTE2bkVvdUdpMHd0dlk5clE5N0NOc1V6d2NsQlpZeU5qTFhvb1NJc2RtQitj?=
 =?utf-8?B?Qkl4UmRtRlVMZWs1MVFoT0I0UzByZms2NVgxbk11UDh1SDZ4THh4ZmtqYUNO?=
 =?utf-8?B?K09DZkt2bVVERjQ5em85eGFmdi9tY2Nrd2xOQ1drdi9pSThsUWg2TENVQlBz?=
 =?utf-8?B?WDBERGZtZjNveTUxUWlOYStwMzd6UzA2cFYvNlBYamN5Y0o3REt1aGx0cHdY?=
 =?utf-8?B?RFBITmdWL0xnS2NKbHN1MnA3ODZkQjErWkRBRE5ha0tnL0l0am0rU2xKRmIr?=
 =?utf-8?B?NlJWY2hHanNOUGQvejJVMU5qUUFDWVhINHhXcHFYT1lHOUJoKzFhNVZLcjhG?=
 =?utf-8?B?TUdocFlBbG1mLzJJM3FYZDV3YkFoeVg5UVpNT01XZFc4TlFYYjJTMUM1cysx?=
 =?utf-8?B?dDdGVVZDMmxxR3grZlFLajd4SlJSeWgyQzkyUFQzZWowRFpheEZDV085WURX?=
 =?utf-8?B?Z2JUNU82OTh0S2QwMFhVM09tRDdFdnYrYXgxbjRUcHZSSnR1TVpNMFZWUGUz?=
 =?utf-8?B?NkppeUlYcEJHSVpDYTBlSzFXbk9nR3MxRnZkLzF2OVo3T2I0MitENyt3SURH?=
 =?utf-8?B?M1NhN2Q0aTNUb01xeGloU21wZWMwc0d6MnN1aG9rRzBLaVA0Nzg1WU9zYmlT?=
 =?utf-8?B?WEtWcENOUHhQK01Ub2pFaGVMaXU4S25UR0d5MzdvdHFoVGRuMzVZRXFaMzk3?=
 =?utf-8?B?VnJDdzNWN3l3QWZoWU9XaGVUYktqNVVXQ20rRVBFZnZIa1NNZTNWTWkwU1FI?=
 =?utf-8?B?VnJFZlhBYjVTQWVudFI1V0tMVFp4YUVhSXlWUUNlbjcxZ0lFeFFwQjg1RFNp?=
 =?utf-8?Q?htONTRyp8MoQ+H2roACFTIN4X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78f65ea-97ea-470f-3906-08dc27ffffd2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 17:12:44.7670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74j2XcrbWtZkfkUF5h+xoNScJIOJvxdKV/6paEBcw1wYrB8Gi0kcfMLwONSqqeYryRHu051BV0R59Xlwuip7EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853

On 2/7/2024 5:05 PM, Ilpo Järvinen wrote:
> On Wed, 7 Feb 2024, Smita Koralahalli wrote:
> 
>> According to PCIe r6.0 sec 6.7.6 [1], async removal with DPC may result in
>> surprise down error. This error is expected and is just a side-effect of
>> async remove.
>>
>> Ignore surprise down error generated as a side-effect of async remove.
>> Typically, this error is benign as the pciehp handler invoked by PDC
>> or/and DLLSC alongside DPC, de-enumerates and brings down the device
>> appropriately. But the error messages might confuse users. Get rid of
>> these irritating log messages with a 1s delay while pciehp waits for
>> dpc recovery.
> 
> dpc -> DPC.

Will fix.

> 
>> The implementation is as follows: On an async remove a DPC is triggered
>> along with a Presence Detect State change and/or DLL State Change.
>> Determine it's an async remove by checking for DPC Trigger Status in DPC
>> Status Register and Surprise Down Error Status in AER Uncorrected Error
>> Status to be non-zero. If true, treat the DPC event as a side-effect of
>> async remove, clear the error status registers and continue with hot-plug
>> tear down routines. If not, follow the existing routine to handle AER and
>> DPC errors.
>>
>> Please note that, masking Surprise Down Errors was explored as an
>> alternative approach, but left due to the odd behavior that masking only
>> avoids the interrupt, but still records an error per PCIe r6.0.1 Section
>> 6.2.3.2.2. That stale error is going to be reported the next time some
>> error other than Surprise Down is handled.
>>
>> Dmesg before:
>>
>>    pcieport 0000:00:01.4: DPC: containment event, status:0x1f01 source:0x0000
>>    pcieport 0000:00:01.4: DPC: unmasked uncorrectable error detected
>>    pcieport 0000:00:01.4: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
>>    pcieport 0000:00:01.4:   device [1022:14ab] error status/mask=00000020/04004000
>>    pcieport 0000:00:01.4:    [ 5] SDES (First)
>>    nvme nvme2: frozen state error detected, reset controller
>>    pcieport 0000:00:01.4: DPC: Data Link Layer Link Active not set in 1000 msec
>>    pcieport 0000:00:01.4: AER: subordinate device reset failed
>>    pcieport 0000:00:01.4: AER: device recovery failed
>>    pcieport 0000:00:01.4: pciehp: Slot(16): Link Down
>>    nvme2n1: detected capacity change from 1953525168 to 0
>>    pci 0000:04:00.0: Removing from iommu group 49
>>
>> Dmesg after:
>>
>>   pcieport 0000:00:01.4: pciehp: Slot(16): Link Down
>>   nvme1n1: detected capacity change from 1953525168 to 0
>>   pci 0000:04:00.0: Removing from iommu group 37
>>
>> [1] PCI Express Base Specification Revision 6.0, Dec 16 2021.
>>      https://members.pcisig.com/wg/PCI-SIG/document/16609
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>> v2:
>> 	Indentation is taken care. (Bjorn)
>> 	Unrelevant dmesg logs are removed. (Bjorn)
>> 	Rephrased commit message, to be clear on native vs FW-First
>> 	handling. (Bjorn and Sathyanarayanan)
>> 	Prefix changed from pciehp_ to dpc_. (Lukas)
>> 	Clearing ARI and AtomicOp Requester are performed as a part of
>> 	(de-)enumeration in pciehp_unconfigure_device(). (Lukas)
>> 	Changed to clearing all optional capabilities in DEVCTL2.
>> 	OS-First -> native. (Sathyanarayanan)
>>
>> v3:
>> 	Added error message when root port become inactive.
>> 	Modified commit description to add more details.
>> 	Rearranged code comments and function calls with no functional
>> 	change.
>> 	Additional check for is_hotplug_bridge.
>> 	dpc_completed_waitqueue to wakeup pciehp handler.
>> 	Cleared only Fatal error detected in DEVSTA.
>>
>> v4:
>> 	Made read+write conditional on "if (pdev->dpc_rp_extensions)"
>> 	for DPC_RP_PIO_STATUS.
>> 	Wrapped to 80 chars.
>> 	Code comment for clearing PCI_STATUS and PCI_EXP_DEVSTA.
>> 	Added pcie_wait_for_link() check.
>> 	Removed error message for root port inactive as the message
>> 	already existed.
>> 	Check for is_hotplug_bridge before registers read.
>> 	Section 6.7.6 of the PCIe Base Spec 6.0 -> PCIe r6.0 sec 6.7.6.
>> 	Made code comment more meaningful.
>>
>> v5:
>> 	$SUBJECT correction.
>> 	Added "Reviewed-by" tag.
>> 	No code changes. Re-spin on latest base to get Bjorn's
>> 	attention.
>>
>> v6:
>> 	Change to write 1's to clear error. (Sathyanarayanan)
>>
>> v7:
>> 	No changes. Rebasing on pci main branch as per Bjorn comments.
>>
>> v8:
>> 	Just return "status & PCI_ERR_UNC_SURPDN" instead of true and
>> 	false and allow C to handle the conversion to bool. (Ilpo)
>> ---
>>   drivers/pci/pcie/dpc.c | 64 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 64 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>> index 94111e438241..ba7240a2ba2f 100644
>> --- a/drivers/pci/pcie/dpc.c
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -303,10 +303,74 @@ void dpc_process_error(struct pci_dev *pdev)
>>   	}
>>   }
>>   
>> +static void pci_clear_surpdn_errors(struct pci_dev *pdev)
>> +{
>> +	u32 reg32;
>> +
>> +	if (pdev->dpc_rp_extensions) {
>> +		pci_read_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS,
>> +				      &reg32);
>> +		pci_write_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS,
>> +				       reg32);
>> +	}
>> +
>> +	/*
>> +	 * In practice, Surprise Down errors have been observed to also set
>> +	 * error bits in the Status Register as well as the Fatal Error
>> +	 * Detected bit in the Device Status Register.
>> +	 */
>> +	pci_write_config_word(pdev, PCI_STATUS, 0xffff);
>> +
>> +	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, PCI_EXP_DEVSTA_FED);
>> +}
>> +
>> +static void dpc_handle_surprise_removal(struct pci_dev *pdev)
>> +{
>> +	if (!pcie_wait_for_link(pdev, false)) {
>> +		pci_info(pdev, "Data Link Layer Link Active not cleared in 1000 msec\n");
>> +		goto out;
>> +	}
>> +
>> +	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev))
>> +		goto out;
>> +
>> +	pci_aer_raw_clear_status(pdev);
>> +	pci_clear_surpdn_errors(pdev);
>> +
>> +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS,
>> +			      PCI_EXP_DPC_STATUS_TRIGGER);
>> +
>> +out:
>> +	clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
>> +	wake_up_all(&dpc_completed_waitqueue);
>> +}
>> +
>> +static bool dpc_is_surprise_removal(struct pci_dev *pdev)
>> +{
>> +	u16 status;
>> +
>> +	if (!pdev->is_hotplug_bridge)
>> +		return false;
>> +
>> +	pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS,
>> +			     &status);
>> +
>> +	return status & PCI_ERR_UNC_SURPDN;
> 
> Thanks for the update, looks more readable now.
> 
> While staring this now again, I think checking for error from
> pci_read_config_word() would be useful so that it cannot confused with
> surprise down?
> 

You are right. I should have it like this:
..
if (pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS,
			 &status)
	return false;

return status & PCI_ERR_UNC_SURPDN;

Let me change and send v9.

Thanks
Smita

