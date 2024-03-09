Return-Path: <linux-pci+bounces-4697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D77877258
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 17:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF20281D6D
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 16:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF7A3FE1;
	Sat,  9 Mar 2024 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwO7WoG2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C0DEBF;
	Sat,  9 Mar 2024 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710002354; cv=none; b=tijP2JwEsABPJ+Ri4Cat2aUCi7s4K21mz30PFLwKav+hKpfcl0V3gEGrt5S18Tpszw8X3mzjr0f+QcObhNJDteX0QJoYIWHCg3+Gj8PDZbJYix0PZyO6u5EeMHnyNWokKGRq3qnNf4T9BOpM9RU638kXt8KW6WYVI4a4Sld/8DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710002354; c=relaxed/simple;
	bh=QnscZIY23j4Z0t5gQ91nqMWvWILEZxniFWscrlCx+2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDS0CjuIGNix7gRtPxKacOn4KxL+nN2JbUDqR5yRIoJikMIBAnRXO6vaM5BNGfV4F7EEfqHM53Rkm3URlSTe3p0WE5eYYdoybNnRqcAXIs7Sm2NaGyvN4D+N19mstjIV3g7Jog3fnRBiS3rlL1t8bh9AVZt+w4gXuOdGN4U+l64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwO7WoG2; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33e2248948bso1955123f8f.0;
        Sat, 09 Mar 2024 08:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710002351; x=1710607151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnscZIY23j4Z0t5gQ91nqMWvWILEZxniFWscrlCx+2M=;
        b=RwO7WoG24TcQgG3jA9VN9H0TRXBJ9ChlD5YaMND4W5MnC1flrHaOKAS/b7Ra9p3WcD
         krsLlQmCip2+CTq5Bb6Z+9owfKvaBdyZjdgPwgvJFn7/t4emH1simptdC8DTLuvQcu3L
         GXWoB+b5bifaPbr92XxgVIPVE0CEijqY4mu/48RFir4jJ/mnjll6KFEBBBAcmJbO7a1c
         aAEtuzRB/bEEcknoJMxjl6GxJpr9ZtBLX4nn1woSvJ3HG8rNTndjK8Cf+n1UVAkxVVj8
         ldGWB5z2Tnj7C5n4iKz45N1quZoMFODKYZrup43XCQsK1gyh1tmjB9aOdVci3tRYCFv0
         u5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710002351; x=1710607151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnscZIY23j4Z0t5gQ91nqMWvWILEZxniFWscrlCx+2M=;
        b=rKl1y2cfaYLYXABEGZe1c+O/YSfCnwWSS+uttxu6JneTn8ql2zB7L23zUcDCkUzwpn
         h5XaBmt9TeFBdISOVKnN06Mn9a+CpI+COMoWWBytibUzvw8KsL6E+cUQo6cWeYZQnaNx
         QYHxKUS8rfOgmQwn1MZshkAA5/As2qeYy3VQATZvHoGzVl7lbtZBlGvfrEyX+h1y1l+h
         mcT2woXr2jruALhx+1gun8JFDo9+3gl8cv9AUBuZwCXa7qddB5J/cy0sLdzrX3b22ifu
         OVYxoPOArZOZfHBw8g7ElDNyEcLpupZ1+XzNtCR/7A7HLV8YAPYf1MYU7wn+OzK0arAs
         mqRA==
X-Forwarded-Encrypted: i=1; AJvYcCX0eou2vPe4CSI57DN71PicSRk9900bwBcbolOyR8SrJKS36A2Tz3K7ub5pTjM8Xn0EneOv150yw7kNHgI96utb1Wh5yyOPvyPn6hyBtJNzF7mP7j+ZsB9tJtPCLmaz
X-Gm-Message-State: AOJu0YwbmedesKEIpSOTT2PZCAASu7GFs5CUFnwrjMPXhvuxxOBC/7In
	KhDaN+N9cdGqdFydtWTU2pPxHv1y4CqZqJpmjrrLUyJrJ+/tbsmNM1emd6mCf5xagfPKU1sgn9D
	Uyedb2ojbIg6UEgBCFFlmr3VM/rY=
X-Google-Smtp-Source: AGHT+IHAXPLOrB8NCfIh9VYSnm6v6lmn7cPuUq71Y5CFq2km0rb0uFNgsJTG5SHsYpp6uiD2D0xWBHyWWOASCwYWaQ8=
X-Received: by 2002:adf:e40b:0:b0:33e:733b:cd11 with SMTP id
 g11-20020adfe40b000000b0033e733bcd11mr1397491wrm.53.1710002350874; Sat, 09
 Mar 2024 08:39:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zeso7eNj1sBhH5zY@infradead.org> <CAADnVQKQumV-0AxGLKX0jQEfa8Z2Bxx2yW8k_1OqGBnD-RqrbA@mail.gmail.com>
 <ZetEkyW1QgIKwfFz@infradead.org> <CAADnVQL4JAUz-p-X9aEggeKNpYUqJZrzQKO7N0dnohE0r7mdpg@mail.gmail.com>
 <ZetJ4xfopatYstPs@infradead.org> <CAADnVQJKPa+JUUKpW7gZehbFBYj3GPrbpd0NCj4xwkU2puObEw@mail.gmail.com>
 <CAADnVQJeOc9Muki+-PUYc20-=1vRgkprbNL0zTc=Cz-T_iYkNQ@mail.gmail.com>
 <CAADnVQ+zbZ1M_uvWmyWUdomAedP+LWMhQX-5bGajzJ0GYzme9g@mail.gmail.com>
 <ZeyATzYas84F3IKQ@infradead.org> <CAADnVQLVr4ppEkDOVScR2FZ0dRwMLADtgh7L4jqt1yOYrxoWZg@mail.gmail.com>
 <ZeyQGU3ziQbLBu_E@infradead.org>
In-Reply-To: <ZeyQGU3ziQbLBu_E@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 9 Mar 2024 08:38:59 -0800
Message-ID: <CAADnVQJVkxKXyQXHuBOrsCR3-9Jb7MV6H0D89Hzd2+ZNOvjv1Q@mail.gmail.com>
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

On Sat, Mar 9, 2024 at 8:36=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Sat, Mar 09, 2024 at 08:33:37AM -0800, Alexei Starovoitov wrote:
> > On Sat, Mar 9, 2024 at 7:29=E2=80=AFAM Christoph Hellwig <hch@infradead=
.org> wrote:
> > >
> > > Hi Alexei,
> > >
> > > yes, the patch looks good,
> >
> > Thanks for the review.
> > Can I add your ack or reviewed-by ?
>
> I thought you had already applied it, but in case you can still
> ammend it:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks. It's on the top, so it's easy.

