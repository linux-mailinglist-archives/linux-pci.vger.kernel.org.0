Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D81E5762F3
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 15:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiGONm6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 09:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiGONm6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 09:42:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608CD7E006;
        Fri, 15 Jul 2022 06:42:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F01A162398;
        Fri, 15 Jul 2022 13:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D97C34115;
        Fri, 15 Jul 2022 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657892576;
        bh=P0r+WyTdBh5LeL1cNNOS1KB7VpTH+2BmbnnTUuDAZI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CYMRp1EOv1X1CMDDhb7eRuJtSK4/dzz7Rntvp5/ETBQrJYc5x2SNAa6Buw5BDj4Zi
         WEGpyixwENFE3MpJoOTW+/SsgbzQ9P5zl+9L+9NYyfm/bCUEYRfjHrk8yd9MtenKzI
         e4+TqHrC/+UxES8t8sgWvcBFbijgs7m4K4WAIXBiYDgf64U47BiJBGbvGwkUwnX1JX
         5t4P3FZofldTt8KqBvTuNYPVCBLpB+1+djfmLgdTxjMhqsPR2iWC3l0XnVoMaVQHs9
         fd/tZ0VWYOHKSrjrSVKMesFAjIwWxtWg0OIABbee1L2cNmit87qoEhZwKVny6atJgO
         VS3h4Q4l7gaUQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oCLav-0006M6-M9; Fri, 15 Jul 2022 15:43:01 +0200
Date:   Fri, 15 Jul 2022 15:43:01 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        dmitry.baryshkov@linaro.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4 1/2] PCI: qcom: Add system PM support
Message-ID: <YtFu5YKdMPqqpZk8@hovoldconsulting.com>
References: <1656684800-31278-1-git-send-email-quic_krichai@quicinc.com>
 <1657118425-10304-1-git-send-email-quic_krichai@quicinc.com>
 <1657118425-10304-2-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657118425-10304-2-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 06, 2022 at 08:10:24PM +0530, Krishna chaitanya chundru wrote:
> Add suspend and resume pm callbacks.
> 
> When system suspends, and if the link is in L1ss, disable the clocks
> and power down the phy so that system enters into low power state to
> save the maximum power. And when the system resumes, enable the clocks
> back and power on phy if they are disabled in the suspend path.
> 
> we are doing this only when link is in l1ss but not in L2/L3 as
> no where we are forcing link to L2/L3 by sending PME turn off.
> 
> is_suspended flag indicates if the clocks are disabled in the suspend
> path or not. And this flag is being used to restrict the access to
> config space, dbi etc when clock are turned-off.
 
> Changes since v3:
> 	- Powering down the phy in suspend and powering it on resume to
> 	  acheive maximum power savings.
> Changes since v2:
> 	- Replaced the enable, disable clks ops with suspend and resume
> 	- Renamed support_pm_opsi flag  with supports_system_suspend.
> Changes since v1:
> 	- Fixed compilation errors.

Changelogs typically go below the --- line below so that they don't end
up in the git logs.
 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 85 ++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)

> +static int qcom_pcie_resume_2_7_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> +	int ret;
> +
> +	clk_prepare_enable(res->pipe_clk);

Note that pipe clock management has now been removed from this driver.

Please consider rebasing on this branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/ctrl/qcom

> +
> +	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
> +
> +	phy_power_on(pcie->phy);
> +
> +	return ret;
> +}

Johan
