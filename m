Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81712F00EA
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jan 2021 16:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbhAIPkn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jan 2021 10:40:43 -0500
Received: from gloria.sntech.de ([185.11.138.130]:36748 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbhAIPkn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 Jan 2021 10:40:43 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kyGLN-0000jX-L2; Sat, 09 Jan 2021 16:39:57 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: (subset) [PATCH 0/2] PCI: rockchip: Fix PCIe probing in 5.9
Date:   Sat,  9 Jan 2021 16:39:52 +0100
Message-Id: <161020678304.3482489.16265373778733987316.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20200815125112.462652-1-maz@kernel.org>
References: <20200815125112.462652-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 15 Aug 2020 13:51:10 +0100, Marc Zyngier wrote:
> Recent changes to the way PCI DT nodes are parsed are now enforcing
> the presence of a "device_type" property, which has been mandated
> since... forever. This has the unfortunate effect of breaking
> non-compliant systems, and those using the Rockchip PCIe driver are
> amongst the victims. Oh well.
> 
> In order to keep users happy as well as my own machines up and
> running, let's paper over the problem by detecting a broken DT from
> the driver itself, and inserting the missing property at runtime.
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: rockchip: Fix PCIe DT properties
      commit: 43f20b1c6140896916f4e91aacc166830a7ba849

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
