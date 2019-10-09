Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F87D0B99
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2019 11:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfJIJoU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 05:44:20 -0400
Received: from foss.arm.com ([217.140.110.172]:58252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbfJIJoU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Oct 2019 05:44:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B74C628;
        Wed,  9 Oct 2019 02:44:19 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B0F13F68E;
        Wed,  9 Oct 2019 02:44:19 -0700 (PDT)
Date:   Wed, 9 Oct 2019 10:44:17 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     Zhiqiang.Hou@nxp.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, Minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Add the Mobiveil EP and Layerscape Gen4 EP driver
 support
Message-ID: <20191009094416.GO42880@e119886-lin.cambridge.arm.com>
References: <20190916021742.22844-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916021742.22844-1-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 16, 2019 at 10:17:36AM +0800, Xiaowei Bao wrote:
> This patch set are for adding Mobiveil EP driver and adding PCIe Gen4
> EP driver of NXP Layerscape platform.
> 
> This patch set depends on:
> https://patchwork.kernel.org/project/linux-pci/list/?series=159139
> 

I've not had any feedback on this earlier series (in your link), I was
planning to review *this* patchset after that.

Thanks,

Andrew Murray

> Xiaowei Bao (6):
>   PCI: mobiveil: Add the EP driver support
>   dt-bindings: Add DT binding for PCIE GEN4 EP of the layerscape
>   PCI: mobiveil: Add PCIe Gen4 EP driver for NXP Layerscape SoCs
>   PCI: mobiveil: Add workaround for unsupported request error
>   arm64: dts: lx2160a: Add PCIe EP node
>   misc: pci_endpoint_test: Add the layerscape PCIe GEN4 EP device
>     support
> 
>  .../bindings/pci/layerscape-pcie-gen4.txt          |  28 +-
>  MAINTAINERS                                        |   3 +
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |  56 ++
>  drivers/misc/pci_endpoint_test.c                   |   2 +
>  drivers/pci/controller/mobiveil/Kconfig            |  22 +-
>  drivers/pci/controller/mobiveil/Makefile           |   2 +
>  .../controller/mobiveil/pcie-layerscape-gen4-ep.c  | 169 ++++++
>  drivers/pci/controller/mobiveil/pcie-mobiveil-ep.c | 568 +++++++++++++++++++++
>  drivers/pci/controller/mobiveil/pcie-mobiveil.c    |  99 +++-
>  drivers/pci/controller/mobiveil/pcie-mobiveil.h    |  72 +++
>  10 files changed, 1009 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c
>  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-ep.c
> 
> -- 
> 2.9.5
> 
