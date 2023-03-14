Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CF56B8F41
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 11:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCNKIh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 06:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCNKIg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 06:08:36 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2090.outbound.protection.outlook.com [40.107.93.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B2317CF4;
        Tue, 14 Mar 2023 03:08:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxOfV7Dm7MAHtH1cZfRrmm0xGUDhlPi0S5sFmDpOt+MV5ho2xevKuAgqPPNKUnOet3difgOEmpIquoMwEn7tLy4zrizjRGA+PwmieyPNIRJawhyDx2lBCdfzcSjC0PYxtUnx8Mc/07q6CLPPgV8nnUV9hshSY1KqIHzoVf5K0XyxTJ7+iTVWdXIy+PjT8nH6sQLFLHGLhlL03QFyFO9EXCgA0ShciX1YULEbFgPP2F4TA/6GkAm9jswI2GTyjcALqT2OtJd3czoq7bLJEgYkL7a0pw7kvSASqF2x++DmXbrHFIaqTyXtd4F10sodNTJPsvqKry4U/WU9qK+m4qBogA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqQYcrInXiPnfQrNejEPOkl+j/vzUJ2Lj+IqlnuUt9E=;
 b=M87Hnuw6ulcHDX/Kv4Q4z5Teq6jcEJAjCjGXPYMOva5jgy+yRV0N2NXHmIuDv2eiaw5VbG5WhDj87vxPOkL/zY1WxEwjGxwKW5UmMtx9+qf9eBqWRQmChiziNox7M5aXXDG4yfdJSTwFdYmpAyp1Jz4f1dUTQC7vey2GGvwAewKrPbHd9Bdh1T9ttdZK1tkcF4jOCkgI06z3xYzvzwm+CCb5gq9tbCHvD0KV7FuC3tfeh1/z84jYgMlTpT6lizT9TXxmBDUS7Iu+eZzY/IR7IG/zXmSlBhcCDK25DI7L93ecHljnKUrCINx14vEvP4QtZn+f+IDUhw/B821Qeutkqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqQYcrInXiPnfQrNejEPOkl+j/vzUJ2Lj+IqlnuUt9E=;
 b=YmHTvlk5dmgY7cfd6TCEEnJhXc25WG6ABBe+/SicFPwpkLPIGQCwpPJnAzQnzrye0U2FXum6NQEQdaJdU5hlhm8t3/7QeYsxUCCImQEzoL1krZeOAgFYgBWjJfOQbjXG/Az1FJaZ5vc1Xj1ixUjeHrbDtZVoTm538nFh9p/AQlc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 BY5PR01MB5924.prod.exchangelabs.com (2603:10b6:a03:1bc::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.26; Tue, 14 Mar 2023 10:08:25 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a%7]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 10:08:25 +0000
Message-ID: <c7a68d5f-3b95-723f-f384-223fcbd6a877@os.amperecomputing.com>
Date:   Tue, 14 Mar 2023 15:38:16 +0530
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
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <6339c50a-8dfe-f3a2-63d7-504abd4e62f0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:610:20::37) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|BY5PR01MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea3c4dc-b420-413a-b60d-08db24740cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o9PKpTAz1BMcNSZ/yd0xSBTkwNdda7j9cvWD6Xgnnc6QyKipQuGt+o7hapzbKTekzyY5RNME6dfrvO3QyGwjILhSAXgGgge4UVzrvblRp/d3bcIlfNzEHF7HgsDCGM5R5hOUwnKeFoSQS6w9xOVCt0km9Fe/m7hWf7/NcYRAVMnoiIRRRBhd6ZJR4NYAT4nmNJp1uKyGISfxFcyhk/4xXFst/udauMu0xc9yalPi/OK8StXS0KdBOrIFGfbrEES84QqzzoVi75VihbsS78K2G4fA2iioly4CIHSTUyZTi6xFkIiQTBsMItExkAk4+KwgxXn/TIvNbAAGqbReSGkc/rKnyuGkhtkqRYfTOA5rbY5TSu62sfey8oApuR+vaBMIXrzAUUZzUazF0aij23HnxL/DJij+EZjgX8N/uct70QxXjHCHDGwFpZnIEWqlfgj5uNs9oprmjtIecHA9O6bwyyh9lkgd0pF6hmNPx0AKAjJyvdUCKH+PSjQJzf1/piCucHBguoc0vEEu2Jo90iisL9nbr9VPExd9kW7Matv9+1wi1YFDFALtUKdLnKlFKBj6lgFHEPWFlV2ny9pdOcRH/D2NebJEZ94NbYQixzEzMB/6MuTZ6zsf3etXYQDl1QUCOb1ahgBLP6dHOuD06XHnsBr+tOJQ/Y189MDzL3tPsB+ISXrlhMhTHQHh9wfCww/N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(136003)(39850400004)(346002)(396003)(451199018)(478600001)(83380400001)(41300700001)(4326008)(66476007)(66556008)(66946007)(316002)(110136005)(8936002)(6666004)(107886003)(2616005)(53546011)(6512007)(6506007)(26005)(31696002)(86362001)(31686004)(186003)(2906002)(5660300002)(8676002)(7416002)(6486002)(966005)(38100700002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHpvSDVNcHVCa1FnSTNhUEVLYkF1T2h5RzRiSHhCcjR1VExxTFZDQ3VsQ0c2?=
 =?utf-8?B?UUFLMWZrR1p0ZC9DZnVBK0ZSd3prMzRidmc5YlFmWFZrTkExTFRXOFlLMWdm?=
 =?utf-8?B?NGpuM0RsZVZJZTJmajJRc3NsZmRKQnRBNS8yaHpva3h0Y3ovTlVINHorY0pY?=
 =?utf-8?B?NFc1SUNnWVg3c01KNlhjdmY1WDdscDRLaVM5bHphVW9NcXhCVWthbnpRTVhj?=
 =?utf-8?B?OGczN2c5RGlkQTdJYkdVK0o0WXFpT05udkF1N2JlYk1HT2JVK25ocy9uODdr?=
 =?utf-8?B?K095SC9qWVRlbXpMYkx0TFZpcFBMaEp6eitiTW5udktqRzIzaEpPOGRQdlpH?=
 =?utf-8?B?T0REWjhWL1VqUEwrZ1pNVHlHWHFlRkUxbHNBL0tpRk1UaDNhMjVXR21CVGlS?=
 =?utf-8?B?ZUh0SEJkU0tVeVJ3bzdDS0gybGI4a2ZnU1hXK29PMTczQmN3eFFzVWFNZXlk?=
 =?utf-8?B?NFV2cENRckJBaTd1T1RHSHVwVllqTG9rRWtzQ1BSNG15Zm9iMEJLMTZjd3BL?=
 =?utf-8?B?UUw4bDRTRU0wcWZXd2RKcXBESklZQWttU1VQVlNFRU1uU3Jsblk4U1FoRlox?=
 =?utf-8?B?RmNob0tlVnNIVDlxWTFrZmxDdlRNajlsL3Y4TTZUbDZ5T2M1VXJMbHl3Mk9i?=
 =?utf-8?B?M1RLcXJaSTBzYmkwWkR5a1FVN05rR1pxS1BGMnFVU2YwQk1acDI5ZzZPeURo?=
 =?utf-8?B?YVM2RnMweHp4alFWYTNQbU02ZitkcDVCTmtlOWtyakExSVIzWnNuM2kwWC9P?=
 =?utf-8?B?M1JSZXpRZXZ1cEtnMklMSk9XNlhUbUpPb3Q4NUJ4VTFUSGI1YmVnWFByY3B5?=
 =?utf-8?B?cENudVhGRk4rOE9EK0hLM0hvek10bmcrMHVTaTRZazdYUDhXRTdUejNrejlm?=
 =?utf-8?B?UmNvZzBRT3lvaWV4ckdSMFBadHRxczFoaHl0ZDV1ck9Ea3RZTGRqYzJleWVn?=
 =?utf-8?B?eWFvMDh6MEVIdWtqOEt2MG1OVUV5U3I4YkRmWVhUYi95d21wTlRGMnFHdmgr?=
 =?utf-8?B?d1dRTENiRkJhMGhoMS8zaW42MUJNUURZYm03Z1hmQzY2NzF3Y002RkxHM0dD?=
 =?utf-8?B?bXdFNlZ3Q093UzlyQXhOUnlJVlM2c2xXVWtJblBHYjZSTzhOU3ZnVmtrYTU1?=
 =?utf-8?B?aGx4Ui9GQ3lpV3ZuemJtRk9ydU5CTnlvd0k1WDYxa3h3endUTzZOblk0bVpo?=
 =?utf-8?B?N0R3ZmVTTjlLbEorRWpSTUNwTG9weUNhWStCRmUrRytoa0FCS2lPaDhOV1NK?=
 =?utf-8?B?blYrckMzQ1hESEh2aVJKVmlWUUdCVFpNdmF6YVU2VXQ4SzFyZHpPVVg1SlVv?=
 =?utf-8?B?WHdjemJmcFlyUm5mZGdFejcySHdhN29JRzR3Z2JTUVBnSC9ScDJDS3A0dGtE?=
 =?utf-8?B?MW92b0tXUWVvcUF1OVIwbDJpc05JUzFlRmxPY29qeVcycjBXRDBpY3pUYVdH?=
 =?utf-8?B?VFBUVG04YnBmV0gyaXlXTE4rRkpoTXJwOHNEalFDc2kwSnY4elNtTG00Z0NB?=
 =?utf-8?B?MWFOSTBISXQ4ZG96RzhRQkZRMTU4SGlnV2k5VUYzbFFFN2VxQkFXUHVNbmZk?=
 =?utf-8?B?ZVoyVEZUMEFrVE5ObXlsVGtwVm1rRUdPUWh0bENMcjU0UGpwaE43eUhiVnp6?=
 =?utf-8?B?NUZUN1pkUnZCanJieUJ5bjlqcmRmZ21WZWpQMmUwZkFDRExpL0ZIbWRabGxh?=
 =?utf-8?B?aFllYXRleUhqbXVxeHhOb3BnWE9QVzhaNjlXUGRrZkZXNDJrQXhmTXhOeFM3?=
 =?utf-8?B?bTYxM1AwVG1FV0lnMWY0Z0VQc3hiWTR6ZGtWRmtaeDNsb3BsS3lNMEd3T1lS?=
 =?utf-8?B?cUhnY2NDZUFaTzc1ck9TWkJzZ256MnlpejYxeThYMS81cTNWOGpQM2NmelVh?=
 =?utf-8?B?dGFwMHFEazdhV2ZQVzByRVd1ekpPYVYwNTFmVHFsTWM1R0ZhWTJybEgxdVky?=
 =?utf-8?B?OUJpL0Y2Sm9QR0lWL3g3eXFuL2craGliYnUxL3RhOVRsQ3N1R0J4b1BJOFJ4?=
 =?utf-8?B?YVpxbjE1UUNUU1N4MDJzZm9ZS1pBR1g5U1haditHK3JjdmJ3VHVUdE41OTd6?=
 =?utf-8?B?NC9nRXFvVTJ2alRONEc2N2NudzFLampRT0NicEVTMEV5Q1V4Q3dRSml3d1dN?=
 =?utf-8?B?M01YTldUTUZRZk02am5YUFdzZzBMWGs3ZWRhSkxhanZFUkpncmtEWjFqUXBh?=
 =?utf-8?Q?yxP51BfFQPFJUlartcPzudVLHEWazTzXCNddD7wOaAlW?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea3c4dc-b420-413a-b60d-08db24740cce
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 10:08:25.4299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Huo/kAFudN9Xrzv8SJGxBemKaalQ7oRaRyE28eLQ/Oq3DQJ8IYs2kwJJWb4IVJ+JadxN8Xaw+bYzXAwjJU7CXgrqkCsm51h/KIxXeUdiw10rJ8jDnI4zkEVDvT4NZGz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR01MB5924
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 14-03-2023 04:00 am, Sathyanarayanan Kuppuswamy wrote:
> Hi Kulkarni,
> 
> On 3/13/23 2:12 PM, Bjorn Helgaas wrote:
>> On Mon, Feb 27, 2023 at 08:21:36PM -0800, Ganapatrao Kulkarni wrote:
>>> As per PCI specification (PCI Express Base Specification Revision
>>> 6.0, Section 10.5) both PF and VFs of a PCI EP are permitted to be enabled
>>> independently for ATS capability, however the STU(Smallest Translation
>>> Unit) is shared between PF and VFs. For VFs, it is hardwired to Zero and
>>> the associated PF's value applies to VFs.
>>>
>>> In the current code, the STU is being configured while enabling the PF ATS.
>>> Hence, it is not able to enable ATS for VFs, if it is not enabled on the
>>> associated PF already.
>>>
>>> Adding a function pci_ats_stu_configure(), which can be called to
>>> configure the STU during PF enumeration.
>>> Latter enumerations of VFs can successfully enable ATS independently.
>>
>> s/STU(Smallest/STU (Smallest/ (add space before paren)
>> s/Adding a function pci_ats_stu_configure()/Add pci_ats_stu_configure()/
>> s/Latter/Subsequent/
>>
>> Add blank line between paragraphs (it looks like "Latter enumerations"
>> is intended to start a new paragraph).
>>
>>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>> Given an ack for the IOMMU patch, I'd be happy to merge both (and I
>> can do the commit log tweaks); just let me know.
>>
>> One comment/question below.
>>
>>> ---
>>>   drivers/pci/ats.c       | 33 +++++++++++++++++++++++++++++++--
>>>   include/linux/pci-ats.h |  3 +++
>>>   2 files changed, 34 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>>> index f9cc2e10b676..1611bfa1d5da 100644
>>> --- a/drivers/pci/ats.c
>>> +++ b/drivers/pci/ats.c
>>> @@ -46,6 +46,35 @@ bool pci_ats_supported(struct pci_dev *dev)
>>>   }
>>>   EXPORT_SYMBOL_GPL(pci_ats_supported);
>>>   
>>> +/**
>>> + * pci_ats_stu_configure - Configure STU of a PF.
>>> + * @dev: the PCI device
>>> + * @ps: the IOMMU page shift
>>> + *
>>> + * Returns 0 on success, or negative on failure.
>>> + */
>>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps)
>>> +{
>>> +	u16 ctrl;
>>> +
>>> +	if (dev->ats_enabled || dev->is_virtfn)
>>> +		return 0;
>>
>> I might return an error for the VF case on the assumption that it's
>> likely an error in the caller.  I guess one could argue that it
>> simplifies the caller if it doesn't have to check for PF vs VF.  But
>> the fact that STU is shared between PF and VFs is an important part of
>> understanding how ATS works, so the caller should be aware of the
>> distinction anyway.
> 
> I have already asked this question. But let me repeat it.
> 
> We don't have any checks for the PF case here. That means you can re-configure
> the STU as many times as you want until ATS is enabled in PF. So, if there are
> active VFs which uses this STU, can PF re-configure the STU at will?
> 

IMO, Since STU is shared, programming it multiple times is not expected 
from callers code do it, however we can add below check to allow to 
program STU once from a PF.

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 1611bfa1d5da..f7bb01068e18 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -60,6 +60,10 @@ int pci_ats_stu_configure(struct pci_dev *dev, int ps)
         if (dev->ats_enabled || dev->is_virtfn)
                 return 0;

+       /* Configured already */
+       if (dev->ats_stu)
+               return 0;
+
         if (!pci_ats_supported(dev))
                 return -EINVAL;
>>
>>> +
>>> +	if (!pci_ats_supported(dev))
>>> +		return -EINVAL;
>>> +
>>> +	if (ps < PCI_ATS_MIN_STU)
>>> +		return -EINVAL;
>>> +
>>> +	dev->ats_stu = ps;
>>> +	pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, &ctrl);
>>> +	ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
>>> +	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(pci_ats_stu_configure);
>>> +
>>>   /**
>>>    * pci_enable_ats - enable the ATS capability
>>>    * @dev: the PCI device
>>> @@ -68,8 +97,8 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>>>   		return -EINVAL;
>>>   
>>>   	/*
>>> -	 * Note that enabling ATS on a VF fails unless it's already enabled
>>> -	 * with the same STU on the PF.
>>> +	 * Note that enabling ATS on a VF fails unless it's already
>>> +	 * configured with the same STU on the PF.
>>>   	 */
>>>   	ctrl = PCI_ATS_CTRL_ENABLE;
>>>   	if (dev->is_virtfn) {
>>> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
>>> index df54cd5b15db..7d62a92aaf23 100644
>>> --- a/include/linux/pci-ats.h
>>> +++ b/include/linux/pci-ats.h
>>> @@ -8,6 +8,7 @@
>>>   /* Address Translation Service */
>>>   bool pci_ats_supported(struct pci_dev *dev);
>>>   int pci_enable_ats(struct pci_dev *dev, int ps);
>>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps);
>>>   void pci_disable_ats(struct pci_dev *dev);
>>>   int pci_ats_queue_depth(struct pci_dev *dev);
>>>   int pci_ats_page_aligned(struct pci_dev *dev);
>>> @@ -16,6 +17,8 @@ static inline bool pci_ats_supported(struct pci_dev *d)
>>>   { return false; }
>>>   static inline int pci_enable_ats(struct pci_dev *d, int ps)
>>>   { return -ENODEV; }
>>> +static inline int pci_ats_stu_configure(struct pci_dev *d, int ps)
>>> +{ return -ENODEV; }
>>>   static inline void pci_disable_ats(struct pci_dev *d) { }
>>>   static inline int pci_ats_queue_depth(struct pci_dev *d)
>>>   { return -ENODEV; }
>>> -- 
>>> 2.38.1
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

Thanks,
Ganapat

