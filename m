Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0756B9DC6
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 19:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCNSCG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 14:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCNSCF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 14:02:05 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2121.outbound.protection.outlook.com [40.107.100.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54558A7AAF;
        Tue, 14 Mar 2023 11:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jh1Pp0MYcSmPQ11aK3meuJEveO428KEjsHg1eg/0qGG0CGzQRE297viiw1rqOJj5Zj1yutU9EtPwo1xshS+L4yGqOWoPs6yTVo4VZQj9wBOKRVASsN1vENSx9WW00eqiOsw7AEYZj0SdolMRuCi/4MNSn9PL6npnyrmjwnHZZGdy33zImqlyU7NnZq2SlHtBGLnnrjoYhT/f+pGAYubym1Xpvbvv4IdU5hduoLZC+R7WuFDXK06aYFjeuLCTDV5MFtuKenIRHfRobqjrWwOkJ6oAQ8hJbJuZQG/f6GcvFYsNBM/S8pTZVpxrg0n8dpOuOhsXTD1loare5q5x+Vk9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVcDHPN40voJ/U3Otyqa/Ej+8VLqjWLQEoV0YXAMddM=;
 b=f2CtRPqSvhL7gUplfvnM6PZdtIS6GkTkTB4xs4JmN1SKl9dwPz9yIiIbu6PE7s+7Xyt6X5zmQDiQPusqdX4QLxVa+w5jkYlNsVwKKYddqF6c7eAUS2K5efeO4Ro0CVJctRQEJo1mqptI/dGsWgc9RcIjI6uisVhTo+SudN6E2PqA3pImhpqSbtbkiPcRcbCNldroS9AuJMnozu6r+AEEtxjk8xfqCwTqlND+ZKxRd4xlDd1LeN8QdBd+tDvE+BgSV1tMEITOKSEZ5jTr2cvbi01rDXQzJ0/PeoNwO+1raGN+A2Q46f+lo4nJVU8nZUQyP8V7QbRkSMyheOO+cwQymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVcDHPN40voJ/U3Otyqa/Ej+8VLqjWLQEoV0YXAMddM=;
 b=EvOiOW70HlOOMd5pSzt/iTpSGi3K0ejNORSVg6qyOVoPlGaY4GzLuKpbVxNlAws97ybhpHwYhR82zk2FS04VtOjelJpX4449iLAHKe0BaeoadCpCM/jyqB/nLxd0SZElyVOUlRpWlSaX724vbYFFUGm22lvxzG9rZv7gLe2BY6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 BN6PR0101MB3028.prod.exchangelabs.com (2603:10b6:405:31::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24; Tue, 14 Mar 2023 18:01:57 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a%7]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 18:01:56 +0000
Message-ID: <43a25b72-f63c-63b3-d483-fd553af91aee@os.amperecomputing.com>
Date:   Tue, 14 Mar 2023 23:31:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] PCI/ATS: Add a helper function to configure ATS
 STU of a PF
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org, jean-philippe@linaro.org,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com
References: <20230314171046.GA1655423@bhelgaas>
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <20230314171046.GA1655423@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0040.namprd13.prod.outlook.com
 (2603:10b6:610:b2::15) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|BN6PR0101MB3028:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1ba596-f7f6-470f-10e0-08db24b63347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZoGm1ybx3Lq4tieyOyfj1zDhasuw0HID0IJMeSHuzJmfGwFL8dkzXTs5fZGXT20zquMpFaIWMOM54dOT9iichmNJJ3Fs0l4AKZi6IS11Nr0WRj41mItvhLGRRyDEkyOQ0xxyuA7/Sbe10pLBmDzJ6me2DYiIzUmLDaJaUV4gKYqwtcm4lgEOH8b10o/3XOmmiFHEgMt2Xfqm1wu8cYUbOGzgPhyTmnD3vgebtIJPVCs+/CkRaEnY/T/MqSbe+AclCO0ZuvIE97D1L4JvErIla/I583z7FGi5ISHGTGLf/iNuSR9iyvnsUprEFdHmb0JYCeFmGLnWuCbuzYASNF14vcWPwkjbwEH8myxi1YaThn5FdhkE/PGl7Pm16aFwuo7nBL54slghJXNtHR2XcmuDtmn+rc9sHzCOCv9s4ihidH4ZbSHTECpWZqUhOl0348wJWpBPr/4nLKPVh56atYj/sywWXu+WWj6gWhPs6wOFOMWpa+vGCieO9DHf5lhI5x2ebwPB2kYnCk7hkjFyMc2AGfjzNg6oPvMqPtIqzFL4rmB/07uwoIzUkkMCEz9OCmSILbxtCKs3pB7Cumtmq0ulSilHdgN/OxOpT/XE+QA6usi7At9qDi2xLNOLeGjbCpOBOxgQdhYDFKO1FmteF3NUrrVrilwTvIgulUWs/9ka7hPNz1LcP0ehQIC8VwRDdPY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39850400004)(346002)(376002)(366004)(451199018)(31696002)(7416002)(6486002)(66946007)(66556008)(8676002)(4326008)(41300700001)(5660300002)(83380400001)(186003)(966005)(66476007)(8936002)(6666004)(6506007)(316002)(53546011)(6512007)(2616005)(107886003)(478600001)(110136005)(26005)(86362001)(2906002)(38100700002)(66899018)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blAraFIrUDVmNGJ6V2VFUXV4M1QySjZ6eUFzd2pHcWpNYmVSbUlGVllhTzA5?=
 =?utf-8?B?cmNwL1JlblJidnBvdG91ODhnV3ZnK29MUDg3M1pvcFdqUytLZGhQNGNWa091?=
 =?utf-8?B?M1djTjJoYTIvRVlSUlQvdmJpNGRsd2RMVzhRZnA1aXZNZnl6eCtUUG0vdFZI?=
 =?utf-8?B?SVZyaTJMdS9Tb3Uxb0EySG43Tnk4dDlIOVdoa1VEOXlDY08xOUVOeVkvQmsx?=
 =?utf-8?B?bXBrQWZPLzJaZW1id2V1MEN4bGFHKzA4cmUyZFNhNkJLWEptMERxRGJzYVMx?=
 =?utf-8?B?anFEVkwxYWR1ejlmbzNta3ozeFhMcXF6VXJucHJzWHpnOVFXZzdvaHZMNWN5?=
 =?utf-8?B?eTI5SFZlbzR3MXFLOWQycmNLck9ML1lXZ2ZUWnYzTDZqTDI3WjhjVlJrOURV?=
 =?utf-8?B?SldmSkFBeWVxSS9rVWZ6RlprY2ZMWVp2TVpmcktncWYrN2VvRFArTTlPVlc5?=
 =?utf-8?B?ZG40b0NmR3dlNWtPTWhjem9JeWYvY2wzdXRxcmQvb2NXdm1SQ0Y3ekxIWEpr?=
 =?utf-8?B?aFNReEpCSWhYaStmZ1libE1xcERCamlMWUNJd1BFbGVOaGxvcC9jNGI4bjNo?=
 =?utf-8?B?NUNQY0hMZlJIcEpkV2hJRW9QTk03cmIxZmVBdE5wRHFiY2lyeTJNK1lKNWNQ?=
 =?utf-8?B?enN1WURDaUdLNzhrU0F4QkxEY3VkK0NneGZRb1pZeUQreDNmOW1TS1g3WXEr?=
 =?utf-8?B?Rm44WEk0OEpSb0xYWFpKS3JXWUlPcEFNcjhKWjc4akFxK0hIeUFwdHJvR1Ra?=
 =?utf-8?B?VVFnT3B1VlBnNWpPZ1VtblpiZ3VxcjFEN0NtZzNIeWU2aS9hUGxmN1RMRjd3?=
 =?utf-8?B?eU15b3RLYWE5Qk95QnBOVDVJaDZtdnFLdFlkaENYcHFCOUx1ZkF1K0tqRG5N?=
 =?utf-8?B?aUZ3RVR3MGtiZzBtYStBYi9lVWRuc2RKdEZ1SFduaHhyTUp3ampwWldHWS9l?=
 =?utf-8?B?Y2k4UVhoOHpoZnJMTEsrUGswR2xPZlNYTjBRT2NwdzFWRVYvUmJlT1FtV09N?=
 =?utf-8?B?Sys1VGF3aGFXd01GNVRiNFczLzdsdTRMQ1JwU0w4aGFJUm1TcVlxQ2I0aVlq?=
 =?utf-8?B?S1kyTC9hYTdLTzJZRzlSM2E4V1puNW5GWEhndCtzSWlMbnhXcXd6cXJJWXUv?=
 =?utf-8?B?Q2VTY2pXWHI3ZitNUTBLVmNMQlAzT3Bac3dBUWp1U1VseTMzM1dBZ01taVJo?=
 =?utf-8?B?M0R0cVlvZEhXV1loaGJmU243bVVKeVRWRi8vMmkxbXUxNEt4VEFINEVoSmhp?=
 =?utf-8?B?RE1nQ3IrSWQzS3VmNXpVNXkwZ2VIWHgrVXVLN2xTbXo3ajhVcVc1KzNySk5v?=
 =?utf-8?B?Y3lrcXBLZnFUWjNiM09TaFYxZW1HU3F0U0t6WitwWDlBbk9CcjcweEJ3ZHo4?=
 =?utf-8?B?VDNkQ2swZTFZeEorUkZOblcveXhnNkdSbVl0WVFnQUhMOGJsK0x2bU9IYVBr?=
 =?utf-8?B?andieUVSNG1Xcm9qRG5IcjVjNDc5bkw0ek1Pa0ZBRkZONDZmNUk3MW9vK0tK?=
 =?utf-8?B?YjRmMDhuOE1VNlhNZncyT0hLR3JWTkhKbVR6OW52Zk4xYXdsRm51a1JEVFBq?=
 =?utf-8?B?SGVSaVRaRmZkcjFJWVVQakxGNWhvU0FqY3k2ZnlTVStrTE8xU282TWVxclFJ?=
 =?utf-8?B?KzVoUFd5emJXMVpzTmQwdkdlYUswYnVVUk5iU0RwODB6TFVYWkhJdlFWMmE4?=
 =?utf-8?B?U0krVGpLdGNxWEYxZWVldnlDN002ZXJBMXI0d3c3Z1FWYUtEUDlQN0FZK01C?=
 =?utf-8?B?MThIay9MVUpseTNuQVpwZDR4dVdRMTE2RkNMMkc5Ry85dGhzZm1JREFtZmx4?=
 =?utf-8?B?OVhQNzJJUFAwdkJmUjJCVHlCanlDSmZyRTRpWnVRN2pKWWdkeVZpSlpnckRW?=
 =?utf-8?B?RlBzNzMyUHZpTjY2Z0dEUXNuSnNBN0g2c2hwc1dpVFhNbUkrMWJ5OENCY1pH?=
 =?utf-8?B?Y2lhMmxkRXZsQ2hWazEyOEd4MTJnakZRdllrRzZGMk5VS0JPTFpxNTBiam9r?=
 =?utf-8?B?aktSVnJPOTFSaS84Z2xHTlorYnplZDZYSmFDdVZCeDJJWXFKRUJHNndHem1q?=
 =?utf-8?B?OHd1Tm90cnJXNGozSU9CaUtpNmd5b1BHYS92cnhFK3pGc0lvb3FkUjRsTjdO?=
 =?utf-8?B?Sk9SbDA4dkF5enMzNWJmbkpWT0pKWkJuMkFPNEJWaEFSV040eWdxTTJYVkxp?=
 =?utf-8?Q?MSWVyQyM94rPUURfnfQgMWNqokzaaRSA5r92vthhWhOn?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1ba596-f7f6-470f-10e0-08db24b63347
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 18:01:56.7718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBN4SkdTrdrQszgUBEjsTWUqv+DGDVEglDli5BCMsp/HKa1bcX516hMY6J1RA23q9/fKGPNpyaIYHDzJu2B7At4yXK2q8rDcWayejPFrsP7P0DkzKp6OHThWCRW5G0kE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR0101MB3028
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 14-03-2023 10:40 pm, Bjorn Helgaas wrote:
> On Tue, Mar 14, 2023 at 09:50:06AM -0700, Sathyanarayanan Kuppuswamy wrote:
>> On 3/14/23 9:02 AM, Bjorn Helgaas wrote:
>>> On Tue, Mar 14, 2023 at 08:06:07PM +0530, Ganapatrao Kulkarni wrote:
>>>> On 14-03-2023 06:22 pm, Sathyanarayanan Kuppuswamy wrote:
>>>>> On 3/14/23 3:08 AM, Ganapatrao Kulkarni wrote:
>>>>>> On 14-03-2023 04:00 am, Sathyanarayanan Kuppuswamy wrote:
>>>>>>> On 3/13/23 2:12 PM, Bjorn Helgaas wrote:
>>>>>>>> On Mon, Feb 27, 2023 at 08:21:36PM -0800, Ganapatrao Kulkarni wrote:
>>>>>>>>> As per PCI specification (PCI Express Base Specification
>>>>>>>>> Revision 6.0, Section 10.5) both PF and VFs of a PCI EP
>>>>>>>>> are permitted to be enabled independently for ATS
>>>>>>>>> capability, however the STU(Smallest Translation Unit) is
>>>>>>>>> shared between PF and VFs. For VFs, it is hardwired to
>>>>>>>>> Zero and the associated PF's value applies to VFs.
>>>>>>>>>
>>>>>>>>> In the current code, the STU is being configured while
>>>>>>>>> enabling the PF ATS.  Hence, it is not able to enable ATS
>>>>>>>>> for VFs, if it is not enabled on the associated PF
>>>>>>>>> already.
>>>>>>>>>
>>>>>>>>> Adding a function pci_ats_stu_configure(), which can be
>>>>>>>>> called to configure the STU during PF enumeration.  Latter
>>>>>>>>> enumerations of VFs can successfully enable ATS
>>>>>>>>> independently.
>>>
>>>>>>>>> @@ -46,6 +46,35 @@ bool pci_ats_supported(struct pci_dev *dev)
>>>>>>>>>     }
>>>>>>>>>     EXPORT_SYMBOL_GPL(pci_ats_supported);
>>>>>>>>>     +/**
>>>>>>>>> + * pci_ats_stu_configure - Configure STU of a PF.
>>>>>>>>> + * @dev: the PCI device
>>>>>>>>> + * @ps: the IOMMU page shift
>>>>>>>>> + *
>>>>>>>>> + * Returns 0 on success, or negative on failure.
>>>>>>>>> + */
>>>>>>>>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps)
>>>>>>>>> +{
>>>>>>>>> +    u16 ctrl;
>>>>>>>>> +
>>>>>>>>> +    if (dev->ats_enabled || dev->is_virtfn)
>>>>>>>>> +        return 0;
>>>>>>>>
>>>>>>>> I might return an error for the VF case on the assumption
>>>>>>>> that it's likely an error in the caller.  I guess one could
>>>>>>>> argue that it simplifies the caller if it doesn't have to
>>>>>>>> check for PF vs VF.  But the fact that STU is shared between
>>>>>>>> PF and VFs is an important part of understanding how ATS
>>>>>>>> works, so the caller should be aware of the distinction
>>>>>>>> anyway.
>>>>>>>
>>>>>>> I have already asked this question. But let me repeat it.
>>>>>>>
>>>>>>> We don't have any checks for the PF case here. That means you
>>>>>>> can re-configure the STU as many times as you want until ATS
>>>>>>> is enabled in PF. So, if there are active VFs which uses this
>>>>>>> STU, can PF re-configure the STU at will?
>>>>>>
>>>>>> IMO, Since STU is shared, programming it multiple times is not expected from callers code do it, however we can add below check to allow to program STU once from a PF.
>>>>>>
>>>>>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>>>>>> index 1611bfa1d5da..f7bb01068e18 100644
>>>>>> --- a/drivers/pci/ats.c
>>>>>> +++ b/drivers/pci/ats.c
>>>>>> @@ -60,6 +60,10 @@ int pci_ats_stu_configure(struct pci_dev *dev, int ps)
>>>>>>           if (dev->ats_enabled || dev->is_virtfn)
>>>>>>                   return 0;
>>>>>>
>>>>>> +       /* Configured already */
>>>>>> +       if (dev->ats_stu)
>>>>>> +               return 0;
>>>>>
>>>>> Theoretically, you can re-configure STU as long as no one is using
>>>>> it. Instead of this check, is there a way to check whether there
>>>>> are active VMs which enables ATS?
>>>>
>>>> Yes I agree, there is no limitation on how many times you write STU
>>>> bits, but practically it is happening while PF is enumerated.
>>>>
>>>> The usage of function pci_ats_stu_configure is almost
>>>> similar(subset) to pci_enable_ats and only difference is one does
>>>> ATS enable + STU program and another does only STU program.
>>>
>>> What would you think of removing the STU update feature from
>>> pci_enable_ats() so it always fails if pci_ats_stu_configure() has not
>>> been called, even when called on the PF, e.g.,
>>>
>>>    if (ps != pci_physfn(dev)->ats_stu)
>>>      return -EINVAL;
>>
>> If we are removing the STU update from pci_enable_ats(), why
>> even allow passing "ps (page shift)" parameter? IMO, we can assume that
>> for STU reconfigure, users will call pci_ats_stu_configure().
> 
> The reason to pass "ps" would be to verify that the STU the caller
> plans to use matches the actual STU.
> 
>> Since zero is a valid STU, enabling ATS can be decoupled from STU
>> update.
>>
>>>    pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, &ctrl);
>>>    ctrl |= PCI_ATS_CTRL_ENABLE;
>>>    pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
>>>
>>> Would probably also have to set "dev->ats_stu = 0" in
>>> pci_disable_ats() to allow the possibility of calling
>>> pci_ats_stu_configure() again.
>>>
>>>> IMO, I dont think, there is any need to find how many active VMs
>>>> with attached VFs and it is not done for pci_enable_ats as well.
>>>
>>> Enabling or disabling ATS in a PF or VF has no effect on other
>>> functions.
>>>
>>> But changing STU while a VF has ATS enabled would definitely break any
>>> user of that VF, so if it's practical to verify that no VFs have ATS
>>> enabled, I think we should.
>>
>> I also think it is better to check for a ats_enabled status of VF before
>> configuring the STU.
>>
>> May be something like below (untested),
>>
>> static int is_ats_enabled_in_vf(struct pci_dev *dev)
>> {
>>          struct pci_sriov *iov = dev->sriov;
>>          struct pci_dev *vdev;
>>
>>          if (dev->is_virtfn)
>>                  return -EINVAL;
>>
>>          for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
>>                  vdev = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus),
>>                                               pci_iov_virtfn_bus(dev, i),
>>                                               pci_iov_virtfn_devfn(dev, i));
> 
> I would try hard to avoid pci_get_domain_bus_and_slot().  That's
> expensive (searches *all* PCI devs with for_each_pci_dev()) and
> requires dealing with reference counts.
> 

