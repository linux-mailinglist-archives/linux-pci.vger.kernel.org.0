Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA7F57397C
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 16:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbiGMO7k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 10:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236608AbiGMO7k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 10:59:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D24F1031;
        Wed, 13 Jul 2022 07:59:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31A8261E2D;
        Wed, 13 Jul 2022 14:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED0BC34114;
        Wed, 13 Jul 2022 14:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657724378;
        bh=ea3eb/QIQfOUewT0mimlbNr1tOOqoDalSZngk8wxy/M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KfhfkFhoRoy8kDeEw5OuiMLXU9o4L8V4FDg8QI0CXzjFaRA0jn2vi0PToz4Ts3ULJ
         t8NrWNzf/df7Xt8CcLVoYp6SaQ5OxDOuTVDrKJuZEQQ8FCSSh9C29RmjXDOAjyX1+C
         ycLSIMXJ3zyjjTp0+XUJaA7zMIokr4aUgtPk+RCVgk5BjZZESCR6gjqicrSB1tGHop
         Pd92hBMeaY18XA3ziAaEs0uAFqhOo7KaB/Q37OFLBHpvZsgo3vge+dYAy+QxAYTL9b
         h0WLHVJ+akOb1t1ucVsWs4+uvo57rCIknOo9qrKNFkDyeOXKsRbQM5lxLFI1WjSSni
         ub9L/nD3HZw/w==
Date:   Wed, 13 Jul 2022 09:59:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Johan Hovold <johan@kernel.org>
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
Message-ID: <20220713145935.GA823122@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys5gUulbU++HvRPC@hovoldconsulting.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 13, 2022 at 08:04:02AM +0200, Johan Hovold wrote:
> On Tue, Jul 12, 2022 at 02:51:37PM -0500, Bjorn Helgaas wrote:
> > On Thu, Jul 07, 2022 at 04:45:52PM +0300, Dmitry Baryshkov wrote:
> > > Fix the typo (compatibles vs compatible) in the condition guarding the
> > > resets being required everywhere except MSM8996.
> > > 
> > > Fixes: 6700a9b00f0a ("dt-bindings: PCI: qcom: Do not require resets on msm8996 platforms")
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > 
> > Applied for v5.20, thanks!
> 
> Glad to see this fixed, Bjorn H, but was there any particular reason why
> you picked this version over the patch I submitted a week earlier when
> reporting the issue?

Sorry, my mistake.  I'll drop this and replace with your patch.

> I posted a link to it earlier in this thread:
> 
> 	https://lore.kernel.org/lkml/20220629141000.18111-2-johan+linaro@kernel.org/
> 
> > > ---
> > >  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > index 0b69b12b849e..9b3ebee938e8 100644
> > > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > @@ -614,7 +614,7 @@ allOf:
> > >    - if:
> > >        not:
> > >          properties:
> > > -          compatibles:
> > > +          compatible:
> > >              contains:
> > >                enum:
> > >                  - qcom,pcie-msm8996
> > > -- 
> > > 2.35.1
> > > 
> 
> Johan
