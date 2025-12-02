Return-Path: <linux-pci+bounces-42467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8BAC9AD8A
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 10:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D62A24E2FC6
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 09:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3966330C619;
	Tue,  2 Dec 2025 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MfTUlGhn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094852FFDC0;
	Tue,  2 Dec 2025 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764667606; cv=none; b=k7h2PemchUSjP2VPl1mcX8DmPW7jpPDJW6/8Ci6tNPCjQZqgC9Mg1Jhubamw5OqUAN7DrHgtHjR0iuNVWJ/Suc+sK3ceyQM7xGGd5cVsdPpLQeJTxm8VrrpDVMmmfzWwYb1PCwzYC89rs/Uv7KBJuNOZeaiImGVra5BqXDTGfDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764667606; c=relaxed/simple;
	bh=e4ADKf5KnBtmyNx7K3nhN5sMxYdX8FSZtoZA9jdJSmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzFHiQ/CwZkXF2p48PaaBjrA2LV/tsAigklVlFpoNkuEk3tBCxZPTyyK9J0bXiE2sZAaSRFTkcJKk0QuJ3l/XvbWaDGnIR0pATFylKDqr2q1A9pqOcGQI9YrRMRjMPkzmSQJG2nIYpEt+lIbSf3ebW1wgT58JPV/cnbAE8Vc+AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MfTUlGhn; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 243561A1EC1;
	Tue,  2 Dec 2025 09:26:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E6457606E3;
	Tue,  2 Dec 2025 09:26:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3DD6211918D13;
	Tue,  2 Dec 2025 10:26:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764667597; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0QhNzQsm8Oj1GGB/bH80Qc9yOMbCIo84NGjawpRGa0U=;
	b=MfTUlGhnnw/aVreeaATbhw0gwkpem3K9EKovmRrLAuPocP4mtIEFaUBJAllgvpXiOFVYVs
	/+wYe6BWiOjXN0TQXfqEbI4kTBiForiN43QgIRFG1Tif71C+pWFPguQb30OO5GR384TVLH
	FZYaHMZgblFJnDTIPRv3nxFL2X7+IteBlMRlRxUIW82bL9nD/zWvqmrNnYX95WKYHUolBR
	aWzmo2dED90Ls+6evrTylVevWGCfFb+t5/b4hRTOr5NOspn3gp8X2yP/8vpWUgnmn8SNQp
	t2T7sfHrwl492i35smJdL2e7LttoyWu75OyA4aNg7/ydqIjfu3dWfVR//psj2w==
Date: Tue, 2 Dec 2025 10:26:19 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Kalle Niemi <kaleposti@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, Arnd
 Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@google.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Charles Keepax
 <ckeepax@opensource.cirrus.com>, Richard Fitzgerald
 <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, Linus
 Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, Davidlohr
 Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Alison Schofield
 <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
 patches@opensource.cirrus.com, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 01/29] Revert "treewide: Fix probing of devices in DT
 overlays"
Message-ID: <20251202102619.5cd971cc@bootlin.com>
In-Reply-To: <55076f4b-d523-4f8c-8bd4-0645b790737e@gmail.com>
References: <20251015071420.1173068-1-herve.codina@bootlin.com>
	<20251015071420.1173068-2-herve.codina@bootlin.com>
	<f74ab0a2-b74b-4b96-8469-a716c850e230@gmail.com>
	<CAL_JsqJDOYuzutMHMeFAogd5a_OX6Hwi8Gwz1Vy7HpXgNeYKsg@mail.gmail.com>
	<5cf2a12a-7c66-4622-b4a9-14896c6df005@gmail.com>
	<CAL_JsqJjm12LxpDg6LmpY=Ro_keHwnrWiYMLVnG=s_pSP4X2WQ@mail.gmail.com>
	<072dde7c-a53c-4525-83ac-57ea38edc0b5@gmail.com>
	<CAL_JsqKyG98pXGKpL=gxSc92izpzN7YCdq62ZJByhE6aFYs1fw@mail.gmail.com>
	<55076f4b-d523-4f8c-8bd4-0645b790737e@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Kalle,

On Fri, 28 Nov 2025 10:34:57 +0200
Kalle Niemi <kaleposti@gmail.com> wrote:

...
> >>>>>>
> >>>>>> Hello,
> >>>>>>
> >>>>>> Test system testing drivers for ROHM ICs bisected this commit to cause
> >>>>>> BD71847 drivers probe to not be called.  
> >>>>> This driver (and overlay support) is in linux-next or something out of
> >>>>> tree on top of linux-next?
> >>>>>
> >>>>> Rob  
> >>>> Yes the driver is in mainline linux: /drivers/mfd/rohm-bd718x7.c  
> >>> I don't see any support to apply overlays in that driver.  
> >> Ah. Sorry for the confusion peeps. I asked Kalle to report this without
> >> proper consideration. 100% my bad.
> >>
> >> While the bd718x7 drive indeed is mainline (and tested), the actual
> >> 'glue-code' doing the overlay is part of the downstream test
> >> infrastructure. So yes, this is not a bug in upstream kernel - this
> >> falls in the category of an upstream change causing downstream things to
> >> break. So, feel free to say: "Go fix your code" :)
> >>
> >> Now that this is sorted, if someone is still interested in helping us to
> >> get our upstream drivers tested - the downstream piece is just taking
> >> the compiled device-tree overlay at runtime (via bin-attribute file),
> >> and applying it using the of_overlay_fdt_apply(). The approach is
> >> working for our testing purposes when the device is added to I2C/SPI
> >> node which is already enabled. However, in case where we have the I2C
> >> disabled, and enable it in the same overlay where we add the new device
> >> - then the new device does not get probed.
> >>
> >> I would be really grateful if someone had a pointer for us.  
> > Seems to be fw_devlink related. I suppose if you turn it off it works?
> > There's info about the dependencies in sysfs or maybe debugfs. I don't
> > remember the details, but that should help to tell you why things
> > aren't probing.

Rob reverted patches but I plan to continue my work on it.
On my side, I need the reverted patches but I fully understand that, on
your side, you need a working system.

In order to move forward and find a solution for my next iteration, can you
send your overlay (dtso) used in your working and non working cases?

Best regards,
Hervé

