Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492A15274A2
	for <lists+linux-pci@lfdr.de>; Sun, 15 May 2022 01:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiENXOs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 May 2022 19:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiENXOp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 May 2022 19:14:45 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF3F11C29;
        Sat, 14 May 2022 16:14:43 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id k25-20020a056830169900b00605f215e55dso7566412otr.13;
        Sat, 14 May 2022 16:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=8fcWrSCf5x/oR5brHV5SFMq/ic1IdVWzznom0Nby5jg=;
        b=GQN6ammb3tTCwLn7yMLt4mOtmdBJc86UvZs4IfwMKmXpylyl9x9Ij7wfcdxbUY6ivm
         NfE0tSSEAmitd21oaJzrp3zhQpupjSdHLNh/DBY4okOXL/OWmYaAG6/mailI6p1Ei3zR
         CQFjQUQF+yiotgw+XZOFugcEW4+X7KASK8dOuaz63iG2L7tlsWz936/1/OpkNJou2455
         WMymnEGO7Q8WhcKQztu/V+FD3rMaG4TNM1ya/NHtdwNh259HX/OUct5qY0lUw4NvYfXc
         GX2ikAyoDQrHJxU1okcJzp6ikoAEcRoR7ZrxvS5A4xO3VOWP4lrLrDR0my/PAkToOUNX
         2J0w==
X-Gm-Message-State: AOAM533x0/j43MqgW3yQ89k7qjGuDCG7VUX7rmjAyBlvvG8v2y+sgT7T
        kNIb3OZVQiXa29AYwORFsA==
X-Google-Smtp-Source: ABdhPJwl9oHK5hDNNxA5VHeDQnmNJ6i+NfFWt4ZnjKEwX0WwdMarfDgU2sJkk1jCO8U1nV6WMPCTsw==
X-Received: by 2002:a05:6830:d2:b0:605:ee58:2dc5 with SMTP id x18-20020a05683000d200b00605ee582dc5mr4057650oto.252.1652570082831;
        Sat, 14 May 2022 16:14:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k101-20020a9d19ee000000b006060322123fsm2633837otk.15.2022.05.14.16.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 16:14:42 -0700 (PDT)
Received: (nullmailer pid 3276246 invoked by uid 1000);
        Sat, 14 May 2022 23:14:41 -0000
From:   Rob Herring <robh@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        Vinod Koul <vkoul@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-phy@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
In-Reply-To: <20220514115946.8858-2-linux@fw-web.de>
References: <20220514115946.8858-1-linux@fw-web.de> <20220514115946.8858-2-linux@fw-web.de>
Subject: Re: [RFC v3 1/5] dt-bindings: phy: rockchip: add PCIe v3 phy
Date:   Sat, 14 May 2022 18:14:40 -0500
Message-Id: <1652570081.002742.3276245.nullmailer@robh.at.kernel.org>
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

On Sat, 14 May 2022 13:59:42 +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add a new binding file for Rockchip PCIe v3 phy driver.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> 
> ---
> v3:
> - drop quotes
> - drop rk3588
> - make clockcount fixed to 3
> - full path for binding header file
> - drop phy-mode and its header and add lane-map
> 
> v2:
> dt-bindings: rename yaml for PCIe v3
> rockchip-pcie3-phy.yaml => rockchip,pcie3-phy.yaml
> 
> changes in pcie3 phy yaml
> - change clock names to ordered const list
> - extend pcie30-phymode description
> - add phy-cells to required properties
> - drop unevaluatedProperties
> - example with 1 clock each line
> - use default property instead of text describing it
> - update license
> ---
>  .../bindings/phy/rockchip,pcie3-phy.yaml      | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml: properties:clock-names: 'oneOf' conditional failed, one must be fixed:
	[{'const': 'refclk_m'}, {'const': 'refclk_n'}, {'const': 'pclk'}] is too long
	[{'const': 'refclk_m'}, {'const': 'refclk_n'}, {'const': 'pclk'}] is too short
	False schema does not allow 3
	1 was expected
	3 is greater than the maximum of 2
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml: ignoring, error in schema: properties: clock-names
Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.example.dtb:0:0: /example-0/phy@fe8c0000: failed to match any schema with compatible: ['rockchip,rk3568-pcie3-phy']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

