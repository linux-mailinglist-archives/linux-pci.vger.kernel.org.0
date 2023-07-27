Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AACB76595C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jul 2023 18:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjG0Q7P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jul 2023 12:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjG0Q7O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jul 2023 12:59:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05090273C;
        Thu, 27 Jul 2023 09:59:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CBA961EE2;
        Thu, 27 Jul 2023 16:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE3EC433C7;
        Thu, 27 Jul 2023 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690477152;
        bh=2LPH2ZikNZEeoMkYepl8BArTbqY3yYkLkdvhWJxt1Hg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YzhDZb+NGDJm5xPzn0sIMO8wCVhqoVdj2GdlFyhUKRxR9HhhmPBH98/cqNhoo2zvK
         XZ+PlHLK4W/94iByiSzGFJ6I9Dm27wqS25H/cuQhXTOCaNy5bhXEoGRb18YTGiL1hd
         yqz/b/7ySrJjy16y0pdRqrIFqOcj6E0/Tl1mxxoZsNx+a+0Hb1siuFnV+fqs0wlCmA
         5xUnoX5VAnvJY4iW9rGATE6pQvziPg90LnqBddtue+824SqLz163MW7QFvLi/8ccb/
         CYrRASOo15AL4anOEZu8BA9GTfcxm9RCQeyuYX25n9gEgVG7AwJrVn91BLRjZCOK3m
         XekbpyzGybBow==
Date:   Thu, 27 Jul 2023 11:59:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/DOE: Fix destroy_work_on_stack() race
Message-ID: <20230727165910.GA786573@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726-doe-fix-v1-1-af07e614d4dd@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 26, 2023 at 11:29:42AM -0700, Ira Weiny wrote:
> The following debug object splat was observed in testing.
> 
>   [   14.061937] ------------[ cut here ]------------
>   [   14.063899] ODEBUG: free active (active state 0) object: 0000000097d23782 object type: work_struct hint: doe_statemachine_work+0x0/0x510
>   [   14.067480] WARNING: CPU: 1 PID: 71 at lib/debugobjects.c:514 debug_print_object+0x7d/0xb0
>   ...
>   [   14.080951] Workqueue: pci 0000:36:00.0 DOE [1 doe_statemachine_work
>   [   14.083485] RIP: 0010:debug_print_object+0x7d/0xb0
>   ...
>   [   14.116231] Call Trace:
>   [   14.117652]  <TASK>
>   [   14.118958]  ? debug_print_object+0x7d/0xb0
>   [   14.120782]  ? __warn+0x7d/0x130
>   [   14.122399]  ? debug_print_object+0x7d/0xb0
>   [   14.123746]  ? report_bug+0x18d/0x1c0
>   [   14.125025]  ? handle_bug+0x3c/0x80
>   [   14.126506]  ? exc_invalid_op+0x13/0x60
>   [   14.127796]  ? asm_exc_invalid_op+0x16/0x20
>   [   14.129380]  ? debug_print_object+0x7d/0xb0
>   [   14.130688]  ? debug_print_object+0x7d/0xb0
>   [   14.131997]  ? __pfx_doe_statemachine_work+0x10/0x10
>   [   14.133597]  debug_object_free.part.0+0x11b/0x150
>   [   14.134940]  doe_statemachine_work+0x45e/0x510
>   [   14.136348]  process_one_work+0x1d4/0x3c0
>   ...
>   [   14.161484]  </TASK>
>   [   14.162434] ---[ end trace 0000000000000000 ]---
> 
> This occurs because destroy_work_on_stack() was called after signaling
> the completion in the calling thread.  This creates a race between
> destroy_work_on_stack() and the task->work struct going of scope in the
> pci_doe().
> 
> Signal the work complete after destroying the work struct.  This is safe
> because signal_task_complete() is the final thing the work item does and
> the workqueue code is careful not to access the work struct after.
> 
> Fixes: abf04be0e707 ("PCI/DOE: Fix memory leak with CONFIG_DEBUG_OBJECTS=y")
> Cc: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Dan, let me know if you'd rather have me take this.

> ---
>  drivers/pci/doe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 1b97a5ab71a9..e3aab5edaf70 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -293,8 +293,8 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
>  static void signal_task_complete(struct pci_doe_task *task, int rv)
>  {
>  	task->rv = rv;
> -	task->complete(task);
>  	destroy_work_on_stack(&task->work);
> +	task->complete(task);
>  }
>  
>  static void signal_task_abort(struct pci_doe_task *task, int rv)
> 
> ---
> base-commit: 20ea1e7d13c1b544fe67c4a8dc3943bb1ab33e6f
> change-id: 20230726-doe-fix-f57943f9ea82
> 
> Best regards,
> -- 
> Ira Weiny <ira.weiny@intel.com>
> 
