Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA3A405C9A
	for <lists+linux-pci@lfdr.de>; Thu,  9 Sep 2021 20:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242942AbhIISJd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Sep 2021 14:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231431AbhIISJa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Sep 2021 14:09:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5804C610C9;
        Thu,  9 Sep 2021 18:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631210897;
        bh=rUgjo8lIkjG8VTsPFFj78gVWqfDjqFx80l5ivn3DkcU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fC933vyE/cBcM4YcmOg+DgH13xy31FrmuVVX3jvutEhRRXmQylLC+HDHkFxCH7XHw
         5h8YbLstZ39heKg7+wKr90HLgqQkkl5O250x3VsWMY3ijIrzPi3VWy+zaXamYODfnR
         SsItmcEZ+pMqc29dWZU2ET3FXmu3rFz1KY+2e7YpxPQqEcNoUXnE0O8ykO7MhplXh/
         tA1OYUykv8MWwiAqGzZfa8ZLp0hHRUdbdEIAcEE9HHWzXIN2m+N41jgSRlzqQOGBEz
         IsaOLE51CpdzB8Ku96fVHDZUqKJ+DPhiBYnpreSDx3opM9uqsNSj2F809nvNtb6e4r
         tdcZ2ZYlUd50Q==
Date:   Thu, 9 Sep 2021 13:08:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Prasad Malisetty <pmaliset@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        bhelgaas@google.com, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, svarbanov@mm-sol.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org, vbadigan@codeaurora.org,
        sallenki@codeaurora.org, manivannan.sadhasivam@linaro.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 4/4] PCI: qcom: Switch pcie_1_pipe_clk_src after PHY
 init in SC7280
