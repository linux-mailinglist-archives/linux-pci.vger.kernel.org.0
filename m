Return-Path: <linux-pci+bounces-18022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 897EC9EAD8E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 11:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CB928389C
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 10:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2536423DEAC;
	Tue, 10 Dec 2024 10:05:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A9323DE9D;
	Tue, 10 Dec 2024 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733825139; cv=none; b=E2mVRpBvwZjSSSNzQx1BbB3QFkydc5y2AWiALeFbfk+1SpEMle6eamZZsBe+8fNx4NJTCTJ5yRx9EWuyjz/ZNNjmdzvuqs+eZQuFvoyemPJVkijKLKtacEwBXshg9uEhmYsQv8MIepCWHVCB8NYnunSzczfeq9ogAQK2YT4mXNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733825139; c=relaxed/simple;
	bh=lyfeqoW7UDdpbTjJvfagr193PybcKSPetWVvLfyXFgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mh0n2k+WO1p7QCmlccqkojeFzGc49TbExeXDofpJWYXYKiXLQ7UKDQKzuJ8Vq0cNSgvrHVD8ktD0xJ22dc2cUlqzU+pTVeKunUFLSIYymQUqZZJminrmf35e5mMxXyupYjRx0aftlJVNl9nvDP6N5M0BHz1MQpiaqly4UR3TyM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id E7CD52800BB73;
	Tue, 10 Dec 2024 11:05:24 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C309A5F845F; Tue, 10 Dec 2024 11:05:24 +0100 (CET)
Date: Tue, 10 Dec 2024 11:05:24 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Niklas Schnelle <niks@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
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
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] PCI/portdrv: Disable bwctrl service if port is fixed at
 2.5 GT/s
Message-ID: <Z1gSZCdv3fwnRRNk@wunner.de>
References: <20241207-fix_bwctrl_thunderbolt-v1-1-b711f572a705@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207-fix_bwctrl_thunderbolt-v1-1-b711f572a705@kernel.org>

On Sat, Dec 07, 2024 at 07:44:09PM +0100, Niklas Schnelle wrote:
> Trying to enable bwctrl on a Thunderbolt port causes a boot hang on some
> systems though the exact reason is not yet understood.

Probably worth highlighting the discrete Thunderbolt chip which exhibits
this issue, i.e. Intel JHL7540 (Titan Ridge).

> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -270,7 +270,8 @@ static int get_port_device_capability(struct pci_dev *dev)
>  		u32 linkcap;
>  
>  		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
> -		if (linkcap & PCI_EXP_LNKCAP_LBNC)
> +		if (linkcap & PCI_EXP_LNKCAP_LBNC &&
> +		    (linkcap & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB)
>  			services |= PCIE_PORT_SERVICE_BWCTRL;
>  	}

This is fine in principle because PCIe r6.2 sec 8.2.1 states:

   "A device must support 2.5 GT/s and is not permitted to skip support
    for any data rates between 2.5 GT/s and the highest supported rate."

However the Implementation Note at the end of PCIe r6.2 sec 7.5.3.18
cautions:

   "It is strongly encouraged that software primarily utilize the
    Supported Link Speeds Vector instead of the Max Link Speed field,
    so that software can determine the exact set of supported speeds
    on current and future hardware. This can avoid software being
    confused if a future specification defines Links that do not
    require support for all slower speeds."

First of all, the Supported Link Speeds field in the Link Capabilities
register (which you're querying here) was renamed to Max Link Speed in
PCIe r3.1 and a new Link Capabilities 2 register was added which contains
a new Supported Link Speeds field.  Software is supposed to query the
latter if the device implements the Link Capabilities 2 register
(see the other Implementation Note at the end of PCIe r6.2 sec 7.5.3.18).

Second, the above-quoted Implementation Note says that software should
not rely on future spec versions to mandate that *all* link speeds
(2.5 GT/s and all intermediate speeds up to the maximum supported speed)
are supported.

Since v6.13-rc1, we cache the supported speeds in the "supported_speeds"
field in struct pci_dev, taking care of the PCIe 3.0 versus later versions
issue.

So to make this future-proof what you could do is check whether only a
*single* speed is supported (which could be something else than 2.5 GT/s
if future spec versions allow that), i.e.:

-		if (linkcap & PCI_EXP_LNKCAP_LBNC)
+		if (linkcap & PCI_EXP_LNKCAP_LBNC &&
+		    hweight8(dev->supported_speeds) > 1)

...and optionally add a code comment, e.g.:

	/* Enable bandwidth control if more than one speed is supported. */

Thanks,

Lukas

