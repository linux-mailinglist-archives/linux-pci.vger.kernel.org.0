Return-Path: <linux-pci+bounces-34108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5E0B27FEC
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 14:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6638BA07882
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 12:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026AD2882A2;
	Fri, 15 Aug 2025 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckHTp2sI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA92571C9;
	Fri, 15 Aug 2025 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755260480; cv=none; b=r25zjlEojWAt38xpCenzZVNo0ssnucQ0zHKaV1upAmSJCKmiyXxn1/r0ysihZdDPwQjxOh8/WWi2CPjWgT+3wly043p1x3EI0cjyduY9Ex/AcBCuDtDgZ4KgQPzUDs0363hMHmSkNC9+RWO4WLvtKQJq7Yz6v0Zye6HRXqKBJWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755260480; c=relaxed/simple;
	bh=P4figdk8mZgw6RRlsEtijc620F/GpPb7iGjJYsk04XY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWOg5AZR6WiVuiPyAlhUQbKIosg5TeZ9MjEWFAk2RuM8p9YWRl31ouxqh56QD+L2awXE9hv1v+gP2C1jniE0Whkqt3cy61xysJDBBAjwjRPCMQLawrYabxNoXvVKdsFTrEdrnBo36uV9lyvFvQv9LaBMTDQb4FPDw8rZmgh5rJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckHTp2sI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-244581eab34so3009845ad.2;
        Fri, 15 Aug 2025 05:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755260479; x=1755865279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4figdk8mZgw6RRlsEtijc620F/GpPb7iGjJYsk04XY=;
        b=ckHTp2sIwltOpPIMreklF79AF0dyLjumsPgjmUGiv+s6MektdJQSamKyB/gMoRok8a
         XadixAoatE9vuSTSTfpt6+KpdDfMSHX+p2tyrQpr9vQ11+LQb+Ctip56xGVfqJJvePEC
         I1iPK9vUiTr/g+M/Vw67lZ9AVtxUW5qjP4ErRB+rkZGAAb9YZAxiOLUTkOlih00ycLw4
         kgEHeV0KJWN45YTY34eyflI75rkixwfrpyZDeyVRhUpMOVUR3/5IviiwayqP0Zj2dYPp
         ERqxMVcG/J2LZd0gMLLGZh1LpRXi0MEWk+6EB04nPdOLQ2wLEL0U5ME0+LoBYosgIsPT
         /PYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755260479; x=1755865279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4figdk8mZgw6RRlsEtijc620F/GpPb7iGjJYsk04XY=;
        b=e6jewi60KizldxzwFLuHllpf5liSUu7JAeOqXNMus1V1ot/T4nxMFAL++xo9R55Iit
         y4GXHQAPYQBNWFKF1EvQedtByPvM3OVk6pBGpGcAi/vLxgPFtodlZORKoW5VNrvTyi7D
         gzZjma1unEqZ1u+aSydGQ3C/KE1gO97AtnDFtCF6bf3PNslp4yynovqw69rpfWehK6TE
         XljNPlej/8TnBT1oFDroX3nH5/HYw+/T3Gzz6Nl/Gj7CfjWT3Ya1unr9OyyNzsGWSY9l
         inPr4VPianKBYKPtarqjUHHAeh1zIuDJqPEu0nqnA1RwtZKKD1XDcKwSAyLYxVHdHQzS
         HrEg==
X-Forwarded-Encrypted: i=1; AJvYcCV8ljkx9oNvfCBjdKnKAPKWKA8xkVDnsML+n9Ki15/q069ueTSqfozZyv/BN6UCv8WB92u7KYsovaiS@vger.kernel.org, AJvYcCWc3TiXP2gspQNPoRzHgUp7kK/LT7cWkA6bmXwgGGLnFi/snQBkTwEL3rD2BiOGJpwMaPvLIZFO44RfW2E=@vger.kernel.org, AJvYcCXU76z9WLM0CBQpmhXpHPHpTtmZeViMvS/gbmh8NGME6exrBhoNXDf41/U8cY8BSrt1d8mmpTS6BLRkqTV6u0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqqDjpZQsFo8a/c5FIiSQeIO9xYYYLZFTJmsJVr86c36rveDec
	k7v6RSPYuzckmIprXalVGImEDkE3ZhaC4PV13pH+YriMzSXU7SDA3DIGSaa6Vqu3p+DrXF5xTlF
	4nd8z8/RpJC8xcZ/+x4xADl3K/bNMJ6g=
X-Gm-Gg: ASbGncs3+DFTnOrsGVLsD8EhoYRffb0q7NevFUvOUuGDOkjS6oFOtKYKqhJaqO7nHz0
	bHs/1UjU7vLvON29ll1olJ0luYMkAmv9N9/aPecL3JW8udE5rq/nZspLB+qoMg1R0MDyw+kgrLy
	uZ2d5kFMOYjiNqxSiFVuovz+iJXz3gm3iRHEJo00MHuHcmwKLdxdKCZ7GnX65iS4gkEscdiJTQO
	BDHAqkhmDS7LoHZWNY=
X-Google-Smtp-Source: AGHT+IFcLs/aX950/ZQ66L+OcdfzEem50lJkq2R4seDnYcwbaTrToX4Wq9qtOxM9TChFdFxhCp/p0ozVYRo3oqA3qcU=
X-Received: by 2002:a17:902:db01:b0:240:8717:e393 with SMTP id
 d9443c01a7336-2446d78f982mr10952015ad.5.1755260478764; Fri, 15 Aug 2025
 05:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
 <jjFmLoNIrT4EPz7LdN97j6uH8O6tsBHwC7-j9YfE6wdzydDFNRGMiVFcv5GI4waWhs_jdhILALP1ObzX7GEzzQ==@protonmail.internalid>
 <20250811-topics-tyr-request_irq2-v9-2-0485dcd9bcbf@collabora.com> <87349seqsj.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87349seqsj.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 15 Aug 2025 14:21:07 +0200
X-Gm-Features: Ac12FXxSVKJqdMnzIDC7gdb-EC4QUA5Dip8tx-FtBDGLObIsINLBSDvT26-52Ao
Message-ID: <CANiq72kY_mtpxGmCQ2ivV3FfV2WfVJmoGUyM0TX9mDUhaCvj8Q@mail.gmail.com>
Subject: Re: [PATCH v9 2/7] rust: irq: add flags module
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, 
	Joel Fernandes <joelagnelf@nvidia.com>, Dirk Behme <dirk.behme@de.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 2:07=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> I would think this can never assert. That would require c_ulong to be
> less than 32 bits, right? Are there any configurations where that is the =
case?

`long` is at least 4 bytes and could potentially be 16 in the future.

Cheers,
Miguel

