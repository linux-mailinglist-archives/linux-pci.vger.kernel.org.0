Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1F252F03D
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 18:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346226AbiETQLl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 12:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351448AbiETQLi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 12:11:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF872A70E;
        Fri, 20 May 2022 09:11:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 131CEB82C88;
        Fri, 20 May 2022 16:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B485FC385A9;
        Fri, 20 May 2022 16:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653063093;
        bh=fblot6AhylMdn+eEOLcKutSN0gFTdfCHC8K7Xs1d7kA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BIn4mFWP7cfAbrb7gQ8DtKLdLDfZPTY3tB6Dofe6ZU5ZdOrr74kzKA81Y9EUDxRIi
         IBt4YILvhH5M2WZnZI4NA9K922g7x6WXM2pu7yRBYCVT9lj37d+Ewc2PTk8GD4X8JO
         HpT124tWHIVksFL7tIm2/Pq5vN+Ax5DdyksWGF526CSmJwwDduIX09YsKgerIFagQJ
         5xihuqCaDDksyo/XEgpQaWCuFkyRH4klNaLsPnDgxQxmTZlWNBDR1/HEO+4e0UsRlL
         PA+EOgsuf+Ki4NAfHZW/P6iKBVzWm8BXOQaM+KqYo9k/dXg3ZUeiZ7apKSpHuemaPx
         gcmeNxJwEjbwQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ns5Dx-00089R-VV; Fri, 20 May 2022 18:11:34 +0200
Date:   Fri, 20 May 2022 18:11:33 +0200
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
Subject: Re: [PATCH v7 5/6] Revert "clk: qcom: regmap-mux: add pipe clk
 implementation"
Message-ID: <Yoe9tfpWtUCGZCif@hovoldconsulting.com>
References: <20220520015844.1190511-1-dmitry.baryshkov@linaro.org>
 <20220520015844.1190511-6-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520015844.1190511-6-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 20, 2022 at 04:58:43AM +0300, Dmitry Baryshkov wrote:
> Johan Hovold has pointed out that there are several deficiencies and a
> race condition in the regmap_mux_safe ops that were merged. Pipe clocks
> has been updated to use newer and simpler clk_regmap_phy_mux_ops. Drop
> the regmap-mux-safe clock ops now.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
