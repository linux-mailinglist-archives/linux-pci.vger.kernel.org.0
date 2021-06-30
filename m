Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614643B88BD
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jun 2021 20:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhF3Sw1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Jun 2021 14:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233046AbhF3SwZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jun 2021 14:52:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09F9361426;
        Wed, 30 Jun 2021 18:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625078996;
        bh=KG5Bqyi3jxIYrNsBw3UY3iU1TyTs0dI1AHQH1CTlP64=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CFRO26B8UzegkPMTQBrMAKRXhkzPFZxRCW3DZesVDQR2m9NbxLWdLHuWRsSDIwyaG
         aE4cOx0n52hYXGBrXbsrIRS0aUEz1ANdHGxl1dtP20+JDKhJI6qgv6uYjABRLIPVCe
         NFttkrr9UheWlTihMLH5ZJexzX1MC1GBE1wNQ3r0djrOxl63MQ7zkGAyBdz2L01FW0
         6BJBL/zBjF4FEQ4/0zuQPu0wpWHHv1JFiXmTbytq5g/6YF5kouXy1fCvkczksZnrp4
         BgyFjavilOZ4wAq9gbQBlcE5yZymxNo/omBtYH74fKk3znEawB7q4db4tqT/qHEF20
         TCM79k+8xTEnA==
Date:   Wed, 30 Jun 2021 13:49:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        rfi@lists.rocketboards.org, Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rockchip: Avoid accessing PCIe registers with
 clocks gated
Message-ID: <20210630184954.GA4169648@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d5a983f-bfdd-d79b-4ec9-357ea26dd2c8@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 29, 2021 at 11:52:44AM +0100, Robin Murphy wrote:

> Well, it does use devm_request_irq() so the handler should be unregistered
> by devres *after* ->remove has finished, however that does still leave a
> potential race window in which a pending IRQ could be taken during the later
> part of rockchip_pcie_remove() after it has started turning off critical
> things. Unless the clocks and regulators can also be delegated to devres, it
> might be more robust to explicitly manage the IRQs as well. Mixing the two
> schemes can be problematic when the exact order of both setup and teardown
> matters.

Thanks for this.  I missed this problem.  We have lots of PCI
controller drivers that use some devm interfaces but use the non-devm
clk_prepare_enable(), and they generally turn things off in their
.remove() methods, which is obviously before any devm unregistration.

Many .suspend() methods turn off clocks and power while leaving the
IRQ handler installed.  Should we get an interrupt from our device
after .suspend()?  *Probably* not, but it makes me a little queasy to
rely on that, or to rely on the assumption that the IRQ is not shared.

Bjorn
