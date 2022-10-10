Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EFD5F982A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Oct 2022 08:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiJJGOy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Oct 2022 02:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiJJGOw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Oct 2022 02:14:52 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0628512095;
        Sun,  9 Oct 2022 23:14:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhJrQqRNYYVvSkdAPA/muxUxmdUvb8exJvV/y+dWsKkr+kQ/HiqAYPNIbiKwV7yRz+w58BQRRgGuv8IZ54L9FfvECzwcjTST4PB3E6s5RvRJjeBLach+kWsOhnhoCHHTK24i61Tfii0k/ZrCFVh4C0GpFFkAQCOylq11ZPulnQ74S6lJZ0wwHlt69Wn2k4IBbhwUYc4IoaLwHdyF9u6uGidK66xQXaBrc3btphAFHW5tHWtHS4rLPQjvwH7qed2wCh5yeGh4M/o35Z0XsMhS7Xp7AZSSzehtYiWIaUZKhmzGU1bT5f6MeKPgIERU5JuLzipuL4nvFPJlMFTdLQ+O9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwbZ/JkeLcMvFJ5XD7z2fmawdxq+S/hgeBkmsGpqPxU=;
 b=nDSSjs3xMZIURTTHnLx5u6GhvRt2dIg/hFzxdcQq8+Ry8reJGQiUI+s52Fyam3pnJVPRLctFq8G2vRmRDMaXJ9LtTvHAbMaXxERRSNfvSuYHCaoP+3qk6XwwRvyUkLKqmKv8JmAJeM6820IXXZQuIYkDZ82P/d0+SGgREstEexxziaj92vlWPAFFaUpHv6kVaoIi5TJPxyAujGreUFPK0FFD/+Iwt5dGKzA8N5Ie9aavYMifEizHL/kQ/A7Od7MOSdm6RGaeC0De8zkOzIn8TAcpFNEKfZ8PEs4vSzEhFR4naBEVS2Ag6I22SbDABUwXWQDHd6xNEAF3kXeQbJlXwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwbZ/JkeLcMvFJ5XD7z2fmawdxq+S/hgeBkmsGpqPxU=;
 b=INz8zfOKGjhEWZW8P+U/+M1yUlzleb7BrzYbl4N5Cb+GggCVXLIISyty4HDEPsFw8dUpmAI1mN1hHnCSREsbSYvYGdyLvBLR/BnmJorhbip4mxQANHN7ub+8eeWK+snwmrLs/yypIFBtekQPCVwaaoRxyeRKyL1zbZUHWc/wCBM0igHqlOoMN6QCXFg5Kb2tR65wTLWs+Fuea/HUjLDzMFgiK+JOSTrUW05KW8s2cIhqCDiIRZR9k1Yh887PG2bkQUWCyhMaAj2o/gmZJGk1CN5lscTFnt4vSBfuXuAXYLDY/fYONunl8uxNW3GwVo+hyZiltDHV2ozXLf+uSdJ/JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by PH8PR12MB7205.namprd12.prod.outlook.com (2603:10b6:510:227::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Mon, 10 Oct
 2022 06:14:46 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3%7]) with mapi id 15.20.5676.031; Mon, 10 Oct 2022
 06:14:46 +0000
Message-ID: <9210e81f-15ee-6c54-bfbb-1188da48dd68@nvidia.com>
Date:   Mon, 10 Oct 2022 11:44:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V1 0/4] GPIO based PCIe Hot-Plug support
Content-Language: en-US
From:   Vidya Sagar <vidyas@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, lpieralisi@kernel.org,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kw@linux.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        mani@kernel.org, Sergey.Semin@baikalelectronics.ru,
        jszhang@kernel.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>
References: <2a465222-342a-418b-95af-9948f6ce9065@linux.dev>
 <20221003180949.GA2104321@bhelgaas> <20221003182147.jp5gn2jpnf4gucdl@pali>
 <364fc93d-a4b5-59cb-c62a-8e3b32507523@nvidia.com>
