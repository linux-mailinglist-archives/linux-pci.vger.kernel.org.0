Return-Path: <linux-pci+bounces-16715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BED549C7F1C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 01:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA5E2816B4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 00:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD8C801;
	Thu, 14 Nov 2024 00:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWEQKpoZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E9E163;
	Thu, 14 Nov 2024 00:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731542606; cv=none; b=iAijIQbVwuc7++iTwF1YxkrpHJDJNm3BvkGO/4JBj6I7NDoHRMjgm3db6XPbkZpGvLRfFuOJc0arVMIxJR+5QOFG8PzRB1Sy+JkGaMWtyWgoriuW1CP0HMcYSM/uIAPEJeGvoxKi7C/Whkbcz2wsGppHswumSBNiHuK6XDWUrXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731542606; c=relaxed/simple;
	bh=6wE9w23E701SXVrE75griIgPVhRTJAA2DvIbf6ahBS0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OfoB0ZCzDnZwlqDen6Kb0dPwOnZvVtBT9/t9O8ot0iOXV4V2bL/hMXTIembEdazRBXM2ZS+n+rHe9JCSRiY9/iKgUzfMh3n18RdEItTjhMusDGkwEgSMjg4dNxxEUozUggeRkX4yItaUpLFWNyKGxt3cGUrIlw2NYlF6liljzD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWEQKpoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40079C4CEC3;
	Thu, 14 Nov 2024 00:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731542606;
	bh=6wE9w23E701SXVrE75griIgPVhRTJAA2DvIbf6ahBS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hWEQKpoZVBf20UTjgat6vFlP9N609q4Z+nI7WMZiukgkE3kCfYFcpUYWnHnuydxT+
	 NqdxsWswL8gpG0clMECkO7VtHquvy6ScTJBRVQiyNHA3g8G12KOxMM+7YJ9yChcHAw
	 0yOck1icEBD7uM8i7ptWHNRdzt9loqhGFxxVonBfOp4iqa/271i1qj+16JsdoE8jGy
	 D4ENYBfqqmTdwYk9mblkCj0bfqclGvvQyZ45i5Iso6YbjewdgE/0cgZXGZjxE/TOta
	 nWG1we/muqTgGNsivOyFVLTwF1P1Vbien35/EXHI7LAAHcEBfxKHuNq/dCXwOJXHgT
	 iWGgJiqx7lM6g==
Date: Wed, 13 Nov 2024 18:03:24 -0600
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
Message-ID: <20241114000324.GA1967327@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR18MB4425C1F63EAFFA2AA3BFCBF2D95A2@PH0PR18MB4425.namprd18.prod.outlook.com>

