Return-Path: <linux-pci+bounces-42269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F25EC92C2D
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 18:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A41AB3468B2
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 17:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6972949E0;
	Fri, 28 Nov 2025 17:07:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD31231A23;
	Fri, 28 Nov 2025 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764349654; cv=none; b=GXHLzqbBwiLFsbb9gUstOUuVaB2fViyRED7aQDClL0gvTbyhbPM6/96eGHlIkqWyUtZ00omFGNGTsegS+30e/7CkcwbbAT6lXr1HnEqU02dsegxC6ljER1SZCkIG+m4g/DHylky4UQKEWPVWEkTB486oxdeNtVlSZqJqA36w+D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764349654; c=relaxed/simple;
	bh=UHZ6oLekuRl8Yuo05PAO9nfYScWmh6ODgtrxOsenLLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKBDVnAFXzvi8ZkiLZNEcm+uy+TL3QqHX37MJ8/Jl+3xG3FkSAc1V3d7JcN50YHXgF+R1uf7wAkb8ds/C6UHG2cF74pEzkzGb1hFviM88sX1Ctg1/ZTH4e+Kuf+wX2akfvpSyNEFFbc4OMP8XBkaYkyN0rbIrv8umqQS4JShhXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id C1EEC2C0017B;
	Fri, 28 Nov 2025 18:07:21 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BC4811D62D; Fri, 28 Nov 2025 18:07:21 +0100 (CET)
Date: Fri, 28 Nov 2025 18:07:21 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Darshit Shah <darnshah@amazon.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jonathan Cameron <Jonthan.Cameron@huawei.com>, darnir@gnu.org,
	Feng Tang <feng.tang@linux.alibaba.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com
Subject: Re: [PATCH] drivers/pci: Allow attaching AER to non-RP devices that
 support MSI
Message-ID: <aSnWyePbCKPvjpKq@wunner.de>
References: <20251128122053.35909-1-darnshah@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128122053.35909-1-darnshah@amazon.de>

On Fri, Nov 28, 2025 at 12:20:53PM +0000, Darshit Shah wrote:
> Previously portdrv tried to prevent non-Root Port (RP) and non-Root
> Complex Event Collector (RCEC) devices from enabling AER capability.
> This was done because some switches enable AER but do not support MSI.

The AER driver only binds to RPs and RCECs, see aer_probe():

	if ((pci_pcie_type(port) != PCI_EXP_TYPE_RC_EC) &&
	    (pci_pcie_type(port) != PCI_EXP_TYPE_ROOT_PORT))
		return -ENODEV;

So there's no point in adding PCIE_PORT_SERVICE_AER to "services"
for other port types (as your patch does).

> However, it is possible to have switches upstream of an endpoint that
> support MSI and AER. Without AER capability being enabled on such
> a switch, portdrv will refuse to enable the DPC capability as well,
> preventing a PCIe error on an endpoint from being handled by the switch.

I assume you're referring to this clause in get_port_device_capability():

	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
	    pci_aer_available() &&
	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
		services |= PCIE_PORT_SERVICE_DPC;

Presumably on your system, BIOS doesn't grant AER handling to the OS
upon _OSC negotiation?  Is there a BIOS knob to change that?
Alternatively, does passing "pcie_ports=dpc-native" fix the issue?
If it does, why do you need the patch instead of using the command line
option?

> Allow enabling the AER service on non-RP, non-RCEC devices if they still
> support both AER and MSI. This allows switches upstream of an endpoint
> to generate and handle DPC events.

Per PCIe r7.0 sec 7.8.4.9, regarding the Root Error Command Register:

   "For Functions other than Root Ports and Root Complex Event Collectors:
   when End-End TLP Prefix Supported is Set or Flit Mode Supported is Set,
   this register is RsvdP, otherwise [...] this register is not required
   to be implemented."

Hence we can't enable AER handling on anything else than RPs and RCECs.

Thanks,

Lukas

