Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8DA549D2D
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 21:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244254AbiFMTPZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 15:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345765AbiFMTNQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 15:13:16 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E23FE28;
        Mon, 13 Jun 2022 10:34:50 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id h7so4767731ila.10;
        Mon, 13 Jun 2022 10:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=VexzobjkGRB0ucHkwaD3d+mrxZdJ+NIvR+Qk/N/8+OM=;
        b=0slZVBP2qlyJzbdMh4j6VOpsAa9u/cDEtlSJGT4coiQT7QMmbxGRlyD/XKEQpRJLGY
         1I05iG02AQv1LNkC693BJhQQHzMS5RjnhG6ACgRYJrYvLqy2QdzfhE4JYDjyVnSp58mb
         BIDree+bOgFzmx+iiDiqhuO9K2hCBE/Y/sI+mYJ8tgR6pV2w9GY8mP89tI2TyDWqcpFL
         HcDVUHUxfHpzQtC39mdpT87mVTjFkS9DDTsqt5oenop2HZ2ZrtxIzkXExW0cigNUmqEI
         RCFo6Tnzva8PZW7WYZx7axykm2LhfHPZki+wmGjzPcGGtINYX2SKUhGEsocwlvA99K6c
         vcEg==
X-Gm-Message-State: AJIora+84G777O8FIAa0XVbQfX3WT31RGl9j0kslzzL+wEhGvddTlXhY
        ljoaI+ttFfVKWMMTXH/QJQ==
X-Google-Smtp-Source: AGRyM1tHMHc+/gWm0UnSKdLtipBp1pFsdBQ8KPOQKgEHymZK6K65TkXJNtJOVtoPrwDzqV+a0hb1yA==
X-Received: by 2002:a92:c891:0:b0:2d3:a221:ad70 with SMTP id w17-20020a92c891000000b002d3a221ad70mr538561ilo.99.1655141688892;
        Mon, 13 Jun 2022 10:34:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id a3-20020a5ec303000000b0066579afd3cbsm4169257iok.50.2022.06.13.10.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:34:48 -0700 (PDT)
Received: (nullmailer pid 3951182 invoked by uid 1000);
        Mon, 13 Jun 2022 17:34:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     bhelgaas@google.com, linux-renesas-soc@vger.kernel.org,
        magnus.damm@gmail.com, krzk+dt@kernel.org,
        marek.vasut+renesas@gmail.com, geert+renesas@glider.be,
        robh+dt@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com
In-Reply-To: <20220613115712.2831386-2-yoshihiro.shimoda.uh@renesas.com>
References: <20220613115712.2831386-1-yoshihiro.shimoda.uh@renesas.com> <20220613115712.2831386-2-yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH 1/7] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
Date:   Mon, 13 Jun 2022 11:34:46 -0600
Message-Id: <1655141686.984544.3951181.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 13 Jun 2022 20:57:06 +0900, Yoshihiro Shimoda wrote:
> Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> PCIe host module.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../bindings/pci/rcar-gen4-pci-host.yaml      | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dtb: pcie@d0e00000: compatible:0: 'renesas,r8a779f0-pcie' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dtb: pcie@d0e00000: compatible:1: 'renesas,rcar-gen4-pcie' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dtb: pcie@d0e00000: compatible: ['intel,lgm-pcie', 'snps,dw-pcie'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dtb: pcie@d0e00000: clocks: [[4294967295, 120]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dtb: pcie@d0e00000: 'clock-names' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dtb: pcie@d0e00000: 'power-domains' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dtb: pcie@d0e00000: 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,dw-pcie.example.dtb: pcie@dfc00000: compatible:0: 'renesas,r8a779f0-pcie' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,dw-pcie.example.dtb: pcie@dfc00000: compatible: ['snps,dw-pcie'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,dw-pcie.example.dtb: pcie@dfc00000: interrupts: [[25], [24]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,dw-pcie.example.dtb: pcie@dfc00000: 'clocks' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,dw-pcie.example.dtb: pcie@dfc00000: 'clock-names' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,dw-pcie.example.dtb: pcie@dfc00000: 'power-domains' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

