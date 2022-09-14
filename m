Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E05D5B86E9
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 13:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiINLC2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 07:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiINLC1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 07:02:27 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0423AE7D;
        Wed, 14 Sep 2022 04:02:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GttlbbJGWg4aMKMG9GG/UKtcusd3lp04JM3AKNi3N/Bm89T1L+plbQlio8nxntBxIgymNlJUMGFxgKt6yRXk3utHuEXakeg5jQabGhXNVsoXvjZsNR7ujjvADBswdyniSNJXLlm7iXIh+gHThm4s2VmsTD6esQNR9iYKi3Zu5gLMtkIws9XH8fOm5XZ0UXd5XTw153ywQySxrI7kOOGwQacXgf3SotkI+U0F615YT70MKg/mQGhLMOStxHACnN/ggDd95siSBJ/KxVjWewpMAHjwBpKUgHzKRDeNsz8Q/EA96vofbeXY13hNx5SuobvuQUk6ES+2WdNudEy9kA7oDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YA7LxOznQcV98rhQePLHv0wh6gZOvwN1QyvZkuc/0QY=;
 b=D4iPmsAZvnIz4YrlI8IZfORxxwYyjgFwiyAbHg+BGdBH5DWZ69YAYtar55m90CUzlQIvMnF/qUeE/lpDvS/TusROeKaXuiWRatI4MKTqYqeroML4H2WRatyXa9C34SUqWU5TtwtgWUvAoK1mXClhujeEK4b1USplrmjm18g9RD0whKbposnkl5El3UvOC/PD/o//tSssicT6CiepDK30eqCJV/v3off/bQFO/32vvqalKoZUg2epZekSCN4Q1NawjMg3nOWpFx3+T5kjagwt3v7iiGPI6obmSZPYQiSIZmfcu0u2T9UgeSJ0bQDAxRH58YxcGJBIb+1nEeRt16l2Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YA7LxOznQcV98rhQePLHv0wh6gZOvwN1QyvZkuc/0QY=;
 b=XqZTBUM/pbYGxa7pYKopsywGs34NnfX25LJpNm7AJKw4vTsuakg9m5qNH82p9LqaVS/006fiu0+J+n39sG4CCnJ/h6XRp1spisSBL0UdczkrmI09o5nKwRJ3vmUmdAmpkLQmy0h+puZtIdz8YLYHZYUFyiLuvkSqOm2s2CE1HJrOWyuRfsikxDdxkif/izXgccXDIXlFg0zoFysDgMq54hZIDPZGNfQHQA5ZJGz/rCrI8tDQFo2LtiUVvX/tgeaoOrLR//wTPTML9+LQsIqYMeF0shTCCCiUEv+JqdyWxJ3drPowpcwZuF/4t2EZ8qxVeqr+beyrlZ2C7mebpTM6dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.23; Wed, 14 Sep
 2022 11:02:23 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::1d26:504d:7cde:3158]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::1d26:504d:7cde:3158%7]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 11:02:22 +0000
