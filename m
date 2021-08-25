Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB323F7DB7
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 23:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhHYV0j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 17:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229923AbhHYV0h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Aug 2021 17:26:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79419610A1;
        Wed, 25 Aug 2021 21:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629926750;
        bh=xQDrtgT6uthmEGov/Ldo+EaOEsSjtEqV6roEUR4U2co=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fASCj+Go18/tQH72Frrh86vQVUhFBKTCcQ9o3Ad3urEcD8hJY/IVjmN/1OlNCuXM4
         7JHmj+5rcXAer/IJ5s5nNiWQN44+Wzp2sr83a87R1CCPRsMKBGBQIH+6UKRHirnyas
         wPVtWIKNENPU02jJD6GFFXh1J0YuLxlengl+em2Gt5AdRTxcLXm3lq/u+SnHoFANyy
         GAemNjEbynsA+w9EusA1aYNMqsnfKT/CgqIfBhQLMN3yeqoGmDtCXqtkzI8KNCv7iO
         +a/vZ9eADe/hwGSLkGP6I/AoRwgMGYHBduxWGD42U57kaBGxpBic1W/I8SmgF28hOe
         Vrciu66nkn5+g==
Date:   Wed, 25 Aug 2021 16:25:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Prasad Malisetty <pmaliset@codeaurora.org>, agross@kernel.org,
        bhelgaas@google.com, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        svarbanov@mm-sol.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        mka@chromium.org, vbadigan@codeaurora.org, sallenki@codeaurora.org,
        manivannan.sadhasivam@linaro.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 4/4] PCI: qcom: Switch pcie_1_pipe_clk_src after PHY
 init in SC7280
Message-ID: <20210825212549.GA3609092@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n50cnWf_3LQ6P9KMaT4dnryWW9JemP95JDZt5WE1G4mZuQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci; patches to drivers/pci/ should always be cc'd there]

On Wed, Aug 25, 2021 at 07:30:09PM +0000, Stephen Boyd wrote:
> Quoting Prasad Malisetty (2021-08-24 01:10:48)
> > On 2021-08-17 22:56, Prasad Malisetty wrote:
> > > On 2021-08-10 09:38, Prasad Malisetty wrote:
> > >> On the SC7280, By default the clock source for pcie_1_pipe is
> > >> TCXO for gdsc enable. But after the PHY is initialized, the clock
> > >> source must be switched to gcc_pcie_1_pipe_clk from TCXO.
> > >>
> > >> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> > >> ---
> > >>  drivers/pci/controller/dwc/pcie-qcom.c | 18 ++++++++++++++++++
> > >>  1 file changed, 18 insertions(+)
> > >>
> > >> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
> > >> b/drivers/pci/controller/dwc/pcie-qcom.c
> > >> index 8a7a300..39e3b21 100644
> > >> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > >> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > >> @@ -166,6 +166,8 @@ struct qcom_pcie_resources_2_7_0 {
> > >>      struct regulator_bulk_data supplies[2];
> > >>      struct reset_control *pci_reset;
> > >>      struct clk *pipe_clk;
> > >> +    struct clk *gcc_pcie_1_pipe_clk_src;
> > >> +    struct clk *phy_pipe_clk;
> > >>  };
> > >>
> > >>  union qcom_pcie_resources {
> > >> @@ -1167,6 +1169,16 @@ static int qcom_pcie_get_resources_2_7_0(struct
> > >> qcom_pcie *pcie)
> > >>      if (ret < 0)
> > >>              return ret;
> > >>
> > >> +    if (of_device_is_compatible(dev->of_node, "qcom,pcie-sc7280")) {
> > >> +            res->gcc_pcie_1_pipe_clk_src = devm_clk_get(dev, "pipe_mux");
> > >> +            if (IS_ERR(res->gcc_pcie_1_pipe_clk_src))
> > >> +                    return PTR_ERR(res->gcc_pcie_1_pipe_clk_src);
> > >> +
> > >> +            res->phy_pipe_clk = devm_clk_get(dev, "phy_pipe");
> > >> +            if (IS_ERR(res->phy_pipe_clk))
> > >> +                    return PTR_ERR(res->phy_pipe_clk);
> > >> +    }
> > >
> > > I would like to check is there any other better approach instead of
> > > compatible method here as well or is it fine to use compatible method.
> 
> I'd prefer the compatible method. If nobody is responding then it's best
> to just resend the patches with the approach you prefer instead of
> waiting for someone to respond to a review comment.

I'm missing some context here, so I'm not exactly sure what your
question is, Prasad, but IMO drivers generally should not need to use
of_device_is_compatible() if they've already called
of_device_get_match_data() (as qcom_pcie_probe() has).

of_device_is_compatible() does basically the same work of looking for
a match in qcom_pcie_match[] that of_device_get_match_data() does, so
it seems pointless to repeat it.

I am a little confused because while [1] adds "qcom,pcie-sc7280" to
qcom,pcie.txt, I don't see a patch that adds it to qcom_pcie_match[].

Bjorn

[1] https://lore.kernel.org/linux-arm-msm/1628568516-24155-2-git-send-email-pmaliset@codeaurora.org/
