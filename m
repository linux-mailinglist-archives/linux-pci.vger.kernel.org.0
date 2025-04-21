Return-Path: <linux-pci+bounces-26339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E262A95421
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 18:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57FC3AA897
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 16:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9A21DF979;
	Mon, 21 Apr 2025 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaJeSKLH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AF01C84AB;
	Mon, 21 Apr 2025 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253197; cv=none; b=UBsBEzHHCqCbWLym5fVzOdDKCFVK1u15umk+uP9FqCHkHMy/Rk7/RMT+j4NduffEOtXYnInD4aVWOE2U9ihhXDMVVPvZLE71E+fAh4eDQqaI93CiaFwDLhQjnEQafEqawId6RnDy0Yvr6uAp4HW79UmvG8Ztl3TXwNcP96NoKM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253197; c=relaxed/simple;
	bh=UoNKEsj17isREgxZLDT9jvBpXB3AVOKKvjmQvpOpFIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PM87QcqLMN3aNwMcNXN+DZoaqeacilNoOCSpv+AXcWE4rijo+rMqKFm7gJMTYOChM2/Qsw51oDN246K0Oz7go33F8yJHEJyL1mddJMK7cJzpsIcnu+1sipA9ozGdPuW0wwkxhSbgT98p197yCsh10F/IYoHCoc193rhsVXq0+5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaJeSKLH; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so39215991fa.1;
        Mon, 21 Apr 2025 09:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745253193; x=1745857993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UoNKEsj17isREgxZLDT9jvBpXB3AVOKKvjmQvpOpFIg=;
        b=iaJeSKLHxk/lM6FNSkaDdYf3Qrtoo3p6g/SwfzgG8oapg1ai2ZA7uIxXGXoE+Py/qY
         0Iqq/5yaOc4avLgNoOi34SBMvY5UiMnmRp+UHiJao1/0latFpYU4ZRwbXzXSf9rlAWZk
         4QHST/RsyWpOhr9ZQDq0hwr2YfkoEG9k9NHk7Bpbs74pm6cTSZOWxkpFmVQxmQJHgWIY
         6E3VK25PRvp+2/DiDMYGP+3kmwqbxqfUaNfH3lynJs56MLkNIp9UL/1KZsC00pZZK3N6
         QfFXxcsDGP0Obg4nJLlimdUx4mu8MzIvnQ2NwF+NpBpRBLZNF+POnBaty7RCj6nq94+E
         GDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745253193; x=1745857993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UoNKEsj17isREgxZLDT9jvBpXB3AVOKKvjmQvpOpFIg=;
        b=kj9d+oprIhPK3ULtKQVXErwOunRY2pv0YrVtM06jg78Fo4mRzQ6aTux5Qwsn6Yw8+6
         qWi6/jUfJjC3MWakmA9niR4DLRsHcnvcMtg8/XhrJeXtotFfKjE3sx18fQEtWKWfG2lx
         VcqxM5sAGxSJYylP5/7W85fMyatfuC4o0GQxlA7btUb8kTppObgJ+1dvpo54fPW5n5Pu
         IXnfmq/Kx7hVFOpky4Em/onCedudVBnRT7mzAi4qOeMqVp9Spu6/6guLF4+/6T37Panc
         8EsqFEIGpbM25lvRCgO+QRdABTZIWSkEPoGXkh+hL6bdWCzwSJFubT86yosOctr5asBA
         exvA==
X-Forwarded-Encrypted: i=1; AJvYcCXXXlQi13PvaPUl0mLdlOoyk2xZjzlnC+Lb9/mrHux9GGszgs9BnFuVHKLrE+32k4YtcU88dPOFRFCZ@vger.kernel.org, AJvYcCXbAmTskyjC1yFVGWh5Co9Cq2smV0LgyOduz+Vw12Z/loW4kHR4phq9Hkf187GY6iBqWkvQIFwvmN3Wnso=@vger.kernel.org, AJvYcCXbzn6ppiC02RsNrvJHMal97tRxI64GJwx18O2tp1RLLFd4fDEJzXll8uTJM7u9flOtzhl1ah5Sh2Z3IQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBXWmxYPhWfXCvS8QqrOxdtdXHF8jre9ynL2b2nDMmDabP6iL7
	pHraBRs+n2varqG26RRJU072FFFvzb8S0PiQV2/9TxMb6RMKVlXIZy3TUX2ELslKyHMmLJT3Wo/
	3N3ElZml+6TXL5RGMM/KAuj2XRzM=
