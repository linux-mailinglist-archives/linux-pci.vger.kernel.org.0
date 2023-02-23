Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE796A10E1
	for <lists+linux-pci@lfdr.de>; Thu, 23 Feb 2023 20:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBWTxy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Feb 2023 14:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjBWTxx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2023 14:53:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BF542BCE;
        Thu, 23 Feb 2023 11:53:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C454BB81A82;
        Thu, 23 Feb 2023 19:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C28BC433EF;
        Thu, 23 Feb 2023 19:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677182027;
        bh=SSOQNYeYFZZOIjsfPQ19zg07NDj4ObUBeG+UVqlyzNI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WdSg0Yst8gvHcFCTNT9jmxs5GM7Cc64y/gJ4PCOK7I1iItEe+0uPJDMm6LbaE78h7
         z1yfqys+WCwtuHnKllj+b5QKQDJ0skUENW+aeW7u73QlULdT/fGC2ubvP8r9B/JSQ/
         Zncjn+NmuaQRkwu0b4KfAacRGE26fMrXKsN2b/O5KfMlboi0wqdA/JLpykLNFlgeWF
         nLcSM4Fv7mnD5u0PN73jF1zuOsB8eEjUpHGRt7gSXoEjdXkG5YniJqNPomgLP2f3jZ
         F/dl2LrF4Th/QIpi6G8BLCMzpOFVbMUaqbGionZ22jomAbS+LtcnYQmGvqOxI1CNvO
         glws4nYbft3uQ==
Date:   Thu, 23 Feb 2023 13:53:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
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
        linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH RESEND] PCI: s390: Fix use-after-free of PCI bus
 resources with s390 per-function hotplug
Message-ID: <20230223195345.GA3805039@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1793b3cd12921b7a3fa8b3ee7e20b7cf1df1eca1.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lukas]

On Wed, Feb 22, 2023 at 05:54:55PM +0100, Niklas Schnelle wrote:
> On Mon, 2023-02-20 at 13:53 +0100, Niklas Schnelle wrote:
> > On Fri, 2023-02-17 at 17:15 -0600, Bjorn Helgaas wrote:
> > > On Tue, Feb 14, 2023 at 10:49:10AM +0100, Niklas Schnelle wrote:
> ---8<---

> > >   - What about zpci_bus_scan_device()?  Why does it call both
> > >     pci_bus_add_device() and pci_bus_add_devices()?  The latter will
> > >     just call the former, so it looks redundant.  And the latter is
> > >     locked but not the former?
> > 
> > Hmm. great find. This seems to have been weird and redundant since I
> > first used that pattern in 3047766bc6ec ("s390/pci: fix enabling a
> > reserved PCI function"). I think maybe then the reason for this was
> > that prior to 960ac3626487 ("s390/pci: allow zPCI zbus without a
> > function zero") when the newly enabled is devfn == 0 there could be
> > functions from the same bus which would not have been added yet. I'm
> > not sure though. That was definitely the idea behind the
> > zpci_bus_scan_bus() in zpci_scan_configured_devices() that is also
> > redundant now as we can now scan each function as it appears.
> 
> I'm working on cleaning this up but I'm a little confused by what
> exactly needs to be under the pci_rescan_remove lock. For example the
> pci_bus_add_device(virtfn) at the end of pci_iov_add_virtfn() doesn't
> seem to be under the lock while most calls to pci_bus_add_devices()
> are, most prominently the one in acpi_pci_root_add() which I assume is
> what is used on most x86 systems. Any hints?
> 
> Also I think my original thought here might have been a premature worry
> about PCI-to-PCI bridges thinking that adding the new device could lead
> to more devices appearing. Of course actually thinking about it a bit
> more there are quite a few other things that won't work without further
> changes if we wanted to add bridges e.g. we would need to create
> zpci_dev structs for these somewhere.

Hmm.  Good question.  Off the top of my head, I can't explain the
difference between pci_rescan_remove_lock and pci_bus_sem, so I'm
confused, too.  I added Lukas in case he has a ready explanation.

Bjorn
