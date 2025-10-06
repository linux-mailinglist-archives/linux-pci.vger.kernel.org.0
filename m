Return-Path: <linux-pci+bounces-37637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA87BBF2B8
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 22:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7145189A7C5
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 20:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F082D3EF6;
	Mon,  6 Oct 2025 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULy6q4kH"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E31C258CF2
	for <linux-pci@vger.kernel.org>; Mon,  6 Oct 2025 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759781941; cv=none; b=MJ8ACt/qytgGVlDRUMtKDiVAdYXldyE0/gmQrkgItPDKt1xPZU6jiOpshvud2pnqZN6LiOgesdNEs7Ot0NEnQv7uJWAg82oyLPGCKK+Fw67jrJ3x53g1vAF6Q+9YguLJcPUJKYo4F8pgP5x53dnIgGnYtQytKaqEh7oCZ8VHCE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759781941; c=relaxed/simple;
	bh=5eQEIeNJ5EZYkPz01gAZjijISqu7bO+HYt1McJx8mUA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MrafNMHzx85RHlBJq3P6aa2RTV4i3wWjj/mQfidwglDolcfMg8Uwa/YeyL/JyUydtwglDiW5S5A7A0IH7Ka5Vy5aNvg3fQ+fCkDCTb3fmGjiyOSPVk1psSDTT0DuxXGcp2mQofO4h4Sq992tjTiweMqYmJqlAi8lAXf2P5e3BjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ULy6q4kH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759781938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRDjOk2UJBNY8OM4uijGV6YLvmoMX0A5enzMiF12TZI=;
	b=ULy6q4kHqn7YpzhWAGL4h+pFcUyOHhejcWEfozNt6kSThbJ0fbXAfA1qik0IkXD0nSVz0n
	neVGeDgT2rm5WUnalkON//yDV15Wvijjf65EuVUYzok2ot9NzkNN3oxnHv8BR0iE8cwapJ
	cbySL1xubi5DefOqBbQ0VS4O+ktk0Gg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-dkuJ7kAjMD-H03SJGH8iGg-1; Mon, 06 Oct 2025 16:18:57 -0400
X-MC-Unique: dkuJ7kAjMD-H03SJGH8iGg-1
X-Mimecast-MFC-AGG-ID: dkuJ7kAjMD-H03SJGH8iGg_1759781937
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-863cd58a92dso1157899185a.1
        for <linux-pci@vger.kernel.org>; Mon, 06 Oct 2025 13:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759781933; x=1760386733;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRDjOk2UJBNY8OM4uijGV6YLvmoMX0A5enzMiF12TZI=;
        b=Ri6HQxLBrY02cYEegw/5u2SKE+T8fDugzxgQXUuV4+9Cot1Q4iitQeevBWnEl3pfgw
         cezU1lK/7y6lsv8W9F8Dp0bTJIGMKlY8N6BzjCYd+ZxR9Z5KZZjh9tkO/0MLxttJhObD
         p3E9Ck1IkKtYuRDqRZGqjCaTSvyCi9rRnNv4xF3sPjh/4XpB/9GfqPqUwzmKE8vFnX2P
         PFc2MydYfPToZa+ALJXHr5Ek0jaZNGzJHV1jlK0m2SvnuvNSwm/l1sJKToPJr1QG7EnN
         kmpiUNGNfshUfOUG8VBVu7xOcQweldZCVtduL76YmjtSm9xY+TmyBo6olKfjBl61uO9a
         qRQw==
X-Forwarded-Encrypted: i=1; AJvYcCXHWijJnXd50cbM4UJoMJ3uiNt6Hxh0ImLGuruw49EqZ0jI/8C/VErlLaNQyHwEIsUKdwmUzupWyG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2fjPEJqJ1y0+BVsbIbLstR09T3PVnYloznRkkO6ob/sI6bsmj
	vSkd0Nm0gnC3ZokPdV12Vyr507940vLMZWh0EFj8LOIiNCePHPp8oRsr6qMNGbYAn3sp1i/JGKj
	gFuhn6cx2ZMuuY+u+VSFXej+tYe0YjbqLj4f1+fUcwwghRDGE9ZA2hE+ILQnDlBShbTaeGg==
X-Gm-Gg: ASbGncs0Kw0QlF7rDKcj6AriaSOdsg8AyuBEiG4QFIg5alVwnCBENJsIt9z1H+DIvkb
	E8HRm74FxflJsntYY4mxYEOF9qdcnas5ckjQL/xAMRX1kKdIfucq55QMtHKKEAEHT5gz6TCskwa
	nhaaCYXqao2TtLo2poCSagw3CYixqMEnlgwgWqld5Q8RFn9HLag+dUOMkx/giWGqK9gBGllO66n
	tPlZk3pOtd8W9AxiDU3Y1c+2hoU79j6S/oyW2F5fUzgZYzK+cD4DGFZi81HWbKdvDfYlWLgnKF1
	vkKaeSlFQnhT92acJZKOG6C+KgRcLQZnLc3UmiFhIIZeSje2cGqsxF02EvmgS2OQ2DRs4iGb6fv
	sIfz5c66OaUGLzMlW
