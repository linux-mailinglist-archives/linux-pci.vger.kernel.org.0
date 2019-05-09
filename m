Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B4418F96
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 19:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfEIRtV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 13:49:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38362 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfEIRtU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 13:49:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id a59so1496394pla.5;
        Thu, 09 May 2019 10:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xGNclB3X4zp+TTPFI7JduJSlyKXyeMQXRwODcYbvWDE=;
        b=IoD45aM0LJOyM3f/3ASR5vZeOg/rb/POXAq5u+jOo8ovy4hzE7SPXnSRhTMoL21dpJ
         Ygex/67fx3Y9W1X2Hu6FLi8Z5GQY0Pd3i2YoON7RhKaw/vZcirt+oeX92L4eLrPwqA83
         wMURjlG6AvHtzS7PT7+YDBZIr0NeWIuxTicCEvLxF2I3R0hyIDE3/xjOp4T0ffDuUu+Z
         uI7DZ9KYIr82UZuWR1fBisYQURkY39ZEN4bWEnwiBPnoCnjLL97d0Pxz3F3n5xMRFoT0
         uEzdo1Foyi0Mv/PVV5k2+JgekMlGydJhb7QLXs93pLPjwPhc2VWLQypdDUBj4Yca5bBs
         29oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xGNclB3X4zp+TTPFI7JduJSlyKXyeMQXRwODcYbvWDE=;
        b=so1vf06NuJlX943U4ncH3GyPvGbwM5wdaZju4NEebL+L+0v0LeITTkdF0Nk79GLAXF
         GwV6kJmztI5s6CTAsTEUMgtjID8wx6YxNvL9iEKijO5zgGUEXRIYDSG51AkKm5kt8ZRo
         HCj394DMc8ME2b1BmJJV7ZPlmW7se3XvMUvnVdXJ+RNjQIoQjjCT/EhnoYUnDaHbS0Zo
         xYNFab8v1eMpRyPLPb3MbvOdb8wXFvDLyDnf97iArvO9eoQtSu4my+jyZPUdg7JvaygX
         3mblQppzOcggy3euTj3awoAQRyhH4qz0ze0NEWL1S4cztdQWNHYK6KaPnMYo82M3yuAC
         J8Zg==
X-Gm-Message-State: APjAAAWxEM37ZT6MT6e7PN4Nhba3h1UF59nez0/GFeWFancy5P3kTD3Y
        Az7N/+SeL8yY7Hm0w8NQNHl8OQtLWVvJNoQawKo=
X-Google-Smtp-Source: APXvYqyy2yBnIkSugLtMCw3gCEWa4fuULEZiSXDEDQlFwBQjm3MPLyj9xEy327TMz96GSIxiypKwPP4cN7CYBrmpFcY=
X-Received: by 2002:a17:902:aa45:: with SMTP id c5mr6857755plr.144.1557424159804;
 Thu, 09 May 2019 10:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190509141456.223614-1-helgaas@kernel.org>
In-Reply-To: <20190509141456.223614-1-helgaas@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 May 2019 20:49:08 +0300
Message-ID: <CAHp75VdrQgu3Tis1V1j1AgjS=Uvw-7tz5ke4kSxRWM=0DrSjhw@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] PCI: Log with pci_dev, not pcie_device
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 9, 2019 at 5:18 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> This is a collection of updates to Fred's v2 patches from:
>
>   https://lore.kernel.org/lkml/20190503035946.23608-1-fred@fredlawl.com
>
> and some follow-on discussion.
>

For non-commented patches,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

For the commented ones, I hope you will address them, and then my tag
applies for them as well.

> Bjorn Helgaas (3):
>   PCI: pciehp: Remove pciehp_debug uses
>   PCI: pciehp: Remove pointless PCIE_MODULE_NAME definition
>   PCI: pciehp: Remove pointless MY_NAME definition
>
> Frederick Lawler (7):
>   PCI/AER: Replace dev_printk(KERN_DEBUG) with dev_info()
>   PCI/PME: Replace dev_printk(KERN_DEBUG) with dev_info()
>   PCI/DPC: Log messages with pci_dev, not pcie_device
>   PCI/AER: Log messages with pci_dev, not pcie_device
>   PCI: pciehp: Replace pciehp_debug module param with dyndbg
>   PCI: pciehp: Log messages with pci_dev, not pcie_device
>   PCI: pciehp: Remove unused dbg/err/info/warn() wrappers
>
>  drivers/pci/hotplug/pciehp.h      | 31 +++++++-------------------
>  drivers/pci/hotplug/pciehp_core.c | 18 +++++++--------
>  drivers/pci/hotplug/pciehp_ctrl.c |  2 ++
>  drivers/pci/hotplug/pciehp_hpc.c  | 17 +++++++-------
>  drivers/pci/hotplug/pciehp_pci.c  |  2 ++
>  drivers/pci/pcie/aer.c            | 32 ++++++++++++++------------
>  drivers/pci/pcie/aer_inject.c     | 22 +++++++++---------
>  drivers/pci/pcie/dpc.c            | 37 +++++++++++++++----------------
>  drivers/pci/pcie/pme.c            | 10 +++++----
>  9 files changed, 82 insertions(+), 89 deletions(-)
>
> --
> 2.21.0.1020.gf2820cf01a-goog
>


-- 
With Best Regards,
Andy Shevchenko
