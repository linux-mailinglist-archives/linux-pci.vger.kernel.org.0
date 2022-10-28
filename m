Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3482611C60
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 23:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJ1VYY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 17:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiJ1VYX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 17:24:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E338724B31D;
        Fri, 28 Oct 2022 14:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666992262; x=1698528262;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l7/pNIpt0c4/zo3sagCVNI3Fbl+47aFIgt3AgFN5d6I=;
  b=YRsbK2wZ6zF+Aqa5GhieZcpMqpJUHBe298KK0DQEV4hPS8tzdC86aW/t
   tr0uaki26p4kkCWN1KwbgwXjiRXijqF3Fi6xJDHWDO+I4u+aXrUkySCcD
   YnzrdJKkPGKGm9u+KZK6XiyGNVhYzqulj89MBQVBVEgGx9L6jiigmaPEB
   F7NM+vbNb25L9iT2OFFeTzGhHQUeDTlyd5WDvulvJfoPr15qG40DiBGKc
   ZU8iwpWyOgwc2JANycQI4sP2YKxlvHWFv9kLlBdQn/zH9T/s9Kuz5YOV8
   EK/ez+JB1tVCLBW6voy0ZcD4xyB/jnVHSLm1ghSh93JprC2gUfWbbmvT/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="310291205"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="310291205"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 14:24:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="807961146"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="807961146"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.212.123.198]) ([10.212.123.198])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 14:24:21 -0700
Message-ID: <f3cf9f00-6762-25b3-1e5a-e379e25d8642@linux.intel.com>
Date:   Fri, 28 Oct 2022 14:24:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH V7 3/4] PCI: vmd: Add vmd_device_data
To:     Jonathan Derrick <jonathan.derrick@linux.dev>,
        david.e.box@linux.intel.com, Bjorn Helgaas <helgaas@kernel.org>
Cc:     lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221028194014.GA907046@bhelgaas>
 <85336561282c1c444501b799096e9c94b23722e0.camel@linux.intel.com>
 <a7629245-850c-e854-9ad9-1e83f971e867@linux.dev>
Content-Language: en-US
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <a7629245-850c-e854-9ad9-1e83f971e867@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/28/2022 2:14 PM, Jonathan Derrick wrote:
>
> On 10/28/2022 3:22 PM, David E. Box wrote:
>> On Fri, 2022-10-28 at 14:40 -0500, Bjorn Helgaas wrote:
>>> On Fri, Oct 28, 2022 at 02:18:48PM -0500, Jonathan Derrick wrote:
>>>> On 10/28/2022 2:13 PM, Bjorn Helgaas wrote:
>>>>> On Mon, Oct 24, 2022 at 05:44:10PM -0700, David E. Box wrote:
>>>>>> Add vmd_device_data to allow adding additional info for driver data.
>>>>>>  	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
>>>>>> -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>>>>>> -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
>>>>>> -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
>>>>>> +		(kernel_ulong_t)&(struct vmd_device_data) {
>>>>>> +			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>>>>>> +				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
>>>>>> +				    VMD_FEAT_OFFSET_FIRST_VECTOR,
>>>>>> +		},
>>>>>> +	},
>>>>> It looks like these devices come in families where several device IDs
>>>>> share the same features.  I think this would be more readable if you
>>>>> defined each family outside this table and simply referenced the
>>>>> family here.  E.g., you could do something like:
>>>>>
>>>>>   static struct vmd_device_data vmd_v1 = {
>>>>>     .features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>>>>> 		VMD_FEAT_HAS_BUS_RESTRICTIONS |
>>>>> 		VMD_FEAT_OFFSET_FIRST_VECTOR,
>>>>>   };
>>>> I seem to recall it being similar to this in one of the previous revisions
>>>> It's fine with me either way
>>> Indeed it was:
>>> https://lore.kernel.org/r/366a9602-555f-7a1b-a8db-bbcbf84b7b08@linux.dev
>>> I'd forgotten that.
>>>
>>> At the time there were four devices (0x467f 0x4c3d 0xa77f 0x9a0b)
>>> that used the 467f data.  The current series adds two more (0x7d0b
>>> 0x0ad0b).  Maybe the "vmd_467f_data" name could have been more
>>> descriptive, but the code was definitely shorter:
>>>
>>>   +     { PCI_VDEVICE(INTEL, 0x467f), (kernel_ulong_t)&vmd_467f_data },
>>>   +     { PCI_VDEVICE(INTEL, 0x4c3d), (kernel_ulong_t)&vmd_467f_data },
>>>   +     { PCI_VDEVICE(INTEL, 0xa77f), (kernel_ulong_t)&vmd_467f_data },
>>>   +     { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
>>> (kernel_ulong_t)&vmd_467f_data },
>> I prefer this too but don't know what's the best name. Could just be by the
>> platform that started this grouping, e.g. vmd_tgl_data for Tiger Lake. What do
>> you think Jonathan?
>>
>> David
> vmd_client_data ? (meaning product class; client vs enterprise)
Product class would make sense. We can keep adding new IDs.
>
>>> I do wish pci_device_id.driver_data were a void pointer, as it is for
>>> of_device_id, which makes it much more natural to express [1], but
>>> that ship has long sailed.
>>>
>>> [1] 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-kirin.c?id=v6.0#n768
>>>
>>>>>   {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
>>>>>     .driver_data = (kernel_ulong_t) &vmd_v1,
>>>>>
>>>>> Then you can add VMD_FEAT_BIOS_PM_QUIRK and the .ltr value in one place
>>>>> instead of repeating it a half dozen times.
>>>>>
>>>>>>  	{0,}
>>>>>>  };
>>>>>>  MODULE_DEVICE_TABLE(pci, vmd_ids);
>>>>>> -- 
>>>>>> 2.25.1
>>>>>>

