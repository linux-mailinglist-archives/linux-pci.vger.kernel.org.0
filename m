Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2AC1E67AE
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 18:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405135AbgE1QrG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 12:47:06 -0400
Received: from foss.arm.com ([217.140.110.172]:55218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405105AbgE1QrF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 May 2020 12:47:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 890F830E;
        Thu, 28 May 2020 09:47:04 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12BB13F6C4;
        Thu, 28 May 2020 09:47:02 -0700 (PDT)
Date:   Thu, 28 May 2020 17:46:57 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v4 0/2]  PCI: Add new UniPhier PCIe endpoint driver
Message-ID: <20200528164657.GA30482@e121166-lin.cambridge.arm.com>
References: <1589457801-12796-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589457801-12796-1-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 14, 2020 at 09:03:19PM +0900, Kunihiko Hayashi wrote:
> This series adds PCIe endpoint controller driver for Socionext UniPhier
> SoCs. This controller is based on the DesignWare PCIe core.
> 
> This driver supports Pro5 SoC only, so Pro5 needs multiple clocks and
> resets in devicetree node.
> 
> Changes since v3:
> - dt-bindings: Convert with dt-schema
> - Replace with devm_platform_ioremap_resource()
> - Add a commnet that mutex covers raising legacy IRQ
> 
> Changes since v2:
> - dt-bindings: Add clock-names, reset-names, and fix example for Pro5
> - Remove 'is_legacy' indicating that the compatible is for legacy SoC
> - Use pci_epc_features instead of defining uniphier_soc_data
> - Remove redundant register read access
> - Clean up return code on uniphier_add_pcie_ep()
> - typo: intx -> INTx
> 
> Changes since v1:
> - dt-bindings: Add Reviewed-by line
> - Fix register value to set EP mode
> - Add error message when failed to get phy
> - Replace INTx assertion time with macro
> 
> Kunihiko Hayashi (2):
>   dt-bindings: PCI: Add UniPhier PCIe endpoint controller description
>   PCI: uniphier: Add Socionext UniPhier Pro5 PCIe endpoint controller
>     driver
> 
>  .../bindings/pci/socionext,uniphier-pcie-ep.yaml   |  92 +++++
>  MAINTAINERS                                        |   4 +-
>  drivers/pci/controller/dwc/Kconfig                 |  13 +-
>  drivers/pci/controller/dwc/Makefile                |   1 +
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c      | 383 +++++++++++++++++++++
>  5 files changed, 489 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
>  create mode 100644 drivers/pci/controller/dwc/pcie-uniphier-ep.c

Applied to pci/dwc, thanks !

Lorenzo
