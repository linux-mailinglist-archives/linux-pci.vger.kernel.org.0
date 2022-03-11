Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB2A4D661B
	for <lists+linux-pci@lfdr.de>; Fri, 11 Mar 2022 17:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350396AbiCKQ0s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Mar 2022 11:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350345AbiCKQ0g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2022 11:26:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163D01BA17F;
        Fri, 11 Mar 2022 08:25:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74FBB61BDF;
        Fri, 11 Mar 2022 16:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C1CC340F9;
        Fri, 11 Mar 2022 16:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647015900;
        bh=aeMzJEZ9sFNCdhritR/EtuJ7IxGKXNGHHq3QcZWtA7Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E6eHbcUTeiM6GjK/GG2GVEFfaaNefS9Ukh65vGoMYE/f7esyLLb1aF7QuKdlKfmys
         D+9Kj5SNr0ULXP+YxEmus4//yoE8HLmOqLeFEolcGSReXSToMphFquMW30JDt1KT+8
         jt0nS+MSKybnCwLwZE4D9odaQSjEjMjr9nTRfB5Vtb/0ckYupweM582QHUw+bUUsgD
         3Tc13TpqhuF1RDDSIfHnGpmz9/y12iTVDbn3ObtfKASNQWHOGcLXB16xH3Gq8cCo9B
         L5VA3QIiq3DbmVXThX+ILr66wcNYphWC2E80hAitsTZXTjcwIXoU5F/43I5ErilDZ8
         eeA4tkA2cyaag==
Date:   Fri, 11 Mar 2022 10:24:59 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, wse@tuxedocomputers.com,
        Matt Hansen <2lprbe78@duck.com>
Subject: Re: [PATCH 3/3] x86/PCI: Preserve host bridge windows completely
 covered by E820
Message-ID: <20220311162459.GA304957@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03675c75-ee6f-5da3-099c-2b82a1865455@redhat.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Matt]

On Fri, Mar 11, 2022 at 08:52:31AM +0100, Hans de Goede wrote:
> On 3/10/22 13:28, Hans de Goede wrote:
> > On 3/9/22 19:15, Bjorn Helgaas wrote:
> >> On Sat, Mar 05, 2022 at 11:37:23AM +0100, Hans de Goede wrote:
> >>> On 3/4/22 16:46, Hans de Goede wrote:
> >>>> On 3/4/22 16:32, Bjorn Helgaas wrote:
> >>>>> On Fri, Mar 04, 2022 at 03:16:42PM +0100, Hans de Goede wrote:
> >>>>>> On 3/4/22 04:51, Bjorn Helgaas wrote:
> >>>>>>> From: Bjorn Helgaas <bhelgaas@google.com>
> >>>>>>>
> >>>>>>> Many folks have reported PCI devices not working.  It could affect any
> >>>>>>> device, but most reports are for Thunderbolt controllers on Lenovo Yoga and
> >>>>>>> Clevo Barebone laptops and the touchpad on Lenovo IdeaPads.
> >>>>>>> ...
> >>
> >>>>>>> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
> >>>>>>> index 7378ea146976..405f0af53e3d 100644
> >>>>>>> --- a/arch/x86/kernel/resource.c
> >>>>>>> +++ b/arch/x86/kernel/resource.c
> >>>>>>> @@ -39,6 +39,17 @@ void remove_e820_regions(struct device *dev, struct resource *avail)
> >>>>>>>  		e820_start = entry->addr;
> >>>>>>>  		e820_end = entry->addr + entry->size - 1;
> >>>>>>>  
> >>>>>>> +		/*
> >>>>>>> +		 * If an E820 entry covers just part of the resource, we
> >>>>>>> +		 * assume E820 is telling us about something like host
> >>>>>>> +		 * bridge register space that is unavailable for PCI
> >>>>>>> +		 * devices.  But if it covers the *entire* resource, it's
> >>>>>>> +		 * more likely just telling us that this is MMIO space, and
> >>>>>>> +		 * that doesn't need to be removed.
> >>>>>>> +		 */
> >>>>>>> +		if (e820_start <= avail->start && avail->end <= e820_end)
> >>>>>>> +			continue;
> >>>>>>> +
> >>>>>>
> >>>>>> IMHO it would be good to add some logging here, since hitting this is
> >>>>>> somewhat of a special case. For the Fedora test kernels I did I changed
> >>>>>> this to:
> >>>>>>
> >>>>>> 		if (e820_start <= avail->start && avail->end <= e820_end) {
> >>>>>> 			dev_info(dev, "resource %pR fully covered by e820 entry [mem %#010Lx-%#010Lx]\n",
> >>>>>> 				 avail, e820_start, e820_end);
> >>>>>> 			continue;
> >>>>>> 		}
> >>>>>>
> >>>>>> And I expect/hope to see this new info message on the ideapad with the
> >>>>>> touchpad issue.
> >>
> >> I added this logging.
> >>
> >>> So I just got the first report back from the Fedora test 5.16.12 kernel
> >>> with this series added. Good news on the ideapad this wotks fine to
> >>> fix the touchpad issue (as expected).
> >>
> >> Any "Tested-by" I could add?  If we can, I'd really like to give some
> >> credit to the folks who suffered through this and helped resolve it.
> > 
> > Good point, the reporter of:
> > https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> > 
> > has done most of the ideapad with touchpad issues testing for me
> > and has been very helpful. I agree he deserves credit for this.
> > 
> > I've asked him if he is ok with adding a Tested-by tag and if yes,
> > which email we should use.
> 
> If you can add the following tag that would be great:
> 
> Tested-by: Matt Hansen <2lprbe78@duck.com>

Done, thank you very much, Matt!  Many people will benefit from your
work.
