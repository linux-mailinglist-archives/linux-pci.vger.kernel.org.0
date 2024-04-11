Return-Path: <linux-pci+bounces-6154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 833788A2048
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 22:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F1A1F221D2
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 20:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E1117C7B;
	Thu, 11 Apr 2024 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slQfO4Yu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A3029417;
	Thu, 11 Apr 2024 20:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867693; cv=none; b=T3sMEgIHIcTI7bC8kzwVdKycOvKW2Y2/CVpC1tue/SkhaK/aiwz6Ag7TPoU89djrshLXFvKAhyNqjJa2v49NxLgoPP6N7lC6sAR9HV0+trjj93yzBXPLJRWcwQ6eFidf3dEOCfrMST/8/Sj4fX0vfA1rwln3Gt/BsS55sGlPXaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867693; c=relaxed/simple;
	bh=9I3BW9al1fnQ0MtkczhNQoRl2kehBKmTZx4LxVoh0cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRlxFiV5iAZ26uI74smCxlIIN6C1pGt/hIxg3kVOhrpFCMLy7hGfCW2t6jSMcBCzXfg4r1nANgsDquvABV1Tzm7/CmCkDvyS4HhxgMJA5itVsPP+dPkd2DqxYM6IumMhlGEUex75RjMKy23ZcEf+cGh3sRhxhV9LXaAZGHroO0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slQfO4Yu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFD8C072AA;
	Thu, 11 Apr 2024 20:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712867692;
	bh=9I3BW9al1fnQ0MtkczhNQoRl2kehBKmTZx4LxVoh0cQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=slQfO4YuWHa5Kq1Dp9bOG+CYajJ0A8owzrfeBgxdPAjvZLlJGWQF0nCkyF6hbdrAA
	 U6oHGUoSj+rTAvCp5iywDP3kj64mXITzC0KOYKjGJHrC0JtPTcYApUcEjX18TiIHCm
	 1nsF7rzWwkOxCZNGzC6U53V8aFAZbblD8KRo0KMuOCCKA9h+iVQ2CDu9n5bM71dHk7
	 5yDx1iFXzuOvL1VHz3mv4JQFiT3D4tWoHe8peAV2aghVefoAjZQk4GJrONS6M42qXl
	 proNfIXgjsGvEp/SpZdQmvMMCpgvnWUIYNBLykY7I1LW2Om7aAJkbSwhNEBsZPgSHZ
	 oxZPqk4QJSgbQ==
Date: Thu, 11 Apr 2024 15:34:49 -0500
From: Rob Herring <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Herve Codina <herve.codina@bootlin.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
	Max Zhen <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>,
	Stefano Stabellini <stefano.stabellini@xilinx.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: of: Attach created of_node to existing device
Message-ID: <20240411203449.GA2641-robh@kernel.org>
References: <20240325153919.199337-1-herve.codina@bootlin.com>
 <20240325153919.199337-3-herve.codina@bootlin.com>
 <2024041142-applause-spearman-bd38@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024041142-applause-spearman-bd38@gregkh>

On Thu, Apr 11, 2024 at 03:23:55PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Mar 25, 2024 at 04:39:15PM +0100, Herve Codina wrote:
> > The commit 407d1a51921e ("PCI: Create device tree node for bridge")
> > creates of_node for PCI devices.
> > 
> > During the insertion handling of these new DT nodes done by of_platform,
> > new devices (struct device) are created. For each PCI devices a struct
> > device is already present (created and handled by the PCI core).
> > Having a second struct device to represent the exact same PCI device is
> > not correct.
> > 
> > On the of_node creation:
> > - tell the of_platform that there is no need to create a device for this
> >   node (OF_POPULATED flag),
> > - link this newly created of_node to the already present device,
> > - tell fwnode that the device attached to this of_node is ready using
> >   fwnode_dev_initialized().
> > 
> > With this fix, the of_node are available in the sysfs device tree:
> > /sys/devices/platform/soc/d0070000.pcie/
> > + of_node -> .../devicetree/base/soc/pcie@d0070000
> > + pci0000:00
> >   + 0000:00:00.0
> >     + of_node -> .../devicetree/base/soc/pcie@d0070000/pci@0,0
> >     + 0000:01:00.0
> >       + of_node -> .../devicetree/base/soc/pcie@d0070000/pci@0,0/dev@0,0
> > 
> > On the of_node removal, revert the operations.
> > 
> > Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> 
> I need an ack from the maintainer here before I can take this.

Correct me if I'm wrong, but having the of_node sysfs link populated or 
changed after device_add is a race we lost. Userspace is notified about 
the new device and then some time later the symlink shows up.

However, it so far is not appearing that there's an easy way to 
reshuffle order of things to fix this.

Maybe the short term (and stable) answer just don't create any of_node 
symlinks on these dynamically created nodes.

Rob

