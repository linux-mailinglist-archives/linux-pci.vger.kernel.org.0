Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1354C654647
	for <lists+linux-pci@lfdr.de>; Thu, 22 Dec 2022 20:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbiLVTCU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Dec 2022 14:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbiLVTB5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Dec 2022 14:01:57 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA6B10D4;
        Thu, 22 Dec 2022 11:01:43 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1442977d77dso3516745fac.6;
        Thu, 22 Dec 2022 11:01:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQqrhVgkGTpp7W6Y9CK+zqEqQirZ1HKVacYHb0XLi4Q=;
        b=bxIDqVV6Vb8J7LK+7/38N2F8EpuQ1rZvrUJcMDfuO931kM7X7HT0MO4zoTmyq6PXxC
         0JPuEH5qvNAYCv6ylQWwtWKjf+B44hiHHljHX06VXGSx7N1xb7UUoNx1ANKpD5dUwZDZ
         HQFx2lMVaVse4FWh3WZLVfdajlNUwlxDdlyjvr5QstA/G8zYu811LRNE65t48ECgjuLJ
         yquCnQAeKV2hOwwA9uY65IS0K0y9FWNZHT9+8ZJFBGE1fVdzMzKENOr1b6TtV9dtmvm5
         40BcpJu0wBNO2eKAUu5UhKTQMd8uDvnOjy3Ubcq5Wn8pGemwMGNKlGqPsDm6qW4Ip2We
         b18A==
X-Gm-Message-State: AFqh2kpk/G3xnWcO8iceMAfUzLjNg4kebzyphEUn5XQ3oOMmS3Du2Jlc
        MU9wXjdG4pNf0JDQjlmEfPf6mSXwAg==
X-Google-Smtp-Source: AMrXdXuz/+C/EyCTr5ELqmWexFe1x5B6/KHopwMxKWhm1iZcM8aMJFJCAYzl7oEmR8ME5Kgay56doQ==
X-Received: by 2002:a05:6871:4104:b0:148:53c7:bf43 with SMTP id la4-20020a056871410400b0014853c7bf43mr3213982oab.53.1671735702166;
        Thu, 22 Dec 2022 11:01:42 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y15-20020a056870418f00b00144e18d8525sm592152oac.25.2022.12.22.11.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 11:01:41 -0800 (PST)
Received: (nullmailer pid 1911711 invoked by uid 1000);
        Thu, 22 Dec 2022 19:01:41 -0000
Date:   Thu, 22 Dec 2022 13:01:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        bhelgaas@google.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: PCI: qcom: Document msi-map and
 msi-map-mask properties
Message-ID: <20221222190141.GA1908434-robh@kernel.org>
References: <20221222133123.50676-1-manivannan.sadhasivam@linaro.org>
 <20221222133123.50676-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222133123.50676-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 22, 2022 at 07:01:22PM +0530, Manivannan Sadhasivam wrote:
> The Qcom PCIe controller is capable of using either internal MSI controller
> or the external GIC-ITS for receiving the MSIs from endpoint devices.
> Currently, the binding only documents the internal MSI implementation.
> 
> Let's document the GIC-ITS imeplementation by making use of msi-map and
> msi-map-mask properties. Only one of the implementation should be used
> at a time.

Isn't that up to the OS to decide? Some versions may not support MSIs.

What about legacy interrupts? Don't you need to keep the interrupt 
properties for them?

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 02450fb26bb9..10fec6a7abfc 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -104,14 +104,20 @@ required:
>    - compatible
>    - reg
>    - reg-names
> -  - interrupts
> -  - interrupt-names
> -  - "#interrupt-cells"
>    - interrupt-map-mask
>    - interrupt-map
>    - clocks
>    - clock-names
>  
> +oneOf:
> +  - required:
> +      - interrupts
> +      - interrupt-names
> +      - "#interrupt-cells"
> +  - required:
> +      - msi-map
> +      - msi-map-mask
> +
>  allOf:
>    - $ref: /schemas/pci/pci-bus.yaml#
>    - if:
> -- 
> 2.25.1
> 
> 