Message-ID: <29b39edd-10ab-b679-f270-67b0b406ca2f@nvidia.com>
Date:   Wed, 14 Sep 2022 16:32:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        treding@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <b1c243b0-2e6e-3254-eff0-a5276020a320@nvidia.com>
 <20220913200746.GA619956@bhelgaas> <20220914062411.GD16459@workstation>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20220914062411.GD16459@workstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::15) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a43bfe-2ebe-4b54-463e-08da96409940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MdG1fSfBWcSv70+RnJVQ9zRkWOGyc77aXW+RemAo7mE2GqKUNo02iPR4mk5eBhR8WGmWI1Yu2AP3sEgGEXWBB+jTllXDmhV4GUdifvRR4QTpVb+khn297teJhIUedzbJvHh6rnEJzSgX9ByVb/3LMe2Jpen5LpJes6w8AJ8twraFOJH7Y6GBpk2dEfnqaQ2Y7wAPUVVAMmVP7+eCccdQuw6iL9b7YKBdsfetEASoQlqN2KZrJMap3qJXj6TsO3uBj9anO+V0bNhs62zKAeRCA2iw5ORC63vaR3NtgQK7ng5uhCU1jRo2cKl5mXNcFd+QU8CWGX94k4zbUAAbEMdrKcU5EBzPQQ2FxfEsNjAjmnnZTr4IVCC/617+DY4DQok2g1E9BvEWlVahOTGN9qY6peaSmnek9CiY/Ywl2EinEcVU8/v5gW3oIWIznqYpiCFPhJEnymQ+oTRVy3+tGzEe4gzOiaVhK0AaU7PnlXyOrWYkfqlvFETnDwfdITlfgyZ7rcyK/J1XxAbFuKZ5HP+880KSJagqfv6AisPXlR/fPpPaWcKDjKgwNTVTnBNA7Sn2zdVEX+9sv8aOmB4iUJ6MercFvQGFX9gCojunaWGnGOJ4VDLQNfXuKOtfOic1OqKVtrovwR1RbatN2Hwh5uc8YDC67TU42Mq71NruUgAIQXCJq2BRl83Hu6raWqahTa9S/uc6B/YnGhuMTSkonn/NMw1xCLEjwEjrFia42syqD2Ju/ZNFihPBUX9L4tqQAQRlh6BFmyB4o40ji++AuzD8e8d+MBi+E+BT87pTBoxBEVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199015)(36756003)(86362001)(38100700002)(31696002)(31686004)(53546011)(6506007)(2906002)(7416002)(478600001)(41300700001)(6666004)(26005)(6512007)(2616005)(6486002)(83380400001)(186003)(66946007)(5660300002)(4326008)(8676002)(8936002)(66476007)(66556008)(316002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlZIbHFmbTVPK0pOVDlMT3JaK3YxcVpmOUtOdjhVUmNtU2NyVFI4T0RLWWlM?=
 =?utf-8?B?T1dFM0d1Tkt0a2lZeDlVL1hFQkFsdEozRWUzYnN5NmhSS3JOK2NXNmMxT1JQ?=
 =?utf-8?B?bjZRQ2YydUFHRU82OEtyOFczSTJJMkcvbGZITFk0dCtlMFI3bXY3TVdreGNn?=
 =?utf-8?B?dUpDaXUrblRqL0M1R2w1bCtteWNOcldrcTkwVnZTc0ZUN21sWE9MNTdUNDA3?=
 =?utf-8?B?ZWdRQlJWQmQwL0c0U2VwbXhLM0I4WHlJYngwTmU4QlFhR2FwZjBGVnJ4RHA3?=
 =?utf-8?B?aXR3Q29YU25ZVmowWUlJNkJIRWFaOHZVT3NTTHpZTEpVOG52NVVrOU9FbUlX?=
 =?utf-8?B?VlpSOUdqaEREaWNzL1pOdFZEandUMSs4YUY5TkZtZFpNbjQ2S3Z6bEY1UkhE?=
 =?utf-8?B?VjFWSkpzY1RFS0QzS2RBeTRMUW5NZm4zWXVEWGpQWUV5dHl4dVlKOTNlQ3J6?=
 =?utf-8?B?VVdwZThtMEFSQTlhY1ZLT1diSUJQeFRkT0M2UkZxTU5VbU45V2tOeng3RE5B?=
 =?utf-8?B?YW9jUUV1TktMTkNWZ3Z1b0RDUThmVmM4WXdoUHhyeWxDNHFIemhpNUppd0Yz?=
 =?utf-8?B?alYrQzR6dUZzL0l3QW43NmltWW5LYk40OUp4ZnZTM1lkZmgxUWNxemIrY0dK?=
 =?utf-8?B?a1NXMHcvcU5neFBZTTFPK05XbnBXMXJkY1RUMmMvaWQrN0hVS1RQWUo2Ty8x?=
 =?utf-8?B?ZTlmR0dUdnNqTVgvUHVXME1QbTB0OGlJaUxUdmQzbmNoaHI3RHUxdkxVNFhM?=
 =?utf-8?B?b0hVaVR1WTdMTml3NURqdU5weDh4Z0t3em1lNHA4TnU5blArcDJkN2wvMkhs?=
 =?utf-8?B?MzYrbVpJdHphLzZUM2VlaGg4aCtCcEpXbUtncElnWUxIakw4K08yT0R2RDFr?=
 =?utf-8?B?azl3NW5mMmZlL3dQOHRrTmdjS0VrblE2N2FuRjdobTNoQ1NYOWZGTTFyMmlz?=
 =?utf-8?B?YkIxb3VuQ0VYVkR1K2duekZvS2Jxd0VVcmhTUkFQQkFDK0tXVER4OEIrY1lU?=
 =?utf-8?B?ajc3NFFQTXB1aXBHY1A1bXE1dlAzQW1sNVlDUjhia0N1QUw5MTZxNFlzVWk1?=
 =?utf-8?B?WDljaFdEaU5rRVhVbWFIWTZ6M2ZPZW4wTmFjRXFYV2haQThyZm1CSXVCcmM4?=
 =?utf-8?B?dlI3b0dUSTdwWXFsd25ia0dhdVA3UHNTQzJaMmNsY1BXVXdRZjgzUWZTemNF?=
 =?utf-8?B?N05LL3EzYytVbzhweUM0eXQzWjJhekkzTFBNYmR2QjE1VTU5VHdzU0ZxTjFm?=
 =?utf-8?B?WG9WOERHQU9oQ3l1S1lrUDRrWU5udHdKM3VZcTZvU1RPNFh6cjBhdCs1TWNL?=
 =?utf-8?B?TW1jQkI4QTlNVEtINFdXZU9YdFdHNk9hekRCMEQ1YnFpYTZMTjhNN2lnQ09K?=
 =?utf-8?B?alV1d05ndkkrdnpLV21zbFo4dmx2ZVdqcU5WSEZVbUNFOFVjaUlVSk9QMm9C?=
 =?utf-8?B?b29YUTFhcmxTSk1SaW91STRYWG1CSEp3Yy9LaWFNMGdHRVRuSElCbWhROWJE?=
 =?utf-8?B?UncrZU9XZEt2SWhmVmQ2RjIxU2t1OW1iS1hHNkFSbzYvWlpyV1BidzJnaHNq?=
 =?utf-8?B?VnlpdGZ4elV4bG85T3B4dUZPQlRzU3Y5UUtBdFM1U3VmSXoyMXZGYWFyanJv?=
 =?utf-8?B?VGJpUXFrNlZFUXFITEFnRks5cWV4TmVqSjB5d0NoSTZPKy95NVFjSDY0ZmJn?=
 =?utf-8?B?cjFoYnVkZzVIZWxLenNGRndsTHBTdFhVb01iZW9ZWEhiK2NCb3R0OWJBb3Zn?=
 =?utf-8?B?d2FKeTlIU1FXZThIRFV3N28zL0gvWjd5ZGd5TEQzbGRrRkpzQVpCbnBnZDVm?=
 =?utf-8?B?VEJxTFBuK3NVWmZ4M1lmc2w2NENZT21BUDRqQ1Jpc1pIRkNyV1dVb2JoMkN0?=
 =?utf-8?B?NCtoa0F2bnB4VTNqbThNN2ZtYWdXT3BhcjloSllTSUloNFNZY3A2TG9zKzlj?=
 =?utf-8?B?K3kwNmN6VlBTUGJMbDZsWVNJL3JVc3ZYc0RpUnd2aUZYWDZlemdEMWl6bFBD?=
 =?utf-8?B?WkM0dVBENGtENUh5QlJBa051dmJoNTQ0ek5wcFdvZ0dncElkZkZEdnA5NTQz?=
 =?utf-8?B?SW56djhHQ3kxU2pOb2V6ZWNvVWNKQmhQRGJ2VzdTY05wbVh5bE5LZngzeVE0?=
 =?utf-8?Q?zP9Fu+Az/B3sC/Mw5smV0DxuV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a43bfe-2ebe-4b54-463e-08da96409940
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 11:02:22.2983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vu68pMVwTxQqGsAaNKv9464uv+GICUGAVq/IaXRXVi6Ap/NZYP083ZlcJG0Cr+lS8glMlQ3qurMhanpkuOA8Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Agree with Mani.
Not all form factors support PRSNT pin (Ex:- M.2 Key-M form factor) and 
even if the slot form factor supports PRSNT, it is not mandatory to have 
a GPIO routed to the PRSNT pin of the slot.
Also, since these are development platforms, we wouldn't want to keep 
changing a controller's status in the DT, instead want to know the 
device's presence/absence (by way of link up) looking at the log.
In my honest opinion, I don't think the absence of a device in the slot 
should be treated as an error.

Thanks,
Vidya Sagar

On 9/14/2022 11:54 AM, Manivannan Sadhasivam wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Sep 13, 2022 at 03:07:46PM -0500, Bjorn Helgaas wrote:
>> On Tue, Sep 13, 2022 at 06:00:30PM +0100, Jon Hunter wrote:
>>> On 13/09/2022 17:51, Manivannan Sadhasivam wrote:
>>>> On Tue, Sep 13, 2022 at 03:42:37PM +0530, Vidya Sagar wrote:
>>>>> Some of the platforms (like Tegra194 and Tegra234) have open slots and
>>>>> not having an endpoint connected to the slot is not an error.
>>>>> So, changing the macro from dev_err to dev_info to log the event.
>>>>
>>>> But the link up not happening is an actual error and -ETIMEDOUT is being
>>>> returned. So I don't think the log severity should be changed.
>>>
>>> Yes it is an error in the sense it is a timeout, but reporting an error
>>> because nothing is attached to a PCI slot seems a bit noisy. Please note
>>> that a similar change was made by the following commit and it also seems
>>> appropriate here ...
>>>
>>> commit 4b16a8227907118e011fb396022da671a52b2272
>>> Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>> Date:   Tue Jun 18 23:32:06 2019 +0530
>>>
>>>      PCI: tegra: Change link retry log level to debug
>>>
>>>
>>> BTW, we check for error messages in the dmesg output and this is a new error
>>> seen as of Linux v6.0 and so this was flagged in a test. We can ignore the
>>> error, but in this case it seem more appropriate to make this a info or
>>> debug level print.
>>
>> Can you tell whether there's a device present, e.g., via Slot Status
>> Presence Detect?  If there's nothing in the slot, I don't know why we
>> would print anything at all.  If a card is present but there's no
>> link, that's probably worthy of dev_info() or even dev_err().
>>
> 
> I don't think all form factors allow for the PRSNT pin to be wired up,
> so we cannot know if the device is actually present in the slot or not all
> the time. Maybe we should do if the form factor supports it?
> 
>> I guess if you can tell the slot is empty, there's no point in even
>> trying to start the link, so you could avoid both the message and the
>> timeout by not even calling dw_pcie_wait_for_link().
> 
> Right. There is an overhead of waiting for ~1ms during boot.
> 
> We workaround this issue by disabling the PCIe instances in devicetree
> for which there would be no devices connected.
> 
> Thanks,
> Mani
> 
>>
>> Bjorn