Thanks Bjorn and Sathyanarayanan for the suggestions.

> Maybe an atomic count in the PF of VFs with ATS enabled.

Yes this makes simple, atomic counter helps to find the active VFs.

I am also thinking, can we put this condition on caller to make sure to 
*not* have any active VFs before calling this helper?
So that the tracking and race issues should be taken care by the caller!.

SMMUv3 driver(first consumer of this helper) is already tracking the 
active ats count(nr_ats_masters) atomically, it can be leveraged while 
calling.

> 
>>                  if (vdev && vdev->ats_enabled)
>>                          return 1;
>>          }
>>
>>          return 0;
>>
>> }
>>
>> int pci_ats_stu_configure(struct pci_dev *dev, int ps)
>> {
>> ...
>> if (is_ats_enabled_in_vf(dev))
>>     return -EBUSY;
>>
>>>
>>>> Also the caller has the requirement to call either
>>>> pci_ats_stu_configure or pci_enable_ats while enumerating the PF.
>>>>
>>>>>>           if (!pci_ats_supported(dev))
>>>>>>                   return -EINVAL;
>>>>>>>>
>>>>>>>>> +
>>>>>>>>> +    if (!pci_ats_supported(dev))
>>>>>>>>> +        return -EINVAL;
>>>>>>>>> +
>>>>>>>>> +    if (ps < PCI_ATS_MIN_STU)
>>>>>>>>> +        return -EINVAL;
>>>>>>>>> +
>>>>>>>>> +    dev->ats_stu = ps;
>>>>>>>>> +    pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, &ctrl);
>>>>>>>>> +    ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
>>>>>>>>> +    pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
>>>>>>>>> +
>>>>>>>>> +    return 0;
>>>>>>>>> +}
>>>>>>>>> +EXPORT_SYMBOL_GPL(pci_ats_stu_configure);
>>>>>>>>> +
>>>>>>>>>     /**
>>>>>>>>>      * pci_enable_ats - enable the ATS capability
>>>>>>>>>      * @dev: the PCI device
>>>>>>>>> @@ -68,8 +97,8 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>>>>>>>>>             return -EINVAL;
>>>>>>>>>           /*
>>>>>>>>> -     * Note that enabling ATS on a VF fails unless it's already enabled
>>>>>>>>> -     * with the same STU on the PF.
>>>>>>>>> +     * Note that enabling ATS on a VF fails unless it's already
>>>>>>>>> +     * configured with the same STU on the PF.
>>>>>>>>>          */
>>>>>>>>>         ctrl = PCI_ATS_CTRL_ENABLE;
>>>>>>>>>         if (dev->is_virtfn) {
>>>>>>>>> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
>>>>>>>>> index df54cd5b15db..7d62a92aaf23 100644
>>>>>>>>> --- a/include/linux/pci-ats.h
>>>>>>>>> +++ b/include/linux/pci-ats.h
>>>>>>>>> @@ -8,6 +8,7 @@
>>>>>>>>>     /* Address Translation Service */
>>>>>>>>>     bool pci_ats_supported(struct pci_dev *dev);
>>>>>>>>>     int pci_enable_ats(struct pci_dev *dev, int ps);
>>>>>>>>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps);
>>>>>>>>>     void pci_disable_ats(struct pci_dev *dev);
>>>>>>>>>     int pci_ats_queue_depth(struct pci_dev *dev);
>>>>>>>>>     int pci_ats_page_aligned(struct pci_dev *dev);
>>>>>>>>> @@ -16,6 +17,8 @@ static inline bool pci_ats_supported(struct pci_dev *d)
>>>>>>>>>     { return false; }
>>>>>>>>>     static inline int pci_enable_ats(struct pci_dev *d, int ps)
>>>>>>>>>     { return -ENODEV; }
>>>>>>>>> +static inline int pci_ats_stu_configure(struct pci_dev *d, int ps)
>>>>>>>>> +{ return -ENODEV; }
>>>>>>>>>     static inline void pci_disable_ats(struct pci_dev *d) { }
>>>>>>>>>     static inline int pci_ats_queue_depth(struct pci_dev *d)
>>>>>>>>>     { return -ENODEV; }
>>
>> -- 
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Thanks,
Ganapat
