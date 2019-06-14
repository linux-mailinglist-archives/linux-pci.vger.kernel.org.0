Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4D1745AC8
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 12:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfFNKnf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 06:43:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:57940 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfFNKnf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 06:43:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5EAhJFG009086;
        Fri, 14 Jun 2019 05:43:20 -0500
Message-ID: <84320a45ef9395d82bf1c5d4d2d7e6db189cbfda.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH v2] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 14 Jun 2019 20:43:19 +1000
In-Reply-To: <906b2576756e82a54b584c3de2d8362602de07ce.camel@kernel.crashing.org>
References: <5783e36561bb77a1deb6ba67e5a9824488cc69c6.camel@kernel.crashing.org>
         <20190613190248.GH13533@google.com>
         <e6c7854ae360be513f6f43729ed6d4052e289376.camel@kernel.crashing.org>
         <CAKv+Gu95pQ7_OfLbEXHZ_bhYnqOgTBKCmTgqUY27un-Y708BgQ@mail.gmail.com>
         <d5d3e7b9553438482854c97e09543afb7de23eaa.camel@kernel.crashing.org>
         <20190614095742.GA27188@e121166-lin.cambridge.arm.com>
         <906b2576756e82a54b584c3de2d8362602de07ce.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2019-06-14 at 20:36 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2019-06-14 at 10:57 +0100, Lorenzo Pieralisi wrote:
> > > Also using "probe_only" for _DSM #5 = 0 isn't a good idea, at least as
> > > implemented today in the rest of the kernel, probe_only also means we
> > > shouldn't assign what was left unassigned. However _DSM #5 allows this.
> > 
> > I am not sure about this. PCI_PROBE_ONLY cannot stop an OS from
> > reassigning BARs that are clearly misconfigured, it does not make
> > any sense.
> 
> PCI_PROBE_ONLY is a linux thing which, as implemented today, implies no
> assignment at all. I believe it originates as a merge of variants of
> the same thing, at least one of them being one I created for powerpc
> back in the days due to our proprietary hypervisor not letting you
> touch any of the PCI config space.

Well... you could "touch" things and even BAR size but mostly we don't
even do that on powerpc on these systems these days, we read the BAR
values (and a bunch of other things) from OFW and manufacture the
pci_dev. The generic code still use cfg space to fill up the blanks.
sparc64 uses the same technique.

This least to another conversation we hinted at earlier.. we should
probably have a way to do the same at least for BARs on ACPI systems so
we don't have to temporarily disable access to a device to size them.

This can be problematic is the device in question need to be used
during the sizing. It can happen with some system devices used behind
the scene by FW, or the device on which the console is (how many time
did I crash bcs I had too verbose printk's in the PCI code during BAR
sizing of the framebuffer or the serial card...)

Cheers,
Ben.


