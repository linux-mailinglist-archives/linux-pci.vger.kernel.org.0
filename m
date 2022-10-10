Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F945F980A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Oct 2022 08:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiJJGCc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Oct 2022 02:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiJJGCa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Oct 2022 02:02:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06922613A;
        Sun,  9 Oct 2022 23:02:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LG0C8zOv0hFwcy+4+iRy7ghCX0nNNXDxB48cdNL9RNLZKHZAnTHp9/dnmPRGJKpYdjLbS/F/CXjgZhDhhjGl4KHoX7WlJ+5ByqVt5CJrB4Jw+/mlznpzOgHE7O+YxNqR2KIKK8zwyVgivhx5yVsBWCus2ouoAuxCTnglmHyCZaifw5eyUJa6nB9A9zgjJ6SoYGdHKRUOUAygmq1aumLG7G1Cnc47sfzHJhdNQQ6cxa5pNa+7/wRocEL2DycGV9Yr/luAaUaFKmAabKziLgAJI+Pe8BspPg1ZwbrmbHw+8ukqMtlrZOBjYEB1qE6JQKx2Iu6Q09ePfmQCnxN53yMcHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q656zymrsoO0PwHK5P4mUxaZXwXizIamEaO6FZpyjVU=;
 b=cOzmGaJUgTMu3IVf71txadNT7uC2cOsl4Aa/f+9yAM5vWfi5aa87BthGYP6kkQkU/3DlbikyMlJnf+JM8/rddiLhevSObqi6FFJQvRyb1pJ7kPnl/pNekKYZq3i/oAD88L33Z7xpxgHtt1V1oLIA/qjxaacQ3mO1jLc+HrlLGC5iC3/ccYNMoQF1BsZE+cVVlTCLiHWzifsDjIvM/G7nCBEd3zpQYrT3SbmcsZ1dXWE5gFT4tflF1m5mDvpXROlsBvkyOtAWlPhM85z35XmHgnedH6Zh5X8ZQUgsnMDpI31R/jTGmzTXZ8cuBW/I8p8y28iUxurD5Vseq8guxCLpIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q656zymrsoO0PwHK5P4mUxaZXwXizIamEaO6FZpyjVU=;
 b=DrpUdpsvujGfDuLHnaZYFdhLYWZ9GP8t0CrVROMzALPTrRhRQZUIbhN5SZDfANPqe6OWa2/UvgJJ55uqdM881iBzHyGBQuyBZQKnq9NHui05K1R71clKI0RWRJ0BrwGGxEEicYQ4xNRMFi089BLe2M/cWURogcLIGzMgUWjNkV6Li4zxRReReCuKlzN6+nB0SZrOJ/8MSAQcTCJdNFz6WGWa7fqut2YSmH4aH9sqONV5H1eZspRIz77xKd8y+cSfaqmQQx2lY0t3ipB0ZbMqnPHmIoq6ivqaVZqrvB5+OMGgcZqgTfhJTLANPIF4ffsHau3NDGwcWSMp3oVttBudOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 06:02:27 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3%7]) with mapi id 15.20.5676.031; Mon, 10 Oct 2022
 06:02:27 +0000
