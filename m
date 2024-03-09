Return-Path: <linux-pci+bounces-4687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C20D4876EA1
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 02:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D061F220C1
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 01:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA558290B;
	Sat,  9 Mar 2024 01:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jlaz2cdP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA52125CA;
	Sat,  9 Mar 2024 01:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709948247; cv=none; b=ujlFeka1KiEHRYFEq9H3olC09ilC2LUYvWlFsICLo46ocicofrvEYBnSvLglUjfqilhpy6TMwgq1Mr3dXrl3AlpoJLp8iP2DUvajyO5uprGabUmObfOPB5dRcPAKIMXFI+WrARaeWlEYE13LN9y8G4dWD5FeFb/VWjEQu/SY+C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709948247; c=relaxed/simple;
	bh=t9sJfx/dPoC4PHFHcz79QVELMCRzIgS/uV7VsG1ZiEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYTE+aOSpcjVPtD02Po2t7ULxZhzRHX9uuFhSa+t4S3WBdkDaUGpZBsn/Go3Fh+0Kbj3uVzBYHZgTugWTFh8KFf3+36eBYXPF/lA+ngr8rL+RuuT7/+w20uVoqKC1WE1Elt4bTnW+Ylawjw9Izcb1ECrAyeaPF1PObZb679E9zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jlaz2cdP; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4131f5f7d47so1211525e9.1;
        Fri, 08 Mar 2024 17:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709948244; x=1710553044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9sJfx/dPoC4PHFHcz79QVELMCRzIgS/uV7VsG1ZiEU=;
        b=Jlaz2cdPWBHXHJdRbFrzP87C91/uWdN70AY6SqmzjUuDbfUpbofq6eU/vUTSKwTh46
         DCHjW9lVVNhZT5iRXJ6zHL2wIJcix9bP1Y2A/qPf+09n/iEDGt79/Tx9iCO5AGKScvgk
         AxHZ4FK8iRLYhU+vTG0Zm3Kqoim4PiBsLolc5d3KG+Y6KLYEJ46sXxy7PHAtqThovTj9
         wQ93gXeYr5ZYmbYikfMxPS6ibZvB1E1SCAjaOmt2XhNf9PuYlyf53BZvu1G4l9XplhNV
         A+UJ764HVjJgrnFKfX52+zcqF0pdy+PY8IXcH7a6MJuKigfQjBQfonswTvMJBzQSfdQ9
         q3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709948244; x=1710553044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9sJfx/dPoC4PHFHcz79QVELMCRzIgS/uV7VsG1ZiEU=;
        b=e49JxgNKaysK9hfCEbb5cOPQNhFKBDWuHYtD98GY95FdJKqZSZMtvh/1/XzE9TAyue
         ZK995Tbtsp9oEgJ5zDPJmKRwCyugBELdFb754AmTIFwH1HWsFsubg466e8Uxn9IpU49C
         XB96R0jEBVyDEw6JiE/q/UJ09hTyg7Q4Rzo4uoGycZfP4sa6SPW+pz4whhmVs6z8XRer
         zrqXRRT9G8D/80M+4/GwKJ/Uq9kWsDbx4R4VhjoBdBckTaX6O2rGVDcdXtslQbjBBanh
         8di7g2V+/0ajP2BEbWoQ/L//WWXxHlHA8R+IaNLdMGQUTWq5ltM1P+JJgZXa2D3QK7oC
         GCnw==
X-Forwarded-Encrypted: i=1; AJvYcCWbJ0MCiOGDq2HoUytz2iFUZoRcI+wdancULNyT+/XGhS3CwFtpOXQphU4K8RD9utHdqZfyZZ9oIta3We5dbVnzn3tF9srbi9iqhjI3Z92nDKfIsOlzcLDWzZ46SzrD
X-Gm-Message-State: AOJu0Yy+ET69MRvwEsl4ruKWATZ6svAVAOFJWNuMa4qnJl+hPXdudzfS
	oGNXR+nu5qyGD7srAFN7NGP6co8B9C5pp34++bQUh3ZZs0MCs7JdOynFSTZT4MeYgg/9axVMHRX
	F8+JLutJGy/IiTSRiWlj82L2xxtM=
X-Google-Smtp-Source: AGHT+IG8nKUYYOjFdMCUDQrm7i9rcMegPic9EYSlh0DvVf0EaRVfqjGxM834FUWChCcqgKR7fVJIScN+mCzQErdyEKM=
X-Received: by 2002:a05:600c:190c:b0:413:1139:3bec with SMTP id
 j12-20020a05600c190c00b0041311393becmr525736wmq.35.1709948244238; Fri, 08 Mar
 2024 17:37:24 -0800 (PST)
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
 <CAADnVQJeOc9Muki+-PUYc20-=1vRgkprbNL0zTc=Cz-T_iYkNQ@mail.gmail.com>
In-Reply-To: <CAADnVQJeOc9Muki+-PUYc20-=1vRgkprbNL0zTc=Cz-T_iYkNQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Mar 2024 17:37:13 -0800
Message-ID: <CAADnVQ+zbZ1M_uvWmyWUdomAedP+LWMhQX-5bGajzJ0GYzme9g@mail.gmail.com>
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

On Fri, Mar 8, 2024 at 2:44=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 8, 2024 at 9:53=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Mar 8, 2024 at 9:24=E2=80=AFAM Christoph Hellwig <hch@infradead=
.org> wrote:
> > >
> > > On Fri, Mar 08, 2024 at 09:20:24AM -0800, Alexei Starovoitov wrote:
> > > > ok. Like the attached patch?
> > >
> > > Looks sensibe, but I think the powerpc callers of ioremap_page_range
> > > will need the same treatment.
> >
> > Good point. Only one of the callers in arch/powerpc needs adjusting.
> > Found few other similar arch users.
> > See attached patch.
> >
> > ioremap_page() in arch/arm/mm/ioremap.c is an interesting case.
> > It is EXPORT_SYMBOL, but there are no in-tree users.
> > I think we shouldn't apply checks to it,
> > since some out-of-tree module may fail.
> > I have no arm boards to test, I suggest we play safe than sorry.
>
> I double checked on my newly setup arm64 VM that the fix works.
> I believe the regression needs to be fixed today, but
> looks like Chritoph is out for today.
> So I can either revert the offending commit or
> apply the proposed fix to bpf-next.
> I'm going to do the latter soon if no one objects.

And now applied the fix to bpf-next
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=
=3Dd0d131e3b655fd267d14bb1bed49e3f990a1465e

I've looked through all remaining users of ioremap_page_range()
in alpha, arm, loongarch, mips, powerpc, sh, x86 and
all of them do the right thing:
*get_vm_area*(.. VM_IOREMAP, ...)
followed by ioremap_page_range().

