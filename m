Return-Path: <linux-pci+bounces-32761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69654B0E678
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 00:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EBD6C3D1B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 22:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F5C27A446;
	Tue, 22 Jul 2025 22:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z326O/6u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E21C27A13D
	for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2025 22:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753223724; cv=none; b=XmyMc9/vrA+3QdJDdO6VI4Sq1RkJmAZgtU5OXKnCLQSAhLoi0jv2W5Lj3q/Mr/Gc2kLMpSc60wy9v80phjZGxoh8erqfo6DU3J8IcmlhfOcIHnoTZhnG3c/pBuvGTNT7gUQSotoDGmT+Z9HwcJJ229NktqtmPKkkDma55xsy/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753223724; c=relaxed/simple;
	bh=XVygRUNpIKt3YzXhLA/An7kw5kFfYsgRVyeZ+q7YwQA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=T3eiQ+mWpLS2bJ8ioMHPS9SE+eiheb33IzcxDL3alrpsIWVc6ZscdMwen4CXOR1cAHFc0vU71tOEdMDQ0J5xyLHCsDxZJXiiEJEOr1DduijTn37WnpEfFbEI1I2k5/DVI1uvajquAEyH4VMZQMbOPBPHbcNCqYKBYV3al0UqgOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z326O/6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A03C4CEEB;
	Tue, 22 Jul 2025 22:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753223723;
	bh=XVygRUNpIKt3YzXhLA/An7kw5kFfYsgRVyeZ+q7YwQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Z326O/6uistlbpKij6OGtp4++KY7zGkDHC2sUiyvhcv46fw2ICdNrRkj4mnQGJox9
	 1p6fu05N+ZhTXO4Z2WIOIf4Enze/3C3brz1gA1wdeb9bFp2Mq+MJkDBpPU5ufcYoIK
	 2+n0JshLMpV2rPK2PNYm0Z+H25ERzY7E2U0CzUSZcdkGTe/nRNMBxbq7AYRicH56QN
	 eRPyiWCvuTqvLtd258Cw7UziH8+YqhmHz7yeudXBPYTjpJjS9wRTnT6iHFr7UjanAw
	 LIJ+hCcEFNi1oDoXlJ0xZ4EYAmGHVJu1ZR6C3IEHFwR/U2INVShmbxytz/qhHLMrio
	 Xi1rl7H1WV50Q==
Date: Tue, 22 Jul 2025 17:35:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Laurent Bigonville <bigon@bigon.be>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Gil Fine <gil.fine@linux.intel.com>,
	Rene Sapiens <rene.sapiens@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/5] PCI: Clean up and fix is_hotplug_bridge usage
Message-ID: <20250722223522.GA2856849@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752390101.git.lukas@wunner.de>

On Sun, Jul 13, 2025 at 04:31:00PM +0200, Lukas Wunner wrote:
> The original impetus of this series is to fix a runtime PM ref imbalance
> on hot-removal of PCIe hotplug ports (patch [1/5]).
> 
> That is achieved by adding an is_pciehp flag to struct pci_dev.
> The new flag is only set on PCIe Hot-Plug Capable ports, unlike the
> existing is_hotplug_bridge flag, which is also set on ACPI slots and
> Conventional PCI hotplug bridges (via quirk_hotplug_bridge()).
> 
> Patches [2/5] to [4/5] replace is_hotplug_bridge with is_pciehp in a
> number of places for clarity and to fix some actual bugs.
> 
> Optional patch [5/5] follows a suggestion from Bjorn to set
> host->native_pcie_hotplug up front based on pcie_ports_native.
> That patch needs an ack from Rafael because it touches ACPI code.
> Up to Bjorn whether it is a worthwhile improvement or not.
> 
> I'm open to suggestions for a different name than is_pciehp,
> e.g. is_pciehp_bridge.
> 
> I've reviewed this a couple of times, but would appreciate further
> reviewing and testing by others to raise the confidence.  Mika is
> out of office until July 28, so I'm cc'ing thunderbolt developers
> Alan, Gil and Rene.
> 
> I've got an additional patch to replace is_hotplug_bridge with is_pciehp
> in quirk_thunderbolt_hotplug_msi() and tb_apple_add_links().  I intend
> to submit it to Mika separately if/when this series is accepted.
> 
> Link to v1, which consisted only of a (problematic) variant of patch [1/5]:
> https://lore.kernel.org/r/86c3bd52bda4552d63ffb48f8a30343167e85271.1750698221.git.lukas@wunner.de/
> 
> Lukas Wunner (5):
>   PCI/ACPI: Fix runtime PM ref imbalance on Hot-Plug Capable ports
>   PCI/portdrv: Use is_pciehp instead of is_hotplug_bridge
>   PCI: pciehp: Use is_pciehp instead of is_hotplug_bridge
>   PCI: Move is_pciehp check out of pciehp_is_native()
>   PCI: Set native_pcie_hotplug up front based on pcie_ports_native
> 
>  drivers/acpi/pci_root.c          |  3 ++-
>  drivers/pci/hotplug/pciehp_hpc.c |  2 +-
>  drivers/pci/pci-acpi.c           | 10 +---------
>  drivers/pci/pci.c                | 18 +++++++++++++-----
>  drivers/pci/pcie/portdrv.c       |  4 ++--
>  drivers/pci/probe.c              |  2 +-
>  include/linux/pci.h              |  6 ++++++
>  include/linux/pci_hotplug.h      |  3 ++-
>  8 files changed, 28 insertions(+), 20 deletions(-)

Thanks!  I applied these to pci/hotplug, hoping to put them in v6.17.

I moved the previous pci/hotplug branch to pci/hotplug-pnv_php.

