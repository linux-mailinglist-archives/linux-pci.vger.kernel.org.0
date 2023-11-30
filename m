Return-Path: <linux-pci+bounces-294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E8D7FF5CE
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 17:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C30281847
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 16:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E61649F9C;
	Thu, 30 Nov 2023 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mMdBAWV8"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0D41B4;
	Thu, 30 Nov 2023 08:31:57 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 323F92000A;
	Thu, 30 Nov 2023 16:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701361916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gV797xi3EHSsgCrohMrZSKeBc2F3mil55AHD5+9kXrY=;
	b=mMdBAWV8m01Tg4INI11/mzYDWX0kf3pzOfTi039efVlOvsIrsMqYFZxwwhQ7PDK2lMvoiT
	+i9DwVp+gnxMeXKfX1ZC+skcTbImVXeVnHyXLrnYCRh1xPFfoIl3gpq5Cv2mCKImVYe/+F
	A/rpY/AcJqomxU8jIB3nCzs6qRQFtGLfA9h9rQUuChX4dneMvYrA8wvxNco/oJrAX19ZXG
	/PgZLIklOt1LPzj29JI35SNkMDGyzuYiDf7AQr7kIRGSu0TcSWYoHjl/GapZ1MgDmCwFHC
	rLbg/ULOb0AETBWXfxscSZwtkkKdbExE/OcMuzBndJilW1zqTdVz8BAn9Q6Iuw==
Date: Thu, 30 Nov 2023 17:31:53 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>, Rob Herring
 <robh@kernel.org>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: of: Attach created of_node to existing device
Message-ID: <20231130173153.1ce8a354@bootlin.com>
In-Reply-To: <2023113008-prenatal-pushchair-956f@gregkh>
References: <20231130152418.680966-1-herve.codina@bootlin.com>
	<20231130152418.680966-3-herve.codina@bootlin.com>
	<2023113008-prenatal-pushchair-956f@gregkh>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Greg,

On Thu, 30 Nov 2023 16:18:58 +0000
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Nov 30, 2023 at 04:24:04PM +0100, Herve Codina wrote:
> > The commit 407d1a51921e ("PCI: Create device tree node for bridge")
> > creates of_node for PCI devices.
> > During the insertion handling of these new DT nodes done by of_platform,
> > new devices (struct device) are created.
> > For each PCI devices a struct device is already present (created and
> > handled by the PCI core).
> > Having a second struct device to represent the exact same PCI device is
> > not correct.
> > 
> > On the of_node creation, tell the of_platform that there is no need to
> > create a device for this node (OF_POPULATED flag), link this newly
> > created of_node to the already present device and tell fwnode that the
> > device attached to this of_node is ready (fwnode_dev_initialized()).
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
> 
> How can this be cc: stable when the api it relies on is not?
> 
> confused,

My bad, I will add cc: stable in the other patch needed.

Sorry about that.
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

