Return-Path: <linux-pci+bounces-17389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DB09DA287
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 07:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345A51649D5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 06:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3FA144D0A;
	Wed, 27 Nov 2024 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgqLnyJX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E4B13BAE4
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 06:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732690633; cv=none; b=iwLZFmh0E4atuGTRjbrD+6Reug5ZNpRnJqaritpxmQXBoNQv4h9wjmv3yhIIbY0ZfzhMLqCT7TgE+jc22rqpFxL9jRIi/N3XhYorliQxHvJFsOl7uGhX0AvU3BYK/Lbp0yIdixLmwaC1jESBZn1BrdwWxcXYUOksvLVoGLM8HOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732690633; c=relaxed/simple;
	bh=1iDQwyxsVBm3G7i0Sf1kwnVSt3fxxMTAzWdY7jRmaEA=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=a4qvhY0aqbhpmMQyjUkIIgEDbHrpo23UXDfkFW/R69JEWjp6q6AdFobsvTQicFonbL1j7SraMFTGhGMSJ6KKkA2gBkgTNjSUX/i8rGskxJfFrptOYX5xkhz4vqs+9dNbmpDMHxsvHktO6YQo6ygQ3HXJxz6F15MrJbdoQQ1r0Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgqLnyJX; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-720cb6ac25aso5284202b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 22:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732690631; x=1733295431; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RXhYw2mO4o75ZSR9AXTguwhpgaoi+ZdT7OPTfLh1SZA=;
        b=KgqLnyJXY3AZPw5Uwrsb6FC1kFhy6M7LWDkgyJnyNeUmpz410rtBpacTJA5eANujkg
         AHEtBTeXU9xeCYBiiufTAHft4qxcECeL0bih84ytZNtgRXOKPfOv51AbikjBHjOgA76T
         IJX3HrtmYbvi1Ca6Oh6lV0MDpF5Hg/yj7XwQS8/YKqeGScbXXAn2VU7jcURtECkn2CYQ
         RcBES8eL4PLDCSoM/dz/qGNkYEdhQkEwWReomTzlIFtSgqH+XX8/+awjs+PXJP8F9BzP
         Bk9JJmBYl+yLupGegqzDFPnF8M2YccaNe21+eGzOBuBU2s8dTy7iM8lAhbhA1xb1fGup
         nMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732690631; x=1733295431;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RXhYw2mO4o75ZSR9AXTguwhpgaoi+ZdT7OPTfLh1SZA=;
        b=IpF1Zaqv4LXjXxm1M97rHv+/1aasQcdKI0GdaBPeVerO5UU5jjhN8wDMYcId85UUT/
         zZV60TzziwjDFyT1mBj5KciB/mxOVcEvH7ffLomC2L1YVkJOXBKUtuJukCwp6ORn6Tv2
         KjMCJoR0hLAPpzttsnUMyxW5bSEkrpJPVVLM3Fj7vae5zt6BgdIdDhIm4sZsm8t4GnOH
         0QO+0Mt/HUw3jYJuQEDKgx3GxHIY6NDu1T3Rj5OgjjZ25KpM8+teX3kmbp6bmpLBaQTF
         bOOQ+2b6pZhMpnrmPsYGi6XIzrdVYFIVfGt8OfC3u2qPAlKo0Z5tuvv8debR7Z0y78sP
         PBwg==
X-Gm-Message-State: AOJu0YyeqwGlknrMTMylBXO6x+9bDxweJkoPl7jhHUE3funnwCdWyI9U
	seLeK2jUIucL26YnWznjGmy+daKWzDrpUCyIBwPnvLy0TrWH7CvmGtMPsHN0
X-Gm-Gg: ASbGncvPFfZ86gEemMoDkhlezwfCS0R5L/+QnFnvjDI/TxmNinPWHq4m6+rufbVUkD8
	meP+UH38paG7qSMgd3Afsdm7z3kPxaqGeKM3Q/bfHPe/LS7QfUg++t6AbLT2J9LdbL/QPDJlyFG
	Fkr9OC7hIxoqb/RWti0DYCVHH4LzlRYxfn1LLVHOgvoHa86GQCpsaOd3L7rLZqjShA+X41K8SB1
	NKUCW+DS59DRyD6VxND/I1YimSaJWeY7DzkfZzFu8xLjFOkcxgJig==
X-Google-Smtp-Source: AGHT+IGWpMRV/93yDVikpt7xTDmRUkQhJCcMv2VAUadCF18nNSPlmApfZdQSolRfSS7F979adBPhRw==
X-Received: by 2002:a05:6a00:21ca:b0:724:f51c:8dc2 with SMTP id d2e1a72fcca58-72530024862mr2277677b3a.9.1732690631277;
        Tue, 26 Nov 2024 22:57:11 -0800 (PST)
