Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5AD53C727
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 10:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbiFCIuQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jun 2022 04:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242633AbiFCIuO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2022 04:50:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3815636E37;
        Fri,  3 Jun 2022 01:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C835D61968;
        Fri,  3 Jun 2022 08:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391C9C385A9;
        Fri,  3 Jun 2022 08:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654246213;
        bh=FgmVJXhalC335VPUtSI7MAoBJqF9Pa8+zowjA83DZt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X/bZbae2zg3L7mDbQEGb8RkHJW9ScfK8VFXdCqLVfwYtjSBMPSnckF1fSTCgiHHR2
         uS5gfgvWpEND3zuxivjnW6PLkGTsWdGNDa0Ty6UmfTeLDPT6tUc9fq8m3iCL8nEtbC
         mW0M4myj8r3a759zGxDklDEsniQhgVNMveOps3pnSsvrKxJ30HppfxngGNukglbnwk
         OWHzTF38z/Jk17yV9dfP3Gp/6HPrbq9xZB+3eUNfDmAvCcVlDMtJTSi/Lqdk8LHM5B
         v5jMTI/J55LFz7m2sVn5IaSp9oN3uYZqa8JUphxRUnl7sWZdaWILtL79lPauITEbTr
         ZJ8L1CIBFYREw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nx30T-0007UH-QC; Fri, 03 Jun 2022 10:50:09 +0200
Date:   Fri, 3 Jun 2022 10:50:09 +0200
From:   Johan Hovold <johan@kernel.org>
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
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 2/5] clk: qcom: gcc-sm8450: use new
 clk_regmap_phy_mux_ops for PCIe pipe clocks
Message-ID: <YpnLQS5lvMbxpUVj@hovoldconsulting.com>
References: <20220603075908.1853011-1-dmitry.baryshkov@linaro.org>
 <20220603075908.1853011-3-dmitry.baryshkov@linaro.org>
 <YpnDkbuZO3jCbxdF@hovoldconsulting.com>
 <bec5ec2a-b749-21ba-e406-fb5799a3df57@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bec5ec2a-b749-21ba-e406-fb5799a3df57@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 03, 2022 at 11:42:47AM +0300, Dmitry Baryshkov wrote:
> On 03/06/2022 11:17, Johan Hovold wrote:
> > On Fri, Jun 03, 2022 at 10:59:05AM +0300, Dmitry Baryshkov wrote:
> >> Use newly defined clk_regmap_phy_mux_ops for PCIe pipe clocks to let
> >> the clock framework automatically park the clock when the clock is
> >> switched off and restore the parent when the clock is switched on.
> >>
> >> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> >> Tested-by: Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> > 
> > The Tested-by tags you added are malformed throughout the series, please
> > review and respin (there should be two separate tags for R and T).
> 
> Hmm, I wonder how did that happen. Probably they came from your message 
> and I didn't notice that they were broken.

You're right, I messed up when I replied to the v7 cover letter. Sorry
about that and thanks for fixing it up.

Johan
