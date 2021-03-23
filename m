Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2076346786
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 19:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhCWSYz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 14:24:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231375AbhCWSYa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Mar 2021 14:24:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC5EB619BF;
        Tue, 23 Mar 2021 18:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616523870;
        bh=2ByQMWPXsAbNM5t8yFCV5DKQH3QIgit6vLww0gdsRmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KXV4pW/sFZRh+mjeGNctALrUSHm53TFGET9WN50ZdHPM6Ya2HaN1fxMgmP1+sx69V
         8JXs2QhkPiaQ/0sCZlEYXOyEbowcGdXfaYu4dEnPIt5L+kSr9owflyL+I1nknLhp1/
         5mvZr9333DaUzmePYKLC2UPYH35eTHUHfiEuBvXpPPnCvK6iryWYzmchrmTZrOw8oV
         4htg+RCw4wVm1sc/+UWvY5fYMVLZEh2zGa8Md8Ln6RvMRv0McdiJBm9cBxuk15mgGr
         lY/JyZ2U9KfzqTH5Uui640TDMXch0en9+ojK80QKTWiNHw7azk6llnT+MQl49+T40f
         SYqePFQRB+4mA==
Date:   Tue, 23 Mar 2021 13:24:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong <linfeilong@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>
Subject: Re: [PATCH] pci: fix memory leak when virtio pci hotplug
Message-ID: <20210323182428.GA584698@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c48998b7-5308-e196-66b5-905fc8c4edc4@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 21, 2021 at 11:29:30PM +0800, Zhiqiang Liu wrote:
> From: Feilong Lin <linfeilong@huawei.com>
> 
> Repeated hot-plugging of pci devices for a virtual
> machine driven by virtio, we found that there is a
> leak in kmalloc-4k, which was confirmed as the memory
> of the pci_device structure. Then we found out that
> it was missing pci_dev_put() after pci_get_slot() in
> enable_slot() of acpiphp_glue.c.
> 
> Signed-off-by: Feilong Lin <linfeilong@huawei.com>
> Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>

Since this came from you, Zhiqiang, it needs a signed-off-by (not just
a reviewed-by) from you.  See
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.11#n361

Also see
https://lore.kernel.org/r/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com
and

  - Wrap commit log to fill 80 columns
  - s/pci/PCI/ (subject and commit log)
  - Run "git log --oneline drivers/pci/hotplug/acpiphp_glue.c".  It's
    not completely consistent, but at least match the style of one of
    them.

There is no "pci_device" structure.  I think you mean the "struct
pci_dev".

The commit log doesn't actually say what the patch does.  It's obvious
from the patch, but it should say in the commit log.  Look at previous
commit logs to see how they do it.

> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 3365c93abf0e..f031302ad401 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -533,6 +533,7 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>  			slot->flags &= ~SLOT_ENABLED;
>  			continue;
>  		}
> +		pci_dev_put(dev);
>  	}
>  }
> 
> -- 
> 2.19.1
> 
> 
