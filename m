Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017AC2D3714
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 00:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgLHXpV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 18:45:21 -0500
Received: from mail-oo1-f68.google.com ([209.85.161.68]:43277 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgLHXpV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 18:45:21 -0500
Received: by mail-oo1-f68.google.com with SMTP id h10so27296ooi.10;
        Tue, 08 Dec 2020 15:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2KQe3ieI4VGx3q64G5WEEcvcuIvQWP0JOsj4euuGCD4=;
        b=OrX9GHZvCfHAknB9P2X54ECdmKgSGpFoTcORlCVnCS23nW4ulRdLJgNSKmKAPCF6Or
         5v5fZaoWNGKtKQIemtgLsSVm1qZ+ikbWtNIaehq+j9n+06cBg60J2cnBGV/kWZfhEx/L
         bYzI6R+RU/gxho/Y0ulweO8L7dMYt3+WZB74NqNZjI8+YLhg/7UxEnbcusLXGHoaCsZp
         hTrWo94vNTBItCLC4B0YqBLKn5aeGE0IgRDzUF56f4piBWWvj7BwyGuU5VQBw2t3Wyuy
         JsFjOF0xeC2+zFk7yxYZudwq6m2eG1Jb0KghqeQziv/8Zm4CSxr+5BP2j8PUB5E9Kyyh
         dd+g==
X-Gm-Message-State: AOAM531zIxo6IxMD6HGYh9d4/MblUTrEWZpmF+H0iI5qkGKravAF+F+r
        Vikj5mnbeA1UiYmgnI+XQy+OdKqGYw==
X-Google-Smtp-Source: ABdhPJyAVXhvxZdVU1wfFlHBFF7RuBp3jz769lshkAFJpz5/IO3/3ARnwahnkYM01JE3/w3Me5Gluw==
X-Received: by 2002:a4a:8606:: with SMTP id v6mr367244ooh.37.1607471080259;
        Tue, 08 Dec 2020 15:44:40 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y35sm81148otb.5.2020.12.08.15.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 15:44:39 -0800 (PST)
Received: (nullmailer pid 3339100 invoked by uid 1000);
        Tue, 08 Dec 2020 23:44:37 -0000
Date:   Tue, 8 Dec 2020 17:44:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2 1/2] dt-bindings: PCI: brcmstb: add BCM4908 binding
Message-ID: <20201208234437.GA3334335@robh.at.kernel.org>
References: <20201130083223.32594-1-zajec5@gmail.com>
 <20201130083223.32594-2-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201130083223.32594-2-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 30, 2020 at 09:32:22AM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> BCM4908 is a SoC family with PCIe controller sharing design with the one
> for STB. BCM4908 has different power management and memory controller so
> few tweaks are required.
> 
> PERST# signal on BCM4908 is handled by an external MISC block so it
> needs specifying a reset phandle.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/pci/brcm,stb-pcie.yaml           | 30 +++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index 807694b4f41f..d3ab9e22f97c 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -14,6 +14,7 @@ properties:
>      items:
>        - enum:
>            - brcm,bcm2711-pcie # The Raspberry Pi 4
> +          - brcm,bcm4908-pcie
>            - brcm,bcm7211-pcie # Broadcom STB version of RPi4
>            - brcm,bcm7278-pcie # Broadcom 7278 Arm
>            - brcm,bcm7216-pcie # Broadcom 7216 Arm
> @@ -64,8 +65,6 @@ properties:
>    aspm-no-l0s: true
>  
>    resets:
> -    description: for "brcm,bcm7216-pcie", must be a valid reset
> -      phandle pointing to the RESCAL reset controller provider node.
>      $ref: "/schemas/types.yaml#/definitions/phandle"

This should really just be 'maxItems: 1'. 'resets' already has a type.

>  
>    reset-names:
> @@ -98,12 +97,39 @@ required:
>  
>  allOf:
>    - $ref: /schemas/pci/pci-bus.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: brcm,bcm4908-pcie
> +    then:
> +      properties:
> +        resets:
> +          items:
> +            - description: reset controller handling the PERST# signal
> +
> +        reset-names:
> +          items:
> +            - const: perst
> +
> +      required:
> +        - resets
> +        - reset-names
>    - if:
>        properties:
>          compatible:
>            contains:
>              const: brcm,bcm7216-pcie
>      then:
> +      properties:
> +        resets:
> +          items:
> +            - description: phandle pointing to the RESCAL reset controller
> +
> +        reset-names:
> +          items:
> +            - const: rescal
> +
>        required:
>          - resets
>          - reset-names
> -- 
> 2.26.2
> 
