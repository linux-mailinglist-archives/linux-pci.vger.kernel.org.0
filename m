Return-Path: <linux-pci+bounces-4722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744F1877F45
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 12:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A34B21AD8
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 11:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F3B3B7A0;
	Mon, 11 Mar 2024 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEEFanXf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28583B78E;
	Mon, 11 Mar 2024 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710157614; cv=none; b=Y2o89PkRmcWISAk9oidAbbjHE9v2NJ2GsUkVFj/nmftmuegKxx2EuXuDaFin+obj3de/NpUYSUlmz8Qw7WJLJvuIk8YWayjVsLJoqb5M+CiBJzqgflAxMuYQr2NrGVGpbD+ca+7mtAtKk6giKxXjoLJjPTXVIuZJ5gvHcXMzUNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710157614; c=relaxed/simple;
	bh=ADA7WsWOqpTgckZhMzIai2MEKGe5CSeq88JNezN9c2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBTeSqEcoGRVdK0gI8yiP5q7IAYT3waNTq7nTvu5ub8ws2M6gyVfXJEO0bF7D6s3y1v5TrerPeh1w1D1PvHU9L4tWqv4WNmfJfkAU27WSgBHsFBpJAWCAP+AxI7rg6TXvLNUlCpEydt0z7HDQVYGc0blAugg5yZfC0CJXyQyDZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEEFanXf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so25414985ad.1;
        Mon, 11 Mar 2024 04:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710157612; x=1710762412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADA7WsWOqpTgckZhMzIai2MEKGe5CSeq88JNezN9c2M=;
        b=MEEFanXfhCGqgIrfQ+0SgaZG0Ad8T/QTzAZ0GRLJebRw0E4rJ+flwEuxdrUa8SoXT8
         QZO6begJwOauRZlD0fakKOOoxl8EFW3EgIBe932vwtA96eVX0C4RQtsT+X00hb5eOE4f
         5MBXVDOXljrQjspWnqjxZYTdy9A2P+RhSJH8uFGW//IL/dA02x/mXpiqAy7HwsD9rsHq
         1v/Erkxu0cGu+l4Pg/TQaMSUjtYVUl3vPMY2uTYSSr1CCMhOnm59GSBRmYJyx1/NosI4
         I/Bb0v2kdk6SmXFX7leqMtbiPamirsao0M2anpGYENBmrGtI/cj+jU44pkh+BHBSFtHl
         Qbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710157612; x=1710762412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADA7WsWOqpTgckZhMzIai2MEKGe5CSeq88JNezN9c2M=;
        b=pXUIBdWECrHZOCjPfH05T6EFlHlXYkcEI/+In7ryKwRqqg4zEZIGb5OaFS7ohXtH5q
         VD+suhXNEz9uKB0utAgOP1L9DcXmIQ5Ymfp3kMmDt8aMvUdLK/0VaJummgKpfMocXBFu
         ml2/MPktLJoqSLHzHpniuaMNpVAlCh8dMR2qR1srK0kphQjII6AFx/XJ+6UdaXJKGHsj
         ZGwaLd+dLp1CZYpGlkD863llvEkwLx82HSwrH26b26hwT+dFFGtDxcHyttPxCuupp1lF
         o47ZFN5lO6y5l1ClUtJPO+sN3nvSWenk59N5mxVo8vviBWoM2VtStuKNamnFOzKvthQv
         ojcg==
X-Forwarded-Encrypted: i=1; AJvYcCXoDfHzqSqEzQDFkC5YpnRhzyv9e9SS5Mt4Wk1dgR7sF6Z/1a3uZRtFPjbhl/JNcOEXf+PXAInUqWTzcaN9Lufiq/2ajESBXHVI8fMalq+uHdiJsLQxUNZAw6AexS5V
X-Gm-Message-State: AOJu0YyNgKM2GGyn1TCKz11mcMwmpwrCFDXGEgQz08rAZe/nooj5K7KE
	sRD8k7bOb4IDXEBMPludd3f8I+rR9TXvgo9bghReLlB9votcdp3s51nSniWgdRMBg5OKpcrfxh3
	ei/Ld8TjVadFZbXG+oJmcQiHEm7k=
X-Google-Smtp-Source: AGHT+IG3/lofTePc3tTrdH/j62d9xz8R6o/uCfYlMdLpBER9bDLT2xGfHEMxm7Bc39GvJ1RhKfxmwbOCvDt8dtP+RJw=
X-Received: by 2002:a17:903:2305:b0:1dc:b64:13cd with SMTP id
 d5-20020a170903230500b001dc0b6413cdmr9596984plh.27.1710157611864; Mon, 11 Mar
 2024 04:46:51 -0700 (PDT)
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
 <ZeyQGU3ziQbLBu_E@infradead.org> <CAADnVQJVkxKXyQXHuBOrsCR3-9Jb7MV6H0D89Hzd2+ZNOvjv1Q@mail.gmail.com>
In-Reply-To: <CAADnVQJVkxKXyQXHuBOrsCR3-9Jb7MV6H0D89Hzd2+ZNOvjv1Q@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 11 Mar 2024 12:46:45 +0100
Message-ID: <CANiq72nYFiL4YRpwjty6BQFbuF1E2Vp1nAxakMOh2fi8vevDfA@mail.gmail.com>
Subject: Re: vm_area at addr ffffffffc0800000 is not marked as VM_IOREMAP
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 5:39=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Thanks. It's on the top, so it's easy.

A Link/Closes to the discussion/report(s) (I think Naresh also
reported it) would be nice. In any case:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

