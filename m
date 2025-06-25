Return-Path: <linux-pci+bounces-30629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF23AAE8690
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 16:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0DA4A6388
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 14:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DAC263C8E;
	Wed, 25 Jun 2025 14:33:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B3625FA07
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750862016; cv=none; b=NlLb4xc/Wbq2qFVkcDhPr5guXuXnyuh5DSLi+EOs2etzd/92wAe1OY7T+Rv4k8Ys2+yBFHAk2E3AN5KZk8eWvSUiw0wFqOCvNgPsinfQZ7pnVJbpyO8l/QeJux7Y1yj/IiKsZzddq1mF+R9uMXgv1/SncUmA5H7SMJ1Ej/2d47o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750862016; c=relaxed/simple;
	bh=/iLj6/oPmFHXVXdglfTrWoLI8TAW+tGOKSkB0IDapSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJcWhTfhi/cw0oSYFRnhMEE3HjxfpnkNdnibP4l7u+ADgGgmhMAG8I1ipEx50guAcFJS+lEIbZsyHddfn7P/WMFZtZsIpIgI3n/5XavOykn+opp0aEH0memMX6JMF1hGk0F29cxMJG1BtTe3J8HRXdRTSDR/FvVVNU1ZyZBHFGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 18D2B2C000A8;
	Wed, 25 Jun 2025 16:33:32 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DD5D43B7098; Wed, 25 Jun 2025 16:33:31 +0200 (CEST)
Date: Wed, 25 Jun 2025 16:33:31 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ben Hutchings <ben@decadent.org.uk>, David Airlie <airlied@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Andi Kleen <ak@linux.intel.com>, Ahmed Salem <x0rw3ll@gmail.com>,
	Borislav Petkov <bp@alien8.de>, dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH] agp/amd64: Bind to unsupported devices only if AGP is
 present
Message-ID: <aFwIu0QveVuJZNoU@wunner.de>
References: <f8ff40f35a9a5836d1371f60e85c09c5735e3c5e.1750497201.git.lukas@wunner.de>
 <b73fbb3e3f03d842f36e6ba2e6a8ad0bb4b904fd.camel@decadent.org.uk>
 <aFalrV1500saBto5@wunner.de>
 <279f63810875f2168c591aab0f30f8284d12fe02.camel@decadent.org.uk>
 <aFa8JJaRP-FUyy6Y@wunner.de>
 <9077aab5304e1839786df9adb33c334d10c69397.camel@decadent.org.uk>
 <98012c55-1e0d-4c1b-b650-5bb189d78009@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98012c55-1e0d-4c1b-b650-5bb189d78009@redhat.com>

On Wed, Jun 25, 2025 at 04:08:38PM +0200, Hans de Goede wrote:
> Lukas made me aware of this attempt to fix the KERN_CRIT msg, because
> I wrote a slightly different patch to fix this:
> 
> https://lore.kernel.org/dri-devel/20250625112411.4123-1-hansg@kernel.org/
> 
> This seems like a cleaner fix to me and something which would be good
> to have regardless since currently the driver_attach() call is doing
> too much work because the promisc table catches an unnecessary wide
> net / match matching many PCI devices which cannot be AGP capable
> at all.

So how do you know that all of these unsupported devices have
PCI_CLASS_BRIDGE_HOST?  The only thing we know is that an AGP
Capability must be present.

In particular, AGP 3.0 sec 2.5 explicitly allows PCI-to-PCI bridges
in addition to Host-to-PCI bridges.

Thanks,

Lukas

