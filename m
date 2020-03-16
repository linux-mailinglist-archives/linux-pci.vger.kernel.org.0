Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76DD1187222
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 19:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732187AbgCPSUC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 14:20:02 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:50981 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731967AbgCPSUC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Mar 2020 14:20:02 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 328D230000CF4;
        Mon, 16 Mar 2020 19:20:00 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 06A0A4058E7; Mon, 16 Mar 2020 19:19:59 +0100 (CET)
Date:   Mon, 16 Mar 2020 19:19:59 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "Hoyer, David" <David.Hoyer@netapp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: Kernel hangs when powering up/down drive using sysfs
Message-ID: <20200316181959.wpzi4hkoyzpghwpw@wunner.de>
References: <DM5PR06MB313235E97731D97AB813F65D92FB0@DM5PR06MB3132.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR06MB313235E97731D97AB813F65D92FB0@DM5PR06MB3132.namprd06.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 14, 2020 at 02:19:44PM +0000, Hoyer, David wrote:
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -637,6 +637,8 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>         events = atomic_xchg(&ctrl->pending_events, 0);
>         if (!events) {
>                 pci_config_pm_runtime_put(pdev);
> +               ctrl->ist_running = false;
> +               wake_up(&ctrl->requester);
>                 return IRQ_NONE;
>        }

Thanks David for the report and sorry for the breakage.

The above LGTM, please submit it as a proper patch and
feel free to add my Reviewed-by.  Please add the same
two lines before the "return ret" a little further up
in the function.

If it's too cumbersome for you to submit a proper patch
I can do it for you.


> We've instrumented the code and we do see that pciehp_ist() runs
> twice, once exiting with IRQ_HANDLED and then again with IRQ_NONE.
> We believe that is due to the timing differences.  Adding debug in
> here changes the timings enough that the hang goes away, so we are
> having troubles proving this 100% at the moment.  But just based on
> code inspection, if pciehp_ist() exits with the IRQ_NONE case, then
> nothing will ever set ist_running=false until a subsequent hotplug
> event happens that causes the IRQ_HANDLED case to run.  (We were
> able to prove that will cause things to "unhang" and progress at
> that point - if you're hung and you remove a drive, the slot status
> change will then unstick things.)

The question is, why is pciehp_ist() run once more.  Most likely
because another event is signaled from the slot.  Try adding a
printk() at the top of pciehp_ist() which emits ctrl->pending_events
to understand what's going on.

Thanks,

Lukas
