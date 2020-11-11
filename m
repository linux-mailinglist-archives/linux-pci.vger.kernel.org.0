Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE082AFA50
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 22:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgKKV3B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 16:29:01 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34192 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKV3A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 16:29:00 -0500
Received: by mail-ot1-f67.google.com with SMTP id j14so3577125ots.1;
        Wed, 11 Nov 2020 13:29:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GTqvmPN8FeL5Camvlbygkl55K/SzqW8sO9N4V5KBE+A=;
        b=Qb0QJbOAQOgk8AW7SsdwVYWVV3SQ6r53/gNTHKQ+5dnurBxn7R+Ffyx5zXwUwfWQ57
         IgGjPMSd/1FEvNbv6QYnFSMrn7bCwEkthi73f83Xijr9UoaYQGXbNo4X9rjf/oonZRvg
         6lL8/ASnggkSsQC2pOz8TZ60OPmxP1jZDfgsdAWyI8NoVDij7FBvi6C7zJXwZUzexjoK
         ZyRqYVV6bWnUPDMzr6So9q7dm/iY/vBY1qmL5V2YIt1B0AHAEXUqJUGr6RzSbTrpn8kD
         ZgQVmX1Xiu5KROPorUX8AzOzmO1cv2dhIhncFGr+OspWBfCjZYsNXtRSXnJH3pSoNWpl
         iRJA==
X-Gm-Message-State: AOAM530EvHCH2gSFax3zRSlNdGkLK0W+Bsx4nfw+CSpycQzS/9+p25z6
        Qx8Ud52TMiugQfqWQoy57w==
X-Google-Smtp-Source: ABdhPJzmEghly3TxVwLcQf55ECIcDH9bmjqKX2JH5w1pCq+Kyel1xEtqU9aIPOXaypf0bgXBiMsJ2Q==
X-Received: by 2002:a05:6830:1dd8:: with SMTP id a24mr18387165otj.163.1605130139745;
        Wed, 11 Nov 2020 13:28:59 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v144sm666366oia.21.2020.11.11.13.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 13:28:58 -0800 (PST)
Received: (nullmailer pid 2067102 invoked by uid 1000);
        Wed, 11 Nov 2020 21:28:57 -0000
Date:   Wed, 11 Nov 2020 15:28:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Roger Quadros <rogerq@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: mfd:
 ti,j721e-system-controller.yaml: Document "syscon"
Message-ID: <20201111212857.GA2059063@bogus>
References: <20201109170409.4498-1-kishon@ti.com>
 <20201109170409.4498-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109170409.4498-2-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 09, 2020 at 10:34:03PM +0530, Kishon Vijay Abraham I wrote:
> Add binding documentation for "syscon" which should be a subnode of
> the system controller (scm-conf).
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../mfd/ti,j721e-system-controller.yaml       | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> index 19fcf59fd2fe..0b115b707ab2 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> @@ -50,6 +50,38 @@ patternProperties:
>        specified in
>        Documentation/devicetree/bindings/mux/reg-mux.txt
>  
> +  "^syscon@[0-9a-f]+$":
> +    type: object
> +    description: |

Don't need '|' if there's no formatting.

> +      This is the system controller configuration required to configure PCIe
> +      mode, lane width and speed.
> +
> +    properties:
> +      compatible:
> +        items:
> +          - enum:
> +              - ti,j721e-system-controller
> +          - const: syscon
> +          - const: simple-mfd

Humm, then what are this node's sub-nodes? And the same compatible as 
the parent?

> +
> +      reg:
> +        maxItems: 1
> +
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 1
> +
> +      ranges: true
> +
> +    required:
> +      - compatible
> +      - reg
> +      - "#address-cells"
> +      - "#size-cells"
> +      - ranges
> +
>  required:
>    - compatible
>    - reg
> @@ -72,5 +104,13 @@ examples:
>              compatible = "mmio-mux";
>              reg = <0x00004080 0x50>;
>          };
> +
> +        pcie1_ctrl: syscon@4074 {
> +            compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
> +            reg = <0x00004074 0x4>;
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            ranges = <0x4074 0x4074 0x4>;

Must be packing a bunch of functions into 4 byte region!

> +        };
>      };
>  ...
> -- 
> 2.17.1
> 
