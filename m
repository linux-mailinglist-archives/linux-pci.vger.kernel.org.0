Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C262542FB73
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 20:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241808AbhJOSxu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 14:53:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241681AbhJOSxt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Oct 2021 14:53:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 857D160F56;
        Fri, 15 Oct 2021 18:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634323902;
        bh=TQmj55y7eunqvNATXkqXYrIJmoAAD05XhzrJljA7J5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=We7LgKd2Hk9dPOpOXVmJG9arRaMlkYVsvIYXVH0l1WFgiwlNXweMoN2eK3GL+LkpU
         YnVHEjZLHZaIyxxI/ApMDJVs/i4AwGX/WSeQXy2wLkmcBODqMV4lPDV4RMpWabfX69
         dQeHEONicd3cvjFExiccCMnGDZOB2TebHHJ3uWrq0hjuHs8EpuTNOoAQps6IeGnkgz
         44aCKt4Sa/9i+TmyB7eKeCrrxLJZcK76+zk64Vmm4ziJIE+Pcvo6dqeIc4hD2cYrQC
         on1YYbIpYynQihZLb2YnnFYIcNvRbNOcgEknDI2Y5ayYX7Ji73Dq5rv7OYXlHPDEaV
         V+xWrAK0nTDmQ==
Date:   Fri, 15 Oct 2021 13:51:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [RESEND v2 4/5] PCI: imx6: Fix the clock reference handling
 unbalance when link never came up
Message-ID: <20211015185141.GA2139462@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015184943.GA2139079@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 15, 2021 at 01:49:45PM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 15, 2021 at 02:05:40PM +0800, Richard Zhu wrote:
> > When link never came up, driver probe would be failed with error -110.
> > To keep usage counter balance of the clocks, disable the previous
> > enabled clocks when link is down.
> > Move definitions of the imx6_pcie_clk_disable() function to the proper
> > place. Because it wouldn't be used in imx6_pcie_suspend_noirq() only.

> > -static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
> > -{
> > -	clk_disable_unprepare(imx6_pcie->pcie);
> > -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> > -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> > -
> > -	switch (imx6_pcie->drvdata->variant) {
> > -	case IMX6SX:
> > -		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> > -		break;
> > -	case IMX7D:
> > -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> > -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> > -		break;
> > -	case IMX8MQ:
> > -		clk_disable_unprepare(imx6_pcie->pcie_aux);
> > -		break;
> > -	default:
> > -		break;

While you're at it, this "default: break;" thing is pointless.
Normally it's better to just *move* something without changing it at
all, but this is such a simple thing I think you could drop this at
the same time as the move.

> > -	}
> > -}
