Return-Path: <linux-pci+bounces-5346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 174C18904D5
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 17:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0AC1F26EF4
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 16:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840A9131BCA;
	Thu, 28 Mar 2024 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAFGfBxE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EBA131BC8;
	Thu, 28 Mar 2024 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642714; cv=none; b=oJjIokW7d1TY6SzSqm3X9YeWIQVR6WoHKZ2mzNulbunzccyPVrxMYWXJbiVvFe2TYiccH+Q9iLeAVOVxoh+WW9gdgT7eW/714sSkp3hcsyGXR22UmgYjZ1UpeoTsJJw4T2z4wajJkCGz4MmlVNUBcqwU4kh11ihGqh6uOpwM0FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642714; c=relaxed/simple;
	bh=kZE5AQy7q/LkMQXaYZMu1agyq0gLCEHxcP10dCKXXmA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=N7Ye0wFAE2CvrQKZI9l1sJpQmS0sX8jfAKmvxJKWdlqdkV2Z9l/Sd8g72Tj7su/tSdt0rIo5bUrw0UWUX977sUHTgflRTYripwcY0vrbWWZx5hzBUCA3mJzwZorU/AfYLT9ThabzD+rNPB66fDd38EHf4Ql+Kh2XMnUAp7mRA3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAFGfBxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B84C433C7;
	Thu, 28 Mar 2024 16:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711642713;
	bh=kZE5AQy7q/LkMQXaYZMu1agyq0gLCEHxcP10dCKXXmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qAFGfBxELR+ImPcOXEz66ekn6o0evwu/KFpr16+y5/qZlMU4On5lREdB3uM9ZNxoI
	 kuFSm2UUX//Zc0nwmIewtAYqwtxKjJVQlDhRPixHkcRL6X/y5eKyw3bOTJIznpbxni
	 gS+mONTxLOb8H65jU9sxsolIVrIuSqLGeV2wgGjxwGeXoF0nFBiwGznsUUzcde5abI
	 ZJ5ejZ7dxAlhJ/FkQnp3POg3ZExwLp5vTNnQZvfWWNMzLKfE5NP4+Ab4nLCcDNl0Vn
	 NpH8n/VGZVvZ+E47Zy5qAlJ2sqVOfXwYA3Z+voB3MA6+mhf6kfbbvTcKzbYHmvsy4i
	 /tcB1/Xk26r7w==
Date: Thu, 28 Mar 2024 11:18:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Update pci_find_capability() stub return values
Message-ID: <20240328161831.GA1568357@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a144b96b-6ec4-4a62-b2ab-1ed631d81544@linux.intel.com>

On Wed, Mar 27, 2024 at 02:49:34PM -0700, Kuppuswamy Sathyanarayanan wrote:
> On 3/27/24 11:02 AM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > f646c2a0a668 ("PCI: Return u8 from pci_find_capability() and similar") and
> > ee8b1c478a9f ("PCI: Return u16 from pci_find_ext_capability() and similar")
> > updated the return type of the extern declarations, but neglected to update
> > the type of the stubs used CONFIG_PCI is not enabled.
> >
> > Update them to match the extern declarations.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> 
> This change looks fine to me.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Thanks for reviewing it!

> But the callers of these functions still seems to use int
> declaration to store the output. Any reason for not changing them?
> Like the usages in drivers/pci/pci.c?

This patch is just to make the extern declarations match the stubs.

No particular reason not to change users other than I didn't want to
change the users before the declarations (to avoid warnings about
assigning an int to a u8 or u16), and there's not a lot of value in
changing local variables, where an int is just on the stack and works
fine.

Changing stored values in a struct would have more benefit.  I took a
quick look and found these possibilities:

  struct controller.cap_offset (drivers/pci/hotplug/shpchp.h SHPC cap)
  struct pci_sriov.pos (drivers/pci/pci.h SR-IOV ext cap)
  struct altera_pcie_data.cap_offset (drivers/pci/controller/pcie-altera.c PCIe cap)

  struct tg3.msi_cap (broadcom/tg3.h MSI cap)
  struct tg3.pcix_cap (broadcom/tg3.h PCI-X cap)
  struct bnx2.pm_cap (broadcom/bnx2.h PM cap)
  struct bnx2.pcix_cap (broadcom/bnx2.h PCI-X cap)
  struct bnx2x_sriov.cap (broadcom/bnx2x/bnx2x_sriov.h SR-IOV ext cap)
  struct amd8111e_priv.pm_cap (amd/amd8111e.c, removed [1])
  struct pci_params.pm_cap (qlogic/qed/qed.h, removed [2])
  struct qed_hw_sriov_info.cap (qlogic/qed/qed_sriov.h SR-IOV ext cap)
  struct eeh_dev.pcix_cap (powerpc/include/asm/eeh.h PCI-X cap)
  struct eeh_dev.pcie_cap (powerpc/include/asm/eeh.h PCIe cap)
  struct eeh_dev.aer_cap (powerpc/include/asm/eeh.h AER ext cap)
  struct eeh_dev.af_cap (powerpc/include/asm/eeh.h AF cap)
  struct icm.vnd_cap (drivers/thunderbolt/icm.c VNDR ext cap)

[1] https://lore.kernel.org/all/20240325220633.1453180-1-helgaas@kernel.org/
[2] https://lore.kernel.org/all/20240325224931.1462051-1-helgaas@kernel.org/

Bjorn

