Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D4A61FFAB
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 21:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiKGUld (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 15:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiKGUlc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 15:41:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B691B5FD2
        for <linux-pci@vger.kernel.org>; Mon,  7 Nov 2022 12:41:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A5FB612CA
        for <linux-pci@vger.kernel.org>; Mon,  7 Nov 2022 20:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85005C433D6;
        Mon,  7 Nov 2022 20:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667853690;
        bh=WrLmPf0nSCckPSVfWs+75psk8D7qhBlFegHx1j72tqw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qBkk53ZYFtD6AfoMw5fcqeJKFxuBxkGf8DWPxFZacNtOlLwtEZ1rPoXLfcXZEtNcK
         ZJSccpWOTvbLdcVcUm8bq0XqMI5OpfrlnXPWQNEX1SGVsv71E/gtEO6ailuZd7Q4cH
         HXHu7+VgMxWzF54lqGDk5iZujVt6tl8coUnSNVuFWLxGcqPX98IqFxxEpYmRBsR4qA
         0QaGpp+3xHdjYNt0MQhWPnxZfJoDeZD0bsR6bSSFu5pTf9Em1SlBoBZxeD6SiAlPQz
         oBgHAYx1SaWmjxANf9nU1PlPnlIkY4+etXYJis9117eRo1zkup484aolGuPsTHMKjL
         S0cBePOqGJdfA==
Date:   Mon, 7 Nov 2022 14:41:29 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     James Puthukattukaran <james.puthukattukaran@oracle.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pci@vger.kernel.org
Subject: Re: sysfs interface to force power off
Message-ID: <20221107204129.GA417338@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0a2c30b-7741-4a89-1f7a-aa5eb7c5e4e3@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lukas, Hans]

On Fri, Nov 04, 2022 at 07:08:34PM -0400, James Puthukattukaran wrote:
> Looking to solve a problem where we have nvme drives that are hung
> in the field and we are not sure of the root cause but the working
> theory is that the controller is "bad" and not responding properly
> to commands. The nvme driver times out on outstanding IO requests
> and as part of recovery, attempts to reset the controller and
> reinitialize the device. The reset controller also hangs like here
> --   
> 
> ernel:info: [10419813.132341] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
> kernel:warning: [10419813.132342] Call Trace:
> kernel:warning: [10419813.132345]  __schedule+0x2bc/0x89b
> kernel:warning: [10419813.132348]  schedule+0x36/0x7c
> kernel:warning: [10419813.132351]  blk_mq_freeze_queue_wait+0x4b/0xaa
> kernel:warning: [10419813.132353]  ? remove_wait_queue+0x60/0x60
> kernel:warning: [10419813.132359]  nvme_wait_freeze+0x33/0x50 [nvme_core]
> kernel:warning: [10419813.132362]  nvme_reset_work+0x802/0xd84 [nvme]
> kernel:warning: [10419813.132364]  ? __switch_to_asm+0x40/0x62
> kernel:warning: [10419813.132365]  ? __switch_to_asm+0x34/0x62
> kernel:warning: [10419813.132367]  ? __switch_to+0x9b/0x505
> kernel:warning: [10419813.132368]  ? __switch_to_asm+0x40/0x62
> kernel:warning: [10419813.132370]  ? __switch_to_asm+0x40/0x62
> kernel:warning: [10419813.132372]  process_one_work+0x169/0x399
> kernel:warning: [10419813.132374]  worker_thread+0x4d/0x3e5
> kernel:warning: [10419813.132377]  kthread+0x105/0x138
> kernel:warning: [10419813.132379]  ? rescuer_thread+0x380/0x375
> kernel:warning: [10419813.132380]  ? kthread_bind+0x20/0x15
> kernel:warning: [10419813.132382]  ret_from_fork+0x24/0x49
> ...
> 
> So, I tried to hot power off the device via
> "echo 0 > /sys/bus/pci/slots/X/power" -- the thread also hangs
> waiting for the nvme reset thread to finish (like so) -- 

Looks like this "power" sysfs file could use some documentation.  I
couldn't find anything in Documentation/ABI/testing/ that seems to
cover it.

> kernel:warning: [10419813.158116]  __schedule+0x2bc/0x89b
> kernel:warning: [10419813.158119]  schedule+0x36/0x7c
> kernel:warning: [10419813.158122]  schedule_timeout+0x1f6/0x31f
> kernel:warning: [10419813.158124]  ? sched_clock_cpu+0x11/0xa5
> kernel:warning: [10419813.158126]  ? try_to_wake_up+0x59/0x505
> kernel:warning: [10419813.158130]  wait_for_completion+0x12b/0x18a
> kernel:warning: [10419813.158132]  ? wake_up_q+0x80/0x73
> kernel:warning: [10419813.158134]  flush_work+0x122/0x1a7
> kernel:warning: [10419813.158137]  ? wake_up_worker+0x30/0x2b
> kernel:warning: [10419813.158141]  nvme_remove+0x71/0x100 [nvme]
> kernel:warning: [10419813.158146]  pci_device_remove+0x3e/0xb6
> kernel:warning: [10419813.158149]  device_release_driver_internal+0x134/0x1eb
> kernel:warning: [10419813.158151]  device_release_driver+0x12/0x14
> kernel:warning: [10419813.158155]  pci_stop_bus_device+0x7c/0x96
> kernel:warning: [10419813.158158]  pci_stop_bus_device+0x39/0x96
> kernel:warning: [10419813.158164]  pci_stop_and_remove_bus_device+0x12/0x1d
> kernel:warning: [10419813.158167]  pciehp_unconfigure_device+0x7a/0x1d7
> kernel:warning: [10419813.158169]  pciehp_disable_slot+0x52/0xca
> kernel:warning: [10419813.158171]  pciehp_sysfs_disable_slot+0x67/0x112
> kernel:warning: [10419813.158174]  disable_slot+0x12/0x14
> kernel:warning: [10419813.158175]  power_write_file+0x6e/0xf8
> kernel:warning: [10419813.158179]  pci_slot_attr_store+0x24/0x2e
> kernel:warning: [10419813.158180]  sysfs_kf_write+0x3f/0x46
> kernel:warning: [10419813.158182]  kernfs_fop_write+0x124/0x1a3
> kernel:warning: [10419813.158184]  __vfs_write+0x3a/0x16d
> kernel:warning: [10419813.158187]  ? audit_filter_syscall+0x33/0xce
> kernel:warning: [10419813.158189]  vfs_write+0xb2/0x1a1
> 
> Is there a way to force power off the device instead of the
> "graceful" approach? Obviously, we don't want to reset the system
> and don't have physical access to the device.  
> 
> Would it make sense to create a "force power off" in
> /sys/bus/pci/slots/X which basically 

> a) Sets completion timeout mask (CTO) (for outstanding IO requests
>    not causing a fatal error due to CTOs; not an issue for DPCs I
>    would think)
> b) power off the slot 
> c) enable CTO mask
> d) unconfigure the device via pciehp_unconfigure_device

So I assume the existing sysfs slot "power" interface would do what
you want except that nvme_remove() hangs?

There might be some improvement to make in nvme_remove(); maybe it
doesn't correctly detect I/O errors or something.

But maybe there's *also* a case to be made for an interface like you
suggest.  Lukas, Hans, any reaction to this?

Bjorn
