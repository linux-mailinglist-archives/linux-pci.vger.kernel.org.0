Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815917DF7D2
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 17:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347656AbjKBQgm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 12:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKBQgl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 12:36:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C05128;
        Thu,  2 Nov 2023 09:36:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B50C433C8;
        Thu,  2 Nov 2023 16:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698942998;
        bh=4aX/P2w1iOqWTOFnUksWlwkGyZTIYrlt8CsHwkusO/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EE7nTGgCPIXHw/5aUh8ORBP2cfTlaGM+HZJlAQyJx8MyCnFDuVl3kzfrWNKjge106
         /ohYegpgbe/d+OilcU+jZCFuMwY6Z3yu0hIrd3C5AR1rKdLuJG3r9jodZqvE5Sdz/1
         bjQxg3V0W1IgIPnHQpzD8+3omh1dp3rL9MQaxCgcM6mNtGOUlALnlpk4zOVQDEgAma
         JBJnpJ8ND2GahKVR4U+qtKXfRHmU5DiOQ1eNwlBQeOeaE6lBwIu4F1kFQLWzmMMR6q
         hcMQfkLdynSYRl57NTr3+1qHnVyOkNf3Ix6os2Z6tWH599kfzwOC1oXCvb8eJYWtjh
         fwWy5G49fVZ2Q==
Date:   Thu, 2 Nov 2023 22:06:19 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Mrinmay Sarkar <quic_msarkar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org, mani@kernel.org,
        robh+dt@kernel.org, quic_shazhuss@quicinc.com,
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
Message-ID: <20231102163619.GA20943@thinkpad>
References: <1698767186-5046-1-git-send-email-quic_msarkar@quicinc.com>
 <1698767186-5046-2-git-send-email-quic_msarkar@quicinc.com>
 <CAA8EJpoMoUvF8R3PjgCNijS6-8Gs5FjvC6dYerNBVBuYW3FmPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJpoMoUvF8R3PjgCNijS6-8Gs5FjvC6dYerNBVBuYW3FmPA@mail.gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 02, 2023 at 05:34:24PM +0200, Dmitry Baryshkov wrote:
> On Tue, 31 Oct 2023 at 17:46, Mrinmay Sarkar <quic_msarkar@quicinc.com> wrote:
> >
> > This change will enable cache snooping logic to support
> > cache coherency for SA8755P RC platform.
> >
> > Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 6902e97..6f240fc 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -51,6 +51,7 @@
> >  #define PARF_SID_OFFSET                                0x234
> >  #define PARF_BDF_TRANSLATE_CFG                 0x24c
> >  #define PARF_SLV_ADDR_SPACE_SIZE               0x358
> > +#define PCIE_PARF_NO_SNOOP_OVERIDE             0x3d4
> >  #define PARF_DEVICE_TYPE                       0x1000
> >  #define PARF_BDF_TO_SID_TABLE_N                        0x2000
> >
> > @@ -117,6 +118,9 @@
> >  /* PARF_LTSSM register fields */
> >  #define LTSSM_EN                               BIT(8)
> >
> > +/* PARF_NO_SNOOP_OVERIDE register value */
> > +#define NO_SNOOP_OVERIDE_EN                    0xa
> > +
> >  /* PARF_DEVICE_TYPE register fields */
> >  #define DEVICE_TYPE_RC                         0x4
> >
> > @@ -961,6 +965,13 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> >
> >  static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
> >  {
> > +       struct dw_pcie *pci = pcie->pci;
> > +       struct device *dev = pci->dev;
> > +
> > +       /* Enable cache snooping for SA8775P */
> > +       if (of_device_is_compatible(dev->of_node, "qcom,pcie-sa8775p"))
> 
> Obviously: please populate a flag in the data structures instead of
> doing of_device_is_compatible(). Same applies to the patch 2.
> 

Not necessary at this point. For some unknown reasons, the HW team ended up
disabling cache snooping on this specific platform. Whereas on other platforms,
it is enabled by default. So I have low expectations that we would need this
setting on other platforms in the future.

My concern with the usage of flag is that it warrants a new "qcom_pcie_cfg"
instance just for this quirk and it looks overkill to me.

So if we endup seeing this behavior on other platforms as well (unlikely) then
we can switch to the flag approach.

- Mani

> > +               writel(NO_SNOOP_OVERIDE_EN, pcie->parf + PCIE_PARF_NO_SNOOP_OVERIDE);
> > +
> >         qcom_pcie_clear_hpc(pcie->pci);
> >
> >         return 0;
> 
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
மணிவண்ணன் சதாசிவம்
