Return-Path: <linux-pci+bounces-4883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9550587F621
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 04:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3551F22825
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 03:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A2C7BAF3;
	Tue, 19 Mar 2024 03:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dP83CJga"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A137BAF0
	for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 03:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710819795; cv=none; b=RxipN1+kzvQOuvZVww/7NlaPVSPQiRlpoIOtnvRJyDg8QElJ16s47pYLLcC1zgVi9LkOBH1Bo4pX5wqvFRIvJr8/PgkgpMcuSpu89HDHia5fc5wLjqU8/sEr0IQIkdFaqdVIhXoW+rGIxkRsZUrkbaUZgLo0rmX2rjZB7rOgZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710819795; c=relaxed/simple;
	bh=CD1/1bx1d+TCuzdjE9iD5vdGj7PVRGdrxserarbTZ4A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qSriPcPNwhCsRgcJx5fpC2KZunlx2vPxI6ZXwnC+VNnIlPW3gbneqCEDXCGY62hLeB7h8Um2BJS1Cd7fel82K0MtPDZHxz87mTqOA90N/aIw6bH/oju13XuQV+7Imix+jMw64sdCITz5mSshVru91YliD0oUdAq7l2TsZK2iyFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dP83CJga; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710819792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=u38Nh3pjPy9Y9iwMv9MFkRdHFhaI4/PvTKYwXfaYKOk=;
	b=dP83CJgaMNr2gIhMO5wPT5sC7YbFCtSoC8Y89dTd17qwVcCh+LEpeO0WQlnAs/hufnsy7u
	yB5PZjTcVcSy2fbZhyeSmv2MAG/mL7m1AUL5FbWLm1NlDl0Byu4MPtK3DOLQjlqX1HmXOr
	dPkiY7VnDPGZN6wLcDCMLA1qmgWYdmA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-S5CyNhGXPuWOZbNoBOmdgA-1; Mon, 18 Mar 2024 23:43:09 -0400
X-MC-Unique: S5CyNhGXPuWOZbNoBOmdgA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29bad31f920so4329203a91.0
        for <linux-pci@vger.kernel.org>; Mon, 18 Mar 2024 20:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710819788; x=1711424588;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u38Nh3pjPy9Y9iwMv9MFkRdHFhaI4/PvTKYwXfaYKOk=;
        b=Bo4rdmlqIdPk73uNvELwhCo6D91G2qRynvRo9l10wCX8xUwjUhUJhMqyZT6imnmQDg
         R+b8TI/M81E4ULwiY/E3+7lHMXbROWAAFyNf02WE4TFRHeo/7yspN/3cPtoBLRj9PPN3
         /Mg/IaibQTQoDqd2TL7jaDCu584IXa2IabSehIIR1ZJ9wdEa9IpBKsVVaOMa7nDDtZWt
         QehHpzUX51PLZ7LNdmsuDc6Ek/BgWfmTGraPi9ehlvUwnNwg91Lv/fIOZ97ckXPWmPUs
         wA0f9D9SuG0hhytOV9KnfvVDyGTf2DZf9lP4hXPVsnaf/qFViRuiDVZzT84as8kho/fJ
         kjAA==
X-Gm-Message-State: AOJu0Yx3pfU4q9qEhrZv3DPBgoAWQGIHUSr2MRniOBN9j/fHUpeD9ZU9
	kP+2lvwIo2EGeI1K9VeQW/cAhbbfbybNLYqt1DjvUikx3Bf1tESwjYm03c/MvFywqVOfQp5Ajdc
	HZdGtq1+lmtBN7UmyrMqxI7V8wv0EQjri1NPbPbD1vs3QOYC1c0VC+oWHyIXnvBE7BGc8rzfVXr
	suvyl9JkFO+Qm63DGmRlbC9R79/e/1ePPCrNswaUghTUtglA==
X-Received: by 2002:a05:6a21:318b:b0:1a3:6a71:8282 with SMTP id za11-20020a056a21318b00b001a36a718282mr3175278pzb.0.1710819788739;
        Mon, 18 Mar 2024 20:43:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO5j7+YDTAtkLNqOIKQWwpCEGsGU/O5fjDQl6kwbNKyt7qamRN0EJdqF96gK2qEFWcA2guwOvr1ke519WhNag=
