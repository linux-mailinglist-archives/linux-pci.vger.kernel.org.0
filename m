Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC5E3E8681
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 01:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhHJX2B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Aug 2021 19:28:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234470AbhHJX2B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Aug 2021 19:28:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5161660551;
        Tue, 10 Aug 2021 23:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628638058;
        bh=6iPB0AbzSm7HODbCyg5KLlAo2RPy57aRQOOWAgrSrEc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qM/qY4W4W4elcZICZhfmoj5pOp7JTj5IbeandeMHqKveNEIz10ruAZgC/zaSrvnwo
         Qp8ajl0nHC47VIeuyfrc1cfdXwKKFlUYS+qnb2xQNwL+3xaFb5rCeqpByDqBtVdygG
         Ht4G8Tntn/UkVvUoK94Wrp5/jki1fgr6NGErVPSCaz7s0p503lL1c9CKjyqojFR/Up
         cITnl6lf2a9nH5ckOkQ+dLw92PrQxkqYLa1PAv7r8akwlCvOSuc1sXeHWtz94XBQle
         Ivq31kXQRIpz6X3UfqkwqDM0rND+4Qiwd+p4M72Zrzlynh5++U+W7Fe8xazrSv++LS
         CRP9LOEIIHIBA==
Date:   Tue, 10 Aug 2021 18:27:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     linux-pci@vger.kernel.org, Artem Lapkin <email2tema@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: Re: ARM Max Read Req Size and PCIE_BUS_PERFORMANCE stories
Message-ID: <20210810232736.GA2315513@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m3zgtp8tvz.fsf@t19.piap.pl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Artem, Art, Neil, Huacai]

On Tue, Aug 10, 2021 at 12:40:48PM +0200, Krzysztof Hałasa wrote:
> Hi,
> 
> Background: I'm using an ARMv7 (i.MX6) system with an RTL8111 (aka
> RTL8169) network interface. By default, the system is using
> PCIE_BUS_DEFAULT:
> 
> config PCIE_BUS_DEFAULT
>           Default choice; ensure that the MPS matches upstream bridge.
> 
> and the r8169 driver doesn't work - the RTL chip requests PCIe read
> longer than 512 bytes, and the CPU rejects the request.

Super.  IIUC, i.MX6 is another DWC-based controller, so this looks
like another case of the issue that afflicts amlogic, keystone,
loongson (weirdly apparently *not* DWC-based), meson, and probably
others.

Some previous discussion here:
https://lore.kernel.org/linux-pci/20210707155418.GA897940@bjorn-Precision-5520/

> I've traced the problem to this: (r8169_main.c: rtl_jumbo_config())
> 	int readrq = 4096;
> ...
> 	if (pci_is_pcie(tp->pci_dev) && tp->supports_gmii)
> 		pcie_set_readrq(tp->pci_dev, readrq);
> 
> I've verified that changing the value back to 512 (after r8168 driver
> set it to 4096) makes it work again.

This sounds like a defect in the CPU/PCI host adapter.  If the device
initiates a 4096-byte read and the CPU or whatever can't deal with it,
the host adapter should break it up into whatever the CPU *can*
handle.  I don't think this is the device's problem or the device
driver's problem.

There is no mechanism in the PCIe or ACPI spec for the driver to learn
the maximum MRRS value the CPU can tolerate.

> We have several PCIE_BUS_* modes, all guarded by CONFIG_EXPERT. I've
> verified that PCIE_BUS_PERFORMANCE also fixes the problem. It sets
> MaxReadReqSize to MaxPayloadSize which is equal to 128 on i.MX6.
> This is, most probably, suboptimal (despite "performance" in the name).

Yes.

> Now, how should it be fixed (so it works by default)?
> 1. should the drivers be banned from using pcie_set_readrq() etc?
>    I believe some chips may require MRRS adjustment by the driver,
>    though.

I don't know the details of this particular situation, but ideally,
drivers should not change MRRS or MPS.  If they do, they definitely
need to use a PCI core interface like pcie_set_readrq() because these
are system-level parameters that need to be considered in relation to
other devices in the hierarchy and sometimes to problems in the PCI
host adapter.

> 2. should the PCI code limit MRRS to MPS by default?
> 3. should the PCI code limit MRRS to the maximum safe value (512 on
>    this CPU)?

How do we learn the maximum safe value?  Is this something a native
driver could read from PCIE_PL_MRCCR0 (see below)?

This sounds like a real train wreck if any of these designs want to
use ACPI.  There's nothing in ACPI to communicate a "maximum safe
MRRS" value to the OS.

> Does hardware like common x86 have a "maximum safe value" (lower than
> 4096)?

Not that I'm aware of.

> Any other ideas?
> 
> i.MX6 details:
> There is mysterious CX_REMOTE_RD_REQ_SIZE (CPU design time constant)
> and the Remote_Read_Request_Size, a part of PCIE_PL_MRCCR0 register:
> 
> "Remote Read Request Size specifies the largest amount of data (bytes)
> that will ever be requested (via an inbound MemRd TLP) by a remote
> device. Must never be programmed with a value that exceeds the value
> represented by the configuration parameter CX_REMOTE_RD_REQ_SIZE as the
> Master Response Composer RAM in the AXI bridge is sized using
> CX_REMOTE_RD_REQ_SIZE."
> 
> Default value is 512 bytes (and works) and while I think it may be
> possible to set it to 1024 or even 2048 bytes, it doesn't seem to work.
> The "Remote Max Bridge Tag" (which is calculated automatically by the
> CPU based on "Remote Read Request Size" changes from 3 to 1 (which may
> make sense):
> 
> "Remote Read Request Size" vs. "Remote Max Bridge Tag"
>  128 13 <<< does that mean 14 simultaneous requests? Or 13?
>  256  6
>  512  3
> 1024  1
> 2048  0 <<< a single request? No requests?
> 4096 31 <<< apparently some internal logic failure
