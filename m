Return-Path: <linux-pci+bounces-16565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D37379C5FB3
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 18:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9CC5B2BD30
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 16:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F25320409D;
	Tue, 12 Nov 2024 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBarR9QI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CC51F7068;
	Tue, 12 Nov 2024 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427716; cv=none; b=ttqlGAhV67vT8gEVHvrlWlRr62pTl4lWEgZgYh2LXPcypeFNyNkNVeqTkNi4Fp0Z2fxgFedSIlPFZaNlY8ZENBYuP9on+tQGuDAtQa/v7yqjJ2ORmWU7dmrRKgrkVJz8MfIPj5nmQwaGijVo7gmxLiMvh46mZddW1G1S07LOW2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427716; c=relaxed/simple;
	bh=4/3U7giMwfegq1WrWjsH7KAiGA60faNeJ9nAsc/0ZQM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WxFGTh28M6yR7AHWgO2I6r6FvNSWaFpa+UxVlag27vfrUpqAQC8qJXQR97TiQMAWY64jDK+zX253CCa9K9UiChxjGHBy0KjmFs1Hxxq048v7ItXOD4fskuAZg4J7RZlNh/4sjRrPxveEkDa63ZJ73eMlQLCBFHEkgCapBopWSb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBarR9QI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC89C4CECD;
	Tue, 12 Nov 2024 16:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731427714;
	bh=4/3U7giMwfegq1WrWjsH7KAiGA60faNeJ9nAsc/0ZQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qBarR9QIQ7lfKBsN085qYcbiHiMDAJe38izCwS4bVr8PoNcOgOWPKLODJhjufAF7Y
	 10/xo8Epsf2NUEuKi0xM7yI2ewuIrVjqZEMaN5I6z5B1doxYm1USGhLhOrxbjDfn9t
	 AC8PQCvEXoBoY8SixtPLsgEdufNZN7B9Bou+66cH6MVQ9AFyO1+r0EjuC1p8yUCziS
	 ekNEq4qgXSF7CzNuA2qjQzpgGMifciFXUWha41w3mxS8h8cQW/KmO9IjIVmiaIzZo2
	 LZ9cSA88QcwwQj8rclF7NUtLgdIpEvrFWKo5L6bSrZsWiVno7tEa6v6Id607TyQ+Q8
	 wa8RGVXubeHbA==
Date: Tue, 12 Nov 2024 10:08:33 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shijith Thotton <sthotton@marvell.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"scott@os.amperecomputing.com" <scott@os.amperecomputing.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Srujana Challa <schalla@marvell.com>,
	Vamsi Krishna Attunuru <vattunuru@marvell.com>
Subject: Re: [PATCH v4] PCI: hotplug: Add OCTEON PCI hotplug controller driver
Message-ID: <20241112160833.GA1845767@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR18MB4425F2F17BA6CC582638F9D7D9592@PH0PR18MB4425.namprd18.prod.outlook.com>

On Tue, Nov 12, 2024 at 09:25:46AM +0000, Shijith Thotton wrote:
> >> This patch introduces a PCI hotplug controller driver for the OCTEON
> >> PCIe device. The OCTEON PCIe device is a multi-function device where the
> >> first function serves as the PCI hotplug controller.
> >>
> >>                +--------------------------------+
> >>                |           Root Port            |
> >>                +--------------------------------+
> >>                                |
> >>                               PCIe
> >>                                |
> >> +---------------------------------------------------------------+
> >> |              OCTEON PCIe Multifunction Device                 |
> >> +---------------------------------------------------------------+
> >>              |                    |              |            |
> >>              |                    |              |            |
> >> +---------------------+  +----------------+  +-----+  +----------------+
> >> |      Function 0     |  |   Function 1   |  | ... |  |   Function 7   |
> >> | (Hotplug controller)|  | (Hotplug slot) |  |     |  | (Hotplug slot) |
> >> +---------------------+  +----------------+  +-----+  +----------------+
> >>              |
> >>              |
> >> +-------------------------+
> >> |   Controller Firmware   |
> >> +-------------------------+
> >>
> >> The hotplug controller driver enables hotplugging of non-controller
> >> functions within the same device. During probing, the driver removes
> >> the non-controller functions and registers them as PCI hotplug slots.
> >> These slots are added back by the driver, only upon request from the
> >> device firmware.
> >>
> >> The controller uses MSI-X interrupts to notify the host of hotplug
> >> events initiated by the OCTEON firmware. Additionally, the driver
> >> allows users to enable or disable individual functions via sysfs slot
> >> entries, as provided by the PCI hotplug framework.
> >
> >Can we say something here about what the benefit of this driver is?
> >For example, does it save power?
> 
> The driver enables hotplugging of non-controller functions within the device
> without requiring a fully implemented switch, reducing both power consumption
> and product cost.

Reduced product cost is motivation for the hardware design, not for
this hotplug driver.

You didn't explicitly say that when function 0 hot-removes another
function, it reduces overall power consumption.  But I assume that's
the case?

> >What causes the function 0 firmware to request a hot-add or
> >hot-removal of another function?
> 
> The firmware will enable the required number of non-controller
> functions based on runtime demand, allowing control over these
> functions. For example, in a vDPA scenario, each function could act
> as a different type of device (such as net, crypto, or storage)
> depending on the firmware configuration.

What is the path for this runtime demand?  I assume function 0
provides some interface to request a specific kind of functionality
(net, crypo, storage, etc)?

I don't know anything about vDPA, so if that's important here, it
needs a little more context.

> Hot removal is useful in cases of live firmware updates.

So the idea is that function X is hot-removed, which forces the driver
to let go of it, the firmware is updated, and X is hot-added again,
and the driver binds to it again?

And somewhere in there is a reset of function X, and after the reset
X is running the new firmware?

Who/what initiates this whole path?  Some request to function 0,
saying "please remove function X"?

But I guess maybe it doesn't go through function 0, since octeon_hp
claims function 0, and it doesn't provide that functionality.  Maybe
the individual drivers for *other* functions know how to initiate
these things, and those functions internally communicate with function
0 to ask it to start a hot-remove/hot-add sequence?

That wouldn't explain the power reduction plan, though.  A driver for
function X could conceivably tell its device "I'm no longer needed"
and function X could tell function 0 to remove it.  That might enable
some power savings.  But that doesn't have a path to *re-enable*
function X, since function X has been removed and there's no driver to
ask for it to be hot-added again.

Maybe there's some out-of-band management path that can tell function
0 to do things, independent of PCIe?

So confused,
  Bjorn

