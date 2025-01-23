Return-Path: <linux-pci+bounces-20301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C408A1A9F3
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 20:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4BE3A2C30
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 19:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E549F156991;
	Thu, 23 Jan 2025 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRehpicm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96DC13D882;
	Thu, 23 Jan 2025 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737659065; cv=none; b=P5w6Hov6W1mP5fwT05dTC6uU1wp2hji7L1HBofzBhwNf1A55laLElrHKgsVBO3aXFF9k6R4MAQp5SKW4lDNhI70GYoUF2F26HNka5XWshvhqczFgOFexfwcLca4/GDzDJYnfxZVpfwJSJzfGUIBubMQ4AEQ0xeodXGpRmkWjAv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737659065; c=relaxed/simple;
	bh=hHJYIYvVQNSFfUvSqBc7Seoz8vNYl2K6sccCJXZy6JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sDfetzd5QgPyTF6MI5P+AnILw9RU6Y8v4zGQ619fcw8fhGcn03O0TUmijiMqfFpmpIPPNs985BXZ7Ewf+z0rj/VCjWIkYYBnmFdVlMI+m8jM1K4G5OXPceCNpVeObwbBnHvT5/IosAXP6DUaqynRtAaIL94j2Xhy9f82nigzmGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRehpicm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4261C4CED3;
	Thu, 23 Jan 2025 19:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737659065;
	bh=hHJYIYvVQNSFfUvSqBc7Seoz8vNYl2K6sccCJXZy6JQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FRehpicmepTuqm1yVXqleYwTJcp3Foa7lJjXlbM96PUuG7tuSxK7gS56iCJdPvjDq
	 0C2/gPczTRzQ7sDBeT31rwsxA81T514+5sHXrfmJF5pYsubFNAc+6+rmJyIBEQMW8i
	 GPRAtWtVQRcRFlfI8GkXNJOf2SSLrGh55++SiGERF2ZXDqjufdoxG9bSFp8d/H9WwS
	 jzIav7GA5XgptD9oTH2rAoSFqZ3vCQLJ75sX6Hxsxa69Wq4f1eBT3GnjAMOrJOU0Gk
	 2msFwHVBh0YgBlh1i569k8vrz9FvHHJtdhHgh/BvmH3Wg+QSoIgzk67idaYNsS6Ldc
	 FcwCl7bJ7UnPg==
Date: Thu, 23 Jan 2025 13:04:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v8 2/7] PCI: dwc: Use devicetree 'ranges' property to get
 rid of cpu_addr_fixup() callback
Message-ID: <20250123190422.GA1215672@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5JegF7i3Ig2pLYB@lizhi-Precision-Tower-5810>

On Thu, Jan 23, 2025 at 10:21:36AM -0500, Frank Li wrote:
> On Fri, Jan 17, 2025 at 10:42:37AM -0500, Frank Li wrote:
> > On Thu, Jan 16, 2025 at 05:29:16PM -0600, Bjorn Helgaas wrote:
> > > On Thu, Jan 16, 2025 at 05:14:00PM -0600, Bjorn Helgaas wrote:
> > > > On Tue, Nov 19, 2024 at 02:44:20PM -0500, Frank Li wrote:
> > > > > parent_bus_addr in struct of_range can indicate address information just
> > > > > ahead of PCIe controller. Most system's bus fabric use 1:1 map between
> > > > > input and output address. but some hardware like i.MX8QXP doesn't use 1:1
> > > > > map.
> ...

> 	I saw you have not picked all of these patches during you rework
> pci git branches.
> 
> 	I know you are busy, do you have chance to pick left patch for 6.14.

This series had a mix of things: several patches related to
.cpu_addr_fixup(), plus several unrelated ones for PHY mode and i.MX8Q
support.  I think I picked up all the unrelated ones.

.cpu_addr_fixup() is a generic problem that affects dwc (dra7xx, imx6,
artpec6, intel-gw, visconti), cadence (cadence-plat), and now
apparently microchip.

I deferred these because I'm hoping we can come up with a more generic
solution that's easier to apply across all these cases.  I don't
really want to merge something that immediately needs to be reworked
for other drivers.

A few of the things I wonder about:

  - dw_pcie_get_parent_addr() has no DWC dependencies, so it doesn't
    make sense to me to have it be DWC-specific and copy and pasted
    to other places that need something similar.

  - It doesn't seem elegant to iterate through for_each_pci_range() in
    devm_of_pci_get_host_bridge_resources(), then again in
    dw_pcie_host_init() for io_bus_addr, then again in
    dw_pcie_iatu_setup() for each window.  Maybe that's the best we
    can do, but maybe there's a way to capture what we need on the
    first time through.

  - The connection between .cpu_addr_fixup() and use_parent_dt_ranges
    is clear in the patches remove a .cpu_addr_fixup(), but not in the
    DWC patches on the other end.

  - Ideally, "use_parent_dt_ranges" would be the default and we
    wouldn't have a flag to indicate that, and drivers would have to
    opt out instead of opt in.  They basically already do that by
    implementing .cpu_addr_fixup(), so maybe we can take advantage of
    that fact.

Bjorn

