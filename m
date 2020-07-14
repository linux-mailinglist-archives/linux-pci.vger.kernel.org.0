Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC2F21FD15
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 21:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgGNTRW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 15:17:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbgGNTRW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jul 2020 15:17:22 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C2B72242C;
        Tue, 14 Jul 2020 19:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594754241;
        bh=E0hKewDf88ReD7MuKJ71LDnFAb0M+7fkM+P2qpud1Pw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JAXrGtakLz8B0J+mxhFRzEsLpmQBrm6CJkeqeifD3TZHm4gOstQ10WWdvhEdNyvzJ
         6JZfCVQ+lP3FwW2aFYTV04gdNH76gPSu9JtqSvOP7lk+nFx+SOQl3AyGWbrJD1hx/S
         4I0cQ/WEs3gu+W0yVm5rVaAltoQEN5i1VNG7oRx4=
Date:   Tue, 14 Jul 2020 14:17:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     =?utf-8?B?0KDRg9GB0LvQsNC9INCY0YHQsNC10LI=?= <ubijca16@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: ibmphp: Remove unused functions
 get_max_adapter_speed(), and get_bus_name() in ibmphp_core.c
Message-ID: <20200714191720.GA410320@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b9310fa-f030-b82c-1440-fe2a3a39e21d@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 14, 2020 at 01:16:04PM +0300, Руслан Исаев wrote:
> These functions are commented out and because of that, are unused.

Thanks for the patch.  That driver is pretty much dead, but I'll
certainly take patches that remove dead code.  But it has a few
problems to fix first.

Run "git log --oneline drivers/pci/hotplug/ibmphp_core.c" and make
your subject line match.

See other patch hints here: https://lore.kernel.org/r/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com

Doesn't apply cleanly, looks like it's whitespace-damaged.  Send the
patch to yourself and make sure it applies cleanly.  Here's what
happened when I tried:

  02:05:27 ~/linux (pci/hotplug)$ b4 am -om/ https://lore.kernel.org/r/4b9310fa-f030-b82c-1440-fe2a3a39e21d@gmail.com
  Looking up https://lore.kernel.org/r/4b9310fa-f030-b82c-1440-fe2a3a39e21d%40gmail.com
  Grabbing thread from lore.kernel.org/linux-pci
  Analyzing 1 messages in the thread
  ---
  Writing m/20200714_ubijca16_pci_ibmphp_remove_unused_functions_get_max_adapter_speed_and_get_bus_name_in_ibmphp_core_c.mbx
    [PATCH] pci: ibmphp: Remove unused functions get_max_adapter_speed(), and get_bus_name() in ibmphp_core.c
  ---
  Total patches: 1
  ---
   Link: https://lore.kernel.org/r/4b9310fa-f030-b82c-1440-fe2a3a39e21d@gmail.com
   Base: not found (applies clean to current tree)
	 git am m/20200714_ubijca16_pci_ibmphp_remove_unused_functions_get_max_adapter_speed_and_get_bus_name_in_ibmphp_core_c.mbx
  02:05:50 ~/linux (pci/hotplug)$ git am m/20200714_ubijca16_pci_ibmphp_remove_unused_functions_get_max_adapter_speed_and_get_bus_name_in_ibmphp_core_c.mbx
  Applying: pci: ibmphp: Remove unused functions get_max_adapter_speed(), and get_bus_name() in ibmphp_core.c
  error: corrupt patch at line 15
  Patch failed at 0001 pci: ibmphp: Remove unused functions get_max_adapter_speed(), and get_bus_name() in ibmphp_core.c
  hint: Use 'git am --show-current-patch' to see the failed patch
  When you have resolved this problem, run "git am --continue".
  If you prefer to skip this patch, run "git am --skip" instead.
  To restore the original branch and stop patching, run "git am --abort".

