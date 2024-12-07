Return-Path: <linux-pci+bounces-17874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423E69E8105
	for <lists+linux-pci@lfdr.de>; Sat,  7 Dec 2024 17:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF17728173A
	for <lists+linux-pci@lfdr.de>; Sat,  7 Dec 2024 16:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC1313D244;
	Sat,  7 Dec 2024 16:31:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B755628F5;
	Sat,  7 Dec 2024 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733589088; cv=none; b=gOeBtYxbS5iXqgDrJe5gL4aon1cUSrZSe9LesUdOy1aDYUiwweBWR2rSQ902xLbe7lPCbqKd3Si0bovau20lsJIyfHcVEWhHcubhcdFUdcAPvwG/yF1a7GZYi+xPqdXktoDU+XVI8W7Pg+vS8gTx7SRoIfVZUvFHheOe2n9H7xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733589088; c=relaxed/simple;
	bh=yYFqEq2kwcktfnz+Klwd/FpVUkkIZx4E/bMB+tmEX8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtLYh3sXaipn3RTSi68DEKdreKufCk1yckYVPvnGax/jCUF+xSy2JUxxk9s9LHBXx2gJQQt2yUEqaXmic32AtNNdhBbxlS8MQ4pAXUPnXSZ2rtHI4SDizC8mMBf//bVW/KEr4EVGDx8834yEQio6LWnxN1UCDHQAWkL7KLac+GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9D018100DA1C3;
	Sat,  7 Dec 2024 17:31:16 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5FEFE15BCCC; Sat,  7 Dec 2024 17:31:16 +0100 (CET)
Date: Sat, 7 Dec 2024 17:31:16 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Niklas Schnelle <niks@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v9 6/9] PCI/bwctrl: Re-add BW notification portdrv as
 PCIe BW controller
Message-ID: <Z1R4VNwCOlh9Sg9n@wunner.de>
References: <20241018144755.7875-1-ilpo.jarvinen@linux.intel.com>
 <20241018144755.7875-7-ilpo.jarvinen@linux.intel.com>
 <db8e457fcd155436449b035e8791a8241b0df400.camel@kernel.org>
 <91b501c0ce92de681cc699eb6064840caad28803.camel@kernel.org>
 <7a4a9d51a9105bd5ca2c850c26fed6435b5e90e9.camel@kernel.org>
 <5f27c14467aa728358ebfe1686517aabe7c1e878.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f27c14467aa728358ebfe1686517aabe7c1e878.camel@kernel.org>

[cc += Mika, start of thread:
https://lore.kernel.org/all/db8e457fcd155436449b035e8791a8241b0df400.camel@kernel.org/
]

On Sat, Dec 07, 2024 at 12:06:49AM +0100, Niklas Schnelle wrote:
> > > On Fri, 2024-12-06 at 19:12 +0100, Niklas Schnelle wrote:
> > > > I bisected a v6.13-rc1 boot hang on my personal workstation to this
> > > > patch. Sadly I don't have much details like a panic or so because the
> > > > boot hangs before any kernel messages, or at least they're not visible
> > > > long enough to see. I haven't yet looked into the code as I wanted to
> > > > raise awareness first. Since the commit doesn't revert cleanly on
> > > > v6.13-rc1 I also haven't tried that yet.
> > > > 
> > > > Here are some details on my system:
> > > > - AMD Ryzen 9 3900X 
> > > > - ASRock X570 Creator Motherboard
> > > > - Radeon RX 5600 XT
> > > > - Intel JHL7540 Thunderbolt 3 USB Controller (only USB 2 plugged)
> > > > - Intel 82599 10 Gigabit NIC with SR-IOV enabled with 2 VFs
> > > > - Intel n I211 Gigabit NIC
> > > > - Intel Wi-Fi 6 AX200
> > > > - Aquantia AQtion AQC107 NIC
> 
> Ok did some fiddeling and it's the thunderbolt ports. The below diff
> works around the issue. That said I guess for a proper fix this would
> should get filtered by the port service matching? Also as can be seen
> in lspci the port still claims to support bandwidth management so maybe
> other thunderbolt ports actually do.
[...]
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -294,6 +294,9 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
>         struct pci_dev *port = srv->port;
>         int ret;
> 
> +       if (srv->port->is_thunderbolt)
> +               return -EOPNOTSUPP;
> +

Thanks for reporting and analyzing this.

The PCIe bandwidth controller is only instantiated on Downstream Ports.
Per the spec, Thunderbolt PCIe Downstream Ports are just tunnel endpoints
with a fake Max Link Speed of 2.5 GT/s (USB4 v2 sec 11.2.1):

   "Max Link Speed field in the Link Capabilities Register set to 0001b
    (data rate of 2.5 GT/s only).
    Note: These settings do not represent actual throughput.
    Throughput is implementation specific and based on the USB4 Fabric
    performance."

So your patch does make sense in so far as the link speed of Thunderbolt
PCIe Downstream Ports is fixed to 2.5 GT/s and cannot be throttled because
that's already the lowest possible PCIe speed.  The actual speed is
determined by the Thunderbolt links.

The check for the is_thunderbolt bit should be moved to the if-clause in
get_port_device_capability() which sets the PCIE_PORT_SERVICE_BWCTRL bit
in the services mask.

Alternatively, it may be worth considering not to instantiate the
bandwidth controller if the only link speed supported is 2.5 GT/s.

We should try to find out what actually causes the boot hang
(some interrupt storm maybe?), but that can hopefully be done
internally at Intel if the boot hang is reproducible.

Thanks,

Lukas

