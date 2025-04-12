Return-Path: <linux-pci+bounces-25712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BF5A86AE0
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 06:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD04446EF0
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 04:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1B51EA90;
	Sat, 12 Apr 2025 04:31:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8321E10F9;
	Sat, 12 Apr 2025 04:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744432284; cv=none; b=MPjtENjtv05Q6iGcvIVeRgGmZnNqFX0dSOSb+HRHu8IVs3gd7cTbq78DpgDsho6kJ4taB8qR1nrz6zwKl3O240biLtRW77cj2VkWKhxRg12ELQidGxJJl4fjBwh+GX52xLJndI4jh8bbmJEEXu1LunQS2FnYP8RnxwmgFc4YdZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744432284; c=relaxed/simple;
	bh=bOkiD1hyZrmRAZQ4QH4zaQyYDHImylAofKNJ105nBaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=br0D1bkOtyaLkbOg5HcbYzEZhH5zjpmkLUAnDLarP+SjED/N+m9TaOohbRoxORt3hzosuW3dEMhFxSQNrUE7m56jZeMSWwX6sKiYXG0HD125z+GX8GbtUnLYOxfXC+LrojBUBWpaVJnhBTR42Vddent6jP2xKni+ezI9bp8TtHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6D562200A2A7;
	Sat, 12 Apr 2025 06:30:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E168310720; Sat, 12 Apr 2025 06:31:12 +0200 (CEST)
Date: Sat, 12 Apr 2025 06:31:12 +0200
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
Message-ID: <Z_nskClPmT4A_5Cf@wunner.de>
References: <20250404041810.245984-1-sanastasio@raptorengineering.com>
 <20250404041810.245984-3-sanastasio@raptorengineering.com>
 <Z-9jOFiPaxYAJwdm@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-9jOFiPaxYAJwdm@wunner.de>

On Fri, Apr 04, 2025 at 06:42:32AM +0200, Lukas Wunner wrote:
> On Thu, Apr 03, 2025 at 11:18:09PM -0500, Shawn Anastasio wrote:
> > The Microsemi Switchtec PM8533 PFX 48xG3 [11f8:8533] PCIe switch system
> > was observed to incorrectly assert the Presence Detect Set bit in its
> > capabilities when tested on a Raptor Computing Systems Blackbird system,
> > resulting in the hot insert path never attempting a rescan of the bus
> > and any downstream devices not being re-detected.
> > 
> > Work around this by additionally checking whether the PCIe data link is
> > active or not when performing presence detection on downstream switches'
> > ports, similar to the pciehp_hpc.c driver.
> [...]
> > --- a/drivers/pci/hotplug/pnv_php.c
> > +++ b/drivers/pci/hotplug/pnv_php.c
> > @@ -390,6 +390,20 @@ static int pnv_php_get_power_state(struct hotplug_slot *slot, u8 *state)
> >  	return 0;
> >  }
> >  
> > +static int pcie_check_link_active(struct pci_dev *pdev)
> > +{
> > +	u16 lnk_status;
> > +	int ret;
> > +
> > +	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> > +	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
> > +		return -ENODEV;
> > +
> > +	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> > +
> > +	return ret;
> > +}
> > +
> 
> This appears to be a 1:1 copy of pciehp_check_link_active(),
> save for the ctrl_dbg() call.
> 
> For the sake of code-reuse, please move the function into the
> PCI library drivers/pci/pci.c so that it can be used everywhere.
> 
> Note that there's another patch pending which does exactly that:
> 
> https://lore.kernel.org/r/20250225-qps615_v4_1-v4-7-e08633a7bdf8@oss.qualcomm.com/
> 
> So either include that patch in your series (addressing the review
> feedback I sent for it and cc'ing the original submitter) or wait
> for it to be respun by the original submitter.

Update -- Krishna respun the patch:

https://lore.kernel.org/r/20250412-qps615_v4_1-v5-7-5b6a06132fec@oss.qualcomm.com/

