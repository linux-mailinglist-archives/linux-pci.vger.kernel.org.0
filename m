Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE2230356A
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 06:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbhAZFkx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 00:40:53 -0500
Received: from foss.arm.com ([217.140.110.172]:52342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729970AbhAYRL0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jan 2021 12:11:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14F8C11FB;
        Mon, 25 Jan 2021 09:10:39 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.45.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 212AF3F68F;
        Mon, 25 Jan 2021 09:10:37 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Chen-Yu Tsai <wens@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v4 0/4] arm64: rockchip: Fix PCIe ep-gpios requirement and Add Nanopi M4B
Date:   Mon, 25 Jan 2021 17:10:31 +0000
Message-Id: <161159460063.30598.10362504498380643091.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210121162321.4538-1-wens@kernel.org>
References: <20210121162321.4538-1-wens@kernel.org>
MIME-Version: 1.0
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

Applied to pci/rockchip (dropped dts patches 3-4), thanks!

[1/2] PCI: rockchip: Make 'ep-gpios' DT property optional
      https://git.kernel.org/lpieralisi/pci/c/96f760cc00
[2/2] dt-bindings: arm: rockchip: Add FriendlyARM NanoPi M4B
      https://git.kernel.org/lpieralisi/pci/c/b205659626

Thanks,
Lorenzo
