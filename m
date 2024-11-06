Return-Path: <linux-pci+bounces-16136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FB19BEF15
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 14:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE271F2479E
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 13:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5CA1F9AB5;
	Wed,  6 Nov 2024 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fMsT0KYq"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F511F9AA4;
	Wed,  6 Nov 2024 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730900010; cv=none; b=FHAEai3wptuh+FKvXwSuI3hyodvtTl16p6g2LypacVs/HIZ3dviuR03ty3dc0/3rWqJ7riSBXfFjoChd3FUjJv9Cpx3Exc1Gb8NV2eQnF3QVVuq6bXtzn+w0ophWrNl+0/uAkn3Zjg4UsRoCPJnrc9fMPyDZAcz1yCjNF2YQHoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730900010; c=relaxed/simple;
	bh=lLqX9RHDVHTROxcXB0PpwF59t28YhopfpxuEMYpIX+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f09lwdS9K6557LLLq4/TjueltPBeK8GybkdP8PQNhvlvymTzLWFVsyeVVJdFrLidoDvTAYMb1hcJ6DUMv+IAoBeM8R/Z+qmuCYa1x9Hl++gRtFs+gTrS05T2vCqmyi9x4aqUR46zh0a7uY4lIcPTtALNAyFBr4D6PmUsk2dWLHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fMsT0KYq; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E0F7360004;
	Wed,  6 Nov 2024 13:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730900005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOXVY6LCnC6pAifdo2TdXKHQxlXlIq7vA3aaefiEND0=;
	b=fMsT0KYq2Ehg/w9gdqNHwMfw1Twpz/WAWjCr6LuAOp3krAkO95fc3g6Q0psT/sJ/kiZcRp
	SGLwazJpynxvqUclTCz2p+7VxAHke2oKe1q9+SaVB/kYLx1BEHxXK0Z+Hcch5Lu+ewn2lm
	DgRSWNzIZKqHFW3aP9fDTfKznfFjHipW4Rh4KN3w4M6Wp6x7EIKz8/eeREdItVwag+L6h8
	SxiGm2LKGoX1pHAdTKQaHgNK57Who+npVcwzEvIX3ZsgCyb/hqes52J/CLdVH9yWfqP7/Y
	sIkUfbH3OoaYrmn34DYf3VF62+geWy8iBxJwOqqoU6k4nQ2HXA4FlRSxy2lLGw==
Date: Wed, 6 Nov 2024 14:33:24 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Saravana Kannan <saravanak@google.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/6] Add support for the root PCI bus device-tree node
 creation.
Message-ID: <20241106143324.3add555c@bootlin.com>
In-Reply-To: <CAL_JsqK-UhnaJ8TgV1PzCO5yO99NQq3ZZcagKvkvg0YgcxFXug@mail.gmail.com>
References: <20241104172001.165640-1-herve.codina@bootlin.com>
	<20241104201507.GA361448-robh@kernel.org>
	<20241105184433.1798fe55@bootlin.com>
	<CAL_JsqK-UhnaJ8TgV1PzCO5yO99NQq3ZZcagKvkvg0YgcxFXug@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Rob,

On Tue, 5 Nov 2024 13:59:40 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, Nov 5, 2024 at 11:44 AM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > Hi Rob,
> >
> > On Mon, 4 Nov 2024 14:15:07 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >
> > ...  
> > > > With those modifications, the LAN966x PCI device is working on x86 systems.  
> > >
> > > That's nice, but I don't have a LAN966x device nor do I want one. We
> > > already have the QEMU PCI test device working with the existing PCI
> > > support. Please ensure this series works with it as well.
> > >  
> >
> > I will check.
> >
> > Can you confirm that you are talking about this test:
> >   https://elixir.bootlin.com/linux/v6.12-rc6/source/drivers/of/unittest.c#L4188
> >
> > The test needs QEMU with a specific setup and I found this entry point:
> >   https://lore.kernel.org/all/fa208013-7bf8-80fc-2732-814f380cebf9@amd.com/  
> 
> Yes, that's it.
> 
> > Do you have an "official" QEMU setup on your side to run the test or any
> > other pointers related to the QEMU command/setup you use?  
> 
> No, it's just something based on what you linked. Here's what I have:
> 
> qemu-system-aarch64 -machine virt -cpu cortex-a72 -machine type=virt
> -nographic -smp 1 -m 2048 -kernel ../linux.git/arch/arm64/boot/Image
> --append console=ttyAMA0 -device
> pcie-root-port,port=0x10,chassis=9,id=pci.9,bus=pcie.0,multifunction=on,addr=0x3
> -device pcie-root-port,port=0x11,chassis=10,id=pci.10,bus=pcie.0,addr=0x3.0x1
> -device x3130-upstream,id=pci.11,bus=pci.9,addr=0x0 -device
> xio3130-downstream,port=0x0,chassis=11,id=pci.12,bus=pci.11,multifunction=on,addr=0x0
> -device i82801b11-bridge,id=pci.13,bus=pcie.0,addr=0x4 -device
> pci-bridge,chassis_nr=14,id=pci.14,bus=pci.13,addr=0x0 -device
> pci-testdev,bus=pci.12,addr=0x0
> 
> Of course, you'll need a few changes to use ACPI.
> 

