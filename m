Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E761450EDD2
	for <lists+linux-pci@lfdr.de>; Tue, 26 Apr 2022 02:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240526AbiDZAub (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Apr 2022 20:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240562AbiDZAua (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Apr 2022 20:50:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86A88233F;
        Mon, 25 Apr 2022 17:47:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB226B81BBD;
        Tue, 26 Apr 2022 00:47:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C00CC385BC;
        Tue, 26 Apr 2022 00:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650934041;
        bh=kLamuQx/TZ/sNoIRw/5TAxBjveCbRpEZboY1GBz+FsU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ff3YbpHMajkkkQd7iGBvfo0jDfSl0+Es3gn64y/jL/MpVBIfCrSI2ej1Bb1CX9Cyj
         C/wyYFVOu8n8PmRIrl/23O/Sqdm3lKb5PugMl0sQYHUsO9rSI15ZUG7GJaonc3kfpw
         0lfX/waaN/3oLyl59rSWdx1VNwSYmRTsKnXYLStxl/SwhQMSIl/f5LLu/JUk//sAhw
         EL3RV3VwvrFpC85bQVAmoptp6PTvBCiNpoJvr+g7mEL9dVA6NyodDhPornLJEk2EYj
         8AootvLdDgj55S7H5PnBAArXtXwPDGUN7F0Ll0htf4vBlMHmB4/m9n04J2DpOHwBX8
         cYUyVp+VbqaRA==
Received: by mail-pf1-f171.google.com with SMTP id y38so673365pfa.6;
        Mon, 25 Apr 2022 17:47:21 -0700 (PDT)
X-Gm-Message-State: AOAM531Vmxo9QAMLDi691J+p+9N/T/L4YS1zyFweoVCs8drCdPfx81F9
        3U2g+HVvZC/+X+g9PabnuwqQl2oi5jIOv25m4Q==
X-Google-Smtp-Source: ABdhPJycsc7NBLBhkO+uQw3aVqYzcavGPUv3sesqoIz5RMiNfznfUgjgBNTclu+0EbdqOtljNB8bkZ9ZkyhqfqI73qY=
X-Received: by 2002:a05:6a00:10d0:b0:4f7:5af4:47b6 with SMTP id
 d16-20020a056a0010d000b004f75af447b6mr21383086pfu.6.1650934040893; Mon, 25
 Apr 2022 17:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220422120850.769480-1-herve.codina@bootlin.com>
 <20220422120850.769480-2-herve.codina@bootlin.com> <YmdAqGyl5pyjvwX+@robh.at.kernel.org>
In-Reply-To: <YmdAqGyl5pyjvwX+@robh.at.kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 25 Apr 2022 19:47:08 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+CZs_0X5R19R86Vck3BeMKYqhNUeZnvZ_YSwuA8ZH3Eg@mail.gmail.com>
Message-ID: <CAL_Jsq+CZs_0X5R19R86Vck3BeMKYqhNUeZnvZ_YSwuA8ZH3Eg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: PCI: pci-rcar-gen2: Convert bindings
 to json-schema
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 25, 2022 at 7:45 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Apr 22, 2022 at 02:08:43PM +0200, Herve Codina wrote:
> > Convert Renesas PCI bridge bindings documentation to json-schema.
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  .../devicetree/bindings/pci/pci-rcar-gen2.txt |  84 ----------
> >  .../bindings/pci/renesas,pci-rcar-gen2.yaml   | 156 ++++++++++++++++++
> >  2 files changed, 156 insertions(+), 84 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> >  create mode 100644 Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
>
> > diff --git a/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
> > new file mode 100644
> > index 000000000000..494eb975c146
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
> > @@ -0,0 +1,156 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/renesas,pci-rcar-gen2.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas AHB to PCI bridge
> > +
> > +maintainers:
> > +  - Marek Vasut <marek.vasut+renesas@gmail.com>
> > +  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > +
> > +description: |
> > +  This is the bridge used internally to connect the USB controllers to the
> > +  AHB. There is one bridge instance per USB port connected to the internal
> > +  OHCI and EHCI controllers.
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-bus.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
>
> Don't need oneOf with only 1 entry. Otherwise,

Nevermind, I see you need it in the next patch.

>
> Reviewed-by: Rob Herring <robh@kernel.org>
>
> > +          - enum:
> > +              - renesas,pci-r8a7742      # RZ/G1H
> > +              - renesas,pci-r8a7743      # RZ/G1M
> > +              - renesas,pci-r8a7744      # RZ/G1N
> > +              - renesas,pci-r8a7745      # RZ/G1E
> > +              - renesas,pci-r8a7790      # R-Car H2
> > +              - renesas,pci-r8a7791      # R-Car M2-W
> > +              - renesas,pci-r8a7793      # R-Car M2-N
> > +              - renesas,pci-r8a7794      # R-Car E2
> > +          - const: renesas,pci-rcar-gen2 # R-Car Gen2 and RZ/G1
> > +
