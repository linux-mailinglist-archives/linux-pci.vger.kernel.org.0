Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D30337A25F
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 10:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhEKInr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 04:43:47 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:45644 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhEKInj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 04:43:39 -0400
Received: by mail-vs1-f50.google.com with SMTP id x188so4225007vsx.12;
        Tue, 11 May 2021 01:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yzRdx62Sq3AaDnhd51+rCUJyJIfzNZKgNx2jthkjD/E=;
        b=UmzsMKflBIc0YxXMZLC4EpFQPhAbEb6MOQ0fP5lK/n5NvPeqgRETZ0Vji7njkaI8Pr
         v3JIfJcBPiLOXLdT7CITzCpxVGvGyUUY4lvtD6tplcNp9tY1ocI0hcZyuLCpVXX3JmdM
         hgDpSJw6ltlajJ2iYIJX8mbtBiWZ2v+ihtWr/bbJkyZ9WzyIrpFweNuwPiSLyiWb6jB6
         tio0JhRBLbKj33+ErYtJPDfAqqEuAL95wLyBCSyYR2gjMFmPgXMSYqtgmn1Pe7JbiQ40
         sn4G2HvkDJRxJQEyEEPfn6aS1T9Jj9iyCsziWBknvkbAmAF03bj2YW7pY62q9nsvrnZw
         JLpQ==
X-Gm-Message-State: AOAM533lZVGZqGkhGkqG5E2EKagCZE7/hRWdWX87dqg3gI/75wR0v/Js
        XEG1gRyBDzy3EqDq0tXP1QAtjf/RZfwWx3yY2L4=
X-Google-Smtp-Source: ABdhPJxidzMgN+SIFQ8O4Pmyfgrc3FjU9fVcUqfJeBTcd/MTQvdGjLXfxIWnE3wqGu11LDO+cBZsOZvFeZQ6Fc7RGVA=
X-Received: by 2002:a67:8745:: with SMTP id j66mr24922894vsd.18.1620722552807;
 Tue, 11 May 2021 01:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617016509.git.gustavo.pimentel@synopsys.com> <daa1efe23850e77d6807dc3f371728fc0b7548b8.1617016509.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <daa1efe23850e77d6807dc3f371728fc0b7548b8.1617016509.git.gustavo.pimentel@synopsys.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 May 2021 10:42:21 +0200
Message-ID: <CAMuHMdWvMpZ35Y-8k1ZOJeD53HyUoWLbzgZa_OMGCq3FOCf19w@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] misc: Add Synopsys DesignWare xData IP driver
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Gustavo,

On Mon, Mar 29, 2021 at 1:19 PM Gustavo Pimentel
<Gustavo.Pimentel@synopsys.com> wrote:
> Add Synopsys DesignWare xData IP driver. This driver enables/disables
> the PCI traffic generator module pertain to the Synopsys DesignWare
> prototype.
>
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Thanks for your patch, which is now commit e8a30eef6ef6da49 ("misc: Add
Synopsys DesignWare xData IP driver") in v5.13-rc1.

> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index f532c59..e6af9ff 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -402,6 +402,16 @@ config SRAM
>  config SRAM_EXEC
>         bool
>
> +config DW_XDATA_PCIE
> +       depends on PCI
> +       tristate "Synopsys DesignWare xData PCIe driver"
> +       help
> +         This driver allows controlling Synopsys DesignWare PCIe traffic
> +         generator IP also known as xData, present in Synopsys DesignWare
> +         PCIe Endpoint prototype.

Hence shouldn't this depend on PCIE_DW_EP, and perhaps be moved to
drivers/pcie/?
Or is that a driver for a different Synopsys DesignWare PCIe Endpoint?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
