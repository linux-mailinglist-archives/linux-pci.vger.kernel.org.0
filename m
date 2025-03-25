Return-Path: <linux-pci+bounces-24612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E458A6E9AE
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 07:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014CD16BA79
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 06:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B1F1F8755;
	Tue, 25 Mar 2025 06:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2HYKJxMC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0AA93D
	for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 06:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742884739; cv=none; b=M7kYY6yBsB2asyU22b61/ASaCTaP5Am8Q/AuVjyAOVYd7hLnzf5R+DQGHKJrSa0GAUrsVrak7Af6o1tMiUKqfTreS7y5Cs0R5lBcBAImOzUfmUxHZh5vG8o3+PjZclm51V+T4I7alBHdZbSgmFLKwe7+3cDtyD543U/muBYLszw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742884739; c=relaxed/simple;
	bh=T1Kj5XzFBrmk3jHH7k6f4Yi0UaHdUydFK1dPr4nCHCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPTLzftbQBh64eFyyvuZ0L9V3nWsDk54QE18mXzehfoZ1ezmEAZHz5wEIjuFd3PRSJWNOcsL1wZqS8u6CzixN0xW6rreWPyPD1mx7afEW6CXOo27VKdijB9ILwoBAr4TIxs1N2M9r7YVOWzOXOwmlqVAedXSYI1wglpdzm9zm6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2HYKJxMC; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4766631a6a4so53036541cf.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 23:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742884737; x=1743489537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71tdewEckJw/9nhboX3/e3aFJxffZh5g7UprIW8MqNw=;
        b=2HYKJxMCYylCPq9x9N/uk1q77RLa9P0uS8uS7WjFtI4X7fdGdJMgACypahGtZzus8U
         o7RTeVXr6B2tR+OTrc2akym54iZ/Hvg34tDKbXixa8ad36C7RpuDzDeNJ2nn9WWHSFbS
         LWB1tH/L/lRqK3DlSbT+8vZsOEq9Kk5ny0FNVYD5w5Q5ASJTm/Jv5g9DmCULbNkon/Wv
         r3JtTIm7Y76lEfwRF9J3SL4BJQIjhiD/ooR+fBE56vs0DHyMwsKHKWj8rHLkkcSVEezU
         lZE4gtlFQsyGmRZ7GkLYZ9heO1AarIlwz6zz/2L4DR3YnlfLKEKSyHNUjOtbFMtGOqMz
         +UsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742884737; x=1743489537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71tdewEckJw/9nhboX3/e3aFJxffZh5g7UprIW8MqNw=;
        b=vbsrd7GvBjl4de6v1v8s7OjFvyx98ipn6SPLFBS5+7LgtL02SijFaSOak7xYoVgmOQ
         M6Z+sfTClUPqhdZfyevLtsfF13jAzVeyTxvInwQs88yoRe5mYbSeNLYPAEvV2P3xmOs/
         OYQP//RtgfDziw8XHpPv/gbNvcsOo15PPjLnglqnyTNyJr6AteFrolsplffvrWW7hDj7
         ScuwFCdz40nzS9UA9TdBpycdvcp4ER8Z7wm1qYA+cDyIS9C5S/V0MMAx0dYXRyrRaTNP
         syYEgbSj2B5Q338cvi/Nv0sR+N65VKzkyK8wUzDdw5mA53vcidt8j4JiBMAKUH5izqxd
         g8Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUQAyvg7JLvPUqrkSiF8VzUBl6ybSQELALsGyIGijKUcXufD1rUL3xICfdm2AdIUwcqDmh1eLcexiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQvMFgAUMCq3Ef1siXkcuw888tWrCLhhs7kwDbK9tLpBTzqViR
	PPwEE5Y3lcjp1bu6FYd2GQ4RYIBsJyX/qeHB4UVshKOrRwHbh4U1kXFMtsnzxQ+axgcfLqZK6kv
	3a6h3A1GP1bJGOfuGwRhuVwBB4CQppXlL08zK
X-Gm-Gg: ASbGncttNpM4OqX0dS4qLZyWTQ52Zax7cSpfofIviU2WVREN/jq/+syCyG1WRJbkkIM
	fE4KJoyptcVcH813Q6Tgn657zG/Pasv8My00IFs7q0axZhK1dD4NHbG0v6ctXzk56/KpUgJsnuK
	5ok5LiPC+F8aV4HaDwld1E5IyIeMjVqMIjAzn3YKeFXf1oSSz8tdylc3I=
