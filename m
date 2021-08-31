Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CB43FC071
	for <lists+linux-pci@lfdr.de>; Tue, 31 Aug 2021 03:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbhHaBWN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 21:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbhHaBWN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Aug 2021 21:22:13 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3E1C061575;
        Mon, 30 Aug 2021 18:21:18 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id q3so24321597edt.5;
        Mon, 30 Aug 2021 18:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qvu/FvktI3MZJ048Z6cQYb4qKeYH6llf7yIDoL3bsqE=;
        b=W+Q/DT0/n243CpLmvnLrNVFcqZkhGEvd2cIFb3cE1mmKZhdOhY9Uq86hUjtcPfDy36
         N6oWIklTREHhJIZAU9TqjHWULOS1wDeTvZ6mreNWq6nvN5tnnoY4CgECbRTiY1FNgRv7
         DXdVwRws/sbxX5PEUwZndeW5Nnu5hsiZDfZbNKRPlZ9fHD1D90Xg3URxhvVq49l2ySs5
         Cx9RgPtwc8CWpbzzAkRUIlxoMHEQW9tAt9PosL3h5Gt3FZLCx3jfvpXURqMlXy83uFOW
         PQpxWld28yyYE4W6WrIcCyieW3cQyMNg6CpiJjY452t4i2ny0tAeWQ7BJe9K0PJAajAa
         3e/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qvu/FvktI3MZJ048Z6cQYb4qKeYH6llf7yIDoL3bsqE=;
        b=qy+cgl5Wv9EC2tPnC4q6zk90xhkmRteoMDzVD8/L9OF3bMvgU7AKcbjbLoVY7kSTRa
         25FkLKX2MJ/phS9D/wZ5pFKX1IAx/ODIH9m7xgMXxkHYoCYfn2FSNuwYgpbsidoQMa6u
         D0vJKHIwUn3b5/26H+ukq8xKt5qTVBqND4toRtqTBFuS4PhPhT4FdGdh8nMwo3GAe2qB
         QYUbFNmT+BlYGZ98AJyhl/AkcNswv67Ul19cPrIdCkKz0ICuzP7pJIOPM7kHgupgQj79
         AOyPfp9U+Q7rIMQyOU1kIrKrMXklnk6XeDNll0nlOwEGLUCHqrL4gswQ5g2KRckPgaPY
         rAtw==
X-Gm-Message-State: AOAM532B5LswFEcAmF6ov4vTaCSiXkH9zWkUxa0rht2Tj0bb9fvGF+RI
        s/Z0b8H9uSU2OejthioXxb42qh/oWgeU3ndgjJc=
X-Google-Smtp-Source: ABdhPJx/wJ7h8gV7ZCBLL7UymIx5I21U9FAhVA9MFJ7xyuczJ4TosmHbwISnecWXWFH+03QY/kpjytHIFpFy6K77RuQ=
X-Received: by 2002:a05:6402:2032:: with SMTP id ay18mr27136884edb.364.1630372877076;
 Mon, 30 Aug 2021 18:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210825102636.52757-4-21cnbao@gmail.com> <20210829145552.GA11556@xsang-OptiPlex-9020>
In-Reply-To: <20210829145552.GA11556@xsang-OptiPlex-9020>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 31 Aug 2021 13:21:06 +1200
Message-ID: <CAGsJ_4yYwjuWsEeK3CvnOhc10mbBNYWXqxqp+mR5587R2FD3gQ@mail.gmail.com>
Subject: Re: [PCI/MSI] a4fc4cf388: dmesg.genirq:Flags_mismatch_irq##(mei_me)vs.#(xhci_hcd)
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan.Cameron@huawei.com, bilbao@vt.edu,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        leon@kernel.org, linux-pci@vger.kernel.org,
        Linuxarm <linuxarm@huawei.com>, luzmaximilian@gmail.com,
        mchehab+huawei@kernel.org, schnelle@linux.ibm.com,
        intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 30, 2021 at 2:38 AM kernel test robot <oliver.sang@intel.com> wrote:
