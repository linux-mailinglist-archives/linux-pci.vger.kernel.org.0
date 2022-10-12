Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DC75FC1E9
	for <lists+linux-pci@lfdr.de>; Wed, 12 Oct 2022 10:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJLIX2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Oct 2022 04:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJLIX0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Oct 2022 04:23:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F79B3B70F
        for <linux-pci@vger.kernel.org>; Wed, 12 Oct 2022 01:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665562996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jELvjO5QqUILY8VqH/j8XPDV639IFLeW5HNerotSla4=;
        b=UzU7cIrMwcmk7Q4i3rIA30FJYJdmr9FJOw9S2DC5XLnMwZvDzv2whb/dP+Lbtu18oSNnhB
        FQINYj8ZwYg8l+4Qga6KOBI2X4S1eR3Nnn66Ti0fDc9neGgemIUdFkP3HOPeGtXOx1HyVW
        Olzqn3LjPeq/6dizEPe6+7tBOU3vicE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-Jg54tFnRMJWHd1gDySTxUQ-1; Wed, 12 Oct 2022 04:23:15 -0400
X-MC-Unique: Jg54tFnRMJWHd1gDySTxUQ-1
Received: by mail-ed1-f70.google.com with SMTP id z11-20020a056402274b00b0045ca9510fc8so1194134edd.23
        for <linux-pci@vger.kernel.org>; Wed, 12 Oct 2022 01:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jELvjO5QqUILY8VqH/j8XPDV639IFLeW5HNerotSla4=;
        b=1tjo1vlrhavsFrnHEaWumtV5Sqzicodq4bnwzqQZo4bmWpSgcSFwdTopna9fZrInIs
         Qf7IdE9WF5eE7SQAE26Cxofbt0YOisDlZ34v+h7iqUtqkB3rmEFXLB/JmK4cFYQ8YIxq
         Pk4QcOvveST19TUodwZvN1wqipvDnJR4iOAlwed8/EGHLxC/vwsPKsfVB2Kvm/ChOy7z
         EkZ66UQWriaag06nKSSNUOB0KoKbadoBP1MhuIW7qTOegRmX/UE+REA/O2w7xB47WlL7
         h5urw85bzrR2YmWsA/9Uc47w/QwdFzFEP+VdJelRshywPjxvBexbUR7FogUpImp/oN1M
         nzrA==
X-Gm-Message-State: ACrzQf1BtZ4culVkTin0G2SLJMjjigeW24onU4gA3iQ25J8s0UJcwFsd
        FWRr3cg8iS+jxGcf3dq5Xyv4h7MVdMmPs1GwG3EvCVv/+et4p8NKrCjjd5zdvUjbwecEt8qlrgS
        ubsYLlK/3SY5PLCJIgtB4
X-Received: by 2002:a17:907:3d9e:b0:78d:e7be:1ee8 with SMTP id he30-20020a1709073d9e00b0078de7be1ee8mr4292096ejc.164.1665562994423;
        Wed, 12 Oct 2022 01:23:14 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7i4nsu+GAVi59ItMezRn1amUyC6vyKNWudRnkv+dBKc/kv00sA71mHTjb6PDHVPMiJbcAilA==
X-Received: by 2002:a17:907:3d9e:b0:78d:e7be:1ee8 with SMTP id he30-20020a1709073d9e00b0078de7be1ee8mr4292083ejc.164.1665562994177;
        Wed, 12 Oct 2022 01:23:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id l25-20020a50d6d9000000b0045723aa48ccsm10616921edj.93.2022.10.12.01.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 01:23:13 -0700 (PDT)
