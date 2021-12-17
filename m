Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D70479628
	for <lists+linux-pci@lfdr.de>; Fri, 17 Dec 2021 22:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhLQVYB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Dec 2021 16:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLQVYA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Dec 2021 16:24:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D6CC061574;
        Fri, 17 Dec 2021 13:24:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3209B623B9;
        Fri, 17 Dec 2021 21:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6B3C36AE2;
        Fri, 17 Dec 2021 21:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639776239;
        bh=FegU7gpP54YJI4EcwtDIK1kWEJABjQxJYefEwl7RJOA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KdiwAVqZrv6nGatfJeenJqMr3xa7q86KFW1Pgp5Nho1KlfaVrPANI/SH/tn5wkUrY
         u4tpByMnlBOSTBu17Ua1GsrGPRP0rgoLm6AGpkat3Emf2Y3cKOJ5ezgt5luOMOrd2l
         LDghkgNPKGI6GmP+IjkruQ6kJiuKxt1U8y1qhaayspIl297p3R5tYR8wAqHjwfWe7V
         uHHAKR5+k3euu/hPy5mxa2Auxk0WlmxQQDCmTKnkEgbWIFbqmtyJtUlAf5vglbfkmv
         F9ruDUeJxzfjbZqGjUl/bh4V4k1WZfc26fsD5yNRvSM9N5Xlm4iDIvm2+49riqJO1j
         vfziFQV94Am9g==
Date:   Fri, 17 Dec 2021 15:23:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH resend] PCI: Make the pci_dev_present() stub a static
 inline
Message-ID: <20211217212356.GA915467@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217141515.379586-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 17, 2021 at 03:15:15PM +0100, Hans de Goede wrote:
> Change the pci_dev_present() stub which is used when CONFIG_PCI is not set
> from a #define to a static inline stub.
> 
> Thix should fix clang -Werror builds failing due to errors like this:
> 
> drivers/platform/x86/thinkpad_acpi.c:4475:35:
>  error: unused variable 'fwbug_cards_ids' [-Werror,-Wunused-const-variable]
> 
> Where fwbug_cards_ids is an array if pci_device_id-s passed to
> pci_dev_present() during a quirk check.
> 
> Fixing this in include/linux/pci.h should ensure that the same issue is
> also fixed in any other drivers hitting the same -Werror issue.
> 
> Cc: platform-driver-x86@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to pci/enumeration for v5.17, thanks!

> ---
>  include/linux/pci.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 18a75c8e615c..7d825637d7ca 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1775,7 +1775,10 @@ static inline struct pci_dev *pci_get_class(unsigned int class,
>  					    struct pci_dev *from)
>  { return NULL; }
>  
> -#define pci_dev_present(ids)	(0)
> +
> +static inline int pci_dev_present(const struct pci_device_id *ids)
> +{ return 0; }
> +
>  #define no_pci_devices()	(1)
>  #define pci_dev_put(dev)	do { } while (0)
>  
> -- 
> 2.33.1
> 
