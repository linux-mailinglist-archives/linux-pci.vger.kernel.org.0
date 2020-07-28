Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E5123078C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 12:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgG1KVC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 06:21:02 -0400
Received: from foss.arm.com ([217.140.110.172]:60376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbgG1KVC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 06:21:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E298F1FB;
        Tue, 28 Jul 2020 03:21:01 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 079763F66E;
        Tue, 28 Jul 2020 03:21:00 -0700 (PDT)
Date:   Tue, 28 Jul 2020 11:20:55 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pci: tegra: Remove PLL power supplies
Message-ID: <20200728102055.GA32448@e121166-lin.cambridge.arm.com>
References: <20200623145528.1658337-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623145528.1658337-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 23, 2020 at 04:55:27PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The XUSB pad controller, which provides access to various USB, PCI and
> SATA pads (or PHYs), needs to bring up the PLLs associated with these
> pads. In order to properly do so, it needs to control the power supplied
> to these PLLs.
> 
> Remove the PLL power supplies from the PCIe controller because it does
> not need direct access to them. Instead it will only use the configured
> pads provided by the XUSB pad controller.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Hi Rob,
> 
> I already made this change as part of the conversion series, but wanted
> to send this out as part of this subseries since it addresses a fairly
> long-standing issue that I'd like to clean up irrespective of the DT
> binding conversion. Since it looks like the conversion series will take
> a bit longer, I think it makes sense to send this out separately.

Applied the series to pci/tegra, thanks.

Lorenzo

> Thierry
> 
>  .../devicetree/bindings/pci/nvidia,tegra20-pcie.txt  | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> index 7939bca47861..d099f3476ccc 100644
> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> @@ -112,28 +112,16 @@ Power supplies for Tegra124:
>  - Required:
>    - avddio-pex-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
>    - dvddio-pex-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
> -  - avdd-pex-pll-supply: Power supply for dedicated (internal) PCIe PLL. Must
> -    supply 1.05 V.
>    - hvdd-pex-supply: High-voltage supply for PCIe I/O and PCIe output clocks.
>      Must supply 3.3 V.
> -  - hvdd-pex-pll-e-supply: High-voltage supply for PLLE (shared with USB3).
> -    Must supply 3.3 V.
>    - vddio-pex-ctl-supply: Power supply for PCIe control I/O partition. Must
>      supply 2.8-3.3 V.
> -  - avdd-pll-erefe-supply: Power supply for PLLE (shared with USB3). Must
> -    supply 1.05 V.
>  
>  Power supplies for Tegra210:
>  - Required:
> -  - avdd-pll-uerefe-supply: Power supply for PLLE (shared with USB3). Must
> -    supply 1.05 V.
>    - hvddio-pex-supply: High-voltage supply for PCIe I/O and PCIe output
>      clocks. Must supply 1.8 V.
>    - dvddio-pex-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
> -  - dvdd-pex-pll-supply: Power supply for dedicated (internal) PCIe PLL. Must
> -    supply 1.05 V.
> -  - hvdd-pex-pll-e-supply: High-voltage supply for PLLE (shared with USB3).
> -    Must supply 3.3 V.
>    - vddio-pex-ctl-supply: Power supply for PCIe control I/O partition. Must
>      supply 1.8 V.
>  
> -- 
> 2.27.0
> 
