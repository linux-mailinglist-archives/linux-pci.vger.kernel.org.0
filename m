Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C113030AA
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 00:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbhAYX5o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jan 2021 18:57:44 -0500
Received: from gloria.sntech.de ([185.11.138.130]:34214 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732288AbhAYX5W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jan 2021 18:57:22 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1l4Bij-00066j-Gg; Tue, 26 Jan 2021 00:56:33 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Chen-Yu Tsai <wens@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Johan Jonker <jbx6244@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/4] arm64: rockchip: Fix PCIe ep-gpios requirement and Add Nanopi M4B
Date:   Tue, 26 Jan 2021 00:56:27 +0100
Message-Id: <161161878915.2050283.9418666502176859174.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121162321.4538-1-wens@kernel.org>
References: <20210121162321.4538-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 22 Jan 2021 00:23:17 +0800, Chen-Yu Tsai wrote:
> This is v4 of my Nanopi M4B series.
> 
> Changes since v3 include:
> 
>   - Directly return dev_err_probe() instead of having a separate return
>     statement
> 
> [...]

Applied, thanks!

[3/4] arm64: dts: rockchip: nanopi4: Move ep-gpios property to nanopc-t4
      commit: 3503376d6cc385b6266f93c24ead9a33d8dfe8cb
[4/4] arm64: dts: rockchip: rk3399: Add NanoPi M4B
      commit: c7b03115003f7f337ab165542cee37148cf30a8a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
