Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8553056843B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 11:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiGFJyf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 05:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiGFJxx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 05:53:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3F301ED;
        Wed,  6 Jul 2022 02:53:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBE8AD6E;
        Wed,  6 Jul 2022 02:53:21 -0700 (PDT)
Received: from [10.57.40.86] (unknown [10.57.40.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30D7F3F66F;
        Wed,  6 Jul 2022 02:53:19 -0700 (PDT)
Message-ID: <35de3948-d8f2-c2da-05f9-995eecf275ce@arm.com>
Date:   Wed, 6 Jul 2022 11:52:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RESEND v1 1/2] ACPI/PCI: Make _SRS optional for link
 device
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20220705172931.GA71865@bhelgaas>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20220705172931.GA71865@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/5/22 19:29, Bjorn Helgaas wrote:
> On Fri, Jul 01, 2022 at 06:16:23PM +0200, Pierre Gondois wrote:
>> From: Pierre Gondois <Pierre.Gondois@arm.com>
>>
>> In ACPI 6.4, s6.2.13 "_PRT (PCI Routing Table)", PCI legacy
>> interrupts can be described though a link device (first model).
>>  From s6.2.16 "_SRS (Set Resource Settings)":
>> "This optional control method [...]"
>>
>> Make it optional to have a _SRS method for link devices.
> 
> I think it would be helpful to outline the reason for wanting these
> changes in the commit log.  Otherwise we don't know the benefit and
> it's harder to justify making the change since it's not an obvious
> cleanup.
> 
> IIRC from [1] there *is* a good reason: you need to use Interrupt Link
> devices so you can specify "level triggered, active high".
> 
> Without an Interrupt Link, you would get the default "level triggered,
> active low" setting, which apparently isn't compatible with GICv2.
> 
> I assume this fixes a device that previously didn't work correctly,
> but I don't see the details of that in the bugzilla.  I'm a little
> confused about this.  Isn't GICv2 widely used already?  How are things
> working now?  Or are there just a lot of broken devices?

It was unsure which of the 2 models described in ACPI 6.4, s6.2.13
"_PRT (PCI Routing Table)" would be used for UEFI for kvmtool.

Remainder:
The first model allows to accurately describe interrupts: level/edge
triggered and active high/low. Interrupts are also configurable with
_CRS/_PRS/_SRS/_DIS methods
The second model allows to describe hardwired interrupts, and are
by default level triggered, active low.

The kernel is aware that GivV2 interrupts are active high, so there
was actually no need to accurately describe them. Thus the second
model was used.
While experimenting, we temporarily had a configuration using
the first model, and only had a _CRS method (no _PRS/_SRS), which
triggered some warnings.

So these patches are not fixes for existing platforms, but merely
to make _PRS/_SRS methods optional.

In [1] I said I would submit patches to change that. If you think
this is not necessary as the configuration is non-existing, I am
perfectly fine to drop the patches.

Also as Rafael noted, the _DIS method should also be taken into
consideration if _PRS/_SRS are made optional.

Regards,
Pierre


> 
> [1] https://lore.kernel.org/r/e2ae06ba-de8f-2cae-60fa-fe9a215d779b@arm.com
> 
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215560
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   drivers/acpi/pci_link.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
>> index 58647051c948..129e3e7e80ee 100644
>> --- a/drivers/acpi/pci_link.c
>> +++ b/drivers/acpi/pci_link.c
>> @@ -288,6 +288,13 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
>>   	if (!irq)
>>   		return -EINVAL;
>>   
>> +	if (!acpi_has_method(handle, METHOD_NAME__SRS)) {
>> +		if (link->irq.active == irq)
>> +			return 0;
>> +		acpi_handle_err(handle, "Unable to set IRQ %d: No _SRS.\n", irq);
>> +		return -ENODEV;
>> +	}
>> +
>>   	resource = kzalloc(sizeof(*resource) + 1, irqs_disabled() ? GFP_ATOMIC: GFP_KERNEL);
>>   	if (!resource)
>>   		return -ENOMEM;
>> -- 
>> 2.25.1
>>
