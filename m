Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9DA62CD33
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 22:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiKPVyy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 16:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiKPVyx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 16:54:53 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4CBE60;
        Wed, 16 Nov 2022 13:54:53 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id v81so20110450oie.5;
        Wed, 16 Nov 2022 13:54:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LQLssx4zAh3Tz5CWxiNAOtibKcauv9A8Mhm/TFr/40=;
        b=tVb1Zsb8IZ1t34RlOvQ7/gFoIgBYJFO61W4lcaIlY/Dz9UA1rVhzwqaZqrQK6ogSTy
         O91YgtUvdvsBoXeDZmRBYQz42aODuSf5lHpP9LhxSh5Qzty8JguNAQjkhyHOs5fbR4GT
         cazcsIIyWy/nnNe3ZhQnl8Q84Fj4PuXfiTgHhdKrEIQo7HZyySscgqXfocbYgWYSsxtm
         nok+IIgq9qQ8Nilu5nmKKQb4wdibgemoGoeV8t8lLVF698Pmf91zxG+w/p+V8/M9CWFb
         dHDg045FLhD2wUPXOS7qvkgVsQAkR2HRialhisAW/PmbtUZCdsJTcuVAsbRZnbdiQvHN
         5vzQ==
X-Gm-Message-State: ANoB5pnPxXCE//o/zNXWShChgOIlVCPxjdJJNzlyOzsfrACTDHfYne8u
        MJ7q2aBu4jLXpy4a9fpz3A==
X-Google-Smtp-Source: AA0mqf7pvQkDnwAo4fvLzwI7cGK16x8ecvw0fBW6PgfSB2XCMHF7D0vDtK2ZOymwmAAiLJoaJMn5lw==
X-Received: by 2002:a05:6808:13c6:b0:344:df12:f079 with SMTP id d6-20020a05680813c600b00344df12f079mr2519427oiw.284.1668635692798;
        Wed, 16 Nov 2022 13:54:52 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r3-20020a4a4e03000000b004982f2d3c03sm6515588ooa.25.2022.11.16.13.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:54:52 -0800 (PST)
Received: (nullmailer pid 1037031 invoked by uid 1000);
        Wed, 16 Nov 2022 21:54:54 -0000
Date:   Wed, 16 Nov 2022 15:54:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-pci@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: Re: [PATCH 1/4] dt-bindings: PCI: qcom: add MSM8998 specific
 compatible
Message-ID: <166863569377.1036974.18351423699681914368.robh@kernel.org>
References: <20221115125310.184012-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115125310.184012-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Tue, 15 Nov 2022 13:53:07 +0100, Krzysztof Kozlowski wrote:
> Add new compatible for MSM8998 (compatible with MSM8996) to allow
> further customizing if needed and to accurately describe the hardware.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 42 ++++++++++---------
>  1 file changed, 23 insertions(+), 19 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
