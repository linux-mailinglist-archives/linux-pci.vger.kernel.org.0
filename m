Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3A951D84B
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 14:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345276AbiEFM7O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 08:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392205AbiEFM6y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 08:58:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396BD5AA72;
        Fri,  6 May 2022 05:54:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE3CEB8346C;
        Fri,  6 May 2022 12:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A04C385A8;
        Fri,  6 May 2022 12:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651841686;
        bh=+a3APGSS8WYaeUTzQfwQZYU1NaWH6L8/oy1A1dr2n5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y8xr5UDJMQPG+Ti/pgBpv24Q2L/v8rLZHCldSRDsSL55g/CbNIPGrckDR9jLH1+MX
         B+TsZMgKubfTNMa4JYmxCdIRFHwKVgZqULGNEP/NQKJOP9jBQHDmyazmDptf14tP0R
         Qc+v9jK3JKZO7vGsjcxhU2NBKx94WU1UK7HvDp0efFtSAj1fOlL1QR1S1aOM+kWhVm
         a2wF7+irZLYUB5opPswtKoxoPXL/dbmGDCKcRakncApSdUOcki0kiWIyMMx3iCrayW
         CI7i7zmg+SeYWdCB21gw25YlnxXdK4z/G+xHdt1ZzfrWLrwczzSo56FGkrh+82+fws
         SzhoURR+EAeIw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nmxTq-0007Xb-Gq; Fri, 06 May 2022 14:54:47 +0200
Date:   Fri, 6 May 2022 14:54:46 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/5] clk: qcom: regmap: add pipe clk implementation
Message-ID: <YnUals1FAssF2zxO@hovoldconsulting.com>
References: <20220501192149.4128158-1-dmitry.baryshkov@linaro.org>
 <20220501192149.4128158-3-dmitry.baryshkov@linaro.org>
 <20220502101053.GF5053@thinkpad>
 <c47616bf-a0c3-3ad5-c3e2-ba2ae33110d0@linaro.org>
 <20220502111004.GH5053@thinkpad>
 <29819e6d-9aa1-aca9-0ff6-b81098077f28@linaro.org>
 <20220502150611.GF98313@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502150611.GF98313@thinkpad>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 02, 2022 at 08:36:11PM +0530, Manivannan Sadhasivam wrote:

> If I get the logic behind this "parking" thing right, then it is required
> for producing a stable pipe_clk from GCC when the PHY is about to initialize.
> Also to make sure that there is no glitch observed on pipe_clk while
> initializing the PHY. And once it is powered ON properly, the pipe_clksrc
> should be used as the parent for pipe_clk.

No, the "parking" is only needed when toggling the corresponding GDSC
which needs a ticking source for some handshake or else it hangs.

The PHY PLL could be muxed in whenever the GDSC power domain is enabled.

That's the thing I don't like about tying the muxing to gating the pipe
clock in the PHY driver. It just happens to work as long as we remember
to gate before disabling the power domain (for a separate device, the
PCIe controller).

But that doesn't solve the case were the boot firmware has left things
in a weird state.

Johan
