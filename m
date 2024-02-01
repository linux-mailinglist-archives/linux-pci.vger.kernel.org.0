Return-Path: <linux-pci+bounces-2964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3404984635C
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 23:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B2F28A659
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 22:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E103FB2E;
	Thu,  1 Feb 2024 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2PUQwEi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA263FB1D
	for <linux-pci@vger.kernel.org>; Thu,  1 Feb 2024 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706826183; cv=none; b=kklYUjtajhlIohFGugHrGAjWeuMUwt0v2YQ4dQvdealQgpF8j9E2K+/j3IRxJ6eFoVBGroU0DUa8/yqcMcBCoyc3oY695cM8MRo4QzPnBeYKOAZje+2K6tmFVoEy/swCzQlBQMDgmqnohKbbTXervgiGPhIZBonEWtCk/iYP3Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706826183; c=relaxed/simple;
	bh=Vs6Mlr4DPZynFAdG76iRA6gWlTHH5bMNxGmzWl37BbY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DYPtZyYOo9LEU4QeiOgjb6PzSq4o2uUPjfdTTiV207CZ4B5aGcs6MpoFEA0pb/KhUHVkVh8hA9D2yqOh4nqXMlp+Rh4I67UtGVGxnZYi0NSL7xkn91/rh5yD2X+NuknvBL8GzpqKCd0+snypDJLmm1OaZqP8a8tz4ZOYwh9VMQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2PUQwEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EC1C433F1;
	Thu,  1 Feb 2024 22:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706826182;
	bh=Vs6Mlr4DPZynFAdG76iRA6gWlTHH5bMNxGmzWl37BbY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=P2PUQwEiwcOzIe/Zc6fB+lfP+iOxqQJNXuvS1u+mttt1hXhXXrHiKqCskf5f13yf2
	 co99GR7+CyL5nVK+etIiQq/u3TSPpB4nDD09OscMHfnFPdv7LyZ8VVMX9E0GCAjNZm
	 gTuynqMWlnp7i2xajRHoZxpN+KGy3kDuPZ2W2spTHdGimUA9o6220UXcNNUk+R8hYE
	 PiLgQlJrghqZ1sIuRY+HfrOTfRSErK5XAOxIPu+Y/EkW+lqumQUs3moGIo2VZjczEG
	 T374ZwyO10x3jphjvETL3NJ5la1PToBfKcDoqu0WRi2I+89SHLswcJPNeu56dHS/hO
	 oIbznjcZUwQOQ==
Date: Thu, 1 Feb 2024 16:22:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org, samruddh.dhope@intel.com,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
Message-ID: <20240201222245.GA650725@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cf8a41181e07ec15dbc95e42c527b6429db8c50.camel@linux.intel.com>

On Tue, Jan 16, 2024 at 01:37:32PM -0700, Nirmal Patel wrote:
> On Fri, 2024-01-12 at 16:55 -0600, Bjorn Helgaas wrote:
> ...

> > I think we're converging on the idea that since VMD is effectively
> > *not* an ACPI host bridge and doesn't have its own _OSC, the _OSC
> > that applies to the VMD endpoint does *not* apply to the hierarchy
> > below the VMD.  In that case, the default is that the OS owns all
> > the features (hotplug, AER, etc) below the VMD.
>
> Well there will be few problems if VMD owns/assigns all the flags by
> itself. We discussed all of the potential problems but due to the
> holidays I think I should summarize them again.
>
> #1 : Currently there is no way to pass the information about AER,
> DPC, etc to VMD driver from BIOS or from boot parameter. For
> example, if VMD blindly enables AER and platform has AER disabled,
> then we will see AERs from devices under VMD but user have no way to
> toggle it since we rejected idea of adding boot parameter for AER,
> DPC under VMD. I believe you also didn't like the idea of sysfs knob
> suggested by Kai-Heng.
> 
> #2 : Even if we use VMD hardware register to store AER, DPC and make
> UEFI VMD driver to write information about Hotplug, DPC, AER, we
> still dont have a way to change the setting if user wants to alter
> them. Also the issue will still persist in client platforms since we
> don't own their UEFI VMD driver. It will be a huge effort.
> 
> #3 : At this moment, user can enable/disable only Hotplug in VMD
> BIOS settings (meaning no AER, DPC, LTR, etc)and VMD driver can read
> it from SltCap register. This means BIOS needs to add other settings
> and VMD needs to figure out to read them which at this moment VMD
> can't do it.
> 
> #4 : consistency with Host OS and Guest OS.
> 
> I believe the current proposed patch is the best option which
> requires minimal changes without breaking other platform features
> and unblock our customers. This issues has been a blocker for us.
> 
> For your concerns regarding how VMD can own all the _OSC features, i
> am open to other ideas and will discuss with the architect if they
> have any suggestions.

As I understand it, the basic model of PCIe features is:

  - If platform doesn't have a way to negotiate ownership of PCIe
    features, the OS owns them by default, e.g., on non-ACPI systems.

  - If platform does have a way to negotiate, e.g., ACPI _OSC, the
    platform owns the features until it grants ownership to the OS.

  - If the OS has ownership (either by default or granted by
    platform), it can use the feature if the hardware device
    advertises support.

I think this model applies to all PCIe features, including hotplug,
AER, DPC, etc., and the OS uses _OSC and the Capabilities in device
config space to determine whether to use the features.

_OSC is the obvious way for a platform to use BIOS settings to
influence what the OS does.  I think the problem with VMD is that you
have a guest OS running on a platform (the guest VM) where you want a
host BIOS setting to control things in that guest platform, but
there's currently no way to influence the _OSC seen by the guest.

I think we need to:

  - Clarify whether _OSC only applies in the domain of the host bridge
    where it appears, i.e., an _OSC in a host bridge to domain 0000
    obviously applies to a VMD Endpoint in domain 0000; does it also
    apply to devices in the domain 10000 *below* the VMD Endpoint?

  - Describe what the VMD bridge does with events below it.  E.g.,
    normally a Root Port that receives an error Message generates an
    interrupt depending on its Interrupt Disable and Error Reporting
    Enable bits.  What happens when it's a VMD Root Port?  Does it
    forward an error Message up via the VMD Endpoint?  Generate an
    interrupt via the VMD Endpoint?  If so, which interrupt?

The question of where _OSC applies feels like an architectural thing.

The question of how AER, DPC, hotplug, etc. events are forwarded
across the VMD Root Port/Endpoint might be, too, or maybe that's all
driver-specific, I dunno.  Either way, I think it's worth documenting
somehow.

Bjorn

