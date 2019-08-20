Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 484C89623B
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 16:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbfHTORU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 10:17:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730311AbfHTORT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Aug 2019 10:17:19 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF011214DA;
        Tue, 20 Aug 2019 14:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566310638;
        bh=RWO+Z7EYfkN5R0lUrg61fH6+d9Xpwe8gRrkmQsB2ugY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/5BNqzTStbsIw/eUIhPJaXaXdCAZEjfrnB+fza6b8Nln2LZyyqIWHyGALYs3aWXC
         Si8ZDuHh7EnMK44b7Iq5aoO0IcEY+MUU600Tr5WYFQhKBQTqxzogwP44MfUY0LfoFr
         B5ZszVgS9LEOltJFjgbSJltb6VaDE/57q+PFkHsM=
Date:   Tue, 20 Aug 2019 09:17:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add sysfs attribute for disabling PCIe link to
 downstream component
Message-ID: <20190820141717.GA14450@google.com>
References: <20190529104942.74991-1-mika.westerberg@linux.intel.com>
 <20190703133953.GK128603@google.com>
 <20190703150341.GW2640@lahna.fi.intel.com>
 <20190801215339.GF151852@google.com>
 <20190806101230.GI2548@lahna.fi.intel.com>
 <20190819235245.GX253360@google.com>
 <20190820095820.GD19908@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820095820.GD19908@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 20, 2019 at 12:58:20PM +0300, Mika Westerberg wrote:
> On Mon, Aug 19, 2019 at 06:52:45PM -0500, Bjorn Helgaas wrote:
> > > Right, it looks like we need some sort of flag there anyway.
> > 
> > Does this mean you're looking at getting rid of "has_secondary_link",
> > you think it's impossible, or you think it's not worth trying?
> 
> I was of thinking that we need some flag anyway for the downstream port
> (such as has_secondary_link) that tells us the which side of the port
> the link is.
> 
> > I'm pretty sure we could get rid of it by looking upstream, but I
> > haven't actually tried it.
> 
> So if we are downstream port, look at the parent and if it is also
> downstream port (or root port) we change the type to upstream port
> accordingly? That might work.

If we see a type of PCI_EXP_TYPE_ROOT_PORT or
PCI_EXP_TYPE_PCIE_BRIDGE, I think we have to assume that's accurate
(which we already do today -- for those types, we assume the device
has a secondary link).

For a device that claims to be PCI_EXP_TYPE_DOWNSTREAM, if a parent
device exists and is a Downstream Port (Root Port, Switch Downstream
Port, and I suppose a PCI-to-PCIe bridge (this is basically
pcie_downstream_port()), this device must actually be acting as a
PCI_EXP_TYPE_UPSTREAM device.

If a device claiming to be PCI_EXP_TYPE_UPSTREAM has a parent that is
PCI_EXP_TYPE_UPSTREAM, this device must actually be a
PCI_EXP_TYPE_DOWNSTREAM port.

For PCI_EXP_TYPE_DOWNSTREAM and PCI_EXP_TYPE_UPSTREAM devices that
don't have parents, we just have to assume they advertise the correct
type (as we do today).  There are sparc and virtualization configs
like this.

> Another option may be to just add a quirk for these ports.

I don't really like the quirk approach because then we have to rely on
user reports of something being broken.

> Only concern for both is that we have functions that rely on the type
> such as pcie_capability_read_word() so if we change the type do we end
> up breaking something? I did not check too closely, though.

I don't think we'll break anything that's not already broken because
the type will reflect exactly what has_secondary_link now tells us.
In fact, we might *fix* some things, e.g., pcie_capability_read_word()
should work better if we fix the type that pcie_downstream_port()
checks.

> I'm willing to cook a patch that fixes this once we have some consensus
> what it should do ;-)