Message-ID: <20210909180815.GA997402@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fae4f586edfde4f615a8ea6a309fbff@codeaurora.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 09, 2021 at 11:21:22PM +0530, Prasad Malisetty wrote:
> On 2021-08-31 21:07, Bjorn Helgaas wrote:
> > On Tue, Aug 31, 2021 at 12:07:30PM +0530, Prasad Malisetty wrote:
> > > On 2021-08-26 18:07, Rob Herring wrote:
> > > > On Thu, Aug 26, 2021 at 2:22 AM Prasad Malisetty
> > > > <pmaliset@codeaurora.org> wrote:
> > > > >
> > > > > On 2021-08-26 02:55, Bjorn Helgaas wrote:
> > > > > > [+cc linux-pci; patches to drivers/pci/ should always be cc'd there]
> > > > > >
> > > > > > On Wed, Aug 25, 2021 at 07:30:09PM +0000, Stephen Boyd wrote:
> > > > > >> Quoting Prasad Malisetty (2021-08-24 01:10:48)
> > > > > >> > On 2021-08-17 22:56, Prasad Malisetty wrote:
> > > > > >> > > On 2021-08-10 09:38, Prasad Malisetty wrote:
> > > > > >> > >> On the SC7280, By default the clock source for pcie_1_pipe is
> > > > > >> > >> TCXO for gdsc enable. But after the PHY is initialized, the clock
> > > > > >> > >> source must be switched to gcc_pcie_1_pipe_clk from TCXO.
> > > > > >> > >>
> > > > > >> > >> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> > > > > >> > >> ---
> > > > > >> > >>  drivers/pci/controller/dwc/pcie-qcom.c | 18 ++++++++++++++++++
> > > > > >> > >>  1 file changed, 18 insertions(+)
> > > > > >> > >>
> > > > > >> > >> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > >> > >> b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > >> > >> index 8a7a300..39e3b21 100644
> > > > > >> > >> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > >> > >> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > >> > >> @@ -166,6 +166,8 @@ struct qcom_pcie_resources_2_7_0 {
> > > > > >> > >>      struct regulator_bulk_data supplies[2];
> > > > > >> > >>      struct reset_control *pci_reset;
> > > > > >> > >>      struct clk *pipe_clk;
> > > > > >> > >> +    struct clk *gcc_pcie_1_pipe_clk_src;
> > > > > >> > >> +    struct clk *phy_pipe_clk;
> > > > > >> > >>  };
> > > > > >> > >>
> > > > > >> > >>  union qcom_pcie_resources {
> > > > > >> > >> @@ -1167,6 +1169,16 @@ static int qcom_pcie_get_resources_2_7_0(struct
> > > > > >> > >> qcom_pcie *pcie)
> > > > > >> > >>      if (ret < 0)
> > > > > >> > >>              return ret;
> > > > > >> > >>
> > > > > >> > >> +    if (of_device_is_compatible(dev->of_node, "qcom,pcie-sc7280")) {
> > > > > >> > >> +            res->gcc_pcie_1_pipe_clk_src = devm_clk_get(dev, "pipe_mux");
> > > > > >> > >> +            if (IS_ERR(res->gcc_pcie_1_pipe_clk_src))
> > > > > >> > >> +                    return PTR_ERR(res->gcc_pcie_1_pipe_clk_src);
> > > > > >> > >> +
> > > > > >> > >> +            res->phy_pipe_clk = devm_clk_get(dev, "phy_pipe");
> > > > > >> > >> +            if (IS_ERR(res->phy_pipe_clk))
> > > > > >> > >> +                    return PTR_ERR(res->phy_pipe_clk);
> > > > > >> > >> +    }
> > > > > >> > >
> > > > > >> > > I would like to check is there any other better
> > > > > >> > > approach instead of compatible method here as well or
> > > > > >> > > is it fine to use compatible method.
> > > > > >>
> > > > > >> I'd prefer the compatible method. If nobody is responding
> > > > > >> then it's best to just resend the patches with the
> > > > > >> approach you prefer instead of waiting for someone to
> > > > > >> respond to a review comment.
> > > > > >
> > > > > > I'm missing some context here, so I'm not exactly sure
> > > > > > what your question is, Prasad, but IMO drivers generally
> > > > > > should not need to use of_device_is_compatible() if
> > > > > > they've already called of_device_get_match_data() (as
> > > > > > qcom_pcie_probe() has).
> > > > > >
> > > > > > of_device_is_compatible() does basically the same work of
> > > > > > looking for a match in qcom_pcie_match[] that
> > > > > > of_device_get_match_data() does, so it seems pointless to
> > > > > > repeat it.
> > > >
> > > > +1
> > > >
> > > > > > I am a little confused because while [1] adds "qcom,pcie-sc7280" to
> > > > > > qcom,pcie.txt, I don't see a patch that adds it to qcom_pcie_match[].
> > > >
> > > > Either that's missing or there's a fallback to 8250 that's not
> > > > documented.
> > > >
> > > > > I agree on your point, but the main reason is to use compatible in
> > > > > get_resources_2_7_0 is same hardware version. For SM8250 & SC7280
> > > > > platforms, the hw version is same. Since we can't have a separate ops
> > > > > for SC7280, we are using compatible method in get_resources_2_7_0 to
> > > > > differentiate SM8250 and SC7280.
> > > >
> > > > Then fix the match data to be not just ops, but ops and the flag you
> > > > need here.
> > > 
> > > This difference is not universal across all the platforms but
> > > instead this is specific to SC7280.  Hence it make sense to use
> > > compatible other than going for a flag.
> > 
> > There's no reason your qcom_pcie_match[].data pointers need to be
> > strictly based on the hardware version.
> > 
> > You can do something like what pcie-brcmstb.c does, e.g.,
> > 
> >   struct pcie_cfg_data {
> >     struct qcom_pcie_ops *ops;
> >     unsigned int pipe_mux:1;
> >   };
> > 
> >   static const struct pcie_cfg_data sm8250_cfg = {
> >     .ops = &ops_1_9_0,
> >   };
> > 
> >   static const struct pcie_cfg_data sc7280_cfg = {
> >     .ops = &ops_1_9_0,
> >     .pipe_mux = 1,
> >   };
> > 
> >   static const struct of_device_id qcom_pcie_match[] = {
> >     { .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
> >     { .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
> >   };
> 
> I have one quick query, If we use above approach, we should change platform
> data reading in PCIe probe to differentiate remaining platforms right.
> expect SM8250 and SC7280 all other platforms are using same qcom_pcie_ops
> structure pointer as data.

Yes.  of_device_get_match_data() must return the same type of pointer
(in the example above, "struct pcie_cfg_data *") for all platforms.
So you would have to add a struct for each of them, and each struct
would contain the ops pointer (&ops_1_0_0, &ops_2_1_0, etc).

Thanks for working on this!

Bjorn
