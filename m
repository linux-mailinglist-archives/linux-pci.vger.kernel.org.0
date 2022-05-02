Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6574451775A
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 21:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbiEBTZ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 15:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiEBTZ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 15:25:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050CBFF0
        for <linux-pci@vger.kernel.org>; Mon,  2 May 2022 12:22:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6C01B819ED
        for <linux-pci@vger.kernel.org>; Mon,  2 May 2022 19:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E077C385AF;
        Mon,  2 May 2022 19:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651519345;
        bh=Hh4AlgPmJhCDXrRtfRBuZb1qLAYQJURmPGPni5vvRoc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FayGj4B+RsJ0ngqhJKdYsr92LCA+jAy/h1wcGghFnQ/9JV3xgPgX/5dOk6spI6yGL
         vFMhZAg1z5eQdPFXFPwyU27gWc/GqfYpezVhR8coHmE+vbWuzm+HtCMLlaA1gtqNYV
         Xf618XD7Pkh9bGiCfd+cns3i/PEcM80n8aJeg+pvvZgk2Nchs0dMhm65JwYMdX9CZ2
         dcy1WuIjeB9xLmSQ5J1N8IzZMIUhtx2kUPRokEXQzpsb0jz0s3AkISLaTq2xXGnubg
         gfuUa+F7FsHJRwKWDUBJbPtursrAy4rzI87zUp4QfSTsycWnkiHGnBLyGyiURhGnGI
         qgKZLAquJhB9A==
Date:   Mon, 2 May 2022 14:22:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Conor.Dooley@microchip.com, lorenzo.pieralisi@arm.com,
        Daire.McNamara@microchip.com, bhelgaas@google.com,
        Cyril.Jean@microchip.com, david.abdurachmanov@gmail.com,
        linux-pci@vger.kernel.org, robh@kernel.org
Subject: Re: [RESEND PATCH v1 1/1] PCI: microchip: Fix potential race in
 interrupt handling
Message-ID: <20220502192223.GA319570@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h76b8nxc.wl-maz@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 30, 2022 at 12:33:51AM +0100, Marc Zyngier wrote:
> On Fri, 29 Apr 2022 22:57:33 +0100,
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Apr 29, 2022 at 09:42:52AM +0000, Conor.Dooley@microchip.com wrote:
> > > On 28/04/2022 10:29, Lorenzo Pieralisi wrote:
> > > > On Tue, Apr 05, 2022 at 12:17:51PM +0100, daire.mcnamara@microchip.com wrote:
> > > >> From: Daire McNamara <daire.mcnamara@microchip.com>
> > > >>
> > > >> Clear MSI bit in ISTATUS register after reading it before
> > > >> handling individual MSI bits

> > > Clear the MSI bit in ISTATUS register after reading it, but before
> > > reading and handling individual MSI bits from the IMSI register.
> > > This avoids a potential race where new MSI bits may be set on the
> > > IMSI register after it was read and be missed when the MSI bit in
> > > the ISTATUS register is cleared.

> > Honestly, I don't understand enough about IRQs to determine whether
> > this is a correct fix.  Hopefully Marc will chime in.  All I really
> > know how to do is compare all the drivers and see which ones don't fit
> > the typical patterns.
> 
> This seems sensible. In general, edge interrupts need an early Ack
> *before* the handler can be run. If it happens after, you're pretty
> much guaranteed to lose edges that would be generated between the
> handler and the late Ack.
> 
> This can be implemented in HW in a variety of ways (read a register,
> write a register, or even both).

Is this something that is or could be documented somewhere under
Documentation, e.g., "here are the common canonical patterns to use"?
I feel like an idiot because I have this kind of question all the time
and I never know how to confidently analyze it.

> > And speaking of that, I looked at all the users of
> > irq_set_chained_handler_and_data() in drivers/pci.  All the handlers
> > except mc_handle_intx() and mc_handle_msi() call chained_irq_enter()
> > and chained_irq_exit().
> > 
> > Are mc_handle_intx() and mc_handle_msi() just really special, or is
> > this a mistake?
> 
> That's just a bug. On the right HW, this would just result in lost
> interrupts.

I wonder if coccinelle or some other static analyzer would be smart
enough to find this kind of error.

Bjorn
