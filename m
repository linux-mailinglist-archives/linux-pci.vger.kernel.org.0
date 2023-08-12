Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E775B779FF3
	for <lists+linux-pci@lfdr.de>; Sat, 12 Aug 2023 14:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbjHLMWZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Aug 2023 08:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHLMWX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Aug 2023 08:22:23 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BEB136;
        Sat, 12 Aug 2023 05:22:26 -0700 (PDT)
Received: from i53875bbf.versanet.de ([83.135.91.191] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qUndI-0000MO-0o; Sat, 12 Aug 2023 14:22:16 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        kernel@collabora.com,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: (subset) [PATCH v4 0/5] RK3588 PCIe2 support
Date:   Sat, 12 Aug 2023 14:22:13 +0200
Message-Id: <169184288419.3581838.12693599479486978046.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731165723.53069-1-sebastian.reichel@collabora.com>
References: <20230731165723.53069-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 31 Jul 2023 18:57:18 +0200, Sebastian Reichel wrote:
> This adds PCIe v2 support for RK3588. The series has been tested with
> the onboard RTL8125 network card on Rockchip RK3588 EVB1 (&pcie2x1l1)
> and Radxa Rock 5B (&pcie2x1l2).
> 
> Changes since v3:
>  * https://lore.kernel.org/all/20230717172651.64324-1-sebastian.reichel@collabora.com/
>  * Remove unneeded quotes in patch 1 (msi handling)
>  * Update patch description of patch 2 (interrupt names) adding information
>    about Rockchip specific parts
> 
> [...]

Applied, thanks!

[5/5] arm64: dts: rockchip: rk3588: add PCIe2 support
      commit: 8d81b77f4c49f8ee1432c20c22bf0f03c2937a88

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
