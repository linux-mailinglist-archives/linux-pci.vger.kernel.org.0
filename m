Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4AE28733A
	for <lists+linux-pci@lfdr.de>; Thu,  8 Oct 2020 13:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgJHLXW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Oct 2020 07:23:22 -0400
Received: from foss.arm.com ([217.140.110.172]:51764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbgJHLXW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Oct 2020 07:23:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE169D6E;
        Thu,  8 Oct 2020 04:23:21 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27BD03F71F;
        Thu,  8 Oct 2020 04:23:20 -0700 (PDT)
Date:   Thu, 8 Oct 2020 12:23:14 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v3 0/4] PCI: dwc: Move iATU register mapping to common
 framework
Message-ID: <20201008112314.GA1181@e121166-lin.cambridge.arm.com>
References: <1601444167-11316-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601444167-11316-1-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 30, 2020 at 02:36:03PM +0900, Kunihiko Hayashi wrote:
> This moves iATU register mapping in the Keystone driver to common
> framework. And this adds "iatu" property description to the dt-bindings
> for UniPhier PCIe host and endpoint controller.
> 
> This series is split from the previous patches:
> https://www.spinics.net/lists/linux-pci/msg97608.html
> "[PATCH v6 0/6] PCI: uniphier: Add features for UniPhier PCIe host controller"
> 
> This has been confirmed with PCIe version 4.80 controller on UniPhier platform.
> Please comfirm this series on Keystone platform if necessary.
> 
> Changes since v2:
> - dt-bindings: Fix errors from dt_binding_check
> 
> Changes since v1:
> - Use to_platform_device() instead of of_find_device_by_node()
> - Add Reviewed-by: line to 4th patch for keystone
> - dt-bindings: Add description for uniphier-ep
> 
> Kunihiko Hayashi (4):
>   dt-bindings: PCI: uniphier: Add iATU register description
>   dt-bindings: PCI: uniphier-ep: Add iATU register description
>   PCI: dwc: Add common iATU register support
>   PCI: keystone: Remove iATU register mapping
> 
>  .../bindings/pci/socionext,uniphier-pcie-ep.yaml     | 20 ++++++++++++++------
>  .../devicetree/bindings/pci/uniphier-pcie.txt        |  1 +
>  drivers/pci/controller/dwc/pci-keystone.c            | 20 ++++----------------
>  drivers/pci/controller/dwc/pcie-designware.c         |  5 +++++
>  4 files changed, 24 insertions(+), 22 deletions(-)

Applied to pci/dwc, thanks.

Lorenzo
