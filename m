Return-Path: <linux-pci+bounces-4674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 939F5876890
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 17:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBA228364F
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 16:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A301291E;
	Fri,  8 Mar 2024 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFgv0VMy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741551CF95;
	Fri,  8 Mar 2024 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915614; cv=none; b=SRXVrETlUje/VFXT3lAKKZXgOVpQnwdzuciSD2pcGKlP2ZrdxWkAn7PKPbCOXtOEz9/LtMTk4Urwbe90++1zaebIsBAutUWhbLQafnA8PNHc5UnN8T9kPCw2zNrtowu6wL6FJgGvpSW6cAOPoTUt+q89AIKUSlwTxU8mV9qfewY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915614; c=relaxed/simple;
	bh=9/FAYiHlr20Cyrm1j5FOoJn0knjxzaGX6qLlMAq6UVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9xIm0k0lpIVRb2Wg0GQCtk2kGKCVWJaJE8n57HFEM+ZTq3Oj/PWDzeof63SnvEJ6/RYcI5gjt7hM5HHVqZroO77tIknP7pHYsz5DpHLITE1TFEkmzEJPze4DRUXmvXsYQnRFIaxpMTYysd16C6i8V638qxvB9WVcGJH1/vhHhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFgv0VMy; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e162b1b71so2048760f8f.1;
        Fri, 08 Mar 2024 08:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709915611; x=1710520411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbgwgkAex3VYDxIBDZPuxNUeU8585DvkCZMxr6fhjg0=;
        b=lFgv0VMys3U0EURrhKWqOkqx+f/Hurk8bWKKuNjhF5usxkvWQbQaTW6M8VuLo8u+MB
         t1vVC7eyzb1GQrEVXVge9ON+Kq/8G5BYW/hTsc+1YjRAd0snoAFB40RUdLgV7ZrpfQW6
         1JDedgJvTWkduDV8GUW8+iDIV6QJf/srCi/0g+fOtc9VWU7NHt87r5hy8VSwYeDSr2TC
         yo3wW8RM1ejUAWcPyIVT55C/nkOM91Xv+A6rU4hxMbs0evbK6RcpZRT9YSELWMICGgjE
         K583cU/j+JXqET02niCCY1P5tv3mR9GbgxpgkrBSe8YROMYm2xT3FVZdq92aSwWyOkMj
         aL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709915611; x=1710520411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbgwgkAex3VYDxIBDZPuxNUeU8585DvkCZMxr6fhjg0=;
        b=c3nB3Db8FdDidBBH8K8FnpKXcgz3YiaVG2U8MtjSxvP0wbbaRdrsNfM4HwfpHxnUIY
         rLMOGHWzC0zjrDIg0VqxAOqkD+ENaaOhmmNSy2+y3TAeqpsJ/bpyFq0hd3FcCi90qOj5
         IeQ+MtWQRMuuX6P1XBj4/hkkeZWBv3DiJ28CC9FpChS7F2KlCjwLJcXVYFxDhohLonOP
         CHC6IHwYx/ISXeWHHNMvD/4qk1YgIH9i3TyIfkJLpiViX5ZkgaC54uYb1bfMV+z6hEQv
         r7gOPoV2bwVWoC462hcTm8uW80eTWZlFf3XmqApYG0N8FX6LkCMqgsY+1DNcXezin/MD
         bIZg==
X-Forwarded-Encrypted: i=1; AJvYcCXiP2NdJu9euTt7LDJvzLZ0GIWJyMf++fpZjGcXsftN3ktr9wluzwHB9f6uRAZUpbZ5GBwLc5l0muQZUnysE70tnQ47CBUOvAaXTAxDjI5VjvHWc/7618nggMjlNkbQ
X-Gm-Message-State: AOJu0Yx8njMwDf5lRMsZqa1V6paxN/P9hWQIKKvEq+Ez7Hl51e5zcux6
	Y3vVTNV1BVRp8WUx8Jv4uRPG6JuiFarIK48mzma6tJU6mGE92urzY2shDbm6T3Z+UHagZtbquz5
	4r4qFAVxtMiuwdkrKNRzoynqwcLA=
X-Google-Smtp-Source: AGHT+IHdxJaJ3BjN39OtK+VvOYPJJdb1YiSUT5r+TVfvi6+mlBgKf8nx4LtzsQUnK/CBhNNSbcZV6F417SAgTs8tOK0=
X-Received: by 2002:adf:ca8a:0:b0:33d:9f58:8803 with SMTP id
 r10-20020adfca8a000000b0033d9f588803mr13484808wrh.18.1709915610478; Fri, 08
 Mar 2024 08:33:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72ka4rir+RTN2FQoT=Vvprp_Ao-CvoYEkSNqtSY+RZj+AA@mail.gmail.com>
 <CAADnVQL1Zt5dwFv9HPDKDuPEKa6V7gb5j-D-LPWv47hC6mtwgw@mail.gmail.com>
 <CAADnVQLP=dxBb+RiMGXoaCEuRrbK387J6B+pfzWKF_F=aRgCPQ@mail.gmail.com> <Zeso7eNj1sBhH5zY@infradead.org>
In-Reply-To: <Zeso7eNj1sBhH5zY@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Mar 2024 08:33:18 -0800
Message-ID: <CAADnVQKQumV-0AxGLKX0jQEfa8Z2Bxx2yW8k_1OqGBnD-RqrbA@mail.gmail.com>
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

On Fri, Mar 8, 2024 at 7:04=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Thu, Mar 07, 2024 at 07:49:16PM -0800, Alexei Starovoitov wrote:
> > Ok. I think I figured it out.
> > Please try the attached patch.
>
> I don't think this is the right thing.  The probem is that
> the PCI code shouldn't really be using ioremap_page_range if it is
> not an ioremap area, but instead directly call into
> vmap_range_noflush (or an added back vmap_range to avoid all the
> duplication) similar to the vunmap case in vunmap_range.

vmap_range_noflush() is static in mm/vmalloc.c
There is vmap_pages_range_noflush() that is in mm/internal.h,
but it needs pages instead of phys_addr_t.
Newly introduced vm_area_map_pages() needs struct vm_struct *area
and struct page **pages.
In this PCI case there is no vm_struct and no pages.
ioremap_page_range() is the only api that fits. afaict.

