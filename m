Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B558A33676
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2019 19:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfFCRWt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jun 2019 13:22:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728903AbfFCRWt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Jun 2019 13:22:49 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35A6824C34;
        Mon,  3 Jun 2019 17:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559582568;
        bh=m0c/8JcFUckNJFkz15Q5J1w/EVegsKZJsLr7Fax2zA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FVBwrdqKBKoPlJXO30OviEZLYdX77wsHDwzw4SIctDxTLeEVYLmHVG5EoOg9NvXdu
         +iP5zmJOrg/eVs0K0SSz97Eg90OfN71PbpzcGzr6+VH0jQ0ZkM4TalnsxQBdMwFeZa
         3vurzZmUXDszgBZMC8Zu7Sms2Rd1eHRIfpuTnjOw=
Date:   Mon, 3 Jun 2019 12:22:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Abhishek Sahu <abhsahu@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] PCI: Create device link for NVIDIA GPU
Message-ID: <20190603172246.GC189360@google.com>
References: <20190531050109.16211-1-abhsahu@nvidia.com>
 <20190531050109.16211-3-abhsahu@nvidia.com>
 <20190531203908.GA58810@google.com>
 <d0824334-99f2-d42e-3a5e-3bdc4c1c37c8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0824334-99f2-d42e-3a5e-3bdc4c1c37c8@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, just FYI]

On Mon, Jun 03, 2019 at 01:30:51PM +0530, Abhishek Sahu wrote:
> On 6/1/2019 2:09 AM, Bjorn Helgaas wrote:
> > On Fri, May 31, 2019 at 10:31:09AM +0530, Abhishek Sahu wrote:
> >> NVIDIA Turing GPUs include hardware support for USB Type-C and
> >> VirtualLink. It helps in delivering the power, display, and data
> >> required to power VR headsets through a single USB Type-C connector.
> >> The Turing GPU is a multi-function PCI device has the following
> >> four functions:
> >>
> >> 	- VGA display controller (Function 0)
> >> 	- Audio controller (Function 1)
> >> 	- USB xHCI Host controller (Function 2)
> >> 	- USB Type-C USCI controller (Function 3)
> >>
> >> The function 0 is tightly coupled with other functions in the
> >> hardware. When function 0 goes in runtime suspended state,
> >> then it will do power gating for most of the hardware blocks.
> >> Some of these hardware blocks are used by other functions which
> >> leads to functional failure. So if any of these functions (1/2/3)
> >> are active, then function 0 should also be in active state.
> > 
> >> 'commit 07f4f97d7b4b ("vga_switcheroo: Use device link for
> >> HDA controller")' creates the device link from function 1 to
> >> function 0. A similar kind of device link needs to be created
> >> between function 0 and functions 2 and 3 for NVIDIA Turing GPU.
> > 
> > I can't point to language that addresses this, but this sounds like a
> > case of the GPU not conforming to the PCI spec.  The general
> > assumption is that the OS should be able to discover everything it
> > needs to do power management directly from the architected PCI config
> > space.
> 
>  The GPU is following PCIe spec but following is the implementation
>  from HW side

Unless you can find spec language that talks about D-state
dependencies between functions, I claim this is not following the
PCIe spec.  For example, PCIe r5.0, sec 1.4, says "the PCI/PCIe
hardware/software model includes architectural constructs necessary to
discover, configure, and use a Function, without needing Function-
specific knowledge." Sec 5.1 says "D states are associated with a
particular Function" and "PM provides ... a mechanism to identify
power management capabilities of a given Function [and] the ability to
transition a Function into a certain power management state."

If there *is* something about dependencies between functions in the
spec, we should improve the generic PCI core to pay attention to that,
and then we wouldn't need this quirk.

If the spec doesn't provide a way to discover them, these dependencies
are exceptions from the spec, and we have to handle them as hardware
defects, using quirks like this.  That's fine, but let's not pretend
that this is a conforming device and that adding quirks is the
expected process.  Just call a spade a spade and say we're working
around a defect in this particular device.

I think the best path forward would be to add this quirk for the
existing device, and then pursue a spec change to add something like
a new PCIe capability to describe the dependencies.  Then we could
enhance the PCI core once and power management for future devices
would "Just Work" without having to add quirks.

Bjorn
