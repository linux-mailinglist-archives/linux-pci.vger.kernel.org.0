Return-Path: <linux-pci+bounces-4685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3FE876D4A
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 23:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5C92823BD
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 22:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0A62C1BA;
	Fri,  8 Mar 2024 22:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtcCMkSr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D47F15AF;
	Fri,  8 Mar 2024 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937856; cv=none; b=BQG/41e3u7aGdvmGO49g4GAA8EkcT5VJ76tl6uVEaiA7WVtYm/w4dH+gzs2R/Tfa18ZFXDZhjQXq6G4soaNGR9fMS7h9NGllaqpBrfmzclDo7ICyWqyUAG/c/ostWsKQTr/caSDyTTJsNKOLdW6yXtUCIrfcEzcEh70a3rXMXoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937856; c=relaxed/simple;
	bh=D3aJXRvY9D9HCzFxB6bg6tdOOq0PzsTOhGjNlR0CgaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHoGGBdDh3E+VO3IURuKrNDJ1HljDg3yJqGQy/N8Nn0j6YkPn/0nHLj3XlO7cjqO2CkhJZhrpHvnx0D5Fg8l8//2lExc28gg7V7547fweNBEW0+98szVnaikca8AHVhNFRB9oVnIWZiTHdhgFQylbMvvWxUD3N1Qi7iAyaxUZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtcCMkSr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412fc5f5152so18985525e9.0;
        Fri, 08 Mar 2024 14:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709937854; x=1710542654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3aJXRvY9D9HCzFxB6bg6tdOOq0PzsTOhGjNlR0CgaI=;
        b=EtcCMkSrJOOeadMo41KtdLmZdRP2kCk7Z//IYYGFXTlbCZrNTR8SCTGvUvsZloDsFQ
         Gr8T8jBsKvFew5Zpqp/hSvg7rW0Pr0kM/sbtBN1g7h83AZEUm2AjxExDu/jGeyI7en2u
         MYDkTZ8qR5WuANMm3VHSlHS5jDtCxlKQ3qKP8JuGwJOx12NYDgBlqOSvDHx+noAKiZmr
         R+Eu7r0h17DGurqnLnS2tDLLf9ss0JQ8ijh7Xzi0kFv1x5JTOTe4SDVP2GZXKNj6YSvj
         cJcuDitmHwLGm5iW9FwU5dflP02KA+JfJpuQ/2c89603QkxecXShKG35moyX52+Xaktp
         l2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709937854; x=1710542654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3aJXRvY9D9HCzFxB6bg6tdOOq0PzsTOhGjNlR0CgaI=;
        b=c/08NC1ZH4hTm4oBFuoKmiL6aZpK4QXyqhqAc1SIMNCYGL3gnAkNlxXZglu3BCcSE+
         bhxtjsTFCbPL0cjizWuwmYe014Tj2qxGZlsUbZqk/dy87iJL+qzclKJ6T7aeN9UHhbn8
         P26Lo60jk2PsrOtTak1LNhtYqkfB7Fy6bMWcAD6VwPc8YXjFiPYAa2q0sX9ErKqqehxr
         glqVm0o9R2qk6tau4OHV9NpzM0rytdOxRBXXyoy12UAhlt4TZ5G+BvVdE/9OAuP9ZkFb
         AnagcpFoKRZYFaOsdP2nwr27lNdux2MGPIoPQt6cPUI2nkj0J4omMRzIbrqf+H7VyPM8
         k9qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFNpQtxU4CFMjVsvJdDYHilkIinpRRXXatMqPkeqztVC/U3DZj+Zc9R8yzCD03OzQpOrRQA1pp3pco7XqEO9FXZGFlSbgS9jgCQYRekeemOLiAaI8vM4+li1QSOPEs
X-Gm-Message-State: AOJu0Yw/gbQ6oPnMpc9mDXP/5KPeo5140SZkdQc1cfvQidYcqF7mr7Yd
	S+BgocgPYzChaRyttzaOkg/huJ5cLw56e7uneEc41oZIvaXBdtyvrtK+PevOJsCJPyV7rhFu6Nr
	+UPMaOMZ9m7h/Q0Ruh5FzfRhisYE=
X-Google-Smtp-Source: AGHT+IF29hP1nUphTx29aJJzjLnvSZ7w2MXv31LF0HDDrSpcFvBtG4aiKykokpKDa4jenS3QWggi3HNaLt+3GSV1b8w=
X-Received: by 2002:a05:600c:b96:b0:412:ef25:aa91 with SMTP id
 fl22-20020a05600c0b9600b00412ef25aa91mr418338wmb.18.1709937853551; Fri, 08
 Mar 2024 14:44:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72ka4rir+RTN2FQoT=Vvprp_Ao-CvoYEkSNqtSY+RZj+AA@mail.gmail.com>
 <CAADnVQL1Zt5dwFv9HPDKDuPEKa6V7gb5j-D-LPWv47hC6mtwgw@mail.gmail.com>
 <CAADnVQLP=dxBb+RiMGXoaCEuRrbK387J6B+pfzWKF_F=aRgCPQ@mail.gmail.com>
 <Zeso7eNj1sBhH5zY@infradead.org> <CAADnVQKQumV-0AxGLKX0jQEfa8Z2Bxx2yW8k_1OqGBnD-RqrbA@mail.gmail.com>
 <ZetEkyW1QgIKwfFz@infradead.org> <CAADnVQL4JAUz-p-X9aEggeKNpYUqJZrzQKO7N0dnohE0r7mdpg@mail.gmail.com>
 <ZetJ4xfopatYstPs@infradead.org> <CAADnVQJKPa+JUUKpW7gZehbFBYj3GPrbpd0NCj4xwkU2puObEw@mail.gmail.com>
In-Reply-To: <CAADnVQJKPa+JUUKpW7gZehbFBYj3GPrbpd0NCj4xwkU2puObEw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Mar 2024 14:44:02 -0800
Message-ID: <CAADnVQJeOc9Muki+-PUYc20-=1vRgkprbNL0zTc=Cz-T_iYkNQ@mail.gmail.com>
Subject: Re: vm_area at addr ffffffffc0800000 is not marked as VM_IOREMAP
To: Christoph Hellwig <hch@infradead.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 9:53=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 8, 2024 at 9:24=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
> >
> > On Fri, Mar 08, 2024 at 09:20:24AM -0800, Alexei Starovoitov wrote:
> > > ok. Like the attached patch?
> >
> > Looks sensibe, but I think the powerpc callers of ioremap_page_range
> > will need the same treatment.
>
> Good point. Only one of the callers in arch/powerpc needs adjusting.
> Found few other similar arch users.
> See attached patch.
>
> ioremap_page() in arch/arm/mm/ioremap.c is an interesting case.
> It is EXPORT_SYMBOL, but there are no in-tree users.
> I think we shouldn't apply checks to it,
> since some out-of-tree module may fail.
> I have no arm boards to test, I suggest we play safe than sorry.

I double checked on my newly setup arm64 VM that the fix works.
I believe the regression needs to be fixed today, but
looks like Chritoph is out for today.
So I can either revert the offending commit or
apply the proposed fix to bpf-next.
I'm going to do the latter soon if no one objects.

