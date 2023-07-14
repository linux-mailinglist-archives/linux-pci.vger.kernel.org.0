Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0853175406B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 19:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbjGNR0B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 13:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbjGNR0A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 13:26:00 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090B03593;
        Fri, 14 Jul 2023 10:25:59 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so3647558e87.2;
        Fri, 14 Jul 2023 10:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689355557; x=1691947557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ww5uJ/kx1wfWM4Xur4cXw8tinYasBTMoIjV5PBf4gjU=;
        b=I0fxvmInW8sNnGe01PIwOZmewXIoHduL/HlegqaiGExAAGi+p3n09de0huGb8EaFKO
         kCl/bXaNPoL91fvm66qdZ35BrpoRk/1eJLPmGmdzvP4Yu7KwE+OIS/zSy7dAl6V+JirW
         jSagclYVn7FZQf7iwl3y5lAgsR9nsm3JTStlFd+32uvj1C2uRLGwfDxWvjNwMq1Me2QX
         jfilnSG2WYOQ2wffuEdhhlYN8zZ31w8VGT7v/Zu8JMcZaujRINyDI86YhZ/C4kADAGFz
         8+LhuVRJs3IUyIbaEmykfaQr+CJWhcIAtAj+cl0vD8nZVQQeFpz5EGWLxEv+NdF+yL5q
         FGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689355557; x=1691947557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ww5uJ/kx1wfWM4Xur4cXw8tinYasBTMoIjV5PBf4gjU=;
        b=hge+ewns41e9O7ahbJdoVLT2HOBrnX3Ta57u5iddvHlBx7N6+mkReAdHc45QLyGCyx
         BLbPbaIO0o5ByKmZLkSmzPMrGK4ZpQMkZIpgCXoh7Mjv+kUNeMgrdgUy7Axok1+ctlUK
         JGU/4cSARk9Wy/hA0WkiSNJWNry0tMlSPPRueO+pl2uWJ9gzWQKN3ASXG/wQwT8XJwQ0
         i2S9BPSwpHG9i5DyfWdYJiHpCNh1RKozyUAKmkxwgpEpQwLJcUiBnIt5DIEafsAQ2VGl
         XXJut5mKi8F8n7Fp7YIvsWdDA9eTr32fpvuZikjel5fMVwvIDoI/s4DV64zmTp70Zz14
         VuWA==
X-Gm-Message-State: ABy/qLabk1wQyPCbJxL5d+coNcnwD2rm/m7JFZ7TT70eYkj/ibJwACPA
        pSm2U+EgFQMgYmAoylXJG3c=
X-Google-Smtp-Source: APBJJlGQ5pQ9sQipWBgmbsSHJXr1DZi9MEQZKP8iArAD2FG3Fpih0+NmK1CLpCo+IBW0kWX8/J7Hwg==
X-Received: by 2002:a05:6512:1110:b0:4fc:6e21:ff51 with SMTP id l16-20020a056512111000b004fc6e21ff51mr4622039lfg.40.1689355556883;
        Fri, 14 Jul 2023 10:25:56 -0700 (PDT)
Received: from mobilestation ([85.249.18.201])
        by smtp.gmail.com with ESMTPSA id n4-20020ac24904000000b004f1383d57ecsm1546224lfi.202.2023.07.14.10.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:25:56 -0700 (PDT)
Date:   Fri, 14 Jul 2023 20:25:52 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: dwc: rockchip: Fix
 interrupt-names issue
Message-ID: <mikpjlkg65ubb75jrcrbiomzq6npte5iheuoexgrtu4kqej5do@qbwcbcgorg3k>
References: <20230713171851.73052-1-sebastian.reichel@collabora.com>
 <20230713171851.73052-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713171851.73052-2-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sebastian

