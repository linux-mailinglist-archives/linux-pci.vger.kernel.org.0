Return-Path: <linux-pci+bounces-42781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48535CADFFD
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 19:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5987308D59C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 18:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CF92E8B66;
	Mon,  8 Dec 2025 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pe4Hyj11"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DD82E88B0;
	Mon,  8 Dec 2025 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765218837; cv=none; b=EeMImex5Wf4rOAO3zSidu5bGk8v1y7NJqG3olJPXtgZEz2xR/Jo1lh8u16v0PXjVPtY9vb9ghHZfeyRw5WYfz5CwZ+jzbSIZRsDtiHDhmdKU4hXWMYL4WvB+ouKLMRHb10pwvzw+vGNjxWk0vqMnRSx8b25m2bZKXfnoEfkEQCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765218837; c=relaxed/simple;
	bh=e93eqfKxDXqA0fX+liok92bIMbKM7F3uE4csfNfPsBM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BBmhz0p3nzbRbiWUnGyZUiYw8TKZSj+Ce1LNwTpkrn+lgX19ck5LX7yh1gy1DvKGCaP2lvmTpicnwyj+fpXSHqQacuO5HMxlWTfDk0LsZjA+gVsq0q5EUAmpZ/akhtivfS3vL+/9FtGijnNwGk0u5N7wMmDrJyT8Q1LwVDPdDlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pe4Hyj11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C9BC4CEF1;
	Mon,  8 Dec 2025 18:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765218837;
	bh=e93eqfKxDXqA0fX+liok92bIMbKM7F3uE4csfNfPsBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pe4Hyj116aZ8thm13O3TvZyAAVeWw8IKnIX0GZJsAjqEjKpo8ViznoXm7738XWsHK
	 r+OGjO05kLha1zsW2zi06zIlp2xU6hVBD9tQjw1tVnhrw67hftKF1eCtLrWwHfeujT
	 yY0BKANf1YOgZ6jPvk6ETBgAG4qnCotmsK/8M6Xx+WK6h0L2a0ceiGu/XzU/Z4NNoO
	 CdXnwhrUP5DdFMN0AV4HBAGwp+TteET35j9PDFGMXCLxVZ8PaqJh9b/3TnoDzySgYC
	 a/9Gys/xQ/bIHfitiLVHazcXQMIvGpU7TBeHgD+I7MHpfuyuqKZJ1oKB5S5dyGhfRS
	 5wUYxnLxhvApQ==
Date: Mon, 8 Dec 2025 12:33:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v13 02/25] PCI/CXL: Introduce pcie_is_cxl()
Message-ID: <20251208183356.GA3416294@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5d4f527-1a66-4c1e-9311-b8f3fe3badf1@amd.com>

On Mon, Dec 08, 2025 at 09:26:29AM -0600, Bowman, Terry wrote:
> On 12/5/2025 6:45 PM, Bjorn Helgaas wrote:
> > On Mon, Nov 03, 2025 at 06:09:38PM -0600, Terry Bowman wrote:
> >> CXL and AER drivers need the ability to identify CXL devices.
> >>
> >> Introduce set_pcie_cxl() with logic checking for CXL.mem or CXL.cache
> >> status in the CXL Flexbus DVSEC status register. The CXL Flexbus DVSEC
> >> presence is used because it is required for all the CXL PCIe devices.[1]

Spec usage seems to be "Flex Bus", which would help searches.

> >> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
> >> CXL.cache and CXl.mem status.
> >>
> >> In the case the device is an EP or USP, call set_pcie_cxl() on behalf of
> >> the parent downstream device. Once a device is created there is
> >> possibilty the parent training or CXL state was updated as well. This
> >> will make certain the correct parent CXL state is cached.
> ...

> >> +		pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_FLEXBUS_STATUS_OFFSET, &cap);
> >> +
> >> +		dev->is_cxl = FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_CACHE_MASK, cap) ||
> >> +			FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_MEM_MASK, cap);

> > Not sure the "_MASK" and "_OFFSET" on the end of all these #defines is
> > really needed.  Other items in pci_regs.h typically don't include
> > them, and these names get really long.  
> 
> These were moved over from local CXL header. As a result they are not 
> consistent in the usage of offset and mask. Would you like for this to 
> be made the same ? This would be to change all points where used.

I think it's worth dropping "_MASK" and "_OFFSET" to reduce the
length.

> >> +	 * Update parent's CXL state because alternate protocol training
> >> +	 * may have changed
> > 
> > What is the event that changes alternate protocol training?  The
> > commit log says "once a device is created", but I don't know what that
> > means in terms of hardware.
> 
> There is potential an upstream device (switch) was hotpluged and in
> the case of the alt training retries may not be correctly cached in
> pci_dev::is_cxl.

I assume this refers to the Alternate Protocol Negotiation (PCIe r7.0,
seg 4.2.5.2), which happens during link training.

IIUC, the problem here is that we may enumerate a bridge before its
secondary link has trained.  In that case, the Cache_Enabled and
Mem_Enabled bits in the bridge's Flex Bus Port Status may be zero.
After the secondary link has trained, those bits may be set based on
the alternate protocol negotiation, so we need to re-read the bridges
Port Status.  Annoying that these are documented as RO when they don't
really seem to be read-only.

Maybe there's no point in reading the bridge Flex Bus Port Status at
all until we enumerate a device *below* the bridge, e.g, something
like this:

  if (!pci_is_pcie(dev))
    return;

  if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT ||
	pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM))
    return;

  /* Parent's CXL status only valid when link to child has trained */
  bridge = pci_upstream_bridge(dev);
  dvsec = pci_find_dvsec_capability(bridge, PCI_VENDOR_ID_CXL,
                                    PCI_DVSEC_CXL_FLEXBUS_PORT);
  if (!dvsec)
    return;

  pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_FLEXBUS_STATUS_OFFSET, &cap);
  ...

