Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE2E525C71
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 09:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377845AbiEMHln (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 03:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377821AbiEMHlm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 03:41:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B33B5DE7B;
        Fri, 13 May 2022 00:41:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89B2461F3F;
        Fri, 13 May 2022 07:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5050C34100;
        Fri, 13 May 2022 07:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652427699;
        bh=sd/Fbf2vZEiz3YDcDvI0ib0X1MS6+7zAgIzqhhTYjC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UaFSRCoSGvA+oph8lshlMj2XwaxQpugmb7TSiRyniOHRz6bn9COBGYdaiPA7FoNUE
         B4iG3QIFD7NZkVwkDODNvzhrhuupXOK2a12gHx2B4MkFF5RMsGy87uCHGDc4HaV/eE
         DWkVBQRVX6BOps0dUChxMEu0qRQUG/eWdMgyPIbal2AByG1esMi/4TqEqrHfaeIj/1
         4UxXJ68lavpJjgDb+mQVIuOHeDseAnGWmweluMjFUNKa6psUP/VHp+XXVkG1KLyEmY
         CC2kOIMOBZYcS8GFjxedf58KDw579Sshzuu1iRNmDt6ndA1blK6IOePEZjhi2nwEpA
         HVCrdejW0G0WA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npPvc-0006wU-6j; Fri, 13 May 2022 09:41:36 +0200
Date:   Fri, 13 May 2022 09:41:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 0/5]  PCI: qcom: Rework pipe_clk/pipe_clk_src handling
Message-ID: <Yn4LsB/dkwjdslQs@hovoldconsulting.com>
References: <20220512172909.2436302-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512172909.2436302-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 12, 2022 at 08:29:04PM +0300, Dmitry Baryshkov wrote:
> PCIe pipe clk (and some other clocks) must be parked to the "safe"
> source (bi_tcxo) when corresponding GDSC is turned off and on again.
> Currently this is handcoded in the PCIe driver by reparenting the
> gcc_pipe_N_clk_src clock.
> 
> Instead of doing it manually, follow the approach used by
> clk_rcg2_shared_ops and implement this parking in the enable() and
> disable() clock operations for respective pipe clocks.
> 
> PCIe part depends on [1].

This one was merged a month ago.

> Changes since v4:
>  - Renamed the clock to clk-regmap-pipe-src,
>  - Added mention of PCIe2 PHY to the commit message,
>  - Expanded commit messages to mention additional pipe clock details.
> 
> Changes since v3:
>  - Replaced the clock multiplexer implementation with branch-like clock.
> 
> Changes since v2:
>  - Added is_enabled() callback
>  - Added default parent to the pipe clock configuration
> 
> Changes since v1:
>  - Rebased on top of [1].
>  - Removed erroneous Fixes tag from the patch 4.
> 
> Changes since RFC:
>  - Rework clk-regmap-mux fields. Specify safe parent as P_* value rather
>    than specifying the register value directly
>  - Expand commit message to the first patch to specially mention that
>    it is required only on newer generations of Qualcomm chipsets.
> 
> [1]: https://lore.kernel.org/all/20220401133351.10113-1-johan+linaro@kernel.org/

Johan
