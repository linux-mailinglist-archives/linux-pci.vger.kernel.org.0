Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79D75F2F8C
	for <lists+linux-pci@lfdr.de>; Mon,  3 Oct 2022 13:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiJCLZj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Oct 2022 07:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJCLZh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Oct 2022 07:25:37 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73147286E1;
        Mon,  3 Oct 2022 04:25:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTSfAWEqjqpHIKYm2TcJ4+O7/8zp90jgTzVPYdM55oOEBIm8qQu52RW8+To/a5Ri6y31g0m2cLrf31YVtgBjlvl8pDgJNQ1rKZ1LTcXBPs1LjkkvpGlxoRlkEflGW/ISX/V+cI1s7suUvVnMpC2muGifAfORF9QbHhUZhNf48wfRjAZvlFaXObWQs8HuVhVPBDpP7Gu1Hjxz7CbEJtq3+rx4PYjBtumagupjz/aVEMzzxUbavYKpz8rJ0aonLhlxl97u7Aqj4msmDCMF8t1VnOhmu67CHDWhIWEd/jewN81x3No4B0t+pH9K6TKlP4FOoyoHqMYu1KF1Cph/PAMYUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKwqfQPf5XjAo4utaXZi+KLFV+03c8DI9kOBMu9Puxo=;
 b=nMXY8df9c3nnARTKK+PmYQGFIqihMO/Qw8CrioQKQ04W6EmZxZfkVZvmeW+Rx4DldUOAINpwrlqxGquN+Sjd5BHQjZ8Ma4PfRNFHdBjf5IjJLnIKQBKZAdIY++IUV/AQooZDulQ4rsd0VV13Mvq+kYu0pnDWqVhQzpySOeMhXdjaiQU3cqdJwaR059HcngfmR00cuTPYZFF8PqYLWAelGvESgeqnlTuoo3iBMJWQmYXizdkGzqK4nMZlZQVJlr6oKFKR6TSBy+XF7jlK/0Jxvph1uiK2kSAUnfR/qu4Wx9/pLj/zWdOCdSIVPaD7Gfv07AE8+UU9l45Mn5WVbE8SpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKwqfQPf5XjAo4utaXZi+KLFV+03c8DI9kOBMu9Puxo=;
 b=ZX+iwsK5WCXlptDZtz0gVmPsCTiWk9FuDBCTZ6WoBfmU2wkhKsf6hr+JrRG6XbCj1Y7HxQ2hadh9fEzZQ/ucVeOIVkd+JPqowIpIieDBfXqiVyzlumIpOjrKmKPMnCQ4n4FBWah2w+EkOrI4Yx3bnLlwB0ywUBo1dNVPs0/dzVzeuEsb5SpemCzrEHxM/dvRCXc5qdHAHZ9EgJyrke+buipqZXf7vMD0WJck/GmuwG3QyfmuwNZb+leKzjgjleVYSaucs6xaDV1ki/YyQ543gbk7uhfrOZYobWC87lcutxyRNwrmJp48XZOX+FsiWo5MC1RZsI7LvpC9ibEp/y2qpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by SJ0PR12MB5421.namprd12.prod.outlook.com (2603:10b6:a03:3bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 11:25:31 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3%7]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 11:25:31 +0000
Message-ID: <27e8f2e8-8b97-a142-9da4-437c8dd498c4@nvidia.com>
Date:   Mon, 3 Oct 2022 16:55:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Content-Language: en-US
From:   Vidya Sagar <vidyas@nvidia.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <treding@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        sagar.tv@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
References: <b1c243b0-2e6e-3254-eff0-a5276020a320@nvidia.com>
 <20220913200746.GA619956@bhelgaas> <20220914062411.GD16459@workstation>
 <CAL_JsqLbr4O_BHb8s-Px4S0OOY23qhFkN32cKBctc_BFakSBzA@mail.gmail.com>
 <20220915145241.GE4550@workstation>
 <75b9bbc0-0e99-3201-f83d-f1fe28c54b12@nvidia.com>
