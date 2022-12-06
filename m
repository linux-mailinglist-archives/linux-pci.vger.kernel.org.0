Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD2C644A49
	for <lists+linux-pci@lfdr.de>; Tue,  6 Dec 2022 18:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbiLFR0J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Dec 2022 12:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiLFR0I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2022 12:26:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A813AC10;
        Tue,  6 Dec 2022 09:26:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F67B615FC;
        Tue,  6 Dec 2022 17:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEADC433D6;
        Tue,  6 Dec 2022 17:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670347566;
        bh=i4LFHgRC3eGQ/h/gsi4nG4EfbOLbqNKtWfgCfmTwX0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PRHv0B5xJ2GAr1bKgFD8L8KIUI75dpWUvoOl1JkwpcMZpMsZb7mrYf7WUgZQV6f1B
         vMo94bzvnSOKsXr2LQT8u0cwgAe+00mfYbwEJB68Xvajf8VrALHJdAmlB1CJXkRRxg
         /dMDgIxn2/IYXp9stpunIJGl3XjA1iUaJjht0UVB3eN6M89zftjSJyjAEV6SFEw4yq
         SCDJkA3XSCd5yiVePRgsWet6+hxP2Ro4qCebopzCo5+r979Q4aX638QYjCIOddc6zV
         UoaFSci2x1r+YOg7PssexvqUKZGyK29RTwLHHT+Tsj8H7/1330DjYrM9u/2muuimRg
         J3SzBtVTwPEZg==
Date:   Tue, 6 Dec 2022 11:26:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linuxkernelml@undead.fr,
        Florent DELAHAYE <kernelorg@undead.fr>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: Disable E820 reserved region clipping for Clevo
 NL4XLU laptops
Message-ID: <20221206172604.GA1356368@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9faa7393-a985-52f6-4ceb-f853c0210a71@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 04, 2022 at 10:42:38AM +0100, Hans de Goede wrote:
> On 12/2/22 22:58, Bjorn Helgaas wrote:
> > On Wed, Oct 12, 2022 at 10:23:12AM +0200, Hans de Goede wrote:
> >> On 10/11/22 19:40, Bjorn Helgaas wrote:
> >>> On Mon, Oct 10, 2022 at 05:02:06PM +0200, Hans de Goede wrote:
> >>>> Clevo NL4XLU barebones have the same E820 reservation covering
> >>>> the entire _CRS 32-bit window issue as the Lenovo *IIL* and
> >>>> Clevo X170KM-G models, relevant dmesg bits (with pci=no_e820):
> >>>> ...
> >>>> Add a no_e820 quirk for these models to fix the touchpad not working
> >>>> (due to Linux being unable to assign a PCI BAR for the i2c-controller).
> ...

> As I mentioned in the email-thread about that patch-series (and there
> now is dmesg E820 output to confirm this) your generic fix will
> unfortunately only work when people boot in EFI mode. It will still
> be good to have the generic fix of course.
> 
> But maybe we should also add this quirk to make sure these
> Clevo-s also work properly when booted in BIOS CSM mode ?

Yes, if they can boot in CSM mode, we should probably add the quirk.
But Florent doesn't see a way to boot his Clevo NL41LU2/NL4XLU in CSM
mode, so I think we can postpone adding the quirk until we find a
machine where it makes a difference:

  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1948811/comments/8

I added a note to https://bugzilla.kernel.org/show_bug.cgi?id=216565
to that effect.

> >>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216565
> >>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>>> ---
> >>>>  arch/x86/pci/acpi.c | 13 +++++++++++++
> >>>>  1 file changed, 13 insertions(+)
> >>>>
> >>>> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> >>>> index 2f82480fd430..45ef65d31a40 100644
> >>>> --- a/arch/x86/pci/acpi.c
> >>>> +++ b/arch/x86/pci/acpi.c
> >>>> @@ -189,6 +189,19 @@ static const struct dmi_system_id pci_crs_quirks[] __initconst = {
> >>>>  			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> >>>>  		},
> >>>>  	},
> >>>> +
> >>>> +	/*
> >>>> +	 * Clevo NL4XLU barebones have the same E820 reservation covering
> >>>> +	 * the entire _CRS 32-bit window issue as the Lenovo *IIL* models.
> >>>> +	 * See https://bugzilla.kernel.org/show_bug.cgi?id=216565
> >>>> +	 */
> >>>> +	{
> >>>> +		.callback = set_no_e820,
> >>>> +		.ident = "Clevo NL4XLU Barebone",
> >>>> +		.matches = {
> >>>> +			DMI_MATCH(DMI_BOARD_NAME, "NL4XLU"),
> >>>> +		},
> >>>> +	},
> >>>>  	{}
> >>>>  };
