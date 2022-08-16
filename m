Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2633E595FE0
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 18:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbiHPQKK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 12:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbiHPQJz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 12:09:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768DC4B0EE;
        Tue, 16 Aug 2022 09:06:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39A17B81A58;
        Tue, 16 Aug 2022 16:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87ED9C433D6;
        Tue, 16 Aug 2022 16:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660665990;
        bh=AXRucAZuPQWJSTJD1Vx5mJLTnGXWgijQwgdKGA4Eue0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eGzWZBgFTUxW507AhfQMNZWfwQDDW8wwAZ2QA9lOmD5wnOPvXiec4TPN0UZfRu6Qs
         Btn1lOgyowcm3l43mJejDK4tGw1stHHIz4Bk2XvxvmseQ3kB5yEhnSygHSSeONuPAf
         4aM6h4QEOqs6y6VlNUMiZIAxM/zh2ZlyTLCetImtkbL7Uk7/CYETDvxqIJM8k80o5k
         zBQAsHN5qfymfuNLMQKTftOEwbGNyfXLCGtW/PhxNteArXLm5StumOauOQAoSb6v7I
         Yiaxlr+V7xCNmInhyjfsN6T1WJ+vCnWhlV9Kx7foKfHmf41RLysOXiO20v8S1J+oJH
         QsnIx5UF6xx/Q==
Date:   Tue, 16 Aug 2022 18:06:21 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Brian Masney <bmasney@redhat.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
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
Message-ID: <YvvAfQJChCVX4cPH@lpieralisi>
References: <20220714071348.6792-1-johan+linaro@kernel.org>
 <20220714071348.6792-9-johan+linaro@kernel.org>
 <YtAny03L/RLk9nv6@xps13>
 <YtEaqHT7NdXPhK+y@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtEaqHT7NdXPhK+y@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 15, 2022 at 09:43:36AM +0200, Johan Hovold wrote:
> On Thu, Jul 14, 2022 at 10:27:23AM -0400, Brian Masney wrote:
> > On Thu, Jul 14, 2022 at 09:13:48AM +0200, Johan Hovold wrote:
> > > Sort the device-id table entries alphabetically by compatible string to
> > > make it easier to find entries and add new ones.
> > > 
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-qcom.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 8dddb72f8647..fea921cca8fa 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -1749,24 +1749,24 @@ static int qcom_pcie_remove(struct platform_device *pdev)
> > >  }
> > >  
> > >  static const struct of_device_id qcom_pcie_match[] = {
> > > +	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
> > >  	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
> > > +	{ .compatible = "qcom,pcie-ipq6018", .data = &cfg_2_9_0 },
> > >  	{ .compatible = "qcom,pcie-ipq8064", .data = &cfg_2_1_0 },
> > >  	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
> > > -	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
> > > -	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
> > >  	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
> > >  	{ .compatible = "qcom,pcie-ipq4019", .data = &cfg_2_4_0 },
> > 
> > qcom,pcie-ipq4019 should be moved up above qcom,pcie-ipq6018.
> 
> If we only had some sort of machine that could sort strings for us... ;)
> I'll rely on vim for this from now on.
> 
> Perhaps Bjorn H can fix that up when applying unless I'll be sending a
> v3 for some other reason. This series still depends on the MSI rework to
> be applied first.

I can do it while applying. A link to the lore archive for the MSI
rework please (I don't think it was merged for v6.0) ? I was away for
two months, catching up with threads.

Thanks,
Lorenzo

> Thanks for reviewing.
> 
> Johan
