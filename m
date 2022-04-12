Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E036B4FDEB4
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 13:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbiDLL5R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 07:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344344AbiDLL4t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 07:56:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92CF60A9A;
        Tue, 12 Apr 2022 03:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EDB4B81CA1;
        Tue, 12 Apr 2022 10:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33452C385A1;
        Tue, 12 Apr 2022 10:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649760014;
        bh=9pk3pVVU+tzTaBuH4UHl5rYkdZrqMTBhJJtEpCzTfyo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eahZ62fOXAYpMrYgfr9ydE51IMiVoUgBsXQph+GuZSgcqRrtunDqIhC2jLGvvXcnA
         ouOr1dnxr4uX2dK+0HJFnAZZUVhv1A8WnxN3jR1Atx8s868HhTy2roiTmytWKO+rJa
         OAMxcepuKuCGfcBD+hN5vNcKJNQXs5KHPNgHGFfa4gS+rr+8deqC2nfE1tlQRIxBk1
         Rt2BGnLctZoGv17phoi/Xk7pb1d2WnPe3inqxPXMmxtLtLBR+7dqk6ZLhd5v0u+hJk
         1AXGRVBPtu3Cs+iBii4FtUCaPFZhoXcc8XR6ssyMJSFkVwUkpfdaf8cJLht+dxstMn
         RJ1e1OdttNz+g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Prasad Malisetty <quic_pmaliset@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajatja@google.com,
        refactormyself@gmail.com, quic_vbadigan@quicinc.com,
        quic_ramkri@quicinc.com, swboyd@chromium.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH v4] PCI: qcom: Add system PM support
References: <1646679306-4768-1-git-send-email-quic_pmaliset@quicinc.com>
        <20220412060144.GA41348@thinkpad>
Date:   Tue, 12 Apr 2022 13:40:08 +0300
In-Reply-To: <20220412060144.GA41348@thinkpad> (Manivannan Sadhasivam's
        message of "Tue, 12 Apr 2022 11:31:44 +0530")
Message-ID: <87k0buoa9j.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ ath11k

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:

> +Kalle, linux-wireless
>
> On Tue, Mar 08, 2022 at 12:25:06AM +0530, Prasad Malisetty wrote:
>> Add suspend_noirq and resume_noirq callbacks to handle
>> system suspend and resume in dwc PCIe controller driver.
>> 
>> When system suspends, send PME turnoff message to enter
>> link into L2 state. Along with powerdown the PHY, disable
>> pipe clock, switch gcc_pcie_1_pipe_clk_src to XO if mux is
>> supported and disable the pcie clocks, regulators.
>> 
>
> Kalle, is this behaviour appropriate for WLAN devices as well? The devices
> will be put into poweroff state (assuming no Vaux provided in D3cold) during
> system suspend.

ath11k leaves the firmware running during suspend. I don't fully
understand what the patch is doing, but if it cuts the power from the
WLAN chip during suspend that will break ath11k.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
