Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAD84FF348
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 11:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiDMJWz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 05:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiDMJWy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 05:22:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960A62B19E;
        Wed, 13 Apr 2022 02:20:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 308F361B60;
        Wed, 13 Apr 2022 09:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D55C385A4;
        Wed, 13 Apr 2022 09:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649841633;
        bh=1PoK9KprQ2GxAfUSolyz5kPTMvtxfF+a54uVEf66VQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l/a3UmxBHEg5dah7MADpl+KYLLovMCq1Vl3x5ExNOJKPN+WKXdl87EB3aLgLtTaJS
         IIc5JoPhpbO4gqxYE4j1nGnD8Jlk6Df00G22K+oVihHZn0SzW1LiBBAXh32lLqesm5
         WjqyzXImWoReq+mVlViZtIdTlKqnnvWjF91pUwqE8ypFtwk2OHwImMglaYXzJIngtc
         LqhDIF1wZOUzKfaR3WV/5zD/SSEg7YKVMsSwIBEeRfMXyAaQ7ygD7dQd48iGd3cqVc
         VsomuLyXZ4Q2vtN5tUqZ3avuRXo+Mqn2JPDbkHutFGx1SmNEe/dMR+JUTKAwkp7tF1
         v7/3PxsguytkA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1neZAp-0005R4-TW; Wed, 13 Apr 2022 11:20:27 +0200
Date:   Wed, 13 Apr 2022 11:20:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/5] PCI: qcom: rework pipe_clk/pipe_clk_src handling
Message-ID: <YlaV2/AQJaQhytR8@hovoldconsulting.com>
References: <20220412193839.2545814-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412193839.2545814-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[ Dropping tdas@codeaurora.org, which bounces. ]

On Tue, Apr 12, 2022 at 10:38:34PM +0300, Dmitry Baryshkov wrote:
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

Looks like you forgot to add the link to the prerequisite patch:

	[1] https://lore.kernel.org/all/20220401133351.10113-1-johan+linaro@kernel.org/

> Changes since v1:
>  - Rebased on top of [1].
>  - Removed erroneous Fixes tag from the patch 4.
> 
> Changes since RFC:
>  - Rework clk-regmap-mux fields. Specify safe parent as P_* value rather
>    than specifying the register value directly
>  - Expand commit message to the first patch to specially mention that
>    it is required only on newer generations of Qualcomm chipsets.

Johan
