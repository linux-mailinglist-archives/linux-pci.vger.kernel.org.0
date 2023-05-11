Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751CF6FFBD9
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 23:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbjEKV1U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 17:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjEKV1T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 17:27:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5403A80;
        Thu, 11 May 2023 14:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30F3265208;
        Thu, 11 May 2023 21:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6CFC433D2;
        Thu, 11 May 2023 21:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683840436;
        bh=MKpx4WeaZw72S2ynWWzQvQwcTmdWNg2PeYSfzsbwLdo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bK6KiGrC+4q2qsi2uzYihFkXJ0nn8ojQgyvD2agyEMBSDLRHgelQCVGLBGjdFd37a
         +OuckV1Ssgr4z3nlPL7TWpDUW8f1eBCovGCMnJpsonD+dau29trINMRFXwGjoY6GjO
         qGQMAfnYsPgKLOIHxUk8iL2oBaye0DAZv3K0sDIK9RP7gawHmimH9dfSdrTXU+Y4J+
         7YU33kTjAcJs3sAhJaEoJ7+i8PZWJ2jkxlVBK5BmPVzp7OUN+ADvP5RxBVXJMYuEoc
         NqqjXlOMbnwTJ1FRoFkC8Mc66sklSHVk6+f2axU5VD7s6yYbkj8Lb5uFfjbfEiFPXl
         MIMFBUSzQ/CqQ==
Date:   Thu, 11 May 2023 16:27:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 01/17] PCI: Add concurrency safe clear_and_set variants
 for LNKCTL{,2}
Message-ID: <ZF1dsvJYYnl8Wv0v@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d5aaff-c7b5-39f6-92ca-319fad6c7fc5@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Emmanuel, Rafael, Heiner, ancient ASPM history]

On Thu, May 11, 2023 at 10:58:40PM +0300, Ilpo Järvinen wrote:
> On Thu, 11 May 2023, Bjorn Helgaas wrote:
> > On Thu, May 11, 2023 at 08:35:48PM +0300, Ilpo Järvinen wrote:
> > > On Thu, 11 May 2023, Bjorn Helgaas wrote:
> > > > On Thu, May 11, 2023 at 04:14:25PM +0300, Ilpo Järvinen wrote:
> > > > > A few places write LNKCTL and LNKCTL2 registers without proper
> > > > > concurrency control and this could result in losing the changes
> > > > > one of the writers intended to make.
> > > > > 
> > > > > Add pcie_capability_clear_and_set_word_locked() and helpers to use it
> > > > > with LNKCTL and LNKCTL2. The concurrency control is provided using a
> > > > > spinlock in the struct pci_dev.
> ...

[beginning of thread is
https://lore.kernel.org/r/20230511131441.45704-1-ilpo.jarvinen@linux.intel.com;
context here is that several drivers clear ASPM config directly,
probably because pci_disable_link_state() doesn't always do it]

> > Many of these are ASPM-related updates that IMHO should not be in
> > drivers at all.  Drivers should use PCI core interfaces so the core
> > doesn't get confused.
> 
> Ah, yes. I forgot to mention it in the cover letter but I noticed that 
> some of those seem to be workarounds for the cases where core refuses to 
> disable ASPM. Some sites even explicit have a comment about that after 
> the call to pci_disable_link_state():
> 
> static void bcm4377_disable_aspm(struct bcm4377_data *bcm4377)
> {
>         pci_disable_link_state(bcm4377->pdev,
>                                PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
> 
>         /*
>          * pci_disable_link_state can fail if either CONFIG_PCIEASPM is disabled
>          * or if the BIOS hasn't handed over control to us. We must *always*
>          * disable ASPM for this device due to hardware errata though.
>          */
>         pcie_capability_clear_word(bcm4377->pdev, PCI_EXP_LNKCTL,
>                                    PCI_EXP_LNKCTL_ASPMC);
> }
> 
> That kinda feels something that would want a force disable quirk that is 
> reliable. There are quirks for some devices which try to disable it but 
> could fail for reasons mentioned in that comment. (But I'd prefer to make 
> another series out of it rather than putting it into this one.)
> 
> It might even be that some drivers don't even bother to make the 
> pci_disable_link_state() call because it isn't reliable enough.

Yeah, I noticed that this is problematic.

We went round and round about this ten years ago [1], which resulted
in https://git.kernel.org/linus/2add0ec14c25 ("PCI/ASPM: Warn when
driver asks to disable ASPM, but we can't do it").

I'm not 100% convinced by that anymore.  It's true that if firmware
retains control of the PCIe capability, the OS is technically not
allowed to write to it, and it's conceivable that even a locked OS
update could collide with some SMI or something that also writes to
it.

I can certainly imagine that firmware might know that *enabling* ASPM
might break because of signal integrity issues or something.  It seems
less likely that *disabling* ASPM would break something, but Rafael [2]
and Matthew [3] rightly pointed out that there is some risk.

But the current situation, where pci_disable_link_state() does nothing
if CONFIG_PCIEASPM is unset or if _OSC says firmware owns it, leads to
drivers doing it directly anyway.  I'm not sure that's better than
making pci_disable_link_state() work 100% of the time, regardless of
CONFIG_PCIEASPM and _OSC.  At least then the PCI core would know
what's going on.

Bjorn

[1] https://lore.kernel.org/all/CANUX_P3F5YhbZX3WGU-j1AGpbXb_T9Bis2ErhvKkFMtDvzatVQ@mail.gmail.com/
[2] https://lore.kernel.org/all/1725435.3DlCxYF2FV@vostro.rjw.lan/
[3] https://lore.kernel.org/all/1368303730.2425.47.camel@x230/
