Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DC764380B
	for <lists+linux-pci@lfdr.de>; Mon,  5 Dec 2022 23:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiLEWZz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Dec 2022 17:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiLEWZx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2022 17:25:53 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4767AB4B;
        Mon,  5 Dec 2022 14:25:53 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-144bd860fdbso2058941fac.0;
        Mon, 05 Dec 2022 14:25:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYt/DH5axArWCdtKIq8L7LqqDIDr8bBvFNydtROy+Xk=;
        b=iZM2ozifaxWOoAojWIN8LlimlX/zmUWY4PEggdSWIZmuZ7sEefntJlh3nE2jjCyRut
         WAovbtiGURkFWK9yRVG/dix5c0/BpKmJkbVMUJKd13IDdV0RqPrSV7o+KLWiZb3eAURI
         QmzEveIlks1OdCl7v6JVTFfpqMGf8LGgczM1qS/2xnnggH+vbQST7bX/+57cBqKdJH5a
         mDETkLEWHl2XngAWe7lFJCEiC5U3JFUu1AuzzGSazlJUV83SpUX0Yeu68qILicxzdr0f
         HeSgRIidPx7XIeEjyIcjNP7kP1Eo8+7N/sSYqFKzi+sdlnBaZCJkTUv9L0rZBUPeZfqQ
         gEPw==
X-Gm-Message-State: ANoB5pkSwsYk5rpd2eAXED+OS3AxsspGRTnJ6VJXHJhu67EWvgaXj0xB
        yWE8URqaSY45B63G6gNmdvLOWSoBTA==
X-Google-Smtp-Source: AA0mqf7+MYm64muTcJa5mzLrg+MyapenmZQOQMjLZWeflzFpG52Pvav0+gpk2TveGELaLB+x1JZIAw==
X-Received: by 2002:a05:6870:c694:b0:13c:d5bd:6faa with SMTP id cv20-20020a056870c69400b0013cd5bd6faamr37009124oab.275.1670279152484;
        Mon, 05 Dec 2022 14:25:52 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n189-20020aca59c6000000b0035a64076e0bsm7542792oib.37.2022.12.05.14.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:25:52 -0800 (PST)
Received: (nullmailer pid 2799247 invoked by uid 1000);
        Mon, 05 Dec 2022 22:25:51 -0000
Date:   Mon, 5 Dec 2022 16:25:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Allow 'dma-coherent' property
Message-ID: <167027915042.2799181.8429355168491802390.robh@kernel.org>
References: <20221205094530.12883-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205094530.12883-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Mon, 05 Dec 2022 10:45:30 +0100, Johan Hovold wrote:
> Devices on some PCIe buses may be cache coherent and must be marked as
> such in the devicetree to avoid data corruption.
> 
> This is specifically needed on recent Qualcomm platforms like SC8280XP.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> Lorenzo, the corresponding SC8280XP DT fix is heading for 6.2 so it
> would be nice if this one could be merged for 6.2-rc1 (or -rc2) as well
> to avoid the corresponding DT validation warnings.
> 
> Johan
> 
> 
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
