Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8F75221A4
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 18:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347632AbiEJQuX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 12:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347638AbiEJQuW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 12:50:22 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1745554182;
        Tue, 10 May 2022 09:46:24 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-ed8a3962f8so18971608fac.4;
        Tue, 10 May 2022 09:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3YHuuVOr3CHSxvJQg05wI1M0h/mZcgRGnnSMMIRn6AI=;
        b=JeQ90JcjGiV2nr9TyCPgOu9vyjuVQLNLTGXnMofQrVPyGA1aAXSMr406/N3bzg5543
         2Qe7sPo3PlNGHj6dunMVLA4/4n3Kb/IZOxNl/tdpvxaRnAwIa4ASAPvy8u2VnPUvC0L5
         YdsLSiWwJjqUmUT0Pkq0QSORpCtxcxYi1y50x5zO4lMKnfNuwCIjEyh87yr6D1ucDQqH
         zfPVsKY5eUnaYdr2j8zDavUjzcItr7lILyzSQzPHqk5r91oNN94wZEQLsa/gpv/75ZaC
         UQeE2z/vMZiSwWcnwr1z7Ct2MoFLPmx1b3sgXLCgUZ2uPHfSmPxa/qjLfuI993CUQD54
         ytdw==
X-Gm-Message-State: AOAM530ZjK7lGLwD+p1JQ4yt4RCmnAZRzD2xPPsMY4ya1Y0pigKXEXDj
        5GE0Rzkr0u4a4ba6LpHyhg==
X-Google-Smtp-Source: ABdhPJygONxbsoY7mhSep1RBe/LIFQIOaruXBWqXWr46gyBCA8cpkiHUjjj3PSI+k0tC6iqus9nPfQ==
X-Received: by 2002:a05:6870:c683:b0:ed:efb9:ffe9 with SMTP id cv3-20020a056870c68300b000edefb9ffe9mr545696oab.241.1652201183404;
        Tue, 10 May 2022 09:46:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z14-20020a056870e30e00b000e7a517df41sm5797709oad.13.2022.05.10.09.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 09:46:22 -0700 (PDT)
Received: (nullmailer pid 2173814 invoked by uid 1000);
        Tue, 10 May 2022 16:46:22 -0000
Date:   Tue, 10 May 2022 11:46:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v6 2/8] dt-bindings: PCI: qcom: Do not require resets on
 msm8996 platforms
Message-ID: <YnqW3h4DvubDMSvx@robh.at.kernel.org>
References: <20220506152107.1527552-1-dmitry.baryshkov@linaro.org>
 <20220506152107.1527552-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506152107.1527552-3-dmitry.baryshkov@linaro.org>
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

On Fri, 06 May 2022 18:21:01 +0300, Dmitry Baryshkov wrote:
> On MSM8996/APQ8096 platforms the PCIe controller doesn't have any
> resets. So move the requirement stanza under the corresponding if
> condition.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml         | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
