Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5D2E1070C
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 12:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfEAKkF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 06:40:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57756 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfEAKkF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 May 2019 06:40:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A01EE80D;
        Wed,  1 May 2019 03:40:04 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76D6F3F719;
        Wed,  1 May 2019 03:40:02 -0700 (PDT)
Date:   Wed, 1 May 2019 11:39:56 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/11] i.MX6, DesignWare PCI improvements
Message-ID: <20190501103956.GA3100@e121166-lin.cambridge.arm.com>
References: <20190415004632.5907-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415004632.5907-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 14, 2019 at 05:46:21PM -0700, Andrey Smirnov wrote:
> Everyone:
> 
> This is the series containing various small improvements that I made
> while reading the code and researching commit history of pci-imx6.c
> and pcie-designware*.c files. All changes are optional, so commits
> that don't seem like an improvement can be easily dropped. Hopefully
> each patch is self-explanatory.
> 
> I tested this series on i.MX6Q, i.MX7D and i.MX8MQ.

Applied with Lucas' tags to pci/imx, hopefully we can squeeze this
in for the v5.2 merge window.

Lorenzo

> Feedback is welcome!
> 
> Thanks,
> Andrey Smirnov
> 
> Chagnes since [v3]:
> 
>     - Collected Reviewed-by from Lucas for most of the patches
> 
>     - Converted "PCI: imx6: Replace calls to udelay() with
>       usleep_range()" to "PCI: imx6: Use usleep_range() in
>       imx6_pcie_enable_ref_clk()"
>       
>     - Converted "PCI: imx6: Remove redundant debug tracing" to "PCI:
>       imx6: Drop imx6_pcie_wait_for_link()"
>       
>     - Converted all of the callers of pcie_phy_poll_ack() to use
>       true/false in "PCI: imx6: Simplify pcie_phy_poll_ack()"
> 
> Changes since [v2]:
> 
>     - All non i.MX6 patches dropped, since they were accepted as a
>       seprarte series
>       
>     - Series rebased on latest 'dwc-pci' branch of PCI tree
>     
>     - Patches "PCI: imx6: Use flags to indicate support for suspend"
>       and "PCI: imx6: Replace calls to udelay() with usleep_range()"
>       added to the series
> 
> Changes since [v1]:
> 
>   - Dropped "PCI: imx6: Drop imx6_pcie_link_up()" due to the matter
>     already having been addressed by "PCI: imx6: Fix link training
>     status detection in link up check" from Trent Piepho
> 
>   - Changed "designware" -> "dwc" for all subject lines
> 
>   - Collected Acked-by's from Gustavo Pimentel
> 
> [v3] lkml.kernel.org/r/20190401042547.14067-1-andrew.smirnov@gmail.com
> [v2] lkml.kernel.org/r/20190104174925.17153-1-andrew.smirnov@gmail.com
> [v1] lkml.kernel.org/r/20181221072716.29017-1-andrew.smirnov@gmail.com
> 
> Andrey Smirnov (11):
>   PCI: imx6: Simplify imx7d_pcie_wait_for_phy_pll_lock()
>   PCI: imx6: Drop imx6_pcie_wait_for_link()
>   PCI: imx6: Return -ETIMEOUT from imx6_pcie_wait_for_speed_change()
>   PCI: imx6: Remove PCIE_PL_PFLR_* constants
>   PCI: dwc: imx6: Share PHY debug register definitions
>   PCI: imx6: Make use of BIT() in constant definitions
>   PCI: imx6: Simplify bit operations in PHY functions
>   PCI: imx6: Simplify pcie_phy_poll_ack()
>   PCI: imx6: Restrict PHY register data to 16-bit
>   PCI: imx6: Use flags to indicate support for suspend
>   PCI: imx6: Use usleep_range() in imx6_pcie_enable_ref_clk()
> 
>  drivers/pci/controller/dwc/pci-imx6.c        | 143 ++++++++-----------
>  drivers/pci/controller/dwc/pcie-designware.c |  12 +-
>  drivers/pci/controller/dwc/pcie-designware.h |   3 +
>  3 files changed, 62 insertions(+), 96 deletions(-)
> 
> -- 
> 2.20.1
> 
