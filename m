Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF9E62CD39
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 22:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiKPV4B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 16:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbiKPVzq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 16:55:46 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CC32ED5D;
        Wed, 16 Nov 2022 13:55:46 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id h132so20141618oif.2;
        Wed, 16 Nov 2022 13:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6jxByGsjVY4+O8WFWedBidMh7X6Ua6n+oe/v1r9DIQ=;
        b=wTg35R9fnRpiSOGLYJsS1G2V2PenCn8oGC4MvX8Lx3jT4xi2JalSsRK2wY+N8qtZza
         jLAl+5bSsv/yc6JMvMB+GjKedzRhTOgXJNzIcHQstAccxcHM7fP5k9hzaP1tpm8KzT1o
         9WrDgvxIxt5Ja3RuKfF2wcIP57JFooLfXbZfZ/L2GRCYxlKkzNzWmtnzdo2mvT/YU5lL
         o1u32Kw9jFde15hmB5rMMBCtHvxDcMEG/ovkxajAoNRONzkeg2dNCC3Ec2KOm9rTUtIF
         hTnS3m3uaVCcKc4jT/gCioNAGmqSfjjlPVvxqUVXW5QWIpN/ym3tfObuaR+TjiYgo3xc
         UITA==
X-Gm-Message-State: ANoB5pmIblF9TChfy4YnrxF/28V5zWoJ6bwSwKTVL9kN/l+NQSOyhiFt
        RjfxafVlskY3yQ0MQmSY+Q==
X-Google-Smtp-Source: AA0mqf7soHOs9EZ49XIFKU8Qzk9wRPE7UYZvw9GVTjFSqh2uvkHljxiVzDVcDrQpTL22Mha3gLar1g==
X-Received: by 2002:aca:da03:0:b0:35a:487b:4dc3 with SMTP id r3-20020acada03000000b0035a487b4dc3mr2532149oig.249.1668635745233;
        Wed, 16 Nov 2022 13:55:45 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z41-20020a056870c22900b001324315bb6asm8599798oae.29.2022.11.16.13.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:55:44 -0800 (PST)
Received: (nullmailer pid 1038181 invoked by uid 1000);
        Wed, 16 Nov 2022 21:55:46 -0000
Date:   Wed, 16 Nov 2022 15:55:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 2/4] dt-bindings: PCI: qcom: unify clock order between
 MSM8996 and MSM8998
Message-ID: <166863574600.1038120.8133034345240056242.robh@kernel.org>
References: <20221115125310.184012-1-krzysztof.kozlowski@linaro.org>
 <20221115125310.184012-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115125310.184012-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Tue, 15 Nov 2022 13:53:08 +0100, Krzysztof Kozlowski wrote:
> MSM8996 and MSM8998 use the same clocks, so use one order to make the
> binding simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 24 ++++++-------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
