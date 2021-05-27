Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0805B393910
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 01:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbhE0XWr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 19:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236566AbhE0XWq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 19:22:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E33E9613BA;
        Thu, 27 May 2021 23:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622157673;
        bh=xKOLa4l9kmHRL2WiIp92+f9BNRy1NDTCGQ6vic1oMBE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pW6PSt2OQNKXCzqPkQhv9ElhrxdWNKkO+bmLQcsvYQ36AinxdfaVdQw2EXBEuwNRB
         Z4qKWe1KraHi3asRlKuEmH3jI3iPtyIUOCiaO9P9vio80Y7Nah9x6yZdg8TP2EGKa+
         NbWQw5zrxw7Ugs2yedJUYSOZaSzFVWIevrtJ6qPuwyeihL40pY4+ShBNtoF1aUh2Wo
         LnNK81Mv20G0lBDJH1LD34ZPSVMNxouESVagAdGnS08OHv1/UBd0cbA8uFzEwRfiys
         xITvOK0zyAim95E41RsLjTiQWrNY5m6zG+/kYIc/qAZYZb6UafgzWmTIX/hKHZDDd9
         QDZucdFFBUKTQ==
Date:   Thu, 27 May 2021 18:21:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, kw@linux.com,
        linuxarm@huawei.com, prime.zeng@huawei.com
Subject: Re: [PATCH v2] PCI/AER: Use consistent format when printing PCI
 device
Message-ID: <20210527232106.GA1443093@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1617015721-51701-1-git-send-email-yangyicong@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 29, 2021 at 07:02:01PM +0800, Yicong Yang wrote:
> We use format domain:bus:slot.function when printing
> PCI device. Use consistent format in AER messages.
> 
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Applied to pci/error for v5.14, thanks!

I also dropped the "AER recover:" prefixes, since pr_fmt() already gives
us an "AER:" prefix.

> ---
> Change since v1:
> - address comments from Krzysztof
> Link: https://lore.kernel.org/linux-pci/1616752057-9720-1-git-send-email-yangyicong@hisilicon.com/
> 
>  drivers/pci/pcie/aer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ba22388..f7f0ca5 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -983,7 +983,7 @@ static void aer_recover_work_func(struct work_struct *work)
>  		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
>  						   entry.devfn);
>  		if (!pdev) {
> -			pr_err("AER recover: Can not find pci_dev for %04x:%02x:%02x:%x\n",
> +			pr_err("AER recover: Can not find pci_dev for %04x:%02x:%02x.%x\n",
>  			       entry.domain, entry.bus,
>  			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
>  			continue;
> @@ -1022,7 +1022,7 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>  				 &aer_recover_ring_lock))
>  		schedule_work(&aer_recover_work);
>  	else
> -		pr_err("AER recover: Buffer overflow when recovering AER for %04x:%02x:%02x:%x\n",
> +		pr_err("AER recover: Buffer overflow when recovering AER for %04x:%02x:%02x.%x\n",
>  		       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
>  }
>  EXPORT_SYMBOL_GPL(aer_recover_queue);
> --
> 2.8.1
> 
