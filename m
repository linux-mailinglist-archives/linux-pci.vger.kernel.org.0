Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252CD288589
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 10:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbgJIItM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 04:49:12 -0400
Received: from foss.arm.com ([217.140.110.172]:45070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730726AbgJIItM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Oct 2020 04:49:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19159D6E;
        Fri,  9 Oct 2020 01:49:11 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBED43F66B;
        Fri,  9 Oct 2020 01:49:09 -0700 (PDT)
Date:   Fri, 9 Oct 2020 09:49:05 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] PCI: dwc: fix two MSI issues
Message-ID: <20201009084904.GA16200@e121166-lin.cambridge.arm.com>
References: <20201009155311.22d3caa5@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009155311.22d3caa5@xhacker.debian>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 09, 2020 at 03:53:11PM +0800, Jisheng Zhang wrote:
> Fix two MSI issues. One to skip PCIE_MSI_INTR0* programming if MSI is
> disabled, another to use an address in the driver data for MSI address,
> to fix the MSI page leakage during suspend/resume.
> 
> Since v6:
>   - Keep the IS_ENABLED(CONFIG_PCI_MSI) check in dw_pcie_msi_init().
> 
> Since v5:
>   - rebase on pci/dwc branch
>   - add Acked-by tag
> 
> Since v4:
>   - fix pci-dra7xx.c
> 
> Since v3:
>   - add Acked-by tag
>   - change patch2 commit msg to make it clear
>   - map the MSI msg with dma_map_single_attrs() for some platforms
>     which either has separate addrs for dma and phy or has mem access
>     limitation for the PCIe.
> 
> Since v2:
>   - add Acked-by tag
>   - use an address in the driver data for MSI address. Thank Ard and Rob
>     for pointing out this correct direction.
>   - Since the MSI page has gone, the leak issue doesn't exist anymore,
>     remove unnecessary patches.
>   - Remove dw_pcie_free_msi rename and the last patch. They could be
>     targeted to next. So will send out patches in a separate series.
> 
> Since v1:
>   - add proper error handling patches.
>   - solve the msi page leakage by moving dw_pcie_msi_init() from each
>     users to designware host
> 
> Jisheng Zhang (2):
>   PCI: dwc: Skip PCIE_MSI_INTR0* programming if MSI is disabled
>   PCI: dwc: Fix MSI page leakage in suspend/resume
> 
>  drivers/pci/controller/dwc/pci-dra7xx.c       | 18 +++++++++-
>  .../pci/controller/dwc/pcie-designware-host.c | 35 ++++++++++---------
>  drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
>  3 files changed, 37 insertions(+), 18 deletions(-)

Applied to pci/dwc, thanks.

Lorenzo
