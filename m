Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E76A6730D7
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 06:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjASFAR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 00:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjASE7u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 23:59:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B696E809;
        Wed, 18 Jan 2023 20:54:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3024661B08;
        Thu, 19 Jan 2023 04:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE8BC433F2;
        Thu, 19 Jan 2023 04:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674104045;
        bh=8STx2T8AJT0u5Zm/c1U9jriS211KAffMt8EbxIqBgBM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rxL85B7jBYlqD7zx9JK9i4b/MHm8n93LItWc32urivS+btvL/bkcFdb23u8uuJSo9
         PRRDihA+oN3AfCvmgRZr/MoEL2N5ElAUTwYGzgFOktwQqypHBoRryAi5L0cpQbeMe3
         tV96jsK2VwlR6rVKtOjeC4JD62SASG0GIAuXrbMaZMFpgGeKjYKqOcHmgKhCqQFrmv
         uih3LhL1xSSQtTUjJRU2iV3754K/kd9PuVU4EdSK33HsFYDMCBZ5oOfAoTZw3cPenJ
         GYcYHPZqdbPkOcBeYvTW1q5ta6scRWGDFTA8ltJXg3wgj4LwCfxbt2p/3JP1cRct6D
         KMR3JkNOG7oZA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     shawn.guo@linaro.org, kw@linux.com, linux-pci@vger.kernel.org,
        lpieralisi@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, robh@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Robert Marko <robimarko@gmail.com>,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        svarbanov@mm-sol.com, mani@kernel.org
Subject: Re: (subset) [PATCH v2 1/9] arm64: dts: qcom: ipq8074: fix Gen2 PCIe QMP PHY
Date:   Wed, 18 Jan 2023 22:54:00 -0600
Message-Id: <167410403679.3048186.3473019994896236828.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230113164449.906002-1-robimarko@gmail.com>
References: <20230113164449.906002-1-robimarko@gmail.com>
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

On Fri, 13 Jan 2023 17:44:41 +0100, Robert Marko wrote:
> Serdes register space sizes are incorrect, update them to match the
> actual sizes from downstream QCA 5.4 kernel.
> 
> 

Applied, thanks!

[1/9] arm64: dts: qcom: ipq8074: fix Gen2 PCIe QMP PHY
      commit: 100d9c94ccf15b02742c326cd04f422ab729153b
[2/9] arm64: dts: qcom: ipq8074: fix Gen3 PCIe QMP PHY
      commit: 7ba33591b45f9d547a317e42f1c2acd19c925eb6
[3/9] arm64: dts: qcom: ipq8074: correct Gen2 PCIe ranges
      commit: 2055cb7dccea16bafa3adf9c5e3216949512c34a
[4/9] arm64: dts: qcom: ipq8074: set Gen2 PCIe pcie max-link-speed
      commit: b60590314828e3da670bed94129f4ebc02b87548
[8/9] arm64: dts: qcom: ipq8074: fix Gen3 PCIe node
      commit: 3e83a9c41ab0244a45a4a2800b9adb8de0d15f82
[9/9] arm64: dts: qcom: ipq8074: correct PCIe QMP PHY output clock names
      commit: 0e8b90c0256cf9c9589e2cee517dedc987a34355

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
