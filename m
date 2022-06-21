Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC872553534
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 17:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351521AbiFUPGi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 11:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351237AbiFUPGh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 11:06:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5C227FD5
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 08:06:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id g8so12797859plt.8
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 08:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UK5eErzZtKg/HvO01KKCBb0udTzOZqxbnH2ci/fBY9s=;
        b=ZIemzyjsRq9eoP1h9jF5KmQizCSVDGt6xI4plwAWYZQLJz3pQk4VDas5EyrnQ0YdCb
         Fs45mr5usc2CrPIlhZLD+lj3w62Z8Ne3WxnrMhq/lfYEA6c3lT0WTSEDUW6PK/SRsW7v
         349tONgsznrE90mTuus6gRE39w7n373/NSybQl2gDyehRhsR7YCbiIUlqJyeOredxrw5
         WDrejAt13I718g4SUvKBDD3tkbeg2DnakRsVMSTC+qpV0/J6tW0fxT3BgJhoitVr7Lhh
         T90S57fg2Y0pM3XswrC0DdGuRFepPMQC+V00zshEMy+kb9nfpPhFK+J06QSWSeuh4Glr
         dYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UK5eErzZtKg/HvO01KKCBb0udTzOZqxbnH2ci/fBY9s=;
        b=YGC5HE+QKjWwzbisMukeykzxRBbKMv/GQX8gXhcOIEU4WC/nuhMNThHLMp3kptzvU+
         Gia0ekIYvqnrbPYHr4aAEppChZxwuSSpSbmrkStAubbMvkZZvJIyt8au3F6R5HIDyjnW
         JWoaP/jFo37dgItEX2USyLmzabdJlJ2R7l+j0yOImzlsZmmk+doAYS9J4L6nPnvhxFjQ
         NSxTdXplVyk/Mhrt55QzA1kqWvAKS2zotypknx3HkJl6UoqeMj1TQ0GRDI6tJwpL5Vm7
         NYja6vTHxNhrBvfHGD8BJqCZkEYsZIrqDIFo3caXRnk9sNBxC4uQcduIvZ53RXCv+jjf
         +aSg==
X-Gm-Message-State: AJIora8zAdHvsPJKVgT94j0sfI6YJEsPlx3xLK5UMq916di88Yd+o0NX
        6CfPNoc2oqB6W+SsvVdzKOkv
X-Google-Smtp-Source: AGRyM1uMYG5Bf48KHuNG7PKQdT3esTHv7uuvP4fyRon91ArW38BvcQbSytXAtlAXHvLN9buBK1imjw==
X-Received: by 2002:a17:90a:5911:b0:1ec:9e24:c671 with SMTP id k17-20020a17090a591100b001ec9e24c671mr14559160pji.173.1655823995841;
        Tue, 21 Jun 2022 08:06:35 -0700 (PDT)
Received: from thinkpad ([117.193.212.116])
        by smtp.gmail.com with ESMTPSA id v11-20020a17090331cb00b00164ade949adsm10788163ple.79.2022.06.21.08.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 08:06:35 -0700 (PDT)
Date:   Tue, 21 Jun 2022 20:36:29 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, yilun.xu@intel.com, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, trix@redhat.com, mdf@kernel.org,
        dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        Max Zhen <max.zhen@xilinx.com>, kishon@ti.com
Subject: Re: [PATCH V1 RESEND 2/4] Documentation: devicetree: bindings: add
 binding for PCIe endpoint bus
Message-ID: <20220621150629.GA28880@thinkpad>
References: <20220305052304.726050-1-lizhi.hou@xilinx.com>
 <20220305052304.726050-3-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220305052304.726050-3-lizhi.hou@xilinx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

+ Kishon

On Fri, Mar 04, 2022 at 09:23:02PM -0800, Lizhi Hou wrote:
> Create device tree binding document for PCIe endpoint bus.
> 

I'm currently working on a PCI endpoint function driver for MHI bus [1] and
hence interested in this topic.

Comments below.

[1] https://lore.kernel.org/lkml/20220502060611.58987-9-manivannan.sadhasivam@linaro.org/

> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>  .../devicetree/bindings/bus/pci-ep-bus.yaml   | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/pci-ep-bus.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/pci-ep-bus.yaml b/Documentation/devicetree/bindings/bus/pci-ep-bus.yaml
> new file mode 100644
> index 000000000000..0ca96298db6f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/pci-ep-bus.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/pci-ep-bus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe Endpoint Bus binding
> +
> +description: |
> +  PCIe device may use flattened device tree to describe apertures in its
> +  PCIe BARs. The Bus PCIe endpoint node is created and attached under the
> +  device tree root node for this kind of device. Then the flatten device
> +  tree overlay for this device is attached under the endpoint node.
> +
> +  The aperture address which is under the endpoint node consists of BAR
> +  index and offset. It uses the following encoding:
> +

On top of Rob's reply:

Currently, the BAR memory for the PCI endpoint device is either allocated
dynamically using pci_epf_alloc_space() or we need to pass the address in
"phys_addr" field of "struct pci_epf_bar".

In most of the PCI endpoint devices, we need to use a fixed memory region as
the BAR. Since there is no devicetree integration for PCI endpoint subsystem,
I've been using the 2nd approach of obtaining the BAR address from PCI endpoint
controller devicetree node and passing it to "phys_addr" of
"struct pci_epf_bar".

Ideally, the BAR information should come from the devicetree. But we cannot use
just "pci-ep-bus" node. I've been thinking about the below structure:

pcie_ep: pcie-ep@40000000 {
        compatible = "pcie-ep";
	....

	pci_epf_0: pci-epf@100000 {
		reg = <0x100000 0x1000>; # BAR0
	};

	pci_epf_1: pci-epf@200000 {
		reg = <0x200000 0x1000>; # BAR1
	};
};

Where, "pci-epf@" represents each of the PCI endpoint functions implemented by
this device (note that there can be more than one function per endpoint device)
and "reg" has the BAR address/size for that function.

Rob, what do you think?

Thanks,
Mani

> +    0xIooooooo 0xoooooooo
> +
> +  Where:
> +
> +    I = BAR index
> +    oooooo oooooooo = BAR offset
> +
> +  The endpoint is compatible with 'simple-bus' and contains 'ranges'
> +  property for translating aperture address to CPU address.
> +
> +allOf:
> +  - $ref: /schemas/simple-bus.yaml#
> +
> +maintainers:
> +  - Lizhi Hou <lizhi.hou@xilinx.com>
> +
> +properties:
> +  compatible:
> +    contains:
> +      const: pci-ep-bus
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":
> +    description: hardware apertures belong to this device.
> +    type: object
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        pci-ep-bus@e0000000 {
> +            compatible = "pci-ep-bus", "simple-bus";
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges = <0x0 0x0 0x0 0xe0000000 0x0 0x2000000
> +                      0x20000000 0x0 0x0 0xe4200000 0x0 0x40000>;
> +        };
> +    };
> -- 
> 2.27.0
> 

-- 
மணிவண்ணன் சதாசிவம்
