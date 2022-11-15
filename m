Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B093062A0A7
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 18:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiKORqk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 12:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiKORqj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 12:46:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11869DFF3;
        Tue, 15 Nov 2022 09:46:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9789961967;
        Tue, 15 Nov 2022 17:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B3AC4347C;
        Tue, 15 Nov 2022 17:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668534398;
        bh=4ujkqMZtjuv2jX4dXqOndyqS/F6K/3aRLsjDLMf/yAQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eRRL+ZRd6zlrnWjAA5+PniHYairQ18AGiqIg8Z5YiqtzRsF+X9EQp5G1XcssRFLjY
         kWKN6WNwxcWMlberi1kztQHJyqfDKx0M3koYYl7TGDzlOSXfAwnfR1d6buYGcY5sbv
         x+PUEfSKNVnv7+KHbFZLNydoucE3t5GjZQoZPhH60x6vzoWdsDCypBvRsCCwNLqdQ1
         w7dwTRWriLlfUjhPdoW4q8D2ykuWgZYPO/fWPUMorqvqCIPUuqs0rUzMnVGP+bLRGk
         NNDYYLt42olIs3Pldb6nTKHhr7mmyVLYEhVLcCfAhIe3ddJYQxrsBZIAsgM/lvBNrQ
         nvYNS2IGgCMGA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        svarbanov@mm-sol.com, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@linaro.org, linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH 1/4] dt-bindings: PCI: qcom: add MSM8998 specific compatible
Date:   Tue, 15 Nov 2022 11:46:31 -0600
Message-Id: <166853438866.1276519.11595015532315610699.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221115125310.184012-1-krzysztof.kozlowski@linaro.org>
References: <20221115125310.184012-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 15 Nov 2022 13:53:07 +0100, Krzysztof Kozlowski wrote:
> Add new compatible for MSM8998 (compatible with MSM8996) to allow
> further customizing if needed and to accurately describe the hardware.
> 
> 

Applied, thanks!

[3/4] arm64: dts: msm8998: add MSM8998 specific compatible
      commit: 0d70d5f6614e15bdc269b630b7f884889568b1bb
[4/4] arm64: dts: msm8998: unify PCIe clock order withMSM8996
      commit: b132731bb936cfe0ee26790eeb51572d12dbf854

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
