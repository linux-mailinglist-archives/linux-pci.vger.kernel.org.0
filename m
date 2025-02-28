Return-Path: <linux-pci+bounces-22656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AD8A4A037
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 18:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96553AE786
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 17:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215911F4C98;
	Fri, 28 Feb 2025 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qI4+5GWu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C641F4C83;
	Fri, 28 Feb 2025 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763402; cv=none; b=ImJEFfZCVYPO/CKi+t7NzifHHToGjnDBaJm8y6uD/NMq+i1MYCub0BVKhWzCkRnnIt/0VCaNW1QAWuFMQ9JQEXG8MJoLyvHMlzFlwM7ll1YbNWB6+q7zDuvpbqxK55eoQC/Rn0cwaADhrmvdBlzSBewq7Y1VQ2TTeLfBLEtFEJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763402; c=relaxed/simple;
	bh=kpa5gUq601xY2LLqyDkp+ULt9YfNAfqA5DJnA1T2tiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E80ss6GaMNFGbP+2uTZ8cyaPQpS9WxkWRqgjlbmb3yj4ShhSkE9oOPEDD9XnnEX1U7z5QrYnkVFd6Gm/C82MptNPprb58yASthjesRrZqPvqp9Y/53LXeA48DW7sS52DXhJ8wJnynL/HiV/1uVT5TAsaPdgYLAB17Ap4l36q6Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qI4+5GWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0163C4CEE2;
	Fri, 28 Feb 2025 17:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740763401;
	bh=kpa5gUq601xY2LLqyDkp+ULt9YfNAfqA5DJnA1T2tiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qI4+5GWu3Wl6VXYHL4b3Ve6TMGej7QVi3Gue5LFr1UrE0smNW9exm5xZmGc5P1H7M
	 IcPoEhQ7oP2NiOIYjqTII48zvHmppdJY/JvBeWUglKBAWO+b7M5CeSa69+W9lMhP7y
	 K88IrRDlpBjDiQkcdeMtk05EK4xijZ+Y30glFh82APDAw8MvBOoXTyBU6YZG3rJ843
	 rxCFHfOZB36Sd1kCXxuZ7j7OWmIH+ZJuC319gGGcR0Ci0q64IDDEn9oRBI4eK0xSS1
	 j40o6g1LKTK1yKF1xKCIMJccoPo1gHDp2vqkkD2GZjsy8sQRMIjaD7YJasRe9RTbDn
	 g7X6bzxXphj2A==
Date: Fri, 28 Feb 2025 22:53:17 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Muni Sekhar <munisekharrms@gmail.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Sanyog Kale <sanyog.r.kale@intel.com>, linux-sound@vger.kernel.org
Subject: Re: pci: acpi: Query on ACPI Device Tree Representation and
 Enumeration for Xilinx FPGA PCIe Endpoint functions
Message-ID: <Z8HxBQbLzgV5NDYA@vaman>
References: <CAHhAz+j46nus_rGJ72rZ86UyzL+AM_HBCivjpZEx3T0thOxqAQ@mail.gmail.com>
 <20250228163219.GA54330@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250228163219.GA54330@bhelgaas>

On 28-02-25, 10:32, Bjorn Helgaas wrote:
> [+cc SoundWire folks]
> 
> On Fri, Feb 28, 2025 at 08:19:44PM +0530, Muni Sekhar wrote:
> > On Thu, Feb 27, 2025 at 9:34 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Thu, Feb 27, 2025 at 07:25:32PM +0530, Muni Sekhar wrote:
> > > > I am currently working on a project involving a Xilinx FPGA connected
> > > > to an x86 CPU via a PCIe root port. The Xilinx FPGA functions as a
> > > > PCIe endpoint with single function capability and is programmed to
> > > > emulate the Soundwire Master controller. It can be dynamically
> > > > reprogrammed to emulate other interfaces as needed. Essentially, the
> > > > FPGA emulates an interface and connects to the CPU via the PCIe bus.
> > > >
> > > > Given this setup, the BIOS does not have prior knowledge of the
> > > > function implemented in the Xilinx FPGA PCIe endpoint. I have a couple
> > > > of questions regarding this configuration:
> > > >
> > > > Is it possible to define an ACPI Device Tree representation for this
> > > > type of hardware setup?
> > > > Can we achieve ACPI-based device enumeration with this configuration?
> > >
> > > If the FPGA is programmed before BIOS enumerates PCI devices, the FPGA
> > > would look just like any other PCI device, and BIOS would be able to
> > > read the Vendor ID and Device ID and would be able to size and program
> > > the BARs.
> >
> > Yes, the FPGA is programmed with this Soundwire IP before the BIOS
> > enumerates PCI devices.
> > We need to port the Soundwire driver
> > (https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/soundwire/qcom.c)
> >  to the x86 platform.
> > 
> > Since x86 platforms typically do not use device trees, and the
> > Soundwire IP is implemented in the FPGA, how can we emulate device
> > tree functionality or use a different mechanism to pass hardware
> > configuration to the driver? Specifically, how can we handle the
> > following API calls on an x86 platform?
> > 
> >    ret = of_property_read_u32(np, "qcom,din-ports", &val);
> >    ret = of_property_read_u32(np, "qcom,dout-ports", &val);
> >    ret = of_property_read_u8_array(np, "qcom,ports-offset1", off1, nports);
> > 
> > static const struct of_device_id qcom_swrm_of_match[] = {
> > { .compatible = "qcom,soundwire-v1.3.0", .data = &swrm_v1_3_data },
> > { .compatible = "qcom,soundwire-v1.5.1", .data = &swrm_v1_5_data },
> > { .compatible = "qcom,soundwire-v1.6.0", .data = &swrm_v1_6_data },
> > { .compatible = "qcom,soundwire-v1.7.0", .data = &swrm_v1_5_data },
> > { .compatible = "qcom,soundwire-v2.0.0", .data = &swrm_v2_0_data },
> > {/* sentinel */},
> > };
> > 
> > Basically, how can we define ACPI tables for functions implemented in
> > an FPGA that connects to the system via PCI?
> 
> Seems like a generic problem for PCI sound devices, and I don't know
> how drivers deal with it.  It looks like all the SoundWire drivers
> are platform drivers (not PCI drivers), so there's nothing there to
> look at.
> 
> Maybe the sound folks have ideas.

X86-Intel devices are PCI devices but then they are compound devices
with DSP and SoundWire links. Please check the DisCo spec for SoundWire,
that already defines the ACPI tables and properties which both Intel and
AMD drivers already use

That should be your start point...

-- 
~Vinod

