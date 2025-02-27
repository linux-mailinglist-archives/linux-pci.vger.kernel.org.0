Return-Path: <linux-pci+bounces-22577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CA0A484A8
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 17:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F6E1786D5
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 16:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6020F27129C;
	Thu, 27 Feb 2025 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgCd7eHq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EEF271298;
	Thu, 27 Feb 2025 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672290; cv=none; b=TwQ7x9yRVmolZ7IoVwkI5vsegWdumZdIFBMXjyzh+G3RbdKEUmD5hYKInUX42LZ+pIMmvknAr0ggzdKS0QYssyX5tzi+RsK7OW+BH9zSZNVWeUDxs9l0UxJPCpKYFRQt6KUGNevALc5pjOPeYR1mXQoF108NY8bwdJ60aAdFApY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672290; c=relaxed/simple;
	bh=cUvKS7WQsngYM/cLQtfCvYOzx4ln3nJsq1TrZ/4MPFU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fFAkz/lOR1r2/Fzbu8qjXKeu2oLNRpLYUo06bQlCZlba5zKVkQqlJy8br8f+iQdpBLr5+DxUMnhM6viD41oRnU6XPrn5h2wrbUc8BZfUZkO2b+gOf+HSdl9MTQC6jS6/HFwc85kyQ6+Symqq1vCwwegCmJ8cBIzukszzjUHZBzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgCd7eHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D790FC4CEE6;
	Thu, 27 Feb 2025 16:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740672290;
	bh=cUvKS7WQsngYM/cLQtfCvYOzx4ln3nJsq1TrZ/4MPFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UgCd7eHqnEWWfha+aKtGhKB7EfDxtXDL1AuXhcDbNl03nnQFDdabk+lDOVc6ErtPn
	 hJLxgw2EdH7REb4fz/f/09aKwCh1UV0dqXH81uBf4vFmq19u24qdBsUmRLsU/3y2eI
	 oFisWVfXo9Sajmyl55NkZiSLt7driuwTpXF2w8LkZF1NT+Y/xLiUDwOT1i/1cqdUZU
	 TXx7c+sDd0ldW0RshghvzH9dFVtz6PIZrT4eNzxxg3EETpr8tvp3F2+/U4RRgmJqeR
	 WCxJtUATQxQosF/w8O3Zn2J+psiTDB1TE6ZFKONung5DjysV5COHjvnrbP53sv14ti
	 kmYcEIW1MW82w==
Date: Thu, 27 Feb 2025 10:04:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: Re: pci: acpi: Query on ACPI Device Tree Representation and
 Enumeration for Xilinx FPGA PCIe Endpoint functions
Message-ID: <20250227160448.GA597390@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHhAz+gUOK4Bn5ijO0H1b5=EtvD5W4GpOTtjP0--yVToNpkEDA@mail.gmail.com>

On Thu, Feb 27, 2025 at 07:25:32PM +0530, Muni Sekhar wrote:
> Hi all,
> 
> I am currently working on a project involving a Xilinx FPGA connected
> to an x86 CPU via a PCIe root port. The Xilinx FPGA functions as a
> PCIe endpoint with single function capability and is programmed to
> emulate the Soundwire Master controller. It can be dynamically
> reprogrammed to emulate other interfaces as needed. Essentially, the
> FPGA emulates an interface and connects to the CPU via the PCIe bus.
> 
> Given this setup, the BIOS does not have prior knowledge of the
> function implemented in the Xilinx FPGA PCIe endpoint. I have a couple
> of questions regarding this configuration:
> 
> Is it possible to define an ACPI Device Tree representation for this
> type of hardware setup?
> Can we achieve ACPI-based device enumeration with this configuration?

If the FPGA is programmed before BIOS enumerates PCI devices, the FPGA
would look just like any other PCI device, and BIOS would be able to
read the Vendor ID and Device ID and would be able to size and program
the BARs.

So I assume the FPGA is not programmed before BIOS enumeration, the
FPGA doesn't respond at all when BIOS or Linux reads the Vendor ID,
and you want to program the FPGA later and make Linux enumerate to
find it.

From Linux's point of view, this is basically a hot-add of a PCI
device.  If the Root Port supports hotplug and you have pciehp enabled
(CONFIG_HOTPLUG_PCI_PCIE=y) and if the FPGA comes out of reset and
brings up the PCIe link after being programmed, it all might "just
work."  You can also force a complete re-enumeration by writing a
non-zero value to /sys/bus/pci/rescan.

I'm not sure why you would need ACPI or a device tree to be involved.
ACPI and device tree are ways to tell the OS about devices that do not
have a native enumeration protocol.  PCI devices (like the programmed
FPGA) do support native enumeration, so generally we don't need ACPI
or device tree descriptions of them.  PCI host bridges have a
CPU-specific bus on the upstream side and a PCI bus on the downstream
side, so they are not themselves PCI devices, and we do need ACPI or
device tree descriptions for them.

If you have something that doesn't work like you expect, can you post
a complete dmesg log and any user commands you're using to program the
FPGA?

Bjorn

