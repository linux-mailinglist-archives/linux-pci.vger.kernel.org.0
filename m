Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1255B2E219E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Dec 2020 21:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgLWUjD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Dec 2020 15:39:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728941AbgLWUjD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Dec 2020 15:39:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71680224B2;
        Wed, 23 Dec 2020 20:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608755902;
        bh=Rry62Bs5KnI+jRK13Lj/HY3xNzvPcT6WuC5Ha51ZJIk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IWRrs5Rx9bUpQbdZGqZuan1m5RyFe47jb7HjsDlKwynd64FBGKd6hm7Qmue7KyWCe
         AC9R3e7H6NIHNuwy90qVE6WNaO8uuTpP7q3Wx1Jk6VbyNEbDQV9eCbBrz2taC5lLQt
         0TeP21cn1pUeF4ti3rgUptl02rYWThZsIR/4JnnTlbTSbaq9ErevFZAkBo8fxKrEjN
         Cdrqe3QZthGHosL9G3EW1yS2nexcebBM2pmkDmaK+H7XQEJDXxTvbUJHRLRNcTCeTS
         Fz/r7G83rkhQoB5S/Yz6q7yAK0SBRybehd4f+hy9c/GOyX8R11rbXqLjmq3J4UwEOD
         HwgIldGmfTAOQ==
Date:   Wed, 23 Dec 2020 14:38:21 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shradha Todi <shradha.t@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        pankaj.dubey@samsung.com
Subject: Re: [PATCH] PCI: dwc: Change size to u64 for EP outbound iATU
Message-ID: <20201223203821.GA320232@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608305648-31816-1-git-send-email-shradha.t@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 18, 2020 at 09:04:08PM +0530, Shradha Todi wrote:
> Since outbound iATU permits size to be greater than
> 4GB for which the support is also available, allow
> EP function to send u64 size instead of truncating
> to u32.

Please wrap your commit messages so they use more of an 80-column
window.  I use "set textwidth=75" for vim to account for git log
indenting by 4 characters.

I know 80 isn't a magic width, but it's the convention in drivers/pci.

This also affects other patches from you, e.g., "PCI: dwc: Add upper
limit address for outbound iATU".

> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  drivers/pci/controller/dwc/pcie-designware.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 7eba3b2..6298212 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -325,7 +325,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
>  
>  void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
>  				  int type, u64 cpu_addr, u64 pci_addr,
> -				  u32 size)
> +				  u64 size)
>  {
>  	__dw_pcie_prog_outbound_atu(pci, func_no, index, type,
>  				    cpu_addr, pci_addr, size);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 28b72fb..bb33f28 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -307,7 +307,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
>  			       u64 size);
>  void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
>  				  int type, u64 cpu_addr, u64 pci_addr,
> -				  u32 size);
> +				  u64 size);
>  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
>  			     int bar, u64 cpu_addr,
>  			     enum dw_pcie_as_type as_type);
> -- 
> 2.7.4
> 
