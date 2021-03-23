Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D895346C5F
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 23:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbhCWWVr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 18:21:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234037AbhCWWTm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Mar 2021 18:19:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C783619B3;
        Tue, 23 Mar 2021 22:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616537981;
        bh=hCB5Ph3FFz48xKeAxtmyZUvCAPJWnOJQU5bn9hbls78=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nPj5Hltm5PS/XtPw8EhpbAjV985Dk/FLiwh1DCgxn0aW3mtcc8cPuAxBA47TuxXwp
         OzL64YIwRKeuCp2t484VYw3DSdjC9nf9g2pE5WttCWSk9nJnsTLDpo4xuCn1yqXWbB
         dYUffi3etn74k0gFWelQeZUuwJgRKoVSMHhp3uqB2viDT7ewYSX9VGHogrUBoMgrqm
         BE3fgAtYRJSlOF7xurkLLFK5sRB3KAJBgkax1HR0a5UypOFPP6zmu5xZVzsoeC92HV
         ps9YsZrJb3vhuISbpWVKS9iiza7NyBm+fyCtvW7dGktanjSL80Lo5ovtOfVK37ooPm
         f//YirHtcvHJg==
Date:   Tue, 23 Mar 2021 17:19:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Scott Murray <scott@spiteful.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: hotplug: fix null-ptr-dereferencd in cpcihp error
 path
Message-ID: <20210323221940.GA493013@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210321055109.322496-1-ztong0001@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 21, 2021 at 01:51:08AM -0400, Tong Zhang wrote:
> There is an issue in the error path, which cpci_thread may remain NULL.
> Calling kthread_stop(cpci_thread) will trigger a BUG().
> It is better to check whether the thread is really created and started
> before stop it.
> 
> [    1.292859] BUG: kernel NULL pointer dereference, address: 0000000000000028
> [    1.293252] #PF: supervisor write access in kernel mode
> [    1.293533] #PF: error_code(0x0002) - not-present page
> [    1.295163] RIP: 0010:kthread_stop+0x22/0x170
> [    1.300491] Call Trace:
> [    1.300628]  cpci_hp_unregister_controller+0xf6/0x130
> [    1.300906]  zt5550_hc_init_one+0x27a/0x27f [cpcihp_zt5550]

Wow, I didn't know anybody actually used this driver :)

> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>  drivers/pci/hotplug/cpci_hotplug_core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
> index d0559d2faf50..b44da397d631 100644
> --- a/drivers/pci/hotplug/cpci_hotplug_core.c
> +++ b/drivers/pci/hotplug/cpci_hotplug_core.c
> @@ -47,7 +47,7 @@ static atomic_t extracting;
>  int cpci_debug;
>  static struct cpci_hp_controller *controller;
>  static struct task_struct *cpci_thread;
> -static int thread_finished;
> +static int thread_started;

Why are we messing around with "thread_started" or "thread_finished"?
We should know whether cpci_thread has been started by the control
flow.

There are two ways to start cpci_thread:

  1)  cpcihp_generic_init                        # module_init function
        cpci_hp_start
          cpci_start_thread
            cpci_thread = kthread_run(...)

  2)  zt5550_hc_init_one                         # .probe function
        cpci_hp_start
          cpci_start_thread
            cpci_thread = kthread_run(...)

cpci_hp_start() returns a non-zero error if kthread_run() fails, and 
both cpcihp_generic_init() and zt5550_hc_init_one() clean up and exit
in that case.

The error cleanup is a little sloppy: if cpci_hp_register_bus() fails,
cpcihp_generic_init() calls cpci_hp_unregister_controller(), which
stops cpci_thread if it has been started.  But in that case, we *know*
there's no cpci_thread because we haven't even tried to start it.  I
think this error cleanup could be done better by splitting the
cpci_stop_thread() out from cpci_hp_unregister_controller() so it
could be done separately.  zt5550_hc_init_one() has a similar problem.

If cpcihp_generic_init() or zt5550_hc_init_one() succeeds, we *know*
there is a cpci_thread.  We should be able to call kthread_stop() on
it unconditionally in the cpcihp_generic_exit() and
zt5550_hc_remove_one() paths.

What do you think?  It's a little more restructuring work, but I think
"thread_started" and "thread_finished" are basically kind of kludgy
and they add complication without giving me confidence that they're
actually correct.

>  static int enable_slot(struct hotplug_slot *slot);
>  static int disable_slot(struct hotplug_slot *slot);
> @@ -447,7 +447,7 @@ event_thread(void *data)
>  				msleep(500);
>  			} else if (rc < 0) {
>  				dbg("%s - error checking slots", __func__);
> -				thread_finished = 1;
> +				thread_started = 0;
>  				goto out;
>  			}
>  		} while (atomic_read(&extracting) && !kthread_should_stop());
> @@ -479,7 +479,7 @@ poll_thread(void *data)
>  					msleep(500);
>  				} else if (rc < 0) {
>  					dbg("%s - error checking slots", __func__);
> -					thread_finished = 1;
> +					thread_started = 0;
>  					goto out;
>  				}
>  			} while (atomic_read(&extracting) && !kthread_should_stop());
> @@ -501,7 +501,7 @@ cpci_start_thread(void)
>  		err("Can't start up our thread");
>  		return PTR_ERR(cpci_thread);
>  	}
> -	thread_finished = 0;
> +	thread_started = 1;
>  	return 0;
>  }
>  
> @@ -509,7 +509,7 @@ static void
>  cpci_stop_thread(void)
>  {
>  	kthread_stop(cpci_thread);
> -	thread_finished = 1;
> +	thread_started = 0;
>  }
>  
>  int
> @@ -571,7 +571,7 @@ cpci_hp_unregister_controller(struct cpci_hp_controller *old_controller)
>  	int status = 0;
>  
>  	if (controller) {
> -		if (!thread_finished)
> +		if (thread_started)
>  			cpci_stop_thread();
>  		if (controller->irq)
>  			free_irq(controller->irq, controller->dev_id);
> -- 
> 2.25.1
> 
