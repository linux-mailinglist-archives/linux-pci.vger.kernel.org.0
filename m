Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3680C1C7C71
	for <lists+linux-pci@lfdr.de>; Wed,  6 May 2020 23:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgEFV3u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 17:29:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbgEFV3t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 May 2020 17:29:49 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC31C2070B;
        Wed,  6 May 2020 21:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588800589;
        bh=XMODf73qdY1pBEPZqbcgGU49OOeQf5NflglZA7mOg1k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=w6td1PRYmzZANGSumMXG6yHUCkJNf+vnnBIWMD2l2XCpZmt52cK9zt6pbuF/L9UIP
         VZlkXyQ0axjjAOeLIngA/ZzOBG7WL/7VQ87UR62+MTc5wAX2d7aQvfIYv/9eBPIAeE
         j0uRIcv/zrrP0lXbNDHjR4FdNzAcUINFXweFhgoc=
Date:   Wed, 6 May 2020 16:29:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] PCI/ASPM: Enable ASPM for bridge-to-bridge link
Message-ID: <20200506212947.GA455758@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506061438.GR487496@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 06, 2020 at 09:14:38AM +0300, Mika Westerberg wrote:
> On Wed, May 06, 2020 at 01:34:21AM +0800, Kai-Heng Feng wrote:
> > The TI PCIe-to-PCI bridge prevents the Intel SoC from entering power
> > state deeper than PC3 due to disabled ASPM, consumes lots of unnecessary
> > power. On Windows ASPM L1 is enabled on the device and its upstream
> > bridge, so it can make the Intel SoC reach PC8 or PC10 to save lots of
> > power.
> > 
> > In short, ASPM always gets disabled on bridge-to-bridge link.
> 
> Excelent finding :) I've heard several reports complaining that we can't
> enter PC10 when TBT is enabled and I guess this explains it.

I'm curious about this.  I first read this patch as affecting
garden-variety Links between a Root Port or Downstream Port and the
Upstream Port of a switch.  But the case we're talking about is
specifically when the downstream device is PCI_EXP_TYPE_PCI_BRIDGE,
i.e., a PCIe to PCI/PCI-X bridge, not a switch.

AFAICT, a Link to a PCI bridge is still a normal Link and ASPM should
still work.  I'm sort of surprised that you'd find such a PCIe to
PCI/PCI-X bridge in a Thunderbolt topology, but maybe that's a common
thing?

I guess "PC8" and "PC10" are some sort of Intel-specific power states?

> > The special case was part of first ASPM introduction patch, commit
> > 7d715a6c1ae5 ("PCI: add PCI Express ASPM support"). However, it didn't
> > explain why ASPM needs to be disabled in special bridge-to-bridge case.
> > 
> > Let's remove the the special case, as PCIe spec already envisioned ASPM
> > on bridge-to-bridge link.
> > 
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207571
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
