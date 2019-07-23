Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6F7072320
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2019 01:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfGWXgy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jul 2019 19:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbfGWXgy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jul 2019 19:36:54 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F58B2184B;
        Tue, 23 Jul 2019 23:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563925013;
        bh=BuegP/V0qI4Z8kyW9R7aYMJWkIoqBWoCJg3WJV3ANEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gEwrrwf7oydOanm0eePwlZFoYfow+Bm7AmlWOdxbHKfMLZE1v6M+hHx5AW70qzZyf
         i3SaBy7lGtnn6tCVBp06LXAuJ2E6k4I6/7N+02PGSqdL6ZU+KOj2KF0079UKfYNPjH
         jR3vUvCApW37szj2/TNaOIGsO9NJInHAFh3bjLmU=
Date:   Tue, 23 Jul 2019 18:36:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Linux-kernel-mentees] [PATCH] PCI: Remove unused
 EXPORT_SYMBOL()s from drivers/pci/bus.c
Message-ID: <20190723233651.GD47047@google.com>
References: <20190717182353.45557-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717182353.45557-1-skunberg.kelsey@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Greg]

On Wed, Jul 17, 2019 at 12:23:53PM -0600, Kelsey Skunberg wrote:
> pci_bus_get() and pci_bus_put() are not used by a loadable kernel module
> and do not need to be exported. Remove lines exporting pci_bus_get() and
> pci_bus_put().
> 
> Functions were exported in commit fe830ef62ac6 ("PCI: Introduce
> pci_bus_{get|put}() to manage PCI bus reference count"). No found history
> of functions being used by a loadable kernel module.
> 
> Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>

Applied with Greg's ack to pci/hide for v5.4, thanks!

> ---
>  drivers/pci/bus.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 495059d923f7..8e40b3e6da77 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -417,11 +417,9 @@ struct pci_bus *pci_bus_get(struct pci_bus *bus)
>  		get_device(&bus->dev);
>  	return bus;
>  }
> -EXPORT_SYMBOL(pci_bus_get);
>  
>  void pci_bus_put(struct pci_bus *bus)
>  {
>  	if (bus)
>  		put_device(&bus->dev);
>  }
> -EXPORT_SYMBOL(pci_bus_put);
> -- 
> 2.20.1
> 
> _______________________________________________
> Linux-kernel-mentees mailing list
> Linux-kernel-mentees@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
