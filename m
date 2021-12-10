Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDB447050E
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 16:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237546AbhLJQCW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 11:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhLJQCV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 11:02:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829D1C061746;
        Fri, 10 Dec 2021 07:58:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9C775CE211C;
        Fri, 10 Dec 2021 15:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADACAC00446;
        Fri, 10 Dec 2021 15:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639151923;
        bh=fQc56/zhViuchrUCAIhMuthGwsW47T40WSdgudAQYzc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FHLocjgzqCGzMfx3ib/9WfgUTkC/67WpdAcwTXnKorWJ+TF53W8nVT3nwggCmq+72
         xzBxG1brd9eOjr5tR6FDs24kChImXLe7Dbpm0k870vQgLTA8A5C3CwergZ9SeivnsI
         D/YVO8VDLJWCqCR+4r95Tr7vMh6pFyxXil3ZgjJDNvzPtkts68w4fTtj9jhM9jo0yv
         ALDW8fnMRBps3R3m6EbLZXkkqx+MIW9W2I9Tw9ZwnKAcj5SogVFhwNxLFpTfEeCD4k
         WYN8LGxyJ7JWdgIoXqJFsR99hewDuXt9SUhSLB4tg8LlInCg+vGkbBoZv1gfzpUFC0
         DmHknT03C16DQ==
Date:   Fri, 10 Dec 2021 09:58:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vihas Mak <makvihas@gmail.com>
Cc:     bhelgaas@google.com, lukas@wunner.de, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: ibmphp: removed the commented-out functions
Message-ID: <20211210155841.GA317413@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209213618.20522-1-makvihas@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 10, 2021 at 03:06:18AM +0530, Vihas Mak wrote:
> The functions get_max_adapter_speed() and get_bus_name() in
> ibmphp_core.c are commented-out and the fields .get_max_adapter_speed
> and .get_bus_name_status are removed from struct hotplug_slot_ops in
> pci_hotplug.h. Remove the commented-out functions.
> 
> Signed-off-by: Vihas Mak <makvihas@gmail.com>

I tweaked the subject line to match the history and applied to
pci/hotplug for v5.17, thanks!

  $ git log --oneline drivers/pci/hotplug/ibmphp_core.c
  e1a6333e7f89 ("PCI: ibmphp: Remove commented-out functions")
  2a727f609137 ("PCI: ibmphp: Turn semaphores into completions or mutexes")
  4051f5ebb11c ("PCI: ibmphp: Fix use-before-set in get_max_bus_speed()")
  ...

> ---
>  drivers/pci/hotplug/TODO          |  5 ---
>  drivers/pci/hotplug/ibmphp_core.c | 74 -------------------------------
>  2 files changed, 79 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/TODO b/drivers/pci/hotplug/TODO
> index cc6194aa2..88f217c82 100644
> --- a/drivers/pci/hotplug/TODO
> +++ b/drivers/pci/hotplug/TODO
> @@ -30,11 +30,6 @@ ibmphp:
>    or ibmphp should store a pointer to its bus in struct slot.  Probably the
>    former.
>  
> -* The functions get_max_adapter_speed() and get_bus_name() are commented out.
> -  Can they be deleted?  There are also forward declarations at the top of
> -  ibmphp_core.c as well as pointers in ibmphp_hotplug_slot_ops, likewise
> -  commented out.
> -
>  * ibmphp_init_devno() takes a struct slot **, it could instead take a
>    struct slot *.
>  
> diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
> index 17124254d..197997e26 100644
> --- a/drivers/pci/hotplug/ibmphp_core.c
> +++ b/drivers/pci/hotplug/ibmphp_core.c
> @@ -50,14 +50,6 @@ static int irqs[16];    /* PIC mode IRQs we're using so far (in case MPS
>  
>  static int init_flag;
>  
> -/*
> -static int get_max_adapter_speed_1 (struct hotplug_slot *, u8 *, u8);
> -
> -static inline int get_max_adapter_speed (struct hotplug_slot *hs, u8 *value)
> -{
> -	return get_max_adapter_speed_1 (hs, value, 1);
> -}
> -*/
>  static inline int get_cur_bus_info(struct slot **sl)
>  {
>  	int rc = 1;
> @@ -401,69 +393,6 @@ static int get_max_bus_speed(struct slot *slot)
>  	return rc;
>  }
>  
> -/*
> -static int get_max_adapter_speed_1(struct hotplug_slot *hotplug_slot, u8 *value, u8 flag)
> -{
> -	int rc = -ENODEV;
> -	struct slot *pslot;
> -	struct slot myslot;
> -
> -	debug("get_max_adapter_speed_1 - Entry hotplug_slot[%lx] pvalue[%lx]\n",
> -						(ulong)hotplug_slot, (ulong) value);
> -
> -	if (flag)
> -		ibmphp_lock_operations();
> -
> -	if (hotplug_slot && value) {
> -		pslot = hotplug_slot->private;
> -		if (pslot) {
> -			memcpy(&myslot, pslot, sizeof(struct slot));
> -			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
> -						&(myslot.status));
> -
> -			if (!(SLOT_LATCH (myslot.status)) &&
> -					(SLOT_PRESENT (myslot.status))) {
> -				rc = ibmphp_hpc_readslot(pslot,
> -						READ_EXTSLOTSTATUS,
> -						&(myslot.ext_status));
> -				if (!rc)
> -					*value = SLOT_SPEED(myslot.ext_status);
> -			} else
> -				*value = MAX_ADAPTER_NONE;
> -		}
> -	}
> -
> -	if (flag)
> -		ibmphp_unlock_operations();
> -
> -	debug("get_max_adapter_speed_1 - Exit rc[%d] value[%x]\n", rc, *value);
> -	return rc;
> -}
> -
> -static int get_bus_name(struct hotplug_slot *hotplug_slot, char *value)
> -{
> -	int rc = -ENODEV;
> -	struct slot *pslot = NULL;
> -
> -	debug("get_bus_name - Entry hotplug_slot[%lx]\n", (ulong)hotplug_slot);
> -
> -	ibmphp_lock_operations();
> -
> -	if (hotplug_slot) {
> -		pslot = hotplug_slot->private;
> -		if (pslot) {
> -			rc = 0;
> -			snprintf(value, 100, "Bus %x", pslot->bus);
> -		}
> -	} else
> -		rc = -ENODEV;
> -
> -	ibmphp_unlock_operations();
> -	debug("get_bus_name - Exit rc[%d] value[%x]\n", rc, *value);
> -	return rc;
> -}
> -*/
> -
>  /****************************************************************************
>   * This routine will initialize the ops data structure used in the validate
>   * function. It will also power off empty slots that are powered on since BIOS
> @@ -1231,9 +1160,6 @@ const struct hotplug_slot_ops ibmphp_hotplug_slot_ops = {
>  	.get_attention_status =		get_attention_status,
>  	.get_latch_status =		get_latch_status,
>  	.get_adapter_status =		get_adapter_present,
> -/*	.get_max_adapter_speed =	get_max_adapter_speed,
> -	.get_bus_name_status =		get_bus_name,
> -*/
>  };
>  
>  static void ibmphp_unload(void)
> -- 
> 2.30.2
> 
