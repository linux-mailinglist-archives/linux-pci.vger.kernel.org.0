Return-Path: <linux-pci+bounces-22284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99852A4340C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 05:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2609C189B636
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 04:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673112A1D8;
	Tue, 25 Feb 2025 04:09:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC95BEED6;
	Tue, 25 Feb 2025 04:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740456563; cv=none; b=RMQ9re/wCQP1rP0zndZov5Kn++NzhoV3iZrh2Q9sNZPPOGRv6PDooi9Bhwsi/hyd811UcEQ/1eh8R+P9ddcpY8DJfszCBsFs72NcMKM+O9U8o7kn9jNnMT6Lpc0ifK6tBTl3uQ8KfWgI7aGJ1p7k6wVUffiPQyof57XfGF6J2Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740456563; c=relaxed/simple;
	bh=qdyB6wysKOXoDd13g7F4gBexafxlvPpIMDWKzV6Uwr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFshmILAI2G3+/r+gNKvw6R1kKlCHl7VCijKKbJQr2vzWqDlgGu/PguAmycjO77SXcRF1V9NLh0Ruc/hhZfT/yTIQOwvAo2L1bMLpgFWOa57IlETrx+Xq7sKrgea4vnH1XRNMNVWTRsvtLOp1/rIUgqSzg4VKokEhdHoxxyDdNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 873CE100DA1B4;
	Tue, 25 Feb 2025 05:09:11 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 44C0F48CC4A; Tue, 25 Feb 2025 05:09:11 +0100 (CET)
Date: Tue, 25 Feb 2025 05:09:11 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>, rafael@kernel.org,
	Markus Elfring <Markus.Elfring@web.de>, lkp@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] PCI/portdrv: Loose the condition check for
 disabling hotplug interrupts
Message-ID: <Z71CZyU11-cBXawr@wunner.de>
References: <20250224034500.23024-1-feng.tang@linux.alibaba.com>
 <20250224034500.23024-4-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224034500.23024-4-feng.tang@linux.alibaba.com>

On Mon, Feb 24, 2025 at 11:44:59AM +0800, Feng Tang wrote:
> Currently when 'pcie_ports_native' and host's 'native_pcie_hotplug' are
> both false, kernel will not disable PCIe hotplug interrupts. But as
> those could be affected by software setup like kernel cmdline parameter,
> remove the depency over them.
[...]
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -263,9 +263,9 @@ static int get_port_device_capability(struct pci_dev *dev)
>  
>  	if (dev->is_hotplug_bridge &&
>  	    (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> -	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) &&
> -	    (pcie_ports_native || host->native_pcie_hotplug)) {
> -		services |= PCIE_PORT_SERVICE_HP;
> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> +		if  (pcie_ports_native || host->native_pcie_hotplug)
> +			services |= PCIE_PORT_SERVICE_HP;
>  
>  		/*
>  		 * Disable hot-plug interrupts in case they have been enabled

If the platform doesn't grant hotplug control to OSPM, OSPM isn't allowed
to disable interrupts behind the platform's back.

So this change doesn't seem safe and we should focus on finding out
why the platform isn't granting hotplug control in the pci=nomsi case.

Thanks,

Lukas

