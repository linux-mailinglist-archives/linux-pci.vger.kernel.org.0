Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3AC4B0010
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 23:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbiBIWWo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 17:22:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbiBIWWo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 17:22:44 -0500
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2415C1DC5D1;
        Wed,  9 Feb 2022 14:22:46 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id t75-20020a4a3e4e000000b002e9c0821d78so4195826oot.4;
        Wed, 09 Feb 2022 14:22:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p7H8vRR/hHMqd6cJjy66lpzbwuEKRZjfv8J4zVqENbI=;
        b=24ksO36RN9ugHFx7oK42JUDono7a9JLVfQJehbUzvVVn+Q2+dp+v6NV8NHKiqayvmU
         61f5QfO2PtRqh3FBiX0q6JzFObypthsO8kqeElqJfM5BJqgbCyhcX5/uamjWvC4x9V1z
         qgHqDfZDTaFz9YDKYJLjKIu3HNH6jWXD1vdMhCN3sxSJARef0Z5EJf2Pe2aMXpCmTdwV
         +OilEJkBNbjNCvsMk77+Af0IH+YF9i2BYccLFU7wqz7TNTC077HtlgyTw9E+fDDgXYW2
         lcr3GP7+dFdRbTT30lGQnjdO/N+EZxp2wZgeR8SLYiz+HYWLHReijJJb650CF/xP6u0L
         IZiw==
X-Gm-Message-State: AOAM532yfbQmpbCmxyboFnN6HNzXnfuF2yLauhONmdvrcfMsRPMnzfPJ
        6rPNWyBxWJ9ZOhgo63wqIw==
X-Google-Smtp-Source: ABdhPJyVgNUrktRsjw7FToQtRXFtneJ6EyZ6SKQuJ3JNOr7cn5rmTG9pPiReipelbwLiLp8L4pj5gQ==
X-Received: by 2002:a05:6871:396:: with SMTP id z22mr1695258oaf.126.1644445366082;
        Wed, 09 Feb 2022 14:22:46 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id ek4sm7771458oab.23.2022.02.09.14.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:22:45 -0800 (PST)
Received: (nullmailer pid 1043668 invoked by uid 1000);
        Wed, 09 Feb 2022 22:22:44 -0000
Date:   Wed, 9 Feb 2022 16:22:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 01/11] dt-bindings: pci: qcom,pcie: drop unused "pipe"
 clocks
Message-ID: <YgQ+tGhLqwUCsTUo@robh.at.kernel.org>
References: <20220204144645.3016603-1-dmitry.baryshkov@linaro.org>
 <20220204144645.3016603-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204144645.3016603-2-dmitry.baryshkov@linaro.org>
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

On Fri, Feb 04, 2022 at 05:46:35PM +0300, Dmitry Baryshkov wrote:
> The "pipe" clock is now unused by the PCIe driver. Drop it from the
> bindings.

Old kernels expect it, so nak.

> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.txt | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> index a0ae024c2d0c..da08f0f9de96 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -154,7 +154,6 @@
>  			- "bus_slave"	Slave AXI clock
>  			- "slave_q2a"	Slave Q2A clock
>  			- "tbu"		PCIe TBU clock
> -			- "pipe"	PIPE clock
>  
>  - clock-names:
>  	Usage: required for sc8180x and sm8250
> @@ -167,7 +166,6 @@
>  			- "slave_q2a"	Slave Q2A clock
>  			- "tbu"		PCIe TBU clock
>  			- "ddrss_sf_tbu" PCIe SF TBU clock
> -			- "pipe"	PIPE clock
>  
>  - resets:
>  	Usage: required
> -- 
> 2.34.1
> 
> 
