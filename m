Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685DD21BEEC
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 23:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgGJVCi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 17:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbgGJVCh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jul 2020 17:02:37 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E13242068F;
        Fri, 10 Jul 2020 21:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594414957;
        bh=emx1sglaxvbuaaDGJ8kfEmduh65sGevNr80tLfeX4KU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LCa5VdeGS2XOBNYoEvHWSyOxfdtzvkwWEPk4rsPb4nTbbyS0Q5RkWlRp0NOe4kOQ1
         afoSzsYVCqrMr6dOMaWbJeUsiUtzEsEdpD2F/7L7KtWTpwLbNPLoi2ix64Nhor3rKK
         pLWrkiDVoQEQOtzGWVOB3LZSmG3KWcQbswyX4Qf8=
Date:   Fri, 10 Jul 2020 16:02:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     wu000273@umn.edu
Cc:     kjlu@umn.edu, Bjorn Helgaas <bhelgaas@google.com>,
        Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Alex Chiang <achiang@hp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix reference count leak in pci_create_slot
Message-ID: <20200710210235.GA79952@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528021322.1984-1-wu000273@umn.edu>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 27, 2020 at 09:13:22PM -0500, wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
> 
> kobject_init_and_add() takes reference even when it fails.
> If this function returns an error, kobject_put() must be called to
> properly clean up the memory associated with the object. Thus,
> when call of kobject_init_and_add() fail, we should call kobject_put()
> instead of kfree(). Previous commit "b8eb718348b8" fixed a similar problem.

Looks like you are also checking other kobject_init_and_add() callers?
I see some similar messages on linux-kernel.  Thanks for doing that!

I looked at the first dozen or so callers and the following look
broken and I don't see patches for them (yet):

  cache_add_dev()
  sq_dev_add
  blk_integrity_add
  acpi_expose_nondev_subnodes
  rnbd_clt_add_dev_kobj

> Fixes: 5fe6cc60680d ("PCI: prevent duplicate slot names")

I'm not sure this is correct.  5fe6cc60680d didn't *add* a
kobject_init_and_add() call; it was there before.  And even before
5fe6cc60680d there was no kobject_put() in the error path.  Am I
missing something?

For now, I applied this to pci/hotplug for v5.9.  I'll update the
commit log to add the Fixes tag if necessary.

> Signed-off-by: Qiushi Wu <wu000273@umn.edu>
> ---
>  drivers/pci/slot.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index cc386ef2fa12..3861505741e6 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -268,13 +268,16 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  	slot_name = make_slot_name(name);
>  	if (!slot_name) {
>  		err = -ENOMEM;
> +		kfree(slot);
>  		goto err;
>  	}
>  
>  	err = kobject_init_and_add(&slot->kobj, &pci_slot_ktype, NULL,
>  				   "%s", slot_name);
> -	if (err)
> +	if (err) {
> +		kobject_put(&slot->kobj);
>  		goto err;
> +	}
>  
>  	INIT_LIST_HEAD(&slot->list);
>  	list_add(&slot->list, &parent->slots);
> @@ -293,7 +296,6 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  	mutex_unlock(&pci_slot_mutex);
>  	return slot;
>  err:
> -	kfree(slot);
>  	slot = ERR_PTR(err);
>  	goto out;
>  }
> -- 
> 2.17.1
> 
