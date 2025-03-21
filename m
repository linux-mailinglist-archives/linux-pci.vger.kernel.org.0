Return-Path: <linux-pci+bounces-24398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FF7A6C36B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 20:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108801722C6
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 19:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6C822E412;
	Fri, 21 Mar 2025 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXZeF4A5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4913F1D54CF;
	Fri, 21 Mar 2025 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742585881; cv=none; b=TzWpMuSP6nGe/nWx2Ti/wLUl0PQhsuU1j18CTV9S5w1PGVXBd86Dh5wS+4Ficr7qHgvfKZq6onsmRJZyjV+1N0GXp84F79Jh4Br4W1275VKG9wFTyFHTLgCeX/hCVVSV4qMN7RHvm8P9weOjtoAUYEXXeCsd0mj/eBWi1NrPS0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742585881; c=relaxed/simple;
	bh=VmGk2QKnCgeNy1W5/I3wjMhcHhVvDTr6PEDFoCrfs4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okQEfRPJQ8qiX5+nUnjdoKHoi7XYxBzetlCKH/jiQfiRcUyjPOnsIm3GuSZDegPj8ouDvriiNE9acW5iJBnT47bLaDQ9dOwui46BuU4h4Rx4zgvICVTL1kAk3dkxUWykk/p6IBXMzGJcEYMj0x7uVgxtT3gD2u2Ed9TtW9u0pto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXZeF4A5; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff62f9b6e4so679265a91.0;
        Fri, 21 Mar 2025 12:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742585879; x=1743190679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmGk2QKnCgeNy1W5/I3wjMhcHhVvDTr6PEDFoCrfs4g=;
        b=fXZeF4A5UpqluhQSkt4GRNwXmwEKE6h3qHQ+Y/T6Ae83q0hln9MjPUwM/XOnd7aCCz
         482oaPNlZhhk4h98RTlMmA6DHGDoYTCFF88IhudBde6UAbUlAXWxrvJFZFFnuBZNBmFt
         2JhaoOWQet4C6rNhChkl0Zest1sUVZqrM0oVjI1bP6QhhAtI7bM2Sg9YuosdyG08pLSv
         H2NWa9HpYyM1HdAmNDKt9EGVWJUE2+NI9QHyn8E+TIch63qQuMj17icmhbjub0Ntv/Sa
         MoNt2izc4P//gZXlUugxa9rkmalBzuiMnKPhprNGpHhi2mcEyl3jyfuRIDFhgCoCflpb
         bydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742585879; x=1743190679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmGk2QKnCgeNy1W5/I3wjMhcHhVvDTr6PEDFoCrfs4g=;
        b=NeVQ8A7P8tBYpyNGpnMc92BjoJ7/2Tdh3p/Kzsb8qLbdAH+1Ehdb1TVIVaPAaflIe+
         lRFaAftz4JLQZX5xYqwPVtR6N/XKhR1zXxPIskP1UcHiHytA5j40JHDnZ/UswDLgOAAa
         Kw7jcFe8iUQIH72h5jmI1Y8AKkxONM64nux9mcMqQd1q4ufIy7fHBzcj5tlg+H9aXmAb
         OlAty6wYNdSAoEepJp1ipLh5ark3Sym5MTs49CQ6Xw2LHC51FHBCJh5fH6KmS2yfRl4o
         FaNqC7EoQkFDzSK+JUtcMJRe5QTezrBTgGFtsBFH1sg+dR5NFvTixxgn4HnyYEesiS50
         YPIA==
X-Forwarded-Encrypted: i=1; AJvYcCUYtYODF8rUzI3RPVE+39yTWl9meW9csyfWwTWEZKM9vHCFEU+hb7wS8Dpc/nirsqTZM6hnwFI0VEgs85w=@vger.kernel.org, AJvYcCWED/yuiFjXQrFG2fstn/cKNa7UJhjmZHyjJ0t5G0Q80rPw47km7egwVGjn+MyLzIVN40L93DyFRMZR@vger.kernel.org, AJvYcCWcnfmq9tzGP+mlXIQHKtwCQ5SKz3d88zr4vaVukp2SfWeOMduMcLzkTg0oz1vuK6NMrb2V621wNKsc7M5H9Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/pKGojOT7dSkBsMiAMjs/g4ao+EI/upyX75OnkoRotfrfK2W3
	e9LYXIR/mGcQF+/gMXVIvUfvtbl5eZdUZA+BciRn5l7kIJtAfFrUr+T1rWe1HopZajnFyrvWVuu
	/yD6n2qpazYohdbYRPz59B+UBFNc=
X-Gm-Gg: ASbGncu0o2jXKIEBwkUBdb0OwD8uSANtfY4Y9OEqB5hcN9LDf0D3h6kCyn4kZb+bNE1
	9xF0FySXY+DQnHeGlB3rCclLpJq0NOFKyU64H0ggr/oZ3laSLaYmkkjeIrlERhKsR4BkJtp69B5
	kqYbybPWWwIn4a7QG4uaqxaicRQg==
X-Google-Smtp-Source: AGHT+IHcbZzF+JlsnM7N1XM9q9dnz9lZIXPMELUd/weF/NBB/+ylTDpLlAt78Ks9jpFQJPhbWPjCqFXH0ARLhFmlQwA=
X-Received: by 2002:a17:90a:e7cc:b0:2fe:7f51:d2ec with SMTP id
 98e67ed59e1d1-3030fb1fff3mr2593669a91.0.1742585879537; Fri, 21 Mar 2025
 12:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320222823.16509-4-dakr@kernel.org> <202503220040.TDePlxma-lkp@intel.com>
 <Z92ldvI4ihlm0HJd@cassiopeiae> <CANiq72=s3rQwRt-TOr0_n=EKHwJSQSGmKfu_4TtoEhSTc2Fvqg@mail.gmail.com>
 <Z9253sEI_cRS3mtN@pollux>
In-Reply-To: <Z9253sEI_cRS3mtN@pollux>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 21 Mar 2025 20:37:47 +0100
X-Gm-Features: AQ5f1JrVmdS3YKYMvAc3O62mGzPeFxqsSgBlARAqJZSbBraEX8Zy_C2Dxa7CiEw
Message-ID: <CANiq72nvp_fWD6oDULgq1PVBD417iUVVWcZr_cvfd8r9Lpk=rg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] rust: pci: impl TryFrom<&Device> for &pci::Device
To: Danilo Krummrich <dakr@kernel.org>
Cc: kernel test robot <lkp@intel.com>, bhelgaas@google.com, gregkh@linuxfoundation.org, 
	rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 8:11=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> From the second link:
>
> "Previously, the compiler's safety checks were not aware that the raw ref
> operator did not actually affect the operand's place, treating it as a po=
ssible
> read or write to a pointer. No unsafety is actually present, however, as =
it just
> creates a pointer.
>
> That sounds like it was a bug, or do I miss anything?

Yeah, if they didn't intend it originally, then I would call it a bug
-- they also seemed to considered it a bug themselves in the end, so I
think you are right.

I meant it from the point of view of the language, i.e. in the sense
that it was a restriction before, and now they relaxed it, so more
programs are accepted, and the feature would be "you need less
`unsafe`" etc.

The blog post seems to mention both sides of the coin ("This code is
now allowed", "Relaxed this", "A future version of Rust is expected to
generalize this").

> Yeah, thanks a lot. Especially for the second link, I couldn't find it ev=
en
> after quite a while of searching.

You're welcome!

Cheers,
Miguel

