Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921473AF812
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 23:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhFUVxv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 17:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231503AbhFUVxu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jun 2021 17:53:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77C5461001;
        Mon, 21 Jun 2021 21:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624312294;
        bh=Fy2DlTQ614EsPInH+BOlGYzRWNw6vYRiIxlEBh10hjM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TCp24i/7mctA1ruAQpDib2jt1TfrviJXZ4iKuOtJuRTBa6ndOtE+bAV+CPRZBt8kS
         XGo1rlKUo+3nt93xclMfkDQ9DfDFGt/P3dGUXXq5TStXMzKglASy0HVDt6Yc2FVsk4
         IvBrGYdtVeBXX9NlMrxIrt1/lPGMPBGkk28mHC60MuYkJh/+S6EuEO/kDxZGfEuHOs
         YGaCmmRMzAIZeXnPSKFwoT0jsUSXf7GKXAr6zY8ylFJIG5aAni6okeoqTnVeNuMEqV
         AHji025yjA7blxxzY3B7RBoH9YpD5qdux3Ve90Wr0yJvSvQfmIavLBA2ZoVwXwL8zE
         aPt9BdHU6sxNg==
Date:   Mon, 21 Jun 2021 16:51:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-pci@vger.kernel.org, Joel <j-comm@westvi.com>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 213519] New: WARNING
 on system reboot in: drivers/gpu/drm/i915/intel_runtime_pm.c:635
 intel_runtime_pm_driver_release]
Message-ID: <20210621215132.GA3305893@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621215009.GA3305615@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Joel (reporter)]

On Mon, Jun 21, 2021 at 04:50:14PM -0500, Bjorn Helgaas wrote:
> ----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----
> 
> Date: Mon, 21 Jun 2021 02:50:09 +0000
> From: bugzilla-daemon@bugzilla.kernel.org
> To: bjorn@helgaas.com
> Subject: [Bug 213519] New: WARNING on system reboot in:
> 	drivers/gpu/drm/i915/intel_runtime_pm.c:635 intel_runtime_pm_driver_release
> Message-ID: <bug-213519-41252@https.bugzilla.kernel.org/>
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=213519
> 
>             Bug ID: 213519
>            Summary: WARNING on system reboot in:
>                     drivers/gpu/drm/i915/intel_runtime_pm.c:635
>                     intel_runtime_pm_driver_release
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 5.12.12
>           Hardware: x86-64
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: j-comm@westvi.com
>         Regression: No
> 
> Created attachment 297517
>   --> https://bugzilla.kernel.org/attachment.cgi?id=297517&action=edit
> Contents of 'warning' stack trace, etc.
> 
> As mentioned in summary - warning message in this routine at system reboot. Try
> as I might, I cannot include the text of the warning directly here in the
> description without losing carriage returns, so I include it as a text
> attachment.
> 
> ----- End forwarded message -----
> 
> [Attachment contents below]
> 
> [  239.019148] ------------[ cut here ]------------
> [  239.024226] i915 0000:00:02.0: i915 raw-wakerefs=1 wakelocks=1 on cleanup
> [  239.031561] WARNING: CPU: 4 PID: 2484 at drivers/gpu/drm/i915/intel_runtime_pm.c:635 intel_runtime_pm_driver_release+0x4f/0x60
> [  239.043974] Modules linked in: mei_wdt x86_pkg_temp_thermal ghash_clmulni_intel mei_me mei cryptd
> [  239.053656] CPU: 4 PID: 2484 Comm: reboot Not tainted 5.12.12 #1
> [  239.060236] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./NUC-8665UE, BIOS P1.50 06/04/2021
> [  239.070766] RIP: 0010:intel_runtime_pm_driver_release+0x4f/0x60
> [  239.077256] Code: 10 4c 8b 6f 50 4d 85 ed 75 03 4c 8b 2f e8 59 8f 11 00 41 89 d8 44 89 e1 4c 89 ea 48 89 c6 48 c7 c7 f8 25 7d b0 e8 06 e8 67 00 <0f> 0b 5b 41 5c 41 5d 5d c3 0f 1f 84 00 00 00 00 00 55 48 89 e5 48
> [  239.097700] RSP: 0018:ffffb8c682f3bd30 EFLAGS: 00010286
> [  239.103422] RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffffb0af01e8
> [  239.111185] RDX: 0000000000000000 RSI: 00000000ffffdfff RDI: ffffffffb0a401e0
> [  239.118850] RBP: ffffb8c682f3bd48 R08: 0000000000000000 R09: ffffb8c682f3bb08
> [  239.126617] R10: ffffb8c682f3bb00 R11: ffffffffb0b20228 R12: 0000000000000001
> [  239.134390] R13: ffff978680d114b0 R14: ffff97868197eae8 R15: 00000000fee1dead
> [  239.142203] FS:  00007f741a182580(0000) GS:ffff9789dc500000(0000) knlGS:0000000000000000
> [  239.151044] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  239.157318] CR2: 000000000169f4c8 CR3: 000000019cf14003 CR4: 00000000003706e0
> [  239.165098] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  239.172874] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  239.180658] Call Trace:
> [  239.183346]  i915_driver_shutdown+0xcf/0xe0
> [  239.187920]  i915_pci_shutdown+0x10/0x20
> [  239.192181]  pci_device_shutdown+0x35/0x60
> [  239.196629]  device_shutdown+0x156/0x1b0
> [  239.200827]  __do_sys_reboot.cold+0x2f/0x5b
> [  239.205410]  __x64_sys_reboot+0x16/0x20
> [  239.209586]  do_syscall_64+0x38/0x50
> [  239.213399]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  239.218837] RIP: 0033:0x7f741a0a9bc3
> [  239.222740] Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 71 c2 0c 00 f7 d8
> [  239.243228] RSP: 002b:00007ffcc2a16488 EFLAGS: 00000206 ORIG_RAX: 00000000000000a9
> [  239.251503] RAX: ffffffffffffffda RBX: 00007ffcc2a165d8 RCX: 00007f741a0a9bc3
> [  239.259304] RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
> [  239.267105] RBP: 0000000000000004 R08: 0000000000000000 R09: 000000000169e2e0
> [  239.274926] R10: fffffffffffffd06 R11: 0000000000000206 R12: 0000000000000000
> [  239.282719] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
> [  239.290433] ---[ end trace cd9d07db38ec6618 ]---
> 
