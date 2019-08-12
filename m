Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99128898EC
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 10:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfHLIpV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 04:45:21 -0400
Received: from foss.arm.com ([217.140.110.172]:45354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbfHLIpU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 04:45:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E936D15A2;
        Mon, 12 Aug 2019 01:45:19 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 696BF3F718;
        Mon, 12 Aug 2019 01:45:19 -0700 (PDT)
Date:   Mon, 12 Aug 2019 09:45:17 +0100
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
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: Re: [PATCH 1/4] dt-bingings: PCI: Remove the num-lanes from Required
 properties
Message-ID: <20190812084517.GW56241@e119886-lin.cambridge.arm.com>
References: <20190812042435.25102-1-Zhiqiang.Hou@nxp.com>
 <20190812042435.25102-2-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812042435.25102-2-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 12, 2019 at 04:22:16AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The num-lanes is not a mandatory property, e.g. on FSL
> Layerscape SoCs, the PCIe link training is completed
> automatically base on the selected SerDes protocol, it
> doesn't need the num-lanes to set-up the link width.
> 
> It has been added in the Optional properties. This
> patch is to remove it from the Required properties.

For clarity, maybe this paragraph can be reworded to:

"It is previously in both Required and Optional properties,
 let's remove it from the Required properties".

I don't understand why this property is previously in
both required and optional...

It looks like num-lanes was first made optional back in
2015 and removed from the Required section (907fce090253).
But then re-added back into the Required section in 2017
with the adition of bindings for EP mode (b12befecd7de).

Is num-lanes actually required for EP mode?

Thanks,

Andrew Murray

> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> index 5561a1c060d0..bd880df39a79 100644
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> @@ -11,7 +11,6 @@ Required properties:
>  	     the ATU address space.
>      (The old way of getting the configuration address space from "ranges"
>      is deprecated and should be avoided.)
> -- num-lanes: number of lanes to use
>  RC mode:
>  - #address-cells: set to <3>
>  - #size-cells: set to <2>
> -- 
> 2.17.1
> 
