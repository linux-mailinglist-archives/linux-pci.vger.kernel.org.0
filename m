Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271777D9836
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 14:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345650AbjJ0Mbn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 08:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345420AbjJ0Mbm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 08:31:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBB2129;
        Fri, 27 Oct 2023 05:31:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DB2C433CC;
        Fri, 27 Oct 2023 12:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698409899;
        bh=AcMSafgikuw0QDyO06n+uZljx9TSL1PuVKSPh0RB4Og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YXPd5is5+RQIvKnCK/8PpgTaXHBwPVeKYqBRMKl0KC/SBZQjgC8G4bAjW/wFEQqly
         Hm7If3WAqhzHtmrP8f/U4c/YSL83ewnD/cfMcBYeNl9lQ+2Mj1t2Ttti2SlCWGU8dy
         yG3SMedBeYlUVuboANt3CpegrTZuMnFEKKxv5UoZelpF/OaS2zRNr7Q/l5/pPOXIZ5
         bkCk7+3dbcK2TNEolNzGvkwFNZjeyFSVPEvfeolQim7sgvd8vOAxDoVealQMR3dqOq
         yuXNE8+anr0uHBQHT3y8FyGYez0G8EMaenJ3Ph5U5FvI6DVZIzKCvxYijSQ1XzKtaj
         x56tnB/J3nsDg==
Date:   Fri, 27 Oct 2023 18:01:25 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, dmitry.baryshkov@linaro.org,
        robh@kernel.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 2/5] PCI: qcom-ep: Add support for SA8775P SOC
Message-ID: <20231027123125.GC17527@thinkpad>
References: <1697715430-30820-1-git-send-email-quic_msarkar@quicinc.com>
 <1697715430-30820-3-git-send-email-quic_msarkar@quicinc.com>
 <20231025075317.GC3648@thinkpad>
 <adbca084-a74b-51be-67b5-a3b9e45da506@quicinc.com>
 <20231026061035.GA4915@thinkpad>
 <23f3f2a8-dcbd-6764-195b-49bcec451084@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23f3f2a8-dcbd-6764-195b-49bcec451084@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 26, 2023 at 12:29:30PM +0530, Mrinmay Sarkar wrote:
> 
> On 10/26/2023 11:40 AM, Manivannan Sadhasivam wrote:
> > On Thu, Oct 26, 2023 at 11:08:03AM +0530, Mrinmay Sarkar wrote:
> > > On 10/25/2023 1:23 PM, Manivannan Sadhasivam wrote:
> > > > On Thu, Oct 19, 2023 at 05:07:07PM +0530, Mrinmay Sarkar wrote:
> > > > > Add support for SA8775P SoC to the Qualcomm PCIe Endpoint Controller
> > > > > driver. There will be some change specific to SA8775P so adding new
> > > > > compatible string.
> > > > > 
> > > > What are those specific changes?
> > > > 
> > > > - Mani
> > > Need to enable cache snooping logic for SA8775P only.
> > > 
> > Then you can add the compatible to the driver at that time and use the fallback
> > till then i.e., just document the SA8775P compatible in bindings and use both
> > SA8775P and SM8450 compatibles in the dts where the latter will act as a
> > fallback.
> > 
> > - Mani
> 
> I am getting below error in dtb checking if I add SM8450 as fallback
> compatible in dtsi. As both has different set of clocks.
> 

Ok. I didn't realize that the clocks are different. In that case, you need to
mention it in the commit message to make it clear and introduce a new
compatible.

- Mani

> //local/mnt/workspace/Mrinmay/new_lemans/next-20231018/linux-next/out/arch/arm64/boot/dts/qcom/sa8775p-ride.dtb:
> pcie-ep@1c00000: compatible: 'oneOf' conditional failed, one must be
> fixed://
> //        ['qcom,sa8775p-pcie-ep', 'qcom,sm8450-pcie-ep'] is too long//
> //        'qcom,sdx65-pcie-ep' was expected//
> //        'qcom,sdx55-pcie-ep' was expected//
> //        from schema $id:
> http://devicetree.org/schemas/pci/qcom,pcie-ep.yaml#//
> ///local/mnt/workspace/Mrinmay/new_lemans/next-20231018/linux-next/out/arch/arm64/boot/dts/qcom/sa8775p-ride.dtb:
> pcie-ep@1c00000: clocks: [[31, 66], [31, 68], [31, 69], [31, 78], [31, 79]]
> is too short//
> //        from schema $id:
> http://devicetree.org/schemas/pci/qcom,pcie-ep.yaml#//
> ///local/mnt/workspace/Mrinmay/new_lemans/next-20231018/linux-next/out/arch/arm64/boot/dts/qcom/sa8775p-ride.dtb:
> pcie-ep@1c00000: clock-names: ['aux', 'cfg', 'bus_master', 'bus_slave',
> 'slave_q2a'] is too short/
> 
> > > --Mrinmay
> > > 
> > > > > Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> > > > > ---
> > > > >    drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
> > > > >    1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > > > index 32c8d9e..4c01c34 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > > > @@ -858,6 +858,7 @@ static void qcom_pcie_ep_remove(struct platform_device *pdev)
> > > > >    }
> > > > >    static const struct of_device_id qcom_pcie_ep_match[] = {
> > > > > +	{ .compatible = "qcom,sa8775p-pcie-ep", },
> > > > >    	{ .compatible = "qcom,sdx55-pcie-ep", },
> > > > >    	{ .compatible = "qcom,sm8450-pcie-ep", },
> > > > >    	{ }
> > > > > -- 
> > > > > 2.7.4
> > > > > 

-- 
மணிவண்ணன் சதாசிவம்
