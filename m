Return-Path: <linux-pci+bounces-15520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D83489B49EC
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 13:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159C51C20E52
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 12:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3BD206044;
	Tue, 29 Oct 2024 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="luhqWDo+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD22F621
	for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2024 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205748; cv=none; b=WseR6icYKlAwUjAbWsRDNClCghPDdo8+kBw9Zg5IdvdtBU6oK1cPKMyoj2c/lRSTH9N6y20k3BFg1qrX4Ehpcf+O4MYonn+pmgYcfZm9zBsl/ZmGrEQxSu2T3rXC/w4hkS/9DtaxK1lDxQbFjKXZWCy9uZWqLewY9ivydyCyTD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205748; c=relaxed/simple;
	bh=QeNmzQrT1GEme27rUDT3ztEmU4p3Je8uEs8cgwiRFcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lB+ag+xvW9WO+ewQDp7dtXuzsLwsb/+OJGaf3Wkct39vQJhQWZCmMj4ou0LbyrFiJjgquxC3ys4kBX1SceS9w7mZY4ufJiPCzBPx5x5G81HfAyeUaCYteaIELrdDN2Kon7pa2Gz+2rPsl35C2ibUdPvAxICSLvFAU1ChRCw9omk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=luhqWDo+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43152b79d25so49689255e9.1
        for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2024 05:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730205744; x=1730810544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeNmzQrT1GEme27rUDT3ztEmU4p3Je8uEs8cgwiRFcQ=;
        b=luhqWDo+nwGOddu0fdkWBMrR22LVhHV5qxI9MOjWJC4/1N1RXj3bQaJqu4e1MPBZYi
         WW9WThFGI+J3M/AiS2tge137vE5cGN7Bjyj34VeQXDhWAuYgeiOe3mQDndCDmgvdgAGc
         0Rcsg0sqtGXgTtXBogXT7O8/f9D7WmvffJb44XuhWMAAfRQ9aC8ljvqGlUACaOzXEYUQ
         G+Jymy6ABKmwoxjDv1wxlYdSSl5xTpnO9vtnAyczV6l98UJaMtGEhM5yNcaicdzXwwkP
         8XpMZ0yJmUPP+1/fOYwiUnkIXH7cibEEKrMq3jk4ekoZUExbduJLJbC1rObxgvm4KVhr
         Qxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730205744; x=1730810544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeNmzQrT1GEme27rUDT3ztEmU4p3Je8uEs8cgwiRFcQ=;
        b=XOhq40Gb/CoaoUVk+a7sJC/wgrKXgiFiebmbaVdVXmisf9qCsPDMz4ZA0oEeuoDpA4
         2/CR+MbUERwzx9MXU4PilUKlejkJKPOElKKrxc+y5sWXF9iEUdGoC7+xXdssu6P/QVlc
         fV1BY/DoUCdlIcSV8BB/7eCcUGHQ4daHwz8uVOOBWbDwcJALGWUApE8Fm6UBCcLIlU3q
         VV4t/0w4Bsk/ttLP0HjoRTtR01QyMd4NQn7Mx9IAYj2fvbL6joKVJAYSTc9VijvyPfZn
         Co/Sk8CsqNHxxoda4siNg4o2qO987PRl7Zu6gznXWVaoPk11HRSaKKWHdJTAxWE9jXGY
         mtzg==
X-Forwarded-Encrypted: i=1; AJvYcCW5hLM1vnWiTpWfrEOhhFBVIJ2rA3UqecKqbEvE55CPzh8AMw6tyKbsBVBZrVUZm7Dgg+RKwWbsqSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwahjO7yqHx7XxvkNlG9QypaM6uxdY2tRO7Tk4vlSLypE+60OPt
	jzPCaQCScRUPR90/DEA/yJLomcvhcSUFsZBpfBK+nqx4kF9aAgD/4FFgkxm+o1oQIwMfScQ/037
	l67ko299YR0sxPYBVJaYFKtNwKpAKfJBwqbbV
X-Google-Smtp-Source: AGHT+IE3P2mRAKE0XL3OkccfC5Gs5ysfMCXjnmNO18zMBB5rShndT3pjk6KQ3q5sT0mHHEqpmuGRRwbccpLiRdU1pps=
X-Received: by 2002:a05:600c:3593:b0:42c:acb0:ddbd with SMTP id
 5b1f17b1804b1-4319ac74251mr104703195e9.7.1730205743904; Tue, 29 Oct 2024
 05:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-2-dakr@kernel.org>
In-Reply-To: <20241022213221.2383-2-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 29 Oct 2024 13:42:11 +0100
Message-ID: <CAH5fLgiHW33AzH3XwHAhG-si-Ezx2+CQf-v=Zo16x=-Hw93PPg@mail.gmail.com>
Subject: Re: [PATCH v3 01/16] rust: init: introduce `Opaque::try_ffi_init`
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com, 
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 11:32=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> This is the same as `Opaque::ffi_init`, but returns a `Result`.
>
> This is used by subsequent patches to implement the FFI init of static
> driver structures on registration.
>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Just as an FYI, try_ffi_init is landing through char-misc-next for 6.13.

Alice