In-Reply-To: <75b9bbc0-0e99-3201-f83d-f1fe28c54b12@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::24) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|SJ0PR12MB5421:EE_
X-MS-Office365-Filtering-Correlation-Id: 19106d24-7360-41a0-11da-08daa531fab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ES+Le3UpXlW74BSWngMNgLU1NW/eB+HE3T1SpueFQ5votOWyY7AmDeOP3yTu6fYzizfQvsBT/w4Q8Fyybn9a0AxuS4hb+mjBdTmFWO70BnoUTVga0EJAgSsMhhuSPlP3YsFIvKoo4G5tYmPfgEeCU87daqsC62bd5GhsN2tx4k/cT7j3xpGC+//V28Ut5WFZvNgDDxZRPQIOB1J9pwpNApii1gVVhEWQdRKVtGZPlacAtPWFWMYwEszQaqBWxdlCzHEhFCbK4Iead6yHrDNtVeG8abwXPnb11Zf9P2gQZMtZPRsdD5E/QsArfUO9osmbjf/5w0wvWw4mQ40tkx6a0T98NR84aUyqYbP7qlbL+ASsm1H24WAVt8lMJghTrJb3F/Ndg4Zu1hFl+d0olyFnEqDT3uffE5bpC+3+LEcRsJF3tNl0yD8RL3HzRBPzyjHWZd/SaLNYQImMSLC5yxK/P5i1SqnXGl6URaKuPud1xPp7DYHVGJTWU3hdVTjb5rKUUzq+Y/tAbqgydKK/ehSRt9RAD+30Afst2yTIkAuijaWrNM5aDyHmk97EdJKcJC9qye7uf+R7UtL4+RmJQoVn3nwhuiLSFsHghYyGmastmnn3wPf1Xr2diJathSaXIWallzpUTl/1LLsHQcfkspCdlJLZDMYLhpGiKFG1gNXi9A8lVkDNGbXpFVOh5gatwZkDkd3f2JdO345k3pnXzax2NwQnxW52ElkcYIPnnqJgIf7qjmMMklVaPG3j5s/v9WoHzomqYntt97cuajeYa61llKs306fZWWzfY0bRfMjdrE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(86362001)(31696002)(36756003)(8676002)(66476007)(66946007)(66556008)(4326008)(54906003)(316002)(2906002)(38100700002)(7416002)(83380400001)(5660300002)(8936002)(41300700001)(110136005)(186003)(2616005)(53546011)(6486002)(6512007)(478600001)(26005)(6506007)(6666004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2dCYy91TGRGVTQyVVhkNVBKdjBCRE5Sa0NtMjNvWm1Pa2dIUkxHMGxoVTRO?=
 =?utf-8?B?eFo3Ym42MWJwdnNsZERzSjR5bGpvRjEvdzBZYWQxZmpIbzgzZ0cwV1hLZlBq?=
 =?utf-8?B?MG5FR0w0SVlkanBZSHIrUWV2dkxYQkljWkg5N0JjUEZ2Nllibm9mblo5UzNj?=
 =?utf-8?B?T01Dd0dWekdqbkZxeERJTTBiOHp2NkdBNERWRzUrTDNFa2lkdGpnTXpOSEI4?=
 =?utf-8?B?T3cyTmJVZWFTVUFWRmFwRHF4bGZpd3BIbGJLZTlKZVNmSVkvVFNSY01xcGVu?=
 =?utf-8?B?a3ViTSticDE4d296K0gxSmdtNkpHSzJ6WWdLbCtwcmd3MDZONVZ3SzBEREJK?=
 =?utf-8?B?WkN4SjFqMjNXM2FXU3g1cnllaUxtZXBOckMrOGZoandxeE1OY3Y3ZzF0VEhk?=
 =?utf-8?B?dmhET3Y2akJnbVhrMDh1SVhXanpGbjd2czRNem1FclNQN0V0RnI4S2pBME5n?=
 =?utf-8?B?UUN6L0R5VzJaQ2tqNVBkUmZhNGY5R0V5QWxueVd1R2k4TUtrMUp0Mm04R3NJ?=
 =?utf-8?B?d3hCTTA4T1pTeTNYb2FyL0VnTTFsS3ptODlRaGMyMVpCRWUzVXlmcC9ianhz?=
 =?utf-8?B?cWNHTmkyWFlKN2NUZXJOazNSdkR2UkxkOSt5QXVLd0xLcGdzV05GU090cWhF?=
 =?utf-8?B?Q2w4UnE2Z2huSXk0K0Rpdm1sU2F1UlE1N2R1WFZBTHpCM3p4SExldmJoVnI2?=
 =?utf-8?B?NGZlMG1JdWR4R2FIYjhOb0NCOHl3cTlSd3ltSDc1emlGUmhnNkY5dWx2RHIx?=
 =?utf-8?B?VDR3dmRrdDlOOGxPdTdXckJEelhvcDBvK1Z3SFJ5SVRVQVVGTHpPczdUVjM3?=
 =?utf-8?B?aWc1WER3SmVSL1BnMldNcHd0ZVpsdGV2a0ZzVDZyWjdObUJQdURPRnk2bkow?=
 =?utf-8?B?NjZMRGlXdVhZd09SVVBUZTJBbjlsTEgwNi9KMU9mTnV2bWx1UXZZaWgzN3Rz?=
 =?utf-8?B?cThzaWR0SWUvNVdyWmpEZDZibDJKdThXRkVPUEZCZ3oxUE1MVWgxQ1kvNFV1?=
 =?utf-8?B?bGFtcDI3dURCUWRaM01oQ0xwdHQwZFg5bkdjREY0N3lNeWxrdU83c3lPdU43?=
 =?utf-8?B?dUhGRzJ1UDJqTk8rZDdqMUhHRTVaL0t1dldyd1NLL2Z4alk3VW1CUWphbmJV?=
 =?utf-8?B?OGEwdXJ5NzFqMDRKRmpIQS9jVjY1U1NDNGZrNTVqVzhtdWJJRFZnT2liNDdz?=
 =?utf-8?B?d0xOa0dFM0dyZkFzbzZRMHdLdGZWVlJOOVd5V290Tjh6VlVZZE1sbnUrQk9q?=
 =?utf-8?B?bzJOMlZiVXBPSnhhZlV0N1JJbFZQVHRkZnljT3NRUWJta05GeXJpKy90Zmwv?=
 =?utf-8?B?aWJQUkQzczhZV2Jqdnl2ZVgyS29iQXZWbUhYOWV4cDNkZC9GMzF2UkZaV2Zz?=
 =?utf-8?B?M3dmZnBqd2czZ2ZGNEttYlJwSHc1Wlh1T0czQWhmZFd6UUxkdXJDekEwQUNy?=
 =?utf-8?B?bnVXbjYrVTJEQ2F0N2JGVHp4blBiL1VYdHRVNkZwNThuOExvM2JVb0ZNV0FD?=
 =?utf-8?B?eS9JU05MWnJLMzlTVDhVUEtad2NacmROd3dWZkIya2Y0MGRmS05Pdjg5S09z?=
 =?utf-8?B?eXEyb3Y0d3RIYVZvMDRTMk5wNThYRDRqcXBKNThSeDJvTkJvSTZ1N3h5c3pt?=
 =?utf-8?B?Yk5CZ0QrWnJLSVYyR3AzRDZhQzYySHpEVjR5L1dtcHJjY1hGaTdienpzL2w4?=
 =?utf-8?B?VVdiVSs2YXNCZnBpekxxWE9sVnRGTWdYODZJT3N1emp5bnhnQ1paYnVQRHlU?=
 =?utf-8?B?VHRtUmdVNG1GZTFtaGJaYzFPd1VkRWNyalZVMVFWRHBRYWJ0VTFsbUNSR0pL?=
 =?utf-8?B?R0sxVGhNM1UrVzRKTy9xNmVJL2FMbkZiSER0YzFJcmNCZ2xKeDBOVzVJbk8v?=
 =?utf-8?B?enJNdlJVN0hzWVYxWFgwcDZuSFhXVFRPd2hRZnNhcDQ0WVAxaWlQVXFBWmpV?=
 =?utf-8?B?U1JETWxkeFVvYnpNa3Q4UGhZNUcvSFg2UUFmckJnT1VYbjB3Mk85ak41dXpp?=
 =?utf-8?B?M05sSkNGVFp0M1lYV3BJRnVYd2RQaTcxdk5EWkRRN3E3eVBpQjNrK1NGaGly?=
 =?utf-8?B?ckl3NmNGWGVRalkxMDBrY0l6K0pocjNSbEFLZGd5NE9TSzVTeEhPV0Y1ZHNC?=
 =?utf-8?Q?sSb+4Gk0hwBV8BrMJ6dtszmFe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19106d24-7360-41a0-11da-08daa531fab4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 11:25:30.9431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ORfC56lf/xOXbVYfYCMkkvhHOxpHMUTZ54uteMYPkqAd11mRjb/O0Tp8h9frqVSqXcqnFLfArrw6U2Q4MsFuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5421
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn / Lorenzo,
Just checking if there are any more comments for this patch? If not, are 
we good to take it?

