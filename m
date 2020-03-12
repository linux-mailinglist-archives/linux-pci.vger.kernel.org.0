Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D42D1839B6
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 20:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgCLTmF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 15:42:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgCLTmF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 15:42:05 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 847AE206E2;
        Thu, 12 Mar 2020 19:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584042124;
        bh=SsQ1VWBuLvBlgfQ4NuKd3UTf275rkS5XNI1edWPIUR4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=T4gAEcRpMuT/Z5vjr+/cUShk6sWt6Wb3V8Jgmg0ixKEYzMIUTvs2w9qnRYDHJuUNd
         6+FrrMGJN5cxfpQK8ppHJ7ESsVZ4eRcLgGzmbuD83o1hk15RXVuCTIpZ31XYDgGRB6
         azWbtUzRStfL6zSN5RTdC5MXY23VrBXxuIkrF5fY=
Date:   Thu, 12 Mar 2020 14:42:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, rajatja@google.com,
        f.fangjian@huawei.com, huangdaode@huawei.com
Subject: Re: [PATCH] PCI/PM: Fix wrong field set when config L1SS
Message-ID: <20200312194202.GA162085@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584012191-34129-1-git-send-email-yangyicong@hisilicon.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 12, 2020 at 07:23:11PM +0800, Yicong Yang wrote:
> We enable proper L1 substates in the end of pcie_config_aspm_l1ss(). It's
> PCI_L1SS_CTL1_L1SS_MASK field should we set in PCI_L1SS_CTL1 register
> rather than PCI_L1SS_CAP_L1_PM_SS.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Would you mind digging up the commit that broke this and including it
in the log message?  Then we can see if this fix should go to stable
and, if so, how far back.

> ---
>  drivers/pci/pcie/aspm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 0dcd443..c2596e7 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -747,9 +747,9 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>  
>  	/* Enable what we need to enable */
>  	pci_clear_and_set_dword(parent, up_cap_ptr + PCI_L1SS_CTL1,
> -				PCI_L1SS_CAP_L1_PM_SS, val);
> +				PCI_L1SS_CTL1_L1SS_MASK, val);
>  	pci_clear_and_set_dword(child, dw_cap_ptr + PCI_L1SS_CTL1,
> -				PCI_L1SS_CAP_L1_PM_SS, val);
> +				PCI_L1SS_CTL1_L1SS_MASK, val);
>  }
>  
>  static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
> -- 
> 2.8.1
> 
