Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739486BC45B
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 04:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjCPDR7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 23:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCPDRz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 23:17:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18545984C0;
        Wed, 15 Mar 2023 20:17:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C06461EF5;
        Thu, 16 Mar 2023 03:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148D1C4339B;
        Thu, 16 Mar 2023 03:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678936672;
        bh=484wecaX4E5d+zm2WfN26QVdRPnNsyO2G41Wq7DM2y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gj99j3Y24VYJd/TMUGaWBlz3JK3pXgTlNjR4RIMiMuB3re4HRlXBqkvlhmMZnoKkT
         eBHYmch21HAr/z0nVjx0m+f+lYv3XtAtOoZ9GfJiTKUtPzFSYeAaCejDcNgxHat7PP
         +p3+N+LIsRM/0qZrcixzr6o5s4VM8HyWpYCuEw1htwgVX7mpEjo8k//0trz9Zp7xPW
         Vayg6d6rattLApJj/06hKtpM7EdSSEXMWogEgopS5TnhzecdvepRpQzQaLJe90iflY
         +mGZnNAq5tq4dJdqs09x27bSgV0wyaFV7tenzT/loQVfDbQy1nuYhTzpYIvBYPX3Gd
         TqdCa9SnaCG4A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, vkoul@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, kishon@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, bhelgaas@google.com,
        linux-phy@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: (subset) [PATCH v3 00/13] Add PCIe RC support to Qcom SDX55 SoC
Date:   Wed, 15 Mar 2023 20:20:56 -0700
Message-Id: <167893686410.303819.5208981481540188437.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308082424.140224-1-manivannan.sadhasivam@linaro.org>
References: <20230308082424.140224-1-manivannan.sadhasivam@linaro.org>
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

On Wed, 8 Mar 2023 13:54:11 +0530, Manivannan Sadhasivam wrote:
> This series adds PCIe RC support to the Qcom SDX55 SoC. The PCIe controller
> in SDX55 can act as both Root Complex and Endpoint but only one mode at a
> time i.e., the mode cannot be switched during runtime.
> 
> This series has been tested on Thundercomm T55 board having QCA6390 WLAN
> chipset connected to the PCIe controller. For powering up the WLAN chipset,
> an out-of-tree patch has been used since we do not have a proper driver in
> mainline to handle the power supplies.
> 
> [...]

Applied, thanks!

[05/13] ARM: dts: qcom: sdx55: Fix the unit address of PCIe EP node
        commit: 3b76b736cd9933ff88764ffec01cbd859c1475e7
[06/13] ARM: dts: qcom: sdx55: Rename pcie0_{phy/lane} to pcie_{phy/lane}
        commit: c9f30e3dd92ba779c9cb8bb694ed7a8e2c9f0bb3
[07/13] ARM: dts: qcom: sdx55: Add support for PCIe RC controller
        commit: 2b20437e67a4b74b990d19d3dbf55388e941f30f
[08/13] ARM: dts: qcom: sdx55: List the property values vertically
        commit: f9364a7ced5e6e36904c359cafe23cbf03645884
[09/13] ARM: dts: qcom: sdx55-t55: Enable PCIe RC support
        commit: 046392390884c9dead1d3703fa60dff97f22857a
[10/13] ARM: dts: qcom: sdx55-t55: Move "status" property down
        commit: 43743bfa36daed8f31860ad889a1413f239bb2f2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
