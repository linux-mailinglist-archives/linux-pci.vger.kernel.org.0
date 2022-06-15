Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A1454D1E7
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 21:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349622AbiFOTqs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 15:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244636AbiFOTqs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 15:46:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A882954BE9;
        Wed, 15 Jun 2022 12:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A200B82145;
        Wed, 15 Jun 2022 19:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2548C34115;
        Wed, 15 Jun 2022 19:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655322404;
        bh=TpKBJ0oUWjgbL4DuuQ9uBRq6WcAQ8DRjn9zlHoW5rgg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Oy48UbhX/989h+ZbgtfIZLsG2DIaIlMfLYMTlLSgni47pU51RHRvEPa82mPew8402
         N27xL2/78Hy55FnhrquJndFG5xlsXn7H+dmFgaCGpi3FWM5xHlv0tOaLfET/uyNHoM
         FO23hFBGU7qt2eWEZHqj//3awg1ONBjM06BOOSeV5y1uze/4YRUuYhdaCDddyCZcPM
         Dva8y94PpJ9sXYEX1clVYdtdhByP4HZzcn6sXalwOgpvqkQfctubKF0D6kvN7YWTwO
         LOHcQRVJQyseySwD+2O0GJ4oaKaDJUZBpoxwjbVazQfF5YbrN83Apj15IQMnBe5C3d
         ZNlntG40Rwicw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220608105238.2973600-2-dmitry.baryshkov@linaro.org>
References: <20220608105238.2973600-1-dmitry.baryshkov@linaro.org> <20220608105238.2973600-2-dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v11 1/5] clk: qcom: regmap: add PHY clock source implementation
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        kernel test robot <lkp@intel.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>
Date:   Wed, 15 Jun 2022 12:46:42 -0700
User-Agent: alot/0.10
Message-Id: <20220615194644.D2548C34115@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Dmitry Baryshkov (2022-06-08 03:52:34)
> On recent Qualcomm platforms the QMP PIPE clocks feed into a set of
> muxes which must be parked to the "safe" source (bi_tcxo) when
> corresponding GDSC is turned off and on again. Currently this is
> handcoded in the PCIe driver by reparenting the gcc_pipe_N_clk_src
> clock. However the same code sequence should be applied in the
> pcie-qcom endpoint, USB3 and UFS drivers.
>=20
> Rather than copying this sequence over and over again, follow the
> example of clk_rcg2_shared_ops and implement this parking in the
> enable() and disable() clock operations. Supplement the regmap-mux with
> the new clk_regmap_phy_mux type, which implements such multiplexers
> as a simple gate clocks.
>=20
> This is possible since each of these multiplexers has just two clock
> sources: one coming from the PHY and a reference (XO) one.  If the clock
> is running off the from-PHY source, report it as enabled. Report it as
> disabled otherwise (if it uses reference source).
>=20
> This way the PHY will disable the pipe clock before turning off the
> GDSC, which in turn would lead to disabling corresponding pipe_clk_src
> (and thus it being parked to a safe, reference clock source). And vice
> versa, after enabling the GDSC the PHY will enable the pipe clock, which
> would cause pipe_clk_src to be switched from a safe source to the
> working one.
>=20
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
