Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03957283BA
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 17:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbjFHP2J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 11:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237092AbjFHP2D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 11:28:03 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0572D46;
        Thu,  8 Jun 2023 08:28:03 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-777b4716673so18918239f.1;
        Thu, 08 Jun 2023 08:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686238082; x=1688830082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qr000rxGLVuWJZz2D0ArKGwSzq3Pa8ar0xjysheU/dU=;
        b=WZRyiS3E0fuXwFPwXxtml2KtMBlbYjKiX4r0KFnMs/NxwkCrIiEzqBGOXq4eGfrubo
         +zox4goabq5d5yBcVdqOyAgw9JvtwaK0MTT7/aldXjDDdDHE+z2IWKuiN1k5v/ODE7+M
         F6y3D2bQUtlLeOdmrj/vbawdezcOUiMOFHRaNXNAZdYNZwLKYK7bRBI1vxowBAWcsop6
         2qfy4w2wDXmbXwHebmRdeV1CrNMI1YxwdV9JMc5i748Li3PaXQWnDUorE8k4vutI4efm
         LnmNGlz/mIZz56jaFB4SD2SpDC0UW289cbXItgqhtMPzI605u8aGT5789+B4C0kllA6M
         pLFA==
X-Gm-Message-State: AC+VfDzq4DFklGgJNJGxMGhMa30bdf6KclW9La33cLz7cTuT1XZyc3o0
        XMXImi7alI+MI6wsw4EK4Q==
X-Google-Smtp-Source: ACHHUZ7yIzpDskqBVsSZugxdatsLxV3rNEEOXYrrNCOawofOsVApP7TUr7KrKg+IbkgmirE1X6UUNw==
X-Received: by 2002:a05:6602:2d01:b0:777:a4d2:8871 with SMTP id c1-20020a0566022d0100b00777a4d28871mr1838491iow.5.1686238082262;
        Thu, 08 Jun 2023 08:28:02 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t5-20020a028785000000b0040fa5258658sm332660jai.77.2023.06.08.08.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 08:28:01 -0700 (PDT)
Received: (nullmailer pid 2724383 invoked by uid 1000);
        Thu, 08 Jun 2023 15:27:59 -0000
Date:   Thu, 8 Jun 2023 09:27:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, quic_vbadigan@quicinc.com,
        quic_ramkri@quicinc.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM" 
        <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: qcom: ep: Add interconnects path
Message-ID: <20230608152759.GA2721945-robh@kernel.org>
References: <1686154687-29356-1-git-send-email-quic_krichai@quicinc.com>
 <1686154687-29356-2-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686154687-29356-2-git-send-email-quic_krichai@quicinc.com>
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

On Wed, Jun 07, 2023 at 09:48:05PM +0530, Krishna chaitanya chundru wrote:
> Add the "pcie-mem" interconnect path to the bindings.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index b3c22eb..6fc5440 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -70,6 +70,13 @@ properties:
>      description: GPIO used as WAKE# output signal
>      maxItems: 1
>  
> +  interconnects:
> +    maxItems: 1
> +
> +  interconnect-names:
> +    items:
> +      - const: pcie-mem
> +
>    resets:
>      maxItems: 1
>  
> @@ -97,6 +104,8 @@ required:
>    - interrupts
>    - interrupt-names
>    - reset-gpios
> +  - interconnects
> +  - interconnect-names

You can't add required properties. That's an ABI break. Up to the 
platform whether that's acceptible, but you have to explain all this in 
the commmit msg.

>    - resets
>    - reset-names
>    - power-domains
> -- 
> 2.7.4
> 
