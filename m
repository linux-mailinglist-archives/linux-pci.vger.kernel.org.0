Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF66358984
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 18:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhDHQUG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 12:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231655AbhDHQUE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Apr 2021 12:20:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68C606100C;
        Thu,  8 Apr 2021 16:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617898792;
        bh=sQcy0UO9owIHSBc5AspToFAZP3AR67cYTVh7M3uYlHI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=C/SZY5ervrnUCW/cQ4uaCBHcxEEAQivAP2SNZaPCdbnvsiFZifMz8plLVA3O1M3pk
         GCTZ6hubYiNtNQml/8s+MZCnoJfe611w4ADmO/6jXMkHY8nJ7h+WbYxDOxPJmtQR2p
         PaHMLdKKejBeVEWhuKd35yK1QQZATUuxToJ069ZAmcHMhTLWs6Fr2X+k1zVUZdMVW0
         GG/wMNOX5HQKg3+YvWbI4jTFdYNWbc+0DPoI3w9GeFbzGsCj+c4A0UdsCfoqML+S+q
         zIX49zQBY9CWeH9w9ebBBsMAh44R2k7dxde8OK7GoiFiE040+PKX4hxTzenAAGUZoy
         XP69yEpfHg33w==
Date:   Thu, 8 Apr 2021 11:19:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linfeilong <linfeilong@huawei.com>
Subject: Re: [PATCH v2] ACPI / hotplug / PCI: fix memory leak in enable_slot()
Message-ID: <20210408161951.GA1934960@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b411af88-5049-a1c6-83ac-d104a1f429be@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 25, 2021 at 03:26:00PM +0800, Zhiqiang Liu wrote:
> From: Feilong Lin <linfeilong@huawei.com>
> 
> In enable_slot() in drivers/pci/hotplug/acpiphp_glue.c, if pci_get_slot()
> will return NULL, we will do not set SLOT_ENABLED flag of slot. if one
> device is found by calling pci_get_slot(), its reference count will be
> increased. In this case, we did not call pci_dev_put() to decrement the
> its reference count, the memory of the device (struct pci_dev type) will
> leak.
> 
> Fix it by calling pci_dev_put() to decrement its reference count after that
> pci_get_slot() returns a PCI device.
> 
> Signed-off-by: Feilong Lin <linfeilong@huawei.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>

Applied with Rafael's reviewed-by to pci/hotplug for v5.13, thanks!

> --
> v2: rewrite subject and commit log as suggested by Bjorn Helgaas.
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
