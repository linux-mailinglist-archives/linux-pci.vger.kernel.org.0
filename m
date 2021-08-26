Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E353F87AB
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 14:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242179AbhHZMiv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 08:38:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241261AbhHZMiu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Aug 2021 08:38:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45AB7610C8;
        Thu, 26 Aug 2021 12:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629981483;
        bh=oYW580H2r0Vk0cbC8cBai0zFZz3y1uoZPGESg1qexXU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f0HZaSS4gtmS+SL34ztpsapPiRtEUGKYJWcRETMfuNr3cIG1p7DW3QaXCLGId7yHd
         VCko2KGBxLk35kGtU4GYr76WUOBaH9xAF13YuP0YP/07m2YdiPncHssgftkP8jZVWX
         aQF637zpXaqpRuqfM3+RR6hfDlAX2Ykqy+6kK4clPbOIiwxXKM0LDHj6LoDlDjqPAH
         TjeTHVnwhhMYjkB5lNWiHnbaJRSb+ljSAhQlLKsnxwmMwUX9YmZwrtkWUEY1gctJEv
         QLbEx8Sp+qk/SCNRdoPkZKILlg4XNC7H6tdp0pzfLdCmQExm6NWRzYLk7utjzAaFg+
         CoSIWmfhVSC4g==
Received: by mail-ej1-f44.google.com with SMTP id ia27so5919378ejc.10;
        Thu, 26 Aug 2021 05:38:03 -0700 (PDT)
X-Gm-Message-State: AOAM532WtF1M7Kj4MkwX6t+QaoGKTUjQLolB6Q2k/rtQYV33BW+ds1Hl
        jbicPnpbymbCZ2BQDaDIHvc5g/rUQhfrRKa3/A==
X-Google-Smtp-Source: ABdhPJzPmphkjNnES72zf5E0Tys8QPVr6+4jD+sFXoKYqUfYojDMBajfSo+1uGlz0Bet8TS24XzxfR5NSH1HPcQKtQI=
X-Received: by 2002:a17:906:25db:: with SMTP id n27mr3993295ejb.108.1629981481805;
 Thu, 26 Aug 2021 05:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210825212549.GA3609092@bjorn-Precision-5520> <1795efc94a7b87fb4d9f769e03ce21c6@codeaurora.org>
In-Reply-To: <1795efc94a7b87fb4d9f769e03ce21c6@codeaurora.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 26 Aug 2021 07:37:48 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+4RZejPcgX3J5JDGnHB6Lgx54BVgwfaZrNuY759wm9ig@mail.gmail.com>
Message-ID: <CAL_Jsq+4RZejPcgX3J5JDGnHB6Lgx54BVgwfaZrNuY759wm9ig@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] PCI: qcom: Switch pcie_1_pipe_clk_src after PHY
 init in SC7280
To:     Prasad Malisetty <pmaliset@codeaurora.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        bhelgaas@google.com, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, svarbanov@mm-sol.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org, vbadigan@codeaurora.org,
        sallenki@codeaurora.org, manivannan.sadhasivam@linaro.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 26, 2021 at 2:22 AM Prasad Malisetty
<pmaliset@codeaurora.org> wrote:
>
> On 2021-08-26 02:55, Bjorn Helgaas wrote:
> > [+cc linux-pci; patches to drivers/pci/ should always be cc'd there]
> >
> > On Wed, Aug 25, 2021 at 07:30:09PM +0000, Stephen Boyd wrote:
> >> Quoting Prasad Malisetty (2021-08-24 01:10:48)
> >> > On 2021-08-17 22:56, Prasad Malisetty wrote:
> >> > > On 2021-08-10 09:38, Prasad Malisetty wrote:
> >> > >> On the SC7280, By default the clock source for pcie_1_pipe is
> >> > >> TCXO for gdsc enable. But after the PHY is initialized, the clock
> >> > >> source must be switched to gcc_pcie_1_pipe_clk from TCXO.
> >> > >>
> >> > >> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> >> > >> ---
> >> > >>  drivers/pci/controller/dwc/pcie-qcom.c | 18 ++++++++++++++++++
> >> > >>  1 file changed, 18 insertions(+)
> >> > >>
> >> > >> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
> >> > >> b/drivers/pci/controller/dwc/pcie-qcom.c
> >> > >> index 8a7a300..39e3b21 100644
> >> > >> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> >> > >> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> >> > >> @@ -166,6 +166,8 @@ struct qcom_pcie_resources_2_7_0 {
> >> > >>      struct regulator_bulk_data supplies[2];
> >> > >>      struct reset_control *pci_reset;
> >> > >>      struct clk *pipe_clk;
> >> > >> +    struct clk *gcc_pcie_1_pipe_clk_src;
> >> > >> +    struct clk *phy_pipe_clk;
> >> > >>  };
> >> > >>
> >> > >>  union qcom_pcie_resources {
> >> > >> @@ -1167,6 +1169,16 @@ static int qcom_pcie_get_resources_2_7_0(struct
> >> > >> qcom_pcie *pcie)
> >> > >>      if (ret < 0)
> >> > >>              return ret;
> >> > >>
> >> > >> +    if (of_device_is_compatible(dev->of_node, "qcom,pcie-sc7280")) {
> >> > >> +            res->gcc_pcie_1_pipe_clk_src = devm_clk_get(dev, "pipe_mux");
> >> > >> +            if (IS_ERR(res->gcc_pcie_1_pipe_clk_src))
> >> > >> +                    return PTR_ERR(res->gcc_pcie_1_pipe_clk_src);
> >> > >> +
> >> > >> +            res->phy_pipe_clk = devm_clk_get(dev, "phy_pipe");
> >> > >> +            if (IS_ERR(res->phy_pipe_clk))
> >> > >> +                    return PTR_ERR(res->phy_pipe_clk);
> >> > >> +    }
> >> > >
> >> > > I would like to check is there any other better approach instead of
> >> > > compatible method here as well or is it fine to use compatible method.
> >>
> >> I'd prefer the compatible method. If nobody is responding then it's
> >> best
> >> to just resend the patches with the approach you prefer instead of
> >> waiting for someone to respond to a review comment.
> >
> > I'm missing some context here, so I'm not exactly sure what your
> > question is, Prasad, but IMO drivers generally should not need to use
> > of_device_is_compatible() if they've already called
> > of_device_get_match_data() (as qcom_pcie_probe() has).
> >
> > of_device_is_compatible() does basically the same work of looking for
> > a match in qcom_pcie_match[] that of_device_get_match_data() does, so
> > it seems pointless to repeat it.

+1

> > I am a little confused because while [1] adds "qcom,pcie-sc7280" to
> > qcom,pcie.txt, I don't see a patch that adds it to qcom_pcie_match[].

Either that's missing or there's a fallback to 8250 that's not documented.
> >
> > Bjorn
> >
> Hi Bjorn,
>
> I agree on your point, but the main reason is to use compatible in
> get_resources_2_7_0 is same hardware version. For SM8250 & SC7280
> platforms, the hw version is same. Since we can't have a separate ops
> for SC7280, we are using compatible method in get_resources_2_7_0 to
> differentiate SM8250 and SC7280.

Then fix the match data to be not just ops, but ops and the flag you need here.

Rob
