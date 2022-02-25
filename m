Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D465F4C4F0B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 20:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiBYTnv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 14:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiBYTnu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 14:43:50 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186E014A04B;
        Fri, 25 Feb 2022 11:43:18 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id y15-20020a4a650f000000b0031c19e9fe9dso7666500ooc.12;
        Fri, 25 Feb 2022 11:43:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xgb0dJvwz1iExFb+kUzchm5jv/LkQ2YDc/ox85Jj8rI=;
        b=oCf0pLycZcGjkctfI8+tFc1vrF9qc573tPZcH42d+poUxgXHxmC634X5DbJ2foYkpF
         tdMZtPL/HzwgOJXcpec7FIfbp46IHzvb4ZAEa+OlUgIxgfCdOYkJlpLXAhAy1tCXwEz6
         Yo5RoGDMeegQnCsaRTa2/qnSxY9tMP/ddnkrrBnq5G+ejNNzIyRDYYmzOorHUkn8uaEX
         SNLnHCZjy5K2yhbMjHQt/HUtYbHLz+ORV2Sx5NpUk963wOxJsdoC5/SpvYpQ0Bdoo5DP
         E7OdZhWmG4pSmZFXNHZCwHNWEGi93noR4kKU2u+LZR2qBtmoI/ask1+/K/tJbqcicfpo
         G4Dg==
X-Gm-Message-State: AOAM532gqjNPRlezVscp3oJTe1/cZWVpt1hWSJX4jLVBSB0xUjbfl2IH
        jCAU2S2h4XGh+dsvjX2PXw==
X-Google-Smtp-Source: ABdhPJxPA+B6OYUNh8b4iyR8ggfpuz/89O7eflPUakUIYUD6KSOXUPYVtJk8cy4Ocz/PhbGcT6NawQ==
X-Received: by 2002:a05:6870:3e0d:b0:d3:fe6d:57c3 with SMTP id lk13-20020a0568703e0d00b000d3fe6d57c3mr2150845oab.225.1645818197476;
        Fri, 25 Feb 2022 11:43:17 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bf39-20020a056808192700b002d51f615f1csm1867414oib.34.2022.02.25.11.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:43:16 -0800 (PST)
Received: (nullmailer pid 1312537 invoked by uid 1000);
        Fri, 25 Feb 2022 19:43:15 -0000
Date:   Fri, 25 Feb 2022 13:43:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        bhupesh.linux@gmail.com, lorenzo.pieralisi@arm.com,
        agross@kernel.org, bjorn.andersson@linaro.org,
        svarbanov@mm-sol.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: pci: qcom: Document PCIe bindings for
 SM8150 SoC
Message-ID: <YhkxU9AUK268G4Uz@robh.at.kernel.org>
References: <20220223192946.473172-1-bhupesh.sharma@linaro.org>
 <20220223192946.473172-2-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223192946.473172-2-bhupesh.sharma@linaro.org>
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

On Thu, Feb 24, 2022 at 12:59:41AM +0530, Bhupesh Sharma wrote:
> Document the PCIe DT bindings for SM8150 SoC. The PCIe IP is similar to
> the one used on SM8250.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

But please convert this to schema. Future changes to the .txt binding 
may not be accepted.

Rob
