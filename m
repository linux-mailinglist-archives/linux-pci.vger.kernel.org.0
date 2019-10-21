Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73DD1DEF22
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 16:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfJUOQF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 10:16:05 -0400
Received: from [217.140.110.172] ([217.140.110.172]:53870 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1728551AbfJUOQF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 10:16:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71E1E1007;
        Mon, 21 Oct 2019 07:15:44 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A115B3F71F;
        Mon, 21 Oct 2019 07:15:43 -0700 (PDT)
Date:   Mon, 21 Oct 2019 15:15:41 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Anvesh Salveru <anvesh.s@samsung.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: designware: Add binding for ZRX-DC
 PHY property
Message-ID: <20191021141541.GS47056@e119886-lin.cambridge.arm.com>
References: <CGME20191021122630epcas5p32bd92762c4304035cad5c1822d96e304@epcas5p3.samsung.com>
 <1571660755-30270-1-git-send-email-anvesh.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571660755-30270-1-git-send-email-anvesh.s@samsung.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 21, 2019 at 05:55:55PM +0530, Anvesh Salveru wrote:
> Add support for ZRX-DC compliant PHYs. If PHY is not compliant to ZRX-DC
> specification, then after every 100ms link should transition to recovery
> state during the low power states which increases power consumption.
> 
> Platforms with ZRX-DC compliant PHY can use "snps,phy-zrxdc-compliant"
> property in DesignWare controller DT node.
> 
> Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> index 78494c4050f7..9507ac38ac89 100644
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> @@ -38,6 +38,8 @@ Optional properties:
>     for data corruption. CDM registers include standard PCIe configuration
>     space registers, Port Logic registers, DMA and iATU (internal Address
>     Translation Unit) registers.
> +- snps,phy-zrxdc-compliant: This property is needed if phy complies with the

Strictly speaking, this is a property of the phy - not the controller that
uses it.

If I understand correctly, there are some DW based PCI controllers that use
a phandle reference in DT to a Phy (such as fsl,imx6q-pcie.txt). Therefore
it feels like this is in the wrong place. Is there a reason this isn't
described in the Phy?

Thanks,

Andrew Murray

> +  ZRX-DC specification.
>  RC mode:
>  - num-viewport: number of view ports configured in hardware. If a platform
>    does not specify it, the driver assumes 2.
> -- 
> 2.17.1
> 