Message-ID: <96dd0b76-00b6-4f18-640a-7540fab13ea7@nvidia.com>
Date:   Mon, 10 Oct 2022 11:32:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <treding@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        sagar.tv@gmail.com
References: <b1c243b0-2e6e-3254-eff0-a5276020a320@nvidia.com>
 <20220913200746.GA619956@bhelgaas> <20220914062411.GD16459@workstation>
 <CAL_JsqLbr4O_BHb8s-Px4S0OOY23qhFkN32cKBctc_BFakSBzA@mail.gmail.com>
 <20220915145241.GE4550@workstation>
 <CAL_JsqJ-qrveNrF2n4jY3yXw4eXqa1Q0-ffX3yssJYmC_xZgRQ@mail.gmail.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <CAL_JsqJ-qrveNrF2n4jY3yXw4eXqa1Q0-ffX3yssJYmC_xZgRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::16) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: 033b8a40-924e-4685-2581-08daaa850218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Jb9H/xMV/LQ992+lzVbd0Qijn5wG3ZVJVoDoQDNjIThLANb/F6HE2UdnK5WAUdit+zu9faO49/iAdZQM/eDouag0pk59VoAfsgX3hMJG55N7vZAqlcBjKRRxpn6UiN4gb6I4P4rvaeYn5s3trlRdxaI+AaddzxYXWAHjMXZFPrNUghmgVzDtK9vcoq3iRet6yLwnMFNTPDe8FSV0Fd+E2Ixm0Zg2x0tPqOFJyfVXkM+Tfu3z70pgAO9ZsqHvNn8DTZW5sezk+4rUw0UBB1Is1DxXHGzI2eb0aXlHvjsH1twoFCGW4Apjyvu11Xmc9B6Kcoj/6jzKOSbpfP6D6LGDdzvaG9QzGBapQ3NU2c3/sANOnOHeqdhkCUGbbccXMFF4fhlFD92MsvmIc9WwgKHoIXW6UQdU9fPYHVpopBkSYvPT5onwiQNa5l/ubu8KpjVK7MdURJubIJTbzSftk4ZiL5p4pefh7MHfdwoUmyyHsJGS29OOL0/P94cDlGfeqvV2BvnS7kQL5Pat4kUWJKUsWsTvUiD16EamZKMnm3Z0vOap+mNoh8L4f6c3mn7D2QpEJMsIkNZpt07Yk6MXFovCQz+3Bs1JIw3H8mAIvBkLZNRecG28CJajS2/9yynzQTttA224C/AiShoOzdYFp0YE8qr14lAW6adhtCSTw3z4MWhv8TtFzjnwPWLCREz8UhNb1P++j+dgWF8p+AlHe/lNYOozc0Fs274rCZMNjjnumnNk+cNjSFhIPf2rHBSlPBeCMwwN99SiTdwbY+wnDFw0asNyFS478r3yfqa6DFaOhM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199015)(83380400001)(6512007)(186003)(31686004)(2616005)(26005)(7416002)(66476007)(2906002)(31696002)(86362001)(5660300002)(4326008)(53546011)(8676002)(66946007)(66556008)(316002)(6506007)(38100700002)(6486002)(478600001)(6666004)(54906003)(110136005)(41300700001)(8936002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDg4eGozK0lKYy9KRU1UcVlXcVJTTy94UEpHTFovZFY2dWYwOEhoaXUzTXdS?=
 =?utf-8?B?cndJTFJCK1BXV0RQemJoVzFLdWNJZlgvNHRpN1l0UVVhNUVpZW1NNHRnbnRT?=
 =?utf-8?B?VGIxT2MvRktaaXRXSXFFdlF0ckJmZUZEQjRBZ29Ma1hOcFZBemN5OEZ0VXh3?=
 =?utf-8?B?bjdmdkUyajBtcmxTRUdYYUV1RHlVT0NTclFGQmRtZ1lacWFtdHg0Y1ZxQkQ2?=
 =?utf-8?B?MUdEYitKN2trQkxZWFR2REg3Ni9kd2Z3OVBpV1FrMUxwRVdsMVIxT3hjWHI1?=
 =?utf-8?B?ckR1ay9oUlRMOE9PRmhMTTJlNnIxZWVYVmhaOUV4a3g2RyswQUVESEtuUXR4?=
 =?utf-8?B?bEpiTnVsejRWeWNLdlJTbjcvNmdMRFAzUTJDclpFR1ViZEhqY3lSLzhSUW90?=
 =?utf-8?B?S3hNUHloVHFJeGNtamNyZW1QR2MzOUpsSUhSUzJ0dDQ2TTZGUjBPN1FFUDdJ?=
 =?utf-8?B?YSthSVY5QllpTmNUQXc0YVRSY1hoRE1TbldoOGF5b1NySitHMjBLaGsvdEh1?=
 =?utf-8?B?VU5FZEVJMm9NTnhBUm9IWDU5SkUvN0ZLWTRWa1F3OWVONnRlSktUWXlvUGVJ?=
 =?utf-8?B?SmxscjZ5MWdsRzZzVnZvQ1VnMGJpT1VCRk9PU3RXbmlucm55WEpoUnp6UTVN?=
 =?utf-8?B?c0RuRTRxS0p1Sm0rSGFCeHJRdk81UlgyMGVmL3ZaTGRuYlk4a0wvTHZZT1Bh?=
 =?utf-8?B?bFA0U2ovaExYN2hob0ZmRmV1QTI5c2NscGZKUG1pci9QMzZja0RwTFI5OEtx?=
 =?utf-8?B?UDQ2UG1HbzViRmlIQmJQcE9DbUJCcVUrTWF6cS9OOFg0SlFMNUhHRGJ6RktG?=
 =?utf-8?B?c2QvczZMUkxtY0ljdHoreDBOa2dVc2grVXU5aFRzSnhSS0wrb2tLeHJOTDhQ?=
 =?utf-8?B?U2dlQ1E3L1dudnJYYTdZYmNEa3B0MTZZNGhIWllzWDJWVkE0TCtEWWdGNks0?=
 =?utf-8?B?anJrZ2Q3Tms3OTY1Q2s3TDM0S2FPcVJsa3RBajhRc2VDYmVvTDBFMmZBNnBj?=
 =?utf-8?B?NVIzMVdURDJRbGhHeDFUbnV2WUVPNHVrZjI1ZkNkWFdUK2w2eDdFSzlkNWE2?=
 =?utf-8?B?V3lFbVBwaU9XbUJzVkd2cFI2UGRFSnRoSkFzdEhyQWRJeXFxUldIekhZNFFt?=
 =?utf-8?B?dHNzVzNnTWQzdEd0ampFWXl1eUpNcEhYYkN2ZnJ6T1laRFdVdHJyZk05MEUv?=
 =?utf-8?B?SCt4THgvRUVSajBGZDFNUElra1lKa3g5QU1lb1JCU0x1UEVZeE8vREZkYkpw?=
 =?utf-8?B?Zmo0RzFWSnBkT0diODAyNncyK1RDNlNLSk1Id0tEK3BxR0o0OHZ3UzZLdUpv?=
 =?utf-8?B?RVdiZmdMOWFXTlIrZlQ3UkFPaXArRmp6ck5IVjVKM0ZrSXVwTWVMV0FIM001?=
 =?utf-8?B?aktNWFRXdjBCOGdQTWk4WGNueHJ6dlRkUFVvVXJwZFk3MG9SY2tMWWs4Z1p5?=
 =?utf-8?B?STVyZFF4ZHE1MjVFczA5QVRkU0F1ZFA3Q2ZUcUxDZ0liNytUWnhrRjZmSWps?=
 =?utf-8?B?R3ZEMHk0c3ZNQzBwUnFlZmp6bi9jVEo5SGhCSUwxMFNrUmE3YnF6NHdIWVRI?=
 =?utf-8?B?NFhFMGYwZGJFL0U4WHkrOG5TaHJvckN2K25wRDFwNE9DWnJIQ0lOSnNwaEZv?=
 =?utf-8?B?MmhSam5PSjhTcHQ3UWhnRGw3ZHAzcElkMVkxSHp3NnJlQ0gwNCt0NWVReUpG?=
 =?utf-8?B?SWUzQktpeTFPTU1jd0ZSejhLSXlYaVlZalJzcmovSXRzVEc4SXVPTkR4bTBy?=
 =?utf-8?B?VmhZME9QVGxraW5HRXc1R3hHSWJxNEpjTzJ0S0p3NDJQaGQxVWMvU2lLaE5r?=
 =?utf-8?B?VW9vVGl0TDZzRzJKdUNrWVRhYlhTWGo3OGFCbTY5c2ppelVVV2FxMEhCRmFU?=
 =?utf-8?B?b3pJL0lSL0FlZlpQK0NIOTZTVC9TcVBsaGtLTC9tREVPdk5BRkkrV1pwaUdF?=
 =?utf-8?B?LzNXUjJEQ3NTbFlHd3NRSnBHOURVeFYyaGNvZkc3UlZubGI0RW0yRHh2eXVy?=
 =?utf-8?B?eEdOU0ZiQ0I2QUNZWDJDcU1yeFU5NFBiMWZuNjlaSkNnckowdWppa0xXNVk4?=
 =?utf-8?B?TFRqTUxJYlY0QWtJSmhCa2VPekZiem9TRmd0Nzg0MHp1MEJZTHZOVU5HdzZR?=
 =?utf-8?Q?iCeVtzurc0s0R0Gj5mKPUlMya?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033b8a40-924e-4685-2581-08daaa850218
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 06:02:27.2917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmQhD411hsd9cn6PWPXzbMaUGHkPCaQggJV1tCOi1z209YPAOW30jtsb9E2uJngsuhQJTdIl98WXfYfAUI9HnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/4/2022 6:23 PM, Rob Herring wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Sep 15, 2022 at 9:52 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
>>
>> On Thu, Sep 15, 2022 at 09:16:27AM -0500, Rob Herring wrote:
>>> On Wed, Sep 14, 2022 at 1:24 AM Manivannan Sadhasivam
>>> <manivannan.sadhasivam@linaro.org> wrote:
>>>>
>>>> On Tue, Sep 13, 2022 at 03:07:46PM -0500, Bjorn Helgaas wrote:
>>>>> On Tue, Sep 13, 2022 at 06:00:30PM +0100, Jon Hunter wrote:
>>>>>> On 13/09/2022 17:51, Manivannan Sadhasivam wrote:
>>>>>>> On Tue, Sep 13, 2022 at 03:42:37PM +0530, Vidya Sagar wrote:
>>>>>>>> Some of the platforms (like Tegra194 and Tegra234) have open slots and
>>>>>>>> not having an endpoint connected to the slot is not an error.
>>>>>>>> So, changing the macro from dev_err to dev_info to log the event.
>>>>>>>
>>>>>>> But the link up not happening is an actual error and -ETIMEDOUT is being
>>>>>>> returned. So I don't think the log severity should be changed.
>>>>>>
>>>>>> Yes it is an error in the sense it is a timeout, but reporting an error
>>>>>> because nothing is attached to a PCI slot seems a bit noisy. Please note
>>>>>> that a similar change was made by the following commit and it also seems
>>>>>> appropriate here ...
>>>>>>
>>>>>> commit 4b16a8227907118e011fb396022da671a52b2272
>>>>>> Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>>>>> Date:   Tue Jun 18 23:32:06 2019 +0530
>>>>>>
>>>>>>      PCI: tegra: Change link retry log level to debug
>>>>>>
>>>>>>
>>>>>> BTW, we check for error messages in the dmesg output and this is a new error
>>>>>> seen as of Linux v6.0 and so this was flagged in a test. We can ignore the
>>>>>> error, but in this case it seem more appropriate to make this a info or
>>>>>> debug level print.
>>>>>
>>>>> Can you tell whether there's a device present, e.g., via Slot Status
>>>>> Presence Detect?  If there's nothing in the slot, I don't know why we
>>>>> would print anything at all.  If a card is present but there's no
>>>>> link, that's probably worthy of dev_info() or even dev_err().
>>>>>
>>>>
>>>> I don't think all form factors allow for the PRSNT pin to be wired up,
>>>> so we cannot know if the device is actually present in the slot or not all
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
>> the PCIe device to be present on the slot.
> 
> Yes, I understand that already.
> 
>> The driver probe order
>> doesn't apply here.
> 
> I'm not talking about probe order, but rather async probe enabling
> parallel probing. If waiting for the link happens asynchronously, then
> other probes can happen in parallel and you won't see the delay (until
> you run out of cores or all the other probes are faster).

Are you suggesting to break the existing probe of DWC based PCIe 
platform drivers into two i.e. sync part that handles the sequence up 
until link up and the async part that starts after link is up (or after 
LIKUP_TIMEOUT if link doesn't come up).

- Vidya Sagar

> 
> Rob
> 
