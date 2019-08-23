Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7BED9ADDD
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2019 13:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfHWLHe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Aug 2019 07:07:34 -0400
Received: from foss.arm.com ([217.140.110.172]:60306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfHWLHd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Aug 2019 07:07:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8065337;
        Fri, 23 Aug 2019 04:07:32 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 417653F246;
        Fri, 23 Aug 2019 04:07:31 -0700 (PDT)
Date:   Fri, 23 Aug 2019 12:07:22 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: Re: [PATCHv2 0/4] Layerscape: Remove num-lanes property from PCIe
 nodes
Message-ID: <20190823110714.GA10257@e121166-lin.cambridge.arm.com>
References: <20190820073022.24217-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820073022.24217-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 20, 2019 at 07:28:37AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> On FSL Layerscape SoCs, the number of lanes assigned to PCIe
> controller is not fixed, it is determined by the selected
> SerDes protocol. The current num-lanes indicates the max lanes
> PCIe controller can support up to, instead of the lanes assigned
> to the PCIe controller. This can result in PCIe link training fail
> after hot-reset.
> 
> Hou Zhiqiang (4):
>   dt-bindings: PCI: designware: Remove the num-lanes from Required
>     properties
>   PCI: dwc: Return directly when num-lanes is not found
>   ARM: dts: ls1021a: Remove num-lanes property from PCIe nodes
>   arm64: dts: fsl: Remove num-lanes property from PCIe nodes
> 
>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 1 -
>  arch/arm/boot/dts/ls1021a.dtsi                            | 2 --
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi            | 1 -
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi            | 3 ---
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi            | 6 ------
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi            | 3 ---
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi            | 4 ----
>  drivers/pci/controller/dwc/pcie-designware.c              | 6 ++++--
>  8 files changed, 4 insertions(+), 22 deletions(-)

Applied to pci/dwc for v5.4, thanks.

Lorenzo
