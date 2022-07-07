Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBC456A91B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 19:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiGGRJS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 13:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbiGGRJS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 13:09:18 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3034131343
        for <linux-pci@vger.kernel.org>; Thu,  7 Jul 2022 10:09:16 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id ck6so23634225qtb.7
        for <linux-pci@vger.kernel.org>; Thu, 07 Jul 2022 10:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VneEvPWdF6mlYziIcZrj3EYP52YVpTU7ZsL0RJCPJFQ=;
        b=Uh4Tsuo2YRPF4FwgP4T/50FuolQJl1/GFqd3XzYKDzX365ndqpE3VJAxDAQfjydTV5
         WlPH+LLLZj1/9g6dONy2x6F9lWHxqRpIobhy7lkcDO/4thfb0F6bTGt50jdTNi0f3HNh
         Lv4G9qndF0evUiGTCFQJKfRuxZVM39Jz+nw/gboNfYHEWNt+qJsmQIxDMNJTiLKDcZrl
         Lmla2nFxqpwkDYCzA8ZG+3TdB1KSdRmpqhAm6MhTFR2I0clwqD4Z7hWXEB27S6ieebeY
         HTsOWW9xa+x+A/738t8cqYlpH0dFAo9vAcgKgyx8ustFqKQP7M/N8u9RR2BahEml2ZC2
         eVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VneEvPWdF6mlYziIcZrj3EYP52YVpTU7ZsL0RJCPJFQ=;
        b=zhqtJ9EhffcI11TD0t1CKzDCjbFkJNzc23ZHwGx9HJrnWMWX6zzvuSqjgcTKcT9xG/
         WFG5riH9n4+K2L9LGZk/JqkDL6yhy+5j4vMMU+MVq9Hp6OJpZ/nbQJEdViUgrPCzkJ77
         mmCVw2zvJ21WlVM3qLlrTqZKJ6VadI0siRiCMpDrZqtjNE6frOhcI8qajJwMDMZtrN95
         2sOOWb7aGpqf6ihrw6ODu1pV/9rmg8kpeTtkJW1+Uci3xCjPBBom7t08X97cPcUie6Wl
         +D6suCFzbeDYG0FFdgIpZP2kOAK+Rbr9mzuzl6IXHHJAeyqPUIQ/Fq3XujORnDk3JvhC
         ohww==
X-Gm-Message-State: AJIora+phujpU6Aq3m5ZUSbxugfUM7IIjQ51L9F7BRVrYKB79DQk/U33
        Iqq/2EiX3DV4K+iv1UMijM61tES7ST6ALcwFd+MEEw==
X-Google-Smtp-Source: AGRyM1uTqIRT81uZlraOmFAY1lNrExbidfEhf+iPZzJKCA6C2WfR0CI6/FXXG2Ugntc6W19Sd7VXAXFsjdZMkU/ayLE=
X-Received: by 2002:ac8:5c96:0:b0:31a:c19a:7da1 with SMTP id
 r22-20020ac85c96000000b0031ac19a7da1mr38887460qta.62.1657213755118; Thu, 07
 Jul 2022 10:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <e00b1317-9c2e-0b11-8c0b-1fa4a17e4761@linaro.org> <20220707154020.GA305104@bhelgaas>
In-Reply-To: <20220707154020.GA305104@bhelgaas>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 7 Jul 2022 20:09:03 +0300
Message-ID: <CAA8EJpqoB+iQCJGPK8DXaEFAyaHnfuZjQi6aepvWxYugqAZa8A@mail.gmail.com>
Subject: Re: [PATCH v11 0/5] PCI: qcom: Rework pipe_clk/pipe_clk_src handling
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 7 Jul 2022 at 18:40, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Jul 07, 2022 at 05:03:48PM +0300, Dmitry Baryshkov wrote:
> > On 16/06/2022 21:21, Bjorn Helgaas wrote:
> > > On Wed, Jun 08, 2022 at 01:52:33PM +0300, Dmitry Baryshkov wrote:
> > > > PCIe pipe clk (and some other clocks) must be parked to the "safe"
> > > > source (bi_tcxo) when corresponding GDSC is turned off and on again.
> > > > Currently this is handcoded in the PCIe driver by reparenting the
> > > > gcc_pipe_N_clk_src clock.
>
> > > > Dmitry Baryshkov (5):
> > > >    clk: qcom: regmap: add PHY clock source implementation
> > > >    clk: qcom: gcc-sm8450: use new clk_regmap_phy_mux_ops for PCIe pipe
> > > >      clocks
> > > >    clk: qcom: gcc-sc7280: use new clk_regmap_phy_mux_ops for PCIe pipe
> > > >      clocks
> > > >    PCI: qcom: Remove unnecessary pipe_clk handling
> > > >    PCI: qcom: Drop manual pipe_clk_src handling
> > > >
> > > >
> > > > Dmitry Baryshkov (5):
> > > >    clk: qcom: regmap: add PHY clock source implementation
> > > >    clk: qcom: gcc-sm8450: use new clk_regmap_phy_mux_ops for PCIe pipe
> > > >      clocks
> > > >    clk: qcom: gcc-sc7280: use new clk_regmap_phy_mux_ops for PCIe pipe
> > > >      clocks
> > > >    PCI: qcom: Remove unnecessary pipe_clk handling
> > > >    PCI: qcom: Drop manual pipe_clk_src handling
> > > >
> > > >   drivers/clk/qcom/Makefile              |  1 +
> > > >   drivers/clk/qcom/clk-regmap-phy-mux.c  | 62 ++++++++++++++++++++
> > > >   drivers/clk/qcom/clk-regmap-phy-mux.h  | 33 +++++++++++
> > > >   drivers/clk/qcom/gcc-sc7280.c          | 49 +++++-----------
> > > >   drivers/clk/qcom/gcc-sm8450.c          | 49 +++++-----------
> > > >   drivers/pci/controller/dwc/pcie-qcom.c | 81 +-------------------------
> > > >   6 files changed, 127 insertions(+), 148 deletions(-)
> > > >   create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.c
> > > >   create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.h
> > >
> > > I applied this to pci/ctrl/qcom for v5.20, thanks!
> > >
> > > Clock folks (Bjorn A, Andy, Michael, Stephen), I assume you're OK with
> > > these being merged via the PCI tree.  Let me know if you prefer
> > > anything different.
> >
> > I noticed that this patchset is not a part of linux-next. Is it still
> > pending to be merged in 5.20?
>
> It's still pending.  I currently have three separate qcom-related
> branches that need to be reconciled before I put them in -next.

Ok, thank you for the explanation. Please excuse my worries.

-- 
With best wishes
Dmitry
