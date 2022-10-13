Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80BE5FD837
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 13:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJMLWq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 07:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJMLWp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 07:22:45 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C041046864;
        Thu, 13 Oct 2022 04:22:44 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id p127so703662oih.9;
        Thu, 13 Oct 2022 04:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zz0LlW4IaEDKOVSif4WH0v0lAUY6tkDYrRcPRPbxKn4=;
        b=e+XWKi8iHbRL40XIeZQP3pq7GDQTxu1iRlSoAUzGmqLqCCL5wETKAd64/v1Edro1hF
         aEkAB/HIhILc1O3B30I/rk6iXP5ohUf9GW09mGuJ+VoRnxGifON8kKXyXmHfrMB4O9Gb
         0xcvDOCnDWEZyb/2UFUFC2v4KIOT/V3ptOYON4RJP4ihZSXNczFEiWP9Q97O4doX1sGW
         AXNyQHfpugrOLdAcT36n448VIS5jO1tA9BpYuJOSi4wdJN9jVpxm9E5l4N1+8tMxYAi2
         sXMbqWw6fk+tU8tYuoeYXSsd1udhK5JtJ3gTzzdL6lK5dWYOykpCkjEvolOooBO/2l80
         kBrQ==
X-Gm-Message-State: ACrzQf0X2NliB5F3881WQSWb8aquWmZfrETdyQgYzoMVgMc7pNOwqt8O
        23mDbl/+SzZVWd93u0r45A==
X-Google-Smtp-Source: AMsMyM7UW8mjhwu66yj3nbamxmNH9eKWPFDyFhaa4nn0LEM08IVnb9A4F2MynUd7d8/waVroHlIaRw==
X-Received: by 2002:a05:6808:1911:b0:354:cede:ec0d with SMTP id bf17-20020a056808191100b00354cedeec0dmr4121263oib.161.1665660163624;
        Thu, 13 Oct 2022 04:22:43 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cg12-20020a056830630c00b006618b23df05sm7041409otb.21.2022.10.13.04.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 04:22:43 -0700 (PDT)
Received: (nullmailer pid 5414 invoked by uid 1000);
        Thu, 13 Oct 2022 11:22:44 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dominic Rath <dominic.rath@ibv-augsburg.de>
Cc:     vigneshr@ti.com, tjoseph@cadence.com, linux-kernel@vger.kernel.org,
        lpieralisi@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Alexander Bahle <bahle@ibv-augsburg.de>,
        linux-pci@vger.kernel.org, Dominic Rath <rath@ibv-augsburg.de>,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org, nm@ti.com
In-Reply-To: <20221013062649.303184-2-dominic.rath@ibv-augsburg.de>
References: <20221013062649.303184-1-dominic.rath@ibv-augsburg.de> <20221013062649.303184-2-dominic.rath@ibv-augsburg.de>
Message-Id: <166565993088.4193992.9896527411552499308.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: PCI: cdns: Add PHY latency properties
Date:   Thu, 13 Oct 2022 06:22:44 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 13 Oct 2022 08:26:47 +0200, Dominic Rath wrote:
> From: Alexander Bahle <bahle@ibv-augsburg.de>
> 
> Add "cdns,tx-phy-latency-ps" and "cdns,rx-phy-latency-ps" DT bindings for
> setting the PCIe PHY latencies.
> The properties expect a list of uint32 PHY latencies in picoseconds for
> every supported speed starting at PCIe Gen1, e.g.:
> 
>   max-link-speed = <2>;
>   tx-phy-latency-ps = <100000 200000>; /* Gen1: 100ns, Gen2: 200ns */
>   rx-phy-latency-ps = <150000 250000>; /* Gen1: 150ns, Gen2: 250ns */
> 
> There should be a value for every supported speed.
> 
> Signed-off-by: Alexander Bahle <bahle@ibv-augsburg.de>
> Signed-off-by: Dominic Rath <rath@ibv-augsburg.de>
> ---
>  .../bindings/pci/cdns,cdns-pcie-ep.yaml       |  2 ++
>  .../bindings/pci/cdns,cdns-pcie-host.yaml     |  2 ++
>  .../devicetree/bindings/pci/cdns-pcie-ep.yaml | 20 +++++++++++++++++++
>  .../bindings/pci/cdns-pcie-host.yaml          | 20 +++++++++++++++++++
>  4 files changed, 44 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml: properties:cdns,tx-phy-latency-ps: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml: properties:cdns,rx-phy-latency-ps: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
./Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml: Error in referenced schema matching $id: http://devicetree.org/schemas/pci/cdns-pcie-host.yaml
./Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml: Error in referenced schema matching $id: http://devicetree.org/schemas/pci/cdns-pcie-ep.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml: properties:cdns,tx-phy-latency-ps: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml: properties:cdns,rx-phy-latency-ps: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
./Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml: Error in referenced schema matching $id: http://devicetree.org/schemas/pci/cdns-pcie-host.yaml
./Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml: Error in referenced schema matching $id: http://devicetree.org/schemas/pci/cdns-pcie-ep.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

