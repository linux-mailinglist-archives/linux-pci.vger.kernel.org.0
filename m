Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC2F55C776
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 14:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238576AbiF0UCX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 16:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240763AbiF0UCW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 16:02:22 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297381C91F
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 13:02:21 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id u9so14272268oiv.12
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 13:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T56oUUt8XiQzKJdGpInekt21HLkZCardztmW7Fr7SY8=;
        b=enzhH8ylnXZnqZn8qU1nwHHBWAD7K83dzBK/hfIHMAwoE4MHxPq5tS0vD0ccGGswdH
         ZVk1jnkczTzZ2pRIovdD346R2mmjyyGgR1qgJXuaMzEWo86rZhlC2zwILCAlG5zamO8o
         xntmXCHU/AR86v7fewmuTrr2lhAE2IMqZ1W/SegSDhEIdjfZn9Hk9IIQpiCNiJFDBOzs
         sO1UfsXe0Riwo1gl7IaHvuMoZSHSr2ghD5UOSstjti21IbcaiYlGhxm+qRCLu30RJh2C
         CtfIMuKYEthpFy7y4nsQz7tGqXEab8VLBLAYFSTQjmXwZ0z7m9fKEvjRTBMPdlBJ+5BB
         2vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T56oUUt8XiQzKJdGpInekt21HLkZCardztmW7Fr7SY8=;
        b=Loo7Yo+/ksFHoEceWig7wmzcUhYJ1VsASm30zl5MyMsVUqoBQEHyMbGRsWrcKx/dgL
         5kVvU51FYHnVxjpZIL1AY1VakT0Mo/WnfvG1GAdRwk/MuEp+URORzA7uutQS/pXB4FgQ
         L+PfOo1X+fd4a4bmgmMT5A2xgInXNDP05RdGdjHILGT6rjDJIbzG39ZvX12bZHAKSXt4
         uY3RKswwao2mWakp8kvqXNO+ZrSvNUtLsgam60pVXU97cKGhCRUeDVaLaEcvGO00fqe0
         rI9dxTVVJ4r4RXE3u5ltMUlJIFvTO58IdTkG3fQmYdnmkDqvkJMcqldrUZTSNp2pggo7
         IYHw==
X-Gm-Message-State: AJIora9t7Sfo4iPn1EaThS/kgPp+lNhXlF7ZcpaqMFGpJSGY+a2TEKdt
        8Rtpc98uM7jyAsoLqnBHC8ycmQ==
X-Google-Smtp-Source: AGRyM1t0+uR3BNQUQfbyJxFrwbmPsg0l88G0mdym1nNPLRzzC75fwSl9M7l8eFL8olE1MRWoRRAbug==
X-Received: by 2002:a05:6808:1414:b0:335:7992:263a with SMTP id w20-20020a056808141400b003357992263amr2814017oiv.9.1656360140331;
        Mon, 27 Jun 2022 13:02:20 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c10-20020a4ad78a000000b004256a36a217sm6322108oou.34.2022.06.27.13.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:02:19 -0700 (PDT)
Date:   Mon, 27 Jun 2022 15:02:17 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v11 1/5] clk: qcom: regmap: add PHY clock source
 implementation
Message-ID: <YroMyWNO8ZLk1bTe@builder.lan>
References: <20220608105238.2973600-2-dmitry.baryshkov@linaro.org>
 <20220608192233.GA413725@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608192233.GA413725@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed 08 Jun 14:22 CDT 2022, Bjorn Helgaas wrote:

> On Wed, Jun 08, 2022 at 01:52:34PM +0300, Dmitry Baryshkov wrote:
> > On recent Qualcomm platforms the QMP PIPE clocks feed into a set of
> > muxes which must be parked to the "safe" source (bi_tcxo) when
> > corresponding GDSC is turned off and on again. Currently this is
> > handcoded in the PCIe driver by reparenting the gcc_pipe_N_clk_src
> > clock. However the same code sequence should be applied in the
> > pcie-qcom endpoint, USB3 and UFS drivers.
> > 
> > Rather than copying this sequence over and over again, follow the
> > example of clk_rcg2_shared_ops and implement this parking in the
> > enable() and disable() clock operations. Supplement the regmap-mux with
> > the new clk_regmap_phy_mux type, which implements such multiplexers
> > as a simple gate clocks.
> > 
> > This is possible since each of these multiplexers has just two clock
> > sources: one coming from the PHY and a reference (XO) one.  If the clock
> > is running off the from-PHY source, report it as enabled. Report it as
> > disabled otherwise (if it uses reference source).
> > 
> > This way the PHY will disable the pipe clock before turning off the
> > GDSC, which in turn would lead to disabling corresponding pipe_clk_src
> > (and thus it being parked to a safe, reference clock source). And vice
> > versa, after enabling the GDSC the PHY will enable the pipe clock, which
> > would cause pipe_clk_src to be switched from a safe source to the
> > working one.
> > 
> > Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> > Tested-by: Johan Hovold <johan+linaro@kernel.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/clk/qcom/Makefile             |  1 +
> >  drivers/clk/qcom/clk-regmap-phy-mux.c | 62 +++++++++++++++++++++++++++
> >  drivers/clk/qcom/clk-regmap-phy-mux.h | 33 ++++++++++++++
> >  3 files changed, 96 insertions(+)
> >  create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.c
> >  create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.h
> 
> Since it's posted as part of the series, I assume this should all be
> applied together, so I'll look for an ack from Bjorn Andersson
> <bjorn.andersson@linaro.org>, maintainer of drivers/clk/qcom.

Hi Bjorn,

Picking the clock patch through the clock tree would allow us to fix up
additional platforms (analog to patch 2 & 3) in time for v5.20 and
reduces risk for merge conflicts.

So please find an immutable branch (tag) of the clock patches here:
https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
tags/20220608105238.2973600-1-dmitry.baryshkov@linaro.org

Hope this suits you.

Regards,
Bjorn
