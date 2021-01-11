Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CAC2F22EB
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jan 2021 23:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390354AbhAKWif (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jan 2021 17:38:35 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:42425 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389720AbhAKWie (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jan 2021 17:38:34 -0500
Received: by mail-ot1-f44.google.com with SMTP id x5so116705otp.9;
        Mon, 11 Jan 2021 14:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fLMj84hkUp5+4mSadplRSQZF7rQJLNm76i5JIfHTAL8=;
        b=i64VkvcIZQKROOie31EaeSBSMkw83z6POeGNxNbo2lfAoW7HhiyPtqG9k8C2T9qC5M
         DtOPSlHwi5Obdp9fVyHzagnh9kuz516MYVnxSnYpcNbG3GHfafW121hKI5iXv9HwCh3t
         7dseXeuEXpjMIH+6r72TpY/5hB8m4Yz6hU9rvOBlUlrDd7nkU3cESGeYJSRQbOvVkl6X
         wC5Kx3lgt3pKFL9upaY4o5biQbwuTh3iNeKIz2Zr4BNYxn4KV70pK4n+UTNNgMXAWCz3
         nQ9IBEh6foCV0fVYs+cOMGQh0/H9RY8fD+kjbYdjhp8ZECOVkpd89qpJ1jk8ewplTLOu
         k/lg==
X-Gm-Message-State: AOAM532rHX3rCRd6IfuOSSbiYylxNJ3/L5gQTNsmBstBwI0OeJzn0ewO
        N9xtS0JiO23RkgKbBcXoNg==
X-Google-Smtp-Source: ABdhPJx9xq6P6glabPHmo4SavGc3OTfs/lhS2g2fLFMmAgMDmpH6KWLvkZWD/hqD8l6UME/txyE6zA==
X-Received: by 2002:a05:6830:2397:: with SMTP id l23mr841766ots.357.1610404672925;
        Mon, 11 Jan 2021 14:37:52 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e10sm236515otr.73.2021.01.11.14.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 14:37:51 -0800 (PST)
Received: (nullmailer pid 3185487 invoked by uid 1000);
        Mon, 11 Jan 2021 22:37:50 -0000
Date:   Mon, 11 Jan 2021 16:37:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nadeem Athani <nadeem@cadence.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] dt-bindings: pci: ti,j721e: Add host mode
 dt-bindings for TI's AM64 SoC
Message-ID: <20210111223750.GA3177728@robh.at.kernel.org>
References: <20210104124103.30930-1-kishon@ti.com>
 <20210104124103.30930-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104124103.30930-3-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 04, 2021 at 06:11:01PM +0530, Kishon Vijay Abraham I wrote:
> Add host mode dt-bindings for TI's AM64 SoC. This is the same IP used in
> J7200, however AM64 is a non-coherent architecture.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/pci/ti,j721e-pci-host.yaml     | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> index 7607018a115b..77118dba415e 100644
> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> @@ -16,12 +16,17 @@ allOf:
>  properties:
>    compatible:
>      oneOf:
> -      - description: PCIe controller in J7200
> +      - const: ti,am64-pcie-host

No, either you have fallback or you don't. 

> +      - const: ti,j7200-pcie-host
> +      - const: ti,j721e-pcie-host
> +      - description: PCIe controller in AM64
>          items:
> +          - const: ti,am64-pcie-host
>            - const: ti,j7200-pcie-host
>            - const: ti,j721e-pcie-host

2 fallbacks is probably not too useful. Do those really enable 
anything?

> -      - description: PCIe controller in J721E
> +      - description: PCIe controller in J7200
>          items:
> +          - const: ti,j7200-pcie-host
>            - const: ti,j721e-pcie-host
>  
>    reg:
> @@ -87,7 +92,6 @@ required:
>    - vendor-id
>    - device-id
>    - msi-map
> -  - dma-coherent
>    - dma-ranges
>    - ranges
>    - reset-gpios
> -- 
> 2.17.1
> 
