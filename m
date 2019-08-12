Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEB46898C2
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 10:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfHLIfb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 04:35:31 -0400
Received: from foss.arm.com ([217.140.110.172]:45092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfHLIfb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 04:35:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D55815A2;
        Mon, 12 Aug 2019 01:35:30 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0D603F718;
        Mon, 12 Aug 2019 01:35:29 -0700 (PDT)
Date:   Mon, 12 Aug 2019 09:35:28 +0100
From:   Andrew Murray <andrew.murray@arm.com>
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
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: Re: [PATCH 3/4] ARM: dts: ls1021a: Remove num-lanes property from
 PCIe nodes
Message-ID: <20190812083527.GU56241@e119886-lin.cambridge.arm.com>
References: <20190812042435.25102-1-Zhiqiang.Hou@nxp.com>
 <20190812042435.25102-4-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812042435.25102-4-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 12, 2019 at 04:22:27AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> On FSL Layerscape SoCs, the number of lanes assigned to PCIe
> controller is not fixed, it is determined by the selected
> SerDes protocol in the RCW (Reset Configuration Word), and
> the PCIe link training is completed automatically base on
> the selected SerDes protocol, and the link width set-up is
> updated by hardware. So the num-lanes is not needed to
> specify the link width.
> 
> The current num-lanes indicates the max lanes PCIe controller
> can support up to, instead of the lanes assigned to the PCIe
> controller. This can result in PCIe link training fail after
> hot-reset. So remove the num-lanes to avoid set-up to incorrect
> link width.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index 464df4290ffc..2f6977ada447 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -874,7 +874,6 @@
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> -			num-lanes = <4>;
>  			num-viewport = <6>;
>  			bus-range = <0x0 0xff>;
>  			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
> @@ -899,7 +898,6 @@
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> -			num-lanes = <4>;
>  			num-viewport = <6>;
>  			bus-range = <0x0 0xff>;
>  			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> -- 
> 2.17.1
> 
