Return-Path: <linux-pci+bounces-8349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BF78FD55A
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 20:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9FA81C21599
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 18:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B5D3D6D;
	Wed,  5 Jun 2024 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ej0ZsfT+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886AD15572C;
	Wed,  5 Jun 2024 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610651; cv=none; b=FBbPJu/3elS/6lIIOkbkJM6HTBAQyx9tun506yt7032MU+ixycPhIn7iHNMGyw62ZszFbRBFFAJ+tiZaoTUbHAYLVeD0RktWAUilDxElKMN//Yxm97X0wyXnIMahwOykqppQig3KSZov1+quA7Vvu61X1MWWZevpZxtSxTBz9DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610651; c=relaxed/simple;
	bh=rYEy0zN2GwpAksIeMEyKNAQAsNKFJ1o2vMiJlZN6j/c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Wm8BYjyMp7LIOBNyF3LR6JxTPOk9KBUvvkoZ6GHT2diRZCJSdvnNY6Ey/5YKzqu584yuAVzuElPdYso2t+hLxo/gqj524rettvx0Yzse1rjIuOfrKCi7sZ+b260Fn0gZkXlf9jEMF4f8xVxn5Fgjw0gXeKyMx1BokQmbK6g8fq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ej0ZsfT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54BDC2BD11;
	Wed,  5 Jun 2024 18:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717610651;
	bh=rYEy0zN2GwpAksIeMEyKNAQAsNKFJ1o2vMiJlZN6j/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ej0ZsfT+/YDqfM/ehjuBw86B6/BSHAXVKss7JRAC+kYCGbNb+TN/rWdjbIvjsJruK
	 rmZuNOTJQHyYN4FkGuJ8MEkuvj8K1EFGfOSeiMfOnCCOXCv26f2MCYaLpxUnNn0xVo
	 spliaFNDLFmjaZ/j7z984sC8DThlmV741bZK7GH84Idcjh5K8XY0EEuSzOCAZUIzPG
	 rSZJQfC0ddF541SIY9UI6PRD0YaR0Cg/F/ElA7MAhEPhYZ1ucstToD7fU0/fMzXxA+
	 /7TQHEzyKQ0VUR8wd0WAH3RNgXH2DHc5zT2qwnq4kEKV00rdaJASmDbKjZavU4WP2+
	 EYEvWxRj04f1g==
Date: Wed, 5 Jun 2024 13:04:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linuxarm@huawei.com,
	terry.bowman@amd.com,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [RFC PATCH 0/9] pci: portdrv: Add auxiliary bus and register CXL
 PMUs (and aer)
Message-ID: <20240605180409.GA520888@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529164103.31671-1-Jonathan.Cameron@huawei.com>

On Wed, May 29, 2024 at 05:40:54PM +0100, Jonathan Cameron wrote:
> Focus of this RFC is CXL Performance Monitoring Units in CXL Root Ports +
> Switch USP and DSPs.
> 
> The final patch moving AER to the aux bus is in the category of 'why
> not try this' rather than something I feel is a particularly good idea.
> I would like to get opinions on the various ways to avoid the double bus
> situation introduced here. Some comments on other options for those existing
> 'pci_express' bus devices at the end of this cover letter.
> 
> The primary problem this RFC tries to solve is providing a means to
> register the CXL PMUs found in devices which will be bound to the
> PCIe portdrv. The proposed solution is to avoid the limitations of
> the existing pcie service driver approach by bolting on support
> for devices registered on the auxiliary_bus.
> 
> Background
> ==========
> 
> When the CXL PMU driver was added, only the instances found in CXL type 3
> memory devices (end points) were supported. These PMUs also occur in CXL
> root ports, and CXL switch upstream and downstream ports.  Adding
> support for these was deliberately left for future work because theses
> ports are all bound to the pcie portdrv via the appropriate PCI class
> code.  Whilst some CXL support of functionality on RP and Switch Ports
> is handled by the CXL port driver, that is not bound to the PCIe device,
> is only instantiated as part of enumerating endpoints, and cannot use
> interrupts because those are in control of the PCIe portdrv. A PMU with
> out interrupts would be unfortunate so a different solution is needed.
> 
> Requirements
> ============
> 
> - Register multiple CXL PMUs (CPMUs) per portdrv instance.

What resources do CPMUs use?  BARs?  Config space registers in PCI
Capabilities?  Interrupts?  Are any of these resources
device-specific, or are they all defined by the CXL specs?

The "device" is a nice way to package those up and manage ownership
since there are often interdependencies.

I wish portdrv was directly implemented as part of the PCI core,
without binding to the device as a "driver".  We handle some other
pieces of functionality that way, e.g., the PCIe Capability itself,
PM, VPD, MSI/MSI-X, 

> - portdrv binds to the PCIe class code for PCI_CLASS_BRIDGE_PCI_NORMAL which
>   covers any PCI-Express port.
> - PCI MSI / MSIX message based interrupts must be registered by one driver -
>   in this case it's the portdrv.

The fact that AER/DPC/hotplug/etc (the portdrv services) use MSI/MSI-X
is a really annoying part of PCIe because bridges may have a BAR or
two and are allowed to have device-specific endpoint-like behavior, so
we may have to figure out how to share those interrupts between the
PCIe-architected stuff and the device-specific stuff.  I guess that's
messy no matter whether portdrv is its own separate driver or it's
integrated into the core.

> Side question.  Does anyone care if /sys/bus/pci_express goes away?
> - in theory it's ABI, but in practice it provides very little
>   actual ABI.

I would *love* to get rid of /sys/bus/pci_express, but I don't know
what, if anything, would break if we removed it.

Bjorn

