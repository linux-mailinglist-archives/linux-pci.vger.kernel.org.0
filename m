Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF143CEF0E
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 00:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354002AbhGSVYj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 17:24:39 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:44599 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379206AbhGSUkc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jul 2021 16:40:32 -0400
Received: by mail-io1-f42.google.com with SMTP id v26so21673975iom.11;
        Mon, 19 Jul 2021 14:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=raiog5253SxE12vV+UiSQQkE0yT8nRcpaRkSvQgu3/E=;
        b=DD5Kpp1gJ4kZNS+WolU0H3OTEUG8GRv60E+VzDb88aKBqP3nhAJi5DielBB4cfyEOD
         LmB5UUeVwdCaImDUpiP1FJC9z3jHIvELAzj6NtTjR1ounGlCh9h2xb0KsPGCEzUA2cDv
         xT6w6v+AmYjerNCVv2MKEpmHfZUdKI4omphOicHnLcnhq8J1BakH14RhyvLtn9Y4IVjW
         cdeMp0AcPMQiAcjM3Ovb1djYdQX80/1pcr7BOw6w5odZfIb5JmmO/Qi4UcgDAZMphxc3
         rRMOs5fMfJl9BN4Kn0tTxaKj1B9umsXfKUWOkqBBBBK2lkrn6zkj42oN51oBACdkqCl+
         VGQw==
X-Gm-Message-State: AOAM532pFjGQrXAMMJoOnPocr3lIN1p7uw4ykAGyBJApDmsRlPdFuKEm
        FRCOtDiY3rckkILWFXSeBQ==
X-Google-Smtp-Source: ABdhPJzHuJUA6pU6N8cr1hA0Fn0T//P5iRFY26E2QLesik1UmyP26LtnrN8vxpgaG2usj0ayO3B25w==
X-Received: by 2002:a05:6638:538:: with SMTP id j24mr14151107jar.59.1626729601504;
        Mon, 19 Jul 2021 14:20:01 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k13sm9821416ilv.18.2021.07.19.14.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 14:20:00 -0700 (PDT)
Received: (nullmailer pid 2572362 invoked by uid 1000);
        Mon, 19 Jul 2021 21:19:58 -0000
Date:   Mon, 19 Jul 2021 15:19:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Bjorn Helgaas <bhelgaas@google.com>, JC Kuo <jckuo@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v5 5/5] dt-bindings: arm64: tegra: fix pcie-ep DT nodes
Message-ID: <20210719211958.GA2571127@robh.at.kernel.org>
References: <cover.1626608375.git.mchehab+huawei@kernel.org>
 <15cf5067c0567614d5b186d006ebd88395d56b63.1626608375.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15cf5067c0567614d5b186d006ebd88395d56b63.1626608375.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jul 18, 2021 at 01:40:52PM +0200, Mauro Carvalho Chehab wrote:
> As defined by Documentation/devicetree/bindings/pci/pci-ep.yaml,
> PCIe endpoints match this pattern:
> 
> 	properties:
> 	  $nodename:
> 	    pattern: "^pcie-ep@"
> 
> Change the existing ones in order to avoid those warnings:
> 
> 	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0001.dt.yaml: pcie_ep@14160000: $nodename:0: 'pcie_ep@14160000' does not match '^pcie-ep@'
> 		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> 	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0001.dt.yaml: pcie_ep@14180000: $nodename:0: 'pcie_ep@14180000' does not match '^pcie-ep@'
> 		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> 	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0001.dt.yaml: pcie_ep@141a0000: $nodename:0: 'pcie_ep@141a0000' does not match '^pcie-ep@'
> 		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> 	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dt.yaml: pcie_ep@14160000: $nodename:0: 'pcie_ep@14160000' does not match '^pcie-ep@'
> 		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> 	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dt.yaml: pcie_ep@14180000: $nodename:0: 'pcie_ep@14180000' does not match '^pcie-ep@'
> 		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> 	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dt.yaml: pcie_ep@141a0000: $nodename:0: 'pcie_ep@141a0000' does not match '^pcie-ep@'
> 		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> 	arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dt.yaml: pcie_ep@14160000: $nodename:0: 'pcie_ep@14160000' does not match '^pcie-ep@'
> 		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> 	arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dt.yaml: pcie_ep@14180000: $nodename:0: 'pcie_ep@14180000' does not match '^pcie-ep@'
> 		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> 	arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dt.yaml: pcie_ep@141a0000: $nodename:0: 'pcie_ep@141a0000' does not match '^pcie-ep@'
> 		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../devicetree/bindings/pci/nvidia,tegra194-pcie.txt        | 2 +-
>  arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts          | 2 +-
>  arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi         | 2 +-
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi                    | 6 +++---
>  4 files changed, 6 insertions(+), 6 deletions(-)

The Tegra maintainers should apply this one.

Acked-by: Rob Herring <robh@kernel.org>
