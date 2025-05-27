Return-Path: <linux-pci+bounces-28470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3C2AC584F
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 19:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C35166377
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 17:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0028827CCF0;
	Tue, 27 May 2025 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmZF8amr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB42750E8
	for <linux-pci@vger.kernel.org>; Tue, 27 May 2025 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367809; cv=none; b=ohyc9pgoMEX1oxzLXssp438BJrVIkB+hMfaoplK2OoTedMWwvgOBEWyPJwulimJTnOV5UAon2H0kZlMwrTiVg1uwuwdi/FVjFKtWSrb5mtqb8mcohFLQSt8AFSeDua3A4j4x9k4xBx+lrEyeHUd9tRwkH4Vv4qL4W7sSXoTtIP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367809; c=relaxed/simple;
	bh=gYt6fwSg/8F5kvpFq0Zq4dQGWP6RE6C2FMu/YhkPOhw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BV3C2ys2AkZ/fviQ1SWBwmnNT8UY/u03qM2c8Z97I09WpgL4D7J7hyjtkvv0Grg8lcAyDg0/ENK64tw5Y+IBcTcEJruocO8U16wtc31ddr6bN5cQFX9XqpFiRM/AQHnKRMikbJH/+IeNnyF+QxGaCAonW8p6/QZ8x5WxiJYHF1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmZF8amr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A29FC4CEEB;
	Tue, 27 May 2025 17:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748367809;
	bh=gYt6fwSg/8F5kvpFq0Zq4dQGWP6RE6C2FMu/YhkPOhw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lmZF8amrqHwYjACFhi1xWE7UrjyTb7Lz6fbYlCwDw0OSFvCXLz+lDcGWn/lHf2NTy
	 yFBoNi9Wq3riug9qt+T7XJu/KUPI0ZgZUrVIcBARa5Gu9pB5Ad69PE2I+uBpWhTy40
	 LgCoN5oVGKQPWPzAlK5Y9DGurCvR9c2SS3uwqnWWMSP13RW2S/lCvyFgs1I/697qPh
	 5KsL0zjIdoRvJ1CtlRMpSGwLWiBUTurAg9F4/JXYA7WGNNt2kgp4KxGbss4kCHTNra
	 1Y3plkhkgMyn0O72ZaiIF8pau5soRGdb+RZcBPpWQP9YWG3sRX/UHAi45f8R1R66va
	 2e7WEjSIB18DA==
Date: Tue, 27 May 2025 12:43:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Subhashini Rao Beerisetty <subhashbeerisetty@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: PCIe: Unexpected .remove() and .probe() Callback Invocation
 Without Device Removal
Message-ID: <20250527174327.GA18348@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPY=qRSvmP=rRki+Q+AV3O3sSNO6-ezCeGr-HBjHhFSS-JYc7A@mail.gmail.com>

On Wed, May 07, 2025 at 08:01:09PM +0530, Subhashini Rao Beerisetty wrote:
> Hi All,
> 
> I’m reaching out for some guidance on a behavior we're observing with
> a Xilinx FPGA based PCIe device on our test systems. This device uses
> an out-of-tree driver.
> 
> We are seeing that, without any actual physical or hotplug
> removal/reinsertion of the PCIe device, the kernel invokes the
> pci_driver's .remove() callback followed shortly by the .probe()
> callback. This appears to be an unexpected re-enumeration or reset of
> the PCIe device.
> 
> Below is a snippet of the relevant kernel log captured during one such event.
> 
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.847385] XILINX_FPGA PCI
> 0000:01:00.0: PME# disabled
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.847410] XILINX_FPGA PCI:
> XILINX_FPGA_pci_remove
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.848110] pci 0000:01:00.0:
> EDR: Notify handler removed
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.848240] pci 0000:01:00.0:
> device released
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.876157] pci_bus 0000:00:
> scanning bus
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.876419] pcieport
> 0000:00:1c.0: scanning [bus 01-01] behind bridge, pass 0
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.876445] pci_bus 0000:01:
> scanning bus
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.876594] pci 0000:01:00.0:
> [1556:5555] type 00 class 0x050000
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.876678] pci 0000:01:00.0:
> reg 0x10: [mem 0xd0400000-0xd07fffff]
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.877426] pci 0000:01:00.0:
> EDR: Notify handler installed
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.877850] pci_bus 0000:01:
> bus scan returning with max=01
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.877872] pcieport
> 0000:00:1c.2: scanning [bus 02-02] behind bridge, pass 0
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.877898] pci_bus 0000:02:
> scanning bus
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.877915] pci_bus 0000:02:
> bus scan returning with max=02
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.877932] pcieport
> 0000:00:1c.3: scanning [bus 03-03] behind bridge, pass 0
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.877956] pci_bus 0000:03:
> scanning bus
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.877965] pci_bus 0000:03:
> bus scan returning with max=03
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.877982] pcieport
> 0000:00:1c.0: scanning [bus 01-01] behind bridge, pass 1
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.878013] pcieport
> 0000:00:1c.2: scanning [bus 02-02] behind bridge, pass 1
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.878043] pcieport
> 0000:00:1c.3: scanning [bus 03-03] behind bridge, pass 1
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.878066] pci_bus 0000:00:
> bus scan returning with max=03
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.878094] pci 0000:01:00.0:
> BAR 0: assigned [mem 0xd0400000-0xd07fffff]
> Apr 30 20:01:05 xilinxtest1 kernel: [6612195.878204] XILINX_FPGA PCI
> 0000:01:00.0: runtime IRQ mapping not provided by arch
> 
> 
> Our Questions:
> 
> What could trigger such a PCIe device re-enumeration without a physical event?
> 
> Are there any known kernel or platform-level triggers that might cause this?
> 
> Any debug hooks or sysfs entries we should monitor or enable to catch
> the root cause?

If you can point us to the source for the driver you're using, we
might be able to help.

Otherwise, adding dump_stack() in your .probe() and .remove()
functions might give clues.

Bjorn

