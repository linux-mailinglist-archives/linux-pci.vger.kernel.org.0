Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA8C18CAF6
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 10:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgCTJ6u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 05:58:50 -0400
Received: from foss.arm.com ([217.140.110.172]:46804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbgCTJ6u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Mar 2020 05:58:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0106030E;
        Fri, 20 Mar 2020 02:58:50 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B7163F305;
        Fri, 20 Mar 2020 02:58:49 -0700 (PDT)
Date:   Fri, 20 Mar 2020 09:58:43 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] dt-bindings: Convert Cadence PCIe RC/EP to DT
 Schema
Message-ID: <20200320095843.GA21858@e121166-lin.cambridge.arm.com>
References: <20200305103017.16706-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305103017.16706-1-kishon@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 05, 2020 at 04:00:13PM +0530, Kishon Vijay Abraham I wrote:
> Cadence PCIe IP is used by multiple SoC vendors (e.g. TI). Cadence
> themselves have a validation platform for validating the PCIe IP which
> is already in the upstream kernel. Right now the binding only exists for
> Cadence platform and this will result in adding redundant binding schema
> for any platform using Cadence PCIe core.
> 
> This series:
> 1) Create cdns-pcie.yaml which includes properties that are applicable
>    to both host mode and endpoint mode of Cadence PCIe core.
> 2) Create cdns-pcie-host.yaml to include properties that are specific to
>    host mode of Cadence PCIe core. cdns-pcie-host.yaml will include
>    cdns-pcie.yaml.
> 3) Create cdns-pcie-ep.yaml to include properties that are specific to
>    endpoint mode of Cadence PCIe core. cdns-pcie-ep.yaml will include
>    cdns-pcie.yaml.
> 4) Remove cdns,cdns-pcie-ep.txt and cdns,cdns-pcie-host.txt which had
>    the binding for Cadence "platform" and add cdns,cdns-pcie-host.yaml
>    and cdns,cdns-pcie-ep.yaml schema for Cadence Platform. The schema
>    for Cadence platform then includes schema for Cadence PCIe core.
> 
> Changes from v4:
> *) Deprecate "cdns,max-outbound-regions" only for host mode. For EP mode
>    this will be a mandatory property.
> 
> Changes from v3:
> *) Add "Reviewed-by: Rob Herring <robh@kernel.org>"
> *) Fix typo in SPDX header
> 
> Changes from v2:
> *) Created "pci-ep.yaml" for common endpoint controller bindings
> *) Deprecate "cdns,max-outbound-regions" and "cdns,no-bar-match-nbits"
>    binding
> 
> Changes from v1:
> *) Fix maximum values of num-lanes and cdns,no-bar-match-nbits
> *) Fix example DT node for PCIe Endpoint.
> 
> Ref: Patches to convert Cadence driver to library
>      https://lkml.org/lkml/2019/11/11/317
> 
> Some of this was initially part of [1], but to accelerate it getting
> into upstream, sending this as a separate series.
> 
> [1] -> http://lore.kernel.org/r/20200106102058.19183-1-kishon@ti.com
> 
> Kishon Vijay Abraham I (4):
>   dt-bindings: PCI: Add PCI Endpoint Controller Schema
>   dt-bindings: PCI: cadence: Add PCIe RC/EP DT schema for Cadence PCIe
>   dt-bindings: PCI: Convert PCIe Host/Endpoint in Cadence platform to DT
>     schema
>   dt-bindings: PCI: cadence: Deprecate inbound/outbound specific
>     bindings
> 
>  .../bindings/pci/cdns,cdns-pcie-ep.txt        | 27 -------
>  .../bindings/pci/cdns,cdns-pcie-ep.yaml       | 49 ++++++++++++
>  .../bindings/pci/cdns,cdns-pcie-host.txt      | 66 ----------------
>  .../bindings/pci/cdns,cdns-pcie-host.yaml     | 75 +++++++++++++++++++
>  .../devicetree/bindings/pci/cdns-pcie-ep.yaml | 25 +++++++
>  .../bindings/pci/cdns-pcie-host.yaml          | 37 +++++++++
>  .../devicetree/bindings/pci/cdns-pcie.yaml    | 23 ++++++
>  .../devicetree/bindings/pci/pci-ep.yaml       | 41 ++++++++++
>  MAINTAINERS                                   |  2 +-
>  9 files changed, 251 insertions(+), 94 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/pci-ep.yaml

Applied first three patches to pci/dt for v5.7.

Thanks,
Lorenzo
