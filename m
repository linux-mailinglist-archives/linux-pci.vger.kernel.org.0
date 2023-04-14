Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1966E2373
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 14:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjDNMhZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 08:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjDNMhW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 08:37:22 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A698698;
        Fri, 14 Apr 2023 05:37:17 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id k22-20020a9d7016000000b006a43382e5b9so2091238otj.3;
        Fri, 14 Apr 2023 05:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681475837; x=1684067837;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1DPXz5CbaLVgCyGeKN3QbapCxaByokh8FAkRZI2YR74=;
        b=Z7laje9C7jw6lKAHxVmhmRpEQeY/kFof0e/v+j34bui53LCEIVkASQg/12piaohJ91
         Hnhz9Zo/yGGyqQioaYM2HA5vG1rqXcwFqtrCu5g4DCiuMOpHGPL8qVtaYHFzGyQi3U8T
         6ui19vetAZorWr7TGj1V88QtcQ/d6CFKxa7D0bvg5lpTzcMaGtTs0Vu5nx3m0tFq57DM
         Qpp0rRFfV0E3kssySdBpLVeWXqJutPtXX4k8bsZIxCWHKYvG2okogukK7uGBWsqfA46P
         WkmyUAlWEcp3AsH39TX7JVWOI4Bu4xKAy+u3MdBjx7Bk3so4bzDzM3XTzK04oNLdVzzm
         Bfmw==
X-Gm-Message-State: AAQBX9dn8THtFHOP5boNqazHPkbRmBt8XkiAD9qtvcZsReRN8wmcHUV2
        7g6/uqNkpGpk1U0BBdzViQ==
X-Google-Smtp-Source: AKy350ZCzjPwV61KpMXMuMTcplpQUOTVEy0zA7LcKQKlFcGavyJBgHw6OjJO9sFV7pNg3RHx4Nwj/g==
X-Received: by 2002:a9d:67d0:0:b0:69b:c852:4ab8 with SMTP id c16-20020a9d67d0000000b0069bc8524ab8mr2553545otn.7.1681475836835;
        Fri, 14 Apr 2023 05:37:16 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m18-20020a9d7ad2000000b00690e21a46e1sm1610219otn.56.2023.04.14.05.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:37:13 -0700 (PDT)
Received: (nullmailer pid 3600814 invoked by uid 1000);
        Fri, 14 Apr 2023 12:37:05 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     gustavo.pimentel@synopsys.com, robh+dt@kernel.org, mani@kernel.org,
        bhelgaas@google.com, lpieralisi@kernel.org,
        fancer.lancer@gmail.com, kw@linux.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        jingoohan1@gmail.com, marek.vasut+renesas@gmail.com,
        kishon@kernel.org
In-Reply-To: <20230414061622.2930995-16-yoshihiro.shimoda.uh@renesas.com>
References: <20230414061622.2930995-1-yoshihiro.shimoda.uh@renesas.com>
 <20230414061622.2930995-16-yoshihiro.shimoda.uh@renesas.com>
Message-Id: <168147485020.3576451.4333163339018554395.robh@kernel.org>
Subject: Re: [PATCH v12 15/19] dt-bindings: PCI: renesas: Add R-Car Gen4
 PCIe Endpoint
Date:   Fri, 14 Apr 2023 07:37:05 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Fri, 14 Apr 2023 15:16:18 +0900, Yoshihiro Shimoda wrote:
> Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> PCIe endpoint module.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  .../bindings/pci/rcar-gen4-pci-ep.yaml        | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.example.dtb: pcie-ep@e65d0000: reg: [[0, 3864854528, 0, 8192], [0, 3864864768, 0, 2048], [0, 3864866816, 0, 8192], [0, 3864875008, 0, 4608], [0, 3864879616, 0, 3584], [0, 4261412864, 0, 4194304]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.example.dtb: pcie-ep@e65d0000: reg-names: ['dbi', 'dbi2', 'atu', 'dma', 'app', 'addr_space'] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230414061622.2930995-16-yoshihiro.shimoda.uh@renesas.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

