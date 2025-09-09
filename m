Return-Path: <linux-pci+bounces-35771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8E9B507CD
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 23:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9361B22257
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 21:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB93255F3F;
	Tue,  9 Sep 2025 21:11:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A0C2517B9
	for <linux-pci@vger.kernel.org>; Tue,  9 Sep 2025 21:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452293; cv=none; b=MCWvxhrm458p49cxUgm87Jx5kkIgy9QtAia6lXUxuEhrya3aeTo6AI/RCKmUbPyvDbAbpgqZ9PInYEdN4XoWrafJ3pKQt56j/f/h4+DXCZmPfb0f/VQQ37r2GWyIvzmG5ngx3TtzStTwttZjCTsyRRIJ4KZCpGoj8wbYyxAI/E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452293; c=relaxed/simple;
	bh=yFBKR6CyaNxRFqy9atHeGzcWUL4lsCYcOtbPoghROlI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=d4tg43xpuX/FdQWIus4q2ST7bxKKwygY1Y370BgrwmsH0WH+CRRTqn897yq1mmpDlbJhw4lxcyEr53gAmpcQYByVmF8jJ8WjpwkPK5Gp2kFXtU1S9IOcKBmOxRfnaO0j1ZXDP3STOTikooZaF33FyiIKRirkwcqoW7+Rj+REda4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-40194dd544eso43359185ab.2
        for <linux-pci@vger.kernel.org>; Tue, 09 Sep 2025 14:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757452291; x=1758057091;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gi+oKRrccGnFwppC+lOMAdaDbYQiIOQIN1lauGMt0Lk=;
        b=GFSOcbwYaXw1KKaDGBPlfTO7S+tWXAOBZfi0SzFVnzyXAoq+NxjiYfTk8bxyd5hGe2
         +aPE8CuyvEcZPtUdCC5WKXJoiCAa6OXY5F0dHav79Ut7LJCBQ4REMiiV/F2Tbos5xKD0
         nHxHcHKJBddlk23fEjP4NJ7DRJxKT2NKAt+2X5o84GH5FSeIRDdBORvKGddqOPKFvZQo
         +ssrXZHrk8ocWTt6kycjJvyQB4j8w/j9xwm3hMEAQpRt98jLWd91fYGi7tTsjMVkRbbt
         dM09wFgVqZ6SGXEahN8mLO2fIhO4KWAQbfF65v5RkI4xvSSB7ECaTILAcPMKMMRXZmHo
         t2Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUMrmY7L+VuMpGTuc1QuTkXg8L7QgwzO4DPQw8qZN5FrBY9ZpinbCPy3yWovJXBQ7VSxQkt/QxoJ/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu51vHl/Xx3I7W7UXoo8Yt7q8zK1yo1jzjwe/Vm5mM22PSqn3l
	fl5Zmt/5WuaRuxiNXQGR0Fk8eq1sq7EwvliGscey6TV4G4WvpvrtQwj+PqbTBT+e1JPHwaoc6Zx
	6VZkqeqXyJNUKntHawYAVmamJfb3rNjqqSXTjtnGCO7ksRZDaDGfNC9YaE2I=
X-Google-Smtp-Source: AGHT+IG6JNU8caQsArnbrh9w46NueVmD5f+ZX71LWlKNXeYltndpSBTNSaVjlvWEBkmfBuxJic+95t3TCYp+AirmSIczEdAhJsNo
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcc:b0:407:24:250f with SMTP id
 e9e14a558f8ab-407002426a1mr129570265ab.27.1757452290925; Tue, 09 Sep 2025
 14:11:30 -0700 (PDT)
Date: Tue, 09 Sep 2025 14:11:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c09802.050a0220.3c6139.000f.GAE@google.com>
Subject: [syzbot] [pci?] INFO: rcu detected stall in vga_arb_release
From: syzbot <syzbot+e333f6ae9120efd3294a@syzkaller.appspotmail.com>
To: bhelgaas@google.com, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f777d1112ee5 Merge tag 'vfs-6.17-rc6.fixes' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11790d62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=429771c55b615e85
dashboard link: https://syzkaller.appspot.com/bug?extid=e333f6ae9120efd3294a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1439d562580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14dac642580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/860ff2f591a4/disk-f777d111.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/31f4ca3a76d4/vmlinux-f777d111.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c534fac91a74/bzImage-f777d111.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e333f6ae9120efd3294a@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P6880
rcu: 	(detected by 0, t=10502 jiffies, g=16217, q=2735 ncpus=2)
task:syz.0.301       state:R  running task     stack:26952 pid:6880  tgid:6880  ppid:5958   task_flags:0x400040 flags:0x00004006
Call Trace:
 <IRQ>
 sched_show_task+0x49d/0x630 kernel/sched/core.c:7933
 rcu_print_detail_task_stall_rnp kernel/rcu/tree_stall.h:292 [inline]
 print_other_cpu_stall+0xf78/0x1340 kernel/rcu/tree_stall.h:681
 check_cpu_stall kernel/rcu/tree_stall.h:857 [inline]
 rcu_pending kernel/rcu/tree.c:3671 [inline]
 rcu_sched_clock_irq+0xa47/0x11b0 kernel/rcu/tree.c:2706
 update_process_times+0x235/0x2d0 kernel/time/timer.c:2473
 tick_sched_handle kernel/time/tick-sched.c:276 [inline]
 tick_nohz_handler+0x39a/0x520 kernel/time/tick-sched.c:297
 __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
 __hrtimer_run_queues+0x503/0xd40 kernel/time/hrtimer.c:1825
 hrtimer_interrupt+0x45d/0xa90 kernel/time/hrtimer.c:1887
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1039 [inline]
 __sysvec_apic_timer_interrupt+0x10b/0x410 arch/x86/kernel/apic/apic.c:1056
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xa8/0x110 kernel/locking/spinlock.c:194
Code: 74 05 e8 8b d3 cb f6 48 c7 44 24 20 00 00 00 00 9c 8f 44 24 20 f6 44 24 21 02 75 4f f7 c3 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> b3 8b 95 f6 65 8b 05 dc dc fb 06 85 c0 74 40 48 c7 04 24 0e 36
RSP: 0018:ffffc90003aafb40 EFLAGS: 00000206
RAX: c013c10a5e9bae00 RBX: 0000000000000a02 RCX: c013c10a5e9bae00
RDX: 0000000000000006 RSI: ffffffff8d03a0c9 RDI: 0000000000000001
RBP: ffffc90003aafbd0 R08: ffffffff8f1d5a37 R09: 1ffffffff1e3ab46
R10: dffffc0000000000 R11: fffffbfff1e3ab47 R12: dffffc0000000000
R13: ffffffff8e16a380 R14: ffffffff8e16a380 R15: 1ffff92000755f68
 unlock_rt_mutex_safe kernel/locking/rtmutex.c:344 [inline]
 rt_mutex_slowunlock+0x493/0x8a0 kernel/locking/rtmutex.c:1454
 spin_unlock_irqrestore include/linux/spinlock_rt.h:122 [inline]
 vga_put drivers/pci/vgaarb.c:553 [inline]
 vga_arb_release+0x3fb/0xa90 drivers/pci/vgaarb.c:1455
 __fput+0x45b/0xa80 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f40e894ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdfc93c728 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 000000000002310c RCX: 00007f40e894ebe9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f40e8b87da0 R08: 0000000000000001 R09: 00000004fc93ca1f
R10: 0000001b30520000 R11: 0000000000000246 R12: 00007f40e8b8609c
R13: 00007f40e8b86090 R14: ffffffffffffffff R15: 00007ffdfc93c840
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

