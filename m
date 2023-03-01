Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF306A7279
	for <lists+linux-pci@lfdr.de>; Wed,  1 Mar 2023 19:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCASCC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Mar 2023 13:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCASCB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Mar 2023 13:02:01 -0500
X-Greylist: delayed 17219 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Mar 2023 10:01:59 PST
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4296836095;
        Wed,  1 Mar 2023 10:01:59 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 5722E92009C; Wed,  1 Mar 2023 19:01:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 5061F92009B;
        Wed,  1 Mar 2023 18:01:58 +0000 (GMT)
Date:   Wed, 1 Mar 2023 18:01:58 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     "H. Peter Anvin" <hpa@zytor.com>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PING^3][RESEND^3][PATCH v3] x86/PCI: Add support for the Intel
 82378ZB/82379AB (SIO/SIO.A) PIRQ router
In-Reply-To: <66DC3D77-91AC-4F1B-BE3E-892A9B9980BC@zytor.com>
Message-ID: <alpine.DEB.2.21.2303011734260.59747@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2301081956290.65308@angie.orcam.me.uk> <alpine.DEB.2.21.2303011311540.57556@angie.orcam.me.uk> <66DC3D77-91AC-4F1B-BE3E-892A9B9980BC@zytor.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 1 Mar 2023, H. Peter Anvin wrote:

> >> The Intel 82378ZB System I/O (SIO) and 82379AB System I/O APIC (SIO.A) 
> >> ISA bridges implement PCI interrupt steering with a PIRQ router[1][2] 
> >> that is exactly the same as that of the PIIX and ICH southbridges (or 
> >> actually the other way round, given that the SIO ASIC was there first).
> >
> > Ping for:
> ><https://lore.kernel.org/lkml/alpine.DEB.2.21.2301081956290.65308@angie.orcam.me.uk/>.
> >
> > I think the patch is fairly obvious.  Are there any outstanding concerns 
> >that prevent it from being applied?
> 
> Has this patch been actually tested on a real machine, or is it purely 
> theoretical?

 I have no way to verify it on real x86 hw, my only SIO southbridge is in 
a DEC Alpha machine, so not relevant.

 This is I believe the final Intel device we're missing PIRQ support for, 
and this work was prompted by a user having issues with his network card, 
which ultimately and with a lot of confusion around I was able to narrow 
down to missing PIRQ support rather than any actual issue with hardware.  
At least Nikolai was patient enough to go through all this and I was 
vigilant enough to actually catch the ongoing discussion on netdev in the 
flood.  See: <https://lore.kernel.org/netdev/60B24AC2.9050505@gmail.com/>.

 I'd rather we did not frustrate someone else with something as trivial 
again, but if you think it's not enough for justification to merge this 
change, then I'll accept it.  I'd like such a decision to be explicitly 
stated though rather than assumed by the loss of the patch in mailing list 
noise (I know we're all overloaded with such stuff).

 Thank your for your input.

  Maciej