X-Gm-Gg: ASbGncv9LKn2jOqEGF7nArYgi7/Ez7q0vk3IvsMBgsIH5q+rlLcQ/lovS1VisdDJDFn
	aTj74bswdj0ayR1L2c2c4FscGYKTUCurxnYejAgaK171L47k8Kv71kX5Iyc55N3SLQV0hY/46LR
	Bwg1CjoCf5RkccEFs/bX1Tzw==
X-Google-Smtp-Source: AGHT+IHBYTXcQcbP9GB5C/9vup5nk8I8rSBNSwS38UnAGqghCncVUy4I/9VhS09CmV0dFJfbXkmit/X8ZLmghZjamjE=
X-Received: by 2002:a2e:a582:0:b0:30d:e104:a943 with SMTP id
 38308e7fff4ca-31090579a17mr29419331fa.39.1745253192974; Mon, 21 Apr 2025
 09:33:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420-pci-tegra-module-v1-0-c0a1f831354a@gmail.com>
 <20250420-pci-tegra-module-v1-2-c0a1f831354a@gmail.com> <pgp3cdksefn2z4n2hlyhftbdlfwyx7gbol7q6wdj5j4brux3cw@thts2qcahdw3>
 <CALHNRZ9R4SWtzAYocY9X7D9hm4mXeWKhdo_rk5UmRPVGD-vbBQ@mail.gmail.com> <lk37wtb25pr2rj3zhct5udaykr7joqw2mpgtupjq33of2xhesi@rmdgucbzxmgz>
In-Reply-To: <lk37wtb25pr2rj3zhct5udaykr7joqw2mpgtupjq33of2xhesi@rmdgucbzxmgz>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 21 Apr 2025 11:33:01 -0500
X-Gm-Features: ATxdqUFH5_AjQnqTEFKcOn5KajPXTH1HhKUSqV4aiEpPra7WIaa9mRdmopDK7dk
Message-ID: <CALHNRZ8gSzOVpN_au_ntSan7or=uRBrPSRFdbDqAHxitcEfs7g@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: tegra: Allow building as a module
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 3:54=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Apr 21, 2025 at 03:09:42AM -0500, Aaron Kling wrote:
> > On Mon, Apr 21, 2025 at 2:52=E2=80=AFAM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Sun, Apr 20, 2025 at 09:59:06PM -0500, Aaron Kling via B4 Relay wr=
ote:
> > > > From: Aaron Kling <webgeek1234@gmail.com>
> > > >
> > > > The driver works fine as a module, so allow building as such.
> > > >
> > >
> > > In the past, the former irqchip maintainer raised concerns for allowi=
ng the
> > > irqchip drivers to be removed from the kernel. The concern was mostly=
 (afaik)
> > > due to not disposing all IRQs before removing the irq_domain.
> > >
> > > So Marek submitted a series [1] that added a new API for that. But th=
at series
> > > didn't progress further. So if you want to make this driver a module,=
 you need
> > > to do 2 things:
> > >
> > > 1. Make sure the cited series gets merged and this driver uses the ne=
w API.
> > > 2. Get an Ack from Thomas (who is the only irqchip maintainer now).
> >
> > Should this be a hard blocker for building this one driver as a
> > module? I did a quick grep of drivers/pci/controller for irq_domain,
> > then compared several of the hits to the Kconfig. And every single one
> > is tristate. Tegra is by far not a unique offender here.
> >
>
> Not 'unique', yes. But the situation is a bit worse atm. Some of the patc=
hes
> (making the driver as a module) were merged in the past without addressin=
g the
> mapping issue.
>
> Please take a look at the reply from Marc:
> https://lkml.iu.edu/hypermail/linux/kernel/2207.2/08367.html
>
> Even though Marc said that disposing IRQs is not enough to make sure ther=
e are
> no dangling pointers of the IRQs in the client drivers, I'm inclined to a=
tleast
> allow modular drivers if they could dispose all the mappings with the new=
 API.
> This doesn't mean that I'm not cared about the potential issue, but the r=
emoving
> of modules is always an 'experimental' feature in the kernel. So users sh=
ould be
> aware of what they are doing. Also, we have not seen any reported issues =
after
> disposing the IRQs from the controller drivers. That also adds to my view=
 on
> this issue.
>
> That being said, the safest option would be to get rid of the remove call=
back
> and make the module modular. This will allow the driver to be built as a =
module
> but never getting removed (make sure .suppress_bind_attrs is also set).
.suppress_bind_attrs is already set in this driver. But what happens
cleanup on shutdown if the remove is dropped? Would it be better to
move remove to shutdown for this case?

Sincerely,
Aaron

