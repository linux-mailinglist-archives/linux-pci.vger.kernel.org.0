Return-Path: <linux-pci+bounces-6172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8792B8A28EE
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 10:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CFA2854CB
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 08:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58FF4EB3F;
	Fri, 12 Apr 2024 08:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pBrJVHzS"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E944C4E1B3;
	Fri, 12 Apr 2024 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909434; cv=none; b=QbhNgKICmrNFx6xKikCQyd2+qtYGc5nkVe3eawbl0SLExEDrYpxBheWgdDHl26NzE2/XqKXYHCRfte3uPch5a+Rmo87dEkncl2OCwbkQIfyzPw6VtK/ljtCa7UiZvNxL6E6rcxak8eVW5KqB8zjB0diVJvGjKeF9p1oaqwiyAiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909434; c=relaxed/simple;
	bh=lyrvQ1jQSDzDlOlLk6Ni8xRBq5CvyRT9MGKZEiVCukg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cp7JztNTTlUMRe+8EAsOR2MePSCS8M6YS6ziAsBDfawTvayW3fIZQomfsSPXKdv5MCfINNfXHGIlalfFZo/K85XSyEAkZFvxjoVCzfHs8xV031jXz2BtC2YEb/oWh3nnDfYo9GpK/CngphHcD3OUWe6FTKPA6tnrf5HPook8W5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pBrJVHzS; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EFFD360007;
	Fri, 12 Apr 2024 08:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712909421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0E7/dykhn14vt5idbhGa3zPIsvtfStWumlOd8mo6+0=;
	b=pBrJVHzSSzlEzc5mqWMjA8Ebi4s/3qDkjT4bVoMZncY6YlMUaVSbtpMHizdauR8LTxd8hW
	OrzVVpm/3TTgrHYaNi33eVL/nal4LrhFQDkb2JTcX6MLbJyy0Ll6EAY0HOfD/zoKqeD4fL
	RD3Al1Mpkmry4eBsj+LCpgz1WDe1SFsKtGOpuVmBwQNdv3Ci42vGvoZ757A6/E7XPf/fV0
	wLu85gSC6ydbLRo00vyDiB/HyVeSzh0Aty396FnUJN0//u0CBaQhWHgo7k0/x9bYPHdIJX
	/Y+BlPo6sA5ty+IqxzIthendSUW1adLNzWGiodC05S9LXy7r4fuYGq0p1ewyEQ==
Date: Fri, 12 Apr 2024 10:10:19 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>, Max
 Zhen <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>, Stefano
 Stabellini <stefano.stabellini@xilinx.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?=
 <kwilczynski@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: of: Attach created of_node to existing
 device
Message-ID: <20240412101019.7ceee755@bootlin.com>
In-Reply-To: <2024041219-impure-upcountry-9e9d@gregkh>
References: <20240325153919.199337-1-herve.codina@bootlin.com>
	<20240325153919.199337-3-herve.codina@bootlin.com>
	<2024041142-applause-spearman-bd38@gregkh>
	<20240411203449.GA2641-robh@kernel.org>
	<2024041219-impure-upcountry-9e9d@gregkh>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Greg, Rob,

On Fri, 12 Apr 2024 09:41:19 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Apr 11, 2024 at 03:34:49PM -0500, Rob Herring wrote:
> > On Thu, Apr 11, 2024 at 03:23:55PM +0200, Greg Kroah-Hartman wrote:  
> > > On Mon, Mar 25, 2024 at 04:39:15PM +0100, Herve Codina wrote:  
> > > > The commit 407d1a51921e ("PCI: Create device tree node for bridge")
> > > > creates of_node for PCI devices.
> > > > 
> > > > During the insertion handling of these new DT nodes done by of_platform,
> > > > new devices (struct device) are created. For each PCI devices a struct
> > > > device is already present (created and handled by the PCI core).
> > > > Having a second struct device to represent the exact same PCI device is
> > > > not correct.
> > > > 
> > > > On the of_node creation:
> > > > - tell the of_platform that there is no need to create a device for this
> > > >   node (OF_POPULATED flag),
> > > > - link this newly created of_node to the already present device,
> > > > - tell fwnode that the device attached to this of_node is ready using
> > > >   fwnode_dev_initialized().
> > > > 
> > > > With this fix, the of_node are available in the sysfs device tree:
> > > > /sys/devices/platform/soc/d0070000.pcie/
> > > > + of_node -> .../devicetree/base/soc/pcie@d0070000
> > > > + pci0000:00
> > > >   + 0000:00:00.0
> > > >     + of_node -> .../devicetree/base/soc/pcie@d0070000/pci@0,0
> > > >     + 0000:01:00.0
> > > >       + of_node -> .../devicetree/base/soc/pcie@d0070000/pci@0,0/dev@0,0
> > > > 
> > > > On the of_node removal, revert the operations.
> > > > 
> > > > Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>  
> > > 
> > > I need an ack from the maintainer here before I can take this.  
> > 
> > Correct me if I'm wrong, but having the of_node sysfs link populated or 
> > changed after device_add is a race we lost. Userspace is notified about 
> > the new device and then some time later the symlink shows up.  
> 
> Ah, yes, I missed that, good catch, this will not work.
> 
> > However, it so far is not appearing that there's an easy way to 
> > reshuffle order of things to fix this.
> > 
> > Maybe the short term (and stable) answer just don't create any of_node 
> > symlinks on these dynamically created nodes.  
> 
> That would work, but does userspace really need to know this
> information?
> 

I don't think that the user space really need this information.
I agree, it should work.

Let me rework my series in that sense and perform some tests before
sending a new iteration removing the of_node sysfs link creation.

Best regards,
Hervé

