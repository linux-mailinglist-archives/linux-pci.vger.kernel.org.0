Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2444E2A840E
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 17:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgKEQzB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 11:55:01 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38187 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKEQzB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 11:55:01 -0500
Received: by mail-oi1-f193.google.com with SMTP id 9so2357462oir.5;
        Thu, 05 Nov 2020 08:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kvokp8rQXVJMhuEPOhp84I5XobCRnIaSydMD9+CEqWw=;
        b=VcrXSsIste4ChiYLq8uakrzq1dMYQShCscfiX+8Aqk27S6M/6M7pvHe2YBCF0tVSrA
         TE+tpzJRnbaPxFe1r3NlsydsQPvHmNvXzhrsZMojbqinoZNHajAxGDlNeQ795FyH2KKT
         9PoFUSIIqpr53BH60wIecK7LBWdduslNQmrPTGEnz0y9feNKWuwkH5YYYwO6g56/Wk1G
         4cmvhZ3Bh/yxUd1QqjJP5NMH4buGhg/HauwYrZUUVIwwfXGKl55i4ktk3ev6ULFwojxU
         tiG2CQWq9JwHxgrlnhTMpO82eOtGH2rT7zNJpNAzkz4LWBVU1V6H8fjZ7AroMfwMDoI0
         gLbg==
X-Gm-Message-State: AOAM530B0o6F/ikzGSGiu1Noh0VM40VPDBtUhODJcpkX3ZjmX2eppLzE
        Qg7jo1N2yqah4Hb94MX77llaRD0u+A==
X-Google-Smtp-Source: ABdhPJydMCdD3tDoknObvDMGWund5FuBY4ItTIDsJLO3mM1xvSFsELeIGyD1lnTjLO3So45xg+QvQw==
X-Received: by 2002:a05:6808:1c4:: with SMTP id x4mr191777oic.91.1604595300641;
        Thu, 05 Nov 2020 08:55:00 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m29sm427680otj.42.2020.11.05.08.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:55:00 -0800 (PST)
Received: (nullmailer pid 1472519 invoked by uid 1000);
        Thu, 05 Nov 2020 16:54:59 -0000
Date:   Thu, 5 Nov 2020 10:54:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Roger Quadros <rogerq@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/8] dt-bindings: mfd: ti,j721e-system-controller.yaml:
 Document "pcie-ctrl"
Message-ID: <20201105165459.GB55814@bogus>
References: <20201102101154.13598-1-kishon@ti.com>
 <20201102101154.13598-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102101154.13598-2-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 02, 2020 at 03:41:47PM +0530, Kishon Vijay Abraham I wrote:
> Add binding documentation for "pcie-ctrl" which should be a subnode of
> the system controller.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/mfd/ti,j721e-system-controller.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> index 19fcf59fd2fe..fd985794e419 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> @@ -50,6 +50,12 @@ patternProperties:
>        specified in
>        Documentation/devicetree/bindings/mux/reg-mux.txt
>  
> +  "^pcie-ctrl@[0-9a-f]+$":

Unit address, so it should have 'reg' too?

You don't need a node if there aren't any properties.

> +    type: object
> +    description: |
> +      This is the PCIe controller configuration required to configre PCIe
> +      mode, lane width and speed.
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.17.1
> 
