Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42495E5371
	for <lists+linux-pci@lfdr.de>; Wed, 21 Sep 2022 20:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiIUS4O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Sep 2022 14:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiIUS4N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Sep 2022 14:56:13 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1380A0634
        for <linux-pci@vger.kernel.org>; Wed, 21 Sep 2022 11:56:11 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1F374300097C6;
        Wed, 21 Sep 2022 20:56:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 01FB74E7FC; Wed, 21 Sep 2022 20:56:09 +0200 (CEST)
Date:   Wed, 21 Sep 2022 20:56:09 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        aaron@sigma-star.at
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 216511] New: Spurious
 PCI_EXP_SLTSTA_DLLSC when hot plugging]
Message-ID: <20220921185609.GA20860@wunner.de>
References: <20220921114020.GA1191462@bhelgaas>
 <20220921180326.GA1221419@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921180326.GA1221419@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 21, 2022 at 01:03:26PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 21, 2022 at 06:40:20AM -0500, Bjorn Helgaas wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=216511
[...]
> Here's the call chain when handling that DLL state change:
> 
>   pciehp_ist
>     pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status)
>     status &= ... PCI_EXP_SLTSTA_DLLSC
>     events |= status
>     if (events & PCI_EXP_SLTSTA_DLLSC)
>       pciehp_handle_presence_or_link_change
>         pciehp_disable_slot
>           __pciehp_disable_slot
>             remove_board
>               pciehp_unconfigure_device
>                 pci_stop_and_remove_bus_device
> 
> Per spec, "software must read the Data Link Layer Link Active bit of
> the Link Status Register to determine if the Link is active before
> initiating configuration cycles to the hot plugged device" (PCIe r6.0,
> sec 7.5.3.11).
> 
> It looks like Linux depends on PCI_EXP_SLTSTA_DLLSC but does not
> actually read PCI_EXP_LNKSTA in this path, so this looks like a pciehp
> defect.

I disagree.  The spec citation pertains to *bringup* of the slot,
but this is the bringdown code path.

The logic in pciehp is such that if we receive DLLSC or PDC and the
slot is up, we always bring it down.  Only then do we check whether
the slot is occupied or link is up.  If that's the case, we attempt
to bring the slot up again.

pciehp assumes that the card may have changed when it receives DLLSC
or PDC.  That's the rationale behind this behavior.

In theory one might think that if DLLSC is received without a concurrent
PDC event, then the card in the slot is still the same and only the
link went down (probably flapped).  Unfortunately the reality is not
that simple:  For one, DLLSC and PDC events may come in arbitrary order
and with quite a delay between them.  Second, there are broken slots
which hardwire PDC to 0 and we support those.  So we can't reliably
determine if presence hasn't changed and only link has.

In this particular case, the PEX switch is clearly broken because it
shouldn't signal DLLSC both for a slot where the link change occurred
and its sibling.

A while ago Jon Derrick submitted a patch for a similar problem:
A bifurcated SSD where bringing down one half of the SSD results
in a spurious DLLSC event for the other half:

https://lore.kernel.org/linux-pci/20210830155628.130054-1-jonathan.derrick@linux.dev/

I'm not really happy with that patch because it adds a quirk
in the middle of the code path for interpreting slot events
which makes it difficult to reason about the code's correctness.

I'm starting to wonder if instead of Jon's patch, we should
just disable DLLSC events on broken devices such as this
PEX switch or Jon's SSD.  We'd only rely on PDC then but
that's probably sufficient.  And the code changes would be
less intrusive.

FWIW, Jon is still interested in upstreaming his quirk:

https://lore.kernel.org/linux-pci/446a21e2-aea2-773f-ca88-b6676b54b292@linux.dev/

@Richard:  I think Jon's patch doesn't solve your issue does it?
Because I think the issue he's seeing is slightly different
albeit likewise caused by unreliable DLLSC.  (His pertains to
bringdown, yours to bringup of the slot it seems.)

Thanks,

Lukas
