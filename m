Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6FF445824
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 18:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhKDRTI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 13:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbhKDRTH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Nov 2021 13:19:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B945FC061714;
        Thu,  4 Nov 2021 10:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ltenyXnrsDdntMO+B9vjFdERdO2QMdRjBCFjFF1YnzM=; b=s1zqU90WpXefrE9/qFNAhs06pj
        PNIRGvj9Mo14MJwqJ2YvpwjEmCdCt7LspW4QsKgGD1laP1jOSckBmVZSTp6r2ds88QER8mzA787QJ
        NBYJ2SxLq732Xen5/Ct/GCwMFrQcd6k0OSXwOzfsBonUWTwjoiwTC1ycb9OjWXTbNUehGGvEysWIx
        yqOfBqztiPIAdXY5XsB9tw6wppnhlUKhrdqUK6gsgwrIT4aSfbN8f3C3TuP1fmlnVxeFS0i8slsmU
        4f9MGKQwAc0LVY54eZ/6ogbuspBewtHOid/fEM7hUJsoeLtoGrC6UAFlvAS0g8O+i6H2ULnvlFJu7
        f6a7rA/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1migHi-0060wt-Q1; Thu, 04 Nov 2021 17:12:46 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 545E19869DF; Thu,  4 Nov 2021 18:12:18 +0100 (CET)
Date:   Thu, 4 Nov 2021 18:12:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Josef Johansson <josef@oderland.se>, boris.ostrovsky@oracle.com,
        helgaas@kernel.org, jgross@suse.com, linux-pci@vger.kernel.org,
        maz@kernel.org, xen-devel@lists.xenproject.org,
        Jason Andryuk <jandryuk@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Peter Jones <pjones@redhat.com>, linux-fbdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] PCI/MSI: Move non-mask check back into low level
 accessors
Message-ID: <20211104171218.GD174703@worktop.programming.kicks-ass.net>
References: <90277228-cf14-0cfa-c95e-d42e7d533353@oderland.se>
 <20211025012503.33172-1-jandryuk@gmail.com>
 <87fssmg8k4.ffs@tglx>
 <87cznqg5k8.ffs@tglx>
 <d1cc20aa-5c5c-6c7b-2e5d-bc31362ad891@oderland.se>
 <89d6c2f4-4d00-972f-e434-cb1839e78598@oderland.se>
 <5b3d4653-0cdf-e098-0a4a-3c5c3ae3977b@oderland.se>
 <87ee7w6bxi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ee7w6bxi.ffs@tglx>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 04, 2021 at 12:45:29AM +0100, Thomas Gleixner wrote:
> On Wed, Oct 27 2021 at 17:29, Josef Johansson wrote:
> > ------------[ cut here ]------------
> > cfs_rq->avg.load_avg || cfs_rq->avg.util_avg || cfs_rq->avg.runnable_avg
> > installing Xen timer for CPU 4
> > WARNING: CPU: 3 PID: 455 at kernel/sched/fair.c:3339  __update_blocked_fair+0x49b/0x4b0
> 
> 	/*
> 	 * _avg must be null when _sum are null because _avg = _sum / divider
> 	 * Make sure that rounding and/or propagation of PELT values never
> 	 * break this.
> 	 */
> 	SCHED_WARN_ON(cfs_rq->avg.load_avg ||
> 		      cfs_rq->avg.util_avg ||
> 		      cfs_rq->avg.runnable_avg);
> 
> PeterZ, does that ring any bell?

Hurrr.. I thought we fixed all those. Vincent?

> > Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer nf_tables nfnetlink vfat fat intel_rapl_msr think_lmi firmware_attributes_class wmi_bmof intel_rapl_common pcspkr uvcvideo videobuf2_vmalloc videobuf2_memops joydev videobuf2_v4l2 sp5100_tco k10temp videobuf2_common i2c_piix4 iwlwifi videodev mc cfg80211 thinkpad_acpi ipmi_devintf ucsi_acpi platform_profile typec_ucsi ledtrig_audio ipmi_msghandler r8169 rfkill typec snd wmi soundcore video i2c_scmi fuse xenfs ip_tables dm_thin_pool dm_persistent_data dm_bio_prison dm_crypt trusted asn1_encoder hid_multitouch amdgpu crct10dif_pclmul crc32_pclmul crc32c_intel gpu_sched i2c_algo_bit drm_ttm_helper ghash_clmulni_intel ttm serio_raw drm_kms_helper cec sdhci_pci cqhci sdhci xhci_pci drm xhci_pci_renesas nvme xhci_hcd ehci_pci mmc_core ehci_hcd nvme_core xen_acpi_processor xen_privcmd xen_pciback xen_blkback xen_gntalloc xen_gntdev xen_evtchn uinput
> > CPU: 3 PID: 455 Comm: kworker/3:2 Tainted: G        W        --------- ---  5.15.0-0.rc7.0.fc32.qubes.x86_64 #1
> > Hardware name: LENOVO 20Y1S02400/20Y1S02400, BIOS R1BET65W(1.34 ) 06/17/2021
> > Workqueue:  0x0 (events)
> > RIP: e030:__update_blocked_fair+0x49b/0x4b0
> > Code: 6b fd ff ff 49 8b 96 48 01 00 00 48 89 90 50 09 00 00 e9 ff fc ff ff 48 c7 c7 10 7a 5e 82 c6 05 f3 35 9e 01 01 e8 1f f3 b2 00 <0f> 0b 41 8b 86 38 01 00 00 e9 c6 fc ff ff 0f 1f 80 00 00 00 00 0f
> > RSP: e02b:ffffc900410d7ce0 EFLAGS: 00010082
> > RAX: 0000000000000000 RBX: 0000000000000018 RCX: ffff8881406d8a08
> > RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff8881406d8a00
> > RBP: ffff8881406e9800 R08: 0000000000000048 R09: ffffc900410d7c78
> > R10: 0000000000000049 R11: 000000002d2d2d2d R12: ffff8881406e9f80
> > R13: ffff8881406e9e40 R14: ffff8881406e96c0 R15: 0000000000000000
> > FS:  0000000000000000(0000) GS:ffff8881406c0000(0000) knlGS:0000000000000000
> > CS:  10000e030 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000782e51820000 CR3: 0000000002810000 CR4: 0000000000050660
> > Call Trace:
> >  update_blocked_averages+0xa8/0x180
> >  newidle_balance+0x175/0x380
> >  pick_next_task_fair+0x39/0x3e0
> >  pick_next_task+0x4c/0xbd0
> >  ? dequeue_task_fair+0xba/0x390
> >  __schedule+0x13a/0x570
> >  schedule+0x44/0xa0
> >  worker_thread+0xc0/0x320
> >  ? process_one_work+0x390/0x390
> >  kthread+0x10f/0x130
> >  ? set_kthread_struct+0x40/0x40
> >  ret_from_fork+0x22/0x30
