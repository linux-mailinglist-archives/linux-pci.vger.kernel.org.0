Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704F34E9C30
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 18:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242075AbiC1QZf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 12:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242077AbiC1QZe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 12:25:34 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBF522BDD;
        Mon, 28 Mar 2022 09:23:54 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id e189so16122386oia.8;
        Mon, 28 Mar 2022 09:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U9oG+yUHi85HjMlVTLwN9ypplBDcaxhapIf5JTbt5ls=;
        b=enPdR7E7FmA9o9XHV7/pbYhYBoczd6p7WFVrcH0NqUqXN4bV+oT3r6G9kohoOvWNYv
         ve6JZgxhwHFkle6RJfunz5yv9fRI08OGBMAAa78LlD45a2B2TexB33eDsJyalYSqtffL
         Hp1h/Y7A2wQ3xQ5qQj7g0ewuQhd4VOpSLaC3PQT1+b4aQCfwmEvjxttZZoFUjXAkdfWk
         Q8LbaK2u6r/fouXUFz7ZLYqeTDFmVUSj4UQknpCMe14dYlG1k2LST0zEIW5bA2OQb/7p
         JwwnKw1GbxNhmpXnGPNKgXDslX98bV6VXDOGp43Eg6wlxnMMRs/VJRpIBcY8Q1zRbJoX
         xbLQ==
X-Gm-Message-State: AOAM5321Fe7SD7rOQUWtOL2AuFq6mpisyq2XSOScySW4UQRyWisatTl7
        huCB3ON1iqytxsF9pwaGqA==
X-Google-Smtp-Source: ABdhPJyppQiP1Xz7up2rltmPfDf+oxHhUQbblcJindIMn7cEwKElDaZkb8FxN4R3FwcCV6grec3FYQ==
X-Received: by 2002:a05:6808:1508:b0:2ec:f48e:df65 with SMTP id u8-20020a056808150800b002ecf48edf65mr12450066oiw.125.1648484633346;
        Mon, 28 Mar 2022 09:23:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bg39-20020a056820082700b00324c8eba341sm5889944oob.18.2022.03.28.09.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 09:23:52 -0700 (PDT)
Received: (nullmailer pid 2500181 invoked by uid 1000);
        Mon, 28 Mar 2022 16:23:51 -0000
Date:   Mon, 28 Mar 2022 11:23:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: uniphier: Convert uniphier-pcie.txt to
 json-schema
Message-ID: <YkHhF7dF9SYS2qTx@robh.at.kernel.org>
References: <1648433498-23450-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1648471865.799906.2153573.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648471865.799906.2153573.nullmailer@robh.at.kernel.org>
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

On Mon, Mar 28, 2022 at 07:51:05AM -0500, Rob Herring wrote:
> On Mon, 28 Mar 2022 11:11:38 +0900, Kunihiko Hayashi wrote:
> > Convert the file into a JSON description at the yaml format.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  .../bindings/pci/socionext,uniphier-pcie.yaml | 100 ++++++++++++++++++
> >  .../devicetree/bindings/pci/uniphier-pcie.txt |  82 --------------
> >  MAINTAINERS                                   |   2 +-
> >  3 files changed, 101 insertions(+), 83 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1609988
> 
> 
> pcie@66000000: compatible: ['socionext,uniphier-pcie', 'snps,dw-pcie'] is too long
> 	arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dt.yaml
> 	arch/arm64/boot/dts/socionext/uniphier-ld20-global.dt.yaml
> 	arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dt.yaml
> 	arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dt.yaml

Ignore this if your intent is to fix these by dropping 'snps,dw-pcie'. I 
think that is the right thing to do. 'snps,dw-pcie' is not too 
meaningful.

Rob
