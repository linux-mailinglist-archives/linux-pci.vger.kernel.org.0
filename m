Return-Path: <linux-pci+bounces-44738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF868D1ED2A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 13:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EC98302080F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 12:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4414397AAE;
	Wed, 14 Jan 2026 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uNacfl4B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEBF396D16;
	Wed, 14 Jan 2026 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394423; cv=none; b=babZC4rP/DHYqGUqXYzCEE7q+MMpdsFDbg4MsNB9/P/5nbm9CMskEmbLAYD9j8+/+g2b93ECn1zKA79uqj1eQAwmOJSW6hNBJR7hP5d8T5G3CodvGl/+V89GcPxuGstFk76lEh96q732F0GpxprcPveAlDhJjheH7jSSHFrF1jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394423; c=relaxed/simple;
	bh=i3ywdlJEEbMCErXDckWbFK8qjmi5xbJlVYcN7KDYJQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ShL2z7JoxS29v13P9xvdWB24IypYEldPHMbtcvno+csz965un7mh6xycXoM/K1iVVScLpuYQeu2HqMWmwaHJ41P5q8Y3mZ/RIzFFmZ20s6F7cnd//iV5YjWgKMnEplzjYNmmkgq6MgvH7YYwpmd99z1JHnBv9r1ZBAD9xOrDdsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uNacfl4B; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7194B4E41FEC;
	Wed, 14 Jan 2026 12:40:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F36F6074A;
	Wed, 14 Jan 2026 12:40:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AE9C110B68235;
	Wed, 14 Jan 2026 13:40:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768394417; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LdTB9SICd7x5Se7c+EJ+56/scU6NfThvAUtGnGGrMx4=;
	b=uNacfl4Bs/+dFN/j5D9PlwbjgNS6nb7BgwzaR6oj2DCUMhGki9TlUQ/otRArV4T4TEPthb
	vLECnyHHIjy9A5cLIyIKysmamaHZLz7lGf9CbftO+0yfLYGAJInMJJcocP1D42nN95FHhu
	aYoE64ScAcn5BFZ2SnxBsUH+GiBv9fQeYg2sPyuLhoWjcTOT3cDH+pa9NU43D5fftdQd6h
	mtCKjvOuuQbvV3ChzfQGdId8DRnDXRksF2WWqhMzKpPOb44Pj7ZhKKguWpUfIv6mOnptLC
	urt5saAEuBgrYfeu017oRmKJVfhFd9ONDBz0VgyPVwVqmSl2jLy0Wjti0WNS1g==
Date: Wed, 14 Jan 2026 13:40:04 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas
 Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, Ilpo
 =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Mark Pearson
 <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-acpi@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>, Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: [PATCH v3 00/14] Add support for handling PCIe M.2 Key E
 connectors in devicetree
Message-ID: <20260114134004.11023a7e@bootlin.com>
In-Reply-To: <aWSuYd8zqCxZ9DYE@smile.fi.intel.com>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
	<aWSq_7_5kkQIv9Hc@smile.fi.intel.com>
	<aWSuYd8zqCxZ9DYE@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Andy, Manivannan,

On Mon, 12 Jan 2026 10:18:41 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> +Cc: Herve (btw, any news on LAN966x support?)

Related to LAN966x support, I am still stucked on issues related to
fw_devlink and DT overlays [1].

[1] https://lore.kernel.org/all/20260112154731.6540453b@bootlin.com/

> 
> On Mon, Jan 12, 2026 at 10:04:24AM +0200, Andy Shevchenko wrote:
> > On Sat, Jan 10, 2026 at 12:26:18PM +0530, Manivannan Sadhasivam via B4 Relay wrote:  
> > > Hi,
> > > 
> > > This series is the continuation of the series [1] that added the initial support
> > > for the PCIe M.2 connectors. This series extends it by adding support for Key E
> > > connectors. These connectors are used to connect the Wireless Connectivity
> > > devices such as WiFi, BT, NFC and GNSS devices to the host machine over
> > > interfaces such as PCIe/SDIO, USB/UART and NFC. This series adds support for
> > > connectors that expose PCIe interface for WiFi and UART interface for BT. Other
> > > interfaces are left for future improvements.

Related to describing a connector in DT. If DT overlays are involved to described
what is connected to this connector, some issues need to be fixed.

Those issues are related to referencing an external symbol from the overlay.

We, at Boolin, have been working on the topic

A talk (last year at ELC Europe) gives all details about the topic an related issue:
  https://bootlin.com/pub/conferences/2025/elce/ceresoli-hotplug-status.pdf
  https://www.youtube.com/watch?v=C8dEQ4OzMnc

Also a discussion took place after this talk:
  https://lore.kernel.org/all/20250902105710.00512c6d@booty/

Recently, I also send a RFC series to DTC in order to move forward on this symbol
reverence topic. This series implements features emerged from the pointed out
discussion.

> > > 
> > > Serdev device support for BT
> > > ============================
> > > 
> > > Adding support for the PCIe interface was mostly straightforward and a lot
> > > similar to the previous Key M connector. But adding UART interface has proved to
> > > be tricky. This is mostly because of the fact UART is a non-discoverable bus,
> > > unlike PCIe which is discoverable. So this series relied on the PCI notifier to
> > > create the serdev device for UART/BT. This means the PCIe interface will be
> > > brought up first and after the PCIe device enumeration, the serdev device will
> > > be created by the pwrseq driver. This logic is necessary since the connector
> > > driver and DT node don't describe the device, but just the connector. So to make
> > > the connector interface Plug and Play, the connector driver uses the PCIe device
> > > ID to identify the card and creates the serdev device. This logic could be
> > > extended in the future to support more M.2 cards. Even if the M.2 card uses SDIO
> > > interface for connecting WLAN, a SDIO notifier could be added to create the
> > > serdev device.
> > > 
> > > Open questions
> > > ==============
> > > 
> > > Though this series adds the relevant functionality for handling the M.2 Key M
> > > connectors, there are still a few open questions exists on the design. 
> > > 
> > > 1. I've used the DT compatible for the serdev swnode to match the existing OF
> > > device_id of the bluetooth driver. This avoids implementing custom serdev id
> > > matching as implemented till v2.  
> > 
> > Yeah, swnodes are not designed to replace the real DT or other firmware
> > interface. The idea of swnodes is to have them providing quirks if needed (i.e.
> > fixing up the broken or missed FW device properties). This should not have been
> > done this way. Please, consider another approach, e.g. DT-overlay.  
> 
> This is what I have in mind when replied to you:
> 
> https://lore.kernel.org/all/20251015071420.1173068-1-herve.codina@bootlin.com/
> 
> > > 2. PCIe client drivers of some M.2 WLAN cards like the Qcom QCA6390, rely on
> > > the PCIe device DT node to extract properties such as
> > > 'qcom,calibration-variant', 'firmware-name', etc... For those drivers, should we
> > > add the PCIe DT node in the Root Port in conjunction with the Port node as
> > > below?
> > > 
> > > pcie@0 {
> > > 	wifi@0 {
> > > 		compatible = "pci17cb,1103";
> > > 		...
> > > 		qcom,calibration-variant = "LE_X13S";
> > > 	};
> > > 
> > > 	port {
> > > 		pcie4_port0_ep: endpoint {
> > > 			remote-endpoint = <&m2_e_pcie_ep>;
> > > 		};
> > > 	};
> > > };

Using mechanisms used by the LAN966x, those wifi@0 and port nodes could be added by
a DT overlay by the PCI device driver handling the Qcom QCA6390 PCI device.

Best regards,
Hervé

