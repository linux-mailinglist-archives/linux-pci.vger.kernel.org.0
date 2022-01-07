Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DAB487F46
	for <lists+linux-pci@lfdr.de>; Sat,  8 Jan 2022 00:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiAGXQW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 18:16:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41164 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiAGXQV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 18:16:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E253B8278F;
        Fri,  7 Jan 2022 23:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6282C36AE9;
        Fri,  7 Jan 2022 23:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641597379;
        bh=SNR9q17r/H0e04aw9e89ZvRUdghwriL3CG6dv9CdeqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mVBC6/mn4oeY/RScJWRT6MxWvI8neNupySllFKNZo7EJg5BHW41rLR9XhCNNMZf0V
         8NvYmqzFh46mFXreRWKpe+eFuI9EF8nOTppsAkdWWe9Kxqju1o90UwNxJxtPk9Os8/
         6nR04R544JGsEYLYQJxWEySS6C3B2wb1c6iALYuyIeKrzNWVM0qrs6wnlbUuVBPESC
         9ocEMUlyVWuqw8rjbB0+HpEtcJROngQoxVvwmPK2+lmlP8Bd8I0WWdDUhdTzbNAUB5
         B6j1e1Nr17QlE7elC3+wIK/ppUyCNVLdGRU1i0JCZsl9fP6fkNAnof6K79cqjLQ/EI
         KbFDR+pla30TQ==
Date:   Fri, 7 Jan 2022 17:16:17 -0600
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
Message-ID: <20220107231617.GA425878@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220107222826.cv2bzywwayjwzy3c@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 07, 2022 at 11:28:26PM +0100, Pali Rohár wrote:
> On Friday 07 January 2022 15:55:04 Bjorn Helgaas wrote:
> > On Thu, Nov 25, 2021 at 01:45:58PM +0100, Pali Rohár wrote:
> > > Properly propagate failure from mvebu_pcie_add_windows() function back to
> > > the caller mvebu_pci_bridge_emul_base_conf_write() and correctly updates
> > > PCI_IO_BASE, PCI_MEM_BASE and PCI_IO_BASE_UPPER16 registers on error.
> > > On error set base value higher than limit value which indicates that
> > > address range is disabled. 
> > 
> > Does the spec say that if software programs something invalid,
> > hardware should proactively set the base and limit registers to
> > disable the window?
> 
> No. But this patch address something totally different. Software can do
> fully valid operation, e.g. try to set forwarding memory window as large
> as possible. But because this driver "emulates" pci bridge by calling
> software/kernel function (mvebu_pcie_add_windows), some operations which
> in real HW cannot happen, are possible in software.
> 
> For example there are limitations in sizes of forwarding memory windows,
> because it is done by mvebu-mbus driver, which is responsible for
> configuring mapping and forwarding of PCIe I/O and MEM windows. And due
> to Marvell HW, there are restrictions which are not in PCIe HW.
> 
> Currently if such error happens, obviously kernel is not able to set
> PCIe windows and it just print warnings to dmesg. Trying to access these
> windows would result in the worst case in crashes.
> 
> With this change when mvebu_pcie_add_windows() function fails then into
> emulated config space is put information that particular forwarding
> window is disabled. I think that it is better to indicate it in config
> space what is the current "reality" of hardware configuration. If window
> is disabled in real-HW (meaning in mvebu-mbus driver) then show it also
> in emulated config space of pci bridge.
> 
> Do you have better idea what should emulated pci bridge do, if software
> try to set fully valid configuration of forwarding window, but it is not
> possible to achieve it (even compliant PCI bridge must be able to do
> it)?

On an ACPI system, the host bridge window sizes are constrained by the
host bridge _CRS method.  I assume there's a similar constraint in DT.

Is the fact that mvebu_pcie_add_windows() can fail a symptom of a DT
that describes more available space than mvebu-bus can map?

> > I'm not sure I've seen hardware that does this, and it seems ... maybe
> > a little aggressive.
> > 
> > What happens if software writes the base and limit in the wrong order,
> > so the window is invalid after the first write but valid after the
> > second?  That actually sounds like it could be a sensible strategy to
> > prevent a partially-configured window from being active.
> 
> Invalid window (limit < base) means that window is disabled. And
> pci-mvebu.c in its callbacks from pci-bridge-emul.c should correctly
> handle it and propagates information about disablement to mvebu-mbus
> driver.
> 
> After window is valid again (limit > base) then pci-mvebu.c call
> mvebu-mbus to setup new mapping.

Not sure I'm understanding the code correctly.  Here's the sort of
thing I'm worried about, but maybe this is actually impossible:

Let's say software writes (0x00, 0xff) to the I/O (base, limit), which
describes the [io 0x0000-0xffff] window.  If mvebu-mbus can't handle
that, it looks like you set the (base, limit) to (0xf0, 0x0f), which
would describe [io 0xf000-0x0fff], which is invalid.

The software writes 0x40 to the limit, so now we have (0xf0, 0x40), or
[io 0xf000-0x40ff].  That's still invalid, but software thinks the
0x00 it wrote to the base is still there.

Bjorn
