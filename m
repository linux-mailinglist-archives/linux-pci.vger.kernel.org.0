Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F056264992
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2019 17:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfGJP3C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jul 2019 11:29:02 -0400
Received: from foss.arm.com ([217.140.110.172]:35368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbfGJP3C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jul 2019 11:29:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49FD82B;
        Wed, 10 Jul 2019 08:29:01 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEC113F246;
        Wed, 10 Jul 2019 08:28:58 -0700 (PDT)
Date:   Wed, 10 Jul 2019 16:28:56 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V13 08/12] dt-bindings: Add PCIe supports-clkreq property
Message-ID: <20190710152856.GB8781@e121166-lin.cambridge.arm.com>
References: <20190710062212.1745-1-vidyas@nvidia.com>
 <20190710062212.1745-9-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710062212.1745-9-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 10, 2019 at 11:52:08AM +0530, Vidya Sagar wrote:
> Some host controllers need to know the existence of clkreq signal routing to
> downstream devices to be able to advertise low power features like ASPM L1
> substates. Without clkreq signal routing being present, enabling ASPM L1 sub
> states might lead to downstream devices falling off the bus. Hence a new device

You mean "being disconnected from the bus" right ? I will update it.

Lorenzo

> tree property 'supports-clkreq' is added to make such host controllers
> aware of clkreq signal routing to downstream devices.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> ---
> V13:
> * None
> 
> V12:
> * Rebased on top of linux-next top of the tree
> 
> V11:
> * None
> 
> V10:
> * None
> 
> V9:
> * None
> 
> V8:
> * None
> 
> V7:
> * None
> 
> V6:
> * s/Documentation\/devicetree/dt-bindings/ in the subject
> 
> V5:
> * None
> 
> V4:
> * Rebased on top of linux-next top of the tree
> 
> V3:
> * None
> 
> V2:
> * This is a new patch in v2 series
> 
>  Documentation/devicetree/bindings/pci/pci.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> index 2a5d91024059..29bcbd88f457 100644
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -27,6 +27,11 @@ driver implementation may support the following properties:
>  - reset-gpios:
>     If present this property specifies PERST# GPIO. Host drivers can parse the
>     GPIO and apply fundamental reset to endpoints.
> +- supports-clkreq:
> +   If present this property specifies that CLKREQ signal routing exists from
> +   root port to downstream device and host bridge drivers can do programming
> +   which depends on CLKREQ signal existence. For example, programming root port
> +   not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
>  
>  PCI-PCI Bridge properties
>  -------------------------
> -- 
> 2.17.1
> 
