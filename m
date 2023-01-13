Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A978B66A2BD
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 20:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjAMTRR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 14:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjAMTRI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 14:17:08 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9BF857FA;
        Fri, 13 Jan 2023 11:17:07 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id m6-20020a9d7e86000000b0066ec505ae93so12738059otp.9;
        Fri, 13 Jan 2023 11:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FapQoxkKDls/b9akC1v16cEe+PDIce/Iikxy1EziQ8I=;
        b=CbkhNGkAE1kk2anaTOnhr8kY9ruYlZpwTO46Ai8SkCnQ1ufndr8NyqGiAsXNzWyFm1
         vwIH0BhhvsgC5ml9kXkCCTBOQ0c0DuJ4hgBf5FGouINfuiWQSSegS4bb1k0+EXKOPGT1
         RRYUmYu1JIR1xyLhEWEy4IOm+Lon+JvVkcTwosvd4LfgNaaZa+xQcL9M/KFcUoCIoxG3
         p1tavotmwF+4/+6qQaD+RRTag6XzZ1hbndzUru37NoHVnajJE5la8xwmuCXxJmleT7uD
         lYOpNRgViudI/Up/X0kbSEjlDVMHYx/lQnJXOdS+saUKLybmU5yCL0F8Sm4Iu2ygv887
         rzzw==
X-Gm-Message-State: AFqh2kqHPFnG+StSBgDu553tscT4M7WFUFQ/PhgHPNuBYYgWHHhi19O/
        GqnWbWU1sKe36gUZxP+i/Bfd3m4o6A==
X-Google-Smtp-Source: AMrXdXvwi/XqjBgQXuKc8TT4fT5fBqWRCmJ2xZ0Xa3GhPV+vqWZTcy9OJrE7vk2Mj1YjWeMDnmNFzg==
X-Received: by 2002:a9d:19e9:0:b0:684:9f0e:57f6 with SMTP id k96-20020a9d19e9000000b006849f0e57f6mr8165074otk.10.1673637426694;
        Fri, 13 Jan 2023 11:17:06 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g72-20020a9d12ce000000b00684ccbfe012sm1767009otg.27.2023.01.13.11.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:17:06 -0800 (PST)
Received: (nullmailer pid 2751067 invoked by uid 1000);
        Fri, 13 Jan 2023 19:17:05 -0000
Date:   Fri, 13 Jan 2023 13:17:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        andersson@kernel.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: PCI: qcom: Allow both GIC-ITS and
 internal MSI controller
Message-ID: <167363742427.2750717.3455349071670736976.robh@kernel.org>
References: <20230111123004.21048-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111123004.21048-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Wed, 11 Jan 2023 18:00:03 +0530, Manivannan Sadhasivam wrote:
> The binding should specify both MSI implementations and the OS/driver
> should choose the one based on the platform requirements.
> 
> Fixes: 2b0d557419cd ("dt-bindings: PCI: qcom: Allow both GIC-ITS and internal MSI controller")
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
