Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A0B5F2F76
	for <lists+linux-pci@lfdr.de>; Mon,  3 Oct 2022 13:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJCLTD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Oct 2022 07:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJCLTA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Oct 2022 07:19:00 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B0F4456D;
        Mon,  3 Oct 2022 04:18:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ll3qtL2TLoR4Cl0rUz280saInLF7H7M1wnzuemVY7Jb2GfUKmOOPTG7SSq2BqQHDa0HDJIr0y5n/zlhTfSTaatY6HrF5zzhwSSc//eT1BzKaA/dZv9BRHXSX8V3XifoJ5H4EMII7B6sTc5tKDZKk1CvUaqoUzqQLkGFw1rokuUuk61uJTX/g+lLqGgK9zllnJLm7Io5HRg+f/NkQ9ZZbJcl3hOOmut0Nb6cHBIRwiMVAvSRHHTg/UYbQBWNiFx55RcQGSXp9nKY76vD/tBxBqejxiHOkEE49jbDF68u3bnl7TXMEHgbuAdcIAEHWurZgQTsq4lAuE074wCv8C7WI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaFLJ2Nf4RLTw3oDPtXpNVrmUD/hjKznU/RfBQ77WF0=;
 b=bEVLCvNmo9A0kxPV3ziHyuOKedRe/Z54KeROlFt0JSFuiQjUUOCmtvJun8P6Q6GC/mPPXbXHKC06RWzsRL6yLlnY93mGrctb4SvK8WrrmBZIwRuVjFl4DDlVhg8enFRcB/u7I+d5LJbywvIMUO04qm6bZm7p/kxYSG6J5UF2tTMoB7htN8XV/ovCNptmSHuxCvPiZ3jADmGkIwmeWgLNchB21vWgH31h5/0dmYX3DUL0naKwTscGBtrjhmh03FpTSn6292jgYU6LQVrK9Z7mZNQGbnPJkguvrX+NhnUUdzequdwL/MIWdiX3KNgnYaQ/OlMjxr1pflhq5XdQgbdQNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaFLJ2Nf4RLTw3oDPtXpNVrmUD/hjKznU/RfBQ77WF0=;
 b=fG00V7kEgzyCQrzh0LFcr5dJYNAoHIkFDeL4Arw9zD90GUKG5FEbQIqj4ueriueS7MCzrYogQWAA14EyzIvw4hQLsFgNQKF0Oo1/uvo5EEriHoUj4Ofuyw0gUfEkbbS6vyWzQMOYk3+HmSs3ZsCNdJz1IS3kGVux5GIpVR+wjDuNnTZ8sOEZ7jwbAjxBY2kd0apWaSKCZ4dDf7vLvdp9++JMXxXfDXu3LLydtTmKpLNIB9SDIUKV7NqNYF6VDRLyMwmX79xIBnQjJcKotMkvj+qvM+dqHqyOVSnYhHBxo3u/7iuEPykC1gjxFkgps9ltaRzwUI3oupcubS33IwaO/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 3 Oct
 2022 11:18:57 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3%7]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 11:18:56 +0000
Message-ID: <37161acb-d523-fb97-2c7a-e8d3aa842c52@nvidia.com>
Date:   Mon, 3 Oct 2022 16:48:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V4 0/3] PCI: designware-ep: Fix DBI access before core
 init
Content-Language: en-US
From:   Vidya Sagar <vidyas@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, mani@kernel.org,
        Sergey.Semin@baikalelectronics.ru, dmitry.baryshkov@linaro.org,
        linmq006@gmail.com, ffclaire1224@gmail.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20220919224014.GA1030798@bhelgaas>
 <554df533-df52-ee69-6c6f-effba88b55e1@nvidia.com>
