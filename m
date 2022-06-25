Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99D355ABFC
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jun 2022 21:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbiFYTBI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Jun 2022 15:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbiFYTBH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Jun 2022 15:01:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FBC13F5B;
        Sat, 25 Jun 2022 12:01:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02CBE60B17;
        Sat, 25 Jun 2022 19:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DC1C3411C;
        Sat, 25 Jun 2022 19:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656183665;
        bh=9Yol+HZbbq6AmjOX2hEQynrbgqOCgS3MOxZs3p5+9iA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YRIUwiFBKbwWTGvrZ1PdENH13XwOqRXpcKER9L9DE5gB1z7ZQO9fQBebVn+dmMEpV
         u2nEvFgNvA0N4ckMdb8FClcjfh/VZV980agff7IpD65JE7gIVwmAZFjld1s4nNRgpW
         DGGZCa1whroyB8Byvbs1tCPQcXjl/5YqXdzdt62At3tBXo14J4KA4KS1ukuss5jp01
         yWT8rZxyK29yFvrfVEB+0UvUh1Yr2Y4Mj9gqpWgr+mAmKI1iBgRUQmgrcBF/oIAS8R
         KwnTFkey7Awp+Z3l69EFRlH4Espe2ooJZnWbKstH3PEp1QjqoQTEMRtifVJ1rU6ruL
         YIOniQXpPRfaw==
Date:   Sat, 25 Jun 2022 14:01:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     yangyicong@hisilicon.com, bhelgaas@google.com, rafael@kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        lenb@kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] PCI/ACPI: Always advertise ASPM support if
 CONFIG_PCIEASPM=y
Message-ID: <20220625190103.GA1559134@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5779c78-eb82-16ae-3f05-16f132f29a67@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 09, 2022 at 08:20:23PM +0800, Yicong Yang wrote:
> On 2022/5/6 2:41, Bjorn Helgaas wrote:
> > On Thu, May 05, 2022 at 08:36:42PM +0800, Yicong Yang wrote:
> >> On 2022/5/4 6:38, Bjorn Helgaas wrote:
> >>> On Mon, Apr 25, 2022 at 03:06:34PM +0800, Yicong Yang wrote:
> >>>> When we have CONFIG_PCIEASPM enabled it means OS can always
> >>>> support ASPM no matter user have disabled it through
> >>>> pcie_aspm=off or not. But currently we won't advertise ASPM
> >>>> support in _OSC negotiation if user disables it, which doesn't
> >>>> match the fact. This will also have side effects that other
> >>>> PCIe services like AER and hotplug will be disabled as ASPM
> >>>> support is required and we won't negotiate other services if
> >>>> ASPM support is absent.
> >>>>
> >>>> So this patch makes OS always advertising ASPM support if
> >>>> CONFIG_PCIEASPM=y.  It intends no functional change to
> >>>> pcie_aspm=off as it will still mark aspm_disabled=1 and
> >>>> aspm_support_enabled=false, driver will check these status
> >>>> before configuring ASPM.
> >>>>
> >>>> Tested this patch with pcie_aspm=off:
> >>>> estuary:/$ dmesg | egrep -i "aspm|osc"
> >>>> [    0.000000] PCIe ASPM is disabled
> >>>> [    8.706961] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
> >>>> ClockPM Segments MSI EDR HPX-Type3]
> >>>> [    8.726032] acpi PNP0A08:00: _OSC: platform does not support [LTR]
> >>>> [    8.742818] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME
> >>>> AER PCIeCapability DPC]
> >>>> estuary:/sys/module/pcie_aspm/parameters$ cat policy
> >>>> [default] performance powersave powersupersave
> >>>> estuary:/sys/module/pcie_aspm/parameters$ echo powersave > policy
> >>>> bash: echo: write error: Operation not permitted
> >>>>
> >>>> Cc: Rafael J. Wysocki <rafael@kernel.org>
> >>>> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> >>>> [https://lore.kernel.org/linux-pci/20220407154257.GA235990@bhelgaas/]
> >>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> >>>> ---
> >>>>  drivers/acpi/pci_root.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> >>>> index 6f9e75d14808..17e78582e633 100644
> >>>> --- a/drivers/acpi/pci_root.c
> >>>> +++ b/drivers/acpi/pci_root.c
> >>>> @@ -393,7 +393,7 @@ static u32 calculate_support(void)
> >>>>  	support |= OSC_PCI_HPX_TYPE_3_SUPPORT;
> >>>>  	if (pci_ext_cfg_avail())
> >>>>  		support |= OSC_PCI_EXT_CONFIG_SUPPORT;
> >>>> -	if (pcie_aspm_support_enabled())
> >>>> +	if (IS_ENABLED(CONFIG_PCIEASPM))
> >>>
> >>> Is there any way firmware could tell the difference between
> >>> "CONFIG_PCIEASPM not set" and "CONFIG_PCIEASPM=y and booted with
> >>> 'pcie_aspm=off'"?
> >>>
> >>> If not, why would we even check whether CONFIG_PCIEASPM is set?
> >>
> >> If we announce ASPM support when CONFIG_PCIEASPM=n it'll work as well
> >> but negotiation and the log don't match the fact. We'll get misleading
> >> messages that ASPM is supported by OS by it cannot be enable as there's
> >> no driver.
> >>
> >> As mentioned by the PCIe Firmware Spec r3.3,
> >> "ASPM Optionality supported
> >>  The operating system sets this bit to 1 if it properly recognizes
> >>  and manages ASPM support on PCI Express components which report
> >>  support for ASPM L1 only in the ASPM Support field within the Link
> >>  Capabilities Register. Otherwise, the operating system sets this
> >>  bit to 0"
> > 
> > Yes.  I don't completely understand this bit, but I think it's related
> > to the fact that L0s support was originally required for all links, so
> > the only defined ASPM Support encodings were these:
> > 
> >   01b - L0s supported
> >   11b - L0s and L1 supported
> > 
> > The "ASPM Optionality" ECN [1] of June 19, 2009, added these new
> > encodings:
> > 
> >   00b - No ASPM support
> >   10b - L1 supported
> > 
> > So I think the _OSC "ASPM Optionality Supported" bit tells the
> > firmware that the OS supports this new possibility of devices that
> > support L1 but not L0s.
> > 
> > Linux currently never sets the "ASPM Optionality Supported" bit, but
> > it probably should, because I think we *do* support L1 even if L0s
> > isn't supported.
> 
> Yes, it sounds sensible to me. Actually I intended to refer BIT[1] which we're
> currently using for advertising ASPM support in _OSC, but I copied the wrong
> field...apologize.
> 
> "Active State Power Management supported
> The operating system sets this bit to 1 if it natively supports configuration
> of Active State Power Management registers in PCI Express devices. Otherwise,
> the operating system sets this bit to 0."
> 
> IIUC, CONFIG_PCIEASPM=y means the OS *natively* support ASPM configuration so
> we should set this bit to 1 even if we boot with pcie_aspm=off; otherwise the
> OS has no native support of ASPM the bit should be 0. Currently the _OSC
> negotiation seems to violent the spec a bit when booting with pcie_aspm=off
> on a OS with CONFIG_PCIASPM=y.

We have three cases:

  1) CONFIG_PCIEASPM=y

     Linux allocates ASPM link_state for downstream ports and manages
     ASPM.

  2) CONFIG_PCIEASPM=y and booted with "pcie_aspm=off"

     aspm_support_enabled is false, so Linux does not allocate ASPM
     link_state and does not manage ASPM.  There is no way to change
     aspm_support_enabled at runtime.  pcie_aspm_get_link() always
     returns NULL, so ASPM cannot be enabled by drivers or by the
     sysfs knobs (aspm_ctrl_attrs[]).

  3) CONFIG_PCIEASPM is unset

     aspm.c is not even compiled, so ASPM cannot be enabled by drivers
     or sysfs.

