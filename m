Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82CF7BAE3D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2019 09:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393218AbfIWHBI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Sep 2019 03:01:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36553 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393152AbfIWHBI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Sep 2019 03:01:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id 67so11192732oto.3;
        Mon, 23 Sep 2019 00:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k0ciB42LtE34aFYb/BfsS5z0gsc3kbG/3hxU2od2OKY=;
        b=jwz5PqNNXzDzcqCcaZdHjy5b6mrL7pb2CQbBehfiCiq9B7oDRCIdMWXk/8+Xjghe5I
         e72XgrX1uKi6M8ceote1WDrDn4tkRnKZANFyhL47L7fxHSuX4bqS1OgIcDONEQOPlrMD
         HjWYveQa0JNaMOreYsAwGHDVTFnq92mnGsAWe6B278Y0w3dJhM0N0t8NhI4LnoyVpWdP
         mRl39d/rd8kFi0lMW5oltfAKeWcep/QF7gTOoTDJjRlK02yqrAf8eBXNyHvC8IUep6CX
         Xw8jessKIcdYNHtkazzFxm11LUPGzekI0JEi8nw3Jqji3mPeBR/8wUKMJ/5CbWjAOIAq
         ynRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k0ciB42LtE34aFYb/BfsS5z0gsc3kbG/3hxU2od2OKY=;
        b=BTHZiXa3LvjLEbPw/gI83nIGJ5tdLBJNbFLvq/tSMRt11+W7rPTSJkk/DPH7fBwb7n
         zsx6b7ujyILWFKTwo7Kd6axrtmhnK82UlSjxRjY3q79pH7cD3lDVLNzrdZtkN+qtI/hL
         BXHAbOZcTSdhtJ0afFZO1ikkp99JIYGFaXmDJw2Oqo2TzM2i19MpxebwK0bpTlPLZz5S
         4Zi3DuymcqzGTXdktuBGEsr3ZbV1GuHo676PzNKCgmFPsdhyRRtfGWFblTNI4NpsTasr
         j037C8Eq/yOMZgBD3wd3t+Rp9xO1wBX97dRZB0bavS66Ze0kdEjRxZQX3JX6fkCG5UWl
         tTwA==
X-Gm-Message-State: APjAAAWzJO2hwXyJOwrU/Lz6h/ABsMTxUTUy4XAMU+QjYYM6v/3L8bYH
        iOI4/C7DLkp5VN8uQT+k9TY+L5lxGMjugibUeRs=
X-Google-Smtp-Source: APXvYqy1s6wsFFsF//C3eQHgH4V8voSHAlYMm+lI/ZsJaDUiWjHPhLz9P8CVpMNFsWxxmU00XF2Yjgk1+OCGCn7CIdQ=
X-Received: by 2002:a9d:5c09:: with SMTP id o9mr19636957otk.298.1569222067728;
 Mon, 23 Sep 2019 00:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <1567438203-8405-1-git-send-email-sundeep.lkml@gmail.com>
In-Reply-To: <1567438203-8405-1-git-send-email-sundeep.lkml@gmail.com>
From:   sundeep subbaraya <sundeep.lkml@gmail.com>
Date:   Mon, 23 Sep 2019 12:30:56 +0530
Message-ID: <CALHRZurHCLY-F0b--jk3QvHmHAGEDH0oaVEszigJz-s5MSW94A@mail.gmail.com>
Subject: Re: [PATCH] PCI: Do not use bus number zero from EA capability
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Stalley, Sean" <sean.stalley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     sgoutham@marvell.com, Subbaraya Sundeep <sbhatta@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Please let me know if you have any comments on the patch.

Thanks,
Sundeep

On Mon, Sep 2, 2019 at 9:00 PM <sundeep.lkml@gmail.com> wrote:
>
> From: Subbaraya Sundeep <sbhatta@marvell.com>
>
> As per the spec, "Enhanced Allocation (EA) for Memory
> and I/O Resources" ECN, approved 23 October 2014,
> sec 6.9.1.2, fixed bus numbers of a bridge can be zero
> when no function that uses EA is located behind it.
> Hence assign bus numbers sequentially when fixed bus
> numbers are zero.
>
> Fixes: 2dbce590117981196fe355efc0569bc6f949ae9b
>
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
>  drivers/pci/probe.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a3c7338..c06ca4c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1095,27 +1095,28 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>   * @sub: updated with subordinate bus number from EA
>   *
>   * If @dev is a bridge with EA capability, update @sec and @sub with
> - * fixed bus numbers from the capability and return true.  Otherwise,
> - * return false.
> + * fixed bus numbers from the capability. Otherwise @sec and @sub
> + * will be zeroed.
>   */
> -static bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
> +static void pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
>  {
>         int ea, offset;
>         u32 dw;
>
> +       *sec = *sub = 0;
> +
>         if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
> -               return false;
> +               return;
>
>         /* find PCI EA capability in list */
>         ea = pci_find_capability(dev, PCI_CAP_ID_EA);
>         if (!ea)
> -               return false;
> +               return;
>
>         offset = ea + PCI_EA_FIRST_ENT;
>         pci_read_config_dword(dev, offset, &dw);
>         *sec =  dw & PCI_EA_SEC_BUS_MASK;
>         *sub = (dw & PCI_EA_SUB_BUS_MASK) >> PCI_EA_SUB_BUS_SHIFT;
> -       return true;
>  }
>
>  /*
> @@ -1151,7 +1152,6 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>         u16 bctl;
>         u8 primary, secondary, subordinate;
>         int broken = 0;
> -       bool fixed_buses;
>         u8 fixed_sec, fixed_sub;
>         int next_busnr;
>
> @@ -1254,11 +1254,12 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>                 pci_write_config_word(dev, PCI_STATUS, 0xffff);
>
>                 /* Read bus numbers from EA Capability (if present) */
> -               fixed_buses = pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
> -               if (fixed_buses)
> +               pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
> +
> +               next_busnr = max + 1;
> +               /* Use secondary bus number in EA */
> +               if (fixed_sec)
>                         next_busnr = fixed_sec;
> -               else
> -                       next_busnr = max + 1;
>
>                 /*
>                  * Prevent assigning a bus number that already exists.
> @@ -1336,7 +1337,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>                  * If fixed subordinate bus number exists from EA
>                  * capability then use it.
>                  */
> -               if (fixed_buses)
> +               if (fixed_sub)
>                         max = fixed_sub;
>                 pci_bus_update_busn_res_end(child, max);
>                 pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
> --
> 2.7.4
>
