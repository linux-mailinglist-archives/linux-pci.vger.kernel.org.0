Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E1C66E6C2
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jan 2023 20:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjAQTPJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Jan 2023 14:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjAQTKm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2023 14:10:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01C537B42;
        Tue, 17 Jan 2023 10:24:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2806B819A1;
        Tue, 17 Jan 2023 18:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2BFC43396;
        Tue, 17 Jan 2023 18:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673979876;
        bh=e/Yadhg7MhxiC6ICfyqgJNkywCHiFZdW0smgFQQj1Ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cWvg9UKfMMTj3rO/pO1Mra0JKxMu5xIubaxUkEzGDvQyPUDv1ud6ehrdFA1TQVKtn
         jhiN+842WVmmNJi5uSNygHV0oRFClHoUqel4z29u1M8KvvoTzJqsPI522+G8quNAxG
         L/vLYT7SSuKkHQKK2sUp1sLpTFyGmbQ79wrVCBJdnQQqvEwgOU3e3fbbSB+dGXq2sM
         Ij4+5FiFWoSCUP1MLxvcBTh+VULLIeVcWhre8CYGbT9Xo2OeJBobXbHAgTHOE18HS8
         aKNZXPiwVvFW7DXeCFYMe+PVxKA5lg4fLm4EQlIqpwAtDZS47Q1FV+wDvPkBSoRNJT
         34nAkBoRcsd2w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     dmitry.baryshkov@linaro.org, kw@linux.com, kishon@kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        jingoohan1@gmail.com, konrad.dybcio@somainline.org,
        agross@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gustavo.pimentel@synopsys.com
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, p.zabel@pengutronix.de,
        linux-pci@vger.kernel.org, johan@kernel.org
Subject: Re: (subset) [PATCH v4 0/8] PCI/phy: Add support for PCI on sm8350 platform
Date:   Tue, 17 Jan 2023 12:24:21 -0600
Message-Id: <167397986254.2832389.9697915757914288404.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221118233242.2904088-1-dmitry.baryshkov@linaro.org>
References: <20221118233242.2904088-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 19 Nov 2022 01:32:34 +0200, Dmitry Baryshkov wrote:
> SM8350 is one of the recent Qualcomm platforms which lacks PCIe support.
> Use sm8450 PHY tables to add support for the PCIe hosts on Qualcomm SM8350 platform.
> 
> Note: the PCIe0 table is based on the lahaina-v2.1.dtsi file, so it
> might work incorrectly on earlier SoC revisions.
> 
> Dependencies:
> - phy/next (for PHY patches only)
> 
> [...]

Applied, thanks!

[7/8] arm64: dts: qcom: sm8350: add PCIe devices
      commit: 6daee40678a0868a994b2ce923694c52299dbd65
[8/8] arm64: dts: qcom: sm8350-hdk: enable PCIe devices
      commit: 186b27135a9edb5bfbdebd5fb525e3fb7eff962e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
