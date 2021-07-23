Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C308B3D42E0
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jul 2021 00:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhGWVs1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 17:48:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231742AbhGWVs1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Jul 2021 17:48:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E06B860EB4;
        Fri, 23 Jul 2021 22:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627079340;
        bh=T7Le/8CCLm9Icc27UxNa+tMvL3/7QQcqd6czZheXD9I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=O32nx+kgSaWm0NVRWGEBVKc1qXhRdDUB22Aj5vWxFuPuvbl1oFGkA/S+G5ywN96fl
         oR9estkX01Y9hXgoZH6XykVHsHoL1Pjo4qPF5tlakfdPBuhm7POmVj/jJHGTk+7cJ9
         kaA66sQZIqsMD1FIP/4zv+pgMCucCFJ1ydodn0nWm8ZNvA2b4ea6/226oMHHX4PVE2
         Z1pU5cHCYjdX2HwfZMB+zcr5nGh40xEL/44iZo6d5fpHEIpbrdAH+/PWY473PKXc9w
         Ryv5baA6E8mzO8e0roA5j6j8PIccUazTgZ8HkjBiqc76j8CsZbc5AHZfLRZH+ybhpg
         KYJayioD7LxCQ==
Date:   Fri, 23 Jul 2021 17:28:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     hemantk@codeaurora.org
Cc:     bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
        bjorn.andersson@linaro.org, linux-pci@vger.kernel.org
Subject: Re: Query on ASPM driver design
Message-ID: <20210723222858.GA445474@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c3c904bc19850f667e2249ccdee0b37@codeaurora.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 23, 2021 at 03:04:52PM -0700, hemantk@codeaurora.org wrote:
> On 2021-07-23 13:32, Bjorn Helgaas wrote:
> > On Fri, Jul 23, 2021 at 01:11:18PM -0700, hemantk@codeaurora.org wrote:
> > > I have a question regarding PCIe ASPM driver in upstream. Looks like
> > > current ASPM driver is going to enable ASPM L1 and L1SS based on
> > > EP's config space capability register read. Why ASPM driver is
> > > enabling L1SS based on capability, instead of that can ASPM honor
> > > default control register value (in EP config space) and let pci
> > > device driver probe (or later after probe) to make the decision if
> > > ASPM needs to be enabled or not.
> > 
> > Are you asking why the PCI core makes the decision about enabling ASPM
> > instead of having each device driver decide?
>
> Yes.
>
> > If you want each driver to decide, what benefit would that have?
>
> Basically if PCI EP has capability to support ASPM L1 and L1SS but
> power on default control reg values are meant to enumerate with ASPM
> disabled.  Which means EP wants to keep ASPM disabled right from the
> enumeration, and at some point of time later EP wants to enable the
> ASPM. Main benefit is to give control to EP to enumerate with what
> ever its control reg's power on default value is. EP does not want
> to enable ASPM during its boot up and after entering to mission mode
> use case it would enable the ASPM.

The power-on default value for the "ASPM Control" field in the Link
Control register is 00b, which means ASPM is disabled.  The current
Linux behavior is that when we enumerate the device, we evaluate the
L0s and L1 exit latencies and enable ASPM if the device can tolerate
them.

It sounds like you want to prevent ASPM from being enabled until the
driver explicitly enables it.  Why?  The device should not be active
until a driver claims it, so it should not be a problem to have ASPM
enabled.

> > > Basically point is: it is possible to honor what device control reg
> > > reflects power on default and let the pci ep driver running on host
> > > to make the decision when to enable/disable the aspm in kernel space
> > > pci driver.
> > 
> > There is a pci_disable_link_state() interface that drivers can use to
> > disable certain link states.  Some drivers use this to work around
> > hardware defects, but it would be better to use quirks in that
> > situation.
>
> Thanks for pointing this API, which quirk also uses. But we just
> have disable ver which EP driver can call only after enumeration is
> done. i was thinking of the other way round where EP enumerates and
> then calls enable API at some point of time. Also, if it decides to
> again disable and then enable.

There is currently no pci_enable_link_state() because nobody has
needed it and implemented it.  I would push back a little bit on
adding this because I don't want to encourage drivers to mess with
ASPM.

Bjorn
