Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0200E66BA03
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jan 2023 10:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjAPJPl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Jan 2023 04:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjAPJO5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2023 04:14:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0EF16AE8;
        Mon, 16 Jan 2023 01:14:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B716360E84;
        Mon, 16 Jan 2023 09:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08433C433F1;
        Mon, 16 Jan 2023 09:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673860482;
        bh=Mv0LFnabOP+tyT97O6XPlBRFQ9+cJvyPwRJ9a26ox8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7jNNZUftu6HSGIobL57nEuo6+dTbYmVo4gHcgi32i1M4iDVw0LMSZJIsCQKe4Eqz
         R/ZohjQkyZbQ8eTBzQOOrN8TTqMGCRy1zpa1wFJ741YuGlKW38DS5xpXSJlANEhm4q
         vJ9FLh0NEXAY2xJ/o2yKGi6nK1h9MbGTLFLyBKwiiPinEv7yYiTyk+ftcxRlSAYip2
         fIxEZj10gxq0WAdv6GpdFbk5imEk5QmfiOChvP36qJkgMsPPk3p7AHmJRRRKWnryya
         Hdy43LBMu0CqSPSDOgWLrNckq8BXyiI28EjSOD+iaQejrxzSusP3mBEKTdWfcKwAmR
         pLSH6XrwW0ERg==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     mani@kernel.org, shawn.guo@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-pci@vger.kernel.org,
        Robert Marko <robimarko@gmail.com>,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        agross@kernel.org, robh@kernel.org, kw@linux.com,
        svarbanov@mm-sol.com, andersson@kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: (subset) [PATCH v2 1/9] arm64: dts: qcom: ipq8074: fix Gen2 PCIe QMP PHY
Date:   Mon, 16 Jan 2023 10:14:32 +0100
Message-Id: <167386042520.7526.13563822566607822845.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Applied to pci/qcom, thanks!

[5/9] dt-bindings: PCI: qcom: alphabetically sort compatibles
      https://git.kernel.org/lpieralisi/pci/c/4bc08cf23aaa
[6/9] dt-bindings: PCI: qcom: document IPQ8074 Gen3 port
      https://git.kernel.org/lpieralisi/pci/c/3271543941d8
[7/9] PCI: qcom: Add support for IPQ8074 Gen3 port
      https://git.kernel.org/lpieralisi/pci/c/0591d47a0217

Thanks,
Lorenzo
