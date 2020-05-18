Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64621D7C05
	for <lists+linux-pci@lfdr.de>; Mon, 18 May 2020 16:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgERO6J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 May 2020 10:58:09 -0400
Received: from foss.arm.com ([217.140.110.172]:42212 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbgERO6J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 May 2020 10:58:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B9C4101E;
        Mon, 18 May 2020 07:58:08 -0700 (PDT)
Received: from red-moon.cambridge.arm.com (unknown [10.57.25.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED0463F52E;
        Mon, 18 May 2020 07:58:06 -0700 (PDT)
Date:   Mon, 18 May 2020 15:57:59 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tom Joseph <tjoseph@cadence.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/4] PCI: cadence: Deprecate inbound/outbound specific
 bindings
Message-ID: <20200518145759.GA19714@red-moon.cambridge.arm.com>
References: <20200508130646.23939-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508130646.23939-1-kishon@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 08, 2020 at 06:36:42PM +0530, Kishon Vijay Abraham I wrote:
> This series is a result of comments given by Rob Herring @ [1].
> Patch series changes the DT bindings and makes the corresponding driver
> changes.
> 
> Changes from v2:
> 1) Changed the order of patches (no solid reason. Just save some
> rebasing effort for me)
> 2) Added Acked-by Tom and Rob except for the dma-ranges patch
> 3) Re-worked dma-ranges patch for it do decode multiple dma-ranges
>    and configure BAR0, BAR1 and NO_BAR instead of just NO_BAR [2].
> 
> Changes from v1:
> 1) Added Reviewed-by: Rob Herring <robh@kernel.org> for dt-binding patch
> 2) Fixed nitpick comments from Bjorn Helgaas
> 3) Added a patch to read 32-bit Vendor ID/Device ID property from DT
> 
> [1] -> http://lore.kernel.org/r/20200219202700.GA21908@bogus
> [2] -> http://lore.kernel.org/r/eb1ffcb3-264f-5174-1f25-b5b2d3269840@ti.com
> 
> Kishon Vijay Abraham I (4):
>   dt-bindings: PCI: cadence: Deprecate inbound/outbound specific
>     bindings
>   PCI: cadence: Remove "cdns,max-outbound-regions" DT property
>   PCI: cadence: Fix to read 32-bit Vendor ID/Device ID property from DT
>   PCI: cadence: Use "dma-ranges" instead of "cdns,no-bar-match-nbits"
>     property
> 
>  .../bindings/pci/cdns,cdns-pcie-ep.yaml       |   2 +-
>  .../bindings/pci/cdns,cdns-pcie-host.yaml     |   3 +-
>  .../devicetree/bindings/pci/cdns-pcie-ep.yaml |  25 +++
>  .../bindings/pci/cdns-pcie-host.yaml          |  10 ++
>  .../devicetree/bindings/pci/cdns-pcie.yaml    |   8 -
>  .../controller/cadence/pcie-cadence-host.c    | 151 +++++++++++++++---
>  drivers/pci/controller/cadence/pcie-cadence.h |  23 ++-
>  7 files changed, 182 insertions(+), 40 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml

I have applied patches 1-3 to pci/cadence (that I think are
self-contained), waiting for the dma-ranges discussion to wrap up on
patch 4.

Lorenzo
