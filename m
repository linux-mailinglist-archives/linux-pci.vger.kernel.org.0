Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821C2528C09
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 19:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241348AbiEPRfl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 13:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbiEPRfl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 13:35:41 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC64FE0;
        Mon, 16 May 2022 10:35:39 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id v65so19432070oig.10;
        Mon, 16 May 2022 10:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yRCFWuG9Oqb4uyJxObAmt3C9VXrpqbJosiPlLmLl9sI=;
        b=EL75QSO/lgYeNiZgrLVbcg77+Bv4AXPDhgQnM6AMtVimqrFACrrRpr552wx4P6vN2O
         P8ib7jaN3w1SepZKhFE2SXR7o/nbkWcBFbwi0tvJ9dLC1idY/9lwP6mTcXMq+5WGSV/X
         5ehwlqMXNLZvVpElhj9kiBSyQqhVy5lmL6dMNFYHKFpJbuHfxw9opjxe9yvWbAO0IEEj
         Us2abEo2VFSndd6V6A96WfDn+Lf7vL0AKznmXiwZCWlzS0Uf/Btzb60/9p5LkypXdP+i
         PZh9osyEK8a7MmxE8abLr1rVWhEj6cPpIjY/LrMVozqz/WBS0lqFXr4BeI18uzVvUgtu
         XvCQ==
X-Gm-Message-State: AOAM533gNJBDBoYD4bXokjmaAcvTWSKdaLSSP8XvblsqdcERyflJd1N6
        qt+GwudkRwm8tNna9wAmFg==
X-Google-Smtp-Source: ABdhPJxuclwaDZzyOItOmmGD3yThwcNVeOZQs+WOMuvGRRbmejydML51xYl4owmx8halO8SP4Fl2pw==
X-Received: by 2002:a05:6808:1703:b0:2f9:cd2d:41c5 with SMTP id bc3-20020a056808170300b002f9cd2d41c5mr14114818oib.77.1652722539072;
        Mon, 16 May 2022 10:35:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v2-20020a056870310200b000e686d1386csm5670158oaa.6.2022.05.16.10.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 10:35:38 -0700 (PDT)
Received: (nullmailer pid 2952486 invoked by uid 1000);
        Mon, 16 May 2022 17:35:37 -0000
Date:   Mon, 16 May 2022 12:35:37 -0500
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
Message-ID: <20220516173537.GA2942634-robh@kernel.org>
References: <20220514115946.8858-1-linux@fw-web.de>
 <20220514115946.8858-2-linux@fw-web.de>
 <1652570081.002742.3276245.nullmailer@robh.at.kernel.org>
 <trinity-02ad648c-f6f8-4383-b389-a0578d5a02d2-1652615387162@3c-app-gmx-bap15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-02ad648c-f6f8-4383-b389-a0578d5a02d2-1652615387162@3c-app-gmx-bap15>
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

On Sun, May 15, 2022 at 01:49:47PM +0200, Frank Wunderlich wrote:
> Hi
> 
> > Gesendet: Sonntag, 15. Mai 2022 um 01:14 Uhr
> > Von: "Rob Herring" <robh@kernel.org>
> 
> > On Sat, 14 May 2022 13:59:42 +0200, Frank Wunderlich wrote:
> > > From: Frank Wunderlich <frank-w@public-files.de>
> > >
> > > Add a new binding file for Rockchip PCIe v3 phy driver.
> > >
> > > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > >
> > > ---
> > > v3:
> > > - drop quotes
> > > - drop rk3588
> > > - make clockcount fixed to 3
> > > - full path for binding header file
> > > - drop phy-mode and its header and add lane-map
> > >
> > > v2:
> > > dt-bindings: rename yaml for PCIe v3
> > > rockchip-pcie3-phy.yaml => rockchip,pcie3-phy.yaml
> > >
> > > changes in pcie3 phy yaml
> > > - change clock names to ordered const list
> > > - extend pcie30-phymode description
> > > - add phy-cells to required properties
> > > - drop unevaluatedProperties
> > > - example with 1 clock each line
> > > - use default property instead of text describing it
> > > - update license
> > > ---
> > >  .../bindings/phy/rockchip,pcie3-phy.yaml      | 82 +++++++++++++++++++
> > >  1 file changed, 82 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
> > >
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml: properties:clock-names: 'oneOf' conditional failed, one must be fixed:
> > 	[{'const': 'refclk_m'}, {'const': 'refclk_n'}, {'const': 'pclk'}] is too long
> > 	[{'const': 'refclk_m'}, {'const': 'refclk_n'}, {'const': 'pclk'}] is too short
> > 	False schema does not allow 3
> > 	1 was expected
> > 	3 is greater than the maximum of 2
> > 	hint: "minItems" is only needed if less than the "items" list length
> > 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml: ignoring, error in schema: properties: clock-names
> > Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.example.dtb:0:0: /example-0/phy@fe8c0000: failed to match any schema with compatible: ['rockchip,rk3568-pcie3-phy']
> 
> seems this is fixed when i remove the "minItems: 3" from clock names 
> (which is already fixed length because of the list).

Yes.

> needed to change type of lane-map to this:
> 
> $ref: /schemas/types.yaml#/definitions/uint8-array

Why? That's not a standard property though, so needs a 'rockchip' 
prefix. Though maybe a common property would be appropriate here.

> then it looks clean for it....
> 
> -m causes many errors unrelated to this schema-file even if i pass
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml

The fix is fixing the remaining 40 or so '-m' errors.

Rob
