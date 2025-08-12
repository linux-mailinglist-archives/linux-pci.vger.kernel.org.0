Return-Path: <linux-pci+bounces-33867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB882B22D57
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 18:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077DE62491C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEE52F7475;
	Tue, 12 Aug 2025 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAyjZUWL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAB22F28F0;
	Tue, 12 Aug 2025 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015465; cv=none; b=pzSuTdfkS49MGWMlVyhkD8sE5cnauI3jST9KfFikwvUL3sG22U9QZwuqmVA4xxlg+Q2nzPt1yUl7TuT1yvWu4zfuwcwdgQafY/wcJiZFDsFyTBNZ6x/1Fhu7El5FZDN/WjaMIqJYMft553oajwAtNjQD70i8mHSNACeXCtEbzpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015465; c=relaxed/simple;
	bh=BoG6J0vitsZeMhBXYAdB4om3bGHuAZphoElNcm/lDZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyypC6R44QgfoafYsT4SWPfrHfiRJ35VTYegABAJJXMWoTbZ0mGZ7BbszI/0PfugmauviWLezRrkJ+KhALIPw6dsX5z93cvNUjVYgKg75SqYLmcyJuwrHIucBjk/aRgtloBLKq/D8tmHt3dTmTTUPYb2Gvo/Mp9u/+N6LxWbiUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAyjZUWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D83DC4CEF0;
	Tue, 12 Aug 2025 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755015465;
	bh=BoG6J0vitsZeMhBXYAdB4om3bGHuAZphoElNcm/lDZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZAyjZUWL/goWT25QQOy/iTxXRTC113j6c0PxQKYkoJFpKfk+R4pH4O73XfBbdLlUT
	 kyw/UTJ8oH6BAwfSTND7jv9Q/SyKI4ms54oiZWPNu8hXgPOkMq28ZdnaN9mvRHT3No
	 hYTTwPwyjxSB/nY1GxyrxFtB8AHSt+fU7m4iN9qZTzZHh0PGplX1bHulkNdsGT7XSZ
	 12TAqWDfDfnukFfv/dLxNbkECPwqhQ1jkyUDt+OTHXfn/Fu0dCEh3Al9si/GiIotXh
	 xK49KukiVy4Hay0DPo+4Qtsq2BQht7qzLRLBWg9x0P1mYB3M2FOH61Df/pd0GDVfZh
	 Hv9NiUqm7uAGg==
Date: Tue, 12 Aug 2025 18:17:40 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: Rob Herring <robh@kernel.org>, maz@kernel.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Issues with OF_DYNAMIC PCI bridge node generation
 (kmemleak/interrupt-map IC reg property)
Message-ID: <aJtpJEPjrEq8Z78F@lpieralisi>
References: <aJms+YT8TnpzpCY8@lpieralisi>
 <c627564a-ccc3-9404-ba87-078fb8d10fea@amd.com>
 <aJrwgKUNh68Dx1Fo@lpieralisi>
 <e15ebb26-15ac-ef7a-c91b-28112f44db55@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e15ebb26-15ac-ef7a-c91b-28112f44db55@amd.com>

