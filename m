Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5997A53C6D1
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 10:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242766AbiFCIR3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jun 2022 04:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbiFCIR2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2022 04:17:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A726513E32;
        Fri,  3 Jun 2022 01:17:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02F4C61946;
        Fri,  3 Jun 2022 08:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2FAC385A9;
        Fri,  3 Jun 2022 08:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654244246;
        bh=n/uxdVFlqd/70NfaZGs7ZnNoGexq1FOQrA++E/GKsZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H9jX0F+YV84ILmAP3hUfghsvQ2F6lfDzlzwfpJKjuShN8+rxbFlQtS/hBOFTF6NT/
         DYjzxaukwJ94phve2VXiXPNdCukhFD1uXa0Lo6sVh6rsFu16SQebjG7Ijc8t4XX29x
         J2cBkVAiFnvA1z5rcZYP+C5tk2LEHGwQD4aI/MmjunjkeWjUUr2S3lVk7zvPJoMzrf
         kNSEfcOexVDp/DcDNB24A1H3Rz0Gc2DXJc9AxbrXIHrYIha6NsYsx15KOWxSEF30l4
         Uso8BK8elr52KojDYek6VEcM4zM1bOK+eScFxZgFoqehBdB8qxevOk7W5CrHfdFLJu
         o3EKe2IfZVfhw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nx2Uj-00078V-86; Fri, 03 Jun 2022 10:17:21 +0200
Date:   Fri, 3 Jun 2022 10:17:21 +0200
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
Message-ID: <YpnDkbuZO3jCbxdF@hovoldconsulting.com>
References: <20220603075908.1853011-1-dmitry.baryshkov@linaro.org>
 <20220603075908.1853011-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603075908.1853011-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 03, 2022 at 10:59:05AM +0300, Dmitry Baryshkov wrote:
> Use newly defined clk_regmap_phy_mux_ops for PCIe pipe clocks to let
> the clock framework automatically park the clock when the clock is
> switched off and restore the parent when the clock is switched on.
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

The Tested-by tags you added are malformed throughout the series, please
review and respin (there should be two separate tags for R and T).

You can drop the Tested-by tags from the two clock driver since I really
tested the corresponding changes on a different platform (my fault, I
replied to the cover in the last round).

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Johan
