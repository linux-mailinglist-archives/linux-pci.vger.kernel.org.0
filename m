Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 753BAE542A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2019 21:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbfJYTRM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Oct 2019 15:17:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46695 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfJYTRM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Oct 2019 15:17:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id f19so2129407pgn.13;
        Fri, 25 Oct 2019 12:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CQ/0y5Q6U9cve/rqfcOyl2Y7XrZFSX/kWDN3gMk9jY0=;
        b=cDRuooQ7ESXeuKARMwPhRSPK81ZuqJ3KGR+tYRw3ElchzVawLyMafPX5ShC5MbXQut
         PP4CMYeFmn64xJs3hYF5C/zSkOeAs+nvpQPoqf4Yt1f8eeEJVuLO/9lnP1u65h8E1Hku
         6fqXpBKhw/KXPgqOfMd/TbTJIaZv+dtNv/2HJFwxWHsvvFTzMBL7XlcuDnHhONkM50jJ
         oKsiy2cgZRjsvoYb9fBbVvCSJCeWP5cdoAqics6asWLT4QLBqDF2q86UX+YYYAVLJs9u
         CEvKBuQMASnzV3jinpz+/cEAvDQKtKRiUDoQkeaS0oGUD2Lfe4Ox/j5wr51yVIXbh44Q
         zHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CQ/0y5Q6U9cve/rqfcOyl2Y7XrZFSX/kWDN3gMk9jY0=;
        b=NSFUXLIzxsTzG539xksZu9OhX2Z0UxqPZ3PPN/tAOMKCTw4zHk7KQkXYKC4PESwP39
         IO9NhWQda4+IzZieT/3H4ZVj5LwJkTWdemBLUDfVjKIErBIREu7rg22Ncht46SCDpIZO
         YvwZLetomUOHD6d41deMa3K1UjNT/Bx0tAGBlhEhBOzwn7XTpDPVG/Sum0vsjIHlJLKr
         YQD+E4LMM0+dSiO2U2Gu0EvO/JHIkd+MJ4D4Szi86VWgfT4wW8DDm0ctGaec5BK4hAjT
         1wixpS075edw440EiYudGSS7ju3M5ykFxSMG708YulfJ4ldItYHv46Qx2n5cVo7th0Fe
         pFCw==
X-Gm-Message-State: APjAAAXudOIWdn5o3Dzn3uTlQSc0O3/IZkgYIZUnb/5vG9lJZ3kwpEyZ
        NVru7DA41NJ9Kv28rR8nIywZgAxzSjBmLGD70nqCCb9mYalAiQ==
X-Google-Smtp-Source: APXvYqxq23c54bfWmKNY1x+nomIQ+g5QNYTgWlzistI8eYNkLPIZUUyXsKRJxxJKc3UFtzsP6ZCBTOTecnJWtTezXj0=
X-Received: by 2002:a65:5542:: with SMTP id t2mr4116778pgr.74.1572031031301;
 Fri, 25 Oct 2019 12:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191025190047.38130-1-stuart.w.hayes@gmail.com> <20191025190047.38130-3-stuart.w.hayes@gmail.com>
In-Reply-To: <20191025190047.38130-3-stuart.w.hayes@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 25 Oct 2019 22:16:59 +0300
Message-ID: <CAHp75Vd54iDEe0ucTW8Gz9Q6cDGnA88XcBMy9-C5P1QuLzDm0Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] PCI: pciehp: Wait for PDS if in-band presence is disabled
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 25, 2019 at 10:01 PM Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>
> From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>
> When inband presence is disabled, PDS may come up at any time, or not
> at all. PDS being low may indicate that the card is still mating, and
> we could expect contact bounce to bring down the link as well.
>
> It is reasonable to assume that most cards will mate in a hotplug slot
> in about a second. Thus, when we know PDS only reflects out-of-band
> presence, it's worthwhile to wait the extra second or so to make sure
> the card is properly mated before loading the driver, and to prevent
> the hotplug code from disabling a device if the presence detect change
> goes active after the device is enabled.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>


> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> ---
> v2:
>   replace while(true) loop with do...while
> v3
>   remove unused variable declaration (pds)
>   modify text of warning message
> v4
>   remove "!!" boolean conversion from "if" condition for readability
>
>  drivers/pci/hotplug/pciehp_hpc.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index dc109d521f30..02d95ab27a12 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -242,6 +242,22 @@ static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
>         return found;
>  }
>
> +static void pcie_wait_for_presence(struct pci_dev *pdev)
> +{
> +       int timeout = 1250;
> +       u16 slot_status;
> +
> +       do {
> +               pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> +               if (slot_status & PCI_EXP_SLTSTA_PDS)
> +                       return;
> +               msleep(10);
> +               timeout -= 10;
> +       } while (timeout > 0);
> +
> +       pci_info(pdev, "Timeout waiting for Presence Detect state to be set\n");
> +}
> +
>  int pciehp_check_link_status(struct controller *ctrl)
>  {
>         struct pci_dev *pdev = ctrl_dev(ctrl);
> @@ -251,6 +267,9 @@ int pciehp_check_link_status(struct controller *ctrl)
>         if (!pcie_wait_for_link(pdev, true))
>                 return -1;
>
> +       if (ctrl->inband_presence_disabled)
> +               pcie_wait_for_presence(pdev);
> +
>         found = pci_bus_check_dev(ctrl->pcie->port->subordinate,
>                                         PCI_DEVFN(0, 0));
>
> --
> 2.18.1
>


-- 
With Best Regards,
Andy Shevchenko
