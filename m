Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D284651A45F
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 17:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbiEDPri (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 May 2022 11:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiEDPri (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 11:47:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36D51AF35;
        Wed,  4 May 2022 08:44:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B958BB8247D;
        Wed,  4 May 2022 15:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE12C385A4;
        Wed,  4 May 2022 15:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651679039;
        bh=jJYVOF65XbY/QhoDeI2ZVjpogs+998okYV/rZf0Ftq0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bmZL/dx/IGJNf11PKxL+15uVILHeBJOgSPqdtMJhl9tQauAqRT+okgdFU13AJIP5B
         q1bu1krQyGOBXokMl2xIgm06STREHQfE0Hkj2tjRyVaJ1dHA9Ohp6bo7nTlhG5h7fk
         RKU6GLYc7IV5OdERa3QUQQ5QhyZkAjuih1cLEW7IMDhq2w6/MLnKERP9gL59BJCvrJ
         ML7yHcJ55SjrLTMAOom+YCssrVPijfoeSrNEDn38smDPFVc39TCn1ENP2Vocls2HJF
         ZzCJixmXuTvNnFhmD1HVgoJ9Qs7kH4JtskiK4Urfeem8aiVI7xNYqsLg8lt1hVjcDv
         j6OmJVfdd24mg==
Received: by mail-pj1-f49.google.com with SMTP id w5-20020a17090aaf8500b001d74c754128so5556869pjq.0;
        Wed, 04 May 2022 08:43:59 -0700 (PDT)
X-Gm-Message-State: AOAM5308/1Qbif3gU9TmyHO4A5KpGjz3A/OMrAQBWd9hCrebFbIikDRm
        mjz+8bqRbjpqoF2QEevp5XTqDiRQbJLRdj0jEA==
X-Google-Smtp-Source: ABdhPJxkucuV8a41LdyYPvaUmw97Bg0ATupEharuX6qajHpWciC7tFXFEfRQjgpryCU/kUyZFOXlbZBrkmbL5LYQf48=
X-Received: by 2002:a17:902:b694:b0:153:1d9a:11a5 with SMTP id
 c20-20020a170902b69400b001531d9a11a5mr21806839pls.151.1651679038864; Wed, 04
 May 2022 08:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220429130221.32113-1-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <20220429130221.32113-1-bharat.kumar.gogada@xilinx.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 4 May 2022 10:43:47 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJkHRbXoHdgDYgeF5JhdPgDhjCg=W7YUmCRdBR8xSKz6A@mail.gmail.com>
Message-ID: <CAL_JsqJkHRbXoHdgDYgeF5JhdPgDhjCg=W7YUmCRdBR8xSKz6A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: xilinx-cpm: Change reg property order
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michals@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 29, 2022 at 8:02 AM Bharat Kumar Gogada
<bharat.kumar.gogada@xilinx.com> wrote:
>
> Describe cpm reg property before cfg reg property to align with
> node name.

The order is an ABI. If breaking it is okay, explain why here.

>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  .../devicetree/bindings/pci/xilinx-versal-cpm.yaml     | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> index 32f4641085bc..cca395317a4c 100644
> --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> @@ -18,13 +18,13 @@ properties:
>
>    reg:
>      items:
> -      - description: Configuration space region and bridge registers.
>        - description: CPM system level control and status registers.
> +      - description: Configuration space region and bridge registers.
>
>    reg-names:
>      items:
> -      - const: cfg
>        - const: cpm_slcr
> +      - const: cfg
>
>    interrupts:
>      maxItems: 1
> @@ -86,9 +86,9 @@ examples:
>                         ranges = <0x02000000 0x0 0xe0000000 0x0 0xe0000000 0x0 0x10000000>,
>                                  <0x43000000 0x80 0x00000000 0x80 0x00000000 0x0 0x80000000>;
>                         msi-map = <0x0 &its_gic 0x0 0x10000>;
> -                       reg = <0x6 0x00000000 0x0 0x10000000>,
> -                             <0x0 0xfca10000 0x0 0x1000>;
> -                       reg-names = "cfg", "cpm_slcr";
> +                       reg = <0x0 0xfca10000 0x0 0x1000>,
> +                             <0x6 0x00000000 0x0 0x10000000>;
> +                       reg-names = "cpm_slcr", "cfg";
>                         pcie_intc_0: interrupt-controller {
>                                 #address-cells = <0>;
>                                 #interrupt-cells = <1>;
> --
> 2.17.1
>