In-Reply-To: <364fc93d-a4b5-59cb-c62a-8e3b32507523@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::14) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|PH8PR12MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: 3594f222-4f3d-4ad8-c1d3-08daaa86ba55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4SbW4r3lY4Dy0h2zCK3FyyYyJlp/w7vDMnPQdzq8PT0gKD9Ep9Y/telsPNFyjxheaH2zauAGvaMfjHU4GAbw95tXeL8oXHbZtzVOc1anv/5sjru3OHGBFyc2Ws29BA9vzx3dkQ9YyfZJnFR0vZ6vJbXuitsJhpgZQEvVA6nc9/THSTACFP2L/87it0fh4aIPHpWmj7OyXh0Z5yEYCApFzx2gwAJY+8mmyfes6U7U8EZqFqW3tW78Sx4dyWJJbIT+xdPhA1NDVZ7Pv9hc/XGMZ01aLeTIR5Ks4rX07wcTtX7yEu+5E8NIhtCTs0sXnNPETgg+csTOuk0XLdmzQ4wuH/7lHsvmfsruAvN+UyMjJrkdj68hYEaVb3yUW/d/yVD45HQkbPfNH9lufUSIUN01HlLvWIc7/jup8VdX6ZHIE7+jpWx3Olf8P0+770qj2nQpGgA20LlGDDIdLs3XWJQKLQLKnkYEmT0cSGGwr76Agd+Uo8N6T8C4xt/+chPiu2z6d74k0muxeQc8Yc/UXosoAX1JSIR22HlIAJeawqDGrSnPXjOffpLRAr5wGPuZsjBR4Tt+ayttHpvyRZsG7EYbLLhT4tsBlYwopR/n9mVdjze2DHsttSbQEJjQx8hQTry34jrV0oPBX5ntgvaf3r/Dg9NPSyaenKKUgapyfFJnxPJf0M0icpk/e3xyJNWSdJ3X+beN2C/MWD2Wmy2tsQ7K2/udQdxeo9ER9uE8NlO5ixNqtXKF695ul4uKGi3IX6294AREj+KkTgH6MG2iajObpmNXfyhdRLuP5FfnjeCmaL/DWCk/t2yQJCmK/md7rvKTXwERlNc9f1Gy3wL9YxB+vd6QsoszIFKQm7kl2tXu4pHzAKpm/dc/LNT4e6wcyqwj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199015)(26005)(6512007)(5660300002)(6506007)(41300700001)(6666004)(4326008)(8676002)(66946007)(7416002)(8936002)(66556008)(66476007)(66574015)(38100700002)(316002)(2906002)(86362001)(36756003)(31696002)(478600001)(53546011)(966005)(31686004)(186003)(6486002)(2616005)(83380400001)(110136005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0gyK0huMCtCOWhXVHRxRXlSWFI0Y3JRTmhPeXQ1VXQvSlY2SXRnSHNleldq?=
 =?utf-8?B?aXZaWUZZQ3RCaDBnZzV6WmpFRTQ0R3IyNWQyY0ZBOHlHenhFdXBQOVRDNVlu?=
 =?utf-8?B?dlY2M200d0JLdWtQcVFtT1Nvd1JWUGRaMmhPK3djT3BpQ3lwejllTWhLS29h?=
 =?utf-8?B?bFZnQ2R1QTZLeW96TlEvRDdZLzRqbUtuNEZDVThBK0RsYlJXSGlNR2pBcmVl?=
 =?utf-8?B?b0lkVHMvbkcvb0FMZUlNVnhxZGtJTmd3TDNqcXloYnArYkhqV2NGV2tibndj?=
 =?utf-8?B?Q1R3Y010c2RHaE1IaFZNcmFxL3BoK1VsM294Uk9IMm83VkF5UWFYV3loRlZy?=
 =?utf-8?B?Yng0bGk5K1czSlRKSlpSVFozZlR3dldVQTNHcm14RDJVc3A0Z2tRNmdER1Fj?=
 =?utf-8?B?Q3VUejJMcnVvZHNsZFBRL1ZiRFlEd3R3clExd2hVTmR5WnQ1NzZmWkNiYndj?=
 =?utf-8?B?Yyt6OStZbTBSYXhWUTQvc2I1WXBWSE1rQ1hqSlc2ZEhqYzVJMmRhaGtzN2Fl?=
 =?utf-8?B?TjlUdXAvZXY2UVVBS2txZmFndXgyNzhqcW1MOXZtY2lVRTdlYmtYcTNoZnlV?=
 =?utf-8?B?UC9haEx4Tzl6UnNabHpRVXZ2bllleCswbkNNUHpGZGNNbjE0cTMrTXJFYkxW?=
 =?utf-8?B?eHd0OUhMUTdyREJhak9Pc0xIdzkwTHY3WVhzbnFSc3JtOWhoc2VROENlaXZy?=
 =?utf-8?B?MFZhcTN3UVhOOXJZN09BaHgyb3JRMzl6UDFDb3Mwck0zM2tTeFBSaXJoRmg4?=
 =?utf-8?B?dmNlb3NnRGJvNDFrTmtwdjdCMUx4a1RSbi8ybk90TWZDdFZ1RitPUnJsTEhz?=
 =?utf-8?B?T1RTdHRIYzQ3Y0VoblU4TWJOOGJiRnZkNUJ5blNCVmhKNUJiZzhBR1p0VjlC?=
 =?utf-8?B?MmRYUzF4cUZRNVVsaVZPaER4UG5aTVI1emVra2doczROck9FREQ2Wjg5amhr?=
 =?utf-8?B?NTdKUVNRaFc2c0tld0dkdHlST2tCaGdZTm1ZaVkwUnhOeFZ6ZThkNldGZU9C?=
 =?utf-8?B?Q0s0QW5JTDZZVHlsdEhRWEswVHNMemh2VnRvcUN2ZHZUWEZhNXRCRitIaEVG?=
 =?utf-8?B?bkdxQy84Mm5yT3REQmdzQWhrN2Q4ZVU2bzg0bUFtc3Z0aFVrSDhSMEhiYnVv?=
 =?utf-8?B?cG9uWVcyYnRNeDhjNkNZV3FRc2kybWFEcWRZNjVoQUxkRGFMTTI0YzQ5YmZC?=
 =?utf-8?B?OGlhUHQyK3RSZ0Z0M3hacFpZdnlUczZoODZiaWlwaG9rd1JmNkdnbDdnbXpC?=
 =?utf-8?B?empqM3dkdWNuMFN3M0NwL2FCVzRveUh2S1pBWFhVWFdFTmYvWDcwUjdwUUFz?=
 =?utf-8?B?eEFieitZajRlRkluMzV2RUliaHR2cHJEbUM2K0pCU05NMHZ1c3JLUGM3L1kr?=
 =?utf-8?B?L21OaWEvdUJtMkZzcGlRMmQySWc5c1p1dS9CNU5YczREazVhODR2blAwUlo5?=
 =?utf-8?B?THcybmFnLzZBN1pEa1ZwZlFBY3k2Q29XVWN4LzIzemFLL0hzZFhsUkxRM21j?=
 =?utf-8?B?SnFjMk5Ra2pBTGNBQi94dTlBMTBPaEpDNHloazY4ZzMrZ0xBbTVtTXozbkFY?=
 =?utf-8?B?RUdLMnQ1QzM2aXhTVkNPZERKeDFKcFVLcVVDSkxvdzJGSGt0TFROYVcvOVB4?=
 =?utf-8?B?Q3FweE40NXBlcTJENjMxb2lvT1lsSFkyYXpEYUlOejZ1NDZuU1FCVEFUYUZv?=
 =?utf-8?B?a0NEdnBMTXJWcURFRFJMTHlMUytKZTR0dHI3Zko4UWxMSlQyczcvendITnB6?=
 =?utf-8?B?TWR2YkN0d2FZZUJ3UE80MXNLN2UzMkRyTnY1aWxXdFVzOFBtSjdHSnNkV2NX?=
 =?utf-8?B?a2dFUDRtcTZoL0gydktTRkQyS3FwR0h6OFlNTFpNMUgrVWxBaWJSTy9NUG1P?=
 =?utf-8?B?MElZTlJQUVNEVlhhRkVaMXBYbUFGTjRHYW9hMlFtenl4UnZ5ZFNXK2FrYTRF?=
 =?utf-8?B?ZVRycUxTWU4wWVBRSTY4NkVuYjJQV3IzUmo4Vnd5UWFQc3pIREJOSzZlVWUy?=
 =?utf-8?B?bGxNcXphWU1NUTRWdmJncEFOTFlDQWxyRU4xdldpcWJsR2xkOWZHSXl6dGI3?=
 =?utf-8?B?dzRvMytWZTF2T2NnUXd0UnMzRnErcm9GTDl4eFBOcVlnYkQza0JTeGZJMnZu?=
 =?utf-8?Q?MEna03slBK/OPa8h2rb1blqID?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3594f222-4f3d-4ad8-c1d3-08daaa86ba55
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 06:14:45.8618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iV10erj7eQqniy8ZAe2bZ3eR9GzPSfKDnosBHkXBLvsD3/wwpcAjr3cCN14XiBLeOpxLJpQJ6x8YK4RPyVaoPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7205
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/4/2022 9:34 AM, Vidya Sagar wrote:
> 
> 
> On 10/3/2022 11:51 PM, Pali Rohár wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Monday 03 October 2022 13:09:49 Bjorn Helgaas wrote:
>>> On Sat, Oct 01, 2022 at 05:50:07PM -0600, Jonathan Derrick wrote:
>>>> On 10/1/2022 10:20 AM, Pali Rohár wrote:
>>>> ...
>>>
>>>>> Would not it better to rather synthesise PCIe Slot Capabilities 
>>>>> support
>>>>> in your PCIe Root Port device (e.g. via pci-bridge-emul.c) and then 
>>>>> let
>>>>> existing PCI hotplug code to take care for hotplugging? Because it
>>>>> already implements all required stuff for re-scanning, registering and
>>>>> unregistering PCIe devices for Root Ports with Slot Capabilities. 
>>>>> And I
>>>>> think that there is no need to have just another (GPIO based)
>>>>> implementation of PCI hotplug.
>>>>
>>>> I did that a few years ago (rejected), but can attest to the 
>>>> robustness of
>>>> the pcie hotplug code on non-hotplug slots.
>>>> https://lwn.net/Articles/811988/
>>>
>>> I think the thread is here:
>>> https://lore.kernel.org/linux-pci/1581120007-5280-1-git-send-email-jonathan.derrick@intel.com/ 
>>>
>>> and I'm sorry that my response came across as "rejected".  I intended
>>> it as "this is good ideas and good work and we should keep going".
>>>
>>> Bjorn
>>
>> Nice! So we have consensus that this is a good idea. Anyway, if you need
>> help with designing something here, please let me know as I have good
>> understanding of all (just two) consumers of pci-bridge-emul.c driver.
>>
> 
> Thanks all for your comments.
> 
> I would like to hear from Bjorn / Lorenzo if the design of the current 
> patch series is fine at a high level or I should explore emulating the 
> root port's configuration space to fake slot config/control registers 
> (which in turn depend on the hotplug GPIO interrupt & state to update 
> Presence Detect related bits in Slot status register) and use the PCIe 
> native Hot-plug framework itself to carry out with enabling the Hot-plug 
> functionality?

Bjorn / Lorenzo,
Could you please take time to comment on the discussion happened here 
and the right approach to be followed?

Thanks,
Vidya Sagar

> 
> Thanks,
> Vidya Sagar
> 
> 
