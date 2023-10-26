Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76967D8868
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 20:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjJZSfG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Oct 2023 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjJZSfG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2023 14:35:06 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8D51AE;
        Thu, 26 Oct 2023 11:35:04 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ce291b5df9so664994a34.2;
        Thu, 26 Oct 2023 11:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698345303; x=1698950103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJ5d2hJDyEPiZfzXMV+6c/eLpjUEHH1CIiOk9L8U4nQ=;
        b=p+z0xdZKgjmn28bf6bclX6EqOdKxTQhmMfAJdR14Q0w4VJv55S1qMM3ThuKdBQdHsL
         KlyI3lkOQU3W9wjXfEdtgsnx7mHXmW1nd8jE06QpKx8nhTMfPFRWiHnn1vHgHXWsQaDF
         pSWeyJ3x0SIwoZzOqnGOHOxdaPn/aL8GFvGrduETXBWbLpmAwilHQdd0pYri2zfW8+JK
         yaSQIGs15FXSpfevaoejDld5U9E3k+F9Wb45FxxMHffRa5kJVer6vxAeoaqT86mLBiO0
         D0IpGNtyFHGO7+dDSj9A1oh8RzQRNitJUbsRcpDqfW5XoP7bhS0j/T72gEXYFdsPHvSA
         u8SQ==
X-Gm-Message-State: AOJu0YxJRcTTUsNYCRo5XoxAP0UEaGxEgQqvr+hELghRuuUE78bF7QuK
        6Oa3sRr0sbyGZIUs1RRxjw==
X-Google-Smtp-Source: AGHT+IHUq+P2QKP2fK2MoJoveneBRt5qk3HCQylAhpNlbJSEDvZ7ZU+kZLkStB9OmmUewoPfot46MQ==
X-Received: by 2002:a05:6830:12c1:b0:6bc:de95:a639 with SMTP id a1-20020a05683012c100b006bcde95a639mr276977otq.16.1698345303599;
        Thu, 26 Oct 2023 11:35:03 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c23-20020a9d6c97000000b006c619f17669sm2733614otr.74.2023.10.26.11.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 11:35:02 -0700 (PDT)
Received: (nullmailer pid 4157785 invoked by uid 1000);
        Thu, 26 Oct 2023 18:35:01 -0000
Date:   Thu, 26 Oct 2023 13:35:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Conor Dooley <conor@kernel.org>, Niklas Cassel <nks@flawful.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: PCI: dwc: rockchip: Add atu property
Message-ID: <20231026183501.GB4122054-robh@kernel.org>
References: <20231024151014.240695-1-nks@flawful.org>
 <20231024151014.240695-2-nks@flawful.org>
 <20231024-zoology-preteen-5627e1125ae0@spud>
 <ZTl0VwdFYt9kqxtp@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTl0VwdFYt9kqxtp@x1-carbon>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 25, 2023 at 08:02:32PM +0000, Niklas Cassel wrote:
> Hello Conor,
> 
> On Tue, Oct 24, 2023 at 05:29:28PM +0100, Conor Dooley wrote:
> > On Tue, Oct 24, 2023 at 05:10:08PM +0200, Niklas Cassel wrote:
> > > From: Niklas Cassel <niklas.cassel@wdc.com>
> > > 
> > > Even though rockchip-dw-pcie.yaml inherits snps,dw-pcie.yaml
> > > using:
> > > 
> > > allOf:
> > >   - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > > 
> > > and snps,dw-pcie.yaml does have the atu property defined, in order to be
> > > able to use this property, while still making sure 'make CHECK_DTBS=y'
> > > pass, we need to add this property to rockchip-dw-pcie.yaml.
> > > 
> > > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > > ---
> > >  Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > > index 1ae8dcfa072c..229f8608c535 100644
> > > --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > > @@ -29,16 +29,20 @@ properties:
> > >            - const: rockchip,rk3568-pcie
> > >  
> > >    reg:
> > > +    minItems: 3
> > >      items:
> > >        - description: Data Bus Interface (DBI) registers
> > >        - description: Rockchip designed configuration registers
> > >        - description: Config registers
> > > +      - description: iATU registers
> > 
> > Is this extra register only for the ..88 or for the ..68 and for the
> > ..88 models?
> 
> Looking at the rk3568 Technical Reference Manual (TRM):
> https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part2%20V1.1-20210301.pdf
> 
> The iATU register register range exists for all 3 PCIe controllers
> found on the rk3568.
> 
> This register range is currently not defined in the rk3568.dtsi, so the driver
> will currently use the default register offset (which is correct), but with
> the driver fallback register size that is only big enough to cover 8 inbound
> and 8 outbound iATUs (internal Address Translation Units).

We should probably make the driver smarter instead or in addition. We 
have the DBI size, Just make atu_size = dbi_size - DEFAULT_DBI_ATU_OFFSET.

> According to the TRM, all three PCIe controllers found on the rk3568 have
> 16 inbound iATUs and 16 outbound iATUs, so if someone wants to be able to
> make use of all the iATUs on the rk3568, they will need to add "atu" to
> rk3568.dtsi.

At least for host side, the number of regions used is based on ranges. 
You'd be hard pressed to need more than 8. That or no h/w with 16 is 
probably why I said 8 was enough at the time.

Rob
