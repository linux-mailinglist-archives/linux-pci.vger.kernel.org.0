Return-Path: <linux-pci+bounces-25659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0789A85719
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 10:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21AB11B61DC0
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 08:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B887529344B;
	Fri, 11 Apr 2025 08:58:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472EE15D5B6;
	Fri, 11 Apr 2025 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744361913; cv=none; b=Xpq6GLYk+IB05HJCq4LDr0/lFNWyP4EGy+oUD/CrUloTOQu9/HEBRht/02SfXLJbH4NDiiTqcOR8chJqmN+aKoSlfMTcfNHtsT4uq3qZFWRiWQeyxqESky6lPFIAiwq1XL+6e6UX8di7dI3JDsPvc683ofxnqKCmxq6F4aA+Glw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744361913; c=relaxed/simple;
	bh=GGcmJ801V4S5R0AOJnKrnxXmRR1nQzrCrRf7CI7Sl4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMYPdSAxxpULOXUXUEEe12Qa1iedha4DcoiRZaNX4EiVbqmJ6wZxFnLYEaKsr3i/i+AKVMqUM0G7UW44FMOcf672/qvDciz5N54mRIQYzyqSBVykmm/ubqpEscjfnuR4Q1HbUGYmbRHcuR9SUs2zKJ83ihmFjW2W7fKj+s8zJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 346D3200A293;
	Fri, 11 Apr 2025 10:57:58 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 93BA55EF8C; Fri, 11 Apr 2025 10:58:26 +0200 (CEST)
Date: Fri, 11 Apr 2025 10:58:26 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Yicong Yang <yangyicong@hisilicon.com>, linux-pci@vger.kernel.org,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Joel Mathew Thomas <proxy0@tutamail.com>,
	Russ Weight <russ.weight@linux.dev>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Yilun Xu <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>, Shay Drory <shayd@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 1/2] PCI: pciehp: Ignore Presence Detect Changed caused
 by DPC
Message-ID: <Z_jZsngaY88cP_iy@wunner.de>
References: <cover.1744298239.git.lukas@wunner.de>
 <fa264ff71952915c4e35a53c89eb0cde8455a5c5.1744298239.git.lukas@wunner.de>
 <6b8cf94f-4264-46c5-bf08-77e77796c3ac@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b8cf94f-4264-46c5-bf08-77e77796c3ac@linux.intel.com>

On Thu, Apr 10, 2025 at 07:34:41PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 4/10/25 8:27 AM, Lukas Wunner wrote:
> > Commit a97396c6eb13 ("PCI: pciehp: Ignore Link Down/Up caused by DPC")
> > amended PCIe hotplug to not bring down the slot upon Data Link Layer State
> > Changed events caused by Downstream Port Containment.
> > 
> > However Keith reports off-list that if the slot uses in-band presence
> > detect (i.e. Presence Detect State is derived from Data Link Layer Link
> > Active), DPC also causes a spurious Presence Detect Changed event.
> > 
> > This needs to be ignored as well.
> > 
> > Unfortunately there's no register indicating that in-band presence detect
> > is used.  PCIe r5.0 sec 7.5.3.10 introduced the In-Band PD Disable bit in
> > the Slot Control Register.  The PCIe hotplug driver sets this bit on
> > ports supporting it.  But older ports may still use in-band presence
> > detect.
> > 
> > If in-band presence detect can be disabled, Presence Detect Changed events
> 
> It should be "in-band presence detect is disabled", right?

Well, for all practical purposes it's the same because pciehp disables
in-band PD if it can be disabled.

> > occurring during DPC must not be ignored because they signal device
> > replacement.  On all other ports, device replacement cannot be detected
> > reliably because the Presence Detect Changed event could be a side effect
> > of DPC.  On those (older) ports, perform a best-effort device replacement
> > check by comparing the Vendor ID, Device ID and other data in Config Space
> > with the values cached in struct pci_dev.  Use the existing helper
> > pciehp_device_replaced() to accomplish this.  It is currently #ifdef'ed to
> > CONFIG_PM_SLEEP in pciehp_core.c, so move it to pciehp_hpc.c where most
> > other functions accessing config space reside.
> 
> Code looks fine to me
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>

Thanks for taking a look!

Lukas

