Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF67599594
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 09:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346923AbiHSHGD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 03:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346871AbiHSHGC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 03:06:02 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE9DE193C
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 00:06:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bm8EhRn79+cBXfgJ7RMitE8j5i36h0Mpj/srzwVENlgd19setV/SUoU+Yuo7KQc2zsadsT6TBLu/zYwDQr4dtW6rRRVkaFB0e7t2XHVSNyCd+FiP6BRq0eI6PCpTSZJwB3TQbk3+MIAX6r1bK3Zg9Z1NQhwPrWMRbEh5Ja7AAHebkXzwYmsOd8HWsSeMNvRapJKgoFBYVYCIxFG65zxkShcd/NC9CLY4Wyheu7ZnLFuXX4sD4I/IKftTm9mDln1U+nL2XUW/AxRzQF3tVgTVmJ/x1v5eY5MAgGWDwcwv8wOEtNmr8DtQuDtH1sj3SEIaYDfu8WukbOAw6TiH4Nse2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73SX5CrFtZhejT/p89iboesh6/GU1AKaUc/LDHHqB84=;
 b=RfpAIKmv81WiCWXy8g1Mu7KjFz7VNtpa0CYcU5dBCpdjeZf5tCdhdnEv1SyPkl32wPj95mMnxfpztFdexX2SjT0ttsvrporbDl3OUhdBxwh4qT94Tc9u11ZABv418JvFDkzNtirJPgpC/QX7dyKx8iOJW8NsE9GqfWi1jmBrhI8rmbxUQ5RaX2jOn44mxqq6pFzB524qwjUHHXPAyuIawl/UeTjaOKyNPoeVAxt72gW7D8e3bMG9DmByN07vAGOsyAj61kw2D8EY0VDqpj497DKBAIZpj6dtzCNa4Q2kjuJAkwA2KquPUuM9WXo1tGna4AP6dZDYF8pAgs0BcsS4Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73SX5CrFtZhejT/p89iboesh6/GU1AKaUc/LDHHqB84=;
 b=4RCAUay+iWl5JzPm5oiEjDeFIWtlxfXQr38B7p+rg4T0kI9W4mx8j8hNqhHvIpyELCQ2nHZ5deY3qamYUrQffOclKTs4AViwg4Xbvb/v1YbygKPMUkfmbB+cwe7Yn2hRZUfJwVmTeUljLQuhMdyDnwz762djW3bup990juVNuog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM5PR12MB1465.namprd12.prod.outlook.com (2603:10b6:4:7::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.16; Fri, 19 Aug 2022 07:05:58 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5504.020; Fri, 19 Aug 2022
 07:05:58 +0000
Message-ID: <c1a4da18-a6e1-c633-a585-1b4940a5de59@amd.com>
Date:   Fri, 19 Aug 2022 09:05:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [Bug 216373] New: Uncorrected errors reported for AMD GPU
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xinhui Pan <Xinhui.Pan@amd.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Tom Seewald <tseewald@gmail.com>, Stefan Roese <sr@denx.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        regressions@lists.linux.dev, linux-pci@vger.kernel.org,
        amd-gfx@lists.freedesktop.org
References: <20220818203812.GA2381243@bhelgaas>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220818203812.GA2381243@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 630930a7-4f96-4f48-a4a4-08da81b14401
X-MS-TrafficTypeDiagnostic: DM5PR12MB1465:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HfNe9CLMqJcZKEMzFh+/xX1A2z3hA3b0KXORyf5aQW8u/rV4UHjxafG0WpISXM+MUPv64bqbY+BeeCWcz2wSLaNrqM8iDZskxj18NpU55GWF5ADkRvlhTOgGB/i9OxMnJ5ciO9s6kZtF9Ef29RP6vl2seB6mfMRJ9bjojwu6mgt9hdIiyUeEaqS0U8dYj/d+CPdz/TXxeq/XP95Ne5RjndLJVRRjwhpRTRR6CYeEjacfOXxa82aPVzrbKMZohtLwag/RrobasdVX9AKj8ko0UkwSP4Qs151iqOj9x30xyIEMS2duZBjmo9k+rruLQPqBsUXwEYwejTLO9HsIE5J+AWT3aoTSQn9CzXuX24PSahDvzH3m336U8cxewxNUSti8BX1m5Tk4GlyJ6wXWAchu6LSVAc9MSb99Jg5JavXO6+W5CjQS6svOwNV7IhMyAcfFm3HwGIt/9FwXB7sy71TgfgvSiUUSJGfRAFQN8krLJXcPUSb3NpSEz3KYM3eUfZ8XUJz+LaYsxg7ktr84LMiPO37hot/8fkhkpKCu63+QyEluPmDs6IFCdz9qVgDk2usgb+1GklgC2TkQNGjx3oEFskUWhn05LgQJla+uchPa9tf6YBHzWkqLetPcl9rY+IP1plGl86Du77PStt9G4EnlH8/RIT4Rpr3yyy/8x2aySdQl5BPQMJ/DPkl1JUhpQs+LQuZVbqJgNjkIeLrTXVSPFcWMvUPWrjkNwxTKzlpPx2J9p06qqEwQzVpNGdJNd/AKjBzsl13nU91fiOHnQDGri9rLK8OcMTrjWBkW1aIGydf+nt7soc3qkDuR75E5Ot/BMQaI3/nPhwoAxbbKiUt7h1hctGb66cVIN91mIzrxZE0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(36756003)(6666004)(86362001)(41300700001)(478600001)(186003)(6506007)(6512007)(31696002)(2906002)(6486002)(2616005)(83380400001)(966005)(45080400002)(66476007)(66946007)(110136005)(5660300002)(31686004)(4326008)(66556008)(8676002)(6636002)(316002)(54906003)(38100700002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3VNQ1VvaEFPU1VJa3JYQkJlOStxZFcrem53Skk1VHdvSGVPOVI2RHpubUN4?=
 =?utf-8?B?SU1xeW5xQ1g2OGRkZWdxU0lId21MWmptTGVwb0xVYVBuYnhNRVhTWHZlVG5H?=
 =?utf-8?B?RnZxSGtsZVZQSmpxYXA1WFdHcjI1VmZkbFZaUll3cThDelNHamU5VnUyYm84?=
 =?utf-8?B?NkM5RkRpbC9kY1NwalJZeGdPWklxNkxnVWdNdTR4aVJEa3lRcWcyNzFHNUlY?=
 =?utf-8?B?elc0Z3pNRkZTTnlVSlFNN1pseDhuZU1FK0hMTjA5NHppdjFQbFBLMW8wQXQx?=
 =?utf-8?B?U0tpVVBmUXpmUGgvcFdsSmtvaTFCV2N0ajAxQ0J4NW9idTk1RFBYMCtZNUVL?=
 =?utf-8?B?NnBId0MvRmhsTG4xNzlLRW9kZllaOStjM24rdXJlckVxMlhWbUNKMEpYalVP?=
 =?utf-8?B?YlhnZlQwN3FTWnlxc1preXZSS2lHWmkrM05iOXljZ1hpbzUzM0JTQ2lWL1BB?=
 =?utf-8?B?Y3pob241QnZiUE9BTXVMS01ZTThtNHpjcnRROXJsZ2JLVFRHRXRwSk9XY1RT?=
 =?utf-8?B?cmtYd0NBczU5Zjh1NHhzN2QrK2tlR2tDVWFIb3ZDZnFuT1NpbU96cFVjeHhu?=
 =?utf-8?B?V2dON1dxbXU1ZlppekZJa3UyM2x6ZCtCbXRDYVhDQ0NTMmtGbExIOGkwWnZ0?=
 =?utf-8?B?UzZpbE96Z1NiMjArTGRmWG4zWnhtb25lZFRiRlZmME5ENGIwbno5a3hBc2VT?=
 =?utf-8?B?UGl3M3QwQ0VuSUkzNExpRlRiU3hycmhzcFh2Qk1nVzF0WmNCREZMOWxsVFVl?=
 =?utf-8?B?c1NKRFh4VXRrYlBBc1RCL2hLNzd3cFVwK0t3UW1QRGNRaFIvTnpWQ0s5aXJm?=
 =?utf-8?B?WjZONmZkZ1hiOE1hUlo5dDg2a21GelQ5Sms1RCtKUmpNSGt1SzB3bGF6eVVk?=
 =?utf-8?B?ZXZ1a0VqK29tQzJPdzNZNGVIcVJZYTI4RXo3RUc1NVdvTUxUUm1UNERpaFpo?=
 =?utf-8?B?MXhiMFoweFZJUUZ5RWFwdkdmYnhCTWNvRVNUYXhxcmRzZGhJaVRuZzlnLzl5?=
 =?utf-8?B?WWtDZUJtZVUxd1BOUktaOTFmZElpM1JsZ1hjakROQnlrMmdYcU14NU9jN2kz?=
 =?utf-8?B?S05JSURmT0J5YVVNZ0JueFZQWEpOcElVOEZ4aWcrdkNlckRSblUrT2JTSGJK?=
 =?utf-8?B?N0RlSS80MEpUUzNiU09WbFNiY3JOWDNEeHBsREozWnJ4ZzNHWExpZE5BTXlR?=
 =?utf-8?B?a2hQMUNvUlprUHQrZjRBQ3o5VDlyQmhpaHBSYTZncUVCSmRtRVltVkpuUnUz?=
 =?utf-8?B?a01WWUJ4czNSYkd1RzhFZUxZSDgvb0hwblhsZ0Judy9iR1VDaE9DVGZSY0hZ?=
 =?utf-8?B?ZU1FMUpCSm9mamtXWW93V1dkMWF6SkpkMTQ3UlJXd0tiR3JOczY3TGh2SjNN?=
 =?utf-8?B?SncrTTQ2eXlzUzNGcmhZdWJwOUgzTGV4UGtuTk5kRHZoMlhVQ0xHY0NJT1Mr?=
 =?utf-8?B?VGNrUWxpa2tuRmVYZ3ZiS0JxVTJVcjV0ZzdzVWdTOFpuYVhtNmJyOTNub3Fx?=
 =?utf-8?B?dUhSZUtUazRsQUNPQ2xPNVRzbzYwSnRIVTBIRE9LMW4zUmhuMXJaWXhzc2ox?=
 =?utf-8?B?aVdqZE5MdW9BOTBrQVhRdUw0bWNRdTRuakJSV3lvNnAzK2s4alZyQXRkbUFV?=
 =?utf-8?B?SmxSNUtZcnQ3OUtZZnlCUW1SWE9mQWhERElNVTN0SXlCWElldU12b04vUWRC?=
 =?utf-8?B?eWZQSG5MWmhSUkdYZVpBTzQyWCtmUkdSdWtjQUlHcU5NSnppSEhCRitTRG8z?=
 =?utf-8?B?akJZTE9SVFBYY1RkTnhaaDdQOHZZSWx6WjhDYUhXZ3lDQy9pM2dKNmh5VXF0?=
 =?utf-8?B?VnVYUmpzSXB0b29Hc1V0MWdEWXpOOG9ZZ3BkSHRDZjNML1MzeHcyTmpreWJy?=
 =?utf-8?B?OFY5TUVHVjVzYURCOXJQaDl2WDM0OC9TeTJESnYvTUd6TTUzRFhMd0VBc3hW?=
 =?utf-8?B?WXlJM2JoT3RXNGdaeTdpZ3A2a0hHWHhvN3NQaFJZall2VjVGbjRvUVlDQlZF?=
 =?utf-8?B?ZVhRU3lYT21qeWlURVdMTHkrOHBIZnFBVDhKSVRSb05IclZxWlRjNVdVaDJm?=
 =?utf-8?B?T3NzWlE2a3dOTzFONlEzL1JzYnZLV1RrYmxWLzJudzhxdXdoYjZOLzl0WEE3?=
 =?utf-8?B?K29vdStTdlYzWDZ3clkxTkJMUGJJMUt2UnR1K0VuUVFxbXdmcjRHbmZxL1Jv?=
 =?utf-8?Q?WLDY4nyXukoLXDyqxqzhHE1kALlwarlb2VLgp9yi4NnU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630930a7-4f96-4f48-a4a4-08da81b14401
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 07:05:57.8686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dcf26Ht0wqU0GKnXNwmTV6YFeTcCkg+b4VuofD4euhCUTIMPWZqzIvwC7RdpzMRo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1465
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Am 18.08.22 um 22:38 schrieb Bjorn Helgaas:
> [Adding amdgpu folks]
>
> On Wed, Aug 17, 2022 at 11:45:15PM +0000, bugzilla-daemon@kernel.org wrote:
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D216373&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7C62cca3872daa46ee7a0a08da8159950a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637964519011973266%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=TFF9LWIXBbdrU27%2FbjDfP8FTUhW874X8%2FA0kIrGrjJs%3D&amp;reserved=0
>>
>>              Bug ID: 216373
>>             Summary: Uncorrected errors reported for AMD GPU
>>      Kernel Version: v6.0-rc1
>>          Regression: No
>> ...
> I marked this as a regression in bugzilla.
>
>> Hardware:
>> CPU: Intel i7-12700K (Alder Lake)
>> GPU: AMD RX 6700 XT [1002:73df]
>> Motherboard: ASUS Prime Z690-A
>>
>> Problem:
>> After upgrading to v6.0-rc1 the kernel is now reporting uncorrected PCI errors
>> for my GPU.
> Thank you very much for the report and for taking the trouble to
> bisect it and test Kai-Heng's patch!
>
> I suspect that booting with "pci=noaer" should be a temporary
> workaround for this issue.  If it, can you add that to the bugzilla
> for anybody else who trips over this?
>
>> I have bisected this issue to: [8795e182b02dc87e343c79e73af6b8b7f9c5e635]
>> PCI/portdrv: Don't disable AER reporting in get_port_device_capability()
>> Reverting that commit causes the errors to cease.
> I suspect the errors still occur, but we just don't notice and log
> them.
>
>> I have also tried Kai-Heng Feng's patch[1] which seems to resolve a similar
>> problem, but it did not fix my issue.
>>
>> [1]
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pci%2F20220706123244.18056-1-kai.heng.feng%40canonical.com%2F&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7C62cca3872daa46ee7a0a08da8159950a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637964519011973266%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Y0ofsDYgNGXoQn2e%2BbCM4NHaMOUnEJPqL8lqs1YJzrQ%3D&amp;reserved=0
>>
>> dmesg snippet:
>>
>> pcieport 0000:00:01.0: AER: Multiple Uncorrected (Non-Fatal) error received:
>> 0000:03:00.0
>> amdgpu 0000:03:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal),
>> type=Transaction Layer, (Requester ID)
>> amdgpu 0000:03:00.0:   device [1002:73df] error status/mask=00100000/00000000
>> amdgpu 0000:03:00.0:    [20] UnsupReq               (First)
>> amdgpu 0000:03:00.0: AER:   TLP Header: 40000001 0000000f 95e7f000 00000000
> I think the TLP header decodes to:
>
>    0x40000001 = 0100 0000 ... 0000 0001 binary
>    0x0000000f = 0000 0000 ... 0000 1111 binary
>
>    Fmt           010b                 3 DW header with data
>    Type          0000b  010 0 0000    MWr Memory Write Request
>    Length        00 0000 0001b        1 DW
>    Requester ID  0x0000               00:00.0
>    Tag           0x00
>    Last DW BE    0000b                must be zero for 1 DW write
>    First DW BE   1111b                all 4 bytes in DW enabled
>    Address       0x95e7f000
>    Data          0x00000000
>
> So I think this is a 32-bit write of zero to PCI bus address
> 0x95e7f000.
>
> Your dmesg log says:
>
>    pci 0000:02:00.0: PCI bridge to [bus 03]
>    pci 0000:02:00.0:   bridge window [mem 0x95e00000-0x95ffffff]
>    pci 0000:03:00.0: reg 0x24: [mem 0x95e00000-0x95efffff]
>    [drm] register mmio base: 0x95E00000
>
> So this looks like a write to the device's BAR 5.  I don't see a PCI
> reason why this should fail.  Maybe there's some amdgpu reason?

Well I have seen a couple of boards where stuff like that happened, but 
from my experience this always has some hardware problem as background.

 From my understanding what essentially happens is that a write doesn't 
make it to the device (e.g. transmission errors can't be corrected).

It's quite likely that the write is then either dropped and doesn't 
matter that much (just clearing the framebuffer for example) or repeated 
and because of this everything still seems to work fine.

Either way I suggest to try this with some other hartdware 
configuration. E.g. put the GPU in another system and see if it still 
gives the same issues or put another GPU into this system.

Regards,
Christian.


>
> Bjorn

