Return-Path: <linux-pci+bounces-39444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E073C0EE6F
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 16:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACCD3ADA2F
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 15:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24832D94BB;
	Mon, 27 Oct 2025 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+thIMVp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670231F5820
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577889; cv=none; b=LXuPa+nV1mNJC9k/1Gm0qYfquovu4thrPaPLziTiHIb1PCqn/hmvuLLXZw/WT5XMO0LxTsfkbVcbujCQP1AYDwGzu5HNCq+T7khAFcd3b6HHkeiqTvwxBivRVL4BvJdAxFFrTnfLFyxZ6/qzAYK0J3A6hEsrsw4kaUIVvlxb5+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577889; c=relaxed/simple;
	bh=lMeTx8WKACZxktYPopjCcShpWfkYkjFg0gmpDilv+Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URKAasuVs6G07tQz6A4gzGckxH9LQezPErkvWKAXIwfivEj7GQfdSArBxObpdOjvWpvej50BuTgPxb3YcqIeNf2YFwQWN2cw6Ulppyb0IWH9T6TefPpayKliFh+BDB2tdAkPCId5O9n6RfAHj7MkdG36bHHtW0sHyNgFRe43Qk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+thIMVp; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b550a522a49so3939321a12.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 08:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577887; x=1762182687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMXfMmOIM1+x1qfpV6gLLOVtUUnpEoN0L/vCSNSTs1w=;
        b=B+thIMVpBN16Gcx2VvajHtZJLAfJC/dNCLmb4yVo3jr6NKGTotr1p5fL/Ji6x5YxHe
         ESs8cbLxREQVayRyUs06QnKgJHPSQ2cFma8nI3cKwszNGS583LzYJ1Kdd5ANewDPONRH
         VExdztEYXKtzDzgvyl0EXjOG3T8+oKiOCVLr4TPyy5sTwg17odtixN6vHLY4TdpqqlGV
         T2H7ebjfoPC5CNp24lKawV6HQVM1yGVj14VMiK6mGWYJHdDko+F8hG2vMWdkxAsEIsXJ
         lO1qjtVzrCK/RqxcIy0lo+WMydnldlYMRqLpxo5y7Vgf+KAvj9791QHOTixfrLtJa3SF
         MNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577887; x=1762182687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMXfMmOIM1+x1qfpV6gLLOVtUUnpEoN0L/vCSNSTs1w=;
        b=g9ZWOA0cndj4mJT4Wk4kjCedRBSXoZbVnkVMTWpD9agVCGMB/69v9MZrlgs3EeNc2+
         qjzos/gDSHHumPLbN7BPnS8Hftkgj1v0KXhQU8bXqx4MJhqG97qKG3MUi6eBnQJRVgSO
         Oe/mQgN5RzSoVO6Dpj6JVqv/sIxZOCv9OF9z6eYUy0sXOHp/q7OJfpy+jjb2QzhHvmq9
         VrbVWtThm1rOFWpI6S93QigPg8+lRr0eY7wH+yi7rcl7j4MZ7kri7HwkbgDPPUuEESyp
         xBgD49GBVmhwFTQFH1M07ruNn3TDqoGeU8kPf1KJDzYc7DbbM4ZNo9qPEUGoYzEtsOoj
         evKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMZxQcwOVGhj+NLZCSgUsqFfD5HoIYQ1bN6O8DVbtCNPEyXSH2Qt8jBiva7rgyZjp/MaDTEP5MFAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBKmu/TN/CJZ/n+jXPTjBLLws7II6mCzdikQ5wmfbFOsaP/uXf
	UjxFItKEJRxCB3wpqOw7Ea0oKFw6KrI6gjbPB35UI2WcLttpJhlfywZ2ld2kYg3n/qqkpMbu6aB
	tBQW0F94oU/Epa79gmxWjSxNHKdI1K0Y=
X-Gm-Gg: ASbGncsbqhpgiTaTYVPTZV6XXNsdMyGd1Lei7ZTRR/TP+MaBIdMNnrVMJ2tw95dTuzN
	fInEPKEKiKcPq919FIVBfgMqqhi76++bEbBAcj0hF2JJ/OHHz9n+lquxwn/cL+Pnxn0qlAGPHKy
	VmfCTHCMF6VVUFJJbieVg7hGflSiYHX+MCI9cj+zGlEDjnx7bQfPOS+7lof6vNn3NZjb4NF3muc
	NnYFzDPKjgffa2s4IJpEEvl4kaYDdhbR4pYm/sZTKd0ba3gRAnFMLq6k8skLKGrsTkaYV8=
X-Google-Smtp-Source: AGHT+IHvEIpzH61YALLxG8gdFqbGgN4XUy+Tq01KU2r2KGY59iowe6I+O3qMno8P0Baluus2Jy1haBpQChfxeUeLEjQ=
X-Received: by 2002:a17:902:d4c6:b0:290:c516:8c53 with SMTP id
 d9443c01a7336-294cb51bbdbmr2289265ad.40.1761577887232; Mon, 27 Oct 2025
 08:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
 <20251026044335.19049-3-jckeep.cuiguangbo@gmail.com> <20251027081125.n7far5BO@linutronix.de>
In-Reply-To: <20251027081125.n7far5BO@linutronix.de>
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Date: Mon, 27 Oct 2025 23:11:16 +0800
X-Gm-Features: AWmQ_blGbxBV7S4l3PmDu4W7QBNWl1J0weVSFn5wNOneG3HXMQQG5CZN34vqzOU
Message-ID: <CAH6oFv+pqPx_0Q=bRmoi4vwxeXmt_D0gQGtxprL_8G43j5pC8w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI/aer_inject: Convert inject_lock to raw_spinlock_t
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Waiman Long <longman@redhat.com>, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 09:11:25AM +0100, Sebastian Andrzej Siewior wrote:
> > @@ -445,7 +445,7 @@ static int aer_inject(struct aer_error_inj *einj)
> >             rperr->source_id &=3D 0x0000ffff;
> >             rperr->source_id |=3D PCI_DEVID(einj->bus, devfn) << 16;
> >     }
> > -   spin_unlock_irqrestore(&inject_lock, flags);
> > +   raw_spin_unlock_irqrestore(&inject_lock, flags);
> >
> >     if (aer_mask_override) {
> >             pci_write_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK,
>
> This is the last hunk. You miss the module exit part. This won't
> compile on its own, as such it can't be applied. It might be chosen for
> a backport. A change must always be self-contained.

I haven=E2=80=99t yet developed the good habit of keeping each patch fully
self-contained. I will fix this in the next version.

Best regards,
Guangbo

