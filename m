Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF61659C8C2
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 21:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbiHVTX4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 15:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238582AbiHVTWF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 15:22:05 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF4A48EB7;
        Mon, 22 Aug 2022 12:21:32 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id h20-20020a056830165400b00638ac7ddba5so8371611otr.4;
        Mon, 22 Aug 2022 12:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=dLuy42xybjawVvlwKq6PcTXdKNjM/zlBr9syVIOuOUc=;
        b=Kg9JWkf56w3Bh9AyBps4C5jpIw5GZGoGt6rDJuxPpu3Zot9upIURlf18U9PTeuoVEY
         p5vKBW7Nc5u3PLsWER7xu9pRZ9/P9oQhXR0awbY0vQhMwYaAI7qPXjUb9TL6mRFY49WS
         luINECFy5u6hTsYrIDhG4XkqEZJhv7dHRvoTr29J5WtYS3/a3etR40q/wQEmuqN/dfpV
         TaAa65EexezcE0z12hwKlFraOgkl+1d8v7JdijONLB+JVia9Lnknd2nww/6AJlybpYLk
         G2Bp6p7Oiv9Zy+QGSyZhkMfbbvd2w9FsFy/AzfJTOHiEB64luwDcICCs1+JfYWsMZykx
         VHcg==
X-Gm-Message-State: ACgBeo392RwYb0R6hYFEwOrptWR2u/LfSaHfSdwYgm1kOnsoyq/n26Is
        tQZL+gqkl19uVEq46Q9nzA==
X-Google-Smtp-Source: AA6agR7ddkKQDSebPyTEWK0KoRUwJdvioaZ5/ox3N9C7Dih8cAiNGW2HHL0ILp2VaJE5MUM54nOLkg==
X-Received: by 2002:a9d:6019:0:b0:639:25fb:c8aa with SMTP id h25-20020a9d6019000000b0063925fbc8aamr2951391otj.64.1661196091707;
        Mon, 22 Aug 2022 12:21:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bx14-20020a0568081b0e00b003450abf4404sm2752855oib.21.2022.08.22.12.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:21:31 -0700 (PDT)
Received: (nullmailer pid 288097 invoked by uid 1000);
        Mon, 22 Aug 2022 19:21:30 -0000
Date:   Mon, 22 Aug 2022 14:21:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/7] dt-bindings: PCI: microchip,pcie-host: fix
 missing clocks properties
Message-ID: <20220822192130.GA288034-robh@kernel.org>
References: <20220819231415.3860210-1-mail@conchuod.ie>
 <20220819231415.3860210-3-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819231415.3860210-3-mail@conchuod.ie>
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

On Sat, 20 Aug 2022 00:14:11 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Recent versions of dt-schema warn about unevaluatedProperties:
> arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dtb: pcie@2000000000: Unevaluated properties are not allowed ('clock-names', 'clocks', 'legacy-interrupt-controller', 'microchip,axi-m-atr0' were unexpected)
>         From schema: Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> 
> The clocks are required to enable interfaces between the FPGA fabric
> and the core complex, so add them to the binding.
> 
> Fixes: 6ee6c89aac35 ("dt-bindings: PCI: microchip: Add Microchip PolarFire host binding")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> dt-schema v2022.08 is required to replicate
> ---
>  .../bindings/pci/microchip,pcie-host.yaml     | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
