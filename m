Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550BD523343
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 14:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiEKMmA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 08:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbiEKMl7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 08:41:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F095D3F311
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 05:41:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BADF1ED1;
        Wed, 11 May 2022 05:41:57 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.1.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DE753F66F;
        Wed, 11 May 2022 05:41:56 -0700 (PDT)
Date:   Wed, 11 May 2022 13:41:52 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Conor.Dooley@microchip.com, Daire.McNamara@microchip.com,
        bhelgaas@google.com, Cyril.Jean@microchip.com,
        david.abdurachmanov@gmail.com, linux-pci@vger.kernel.org,
        robh@kernel.org
Subject: Re: [RESEND PATCH v1 1/1] PCI: microchip: Fix potential race in
 interrupt handling
Message-ID: <YnuvENwLpDl4BJXg@lpieralisi>
References: <20220504165924.GA453752@bhelgaas>
 <5afbd996-ba2b-9b12-4ab2-ff3e0c23d1f5@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5afbd996-ba2b-9b12-4ab2-ff3e0c23d1f5@conchuod.ie>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 11, 2022 at 11:00:18AM +0100, Conor Dooley wrote:
> On 04/05/2022 17:59, Bjorn Helgaas wrote:
> > On Wed, May 04, 2022 at 04:12:39PM +0100, Conor Dooley wrote:
> > > On 02/05/2022 20:22, Bjorn Helgaas wrote:
> > > > On Sat, Apr 30, 2022 at 12:33:51AM +0100, Marc Zyngier wrote:
> > > > > On Fri, 29 Apr 2022 22:57:33 +0100,
> > > > > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Fri, Apr 29, 2022 at 09:42:52AM +0000, Conor.Dooley@microchip.com wrote:
> > > > > > > On 28/04/2022 10:29, Lorenzo Pieralisi wrote:
> > > > > > > > On Tue, Apr 05, 2022 at 12:17:51PM +0100, daire.mcnamara@microchip.com wrote:
> > > > > > > > > From: Daire McNamara <daire.mcnamara@microchip.com>
> > > > > > > > > 
> > > > > > > > > Clear MSI bit in ISTATUS register after reading it before
> > > > > > > > > handling individual MSI bits
> > > > 
> > > > > > > Clear the MSI bit in ISTATUS register after reading it, but before
> > > > > > > reading and handling individual MSI bits from the IMSI register.
> > > > > > > This avoids a potential race where new MSI bits may be set on the
> > > > > > > IMSI register after it was read and be missed when the MSI bit in
> > > > > > > the ISTATUS register is cleared.
> > 
> > Restoring the context here:
> > 
> > > > > > "ISTATUS" doesn't appear in the code as a register name.
> > > > > > Neither does "IMSI".  Please use names that match the code.
> > 
> > > Daire is still having the IT issues, so before I resend the patch with
> > > a new commit message, how is the following:
> > > 
> > > Clear the MSI bit in ISTATUS_LOCAL register after reading it, but
> > > before reading and handling individual MSI bits from the ISTATUS_MSI
> > > register. This avoids a potential race where new MSI bits may be set
> > > on the ISTATUS_MSI register after it was read and be missed when the
> > > MSI bit in the ISTATUS_LOCAL register is cleared.
> > 
> > Looks good, thank you!
> 
> Hmm, there's now a response saying that the proposed commit message is
> fine and one saying it isn't. Which is it?

I would like the commit log to contain an explanation of what
ISTATUS_LOCAL reg is there for and how it is related to ISTATUS_MSI
please.

Thanks,
Lorenzo

> > > > > > And speaking of that, I looked at all the users of
> > > > > > irq_set_chained_handler_and_data() in drivers/pci.  All the handlers
> > > > > > except mc_handle_intx() and mc_handle_msi() call chained_irq_enter()
> > > > > > and chained_irq_exit().
> > > > > > 
> > > > > > Are mc_handle_intx() and mc_handle_msi() just really special, or is
> > > > > > this a mistake?
> > > > > 
> > > > > That's just a bug. On the right HW, this would just result in lost
> > > > > interrupts.
> > > 
> > > Separate issue, separate patch. Do you want them in a series or as
> > > another standalone patch?
> > 
> > Agreed, should be a separate patch.  Doesn't need to be a series
> > unless that patch only applies correctly on top of this one.
> 
> Cool, just sent one:
> https://lore.kernel.org/linux-pci/20220511095504.2273799-1-conor.dooley@microchip.com/
> 
> Thanks,
> Conor.
