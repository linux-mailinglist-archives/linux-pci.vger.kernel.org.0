Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 433FE9F6D8
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 01:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfH0XZV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 19:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfH0XZV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 19:25:21 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 212D920856;
        Tue, 27 Aug 2019 23:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566948320;
        bh=LjeKtcL+tre8T5+8STXYq7fJxwH9y7GRM/bKzsvNuTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gSNjuAXIFwhvRADXCP9CPSUPjfyvhsFiElfke5de4cJ5F5ouiV/SafluRTPSJ/w/w
         ImTPnLT8hWXiSH2KDim39hKj4lKxmI76wU2WmvL+h06DFMTGtkKm42zivYKanB0S5b
         MrI0mZ8u92wPK+bFMf7TZ2ltweWn4VRDuP52yzy8=
Date:   Tue, 27 Aug 2019 18:25:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Remove the use of printk_ratelimit() in pci.c
Message-ID: <20190827232518.GJ9987@google.com>
References: <20190825224616.8021-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825224616.8021-1-kw@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 26, 2019 at 12:46:16AM +0200, Krzysztof Wilczynski wrote:
> Do not use printk_ratelimit() in drivers/pci/pci.c as it shares the
> rate limiting state with all other callers to the printk_ratelimit().
> 
> Add pci_info_ratelimited macro similar to pci_notice_ratelimited
> added in the commit a88a7b3eb076 ("vfio: Use dev_printk() when
> possible") and use it instead of pr_info inside the if-statement.
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>

Applied to pci/misc for v5.4, thanks!

> ---
>  drivers/pci/pci.c   | 4 ++--
>  include/linux/pci.h | 3 +++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f20a3de57d21..e3d190d003c5 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -890,8 +890,8 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>  
>  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>  	dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> -	if (dev->current_state != state && printk_ratelimit())
> -		pci_info(dev, "Refused to change power state, currently in D%d\n",
> +	if (dev->current_state != state)
> +		pci_info_ratelimited(dev, "Refused to change power state, currently in D%d\n",
>  			 dev->current_state);
>  
>  	/*
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 463486016290..73ce8d908322 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2367,4 +2367,7 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
>  #define pci_notice_ratelimited(pdev, fmt, arg...) \
>  	dev_notice_ratelimited(&(pdev)->dev, fmt, ##arg)
>  
> +#define pci_info_ratelimited(pdev, fmt, arg...) \
> +	dev_info_ratelimited(&(pdev)->dev, fmt, ##arg)
> +
>  #endif /* LINUX_PCI_H */
> -- 
> 2.22.1
> 
