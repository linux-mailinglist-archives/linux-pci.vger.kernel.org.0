Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476B7549D1D
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 21:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbiFMTOQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 15:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348359AbiFMTNc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 15:13:32 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B566C3F;
        Mon, 13 Jun 2022 10:34:52 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id f7so4781918ilr.5;
        Mon, 13 Jun 2022 10:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=inaX8bZake1uK03pZZ115muQtE+Cy1cKAMm+WceEhjI=;
        b=mdDiZ5AS/HWiLGEkWot4g9c+MHrX8O1WX5L/rX64wFg76GitZPynIajfJTKx7pGbOO
         +y8CjMZxrekzvIOe1zzQMnTA4DfcfEpj6Mjbn+k1KrmK2z8MY07Yy29YS8ZOagtR5lKX
         /4HCHxdNuTp+z9kiYCfKEOtPweFKoW8R6VuvaUVXKBZh3uXUkKGtd1rIIaT2vRMspzjT
         Gq6vbAUhLx72eAkN5ffE1xT8WvZArxFVxaBojbFxYvvlGhphuJXGpoFH1mssfSxDolQX
         R48/Kv9TNv+7FgAChLCJ8ksPnM7eQ1m4rHffu3YJ7X9w+E7qZsY/lxq8OmEq+29ZiFRd
         5Hog==
X-Gm-Message-State: AJIora8teG7ZU9dWT61x6ol32q2SRZxEto0MDxKIfWOTELaIWoejC555
        pT2shsat1Mbzq/0H/24ldA==
X-Google-Smtp-Source: AGRyM1t8MZFwlalMjddYXCHhYrtFZXaO6A02e2NyRm9JgDEGuq5eNvVvTxx+DfXezQjuV0MPJS+OEg==
X-Received: by 2002:a92:7c06:0:b0:2d6:605d:8164 with SMTP id x6-20020a927c06000000b002d6605d8164mr505102ilc.179.1655141691307;
        Mon, 13 Jun 2022 10:34:51 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id v2-20020a056602014200b0066a0c0beee7sm211899iot.44.2022.06.13.10.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:34:50 -0700 (PDT)
Received: (nullmailer pid 3951188 invoked by uid 1000);
        Mon, 13 Jun 2022 17:34:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     krzk+dt@kernel.org, robh+dt@kernel.org, geert+renesas@glider.be,
        magnus.damm@gmail.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kw@linux.com,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        lpieralisi@kernel.org, marek.vasut+renesas@gmail.com
In-Reply-To: <20220613115712.2831386-3-yoshihiro.shimoda.uh@renesas.com>
References: <20220613115712.2831386-1-yoshihiro.shimoda.uh@renesas.com> <20220613115712.2831386-3-yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH 2/7] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
Date:   Mon, 13 Jun 2022 11:34:46 -0600
Message-Id: <1655141686.995312.3951187.nullmailer@robh.at.kernel.org>
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

On Mon, 13 Jun 2022 20:57:07 +0900, Yoshihiro Shimoda wrote:
> Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> PCIe endpoint module.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../bindings/pci/rcar-gen4-pci-ep.yaml        | 111 ++++++++++++++++++
>  1 file changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.example.dtb: pcie-ep@dfd00000: compatible:0: 'renesas,r8a779f0-pcie-ep' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.example.dtb: pcie-ep@dfd00000: compatible: ['snps,dw-pcie-ep'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.example.dtb: pcie-ep@dfd00000: reg: [[3753902080, 4096], [3753906176, 4096], [3489660928, 33554432]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.example.dtb: pcie-ep@dfd00000: reg-names:1: 'atu' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.example.dtb: pcie-ep@dfd00000: reg-names:2: 'appl' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.example.dtb: pcie-ep@dfd00000: reg-names: ['dbi', 'dbi2', 'addr_space'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.example.dtb: pcie-ep@dfd00000: 'resets' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.example.dtb: pcie-ep@dfd00000: 'power-domains' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.example.dtb: pcie-ep@dfd00000: 'clocks' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.example.dtb: pcie-ep@dfd00000: 'clock-names' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.example.dtb: pcie-ep@dfd00000: 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

