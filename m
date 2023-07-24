Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D586275FFA3
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 21:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjGXTMs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 15:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXTMr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 15:12:47 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9D194;
        Mon, 24 Jul 2023 12:12:45 -0700 (PDT)
Received: from [193.138.155.172] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qO0z0-00009J-F5; Mon, 24 Jul 2023 21:12:38 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, Qu Wenruo <wqu@suse.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Simon Xue <xxm@rock-chips.com>, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, John Clark <inindev@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>, kernel@collabora.com,
        Vinod Koul <vkoul@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: (subset) [PATCH v2 0/2] RK3588 PCIe3 support
Date:   Mon, 24 Jul 2023 21:12:35 +0200
Message-Id: <169022594803.2911118.12432442062352790360.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717173512.65169-1-sebastian.reichel@collabora.com>
References: <20230717173512.65169-1-sebastian.reichel@collabora.com>
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

On Mon, 17 Jul 2023 19:35:10 +0200, Sebastian Reichel wrote:
> This adds PCIe v3 support for RK3588. The series depends on the PCIe
> v2 series [0], since the the same binding is used. It has been tested
> on Rockchip EVB1 and Radxa Rock 5B.
> 
> Note, that the PCIe3 PHY driver is currently missing bifurcation
> support for RK3588. Thus after this series only PCIe3x4 is usable
> (in aggregated x4 mode) without adding support for the PHY's
> "rockchip,pcie30-phymode" DT property, which allows configuring
> how the lanes are distributed. Aggregated 3x4 mode seems to be the
> most common configuration. Both EVB1 and Rock 5B use it, so I
> cannot test anything else anyways.
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: rockchip: rk3588: add PCIe3 support
      commit: 0acf4fa7f187cd7e3dad93f1ee14e9509687621e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
