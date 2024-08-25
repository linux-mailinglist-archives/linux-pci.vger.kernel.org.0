Return-Path: <linux-pci+bounces-12179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BE395E3F8
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 16:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F8AB20ECC
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 14:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D18B155320;
	Sun, 25 Aug 2024 14:42:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34602320C;
	Sun, 25 Aug 2024 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724596950; cv=none; b=kn0FxRVOF4mF6XOt/iSnEUmeozr12aL5Fzk0g8mVDKlKHrgHprjwujRsAGX2IpSM0Cd67aIwamtEBjJ0b2cGBccUeDXL6HqbvuhPq5ITcXiZvn1Ehajnb9Xbtsq6E2joOtOeLXO4uegLXC8lKpnsBh7aKFvnzaSTZ4z9aVL+8Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724596950; c=relaxed/simple;
	bh=GFKNlmSu3GWJZfej888LPMpOgEYnF4XHx//K2cXP4s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivh0cRQfzCP+r0wjzd/M0gX1axfxnmsl9ZMhdQtJHIvCZBOZq/2xB7pt9g2i43AQ68NKa20RenOd3KFDMWr9uj2oUi/z0QogDqWiPKCNlqyb2J+wPejewEmm3ha2TaYMIGH/ZbMG6Lyi0UndTSokmpVRy/OCSMknbVZMo6HEafg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id BB4442800B3D2;
	Sun, 25 Aug 2024 16:42:18 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 94612356259; Sun, 25 Aug 2024 16:42:18 +0200 (CEST)
Date: Sun, 25 Aug 2024 16:42:18 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	iommu@lists.linux.dev,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI: Detect and trust built-in Thunderbolt chips
Message-ID: <ZstCyti3FHZIeFO8@wunner.de>
References: <20240823-trust-tbt-fix-v4-1-c6f1e3bdd9be@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823-trust-tbt-fix-v4-1-c6f1e3bdd9be@chromium.org>

On Fri, Aug 23, 2024 at 04:53:16PM +0000, Esther Shimanovich wrote:
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> +static bool pcie_has_usb4_host_interface(struct pci_dev *pdev)
> +{
> +	struct fwnode_handle *fwnode;
> +
> +	/*
> +	 * For USB4, the tunneled PCIe root or downstream ports are marked
> +	 * with the "usb4-host-interface" ACPI property, so we look for
> +	 * that first. This should cover most cases.
> +	 */
> +	fwnode = fwnode_find_reference(dev_fwnode(&pdev->dev),
> +				       "usb4-host-interface", 0);

This is all ACPI only, so it should either be #ifdef'ed to CONFIG_ACPI
or moved to drivers/pci/pci-acpi.c.

Alternatively, it could be moved to arch/x86/pci/ because ACPI can also
be enabled on arm64 or riscv but the issue seems to only affect x86.


>  static void set_pcie_untrusted(struct pci_dev *dev)
>  {
> -	struct pci_dev *parent;
> +	struct pci_dev *parent = pci_upstream_bridge(dev);
>  
> +	if (!parent)
> +		return;
>  	/*
> -	 * If the upstream bridge is untrusted we treat this device
> +	 * If the upstream bridge is untrusted we treat this device as
>  	 * untrusted as well.
>  	 */
> -	parent = pci_upstream_bridge(dev);
> -	if (parent && (parent->untrusted || parent->external_facing))
> +	if (parent->untrusted)
>  		dev->untrusted = true;
> +
> +	if (pcie_is_tunneled(dev)) {
> +		pci_dbg(dev, "marking as untrusted\n");
> +		dev->untrusted = true;
> +	}
>  }

I think you want to return in the "if (parent->untrusted)" case
because there's no need to double-check pcie_is_tunneled(dev)
if you've already determined that the device is untrusted.


>  static void pci_set_removable(struct pci_dev *dev)
>  {
>  	struct pci_dev *parent = pci_upstream_bridge(dev);
>  
> +	if (!parent)
> +		return;
>  	/*
> -	 * We (only) consider everything downstream from an external_facing
> +	 * We (only) consider everything tunneled below an external_facing
>  	 * device to be removable by the user. We're mainly concerned with
>  	 * consumer platforms with user accessible thunderbolt ports that are
>  	 * vulnerable to DMA attacks, and we expect those ports to be marked by
> @@ -1657,9 +1784,13 @@ static void pci_set_removable(struct pci_dev *dev)
>  	 * accessible to user / may not be removed by end user, and thus not
>  	 * exposed as "removable" to userspace.
>  	 */
> -	if (parent &&
> -	    (parent->external_facing || dev_is_removable(&parent->dev)))
> +	if (dev_is_removable(&parent->dev))
> +		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> +
> +	if (pcie_is_tunneled(dev)) {
> +		pci_dbg(dev, "marking as removable\n");
>  		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> +	}
>  }

Same here, return in the "if (dev_is_removable(&parent->dev))" case.

Thanks,

Lukas

