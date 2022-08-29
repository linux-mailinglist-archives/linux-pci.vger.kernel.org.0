Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AB45A57F3
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 01:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiH2Xql (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 19:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiH2Xqg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 19:46:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B5D9858D;
        Mon, 29 Aug 2022 16:46:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B5B6B815BE;
        Mon, 29 Aug 2022 23:46:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559EBC43141;
        Mon, 29 Aug 2022 23:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816786;
        bh=ngzmV0n2+BdQTsftiFqUPUBwcYzqmAbmruA7VSeNz4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MEmGzWGcxd7CxQW8trPlhlt+53aCFKMC4zmgwPZxpJVzaKqINuGLFJFOxJnlrAquo
         QOeN5shQYatX0DYVy5Wn/jSYOHMn5XiLRs6QHlskFh69gP5VGn0hlMPY3RuaXSOJrm
         F4IPfivkApj7zfhxnA2ckL/PJUKYOa/ePqAWRIaI13cGs+CZ0pxB04NjMVOMpAYqdE
         pwPtKdjykkCJAlVqBG7vLsc7PrhMbOrD/63dPC3XSzg1xgYaPtok0rNRdXl7QZmcD6
         e18KAlUZnhsNXgeqL9eHWNWFbkhUNrZlphlmJJ4VhlqpQwXaCgwaYcoMWkgW5/zwFa
         ZOSNKnIYvq1hA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     svarbanov@mm-sol.com, bhelgaas@google.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        dmitry.baryshkov@linaro.org,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, krzk@kernel.org,
        gustavo.pimentel@synopsys.com, agross@kernel.org,
        jingoohan1@gmail.com
Cc:     vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v6 0/8] dt-bindings: YAMLify pci/qcom,pcie schema
Date:   Mon, 29 Aug 2022 18:45:48 -0500
Message-Id: <166181675954.322065.13917863226210915201.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220506152107.1527552-1-dmitry.baryshkov@linaro.org>
References: <20220506152107.1527552-1-dmitry.baryshkov@linaro.org>
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

On Fri, 6 May 2022 18:20:59 +0300, Dmitry Baryshkov wrote:
> Convert pci/qcom,pcie schema to YAML description. The first patch
> introduces several warnings which are fixed by the other patches in the
> series.
> 
> Note regarding the snps,dw-pcie compatibility. The Qualcomm PCIe
> controller uses Synopsys PCIe IP core. However it is not just fused to
> the address space. Accessing PCIe registers requires several clocks and
> regulators to be powered up. Thus it can be assumed that the qcom,pcie
> bindings are not fully compatible with the snps,dw-pcie schema.
> 
> [...]

Applied, thanks!

[5/8] arm64: dts: qcom: stop using snps,dw-pcie falback
      commit: 3e4fec3bc8f8d1366cf2d8d8a054ed37e5a41cba
[8/8] arm64: dts: qcom: replace deprecated perst-gpio with perst-gpios
      commit: f3f5fb3184ec0cd7f98267a8dc1c0538575fbb77

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
