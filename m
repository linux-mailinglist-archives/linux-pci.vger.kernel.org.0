Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A446151A957
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 19:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356297AbiEDRRE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 May 2022 13:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358182AbiEDRPo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 13:15:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA0F56425
        for <linux-pci@vger.kernel.org>; Wed,  4 May 2022 09:59:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FDBC61770
        for <linux-pci@vger.kernel.org>; Wed,  4 May 2022 16:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8084FC385B0;
        Wed,  4 May 2022 16:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651683566;
        bh=mNKghIme2ywQvwL7BlzCw6MrK2ZPU84sXX0KFl2hZBU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V9Ea8Eo6WdpTV16tt1QPjeQGxECK+40zE3QX2K+3+SDzlWKmQVMW8VTFfD7M1kdpr
         D/50t5Y2GJLdz4BFsSZrBWgDnL7QRP+uRxJ0sNPA//nkNtUaJcKFQzEeSm+U799Ro7
         f55ooTIHyb53qCZR6z9lz240PgMtO1x2n1UgZsVBiBCaKO63RhrcDi+kisJ4sc1cp4
         cT0htYQpEFDNu2wJkSmOyZcr1UGFXxC+n8SMV9aJC4eXvGNKiQ16hmo0PouJcCPaIE
         JysILwHVgIZK4emymtGoeV5HQEqcim4wo+/GezC3/XGZ0vahSKM4pcfEd0y91r7iya
         SIdAmKBCmYvzA==
Date:   Wed, 4 May 2022 11:59:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Marc Zyngier <maz@kernel.org>, Conor.Dooley@microchip.com,
        lorenzo.pieralisi@arm.com, Daire.McNamara@microchip.com,
        bhelgaas@google.com, Cyril.Jean@microchip.com,
        david.abdurachmanov@gmail.com, linux-pci@vger.kernel.org,
        robh@kernel.org
Subject: Re: [RESEND PATCH v1 1/1] PCI: microchip: Fix potential race in
 interrupt handling
Message-ID: <20220504165924.GA453752@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <199f5479-b212-e1ac-f9e4-d5d13708cb0c@conchuod.ie>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Restoring the context here:

> >>> "ISTATUS" doesn't appear in the code as a register name.
> >>> Neither does "IMSI".  Please use names that match the code.

> Daire is still having the IT issues, so before I resend the patch with
> a new commit message, how is the following:
> 
> Clear the MSI bit in ISTATUS_LOCAL register after reading it, but
> before reading and handling individual MSI bits from the ISTATUS_MSI
> register. This avoids a potential race where new MSI bits may be set
> on the ISTATUS_MSI register after it was read and be missed when the
> MSI bit in the ISTATUS_LOCAL register is cleared.

Looks good, thank you!

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

Agreed, should be a separate patch.  Doesn't need to be a series
unless that patch only applies correctly on top of this one.

Bjorn
