Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7801DD826
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 22:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgEUUUq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 16:20:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgEUUUq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 16:20:46 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C620820814;
        Thu, 21 May 2020 20:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590092446;
        bh=jJs/r1WZjzmyF7nOQs5Rqkg4BZulAY2Tn/6zVACwqIE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Jt0/FvmfOZGKcQ82VDMIX2rMx38fd/Gw1PZuOFOiu4A285kq3GfsuBkr218Lv4lVx
         N8kVzY2Z7cFwxZj0axl5Uof7CIAaZEHgZKlaPa1G5fMgu9HfkiYPM9tahduQ2IUN8Z
         uJCrWL7Q9lB5/Wzj/a6kjqbONlJctC9XMVqNVkh8=
Date:   Thu, 21 May 2020 15:20:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: shpchp: Remove surplus variable and ineffectual
 error check
Message-ID: <20200521202044.GA1174339@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200521190457.1066600-1-kw@linux.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 21, 2020 at 07:04:57PM +0000, Krzysztof Wilczynski wrote:
> Function remove_board() calls shpchp_unconfigure_device() and checks its
> return code for a possible error which is unnecessary as
> shpchp_unconfigure_device() always returns 0.
> 
> Also, remove surplus variable that has not been used for anything.  This
> will also address the following Coccinelle warning:
> 
>   drivers/pci/hotplug/shpchp_pci.c:66:5-7: Unneeded variable: "rc".
>   Return "0" on line 86
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>

Applied to pci/hotplug for v5.8, thanks!

> ---
>  drivers/pci/hotplug/shpchp.h      | 2 +-
>  drivers/pci/hotplug/shpchp_ctrl.c | 3 +--
>  drivers/pci/hotplug/shpchp_pci.c  | 5 +----
>  3 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
> index f7f13ee5d06e..6e85885b554c 100644
> --- a/drivers/pci/hotplug/shpchp.h
> +++ b/drivers/pci/hotplug/shpchp.h
> @@ -164,7 +164,7 @@ u8 shpchp_handle_switch_change(u8 hp_slot, struct controller *ctrl);
>  u8 shpchp_handle_presence_change(u8 hp_slot, struct controller *ctrl);
>  u8 shpchp_handle_power_fault(u8 hp_slot, struct controller *ctrl);
>  int shpchp_configure_device(struct slot *p_slot);
> -int shpchp_unconfigure_device(struct slot *p_slot);
> +void shpchp_unconfigure_device(struct slot *p_slot);
>  void cleanup_slots(struct controller *ctrl);
>  void shpchp_queue_pushbutton_work(struct work_struct *work);
>  int shpc_init(struct controller *ctrl, struct pci_dev *pdev);
> diff --git a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
> index 078003dcde5b..afdc52d1cae7 100644
> --- a/drivers/pci/hotplug/shpchp_ctrl.c
> +++ b/drivers/pci/hotplug/shpchp_ctrl.c
> @@ -341,8 +341,7 @@ static int remove_board(struct slot *p_slot)
>  	u8 hp_slot;
>  	int rc;
>  
> -	if (shpchp_unconfigure_device(p_slot))
> -		return(1);
> +	shpchp_unconfigure_device(p_slot);
>  
>  	hp_slot = p_slot->device - ctrl->slot_device_offset;
>  	p_slot = shpchp_find_slot(ctrl, hp_slot + ctrl->slot_device_offset);
> diff --git a/drivers/pci/hotplug/shpchp_pci.c b/drivers/pci/hotplug/shpchp_pci.c
> index 115701301487..36db0c3c4ea6 100644
> --- a/drivers/pci/hotplug/shpchp_pci.c
> +++ b/drivers/pci/hotplug/shpchp_pci.c
> @@ -61,9 +61,8 @@ int shpchp_configure_device(struct slot *p_slot)
>  	return ret;
>  }
>  
> -int shpchp_unconfigure_device(struct slot *p_slot)
> +void shpchp_unconfigure_device(struct slot *p_slot)
>  {
> -	int rc = 0;
>  	struct pci_bus *parent = p_slot->ctrl->pci_dev->subordinate;
>  	struct pci_dev *dev, *temp;
>  	struct controller *ctrl = p_slot->ctrl;
> @@ -83,6 +82,4 @@ int shpchp_unconfigure_device(struct slot *p_slot)
>  	}
>  
>  	pci_unlock_rescan_remove();
> -	return rc;
>  }
> -
> -- 
> 2.26.2
> 