X-Received: by 2002:a05:6a21:318b:b0:1a3:6a71:8282 with SMTP id
 za11-20020a056a21318b00b001a36a718282mr3175268pzb.0.1710819788354; Mon, 18
 Mar 2024 20:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Changhui Zhong <czhong@redhat.com>
Date: Tue, 19 Mar 2024 11:42:56 +0800
Message-ID: <CAGVVp+U+s692sC8-ioGQ7aP2shhQ6qyGOThVk=L6P4_XovDo5Q@mail.gmail.com>
Subject: [bug report] WARNING: CPU: 0 PID: 1 at kernel/resource.c:834 __insert_resource+0x84/0x110
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

found a kernel warning issue at "kernel/resource.c:834
__insert_resource+0x84/0x110" ,please help check,

repo:https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
branch: master
commit HEAD:f6cef5f8c37f58a3bc95b3754c3ae98e086631ca

 [    0.130164] ------------[ cut here ]------------
[    0.130370] WARNING: CPU: 0 PID: 1 at kernel/resource.c:834
__insert_resource+0x84/0x110
[    0.131364] Modules linked in:
[    0.132364] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0+ #1
[    0.133365] Hardware name: Dell Inc. PowerEdge R640/06DKY5, BIOS
2.15.1 06/15/2022
[    0.134364] RIP: 0010:__insert_resource+0x84/0x110
[    0.135364] Code: d0 4c 39 c1 76 b1 c3 cc cc cc cc 4c 8d 4a 30 48
8b 52 30 48 85 d2 75 b7 48 89 56 30 49 89 31 48 89 46 28 31 c0 c3 cc
cc cc cc <0f> 0b 48 89 d0 c3 cc cc cc cc 49 89 d2 eb 1a 4d 39 42 08 77
19 4d
[    0.136363] RSP: 0000:ffffb257400dfe08 EFLAGS: 00010246
[    0.137363] RAX: ffff9e147ffca640 RBX: 0000000000000000 RCX: 0000000026000000
[    0.138363] RDX: ffffffff86c45ee0 RSI: ffffffff86c45ee0 RDI: 0000000026000000
[    0.139363] RBP: ffffffff8684d120 R08: 0000000035ffffff R09: 0000000035ffffff
[    0.140363] R10: 000000002f31646f R11: 0000000059a7ffee R12: ffffffff86c45ee0
[    0.141363] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    0.142363] FS:  0000000000000000(0000) GS:ffff9e1277800000(0000)
knlGS:0000000000000000
[    0.143363] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.144363] CR2: ffff9e1333601000 CR3: 0000000332220001 CR4: 00000000007706f0
[    0.145363] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.146363] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.147363] PKRU: 55555554
[    0.148363] Call Trace:
[    0.149364]  <TASK>
[    0.150365]  ? __warn+0x7f/0x130
[    0.151363]  ? __insert_resource+0x84/0x110
[    0.152364]  ? report_bug+0x18a/0x1a0
[    0.153364]  ? handle_bug+0x3c/0x70
[    0.154363]  ? exc_invalid_op+0x14/0x70
[    0.155363]  ? asm_exc_invalid_op+0x16/0x20
[    0.156364]  ? __insert_resource+0x84/0x110
[    0.157364]  ? add_device_randomness+0x75/0xa0
[    0.158363]  insert_resource+0x26/0x50
[    0.159364]  ? __pfx_insert_crashkernel_resources+0x10/0x10
[    0.160363]  insert_crashkernel_resources+0x62/0x70
[    0.161365]  do_one_initcall+0x41/0x300
[    0.162364]  kernel_init_freeable+0x21e/0x320
[    0.163365]  ? __pfx_kernel_init+0x10/0x10
[    0.164364]  kernel_init+0x16/0x1c0
[    0.165364]  ret_from_fork+0x2d/0x50
[    0.166364]  ? __pfx_kernel_init+0x10/0x10
[    0.167363]  ret_from_fork_asm+0x1a/0x30
[    0.168365]  </TASK>
[    0.169363] ---[ end trace 0000000000000000 ]---

Thanks,


