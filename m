Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E63B6E236C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 14:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjDNMhW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 08:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjDNMhO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 08:37:14 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C6C11C;
        Fri, 14 Apr 2023 05:37:12 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-187bee46f9dso83544fac.11;
        Fri, 14 Apr 2023 05:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681475832; x=1684067832;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tif8NhdXDaYsKWyUG+spnxjaLJkK+6EAtIt8ttAcEs4=;
        b=i+4joY4xSfcJWUGbb/QKqQhM6JAFGQGGC2hc8kjXcu+DFxMEumpHtzO+djsGYvUHGM
         V+P6a26j383t68rtnfI5RZh59jhcACjD9qLDg9yy6J6AuxUX9/RgpKZu6ANNokstysIm
         nn5xVbT2iT76xHF7EFmYwHwy1B5kObd/euSHWH6L4WjG1OK4qNkgXASzVEkY1BAZDU/B
         rj3ie90JVqz2NjaQG0EwhYHW1OqfD4wuEoUNrP3Hcl17PFlbu48BcwPX65eIOksUFKm0
         AubaGQ0aS0y0XWTTRfccFLfws77JxLR/DYNBzAV+iTNLa99ZyrzJxlk+tYpPiq+EMQA0
         pIUQ==
X-Gm-Message-State: AAQBX9ci6Dmh/0k6E7y4OnObJ2LoDSC5mslbh+zaC6Y5PMJaEAuf645h
        UMkGnIk2mwvMfuv4U6e/qQ==
X-Google-Smtp-Source: AKy350YtIiRkiMozbJSJbOls/JKKCcKXGbj0sXIIm/2Aub6PlAVIfCaR3m+eP4C5BMr98YW8rvXHAQ==
X-Received: by 2002:a05:6870:c227:b0:177:b6ed:a154 with SMTP id z39-20020a056870c22700b00177b6eda154mr4230820oae.34.1681475832618;
        Fri, 14 Apr 2023 05:37:12 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id eb8-20020a056870a88800b001777244e3f9sm1740074oab.8.2023.04.14.05.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:37:11 -0700 (PDT)
Received: (nullmailer pid 3600812 invoked by uid 1000);
        Fri, 14 Apr 2023 12:37:05 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     kishon@kernel.org, linux-renesas-soc@vger.kernel.org,
        robh+dt@kernel.org, bhelgaas@google.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        fancer.lancer@gmail.com, marek.vasut+renesas@gmail.com,
        kw@linux.com, lpieralisi@kernel.org, jingoohan1@gmail.com
In-Reply-To: <20230414061622.2930995-15-yoshihiro.shimoda.uh@renesas.com>
References: <20230414061622.2930995-1-yoshihiro.shimoda.uh@renesas.com>
 <20230414061622.2930995-15-yoshihiro.shimoda.uh@renesas.com>
Message-Id: <168147484959.3576429.13497930996151330300.robh@kernel.org>
Subject: Re: [PATCH v12 14/19] dt-bindings: PCI: renesas: Add R-Car Gen4
 PCIe Host
Date:   Fri, 14 Apr 2023 07:37:05 -0500
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


On Fri, 14 Apr 2023 15:16:17 +0900, Yoshihiro Shimoda wrote:
> Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> PCIe host module.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  .../bindings/pci/rcar-gen4-pci-host.yaml      | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.example.dtb: pcie@e65d0000: reg: [[0, 3864854528, 0, 4096], [0, 3864862720, 0, 2048], [0, 3864866816, 0, 8192], [0, 3864875008, 0, 4608], [0, 3864879616, 0, 3584], [0, 4261412864, 0, 4194304]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.example.dtb: pcie@e65d0000: reg-names: ['dbi', 'dbi2', 'atu', 'dma', 'app', 'config'] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.example.dtb: pcie@e65d0000: Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'dma-ranges', 'interrupt-map', 'interrupt-map-mask', 'ranges', 'snps,enable-cdm-check' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230414061622.2930995-15-yoshihiro.shimoda.uh@renesas.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

