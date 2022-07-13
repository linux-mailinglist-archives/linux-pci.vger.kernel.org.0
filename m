Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA56572DDB
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 08:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbiGMGEO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 02:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiGMGED (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 02:04:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DB32317A;
        Tue, 12 Jul 2022 23:04:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C35E161C28;
        Wed, 13 Jul 2022 06:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A08C3411E;
        Wed, 13 Jul 2022 06:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657692240;
        bh=clshhfy1J+TLRTFrz2aXf8/1oU1ARgiSNdbXmyDmDwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EElNlRrHnK9cL9IIdHUgX/zk+YTjhG1txHxdK+jYdHWl48jS0p4GVKQ3EuXD54kpP
         CY6+nFn4tw2DugWBYjk3cn6KDLozCT0UQmqRSS+31ichOF2nb0I0MfhgXpUgthYRc/
         XDLHM2NYbTpZexkRoayUrvF7z8GaWzdMVFXkTAdE67i5xc+g1NXQwaC289ZcBaaq0I
         g3xyWWq+8F1xtBPwYXCDsGDLzlJsfRdu0ZfKL0jdjTKzEnB6zeeW6REXkKuYG95nsz
         RFXG5NJftanZxDLcKhgtvvlhxi5a5mSsdwfcHgDEG9/NNE/806Qbaw6yAmxKq8qhxT
         Drs7ISq1pA4KQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oBVTe-0000Fn-Db; Wed, 13 Jul 2022 08:04:02 +0200
Date:   Wed, 13 Jul 2022 08:04:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: fix typo in condition guarding
 resets
Message-ID: <Ys5gUulbU++HvRPC@hovoldconsulting.com>
References: <20220707134552.2436442-1-dmitry.baryshkov@linaro.org>
 <20220712195137.GA790567@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712195137.GA790567@bhelgaas>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 12, 2022 at 02:51:37PM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 07, 2022 at 04:45:52PM +0300, Dmitry Baryshkov wrote:
> > Fix the typo (compatibles vs compatible) in the condition guarding the
> > resets being required everywhere except MSM8996.
> > 
> > Fixes: 6700a9b00f0a ("dt-bindings: PCI: qcom: Do not require resets on msm8996 platforms")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Applied for v5.20, thanks!

Glad to see this fixed, Bjorn H, but was there any particular reason why
you picked this version over the patch I submitted a week earlier when
reporting the issue?

I posted a link to it earlier in this thread:

	https://lore.kernel.org/lkml/20220629141000.18111-2-johan+linaro@kernel.org/

> > ---
> >  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > index 0b69b12b849e..9b3ebee938e8 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > @@ -614,7 +614,7 @@ allOf:
> >    - if:
> >        not:
> >          properties:
> > -          compatibles:
> > +          compatible:
> >              contains:
> >                enum:
> >                  - qcom,pcie-msm8996
> > -- 
> > 2.35.1
> > 

Johan
