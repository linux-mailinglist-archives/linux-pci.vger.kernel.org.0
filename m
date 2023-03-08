Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0635D6B1126
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 19:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCHSiM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 13:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCHSiK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 13:38:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E155231DD;
        Wed,  8 Mar 2023 10:38:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E57A86190C;
        Wed,  8 Mar 2023 18:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B15BC433D2;
        Wed,  8 Mar 2023 18:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678300686;
        bh=hcpPy5S4b/mXtJFXPlOFcclMoVUSqnrUljrAkNT6eYE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=R8I/rAYhr/vtRfp0FpY2SA1ctG+/r1jdn7TvZMZPVXgIxMwonR4lHm2f9l2nsFC9v
         HCK6hWbE2CyhEhr2kWmjoq0H5+2rJdwFWe13F3j3E+OqNmEun5RW/kRZn3e3quJz9l
         StL3x9ELOKwK61ixvTNL4cQohEqYxTG+7158QJF1IVkEbMEDm1vgrrdSRaEK85HHMA
         tUSjETBnRCORAP5jeDtk9LwR9XB8vDQ4mKH096gxg/WZgjiwtyLtqfaXCknA6sPHNl
         WFvi2EhoCLQdibdB+qK3w6j4BNSmyVHyaG5uU2zXPPK6v01tC1hAka6jUgcccPxJly
         yM6URIA0H1wjA==
Date:   Wed, 8 Mar 2023 12:38:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Gerd Bayer <gbayer@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI: s390: Fix use-after-free of PCI bus
 resources with s390 per-function hotplug
Message-ID: <20230308183804.GA1028912@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bf4ca0f643bcd59f5761cdd29403433046a9995.camel@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 28, 2023 at 10:08:45AM +0100, Niklas Schnelle wrote:
> On Fri, 2023-02-24 at 05:19 +0100, Lukas Wunner wrote:
> > On Thu, Feb 23, 2023 at 01:53:45PM -0600, Bjorn Helgaas wrote:
> > > Hmm.  Good question.  Off the top of my head, I can't explain the
> > > difference between pci_rescan_remove_lock and pci_bus_sem, so I'm
> > > confused, too.  I added Lukas in case he has a ready explanation.
> > 
> > pci_bus_sem is a global lock which protects the "devices" list of all
> > pci_bus structs.
> > 
> > We do have a bunch of places left where the "devices" list is accessed
> > without holding pci_bus_sem, though I've tried to slowly eliminate
> > them.
> > 
> > pci_rescan_remove_lock is a global "big kernel lock" which serializes
> > any device addition and removal.
> > 
> > pci_rescan_remove_lock is known to be far too course-grained and thus
> > deadlock-prone, particularly if hotplug ports are nested (as is the
> > case with Thunderbolt).  It needs to be split up into several smaller
> > locks which protect e.g. allocation of resources of a bus (bus numbers
> > or MMIO / IO space) and whatever else needs to be protected.  It's just
> > that nobody has gotten around to identify what exactly needs to be
> > protected, adding the new locks and removing pci_rescan_remove_lock.
> 
> Thanks for the insights. So from that description I think it might make
> sense to do this fix patch with the pci_rescan_remove_lock so it can be
> backported. Then we can take the opportunity to add a lock specific to
> the allocation/freeing of resources which would then replace at least
> this new directly and clearly resource related use of
> pci_rescan_remove_lock and potentially others we find.
> What do you think?

I don't think Lukas was suggesting that *you* need to split the
locking up, just that it *should* be split up someday.  To me, that
looks like a project on its own that is beyond the scope of this
particular fix, so I think the pci_lock_rescan_remove() as you have it
here is fine for now.

When you fix up the superfluous "return", go ahead and add my

  Acked-by: Bjorn Helgaas <bhelgaas@google.com>

to your patch.  I assume it's easier for you to shepherd this through
the s390 tree, but let me know if you'd rather that I take it.

Bjorn
