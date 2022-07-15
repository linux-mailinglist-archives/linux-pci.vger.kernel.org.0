Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C30575C94
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 09:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiGOHni (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 03:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiGOHne (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 03:43:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A085D1DF;
        Fri, 15 Jul 2022 00:43:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D518619CB;
        Fri, 15 Jul 2022 07:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3E4C34115;
        Fri, 15 Jul 2022 07:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657871012;
        bh=0iGDNIkKNv/Up65EK2U2773EXnDVZqycw7MK0mT2K0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gGAovutajNnUoHyY93NBbHukld9fKKNu1xIGKtRyYAsdFeIrQdRy0CLI0IaVZnGpW
         pHnbRPPireGo6J5ShQxtpjDP2gd/YitIEvRc2ALODmhP6EdGSICookvTZsxbVXa/Sf
         RG5PVN9W+CCe8YuikNVmRcbOKRLUlkmMFqb0vXWhKeaSdyi6EcK2xuMDAkgflXqpRN
         b83WEOPD8/QT5nKJanjqA1SDkrNfWP/P1jbBRP9IiAm1KnTS3DaTPP2ESt2jwdrFwe
         JLRY7zh+CCI8FW2rt504Bb8snjLg6Nv/CgpGgrzb1cy0gEnHABe3HZg/SUidN9DL3X
         BI7hDF7fAdCWw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oCFz6-0007tQ-Od; Fri, 15 Jul 2022 09:43:37 +0200
Date:   Fri, 15 Jul 2022 09:43:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] PCI: qcom: Sort device-id table
Message-ID: <YtEaqHT7NdXPhK+y@hovoldconsulting.com>
References: <20220714071348.6792-1-johan+linaro@kernel.org>
 <20220714071348.6792-9-johan+linaro@kernel.org>
 <YtAny03L/RLk9nv6@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtAny03L/RLk9nv6@xps13>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 14, 2022 at 10:27:23AM -0400, Brian Masney wrote:
> On Thu, Jul 14, 2022 at 09:13:48AM +0200, Johan Hovold wrote:
> > Sort the device-id table entries alphabetically by compatible string to
> > make it easier to find entries and add new ones.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 8dddb72f8647..fea921cca8fa 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1749,24 +1749,24 @@ static int qcom_pcie_remove(struct platform_device *pdev)
> >  }
> >  
> >  static const struct of_device_id qcom_pcie_match[] = {
> > +	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
> >  	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
> > +	{ .compatible = "qcom,pcie-ipq6018", .data = &cfg_2_9_0 },
> >  	{ .compatible = "qcom,pcie-ipq8064", .data = &cfg_2_1_0 },
> >  	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
> > -	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
> > -	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
> >  	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
> >  	{ .compatible = "qcom,pcie-ipq4019", .data = &cfg_2_4_0 },
> 
> qcom,pcie-ipq4019 should be moved up above qcom,pcie-ipq6018.

If we only had some sort of machine that could sort strings for us... ;)
I'll rely on vim for this from now on.

Perhaps Bjorn H can fix that up when applying unless I'll be sending a
v3 for some other reason. This series still depends on the MSI rework to
be applied first.

Thanks for reviewing.

Johan