X-Google-Smtp-Source: AGHT+IEGKZi+1aLt9scm9sUb9YqAFLoiTtqxzsba9OKFz2SH4DHeaqUENbYD6sAd8IV/WNsbR6PqJ9B/RKqnO0xTd0g=
X-Received: by 2002:a05:622a:250a:b0:477:4224:9607 with SMTP id
 d75a77b69052e-477422496a6mr99228691cf.12.1742884736415; Mon, 24 Mar 2025
 23:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303070501.2740392-1-danielsftsai@google.com>
 <87a5a2cwer.ffs@tglx> <CAK7fddD4Y5CJ3hKQvppGB2Bof4ibYDX4mBK3N1y8qt-NVoBb7w@mail.gmail.com>
 <87eczd6scg.ffs@tglx> <CAK7fddAqDPw1CuvBDUsQApbs1ZSE_ruyTAdsp+c4116C0ZjvVw@mail.gmail.com>
 <878qpi61sk.ffs@tglx> <CAK7fddCG6-Q0s-jh5GE7LG+Kf6nON8u9BS4Ame9Xa7VF1=ujiw@mail.gmail.com>
 <878qpg4o4t.ffs@tglx> <CAK7fddBSJk61h2t73Ly9gxNX22cGAF46kAP+A2T5BU8VKENceQ@mail.gmail.com>
 <874izz1x42.ffs@tglx>
In-Reply-To: <874izz1x42.ffs@tglx>
From: Tsai Sung-Fu <danielsftsai@google.com>
Date: Tue, 25 Mar 2025 14:38:44 +0800
X-Gm-Features: AQ5f1Jp-jjTIxnmSKo3TNp7XO34_AyVvuL271vXLLP8rCOHFLde3CpN2V_7ltwY
Message-ID: <CAK7fddBidt90Yjh=fjj=w8uovjEyes6Qe1U0m7k5XWGYZm+GHA@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Chain the set IRQ affinity request back to the parent
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Chant <achant@google.com>, 
	Brian Norris <briannorris@google.com>, Sajid Dalvi <sdalvi@google.com>, 
	Mark Cheng <markcheng@google.com>, Ben Cheng <bccheng@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 10:05=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Tue, Mar 11 2025 at 17:52, Tsai Sung-Fu wrote:
>
> Please do not top-post and trim your replies.
>
> > Running some basic tests with this patch (
> > https://tglx.de/~tglx/patches.tar ) applied on my device, at first
> > glance, the affinity feature is working.
> >
> > I didn't run stress test to test the stability, and the Kernel version
> > we used is a bit old, so I only applied change in this 2 patches
>
> I don't care about old kernels and what you can apply or not. Kernel
> development happens against upstream and not against randomly chosen
> private kernel versions.
>
> > And adding if check on irq_chip_redirect_set_affinity() and
> > irq_set_redirect_target() to avoid cpumask_first() return nr_cpu_ids
>
> I assume you know how diff works.
>
> > May I ask, would this patch be officially added to the 6.14 kernel ?
>
> You may ask. But you should know the answer already, no?
>
> The merge window for 6.14 closed on February 2nd with the release of
> 6.14-rc1. Anything which goes into Linus tree between rc1 and the final
> release is fixes only.
>
> This is new infrastructure, which has neither been posted nor reviewed
> nor properly tested. There are also no numbers about the overhead and
> no analysis whether that overhead causes regressions on existing setups.
>
> These changes want to be:
>
>    1) Put into a series with proper change logs
>
>    2) Posted on the relevant mailing list
>
>    3) Tested and proper numbers provided
>
> So they are not even close to be ready for the 6.15 merge window, simply
> because the irq tree is going to freeze at 6.14-rc7, i.e. by the end of
> this week.
>
> I'm not planning to work on them. Feel free to take the PoC patches,
> polish them up and post them according to the documented process.
>
I really appreciate the patches from you, I am quite new to the
upstream and IRQ framework. So would you help to share
some experiences on how this kind of new infrastructure of IRQ
framework should be tested if you don't mind ?
> Thanks,
>
>         tglx

Thanks

