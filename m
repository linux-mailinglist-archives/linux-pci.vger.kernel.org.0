Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D9966536D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 06:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbjAKFT3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 00:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjAKFST (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 00:18:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A7713F4D;
        Tue, 10 Jan 2023 21:10:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB56061A32;
        Wed, 11 Jan 2023 05:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58219C433D2;
        Wed, 11 Jan 2023 05:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413810;
        bh=k4mGoJ157XjRn/jn8LZpqS2SMuqUWhz6UMJcjbqpuCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vGHvht/2ZkAHIYav1P5IPrJNgJ1nooKqgLRTKGBh5C+jeDG0ABlQ96Uq5H6nvHLQ1
         hpKWJ7ZN1kwd8h6nWqVyLRUkcYPRj/sjH4TqNHGZfZXEUztXFjWgCpIeuZIrmt0qAO
         ylHHm30KCjVmDak84mJjWBHOb5myLZW9kqbu2kVvMpqpJxzsYUS++Jzci6lwhj7AlY
         riRQebAfVaEaqLd7qbCmEY84ZEu72GtqyokdPBoHw9VxJfC9zaVkqxMRduugjDONml
         dgTflgE06yGUJZM9e2wt1L0y2t8vDWquFmec/x/hx5D8cdbu/b59Dv1SG4dWRXVYrX
         C5YJj8Qfz0l9g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org,
        Manivannan Sadhasivam <mani@kernel.org>, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bhelgaas@google.com,
        lpieralisi@kernel.org, konrad.dybcio@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/3] Qcom: Add GIC-ITS support to SM8450 PCIe controllers
Date:   Tue, 10 Jan 2023 23:09:35 -0600
Message-Id: <167341377734.2246479.3912672275247761448.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230102105821.28243-1-manivannan.sadhasivam@linaro.org>
References: <20230102105821.28243-1-manivannan.sadhasivam@linaro.org>
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

On Mon, 2 Jan 2023 16:28:18 +0530, Manivannan Sadhasivam wrote:
> This series adds GIC-ITS support to SM8450 PCIe controllers for signalling
> the MSIs received from endpoint devices to the CPU cores.
> 
> The GIC-ITS MSI implementation provides an advantage over internal MSI
> implementation using Locality-specific Peripheral Interrupts (LPI) that
> would allow MSIs to be targeted for each CPU core.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sm8450: Use GIC-ITS for PCIe0 and PCIe1
      commit: ff384ab56f164ef14bcc5f2bd79e995b4dea4bf3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
