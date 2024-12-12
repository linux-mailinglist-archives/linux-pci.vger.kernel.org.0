Return-Path: <linux-pci+bounces-18282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C749EE6C1
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 13:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8E1165401
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 12:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDD92135A9;
	Thu, 12 Dec 2024 12:32:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFA11F0E55;
	Thu, 12 Dec 2024 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734006746; cv=none; b=M/7nwW2CN9bNhFnp7dDhqtVN2kBCklzsLAByL50Y4W2UPnVoAJw1Zf68Kbez6+Gi2ciiGQRhPFmMYYW8Aa7h1m+IDzo8cOyP4c1kuELXbaoa3Cg4+WP2odQvAntIa199SZ+nH44861PqYARdxIvltfopwdzdMu1FEyGTED37dvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734006746; c=relaxed/simple;
	bh=ZLwwr0tTdqUWrrcfKUdBCuN7WEO36OZq9JdJjbVxAnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXdz+dgbuBcUFLUyTQcMgpeGxLcPHIVIC6MhDLxMViIqcHI/YpvO+zLXAp8qiU5BV6/oEnsYj6zURxQRpuFE8O0Cb1qhDmgwHZv3T73abm1MBKmHd6LdA/HjWkMiUffmw5dzqfsVEE/SAlXhUYR5TkZ7XL4ba/X4kXP4lX2rTM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id D1748300002D5;
	Thu, 12 Dec 2024 13:32:20 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BB8BA3A0E76; Thu, 12 Dec 2024 13:32:20 +0100 (CET)
Date: Thu, 12 Dec 2024 13:32:20 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Niklas Schnelle <niks@kernel.org>,
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
Message-ID: <Z1rX1BgdsPHIHOv4@wunner.de>
References: <20241207-fix_bwctrl_thunderbolt-v1-1-b711f572a705@kernel.org>
 <Z1gSZCdv3fwnRRNk@wunner.de>
 <70829798889c6d779ca0f6cd3260a765780d1369.camel@kernel.org>
 <Z1lF468L8c84QJkD@wunner.de>
 <dc6e677f-4c19-dd25-8878-8eae9154cff4@linux.intel.com>
 <Z1qoDmF6urJDN5jh@wunner.de>
 <97bbbdecb8c65cfa2625b47aa2585a7417ddcb81.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97bbbdecb8c65cfa2625b47aa2585a7417ddcb81.camel@linux.ibm.com>

On Thu, Dec 12, 2024 at 10:17:21AM +0100, Niklas Schnelle wrote:
> On Thu, 2024-12-12 at 10:08 +0100, Lukas Wunner wrote:
> > After re-reading the spec I'm convinced now
> > that we're doing this wrong and that we should honor the Max Link Speed
> > instead of blindly deeming all set bits in the Link Capabilities 2
> > Register as supported speeds:
> > 
> > https://lore.kernel.org/r/e3386d62a766be6d0ef7138a001dabfe563cdff8.1733991971.git.lukas@wunner.de/
> > 
> > @Niklas, could you test if this is sufficient to avoid the issue?
> > Or do we still need to stop instantiating the bandwidth controller
> > if more than one speed is supported?
> 
> Yes, I will test this but will only get to do so tonight (UTC +2).

Hey, no worries.  We're not on the run!

> If it's not sufficient I think we could use the modified
> pcie_get_supported_speeds() to check if only one link speed is
> supported, right?

pcie_get_supported_speeds() is used to fill in the supported_speeds
field in struct pci_dev.

And that field is used in a number of places (exposure of the max link
speed in sysfs, delay handling in pci_bridge_wait_for_secondary_bus(),
link tuning in radeon/amdgpu drivers, etc).

So we can't use pcie_get_supported_speeds() to (exclusively) influence
the behavior of the bandwidth controller.  Instead, the solution is your
patch for get_port_device_capability(), but future-proofed such that
bwctrl is only instantiated if more than one link speed is supported.

Thanks!

Lukas

