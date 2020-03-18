Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 196FD18A8E8
	for <lists+linux-pci@lfdr.de>; Thu, 19 Mar 2020 00:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCRXGI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 19:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgCRXGH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Mar 2020 19:06:07 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 060812076C;
        Wed, 18 Mar 2020 23:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584572767;
        bh=PPmT01aJTlHOD4RNyzydirhhaBcueEvetEJiDH2EKvM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HrFy95uDjWSmf53OD5YQXLPXtjD+nZLCkv1/jcmolzBmKKCfbvOeF6+nttFAKA+qO
         uLDJgReknmeU6sDg7UHWU0zRno5kaTNN4RXgTcjboc2JJfpDhteVel6qnbKvoJXrJ7
         n1dYCIRXRJ6FCQLlfAEZuOKPDktoKDElU8/Pn0Xg=
Date:   Wed, 18 Mar 2020 18:06:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, rajatja@google.com, linuxarm@huawei.com
Subject: Re: [PATCH v2] PCI/ASPM: Fix wrong field set when config L1SS
Message-ID: <20200318230605.GA1704@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584093227-1292-1-git-send-email-yangyicong@hisilicon.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 13, 2020 at 05:53:47PM +0800, Yicong Yang wrote:
> We enable proper L1 substates in the end of pcie_config_aspm_l1ss(). It's
> PCI_L1SS_CTL1_L1SS_MASK field should we set in PCI_L1SS_CTL1 register
> rather than PCI_L1SS_CAP_L1_PM_SS.
> 
> Fixes: aeda9adebab8 ("PCI/ASPM: Configure L1 substate settings")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Applied to pci/aspm for v5.7, thanks!

I also added a stable tag for v4.11+.

> ---
> change since v1:
> 1. Add fixes tag in the commit message
> 2. change category to ASPM from PM in the subject
> Link: https://lore.kernel.org/linux-pci/20200312194202.GA162085@google.com/
> 
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
