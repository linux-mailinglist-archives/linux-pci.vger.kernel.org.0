Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813D45705CC
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 16:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiGKOix (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 10:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiGKOir (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 10:38:47 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB6C110F;
        Mon, 11 Jul 2022 07:38:45 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id v2so3118641ilo.7;
        Mon, 11 Jul 2022 07:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QI8NoXmTu99A3BGvUDI/8ShLiNFWmdGoMBR5ix0lWDo=;
        b=isFWdPpUsJEtb3YRqEZyVZhJdZUgu6rdoaukTP8lBnC3z2f8C7vYXvm2NozLaGg5lw
         TFT+4lZQc/RFEFZASQzNz5nrZ26Rq7RFhrgBV3/fE3CzHSq5cXToSiHuDJPqyaNQ5QHt
         1Jd2jl9+CPja65JysdSisuAhBlzoUvkd6PDuUJR0xITokLDEytfr2rTagL4+aMTOGhJU
         QIaw6qW9wxPgyoZKgO0PMu7xZ9TQy9kugpNSk61mLCmWJSjzITQQeJb7tFRyk+8nDdyu
         4wUkkh36wnL4qH/SC6upR4gYHa6zj6Ka2yrx9ZYNxPqpXf8szltwE20H5nBHbfJYyn2b
         l0Vg==
X-Gm-Message-State: AJIora+vMsqjZHl2nThta2mBgmSov+a5uKhzx5UHgiCbN5Q9ujwoqOws
        rHm+K3A2uEjcZzx1T5ZkCA==
X-Google-Smtp-Source: AGRyM1vv3IGpJxVA3/ctWFf3shZBxzdiPh3c5Ui151b/79yHG8d9Nn0GwZ8SPYFxfnp8pK50KoGb7g==
X-Received: by 2002:a05:6e02:164b:b0:2dc:85e3:238b with SMTP id v11-20020a056e02164b00b002dc85e3238bmr1220980ilu.121.1657550324397;
        Mon, 11 Jul 2022 07:38:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r16-20020a92c5b0000000b002dad39ff841sm2787827ilt.19.2022.07.11.07.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 07:38:44 -0700 (PDT)
Received: (nullmailer pid 3845949 invoked by uid 1000);
        Mon, 11 Jul 2022 14:38:42 -0000
Date:   Mon, 11 Jul 2022 08:38:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     kthota@nvidia.com, sagar.tv@gmail.com, lpieralisi@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        kishon@ti.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, jonathanh@nvidia.com,
        gustavo.pimentel@synopsys.com, linux-tegra@vger.kernel.org,
        thierry.reding@gmail.com, mmaddireddy@nvidia.com,
        jingoohan1@gmail.com, kw@linux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 3/9] dt-bindings: PCI: tegra234: Add schema for
 tegra234 endpoint mode
Message-ID: <20220711143842.GA3840001-robh@kernel.org>
References: <20220707081301.29961-1-vidyas@nvidia.com>
 <20220707081301.29961-4-vidyas@nvidia.com>
 <1657196871.476299.1454231.nullmailer@robh.at.kernel.org>
 <afc9cd15-a895-792f-3f49-1dca3694b0f3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afc9cd15-a895-792f-3f49-1dca3694b0f3@nvidia.com>
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

On Sat, Jul 09, 2022 at 08:03:45AM +0530, Vidya Sagar wrote:
> 
> 
> On 7/7/2022 5:57 PM, Rob Herring wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Thu, 07 Jul 2022 13:42:55 +0530, Vidya Sagar wrote:
> > > Add support for PCIe controllers that operate in the endpoint mode
> > > in tegra234 chipset.
> > > 
> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > ---
> > > V4:
> > > * Rebased on top of previous patch
> > > 
> > > V3:
> > > * New patch in this series
> > > 
> > >   .../bindings/pci/nvidia,tegra194-pcie-ep.yaml | 123 +++++++++++++++++-
> > >   1 file changed, 117 insertions(+), 6 deletions(-)
> > > 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.example.dtb: pcie-ep@141a0000: Unevaluated properties are not allowed ('nvidia,enable-ext-refclk' was unexpected)
> >          From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/patch/
> > 
> > This check can fail if there are any dependencies. The base for a patch
> > series is generally the most recent rc1.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit.
> 
> I did run 'make dt_binding_check' before sending the patches for review and
> didn't observe any issue. Just to make sure that I observe the same issue
> locally, I updated dtschema and gave DT_CHECKER_FLAGS=-m and yet didn't
> observe the tool reporting any issue.
> FWIW, I think I missed adding the documentation for
> 'nvidia,enable-ext-refclk' property. I'll add it and send again, but before
> that, I would like to see if my change addresses the issue correctly and
> also there are no other issues. Could you please help me with why I'm not
> observing the issue locally?

There's a fix for unevaluatedProperties that's only in the dtschema main 
branch and not yet in a release.

Rob
