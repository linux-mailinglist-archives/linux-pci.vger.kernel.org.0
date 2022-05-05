Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5B251CA5D
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 22:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385753AbiEEUQn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 16:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240042AbiEEUQl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 16:16:41 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46C15F8EC;
        Thu,  5 May 2022 13:12:58 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id r1so5481982oie.4;
        Thu, 05 May 2022 13:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LKSq9ygO8p0SX89rGrushVCZPYll0ugvrIp+r4vJs4c=;
        b=xixIMIVaOkW3nn7rH8hmYaZgGkjcDpnpdfsaphZXfOTBPTOih3ZiXqz7P4sPWaMngI
         K8va0jzZqKI68cQddjv8CF2EcsCBEpIP1vQIS4TQBw2H8P6TiLKTKpmxxTBerQ8icBO0
         XHicG6YCVqWlxPXl2jgeCiOXEmRNKAmz4qWpNRYJ/6HhijjzA0v6vdZ73M743HkeGTIv
         dMLS6Q+TkKRWweg+3iHkmnX3eWvAsYKQiJXE3lKmkRbJjlTjzUaTmxDZeMGSDfnoYE2U
         AMzmDfEROJS+jSAVGvVs6u6bbHmPVq8kGpQXNhDRFE0/0XsuuJuiyKlChKiJSayq7p/U
         nCJg==
X-Gm-Message-State: AOAM530naDe/Duv+yZHYCIt0GpapwQkbq4Pwh39X2cI8T8n6ADjzI4mP
        e5XYE9JeR2ybEqdp7/dEFA==
X-Google-Smtp-Source: ABdhPJy2LaDlNuEN4fTb3tmPlWG1BStPJyJ4pRgbLQ/hK/1OsOlWlHpUNHP6GCO9319ww1N0m1stkw==
X-Received: by 2002:a05:6808:1690:b0:325:4159:2004 with SMTP id bb16-20020a056808169000b0032541592004mr4712oib.86.1651781578066;
        Thu, 05 May 2022 13:12:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n19-20020a056870971300b000e92d5a54ffsm854981oaq.26.2022.05.05.13.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 13:12:57 -0700 (PDT)
Received: (nullmailer pid 114810 invoked by uid 1000);
        Thu, 05 May 2022 20:12:56 -0000
Date:   Thu, 5 May 2022 15:12:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/7] PCI: qcom: Revert "PCI: qcom: Add support for
 handling MSIs from 8 endpoints"
Message-ID: <YnQvyDGUpoy2RO7O@robh.at.kernel.org>
References: <20220505135407.1352382-1-dmitry.baryshkov@linaro.org>
 <20220505135407.1352382-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505135407.1352382-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 05, 2022 at 04:54:01PM +0300, Dmitry Baryshkov wrote:
> I have replied with my Tested-by to the patch at [2], which has landed
> in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
> Add support for handling MSIs from 8 endpoints"). However lately I
> noticed that during the tests I still had 'pcie_pme=nomsi', so the
> device was not forced to use higher MSI vectors.
> 
> After removing this option I noticed that hight MSI vectors are not

s/hight/high/

> delivered on tested platforms. Additional research pointed to
> a patch in msm-4.14 ([1]), which describes that each group of MSI
> vectors is mapped to the separate interrupt.
> 
> Without these changes specifying num_verctors can lead to missing MSI

s/num_verctors/num_vectors/

> interrupts and thus to devices malfunction.
> 
> Fixes: 20f1bfb8dd62 ("PCI: qcom: Add support for handling MSIs from 8 endpoints")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
