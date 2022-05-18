Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE4252BF9A
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 18:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239753AbiERP4N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 11:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239766AbiERPz6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 11:55:58 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC9021AB;
        Wed, 18 May 2022 08:55:54 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id s12-20020a0568301e0c00b00605f30530c2so1625271otr.9;
        Wed, 18 May 2022 08:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pL9sXlkxO4wUxq+I5961tw5THWjp2m8gWvZxMl5uTTs=;
        b=RL9/c3i+0A9E+zy69T9HBDzadzzlYVGGcrzdaqkbV8GvBu1o6y9zQmXinjBydOndQq
         COZGi0bjdjbLkgArzoEPv4yhd0ZGNXvqwPVLgeJoCx1qO6vwSnUfeZpd6dOg2SJ4Ypce
         C+1hgcwLMHZQ73G3/ndj3kroNZV8nqJlJCHwqqR0RQQxt3wskxajac1SSdXrujqFII00
         CdcSORKWxasGWGoz6wyAsaMIvFPk2qh0e0yc8aRK9zInU7TNFTRZKB8ZMDf2isS34Cch
         XHzbqGKEoH5bSBMlxv9bK30piLGKEdrLc5Q9Z9xgEMKsHISgKqMjAHEENwLPqFA6c3j/
         /TPQ==
X-Gm-Message-State: AOAM5331HbV7kzCOkQk+0uHyiS+hG227hJU946VZjMXZLc7QMADQwGnZ
        MobdFSwx1vd9rxoGyY3C5A==
X-Google-Smtp-Source: ABdhPJxiry19r1K5KnHA2+Vc2jieYBIM7bIX3w1IUZHtsbb6TFULxR9rOzLG/JZJSgpOalKPbr31YA==
X-Received: by 2002:a05:6830:2387:b0:606:4470:133 with SMTP id l7-20020a056830238700b0060644700133mr120520ots.133.1652889353575;
        Wed, 18 May 2022 08:55:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i131-20020acaea89000000b00325cda1ffbasm846556oih.57.2022.05.18.08.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 08:55:52 -0700 (PDT)
Received: (nullmailer pid 3393244 invoked by uid 1000);
        Wed, 18 May 2022 15:55:51 -0000
Date:   Wed, 18 May 2022 10:55:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Vinod Koul <vkoul@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: Re: [RFC v3 1/5] dt-bindings: phy: rockchip: add PCIe v3 phy
Message-ID: <20220518155551.GB3302100-robh@kernel.org>
References: <20220514115946.8858-1-linux@fw-web.de>
 <20220514115946.8858-2-linux@fw-web.de>
 <1652570081.002742.3276245.nullmailer@robh.at.kernel.org>
 <trinity-02ad648c-f6f8-4383-b389-a0578d5a02d2-1652615387162@3c-app-gmx-bap15>
 <20220516173537.GA2942634-robh@kernel.org>
 <9496CAFB-6CB6-4BDA-A539-3A6E1B562299@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9496CAFB-6CB6-4BDA-A539-3A6E1B562299@public-files.de>
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

On Mon, May 16, 2022 at 09:21:31PM +0200, Frank Wunderlich wrote:
> Am 16. Mai 2022 19:35:37 MESZ schrieb Rob Herring <robh@kernel.org>:
> >On Sun, May 15, 2022 at 01:49:47PM +0200, Frank Wunderlich wrote:
> >> Hi
> >> 
> >> > Gesendet: Sonntag, 15. Mai 2022 um 01:14 Uhr
> >> > Von: "Rob Herring" <robh@kernel.org>
> >> 
> >> > On Sat, 14 May 2022 13:59:42 +0200, Frank Wunderlich wrote:
> 
> >Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
> >> > >
> >> >
> >> > My bot found errors running 'make DT_CHECKER_FLAGS=-m
> >dt_binding_check'
> >> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >> >
> >> > yamllint warnings/errors:
> >> >
> >> > dtschema/dtc warnings/errors:
> >> >
> >/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml:
> >properties:clock-names: 'oneOf' conditional failed, one must be fixed:
> >> > 	[{'const': 'refclk_m'}, {'const': 'refclk_n'}, {'const': 'pclk'}]
> >is too long
> >> > 	[{'const': 'refclk_m'}, {'const': 'refclk_n'}, {'const': 'pclk'}]
> >is too short
> >> > 	False schema does not allow 3
> >> > 	1 was expected
> >> > 	3 is greater than the maximum of 2
> >> > 	hint: "minItems" is only needed if less than the "items" list
> >length
> >> > 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> >> >
> >/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml:
> >ignoring, error in schema: properties: clock-names
> >> >
> >Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.example.dtb:0:0:
> >/example-0/phy@fe8c0000: failed to match any schema with compatible:
> >['rockchip,rk3568-pcie3-phy']
> >> 
> >> seems this is fixed when i remove the "minItems: 3" from clock names 
> >> (which is already fixed length because of the list).
> >
> >Yes.
> >
> >> needed to change type of lane-map to this:
> >> 
> >> $ref: /schemas/types.yaml#/definitions/uint8-array
> >
> >Why? That's not a standard property though, so needs a 'rockchip' 
> >prefix. Though maybe a common property would be appropriate here.
> 
> Originally it was a bool property named "rockchip,bifurcation" and we 
> changed it (after comments) to be a more generic property "lane-map" 
> that can be re-used on other vendors/controllers/phys.

Fair enough. The type needs to be defined in a common binding though. 
phy/phy-provider.yaml in dtschema probably.

We already have clock-lanes and data-lanes for other serdes interfaces. 
Maybe data-lanes works here?

> Driver reads as u8 array and range is small enough for u8 even if 
> used for larger controllers (e.g. PCIe x16).

Not arguing that it shouldn't be, just confused how the type was related 
to warnings.

> 
> >> then it looks clean for it....
> >> 
> >> -m causes many errors unrelated to this schema-file even if i pass
> >>
> >DT_SCHEMA_FILES=Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
> >
> >The fix is fixing the remaining 40 or so '-m' errors.
> 
> So now clean for you(r bot), too? Did only get a bunch of other unrelated messages.

No, the bot does a baseline build and extracts the diff in warnings. 
Still too many warnings popping up frequently... :(

Rob
