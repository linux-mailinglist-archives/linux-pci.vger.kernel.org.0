Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE45543CB6
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 21:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiFHTWi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 15:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiFHTWh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 15:22:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C1A1CC63B;
        Wed,  8 Jun 2022 12:22:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D76560DE5;
        Wed,  8 Jun 2022 19:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465A6C34116;
        Wed,  8 Jun 2022 19:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654716155;
        bh=4CmWMYqOhTd+CsyQ4Y8Zr9PLebkFUDAuZbRHMC9MkHU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=I1PYeb4amnKmH0h82VzOMxZtMAYjP88ThDHIWxDbGEOQF7rJvIOwZXvzeTuwktEWR
         P49u7qo+j1Jr8n2fp0bcL5KDA7aOSA0NLj5TvRguAFGErYn5lWtFXyFLyWsPqqs/LO
         SevdOHRDtXcGmR/UyN1ZWPW/wB8tWs4STslqkQrhbPSPuumaDhrhjwrdUrKmQnxgHx
         E5j7WKDMuP26UZafg8K64DvhqvjxIhs54lIk6Kz87tr/MfjB8/xGbqoeuREY9kRWDz
         ZQszORF4NgBjOUuPKr8/5Q//ojt4LZODJnprCOVl93W/xavH1kXNaWQUR/XhyKwhWq
         yan5+6nsmb0ZQ==
Date:   Wed, 8 Jun 2022 14:22:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v11 1/5] clk: qcom: regmap: add PHY clock source
 implementation
Message-ID: <20220608192233.GA413725@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608105238.2973600-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 08, 2022 at 01:52:34PM +0300, Dmitry Baryshkov wrote:
> On recent Qualcomm platforms the QMP PIPE clocks feed into a set of
> muxes which must be parked to the "safe" source (bi_tcxo) when
> corresponding GDSC is turned off and on again. Currently this is
> handcoded in the PCIe driver by reparenting the gcc_pipe_N_clk_src
> clock. However the same code sequence should be applied in the
> pcie-qcom endpoint, USB3 and UFS drivers.
> 
> Rather than copying this sequence over and over again, follow the
> example of clk_rcg2_shared_ops and implement this parking in the
> enable() and disable() clock operations. Supplement the regmap-mux with
> the new clk_regmap_phy_mux type, which implements such multiplexers
> as a simple gate clocks.
> 
> This is possible since each of these multiplexers has just two clock
> sources: one coming from the PHY and a reference (XO) one.  If the clock
> is running off the from-PHY source, report it as enabled. Report it as
> disabled otherwise (if it uses reference source).
> 
> This way the PHY will disable the pipe clock before turning off the
> GDSC, which in turn would lead to disabling corresponding pipe_clk_src
> (and thus it being parked to a safe, reference clock source). And vice
> versa, after enabling the GDSC the PHY will enable the pipe clock, which
> would cause pipe_clk_src to be switched from a safe source to the
> working one.
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/clk/qcom/Makefile             |  1 +
>  drivers/clk/qcom/clk-regmap-phy-mux.c | 62 +++++++++++++++++++++++++++
>  drivers/clk/qcom/clk-regmap-phy-mux.h | 33 ++++++++++++++
>  3 files changed, 96 insertions(+)
>  create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.c
>  create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.h

Since it's posted as part of the series, I assume this should all be
applied together, so I'll look for an ack from Bjorn Andersson
<bjorn.andersson@linaro.org>, maintainer of drivers/clk/qcom.
