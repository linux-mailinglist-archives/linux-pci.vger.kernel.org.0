Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D547B474DC9
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 23:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhLNWQJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Dec 2021 17:16:09 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:37531 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbhLNWQI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Dec 2021 17:16:08 -0500
Received: by mail-ot1-f46.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so22519684otg.4;
        Tue, 14 Dec 2021 14:16:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SX/9YrUtplncL5wWQZap08LTDJOW0Q9uZQc36gCy2Uw=;
        b=jKYiF0WsPh4QiR4ZH+0M2Y064HsNRLe3ND/OFH4IjDkwo+CrECniDoJH4rcy/r6tM7
         B27AfDwc6wnCNQd0DBg2Rp0iDhfJRMqhJQQBCKKt7RucM5j8D30S37q2cXRJt0cWa97X
         v/8AjZQyxJip5//SzTzEobX+nqHPDPiyODwWzBukn+uw4cw7CYafVXn2cyvvN8Cezq7G
         vENGouD67nkPFFnqUVAb57lZIH9gBmBR7nkqwrZD96VZlWsHOBR+qBTFIKONRwaBFx8O
         ZmTyG+crN+Dq/UBda2j0pmDNueu5m3iKuJCmfnRodKliPR21WW2/xLv8Kn4iHH54vQh/
         sM7g==
X-Gm-Message-State: AOAM532Ay0Zr8jkUeMWDd0cZTyrOeAz+qdBe+Q37edwbghtpJk2xnYIu
        mSWKW8OHehg8KVGicDBIGQ==
X-Google-Smtp-Source: ABdhPJzbjxO0Xl93R1cCScNoNZllcabCBzDCPy+fKLXaQ6Ybf6LBpMdoCbxJyE/cwv4O1OzllFTbIg==
X-Received: by 2002:a05:6830:442a:: with SMTP id q42mr6534523otv.385.1639520167393;
        Tue, 14 Dec 2021 14:16:07 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 109sm16294otv.30.2021.12.14.14.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 14:16:06 -0800 (PST)
Received: (nullmailer pid 4052260 invoked by uid 1000);
        Tue, 14 Dec 2021 22:16:05 -0000
Date:   Tue, 14 Dec 2021 16:16:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] dt-bindings: PCI: Fix 'unevaluatedProperties' warnings
Message-ID: <YbkXpXFFPjmRmpXk@robh.at.kernel.org>
References: <20211206194406.2469361-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206194406.2469361-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 06 Dec 2021 13:44:05 -0600, Rob Herring wrote:
> With 'unevaluatedProperties' support implemented, there's several
> warnings due to undocumented properties:
> 
> Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.example.dt.yaml: pcie@1e140000: pcie@0,0: Unevaluated properties are not allowed ('phy-names' was unexpected)
> Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.example.dt.yaml: pcie@1e140000: pcie@1,0: Unevaluated properties are not allowed ('phy-names' was unexpected)
> Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.example.dt.yaml: pcie@1e140000: pcie@2,0: Unevaluated properties are not allowed ('phy-names' was unexpected)
> Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.example.dt.yaml: pcie@11230000: Unevaluated properties are not allowed ('phy-names' was unexpected)
> Documentation/devicetree/bindings/pci/microchip,pcie-host.example.dt.yaml: pcie@2030000000: Unevaluated properties are not allowed ('interrupt-controller' was unexpected)
> Documentation/devicetree/bindings/pci/ti,am65-pci-ep.example.dt.yaml: pcie-ep@5500000: Unevaluated properties are not allowed ('num-ib-windows', 'num-ob-windows' were unexpected)
> Documentation/devicetree/bindings/pci/ti,am65-pci-host.example.dt.yaml: pcie@5500000: Unevaluated properties are not allowed ('num-viewport', 'interrupts' were unexpected)
> Documentation/devicetree/bindings/pci/ti,j721e-pci-host.example.dt.yaml: pcie@2900000: Unevaluated properties are not allowed ('dma-coherent' was unexpected)
> 
> Add the necessary property definitions or remove the properties from the
> examples to fix these warnings.
> 
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Jianjun Wang <jianjun.wang@mediatek.com>
> Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Daire McNamara <daire.mcnamara@microchip.com>
> Cc: Abraham I <kishon@ti.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/pci/mediatek,mt7621-pcie.yaml     |  3 +++
>  .../bindings/pci/mediatek-pcie-gen3.yaml       |  4 ++++
>  .../bindings/pci/microchip,pcie-host.yaml      | 18 ++++++++++++++++++
>  .../bindings/pci/ti,am65-pci-ep.yaml           |  2 --
>  .../bindings/pci/ti,am65-pci-host.yaml         |  4 +++-
>  .../bindings/pci/ti,j721e-pci-host.yaml        |  2 ++
>  6 files changed, 30 insertions(+), 3 deletions(-)
> 

Applied, thanks!
