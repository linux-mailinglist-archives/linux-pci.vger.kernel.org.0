Return-Path: <linux-pci+bounces-25271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A74A7B6FC
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 06:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D15B188B7F4
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 04:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A96433A8;
	Fri,  4 Apr 2025 04:51:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01C4A95E;
	Fri,  4 Apr 2025 04:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743742293; cv=none; b=M58zwhbUbxyLb84KOsgAdZSbIKa6ZEX/HfOIXJyo+to9IejvKDod01eHtaknr9gLO5+7P8e28VqmujajYkQm6ilBP3uMWlMInxQZbCU0dvA9SUrSpmXrk6PchtwvHednxD29KvQiCYMogdH5sgRMTMAVQVk3c8MbIaFBmAf32S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743742293; c=relaxed/simple;
	bh=JAKicYwYnX+BY+e/z0h+lneUm38kHCWULfOxJEdxa7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYoY06HtfHlVs+/at03RrIWEaN/RxRojV++LxmVGEc6x0zV+VB0mRcE/kI9s9Fe3icNnqK6fi4JWu2+K6KWHreZnzfLAJF1TND1PulGbZNfGvk6/2kZLkcBbTlKsVH0D7SVNMadaqCRI/7ndxkBaBY19/gSjHB1AHjuLxIGqHQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 84EE52C06E55;
	Fri,  4 Apr 2025 06:42:29 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BD8EF1143F; Fri,  4 Apr 2025 06:42:32 +0200 (CEST)
Date: Fri, 4 Apr 2025 06:42:32 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Shawn Anastasio <sanastasio@raptorengineering.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, tpearson@raptorengineering.com,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] pci/hotplug/pnv_php: Work around switches with
 broken presence detection
Message-ID: <Z-9jOFiPaxYAJwdm@wunner.de>
References: <20250404041810.245984-1-sanastasio@raptorengineering.com>
 <20250404041810.245984-3-sanastasio@raptorengineering.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404041810.245984-3-sanastasio@raptorengineering.com>

[cc += Krishna]

On Thu, Apr 03, 2025 at 11:18:09PM -0500, Shawn Anastasio wrote:
> The Microsemi Switchtec PM8533 PFX 48xG3 [11f8:8533] PCIe switch system
> was observed to incorrectly assert the Presence Detect Set bit in its
> capabilities when tested on a Raptor Computing Systems Blackbird system,
> resulting in the hot insert path never attempting a rescan of the bus
> and any downstream devices not being re-detected.
> 
> Work around this by additionally checking whether the PCIe data link is
> active or not when performing presence detection on downstream switches'
> ports, similar to the pciehp_hpc.c driver.
[...]
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -390,6 +390,20 @@ static int pnv_php_get_power_state(struct hotplug_slot *slot, u8 *state)
>  	return 0;
>  }
>  
> +static int pcie_check_link_active(struct pci_dev *pdev)
> +{
> +	u16 lnk_status;
> +	int ret;
> +
> +	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> +	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
> +		return -ENODEV;
> +
> +	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> +
> +	return ret;
> +}
> +

This appears to be a 1:1 copy of pciehp_check_link_active(),
save for the ctrl_dbg() call.

For the sake of code-reuse, please move the function into the
PCI library drivers/pci/pci.c so that it can be used everywhere.

Note that there's another patch pending which does exactly that:

https://lore.kernel.org/r/20250225-qps615_v4_1-v4-7-e08633a7bdf8@oss.qualcomm.com/

So either include that patch in your series (addressing the review
feedback I sent for it and cc'ing the original submitter) or wait
for it to be respun by the original submitter.

Thanks,

Lukas

