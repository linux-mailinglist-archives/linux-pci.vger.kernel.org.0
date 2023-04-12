Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DF86DF1B8
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 12:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjDLKL2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 06:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjDLKL1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 06:11:27 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E82D95
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 03:11:22 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e18-20020a17090ac21200b00246952d917fso9482830pjt.4
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 03:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681294282; x=1683886282;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E8Dyl4+NdOephBJ8a5CGLrM2Bu7+ex2R8fnMkaTpqs4=;
        b=mz5OpN3ySFLWfaIDtFk+QVy7GrbLBKNedf9Vu+hPa+TK0mu13m7MrIQ8OEe6pbJAWQ
         fbNT7LpAG2fd4KTvtHfzUu6jof2ugDDGynUWoavd+e/Jt3PY6P5L+vYcwrabo+RSYWri
         ILmzz2EOWH/mZlpfbeU2MtvwJUMnUsDeK0FDzNJtDxRnR6SbeaMGJil5T9RGDlncPbib
         uAC5ZIexDvQORv2cI+I38V/ubGCDciwBgIFDqlFLf5Ia4SOWcFXnIYWEmKKQBgcIi/vy
         c86DUgPPBy+nlDR9ZeEfbfqxyM6Y9R7QN+6mFnclLLmy/UjO/QlzcGXgQ3uMC2tgB3Ib
         86NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681294282; x=1683886282;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E8Dyl4+NdOephBJ8a5CGLrM2Bu7+ex2R8fnMkaTpqs4=;
        b=UngnB4MUfc6755pXizCTeKmvKSRkVrcQ6YvAhW9/e9uMXr6WOCrFfuhTOpN/Yi5utP
         vIaUinmyn+L44dMYBW5PwNNpYdoDgWpCNeu1iXzY6SSvPtGLbP++WTnUo0CwAbizZ17c
         9sN/GZoNM6Ny9OOcs73REXJjTZiwFVVLilPlALb2WtVCEe8rO+69CQiO4aitOhbR/NwR
         KzsXEy1BlDM8f08M6e5j4qsfZhPclsaysnCTgiWiCvjZ91PssQDQUCpaykWzy5fgnHHG
         5rV7J8crvqUGpq4VhZkeVnbcCZvlAStFI+WNCyQc+DeD5is84yankCjvEro+XbnxGCsg
         Keeg==
X-Gm-Message-State: AAQBX9cD55Gx18ThvYFiOgyKCCbvFQXYtoWofvNIxuscNvNni0W8rShQ
        WZKeLAncg8E3po0aezJYaghP
X-Google-Smtp-Source: AKy350ag0nT+T/UdRSRwoJJZyisBeaEREEvNiKolME4G238ayYlNBBq1ZXotsF5BB8/0cI9XV4UrbA==
X-Received: by 2002:a17:902:ce86:b0:1a6:4532:1159 with SMTP id f6-20020a170902ce8600b001a645321159mr7580106plg.63.1681294281569;
        Wed, 12 Apr 2023 03:11:21 -0700 (PDT)
Received: from thinkpad ([117.216.120.128])
        by smtp.gmail.com with ESMTPSA id iz15-20020a170902ef8f00b001a1dc2be791sm6121654plb.259.2023.04.12.03.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 03:11:21 -0700 (PDT)
Date:   Wed, 12 Apr 2023 15:41:12 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bhelgaas@google.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "dt-bindings: PCI: qcom: Add iommu-map properties"
Message-ID: <20230412101112.GA9463@thinkpad>
References: <20230411121533.22454-1-manivannan.sadhasivam@linaro.org>
 <20230411174742.GA3428751-robh@kernel.org>
 <20230411184231.GA59982@thinkpad>
 <ZDZouY0PEL64MT6N@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZDZouY0PEL64MT6N@lpieralisi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 12, 2023 at 10:15:53AM +0200, Lorenzo Pieralisi wrote:
> On Wed, Apr 12, 2023 at 12:12:31AM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Apr 11, 2023 at 12:47:42PM -0500, Rob Herring wrote:
> > > On Tue, Apr 11, 2023 at 05:45:33PM +0530, Manivannan Sadhasivam wrote:
> > > > This reverts commit 6ebfa40b63ae65eac20834ef4f45355fc5ef6899.
> > > > 
> > > > "iommu-map" property is already documented in commit
> > > 
> > > Need the commit hash here.
> > > 
> > > > ("dt-bindings: PCI: qcom: Add SM8550 compatible") along with the "iommus"
> > > > property.
> > > 
> > > Shouldn't there be a patch removing "iommus" as discussed?
> > > 
> > 
> > Yeah, that was my intention after the dts patches were merged. And since the
> > dts patches are in linux-next now, I could finally send the patch.
> 
> I don't understand what's the plan here. By the way, instead of merging
> this revert I just dropped the commit that this patch is reverting from
> the controller/qcom branch, please have a look to check if everything is
> what you expect it to be there.
> 

This is fine. The plan is to remove the "iommus" property from Qcom PCI binding
since we have removed the usage of that property from devicetree [1]. Initially
the iommu properties were not documented at all in the binding. But commit,
"dt-bindings: PCI: qcom: Add SM8550 compatible" added them to the binding to
satisfy dtbs check. But in parallel, the patch removing "iommus" property from
dts got merged to qcom tree.

So now we have 2 options here:

1. Amend the commit "dt-bindings: PCI: qcom: Add SM8550 compatible" to remove
the "iommus" property.

2. I will submit a separate patch removing that property.

Lorenzo, let me know what works for you. Sorry for the mess! Confusion happened
due to patches getting applied without sync.

- Mani

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=6340b391e15094575911ab0d96bfff09deadafba

> Lorenzo
> 
> > - Mani
> > 
> > > > 
> > > > So let's revert the commit that just added "iommu-map" to avoid
> > > > duplication.
> > > > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 --
> > > >  1 file changed, 2 deletions(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > > index 5d236bac99b6..a1318a4ecadf 100644
> > > > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > > @@ -78,8 +78,6 @@ properties:
> > > >  
> > > >    dma-coherent: true
> > > >  
> > > > -  iommu-map: true
> > > > -
> > > >    interconnects:
> > > >      maxItems: 2
> > > >  
> > > > -- 
> > > > 2.25.1
> > > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
