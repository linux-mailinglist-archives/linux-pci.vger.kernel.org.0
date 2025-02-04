Return-Path: <linux-pci+bounces-20690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5020A26DE8
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 10:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691241667A9
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 09:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F2B207A00;
	Tue,  4 Feb 2025 09:07:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674EE207675;
	Tue,  4 Feb 2025 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738660038; cv=none; b=qkKmi2RHw4ddKzta8fNgyYpH75dN4QH8B8NeliCxnlHmEeXjgwhCgupb+5Nz+nrRny2J2nqJzSecMAmzsKCdX3r9qzXoyAyKDmv8DliUOqJuJVxBN4O44xveqSEbsmbbtOw524tcmuo3vItMoP8JsB4DU43vTHazS04DYPscuhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738660038; c=relaxed/simple;
	bh=VvFz76Pt2lcb1LURo9lrIoQWVqRNphfZvk0trxqRUU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gw858rxLWspg5VIHmMNgc8yjDM+4BxQauo1SuCyK4aLDI5wxgDaMzkHmjt0uZfzOjaXZo/UF4fepwS+R4ayZ4L3Zwr9XF0sAMo7DGlo0S7YwKXX0j+s3DBsqZhQJqUqImlYeJmmCsbtDswBYDtSC56jQVmhlAsBqI39aXQxrQXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 9775E280072B2;
	Tue,  4 Feb 2025 10:07:04 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 764B256A482; Tue,  4 Feb 2025 10:07:04 +0100 (CET)
Date: Tue, 4 Feb 2025 10:07:04 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/portdrv: Add necessary delay for disabling
 hotplug events
Message-ID: <Z6HYuBDP6uvE1Sf4@wunner.de>
References: <20250204053758.6025-1-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204053758.6025-1-feng.tang@linux.alibaba.com>

On Tue, Feb 04, 2025 at 01:37:57PM +0800, Feng Tang wrote:
> According to PCIe 6.1 spec, section 6.7.3.2, software need to wait at
> least 1 second for the command-complete event, before resending the cmd
> or sending a new cmd.
> 
> Currently get_port_device_capability() sends slot control cmd to disable
> PCIe hotplug interrupts without waiting for its completion and there was
> real problem reported for the lack of waiting.
> 
> Add the necessary wait to comply with PCIe spec. The waiting logic refers
> existing pcie_poll_cmd().
[...]
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -230,8 +260,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  		 * Disable hot-plug interrupts in case they have been enabled
>  		 * by the BIOS and the hot-plug service driver is not loaded.
>  		 */
> -		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> -			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> +		pcie_disable_hp_interrupts_early(dev);
>  	}

The language of the code comment is a bit confusing in that it
says the hot-plug driver may not be "loaded".  This sounds like
it could be modular.  But it can't.  It's always built-in.

So I think what is really meant here is that the driver may be
*disabled* in the config, i.e. CONFIG_HOTPLUG_PCI_PCIE=n.

Now if CONFIG_HOTPLUG_PCI_PCIE=n, you don't need to observe the
Command Completed delay because the hotplug driver won't touch
the Slot Control register afterwards.  It's not compiled in.

On the other hand if CONFIG_HOTPLUG_PCI_PCIE=y, you don't need
to disable the CCIE and HPIE interrupt because the hotplug driver
will handle them.

So I think the proper solution here is to make the write to the
Slot Control register conditional on CONFIG_HOTPLUG_PCI_PCIE,
like this:

	if (dev->is_hotplug_bridge &&
	    (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
-	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) &&
-	    (pcie_ports_native || host->native_pcie_hotplug)) {
-		services |= PCIE_PORT_SERVICE_HP;
+	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)) {
+		if (pcie_ports_native || host->native_pcie_hotplug)
+			services |= PCIE_PORT_SERVICE_HP;

		/*
		 * Disable hot-plug interrupts in case they have been enabled
		 * by the BIOS and the hot-plug service driver is not loaded.
		 */
-		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
-			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
+		if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
+			pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
+				  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
	}

The above patch also makes sure the interrupts are quiesced if the
platform didn't grant hotplug control to OSPM.

Thanks,

Lukas

