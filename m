Return-Path: <linux-pci+bounces-2391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84239832E34
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 18:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65DD1C212B6
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 17:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4633B55E76;
	Fri, 19 Jan 2024 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3eVaqJV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A93E55C05;
	Fri, 19 Jan 2024 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685500; cv=none; b=u7NZkcTE3BrpOhGH92e7EMtdkW0TTBDqehWpwKvrdzrNMOCBbB7aU8oF2MmN7w64LCfDYNnhUJZtiWMJitIDM+UX83MClA+JgKMGHpLz4ak2yDldhY/yf3br0WUIa4CJMdP/H9Kk6qVRvcXkwjkdq1W+k+KrGnqyNVle04n/Clw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685500; c=relaxed/simple;
	bh=bx3dBEafVwA3lVJVceH0Td6l7zSsuteDOXP4YqQuYQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iQEERUECthgDV8UCBEucyUFsDBFu2J5lIFktbBfo1qYn/Av9KusCpcjtJ/w/N00OY2Ekmc2oQWfx5dBioi2oQLFjWngGvW7Zpto/BNkaQ3qUK2JXPMT8sLKrnH40nDmplUjCChXvEp6p8CFFkBSF2d3rBHxsKHeQucCsnyL1qC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3eVaqJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3592AC433F1;
	Fri, 19 Jan 2024 17:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705685499;
	bh=bx3dBEafVwA3lVJVceH0Td6l7zSsuteDOXP4YqQuYQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=d3eVaqJVId8F9SFx2HE7+VtBKBkeoTgOSnCfGcnutVGB8Amu2/NnAr53RHpdJW2cI
	 HsrCHES1ME2ZiCgLk6EGJZ08QqQamaNwM/dbaSfc1oas1ONNVAI1XEH7Pp3sMe+nQ6
	 k4w/PAWIWW0rY38M5L0JQwavF9MGjRS/YOEUv5ktyVRdMAslB6F1gZ3sH0a0qDJ8b3
	 4K29qSzZG6hn5jyt1VLBc2obJvJVFWAQOwauaeBIZ7MUe7eRZKL0jExT4NydchuIVx
	 SdTIokkHWVIE0KAg0DXmhikeel9INExRR1RqCK0mijGX2qrUNINUVGexcvi5zp43iP
	 w2pZNvgaL6SZw==
Date: Fri, 19 Jan 2024 11:31:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: robh@kernel.org, lpieralisi@kernel.org, kw@linux.com,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, will@kernel.org, frowand.list@gmail.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V2 2/2] PCI: Add support for "preserve-boot-config"
 property
Message-ID: <20240119173137.GA180921@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e8f6c52-6149-42c0-affb-d8b072a77956@nvidia.com>

On Mon, Jan 15, 2024 at 08:02:56PM +0530, Vidya Sagar wrote:
> On 1/12/2024 10:28 PM, Bjorn Helgaas wrote:
> > On Wed, Jan 10, 2024 at 08:37:25AM +0530, Vidya Sagar wrote:
> > > Add support for "preserve-boot-config" property that can be used to
> > > selectively (i.e. per host bridge) instruct the kernel to preserve the
> > > boot time configuration done by the platform firmware.
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > ---
> > > V2:
> > > * Addressed issues reported by kernel test robot <lkp@intel.com>
> > > 
> > >   drivers/pci/controller/pci-host-common.c |  5 ++++-
> > >   drivers/pci/of.c                         | 18 ++++++++++++++++++
> > >   drivers/pci/probe.c                      |  2 +-
> > >   include/linux/of_pci.h                   |  6 ++++++
> > >   4 files changed, 29 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> > > index 6be3266cd7b5..d3475dc9ec44 100644
> > > --- a/drivers/pci/controller/pci-host-common.c
> > > +++ b/drivers/pci/controller/pci-host-common.c
> > > @@ -68,13 +68,16 @@ int pci_host_common_probe(struct platform_device *pdev)
> > > 
> > >        of_pci_check_probe_only();
> > > 
> > > +     bridge->preserve_config =
> > > +             of_pci_check_preserve_boot_config(dev->of_node);
> > 
> > Thanks for leveraging the existing "preserve_config" support for the
> > ACPI _DSM.  Is pci_host_common_probe() the best place for this?  I
> > think there are many DT platform drivers that do not use
> > pci_host_common_probe(), so I wonder if there's a more generic place
> > to put this.
>
> My understanding is that pci_host_common_probe() is mainly used in
> systems where the firmware would have taken care of all the platform
> specific initialization and giving the ECAM and 'ranges' info through DT
> for the Linux kernel to go ahead and perform the enumeration. This is
> similar to ACPI way of handing over the system from firmware to the OS.
> 
> If PCIe controllers are getting initialized in the kernel itself, then
> pci_host_probe() is called directly from the respective host controller
> drivers which is the case with all the DesignWare based implementations
> including Tegra194 and Tegra234. In those systems, since the controllers
> themselves have come up and gotten initialized in the kernel, resource
> assignment has to happen anyway.

acpi_pci_root_create() sets "preserve_config" based on the
DSM_PCI_PRESERVE_BOOT_CONFIG _DSM for all ACPI host bridges.

Similarly, I think we should set "preserve_config" based on the DT
"preserve-boot-config" property for *all* DT-based host bridges,
regardless of where the controller init happens.

  acpi_pci_root_create
    pci_create_root_bus
      pci_alloc_host_bridge
      pci_register_host_bridge
    acpi_evaluate_dsm_typed(DSM_PCI_PRESERVE_BOOT_CONFIG)  <--
    pci_scan_child_bus

  pci_host_common_probe
+   of_pci_check_preserve_boot_config       <-- proposed
    pci_host_probe
      pci_scan_root_bus_bridge
        pci_register_host_bridge
          pci_set_bus_of_node
        pci_scan_child_bus

Maybe we should do both in pci_register_host_bridge()?  E.g., make a
function that sets "preserve_config" based on either the ACPI _DSM or
the DT property, whichever is appropriate, and call it from
pci_register_host_bridge()?

Bjorn

