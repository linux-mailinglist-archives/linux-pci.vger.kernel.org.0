Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDED383A14
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 18:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245361AbhEQQhx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 12:37:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245137AbhEQQhl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 May 2021 12:37:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 648FF611BD;
        Mon, 17 May 2021 16:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621269384;
        bh=+X4+bVfzpXfIBWRjakB4ifMEjfwf5eB74K2ooB0BvKs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mrYMtv1M6tHlqyA6CqYBWaIneywFJ8hwyUoaWmJWO1aBoBlYRnCcmyhZMKC0yLyaR
         L7mvWpGdybVWGaENMBE6mq9gjH0sfYPnaY1+eRq8R+ZOHeLGqZceQDDNgUAU0f4Jvq
         MmibiOMYL5cSc1+YOUeDBcM1IQIsyMe4+riNcK3g3bdQyJCSbq3WIx37g6RM4islnV
         tptmI49809/uRmboehthxjM3H/6kET4bnLxDOynWRLSYv7o0+atkGxN/ZW5CMwwhYq
         3vMKLyMt36Uaghsjc+qHPKSjyJnedWRE4+zCKZq6d1L1tfMgKtHkfBDF39YZXot178
         zFp+kV+EOkf3A==
Date:   Mon, 17 May 2021 11:36:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH 0/5] PCI: dwc: pci-dra7xx: miscellaneous improvements
Message-ID: <20210517163623.GA21579@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517154122.430544-1-luca@lucaceresoli.net>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 17, 2021 at 05:41:17PM +0200, Luca Ceresoli wrote:
> This is an series of mixed improvements to the DRA7 PCI controller driver:
> allow building as a loadabel module, allow to get and enable a clock and a
> small cleanup.
> 
> Luca
> 
> Luca Ceresoli (5):
>   PCI: dwc: export more symbols to allow modular drivers
>   PCI: dwc: pci-dra7xx: make it a kernel module
>   PCI: dwc: pci-dra7xx: allow to build as a loadable module
>   PCI: dwc: pci-dra7xx: remove unused include
>   PCI: dwc: pci-dra7xx: get an optional clock

This driver has a poor record of subject lines:

  PCI: pci-dra7xx: Prepare for deferred probe with module_platform_driver
  PCI: dwc: Move dw_pcie_setup_rc() to DWC common code
  PCI: dwc/dra7xx: Use the common MSI irq_chip
  PCI: dwc: pci-dra7xx: Fix runtime PM imbalance on error

The "PCI: dwc:" ones are fine -- they apply to the shared dwc core,
not specifically to dra7xx.

The driver-specific ones:

  PCI: pci-dra7xx:
  PCI: dwc/dra7xx:
  PCI: dwc: pci-dra7xx:

are redundant and waste space.  There's no need to mention "dwc" for
dra7xx-specific things, and no need to mention "PCI" twice.

We should use the "PCI: dra7xx:" prefix for things specific to this
driver.

The rest of the subject line should start with a capital letter.  The
subject line should contain specific information when practical.  For
example,

  PCI: dwc: Export dw_pcie_link_up(), dw_pcie_ep_reset_bar() for modular drivers
  PCI: dra7xx: Allow building as module
  PCI: dra7xx: Remove unused linux/init.h include
  PCI: dra7xx: Get optional external clock

I would squash 2/5 and 3/5, similar to a98d2187efd9 ("PCI: meson:
Build as module by default") and 526a76991b7b ("PCI: aardvark:
Implement driver 'remove' function and allow to build it as module").

>  drivers/pci/controller/dwc/Kconfig            |  6 +++---
>  drivers/pci/controller/dwc/pci-dra7xx.c       | 21 +++++++++++++++++--
>  .../pci/controller/dwc/pcie-designware-ep.c   |  1 +
>  drivers/pci/controller/dwc/pcie-designware.c  |  1 +
>  4 files changed, 24 insertions(+), 5 deletions(-)
> 
> -- 
> 2.25.1
> 
