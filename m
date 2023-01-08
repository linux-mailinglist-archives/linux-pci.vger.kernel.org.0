Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1BC66195B
	for <lists+linux-pci@lfdr.de>; Sun,  8 Jan 2023 21:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjAHUdq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Jan 2023 15:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjAHUdp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Jan 2023 15:33:45 -0500
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A29538BF;
        Sun,  8 Jan 2023 12:33:45 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id g20so3654100iob.2;
        Sun, 08 Jan 2023 12:33:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7vLsrRzX2QRbu+wn8E6Xsxz4vl8fBTbDiQhccvHsVU=;
        b=3lQztFCB2EAsJ6MTUqR8J/Jm1XMedWRDkZby7IbpaLREz26YuT7NPQHVY0+Z1gItpE
         Ndj/+D+0bduOmAyoM3gkPiAqsZgzrjLpVtlL6DT+QbMt3yu7twmE/Y/GrjoE9IdPdvgQ
         HlX4L6GwcOO2n1PfQFEkwUHS7GoFZngkUO7hY1e/eKPx0NFUlWVqGqfwX5lbfrGK+Ill
         eah5eludBJ3abx2Xh3HZcXRzIy07nX/1musD9cx6xV0AZWF7lBw3EIlVR7RXYq5SaRY9
         JWeu9qhdsDke30FTqRiB7AwtBxlD0rZ2XO7UoR9gQ6QlDmN52knaBahuqBa9APKnFUEu
         4fJw==
X-Gm-Message-State: AFqh2koAQzqHxMQw3RI5IhGWZWC2VlFo67ZaWhUCLSMQi/6hnu1u9nV5
        n1pnm+yZeMfjfGoTvjRGaw==
X-Google-Smtp-Source: AMrXdXs7Iric8iirKgTG0nbuAmrIi9VB1Tyzw1JzK/MY5Ma+Anp5Qyj810iw8MIcX7p73GiTRpDaAw==
X-Received: by 2002:a5e:c708:0:b0:6bc:d715:362d with SMTP id f8-20020a5ec708000000b006bcd715362dmr42361952iop.2.1673210023991;
        Sun, 08 Jan 2023 12:33:43 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id k64-20020a6bba43000000b006e0577610e2sm2575711iof.45.2023.01.08.12.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 12:33:43 -0800 (PST)
Received: (nullmailer pid 239807 invoked by uid 1000);
        Sun, 08 Jan 2023 20:33:40 -0000
Date:   Sun, 8 Jan 2023 14:33:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        bhelgaas@google.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lpieralisi@kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: PCI: qcom: Document msi-map and
 msi-map-mask properties
Message-ID: <20230108203340.GA229573-robh@kernel.org>
References: <20230102105821.28243-1-manivannan.sadhasivam@linaro.org>
 <20230102105821.28243-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102105821.28243-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 02, 2023 at 04:28:20PM +0530, Manivannan Sadhasivam wrote:
> The Qcom PCIe controller is capable of using either internal MSI controller
> or the external GIC-ITS for signaling MSIs sent by endpoint devices.
> Currently, the binding only documents the internal MSI implementation.
> 
> Let's document the GIC-ITS imeplementation by making use of msi-map and
> msi-map-mask properties. Only one of the implementation should be used
> at a time.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index a3639920fcbb..01208450e05c 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -114,14 +114,20 @@ required:
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

anyOf

The OS should have the option of both being present and pick which MSI 
path it wants to use. 

Rob
