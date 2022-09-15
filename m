Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9F45B934C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Sep 2022 05:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiIODhy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 23:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiIODho (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 23:37:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECE793222;
        Wed, 14 Sep 2022 20:37:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 666CC6207E;
        Thu, 15 Sep 2022 03:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE218C43144;
        Thu, 15 Sep 2022 03:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663213040;
        bh=30VmoIH2mojzRZCxxN09Bex8ueXFnh+raoeTk+4l268=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E36P+ppNiZ6lJ86ZmF3sxthTtcj82UQHeVw6uPafr9glHSI3wMvf2A0U2E8aXK2Ye
         U9eeOAfqobE3tfasZfS4Q5Q4iNV/2IJmqcrRFnSWuU4tind5n+GEsMkqSfdXPceaPy
         wrfS1i6xrTuAOHZWqI8LUPu4sQadsE+fBPiCrjInxv0eqJQBVUxD7lH2qb3kuw1zHq
         fruw0mcOewCuWgere4s/UllVXkUophB6/xXJUT5sfuX7xu6ZZ0K33H/+bEUmo6soFf
         eaEgVsDJxP6fX8l7xOrK+RXQE2n6IkONYdhahVakntap+l92DIdfdNdYbjFI0MKB+h
         yBtV+FM1UIJXA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_krichai@quicinc.com, helgaas@kernel.org
Cc:     quic_skananth@quicinc.com, quic_hemantk@quicinc.com,
        mka@chromium.org, swboyd@chromium.org, quic_ramkri@quicinc.com,
        dmitry.baryshkov@linaro.org, quic_nitegupt@quicinc.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 0/2] PCI: qcom: sc7280: add missing aggre0 and aggre1 clocks
Date:   Wed, 14 Sep 2022 22:37:02 -0500
Message-Id: <166321302065.788007.14282428771934393064.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1662626776-19636-1-git-send-email-quic_krichai@quicinc.com>
References: <1662626776-19636-1-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 8 Sep 2022 14:16:14 +0530, Krishna chaitanya chundru wrote:
> Add missing aggre0 and aggre1 clocks supports to PCIe node.
> 
> Without voting these clocks, PCIe link is going down when system is
> suspended as these clocks can get turned off as no-one is voting for them.
> 
> Krishna chaitanya chundru (2):
>   arm64: dts: qcom: sc7280: Add missing aggre0, aggre1 clocks
>   dt-bindings: pci: QCOM Add missing sc7280 aggre0, aggre1 clocks
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sc7280: Add missing aggre0, aggre1 clocks
      commit: aaf85b46aa4145f5ec7aa0a9bdf4a93b23474524
[2/2] dt-bindings: pci: QCOM Add missing sc7280 aggre0, aggre1 clocks
      commit: a672a9f4a6bba31f8dfb3a77714468ddb985ecf7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
