Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B8F5EA271
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 13:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237364AbiIZLHu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 07:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237361AbiIZLGr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 07:06:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFD350519;
        Mon, 26 Sep 2022 03:34:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWDCLYYWHLIDZDpTtY8xe2SRzLqHlVDQMnPPKXNANuI7BlmKYMRTxCs54l3oBR1eGqp2DC0DOALsQtdjOK6pXBuC5NvNrheCkuBfZ4CT1xAf4YM2CoNdZp+p3jVYR+R8cNWQiABWftQQnanmDyw7FF6/U94OM8IGRn9mJFlItNPHfyiRrsv5gNyx38iaj8aYDKOvncbK7CCajNy1S6M91sCeMdx5JjuFEjad6ULdgbylMkZwWhXrzpS3mb2bYKub4aKg8xqTu7hE1dMebv0vIn4MB5qg7i5dG0Cr665116VJgxParQ8HWY6aJOVnUTGgkuvcPQE+CYSV7Y1QEMG1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaAeoEmDjL11BYfLSRlpuaDZv3BGBRIv18U02/DDW5c=;
 b=EG+Jn/HY+6pdJKVCjI8EqHvl+1DpZTNyqmhsh/jWGSnUezV8XHFsUnyJYRuXmb1dwTBTJO7dHxOI/9M6L5e5Vd4OgL38pbVd38OcRVPIU34l/l3So84yT3QNYDPuRWQVewp2HUH0AGJwrOSeYE1nSRLbMk2PlkPSdYD/r1ezgqQxjUwwzCuqk1Z1B5PeMr+jA7kM1/kiu9Ud+aghViMiXvd94U3c+pBbbdDJw1OnriyiUVHNpcF/tLjI1216R8w8Lw4dMueSBtK1QcpXIoTTlpi61C/5FbGvSUs4qGWNqhUOHqxW4tvXZrlmhE9GqjHYQ/JZgJefyOmhb+9j5EcU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaAeoEmDjL11BYfLSRlpuaDZv3BGBRIv18U02/DDW5c=;
 b=KxPv0rqdI6axhkAd2AtiP4nTaE3ib3Su/qGYPio5utATYMXZ2EtzPCXDdzSx5Xz8YSSIBClWdm1E+8AgSrxkWEHrE1l/OHWk4L1rpPD6lh8BmXZImUqyl2RX+sFS1X1tgIWCDbQ/qtaCCXIgrs3UD1eLOw3DB/2WKMcCzWUA1qINvrnZBY/SvRvRuPA0r4GNGFlw8qlGavCM/TiM/gX8h6jkrCuSuqKp/Val3SQz49pCxK37jfmSIbh89evdR+bOwqw896pXN3u9oNF0LEkGnEbXkAy7Xo859eJROm9IELH8Na17VZdbzebABUCOvg+TPPbYlubuaeVov+9dXGUuqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2907.namprd12.prod.outlook.com (2603:10b6:5:183::14)
 by BN9PR12MB5289.namprd12.prod.outlook.com (2603:10b6:408:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Mon, 26 Sep
 2022 10:29:43 +0000
Received: from DM6PR12MB2907.namprd12.prod.outlook.com
 ([fe80::25ab:65ec:8512:5f2b]) by DM6PR12MB2907.namprd12.prod.outlook.com
 ([fe80::25ab:65ec:8512:5f2b%7]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 10:29:42 +0000
Message-ID: <75b9bbc0-0e99-3201-f83d-f1fe28c54b12@nvidia.com>
Date:   Mon, 26 Sep 2022 15:59:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
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
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20220915145241.GE4550@workstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::22) To DM6PR12MB2907.namprd12.prod.outlook.com
 (2603:10b6:5:183::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2907:EE_|BN9PR12MB5289:EE_
X-MS-Office365-Filtering-Correlation-Id: 82fe6ad4-3468-4672-113b-08da9faa0640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7wZOs9pWItkGT43gfBSNtj9qXcr1wttwh4Ep8lxWGzBkUK+FskOhaLu+A0f8ILaDokPxBN08X5SLmEy+XuL+IGmbHsA+hPnHqFgJCDOEw5mfOURp+im2CAGiYesp4LgjYifCC3y3jQ5zgmrVrQFvTZKH+fq/5r5xInBMTw0xQ6MvlwX3RAJWOdl319s2I32USEwjrPSJYDrMMYS/q30WQND5SXJojibScymP3/p9lzK+YM+qLi6VeJtzuw24AXxKHXes+EV+o4zct0dtjJYoGQXR/XFN+SmidlpFSNaMaOzPxLG6V+yEMNiJrWgtAds9R50kZbV60TdZotdFah0BVH1B5+qfj7issw0itzEieJ7PoZr7zpy3e24ulyEvzRsEJHb0BMGXmxl0ZRXV9UIEJetwuFwD5lt9HoogSKi9n3S9KuIhUgJ33ND6VKKNAf4POHPvfDJnxZorShrX0FQ/jTgoOKpKrlZsaxP3fPtYEq+7lZvONdK7faqcbxRu2HTd7GgCsb7hlC9msCaXy4msjU4SRU001acA7EHAc7Lk7qtAQMJ8HNO2ODZYg9Yt8Co5AlM2DBNstvlbg1W9yIMeo71Cp8saT8ViQEtfPalYgc/Tc6Ku/jy7q383jdEUSmSJvTLgAHlkRVC4d9/nNzpxqrZ6ttII5xIm8jhpeNNz3FISQmQVQEss2b4dnZ68VEL+GRpW4jwA6VwPNVDa7N+EC5dt+y3uiiqS1/1kSv3FAVgIgulZ8sCjoY8cMjImWRN5aAH04BgrSIZkYVLsZpUNbYPJUguCmVzLRXVfdUmwyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2907.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199015)(36756003)(31696002)(86362001)(38100700002)(2906002)(5660300002)(7416002)(6486002)(478600001)(4326008)(8676002)(66946007)(66476007)(66556008)(54906003)(316002)(110136005)(8936002)(186003)(83380400001)(6666004)(41300700001)(2616005)(53546011)(6506007)(26005)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUh0Tnl1dEhxUGlmZHcrTkNaRzdMS1dzVGJtbU9sY3Nsc05QN0xoNjcwTktp?=
 =?utf-8?B?SnhqTEFiMGxGd2xTSWlsb0JacGFZWWVtMWNoNFRQcWE2bGp1c1A0dlNwajI3?=
 =?utf-8?B?OEExajVFUENva0x3RjdLUXFpL2hPaURKcEpOcTFGT1lBNW90OHAxTWdqQy90?=
 =?utf-8?B?WDczaExGb1BhWTFvRG5BM1dld1BnVzg3dXYyVlJ1VVpwVTVjcVJZYTVZNk9a?=
 =?utf-8?B?NElBOEVlU0M5aDBmT0tLWUdGa0F0a2U3bGxZSEl1UFVDL2w5T2o4SUEydVdJ?=
 =?utf-8?B?NU9OazJVQTlxTlBXREIzVTdOaDkrcktPT1ZmQWd0TnNxNVdpRklYTWMxSVBn?=
 =?utf-8?B?T3IvSU4rY0pwSGlqWGRKRmgxaDd3MlBvRjBzQUFVdEhiRnRJYkx3eEN1Q0RV?=
 =?utf-8?B?YnVYM0hUNzNVZmtLSHprMHdEMkFkVjFJemcrM01mTjA4MG5zVkVZYkdydU1S?=
 =?utf-8?B?bmN5VHo4RnB4eUZtWkNHaVZoT0duSmhsenhDQ0RhWlpvWS9EWGI0Y2RuR0l4?=
 =?utf-8?B?MU8xc2RJNVp2TDZtNytGQm5MUkc0bE5icUdmdTJtd0ZGakxEWTUvNHhNalZY?=
 =?utf-8?B?SWxTUWdYQkI4QXhPdmFxRlVDRnIwYTlUR3NyTjh2ZCtmeEZBNjU5MDFvYm4x?=
 =?utf-8?B?NjkvdnorMTROc0RTandIR3ZDYnBkbXplT0NyV0RJcWJUbzRTeEZrYStzMUQv?=
 =?utf-8?B?bEIrSXl2R0s0T0owZVBjVFFhUVRyVXRZTlY0SXRVZWs2MktJWUNZZjVVV1NJ?=
 =?utf-8?B?VUU3RlVqVU5BbEplM3ZvZ0dGM0xrU29lcDBUMm5KQjhrWVRJWHpud1lLTHln?=
 =?utf-8?B?OWU0YlczbmN0SXBwd1ZWTDdBU3QrKzY1N2sra2VMWDFrc1JDSnZxM3RzUzd6?=
 =?utf-8?B?bGtSR0tabllTTXFjWXZ4cjlBQThJTzNmT1Q0cktkbFgxUUw5QTRPd0pCWWRw?=
 =?utf-8?B?eGJiRUtDREFVNWxvdk1XRlV6VUVrRDk4dmJvejRwek9BWnVoYUVIZng1QzhW?=
 =?utf-8?B?Y0tXVlpZRmFXMTgrM2lVT0RHcFBPWTF1aW9TOTdnVHA5NHp6OTdiakd6QzNx?=
 =?utf-8?B?QlJWRXh6ZTR0VklBVDkxT2xMT2pYSXJqNU5FV28xRytvOEs0VmwyTnFya3px?=
 =?utf-8?B?bjlsWmM3ZklMNFRyTmdOejVPQ2hLTFJhalJaOFNwVC9oT3lBS1JQSm9ncEk4?=
 =?utf-8?B?Zkx2czNXSTZ0RGxGV24xdU5tOWg0NnZKOGtNZ2pkYkNpSGpaWERZWXhYOWdn?=
 =?utf-8?B?UmFaZ01tMDlzUG95RjVCYitHaDZnTXRPV0lmUlFOVjNpNjlHU3FiQXloNXNo?=
 =?utf-8?B?SHRJYXZvMTQ0ODZSL0lQcllZZXlhenExSGRsTGd4bXVYcndjZ2xCVEtCTXNz?=
 =?utf-8?B?dHA5WGpMMFRIL2ljakZmUkxSemNJSlYxSzMxTXlldnJId3FvYUF2ckdIRmhp?=
 =?utf-8?B?a2pWN3VXUEZhemo0bnNTNHpYV08vSU5tTmVDQzNPOXJ2bmdMbmlmVkxFNkov?=
 =?utf-8?B?R3dpeEVIS1hudDZBWUdUNlFmSGlGREg1YzNQMk5kNUhkaG9UMlM3dHN3UEdu?=
 =?utf-8?B?bGFEU0dXTE03cVJad3hVRTZXZXhFN3ZhRFNDejhUb2FMYWtNZVVYdTNEZ05R?=
 =?utf-8?B?VDhZRGkxaGVkbjZXM2txNlBBWlg0dmJhYTk0Lzg3elR4MVFPbktsNlhrZ2w0?=
 =?utf-8?B?VTF5STdkQTRCcUlXSW4yblJCdThONFdvUTZvalUwQkpBSEg5SUVRMmVlZHFH?=
 =?utf-8?B?M2JEYmZac042VjZKOXp3aHVSWDA2ZXIxQ2NHU2pNbmhBRHRGQ0ErUzN3bFVR?=
 =?utf-8?B?WFhLc0ZjNWhjdEd3OU95a1B2UTdsZVZlWUtTYUVqMk9kcnlzZmpabzRWZGgv?=
 =?utf-8?B?TnRyMlluYTMvS3lyVHhYenRTZHh1bDFrMWZTRzdSclBmbUh4MTVCTFo1RlZu?=
 =?utf-8?B?Y20zb0RmcVMyQ2NnbVZSSDlhaU9yMUIwRWRtSWQ0SmQ5Y3V2dGJTOGl2RERM?=
 =?utf-8?B?YXh4eGF0bGJvdVd5U1dxUTlKY3VXWXhMMXdHMXJocmNwZmtlb040SnVkV281?=
 =?utf-8?B?MExza1h3WDV6cW1FYU9uRjJ5M3VyN01QdW9zQTdVazMvZHFXbGNFVUVvdXVx?=
 =?utf-8?Q?JuV4NCZ9ghEz5CsYOFDFRUoAH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fe6ad4-3468-4672-113b-08da9faa0640
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2907.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 10:29:42.8058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4uzhC1+eKJkNF9J1JyiHEU5aPg8HJV2wlIbHwbHITT3dyS3HJPWgobylaJCZecPcGEhDlScpYBNE0gZVQHvew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5289
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,
Just checking if we are good with this patch or does it need any further 
modifications?

Thanks,
Vidya Sagar

On 9/15/2022 8:22 PM, Manivannan Sadhasivam wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Sep 15, 2022 at 09:16:27AM -0500, Rob Herring wrote:
>> On Wed, Sep 14, 2022 at 1:24 AM Manivannan Sadhasivam
>> <manivannan.sadhasivam@linaro.org> wrote:
>>>
>>> On Tue, Sep 13, 2022 at 03:07:46PM -0500, Bjorn Helgaas wrote:
>>>> On Tue, Sep 13, 2022 at 06:00:30PM +0100, Jon Hunter wrote:
>>>>> On 13/09/2022 17:51, Manivannan Sadhasivam wrote:
>>>>>> On Tue, Sep 13, 2022 at 03:42:37PM +0530, Vidya Sagar wrote:
>>>>>>> Some of the platforms (like Tegra194 and Tegra234) have open slots and
>>>>>>> not having an endpoint connected to the slot is not an error.
>>>>>>> So, changing the macro from dev_err to dev_info to log the event.
>>>>>>
>>>>>> But the link up not happening is an actual error and -ETIMEDOUT is being
>>>>>> returned. So I don't think the log severity should be changed.
>>>>>
>>>>> Yes it is an error in the sense it is a timeout, but reporting an error
>>>>> because nothing is attached to a PCI slot seems a bit noisy. Please note
>>>>> that a similar change was made by the following commit and it also seems
>>>>> appropriate here ...
>>>>>
>>>>> commit 4b16a8227907118e011fb396022da671a52b2272
>>>>> Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>>>> Date:   Tue Jun 18 23:32:06 2019 +0530
>>>>>
>>>>>      PCI: tegra: Change link retry log level to debug
>>>>>
>>>>>
>>>>> BTW, we check for error messages in the dmesg output and this is a new error
>>>>> seen as of Linux v6.0 and so this was flagged in a test. We can ignore the
>>>>> error, but in this case it seem more appropriate to make this a info or
>>>>> debug level print.
>>>>
>>>> Can you tell whether there's a device present, e.g., via Slot Status
>>>> Presence Detect?  If there's nothing in the slot, I don't know why we
>>>> would print anything at all.  If a card is present but there's no
>>>> link, that's probably worthy of dev_info() or even dev_err().
>>>>
>>>
>>> I don't think all form factors allow for the PRSNT pin to be wired up,
>>> so we cannot know if the device is actually present in the slot or not all
>>> the time. Maybe we should do if the form factor supports it?
>>>
>>>> I guess if you can tell the slot is empty, there's no point in even
>>>> trying to start the link, so you could avoid both the message and the
>>>> timeout by not even calling dw_pcie_wait_for_link().
>>>
>>> Right. There is an overhead of waiting for ~1ms during boot.
>>
>> Async probe should mitigate that, right? Saravana is working toward
>> making that the default instead of opt in, but you could opt in now.
>>
> 
> No. The delay is due to the DWC core waiting for link up that depends on
> the PCIe device to be present on the slot. The driver probe order
> doesn't apply here.
> 
> Thanks,
> Mani
> 
>> Rob
