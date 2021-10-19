Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E994043370E
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 15:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhJSNcW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 09:32:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231563AbhJSNcV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 09:32:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D4AB61374;
        Tue, 19 Oct 2021 13:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634650208;
        bh=f/wB0Vy8SSk93aaj9uXpLmhnQ6j6vR6JE5NX/5XOTLk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kSs8J+h7vHCexTiX4JxHH2cZhH9R2XzyTETKuuof/x0oPYLcWM0atJg2OaU48MXW4
         W4Fo4sum+Zti0WYc9yuqWwzELFW+C4KMYzxegHAiqW0icZ/7Phz7kCDcjykwgUyoft
         lfSFEO7r/MPHk8WktZOaYbQ0BNXxc5v8JLgt/I21GSWtjWMq29pVbMSHTaH53+KWBD
         6Sjysoh2lybw61bPFpbh+GLse4Cm/RCHwdC3ct//Hjti7ktl/BsaNXUki/k7egeBam
         tBgbWTBIEtiRvrpOzbFAn8pP14sBLRihkMYo7VfuYvVtk2cSnOhwPgh6FET46bElpU
         h2yhP8GywpAWw==
Date:   Tue, 19 Oct 2021 08:30:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Meng Li <Meng.Li@windriver.com>
Cc:     geert+renesas@glider.be, magnus.damm@gmail.com, robh+dt@kernel.org,
        marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        lorenzo.pieralisi@arm.com, kw@linux.com, bhelgaas@google.com,
        lgirdwood@gmail.com, broonie@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: pcie-rcar: add regulators support
Message-ID: <20211019133007.GA2331336@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019095858.21316-1-Meng.Li@windriver.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 19, 2021 at 05:58:58PM +0800, Meng Li wrote:
> From: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> 
> Add PCIe regulators for KingFisher board.

Please pay attention to the existing code and history.  Your current
subject line is:

  pci: pcie-rcar: add regulators support

which looks nothing like the history:

  $ git log --oneline drivers/pci/controller/pcie-rcar-host.c
  861e133ba268 ("PCI: rcar-host: Remove unneeded includes")
  a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
  d21faba11693 ("PCI: Bulk conversion to generic_handle_domain_irq()")
  83ed8d4fa656 ("PCI: rcar: Convert to MSI domains")
  93cd1bb4862d ("PCI: rcar: Don't allocate extra memory for the MSI capture address")
  c4e0fec2f7ee ("PCI: rcar: Always allocate MSI addresses in 32bit space")
  6e8e137abeab ("PCI: rcar: Drop unused members from struct rcar_pcie_host")
  b64aa11eb2dd ("PCI: Set bridge map_irq and swizzle_irq to default functions")
  669cbc708122 ("PCI: Move DT resource setup into devm_pci_alloc_host_bridge()")
  b411b2e1adb9 ("PCI: rcar: Use struct pci_host_bridge.windows list directly")
  61f11f8250e2 ("PCI: rcar: Use devm_pci_alloc_host_bridge()")
  4f5c883d7815 ("PCI: Move setting pci_host_bridge.busnr out of host drivers")
  6176a5f32751 ("PCI: rcar: Use pci_is_root_bus() to check if bus is root bus")
  6a589900d050 ("PCI: Set default bridge parent device")
  a68e06e729b1 ("PCI: rcar: Fix runtime PM imbalance on error")
  56d292348470 ("PCI: rcar: Use pci_host_probe() to register host")
  78a0d7f2f5a3 ("PCI: rcar: Move shareable code to a common file")
  a18f4b6ea50b ("PCI: rcar: Rename pcie-rcar.c to pcie-rcar-host.c")

You could use something like:

  PCI: rcar-host: Add regulator support for KingFisher

> +	host->pcie3v3 = devm_regulator_get_optional(dev, "pcie3v3");
> +	if (IS_ERR(host->pcie3v3)) {

+1 to Geert's comments.  Sprinkling IS_ERR() everywhere is kind of
ugly.  host->pcie3v3 should be NULL if not present.

Bjorn
