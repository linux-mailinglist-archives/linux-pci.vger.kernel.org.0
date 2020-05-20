Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16631DB954
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 18:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgETQbN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 12:31:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgETQbM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 May 2020 12:31:12 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB03D20709;
        Wed, 20 May 2020 16:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589992272;
        bh=ZHt0SWZGXV4CqNqR8zsAlH++equ142w+4Iqq7YRsfHU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SQ4SXMhDb2MSpdo3w9xB2XhZC08O/a3U7PR1mlm4UiG84FSmcNUxTTGJ6jyikYs3R
         G9KCaw7FiN+UG0uE8kdGPMuxcCd1Ukd49QB6BmDLTmVanHUZaOyMw6lVasmy/SBXtI
         IWl3/3IXLnjWTAJPvJgaC148m+hohSYL8LFT+MSE=
Date:   Wed, 20 May 2020 11:31:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daire.McNamara@microchip.com
Cc:     amurray@thegoodpenguin.co.uk, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 0/2] PCI: Microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20200520162923.GA1100031@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7b32f86783f0e4883dbf917146f1c2bdb9f9589.camel@microchip.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[fixed Rob's email address ("robh+dt", not "robh-dt"]

On Wed, May 20, 2020 at 11:43:43AM +0000, Daire.McNamara@microchip.com wrote:
> 
> This v9 patch adds support for the Microchip PCIe PolarFire PCIe
> controller when configured in host (Root Complex) mode.

Nit: v7 and v8 used "PCI: microchip:" subject prefixes, which matches
the convention for driver names in drivers/pci/controllers.  This v9
uses "Microchip" again, which doesn't.

Patch 2/2 has extraneous "Subject:" in the subject line.  Again, just
a nit, but it makes a little extra work for somebody to remove that
when applying.

It's also more convenient if 1/2 and 2/2 are sent as replies to the
0/2 cover letter, as you did for v3.

s/This patch// in commit logs (use imperative mood instead).

Rewrap commit logs to fill 75 columns (leaving room for the 4 spaces
added by git log).

No need to repost for these unless you make other fixes, but things
you can consider for the future.

> Updates since v8:
> * Refactored as per Rob Herring's comments:
>   - bindings in schema format
>   - Adjusted licence to GPLv2.0
>   - Refactored access to config space between driver and common eCAM code
>   - Adopted pci_host_probe()
>   - Miscellanous other improvements
> 
> Updates since v7:
> * Build for 64bit RISCV architecture only
> 
> Updates since v6:
> * Refactored to use common eCAM driver
> * Updated to CONFIG_PCIE_MICROCHIP_HOST etc
> * Formatting improvements
> * Removed code for selection between bridge 0 and 1
> 
> Updates since v5:
> * Fixed Kconfig typo noted by Randy Dunlap
> * Updated with comments from Bjorn Helgaas
> 
> Updates since v4:
> * Fix compile issues.
> 
> Updates since v3:
> * Update all references to Microsemi to Microchip
> * Separate MSI functionality from legacy PCIe interrupt handling functionality
> 
> Updates since v2:
> * Split out DT bindings and Vendor ID updates into their own patch
>   from PCIe driver.
> * Updated Change Log
> 
> Updates since v1:
> * Incorporate feedback from Bjorn Helgaas
> 
> Daire McNamara (2):
>   PCI: Microchip: Add host driver for Microchip PCIe controller
>   PCI: Microchip: Add host driver for Microchip PCIe controller
> 
>  .../bindings/pci/microchip,pcie-host.yaml     |  94 +++
>  drivers/pci/controller/Kconfig                |   9 +
>  drivers/pci/controller/Makefile               |   1 +
>  drivers/pci/controller/pcie-microchip-host.c  | 664 ++++++++++++++++++
>  4 files changed, 768 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
>  create mode 100644 drivers/pci/controller/pcie-microchip-host.c
> 
> 
> base-commit: c0cc271173b2e1c2d8d0ceaef14e4dfa79eefc0d
> -- 
> 2.17.1
> 
