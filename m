Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A921E3454F5
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 02:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhCWBY4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 21:24:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231569AbhCWBYo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Mar 2021 21:24:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 917C461934;
        Tue, 23 Mar 2021 01:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616462682;
        bh=EoBN4W8jvfpgQpUiF4qeqHSUMWuVaP/vkiyeVe8OrcU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oITALvP94gugPGD651TSoMU9ZT+C6s7/z3V7eEEvHJVif1U4nNfPwIl98YX6LC5Gb
         Sjc/lGg89KkYXllxsObRlxKaAbhozN6xI65U0ZO1evxGeydfnx+c3yuNqSxlKat122
         pRMixEZ4fWN0S/gcxYpRr6o7s5RdDbuwZllx5n2/pIqFJwATcugypivBje51xzpaTJ
         zlkJHIXMmMFjKzM2Xgcc/QnJeAvwf0bTYV0CULiS7+N0c8g9bG5VAyLRZtwRQyJnd7
         Hmi7rfrwfc0wz6vPu5uLpM2R7sbbPjIOqG8a2VCylRorJGVC3ehqcnmtQNPm65/qLx
         n5uwmG8Z5WSfQ==
Date:   Mon, 22 Mar 2021 20:24:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: Re: [PATCH RESEND] PCI: dwc: Fix MSI not work after resume
Message-ID: <20210323012441.GA515937@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301111031.220a38b8@xhacker.debian>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Kishon, Richard, Lucas, Dilip]

On Mon, Mar 01, 2021 at 11:10:31AM +0800, Jisheng Zhang wrote:
> After we move dw_pcie_msi_init() into core -- dw_pcie_host_init(), the
> MSI stops working after resume. Because dw_pcie_host_init() is only
> called once during probe. To fix this issue, we move dw_pcie_msi_init()
> to dw_pcie_setup_rc().

This patch looks fine, but I don't think the commit log tells the
whole story.

Prior to 59fbab1ae40e, it looks like the only dwc-based drivers with
resume functions were dra7xx, imx6, intel-gw, and tegra [1].

Only tegra called dw_pcie_msi_init() in the resume path, and I do
think 59fbab1ae40e broke MSI after resume because it removed the
dw_pcie_msi_init() call from tegra_pcie_enable_msi_interrupts().

I'm not convinced this patch fixes it reliably, though.  The call
chain looks like this:

  tegra_pcie_dw_resume_noirq
    tegra_pcie_dw_start_link
      if (dw_pcie_wait_for_link(pci))
        dw_pcie_setup_rc

dw_pcie_wait_for_link() returns 0 if the link is up, so we only call
dw_pcie_setup_rc() in the case where the link *didn't* come up.  If
the link comes up nicely without retry, we won't call
dw_pcie_setup_rc() and hence won't call dw_pcie_msi_init().

Since then, exynos added a resume function.  My guess is MSI never
worked after resume for dra7xx, exynos, imx6, and intel-gw because
they don't call dw_pcie_msi_init() in their resume functions.

This patch looks like it should fix MSI after resume for exynos, imx6,
and intel-gw because they *do* call dw_pcie_setup_rc() from their
resume functions [2], and after this patch, dw_pcie_msi_init() will be
called from there.

I suspect MSI after resume still doesn't work on dra7xx.

[1] git grep -A20 -e "static.*resume_noirq" 59fbab1ae40e^:drivers/pci/controller/dwc
[2] git grep -A20 -e "static.*resume_noirq" drivers/pci/controller/dwc

> Fixes: 59fbab1ae40e ("PCI: dwc: Move dw_pcie_msi_init() into core")
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
> Since v1:
>  - collect Reviewed-by tag
> 
>  drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 7e55b2b66182..e6c274f4485c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -400,7 +400,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	}
>  
>  	dw_pcie_setup_rc(pp);
> -	dw_pcie_msi_init(pp);
>  
>  	if (!dw_pcie_link_up(pci) && pci->ops && pci->ops->start_link) {
>  		ret = pci->ops->start_link(pci);
> @@ -551,6 +550,8 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  		}
>  	}
>  
> +	dw_pcie_msi_init(pp);
> +
>  	/* Setup RC BARs */
>  	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0x00000004);
>  	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
> -- 
> 2.30.1
> 