Received: from smtpclient.apple ([2404:9dc0:cd01::14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de559763sm9519232b3a.162.2024.11.26.22.57.09
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2024 22:57:10 -0800 (PST)
From: fengnan chang <fengnanchang@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Deadlock during PCIe hot remove and SPDK exit
Message-Id: <D0B37524-9444-423B-9E48-406CF9A29A6A@gmail.com>
Date: Wed, 27 Nov 2024 14:56:57 +0800
To: linux-pci@vger.kernel.org
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Dear PCI maintainers:
   I'm having a deadlock issue, somewhat similar to a previous one =
https://lore.kernel.org/linux-pci/CS1PR8401MB0728FC6FDAB8A35C22BD90EC95F10=
@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM/#t=EF=BC=8C but my kernel =
(6.6.40) already included the fix f5eff55.=20
   Here is my test process, I=E2=80=99m running kernel with 6.6.40 and =
SPDK v22.05:
   1. SPDK use vfio driver to takeover two nvme disks, running some io =
in nvme.
   2. pull out two nvme disks
   3. Try to kill -9 SPDK process.
   Then deadlock issue happened. For now I can 100% reproduce this =
problem. I=E2=80=99m not an export in PCI, but I did a brief analysis:
   irq 149 thread take pci_rescan_remove_lock mutex lock, and wait for =
SPDK to release vfio.
   irq 148 thread take reset_lock of ctrl A, and wait for =
psi_rescan_remove_lock
   SPDK process try to release vfio driver, but wait for reset_lock of =
ctrl A.


irq/149-pciehp stack, cat /proc/514/stack,=20
[<0>] pciehp_unconfigure_device+0x48/0x160 // wait for =
pci_rescan_remove_lock
[<0>] pciehp_disable_slot+0x6b/0x130       // hold reset_lock of ctrl A
[<0>] pciehp_handle_presence_or_link_change+0x7d/0x4d0
[<0>] pciehp_ist+0x236/0x260
[<0>] irq_thread_fn+0x1b/0x60
[<0>] irq_thread+0xed/0x190
[<0>] kthread+0xe4/0x110
[<0>] ret_from_fork+0x2d/0x50
[<0>] ret_from_fork_asm+0x11/0x20


irq/148-pciehp stack, cat /proc/513/stack
[<0>] vfio_unregister_group_dev+0x97/0xe0 [vfio]     //wait for=20
[<0>] vfio_pci_core_unregister_device+0x19/0x80 [vfio_pci_core]
[<0>] vfio_pci_remove+0x15/0x20 [vfio_pci]
[<0>] pci_device_remove+0x39/0xb0
[<0>] device_release_driver_internal+0xad/0x120
[<0>] pci_stop_bus_device+0x5d/0x80
[<0>] pci_stop_and_remove_bus_device+0xe/0x20
[<0>] pciehp_unconfigure_device+0x91/0x160   //hold =
pci_rescan_remove_lock, release reset_lock of ctrl B=20
[<0>] pciehp_disable_slot+0x6b/0x130
[<0>] pciehp_handle_presence_or_link_change+0x7d/0x4d0
[<0>] pciehp_ist+0x236/0x260             //hold reset_lock of ctrl B=20
[<0>] irq_thread_fn+0x1b/0x60
[<0>] irq_thread+0xed/0x190
[<0>] kthread+0xe4/0x110
[<0>] ret_from_fork+0x2d/0x50
[<0>] ret_from_fork_asm+0x11/0x20


SPDK stack, cat /proc/166634/task/167181/stack
[<0>] down_write_nested+0x1b7/0x1c0            //wait for reset_lock of =
ctrl A.
[<0>] pciehp_reset_slot+0x58/0x160
[<0>] pci_reset_hotplug_slot+0x3b/0x60
[<0>] pci_reset_bus_function+0x3b/0xb0
[<0>] __pci_reset_function_locked+0x3e/0x60
[<0>] vfio_pci_core_disable+0x3ce/0x400 [vfio_pci_core]
[<0>] vfio_pci_core_close_device+0x67/0xc0 [vfio_pci_core]
[<0>] vfio_df_close+0x79/0xd0 [vfio]
[<0>] vfio_df_group_close+0x36/0x70 [vfio]
[<0>] vfio_device_fops_release+0x20/0x40 [vfio]
[<0>] __fput+0xec/0x290
[<0>] task_work_run+0x61/0x90
[<0>] do_exit+0x39c/0xc40
[<0>] do_group_exit+0x33/0xa0
[<0>] get_signal+0xd84/0xd90
[<0>] arch_do_signal_or_restart+0x2a/0x260
[<0>] exit_to_user_mode_prepare+0x1c7/0x240
[<0>] syscall_exit_to_user_mode+0x2a/0x60
[<0>] do_syscall_64+0x3e/0x90


