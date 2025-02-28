Return-Path: <linux-pci+bounces-22652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88107A49EE3
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 17:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5380116B9F0
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 16:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE5227FE9A;
	Fri, 28 Feb 2025 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpDetBCS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB8D271818;
	Fri, 28 Feb 2025 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760341; cv=none; b=CRpOXc49msb7kZO28/8L6vU71NGWXKD86R2Xx+P/jEw9BfWGm/QdTjDydVOaaviUXM8FRsSRSolBKkuu4nHgjFkWgWXFrwdYE9lVtQf3dYucpBDx+/E/oxMDUic9IXR6H7vNAjO7y6eej0hrK14dO2oBrhHXgCiKXkkuswxbB28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760341; c=relaxed/simple;
	bh=naU5NcTyc/mk/u2vWARR4qABxP0SYCsR8XPzuhcXIqY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rfTCLR0RU/PevXxlQm4P22ooybW95NXSx3hHiqE7QkSnNuVkQ1sHx1NSFyxbgd9u/wWmucRldT+Gn0w13dRh8LuQat7jIR1JgDRTkPTuO1Dz0nrpz6xpgEP4ggZp82U5mPBPWoNSHL+z7h0HOWHNDG5tiX8iw/5wvmftW8she34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpDetBCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E2AC4CED6;
	Fri, 28 Feb 2025 16:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740760340;
	bh=naU5NcTyc/mk/u2vWARR4qABxP0SYCsR8XPzuhcXIqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FpDetBCSWlgBGYHmAWsX4bv9+6pykViHpztrT9L1JYjeU3X9vHu6CnxAb8/rNlZz5
	 uy+YeWzp8yVumQidC26CsgCnE3548jkJtzNMhmeWgfvdaVyVJplORBp3crJXQdqHdw
	 Rz+66HRBsjvAa1q/yryzfaAwPGme+RTEAVCgjoSi+p9Y36s8hGra/REouAYQ77UJiZ
	 mFBa0noorypX9k+GbmhYHvVAiNjRL9qz6F6tyv1RmW931vVthfC+cs0ZEw4KLAIVBf
	 gCozJs12v1nuz6hYZ0dZ9mvuNonVlaBmiZb7x5Z+FT1RsLEJzBQI5ukPGImylQRKIK
	 fOYmFS4uZoxJg==
Date: Fri, 28 Feb 2025 10:32:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Sanyog Kale <sanyog.r.kale@intel.com>, linux-sound@vger.kernel.org
Subject: Re: pci: acpi: Query on ACPI Device Tree Representation and
 Enumeration for Xilinx FPGA PCIe Endpoint functions
Message-ID: <20250228163219.GA54330@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHhAz+j46nus_rGJ72rZ86UyzL+AM_HBCivjpZEx3T0thOxqAQ@mail.gmail.com>

[+cc SoundWire folks]

On Fri, Feb 28, 2025 at 08:19:44PM +0530, Muni Sekhar wrote:
> On Thu, Feb 27, 2025 at 9:34 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Feb 27, 2025 at 07:25:32PM +0530, Muni Sekhar wrote:
> > > I am currently working on a project involving a Xilinx FPGA connected
> > > to an x86 CPU via a PCIe root port. The Xilinx FPGA functions as a
> > > PCIe endpoint with single function capability and is programmed to
> > > emulate the Soundwire Master controller. It can be dynamically
> > > reprogrammed to emulate other interfaces as needed. Essentially, the
> > > FPGA emulates an interface and connects to the CPU via the PCIe bus.
> > >
> > > Given this setup, the BIOS does not have prior knowledge of the
> > > function implemented in the Xilinx FPGA PCIe endpoint. I have a couple
> > > of questions regarding this configuration:
> > >
> > > Is it possible to define an ACPI Device Tree representation for this
> > > type of hardware setup?
> > > Can we achieve ACPI-based device enumeration with this configuration?
> >
> > If the FPGA is programmed before BIOS enumerates PCI devices, the FPGA
> > would look just like any other PCI device, and BIOS would be able to
> > read the Vendor ID and Device ID and would be able to size and program
> > the BARs.
>
> Yes, the FPGA is programmed with this Soundwire IP before the BIOS
> enumerates PCI devices.
> We need to port the Soundwire driver
> (https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/soundwire/qcom.c)
>  to the x86 platform.
> 
> Since x86 platforms typically do not use device trees, and the
> Soundwire IP is implemented in the FPGA, how can we emulate device
> tree functionality or use a different mechanism to pass hardware
> configuration to the driver? Specifically, how can we handle the
> following API calls on an x86 platform?
> 
>    ret = of_property_read_u32(np, "qcom,din-ports", &val);
>    ret = of_property_read_u32(np, "qcom,dout-ports", &val);
>    ret = of_property_read_u8_array(np, "qcom,ports-offset1", off1, nports);
> 
> static const struct of_device_id qcom_swrm_of_match[] = {
> { .compatible = "qcom,soundwire-v1.3.0", .data = &swrm_v1_3_data },
> { .compatible = "qcom,soundwire-v1.5.1", .data = &swrm_v1_5_data },
> { .compatible = "qcom,soundwire-v1.6.0", .data = &swrm_v1_6_data },
> { .compatible = "qcom,soundwire-v1.7.0", .data = &swrm_v1_5_data },
> { .compatible = "qcom,soundwire-v2.0.0", .data = &swrm_v2_0_data },
> {/* sentinel */},
> };
> 
> Basically, how can we define ACPI tables for functions implemented in
> an FPGA that connects to the system via PCI?

Seems like a generic problem for PCI sound devices, and I don't know
how drivers deal with it.  It looks like all the SoundWire drivers
are platform drivers (not PCI drivers), so there's nothing there to
look at.

Maybe the sound folks have ideas.

Bjorn

