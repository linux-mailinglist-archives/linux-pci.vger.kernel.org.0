Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CC873DCCB
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jun 2023 13:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjFZLEV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jun 2023 07:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjFZLEK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2023 07:04:10 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196329F;
        Mon, 26 Jun 2023 04:04:08 -0700 (PDT)
Received: from [185.109.152.99] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qDk0o-0000D5-Rv; Mon, 26 Jun 2023 13:04:02 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch
Cc:     Heiko Stuebner <heiko@sntech.de>, Johan Jonker <jbx6244@gmail.com>,
        dlemoal@kernel.org, Caleb Connolly <kc@postmarketos.org>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        xxm@rock-chips.com, linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Rob Herring <robh@kernel.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: (subset) [PATCH v5 00/11] PCI: rockchip: Fix RK3399 PCIe endpoint controller driver
Date:   Mon, 26 Jun 2023 13:03:51 +0200
Message-Id: <168777739039.859872.14001629058875555659.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418074700.1083505-1-rick.wertenbroek@gmail.com>
References: <20230418074700.1083505-1-rick.wertenbroek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 18 Apr 2023 09:46:47 +0200, Rick Wertenbroek wrote:
> This is a series of patches that fixes the PCIe endpoint controller driver
> for the Rockchip RK3399 SoC. The driver was introduced in commit
> cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
> The original driver had issues and would not allow for the RK3399 to
> operate in PCIe endpoint mode correctly. This patch series fixes that so
> that the PCIe core controller of the RK3399 SoC can now act as a PCIe
> endpoint. This is v5 of the patch series and addresses the comments received
> during the review of the v4 [1]. The changes to the v4 are minor and none of
> them change the logic of the driver.
> 
> [...]

Applied, thanks!

[05/11] arm64: dts: rockchip: Add dtsi entry for RK3399 PCIe endpoint core
        commit: 9755a52d65350233f74e234b1cf2804bd5a1839e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
