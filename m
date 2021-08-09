Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FE03E487E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 17:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbhHIPRI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 11:17:08 -0400
Received: from foss.arm.com ([217.140.110.172]:34770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234125AbhHIPRH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Aug 2021 11:17:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EF426D;
        Mon,  9 Aug 2021 08:16:46 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.39.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC9623F718;
        Mon,  9 Aug 2021 08:16:42 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Simon Xue <xxm@rock-chips.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Kever Yang <kever.yang@rock-chips.com>,
        devicetree@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        linux-pci@vger.kernel.org, Johan Jonker <jbx6244@gmail.com>,
        robh+dt@kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v11] PCI: rockchip-dwc: Add Rockchip RK356X host controller driver
Date:   Mon,  9 Aug 2021 16:16:35 +0100
Message-Id: <162852218275.22823.11845865403290734998.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210625065511.1096935-1-xxm@rock-chips.com>
References: <20210625065511.1096935-1-xxm@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 25 Jun 2021 14:55:11 +0800, Simon Xue wrote:
> Add a driver for the DesignWare-based PCIe controller found on
> RK356X. The existing pcie-rockchip-host driver is only used for
> the Rockchip-designed IP found on RK3399.

Applied to pci/dwc, thanks!

[1/1] PCI: rockchip-dwc: Add Rockchip RK356X host controller driver
      https://git.kernel.org/lpieralisi/pci/c/e1229e884e

Thanks,
Lorenzo
