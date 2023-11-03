Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9947E0180
	for <lists+linux-pci@lfdr.de>; Fri,  3 Nov 2023 11:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346272AbjKCH7H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Nov 2023 03:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346404AbjKCH7E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2023 03:59:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55F8D42;
        Fri,  3 Nov 2023 00:59:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F884C433C8;
        Fri,  3 Nov 2023 07:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698998340;
        bh=qtqj9OcXQ0iJ8x3L6ERsYaZ8Di9Scjzubky7iBS/P+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TfY5gDc10v1zOKbNWcFNALTh2Q5pUyUv6TL2J3Y3/xy8uaJKFJOoBGuKXkMOQVPfv
         1LvUCqNK7xvo5M5lkVovgiUkRmHeCQUdqXrq3G75tMl6xkStdO2EqbVdZazFsCn/N5
         xpBYnkgNtaG/Jar/jP2hEnUCyTIQm+3dedS8ATUKIRC6iCMlkGUOr8Jf42v1FcgRw9
         /NzGaz7k7m+sgHpkiyiUC6+3pZhcdvJAHTSzPwrWo0xrllUbWGm8OOLknYwLk8yxdc
         7/BshZ3WmshVeIKYDbmtR4xv9Rt+GL62+HIruVbBlL3IdWiz8VTwfDTYY1Bpw6m2vL
         cfn3M5sFPr7hg==
Date:   Fri, 3 Nov 2023 13:28:49 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, robh+dt@kernel.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, robh@kernel.org,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, quic_schintav@quicinc.com,
        quic_shijjose@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 1/3] PCI: qcom: Enable cache coherency for SA8775P RC
Message-ID: <20231103075849.GA3039@thinkpad>
References: <1698767186-5046-1-git-send-email-quic_msarkar@quicinc.com>
 <1698767186-5046-2-git-send-email-quic_msarkar@quicinc.com>
 <CAA8EJpoMoUvF8R3PjgCNijS6-8Gs5FjvC6dYerNBVBuYW3FmPA@mail.gmail.com>
 <20231102163619.GA20943@thinkpad>
 <21dea74b-b802-2e69-af4b-07dfb68b7024@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21dea74b-b802-2e69-af4b-07dfb68b7024@linaro.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 02, 2023 at 11:25:36PM +0100, Konrad Dybcio wrote:
> 
> 
> On 02/11/2023 17:36, Manivannan Sadhasivam wrote:
> > On Thu, Nov 02, 2023 at 05:34:24PM +0200, Dmitry Baryshkov wrote:
> > > On Tue, 31 Oct 2023 at 17:46, Mrinmay Sarkar <quic_msarkar@quicinc.com> wrote:
> > > > 
> > > > This change will enable cache snooping logic to support
> > > > cache coherency for SA8755P RC platform.
> > > > 
> > > > Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> > > > ---
> > > >   drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
> > > >   1 file changed, 11 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > index 6902e97..6f240fc 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > @@ -51,6 +51,7 @@
> > > >   #define PARF_SID_OFFSET                                0x234
> > > >   #define PARF_BDF_TRANSLATE_CFG                 0x24c
> > > >   #define PARF_SLV_ADDR_SPACE_SIZE               0x358
> > > > +#define PCIE_PARF_NO_SNOOP_OVERIDE             0x3d4
> > > >   #define PARF_DEVICE_TYPE                       0x1000
> > > >   #define PARF_BDF_TO_SID_TABLE_N                        0x2000
> > > > 
> > > > @@ -117,6 +118,9 @@
> > > >   /* PARF_LTSSM register fields */
> > > >   #define LTSSM_EN                               BIT(8)
> > > > 
> > > > +/* PARF_NO_SNOOP_OVERIDE register value */
> > > > +#define NO_SNOOP_OVERIDE_EN                    0xa
> > > > +
> > > >   /* PARF_DEVICE_TYPE register fields */
> > > >   #define DEVICE_TYPE_RC                         0x4
> > > > 
> > > > @@ -961,6 +965,13 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> > > > 
> > > >   static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
> > > >   {
> > > > +       struct dw_pcie *pci = pcie->pci;
> > > > +       struct device *dev = pci->dev;
> > > > +
> > > > +       /* Enable cache snooping for SA8775P */
> > > > +       if (of_device_is_compatible(dev->of_node, "qcom,pcie-sa8775p"))
> > > 
> > > Obviously: please populate a flag in the data structures instead of
> > > doing of_device_is_compatible(). Same applies to the patch 2.
> > > 
> > 
> > Not necessary at this point. For some unknown reasons, the HW team ended up
> > disabling cache snooping on this specific platform. Whereas on other platforms,
> > it is enabled by default. So I have low expectations that we would need this
> > setting on other platforms in the future.
> > 
> > My concern with the usage of flag is that it warrants a new "qcom_pcie_cfg"
> > instance just for this quirk and it looks overkill to me.
> > 
> > So if we endup seeing this behavior on other platforms as well (unlikely) then
> > we can switch to the flag approach.
> This register reads zeroes on 8250, can we confirm it works as
> expected there?

I don't know if this register is even implemented in 8250. Mrinmay, can you
check?

> I guess some benchmarks with and without
> 'dma-coherent'?
> 

The performance benefit can be measured by saturating the link. But it is
obvious that snooping the cache will give better performance (plus it avoids
cache flush in kernel).

- Mani

-- 
மணிவண்ணன் சதாசிவம்
