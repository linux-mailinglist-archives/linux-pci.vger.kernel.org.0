Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3178F5960DF
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 19:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiHPRQ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 13:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiHPRQ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 13:16:56 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DED7B1D3;
        Tue, 16 Aug 2022 10:16:55 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id x64so8741876iof.1;
        Tue, 16 Aug 2022 10:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=D6Sgt43wReIJnABbhCpmxjkDmeNfZCDyXj29Wo+CNs8=;
        b=oqsGkJNcK9PlGa0hC+MpVDFoUX2AprOvdi8mcPanOLRigWx5JGABs70fBOcrv7GAs4
         hpBEgIuLq9Q7UqJqxXfU8n2kW/d4KJit8+JrVLt4tZ3MctWzoIhXA/NcPrSqUCIkRjFt
         htf9Cuflbo0A2gadI3GbF7dMUQvNC28FQ8DO9uE3+UDyUv787MXbjxhkAqrEmbhtEWpp
         SWzaoDgGCZnrwQvp64iZY2e39+5C9b0V8Q0abt3xNuHqj/po1qelVRrDH1ysYQFHYC0r
         lUD6SB0i7Iz2VW7v6KBZrO31eKKRIwGNPLfAT4GBAKxiKe3XT9kvKTQ+fcvdHdaTITOW
         3Isg==
X-Gm-Message-State: ACgBeo1Vmpe62eEieuI9yIefLFt1ug2dowkVxwF7ihWtnpkhz+/E1oMH
        vl32G2c8ZyanLuqG0rS0Rw==
X-Google-Smtp-Source: AA6agR4UoyqZp5rPDlBv+twyXjIBp3pBBc8VUd5rGKNF9vZzXP9/deWo2SFDDC4yGZQAjMi/xA1z6A==
X-Received: by 2002:a05:6638:1450:b0:346:8b01:c980 with SMTP id l16-20020a056638145000b003468b01c980mr4307459jad.286.1660670214577;
        Tue, 16 Aug 2022 10:16:54 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f24-20020a02a118000000b00339df77c491sm4536515jag.114.2022.08.16.10.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:16:54 -0700 (PDT)
Received: (nullmailer pid 2399174 invoked by uid 1000);
        Tue, 16 Aug 2022 17:16:52 -0000
Date:   Tue, 16 Aug 2022 11:16:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor.Dooley@microchip.com
Cc:     krzysztof.kozlowski@linaro.org, mail@conchuod.ie,
        Daire.McNamara@microchip.com, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 4/4] dt-bindings: PCI: microchip,pcie-host: fix missing
 address translation property
Message-ID: <20220816171652.GA2390778-robh@kernel.org>
References: <20220811203306.179744-1-mail@conchuod.ie>
 <20220811203306.179744-5-mail@conchuod.ie>
 <edf3da1b-79dc-4e09-8d3e-73aca09e847f@linaro.org>
 <0dd12c70-70f9-1dc1-c5c8-a3ff15be81f6@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dd12c70-70f9-1dc1-c5c8-a3ff15be81f6@microchip.com>
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

On Fri, Aug 12, 2022 at 08:20:45AM +0000, Conor.Dooley@microchip.com wrote:
> On 12/08/2022 08:52, Krzysztof Kozlowski wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On 11/08/2022 23:33, Conor Dooley wrote:
> >> From: Conor Dooley <conor.dooley@microchip.com>
> >>
> >> When the PCI controller node was added to the PolarFire SoC dtsi,
> >> dt-schema was not able to detect the presence of some undocumented
> >> properties due to how it handled unevaluatedProperties. v2022.08
> >> introduces better validation, producing the following error:
> >>
> >> arch/riscv/boot/dts/microchip/mpfs-polarberry.dtb: pcie@2000000000: Unevaluated properties are not allowed ('clock-names', 'microchip,axi-m-atr0' were unexpected)
> >>          From schema: Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> >>
> >> Fixes: 528a5b1f2556 ("riscv: dts: microchip: add new peripherals to icicle kit device tree")
> >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >> ---
> >> I feel like there's a pretty good chance that this is not the way this
> >> should have been done and the property should be marked as deprecated
> >> but I don't know enough about PCI to answer that.
> > 
> > It seems bindings were added incomplete and now based on DTS (which did
> > not match bindings), we keep adding "missing" properties. I don't think
> > it is good. It creates a precedence where someone might intentionally
> > sneak limited bindings (without controversial property) and later claim
> > "I forgot to include foo,bar".
> 
> Yup, again pretty much the same thoughts as me. I don't think that, even
> if the property is valid, should be either named as it is or only work
> for translation table 0.
> 
> > 
> > Therefore the property should pass review just like it is newly added
> > property.
> 
> SGTM.
> 
> > 
> >> ---
> >>   .../devicetree/bindings/pci/microchip,pcie-host.yaml  | 11 +++++++++++
> >>   1 file changed, 11 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> >> index 9b123bcd034c..9ac34b33c4b2 100644
> >> --- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> >> +++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> >> @@ -71,6 +71,17 @@ properties:
> >>     msi-parent:
> >>       description: MSI controller the device is capable of using.
> >>
> >> +  microchip,axi-m-atr0:
> > 
> > Name is not helping. If it is offset, add such suffix (see
> > brcm,iproc-pcie.yaml).
> > 
> > Unfortunately I don't know PCIe good enough to judge whether the
> > property makes any sense or some other ranges-style should be used.
> 
> Yup, I think it is similar to that. Except we have 4 tables rather
> than one.

Looks to me like dma-ranges is the answer.

Rob
