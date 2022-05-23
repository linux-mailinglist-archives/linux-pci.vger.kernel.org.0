Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D12E530B4F
	for <lists+linux-pci@lfdr.de>; Mon, 23 May 2022 11:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiEWIzE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 04:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiEWIy6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 04:54:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4C3DEE0;
        Mon, 23 May 2022 01:54:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41C9DB80FA6;
        Mon, 23 May 2022 08:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22ADC385AA;
        Mon, 23 May 2022 08:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653296093;
        bh=V04WMePLj2QW2a3wfchN9AcGZ5qHObdYKcyrhHylPuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jFpXQlzhCc5snOsJ9VHpKG1ulz457MS5qaXmd83zFh81oslSB3cL3Ve+qBhFjL1EA
         xjtZyHyWS4JfTXp1yY1+N2s5LZD7l4E9fzLNLpro8RNnr/rps0jNrrGnyvZtCAUpHc
         Z2BYNHBixNfkekh/mHgo/mJfDhdMG3dCskqsLwrFOYRPnAJnFBIv05FLgDT0Ip+8Fa
         vs2hbt4BkRCBB6YRyMawo+MwN1YNdZlOsyHUaMZDeFc0t36n38Nrumij+PZPNjiK+l
         mmIa0fx5TLWBALv7zfxTcP2L4Sq5bdlUNFQPOtb+9rUcVblTDs6r/g/6bBEQfgS4Wt
         dzlENDZQPL7aw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nt3py-0000g4-SC; Mon, 23 May 2022 10:54:50 +0200
Date:   Mon, 23 May 2022 10:54:50 +0200
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
Subject: Re: [PATCH v7 0/8] PCI: qcom: Rework pipe_clk/pipe_clk_src handling
Message-ID: <YotL2rqv8N9+jmpV@hovoldconsulting.com>
References: <20220521005343.1429642-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521005343.1429642-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 21, 2022 at 03:53:35AM +0300, Dmitry Baryshkov wrote:
> PCIe pipe clk (and some other clocks) must be parked to the "safe"
> source (bi_tcxo) when corresponding GDSC is turned off and on again.
> Currently this is handcoded in the PCIe driver by reparenting the
> gcc_pipe_N_clk_src clock.
> 
> Instead of doing it manually, follow the approach used by
> clk_rcg2_shared_ops and implement this parking in the enable() and
> disable() clock operations for respective pipe clocks.
> 
> Changes since v7:
>  - Brought back the struct clk_regmap_phy_mux (Johan)
>  - Fixed includes (Stephen)

So this is v8, but Subject still reads v7.

It looks like you also dropped the CLK_SET_RATE_PARENT flags in this
version.

For the series:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
