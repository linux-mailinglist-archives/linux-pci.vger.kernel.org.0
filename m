Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF36A51CA36
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 22:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383011AbiEEUOy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 16:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241971AbiEEUOy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 16:14:54 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6A11EAE0;
        Thu,  5 May 2022 13:11:14 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-e93bbb54f9so5296524fac.12;
        Thu, 05 May 2022 13:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fXylqsRuIegGKiz36gyl6V/8kEXINeMs3Gnd/0jTh5I=;
        b=6PktU+sqcSZl6SY2jGNzepJ2flDawimUGk+XbwLhs/DDzqbXayisI2XPpJLfmm0VYn
         TVBvj6kXAX/whj5JIoKRuFUNH7HJ4PAPGFDalq3WWLZnWFRMdOiaDLX2hTr3mBkkCYlp
         95OLMsR2dajnn4PxEF1nIyZ+q/XRNCaV1xfuF2QHXKLeiRiNlofnkLCqIUQNSMf3G9xQ
         MNrrgSrU1KvabiKVgGsUnbjrm7PtsFWZYbvJL5z8V5opklnhTc2uCO+1BLZjkfT7jxvl
         ltGBhabvE++BPtuQp2QITWSisiZWac04oGoeO0WdxW6Zx46ofhJD8Chh66PtvpQOOijM
         sJkQ==
X-Gm-Message-State: AOAM530vPD1utNCrHDDKIYKxBjL82z+6xI06hcENmDz4MqgzRcOeoBNk
        I09RQhroywuEwlwZ53uVFw==
X-Google-Smtp-Source: ABdhPJy+FjWvaTAc+zGul9wdXzty3kJadu9pz+uxQSZ2BN26bKo77Tr0W3Q/tzYpkN5YY0X2NLl0sg==
X-Received: by 2002:a05:6870:344f:b0:e2:c4c0:86a5 with SMTP id i15-20020a056870344f00b000e2c4c086a5mr15451oah.189.1651781473542;
        Thu, 05 May 2022 13:11:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id be8-20020a056808218800b00325cf57766bsm967937oib.1.2022.05.05.13.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 13:11:13 -0700 (PDT)
Received: (nullmailer pid 112574 invoked by uid 1000);
        Thu, 05 May 2022 20:11:12 -0000
Date:   Thu, 5 May 2022 15:11:12 -0500
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
Subject: Re: [PATCH v7 2/7] PCI: dwc: Correct msi_irq condition in
 dw_pcie_free_msi()
Message-ID: <YnQvYI1R6fXDI/nf@robh.at.kernel.org>
References: <20220505135407.1352382-1-dmitry.baryshkov@linaro.org>
 <20220505135407.1352382-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505135407.1352382-3-dmitry.baryshkov@linaro.org>
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

On Thu, May 05, 2022 at 04:54:02PM +0300, Dmitry Baryshkov wrote:
> The subdrivers pass -ESOMETHING if they do not want the core to touch
> MSI IRQ. dw_pcie_host_init() also checks if (msi_irq > 0) rather than
> just if (msi_irq). So let's make dw_pcie_free_msi() also check that
> msi_irq is greater than zero.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
