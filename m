Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D726DF22F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 12:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDLKqu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 06:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjDLKqn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 06:46:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712736EAD;
        Wed, 12 Apr 2023 03:46:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 026A2632E3;
        Wed, 12 Apr 2023 10:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DBCC433D2;
        Wed, 12 Apr 2023 10:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681296401;
        bh=Tr7sV3WyZ6on9eEvc7Hx0VuBM8bAoYrBgT9VuZrFKkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vPicg3eVeTDzbveoDfulpmZHOZi2awyobEqabPWEJY1aSq7NkoxiiX5WZSlGLXAh/
         RAKAywOwVdpaT+TwxqyPUK/j8GwPBYcaRi/kpX47h9BmEj4MFoVo+wLrNb2vLiW2V8
         pMfAFTUrWgUBAZ+rjoV+EB+rCvb26a8DpHoAegcckY/OVqISbOVAMEy7rGuPqo+uJN
         wJNg1sCS0Ca1RYq/zlJOXI0hc1378bX3la53LSmO0qS1JfHN0SE9B6w4QbARQypMJi
         ZGx2ZOXlqhehpQ70c7D+Mu1q0sXxlhc/OhQo7ITZow9eZrfUiYn7KQvE9Vq2eFpimP
         3FcEfZ/UXqMDw==
Date:   Wed, 12 Apr 2023 12:46:33 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bhelgaas@google.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "dt-bindings: PCI: qcom: Add iommu-map properties"
Message-ID: <ZDaMCcTD/Nwx0vnh@lpieralisi>
References: <20230411121533.22454-1-manivannan.sadhasivam@linaro.org>
 <20230411174742.GA3428751-robh@kernel.org>
 <20230411184231.GA59982@thinkpad>
 <ZDZouY0PEL64MT6N@lpieralisi>
 <20230412101112.GA9463@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230412101112.GA9463@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 12, 2023 at 03:41:12PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Apr 12, 2023 at 10:15:53AM +0200, Lorenzo Pieralisi wrote:
> > On Wed, Apr 12, 2023 at 12:12:31AM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Apr 11, 2023 at 12:47:42PM -0500, Rob Herring wrote:
> > > > On Tue, Apr 11, 2023 at 05:45:33PM +0530, Manivannan Sadhasivam wrote:
> > > > > This reverts commit 6ebfa40b63ae65eac20834ef4f45355fc5ef6899.
> > > > > 
> > > > > "iommu-map" property is already documented in commit
> > > > 
> > > > Need the commit hash here.
> > > > 
> > > > > ("dt-bindings: PCI: qcom: Add SM8550 compatible") along with the "iommus"
> > > > > property.
> > > > 
> > > > Shouldn't there be a patch removing "iommus" as discussed?
> > > > 
> > > 
> > > Yeah, that was my intention after the dts patches were merged. And since the
> > > dts patches are in linux-next now, I could finally send the patch.
> > 
> > I don't understand what's the plan here. By the way, instead of merging
> > this revert I just dropped the commit that this patch is reverting from
> > the controller/qcom branch, please have a look to check if everything is
> > what you expect it to be there.
> > 
> 
> This is fine. The plan is to remove the "iommus" property from Qcom PCI binding
> since we have removed the usage of that property from devicetree [1]. Initially
> the iommu properties were not documented at all in the binding. But commit,
> "dt-bindings: PCI: qcom: Add SM8550 compatible" added them to the binding to
> satisfy dtbs check. But in parallel, the patch removing "iommus" property from
> dts got merged to qcom tree.
> 
> So now we have 2 options here:
> 
> 1. Amend the commit "dt-bindings: PCI: qcom: Add SM8550 compatible" to remove
> the "iommus" property.
> 
> 2. I will submit a separate patch removing that property.
> 
> Lorenzo, let me know what works for you. Sorry for the mess! Confusion happened
> due to patches getting applied without sync.

You can inline a diff here for (1), I will amend the commit.

Thanks,
Lorenzo

> - Mani
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=6340b391e15094575911ab0d96bfff09deadafba
> 
> > Lorenzo
> > 
> > > - Mani
> > > 
> > > > > 
> > > > > So let's revert the commit that just added "iommu-map" to avoid
> > > > > duplication.
> > > > > 
> > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 --
> > > > >  1 file changed, 2 deletions(-)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > > > index 5d236bac99b6..a1318a4ecadf 100644
> > > > > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > > > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > > > @@ -78,8 +78,6 @@ properties:
> > > > >  
> > > > >    dma-coherent: true
> > > > >  
> > > > > -  iommu-map: true
> > > > > -
> > > > >    interconnects:
> > > > >      maxItems: 2
> > > > >  
> > > > > -- 
> > > > > 2.25.1
> > > > > 
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்
