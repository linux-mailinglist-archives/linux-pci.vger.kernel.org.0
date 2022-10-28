Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501E2611AC0
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 21:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJ1TS6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 15:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJ1TS5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 15:18:57 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03B220C9BA;
        Fri, 28 Oct 2022 12:18:55 -0700 (PDT)
Message-ID: <5c0a8a41-db58-ac73-da08-681b20156786@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666984734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mjXor4eZMxYqiCEcL6iQKj+HrTeElB6DfqFGXiUnpAg=;
        b=hkmGvr7UIHA+ZzceV7bC1Z6D6WM5XM14PnP0nsipZXvelPDmRJLgzAyI/of/7rAFtb350G
        YA7KeJjjOzHe8oPR0rDZW+ldYNLlgFJryaSQOkmboqz9qm/c/4pM55jmNVARW6LJ0lBsbD
        cHD98FX3lyLitVelJifZ9Lw4LSKykU0=
Date:   Fri, 28 Oct 2022 14:18:48 -0500
MIME-Version: 1.0
Subject: Re: [PATCH V7 3/4] PCI: vmd: Add vmd_device_data
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>
Cc:     nirmal.patel@linux.intel.com, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221028191308.GA903098@bhelgaas>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20221028191308.GA903098@bhelgaas>
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



On 10/28/2022 2:13 PM, Bjorn Helgaas wrote:
> On Mon, Oct 24, 2022 at 05:44:10PM -0700, David E. Box wrote:
>> Add vmd_device_data to allow adding additional info for driver data.
> 
>>  	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
>> -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>> -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
>> -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
>> +		(kernel_ulong_t)&(struct vmd_device_data) {
>> +			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>> +				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
>> +				    VMD_FEAT_OFFSET_FIRST_VECTOR,
>> +		},
>> +	},
> 
> It looks like these devices come in families where several device IDs
> share the same features.  I think this would be more readable if you
> defined each family outside this table and simply referenced the
> family here.  E.g., you could do something like:
> 
>   static struct vmd_device_data vmd_v1 = {
>     .features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> 		VMD_FEAT_HAS_BUS_RESTRICTIONS |
> 		VMD_FEAT_OFFSET_FIRST_VECTOR,
>   };
I seem to recall it being similar to this in one of the previous revisions
It's fine with me either way

> 
>   {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
>     .driver_data = (kernel_ulong_t) &vmd_v1,
> 
> Then you can add VMD_FEAT_BIOS_PM_QUIRK and the .ltr value in one place
> instead of repeating it a half dozen times.
> 
>>  	{0,}
>>  };
>>  MODULE_DEVICE_TABLE(pci, vmd_ids);
>> -- 
>> 2.25.1
>>
