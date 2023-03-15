Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED276BBFA6
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 23:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjCOWQg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 18:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjCOWQf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 18:16:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A2C2708
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 15:16:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJ8WPX1sLrw7K8YW4ckeKSMPXnip2+jtUAG84z5Xx7b/0Y2E8lNepKOAl06eeukmOdV5nXx0wKWi6nzS9mzP9ZkmcBlQ5S44UkM2SLtqUX3uSl2rDbb3aPBDhC6v3o19urNwwUKbFEB2RuBcjQS+/zYV0ldzIJAZET5xX9OLDkajAzSczQdnSbOy47n274SCjj40JDG8UsieAKsey04/kkaEjQRvtoxzdYk1fatQPbTTZO3rbUb7p3ELxas/2KkNPeR9P9K3HQDmWcLhREW3kfuCmnnygIkf41JNIClN51WzoaMh6KSfx28SdScO9amEXXj3lzm5qYLRgs3Gh0le2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IF2XABrLuh/2GWsvprSZj3HdLdU1lLAwHs4ErdL0yC8=;
 b=InnuvHr11+vR/c0Q8Ko4TTz1QOWYvK/wVT0nAboJmDigtooozmoIk7lLD8u9+eQdGTwFRunydJcRbGqAg4CGRkZkwtkeyDU/AYXZtM38Gd+momSpaUZbXlV/VqBq05RAaxe0O1SZAEzyzBB7FD1G0Q1TDXZKA47XZYfwqMEoTb+2nJftLc/a5it0VSr0FAwCYzTrZjz0pJsdIxd1DrR09gnB/HQfMeA7bdsbuDXC/hdHMEB29uEQpIJfgmOgHiqy4UC4xBDxCCDBEB0rSqZbP9gjvVWofmcRQvv8iAuu7iYq/QYpvEOHYVo7yxMbCUfOO/o4CyTG37uIdBsUj3YMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IF2XABrLuh/2GWsvprSZj3HdLdU1lLAwHs4ErdL0yC8=;
 b=b9L9UF9LRFOFbWxtCblX/rST9qxTidSMFifs74rxKGvLXaF2bWDQsuMleJdkXcz4CP0y62lP4spnEBS1+BCJlmnLa3LWHcCxD45zWcZO1qykMVV1aH8WrOaRjSmssqFgMiTBacmPFfyR/JOqEC6t1jJSV9YN11kYuIdMdJFxXD9dPyz+Kl7L37z/sp3+C3ruLSHKwigLTips9adkE3w8ZUsLAoKDApQcQYhp5q3k3ARa2VxtSg9mPMNwKUeQDPmyjYPPZ4hdcQFkayp3mIrk+I6khAL7MX65xy7NCik7WF8Qo7CULHlw5LCDP8m7QJkgPFfKLvNCkVOOVs5dTIuLAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3189.namprd12.prod.outlook.com (2603:10b6:a03:134::11)
 by DS0PR12MB8564.namprd12.prod.outlook.com (2603:10b6:8:167::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 22:16:30 +0000
Received: from BYAPR12MB3189.namprd12.prod.outlook.com
 ([fe80::c4b1:77a1:8e6b:841d]) by BYAPR12MB3189.namprd12.prod.outlook.com
 ([fe80::c4b1:77a1:8e6b:841d%5]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 22:16:29 +0000
Message-ID: <d41eb762-af7f-ccd2-51de-5c3f81138985@nvidia.com>
Date:   Wed, 15 Mar 2023 15:16:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: nvme-pci: Disabling device after reset failure: -5 occurs while
 AER recovery
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
References: <c17f7476-8ed0-212e-9480-78732635ee3f@nvidia.com>
 <20230314161127.GA1648664@bhelgaas>
 <ZBCuPM0WcWaLwWXJ@kbusch-mbp.dhcp.thefacebook.com>
 <e598b84f-2f90-b29a-6209-17309763514f@nvidia.com>
 <362f552f-df15-878a-1fd6-4ef086e8fdb1@linux.intel.com>
From:   Tushar Dave <tdave@nvidia.com>
In-Reply-To: <362f552f-df15-878a-1fd6-4ef086e8fdb1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:303:8d::6) To BYAPR12MB3189.namprd12.prod.outlook.com
 (2603:10b6:a03:134::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3189:EE_|DS0PR12MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: b42eb3b7-eab0-4e9c-2c47-08db25a2ed15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2jpLNuv7hwYCvbVeaqgbzAfplW8C2357zVmdcYOJiH6IAZ1wweL/PEONsoYa47jPiIaZ/Q2MbQb6ojiYDh1qt0fwKGsF/oNW4c9XvwWL65MXZgrD57oBiigpiaU1ICNPLkInw5oBUt/j3062i3kzl9k4khz/hOFIcvNEZncD+ez2kS9iNEWB9W+gfWGEappWeAsD63Q4S4aChCU8LRMRgyNXQFWlbFWxEr1P3H7Tj0oyi7lTJ3ACrAP9tW2yIlnkl+QoKGdp2EPoT9hi0CsLpWUT3RskrdAs5qmxFXJ/F14kDqgKJkQznObmNLd/eXQhzpmHQybAHrZWy80gUEWEJifGSkRwpNR4f3uVFeHUwWao9U3LmtugzCnEdDPp0XSAMmD6+favq97HTeLD6kFwp2f8pAX/KFSA4MMu9aAkz83kmuqfOecKQaeMpwEcguYHe97WNrfqpsQUzUCXznRFeft24FW2MH/otphO3s6wY9F1Lvkyg4TthbuBLLs4ULFWR1eMHOZD6vJmmJaCz+HE0E6X27S+2pENnXK2byZuHym+1KyLDYb/tHO9z06gE2DRH9Zsf7ugMFDTpDjsXTvh1pBIh08e85bAhxG99eFSYdnYACDFwh+Wf9JtD/cVYW8Mj0KemECpCB1N0nCZTM1T6S/CDUmhUleQ9KKGD/YQG1a479/cqBVXVPU5K/9wl2+FY/h9gDaudI+cqTVL3EJikDysqnizgrPNQL+X6EYtgvCYDeErZjQ9RETRBH/xctv7d1g00fGcnfX8qJjVvGZrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199018)(31696002)(86362001)(38100700002)(8936002)(41300700001)(5660300002)(36756003)(2906002)(83380400001)(54906003)(26005)(2616005)(53546011)(186003)(316002)(6506007)(6512007)(110136005)(8676002)(66556008)(966005)(6486002)(478600001)(4326008)(66946007)(66476007)(66899018)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk9TTmtuWnhYMVczeXJJQXRiNEx1dUlJT2p2NHdUU0ZtQVIyb0tkNVl1MSsx?=
 =?utf-8?B?Z29GdkdxdUdMM1F4MHZGQWxkTWcxV25HUXBWcDlCRHc5emtlN0doZUJZWTdL?=
 =?utf-8?B?ZmUxZ1p0UFVVenVEODVkMUlOZGJDeHVJZmsrVmE4Q1pJREt1cjFuMEFicXA0?=
 =?utf-8?B?aGpVeFdSTkNKNGZVenE1NFBhUlY4RUxROGJYejFjZStLSGNaaGxQM0JWNHRU?=
 =?utf-8?B?K05TSTZXbHhaZUFiOWVwaDJtTHZHOHFESU52SmhMTFZjZ2Vic2RPcGFCenVF?=
 =?utf-8?B?djhsbW96UVcyMEJBaXgyMm9mcEpXeERCemZmZnAvQ1k2L0pGbXA4V2NKeEF5?=
 =?utf-8?B?bWJTcVUwaTlGY2xwaGxGSERwNEtmNitNN3h0clhDRGNPSEY2bUZHRXdka0xP?=
 =?utf-8?B?bGx5VWhCQUlwdnEvaHpKQTlrZkhFSlRydGRNaU1sREdFYmpKam8vNWZWZzRG?=
 =?utf-8?B?NkJVOHZKNE1CNXNqYzVCS0VHTVh3M0xZSE45cUFCdkFkZTZpcFBNQ0dNRC9D?=
 =?utf-8?B?M0gxSkZENnhhTDRocTRaLzNYaEtwVEFGdnJTdzVWbTBWbEFQaExoTGhVNzVB?=
 =?utf-8?B?c24yQ1RxMU1nL0ZWaEc4cGtjMDMrdUxxNWhQbkhJS01uK1d5MnFnZzFpZUli?=
 =?utf-8?B?N1IxT0U4c1dFRG9UNkxLM0ptZHFWQjJiYTNkbGhWcThWcEtRZE4wU1NYTDl4?=
 =?utf-8?B?aU1wV2JpRTNYS0tHbmFmbVNXRmJQdytLOWhheDJleUI0WDZsWlUxQ2JYdkJ0?=
 =?utf-8?B?cU1NUVQ0VTMxY2g5Y0lqYXNLeXk2UWpkU2ZPT0ZtNXFXZEVXeGZrT1A5cXNC?=
 =?utf-8?B?aU9WQnJKcE1QNkhxTG1UdFFFTGRod1ZBR3ArdG1pcDBLZjhKRkpxVXVqVTFk?=
 =?utf-8?B?NlJ3RUxjeFl0emF6WmZndC9RR0g2R3RKRW9HcWwxU29SUEJhVlFqdk5MOFBa?=
 =?utf-8?B?UDFhcElNU0tHMG5TUXZaWWJTVVk1Mm9QZS9GeVg4bkJVVHdHTFYxZE5NVjRa?=
 =?utf-8?B?L3N6eGV5eEpFNlc3M2U4OGhMalFKVWN4Nzl5cXpKcVJQNTZuVnJTR2NNS2Fv?=
 =?utf-8?B?VGk5Rk44OUl6SDRMUmtWeE9EV0JibFI5Mmc2eHNtNkpaZXhILyt1dFhpaHl3?=
 =?utf-8?B?eXB4MUZLSG10a2VJVjQ0MkdLcllMeGNaNm05cEp0dzFRc09qSTR0WkwwZC9H?=
 =?utf-8?B?bWEyS2RyckVjN0VvL2F6NU5mL0N1SVlNV2p2S2RLUm1XWW5yT25zc3pUblRO?=
 =?utf-8?B?NysxaGZEMmh3a1FQSnlwOGcvc3dmU2lDQ0lzWUpGMlk3c2I2ZW5GL3VXVDJl?=
 =?utf-8?B?UnUxK2pYby9wRDdTM3ZUelBxSDlBUXhIQi8rWlQ1VkZnSkJZZEJySWtZeEsr?=
 =?utf-8?B?NkdOWDlVcHZNY1p2bnlWS1ZCVnc1eU1BT1B1Vy9uMWVnOGxXNDFyWGxaTkhs?=
 =?utf-8?B?UTlvZDlVd1ZMdWFRVTBHZU1hZ0tzSGkyL2dYd3lDTTRLL2R4MzBCcGptdVdT?=
 =?utf-8?B?WlZjTDNDUUIwVkI4NzZCVjBXblUrc3dZc0lWSHVSSHFRTFdwSXFTSmF6dGth?=
 =?utf-8?B?dHZHVmROa3NxcUF3bVFBeExQSjViUXBmb1JJaldHUi9GbmNoOG1TcDFIakpF?=
 =?utf-8?B?bFFTaUFsS0FCaURJS3krdmxCalFRTDVrNnQzUnhkVHdxaGRDTHI2VXZnOThK?=
 =?utf-8?B?d240R1dXekpMd3F1b2N1enBOclEzYVJHNjFnajMzNkN0dHVuRVRNY0htdXEv?=
 =?utf-8?B?ZFF3QXFhRll1ajRBSnNiam8zRE52NGpOR3lacXNZT0l5MEV1anQ2THJYRHpE?=
 =?utf-8?B?UStYUnBpcVdsaGcwY0FHaG1GYkxPR2lPNXQwSlRvVkw4MWhkd1JvRWkzdXJF?=
 =?utf-8?B?bVdaZlF3ZStKZFFHWk5ieENodUE5dFVSK0ZOcFJPMmpFYjZzZFJ4enJta25s?=
 =?utf-8?B?Z0tRTnZYa0hBbzUrUHJuT29OaTFITkxQalgremkrQjBzZUY0NVdLVDJ0M1hR?=
 =?utf-8?B?b2s3ZzVVSitrQWpLLzByM1AzcjkxVEhySHZ5ZCtNclJBdjFpMHhCK1U3K2NF?=
 =?utf-8?B?dWZlSHhvQi9KNVExQmd0OXpoY04zK3ZNN3BqWE9XYXM0Qld3UzBsQkFrTEc4?=
 =?utf-8?Q?Ss0seDUnYL8xINCs2sOkgEQhX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42eb3b7-eab0-4e9c-2c47-08db25a2ed15
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 22:16:29.7761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxdqPeu7WiUUh28iDXKYaMCqV3WjuHe2mf8XFFpvg4N6NczJcfnXHNt7OeaTop1iLA0V22TzIEp2Zw2uDRjgYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8564
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/15/23 13:43, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 3/15/23 1:01 PM, Tushar Dave wrote:
>>
>>
>> On 3/14/23 10:26, Keith Busch wrote:
>>> On Tue, Mar 14, 2023 at 11:11:27AM -0500, Bjorn Helgaas wrote:
>>>> On Mon, Mar 13, 2023 at 05:57:43PM -0700, Tushar Dave wrote:
>>>>> On 3/11/23 00:22, Lukas Wunner wrote:
>>>>>> On Fri, Mar 10, 2023 at 05:45:48PM -0800, Tushar Dave wrote:
>>>>>>> On 3/10/2023 3:53 PM, Bjorn Helgaas wrote:
>>>>>>>> In the log below, pciehp obviously is enabled; should I infer that in
>>>>>>>> the log above, it is not?
>>>>>>>
>>>>>>> pciehp is enabled all the time. In the log above and below.
>>>>>>> I do not have answer yet why pciehp shows-up only in some tests (due to DPC
>>>>>>> link down/up) and not in others like you noticed in both the logs.
>>>>>>
>>>>>> Maybe some of the switch Downstream Ports are hotplug-capable and
>>>>>> some are not?  (Check the Slot Implemented bit in the PCI Express
>>>>>> Capabilities Register as well as the Hot-Plug Capable bit in the
>>>>>> Slot Capabilities Register.)
>>>>>> ...
>>>>
>>>>>>>> Generally we've avoided handling a device reset as a
>>>>>>>> remove/add event because upper layers can't deal well with
>>>>>>>> that.  But in the log below it looks like pciehp *did* treat
>>>>>>>> the DPC containment as a remove/add, which of course involves
>>>>>>>> configuring the "new" device and its MPS settings.
>>>>>>>
>>>>>>> yes and that puzzled me why? especially when"Link Down/Up
>>>>>>> ignored (recovered by DPC)". Do we still have race somewhere, I
>>>>>>> am not sure.
>>>>>>
>>>>>> You're seeing the expected behavior.  pciehp ignores DLLSC events
>>>>>> caused by DPC, but then double-checks that DPC recovery succeeded.
>>>>>> If it didn't, it would be a bug not to bring down the slot.  So
>>>>>> pciehp does exactly that.  See this code snippet in
>>>>>> pciehp_ignore_dpc_link_change():
>>>>>>
>>>>>>      /*
>>>>>>       * If the link is unexpectedly down after successful recovery,
>>>>>>       * the corresponding link change may have been ignored above.
>>>>>>       * Synthesize it to ensure that it is acted on.
>>>>>>       */
>>>>>>      down_read_nested(&ctrl->reset_lock, ctrl->depth);
>>>>>>      if (!pciehp_check_link_active(ctrl))
>>>>>>          pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
>>>>>>      up_read(&ctrl->reset_lock);
>>>>>>
>>>>>> So on hotplug-capable ports, pciehp is able to mop up the mess
>>>>>> created by fiddling with the MPS settings behind the kernel's
>>>>>> back.
>>>>>
>>>>> That's the thing, even on hotplug-capable slot I do not see pciehp
>>>>> _all_ the time. Sometime pciehp get involve and takes care of things
>>>>> (like I mentioned in the previous thread) and other times no pciehp
>>>>> engagement at all!
>>>>
>>>> Possibly a timing issue, so I'll be interested to see if 53b54ad074de
>>>> ("PCI/DPC: Await readiness of secondary bus after reset") makes any
>>>> difference.  Lukas didn't mention that, so maybe it's a red herring,
>>>> but I'm still curious since it explicitly mentions the DPC reset case
>>>> that you're exercising here.
>>
>> Commit 53b54ad074de ("PCI/DPC: Await readiness of secondary bus after reset") didn't help.
> 
> I did not check the full thread. Since this seems to be in EDR recovery path, make sure to
> include following patch.
> 
> https://lore.kernel.org/lkml/20230215200532.3126937-1-sathyanarayanan.kuppuswamy@linux.intel.com/T/

Sorry but in your patch I guess you really want 'pdev' instead of 'dev' in 
pcie_clear_device_status(dev);

or I am missing something?

> 
>>
>> [ 6265.268757] pcieport 0000:a5:01.0: EDR: EDR event received
>> [ 6265.276034] pcieport 0000:a5:01.0: EDR: Reported EDR dev: 0000:a9:10.0
>> [ 6265.283780] pcieport 0000:a9:10.0: DPC: containment event, status:0x2009 source:0x0000
>> [ 6265.292972] pcieport 0000:a9:10.0: DPC: unmasked uncorrectable error detected
>> [ 6265.301284] pcieport 0000:a9:10.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
>> [ 6265.313569] pcieport 0000:a9:10.0:   device [1000:c030] error status/mask=00040000/00180000
>> [ 6265.323208] pcieport 0000:a9:10.0:    [18] MalfTLP                (First)
>> [ 6265.331084] pcieport 0000:a9:10.0: AER:   TLP Header: 6000007a ab0000ff 00000001 629d4318
>> [ 6265.340536] pcieport 0000:a9:10.0: AER: broadcast error_detected message
>> [ 6265.348320] nvme nvme1: frozen state error detected, reset controller
>> [ 6265.419633] pcieport 0000:a9:10.0: waiting 100 ms for downstream link, after activation
>> [ 6265.627639] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
>> [ 6265.635289] nvme nvme1: restart after slot reset
>> [ 6265.641016] nvme 0000:ab:00.0: restoring config space at offset 0x3c (was 0x100, writing 0x1ff)
>> [ 6265.651248] nvme 0000:ab:00.0: restoring config space at offset 0x30 (was 0x0, writing 0xe0600000)
>> [ 6265.661739] nvme 0000:ab:00.0: restoring config space at offset 0x10 (was 0x4, writing 0xe0710004)
>> [ 6265.672210] nvme 0000:ab:00.0: restoring config space at offset 0xc (was 0x0, writing 0x8)
>> [ 6265.681897] nvme 0000:ab:00.0: restoring config space at offset 0x4 (was 0x100000, writing 0x100546)
>> [ 6265.692616] pcieport 0000:a9:10.0: AER: broadcast resume message
>> [ 6265.716299] nvme 0000:ab:00.0: saving config space at offset 0x0 (reading 0xa824144d)
>> [ 6265.725614] nvme 0000:ab:00.0: saving config space at offset 0x4 (reading 0x100546)
>> [ 6265.734657] nvme 0000:ab:00.0: saving config space at offset 0x8 (reading 0x1080200)
>> [ 6265.743824] nvme 0000:ab:00.0: saving config space at offset 0xc (reading 0x8)
>> [ 6265.752348] nvme 0000:ab:00.0: saving config space at offset 0x10 (reading 0xe0710004)
>> [ 6265.761647] nvme 0000:ab:00.0: saving config space at offset 0x14 (reading 0x0)
>> [ 6265.770247] nvme 0000:ab:00.0: saving config space at offset 0x18 (reading 0x0)
>> [ 6265.778857] nvme 0000:ab:00.0: saving config space at offset 0x1c (reading 0x0)
>> [ 6265.787450] nvme 0000:ab:00.0: saving config space at offset 0x20 (reading 0x0)
>> [ 6265.796034] nvme 0000:ab:00.0: saving config space at offset 0x24 (reading 0x0)
>> [ 6265.804620] nvme 0000:ab:00.0: saving config space at offset 0x28 (reading 0x0)
>> [ 6265.813201] nvme 0000:ab:00.0: saving config space at offset 0x2c (reading 0xa80a144d)
>> [ 6265.822473] nvme 0000:ab:00.0: saving config space at offset 0x30 (reading 0xe0600000)
>> [ 6265.831816] nvme 0000:ab:00.0: saving config space at offset 0x34 (reading 0x40)
>> [ 6265.840482] nvme 0000:ab:00.0: saving config space at offset 0x38 (reading 0x0)
>> [ 6265.849037] nvme 0000:ab:00.0: saving config space at offset 0x3c (reading 0x1ff)
>> [ 6275.037534] block nvme1n1: no usable path - requeuing I/O
>> [ 6326.920009] nvme nvme1: I/O 22 QID 0 timeout, disable controller
>> [ 6326.988701] nvme nvme1: Identify Controller failed (-4)
>> [ 6326.995253] nvme nvme1: Disabling device after reset failure: -5
>> [ 6327.032308] pcieport 0000:a9:10.0: AER: device recovery successful
>> [ 6327.039781] pcieport 0000:a9:10.0: EDR: DPC port successfully recovered
>> [ 6327.047687] pcieport 0000:a5:01.0: EDR: Status for 0000:a9:10.0: 0x80
>> [ 6327.083131] pcieport 0000:a5:01.0: EDR: EDR event received
>> [ 6327.090173] pcieport 0000:a5:01.0: EDR: Reported EDR dev: 0000:a9:10.0
>> [ 6327.097816] pcieport 0000:a9:10.0: DPC: containment event, status:0x2009 source:0x0000
>> [ 6327.107009] pcieport 0000:a9:10.0: DPC: unmasked uncorrectable error detected
>> [ 6327.115330] pcieport 0000:a9:10.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
>> [ 6327.127640] pcieport 0000:a9:10.0:   device [1000:c030] error status/mask=00040000/00180000
>> [ 6327.137319] pcieport 0000:a9:10.0:    [18] MalfTLP                (First)
>> [ 6327.145236] pcieport 0000:a9:10.0: AER:   TLP Header: 60000080 ab0000ff 00000001 5ad65000
>> [ 6327.154728] pcieport 0000:a9:10.0: AER: broadcast error_detected message
>> [ 6327.162624] nvme nvme1: frozen state error detected, reset controller
>> [ 6327.183979] pcieport 0000:a9:10.0: waiting 100 ms for downstream link, after activation
>> [ 6327.387969] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
>> [ 6327.395596] nvme nvme1: restart after slot reset
>> [ 6327.401313] nvme 0000:ab:00.0: restoring config space at offset 0x3c (was 0x100, writing 0x1ff)
>> [ 6327.411517] nvme 0000:ab:00.0: restoring config space at offset 0x30 (was 0x0, writing 0xe0600000)
>> [ 6327.422045] nvme 0000:ab:00.0: restoring config space at offset 0x10 (was 0x4, writing 0xe0710004)
>> [ 6327.432523] nvme 0000:ab:00.0: restoring config space at offset 0xc (was 0x0, writing 0x8)
>> [ 6327.442212] nvme 0000:ab:00.0: restoring config space at offset 0x4 (was 0x100000, writing 0x100546)
>> [ 6327.452933] pcieport 0000:a9:10.0: AER: broadcast resume message
>> [ 6327.460184] pcieport 0000:a9:10.0: AER: device recovery successful
>> [ 6327.467533] pcieport 0000:a9:10.0: EDR: DPC port successfully recovered
>> [ 6327.475367] pcieport 0000:a5:01.0: EDR: Status for 0000:a9:10.0: 0x80
>>
>>>
>>> Catching the PDC event may be timing related. pciehp ignores the link events
>>> during a DPC event, but it always reacts to PDC since it's indistinguishable
>>> from a DPC occuring in response to a surprise removal, and these slots probably
>>> don't have out-of-band presence detection.
>>
>> yeah, In-Band PD Disable bit in Slot Control register of PCIe Downstream Switch port is set to '0' , no idea about out-of-band presence detection!
> 
