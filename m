Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0776B9816
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 15:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjCNOgY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 10:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjCNOgX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 10:36:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2105.outbound.protection.outlook.com [40.107.223.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF57E90783;
        Tue, 14 Mar 2023 07:36:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBR/ZUHWrO9PAw65qns1OLe27SbjHJH8rWyq85iHNVei7iQpx9/JWWhBhei9Jn6+1oR//63ue8bSJDszkZrcwJ5L+GIGDNszmRuNW8uUkifd8Gcba+EkXQq4ILdhF7mPfj0aFA/AgLww6KdZFLoPkYc2EVzcVKdOe0Kcsv1JrkCyWC9Oybq7bjyDsgZK9HO6Ecol5gXV8wG0FaE/sHixIuaGE84sTNzI2V5lBMUW+5AG+3/QosJCE2avYF3mYOnE+bAVfN7OwzIbF7FPLvp7UmvMPakJY13U4iB9VOmAAUEh9TalVKFtgqjygNxezesvAEhYsOfPzRzAHppFpGw2Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Az4e8hmaG0ImgUW2uD3Q9tkejKdKmntXojx9906JjZk=;
 b=CJBHtzsw3q4O8DlqtNDBG0Xj8Zjn8jUNb9rGhYGxLOt0DGZRc6Tkqh8+NcvcCrCrdTu9OGRRU+iTOkRCdEtlvzhUj19yN2YC6QWRTWGwJFAWJbqiuZcz2CO1+ayWZZA2OleUT2LDYYlpUlQQxqK8GSiudf83byZfVD9Ilnsh2+P6QWW/RReezQs4elgc2IkAIimaEbTbbyKLDoHs4QC+wXWKyd0yxNstyA38zkVBtkQLXy5+RsJ5rOcuit9PrbJ16AR8tMCz1nh8wllxH12rLFE4MVSl8gUoBAJVPZr3R6SBej27bm9F1B7vOAvgbnGKOBq75Oiqra4mF0r6yWFkDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Az4e8hmaG0ImgUW2uD3Q9tkejKdKmntXojx9906JjZk=;
 b=t9M56pM6tvMTgRQ56XHd1Mwt4QDjPlpd7sNWy/05dM7xzucGq0Xz9evDAOKeniwB052uGeUygtXO0YgDMf7rao4BQmWwtNkiotq3bugJg6AFbNVj60TJjpTP2cQFCcrq7aKjwXYC60LQhDfX1eqBqwfPYaGUTZytLFnajSsbQic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 BYAPR01MB5671.prod.exchangelabs.com (2603:10b6:a03:118::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24; Tue, 14 Mar 2023 14:36:16 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a%7]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 14:36:16 +0000
Message-ID: <799c6c17-c448-387c-fea1-b5f1c5045819@os.amperecomputing.com>
Date:   Tue, 14 Mar 2023 20:06:07 +0530
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
References: <20230313211201.GA1540091@bhelgaas>
 <6339c50a-8dfe-f3a2-63d7-504abd4e62f0@linux.intel.com>
 <c7a68d5f-3b95-723f-f384-223fcbd6a877@os.amperecomputing.com>
 <646638fa-42e8-624a-068b-9c8a26ebfd98@linux.intel.com>
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <646638fa-42e8-624a-068b-9c8a26ebfd98@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:610:5a::13) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|BYAPR01MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 711e124a-8a9a-400c-3c2e-08db249977da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kA4G4kfjGYt326PfS6TXlBOwjw3SPduyCGpQC8OsDOc5lKHX8dqsx8qAeq4l+tJpS1jmzB5SkQ7y0hKmE93rTOoLZY7yjbWwXHCFDJ1kls+AVpvu8FP6KVlX0xMD+K4CWFxJ2RhDrp9lNjcpoHaH8VKUdFz5XVmWB19jhybAB+FMyeenOWBvXPB9G+vSYTai0jrmhHGUnQ7WmEe5pUXffgG9YcXoeGqKikoNWzb2CD7ErIp5XVa3ytHANq4G7QVzn2kh57uDBwYcaHpYbNU0QVVhhQZNfBNE9lynXswF5XdylutwesYV6nwR0tBFW3SKW0yD20evvyXLe3826xRX6gz/69VwIaLmxZshcGgOH86kfyiqkxKtugGbkyJt6torn43lq0OhjM//7RXP05bXJWlU86QJTHxG5MFzXVN4Ozdy18AQRKLJEk0C4K2PjKL5E9hW6w2ITF7MV/LdFX8oCw/7lPoHcjodvvZ+M5U17UFRQgTS7GMPrp3Gv+oKHDwgS3odJeYO9n3KFG0VFN/3B9cweI73Kx+C/V6Vbi0/miWx5ryH319zXaNT312Ua8htmgipuEZHTH9BY3xPAcWNLZkwI5T9W86TpwMMMLUgqaBADG1oFRUNKftPlbbo3AYCohoy204oBXcIOe4CfLqbXBzbxOsZYeeW8NrJTu2kqiDpcVMBkmhEfRTduyHdEkaO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39850400004)(136003)(366004)(376002)(451199018)(7416002)(5660300002)(83380400001)(186003)(478600001)(26005)(107886003)(2616005)(966005)(6506007)(6512007)(6666004)(53546011)(6486002)(66556008)(8676002)(38100700002)(4326008)(316002)(66476007)(8936002)(66946007)(41300700001)(31696002)(86362001)(110136005)(2906002)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WCtEMDFSS09BcHo1NElXendXVmk3M2dWUlI5VUU5NE1qV0ZqRlJvOFJGQzZC?=
 =?utf-8?B?aGs2U2RidlMwK1UxeDROQ1c1N3ZRTDh4em56MHpPMGhlKzYzVHlqUVA4OWwr?=
 =?utf-8?B?bEVNdnhTN3A1YkViOS9HME0yMHRmTjdjRVR6S24veGIrL3ZsMHFBbHdCYktH?=
 =?utf-8?B?bkVuU0lRVEkyODNUSWpIUnNia2ZyMll1cFordXhNbHZxVDZKSnJPMUlaMHpF?=
 =?utf-8?B?NURYNHJVaXhEbFAyZXR3dnJMb1VTbFpnc2JISEh5S2VmY3VUKzhBcmxEWUc3?=
 =?utf-8?B?b0F6SWc2ejVzV3I3eUkyQzBDN0ZkNThBUk4wNG9QeTg0NTgwMVhrMzByaUdn?=
 =?utf-8?B?VEU5MlNCUTZ4eG5SZ2poMXB5Uys5UjdVZlZadzQ1MkZLQXZOTkxBcytYVkNz?=
 =?utf-8?B?b2psZ1l6czJMdEZnR1dSdnIyNmJjdTQxaFEzRng1bm11ZlJJUCsvNzFSdWZM?=
 =?utf-8?B?ZzlnZmtnc2Q3d1V3aDBQU0hMSUhVZDBwNmVzMTF0WjUwY1BiTDBDRlJWYk9q?=
 =?utf-8?B?WXc5eGFZQ2xPWUxFbEYxZ3JuSDB2ZjExaFJXR0lRZEJncnFxVnFVVlVDVSs5?=
 =?utf-8?B?UmdXQWVRQXluWUFwRHhMbE43dFVxcFFQZldyTEhYWmI5c1VOKytnWlBCdllo?=
 =?utf-8?B?b0VwTW1NZ2RYbDZjN21BR0VSNFZ1WVp6NDU1QWdWWDJ0ZzNTRVJOT1Z6QzMy?=
 =?utf-8?B?eUw0MjlZampsS2lCVkhOeTIzMXVIY2IvdmdWNERrUTEzaUN5M2NYNmh0Mks3?=
 =?utf-8?B?cGwrYlFGdUhkcStLUGcwdXczNGFpZGZ3UVNrU3l1M0p3YjVTakxTOXpYSUpU?=
 =?utf-8?B?Tm1maCtPdGRESDROdzhxanVYM1BrVWlyRERpNGFWZVY4L05laE1Sa0F1UDI0?=
 =?utf-8?B?YTh6WFpPSktlNVFIb0pIZXhxL09HK1lhbVRzN2w4eFNjdEtYRnpnOXlKaWli?=
 =?utf-8?B?Q2Q1ZWpJaXdDdDlBZ3VDaktIczNNNkFBYXZzNzJoSnVoQlhQK1k1c05KaFFI?=
 =?utf-8?B?bkhRdU1XUlVPU0plV0svZHBobTlGNnQxWUp3aWZyV0NqNUlGQlZYdDVtbzI3?=
 =?utf-8?B?SGYwTFNLaXlGcEFSWTBnWjdFT2Fnc1p1SlBpQ1FFQ01COUZOQTRNeG1MOHMy?=
 =?utf-8?B?Mm5WeDhxSVlTZmlQWHBaRUVDc1c2anNIQi9sQjZOaHVVT3BaWUFONEZBSzBt?=
 =?utf-8?B?ZDBMbGZOZGpBMGcxcUFmZGI1cDU1eS9CZS9ZbFcvb0RtbnJQYXkzcmJyUDIr?=
 =?utf-8?B?WVFJd1EwOTI3TU1vekRDdlZDeWdmWEU5WXlmR0RxekZPbTJ5MTZkTERzaHZs?=
 =?utf-8?B?ZU9pRGVEMUdJQ21ZY2VxODdCSm5Zb1NVNVJKL2t0Z21FdHdkczhrL1ZRRTRp?=
 =?utf-8?B?dTAzT3RyOVVUeVY4TEwySWtNRDRKbnU3cW5maFZqcmdQdngrVklNVG9tYXda?=
 =?utf-8?B?aTJiZW9SaGFoalJjYkJ0TU5KaERxbGRvb3FsK3pYb2QzS0JUUUlBNEpWUkhw?=
 =?utf-8?B?QkdRZGNJdnpLb0JwaUc4elhSeldwenpCeHFGSGllYWd2NXFPL2p1cHV4WTA0?=
 =?utf-8?B?MHhKN3dILzN2ZGRQRHpXdG8yeFVHODVBOS9kUnpGcmxDOVBucDA2RUtVYVBa?=
 =?utf-8?B?T1NWeDRoTStxU3Vqc05SM1NoYXhtYUp4SGRLalk1cUdMdHNRT0NJY0dTSllI?=
 =?utf-8?B?OTNZSENnRnZ1N2RoTktnOHNYcmZwSW9iQmErcGxqcXV6dUNLWVBIOFJ2NENa?=
 =?utf-8?B?UnQrL1N4Mm1yNEtsZEpIelJqc0RlaDFiYXJydW5kbWxVTHVpRnpmWHNjdmJh?=
 =?utf-8?B?eHNNSnYzajVlVGlodHNVcUE2WjhSSXhSL2tpSGxsUjFjMXlIT1JTZk1xcEVH?=
 =?utf-8?B?TGMxWXdJZmQxZUUzSnQxVm0xUGdUUEZlTGRPdTBSQllnZGd5SzEvL0dLMCsr?=
 =?utf-8?B?UUVqTmoza1U5TUV4MDRodjd6OHZKUTlld2lac2FtbUM0UDhPMmgwM1RWZVJk?=
 =?utf-8?B?WEZhTTlqWjN5b3JXOEhwb0dJYk9GL24zMDc5UjhEYXM3RFZ2dnRUYlNsYjdN?=
 =?utf-8?B?aDJtNmV5VzFRVy9mQVJ1OGwxcG1wUXMzakpLdTNYT3N4elNRS2FYVWc2SzVD?=
 =?utf-8?B?ejQ3dFVUQkhtUElUaGx4VXFtRldDTllOK3Y0RlZoRFpTZVczVEJoRitBN09U?=
 =?utf-8?Q?pBZ/nWswbEAjOkDYxs6IzcNMRrKre4iw3TqNZJGgonXP?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711e124a-8a9a-400c-3c2e-08db249977da
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 14:36:16.4318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXZZN4lOUfsm2dyxUURz7Gns9N4PtB3eIr5EU4SkiX7Y/1M5+WYfAKLKlwVFhshDQGC/7z6yH+TDN0lxQJoQmLMYR+gI+yUJGIMTFS1uhti1f1x0AQmwwJPpZ5dpYRgy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5671
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi Sathyanarayanan,

