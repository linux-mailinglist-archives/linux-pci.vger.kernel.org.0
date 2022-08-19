Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CAC599659
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 09:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346719AbiHSHrD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 03:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbiHSHrC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 03:47:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04A4D7429;
        Fri, 19 Aug 2022 00:47:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57C9D6150B;
        Fri, 19 Aug 2022 07:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B8BC433C1;
        Fri, 19 Aug 2022 07:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660895220;
        bh=Em3J87UAnVJ85gv0oSrm3kKkfOsRWsOBe6EAHU7l2Y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RV1Xgtnoo11aUynUI43snFihEUiJoxtsfSp/+affmZxiR3uKDGeje2ZF6KKwRxeWL
         UmHgZoqTk5cPEOnmSXqjIR5E3XZgWsgRtMD411I+TmDEQAlagV9oV1Fz8ngZ+DPO2+
         0153hl+uIca2TT2mNsIBe7xTmuPUuJ9G8Ttqew/m4mUEI3yT5HA2+0XUKeNW9d4BTH
         9SRTgPkp4TU2DggDJeGBfN4EWkjCeccF4Qm0kg9t1OVss1mCov+mvEI4jzGI4J4rak
         QI7vNC4xAuNRTsae/OR3WEp0n6yOwC9pIy3zqL87xzIlXJXKuh11H7y8KncU9yUb3G
         4k1x5RCwizUxA==
Date:   Fri, 19 Aug 2022 09:46:51 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Johan Hovold <johan@kernel.org>, Brian Masney <bmasney@redhat.com>,
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
Message-ID: <Yv8/6x7pgrBhzdbQ@lpieralisi>
References: <20220714071348.6792-1-johan+linaro@kernel.org>
 <20220714071348.6792-9-johan+linaro@kernel.org>
 <YtAny03L/RLk9nv6@xps13>
 <YtEaqHT7NdXPhK+y@hovoldconsulting.com>
 <YvvAfQJChCVX4cPH@lpieralisi>
 <20220818200530.lab2zlcaetekcclq@halaneylaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818200530.lab2zlcaetekcclq@halaneylaptop>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 18, 2022 at 03:05:30PM -0500, Andrew Halaney wrote:
> Hi Lorenzo,
> 
> On Tue, Aug 16, 2022 at 06:06:21PM +0200, Lorenzo Pieralisi wrote:
> > On Fri, Jul 15, 2022 at 09:43:36AM +0200, Johan Hovold wrote:
> > > On Thu, Jul 14, 2022 at 10:27:23AM -0400, Brian Masney wrote:
> > > > On Thu, Jul 14, 2022 at 09:13:48AM +0200, Johan Hovold wrote:
> > > > > Sort the device-id table entries alphabetically by compatible string to
> > > > > make it easier to find entries and add new ones.
> > > > > 
> > > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > > > ---
> > > > >  drivers/pci/controller/dwc/pcie-qcom.c | 12 ++++++------
> > > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > index 8dddb72f8647..fea921cca8fa 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > @@ -1749,24 +1749,24 @@ static int qcom_pcie_remove(struct platform_device *pdev)
> > > > >  }
> > > > >  
> > > > >  static const struct of_device_id qcom_pcie_match[] = {
> > > > > +	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
> > > > >  	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
> > > > > +	{ .compatible = "qcom,pcie-ipq6018", .data = &cfg_2_9_0 },
> > > > >  	{ .compatible = "qcom,pcie-ipq8064", .data = &cfg_2_1_0 },
> > > > >  	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
> > > > > -	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
> > > > > -	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
> > > > >  	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
> > > > >  	{ .compatible = "qcom,pcie-ipq4019", .data = &cfg_2_4_0 },
> > > > 
> > > > qcom,pcie-ipq4019 should be moved up above qcom,pcie-ipq6018.
> > > 
> > > If we only had some sort of machine that could sort strings for us... ;)
> > > I'll rely on vim for this from now on.
> > > 
> > > Perhaps Bjorn H can fix that up when applying unless I'll be sending a
> > > v3 for some other reason. This series still depends on the MSI rework to
> > > be applied first.
> > 
> > I can do it while applying. A link to the lore archive for the MSI
> > rework please (I don't think it was merged for v6.0) ? I was away for
> > two months, catching up with threads.
> 
> I don't see a reply to this, so here I am following up out of interest
> for getting this in mainline for my x13s laptop to use.
> 
> It appears the MSI rework[0] (which is in the cover letter here so I
> know I grabbed the right thing) was applied in 6.0:
> 
>     ahalaney@halaneylaptop ~/git/linux (git)-[remotes/upstream/HEAD] % git log --oneline --abbrev=12 --grep=2436629 v6.0-rc1 -- drivers/pci/controller/dwc/ 
>     cd761378e62c PCI: dwc: Handle MSIs routed to multiple GIC interrupts
>     db388348acff PCI: dwc: Convert struct pcie_port.msi_irq to an array
>     226ec087497a PCI: dwc: Split MSI IRQ parsing/allocation to a separate function
>     3c62f878a969 PCI: dwc: Correct msi_irq condition in dw_pcie_free_msi()
>     ahalaney@halaneylaptop ~/git/linux (git)-[remotes/upstream/HEAD] %
> 
> Just a friendly FYI, hope that helps!

Thanks for the heads-up, I will merge this series then.

Lorenzo

> [0] https://lore.kernel.org/all/20220707134733.2436629-6-dmitry.baryshkov@linaro.org/
> 
> Thanks,
> Andrew
> 
> > 
> > Thanks,
> > Lorenzo
> > 
> > > Thanks for reviewing.
> > > 
> > > Johan
> 