X-Received: by 2002:a05:620a:1707:b0:84b:ebcf:56a3 with SMTP id af79cd13be357-87a34aa4516mr1588124685a.21.1759781932761;
        Mon, 06 Oct 2025 13:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1dgJjNLxpPDAd6SOq/4Amrbct/qwou5kIt8RniF4E527vSqzwcPOgDR30Aenfez80Nn+SaQ==
X-Received: by 2002:a05:620a:1707:b0:84b:ebcf:56a3 with SMTP id af79cd13be357-87a34aa4516mr1588121585a.21.1759781932301;
        Mon, 06 Oct 2025 13:18:52 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-877725550b3sm1380084485a.26.2025.10.06.13.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 13:18:51 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0bfeee57-d0dd-4480-8539-0ae5d7d4ea04@redhat.com>
Date: Mon, 6 Oct 2025 16:18:50 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: Account for lockdep hardirq context in
 irq_forced_thread_fn under PREEMPT_RT
To: Guangbo Cui <2407018371@qq.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <tencent_B5CE9A8654E8B2476383AEC85C25BDA7BD05@qq.com>
Content-Language: en-US
In-Reply-To: <tencent_B5CE9A8654E8B2476383AEC85C25BDA7BD05@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/25 2:34 PM, Guangbo Cui wrote:
> In PREEMPT_RT, IRQs are forced to run in threaded. However, lockdep did not correctly
> account for this case, causing false-positive warnings about hardirq context violations
> when analyzing lock acquisition in such threaded IRQs (see function `task_wait_context`).
>
> This patch updates `irq_forced_thread_fn` to explicitly call `lockdep_hardirq_enter()`
> and `lockdep_hardirq_exit()` when PREEMPT_RT is enabled, ensuring lockdep correctly
> tracks the hardirq context even when the IRQ is executed in a forced thread.
>
> This was discovered while testing PCIe AER error injection on an arm64 QEMU virtual machine:
>
> ```
>    qemu-system-aarch64 \
>        -nographic \
>        -machine virt,highmem=off,gic-version=3 \
>        -cpu cortex-a72 \
>        -kernel arch/arm64/boot/Image \
>        -initrd initramfs.cpio.gz \
>        -append "console=ttyAMA0 root=/dev/ram rdinit=/linuxrc earlyprintk nokaslr" \
>        -m 2G \
>        -smp 1 \
>        -netdev user,id=net0,hostfwd=tcp::2223-:22 \
>        -device virtio-net-pci,netdev=net0 \
>        -device pcie-root-port,id=rp0,chassis=1,slot=0x0 \
>        -device pci-testdev -s -S
> ```
>
> Injecting a correctable PCIe error via /dev/aer_inject caused a BUG
> report with "Invalid wait context" in the irq/PCIe thread.
>
> ```
> ~ # export HEX="00020000000000000100000000000000000000000000000000000000"
> ~ # echo -n "$HEX" | xxd -r -p | tee /dev/aer_inject >/dev/null
> [ 1850.947170] pcieport 0000:00:02.0: aer_inject: Injecting errors 00000001/00000000 into device 0000:00:02.0
> [ 1850.949951]
> [ 1850.950479] =============================
> [ 1850.950780] [ BUG: Invalid wait context ]
> [ 1850.951152] 6.17.0-11316-g7a405dbb0f03-dirty #7 Not tainted
> [ 1850.951457] -----------------------------
> [ 1850.951680] irq/16-PCIe PME/56 is trying to lock:
> [ 1850.952004] ffff800082865238 (inject_lock){+.+.}-{3:3}, at: aer_inj_read_config+0x38/0x1dc
> [ 1850.952731] other info that might help us debug this:
> [ 1850.952997] context-{5:5}
> [ 1850.953192] 5 locks held by irq/16-PCIe PME/56:
> [ 1850.953415]  #0: ffff800082647390 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x30/0x268
> [ 1850.953931]  #1: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
> [ 1850.954453]  #2: ffff000004bb6c58 (&data->lock){+...}-{3:3}, at: pcie_pme_irq+0x34/0xc4
> [ 1850.954949]  #3: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
> [ 1850.955420]  #4: ffff800082863d10 (pci_lock){....}-{2:2}, at: pci_bus_read_config_dword+0x5c/0xd8

data->lock is a rt_spin_lock and pci_lock is a raw_spinlock_t with irq 
disabled. So the data->lock => pci_lock sequence is OK. However, 
inject_lock is a rt_spin_lock again. So you can't acquire it with a 
raw_spinlock held and interrupt disabled. It is something that needs to 
be fixed not worked around as if it is OK. It is not a false positive.

Cheers,
Longman


