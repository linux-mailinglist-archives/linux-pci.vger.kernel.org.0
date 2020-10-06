Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6758B2853D4
	for <lists+linux-pci@lfdr.de>; Tue,  6 Oct 2020 23:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgJFVZF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Oct 2020 17:25:05 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38057 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbgJFVZF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Oct 2020 17:25:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id 26so143105ois.5;
        Tue, 06 Oct 2020 14:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JO35QNksNafPiPoNfhfKmz+mcxZsJcR4pz+973C07jU=;
        b=tVkFCq2tIYQnBUSHyTQDZgT1skOAOM8Hsnp6Gz2f/T0ZJ96noVB0j640pljKeTz4i2
         Ix0SFWvlRPN8Mnrbh0WFdZ6nmDgic/4vjWJIczuSWo4PLnT9riMOQ2rfGcpbRO+lNT/N
         EEyE0TRTzK0Tn0MgkPDDOk52I8Ot8HrOGcWWOeZfv0BlRpOCs/jLU6HZdUdNyf+yf2GI
         dEEO9O4ez5funG8w5gdg8jqGUEDLbOrT66sVwYTjJm87QjwFshrG/iUt5+YjchZnRrbo
         i4yMEC80CgOZZkVx5AkYe0hDVN6qk4HEhahL07BfWlqsZyTScfogqlcN9tufcC759e31
         gi3A==
X-Gm-Message-State: AOAM531KjCCTcFs2M1JIjzFFbXNDiLJQyvc3h+WTdGUhU8PpJTPfpjpA
        fzwlRAr1bVI53D7EJfX7Nw==
X-Google-Smtp-Source: ABdhPJw6XhxTki8ItSMT1HhgO9hq9gFvJXenFx4JV6TiJEboAUdoHRidMc/5Q6HFS1gfcwLpOzejJg==
X-Received: by 2002:aca:2b02:: with SMTP id i2mr153953oik.108.1602019503921;
        Tue, 06 Oct 2020 14:25:03 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z25sm137745ood.21.2020.10.06.14.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 14:25:03 -0700 (PDT)
Received: (nullmailer pid 2870551 invoked by uid 1000);
        Tue, 06 Oct 2020 21:25:02 -0000
Date:   Tue, 6 Oct 2020 16:25:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [RFC PATCH 2/3] dt-bindings: gpio: Add binding documentation for
 Etron EJ168/EJ188/EJ198
Message-ID: <20201006212502.GA2866970@bogus>
References: <20201004162908.3216898-1-martin.blumenstingl@googlemail.com>
 <20201004162908.3216898-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201004162908.3216898-3-martin.blumenstingl@googlemail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 04, 2020 at 06:29:07PM +0200, Martin Blumenstingl wrote:
> Etron EJ168/EJ188/EJ198 are USB xHCI host controllers which embed a GPIO
> controller.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/gpio/etron,ej1x8.yaml | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/etron,ej1x8.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/etron,ej1x8.yaml b/Documentation/devicetree/bindings/gpio/etron,ej1x8.yaml
> new file mode 100644
> index 000000000000..fa554045bdb5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/etron,ej1x8.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/etron,ej1x8.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GPIO controller embedded into the EJ168/EJ188/EJ198 xHCI controllers
> +
> +maintainers:
> +  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - pci1b6f,7023
> +      - pci1b6f,7052
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  gpio-controller: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#gpio-cells"
> +  - gpio-controller
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +      pcie {
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        gpio@0,0,0 {
> +          compatible = "pci1b6f,7023";
> +          reg = <0x0 0x0 0x0 0x0 0x1000>;
> +          gpio-controller;
> +          #gpio-cells = <2>;
> +        };

How would this look if you needed to describe the XHCI controller? 
That's another PCI function?

> +      };
> +
> +...
> -- 
> 2.28.0
> 
