Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF07215455
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jul 2020 11:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgGFJEf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 05:04:35 -0400
Received: from foss.arm.com ([217.140.110.172]:49176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728259AbgGFJEf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jul 2020 05:04:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A03DB30E;
        Mon,  6 Jul 2020 02:04:34 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F04CA3F71E;
        Mon,  6 Jul 2020 02:04:33 -0700 (PDT)
Date:   Mon, 6 Jul 2020 10:04:28 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/15] PCI controller probe cleanups
Message-ID: <20200706090428.GA26239@e121166-lin.cambridge.arm.com>
References: <20200522234832.954484-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522234832.954484-1-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 22, 2020 at 05:48:17PM -0600, Rob Herring wrote:
> I started this on my last series of dma-ranges rework and am just 
> getting back to finishing it. This series simplifies the resource list 
> handling in a couple of drivers and converts almost all the remaining 
> drivers to use pci_host_probe().
> 
> The one holdout is Designware. This is due to the .scan_bus() hook 
> which is only used by TI Keystone. I think it could be a fixup instead 
> matching on the root bus id. I'm not sure though. See 
> ks_pcie_v3_65_scan_bus().
> 
> Rob
> 
> 
> Rob Herring (15):
>   PCI: cadence: Use struct pci_host_bridge.windows list directly
>   PCI: mvebu: Use struct pci_host_bridge.windows list directly
>   PCI: host-common: Use struct pci_host_bridge.windows list directly
>   PCI: brcmstb: Use pci_host_probe() to register host
>   PCI: mobiveil: Use pci_host_probe() to register host
>   PCI: tegra: Use pci_host_probe() to register host
>   PCI: v3: Use pci_host_probe() to register host
>   PCI: versatile: Use pci_host_probe() to register host
>   PCI: xgene: Use pci_host_probe() to register host
>   PCI: altera: Use pci_host_probe() to register host
>   PCI: iproc: Use pci_host_probe() to register host
>   PCI: rcar: Use pci_host_probe() to register host
>   PCI: rockchip: Use pci_host_probe() to register host
>   PCI: xilinx-nwl: Use pci_host_probe() to register host
>   PCI: xilinx: Use pci_host_probe() to register host
> 
>  .../controller/cadence/pcie-cadence-host.c    | 26 ++++----------
>  .../controller/mobiveil/pcie-mobiveil-host.c  | 16 +--------
>  drivers/pci/controller/pci-host-common.c      | 36 ++++++-------------
>  drivers/pci/controller/pci-mvebu.c            | 13 +++----
>  drivers/pci/controller/pci-tegra.c            | 11 +-----
>  drivers/pci/controller/pci-v3-semi.c          | 13 +------
>  drivers/pci/controller/pci-versatile.c        | 14 +-------
>  drivers/pci/controller/pci-xgene.c            | 13 +------
>  drivers/pci/controller/pcie-altera.c          | 17 +--------
>  drivers/pci/controller/pcie-brcmstb.c         | 20 +++--------
>  drivers/pci/controller/pcie-iproc.c           | 18 +++-------
>  drivers/pci/controller/pcie-iproc.h           |  2 --
>  drivers/pci/controller/pcie-rcar-host.c       | 18 +---------
>  drivers/pci/controller/pcie-rockchip-host.c   | 18 +++-------
>  drivers/pci/controller/pcie-rockchip.h        |  1 -
>  drivers/pci/controller/pcie-xilinx-nwl.c      | 14 +-------
>  drivers/pci/controller/pcie-xilinx.c          | 13 +------
>  17 files changed, 45 insertions(+), 218 deletions(-)

Applied to pci/misc for v5.9, thanks !

Lorenzo
