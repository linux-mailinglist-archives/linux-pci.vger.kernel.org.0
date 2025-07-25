Return-Path: <linux-pci+bounces-32923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C671CB119B2
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 10:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D9D188D375
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 08:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D245192D97;
	Fri, 25 Jul 2025 08:19:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B081E5213
	for <linux-pci@vger.kernel.org>; Fri, 25 Jul 2025 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753431554; cv=none; b=sl4f7KNv5lR63Cm/HB5wfENuFRvQlyPFOVRWxxNQGrbdm5wh4T8uNiZqUaNksiIU3nwxaciXN+nxE+Xtgj8Vz47Fyqt4QRV+hgvHBCZ5fBGa89sCc8N5apUXSxNWa9bu5RZR6dUU7y8RnmYb296ZVI3arxIHInYNi8Moj4agPmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753431554; c=relaxed/simple;
	bh=GHTzgTlwawkMkbdq0Hnz/TrXivQXnXiOY8cVAvqNgis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9SSb20O176Ty4uU6HuAq2dbH9Q9zKYbHl3uIoMKriDhlRGCgjHOKF5Ddc8sj82TgIb2NTHax0f5MPqS6fvoR9oR92GzATUUoVBBX3N8qnPF6VvuoPAS6RB64pidu+kZcMu7R5olLROoFeyWxNgDU4lnvVCVaDDmINOakW13Meg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7306D2C00E99;
	Fri, 25 Jul 2025 10:19:02 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 626E02E6C93; Fri, 25 Jul 2025 10:19:02 +0200 (CEST)
Date: Fri, 25 Jul 2025 10:19:02 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Laurent Bigonville <bigon@bigon.be>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Gil Fine <gil.fine@linux.intel.com>,
	Rene Sapiens <rene.sapiens@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/5] PCI: Clean up and fix is_hotplug_bridge usage
Message-ID: <aIM99vImO6kwAkO2@wunner.de>
References: <cover.1752390101.git.lukas@wunner.de>
 <20250722223522.GA2856849@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722223522.GA2856849@bhelgaas>

On Tue, Jul 22, 2025 at 05:35:22PM -0500, Bjorn Helgaas wrote:
> On Sun, Jul 13, 2025 at 04:31:00PM +0200, Lukas Wunner wrote:
> >   PCI/ACPI: Fix runtime PM ref imbalance on Hot-Plug Capable ports
> >   PCI/portdrv: Use is_pciehp instead of is_hotplug_bridge
> >   PCI: pciehp: Use is_pciehp instead of is_hotplug_bridge
> >   PCI: Move is_pciehp check out of pciehp_is_native()
> >   PCI: Set native_pcie_hotplug up front based on pcie_ports_native
> 
> Thanks!  I applied these to pci/hotplug, hoping to put them in v6.17.
> 
> I moved the previous pci/hotplug branch to pci/hotplug-pnv_php.

Just a heads-up in case it's unintentional, pci/next as of 10 hours ago
does not include the following pci.git branches:

- hotplug

- hotplug-pnv_php
  expected to be applied through powerpc tree per:
  https://lore.kernel.org/r/20250723113912.GA2880767@bhelgaas/

- controller/dwc-stm32
  awaiting a build fix per:
  https://lore.kernel.org/r/20250716192418.GA2550861@bhelgaas/

- trace
  deferred to v6.18 per:
  https://lore.kernel.org/r/20250724222759.GA3065374@bhelgaas/

Thanks,

Lukas

