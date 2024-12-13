Return-Path: <linux-pci+bounces-18359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3969F067D
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 09:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6802282E43
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 08:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C741AA1DF;
	Fri, 13 Dec 2024 08:37:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A291A8F76;
	Fri, 13 Dec 2024 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079032; cv=none; b=lWU8mWmXeOK9NtTF9PrcMNixALxQxdCW0cacW8W98dGKRd2UILNafRQHAeVpR4HFXa3fWdl7e/4s0ziG9fGzadc2iHl7VLGYhSxWJ9vQcJhQh/yVpxoIL7nhuEso/BbAmKW6PW8gHpXhAitTloSWx7naME/NssvmKWs49ObD/Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079032; c=relaxed/simple;
	bh=qzqJnt4UH+d1eHyynyyv8N54391sMrNELpuncmbi1Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7Kmz4rWoqX6XyRzqhHbhiNOo+WtpdZu9366tQ9MwJ4ZvdJIo/JasZ5D7mdvFdNudFvAb/82c9yE1lnQCsWX2i6Wfr4vhB/jtKw2VMP+Z1Ubx9JdfDVs+K3fP1ytaMdIewpgdsLSLZ72bovR3FLOz+Xa8l4Q9NDbSJi+fnEK2S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 823DB2800C988;
	Fri, 13 Dec 2024 09:37:00 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 638B03A4BC0; Fri, 13 Dec 2024 09:37:00 +0100 (CET)
Date: Fri, 13 Dec 2024 09:37:00 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Niklas Schnelle <niks@kernel.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI/portdrv: Disable bwctrl service if port is fixed at
 2.5 GT/s
Message-ID: <Z1vyLNW20RuVaZe5@wunner.de>
References: <20241207-fix_bwctrl_thunderbolt-v1-1-b711f572a705@kernel.org>
 <Z1gSZCdv3fwnRRNk@wunner.de>
 <70829798889c6d779ca0f6cd3260a765780d1369.camel@kernel.org>
 <Z1lF468L8c84QJkD@wunner.de>
 <dc6e677f-4c19-dd25-8878-8eae9154cff4@linux.intel.com>
 <Z1qoDmF6urJDN5jh@wunner.de>
 <97bbbdecb8c65cfa2625b47aa2585a7417ddcb81.camel@linux.ibm.com>
 <Z1rX1BgdsPHIHOv4@wunner.de>
 <1dcc3ca74c3fbb3b4a1adcafb648dfd2501310f1.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dcc3ca74c3fbb3b4a1adcafb648dfd2501310f1.camel@kernel.org>

On Thu, Dec 12, 2024 at 09:40:04PM +0100, Niklas Schnelle wrote:
> On Thu, 2024-12-12 at 13:32 +0100, Lukas Wunner wrote:
> > pcie_get_supported_speeds() is used to fill in the supported_speeds
> > field in struct pci_dev.
> > 
> > And that field is used in a number of places (exposure of the max link
> > speed in sysfs, delay handling in pci_bridge_wait_for_secondary_bus(),
> > link tuning in radeon/amdgpu drivers, etc).
> 
> Side question. If this is used in radeon/amdgpu could detecting the
> thunderbolt port's max link speed as 2.5 GT/s cause issues for external
> GPUs?

I don't think so:

An attached Thunderbolt gadget (e.g. eGPU) is visible to the OS as a
PCIe switch.  A portion of the Switch Downstream Ports is used to
attach Endpoints (e.g. GPU) and the remainder is used for tunneling,
i.e. to extend the hierarchy further if multiple Thunderbolt devices
are daisy-chained.

My expectation is that the Max Link Speed is 8 GT/s on those Downstream
Ports leading to Endpoints and 2.5 GT/s on those Downstream Ports used
for tunneling (to conform with the USB4/Thunderbolt spec).  In other words,
the Supported Link Speeds is the same on all of them, but Max Link Speed
is reduced to 2.5 GT/s on so-called PCIe Adapters (in USB4/Thunderbolt
terminology).

The PCIe Adapters encapsulate PCIe TLPs into Thunderbolt packets and
send them over the Thunderbolt fabric, and similarly decapsulate TLPs
received from the fabric.

There are some illustrations available here which explain the distinction
between the two types of Downstream Ports:

https://developer.apple.com/library/archive/documentation/HardwareDrivers/Conceptual/ThunderboltDevGuide/Basics/Basics.html

I'm hoping Mika or Ilpo can verify the above information.  I have
lspci dumps here of MeteorLake-P and BarlowRidge host controllers,
but without any attached USB4/Thunderbolt gadgets.

Thanks,

Lukas

