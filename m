Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6F559C8A2
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 21:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbiHVTWA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 15:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238718AbiHVTU7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 15:20:59 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D831583A;
        Mon, 22 Aug 2022 12:20:35 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id j5so13376165oih.6;
        Mon, 22 Aug 2022 12:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=B6xw/Cz6pu5G+t2AHd6LglUUHVajl9/hwpJ6XbtejIs=;
        b=jf2i0REGfeGAEsZpvQ+yfFHq2tdOtKjycUxCddKs59IHpCLFiiW9nanULotezym8aM
         ZJGeXMBHP+3EecnuCL86Nq/LhJmqIlYDo56kqg877LB7sXROtZWWpwjkmuRgOfIj2FY0
         sLoBAG3Am80OgFTtDrRb8CzkhN8zdiIktg1XTCRWAP5PJsxf4NOY/IdoaowO7J3Q8rZl
         HAL/AvdyNV68yYjSANgIRaLuO4DqVxpyNzy8LOw2BJHeZkzLFXfv5s4Y3ik3cQI+zpM2
         UswX0JQQsmDHGO6bjL0ZsqWFaucvy/8XFioNQHpqkD++/EeVr8iQTEqIQZjzwZUob342
         o9Ow==
X-Gm-Message-State: ACgBeo0TtICXsAwL24hDisNi8NDKFWJlaoAI79cwzWIw18/Mqn4QO8lh
        mD6VYm9p4luia7pbKibpgDR0ZzSkhg==
X-Google-Smtp-Source: AA6agR73zf1PIYrSd81xUVIR0DA6FXBmjDteQmGwPHo/nIcUUF1r97Vn6HNX0r+wQtaupfFJ2yrtNg==
X-Received: by 2002:aca:4189:0:b0:344:d96f:4635 with SMTP id o131-20020aca4189000000b00344d96f4635mr11556610oia.131.1661196034364;
        Mon, 22 Aug 2022 12:20:34 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p18-20020a4ad452000000b0041ba304546csm2628004oos.1.2022.08.22.12.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:20:34 -0700 (PDT)
Received: (nullmailer pid 283097 invoked by uid 1000);
        Mon, 22 Aug 2022 19:20:32 -0000
Date:   Mon, 22 Aug 2022 14:20:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        devicetree@vger.kernel.org, Greentime Hu <greentime.hu@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH v3 1/7] dt-bindings: PCI: fu740-pci: fix missing
 clock-names
Message-ID: <20220822192032.GA283027-robh@kernel.org>
References: <20220819231415.3860210-1-mail@conchuod.ie>
 <20220819231415.3860210-2-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819231415.3860210-2-mail@conchuod.ie>
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

On Sat, 20 Aug 2022 00:14:10 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The commit b92225b034c0 ("dt-bindings: PCI: designware: Fix
> 'unevaluatedProperties' warnings") removed the clock-names property as
> a requirement and from the example as it triggered unevaluatedProperty
> warnings. dtbs_check was not able to pick up on this at the time, but
> now can:
> 
> arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dtb: pcie@e00000000: Unevaluated properties are not allowed ('clock-names' was unexpected)
>         From schema: linux/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> 
> The property was already in use by the FU740 DTS and the clock must be
> enabled. The Linux and FreeBSD drivers require the property to enable
> the clocks correctly Re-add the property and its "clocks" dependency,
> while making it required.
> 
> Fixes: b92225b034c0 ("dt-bindings: PCI: designware: Fix 'unevaluatedProperties' warnings")
> Fixes: 43cea116be0b ("dt-bindings: PCI: Add SiFive FU740 PCIe host controller")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> v2022.08 of dt-schema is required.
> ---
>  .../devicetree/bindings/pci/sifive,fu740-pcie.yaml        | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
