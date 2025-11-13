Return-Path: <linux-pci+bounces-41176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D318C59B9D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 20:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70DA3BBF16
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F2931A54E;
	Thu, 13 Nov 2025 19:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0X7qiri"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5087C316907
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 19:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763061502; cv=none; b=lj1scXqikril4yqUDYweGbb+unttAdOK8GCfyXrlw949xBTXZg00yGD70YUmAjR7kNOg7FnVn8HuEbjuD5rN+yv2u+ajW/fSAj20PPTIWOXVbEVVCGWP4d0Jg5ugXz9LGwZHxqDUa2KTO82FS3+Y+JD9G7BdXVWZT9qI54DcBm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763061502; c=relaxed/simple;
	bh=6UprQ8VPFTOJEJnrAk3c1+70Nbd/u85upyCo1jyU1qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/vDxUZd7kXG6zusXj0W5PWu+nT49YaErj73TAFvhrhZWqj4N/mvQoMOCDWxRQPn2HIXBgs1uHQ9kclOOMr7JYtfIwUl41Jikypcv0TQk9MrXVP5QQHZk4SaoaNsRZIss7hSiA+e0lWDtf2j3JKopII6HEpLlwV+KDLw+VQhoPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0X7qiri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C2DC113D0
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 19:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763061502;
	bh=6UprQ8VPFTOJEJnrAk3c1+70Nbd/u85upyCo1jyU1qk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W0X7qiriJx8qwv9BbYquHPo7dcdlB2adgQNwN+FfcpIdmW/AITZJ5Zpqm03CC/Dxr
	 6GnRSXQmfJ+W2vthEpzKITubGF74mnCc6WUcvin3uowyc8BT86f+//ZfLYv29g+BBF
	 lF+wiMxVq3NM9L1tiAzuG5XwvTH/cQqPOIPuH8Swojls+LSeWQiKJpBdWwsNkrHfoc
	 ViJlr54gGxXeICJKCHSvemTDsL0eAAUa1Kuky49BxecjyBAtJpJBy74zC1sU1paLFh
	 iEnE0JiwwGU2Q+ypXPimklXXrXm0/+3QIl6jESwwRiu7KL4wKdlkBy+NprPJA+WbMw
	 +qgnAYGxQ0H4g==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-656b7f02b56so536682eaf.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 11:18:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXG8i60pKPkX41RyXvj7C+BroJxyT1EvBm/8WtRYEgE2I1YzSk0VIT6NJVKnkwVY/L1B5Bia9LB49A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvZ8Um9gkb1maLuaFcYW4U4FKlgkOiYWClAtqN1CyOk9me2FV5
	qETTY5F/lu/qLzjMA/fZXfkR0QYQbX7t9aJOOpFyGh3jiHdR+nzp6WuNHWZTb8IHbK4ieGPoKtF
	/YpeAsiDgiU4yGCHUjl9V9enomHksAcM=
X-Google-Smtp-Source: AGHT+IEEkDRYf3o6eWh7An4Eb7oaPpWELLivUE1adLZQeit4rdCPvsjZcC3pPuLNVua35azYMW1z4kNGcBFvSY5y77M=
X-Received: by 2002:a05:6871:e324:b0:3d4:b889:7d65 with SMTP id
 586e51a60fabf-3e8674043b0mr485629fac.19.1763061501288; Thu, 13 Nov 2025
 11:18:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029163336.2785270-1-thierry.reding@gmail.com>
 <20251029163336.2785270-2-thierry.reding@gmail.com> <CAJZ5v0igMJ12KoYCmrWauvOfdxaNP5-XVKoSxUroaKFN7S-rTQ@mail.gmail.com>
 <3dzha4qyqdrbutxby3n5nkvihnxrhniqr6w726eumhzgln2w5l@fbu72mzmjz4m> <2tx3o5es77oa37zqvikcoo6n2ryxvepa54ezsaawcjdbf3g3wp@o2dbcbskjksk>
In-Reply-To: <2tx3o5es77oa37zqvikcoo6n2ryxvepa54ezsaawcjdbf3g3wp@o2dbcbskjksk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Nov 2025 20:18:10 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gupHEg8ip+2R1wYAQ=BQn4Mk5EMMu==StRxwvXA0WwsA@mail.gmail.com>
X-Gm-Features: AWmQ_bka8IUODzeQR5ggeX8uZbZXXCIST1G0sD3k8DJ8TOKe2Mgor6ApCD0oVpM
Message-ID: <CAJZ5v0gupHEg8ip+2R1wYAQ=BQn4Mk5EMMu==StRxwvXA0WwsA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] syscore: Pass context data to callbacks
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-mips@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 7:32=E2=80=AFPM Thierry Reding <thierry.reding@gmai=
l.com> wrote:
>
> On Wed, Nov 05, 2025 at 05:52:01PM +0100, Thierry Reding wrote:
> > On Mon, Nov 03, 2025 at 05:18:08PM +0100, Rafael J. Wysocki wrote:
> > > On Wed, Oct 29, 2025 at 5:33=E2=80=AFPM Thierry Reding <thierry.redin=
g@gmail.com> wrote:
> > > >
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >
> > > > Several drivers can benefit from registering per-instance data alon=
g
> > > > with the syscore operations. To achieve this, move the modifiable f=
ields
> > > > out of the syscore_ops structure and into a separate struct syscore=
 that
> > > > can be registered with the framework. Add a void * driver data fiel=
d for
> > > > drivers to store contextual data that will be passed to the syscore=
 ops.
> > > >
> > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > >
> > > This change is fine with me, so I can apply it unless somebody has an=
y
> > > specific heartburn related to it (Greg?), but in case you want to
> > > route it differently
> > >
> > > Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> >
> > I have a few follow-up patches for the Tegra PMC driver that depend on
> > this. 6.19 is what I was targetting, so if we could put this into a
> > stable branch that'd be the best solution. I can set that up via the
> > Tegra tree if you and Greg are okay with it.
> >
> > If that's all too complicated, I can probably wait until the next cycle
> > to merge the PMC changes.
>
> I've added this single patch to a branch based off of v6.18-rc1 that I
> plan to feed into linux-next so it can get some broader exposure.
>
> I can keep that branch stable so it can go through multiple trees if
> needed. If anyone's interested, the branch is here:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/l=
og/?h=3Dfor-6.19/syscore

You beat me to this, sorry about the delay.

