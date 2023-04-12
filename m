Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7377C6DED57
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 10:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjDLIQE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 04:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjDLIQD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 04:16:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916CDFC;
        Wed, 12 Apr 2023 01:16:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C98862F53;
        Wed, 12 Apr 2023 08:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145D7C433EF;
        Wed, 12 Apr 2023 08:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681287360;
        bh=cYGLuhrnmzlOrQY4GPjvQrjAZMGeHUI8Q3IUNRi/rpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L2vJGHEj9+I6HvrX/reWlTyE3ZjC7n016eJ0kRowVvlirkFCmMnKZuAEqvJmSOHsn
         Cbjpzph6EbRTHLbYVh6n7pRqjNC6SVPyFJj2dr6jPW831dY41JDkYHvK5TtSdGi0aL
         m378zOczEuQr3npwBi4jvS5prLcK1UWrPVhoaoJ8KhVqh9b/3bknngcA7Ck6YPMW37
         sQXEqwZAhNIw6RITV6rIp+vJywCR2Sc9IyuezN1JuoojcXVZukKEOdDtH06iL3SW1U
         418v0oYtLRmLFzAU22Z5GilXjGlnrAFlRf/ATedgbH1R+T2QsUU/rP0tl1HzJK4KFb
         tfWIGSmQ+kHOQ==
Date:   Wed, 12 Apr 2023 10:15:53 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bhelgaas@google.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "dt-bindings: PCI: qcom: Add iommu-map properties"
Message-ID: <ZDZouY0PEL64MT6N@lpieralisi>
References: <20230411121533.22454-1-manivannan.sadhasivam@linaro.org>
 <20230411174742.GA3428751-robh@kernel.org>
 <20230411184231.GA59982@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411184231.GA59982@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 12, 2023 at 12:12:31AM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 11, 2023 at 12:47:42PM -0500, Rob Herring wrote:
> > On Tue, Apr 11, 2023 at 05:45:33PM +0530, Manivannan Sadhasivam wrote:
> > > This reverts commit 6ebfa40b63ae65eac20834ef4f45355fc5ef6899.
> > > 
> > > "iommu-map" property is already documented in commit
> > 
> > Need the commit hash here.
> > 
> > > ("dt-bindings: PCI: qcom: Add SM8550 compatible") along with the "iommus"
> > > property.
> > 
> > Shouldn't there be a patch removing "iommus" as discussed?
> > 
> 
> Yeah, that was my intention after the dts patches were merged. And since the
> dts patches are in linux-next now, I could finally send the patch.

I don't understand what's the plan here. By the way, instead of merging
this revert I just dropped the commit that this patch is reverting from
the controller/qcom branch, please have a look to check if everything is
what you expect it to be there.

Lorenzo

> - Mani
> 
> > > 
> > > So let's revert the commit that just added "iommu-map" to avoid
> > > duplication.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 --
> > >  1 file changed, 2 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > index 5d236bac99b6..a1318a4ecadf 100644
> > > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > @@ -78,8 +78,6 @@ properties:
> > >  
> > >    dma-coherent: true
> > >  
> > > -  iommu-map: true
> > > -
> > >    interconnects:
> > >      maxItems: 2
> > >  
> > > -- 
> > > 2.25.1
> > > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