I ran the OF kunit tests with the following command:
qemu-system-x86_64 -machine q35 -nographic \
	-kernel arch/x86_64/boot/bzImage --append console=ttyS0 \
	-device pcie-root-port,port=0x10,chassis=9,id=pci.9,bus=pcie.0,multifunction=on,addr=0x3 \
	-device pcie-root-port,port=0x11,chassis=10,id=pci.10,bus=pcie.0,addr=0x3.0x1 \
	-device x3130-upstream,id=pci.11,bus=pci.9,addr=0x0 \
	-device xio3130-downstream,port=0x0,chassis=11,id=pci.12,bus=pci.11,multifunction=on,addr=0x0 \
	-device i82801b11-bridge,id=pci.13,bus=pcie.0,addr=0x4 \
	-device pci-bridge,chassis_nr=14,id=pci.14,bus=pci.13,addr=0x0 \
	-device pci-testdev,bus=pci.12,addr=0x0

Same -device options as the ones present in your command.

Tests are successful:
  [    0.000000] DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-1.fc39 04/01/2014
  ...
  [    0.030500] ACPI: Early table checksum verification disabled
  [    0.030771] ACPI: RSDP 0x00000000000F5250 000014 (v00 BOCHS )
  [    0.030993] ACPI: RSDT 0x0000000007FE4068 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
  [    0.031438] ACPI: FACP 0x0000000007FE3E60 0000F4 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
  [    0.031920] ACPI: DSDT 0x0000000007FE0040 003E20 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
  [    0.031993] ACPI: FACS 0x0000000007FE0000 000040
  [    0.032036] ACPI: APIC 0x0000000007FE3F54 000078 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
  [    0.032060] ACPI: HPET 0x0000000007FE3FCC 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
  [    0.032084] ACPI: MCFG 0x0000000007FE4004 00003C (v01 BOCHS  BXPC     00000001 BXPC 00000001)
  [    0.032105] ACPI: WAET 0x0000000007FE4040 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
  [    0.032171] ACPI: Reserving FACP table memory at [mem 0x7fe3e60-0x7fe3f53]
  [    0.032206] ACPI: Reserving DSDT table memory at [mem 0x7fe0040-0x7fe3e5f]
  [    0.032215] ACPI: Reserving FACS table memory at [mem 0x7fe0000-0x7fe003f]
  [    0.032220] ACPI: Reserving APIC table memory at [mem 0x7fe3f54-0x7fe3fcb]
  [    0.032226] ACPI: Reserving HPET table memory at [mem 0x7fe3fcc-0x7fe4003]
  [    0.032231] ACPI: Reserving MCFG table memory at [mem 0x7fe4004-0x7fe403f]
  [    0.032236] ACPI: Reserving WAET table memory at [mem 0x7fe4040-0x7fe4067]
  ...
  [    3.466693] ### dt-test ### pass of_unittest_pci_node():4202
  [    3.466887] ### dt-test ### pass of_unittest_pci_node_verify():4155
  [    3.467133] ### dt-test ### pass of_unittest_pci_node_verify():4162
  [    3.467278] ### dt-test ### pass of_unittest_pci_node_verify():4169
  [    3.467442] ### dt-test ### pass of_unittest_pci_node():4214
  [    3.467572] ### dt-test ### pass of_unittest_pci_node():4216
  [    3.469993] ### dt-test ### pass of_unittest_pci_node_verify():4155
  [    3.470273] ### dt-test ### pass of_unittest_pci_node_verify():4175
  [    3.470577] ### dt-test ### pass of_unittest_pci_node_verify():4177
  ...
  [    3.513309] ### dt-test ### end of unittest - 387 passed, 0 failed


Best regards,
Hervé

