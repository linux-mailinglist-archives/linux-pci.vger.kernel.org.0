Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B3551A7E2
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 19:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355142AbiEDRGG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 May 2022 13:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355708AbiEDREj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 13:04:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B8AD4F452
        for <linux-pci@vger.kernel.org>; Wed,  4 May 2022 09:53:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9F661042;
        Wed,  4 May 2022 09:53:14 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.1.196])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE8E43FA27;
        Wed,  4 May 2022 09:53:12 -0700 (PDT)
Date:   Wed, 4 May 2022 17:53:07 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Conor.Dooley@microchip.com, Daire.McNamara@microchip.com,
        bhelgaas@google.com, Cyril.Jean@microchip.com,
        david.abdurachmanov@gmail.com, linux-pci@vger.kernel.org,
        robh@kernel.org
Subject: Re: [RESEND PATCH v1 1/1] PCI: microchip: Fix potential race in
 interrupt handling
Message-ID: <20220504165307.GA19115@lpieralisi>
References: <20220502192223.GA319570@bhelgaas>
 <199f5479-b212-e1ac-f9e4-d5d13708cb0c@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <199f5479-b212-e1ac-f9e4-d5d13708cb0c@conchuod.ie>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 04, 2022 at 04:12:39PM +0100, Conor Dooley wrote:
> On 02/05/2022 20:22, Bjorn Helgaas wrote:
> > On Sat, Apr 30, 2022 at 12:33:51AM +0100, Marc Zyngier wrote:
> >> On Fri, 29 Apr 2022 22:57:33 +0100,
> >> Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>> On Fri, Apr 29, 2022 at 09:42:52AM +0000, Conor.Dooley@microchip.com wrote:
> >>>> On 28/04/2022 10:29, Lorenzo Pieralisi wrote:
> >>>>> On Tue, Apr 05, 2022 at 12:17:51PM +0100, daire.mcnamara@microchip.com wrote:
> >>>>>> From: Daire McNamara <daire.mcnamara@microchip.com>
> >>>>>>
> >>>>>> Clear MSI bit in ISTATUS register after reading it before
> >>>>>> handling individual MSI bits
> > 
> >>>> Clear the MSI bit in ISTATUS register after reading it, but before
> >>>> reading and handling individual MSI bits from the IMSI register.
> >>>> This avoids a potential race where new MSI bits may be set on the
> >>>> IMSI register after it was read and be missed when the MSI bit in
> >>>> the ISTATUS register is cleared.
> > 
> >>> Honestly, I don't understand enough about IRQs to determine whether
> >>> this is a correct fix.  Hopefully Marc will chime in.  All I really
> >>> know how to do is compare all the drivers and see which ones don't fit
> >>> the typical patterns.
> >>
> >> This seems sensible. In general, edge interrupts need an early Ack
> >> *before* the handler can be run. If it happens after, you're pretty
> >> much guaranteed to lose edges that would be generated between the
> >> handler and the late Ack.
> >>
> >> This can be implemented in HW in a variety of ways (read a register,
> >> write a register, or even both).
> > 
> > Is this something that is or could be documented somewhere under
> > Documentation, e.g., "here are the common canonical patterns to use"?
> > I feel like an idiot because I have this kind of question all the time
> > and I never know how to confidently analyze it.
> 
> Daire is still having the IT issues, so before I resend the patch with
> a new commit message, how is the following:
> 
> Clear the MSI bit in ISTATUS_LOCAL register after reading it, but
> before reading and handling individual MSI bits from the ISTATUS_MSI
> register. This avoids a potential race where new MSI bits may be set
> on the ISTATUS_MSI register after it was read and be missed when the
> MSI bit in the ISTATUS_LOCAL register is cleared.

It is still unclear. You should translate what Marc said above into
how ISTATUS_MSI and ISTATUS_LOCAL work (ie describe how HW works).

Please describe what the registers do and use that to describe
the fix.

Thanks,
Lorenzo

> Reported by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://lore.kernel.org/linux-pci/20220127202000.GA126335@bhelgaas/
> Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip PolarFire PCIe controller driver")
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> > 
> >>> And speaking of that, I looked at all the users of
> >>> irq_set_chained_handler_and_data() in drivers/pci.  All the handlers
> >>> except mc_handle_intx() and mc_handle_msi() call chained_irq_enter()
> >>> and chained_irq_exit().
> >>>
> >>> Are mc_handle_intx() and mc_handle_msi() just really special, or is
> >>> this a mistake?
> >>
> >> That's just a bug. On the right HW, this would just result in lost
> >> interrupts.
> 
> Separate issue, separate patch. Do you want them in a series or as
> another standalone patch?
> 
> Thanks,
> Conor.
