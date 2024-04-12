Return-Path: <linux-pci+bounces-6170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E418A2861
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 09:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD273B2325B
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 07:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D894C601;
	Fri, 12 Apr 2024 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uaqj3G6J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4AA3218B;
	Fri, 12 Apr 2024 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907683; cv=none; b=Cl9Xi6pRC/J39D3GrX29atxIFjaoJNhtE4rMBG/Il5MWTNibk94PekOmvQhqSNYYs7AxDMW6Lz4u/zU6uyQjON5Dp6RDWf/jX4EboV+gnjw3zKOwcMlqftYHD/TcQta9iuz5T/vUtt+iXXloyhG9ZXkz3FCElfSsvHeHLSVM6XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907683; c=relaxed/simple;
	bh=LR+bEwyj9w9Lz1Iy+tTJ6XhyijBDBX//2OTo3KKfYvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZntqnS8z51fZ9LiscHVd16ZO3dtGflXAkRT6oQ8Cnpc5nBTix21j5Jplmr8rTvOCjyvlLzlwfHRFQBT/mamsXcIvz+3CGJqiuLBIDKkQhfdOBxSqYi10FUn710SWgz+tYygcaj8YMYunjq3afu7MBPyZBSG5WXYcjLb59KDQik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uaqj3G6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA9CC113CC;
	Fri, 12 Apr 2024 07:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712907682;
	bh=LR+bEwyj9w9Lz1Iy+tTJ6XhyijBDBX//2OTo3KKfYvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uaqj3G6JwGUsGiKVZAnZ/RABtuhKdxdxGmICk8vmMfDrEhUHa8ClA+BCqBs48OjZp
	 t0n+sysKV81IUSZ5qM9PJFCMAPE/FOf2f84Qsb0BDZ6rYgxd9BAkg77O7OFfxI2Nau
	 HXGUtnBS6btQvSv7Bgrr+5Gfg3b+QDwFbdpPdS7o=
Date: Fri, 12 Apr 2024 09:41:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rob Herring <robh@kernel.org>
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
Message-ID: <2024041219-impure-upcountry-9e9d@gregkh>
References: <20240325153919.199337-1-herve.codina@bootlin.com>
 <20240325153919.199337-3-herve.codina@bootlin.com>
 <2024041142-applause-spearman-bd38@gregkh>
 <20240411203449.GA2641-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411203449.GA2641-robh@kernel.org>

On Thu, Apr 11, 2024 at 03:34:49PM -0500, Rob Herring wrote:
> On Thu, Apr 11, 2024 at 03:23:55PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Mar 25, 2024 at 04:39:15PM +0100, Herve Codina wrote:
> > > The commit 407d1a51921e ("PCI: Create device tree node for bridge")
> > > creates of_node for PCI devices.
> > > 
> > > During the insertion handling of these new DT nodes done by of_platform,
> > > new devices (struct device) are created. For each PCI devices a struct
> > > device is already present (created and handled by the PCI core).
> > > Having a second struct device to represent the exact same PCI device is
> > > not correct.
> > > 
> > > On the of_node creation:
> > > - tell the of_platform that there is no need to create a device for this
> > >   node (OF_POPULATED flag),
> > > - link this newly created of_node to the already present device,
> > > - tell fwnode that the device attached to this of_node is ready using
> > >   fwnode_dev_initialized().
> > > 
> > > With this fix, the of_node are available in the sysfs device tree:
> > > /sys/devices/platform/soc/d0070000.pcie/
> > > + of_node -> .../devicetree/base/soc/pcie@d0070000
> > > + pci0000:00
> > >   + 0000:00:00.0
> > >     + of_node -> .../devicetree/base/soc/pcie@d0070000/pci@0,0
> > >     + 0000:01:00.0
> > >       + of_node -> .../devicetree/base/soc/pcie@d0070000/pci@0,0/dev@0,0
> > > 
> > > On the of_node removal, revert the operations.
> > > 
> > > Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > 
> > I need an ack from the maintainer here before I can take this.
> 
> Correct me if I'm wrong, but having the of_node sysfs link populated or 
> changed after device_add is a race we lost. Userspace is notified about 
> the new device and then some time later the symlink shows up.

Ah, yes, I missed that, good catch, this will not work.

> However, it so far is not appearing that there's an easy way to 
> reshuffle order of things to fix this.
> 
> Maybe the short term (and stable) answer just don't create any of_node 
> symlinks on these dynamically created nodes.

That would work, but does userspace really need to know this
information?

thanks,

greg k-h