> Signed-off-by: Ruslan Isaev <ubijca16@gmail.com>
> ---
>  drivers/pci/hotplug/TODO          |  5 ---
>  drivers/pci/hotplug/ibmphp_core.c | 74 -------------------------------
>  2 files changed, 79 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/TODO b/drivers/pci/hotplug/TODO
> index a32070be5adf..856535858ddf 100644
> --- a/drivers/pci/hotplug/TODO
> +++ b/drivers/pci/hotplug/TODO
> @@ -30,11 +30,6 @@ ibmphp:
>    or ibmphp should store a pointer to its bus in struct slot. Probably the
>    former.
> 
> -* The functions get_max_adapter_speed() and get_bus_name() are commented
> out.
> -  Can they be deleted?  There are also forward declarations at the top of
> -  ibmphp_core.c as well as pointers in ibmphp_hotplug_slot_ops, likewise
> -  commented out.
> -
>  * ibmphp_init_devno() takes a struct slot **, it could instead take a
>    struct slot *.
> 
> diff --git a/drivers/pci/hotplug/ibmphp_core.c
> b/drivers/pci/hotplug/ibmphp_core.c
> index 17124254d897..197997e264a2 100644
> --- a/drivers/pci/hotplug/ibmphp_core.c
> +++ b/drivers/pci/hotplug/ibmphp_core.c
> @@ -50,14 +50,6 @@ static int irqs[16];    /* PIC mode IRQs we're using so
> far (in case MPS
> 
>  static int init_flag;
> 
> -/*
> -static int get_max_adapter_speed_1 (struct hotplug_slot *, u8 *, u8);
> -
> -static inline int get_max_adapter_speed (struct hotplug_slot *hs, u8
> *value)
> -{
> -    return get_max_adapter_speed_1 (hs, value, 1);
> -}
> -*/
>  static inline int get_cur_bus_info(struct slot **sl)
>  {
>      int rc = 1;
> @@ -401,69 +393,6 @@ static int get_max_bus_speed(struct slot *slot)
>      return rc;
>  }
> 
> -/*
> -static int get_max_adapter_speed_1(struct hotplug_slot *hotplug_slot, u8
> *value, u8 flag)
> -{
> -    int rc = -ENODEV;
> -    struct slot *pslot;
> -    struct slot myslot;
> -
> -    debug("get_max_adapter_speed_1 - Entry hotplug_slot[%lx]
> pvalue[%lx]\n",
> -                        (ulong)hotplug_slot, (ulong) value);
> -
> -    if (flag)
> -        ibmphp_lock_operations();
> -
> -    if (hotplug_slot && value) {
> -        pslot = hotplug_slot->private;
> -        if (pslot) {
> -            memcpy(&myslot, pslot, sizeof(struct slot));
> -            rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
> -                        &(myslot.status));
> -
> -            if (!(SLOT_LATCH (myslot.status)) &&
> -                    (SLOT_PRESENT (myslot.status))) {
> -                rc = ibmphp_hpc_readslot(pslot,
> -                        READ_EXTSLOTSTATUS,
> -                        &(myslot.ext_status));
> -                if (!rc)
> -                    *value = SLOT_SPEED(myslot.ext_status);
> -            } else
> -                *value = MAX_ADAPTER_NONE;
> -        }
> -    }
> -
> -    if (flag)
> -        ibmphp_unlock_operations();
> -
> -    debug("get_max_adapter_speed_1 - Exit rc[%d] value[%x]\n", rc, *value);
> -    return rc;
> -}
> -
> -static int get_bus_name(struct hotplug_slot *hotplug_slot, char *value)
> -{
> -    int rc = -ENODEV;
> -    struct slot *pslot = NULL;
> -
> -    debug("get_bus_name - Entry hotplug_slot[%lx]\n", (ulong)hotplug_slot);
> -
> -    ibmphp_lock_operations();
> -
> -    if (hotplug_slot) {
> -        pslot = hotplug_slot->private;
> -        if (pslot) {
> -            rc = 0;
> -            snprintf(value, 100, "Bus %x", pslot->bus);
> -        }
> -    } else
> -        rc = -ENODEV;
> -
> -    ibmphp_unlock_operations();
> -    debug("get_bus_name - Exit rc[%d] value[%x]\n", rc, *value);
> -    return rc;
> -}
> -*/
> -
>  /****************************************************************************
>   * This routine will initialize the ops data structure used in the validate
>   * function. It will also power off empty slots that are powered on since
> BIOS
> @@ -1231,9 +1160,6 @@ const struct hotplug_slot_ops ibmphp_hotplug_slot_ops
> = {
>      .get_attention_status =        get_attention_status,
>      .get_latch_status =        get_latch_status,
>      .get_adapter_status =        get_adapter_present,
> -/*    .get_max_adapter_speed =    get_max_adapter_speed,
> -    .get_bus_name_status =        get_bus_name,
> -*/
>  };
> 
>  static void ibmphp_unload(void)
> -- 
> 2.27.0.windows.1
> 
> 