Currently we set OSC_PCI_ASPM_SUPPORT only for case 1.  This patch
would set it for both case 1 and case 2.

But I think case 2 and case 3 are indistinguishable from the
platform's point of view.  The only difference is that case 2 includes
some ASPM code in the image that can never be used.

I think part of the motivation for this patch is that we'd like AER,
hotplug, etc to work even in case 2.  We could make an argument for
doing that, but then AER and hotplug should work even in case 3.

If we want to do that, I think we should do it head-on by relaxing
this test in os_control_query_checks():

  if ((support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT) {
    decode_osc_support(root, "not requesting OS control; OS requires",
		       ACPI_PCIE_REQ_SUPPORT);
    return false;
  }

> >> When CONFIG_PCIEASPM=n we have no aspm driver and apparently cannot
> >> support any ASPM features so we should set the bit to 0 to match the spec.
> > 
> > I think you're saying that firmware could not tell the difference, but
> > the Linux log messages might be slightly misleading.  I assume you
> > mean this message:
> > 
> >   acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> > 
> > where we would claim that we support ASPM even when CONFIG_PCIEASPM is
> > unset.
> > 
> 
> yes. That's what I mean misleading.
> 
> > The purpose of that message is to expose what Linux is telling the
> > platform via _OSC.  If we're telling the platform we support ASPM, I
> > think the message should reflect that.
> > 
> 
> agree.
> 
> > But I'm actually not sure there's real value in advertising ASPM
> > support to the platform when CONFIG_PCIEASPM=y but we're booted with
> > "pcie_aspm=off".  It sounds like this was found by using that option
> > (even though it wasn't *needed*) and finding that Linux didn't request
> > control of other PCIe services.  I don't know if that's worth
> > changing.
> > 
> 
> It's found in one of our test scenes that the AER is not worked. The issue
> is implicit as AER is influenced by the ASPM which it shouldn't be. And
> the implementation of pcie_aspm=off seems don't follow the spec. This patch
> intends to make the code follow the spec in this corner case and by the way
> fixes the issue I met. In the general cases there intends no change.
> 
> For the usage of pcie_aspm=off there may be cases of turning off ASPM when
> the firmware grant the control to the OS. On some platform user may disable
> ASPM through firmware by ACPI FADT, but on other platform OS may always get
> the control of ASPM so this provide a way of disabling it. But I think it's
> not proper to assume user doesn't want other services like AER either.
> 
> Since we haven't met any realistic issue on this boot option, I'd really
> appreciate your suggestions on this.
> 
> Regards,
> Yicong
