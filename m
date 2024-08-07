Return-Path: <linux-pci+bounces-11452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA5E94ADE2
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 18:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D9C1F224DB
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 16:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32162131E38;
	Wed,  7 Aug 2024 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHFc4o2E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8E783CD9;
	Wed,  7 Aug 2024 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047500; cv=none; b=qb3g9mB97I09hJ8FHQtNHzcp/BlNM/8DKV9yTXsWnE2jboiYx9p6Y9omvZ4LrKZs2FynPmLAWJFi+gLdituu1xuG3XLSXaQUPHz9QeX4zDrFoAVsEBSBfgnKex0maXcsGCCUZ7JfbRZ4MNGAlSX8To1t45Z0eNp4brKe0LRGoDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047500; c=relaxed/simple;
	bh=Mk0s1ojZm5rRkmgUowxlKminrXpJsoJRheZJbo2FHR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXZiKulWho6gARJzJ5ugPxwkjQKxl1U+ESkrlDu/Sj8FNM3rLth7eFsfhrTFhSUpiJUYp6ymbVfDJXbn6Q7ByZTr+5uKomKsvqX0Va8xv82l3C0DGTdICErjn40rEq0kt0TatkAC5a6HqAmQ50U4oVvuBGSms5pSRWO4s6y7Pwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHFc4o2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889A1C4AF14;
	Wed,  7 Aug 2024 16:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723047499;
	bh=Mk0s1ojZm5rRkmgUowxlKminrXpJsoJRheZJbo2FHR8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jHFc4o2EWcCuc5F8Qtug/XwHS77hf3POA/H9W9hxDeKIhlAvUxLVqx5qxUlVaAE9v
	 jMsE64Mw+0wQ992/MaI139CBssMBrbDGLxeGoP8NXPfiWvJne9ysKMsdBoGNbNmp/M
	 rDPTfdUI1M+wwv2FZ8sJfATyzEvBrSnYDtG8Lr9c4CZENR+FOZlSjObwJ+qJF4A7YB
	 ARDbsDvY/rmnJ6lyCjBsNG/jIilc6cBUgO8mMMV2ikTNdvxvgUmvnrUOPEPWPwPv3I
	 duYegBdcgRNAo9zu8P/Lk+7nalvtnkycvwYknYN9jKUgc45c3pJ9OUxty5vMAUgGeI
	 c8XyDqxBhH7cw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f15e48f35bso19913811fa.0;
        Wed, 07 Aug 2024 09:18:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsN1HJ4h9nk1d9VgUt6CFXWg1HeXQmDt52gNwOdp2XYDkSoKsD909lbWbwW9YWmE60sjgzGtd3RPDJMy3uytSilPK8cvNOFt9It7npmBS7hm22undmpv1viYSgWFyE8S1vr9aCIBdP
X-Gm-Message-State: AOJu0YzGEzsbClm29W8fick9gaON9IBmwf9x0sNHCllehw0cPGBWcrjw
	sYaBZqq8X61syac704dThy3UiwFA743poOtrffMTK9UozCciH3IVdGHK/HBZnRL+Tz3tBGbgArb
	6wxW+XGRFgiYqQ9jW7LiiFqIqHQ==
X-Google-Smtp-Source: AGHT+IFvirPG+TexAuy0pTZCC7qLUjk+KO3EuU2+ZkVQoTOgfugzk2BZ9UwEKE1QT2p/A/TCIRhp02Ocdm5b72pn2I0=
X-Received: by 2002:a2e:720a:0:b0:2ee:7dfe:d99c with SMTP id
 38308e7fff4ca-2f15ab0c434mr137527131fa.31.1723047497621; Wed, 07 Aug 2024
 09:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719223805.102929-1-david.hunter.linux@gmail.com>
 <20240801235526.GA129068@bhelgaas> <20240807114747.00002fc2@Huawei.com>
In-Reply-To: <20240807114747.00002fc2@Huawei.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 7 Aug 2024 10:18:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLTDDAtCQ2YeNjUZ6dPJmRtaSEYmYtN2-jAjQFkpKRLfg@mail.gmail.com>
Message-ID: <CAL_JsqLTDDAtCQ2YeNjUZ6dPJmRtaSEYmYtN2-jAjQFkpKRLfg@mail.gmail.com>
Subject: Re: [PATCH] of.c: replace of_node_put with __free improves cleanup
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	David Hunter <david.hunter.linux@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, julia.lawall@inria.fr, 
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 4:47=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 1 Aug 2024 18:55:26 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> > [+cc Rob, Jonathan]
> >
> > On Fri, Jul 19, 2024 at 06:38:05PM -0400, David Hunter wrote:
> > > The use of the __free function allows the cleanup to be based on scop=
e
> > > instead of on another function called later. This makes the cleanup
> > > automatic and less susceptible to errors later.
> > >
> > > This code was compiled without errors or warnings.
> >
> > I *think* this looks OK, but I'm not comfy with all this scope magic
> > yet, so would like Jonathan and/or Rob to take a peek too.
>
> I'm suspicious of usecases where there isn't a constructor / destructor p=
air.
>
> This is more of a 'steal' the pointer and destroy it pattern.
>
> Also, bug in this case.... see below.
>
> >
> > And is there some way to include a hint here about how to find the
> > implicit of_node_put()?  I think it's this from 9448e55d032d ("of: Add
> > cleanup.h based auto release via __free(device_node) markings"):
> >
> >   +DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_=
T))
>
> Yes, it's that one.  Makes sense to add a reference to that in the
> patch description for these.
> >
> > but it did take some looking to find it.
> >
> > If it looks good, I'll tweak the commit log to use imperative mood:
> > https://chris.beams.io/posts/git-commit/
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?id=3Dv6.9#n94
> >
> > since this technically says what *could* happen but not what the patch
> > *does*.
> >
> > > Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
> > > ---
> > >  drivers/pci/of.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > index b908fe1ae951..8b150982f5cd 100644
> > > --- a/drivers/pci/of.c
> > > +++ b/drivers/pci/of.c
> > > @@ -616,16 +616,14 @@ int devm_of_pci_bridge_init(struct device *dev,=
 struct pci_host_bridge *bridge)
> > >
> > >  void of_pci_remove_node(struct pci_dev *pdev)
> > >  {
> > > -   struct device_node *np;
> > > +   struct device_node *np __free(device_node) =3D pci_device_to_OF_n=
ode(pdev);
> > >
> > > -   np =3D pci_device_to_OF_node(pdev);
> > >     if (!np || !of_node_check_flag(np, OF_DYNAMIC))
>
> Wil now put the node if that second check fails. Didn't do that before
> and I'm guessing we shouldn't?  Technically it calls the cleanup
> in the !np case but that is fine as we check for NULL pointer.
>
> So I'd leave this particular one alone.

Right. The pci_device_to_OF_node() doesn't do a get, so using __free()
isn't really appropriate here. The put here is to free the node. The
get to balance the put was the allocation of the node.

Rob

