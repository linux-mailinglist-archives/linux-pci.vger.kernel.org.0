Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C276DF3E4
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 13:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjDLLjh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 07:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjDLLjK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 07:39:10 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C85B9
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 04:38:49 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-18779252f7fso1126341fac.12
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 04:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681299527; x=1683891527;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RguhCsxW3m1Xnak065S9tzxK4IAulmFgd1kMo/z7Tf4=;
        b=mRpX/uNVogg67Gx9grBrsXIDhRV0KwSr8LCHn9ChfYRxk/ZQnyQpsDTRAYmjYD6VSY
         hCh9I+fMK7Gq9K5qA34Un3RYYvIGJPhvKKY4IFNy98tTEOJikCSLS6Y85UJZI4/FYCos
         +vQSGgtsGeRUGHDNUfwVHDZPofIp3puohH/7ThKiZaTczz4I4LZbGXJoNPOT3FgrE4S9
         0O5L9+l57SYuMG43xlCOcOTrP+p9PUieUzTsqGUrcMU7W0ZbMMX19CpZRU2iBtRN+9Xu
         jeC/k8d1SzIYbfK9dhXSJ4/qmRFsy6HVfv5LtjQBrdqax3JDqukAs/ISzGBISAt7NAqy
         sPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681299527; x=1683891527;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RguhCsxW3m1Xnak065S9tzxK4IAulmFgd1kMo/z7Tf4=;
        b=ZBpkNCoiHAeqG6vXvpawzIYaTF3un/RQQAQnijFTJmFyQM78Nb5wppAzRQiMGQNdmP
         QV+0jt37w/4VdIwtfaAxKnYFW/OawPV9U1vPFgO7Jgdg1rEErbhH9ljm+2IO1PBCS8ow
         lMiExzwXxUSnprM23Hnh/Aw+gVlxEnE62hU2n5AnhcTqiHBwEALhCqhskUPdokGwPJ71
         ABQUTKIWVQqIlQRaPxAvQN6CdhhjevODL3GEUq5XNtJca6OoV+PnfKHmQxySsAarvs14
         /z8bi8XOd4AcDGqtU8FOf0Rb9i24hSNSvrodIeK3PQKSvP5chKBuWq4VJREg4GEVB1nr
         dYbg==
X-Gm-Message-State: AAQBX9ftTfV7QbIgQkFYyzM86f8k6Bp/h9p8wciKDP6/5WxxhCmTGMZU
        idjlKO1eIFZkuVM8U1DIQfZXu5H1T3qKij6fnQ==
X-Google-Smtp-Source: AKy350YmhlUtJ1JNF1WBRpTF+TPlRqZ/iU4AhnXjjMUQjUQ91/jp8PojzYNo89aR9DsR0tyNJKptNQ==
X-Received: by 2002:a05:6a20:3a9a:b0:e3:8710:6846 with SMTP id d26-20020a056a203a9a00b000e387106846mr5768238pzh.10.1681298965894;
        Wed, 12 Apr 2023 04:29:25 -0700 (PDT)
Received: from thinkpad ([117.217.185.192])
        by smtp.gmail.com with ESMTPSA id v5-20020a62a505000000b00625e14d3a15sm11421561pfm.166.2023.04.12.04.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 04:29:25 -0700 (PDT)
Date:   Wed, 12 Apr 2023 16:59:18 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bhelgaas@google.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "dt-bindings: PCI: qcom: Add iommu-map properties"
Message-ID: <20230412112918.GB9463@thinkpad>
References: <20230411121533.22454-1-manivannan.sadhasivam@linaro.org>
 <20230411174742.GA3428751-robh@kernel.org>
 <20230411184231.GA59982@thinkpad>
 <ZDZouY0PEL64MT6N@lpieralisi>
 <20230412101112.GA9463@thinkpad>
 <ZDaMCcTD/Nwx0vnh@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZDaMCcTD/Nwx0vnh@lpieralisi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 12, 2023 at 12:46:33PM +0200, Lorenzo Pieralisi wrote:
> On Wed, Apr 12, 2023 at 03:41:12PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Apr 12, 2023 at 10:15:53AM +0200, Lorenzo Pieralisi wrote:
> > > On Wed, Apr 12, 2023 at 12:12:31AM +0530, Manivannan Sadhasivam wrote:
> > > > On Tue, Apr 11, 2023 at 12:47:42PM -0500, Rob Herring wrote:
> > > > > On Tue, Apr 11, 2023 at 05:45:33PM +0530, Manivannan Sadhasivam wrote:
> > > > > > This reverts commit 6ebfa40b63ae65eac20834ef4f45355fc5ef6899.
> > > > > > 
> > > > > > "iommu-map" property is already documented in commit
> > > > > 
> > > > > Need the commit hash here.
> > > > > 
> > > > > > ("dt-bindings: PCI: qcom: Add SM8550 compatible") along with the "iommus"
> > > > > > property.
> > > > > 
> > > > > Shouldn't there be a patch removing "iommus" as discussed?
> > > > > 
> > > > 
> > > > Yeah, that was my intention after the dts patches were merged. And since the
> > > > dts patches are in linux-next now, I could finally send the patch.
> > > 
> > > I don't understand what's the plan here. By the way, instead of merging
> > > this revert I just dropped the commit that this patch is reverting from
> > > the controller/qcom branch, please have a look to check if everything is
> > > what you expect it to be there.
> > > 
> > 
> > This is fine. The plan is to remove the "iommus" property from Qcom PCI binding
> > since we have removed the usage of that property from devicetree [1]. Initially
> > the iommu properties were not documented at all in the binding. But commit,
> > "dt-bindings: PCI: qcom: Add SM8550 compatible" added them to the binding to
> > satisfy dtbs check. But in parallel, the patch removing "iommus" property from
> > dts got merged to qcom tree.
> > 
> > So now we have 2 options here:
> > 
> > 1. Amend the commit "dt-bindings: PCI: qcom: Add SM8550 compatible" to remove
> > the "iommus" property.
> > 
> > 2. I will submit a separate patch removing that property.
> > 
> > Lorenzo, let me know what works for you. Sorry for the mess! Confusion happened
> > due to patches getting applied without sync.
> 
> You can inline a diff here for (1), I will amend the commit.
> 

Here you go:

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index a1318a4ecadf..1548a7114732 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -60,9 +60,6 @@ properties:
     minItems: 1
     maxItems: 8
 
-  iommus:
-    maxItems: 1
-
   iommu-map:
     maxItems: 2
 

- Mani

> Thanks,
> Lorenzo
> 
> > - Mani
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=6340b391e15094575911ab0d96bfff09deadafba
> > 
> > > Lorenzo
> > > 
> > > > - Mani
> > > > 
> > > > > > 
> > > > > > So let's revert the commit that just added "iommu-map" to avoid
> > > > > > duplication.
> > > > > > 
> > > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 --
> > > > > >  1 file changed, 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > > > > index 5d236bac99b6..a1318a4ecadf 100644
> > > > > > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > > > > @@ -78,8 +78,6 @@ properties:
> > > > > >  
> > > > > >    dma-coherent: true
> > > > > >  
> > > > > > -  iommu-map: true
> > > > > > -
> > > > > >    interconnects:
> > > > > >      maxItems: 2
> > > > > >  
> > > > > > -- 
> > > > > > 2.25.1
> > > > > > 
> > > > 
> > > > -- 
> > > > மணிவண்ணன் சதாசிவம்
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
