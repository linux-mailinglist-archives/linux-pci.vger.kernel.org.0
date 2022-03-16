Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F284DA6AF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 01:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345086AbiCPAJK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Mar 2022 20:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244967AbiCPAJJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2022 20:09:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C77BF5B;
        Tue, 15 Mar 2022 17:07:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A72EB818F9;
        Wed, 16 Mar 2022 00:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120E1C340E8;
        Wed, 16 Mar 2022 00:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647389273;
        bh=2tyUNb7dn2nQ7bEuHj4DwFLAyjpMrDCvB7bUvqHcVqs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=HXTnDlnK7X8WXEYPJqBaSVQqB90AoS0J/YuLBt+jBfpY3108BRQh+dbKUMb9lUoJL
         b10YesXghFIDHfs2pFIxgbdrYO/NRrvuxkuAaOfGvI3TjjUnTqXDYweGIJIj1xySdu
         lQdF0V5H+wW90MC0XK9aQeJmLYyTrRB+bfLRuF/EvKUuq9zQE6GoC/2N82dRB579Qm
         L8lx1s/ATXeUNz+jVIJvK8N7xbe9WH0rC9gZrE+lnR+cXSV3WO6HZhLcMo3oa/mShL
         dLBGZ93X3nltrb9iUpH1CKQMwZrqPyS8zmxyVLovb+z8HE27zctMmt4U/PighDr7Hm
         oXx2x6ZReeAXw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220313000824.229405-4-dmitry.baryshkov@linaro.org>
References: <20220313000824.229405-1-dmitry.baryshkov@linaro.org> <20220313000824.229405-4-dmitry.baryshkov@linaro.org>
Subject: Re: [RFC PATCH 3/5] clk: qcom: gcc-sc7280: use new clk_regmap_mux_safe_ops for PCIe pipe clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Prasad Malisetty <quic_pmaliset@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Tue, 15 Mar 2022 17:07:51 -0700
User-Agent: alot/0.10
Message-Id: <20220316000753.120E1C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Dmitry Baryshkov (2022-03-12 16:08:22)
> Use newly defined clk_regmap_mux_safe_ops for PCIe pipe clocks to let
> the clock framework automatically park the clock when the clock is
> switched off and restore the parent when the clock is switched on.
>=20
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/clk/qcom/gcc-sc7280.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
> index 423627d49719..69887e45d02f 100644
> --- a/drivers/clk/qcom/gcc-sc7280.c
> +++ b/drivers/clk/qcom/gcc-sc7280.c
> @@ -373,13 +373,14 @@ static struct clk_regmap_mux gcc_pcie_0_pipe_clk_sr=
c =3D {
>         .reg =3D 0x6b054,
>         .shift =3D 0,
>         .width =3D 2,
> +       .safe_src_index =3D 2,

Can this be

	.safe_src_index =3D gcc_parent_map_6[1].cfg

or something that indicates that this is a value inside the parent map
and not an array index?
