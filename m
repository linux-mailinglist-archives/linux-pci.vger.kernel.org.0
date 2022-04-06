Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5AB4F6972
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 20:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiDFSzC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Apr 2022 14:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiDFSwU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2022 14:52:20 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038972CCAF;
        Wed,  6 Apr 2022 11:14:01 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id t21so3214371oie.11;
        Wed, 06 Apr 2022 11:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H0QnhyvMcyeV2GoiwbyXURkXVFnwPb25uAf5GGlcDj8=;
        b=yKEw84dgk95sVPIK6YmwK0pkGQdmw/v0sZr0CNdaN5JfFwktXkOw+uZf8ub+vO5IGr
         vdkaQAjDFHFXZK2MlTF9Vy/zIpW6pM9nJubC4TOVEzSs6wyI2SHhIVX1qStZ3Og4Z90k
         mTdxjga+eJXnsGHpdKLMS+VstKtzwMwvAPUOqmU1BamlMO7Y4yjRE3mLXuvYhVGJktwm
         y6CuPJfsZawxYt72jpPXUJH4scEuJ11/Wnr08o2Ez5WZAFJJcJ3u+98yCTcVbS/Z5LPl
         9VK247rKAEztBKQlWpZsPseKEBxkEXuFhtW5ic1sblWw4j2Xcbr+qm2NG7qlOpRVn+jg
         vzwQ==
X-Gm-Message-State: AOAM53089aNiK+pCilcBOSAAFJpiA7pXH0HnEmcOM/NGf/KDiJBgKuuW
        qn1NML8Qe6xaj/FAsUec7w==
X-Google-Smtp-Source: ABdhPJwOM1hhMXjwmrAos/oBCbAVRzpkNRe0dBmU8uisDOIEhohB6rSgPnkpQvD3BadEROZk3cMEuw==
X-Received: by 2002:a05:6808:202:b0:2ef:8867:bffb with SMTP id l2-20020a056808020200b002ef8867bffbmr4315072oie.28.1649268841208;
        Wed, 06 Apr 2022 11:14:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o18-20020a9d7652000000b005cbf6f5d7c5sm7110203otl.21.2022.04.06.11.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:14:00 -0700 (PDT)
Received: (nullmailer pid 2523072 invoked by uid 1000);
        Wed, 06 Apr 2022 18:14:00 -0000
Date:   Wed, 6 Apr 2022 13:14:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: PCI: designware-ep: Increase maxItems
 of reg and reg-names
Message-ID: <Yk3YaAWPJ0bpLTHK@robh.at.kernel.org>
References: <1649145062-29833-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1649145062-29833-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649145062-29833-2-git-send-email-hayashi.kunihiko@socionext.com>
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

On Tue, Apr 05, 2022 at 04:51:00PM +0900, Kunihiko Hayashi wrote:
> UniPhier PCIe EP controller has 5 register mappings (dbi, dbi2, link,
> config and atu), so maxItems of "reg" and "reg-names" should allow 5.

Shouldn't that be 'addr_space' rather than 'config'? IIRC, 'config' is 
only for the host.

> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> index e59059ab5be0..03f97e7c4089 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> @@ -28,11 +28,11 @@ properties:
>        versions.
>        For designware core version >= 4.80, it may contain ATU address space.
>      minItems: 2
> -    maxItems: 4
> +    maxItems: 5
>  
>    reg-names:
>      minItems: 2
> -    maxItems: 4
> +    maxItems: 5
>      items:
>        enum: [dbi, dbi2, config, atu, addr_space, link, atu_dma, appl]
>  
> -- 
> 2.25.1
> 
> 
