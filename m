Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E360934B810
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 16:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhC0P65 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 11:58:57 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:44668 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhC0P6f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 11:58:35 -0400
Received: by mail-oi1-f182.google.com with SMTP id a8so8860152oic.11;
        Sat, 27 Mar 2021 08:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=5SuxDM5eMFIugBHxooQXY5NCqnrI/pfH9JxMhzhQSys=;
        b=N9kFnbS6gGfP9V0PO1R7dcWCxKlanpS3/k9X+ZXcvWBtg1iEnbsa0s8o6ROndYYPNa
         CCZ37TmPKSRmi8mck7AzVHOwEAXLLYN6yDv4wubqxNvJsiiH20x8GfZ4gOmGLPyuM0gI
         Vw8LSQQ+6QqUplIWEoyOiXjLMeBHMzAAcLQOYi7HMtdoJyaaMccxKd+zWl4VUe/2NGea
         gg062Q6ZnbTt/fEHjUHCVMYSRWR8reHvP3LxQ9JZBPE0bLR39v7mY+u6ryjkOxLZwhdp
         ZAXamwxgglDTTQK4X9cfSOcYddv/ahxEBQgXfDrQjOCkP6RQf8Zk6X/veKqcmIvZt/N/
         /rxg==
X-Gm-Message-State: AOAM5308YiO4MzsVBrRFjnk7gg8TeWLZNRFLrV9V460rYStXFgb94JVC
        G/9p+3RQZwMn0OMKsahgWA==
X-Google-Smtp-Source: ABdhPJxLhrLhjniQGWIDx5mRjBUcw0OCSLrNYwJ4ofUnvan/uVGVBDySVtY2LfcLMGrmxSINDeakSA==
X-Received: by 2002:aca:d514:: with SMTP id m20mr13540852oig.47.1616860715194;
        Sat, 27 Mar 2021 08:58:35 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.177])
        by smtp.gmail.com with ESMTPSA id o6sm3059852otj.81.2021.03.27.08.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 08:58:34 -0700 (PDT)
Received: (nullmailer pid 157291 invoked by uid 1000);
        Sat, 27 Mar 2021 15:58:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        james.quinlan@broadcom.com, linux-kernel@vger.kernel.org
In-Reply-To: <20210326191906.43567-2-jim2101024@gmail.com>
References: <20210326191906.43567-1-jim2101024@gmail.com> <20210326191906.43567-2-jim2101024@gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add bindings for Brcmstb EP voltage regulators
Date:   Sat, 27 Mar 2021 09:58:29 -0600
Message-Id: <1616860709.150621.157290.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 26 Mar 2021 15:18:59 -0400, Jim Quinlan wrote:
> Similar to the regulator bindings found in "rockchip-pcie-host.txt", this
> allows optional regulators to be attached and controlled by the PCIe RC
> driver.  That being said, this driver searches in the DT subnode (the EP
> node, eg pci@0,0) for the regulator property.
> 
> The use of a regulator property in the pcie EP subnode such as
> "vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
> file at
> 
> https://github.com/devicetree-org/dt-schema/pull/54
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/pci/brcm,stb-pcie.example.dts:48.48-49 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:349: Documentation/devicetree/bindings/pci/brcm,stb-pcie.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1380: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1458942

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