On Thu, Jul 13, 2023 at 07:18:49PM +0200, Sebastian Reichel wrote:
> The RK356x (and RK3588) have 5 ganged interrupts. For example the
> "legacy" interrupt combines "inta/intb/intc/intd" with a register
> providing the details.
> 
> Currently the binding is not specifying these interrupts resulting
> in a bunch of errors for all rk356x boards using PCIe.
> 
> Fix this by specifying the interrupts and add them to the example
> to prevent regressions.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/pci/rockchip-dw-pcie.yaml        | 18 +++++
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml | 76 ++++++++++++++++++-
>  2 files changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> index a4f61ced5e88..aad53c7d8485 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> @@ -60,6 +60,17 @@ properties:
>        - const: aux
>        - const: pipe
>  
> +  interrupts:
> +    maxItems: 5
> +
> +  interrupt-names:
> +    items:
> +      - const: sys
> +      - const: pmc
> +      - const: msg
> +      - const: legacy
> +      - const: err
> +
>    msi-map: true
>  
>    num-lanes: true
> @@ -108,6 +119,7 @@ unevaluatedProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
>      bus {
>          #address-cells = <2>;
> @@ -127,6 +139,12 @@ examples:
>                            "aclk_dbi", "pclk",
>                            "aux";
>              device_type = "pci";
> +            interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "sys", "pmc", "msg", "legacy", "err";
>              linux,pci-domain = <2>;
>              max-link-speed = <2>;
>              msi-map = <0x2000 &its 0x2000 0x1000>;
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> index 1a83f0f65f19..973bf8f2730d 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> @@ -193,9 +193,83 @@ properties:
>            oneOf:
>              - description: See native "app" IRQ for details
>                enum: [ intr ]
> +        - description:
> +            Combined legacy interrupt, which is used to signal the following
> +            interrupts
> +              * inta
> +              * intb
> +              * intc
> +              * intd
> +          const: legacy
> +        - description:
> +            Combined system interrupt, which is used to signal the following
> +            interrupts
> +              * phy_link_up
> +              * dll_link_up
> +              * link_req_rst_not
> +              * hp_pme
> +              * hp
> +              * hp_msi
> +              * link_auto_bw
> +              * link_auto_bw_msi
> +              * bw_mgt
> +              * bw_mgt_msi
> +              * edma_wr
> +              * edma_rd
> +              * dpa_sub_upd
> +              * rbar_update
> +              * link_eq_req
> +              * ep_elbi_app
> +          const: sys
> +        - description:
> +            Combined PM interrupt, which is used to signal the following
> +            interrupts
> +              * linkst_in_l1sub
> +              * linkst_in_l1
> +              * linkst_in_l2
> +              * linkst_in_l0s
> +              * linkst_out_l1sub
> +              * linkst_out_l1
> +              * linkst_out_l2
> +              * linkst_out_l0s
> +              * pm_dstate_update
> +          const: pmc
> +        - description:
> +            Combined message interrupt, which is used to signal the following
> +            interrupts
> +              * ven_msg
> +              * unlock_msg
> +              * ltr_msg
> +              * cfg_pme
> +              * cfg_pme_msi
> +              * pm_pme
> +              * pm_to_ack
> +              * pm_turnoff

> +              * obff_idle
> +              * obff_obff
> +              * obff_cpu_active

These are marked is "inputs" (from the DW PCIe controller point of
view) in the HW manual. Are you sure they are supposed to generate any
IRQ? Based on the DW PCIe HW-manual they are supposed to be set by the
_application_ (a.k.a your driver or vendor-specific RTL block) as a
request to the DW PCIe controller to emit an OBFF message. There is a
signal marked as "output" and named as "app_obff_msg_grant" which most
likely is relevant here.

> +          const: msg
> +        - description:
> +            Combined error interrupt, which is used to signal the following
> +            interrupts
> +              * aer_rc_err
> +              * aer_rc_err_msi
> +              * rx_cpl_timeout
> +              * tx_cpl_timeout
> +              * cor_err_sent
> +              * nf_err_sent
> +              * f_err_sent
> +              * cor_err_rx
> +              * nf_err_rx
> +              * f_err_rx
> +              * radm_qoverflow
> +          const: err

The most of the signals you cited in the description properties are a
part of the so called "System Information Interface" defined in the DW
PCIe databook. Here is what the doc says regarding these signals:

"The SII exchanges various system-related information between the
controller and your application. Most of the SII signals are provided
for flexibility. Your application is not required to use all of the
SII signals. Your application logic is expected to drive and monitor
the signals that it needs to function correctly. SII inputs that your
application does not require, must be driven to 0."

Amongst tons of various informational signals available in the
framework of SII, there is "SII: Interrupt Signals" which are normally
utilized by the vendor-specific controller implementations and which
are defined as generic in this DT-bindings. (MSI IRQ signal is defined
separately from SII as "MSI Interface Signals".)

What is normally expected is that all the generic SII IRQs are
supplied as the separate signals meanwhile the rest of the SII signals
are combined in an additional line named like "app".

In your case we find an intermix of the SII generic IRQs and some SII
signals (though some of the names listed in your descriptions don't
match to what is defined in the DW PCIe HW manual). So what you said
in v1:

On Thu, Jul 13, 2023 at 7:47PM +0200, Sebastian Reichel wrote:
> I suppose "sys", "pmc", "msg" and "err" all fit for "app", since
> they are vendor specific with the extra layer? But obviously I
> cannot specify "app" more than once."

is mainly correct. For instance, the most of the generic SII interrupt
signals are combined in your "sys" IRQ, like "hp", "bw_au", "bw_mg",
"dma", "l_eq"; your "pmc" and "msg" IRQs are a set of the SII signals
not listed in the "SII Interrupt Signals" list; the "err" IRQ has the
"aer" generic SII Interrupt, but the rest of the signals are common SII
signals.

I am not fully certain of what to do in this case. Some possible options:

1. Keep the names defined as is, add them to the list of generic IRQ
names, describe them as "Combined IRQ signals" but with no specific
signals listed and with some generic meaningful description.
Alternatively create a separate sub-schema in the generic
"interrupt-names" property constraints in the same way as it's done
for the "vendor-specific IRQ names" and do the same with the names
descriptions. In anyway move your detailed descriptions to the
Rockchip DW PCIe DT-schema. In this case we imply that your names
could be re-used for some other device bindings.

2. Keep the names defined as is, add them to the list of
"vendor-specific IRQ names" sub-schema in the "interrupt-names"
property, describe each of them as "Combined IRQ signals" but with no
specific signals listed and with some generic meaningful description.
Move your detailed descriptions to the Rockchip DW PCIe DT-schema.

3. Add "app_" prefix to all your IRQs (except "legacy") and convert
the generic "app" IRQ name constraint to accepting a pattern like
'^app(_.*)?$' or similar. Move your detailed descriptions to the
Rockchip DW PCIe DT-schema.

4. Add Rockchip-specific prefix to the names (except "legacy"), add
all of them (for instance as a pattern-like schema) to the
vendor-specific IRQ names part of the "interrupt-names" items list
with a description referring to the Rockchip DT-bindings. Move your
detailed descriptions to the Rockchip DW PCIe DT-schema.

Doubtfully the categorization chosen by the Rockchip HW designers is
fully universal so the names could be utilized for other devices. Thus
IMO the options 2-4 might be more preferable over 1.

In anyway the detailed descriptions with the listed lines should be
in the Rockchip DW PCIe DT-bindings since they are definitely
vendor-specific.

Regarding the "legacy" name used as a combined "int(a|b|c|d)" IRQ.
Alas we can't change it. So it's either option 1 or 2. 

What do you think? Rob, Krzysztof, any better idea?

> +

>      allOf:
>        - contains:
> -          const: msi
> +          enum:
> +            - msi
> +            - msg

Based on the above the "msg" interrupt doesn't get to be required.
Rob, is it possible to have a constraint which would require either
the "msi" IRQ name or the "msi-map" DT-property or both?

-Serge(y)

>  
>  additionalProperties: true
>  
> -- 
> 2.40.1
> 