On Wed, Nov 13, 2024 at 12:20:20PM +0000, Shijith Thotton wrote:
> >> >> This patch introduces a PCI hotplug controller driver for the OCTEON
> >> >> PCIe device. The OCTEON PCIe device is a multi-function device where the
> >> >> first function serves as the PCI hotplug controller.
> >> >>
> >> >>                +--------------------------------+
> >> >>                |           Root Port            |
> >> >>                +--------------------------------+
> >> >>                                |
> >> >>                               PCIe
> >> >>                                |
> >> >> +---------------------------------------------------------------+
> >> >> |              OCTEON PCIe Multifunction Device                 |
> >> >> +---------------------------------------------------------------+
> >> >>              |                    |              |            |
> >> >>              |                    |              |            |
> >> >> +---------------------+  +----------------+  +-----+  +----------------+
> >> >> |      Function 0     |  |   Function 1   |  | ... |  |   Function 7   |
> >> >> | (Hotplug controller)|  | (Hotplug slot) |  |     |  | (Hotplug slot) |
> >> >> +---------------------+  +----------------+  +-----+  +----------------+
> >> >>              |
> >> >>              |
> >> >> +-------------------------+
> >> >> |   Controller Firmware   |
> >> >> +-------------------------+
> >> >>
> >> >> The hotplug controller driver enables hotplugging of non-controller
> >> >> functions within the same device. During probing, the driver removes
> >> >> the non-controller functions and registers them as PCI hotplug slots.
> >> >> These slots are added back by the driver, only upon request from the
> >> >> device firmware.
> >> >>
> >> >> The controller uses MSI-X interrupts to notify the host of hotplug
> >> >> events initiated by the OCTEON firmware. Additionally, the driver
> >> >> allows users to enable or disable individual functions via sysfs slot
> >> >> entries, as provided by the PCI hotplug framework.
> >> >
> >> >Can we say something here about what the benefit of this driver is?
> >> >For example, does it save power?
> >>
> >> The driver enables hotplugging of non-controller functions within the device
> >> without requiring a fully implemented switch, reducing both power
> >consumption
> >> and product cost.
> >
> >Reduced product cost is motivation for the hardware design, not for
> >this hotplug driver.
> >
> >You didn't explicitly say that when function 0 hot-removes another
> >function, it reduces overall power consumption.  But I assume that's
> >the case?
> >
> 
> Yes, I will explain it in detail below
> 
> >> >What causes the function 0 firmware to request a hot-add or
> >> >hot-removal of another function?
> >>
> >> The firmware will enable the required number of non-controller
> >> functions based on runtime demand, allowing control over these
> >> functions. For example, in a vDPA scenario, each function could act
> >> as a different type of device (such as net, crypto, or storage)
> >> depending on the firmware configuration.
> >
> >What is the path for this runtime demand?  I assume function 0
> >provides some interface to request a specific kind of functionality
> >(net, crypo, storage, etc)?
> >
> 
> Right now, it done via firmware management console.
> 
> >I don't know anything about vDPA, so if that's important here, it
> >needs a little more context.
> >
> >> Hot removal is useful in cases of live firmware updates.
> >
> >So the idea is that function X is hot-removed, which forces the driver
> >to let go of it, the firmware is updated, and X is hot-added again,
> >and the driver binds to it again?
> >
> 
> I will explain the process in detail, which should also address the questions
> below.
> 
> >And somewhere in there is a reset of function X, and after the reset
> >X is running the new firmware?
> >
> >Who/what initiates this whole path?  Some request to function 0,
> >saying "please remove function X"?
> >
> >But I guess maybe it doesn't go through function 0, since octeon_hp
> >claims function 0, and it doesn't provide that functionality.  Maybe
> >the individual drivers for *other* functions know how to initiate
> >these things, and those functions internally communicate with function
> >0 to ask it to start a hot-remove/hot-add sequence?
> >
> >That wouldn't explain the power reduction plan, though.  A driver for
> >function X could conceivably tell its device "I'm no longer needed"
> >and function X could tell function 0 to remove it.  That might enable
> >some power savings.  But that doesn't have a path to *re-enable*
> >function X, since function X has been removed and there's no driver to
> >ask for it to be hot-added again.
> >
> >Maybe there's some out-of-band management path that can tell function
> >0 to do things, independent of PCIe?
> >
> 
> Our implementation aims to achieve two main objectives:
> 
> 1. Enable changing a function's personality at runtime.
> 2. Reduce power consumption.
> 
> The OCTEON PCI device has multiple ARM cores running Linux, with its firmware
> composed of multiple components. For example, the firmware includes components
> like Virtio-net, NVMe, and Virtio-Crypto, which can be assigned to any function
> at runtime. The device firmware is accessible via a management console, allowing
> components to be started or stopped. For each component, an associated function
> is hot-added on the host to expose its functionality. Initially, after boot, only
> Function 0 and the controller firmware are active.
> 
> Here's a breakdown:
> 
> At Time 0:
> - Linux boots on the device, starting the controller firmware.
> 
> At Time 1:
> - The hotplug driver loads on the host, temporarily removing other functions.
> 
> At Time 2:
> - A network device firmware component starts on an ARM core (initiated through
>   a console command).
> - This component sets up the Function 1 configuration space, data, and other
>   request handlers for network processing.
> - The firmware issues a hot-add request to Function 0 (hotplug driver) on the
>   host to enable Function 1.
> 
> At Time 3:
> - The Function 0 hotplug driver on the host receives the hot-add request and
>   enables Function 1 on the host.
> - A network driver binds to Function 1 based on device class and ID.
> 
> At Time 4:
> - The network device firmware component receives a stop signal.
> - The firmware issues a hot-remove request for Function 1 on the host.
> - The firmware component halts, reducing the device's power consumption.
> 
> At Time 5:
> - The Function 0 hotplug driver on the host receives the hot-remove request and
>   disables Function 1 on the host.
> 
> At Time 6:
> - A crypto device firmware component starts on an ARM core.
> - This component configures the Function 1 configuration space for crypto
>   processing and sets up the required firmware handlers.
> - The firmware issues a hot-add request to enable Function 1 on the host.
> 
> At Time 7:
> - The Function 0 hotplug driver on the host receives the hot-add request and                                                                                                                                                                                                      enables Function 1 on the host.
> - A crypto driver binds to Function 1 based on device class and ID.
> 
> The firmware component for each function only runs and is hot-added when
> needed. Only Function 0 and the controller firmware remain active
> continuously. This dynamic control reduces power usage by keeping unnecessary
> components off. Additionally, a single function can adapt its personality based
> on the associated firmware component, enhancing flexibility. 
>                                                                                                                                                                                                                    
> I hope this clarifies the implementation. Let me know if you have any
> questions.

Thanks very much!  I propose adding text like this to the commit log:

  There is an out-of-band management console interface to firmware
  running on function 0 whereby an administrator can disable functions
  to save power or enable them with one of several personalities
  (virtio-net, virtio-crypto, NVMe, etc) for the other functions.
  Function 0 initiates hotplug events handled by this driver when the
  other functions are enabled or disabled.

I provisionally applied this to pci/hotplug-octeon, but will be happy
to update the text if necessary.

Bjorn

