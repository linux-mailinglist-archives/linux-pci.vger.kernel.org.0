Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1787D351ECA
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 20:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbhDASrB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 14:47:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238558AbhDASo7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Apr 2021 14:44:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 769D66112D;
        Thu,  1 Apr 2021 12:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617280061;
        bh=6hbeoJ4IU0VAYkOxOutAUGEasgxae6JptOzfhG1Kkfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IKEIEtKNXNCtYYmT5WvsSYESDz2+fglABxfVImzWJebuOYggWp+qEKUuAmnddpoxN
         CFqyOL18PjAK9dpeO7E8cAIVdZ+IJAHRlguVex37xyKPUy2hVzlAhlZf7MEznyHHat
         Iz0ZwzkKf7A6GQCjN4B+jA4DOO93J00hO8M5C1FCS+TJJ3J1JPVw1mxiOx9Gmko9Rm
         O2BZaVrujhcTB3Eqi5BnyymxM6xT0rxZRU5weGSr9end4PIMoT5PY45cblzSgICzpy
         ZQLD0EGUcnn0ZaCH5Uw5TbRzK/zU0peIX8X9WxZ7Lm/8JTY72iHpcccyx5+//3hAUI
         RFIqe9HkabqEQ==
Date:   Thu, 1 Apr 2021 15:27:37 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Raphael Norwitz <raphael.norwitz@nutanix.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ameynarkhede03@gmail.com" <ameynarkhede03@gmail.com>
Subject: Re: [PATCH] PCI: merge slot and bus reset implementations
Message-ID: <YGW8Oe9jn+n9sVsw@unreal>
References: <20210401053656.16065-1-raphael.norwitz@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401053656.16065-1-raphael.norwitz@nutanix.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 01, 2021 at 05:37:16AM +0000, Raphael Norwitz wrote:
> Slot resets are bus resets with additional logic to prevent a device
> from being removed during the reset. Currently slot and bus resets have
> separate implementations in pci.c, complicating higher level logic. As
> discussed on the mailing list, they should be combined into a generic
> function which performs an SBR. This change adds a function,
> pci_reset_bus_function(), which first attempts a slot reset and then
> attempts a bus reset if -ENOTTY is returned, such that there is now a
> single device agnostic function to perform an SBR.
> 
> This new function is also needed to add SBR reset quirks and therefore
> is exposed in pci.h.
> 
> Link: https://lkml.org/lkml/2021/3/23/911
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> ---
>  drivers/pci/pci.c   | 17 +++++++++--------
>  include/linux/pci.h |  1 +
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 16a17215f633..12a91af2ade4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4982,6 +4982,13 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
>  }
>  
> +int pci_reset_bus_function(struct pci_dev *dev, int probe)
> +{
> +	int rc = pci_dev_reset_slot_function(dev, probe);
> +
> +	return (rc == -ENOTTY) ? pci_parent_bus_reset(dev, probe) : rc;

The previous coding style is preferable one in the Linux kernel.
int rc = pci_dev_reset_slot_function(dev, probe);
if (rc != -ENOTTY)
  return rc;
return pci_parent_bus_reset(dev, probe);


> +}
> +
>  static void pci_dev_lock(struct pci_dev *dev)
>  {
>  	pci_cfg_access_lock(dev);
> @@ -5102,10 +5109,7 @@ int __pci_reset_function_locked(struct pci_dev *dev)
>  	rc = pci_pm_reset(dev, 0);
>  	if (rc != -ENOTTY)
>  		return rc;
> -	rc = pci_dev_reset_slot_function(dev, 0);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	return pci_parent_bus_reset(dev, 0);
> +	return pci_reset_bus_function(dev, 0);
>  }
>  EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
>  
> @@ -5135,13 +5139,10 @@ int pci_probe_reset_function(struct pci_dev *dev)
>  	if (rc != -ENOTTY)
>  		return rc;
>  	rc = pci_pm_reset(dev, 1);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	rc = pci_dev_reset_slot_function(dev, 1);
>  	if (rc != -ENOTTY)
>  		return rc;
>  
> -	return pci_parent_bus_reset(dev, 1);
> +	return pci_reset_bus_function(dev, 1);
>  }
>  
>  /**
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 86c799c97b77..979d54335ac1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1228,6 +1228,7 @@ int pci_probe_reset_bus(struct pci_bus *bus);
>  int pci_reset_bus(struct pci_dev *dev);
>  void pci_reset_secondary_bus(struct pci_dev *dev);
>  void pcibios_reset_secondary_bus(struct pci_dev *dev);
> +int pci_reset_bus_function(struct pci_dev *dev, int probe);
>  void pci_update_resource(struct pci_dev *dev, int resno);
>  int __must_check pci_assign_resource(struct pci_dev *dev, int i);
>  int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
> -- 
> 2.20.1
