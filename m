Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1701D3A4AE7
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jun 2021 00:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhFKWRb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Jun 2021 18:17:31 -0400
Received: from gloria.sntech.de ([185.11.138.130]:51732 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhFKWRa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jun 2021 18:17:30 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lrpQz-0004nw-4p; Sat, 12 Jun 2021 00:15:25 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Punit Agrawal <punitagrawal@gmail.com>, robh+dt@kernel.org,
        helgaas@kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, shawn.lin@rock-chips.com,
        pgwipeout@gmail.com, wqu@suse.com, briannorris@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alexandru.elisei@arm.com,
        robin.murphy@arm.com, ardb@kernel.org
Subject: Re: (subset) [PATCH v3 0/4] PCI: of: Improvements to handle 64-bit attribute for non-prefetchable ranges
Date:   Sat, 12 Jun 2021 00:15:23 +0200
Message-Id: <162344971712.3540446.14566858529390370657.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210607112856.3499682-1-punitagrawal@gmail.com>
References: <20210607112856.3499682-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 7 Jun 2021 20:28:52 +0900, Punit Agrawal wrote:
> This is the third iteration to improve handling of the 64-bit
> attribute on non-prefetchable host bridge ranges. Previous version can
> be found at [0][1].
> 
> This version is a small update over the previous version - changelog
> below. If there is no futher feedback on the patches, please consider
> merging them.
> 
> [...]

Applied, thanks!

[4/4] arm64: dts: rockchip: Update PCI host bridge window to 32-bit address memory
      commit: 8efe01b4386ab38a36b99cfdc1dc02c38a8898c3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
