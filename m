Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911B73F368A
	for <lists+linux-pci@lfdr.de>; Sat, 21 Aug 2021 00:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhHTWkw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 18:40:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230527AbhHTWkw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 18:40:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62D496103D;
        Fri, 20 Aug 2021 22:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629499213;
        bh=CiA4Isj34k4IUERg8A9SrOPmO4Q9Q9dmA82ZxVRjHBc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YRueHQnNHigghL4PyL/uuKgjEuIfe5rl/7TAhxQ3lI6tVeoMmiz97h/z7pHnUa2sM
         0yCxOquYappGYi9eAX341uafMJ/Gfa6jnAVVt8phlJeO0OeNE4mBR/tRnnM+IauQhv
         8llDNb8wSU1rrfqRBy2NMbkjoXAGdx4lI4kjZ91XdFnkLMXeJujE21Q4Qfk7gAMtvB
         fS6TI5PJCTQFVrSK1Pd0wvkZbwyYIkpNlNT834ctUAFfk0vGEH3sGf5X3hvkNALMp+
         nIUkA1xTFaW4XC1KJPnnXjGI0gH5q4S/WMyHmx2em+gCyYbeTe9m6TEsljBnD4VV93
         2514N7GJs6fvQ==
Date:   Fri, 20 Aug 2021 17:40:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] PCI: Sync __pci_register_driver() stub for
 CONFIG_PCI=n
Message-ID: <20210820224012.GA3367853@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813153619.89574-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 13, 2021 at 06:36:19PM +0300, Andy Shevchenko wrote:
> The CONFIG_PCI=y case got a new parameter long time ago.
> Sync the stub as well.
> 
> Fixes: 725522b5453d ("PCI: add the sysfs driver name to all modules")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to pci/misc for v5.15, thanks!

> ---
>  include/linux/pci.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 540b377ca8f6..1ef4ee6a8b2e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1740,8 +1740,9 @@ static inline void pci_disable_device(struct pci_dev *dev) { }
>  static inline int pcim_enable_device(struct pci_dev *pdev) { return -EIO; }
>  static inline int pci_assign_resource(struct pci_dev *dev, int i)
>  { return -EBUSY; }
> -static inline int __pci_register_driver(struct pci_driver *drv,
> -					struct module *owner)
> +static inline int __must_check __pci_register_driver(struct pci_driver *,
> +						     struct module *,
> +						     const char *mod_name)
>  { return 0; }
>  static inline int pci_register_driver(struct pci_driver *drv)
>  { return 0; }
> -- 
> 2.30.2
> 
