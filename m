Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877D452B38E
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 09:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbiERHhr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 03:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiERHhq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 03:37:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E090D4112;
        Wed, 18 May 2022 00:37:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC995B81EB6;
        Wed, 18 May 2022 07:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA94C385AA;
        Wed, 18 May 2022 07:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652859462;
        bh=Vs6qvP2kFYnYqFiyhRooHzLigUYt2Jmu+7ZoFH6JXco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hYXMgXtkeCIhdarh5NmucaM1eo1diPqHUK3xMGlaTHtVLE5BxPpr7dU+6Egyrrt4Q
         d6XZmEjG97nCdpr9nAObETGxW3PsH5D3haJjbGoeGNWA+zkLYFgPmo7o9T215xyVV+
         XlKW5AinVzct6LbT1+OK0MbMchMmYjpD3P1TOAAUhJz37bLTX9UILlPBKSQh6rIy0O
         vTUVYJ8r0WMA6j0Ufpq3IG12p/Rfi/8/XQqs7ovaByZg5t4rJ2339NRj8wg2tg6vH1
         axzpUHx9t4RytY94uUPqsJkIbbV/1GmxUfKIcWTI3Cv1NqbHbyfnEpplCG2pxY9iNB
         sICWkGvZs1Y9w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nrEFa-0004FL-R5; Wed, 18 May 2022 09:37:42 +0200
Date:   Wed, 18 May 2022 09:37:42 +0200
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
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 4/5] clk: qcom: gcc-sc7280: use new
 clk_regmap_pipe_src_ops for PCIe pipe clocks
Message-ID: <YoSiRgWBJU09NXKJ@hovoldconsulting.com>
References: <20220513175339.2981959-1-dmitry.baryshkov@linaro.org>
 <20220513175339.2981959-5-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513175339.2981959-5-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 13, 2022 at 08:53:38PM +0300, Dmitry Baryshkov wrote:
> Use newly defined clk_regmap_pipe_src_ops for PCIe pipe clocks to let

clk_regmap_phy_mux

> the clock framework automatically park the clock when the clock is
> switched off and restore the parent when the clock is switched on.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Looks good otherwise:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
