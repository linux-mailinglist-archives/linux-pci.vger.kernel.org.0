Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE9E59C8CB
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 21:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbiHVT1q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 15:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbiHVT0P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 15:26:15 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A303053012;
        Mon, 22 Aug 2022 12:22:17 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-11c4d7d4683so14087501fac.8;
        Mon, 22 Aug 2022 12:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=XYeCBMg131pB0j2VmNawT54IXYU5/MzkZ/BlFX3u31o=;
        b=zW/Pg9Pdr7uW0RIWjaoqNZnv14hYQVGyykcQqAK3k09aF8G2HXMjeFueDojFKuI6/S
         RCkmOyocS30zlU9mn2E3J2j0TUo1/u4pPXdkYQX+gDkDri47kAntwDcMZvWRhpZh0wB6
         METVfb20UzTYcTaRF0T07Ymckybx20ZfJMpUc2P9HmeKNiu7C5p/rgHo/fXPTuNJyACT
         fkHoMR6vrJnL9NyoOcbudqypOJtnwhfZMHOBKJlD2ByflEut6jegDWSCWBp4haaIXK8B
         gVhpbs31L5jxQc66SR/tXoDFgxwAZRv47gfSqvRxtKpgEsEj4pCxChpl9lngjHYRFVeE
         Z3Zg==
X-Gm-Message-State: ACgBeo1RT3CT6nfA13I2rHTQMsHW6znQqykCvtUaSHv0UdIwhGtzSY/N
        Xlq26fEoV+2D0kbhLOZ+TA==
X-Google-Smtp-Source: AA6agR4C6U0o8E+u7YSuackcXgmLM/+ZYuWOzjyzdDV3bdDWFS1RQQRbmCvkIUaUBWmg8TrLD6DxVw==
X-Received: by 2002:a05:6870:2499:b0:101:7531:c7ec with SMTP id s25-20020a056870249900b001017531c7ecmr13481946oaq.42.1661196135861;
        Mon, 22 Aug 2022 12:22:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k5-20020a544405000000b003352223a14asm2767770oiw.15.2022.08.22.12.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:22:15 -0700 (PDT)
Received: (nullmailer pid 292234 invoked by uid 1000);
        Mon, 22 Aug 2022 19:22:14 -0000
Date:   Mon, 22 Aug 2022 14:22:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 3/7] dt-bindings: PCI: microchip,pcie-host: fix
 missing dma-ranges
Message-ID: <20220822192214.GA292150-robh@kernel.org>
References: <20220819231415.3860210-1-mail@conchuod.ie>
 <20220819231415.3860210-4-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819231415.3860210-4-mail@conchuod.ie>
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

On Sat, 20 Aug 2022 00:14:12 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The dma-ranges property was missed when adding the binding initially.
> The root port can use up to 6 address translation tables, depending on
> configuration.
> 
> Link: https://www.microsemi.com/document-portal/doc_download/1245812-polarfire-fpga-and-polarfire-soc-fpga-pci-express-user-guide # Section 1.3.3
> Fixes: 6ee6c89aac35 ("dt-bindings: PCI: microchip: Add Microchip PolarFire host binding")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/pci/microchip,pcie-host.yaml          | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
