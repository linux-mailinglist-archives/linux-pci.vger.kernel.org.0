Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A1F38F5A9
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 00:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhEXWcm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 18:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhEXWcl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 May 2021 18:32:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 148BA61400;
        Mon, 24 May 2021 22:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621895472;
        bh=BgaJ6bBhVMSkPpMM7ztBqXvDF9jcSK5FB4nnN1qd4Yo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AgHsVEFBenklmyX1hvqgZjknjAn7LHOxyMuGLVu9LNmAYDAtNUj9iKdnYmzFLuiDw
         Q85vCAkBIAjFjk0VVo8CDUcTKGq04HyBtZwESvE+TrueP/hR0x7H4CRb9SHUQ1Imrj
         XNrVu9bgAYXShzr/ANMuBCyYck8YKrEJVAkoB3zmPaWIDvH1vbWcS09kBrL3gOouhP
         nq+5qZLUV/4qYb348My/vhdzv9IYZOsOSiiC+nwavxEUEfAQc8y7qht5WMs8BgTy5+
         NDiyRLebtUYPsqnNFFT0EaG3MQPi2R17goboHHtzfyhEx1XjpqlS5AykKG4l4Luy6H
         S340JNQNSaX4g==
Date:   Mon, 24 May 2021 17:31:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Raphael Norwitz <raphael.norwitz@nutanix.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ameynarkhede03@gmail.com" <ameynarkhede03@gmail.com>
Subject: Re: [PATCH v2] PCI: merge slot and bus reset implementations
Message-ID: <20210524223110.GA1127348@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408182328.12323-1-raphael.norwitz@nutanix.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 08, 2021 at 06:23:40PM +0000, Raphael Norwitz wrote:
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

I dropped this exposure in pci.h because there's no user yet.  We can
expose it when we add the user.

> Link: https://lkml.org/lkml/2021/3/23/911
>
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

Applied to pci/reset for v5.14 with subject
"PCI: Add pci_reset_bus_function() Secondary Bus Reset interface"

I attached the patch as applied.

> ---
>  drivers/pci/pci.c   | 19 +++++++++++--------
>  include/linux/pci.h |  1 +
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 16a17215f633..a8f8dd588d15 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4982,6 +4982,15 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
>  }
>  
> +int pci_reset_bus_function(struct pci_dev *dev, int probe)
> +{
> +	int rc = pci_dev_reset_slot_function(dev, probe);
> +
> +	if (rc != -ENOTTY)
> +		return rc;
> +	return pci_parent_bus_reset(dev, probe);
> +}
> +
>  static void pci_dev_lock(struct pci_dev *dev)
>  {
>  	pci_cfg_access_lock(dev);
> @@ -5102,10 +5111,7 @@ int __pci_reset_function_locked(struct pci_dev *dev)
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
> @@ -5135,13 +5141,10 @@ int pci_probe_reset_function(struct pci_dev *dev)
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

commit 0dad3ce523c2 ("PCI: Add pci_reset_bus_function() Secondary Bus Reset interface")
Author: Raphael Norwitz <raphael.norwitz@nutanix.com>
Date:   Thu Apr 8 18:23:40 2021 +0000

    PCI: Add pci_reset_bus_function() Secondary Bus Reset interface
    
    pci_parent_bus_reset() resets a device by performing a Secondary Bus Reset
    on a PCI-to-PCI bridge leading to the device.
    
    pci_dev_reset_slot_function() does the same, except that it uses a hotplug
    driver to keep the reset from looking like a hot-remove followed by a
    hot-add.
    
    Add a pci_reset_bus_function() wrapper, which attempts the hotplug driver
    slot reset and falls back to the parent bus reset if that fails.  This
    provides a single interface for performing a Secondary Bus Reset.
    
    [bhelgaas: commit log, don't expose yet]
    Suggested-by: Alex Williamson <alex.williamson@redhat.com>
    Link: https://lore.kernel.org/r/20210323100625.0021a943@omen.home.shazbot.org/
    Link: https://lore.kernel.org/r/20210408182328.12323-1-raphael.norwitz@nutanix.com
    Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
    Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b717680377a9..452351025a09 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5020,6 +5020,16 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
 	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
 }
 
+static int pci_reset_bus_function(struct pci_dev *dev, int probe)
+{
+	int rc;
+
+	rc = pci_dev_reset_slot_function(dev, probe);
+	if (rc != -ENOTTY)
+		return rc;
+	return pci_parent_bus_reset(dev, probe);
+}
+
 static void pci_dev_lock(struct pci_dev *dev)
 {
 	pci_cfg_access_lock(dev);
@@ -5140,10 +5150,7 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 	rc = pci_pm_reset(dev, 0);
 	if (rc != -ENOTTY)
 		return rc;
-	rc = pci_dev_reset_slot_function(dev, 0);
-	if (rc != -ENOTTY)
-		return rc;
-	return pci_parent_bus_reset(dev, 0);
+	return pci_reset_bus_function(dev, 0);
 }
 EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
 
@@ -5173,13 +5180,10 @@ int pci_probe_reset_function(struct pci_dev *dev)
 	if (rc != -ENOTTY)
 		return rc;
 	rc = pci_pm_reset(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_dev_reset_slot_function(dev, 1);
 	if (rc != -ENOTTY)
 		return rc;
 
-	return pci_parent_bus_reset(dev, 1);
+	return pci_reset_bus_function(dev, 1);
 }
 
 /**
