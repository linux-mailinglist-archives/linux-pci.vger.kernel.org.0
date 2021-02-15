Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECCE31C2EB
	for <lists+linux-pci@lfdr.de>; Mon, 15 Feb 2021 21:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhBOUZ2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Feb 2021 15:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhBOUZ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Feb 2021 15:25:27 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6BBC061574
        for <linux-pci@vger.kernel.org>; Mon, 15 Feb 2021 12:24:47 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id t63so7572061qkc.1
        for <linux-pci@vger.kernel.org>; Mon, 15 Feb 2021 12:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to;
        bh=DvoRXzwzvXTWqoU2SmDjRGAMPM5/FJbKCW4hLOOZ0aQ=;
        b=j2nwmsVFijDf6nLajg7AKo/XsMaqTZca9HD9TPqJNfFsIl1uOanaXRYGjwM8MPkPbe
         OvGET4BTU6Ao7TX2smyPskRc0S2+CxtatMErLshsa9TBcG0ZfRAupL0R/NMqWlDT94AY
         gF/mymFwG7P6Atj/dah0z2mxQgo119BZTMIfDHVcDARhulKMuxjK9qkg3BQ2ylvh25/s
         KpLBAipjvVoy7Yb4u8Izrar2chdSnl2Moe8NibpvBoUZSNokByEnqRFNcMKpXOy34wje
         FYtUpQcPtlo2uTfulMJVdJuiw/P40QNMuofbSpyy8QoWPla1TH18W8AHq3Sc3xyUk7NP
         TlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to;
        bh=DvoRXzwzvXTWqoU2SmDjRGAMPM5/FJbKCW4hLOOZ0aQ=;
        b=hEcYjwDVTd8gDrbHPyRxVt1CwbOnCtMCRaB0hxXJYsx+GT81SDntbmxiRjBEz/KAn/
         E5xJ/wSbHRTVgrIK8R5XdUEzQMzPQLftQ19nV76iHv7JBp/9tSdrgbVCXLm6sb0gVSJL
         /W0SQecPKbG6n5N8g+FG6Jb8R6ReffTD2CzfT2J7KeRwEJ93XBa1veh4OGjYEQ9sHNIO
         VBc7pjKhM3AmtX+bAGtBhRMK4GfwfCuNy3KOHB0vU516eAGu0oUsAyzz3/vttNU4/xjz
         mggTTM+Dgweawcybg9OZ5Owe10YqktBE2mE9U2y1a8rcwgp6jf3SgcNAA4cPnn3RIvhp
         bclQ==
X-Gm-Message-State: AOAM5324PD1N7MFwqTT5Ql+lhffWDvhIV2kEjPT9C/nq5zTrxAEFhoqm
        pFH+l3rvW3WWsAHTJqyk+cN5r1TjozwKdOgFSPND78AP
X-Google-Smtp-Source: ABdhPJxSV2pmFBf3sopEdKCvLsF4cQJCSfDiQlFn5mvoiPAUswt6kjQBdAwd8vPj1h8UM8Tlu1AyhtNpx/P88p1l6Dw=
X-Received: by 2002:a05:620a:485:: with SMTP id 5mr16078572qkr.461.1613420686174;
 Mon, 15 Feb 2021 12:24:46 -0800 (PST)
MIME-Version: 1.0
References: <CAPYVV1c7bUPKg5TzAOAsgQJq2DdPUDb_1=5TqwkJzxZO0w-NmQ@mail.gmail.com>
In-Reply-To: <CAPYVV1c7bUPKg5TzAOAsgQJq2DdPUDb_1=5TqwkJzxZO0w-NmQ@mail.gmail.com>
Reply-To: raydude@gmail.com
From:   Brian McKee <raydude@gmail.com>
Date:   Mon, 15 Feb 2021 12:24:35 -0800
Message-ID: <CAPYVV1ciaLbsvM6aqHOEZ52jE83h+KMP0nzHS2uYWxWZbznZEw@mail.gmail.com>
Subject: Fwd: Trying to get nvme and altera-pci drivers to play nice.
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,
I'm a hardware guy, debugging an embedded system using a Cyclone V
SOC. It utilizes pcie 1.0 with four lanes connected to an NVMe drive
for main storage.

Bringup has come to a halt as I haven't been able to get the
altera-pci driver to play nice with the nvme driver.

The altera-pcie module loads and lspci -v shows the nvme drive and the
number of lanes connected and speed, but when I load the nvme driver
it hangs on the first try:

(pardon my printk's, I've been trying to track this down to find out
what I'm doing wrong in the hardware)

nvme: Successfully exiting nvme_pci_enable.
pci.c: nvme_reset_work: calling nvme_pci_configure_admin_queue.
nvme: core.c: nvme_wait_ready entry
nvme: core.c: nvme_wait_ready return
nvme: core.c: nvme_wait_ready entry
nvme: core.c: nvme_wait_ready return
pci.c: nvme_reset_work: calling nvme_alloc_admin_tags.
nvme: core.c: nvme_change_ctrl_state entry
pci.c: nvme_reset_work: calling nvme_init_identify.
nvme: core.c: entering nvme_init_identify
nvme: core.c: nvme_init_identify: calling nvme_identify_ctrl
nvme: core.c: Entering nvme_identify_ctrl
nvme: core.c: nvme_identify_ctrl: getting nvme_admin_identify...
nvme: core.c: nvme_identify_ctrl: kmalloc(nvme_id_ctrl)
nvme: core.c: nvme_identify_ctrl: calling nvme_submit_sync_cmd
nvme: core.c: Entering __nvme_submit_sync_cmd
nvme: core.c: __nvme_submit_sync_cmd: calling nvme_alloc_request
nvme: core.c: nvme_alloc_request entry
nvme: core.c: nvme_alloc_request calling blk_mq_alloc_request
nvme: core.c: nvme_alloc_request done. cmd = 0xef22fd08
nvme: core.c: __nvme_submit_sync_cmd: calling blk_rq_map_kern
nvme: core.c: __nvme_submit_sync_cmd: calling blk_execute_rq
blk-exec.c: Entering blk_execute_rq
blk-exec.c: blk_execute_rq: calling blk_execute_rq_nowait
blk-exec.c: blk_execute_rq_nowait: calling blk_mq_sched_insert_request
nvme: core.c: nvme_setup_cmd entry
nvme: core.c: nvme_setup_cmd: adding command: 34 to nvme_req queue
nvme: core.c: nvme_setup_cmd return
blk-exec.c: blk_execute_rq: starting wait_for_completion_io_timeout()


After a watchdog, reboot and reload of both modules, it produces this
message sometimes other times it repeats the watchdog reset:

[   64.471966] nvme nvme0: I/O 16 QID 0 timeout, disable controller
[   64.478147] nvme nvme0: Identify Controller failed (-4)
[   64.483380] nvme nvme0: Removing after probe failure status: -5

According to my printks the nvme driver is attempting a drive
identify. But the blk read never returns. I can't figure out exactly
what code is being called by the nvme driver as none of the altera-pci
routine printks I have installed are showing up before the hang. The
code traverses into blk-exec.c and never comes out.

I know it's a big ask, but can someone advise me on how to proceed to
debug this?

Brian
