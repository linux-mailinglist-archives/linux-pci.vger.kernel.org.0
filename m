Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3832B8656
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 22:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgKRVLn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 16:11:43 -0500
Received: from mail-oo1-f67.google.com ([209.85.161.67]:33848 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgKRVLm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 16:11:42 -0500
Received: by mail-oo1-f67.google.com with SMTP id q28so809121oof.1;
        Wed, 18 Nov 2020 13:11:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uD5r0mgjx4XJefZojTk2Z0WXY+V/wMDo4YKRMEiDeRo=;
        b=ai8dGM4IEJXeLYTj5uxG78HcCaY3g/mzGYXzmyUE9uwfGykLaWymjACaGlUGK2T9ju
         949XqnEFlrXBfvDZoL31F+ZdeaNMZGzoLDBJbprUl5xQMcPY5fz28+GK3ap9rtK2W0xC
         skSR4mB7Q+iMNo6WDZw5ys9PGIe3WwboRMS8ViQYlrxLybJW+y/Wc0lcn3/zqnbvkRGg
         ypTZiwCkmaZaJYtM3pgeZg5qbSTl5FuXeepeCb8nhNOrAi9d1voLBNNyVSAO84OUv08v
         xCIUtTLD9PYWHSvqRk2o+jcqIqFlRqJn6mLjTjIMLypfiMVZJQBBeptDREzHhfH8lVVz
         xLNw==
X-Gm-Message-State: AOAM5321818luQH4asRKONJC3UPeIa9T5U0aOkm7bJlAyGCfUL6ANEfq
        8CJ8cULqfw1LmnJVrAr/aNpudm6XlA==
X-Google-Smtp-Source: ABdhPJxOzK+MobHEv7bORvgn3Y50ldP9mkw/2MAFt5uWRKavbH8N6hGY5gQPftuWziY/LxDkTP4CQg==
X-Received: by 2002:a05:6820:453:: with SMTP id p19mr7783312oou.28.1605733901532;
        Wed, 18 Nov 2020 13:11:41 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m109sm7852560otc.30.2020.11.18.13.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 13:11:40 -0800 (PST)
Received: (nullmailer pid 1823762 invoked by uid 1000);
        Wed, 18 Nov 2020 21:11:39 -0000
Date:   Wed, 18 Nov 2020 15:11:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: pci: ti,j721e: Fix
 "ti,syscon-pcie-ctrl" to take argument
Message-ID: <20201118211139.GA1815279@bogus>
References: <20201116173141.31873-1-kishon@ti.com>
 <20201116173141.31873-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116173141.31873-2-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 16, 2020 at 11:01:39PM +0530, Kishon Vijay Abraham I wrote:
> Fix binding documentation of "ti,syscon-pcie-ctrl" to take phandle with
> argument. The argument is the register offset within "syscon" used to
> configure PCIe controller.
> 
> Link: Link: http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com

Link: Link: ?

AIUI, 'Link' is supposed to be a link to this patch. I guess more than 1 
Link would be okay though.

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml     | 12 ++++++++----
>  .../devicetree/bindings/pci/ti,j721e-pci-host.yaml   | 12 ++++++++----
>  2 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> index 3ae3e1a2d4b0..e9685c0bdc3e 100644
> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> @@ -29,9 +29,13 @@ properties:
>        - const: mem
>  
>    ti,syscon-pcie-ctrl:
> -    description: Phandle to the SYSCON entry required for configuring PCIe mode
> -                 and link speed.
> -    $ref: /schemas/types.yaml#/definitions/phandle
> +    allOf:

You no longer need allOf here.

> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
> +      - items:
> +          - items:
> +            - description: Phandle to the SYSCON entry
> +            - description: pcie_ctrl register offset within SYSCON
> +    description: Specifier for configuring PCIe mode and link speed.
>  
>    power-domains:
>      maxItems: 1
> @@ -80,7 +84,7 @@ examples:
>                   <0x00 0x0d000000 0x00 0x00800000>,
>                   <0x00 0x10000000 0x00 0x08000000>;
>             reg-names = "intd_cfg", "user_cfg", "reg", "mem";
> -           ti,syscon-pcie-ctrl = <&pcie0_ctrl>;
> +           ti,syscon-pcie-ctrl = <&pcie0_ctrl 0x4070>;
>             max-link-speed = <3>;
>             num-lanes = <2>;
>             power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> index ee7a8eade3f6..a3b82992bcfa 100644
> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> @@ -29,9 +29,13 @@ properties:
>        - const: cfg
>  
>    ti,syscon-pcie-ctrl:
> -    description: Phandle to the SYSCON entry required for configuring PCIe mode
> -      and link speed.
> -    $ref: /schemas/types.yaml#/definitions/phandle
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
> +      - items:
> +          - items:
> +            - description: Phandle to the SYSCON entry
> +            - description: pcie_ctrl register offset within SYSCON
> +    description: Specifier for configuring PCIe mode and link speed.
>  
>    power-domains:
>      maxItems: 1
> @@ -90,7 +94,7 @@ examples:
>                    <0x00 0x0d000000 0x00 0x00800000>,
>                    <0x00 0x10000000 0x00 0x00001000>;
>              reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
> -            ti,syscon-pcie-ctrl = <&pcie0_ctrl>;
> +            ti,syscon-pcie-ctrl = <&pcie0_ctrl 0x4070>;
>              max-link-speed = <3>;
>              num-lanes = <2>;
>              power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
> -- 
> 2.17.1
> 
