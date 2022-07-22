Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5EA57E962
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 23:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbiGVV7J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 17:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbiGVV7F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 17:59:05 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AC32228D;
        Fri, 22 Jul 2022 14:59:04 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id g20-20020a9d6a14000000b0061c84e679f5so4299037otn.2;
        Fri, 22 Jul 2022 14:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wGhPXW+iEOdkvg+vG/Kkr+K+8RKFUAz0LS2o7676KFs=;
        b=GkL09gP/QUWYroxTM5aL85fJB59ZJ7rRbC/7CoC0YjZTs52eyG9rPTaVMzOZHNxvRT
         4W4ray4G7HHQMtBYA2y3Tmw5kljJMuvpHsXZLwieEKRXqF60VDKyGC3bQQEEKF+gIXUa
         LBmoekxtHx3FOCcvHek4wWRKt5cMT3EoWUux+1mWht5l9uXx68+mnQ/bCUXMe+3Ah2XM
         mUs58VZoZj6k2aFPKs47cPperQpIGtp5W3hodz00MY5n6TmwJmSMORL5mmpIF3tEKens
         hk8RyDDPAzdmmZCNP8iIrkUPhZMpTlFQGgpYCUG6kCBA9JsKl13vPwF+I9loqP8BJ6fx
         VotQ==
X-Gm-Message-State: AJIora+M4lQpw8uSfJExuKsWbO/S2/1YzOpFVtZYc+RL8ZvcfIsiwCtX
        xjOHix1pao7QhxXSvBE3oA==
X-Google-Smtp-Source: AGRyM1vZqeRx4+M9prX1PCn/vlcW1frqBq8+n/89xRmNP4nVTSW5q2m2RvaqdcGrtJeJ6mD9+bc9Tw==
X-Received: by 2002:a9d:f62:0:b0:610:417c:807b with SMTP id 89-20020a9d0f62000000b00610417c807bmr768344ott.93.1658527144055;
        Fri, 22 Jul 2022 14:59:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d3-20020a056830004300b0061c7ce09091sm2386917otp.67.2022.07.22.14.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 14:59:03 -0700 (PDT)
Received: (nullmailer pid 4101811 invoked by uid 1000);
        Fri, 22 Jul 2022 21:59:00 -0000
Date:   Fri, 22 Jul 2022 15:59:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-pci@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: PCI: fsl,imx6q-pcie: Add missing type for
 'reset-gpio-active-high'
Message-ID: <20220722215900.GA4101751-robh@kernel.org>
References: <20220719215031.1875860-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719215031.1875860-1-robh@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 19 Jul 2022 15:50:31 -0600, Rob Herring wrote:
> 'reset-gpio-active-high' is missing a type definition and is not a common
> property. The type is boolean.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
