Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0106B5221A9
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 18:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244751AbiEJQw1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 12:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244940AbiEJQw0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 12:52:26 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C636293B5A;
        Tue, 10 May 2022 09:48:29 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id q10so4006342oia.9;
        Tue, 10 May 2022 09:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9WJmL0MX1n/w/C39yTiMkMgGPMncxgk6Y06oR/j+s+8=;
        b=l0v6jImYGlYCWc0v/g/CyJqE/r7qutudPSghdtINuUQUxOWE3IpECcAiERaPS7kesg
         wxT02/K5890JzjRxcTyatuL5LMuBS9gbs0Wmwjkosn7obG7xsSCYtwflq5DILpc8tgPA
         /oqhJGJMDQmf+ARoua5rVu8vZ6QFuOVDYtVLXedKS2kkrpGFSJbzHAtsdlGXgVISnX/v
         vXmZmRXqo+t+bxyxmYpMvucy1LTQJUVscRNfJOy6QZ+MZh44aT9a1qgNEODMLYlYLw8V
         +/wQOuoKY8apqJgCIcuVZZonItSy5OT1VhhkP+DpfVrRKNDcqx2YKCYW8QEtNr0RyLat
         VZaQ==
X-Gm-Message-State: AOAM531PE/skKC9l0J/lDBQjm/LLXvuH3fJrxN2q0t9i4IY4/dUsbepV
        CFoabyxdqfrTBt2A0jEzOIUjlrP26Q==
X-Google-Smtp-Source: ABdhPJwdFNG/yC7dEq4aGYZi36BrWOzAVOBTkuiG+4BBu96ny1kxHCumiIde2qXKHaR47uD8wVUtxQ==
X-Received: by 2002:a54:4684:0:b0:322:a9ed:78a4 with SMTP id k4-20020a544684000000b00322a9ed78a4mr492628oic.193.1652201308439;
        Tue, 10 May 2022 09:48:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c15-20020a9d684f000000b0060603d8be2dsm5902592oto.67.2022.05.10.09.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 09:48:27 -0700 (PDT)
Received: (nullmailer pid 2177279 invoked by uid 1000);
        Tue, 10 May 2022 16:48:27 -0000
Date:   Tue, 10 May 2022 11:48:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-pci@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH v6 3/8] dt-bindings: PCI: qcom: Specify reg-names
 explicitly
Message-ID: <YnqXW+OA38LtgWFq@robh.at.kernel.org>
References: <20220506152107.1527552-1-dmitry.baryshkov@linaro.org>
 <20220506152107.1527552-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506152107.1527552-4-dmitry.baryshkov@linaro.org>
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

On Fri, 06 May 2022 18:21:02 +0300, Dmitry Baryshkov wrote:
> Instead of specifying the enum of possible reg-names, specify them
> explicitly. This allows us to specify which chipsets need the "atu"
> regions, which do not. Also it clearly describes which platforms
> enumerate PCIe cores using the dbi region and which use parf region for
> that.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 91 +++++++++++++++++--
>  1 file changed, 84 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