>
>
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: a4fc4cf388319ea957ffbdab5073bdd267de9082 ("[PATCH v3 3/3] PCI/MSI: remove msi_attrib.default_irq in msi_desc")
> url: https://github.com/0day-ci/linux/commits/Barry-Song/PCI-MSI-Clarify-the-IRQ-sysfs-ABI-for-PCI-devices/20210825-183018
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 6e764bcd1cf72a2846c0e53d3975a09b242c04c9
>
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-ebaa603b-1_20210825
> with following parameters:
>
>         group: pidfd
>         ucode: 0xe2
>
> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>
>
> on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
>
> [  179.602028][   T34] genirq: Flags mismatch irq 16. 00002000 (mei_me) vs. 00000000 (xhci_hcd)
> [  179.614073][   T34] CPU: 2 PID: 34 Comm: kworker/u8:2 Not tainted 5.14.0-rc7-00014-ga4fc4cf38831 #1
> [  179.623225][   T34] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
> [  179.631432][   T34] Workqueue: events_unbound async_run_entry_fn
> [  179.637543][   T34] Call Trace:
> [  179.640789][   T34]  dump_stack_lvl+0x45/0x59
> [  179.645253][   T34]  __setup_irq.cold+0x50/0xd4
> [  179.649893][   T34]  ? mei_me_pg_exit_sync+0x480/0x480 [mei_me]
> [  179.655923][   T34]  request_threaded_irq+0x10c/0x180
> [  179.661073][   T34]  ? mei_me_irq_quick_handler+0x240/0x240 [mei_me]
> [  179.667528][   T34]  mei_me_probe+0x131/0x300 [mei_me]
> [  179.672767][   T34]  local_pci_probe+0x42/0x80
> [  179.677313][   T34]  pci_device_probe+0x107/0x1c0
> [  179.682118][   T34]  really_probe+0xb6/0x380
> [  179.687094][   T34]  __driver_probe_device+0xfe/0x180
> [  179.692242][   T34]  driver_probe_device+0x1e/0xc0
> [  179.697133][   T34]  __driver_attach_async_helper+0x2b/0x80
> [  179.702802][   T34]  async_run_entry_fn+0x30/0x140
> [  179.707693][   T34]  process_one_work+0x274/0x5c0
> [  179.712503][   T34]  worker_thread+0x50/0x3c0
> [  179.716959][   T34]  ? process_one_work+0x5c0/0x5c0
> [  179.721936][   T34]  kthread+0x14f/0x180
> [  179.725958][   T34]  ? set_kthread_struct+0x40/0x40
> [  179.730935][   T34]  ret_from_fork+0x22/0x30
> [  179.735699][   T34] mei_me 0000:00:16.0: request_threaded_irq failure. irq = 16
> [  179.743125][   T34] mei_me 0000:00:16.0: initialization failed.
> [  179.749399][   T34] mei_me: probe of 0000:00:16.0 failed with error -16
>
>

it seems there is a direct reference to pdev->irq.
Hi Oliver, would you try if the below patch can fix the problem:

diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index c3393b383e59..a45a2d4257a6 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -216,7 +216,7 @@ static int mei_me_probe(struct pci_dev *pdev,
const struct pci_device_id *ent)

        pci_enable_msi(pdev);

-       hw->irq = pdev->irq;
+       hw->irq = pci_irq_vector(pdev, 0);

         /* request and enable interrupt */
        irqflags = pci_dev_msi_enabled(pdev) ? IRQF_ONESHOT : IRQF_SHARED;


I don't have any hardware to test.

>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install                job.yaml  # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml  # generate the yaml file for lkp run
>         bin/lkp run                    generated-yaml-file
>
>
>
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
>
> Thanks,
> Oliver Sang
>

Thanks
barry
