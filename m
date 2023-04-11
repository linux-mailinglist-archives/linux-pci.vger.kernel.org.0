Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D806DDA1B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 13:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjDKLwZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 07:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjDKLwX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 07:52:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA06E0;
        Tue, 11 Apr 2023 04:52:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0E5662292;
        Tue, 11 Apr 2023 11:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F87C433EF;
        Tue, 11 Apr 2023 11:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681213941;
        bh=7RJUk4YSpd3pqSy0exl1oYWF66yQpy0/ne486dtH/XM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c1gOSy88hc71+QkoCHhohvTl/y7A+kQeo7BHoUCffJqiu75CRPLLtcZljbp7c1tkK
         CtAtZ+H1vzm6I1idVCZdhZiSwX9Ku3emALK6adwDciQtTSRJk2/W3qIkGF+yB20PNc
         Sx2RV87NVXxczyNoNCqgWzrVEdhPenghf+raL60PnomNznqiHYC4cwSEOr/RhazCYX
         sMpF6bwTcZqy5NimR+veX23m7xDpm1q4MMZjzBfQ4/WawLoBQCcdf1G+m4fMsdYCRi
         l5y96hmZLSNOwQXVRsVYPeSQ+1RSOouhWKqq7Z1GHe/CMaxKt/0RLMe/h/LRnWDArR
         nSWwSz5zbxdiA==
Date:   Tue, 11 Apr 2023 17:22:01 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, mani@kernel.org, p.zabel@pengutronix.de,
        linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
Subject: Re: [PATCH V2 5/9] dt-bindings: PCI: qcom: Add IPQ9574
Message-ID: <20230411115201.GM5333@thinkpad>
References: <20230404164828.8031-1-quic_devipriy@quicinc.com>
 <20230404164828.8031-6-quic_devipriy@quicinc.com>
 <79ddaff0-00a9-36db-2bc0-4c844ffd9528@linaro.org>
 <999dfe1c-3b0d-1cc1-7407-e0917fc62d77@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <999dfe1c-3b0d-1cc1-7407-e0917fc62d77@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 11, 2023 at 04:27:23PM +0530, Devi Priya wrote:
> 
> 
> On 4/5/2023 12:28 PM, Krzysztof Kozlowski wrote:
> > On 04/04/2023 18:48, Devi Priya wrote:
> > > Add bindings for PCIe hosts on IPQ9574 platform and allow
> > > msi-parent property
> > 
> > Missing full stop. Also in your other patches.
> Okay
> > 
> > > 
> > > Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> > > ---
> > >   Changes in V2:
> > > 	- Updated the commit message and dropped the aggr_noc entries
> > > 	  as it will be handled via interconnect driver
> > > 
> > >   .../devicetree/bindings/pci/qcom,pcie.yaml    | 48 +++++++++++++++++++
> > >   1 file changed, 48 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > index fb32c43dd12d..8657ab65008c 100644
> > > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > @@ -26,6 +26,7 @@ properties:
> > >             - qcom,pcie-ipq8064-v2
> > >             - qcom,pcie-ipq8074
> > >             - qcom,pcie-ipq8074-gen3
> > > +          - qcom,pcie-ipq9574
> > >             - qcom,pcie-msm8996
> > >             - qcom,pcie-qcs404
> > >             - qcom,pcie-sa8540p
> > > @@ -105,6 +106,8 @@ properties:
> > >       items:
> > >         - const: pciephy
> > > +  msi-parent: true
> > 
> 
> Yes right, will rebase it on Mani's series.
> But, as you have pointed out don't see the binding changes
> in linux-next/master
> Mani, could you please provide the tree details onto which the
> binding change is merged?
> 

Looks like the initial msi-map binding's patch [1] never got merged even though
the dts patch went in.

I'll squash the later fix to this, post v4 and CC you.

- Mani

[1] https://lore.kernel.org/all/20230102105821.28243-3-manivannan.sadhasivam@linaro.org/

> > Isn't this conflicting with Mani's series:
> > https://lore.kernel.org/all/20230108203340.GA229573-robh@kernel.org/
> > https://lore.kernel.org/all/20230111123004.21048-1-manivannan.sadhasivam@linaro.org/#t
> > 
> > Although for some reason Mani's patch references non-existing commit and
> > hunk...
> > 
> > Best regards,
> > Krzysztof
> > 
> Best Regards,
> Devi Priya

-- 
மணிவண்ணன் சதாசிவம்
