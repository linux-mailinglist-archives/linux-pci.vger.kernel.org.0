Return-Path: <linux-pci+bounces-33704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC59AB2021A
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 10:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 291EE7A5FD6
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 08:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4ED2DCBF7;
	Mon, 11 Aug 2025 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCuCONJc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA782DC34F;
	Mon, 11 Aug 2025 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754901760; cv=none; b=J37zWMJJBPgTG75hF3o9+EtOcflJICRZpKe01qqnk+C6BRIv7bQC0dvwFjpKtehV3mvMmPUEQeeuoed25kScFUFo4yvDSe2Kc6eA+InDNibBR21OBwosaxg7Nu4nFPkDepahxNEh10rFGFrKHI56/5bPyd7BHMnWC4Mg3bH9eGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754901760; c=relaxed/simple;
	bh=JDNNTD+SRMn0si8y5OWJhsNjo2s9JrTceyqBhranGMc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LHT8UaUovdka+bo86GdU+wDqHtI0F8NqJdQZZEAcT+hTZoOm76kutq3dPJB8R4hZHXgMjEYyi+Re2Xkk2AHa5SwP+utCiutNdM0JVFJm8Yz9UUlIjkJ/DOFBHo3uXcOt3abbIEYaSs+sNC5pbOoO8Ha15XejA1lnip0UMtNBbbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCuCONJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3356C4CEED;
	Mon, 11 Aug 2025 08:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754901757;
	bh=JDNNTD+SRMn0si8y5OWJhsNjo2s9JrTceyqBhranGMc=;
	h=Date:From:To:Cc:Subject:From;
	b=gCuCONJc3Ct8dG4sC7W8BzlcNRGv+wX9YC/eGN2Pb9syJvegCiWF9DSXQbYGOdkya
	 HYgt9dRKSlwyMU6MjsXOreUUuhSgApbDVlX8xn+CMEwNxzHlAw+L9S2ZdZcCEGgDkc
	 LW19JxRSdyVM/phVMKeKWJ7xzW5vJIcdRsPEOnsVmKvhLTC441DjZ1v7TS73cF3Zkk
	 oLikz77oe3u3jBxrOuGd1s5L4RLWmj34HDs7gUtNuC4X5iiEvb0rMLLqoVb3LzK+qf
	 n3099Uk2Zx3UBQkRX3XlYDWbEIkRjiUwWXi8ZnLRHKHTGnD0iOr6XSmHkRaKJXRqQj
	 cZp6AJ74xFCyw==
Date: Mon, 11 Aug 2025 10:42:33 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Lizhi Hou <lizhi.hou@amd.com>, Rob Herring <robh@kernel.org>
Cc: maz@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Issues with OF_DYNAMIC PCI bridge node generation
 (kmemleak/interrupt-map IC reg property)
Message-ID: <aJms+YT8TnpzpCY8@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lizhi, Rob,

while debugging something unrelated I noticed two issues
(related) caused by the automatic generation of device nodes
for PCI bridges.

GICv5 interrupt controller DT top level node [1] does not have a "reg"
property, because it represents the top level node, children (IRSes and ITSs)
are nested.

It does provide #address-cells since it has child nodes, so it has to
have a "ranges" property as well.

You have added code to automatically generate properties for PCI bridges
and in particular this code [2] creates an interrupt-map property for
the PCI bridges (other than the host bridge if it has got an OF node
already).

That code fails on GICv5, because the interrupt controller node does not
have a "reg" property (and AFAIU it does not have to - as a matter of
fact, INTx mapping works on GICv5 with the interrupt-map in the
host bridge node containing zeros in the parent unit interrupt
specifier #address-cells).

It is not clear to me why, to create an interrupt-map property, we
are reading the "reg" value of the parent IC node to create the
interrupt-map unit interrupt specifier address bits (could not we
just copy the address in the parent unit interrupt specifier reported
in the host bridge interrupt-map property ?).

- #address-cells of the parent describes the number of address cells of
  parent's child nodes not the parent itself, again, AFAIK, so parsing "reg"
  using #address-cells of the parent node is not entirely correct, is it ?
- It is unclear to me, from an OF spec perspective what the address value
  in the parent unit interrupt specifier ought to be. I think that, at
  least for dts including a GICv3 IC, the address values are always 0,
  regardless of the GICv3 reg property.

I need your feedback on this because the automatic generation must
work seamlessly for GICv5 as well (as well as all other ICs with no "reg"
property) and I could not find anything in the OF specs describing
how the address cells in the unit interrupt specifier must be computed.

I found this [3] link where in section 7 there is an interrupt mapping
algorithm; I don't understand it fully and I think it is possibly misleading.

Now, the failure in [2] (caused by the lack of a "reg" property in the
IC node) triggers an interrupt-map property generation failure for PCI
bridges that are upstream devices that need INTx swizzling.

In turn, that leads to a kmemleak detection:

unreferenced object 0xffff000800368780 (size 128):
  comm "swapper/0", pid 1, jiffies 4294892824
  hex dump (first 32 bytes):
    f0 b8 34 00 08 00 ff ff 04 00 00 00 00 00 00 00  ..4.............
    70 c2 30 00 08 00 ff ff 00 00 00 00 00 00 00 00  p.0.............
  backtrace (crc 1652b62a):
    kmemleak_alloc+0x30/0x3c
    __kmalloc_cache_noprof+0x1fc/0x360
    __of_prop_dup+0x68/0x110
    of_changeset_add_prop_helper+0x28/0xac
    of_changeset_add_prop_string+0x74/0xa4
    of_pci_add_properties+0xa0/0x4e0
    of_pci_make_dev_node+0x198/0x230
    pci_bus_add_device+0x44/0x13c
    pci_bus_add_devices+0x40/0x80
    pci_host_probe+0x138/0x1b0
    pci_host_common_probe+0x8c/0xb0
    platform_probe+0x5c/0x9c
    really_probe+0x134/0x2d8
    __driver_probe_device+0x98/0xd0
    driver_probe_device+0x3c/0x1f8
    __driver_attach+0xd8/0x1a0

I have not grokked it yet but it seems genuine, so whatever we decide
in relation to "reg" above, this ought to be addressed too, if it
is indeed a memleak.

Please let me know if something is unclear I can provide further
details.

Thanks,
Lorenzo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5.yaml?h=v6.17-rc1
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/of_property.c?h=v6.17-rc1#n283
[3] https://www.devicetree.org/open-firmware/practice/imap/imap0_9d.html