Message-ID: <a9203d47-5b85-c035-3ec7-973dcb6a840a@redhat.com>
Date:   Wed, 12 Oct 2022 10:23:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] x86/PCI: Disable E820 reserved region clipping for Clevo
 NL4XLU laptops
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linuxkernelml@undead.fr,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
References: <20221011174010.GA3001067@bhelgaas>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221011174010.GA3001067@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 10/11/22 19:40, Bjorn Helgaas wrote:
> On Mon, Oct 10, 2022 at 05:02:06PM +0200, Hans de Goede wrote:
>> Clevo NL4XLU barebones have the same E820 reservation covering
>> the entire _CRS 32-bit window issue as the Lenovo *IIL* and
>> Clevo X170KM-G models, relevant dmesg bits (with pci=no_e820):
>>
>>  BIOS-e820: [mem 0x000000005bc50000-0x00000000cfffffff] reserved
>>  pci_bus 0000:00: root bus resource [mem 0x6d800000-0xbfffffff window]
>>
>> Note how the e820 reservation covers the entire PCI root mem window.
>>
>> Add a no_e820 quirk for these models to fix the touchpad not working
>> (due to Linux being unable to assign a PCI BAR for the i2c-controller).
> 
> I do plan to apply this, but a little food for thought below.
> 
> I explored this issue a little bit with the ACPI/UEFI folks (see
> https://members.uefi.org/wg/aswg/mail/thread/9265 if you have access).  
> 
> One aspect I had glossed over earlier is that on most recent machines,
> the "E820 map" Linux uses is actually constructed internally by Linux
> based on the UEFI memory map, and that construction conflates several
> EFI types into E820_TYPE_RESERVED; see
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/efi/libstub/x86-stub.c?id=v5.19#n576
> 
> We don't have a dmesg log with "efi=debug" for this case, but in most
> cases where E820 says the entire root mem window is reserved, I think
> it's because an EfiMemoryMappedIO entry was converted to
> E820_TYPE_RESERVED.
> 
> From a response in the ACPI/UEFI discussion:
> 
>   The reason EfiMemoryMappedIO[1] exist in the UEFI memory map is to
>   request a virtual mapping for UEFI Runtime Services.
>   
>   For example if the EFI Runtime Service needed to write to FLASH then
>   the NOR FLASH would need a mapping. Also the NOR FLASH controller
>   might also need a mapping and this could include PCI Config Space if
>   needed registers existed in that space.
>   
>   Thus the EfiMemoryMappedIO entries just exist to pass up the
>   EFI_MEMORY_RUNTIME attribute in the UEFI Memory Map. This is the part
>   of the contract for UEFI Runtime Service to use virtual mappings
>   provided by the OS. So from an OS point of view EfiMemoryMappedIO has
>   no other purpose.
>   
>   [1] UEFI: Table 7-5 Memory Type Usage before ExitBootServices() "Used
>   by system firmware to request that a memory-mapped IO region be
>   mapped by the OS to a virtual address so it can be accessed by EFI
>   runtime services."
> 
> So the point here is that Linux currently converts EfiMemoryMappedIO
> to E820_TYPE_RESERVED, and that likely attaches more meaning to those
> regions than firmware intended.
> 
> I'm a little leery of changing that UEFI->E820 conversion because of
> other possible implications, but it may be that omitting
> EfiMemoryMappedIO entries from the E820 map and keeping the original
> "avoid E820 regions" (4dc2287c1805) would also solve this problem.

Actually during my many attempts to fix this I did write a patch
adding a new E820_TYPE_MMIO to the generated e820-memmap which
would only show up in the EFI -> E820 entry generation case
and then used that to not exclude that E820 region, see
this RFC series:

https://lore.kernel.org/linux-pci/20220214151759.98267-1-hdegoede@redhat.com/

Unfortunately this series caused the same X1 carbon gen2 suspend/resume
not working problem as the earlier set pci=no_e820 based on a BIOS date cutoff
attempt which I did earlier and which even briefly was in some -rc kernels
through Rafael's tree.

I also did another series which used the EfiMemoryMappedIO type as
an input to heuristics to automatically set pci=no_e820, see:

https://lore.kernel.org/linux-pci/20220228105259.230903-1-hdegoede@redhat.com/

IIRC that patch eventually got replaced by a similar but simpler
heuristic from you. Which IIRC eventually got dropped again because
it was causing regressions on some models again.

So we ended up with the current set pci=no_e820 using DMI based quirks +
try to enable it for all BIOS-es with date >= 2023 approach,
with the plan to do DMI quirks setting pci=use_e820 if any (buggy)
2023 BIOS-es show up which need this.

Regards,

Hans







>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216565
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  arch/x86/pci/acpi.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
>> index 2f82480fd430..45ef65d31a40 100644
>> --- a/arch/x86/pci/acpi.c
>> +++ b/arch/x86/pci/acpi.c
>> @@ -189,6 +189,19 @@ static const struct dmi_system_id pci_crs_quirks[] __initconst = {
>>  			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
>>  		},
>>  	},
>> +
>> +	/*
>> +	 * Clevo NL4XLU barebones have the same E820 reservation covering
>> +	 * the entire _CRS 32-bit window issue as the Lenovo *IIL* models.
>> +	 * See https://bugzilla.kernel.org/show_bug.cgi?id=216565
>> +	 */
>> +	{
>> +		.callback = set_no_e820,
>> +		.ident = "Clevo NL4XLU Barebone",
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "NL4XLU"),
>> +		},
>> +	},
>>  	{}
>>  };
>>  
>> -- 
>> 2.37.3
>>
> 

