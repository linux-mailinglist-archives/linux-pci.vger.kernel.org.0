Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF42226DB1A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 14:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgIQMJA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 08:09:00 -0400
Received: from foss.arm.com ([217.140.110.172]:45454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgIQMIr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 08:08:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 056CF30E;
        Thu, 17 Sep 2020 05:08:13 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F4053F68F;
        Thu, 17 Sep 2020 05:08:11 -0700 (PDT)
Date:   Thu, 17 Sep 2020 13:08:06 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v12 00/10] PCI: brcmstb: enable PCIe for STB chips
Message-ID: <20200917120806.GA3666@e121166-lin.cambridge.arm.com>
References: <20200911175232.19016-1-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911175232.19016-1-james.quinlan@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 11, 2020 at 01:52:20PM -0400, Jim Quinlan wrote:

[...]

> Jim Quinlan (10):
>   PCI: brcmstb: PCIE_BRCMSTB depends on ARCH_BRCMSTB
>   dt-bindings: PCI: Add bindings for more Brcmstb chips
>   PCI: brcmstb: Add bcm7278 register info
>   PCI: brcmstb: Add suspend and resume pm_ops
>   PCI: brcmstb: Add bcm7278 PERST# support
>   PCI: brcmstb: Add control of rescal reset
>   PCI: brcmstb: Set additional internal memory DMA viewport sizes
>   PCI: brcmstb: Accommodate MSI for older chips
>   PCI: brcmstb: Set bus max burst size by chip type
>   PCI: brcmstb: Add bcm7211, bcm7216, bcm7445, bcm7278 to match list
> 
>  .../bindings/pci/brcm,stb-pcie.yaml           |  56 ++-
>  drivers/pci/controller/Kconfig                |   3 +-
>  drivers/pci/controller/pcie-brcmstb.c         | 436 +++++++++++++++---
>  3 files changed, 424 insertions(+), 71 deletions(-)

Applied to pci/bcrmstb, thanks !

Lorenzo
