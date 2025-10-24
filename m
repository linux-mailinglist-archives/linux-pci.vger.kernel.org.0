Return-Path: <linux-pci+bounces-39289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E22C078CF
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 19:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14D2956342D
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 17:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55EF3446A4;
	Fri, 24 Oct 2025 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNFsOql5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34849254855
	for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761327054; cv=none; b=biXc70HaMu8MzJY0aXuBrYM5pLSmxkBQog9PptrDU79KoTDIGZvNiM6PkZ23N9ULkly6JLGKplCOThdncoT9nSmOjMWR2gVSnd4jr/K+RWDWrbbbEg3qAWr8A2RNnVCgBBG1voOZFxiGjXB7CpfUAF92hpS7hjhxg5+fyftseIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761327054; c=relaxed/simple;
	bh=nsZ3xho59rfJltmBY1VoMiVkLm14bUFIBqE2RDJ0hoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WXvffdtWJVGH4KptXaQkTanby4kcR8MI8q773kxJe1X/0C3i1vFjN6j8ylecCzJdqcDGum7cLYI8hoOATlBLp06nC7fP1ceehq4M6j0y7s+C1jOXxhxoJaoBLRsDmkzwUDuY3B9vJ3udS8hgoHqs3K7CJpWRDUB3ouGVj32prq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNFsOql5; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6cf3174ca4so1600560a12.2
        for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761327051; x=1761931851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsZ3xho59rfJltmBY1VoMiVkLm14bUFIBqE2RDJ0hoA=;
        b=jNFsOql5dL5bPHzWr9xYrb/OR70S8FB5UrgA7l31cx5A1Qpyt0QTKZyUKvlqSCWgNO
         xf91G20rK4ZfCVLzGCHpsgx+8CLOp+dG9oNUIccpwcH1/Pngva+EqMqkWUqA2qg6jqNF
         4NNCOWEMKKLCec6WJi/qV9yqcJs8Y3CqM3axBavT6rfPDn4U/zbr9qqTYb624eA1+aQs
         Doo4bLAINiAT2SRUTUXF7YHnodx3tv9nMcR5H8aUhEoXxCt3dHOqpNLQSWhdAmllqJFo
         fFGf1RTqg3PY04+iwnxD1Owp8k7hlgJJ2/b+alFDMIKWb6T2Gth07En8k79bXrk5Z3XL
         /Zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761327051; x=1761931851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsZ3xho59rfJltmBY1VoMiVkLm14bUFIBqE2RDJ0hoA=;
        b=qgfBkAh8+4HFgbVtOCxbQeHQe50NyOYuZseRiLlQl4uJDmbZiG4ERsZ9DVdORuPEEM
         8LAf9W74qyjxtKU0/UZo/iPrJXw/vHUWK8E3zV+zmtlLUJaB8/Pr/WSRKxyBjd3G+cel
         5zCatsS9tW9M0g+nKJrfL/45b08GWhwzyIWeSbcV+YfY0rs09CBhywCdtcHiEdWhBRqE
         yqaIiRzVARIykJuSG2kFr2fR2tTBPGFFgO5vdBBcg0xKIMH2aaSNj1BIljjW0rp1J8my
         buZrc+AYy3v0C2ehyF4YajaN5K92j9bnsWMYxrs1aP8iWEqGu4BbtIFMbHkmprOSy5wo
         H1rg==
X-Forwarded-Encrypted: i=1; AJvYcCWT7KV3G8h4CXBCqS63evzOn9MQNqf6fzbuoxI6Enk3sImhG5UbD88zobHNejmQV82PY1NLSWMXLgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuxEFyA5Xq12REnfGvpPt8LczU6qlOwrEeaR+zxsPWGi3DEdPe
	9V4mzn7rjx8nbFjQubN2DBVC54b5mWVgJ7QxP/xqnfEMBceq3kA7BHvZuu3VBcP5PQPL1fASueq
	AhonXhloIklYf89nrP+vErFLhqQfrpZs=
X-Gm-Gg: ASbGncv8KnoLYvncEVL3b5rEWUyVk/QX8/fuur6UEdCZ6Y3E5yxCPqZyWCtxY4HV5Jw
	oIGwwhkDJq5Q10ayZEbd0VtOioKf19eDh0RzNQhPB2sgeA2JKsJ8S4EmEVDXcIPgcCPi1maLWuc
	luu9TQIv6O6vGYYPe/ai35dNyQqp3hUrcaWQNLnhEzlkZBOd0Gt+/8xTyyD0G0zNYo6s0jKJf3d
	Pt+DnsIoRf5BhgKxO76BRCLD/HwbhntSUGIVO8wbCXbo1ClmglMpDIKJ89gZA==
X-Google-Smtp-Source: AGHT+IHQhnjzmGIGhBDoQ4ngdvtx/yYjY0WDUYmMTlcSQSZ0eDN1W/dXc1+Jq8Cx2TnQgYBz6MVBdKFjMRDBtJx3n+Q=
X-Received: by 2002:a17:902:cec7:b0:290:afe9:76ef with SMTP id
 d9443c01a7336-290caf8505bmr377100585ad.40.1761327051116; Fri, 24 Oct 2025
 10:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009150651.93618-1-jckeep.cuiguangbo@gmail.com>
 <20251010071555.u4ubYPid@linutronix.de> <CAH6oFv+SUo7B6nPPw=OgQ1AhqVfQYC1HvX=kjcHJX8W13kTwZQ@mail.gmail.com>
 <20251024131719.tJRyYGcD@linutronix.de>
In-Reply-To: <20251024131719.tJRyYGcD@linutronix.de>
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Date: Sat, 25 Oct 2025 01:30:40 +0800
X-Gm-Features: AS18NWDuFjVwPVmnhn7ThOaKPPOq5x-YUVnqIn4rpEZv7zoFKB8wtJ_ayD8162s
Message-ID: <CAH6oFvJ-24v2X_NrxXjYvODp_9+ZRXQQFGzWq0NcNn3Yb4-Gqw@mail.gmail.com>
Subject: Re: [PATCH v2] pci/aer_inject: switching inject_lock to raw_spinlock_t
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Waiman Long <longman@redhat.com>, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 03:17:19PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-10-11 01:18:05 [+0800], Guangbo Cui wrote:
> > I will drop the lock in aer_inject_exit, and update commit msg.
>
> Was here a follow-up?

My apologies - I=E2=80=99ve been quite busy recently and it slipped my mind=
.
I will post a new version of the patch this weekend.

Best regards,
Guangbo

