Return-Path: <linux-pci+bounces-4660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E603876331
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 12:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E077F1F22087
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 11:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3473055E4E;
	Fri,  8 Mar 2024 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LG/P5tQB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C892855C27;
	Fri,  8 Mar 2024 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897026; cv=none; b=GGxNyHTL4nDotMi5VUXn2NHOzcygSaIXuoc67CZaFBERYIxTMPp7pKqm1RWN2IWvXaTqIIDCvtQDKLJJPgsK+y/Hc6+xf9ol+Y+CCTEbzX48CETb05hi08hhIx4PIVf5tkDlv6aJMDFIE3UW8BiVECSosDO4fEQd1qY9+vCVnVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897026; c=relaxed/simple;
	bh=4ppzpC6QfKVkA0N3umVzKTv2UWQkb0gMKFhOE3q2BRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLrbTK3EHCQFoBMCfckKcJVklAN1O3gcPTtOEywYTiDxigI0T3IhGKWmwiqi2J+lSpx56avKsbQydOvL1Qx54BwmF1taBuLBDbWSibbuUo091Are31GNTS+MzseGqFxodCksJ2WMm2z70Ub4qnZCjU3bGSASII+uFyC73Qp28bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LG/P5tQB; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29a74c88f74so568012a91.3;
        Fri, 08 Mar 2024 03:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709897024; x=1710501824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ppzpC6QfKVkA0N3umVzKTv2UWQkb0gMKFhOE3q2BRw=;
        b=LG/P5tQBzzP0jI4JaUaja7pRksBrQyXfqjLhuku0PvepJ08iTVhvwWaOuOzeUNK62I
         m79lieub9Wm3mxZr0FSiQXgLkSVUHDdTf+CUBrKrjl3teQ7m3KVEMfHwfz16W0GZbnDY
         oXSymh/BONAVvvt49TxUcncHqyF652Hv7FwJmYWIDoki1ltrhOyCQk3YKhS1MNwvHdyE
         vNGq1/Qu1c33cx6ZyooGl2QQ3J1A/A1ItsfQWF1DHwxy4klMyqzG35Nd855kBrGe3pJG
         g6nETWQCYdbp5jI1Pye1c4ZEm2T8bldy1DcM2wYzYqG2gXLe127Gz11yMiedacrZp+11
         YhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709897024; x=1710501824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ppzpC6QfKVkA0N3umVzKTv2UWQkb0gMKFhOE3q2BRw=;
        b=j8wmE9QAzU1Ht7dgQ0nT7szfJA8tbUBJwmUqT17MR8AZY9JeRyt15DtbOZnSRh4y7u
         qsIo+epWT/dQlEzrtVGcF+0oA6OyHl008IODnlmq4K6ZpmmCpku/71UREcUkxbfL9MlB
         CHkfvMalgbc3w7C1eewr88gzYQii1Q/ox0MVkmQO99pDTAVP530E0bplNC5our83oJww
         Y3/+om4XHt3YavFzPM79QlxoPT2sq4BeNp3kPh5Lo7S8w3nD0M1widVQqbujLoJPHicr
         6WkrkESIOjE25kLaQS1WNDu8jwDsBkErGHjkc2vZsIdJ8ShH1XCFzo3nfPkw+k+Rvu1B
         B7/g==
X-Forwarded-Encrypted: i=1; AJvYcCWc7887XbWMc7xOLuUR1mobdj41gTfXCdzP4KwqKhHm3GfMfvaTxztytXDbF4QM1X0IS+QPIobdtsribwjFhBlGI3+IZN9o4mI5+felAwyNinjgGgksM3ZnbLE/EDni
X-Gm-Message-State: AOJu0YyYeTzC0l3u2UjwYJ06wikiiJnoPinRmdCdx+QP4Lm5mxSJWOS3
	FTg88TXuiUdgbePJjjLIxmej2iIdnSpUdO/+JI6uw6KWrkqvJoln4kyRBJOarJb+5hx8CyOdmff
	Kg41aXiJ+PL3mxb0ZEpCHLrdv5Ng=
X-Google-Smtp-Source: AGHT+IHWByPgN5/INLRj9h9f1n2iuWq+SGjq1T9BwyrfIASWGOtYz+mpsjMb+IvHdHZ0B4n4v7Dr1TD6SKe9a9sL9b0=
X-Received: by 2002:a17:90a:f40f:b0:29b:b05e:3a5b with SMTP id
 ch15-20020a17090af40f00b0029bb05e3a5bmr1221987pjb.47.1709897024038; Fri, 08
 Mar 2024 03:23:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72ka4rir+RTN2FQoT=Vvprp_Ao-CvoYEkSNqtSY+RZj+AA@mail.gmail.com>
 <CAADnVQL1Zt5dwFv9HPDKDuPEKa6V7gb5j-D-LPWv47hC6mtwgw@mail.gmail.com> <CAADnVQLP=dxBb+RiMGXoaCEuRrbK387J6B+pfzWKF_F=aRgCPQ@mail.gmail.com>
In-Reply-To: <CAADnVQLP=dxBb+RiMGXoaCEuRrbK387J6B+pfzWKF_F=aRgCPQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 8 Mar 2024 12:23:31 +0100
Message-ID: <CANiq72kh-OcUsoCXD-mPYarTyHVv7pd83zgHxMKZWT8Qbb6CKg@mail.gmail.com>
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

On Fri, Mar 8, 2024 at 4:49=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Ok. I think I figured it out.
> Please try the attached patch.

On top of today's next-20240308 for both arm64 and x86_64 under QEMU:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

