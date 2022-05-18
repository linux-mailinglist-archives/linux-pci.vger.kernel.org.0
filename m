Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6230152B383
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 09:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiERHg3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 03:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiERHg2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 03:36:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167D86E8D4;
        Wed, 18 May 2022 00:36:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BEF5CB81EB3;
        Wed, 18 May 2022 07:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C75CC385AA;
        Wed, 18 May 2022 07:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652859384;
        bh=FmBz/6tJzQ7oxfLG8WOCSnnMFkJVR+lCnCuoNRKZ8I4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RtBg5Qw06YJyzq8Lprcq/B77eV6vfaUvGZ37Nryc/qmpBFHeLR/bcJ/0vlnc0hwfU
         UkfvLGuAT8VxnTu2OYf2svVFlVAU8xB6wsziq5ShJTjUGwm5IItqs1E+WF6nqD/jiO
         6vjHqVZOoQPK4LkrX/2M9QvOAuaWCyxu+I+CfJ52D8tY8Yd0pa7snbgp9K+VN2IWos
         fg5KQZYra15afGuQz8dEqJ4L3WbwZEOCd8TQzDjwiNgqnjsR5WSyohWHW28WCtgH/S
         5RTG1Bq6rFEycNHmPADHfjcUgYkJBtYy7fCcj/xnU1W9WN1z017naWNZqJRXWJV3JX
         wwwvwXVKutscA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nrEEL-0004EE-2o; Wed, 18 May 2022 09:36:25 +0200
Date:   Wed, 18 May 2022 09:36:25 +0200
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
Subject: Re: [PATCH v6 3/5] clk: qcom: gcc-sm8450: use new
 clk_regmap_pipe_src_ops for PCIe pipe clocks
Message-ID: <YoSh+dtJCPE2utTp@hovoldconsulting.com>
References: <20220513175339.2981959-1-dmitry.baryshkov@linaro.org>
 <20220513175339.2981959-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513175339.2981959-4-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 13, 2022 at 08:53:37PM +0300, Dmitry Baryshkov wrote:
> Use newly defined clk_regmap_pipe_src_ops for PCIe pipe clocks to let

clk_regmap_phy_mux

> the clock framework automatically park the clock when the clock is
> switched off and restore the parent when the clock is switched on.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Looks good otherwise:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