Thanks,
Vidya Sagar

On 9/26/2022 3:59 PM, Vidya Sagar wrote:
> Hi,
> Just checking if we are good with this patch or does it need any further 
> modifications?
> 
> Thanks,
> Vidya Sagar
> 
> On 9/15/2022 8:22 PM, Manivannan Sadhasivam wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Thu, Sep 15, 2022 at 09:16:27AM -0500, Rob Herring wrote:
>>> On Wed, Sep 14, 2022 at 1:24 AM Manivannan Sadhasivam
>>> <manivannan.sadhasivam@linaro.org> wrote:
>>>>
>>>> On Tue, Sep 13, 2022 at 03:07:46PM -0500, Bjorn Helgaas wrote:
>>>>> On Tue, Sep 13, 2022 at 06:00:30PM +0100, Jon Hunter wrote:
>>>>>> On 13/09/2022 17:51, Manivannan Sadhasivam wrote:
>>>>>>> On Tue, Sep 13, 2022 at 03:42:37PM +0530, Vidya Sagar wrote:
>>>>>>>> Some of the platforms (like Tegra194 and Tegra234) have open 
>>>>>>>> slots and
>>>>>>>> not having an endpoint connected to the slot is not an error.
>>>>>>>> So, changing the macro from dev_err to dev_info to log the event.
>>>>>>>
>>>>>>> But the link up not happening is an actual error and -ETIMEDOUT 
>>>>>>> is being
>>>>>>> returned. So I don't think the log severity should be changed.
>>>>>>
>>>>>> Yes it is an error in the sense it is a timeout, but reporting an 
>>>>>> error
>>>>>> because nothing is attached to a PCI slot seems a bit noisy. 
>>>>>> Please note
>>>>>> that a similar change was made by the following commit and it also 
>>>>>> seems
>>>>>> appropriate here ...
>>>>>>
>>>>>> commit 4b16a8227907118e011fb396022da671a52b2272
>>>>>> Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>>>>> Date:   Tue Jun 18 23:32:06 2019 +0530
>>>>>>
>>>>>>      PCI: tegra: Change link retry log level to debug
>>>>>>
>>>>>>
>>>>>> BTW, we check for error messages in the dmesg output and this is a 
>>>>>> new error
>>>>>> seen as of Linux v6.0 and so this was flagged in a test. We can 
>>>>>> ignore the
>>>>>> error, but in this case it seem more appropriate to make this a 
>>>>>> info or
>>>>>> debug level print.
>>>>>
>>>>> Can you tell whether there's a device present, e.g., via Slot Status
>>>>> Presence Detect?  If there's nothing in the slot, I don't know why we
>>>>> would print anything at all.  If a card is present but there's no
>>>>> link, that's probably worthy of dev_info() or even dev_err().
>>>>>
>>>>
>>>> I don't think all form factors allow for the PRSNT pin to be wired up,
>>>> so we cannot know if the device is actually present in the slot or 
>>>> not all
>>>> the time. Maybe we should do if the form factor supports it?
>>>>
>>>>> I guess if you can tell the slot is empty, there's no point in even
>>>>> trying to start the link, so you could avoid both the message and the
>>>>> timeout by not even calling dw_pcie_wait_for_link().
>>>>
>>>> Right. There is an overhead of waiting for ~1ms during boot.
>>>
>>> Async probe should mitigate that, right? Saravana is working toward
>>> making that the default instead of opt in, but you could opt in now.
>>>
>>
>> No. The delay is due to the DWC core waiting for link up that depends on
>> the PCIe device to be present on the slot. The driver probe order
>> doesn't apply here.
>>
>> Thanks,
>> Mani
>>
>>> Rob
