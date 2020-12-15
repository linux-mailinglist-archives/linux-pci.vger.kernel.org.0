Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205A42DADF5
	for <lists+linux-pci@lfdr.de>; Tue, 15 Dec 2020 14:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgLON0E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Dec 2020 08:26:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:38510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgLONZ5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Dec 2020 08:25:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 32F96AC7F;
        Tue, 15 Dec 2020 13:25:11 +0000 (UTC)
Date:   Tue, 15 Dec 2020 14:25:04 +0100
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: dwc: tegra194: issue with card containing a bridge
Message-ID: <20201215132504.GA20914@suse.de>
References: <20201215102442.GA20517@suse.de>
 <9a8abc90-cf18-b0c8-3bcb-efbe03f0ca4c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a8abc90-cf18-b0c8-3bcb-efbe03f0ca4c@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 15, 2020 at 05:45:59PM +0530, Vidya Sagar wrote:
> Thanks Mian for bringing it to our notice.
> Have you tried removing the dw_pcie_setup_rc(pp); call from pcie-tegra194.c
> file on top of linux-next? and does that solve the issue?
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c
> b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 5597b2a49598..1c9e9c054592 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -907,7 +907,7 @@ static void tegra_pcie_prepare_host(struct pcie_port
> *pp)
>                 dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF,
> val);
>         }
> 
> -       dw_pcie_setup_rc(pp);
> +       //dw_pcie_setup_rc(pp);
I still see the same issue with this change.
Reverting b9ac0f9dc8ea works though.
> 
>         clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
> 
> I took a quick look at the dw_pcie_setup_rc() implementation and I'm not
> sure why calling it second time should create any issue for the enumeration
> of devices behind a switch. Perhaps I need to spend more time to debug that
> part.
> In any case, since dw_pcie_setup_rc() is already part of
> dw_pcie_host_init(), I think it can be removed from
> tegra_pcie_prepare_host() implemention.
> 
> Thanks,
> Vidya Sagar
> 
BR,
Yousaf
