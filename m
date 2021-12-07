Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D4246C44D
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 21:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbhLGUVU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 15:21:20 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:33637 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhLGUVT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 15:21:19 -0500
Received: by mail-ot1-f41.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso447665otf.0;
        Tue, 07 Dec 2021 12:17:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+MB6yXYtqMzh5VNyaR3gPGIIrEYooy9VuBz2n/yIA8c=;
        b=XtUek/csyPycL/68jDCsEDgzJkvghwxhkkWPVn1w/2+rkZ9bjJWQhzUzjFBOsHhN5R
         zbGyenzd5fETjMYRotLbnWmAMIuv7XUDOSnzGHR8yG4RQjV9MRxqtDjzhioaSpm/9XUV
         Y7lI9wzI17I5JSaDGZGctOPFV23S6SgVGtEYQlwrgDzZDClGeyI8jF9mBG1IZaD3fjqt
         /1AgNaIQpSjhRClbAaOAJ9iwkn366LEB6A2VojDJqCZSq7JNyXCndok0rtZ9rSj+nL98
         zNurCgFL2wTA8IkAjM87024qDPX1HDt7DdZcegLhC0OAUR4LK41QZZawhEtGmUA5/+P+
         PBgw==
X-Gm-Message-State: AOAM531QOf/agoy/u1Eohvy0RnjJQ/o3hfW5o6r/CcPQlCpjgZg9vQgB
        rY+z9v/cpdQ/T7ftnm5WrQ==
X-Google-Smtp-Source: ABdhPJw4qzAjPBdGAFRx6O6XT1ckH3u9GEqrcqCw84pwWhRxaYjnxvcT+FztKBIhcpB09VBz5ojcVw==
X-Received: by 2002:a9d:4543:: with SMTP id p3mr37789092oti.99.1638908268313;
        Tue, 07 Dec 2021 12:17:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r5sm144000oiw.20.2021.12.07.12.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:17:47 -0800 (PST)
Received: (nullmailer pid 759672 invoked by uid 1000);
        Tue, 07 Dec 2021 20:17:46 -0000
Date:   Tue, 7 Dec 2021 14:17:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 3/7] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
Message-ID: <Ya/Bar212Tb+S9Eo@robh.at.kernel.org>
References: <20211119220756.18628-1-jim2101024@gmail.com>
 <20211119220756.18628-4-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119220756.18628-4-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 19, 2021 at 05:07:50PM -0500, Jim Quinlan wrote:
> Add bindings for Brcmstb EP voltage regulators.  A new mechanism is to be
> added to the Linux PCI subsystem that will allocate and turn on/off
> regulators.  These are standard regulators -- vpcie12v, vpcie3v3, and
> vpcie3v3aux -- placed in the DT in the bridge node under the host bridge
> device.
> 
> The use of a regulator property in the pcie EP subnode such as
> "vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
> file at
> 
> https://github.com/devicetree-org/dt-schema/pull/63
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  .../bindings/pci/brcm,stb-pcie.yaml           | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index 22f2ef446f18..7113a7f726e7 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -159,5 +159,28 @@ examples:
>                                   <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
>                      brcm,enable-ssc;
>                      brcm,scb-sizes =  <0x0000000080000000 0x0000000080000000>;
> +
> +                    /* PCIe bridge */

Root port specifically. Didn't Pali mention that before?

> +                    pci@0,0 {
> +                            #address-cells = <3>;
> +                            #size-cells = <2>;
> +                            reg = <0x0 0x0 0x0 0x0 0x0>;
> +                            compatible = "pciclass,0604";
> +                            device_type = "pci";
> +                            vpcie3v3-supply = <&vreg7>;
> +                            ranges;
> +
> +                            /* PCIe endpoint */
> +                            pci-ep@0,0 {
> +                                    assigned-addresses =
> +                                        <0x82010000 0x0 0xf8000000 0x6 0x00000000 0x0 0x2000>;
> +                                    reg = <0x0 0x0 0x0 0x0 0x0>;
> +                                    compatible = "pci14e4,1688";

> +                                    #address-cells = <3>;
> +                                    #size-cells = <2>;
> +
> +                                    ranges;

These aren't appropriate for an endpoint.

> +                            };
> +                    };
>              };
>      };
> -- 
> 2.17.1
> 
> 
