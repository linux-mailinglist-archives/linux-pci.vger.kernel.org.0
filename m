Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F99C6DD73B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 11:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjDKJwx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 05:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjDKJwf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 05:52:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D3A1BE7;
        Tue, 11 Apr 2023 02:52:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6544B62377;
        Tue, 11 Apr 2023 09:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53A4C433EF;
        Tue, 11 Apr 2023 09:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681206752;
        bh=jHBr/160DV+CBpdR8u/29LNoLezOZW31xy3PT1M/tI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LWo9dfkR+O1nUTFzeTL2Br7DLArgsRwb14bZ2Y8tNYgvSHbRfLYIfW9Lf2PqdysW1
         vevcPW5tCbfHHX9I6PeWH7dX/duXPp724HLDYJNGIA8fjpgBK6FI/w0UwDj1FOOfs4
         3Onl4b2wwexaUnBNehW+kejRgLuUVJq5cIWXsxp0517ka017bT+onKKeg9TwX7ZVUf
         8NDTfasy8R0iMnav0D0RhwZ9fIgctcQ48vjJ97Wlfivb1w1mUzq19PzPefDtQ9mo67
         GEtjNNl0eLWs+By9fPUO1d4H06USGu6tQGaVL11Wnzlpv1AzC7+kpHcTUWRd9wGcwD
         dzi24fRDG5VkA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     kw@linux.com, robh@kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, andersson@kernel.org,
        konrad.dybcio@linaro.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_krichai@quicinc.com,
        johan+linaro@kernel.org, steev@kali.org, mka@chromium.org
Subject: Re: [PATCH v4 0/1] PCI: qcom: Add support for system suspend and resume
Date:   Tue, 11 Apr 2023 11:52:24 +0200
Message-Id: <168120672656.16216.1523847803663510861.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230403154922.20704-1-manivannan.sadhasivam@linaro.org>
References: <20230403154922.20704-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 03 Apr 2023 21:19:21 +0530, Manivannan Sadhasivam wrote:
> This series (a single patch) adds the system suspend and resume support
> to the Qualcomm PCIe RC controller.
> 
> Background
> ==========
> 
> There were previous attempts [1][2] to add system suspend and resume
> support to this driver.
> 
> [...]

Applied to controller/qcom, thanks!

[1/1] PCI: qcom: Add support for system suspend and resume
      https://git.kernel.org/pci/pci/c/ca0e2aad2720

Thanks,
Lorenzo
