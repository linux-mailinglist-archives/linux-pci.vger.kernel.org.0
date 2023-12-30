Return-Path: <linux-pci+bounces-1564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 823098204A9
	for <lists+linux-pci@lfdr.de>; Sat, 30 Dec 2023 12:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB44F1C20D5B
	for <lists+linux-pci@lfdr.de>; Sat, 30 Dec 2023 11:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1C37493;
	Sat, 30 Dec 2023 11:46:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67A779CD;
	Sat, 30 Dec 2023 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 0F3BB2800B6C3;
	Sat, 30 Dec 2023 12:45:50 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 007581AA9C7; Sat, 30 Dec 2023 12:45:49 +0100 (CET)
Date: Sat, 30 Dec 2023 12:45:49 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Alex Deucher <alexdeucher@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v3 05/10] PCI: Store all PCIe Supported Link Speeds
Message-ID: <20231230114549.GB12257@wunner.de>
References: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com>
 <20230929115723.7864-6-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230929115723.7864-6-ilpo.jarvinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Sep 29, 2023 at 02:57:18PM +0300, Ilpo Järvinen wrote:
> struct pci_bus stores max_bus_speed. Implementation Note in PCIe r6.0.1
> sec 7.5.3.18, however, recommends determining supported Link Speeds
> using the Supported Link Speeds Vector in the Link Capabilities 2
> Register (when available).
> 
> Add pcie_bus_speeds into struct pci_bus which caches the Supported Link
> Speeds. The value is taken directly from the Supported Link Speeds
> Vector or synthetized from the Max Link Speed in the Link Capabilities
> Register when the Link Capabilities 2 Register is not available.

Remind me, what's the reason again to cache this and why is
max_bus_speed not sufficient?  Is the point that there may be
"gaps" in the supported link speeds, i.e. not every bit below
the maximum supported speed may be set?  And you need to skip
over those gaps when throttling to a lower speed?

Maybe this becomes apparent in a later patch but from a reviewer's
perspective starting at patch 1 and working one's way forward through
the series, it's a bit puzzling, so an explanation in the commit
message would be beneficial.


> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
[...]
> +static u8 pcie_get_supported_speeds(u32 linkcap, u32 linkcap2)
> +{
> +	u8 speeds;
> +
> +	speeds = linkcap2 & PCI_EXP_LNKCAP2_SLS;
> +	if (speeds)
> +		return speeds;
> +
> +	/*
> +	 * Synthetize supported link speeds from the Max Link Speed in the
> +	 * Link Capabilities Register.
> +	 */
> +	speeds = PCI_EXP_LNKCAP2_SLS_2_5GB;
> +	if ((linkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
> +		speeds |= PCI_EXP_LNKCAP2_SLS_5_0GB;
> +	return speeds;
> +}

This seems to duplicate portions of pcie_get_speed_cap().

Can you refactor that function to take advantage of the cached value,
i.e. basically return PCIE_LNKCAP2_SLS2SPEED(dev->bus->pcie_bus_speeds)?

Also, I note that pci_set_bus_speed() doesn't use LNKCAP2.
Presumably that's a historic artefact but maybe it can be
converted to use LNKCAP2 as well.  Granted, it's not directly
related to this series, but always nice to clean up and
rationalize the code.

Thanks,

Lukas

