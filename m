Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401CD3AE957
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 14:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhFUMqm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 08:46:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229765AbhFUMqk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jun 2021 08:46:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 840966101D;
        Mon, 21 Jun 2021 12:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624279466;
        bh=XxT7ILbl7JNxu7sXKVtub2T7m1zs0ZPFGq+yWL+FVo4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=m/yyXi/jjpqluqaUBmOfEY/50Z0OmcAuE+d4PxsEYb2d3/7s5SMhPkFlA5jeLp7CQ
         NimxK9u8S05tIU+5e7S7wvzUhSygt3CGF/aPyyvuO7kgzvdpEqwpYNW++J3bYlvuWz
         I7AcquLhMv7xp4Bz/E0eeL5MepYOphI34ZhefrNiL5+XvkjjaGK/aUcaGHI0Psfvyg
         EvwvENxfnnDBI7jBJy5LVLs+gAXrcxmCP82aRJzOIGSfWE5c22/USQrhHiZP5P53BS
         XMH0SuiEhuqIuHxcYS7lyjLlRPuUtGQIuq5MJsfdyWHeNuc5EQ88cWWBc+z05agk9l
         Lak14lcYosQWw==
Date:   Mon, 21 Jun 2021 07:44:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: New Defects reported by Coverity Scan for Linux
Message-ID: <20210621124420.GA3287195@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60d0439a1c15c_16db9f2ab48dcf79b875634@prd-scan-dashboard-0.mail>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

FYI.  Looks like we rely directy on the result of a read from the
device to index an array, probably not a great idea.

On Mon, Jun 21, 2021 at 07:45:30AM +0000, scan-admin@coverity.com wrote:
> Hi,
> 
> Please find the latest report on new defect(s) introduced to Linux found with Coverity Scan.
> 
> 7 new defect(s) introduced to Linux found with Coverity Scan.
> 4 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.


> ** CID 1475616:  Memory - illegal accesses  (OVERRUN)
> /drivers/pci/controller/dwc/pcie-tegra194.c: 994 in tegra_pcie_dw_start_link()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 1475616:  Memory - illegal accesses  (OVERRUN)
> /drivers/pci/controller/dwc/pcie-tegra194.c: 994 in tegra_pcie_dw_start_link()
> 988     		retry = false;
> 989     		goto retry_link;
> 990     	}
> 991     
> 992     	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
> 993     		PCI_EXP_LNKSTA_CLS;
> >>>     CID 1475616:  Memory - illegal accesses  (OVERRUN)
> >>>     Overrunning array "pcie_gen_freq" of 4 4-byte elements at element index 4294967295 (byte offset 17179869183) using index "speed - 1U" (which evaluates to 4294967295).
> 994     	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> 995     
> 996     	tegra_pcie_enable_interrupts(pp);
> 997     
> 998     	return 0;
> 999     }
> 
> ** CID 1475402:  Memory - illegal accesses  (OVERRUN)
> /drivers/pci/controller/dwc/pcie-tegra194.c: 457 in tegra_pcie_ep_irq_thread()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 1475402:  Memory - illegal accesses  (OVERRUN)
> /drivers/pci/controller/dwc/pcie-tegra194.c: 457 in tegra_pcie_ep_irq_thread()
> 451     	struct tegra_pcie_dw *pcie = arg;
> 452     	struct dw_pcie *pci = &pcie->pci;
> 453     	u32 val, speed;
> 454     
> 455     	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
> 456     		PCI_EXP_LNKSTA_CLS;
> >>>     CID 1475402:  Memory - illegal accesses  (OVERRUN)
> >>>     Overrunning array "pcie_gen_freq" of 4 4-byte elements at element index 4294967295 (byte offset 17179869183) using index "speed - 1U" (which evaluates to 4294967295).
> 457     	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> 458     
> 459     	/* If EP doesn't advertise L1SS, just return */
> 460     	val = dw_pcie_readl_dbi(pci, pcie->cfg_link_cap_l1sub);
> 461     	if (!(val & (PCI_L1SS_CAP_ASPM_L1_1 | PCI_L1SS_CAP_ASPM_L1_2)))
> 462     		return IRQ_HANDLED;
