Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9ACC611C48
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 23:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJ1VOl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 17:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ1VOk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 17:14:40 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3E4DEF7;
        Fri, 28 Oct 2022 14:14:36 -0700 (PDT)
Message-ID: <a7629245-850c-e854-9ad9-1e83f971e867@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666991674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1pOmJVK8D335gMD8nvcvHaDc4747jVgbe83q3WqPhro=;
        b=ovttEpBYNB78uQPn/5wrJLSGC7j5XJErM1QiflClAyYOmRW7940PrJVCUAJzm/PoROXG2L
        ZpbXLWkkvtc2WeCYjnppq6uujxHsjexNbjOndVdx9du4yc6f4XDpgzR6+pHVSNWZKjt1d6
        Gy7rhv5I8DcUzVYe/nz7KavBPmM0cQY=
Date:   Fri, 28 Oct 2022 16:14:31 -0500
MIME-Version: 1.0
Subject: Re: [PATCH V7 3/4] PCI: vmd: Add vmd_device_data
Content-Language: en-US
To:     david.e.box@linux.intel.com, Bjorn Helgaas <helgaas@kernel.org>
Cc:     nirmal.patel@linux.intel.com, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221028194014.GA907046@bhelgaas>
 <85336561282c1c444501b799096e9c94b23722e0.camel@linux.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <85336561282c1c444501b799096e9c94b23722e0.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/28/2022 3:22 PM, David E. Box wrote:
> On Fri, 2022-10-28 at 14:40 -0500, Bjorn Helgaas wrote:
>> On Fri, Oct 28, 2022 at 02:18:48PM -0500, Jonathan Derrick wrote:
>>> On 10/28/2022 2:13 PM, Bjorn Helgaas wrote:
>>>> On Mon, Oct 24, 2022 at 05:44:10PM -0700, David E. Box wrote:
>>>>> Add vmd_device_data to allow adding additional info for driver data.
>>>>>  	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
>>>>> -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>>>>> -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
>>>>> -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
>>>>> +		(kernel_ulong_t)&(struct vmd_device_data) {
>>>>> +			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>>>>> +				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
>>>>> +				    VMD_FEAT_OFFSET_FIRST_VECTOR,
>>>>> +		},
>>>>> +	},
>>>>
>>>> It looks like these devices come in families where several device IDs
>>>> share the same features.  I think this would be more readable if you
>>>> defined each family outside this table and simply referenced the
>>>> family here.  E.g., you could do something like:
>>>>
>>>>   static struct vmd_device_data vmd_v1 = {
>>>>     .features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>>>> 		VMD_FEAT_HAS_BUS_RESTRICTIONS |
>>>> 		VMD_FEAT_OFFSET_FIRST_VECTOR,
>>>>   };
>>>
>>> I seem to recall it being similar to this in one of the previous revisions
>>> It's fine with me either way
>>
>> Indeed it was:
>> https://lore.kernel.org/r/366a9602-555f-7a1b-a8db-bbcbf84b7b08@linux.dev
>> I'd forgotten that.
>>
>> At the time there were four devices (0x467f 0x4c3d 0xa77f 0x9a0b)
>> that used the 467f data.  The current series adds two more (0x7d0b
>> 0x0ad0b).  Maybe the "vmd_467f_data" name could have been more
>> descriptive, but the code was definitely shorter:
>>
>>   +     { PCI_VDEVICE(INTEL, 0x467f), (kernel_ulong_t)&vmd_467f_data },
>>   +     { PCI_VDEVICE(INTEL, 0x4c3d), (kernel_ulong_t)&vmd_467f_data },
>>   +     { PCI_VDEVICE(INTEL, 0xa77f), (kernel_ulong_t)&vmd_467f_data },
>>   +     { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
>> (kernel_ulong_t)&vmd_467f_data },
> 
> I prefer this too but don't know what's the best name. Could just be by the
> platform that started this grouping, e.g. vmd_tgl_data for Tiger Lake. What do
> you think Jonathan?
> 
> David
vmd_client_data ? (meaning product class; client vs enterprise)


> 
>>
>> I do wish pci_device_id.driver_data were a void pointer, as it is for
>> of_device_id, which makes it much more natural to express [1], but
>> that ship has long sailed.
>>
>> [1] 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-kirin.c?id=v6.0#n768
>>
>>>>   {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
>>>>     .driver_data = (kernel_ulong_t) &vmd_v1,
>>>>
>>>> Then you can add VMD_FEAT_BIOS_PM_QUIRK and the .ltr value in one place
>>>> instead of repeating it a half dozen times.
>>>>
>>>>>  	{0,}
>>>>>  };
>>>>>  MODULE_DEVICE_TABLE(pci, vmd_ids);
>>>>> -- 
>>>>> 2.25.1
>>>>>
> 