On 14-03-2023 06:22 pm, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 3/14/23 3:08 AM, Ganapatrao Kulkarni wrote:
>>
>>
>> On 14-03-2023 04:00 am, Sathyanarayanan Kuppuswamy wrote:
>>> Hi Kulkarni,
>>>
>>> On 3/13/23 2:12 PM, Bjorn Helgaas wrote:
>>>> On Mon, Feb 27, 2023 at 08:21:36PM -0800, Ganapatrao Kulkarni wrote:
>>>>> As per PCI specification (PCI Express Base Specification Revision
>>>>> 6.0, Section 10.5) both PF and VFs of a PCI EP are permitted to be enabled
>>>>> independently for ATS capability, however the STU(Smallest Translation
>>>>> Unit) is shared between PF and VFs. For VFs, it is hardwired to Zero and
>>>>> the associated PF's value applies to VFs.
>>>>>
>>>>> In the current code, the STU is being configured while enabling the PF ATS.
>>>>> Hence, it is not able to enable ATS for VFs, if it is not enabled on the
>>>>> associated PF already.
>>>>>
>>>>> Adding a function pci_ats_stu_configure(), which can be called to
>>>>> configure the STU during PF enumeration.
>>>>> Latter enumerations of VFs can successfully enable ATS independently.
>>>>
>>>> s/STU(Smallest/STU (Smallest/ (add space before paren)
>>>> s/Adding a function pci_ats_stu_configure()/Add pci_ats_stu_configure()/
>>>> s/Latter/Subsequent/
>>>>
>>>> Add blank line between paragraphs (it looks like "Latter enumerations"
>>>> is intended to start a new paragraph).
>>>>
>>>>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>>>>
>>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>>>
>>>> Given an ack for the IOMMU patch, I'd be happy to merge both (and I
>>>> can do the commit log tweaks); just let me know.
>>>>
>>>> One comment/question below.
>>>>
>>>>> ---
>>>>>    drivers/pci/ats.c       | 33 +++++++++++++++++++++++++++++++--
>>>>>    include/linux/pci-ats.h |  3 +++
>>>>>    2 files changed, 34 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>>>>> index f9cc2e10b676..1611bfa1d5da 100644
>>>>> --- a/drivers/pci/ats.c
>>>>> +++ b/drivers/pci/ats.c
>>>>> @@ -46,6 +46,35 @@ bool pci_ats_supported(struct pci_dev *dev)
>>>>>    }
>>>>>    EXPORT_SYMBOL_GPL(pci_ats_supported);
>>>>>    +/**
>>>>> + * pci_ats_stu_configure - Configure STU of a PF.
>>>>> + * @dev: the PCI device
>>>>> + * @ps: the IOMMU page shift
>>>>> + *
>>>>> + * Returns 0 on success, or negative on failure.
>>>>> + */
>>>>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps)
>>>>> +{
>>>>> +    u16 ctrl;
>>>>> +
>>>>> +    if (dev->ats_enabled || dev->is_virtfn)
>>>>> +        return 0;
>>>>
>>>> I might return an error for the VF case on the assumption that it's
>>>> likely an error in the caller.  I guess one could argue that it
>>>> simplifies the caller if it doesn't have to check for PF vs VF.  But
>>>> the fact that STU is shared between PF and VFs is an important part of
>>>> understanding how ATS works, so the caller should be aware of the
>>>> distinction anyway.
>>>
>>> I have already asked this question. But let me repeat it.
>>>
>>> We don't have any checks for the PF case here. That means you can re-configure
>>> the STU as many times as you want until ATS is enabled in PF. So, if there are
>>> active VFs which uses this STU, can PF re-configure the STU at will?
>>>
>>
>> IMO, Since STU is shared, programming it multiple times is not expected from callers code do it, however we can add below check to allow to program STU once from a PF.
>>
>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>> index 1611bfa1d5da..f7bb01068e18 100644
>> --- a/drivers/pci/ats.c
>> +++ b/drivers/pci/ats.c
>> @@ -60,6 +60,10 @@ int pci_ats_stu_configure(struct pci_dev *dev, int ps)
>>          if (dev->ats_enabled || dev->is_virtfn)
>>                  return 0;
>>
>> +       /* Configured already */
>> +       if (dev->ats_stu)
>> +               return 0;
>> +
> 
> Theoretically, you can re-configure STU as long as no one is using it. Instead of this check, is
> there a way to check whether there are active VMs which enables ATS?

Yes I agree, there is no limitation on how many times you write STU 
bits, but practically it is happening while PF is enumerated.

The usage of function pci_ats_stu_configure is almost similar(subset) to
pci_enable_ats and only difference is one does ATS enable + STU program 
and another does only STU program.

IMO, I dont think, there is any need to find how many active VMs with 
attached VFs and it is not done for pci_enable_ats as well.

Also the caller has the requirement to call either pci_ats_stu_configure 
or pci_enable_ats while enumerating the PF.

> 
>>          if (!pci_ats_supported(dev))
>>                  return -EINVAL;
>>>>
>>>>> +
>>>>> +    if (!pci_ats_supported(dev))
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    if (ps < PCI_ATS_MIN_STU)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    dev->ats_stu = ps;
>>>>> +    pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, &ctrl);
>>>>> +    ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
>>>>> +    pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(pci_ats_stu_configure);
>>>>> +
>>>>>    /**
>>>>>     * pci_enable_ats - enable the ATS capability
>>>>>     * @dev: the PCI device
>>>>> @@ -68,8 +97,8 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>>>>>            return -EINVAL;
>>>>>          /*
>>>>> -     * Note that enabling ATS on a VF fails unless it's already enabled
>>>>> -     * with the same STU on the PF.
>>>>> +     * Note that enabling ATS on a VF fails unless it's already
>>>>> +     * configured with the same STU on the PF.
>>>>>         */
>>>>>        ctrl = PCI_ATS_CTRL_ENABLE;
>>>>>        if (dev->is_virtfn) {
>>>>> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
>>>>> index df54cd5b15db..7d62a92aaf23 100644
>>>>> --- a/include/linux/pci-ats.h
>>>>> +++ b/include/linux/pci-ats.h
>>>>> @@ -8,6 +8,7 @@
>>>>>    /* Address Translation Service */
>>>>>    bool pci_ats_supported(struct pci_dev *dev);
>>>>>    int pci_enable_ats(struct pci_dev *dev, int ps);
>>>>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps);
>>>>>    void pci_disable_ats(struct pci_dev *dev);
>>>>>    int pci_ats_queue_depth(struct pci_dev *dev);
>>>>>    int pci_ats_page_aligned(struct pci_dev *dev);
>>>>> @@ -16,6 +17,8 @@ static inline bool pci_ats_supported(struct pci_dev *d)
>>>>>    { return false; }
>>>>>    static inline int pci_enable_ats(struct pci_dev *d, int ps)
>>>>>    { return -ENODEV; }
>>>>> +static inline int pci_ats_stu_configure(struct pci_dev *d, int ps)
>>>>> +{ return -ENODEV; }
>>>>>    static inline void pci_disable_ats(struct pci_dev *d) { }
>>>>>    static inline int pci_ats_queue_depth(struct pci_dev *d)
>>>>>    { return -ENODEV; }
>>>>> -- 
>>>>> 2.38.1
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> linux-arm-kernel mailing list
>>>>> linux-arm-kernel@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>
>> Thanks,
>> Ganapat
>>
> 
Thanks,
Ganapat

