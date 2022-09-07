Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAB45B0CAC
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 20:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiIGSoz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Sep 2022 14:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiIGSop (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2022 14:44:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6B01FCD6;
        Wed,  7 Sep 2022 11:44:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB76B61983;
        Wed,  7 Sep 2022 18:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4332C433C1;
        Wed,  7 Sep 2022 18:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662576279;
        bh=k8yIosi5SUGgCrgLwCIzRTlvsUroui/xnAWiLrUI0ko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AWh7aKF0gKdd84R12nhidY+viV0A/WGpmGkpa68NHblPHRXpOAGhwQ8VQDVPd2ztH
         36L+QWZK5nd/ZBwV2noXkxtLgajySpY69yCsmmbJ1K7Ii8Qy3fBHUq+h/FXKwfJa72
         sw7CYQHs2EpiKTpABVPZRDnSVJ7eA9WCk2ArA3akHgsS+AW+iZdbugsoOgYUvq4cKr
         kbuyika1ydPZF3Im+zYBXT4GDxz0BAbzESCOaDNDHfFtUNC9I96rK2Ju+86EMiGE1+
         vWnfQAudSP9zyP0XoJwIWY+RYP0PbhyZSFan+RxZ+OCKJNWwLuyI20e2yyou1EwHYN
         oiDOCFKfzdRIg==
Date:   Wed, 7 Sep 2022 13:44:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 1/3] PCI: qcom: Add sc7280 aggre0, aggre1 and ddr sf
 tbu clocks in PCIe driver
Message-ID: <20220907184437.GA137711@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662171184-25211-2-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 03, 2022 at 07:43:02AM +0530, Krishna chaitanya chundru wrote:
> Add missing aggre0, aggre1 and ddrs sf tbu clocks in PCIe driver.
> 
> If these clocks are not presenti, the PCIe link goes down in system suspend
> and resume.

s/presenti/present/

But the hardware clocks are present regardless of this driver change.

I suspect the point of this is really that if the driver doesn't
clk_get() these clocks to increase the reference count, we don't know
that the clocks are in use, and since they appear unused, they get
turned off during suspend.

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 2ea1375..a7202f0 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1548,7 +1548,10 @@ static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
>  static const struct qcom_pcie_cfg sc7280_cfg = {
>  	.ops = &ops_1_9_0,
>  	.has_tbu_clk = true,
> +	.has_ddrss_sf_tbu_clk = true,
>  	.pipe_clk_need_muxing = true,
> +	.has_aggre0_clk = true,
> +	.has_aggre1_clk = true,
>  };
>  
>  static const struct qcom_pcie_cfg sc8180x_cfg = {
> -- 
> 2.7.4
> 
