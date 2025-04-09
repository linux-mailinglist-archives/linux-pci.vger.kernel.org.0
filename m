Return-Path: <linux-pci+bounces-25550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A42EEA82142
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 11:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90DD24C22A6
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 09:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD4125522F;
	Wed,  9 Apr 2025 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r8aO4zvm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4645525D214
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744191958; cv=none; b=gwbwdc2REpQamDoEPybqpBGt5TBOUX3AGsAXlqCjxHd90iRilyke+gUPGVg1pQ/UB88wcenArvWnx2AnflQN085yttCm8q2BSsCG0D1x8UFnl6a+4TsDQaT6Pfojz1/ht/O1AZ33ys0XR0q5dY3y7dFomajVd/loWAfHwornJxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744191958; c=relaxed/simple;
	bh=jbY8OFRGtCS3qGB2dY7IOuwbUBWjbDPtzPyd0O8E/WA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ixWZR2WaGsB/9PjRISn9k0uD7aPmPxP0zR1fOBSQsIL+6sfQ3URfrv1K93wV6Wt1TRvjeuVkBS/AqP3mawys69MWII+TKCeJL4Hl6BYL1P/qA4gTnSbQJAFOQeKrdIcINPRlzI6y7OdbTB/5uAOQ7+fUscL08orWbjD51SvEEn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r8aO4zvm; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-39c2da64df9so4365308f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Apr 2025 02:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744191954; x=1744796754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbY8OFRGtCS3qGB2dY7IOuwbUBWjbDPtzPyd0O8E/WA=;
        b=r8aO4zvmzxwWaruksoc0zgn83lutnuIMskxjEAoafYbf/yG5XzD82W4K/ESlugpz2H
         sfpgLEa5qdi0SdCzUyOcGodp3trJ3WpKd/kQ6aMXUcVxDqH1+D/FfTxm9lDxrPEOuaTf
         yfysVF8uv87aI7CTTiSOodxdGdYzraoFnxm4hj2l43KNAEav2RT5EzBolLmdqB+uuodf
         tCvg6EP5/3QpVPzVKQ/VVMNlG1f85K7IINkRxlfhE/SORvGdvm69UH2RUcf9zYJlejiy
         EJv+FVXE0eMO2EJhQ1CZ2yzRZzIdoB10qvY5HfbKIe1WcmfHWx2I1zUSalsnGSTcliAw
         /mWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744191954; x=1744796754;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jbY8OFRGtCS3qGB2dY7IOuwbUBWjbDPtzPyd0O8E/WA=;
        b=ItmZ0r+fYeMuwXiYIKXPGb4gHU+tXmI3bGhsaHqSBuU5sybXIc+FLoHmHx89t/YG/9
         R2Lkef3mKLamWGn93w4BPC3I1mFGhuo8hcHWz43d+jH50TF0pDSfiLVnINzJ2xzs7bhr
         fI3geT5Od7nyptNsDxOVyVjo+TbAJYskFStF0t/XEkHt6edVAqraDglJfmcIk1pyOoUv
         rq1WbmHvF+yMwOkrxWExjBBYomF+V2aCSpkZr7whsM26X5qpTXY/y/t9ZgmW6q2NaPak
         Cfh591R3p+lfd35JB0gQXNojHPKuO2WNqtoE2qKPft2RoFA3df8XjX4l1449o1TLHCSi
         eoKw==
X-Forwarded-Encrypted: i=1; AJvYcCVva57GD7J4y8qvOYWQMU6gtb62ETle5HgtT7J88Om/SOrEgzGFQXM/q1qsn8Sndh4iaAMk6ssgWg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQJjf/Pws3LXwwnPqxWAnhNYOg6FZmW9m3KsK+BiM51LuhWj7P
	GhX+33stmUeNb8Vx/fxkxzQnoYkJRw+jFejGI4vdoBlVuo7suE2/Vd68zMvi5uLTAEyAAr7loiY
	8qnKieXdMqZaKiQ==
X-Google-Smtp-Source: AGHT+IFU5PtqYzywsfZTZnvn0+eGgwmBOUG2VhP8fojRJNHYDCxKaO4/6DkqMYUH/KrEpuJdW/spl9clwX6DMWQ=
X-Received: from wrbdi7.prod.google.com ([2002:a05:6000:ac7:b0:39a:bed5:1512])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2ca:b0:39c:30cd:352c with SMTP id ffacd0b85a97d-39d88525afamr1619648f8f.8.1744191954414;
 Wed, 09 Apr 2025 02:45:54 -0700 (PDT)
Date: Wed, 9 Apr 2025 09:45:52 +0000
In-Reply-To: <CAJ-ks9njZbqRFVXTFkG1ms2UxsHtym+gP6Od-Hz+=sj+VeTX3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250307-no-offset-v1-0-0c728f63b69c@gmail.com>
 <20250307-no-offset-v1-2-0c728f63b69c@gmail.com> <Z9gIvLY1uubS6OX-@google.com>
 <CAJ-ks9njZbqRFVXTFkG1ms2UxsHtym+gP6Od-Hz+=sj+VeTX3g@mail.gmail.com>
Message-ID: <Z_ZB0BZuugdjsBR3@google.com>
Subject: Re: [PATCH 2/2] rust: workqueue: remove HasWork::OFFSET
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 07:35:55AM -0400, Tamir Duberstein wrote:
> On Mon, Mar 17, 2025 at 7:34=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > Overall looks good to me, but please CC the WORKQUEUE maintainers on th=
e
> > next version.
>=20
> Thanks! Does there need to be another version? No changes have been reque=
sted.

Yes, it needs a new version to fix conflicts with commit 7b948a2af6b5
("rust: pci: fix unrestricted &mut pci::Device") that landed in the
merge window just now. More generally, a new version is also recommended
if maintainers are missing in the CC list.

As an FYI, I'm looking to do some additional work on the workqueue
abstractions to support delayed work items for use by GPU drivers. Since
I agree with this change, I'll base my work on top of your series.

Alice

