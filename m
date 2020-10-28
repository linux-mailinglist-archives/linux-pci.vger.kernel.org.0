Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789F829DB27
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 00:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbgJ1Xnw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 19:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389612AbgJ1WvW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 18:51:22 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CD3C0613CF;
        Wed, 28 Oct 2020 15:51:21 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w25so1219723edx.2;
        Wed, 28 Oct 2020 15:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9nvUcWbLCYzP8icVZr09w080lWJ1d3JwvhqvzFXlS88=;
        b=Ub5PcH6bmuPUiToAtOG8mBCdmg6ZwtsCWGz3IaGkjVR4sH9NEqa6PkWeR5A0CQNBSh
         3d0bT4egjdhlkvJWexgeTQvgx+TBaYydBnQDNjZne7ZCSyO1J51X+iLeCK6gv5esOWmJ
         JUETbOcUMKtz7ebHTxiek/PvZAXvSBKTYfPK3RltbqUcrfsqsBdc7BX4ESvph9Zoy2NW
         oATYYx6k9FPJbqvYMMXe5Uq11KpM1CHuSYiUqcPuCh6+VVFKASXnguYRIWFgdfJAKPU/
         A0YQEpB7sRwLNUYKO9xviPdWAzXm8IDsSV7ekiVif/RMjMOvmxideHvaM6f9a1bGvzNN
         iv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9nvUcWbLCYzP8icVZr09w080lWJ1d3JwvhqvzFXlS88=;
        b=sxY3lkAq0R8tY5FiqdPg3sdW9el0IYlDcO1jhFJRgfTaK5vGniz03wvIfWVkyG2YNH
         tv0wPsMOwUtQ6brd1NMrXr9PPQHzH2Dvkc5X2PEvB2iKTzIfdjjH2AtbL+gSDC+TYWiV
         OmG4D8jJFoOUMcOkmxouLaBO1MMiZRQRICByjPOhKHeL7KtufIzqjKBEhXtoTUFAlufP
         GCBU5782tP1AxbR4aqa61tDr2+DMo8dESEAzQnIalUmdfzySMJq8WkvNy4KJrZpKAvVN
         6DmQ472TqFWlj0P8tG281ciV7PgWWw2mnOrlLAQ3p17npBSDNjhlrYVZzqgIn9y0DGrf
         6DJw==
X-Gm-Message-State: AOAM531WJyIm1dBp9fT36dx0qrAbvZg72ZwK8jgAU3aES0eRMLi7xcTW
        GMh0gDMSsoCryXVO0caqe/+828W8sfEPYYXYKpRR8+Xw+NA=
X-Google-Smtp-Source: ABdhPJxNPdgGc7ZcQuVCgQ7/NFrXUSX/CSfqPrZC++S8LAM7joaA2Yh9jyR/HPJlGeTlq01aDye8wBjf4JK46CCrq28=
X-Received: by 2002:aa7:cb92:: with SMTP id r18mr6339211edt.13.1603865370008;
 Tue, 27 Oct 2020 23:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com> <fcbe8a624166a1101a755edfef44a185d32ff493.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <fcbe8a624166a1101a755edfef44a185d32ff493.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Wed, 28 Oct 2020 14:09:18 +0800
Message-ID: <CAKF3qh1j1GAOxK8QAwAgPpn3wxtvZgp8QJQ2zjcv5B=jEVG_eg@mail.gmail.com>
Subject: Re: [PATCH v11 1/5] PCI: Conditionally initialize host bridge
 native_* members
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>, knsathya@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 27, 2020 at 10:00 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> If CONFIG_PCIEPORTBUS is not enabled in kernel then initialing
> struct pci_host_bridge PCIe specific native_* members to "1" is
> incorrect. So protect the PCIe specific member initialization
> with CONFIG_PCIEPORTBUS.
>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/probe.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4289030b0fff..756fa60ca708 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -588,12 +588,14 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>          * may implement its own AER handling and use _OSC to prevent the
>          * OS from interfering.
>          */
> +#ifdef CONFIG_PCIEPORTBUS
>         bridge->native_aer = 1;
>         bridge->native_pcie_hotplug = 1;
> -       bridge->native_shpc_hotplug = 1;
>         bridge->native_pme = 1;
> -       bridge->native_ltr = 1;
>         bridge->native_dpc = 1;
> +#endif
  If CONFIG_PCIEPORTBUS wasn't defined, leave them to "unknown" value ?

> +       bridge->native_ltr = 1;
> +       bridge->native_shpc_hotplug = 1;
>
>         device_initialize(&bridge->dev);
>  }
> --
> 2.17.1
>
