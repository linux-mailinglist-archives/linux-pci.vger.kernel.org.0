Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA74C6BB607
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 15:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjCOOay (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 10:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjCOOax (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 10:30:53 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2135.outbound.protection.outlook.com [40.107.102.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A3E311D5;
        Wed, 15 Mar 2023 07:30:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8jCySBjiyCsEe+Vv8yH3TY0jXIxe+rgZjuJptOZzEqYYDfWmqsoemknfhZTzK4E/khaW+dF0uGAhXgC/k9YO0hbHQ+MSahcSwwDB51MNuiGAfYlpaXQ/E1+GaLF3FYtJ1FdvrqN0DsWL/x1kLDoJvoajsW6Kbp1/t2GezHjS+tFCcvnUWKtBzMsTvL45UCgJ8hv7Y/dCwV/HfNfikm2LaGTFMtF3VZ6WBJqiRSmnVC93PLD0e9SkQGSSaBHBlxqH+JkaUi5L5zjad2o67qzPcLxzMTUSgfd9fKeapcbTvGp3ImhiDh9dZ8Rq9DASsGjkZFXnFKbe5xwA4Wp1yvIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSHnYNRKn7aGBnGLqa5BPx8bn9e2JKaWb6/dq3MoM6Y=;
 b=jskBUTpqaVxxF/Kt0fHNg7MIOTkuDnqzCUZRDr3SGpRwV+Q0Wb/LsTuVNP3BhoWjjFthkoNLyJk1o6W8sx1nhjj2FXUGo71e8rELv58THn6XBJVNTQXEEwMMDpvEa1YVFuAAKYGsprUE+Vge+WdAtN4h8/U07zARS925DV8RFUQ3YxXTmgE7un0sc+JlKsVOcpIH/JPBmTDKKjnGQdpmQ2Ha0KTGf0Jfs3y6xhRBi/m8zLFl9IfRpyLrBMz6F93TtzxTC6IVB5siLqyezBIWaeq+3RuE8u8OPwld1Xepqjp0nqp6J1KacoO+b7IaySnm7cq4lAefqP8jr4rbuqmu7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSHnYNRKn7aGBnGLqa5BPx8bn9e2JKaWb6/dq3MoM6Y=;
 b=api1OQNgs/BdB/Ht3O8q31ZaYNmHHJQ9kJg3AroD+bDD+wmgPlpnd3TpFZykk/yuwxiajajyclpd5QyFvb2+5mDZbgAgrdQLuw1dNQiWwABO0lH5Yse+QcnM/+UycHk5jwPSwHvRB0+EMVKfih0L6CYzBB/38RpYbQxYROxG01s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 DM5PR01MB2763.prod.exchangelabs.com (2603:10b6:3:fa::20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.29; Wed, 15 Mar 2023 14:30:20 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a%8]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 14:30:20 +0000
Message-ID: <4a089101-eb5d-f6df-992c-0b1711dda878@os.amperecomputing.com>
Date:   Wed, 15 Mar 2023 20:00:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] PCI/ATS: Add a helper function to configure ATS
 STU of a PF
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org, jean-philippe@linaro.org,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com
References: <20230314171046.GA1655423@bhelgaas>
 <63619dd6-8e59-89f1-8e3a-766ed9501f1d@linux.intel.com>
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <63619dd6-8e59-89f1-8e3a-766ed9501f1d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0037.namprd14.prod.outlook.com
 (2603:10b6:610:56::17) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|DM5PR01MB2763:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad834b7-5ab1-4937-28be-08db2561ce26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2LyClq1hYK6Tvku0KJKFGEepwo/JgYeq30+on5v9JbMA0GKcf6davshmlw2oIG1iDlQHVfEugVJxq1oG028iefWMuQZ7+5EsYHeR9nsTkVRkKvwV7w++h0xMjWY6dfWHksohiENBLBz3sRXVWucdloEcsQBi2jbd0UScOiArNyAGz0uQSrKolbOUlaqFROcETL0akKcdupD8rz+WTOZDNmdlccd3CLufB97G0Opnb/1WMt/mprb8Vv1VcLyIrg1X2HUgDe6N7xA+KjOOqcmDVFSxP5Mt35J7cc6UaEnR2G3bqAHVp1u6AcIsNUeNhCn4hJekHdZ2IIOqg0v/FXMhCG1ZtmblLobH9bRg8cTZF4n979A4Y8whaLDgYVVv9y5ee/v/cKEPnVK7BfOwlliHB79oFykNrg2LCJ1lUaa3/rUP8Xf2qGPPkEC/l4U4ij5CGnkY7/aV6PZqdm/+zpBztQUwa6uL4KYVy+7zHfYwLHVJpP5cIekhtO3GW5WTcWr+Kvu91VE+kSs/4cC0KjqnU1Izrga2qCfWTgL8NSZS5ivMAgPMRA/i+A8DxiYwuvrEkLKokM4tLBCPv9EtV4wTwJXNtqyjGZVGJeHockJJNy9v96tCzTeXVhFtGowmIM1cLTyLY1P2okBf2upeVh3kGDUkrPIQTbtxKb7QFVqf+l/D1Mk+GPcjyNvCQCRm9rOD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(136003)(376002)(39850400004)(346002)(451199018)(2906002)(7416002)(5660300002)(2616005)(186003)(83380400001)(478600001)(53546011)(107886003)(6666004)(6512007)(6506007)(26005)(6486002)(966005)(66476007)(66556008)(66946007)(86362001)(31696002)(41300700001)(8936002)(8676002)(4326008)(110136005)(316002)(38100700002)(66899018)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEE2cGVHM2V4bFdrbldpNTQ4cjZnWkJtd0pQbmNPMk1YNG80UnJxSzhGMXVE?=
 =?utf-8?B?UHBJRmdSZ2N1azJBZkdRczRQY0t4dGl5dVdrZStXY284eFh0L050anlTSnBl?=
 =?utf-8?B?NjRQU3NRSVNWcDNWQzNuOUYydzZXc1hnVTU0Ulp3MzBNM2d5a2JtRTRzWExM?=
 =?utf-8?B?KzZoVTdYck5hTTJQa0VGQ0psZlRJMDFyd3VEY205Z1NOQnEzK09WYUE5NzJT?=
 =?utf-8?B?cm9CY1M4QXVoUmpON0xMNFI0QVUwR1RCa3kzbkVNWURUZE8zcEVDMTM1N1lm?=
 =?utf-8?B?aEtXa3RtaU9tTlRHZmhoODU3YmlkOExlSVE1N1ZQcStVRk82Y2xhOW1zbTNV?=
 =?utf-8?B?M0tlN1ozOE81a1dQQW5HZUNITTdHYlprUFZwRG9uMy96enUyWTJjM0hUK3F1?=
 =?utf-8?B?cWNsK1oyRDBjeEwxbVR6c25RV1E5eGp0NVVSbGVEVkZXUSt2Q1I5Z3I3MUdC?=
 =?utf-8?B?K0o4RUxxMi9wNW50bTBoT1M5VUtzRnYvQ2NJaXZoWUJ1eVp2ZlBBVkluRlc0?=
 =?utf-8?B?V1ZzK05GZlY5TUtZQTFQVHJOdlcwZUcrSUEwTHRjaEV1K3dQNkp4Uzd1UC9y?=
 =?utf-8?B?SG0rNlNtUUJaMmN1aVZJc0FhazcxajBPM0tWT0N3Qm4zUjdMaXRKUERxSWdG?=
 =?utf-8?B?ZnNlVXN2VFUwOWdlekNlUEpKUHFSL3pYSldCV3BJSElXRWdwZmNSMGFMbUk3?=
 =?utf-8?B?YmFSZy9jbDFqUXM5RG5yZ3l1QkhnM2pVWHNsTEd1VDRxRzZUcFpvbnBWZTJW?=
 =?utf-8?B?ZVNaenpYTDZCSTBXNWhjRmhUOUdDRTNaV0ZqSklXT0d2MEtXK1UzVnhJNWpK?=
 =?utf-8?B?RFNHZS82UFhuMkx6cmhWUTM0SzJXWGs3QnRIaUd3NGt5UDZiZk5WOVpVNm9P?=
 =?utf-8?B?K253YXozdG42bzdITjJGN2d0VHg4b3ByY0E4VmZtbDFkRENORVdERU9SVW16?=
 =?utf-8?B?MXhxRkptOU01ajhLbXYzeThZeml1TExzc1lmb1ZkMVR1dlBPTjdDNmlBKzFv?=
 =?utf-8?B?VjE4djlkWGtYNCtQa1MrK2lEQWFyM1cwRGw3UUl4dFVlVnBTaEFCalNuOGgz?=
 =?utf-8?B?UkxzeGZhVDhoc3FMazhBZjlSZTkyalpmKzBCS3NYT2JHbVlTait2MUFlRENW?=
 =?utf-8?B?OUlDMm43dWlQUzQ4Q0t0Rlk0a3gyTk55VU52MDJaL2ZDcGo3WkkveWd0VGJh?=
 =?utf-8?B?ZnZrQWdNV0M5TnRoOUxtbk1RMUdJVWtHdlhHMW1VM2lCYlBSWlVkZDhSN0tX?=
 =?utf-8?B?WXptRlZGRUt4aXcxVFFrSWkxN1VvazZZMUZ5QWJMQkVIcWRlNjZKTk1mK2Rl?=
 =?utf-8?B?UnZXdUVseXJHWjNLb3FLSVpIcEJPZzQ4QkV1SGUrR1lPTzgzYkFxMUFveFRH?=
 =?utf-8?B?Z2NHSWo5MXpFYVNDNWVzTkhLRTUrb05xTEZzL0VsYmdhWXRYYnc1NzNqWndy?=
 =?utf-8?B?QzRiV1JVaDJsaUw2Z2M1THBUdEtEanFYOUQvNDBFd3RzRVVmUEF4OEdSNzFY?=
 =?utf-8?B?KzJBRHlFNFZUVmkvWVN4NjljYUlKandhTnE2TEdKTVliVXkvbTUwdWovUk01?=
 =?utf-8?B?NDg3bVVYWkNNRlRZM2RPQ1JDTzVwMWFLdzYwQkJscTkvNG56YTI5ZkFNRHc4?=
 =?utf-8?B?cW1MNEJMQlBHbHNBZDRXamd6RkZTeS9RWmpQQ1BmZ2dsUEE1U3Z1U0FDaVp4?=
 =?utf-8?B?a2RXZk1ZT0dJcjdESnU1YXpKZzFlWGJyQ1RTZGxJRi9iTk9hSWt4eXFXbnN5?=
 =?utf-8?B?dEw4d3piWnFkRDZQVEJ3eCtyWjRJazlVcld1eWFGWGxLWGcxQ3ZlTzRXa3l5?=
 =?utf-8?B?TVBkakZraVlrS3NLOEZBMk8wc25EMm1nSml5S0ZYd09rQ3FpYndLa29jSkdr?=
 =?utf-8?B?Tlo0TzFhU0tlT1ZFbWtyMGRUelc2Z0s2RzVpKzJyT1lQM2xwUzVxT3JQeUNj?=
 =?utf-8?B?a29oN25aQTdsbjd2QklQKzRHZ1JRL01MU3JDU3d5aFJmVnlYV25pMFVnRThN?=
 =?utf-8?B?M2dacVBsWTZ5S0IvSjJnVjUva25QaXlrZG1zelJ0eFN0K1RmRHl4UE1JOC9K?=
 =?utf-8?B?VjVTbmhiUEdpUSs1WVJ2Y3RwWCtvMkJLeW95Wnk4QkNpa0RXZUNETnI3aUJE?=
 =?utf-8?B?bzRGc1dxN1FqVTdpSUlZVFJWK2hxL2YvQTJxNHMvbG82VE10Q3FFNVBITWl2?=
 =?utf-8?Q?BoEJEeK5ZaOY1dVUHd4Tt9JFcnNppsp158IArJ0zXDhb?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad834b7-5ab1-4937-28be-08db2561ce26
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 14:30:20.5282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bX1vGU0SlDydZl9HUdwqwoBLjqMNcPJQ+UGVGT4lTvQecNuTSR0FzUb4QyBZcMRP2QjKJAYGq0sGpWVW93HhgjbyCHWH4kw4XBriTdr9wxxdACc6PUq24VGg0K6IZYLk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR01MB2763
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 14-03-2023 11:42 pm, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 3/14/23 10:10 AM, Bjorn Helgaas wrote:
>> On Tue, Mar 14, 2023 at 09:50:06AM -0700, Sathyanarayanan Kuppuswamy wrote:
>>> On 3/14/23 9:02 AM, Bjorn Helgaas wrote:
>>>> On Tue, Mar 14, 2023 at 08:06:07PM +0530, Ganapatrao Kulkarni wrote:
>>>>> On 14-03-2023 06:22 pm, Sathyanarayanan Kuppuswamy wrote:
>>>>>> On 3/14/23 3:08 AM, Ganapatrao Kulkarni wrote:
>>>>>>> On 14-03-2023 04:00 am, Sathyanarayanan Kuppuswamy wrote:
>>>>>>>> On 3/13/23 2:12 PM, Bjorn Helgaas wrote:
>>>>>>>>> On Mon, Feb 27, 2023 at 08:21:36PM -0800, Ganapatrao Kulkarni wrote:
>>>>>>>>>> As per PCI specification (PCI Express Base Specification
>>>>>>>>>> Revision 6.0, Section 10.5) both PF and VFs of a PCI EP
>>>>>>>>>> are permitted to be enabled independently for ATS
>>>>>>>>>> capability, however the STU(Smallest Translation Unit) is
>>>>>>>>>> shared between PF and VFs. For VFs, it is hardwired to
>>>>>>>>>> Zero and the associated PF's value applies to VFs.
>>>>>>>>>>
>>>>>>>>>> In the current code, the STU is being configured while
>>>>>>>>>> enabling the PF ATS.  Hence, it is not able to enable ATS
>>>>>>>>>> for VFs, if it is not enabled on the associated PF
>>>>>>>>>> already.
>>>>>>>>>>
>>>>>>>>>> Adding a function pci_ats_stu_configure(), which can be
>>>>>>>>>> called to configure the STU during PF enumeration.  Latter
>>>>>>>>>> enumerations of VFs can successfully enable ATS
>>>>>>>>>> independently.
>>>>
>>>>>>>>>> @@ -46,6 +46,35 @@ bool pci_ats_supported(struct pci_dev *dev)
>>>>>>>>>>     }
>>>>>>>>>>     EXPORT_SYMBOL_GPL(pci_ats_supported);
>>>>>>>>>>     +/**
>>>>>>>>>> + * pci_ats_stu_configure - Configure STU of a PF.
>>>>>>>>>> + * @dev: the PCI device
>>>>>>>>>> + * @ps: the IOMMU page shift
>>>>>>>>>> + *
>>>>>>>>>> + * Returns 0 on success, or negative on failure.
>>>>>>>>>> + */
>>>>>>>>>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps)
>>>>>>>>>> +{
>>>>>>>>>> +    u16 ctrl;
>>>>>>>>>> +
>>>>>>>>>> +    if (dev->ats_enabled || dev->is_virtfn)
>>>>>>>>>> +        return 0;
>>>>>>>>>
>>>>>>>>> I might return an error for the VF case on the assumption
>>>>>>>>> that it's likely an error in the caller.  I guess one could
>>>>>>>>> argue that it simplifies the caller if it doesn't have to
>>>>>>>>> check for PF vs VF.  But the fact that STU is shared between
>>>>>>>>> PF and VFs is an important part of understanding how ATS
>>>>>>>>> works, so the caller should be aware of the distinction
>>>>>>>>> anyway.
>>>>>>>>
>>>>>>>> I have already asked this question. But let me repeat it.
>>>>>>>>
>>>>>>>> We don't have any checks for the PF case here. That means you
>>>>>>>> can re-configure the STU as many times as you want until ATS
>>>>>>>> is enabled in PF. So, if there are active VFs which uses this
>>>>>>>> STU, can PF re-configure the STU at will?
>>>>>>>
>>>>>>> IMO, Since STU is shared, programming it multiple times is not expected from callers code do it, however we can add below check to allow to program STU once from a PF.
>>>>>>>
>>>>>>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>>>>>>> index 1611bfa1d5da..f7bb01068e18 100644
>>>>>>> --- a/drivers/pci/ats.c
>>>>>>> +++ b/drivers/pci/ats.c
>>>>>>> @@ -60,6 +60,10 @@ int pci_ats_stu_configure(struct pci_dev *dev, int ps)
>>>>>>>           if (dev->ats_enabled || dev->is_virtfn)
>>>>>>>                   return 0;
>>>>>>>
>>>>>>> +       /* Configured already */
>>>>>>> +       if (dev->ats_stu)
>>>>>>> +               return 0;
>>>>>>
>>>>>> Theoretically, you can re-configure STU as long as no one is using
>>>>>> it. Instead of this check, is there a way to check whether there
>>>>>> are active VMs which enables ATS?
>>>>>
>>>>> Yes I agree, there is no limitation on how many times you write STU
>>>>> bits, but practically it is happening while PF is enumerated.
>>>>>
>>>>> The usage of function pci_ats_stu_configure is almost
>>>>> similar(subset) to pci_enable_ats and only difference is one does
>>>>> ATS enable + STU program and another does only STU program.
>>>>
>>>> What would you think of removing the STU update feature from
>>>> pci_enable_ats() so it always fails if pci_ats_stu_configure() has not
>>>> been called, even when called on the PF, e.g.,
>>>>
>>>>    if (ps != pci_physfn(dev)->ats_stu)
>>>>      return -EINVAL;
>>>
>>> If we are removing the STU update from pci_enable_ats(), why
>>> even allow passing "ps (page shift)" parameter? IMO, we can assume that
>>> for STU reconfigure, users will call pci_ats_stu_configure().
>>
>> The reason to pass "ps" would be to verify that the STU the caller
>> plans to use matches the actual STU.
> 
> Do we really need to verify it? My thinking is, by introducing
> pci_ats_stu_configure() we are already trying to decouple the STU config
> from pci_enable_ats(). So why again check for it when enabling ATS?

AFAIK, we are not decoupling STU from pci_enable_ats, there is a case 
where ATS is not enabled on PF (host kernel booted in passthrough) where 
as ATS gets enabled on VF while it is attached to a VM(through vfio 
driver). In such case, during PF enumeration, pci_ats_stu_configure is 
called to program STU and allow ATS to be enabled on VFs.

In normal case, PF enables ATS and STU is programmed and no issue while 
enabling the VFs.

> 
>>
>>> Since zero is a valid STU, enabling ATS can be decoupled from STU
>>> update.
>>>
>>>>    pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, &ctrl);
>>>>    ctrl |= PCI_ATS_CTRL_ENABLE;
>>>>    pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
>>>>
>>>> Would probably also have to set "dev->ats_stu = 0" in
>>>> pci_disable_ats() to allow the possibility of calling
>>>> pci_ats_stu_configure() again.
>>>>
>>>>> IMO, I dont think, there is any need to find how many active VMs
>>>>> with attached VFs and it is not done for pci_enable_ats as well.
>>>>
>>>> Enabling or disabling ATS in a PF or VF has no effect on other
>>>> functions.
>>>>
>>>> But changing STU while a VF has ATS enabled would definitely break any
>>>> user of that VF, so if it's practical to verify that no VFs have ATS
>>>> enabled, I think we should.
>>>
>>> I also think it is better to check for a ats_enabled status of VF before
>>> configuring the STU.
>>>
>>> May be something like below (untested),
>>>
>>> static int is_ats_enabled_in_vf(struct pci_dev *dev)
>>> {
>>>          struct pci_sriov *iov = dev->sriov;
>>>          struct pci_dev *vdev;
>>>
>>>          if (dev->is_virtfn)
>>>                  return -EINVAL;
>>>
>>>          for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
>>>                  vdev = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus),
>>>                                               pci_iov_virtfn_bus(dev, i),
>>>                                               pci_iov_virtfn_devfn(dev, i));
>>
>> I would try hard to avoid pci_get_domain_bus_and_slot().  That's
>> expensive (searches *all* PCI devs with for_each_pci_dev()) and
>> requires dealing with reference counts.
>>
>> Maybe an atomic count in the PF of VFs with ATS enabled.
>>
>>>                  if (vdev && vdev->ats_enabled)
>>>                          return 1;
>>>          }
>>>
>>>          return 0;
>>>
>>> }
>>>
>>> int pci_ats_stu_configure(struct pci_dev *dev, int ps)
>>> {
>>> ...
>>> if (is_ats_enabled_in_vf(dev))
>>>     return -EBUSY;
>>>
>>>>
>>>>> Also the caller has the requirement to call either
>>>>> pci_ats_stu_configure or pci_enable_ats while enumerating the PF.
>>>>>
>>>>>>>           if (!pci_ats_supported(dev))
>>>>>>>                   return -EINVAL;
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +    if (!pci_ats_supported(dev))
>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>> +
>>>>>>>>>> +    if (ps < PCI_ATS_MIN_STU)
>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>> +
>>>>>>>>>> +    dev->ats_stu = ps;
>>>>>>>>>> +    pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, &ctrl);
>>>>>>>>>> +    ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
>>>>>>>>>> +    pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
>>>>>>>>>> +
>>>>>>>>>> +    return 0;
>>>>>>>>>> +}
>>>>>>>>>> +EXPORT_SYMBOL_GPL(pci_ats_stu_configure);
>>>>>>>>>> +
>>>>>>>>>>     /**
>>>>>>>>>>      * pci_enable_ats - enable the ATS capability
>>>>>>>>>>      * @dev: the PCI device
>>>>>>>>>> @@ -68,8 +97,8 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>>>>>>>>>>             return -EINVAL;
>>>>>>>>>>           /*
>>>>>>>>>> -     * Note that enabling ATS on a VF fails unless it's already enabled
>>>>>>>>>> -     * with the same STU on the PF.
>>>>>>>>>> +     * Note that enabling ATS on a VF fails unless it's already
>>>>>>>>>> +     * configured with the same STU on the PF.
>>>>>>>>>>          */
>>>>>>>>>>         ctrl = PCI_ATS_CTRL_ENABLE;
>>>>>>>>>>         if (dev->is_virtfn) {
>>>>>>>>>> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
>>>>>>>>>> index df54cd5b15db..7d62a92aaf23 100644
>>>>>>>>>> --- a/include/linux/pci-ats.h
>>>>>>>>>> +++ b/include/linux/pci-ats.h
>>>>>>>>>> @@ -8,6 +8,7 @@
>>>>>>>>>>     /* Address Translation Service */
>>>>>>>>>>     bool pci_ats_supported(struct pci_dev *dev);
>>>>>>>>>>     int pci_enable_ats(struct pci_dev *dev, int ps);
>>>>>>>>>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps);
>>>>>>>>>>     void pci_disable_ats(struct pci_dev *dev);
>>>>>>>>>>     int pci_ats_queue_depth(struct pci_dev *dev);
>>>>>>>>>>     int pci_ats_page_aligned(struct pci_dev *dev);
>>>>>>>>>> @@ -16,6 +17,8 @@ static inline bool pci_ats_supported(struct pci_dev *d)
>>>>>>>>>>     { return false; }
>>>>>>>>>>     static inline int pci_enable_ats(struct pci_dev *d, int ps)
>>>>>>>>>>     { return -ENODEV; }
>>>>>>>>>> +static inline int pci_ats_stu_configure(struct pci_dev *d, int ps)
>>>>>>>>>> +{ return -ENODEV; }
>>>>>>>>>>     static inline void pci_disable_ats(struct pci_dev *d) { }
>>>>>>>>>>     static inline int pci_ats_queue_depth(struct pci_dev *d)
>>>>>>>>>>     { return -ENODEV; }
>>>
>>> -- 
>>> Sathyanarayanan Kuppuswamy
>>> Linux Kernel Developer
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

Thanks,
Ganapat
