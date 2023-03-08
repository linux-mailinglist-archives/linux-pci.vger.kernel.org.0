Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1816B0A85
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 15:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjCHOIK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 09:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjCHOHv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 09:07:51 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6265C4DE35;
        Wed,  8 Mar 2023 06:06:30 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id q15so12199279oiw.11;
        Wed, 08 Mar 2023 06:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678284389;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=46ifXtx7H5qHUf/TrPJ9mIvLhusVn1artVDZ/aEfyqY=;
        b=KWFUyO0nioE5dQ7vHHl//5hg/neJ0gcA6fLP4BsYkFKL2k7ukG2RASWWdjPOsxrKrb
         oCvayFtAzWC++0SJnFA03XE7HxUpkx9ti4QJb/ARvO9rGUhjgsiHxZi5aYZYYoHksRvy
         R/FEi8Np8/k+ZU8J7lCV3BFy5VC07qMALGgjQt9zL0Wm/MUJWlqAZLi4XDEGQzqHvKJp
         S8GipnhT/M871QNNjW2aIwfG2fOx9VPcMX0IAVVk1TzNoi5LDUSuynX0yiZpgvg2+uR/
         CYNIFYb63AYYK3R4fOYAoqflFFEsEEEG9b8i4uKxbpKFU0SwXtC4VgNkthRttQE2bCS4
         QTng==
X-Gm-Message-State: AO0yUKU4KxJIrT8bHxWBiyuSxvhyB4JIQCdnxMMzKBmW9MXU1WboS8pB
        6FWsiX0LU4zfG3+H1VmraQ==
X-Google-Smtp-Source: AK7set8gAyNjY8BkNBNF90LL+mmM7D2sm8zj5SI+095OPsrGhbzhNlHil1wu52ljYCwndnnZtwARTA==
X-Received: by 2002:a05:6808:251:b0:384:637:a4f with SMTP id m17-20020a056808025100b0038406370a4fmr8319226oie.10.1678284389579;
        Wed, 08 Mar 2023 06:06:29 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p13-20020a05680811cd00b0037d59e90a07sm6336512oiv.55.2023.03.08.06.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 06:06:28 -0800 (PST)
Received: (nullmailer pid 2666447 invoked by uid 1000);
        Wed, 08 Mar 2023 14:06:21 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     marek.vasut+renesas@gmail.com, lpieralisi@kernel.org,
        jingoohan1@gmail.com, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, Sergey.Semin@baikalelectronics.ru,
        kw@linux.com, robh+dt@kernel.org, gustavo.pimentel@synopsys.com
In-Reply-To: <20230308082352.491561-5-yoshihiro.shimoda.uh@renesas.com>
References: <20230308082352.491561-1-yoshihiro.shimoda.uh@renesas.com>
 <20230308082352.491561-5-yoshihiro.shimoda.uh@renesas.com>
Message-Id: <167828360013.2613033.9597953469083757730.robh@kernel.org>
Subject: Re: [PATCH v10 04/12] dt-bindings: PCI: renesas: Add R-Car Gen4
 PCIe Endpoint
Date:   Wed, 08 Mar 2023 08:06:21 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Wed, 08 Mar 2023 17:23:44 +0900, Yoshihiro Shimoda wrote:
> Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> PCIe endpoint module.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/pci/rcar-gen4-pci-ep.yaml        | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.example.dtb: pcie-ep@e65d0000: reg-names:2: 'app' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230308082352.491561-5-yoshihiro.shimoda.uh@renesas.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

