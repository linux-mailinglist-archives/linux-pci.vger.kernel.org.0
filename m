Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D4D54E944
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 20:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245545AbiFPSZf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jun 2022 14:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236866AbiFPSZe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2022 14:25:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E5E50B2B;
        Thu, 16 Jun 2022 11:25:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C043B61B9C;
        Thu, 16 Jun 2022 18:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7496BC3411F;
        Thu, 16 Jun 2022 18:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655403933;
        bh=Clcc2jldUDLAKGs+98QZADd84E7uKFlA4U+ZTEzEgf8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jkKhCfaSel6dI5ZrOH4cCeyxKtiWCZv82vm3j7DpDhfK3fuaOKJTdNjcB2ulTJq5v
         jD07FZDW19dppp8uM93YnEikXUq+tP0qxTVpZCDni6xGIvBN2JxKX3afqVrR+xJjam
         vB1wqEvd9aJDo7V0TWO6aWLlo2BC3bJLargYz7e5XUm9jB+lQbBMiNUkf51Pf+nNbL
         QCIRNZb5o6zRhKIAN5o7fOcXsaXbLOtDS/xshIUwVdubqFIGPQuV2rH+gLP6IKoDiA
         2RVTKuUdXyFP6RFW7WhpwXPywGjhLZ1o0oUxWDRug3/wXjLtBCgqoqsNZIgvu5XCpt
         rt/ntqM25FWZQ==
Date:   Thu, 16 Jun 2022 13:25:30 -0500
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
Message-ID: <20220616182530.GA1100311@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608105238.2973600-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

FWIW, I dropped this Reported-by tag because I don't think it's really
relevant to this patch.  I think it's from this lkp report:

  https://lore.kernel.org/r/202206052344.Lkv2vI5x-lkp@intel.com

but that link wasn't included here and I don't think there's value in
including this detail about a minor build issue that was fixed before
the patch was ever applied anywhere.

Bjorn