On Tue, Aug 12, 2025 at 08:53:06AM -0700, Lizhi Hou wrote:
> 
> On 8/12/25 00:42, Lorenzo Pieralisi wrote:
> > On Mon, Aug 11, 2025 at 08:26:11PM -0700, Lizhi Hou wrote:
> > > On 8/11/25 01:42, Lorenzo Pieralisi wrote:
> > > 
> > > > Hi Lizhi, Rob,
> > > > 
> > > > while debugging something unrelated I noticed two issues
> > > > (related) caused by the automatic generation of device nodes
> > > > for PCI bridges.
> > > > 
> > > > GICv5 interrupt controller DT top level node [1] does not have a "reg"
> > > > property, because it represents the top level node, children (IRSes and ITSs)
> > > > are nested.
> > > > 
> > > > It does provide #address-cells since it has child nodes, so it has to
> > > > have a "ranges" property as well.
> > > > 
> > > > You have added code to automatically generate properties for PCI bridges
> > > > and in particular this code [2] creates an interrupt-map property for
> > > > the PCI bridges (other than the host bridge if it has got an OF node
> > > > already).
> > > > 
> > > > That code fails on GICv5, because the interrupt controller node does not
> > > > have a "reg" property (and AFAIU it does not have to - as a matter of
> > > > fact, INTx mapping works on GICv5 with the interrupt-map in the
> > > > host bridge node containing zeros in the parent unit interrupt
> > > > specifier #address-cells).
> > > Does GICv5 have 'interrupt-controller' but not 'interrupt-map'? I think
> > > of_irq_parse_raw will not check its parent in this case.
> > But that's not the problem. GICv5 does not have an interrupt-map,
> > the issue here is that GICv5 _is_ the parent and does not have
> > a "reg" property. Why does the code in [2] check the reg property
> > for the parent node while building the interrupt-map property for
> > the PCI bridge ?
> 
> Based on the document, if #address-cells is not zero, it needs to get parent
> unit address. Maybe there is way to get the parent unit address other than
> read 'reg'?

Reading the parent "reg" using the parent #address-cells as address size does
not seem correct to me anyway.

> Or maybe zero should be used as parent unit address if 'reg' does not
> exist?

zeros are used for eg GICv3 interrupt-map properties, I suppose that's
a wild card to say "any device in the interrupt-controller bus",
whatever that means.

Just my interpretation, I don't know the history behind this.

> Rob, Could you give us some advise on this?

Please, thanks.

Lorenzo

> Thanks,
> 
> Lizhi
> 
> 
> > 
> > > > It is not clear to me why, to create an interrupt-map property, we
> > > > are reading the "reg" value of the parent IC node to create the
> > > > interrupt-map unit interrupt specifier address bits (could not we
> > > > just copy the address in the parent unit interrupt specifier reported
> > > > in the host bridge interrupt-map property ?).
> > > > 
> > > > - #address-cells of the parent describes the number of address cells of
> > > >     parent's child nodes not the parent itself, again, AFAIK, so parsing "reg"
> > > >     using #address-cells of the parent node is not entirely correct, is it ?
> > > > - It is unclear to me, from an OF spec perspective what the address value
> > > >     in the parent unit interrupt specifier ought to be. I think that, at
> > > >     least for dts including a GICv3 IC, the address values are always 0,
> > > >     regardless of the GICv3 reg property.
> > > > 
> > > > I need your feedback on this because the automatic generation must
> > > > work seamlessly for GICv5 as well (as well as all other ICs with no "reg"
> > > > property) and I could not find anything in the OF specs describing
> > > > how the address cells in the unit interrupt specifier must be computed.
> > > Please see: https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html
> > > 
> > > 2.4.3.1 mentions:
> > > 
> > > "Both the child node and the interrupt parent node are required to have
> > > #address-cells and #interrupt-cells properties defined. If a unit address
> > > component is not required, #address-cells shall be explicitly defined to be
> > > zero."
> > Yes, but again, that's not what I am asking. GICv5 requires
> > #address-cells (2.3.5 - link above - it has child nodes and it
> > has to define "ranges") but it does not require a "reg" property,
> > code in [2] fails.
> > 
> > That boils down to what does "a unit address component is not required"
> > means.
> > 
> > Why does the code in [2] read "reg" to build the parent unit interrupt
> > specifier (with #address-cells size of the parent, which, again, I
> > don't think it is correct) ?
> > 
> > > > I found this [3] link where in section 7 there is an interrupt mapping
> > > > algorithm; I don't understand it fully and I think it is possibly misleading.
> > > > 
> > > > Now, the failure in [2] (caused by the lack of a "reg" property in the
> > > > IC node) triggers an interrupt-map property generation failure for PCI
> > > > bridges that are upstream devices that need INTx swizzling.
> > > > 
> > > > In turn, that leads to a kmemleak detection:
> > > > 
> > > > unreferenced object 0xffff000800368780 (size 128):
> > > >     comm "swapper/0", pid 1, jiffies 4294892824
> > > >     hex dump (first 32 bytes):
> > > >       f0 b8 34 00 08 00 ff ff 04 00 00 00 00 00 00 00  ..4.............
> > > >       70 c2 30 00 08 00 ff ff 00 00 00 00 00 00 00 00  p.0.............
> > > >     backtrace (crc 1652b62a):
> > > >       kmemleak_alloc+0x30/0x3c
> > > >       __kmalloc_cache_noprof+0x1fc/0x360
> > > >       __of_prop_dup+0x68/0x110
> > > >       of_changeset_add_prop_helper+0x28/0xac
> > > >       of_changeset_add_prop_string+0x74/0xa4
> > > >       of_pci_add_properties+0xa0/0x4e0
> > > >       of_pci_make_dev_node+0x198/0x230
> > > >       pci_bus_add_device+0x44/0x13c
> > > >       pci_bus_add_devices+0x40/0x80
> > > >       pci_host_probe+0x138/0x1b0
> > > >       pci_host_common_probe+0x8c/0xb0
> > > >       platform_probe+0x5c/0x9c
> > > >       really_probe+0x134/0x2d8
> > > >       __driver_probe_device+0x98/0xd0
> > > >       driver_probe_device+0x3c/0x1f8
> > > >       __driver_attach+0xd8/0x1a0
> > > > 
> > > > I have not grokked it yet but it seems genuine, so whatever we decide
> > > > in relation to "reg" above, this ought to be addressed too, if it
> > > > is indeed a memleak.
> > > Not sure what is the leak. I will look into more.
> > Thanks,
> > Lorenzo
> > 
> > > 
> > > Lizhi
> > > 
> > > > Please let me know if something is unclear I can provide further
> > > > details.
> > > > 
> > > > Thanks,
> > > > Lorenzo
> > > > 
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5.yaml?h=v6.17-rc1
> > > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/of_property.c?h=v6.17-rc1#n283
> > > > [3] https://www.devicetree.org/open-firmware/practice/imap/imap0_9d.html

