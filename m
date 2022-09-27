Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452505EB8A9
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 05:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiI0DYg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 23:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiI0DX5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 23:23:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E00C57BE3;
        Mon, 26 Sep 2022 20:23:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DABD1B81910;
        Tue, 27 Sep 2022 03:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA21BC4347C;
        Tue, 27 Sep 2022 03:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664248993;
        bh=WPTi/MLtEp6ejiLdeHDqeJBbCy8zfALjPLNAZfwnaTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cVbpZHibYUbFbbCo3awQ65Obu32RYX70+lwY7amHfgd5tCoizCCYWCKhPz/uyN3fX
         1kkaQ4egx2PuDxGlFplUrjYE5x9HTNO46UzzpNDmDqbS2WKez/tYWOvoYkypp9jKMT
         /tpEOm16jAMmatm0coenAEb6y2Q6xwexwOYy8FwWZRoh+Wzb70/t7WQcKsDovHGLZ/
         y+AUTedsTONS8qoEVOexxvWYZrdoCl884zpNmyNU3VS9GpiSR4e56wm5gyjqr4WeU+
         NFY8YOLj+Q6hOUjt2RlJlPjcSU5F0k92KQaS/oqD0UWu5OqY1Y7fqocrgIlYuhPQju
         jz52H4FPe5NIw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_krichai@quicinc.com, helgaas@kernel.org
Cc:     quic_vbadigan@quicinc.com, vkoul@kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, quic_ramkri@quicinc.com,
        konrad.dybcio@somainline.org, bhelgaas@google.com,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, quic_nitegupt@quicinc.com,
        svarbanov@mm-sol.com, lpieralisi@kernel.org, kishon@ti.com,
        quic_skananth@quicinc.com, mturquette@baylibre.com,
        robh@kernel.org, mka@chromium.org, linux-phy@lists.infradead.org,
        agross@kernel.org, quic_hemantk@quicinc.com, kw@linux.com,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: (subset) [PATCH v7 0/5] PCI: qcom: Add system suspend & resume support
Date:   Mon, 26 Sep 2022 22:23:03 -0500
Message-Id: <166424897975.1766486.8316270705903909845.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1663669347-29308-1-git-send-email-quic_krichai@quicinc.com>
References: <1663669347-29308-1-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 20 Sep 2022 15:52:22 +0530, Krishna chaitanya chundru wrote:
> Few PCIe endpoints like NVMe and WLANs are always expecting the device
> to be in D0 state and the link to be active (or in l1ss) all the
> time (including in S3 state).
> 
> This patch series adds this support for allowing the system to enter
> S3 state (and further low power states) with PCIe Device being in D0
> state and with link being in l1ss on qcom platforms.
> 
> [...]

Applied, thanks!

[5/5] clk: qcom: gcc-sc7280: Update the .pwrsts for PCIe GDSC
      commit: 1a58ee1330b2cb6d71feb0aaf827cc10030f78b4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
