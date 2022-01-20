Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BF24954FE
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 20:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347079AbiATThT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 14:37:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43608 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347128AbiATThQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 14:37:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68127617EA;
        Thu, 20 Jan 2022 19:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF72C340E0;
        Thu, 20 Jan 2022 19:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642707434;
        bh=c6it65oKmRZ6PatH1XXpTi/7Ogh0y9t2s/hbFDPtL3M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eXvdKn6fPxFuwGy7LfaVDY7gscTPyd25WT8nzUTybcidCKhQzvjPaZKdNLWpa1wad
         K6/ljKg+U6Mz0FgkWEBwRpsBDBn6tc8atrLOkzEiRVvVbShG+g10aRYbFh78R+D6pA
         O8N/6tx9JQ12HfRcRJjHqXb8sO3uz2CznirF0zGSzBGHcxiLLMjwfADVJVWL3JMnxi
         8XiC+DTG6zuJEt+i8WPBxcvRtUlzAMCwWMzU3A7UXdAl3NmSsTHUp2IgciWeLtys6O
         zfhtiWzL0m0wMSLZC1+FnEStkkkSZ4f9DjbjLVZF/q/tINafo4DGVpAZ6dXdMzgc8V
         kiX++6uNtDt9A==
Date:   Thu, 20 Jan 2022 13:37:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] PCI: mvebu: Propagate errors when updating
 PCI_IO_BASE and PCI_MEM_BASE registers
Message-ID: <20220120193713.GA1060589@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220120190826.wkhkcx53lmafq2yp@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 20, 2022 at 08:08:26PM +0100, Pali Rohár wrote:
> On Thursday 20 January 2022 11:50:47 Bjorn Helgaas wrote:
> > On Thu, Jan 13, 2022 at 11:35:23AM +0100, Pali Rohár wrote:
> > > On Wednesday 12 January 2022 18:19:21 Bjorn Helgaas wrote:
> > > > On Sat, Jan 08, 2022 at 12:46:58AM +0100, Pali Rohár wrote:
> > > > > On Friday 07 January 2022 17:16:17 Bjorn Helgaas wrote:
> > > > > > On Fri, Jan 07, 2022 at 11:28:26PM +0100, Pali Rohár wrote:
> > > > > > > On Friday 07 January 2022 15:55:04 Bjorn Helgaas wrote:
> > > > > > > > On Thu, Nov 25, 2021 at 01:45:58PM +0100, Pali Rohár wrote:
> > > > > > > > > Properly propagate failure from
> > > > > > > > > mvebu_pcie_add_windows() function back to the caller
> > > > > > > > > mvebu_pci_bridge_emul_base_conf_write() and
> > > > > > > > > correctly updates PCI_IO_BASE, PCI_MEM_BASE and
> > > > > > > > > PCI_IO_BASE_UPPER16 registers on error.  On error
> > > > > > > > > set base value higher than limit value which
> > > > > > > > > indicates that address range is disabled. 

> > Regardless, this means PCI thinks [mem 0xe0000000-0xe7ffffff] is
> > available on bus 00 and can be assigned to devices on bus 00
> > according to the normal PCI rules (BARs aligned on size, PCI
> > bridge windows aligned on 1MB and multiple of 1MB in size).  IIUC,
> > mvebu imposes additional alignment constraints on the bridge
> > windows.
> > 
> > These are the bridge window assignments from your dmesg:
> > 
> > > pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xe00fffff]
> > > pci 0000:00:02.0: BAR 8: assigned [mem 0xe0200000-0xe04fffff]
> > > pci 0000:00:03.0: BAR 8: assigned [mem 0xe0100000-0xe01fffff]
> > 
> > > pci 0000:00:01.0: PCI bridge to [bus 01]
> > > pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe00fffff]
> > > pci 0000:00:02.0: PCI bridge to [bus 02]
> > > pci 0000:00:02.0:   bridge window [mem 0xe0200000-0xe04fffff]
> > > pci 0000:00:03.0: PCI bridge to [bus 03]
> > > pci 0000:00:03.0:   bridge window [mem 0xe0100000-0xe01fffff]
> > 
> > The PCI core knows nothing about the mvebu constraints.  Are we
> > just lucky here that when PCI assigned these bridge windows, they
> > happen to be supported on mvebu?  What happens if PCI decides it
> > needs 29MB on bus 01?
> 
> In this case pci-mvebu.c split 29MB window into continuous ranges of
> power of two (16MB + 8MB + 4MB + 1MB) and then register each range
> to mbus slot. Code is in function mvebu_pcie_add_windows():
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pci-mvebu.c?h=v5.15#n300
> 
> So at the end there is continuous space of 29MB PCIe window, just it
> "eats" 4 mbus slots.
> 
> This function may fail (if there is not enough free mbus slots) and
> this patch is propagating that failure back to the caller.

This failure cannot occur in conforming PCI hardware.  I guess if you
want to propagate the error from mvebu_pcie_add_windows() back to
mvebu_pci_bridge_emul_base_conf_write() and do something there, I'm OK
with that.

But change the commit log so it doesn't say "... and correctly update
PCI_IO_BASE, PCI_MEM_BASE and PCI_IO_BASE_UPPER16" because this is
completely device-specific behavior and is not "correct" per any PCI
spec.

Instead, say something about how mvebu doesn't support arbitrary
windows and we're disabling the window completely if we can't provide
what's requested.  

Maybe this error warrants a clue in dmesg?  How would a user figure
out what's going on in this situation?  From the patch, it looks like
we would assign resources to a device, but the device just would not
work because the root port window was silently disabled?

Bjorn
