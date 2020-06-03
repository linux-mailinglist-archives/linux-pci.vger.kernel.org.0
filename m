Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CD31ED745
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 22:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgFCUVb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 16:21:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgFCUVb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jun 2020 16:21:31 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EBE220734;
        Wed,  3 Jun 2020 20:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591215690;
        bh=PWG3HcFtvQQHflsr386q04yMi+5dkQJkQgKoI1gUb3w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RCR9xR14UgY9q0yumA2sAhmdyR4D+hs3aFG7TOXTDrAlH2R2h3LjqGHmxgsd0faAL
         TknFRCDsIT+2xAr6ODPSm3gxpiVnwGB8lR9baYJNWNr8NLMsDgN/kbYpLuHrQqKm4M
         BNQ92kYq7OzYUcz4cO7GQSb4fcTAoIPrz+Wu5F8U=
Date:   Wed, 3 Jun 2020 15:21:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: pcie_bus_config settings. What exactly do each setting mean..
Message-ID: <20200603202128.GA931723@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603032354.GA18165@otc-nc-03>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 02, 2020 at 08:23:54PM -0700, Raj, Ashok wrote:
> Hi Bjorn
> 
> I was trying to fix pcie_write_mrrs() since it seems to not follow PCIe
> SIG recommendations. 
> 
> It appears to that 010 (512b) is the default and 4096b is the max spec
> allowed limit.
> 
> Current code seems to match MRRS and MPS, which seem to be completely
> different purposes. 

Yes, I agree that MRRS and MPS have different purposes, and from a
hardware point of view, there's no reason MRRS should be related to
MPS.

The reason Linux tries to set MRRS == MPS is so we can set MPS on
shared paths to be higher than the smallest MPS of the leaves.  For
the leaf with a small MPS, we set MRRS == MPS and assume that is
enough to limit the size of TLPs it receives.  That assumption is true
for *reads* initiated by the leaf, but not it's necessarily true for
*writes* to the leaf, e.g., peer-to-peer writes.

There's a little more explanation here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b03e7495a862

> But trying to fix i got confused with all these pcie_bus_config_types.
> 
> enum pcie_bus_config_types {
>         PCIE_BUS_TUNE_OFF,      /* Don't touch MPS at all */
>         PCIE_BUS_DEFAULT,       /* Ensure MPS matches upstream bridge */
>         PCIE_BUS_SAFE,          /* Use largest MPS boot-time devices support */
>         PCIE_BUS_PERFORMANCE,   /* Use MPS and MRRS for best performance */
>         PCIE_BUS_PEER2PEER,     /* Set MPS = 128 for all devices */
> };
> 
> Not sure what the difference between BUS_TUNE_OFF and BUS_DEFAULT is.

I'm not sure either, but there is a case in pci_configure_mps() where
we test for PCIE_BUS_TUNE_OFF but not BUS_DEFAULT, so it's not
completely obvious that they're identical.

> MPS matching upstream bridge is required in all cases right?

The MRRS trick above is intended to relax this requirement.

> BUS_SAFE/BUS_PERFORMANCE? Not sure why that is special for BUS_DEFAULT.
> 
> Wouldn't it be simple to say:
> 
> BUS_DEFAULT : Just use BIOS settings, no change to anything.
> 
> BUS_SAFE: Says Choose largest MPS boot-time settings? What does that
> actually mean? Why isn't that BUS_PERFORMANCE?
> 
> P2P: Choose smallest setting makes sense.
> 
> I think only 3 settings make sense.
> 
> BUS_DEFAULT == TUNE_OFF : Choose BIOS values, don't touch anything
> BUS_SAFE == BUS_PERFORMANCE : Should actually be the default.
> BUS_PEER2PEER - Same as now
> 
> Do we really have value for the other settings? Maybe for BUS_DEFAULT we
> should call it BUS_BIOS (to indicate real meaning)
> 
> BUS_PERFORMANCE should be the default setting for the system.
> 
> BUS_P2P if someone needs to configure for p2p.

I would love it if somebody reworked this a bit.  I think it's a
little confusing right now.

Bjorn
