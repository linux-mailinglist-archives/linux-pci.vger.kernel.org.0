Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA7341FD53
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 19:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhJBROP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Oct 2021 13:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhJBROP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Oct 2021 13:14:15 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1A9C0613EC
        for <linux-pci@vger.kernel.org>; Sat,  2 Oct 2021 10:12:29 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id s69so15756642oie.13
        for <linux-pci@vger.kernel.org>; Sat, 02 Oct 2021 10:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aeqJfHb0iLnFHIG5GIxnb4uxBHYoE9DuLz3G0/kwTeI=;
        b=j5q1kmOHxJ+YhfIgHbejrjffpuKubzJ68SlkIeP6Wz4lq8ip0vrht/SU6J4QEjBnwj
         tdIx7cquOcaWrUFEXchj6NxmpU23NyPVg3NEPNSNYJx+stqb9JPUee2/Ob5CCK3IQa5p
         vcD3IRu03Tn69e/7Of+OlA1LVkJiVsxIQyeuKFQMBiuUgukncc/uyz+lUXvFTH2hsQ7n
         FMTZ/P8eJLwcVf/Cw32tBc4abqasPd5X3d0LqZxMfK3dF9nXKwysvHtt0KLHLrxVTwld
         uBGRh7kMhygPSMNv2A6L14snyfGstRgIn0LM9sHRGT0UJqUdtjtO9ZJQYDHACgWu6tFy
         XFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aeqJfHb0iLnFHIG5GIxnb4uxBHYoE9DuLz3G0/kwTeI=;
        b=y7LiJcGP5kOt8uCr2ihYk/V08nx6uwp5AiZZLrK4Xduy8Gec42xrwreAi5ToFO9vu3
         68Cqz6Yzo1krxlMdQy9mRt2hst/OasHvPnf6nJBDsiFT28CULZLqWZXKJ1LZBnFA7//n
         0yxtu2U14sA5UGEnDD1udikwbrCYNXKpEAljqerBcGEHV/OdUy7VR1+mV+f1lZH+Bt/P
         b2F6TvHHE4DMFhqBT0dw6NyEH+08vkI7Rwah/MS5314+Psi2d1gWqI4AOJHgZVX5Zbt1
         nG3SS7IWD9b2Lzp9M6tKx4cemP+65Ng8ikPgFk20Nz2WGAwGrqWmAyvoAsKU4pzsu0WZ
         YfBg==
X-Gm-Message-State: AOAM530Tt5YQdg66saU3NUm4AqVEfWtBj3tiNjQb8RQHyix6rwPbWeXV
        fKBbYKg5P0ELOBr8DRvgeu+wQuAt404PfJh7xoYmh1ft9g0=
X-Google-Smtp-Source: ABdhPJwwCIvY9/wm8fbagZLKMtqVAxIko8hB39gKi/PnC+xQwDVoCKTNsXaYaNs6TtHuYNj8xVoGHy7wEvdJDfMoinU=
X-Received: by 2002:aca:6009:: with SMTP id u9mr1482184oib.71.1633194748448;
 Sat, 02 Oct 2021 10:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHP4M8U-uGwZqqGk5Z9KP7w_hESgTtrAsSrwxFfCiLZOht1uYw@mail.gmail.com>
 <20211002155508.GA968974@bhelgaas>
In-Reply-To: <20211002155508.GA968974@bhelgaas>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sat, 2 Oct 2021 22:42:16 +0530
Message-ID: <CAHP4M8XszWK6eGEPvvAV0E3mJWhZZdZMb4CmUsQg6jRdoABWjw@mail.gmail.com>
Subject: Re: None of the virtual/physical/bus address matches the (base) BAR-0 register
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Bjorn, that certainly helped.
Especially, it is nice to see that ptr->resource[0].start does give e2c20000 :)

Also, idiotic of me of making newbie kernel-format-specifier mistakes :-|

So, now the outputs corresponding to

    printk("Base virtual-address = [%lx]\n", bar0_ptr);
    printk("Base physical-address (form-1) = [%lx]\n", dev->resource[0].start);
    printk("Base bus-address = [%lx]\n", pci_bus_address(dev, 0));
    printk("BAR 0: %pR\n", &dev->resource[0]);


are :

    Base virtual-address = [ffffa0c6c02eb000]
    Base physical-address (form-1) = [e2c20000]
    Base bus-address = [e2c20000]
    BAR 0: [mem 0xe2c20000-0xe2c201ff]


All as expected.
Plus, all the lower 12 bits are now same everywhere (due to the 4 KB
page-size alignment in x86, right)?



My major missing understanding regarding this, is that we use the
iowrite*/ioread* functions, using bar0_ptr as the
base-(virtual-)address.
Thus, bar0_ptr *is* very well the kernel-virtual-address, which maps
to some physical-address (hopefully e2c20000), which directly triggers
the write/read with the pci-device.

Right now, the physical-address (form-1) we have printed, is via the
data-structure field.
However, looking from the virtual-address <=> physical-address
translation from the usual memory write/read datapath's perspective, I
am still not able to coalesce things.


In the same run as above, if I add the following statements :

    printk("Base physical-address (form-2) = [%lx]\n", virt_to_phys(bar0_ptr));
    printk("Base physical-address (form-3) = [%lx]\n",
virt_to_phys(*((uint32_t*)bar0_ptr)));
    printk("Base physical-address (form-4) = [%lx]\n",
virt_to_phys(*((uint64_t*)bar0_ptr)));

I get :

    Base physical-address (form-2) = [12e6002eb000]
    Base physical-address (form-3) = [721f4000001e]
    Base physical-address (form-4) = [721f4000001e]


Looking at the function-doc for virt_to_phys(), it states :

########################################################
* This function does not give bus mappings for DMA transfers. In
* almost all conceivable cases a device driver should not be using
* this function
########################################################



So, two queries :

1)
Does the above comment apply here too (in MMIO case)?

2)
If yes, then what is the datapath followed for our case (since
conventional virtual-address <=> physical-address translations via MMU
/ TLB / page-tables is out of the picture I guess)?


Thanks a ton already to everyone, in helping me clearing out my mind.


Thanks and Regards,
Ajay
