Return-Path: <linux-pci+bounces-4694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7815887724E
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 17:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00684281968
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 16:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AF515BA;
	Sat,  9 Mar 2024 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEaMAnbl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A6EEBF;
	Sat,  9 Mar 2024 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710002032; cv=none; b=iAgbYD9GwX1ovVRUfOXGxafbKXapBQmfVq/H7kPMoc+KS/PPEBtrRT5VM9eJK4TTMhBQnUVw2nmVci+sB+nxcE5JOzsSrqzjILfzIltJ4al3vx4SAH+vbo6Dq+7CQbjW2ukB7dtW/kqW07+yCfcHmVNUbScHPfE9ME24/Zl/5Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710002032; c=relaxed/simple;
	bh=VYW3LXEdZn4/ijTYL/iheFaI/HsZ+NDFhk8D1UbfQ00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEHV8h03TEbkxz+GrDyJ3KWSoyZIFNj6U19j4L1MibwMxukuCCcELAqr1+ON/x+KuHoMA8mtMnVevwKSkRuA9L8K/bt12jdfbfE+jcZVPwi6BACSUQoEEmfLpqucWK+GTUV8esb2kd5gyBMo8SSP/EZr0Vxn9TEeRfCuQH87TbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEaMAnbl; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e686d60eeso1396466f8f.0;
        Sat, 09 Mar 2024 08:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710002029; x=1710606829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/e4Fet7IjzqwV+1YTy6/YgOk5MLX9oVPoESQlOIoCNw=;
        b=TEaMAnbl+zMuTVVc+rrsK0fJsartz255VlXrZP0vMRugLhzngOLLBz7mfR+4CGndG2
         7bc+ZvT/Y3+AYRaGiHt92Wpt6srcPnErcCMAcIuW4esSK8gEDezxnop3amDcaYVNJZCD
         bS8ezZPl9mdNJ/TxVXtb5h1ZopPaAXMHJBaQHLKzwuKVKXiYEaBu1nVcTGH0k5v6FO++
         QdKgYSLApcdgurXaNsPM0PAXbcDanI6CdgWJtCZfENGH619wPGa/57DDeKzkm63xVSWV
         idiEf14ysXKJa1/3oChsgLry/Ei0L7z7tmpJtHgChdhUH6TZQcgzOrrydnkl7hfrVPft
         A+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710002029; x=1710606829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/e4Fet7IjzqwV+1YTy6/YgOk5MLX9oVPoESQlOIoCNw=;
        b=rqPJBwbbn7R+OYwClI9gNsOnxR7dlxsyh1gPu76JvIHp6NRxaYwFmmpq+q9AwwDnr5
         NoEmUvQnAO7IsIx/XdR94QAuNycshOXu9RkLMCpT/AgbvAPCNzGMEAB6Vmi2FxCGXGYa
         mvIsFj1f8YveqjD1p6QeooHNLtkHw6zh5Y1VVMh+VmjZYPE4CbCMPl6Q/JGaGAyT5h7l
         2oSjrK1LutlX0K5HQZzmU033poRzMvFfKLd9+XfYghyAHyMONWKIX7eV1wYIMiSLckSC
         sZRFqBikHuYt7HRaQMVyYmqDhMTZ2uvrqZE2PWqzrP+iutbJlKO/A4MFKkjozuHNuFBg
         T8Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXnrA4UZvXxOW8QNOkjHlgUnD6cjeeWQoGI2NrFxCjVUfbZc65FDXlfk73BfboVFh2kgftwxDGve3fOGOUpsQ8bHr2xATHZhylg0Ml66CD+WUtyjZLYsv4qY6ByY7hC
X-Gm-Message-State: AOJu0YwkgLbJIuXL63aZqb6ODXpS2IwHKoL2dx+YZKYyCuwBWkq491cc
	twVhNF5C53JyyhXtQwFgMqmdmt2LOPxuz6QTUy44/BzthBcT7OunNGa2GHco7Yi/ZkUKkFbkreM
	SsOxqJJJ65yTwH0rsIVGUBRS6cfQ=
X-Google-Smtp-Source: AGHT+IFTrt6A9iDoKKnK4T9RJ/3EaY5Ma5+9a+V8qIiLzGQ/3w4UmFislyGktP2vNMhEG57TMpHr9M9lFAT1JRU8Oic=
X-Received: by 2002:a5d:4c4d:0:b0:33e:66d8:56df with SMTP id
 n13-20020a5d4c4d000000b0033e66d856dfmr1290242wrt.13.1710002028536; Sat, 09
 Mar 2024 08:33:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQL1Zt5dwFv9HPDKDuPEKa6V7gb5j-D-LPWv47hC6mtwgw@mail.gmail.com>
 <CAADnVQLP=dxBb+RiMGXoaCEuRrbK387J6B+pfzWKF_F=aRgCPQ@mail.gmail.com>
 <Zeso7eNj1sBhH5zY@infradead.org> <CAADnVQKQumV-0AxGLKX0jQEfa8Z2Bxx2yW8k_1OqGBnD-RqrbA@mail.gmail.com>
 <ZetEkyW1QgIKwfFz@infradead.org> <CAADnVQL4JAUz-p-X9aEggeKNpYUqJZrzQKO7N0dnohE0r7mdpg@mail.gmail.com>
 <ZetJ4xfopatYstPs@infradead.org> <CAADnVQJKPa+JUUKpW7gZehbFBYj3GPrbpd0NCj4xwkU2puObEw@mail.gmail.com>
 <CAADnVQJeOc9Muki+-PUYc20-=1vRgkprbNL0zTc=Cz-T_iYkNQ@mail.gmail.com>
 <CAADnVQ+zbZ1M_uvWmyWUdomAedP+LWMhQX-5bGajzJ0GYzme9g@mail.gmail.com> <ZeyATzYas84F3IKQ@infradead.org>
In-Reply-To: <ZeyATzYas84F3IKQ@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 9 Mar 2024 08:33:37 -0800
Message-ID: <CAADnVQLVr4ppEkDOVScR2FZ0dRwMLADtgh7L4jqt1yOYrxoWZg@mail.gmail.com>
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

On Sat, Mar 9, 2024 at 7:29=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> Hi Alexei,
>
> yes, the patch looks good,

Thanks for the review.
Can I add your ack or reviewed-by ?

> and yes, arm32 ioremap_page should just be
> removed.  I can send  patch unless you plan to.

Pls go ahead.