In-Reply-To: <554df533-df52-ee69-6c6f-effba88b55e1@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::31) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|BL0PR12MB4849:EE_
X-MS-Office365-Filtering-Correlation-Id: 745624e2-b1b8-48d1-79b1-08daa5310fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7V4FvnH+f8Bhh/01RppW2KmZ+1eLL8OexL6o4AqurU0IulwZVqDxBEW3XLzauWGecBMaQPANy2/ZHPrcK5o8wHXtqHrRkRMZRB8vA6TUInqO70qZU9ib/d3SLIj2Vr0uBxrmNcLNsUfPRtH5FuQr5lz6i1uCOrBCON6/n9nAHKtZ3IeNO2Ow4KT6b5iFdKkV/LI3Jw01hDErclxwVecnGw4qYb+6ndBNDdZC1Yguv4zX+Tk1nx/Lzh2A0mQm3fu2m47PKIMbYYgvolCZZbSrkOw/acoljcHk/dhoWhXsuLw2UKH8f9jcyo09LD/FpZg/8XbACqUoJ7D4dAlJjIlF+4qVJdL3fMkuMA/ZkZUktDYU0gZ7R0XdQiOJfuFRc91JuqFNrYNTKtG3wqQwMnfb0GwxJNmVCsrYEw1XNzyCs8qb9M/SrxmqeLu+rBUnY91mZJxBA8yPJ/KLwe0Jf+hIFlxDirErD23hmHeGBxdiq8ZLAu63JbR6t1mGMYlHN/Ronhc0C7iZDvjaCH6k30o+V6ic5v91Ie2Zg2Y9/o8AV8+v8NVqrC6b2IPiJUOItGpnI0sihhuYf0/3fYp0CXMdF7YFHSA6crgW8OGdQxzpXb13eWX3CrmDscaHSDqo8P16yF9NS+llhdjVmXomnAKcUbmTm5yxIf8Mkr+u91FHqVaSOPm9WFcUgNsroiKKk62mKlqe6UPcPfQr3Vhuyl9+3B3X7Im4yGBCT5vn7dEENkIoZpjCgFx4PgTJkTiDmsZWerLBcJ7B3gX81wOA7/dvRuv13D6BN8eH22KGXKpDCtaJAd66iRIl9Z7/otI4oyyOo2pPUFo1Z4MahwJqskwljGy7m4R1n2G5IeBVZQr0Q1xT8b3jNJkpfre4WF+IL0eN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199015)(31686004)(8676002)(66476007)(66556008)(66946007)(4326008)(7416002)(86362001)(6512007)(38100700002)(41300700001)(5660300002)(6916009)(6486002)(316002)(966005)(36756003)(8936002)(478600001)(6506007)(53546011)(31696002)(6666004)(2616005)(2906002)(186003)(83380400001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2VWTGZlcHI3RGthb1ZpRWhHMy9xSWk0NisvQU91U3VjRGhBcGpPU0ZDQmgv?=
 =?utf-8?B?Y2N3Q3MrZEo4NFZhdkVrclVDTGdWdDFUcE5uVCswSDBsRzdNK0hUOTNPVUY2?=
 =?utf-8?B?OE9WMXMzS0N0Q3ZERnl5Mkp2NjFwS245cVRDU01KKzRIVEgxT2l1MnZNRldC?=
 =?utf-8?B?VkQ3TFp3OGIvNTludWFaRHhGNWN3anRPRmRCQW1EVDkwSmEreXZERGNJMnQz?=
 =?utf-8?B?RkRrMzRUb3lWYVFUN2RHeUh2cWpnQ1Q1ZDNTNi9sK1prNysxSWRaYkEvTS9l?=
 =?utf-8?B?N2hrd3huSStkaXFkVTJQOGV6LzBlN2VHYUJFZ1Z4VDJabmZ4VjRTRXBlbGlT?=
 =?utf-8?B?amwveURWdTNSYzJaV3p0Z0dhVUwwU3R5UlBmdjBFblNBUWFXOVMzcE5mSnFH?=
 =?utf-8?B?SjdaUkt0Z2d4SHBabGNtS2ZleTk4Vmw4ektUajNOL3VhV21ZRHE4c1ArdGNj?=
 =?utf-8?B?NUlYQlVWS0l6Rk52aXladTVHMzkyZmxIMW1aeGRTVENhZWthNE5vS1YvRUx2?=
 =?utf-8?B?VzMrQkhOdnpDaUVFV1FNR1R6MkRuT3FWTEpDbERLWG40QkdwbnJXRXJuQXJs?=
 =?utf-8?B?azNEajcwS0FzdTJkaDVzN0FPeDg2MXpsNm8wdUd0ak13T3FKL2tYWFltNW1S?=
 =?utf-8?B?RUxvMGZTeVMwTFhKemhCQkpQc3hLSExFOVdxVm9FbElhWUY4RS9DK2dkUTMy?=
 =?utf-8?B?K0JjT1pBZVNLZ1JkTEo2Wm5VNXpqZzlRVmpyS0JnL3Fpc0lBcllzNHB3S0U2?=
 =?utf-8?B?c0tBZkFFMUZVTmF2MnFLL09NbW5TNzRnSlRjb3NjVkE1eDNXaTRKM29HcC9j?=
 =?utf-8?B?RmRWV1l0UnozcnVFVldJZTlOWGUyK1ZpYzR6ZFhrdHdwaHMyS1p5UXY0K0py?=
 =?utf-8?B?cFd6bUhUaW52dFkxY0taRHdiN2dwNUJyclNsbnpEYUhYb3JhWVpNU3oxOEpO?=
 =?utf-8?B?ZjhBVk5BZU82RkNjb29DOEF1SzdmOC9UNXZxUjJ5WHM5ejRiZ1pNU1B3dktT?=
 =?utf-8?B?azlIM3FKYjBzTUtKTTBodUxsa0dQSTh2bGltV1IyQ0NoM29qSVNpakJkUlpE?=
 =?utf-8?B?MHpSNmNBNFRybGh2SmloM3RCbGRiNlgrSGFwYlAwbGR2ZVFzSWh2NnQ5UlQy?=
 =?utf-8?B?R2szc2FmS1RvNVJHOGNQOXlzQWF1WGJZWFFuNnJhQWxGWE55eE9JeUNlNk95?=
 =?utf-8?B?MmRDWVo2VlNCcHNrMUxZWEdsYWd3dExqMWRXc00wOUNYSitzWUsyQzRicm1a?=
 =?utf-8?B?QzhscG5vcFN6ZTRlUzhwWW45eHhHNmMrMmFkakRtb0c1a3lmN29HaGRRdmRK?=
 =?utf-8?B?NzVLU1FTdVRtR1hJTHdpYllmTkxURkIwdk5LSEZzV1pIQmEwTnlMRmx5a2N4?=
 =?utf-8?B?bVVSUitneDJVUDVxL3grRzlCZ1Fzc041aks0bFBiWWVaNnZGWUxBU0QwQWUr?=
 =?utf-8?B?Y05pSk1MRTI4VWRFTnpsT3dFRktkblhUREh0em92Y0xFbFRCUGs0NjZ5dE1R?=
 =?utf-8?B?WWJ4Q1cyM3pTd0s4L0NTTnJCTkxUY0Nmdmw5bXZEbjlBRStGVDROanAyZlFt?=
 =?utf-8?B?ZWJ0cGViRHlCK0doOEJvbHFBa0U0bTJ2RnZBdXdaa29uTmpRT3p5cEVka1Nt?=
 =?utf-8?B?cjh4WC84T1VaSDJJMUVwL3l0OWczeFQ3cVZ5ZFpJZGJYa2tFWjZNWXJERWZQ?=
 =?utf-8?B?WHlibm5lcE85NklUcVBIS0VTamlKVTRWZGtIUExyMDNwWU15Ym5HMGErSHlS?=
 =?utf-8?B?bUZNVWFIYmNnc05UV3BLeGdNY3B2RzNoaFZ1ZnEvcUN3K1dud09FVW5oMG12?=
 =?utf-8?B?bkxQdnpiRFBFL0ZMNk5BQ2J5ZE9vblhUYm1vb1k2UXY2MXBOZEVNSUhnK3l0?=
 =?utf-8?B?a2tIc1QrUGVCNW04d2RXYWMzMGdBeEMxZGNuek85MkxlYVF2ODVyb1lKdFlK?=
 =?utf-8?B?elluUWVmUS9YWDRyNlUzV1BqT3RQUmN3Q1R1dWxEczZaNUNmcllHazFiOW5J?=
 =?utf-8?B?QVJud3hRN1kxZEt6bG9mWCtWZHZmZlluOEVBeGZSU2F4NFRjZU5UMmVkWWk2?=
 =?utf-8?B?NVdyZDZ6K0hiZWVnUHRoMyt6YzVnUWovNWFLem50UCswa2tWMEk2VGtsMGFM?=
 =?utf-8?Q?tk0uSU1p8ZNvbvjtLw6EZ2EVG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745624e2-b1b8-48d1-79b1-08daa5310fd8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 11:18:56.8859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ikhpr5kYGTdlJDx6NT3vrU47cfP/aw5ZjME7oj7yeuvGOdGrBLZnSEiyU5d+YEX69/ibvPGU2FzsyKuZgEe8Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4849
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,
Did you find time to take a look at my responses?
If you don't have anything to add further, I'll take care of the review 
comments as mentioned and send the V5 patch for review.
Please let me know.

Thanks,
Vidya Sagar

On 9/26/2022 8:32 PM, Vidya Sagar wrote:
> 
> 
> On 9/20/2022 4:10 AM, Bjorn Helgaas wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Tue, Sep 20, 2022 at 12:03:39AM +0530, Vidya Sagar wrote:
>>> This series attempts to fix the issue with core register (Ex:- DBI) 
>>> accesses
>>> causing system hang issues in platforms where there is a dependency 
>>> on the
>>> availability of PCIe Reference clock from the host for their core
>>> initialization.
>>> This series is verified on Tegra194 & Tegra234 platforms.
>>
>> I think this design is just kind of weird, specifically, the fact that
>> setting .core_init_notifier makes dw_pcie_ep_init() bail out early.
>> The usual pattern is more like "if the specific driver sets this
>> function pointer, the generic code calls it."
> 
> Thanks for the review Bjorn.
> 
> Typically the PCIe endpoints run using the reference clock from the 
> hosts that they are connected to. Our hardware designers followed the 
> same approach here as well, but the main difference here being that the 
> controllers operating in the endpoint mode are not standalone 
> controllers but part of a bigger Tegra (/Qcom) systems.
> So, the complete controller initialization sequence just can't happen 
> during the boot stage itself, hence the boot initialization sequence 
> needs to be split into two parts viz a) early initialization - that just 
> parses DT, does the programming that doesn't depend on the reference 
> clock from host and b) does the programming that can only be performed 
> after reference clock is available from the host
> We are working with our hardware designers to avoid this dependency on 
> the reference clock from the host so that all the programming can happen 
> during boot itself and hardware is smart enough to switch to using the 
> reference clock from the host when it is available. But, this is for 
> future designs and Tegra194 & Tegra234 continue to have this limitation.
> 
>>
>> The name "dw_pcie_ep_init_complete()" is not as helpful as it could
>> be: it tells us something about what has happened before this point,
>> but it doesn't tell us anything about what dw_pcie_ep_init_complete()
>> *does*.
> 
> To be inline with new ops ep_init_late that I added in this series, 
> would it be fine to name this as dw_pcie_ep_init_late()?
> 
>>
>> Same thing with dw_pcie_ep_init_notify() -- it doesn't tell us
>> anything about what the function *does*.
> 
> Would it make more sense to rename it as dw_pcie_ep_linkup_notify()?
> 
>    I see that it calls
>> pci_epc_init_notify(), which calls a notifier call chain (currently
>> always empty except for a test case).  I think pci_epc_linkup() is a
>> better name because it says something about what's happening: the link
>> is now up and we're telling somebody about it.  "pci_epc_init_notify()"
>> doesn't convey that.  "pci_epc_core_initialized()" might.
> 
> Ok. I'll rename it to pci_epc_core_initialized().
> 
>>
>> It looks like both qcom and tegra wait for an interrupt before calling
>> dw_pcie_ep_init_notify(), but I'm a little concerned because I can't
>> figure out what specifically they do to start the process that
>> ultimately generates the interrupt.
> 
> As part of 'start'ing the endpoint as mentioned in 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/PCI/endpoint/pci-test-howto.rst#n101 
> 
> we execute the following
> echo 1 > controllers/141a0000.pcie-ep/start
> that enables the interrupt generation for toggles on the PERST# line.
> 
>    Presumably they request the IRQ
>> *before* starting the process, but there's not much between the
>> devm_request_threaded_irq() and the interrupt handler, which makes me
>> wonder if both are racy.
> 
> I don't think there is any race between these two as the 'start' is 
> initiated from the user space. Not sure if I'm missing something here 
> though.
> 
>>
>>> Manivannan, could you please verify on qcom platforms?
>>>
>>> V4:
>>> * Addressed review comments from Bjorn and Manivannan
>>> * Added .ep_init_late() ops
>>> * Added patches to refactor code in qcom and tegra platforms
>>>
>>> Vidya Sagar (3):
>>>    PCI: designware-ep: Fix DBI access before core init
>>>    PCI: qcom-ep: Refactor EP initialization completion
>>>    PCI: tegra194: Refactor EP initialization completion
>>>
>>>   .../pci/controller/dwc/pcie-designware-ep.c   | 112 ++++++++++--------
>>>   drivers/pci/controller/dwc/pcie-designware.h  |  10 +-
>>>   drivers/pci/controller/dwc/pcie-qcom-ep.c     |  27 +++--
>>>   drivers/pci/controller/dwc/pcie-tegra194.c    |   4 +-
>>>   4 files changed, 85 insertions(+), 68 deletions(-)
>>>
>>> -- 
>>> 2.17.1
>>>
