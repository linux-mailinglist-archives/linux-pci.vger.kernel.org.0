Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62059562EA6
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 10:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbiGAIqM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 04:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiGAIqM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 04:46:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0407126B;
        Fri,  1 Jul 2022 01:46:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBBC7621BA;
        Fri,  1 Jul 2022 08:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4044FC3411E;
        Fri,  1 Jul 2022 08:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656665170;
        bh=d8YS2MfyIifK2eexLKF4rU7qHuCuM0M62Yrtfq5jCDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OiP0RmofRuxnGV2te9aHbDTTi2PSWuFavTk5civOdJw67OkzxBMnn3p87wCYBt4G+
         tWQzNjX2QjweJYAEFyv2rPPI5qALy0SXF4aLiSXtIcvvBSwspSacBFofei/fr94V/J
         sg8/YVR2Etu/bWmXB93KOhZnENbkvml5+wGweFvW1l1kAGuQE+hpzWpuZ6nF7VToyX
         FsiTEq0WJvAGQZUfbm7SKQG5Y+mH8mcC2R7kdmRQDtZ9e4cMVBGsqa+s6+l45YyCrp
         jxoXuYPvaQkIMoGEXasVNAM5EYFa/hTlHAmyzAhjs68VZuJF87Tn6n/Hr0W3H9C1bO
         MgjWsq5XpRJZA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o7CHy-0001hi-34; Fri, 01 Jul 2022 10:46:10 +0200
Date:   Fri, 1 Jul 2022 10:46:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] PCI: qcom: Sort device-id table
Message-ID: <Yr60Ugswl8kKpbbT@hovoldconsulting.com>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-11-johan+linaro@kernel.org>
 <0cb92a07-b310-ddc8-a705-522842a6939f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cb92a07-b310-ddc8-a705-522842a6939f@linaro.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 01, 2022 at 10:40:52AM +0200, Krzysztof Kozlowski wrote:
> On 29/06/2022 16:10, Johan Hovold wrote:
> > Sort the device-id table entries alphabetically by compatible string to
> > make it easier to find entries and add new ones.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 567601679465..093f4d4bc15d 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1572,23 +1572,23 @@ static int qcom_pcie_remove(struct platform_device *pdev)
> >  }
> >  
> >  static const struct of_device_id qcom_pcie_match[] = {
> > +	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
> >  	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
> >  	{ .compatible = "qcom,pcie-ipq8064", .data = &cfg_2_1_0 },
> >  	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
> > -	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
> > -	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
> >  	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
> >  	{ .compatible = "qcom,pcie-ipq4019", .data = &cfg_2_4_0 },
> > -	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
> > +	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
> >  	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
> > +	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
> > +	{ .compatible = "qcom,pcie-sc8180x", .data = &cfg_1_9_0 },
> > +	{ .compatible = "qcom,pcie-sc8280xp", .data = &cfg_1_9_0 },
> >  	{ .compatible = "qcom,pcie-sdm845", .data = &cfg_2_7_0 },
> >  	{ .compatible = "qcom,pcie-sm8150", .data = &cfg_1_9_0 },
> >  	{ .compatible = "qcom,pcie-sm8250", .data = &cfg_1_9_0 },
> > -	{ .compatible = "qcom,pcie-sc8180x", .data = &cfg_1_9_0 },
> > -	{ .compatible = "qcom,pcie-sc8280xp", .data = &cfg_1_9_0 },
> >  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
> >  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
> > -	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
> > +	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
> 
> Idea is good but it is not sorted alphabetically (not entirely). Q goes
> before S.

Heh. I blame the heat.

Johan
