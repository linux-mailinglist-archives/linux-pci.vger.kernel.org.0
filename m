Return-Path: <linux-pci+bounces-6124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D808A1571
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 15:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB452845AD
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 13:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FE914BFB4;
	Thu, 11 Apr 2024 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fcEaIz9k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F15335BC;
	Thu, 11 Apr 2024 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712841839; cv=none; b=ra3WszG6uoBKbapQLt3iIcP3rptdXbbYWUR+4njYz5hOsyulxrTyvAkBPQD191b3dJmUh8sEcRDuzKN3mQdc0fDSwU8+u2syzRBLyqKHw2+HdOfut2dWzR7Hx6CSyFpfOY/JXxcSHwvhpylE3IqCNhPBwmV9IBTQaqFB2SYHXF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712841839; c=relaxed/simple;
	bh=ETgA5noj6Ysp52fHUsZ5Xahb/AFo+afbTPHONR6SsNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyiXmoe2QIg2UKz2k7L2uoCU6Sob+R40C+z8BVJUV2n75OBm//k4NmwIcnvMnYlRisxka0CS5elsABJuPfYThlA2dTaqW/KPJQXgWULOBvoqujv+x7nNvfCKS/YKOCTG61bDyWo/Ze66HjE645i4PfftXcCgU2xfFFmrZ6N5Rws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fcEaIz9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0663C4AF50;
	Thu, 11 Apr 2024 13:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712841838;
	bh=ETgA5noj6Ysp52fHUsZ5Xahb/AFo+afbTPHONR6SsNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fcEaIz9k3Q4JpS8tEx7maD/lLU7Byeg3qH88bJrZZw/ILHbrSyNdM7ycqQP5KsEcL
	 jrpF+rlPaTDPwUDOjZhOj36XxyuV/vqh2JeflTu+H0P1DHQrndWZTYedLVJHfMurle
	 hCBMWSqVKtPKQSlxm1lyi9wNYaDVytKVB4NStey8=
Date: Thu, 11 Apr 2024 15:23:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
	Rob Herring <robh@kernel.org>, Max Zhen <max.zhen@amd.com>,
	Sonal Santan <sonal.santan@amd.com>,
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
Message-ID: <2024041142-applause-spearman-bd38@gregkh>
References: <20240325153919.199337-1-herve.codina@bootlin.com>
 <20240325153919.199337-3-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325153919.199337-3-herve.codina@bootlin.com>

On Mon, Mar 25, 2024 at 04:39:15PM +0100, Herve Codina wrote:
> The commit 407d1a51921e ("PCI: Create device tree node for bridge")
> creates of_node for PCI devices.
> 
> During the insertion handling of these new DT nodes done by of_platform,
> new devices (struct device) are created. For each PCI devices a struct
> device is already present (created and handled by the PCI core).
> Having a second struct device to represent the exact same PCI device is
> not correct.
> 
> On the of_node creation:
> - tell the of_platform that there is no need to create a device for this
>   node (OF_POPULATED flag),
> - link this newly created of_node to the already present device,
> - tell fwnode that the device attached to this of_node is ready using
>   fwnode_dev_initialized().
> 
> With this fix, the of_node are available in the sysfs device tree:
> /sys/devices/platform/soc/d0070000.pcie/
> + of_node -> .../devicetree/base/soc/pcie@d0070000
> + pci0000:00
>   + 0000:00:00.0
>     + of_node -> .../devicetree/base/soc/pcie@d0070000/pci@0,0
>     + 0000:01:00.0
>       + of_node -> .../devicetree/base/soc/pcie@d0070000/pci@0,0/dev@0,0
> 
> On the of_node removal, revert the operations.
> 
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

I need an ack from the maintainer here before I can take this.

thanks,

greg k-h

