Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDBF474DD1
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 23:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhLNWQr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Dec 2021 17:16:47 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:34589 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhLNWQr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Dec 2021 17:16:47 -0500
Received: by mail-oi1-f169.google.com with SMTP id t19so29140811oij.1;
        Tue, 14 Dec 2021 14:16:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/P7WdlopaK3BJckMeyOdCZ27ARBVlWa5L1sm5URTLic=;
        b=77V5S+OyvnEEsSaVuIftdzxbF8nj0A5jnUX0ZJ/3QsHSSmd4RmQSsb5+LtL7mEEiJg
         Sj4tqNH0zmBpEOGl+qMZQW9YMVR3UfM81MlzgLacKmmlMTz9vIcXrZcwaj8HxehxilL1
         TxbPaGchQ01FVLJmxdz1ERkrCDOmVUp/i56v+pMZOt1gTZtW47PLZTJ5yg5pusoTCYyN
         P+NXU4Qyf5/pDNuxyUssmvwJLil6ZM1uRB1/k8XY7qx9rc2Q9DauULLzEq4YCbYbIoLr
         ySCiccqPKRUOUbzzTYphXjS5ZjBbLridHGjiRrfckKrjYL1mMnML9e3rpyWWzrBOkG4l
         2g+w==
X-Gm-Message-State: AOAM530nitvXX+YMYismfXWgedLwZIOj+VKRS1XZZyLyhxI9uuMprijb
        tZSOCqplRYzZDcHJnRwSWA==
X-Google-Smtp-Source: ABdhPJwW4S9aXKgQmc4ylqmSsIukwflmXezSDLsLGo9bKW6HtV2kspuhgVhb1ZvRlT55hVXDVSM3Kw==
X-Received: by 2002:aca:1b15:: with SMTP id b21mr35225195oib.64.1639520206668;
        Tue, 14 Dec 2021 14:16:46 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g7sm40352oon.27.2021.12.14.14.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 14:16:45 -0800 (PST)
Received: (nullmailer pid 4053556 invoked by uid 1000);
        Tue, 14 Dec 2021 22:16:44 -0000
Date:   Tue, 14 Dec 2021 16:16:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jingoo Han <jingoohan1@gmail.com>, devicetree@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org,
        Xiaowei Song <songxiaowei@hisilicon.com>
Subject: Re: [PATCH] dt-bindings: PCI: designware: Fix
 'unevaluatedProperties' warnings
Message-ID: <YbkXzPqy8gNwKDWR@robh.at.kernel.org>
References: <20211206194426.2470080-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206194426.2470080-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 06 Dec 2021 13:44:25 -0600, Rob Herring wrote:
> With 'unevaluatedProperties' support implemented, there's a number of
> warnings from the Designware PCIe based bindings:
> 
> Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dt.yaml: pcie@1ffc000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'device_type', 'bus-range', 'ranges', '#interrupt-cells', 'interrupt-map-mask', 'interrupt-map' were unexpected)
> Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dt.yaml: pcie@1ffc000: Unevaluated properties are not allowed ('clock-names' was unexpected)
> Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dt.yaml: pcie@f4000000: Unevaluated properties are not allowed ('bus-range', '#address-cells', '#size-cells', 'device_type', 'ranges', 'num-lanes', '#interrupt-cells', 'interrupts', 'interrupt-names', 'interrupt-map-mask', 'interrupt-map', 'clocks', 'clock-names' were unexpected)
> Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dt.yaml: pcie@f4000000: Unevaluated properties are not allowed ('clock-names' was unexpected)
> Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dt.yaml: pcie@f5000000: Unevaluated properties are not allowed ('bus-range', '#address-cells', '#size-cells', 'device_type', 'phys', 'ranges', 'num-lanes', '#interrupt-cells', 'interrupts', 'interrupt-names', 'interrupt-map-mask', 'interrupt-map', 'reset-gpios', 'pcie@0,0' were unexpected)
> Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dt.yaml: pcie@f5000000: Unevaluated properties are not allowed ('phys', 'hisilicon,clken-gpios' were unexpected)
> Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dt.yaml: pcie@d0e00000: Unevaluated properties are not allowed ('device_type', '#address-cells', '#size-cells', 'linux,pci-domain', 'bus-range', '#interrupt-cells', 'interrupt-map-mask', 'interrupt-map' were unexpected)
> Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dt.yaml: pcie@d0e00000: Unevaluated properties are not allowed ('resets', 'phys', 'phy-names', 'reset-assert-ms' were unexpected)
> Documentation/devicetree/bindings/pci/rockchip-dw-pcie.example.dt.yaml: pcie@fe280000: Unevaluated properties are not allowed ('clock-names', 'msi-map', 'phys', 'phy-names', 'power-domains', 'resets', 'reset-names' were unexpected)
> Documentation/devicetree/bindings/pci/samsung,exynos-pcie.example.dt.yaml: pcie@15700000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#interrupt-cells', 'device_type', 'bus-range', 'ranges', 'interrupt-map-mask', 'interrupt-map' were unexpected)
> Documentation/devicetree/bindings/pci/samsung,exynos-pcie.example.dt.yaml: pcie@15700000: Unevaluated properties are not allowed ('clock-names', 'phys', 'vdd10-supply', 'vdd18-supply' were unexpected)
> Documentation/devicetree/bindings/pci/sifive,fu740-pcie.example.dt.yaml: pcie@e00000000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#interrupt-cells', 'device_type', 'dma-coherent', 'bus-range', 'ranges', 'interrupts', 'interrupt-parent', 'interrupt-map-mask', 'interrupt-map', 'clock-names', 'clocks' were unexpected)
> Documentation/devicetree/bindings/pci/sifive,fu740-pcie.example.dt.yaml: pcie@e00000000: Unevaluated properties are not allowed ('dma-coherent', 'clock-names', 'resets', 'pwren-gpios' were unexpected)
> Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.example.dt.yaml: pcie-ep@66000000: Unevaluated properties are not allowed ('clock-names', 'clocks', 'reset-names', 'resets', 'phy-names', 'phys' were unexpected)
> Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.example.dt.yaml: pcie@28400000: Unevaluated properties are not allowed ('clock-names' was unexpected)
> Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.example.dt.yaml: pcie@28400000: Unevaluated properties are not allowed ('device_type', 'bus-range', 'num-viewport', '#address-cells', '#size-cells', '#interrupt-cells', 'ranges', 'interrupt-names', 'interrupt-map-mask', 'interrupt-map', 'max-link-speed' were unexpected)
> 
> The main problem is that snps,dw-pcie.yaml and snps,dw-pcie-ep.yaml
> shouldn't set 'unevaluatedProperties: false'. Otherwise, bindings that
> reference them cannot add additional properties. With that addressed,
> there's a handful of other undocumented properties to add.
> 
> Cc: Xiaowei Song <songxiaowei@hisilicon.com>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Greentime Hu <greentime.hu@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/pci/hisilicon,kirin-pcie.yaml          | 13 +++++++++++++
>  .../devicetree/bindings/pci/sifive,fu740-pcie.yaml  |  4 ++--
>  .../devicetree/bindings/pci/snps,dw-pcie-ep.yaml    |  2 +-
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml       |  2 +-
>  .../bindings/pci/socionext,uniphier-pcie-ep.yaml    |  2 +-
>  5 files changed, 18 insertions(+), 5 deletions(-)
> 

Applied, thanks!
