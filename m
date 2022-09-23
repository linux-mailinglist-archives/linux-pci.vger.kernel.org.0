Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A475E70B8
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 02:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiIWAi4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 20:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiIWAiz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 20:38:55 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A67D109507;
        Thu, 22 Sep 2022 17:38:44 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 7289392009C; Fri, 23 Sep 2022 02:38:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7002F92009B;
        Fri, 23 Sep 2022 01:38:41 +0100 (BST)
Date:   Fri, 23 Sep 2022 01:38:41 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Sanitise firmware BAR assignments behind a
 PCI-PCI bridge
In-Reply-To: <20220921225342.GA1233029@bhelgaas>
Message-ID: <alpine.DEB.2.21.2209230009020.29493@angie.orcam.me.uk>
References: <20220921225342.GA1233029@bhelgaas>
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

On Wed, 21 Sep 2022, Bjorn Helgaas wrote:

> >  I have trimmed the change description down as you requested and left the 
> > change proper unmodified, as discussed in my earlier response.
> 
> I think this is great.  It shouldn't have taken me this long, so
> thanks for persevering.

 No worries, owing to various distractions it took me way too long to 
iterate over this change too.

> I think we can use pci_upstream_bridge() as below.  Let me know if
> not.

 Based on how the helper has been documented I think you are right.  Also 
I have verified your branch with my hardware and it still works.

> Here it is as I applied to pci/resource for v6.1:

 Thank you!  I find your rewritten change description a pleasure to read.

 I guess at this stage we'll never find out what the exact configuration 
was that has lead to commit 351fc6d1a517 ("PCI: Fix starting basis for 
resource requests").  At least it does not stand in the way.

 What a mess it was with the firmware side of the earlier PCI systems even 
once they've sorted the teething problems of the hardware side!  I still 
need to figure out how to get PCI interrupt routing to automagically work 
in the I/O APIC mode with this x86 machine and its broken MP-table which 
reports PCI interrupts as ISA interrupts, and then INTA only (at least our 
PIRQ router code now handles PCI-to-PCI bridges in the PIC mode).  And it 
would have been so easy to get it right even with a fixed table (the BIOS 
seems to build the table dynamically for no good reason even though the 
wiring is fixed in hardware)!

  Maciej
