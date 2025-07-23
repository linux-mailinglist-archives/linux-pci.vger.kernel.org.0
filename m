Return-Path: <linux-pci+bounces-32791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49585B0F125
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 13:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7551C21098
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 11:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703662C1581;
	Wed, 23 Jul 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gna5kEEQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33188298CA5;
	Wed, 23 Jul 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270044; cv=none; b=Wr1exv4SUQQf1xCgcZGEn6teWVWuXr8q5qE+ofvqKvyDI9eEiRyT3nsjCsC6WNF/PQeLzzsBUg6Uz5kgSEaaWtrTDaYxLU7QZLKiBQHa/xJ1W1AIKAsNKtZh8ggTh6PLKRlJ3y13OkYc0Zjzq2Bk+C9pfsi9vm5wr5uksf6KppU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270044; c=relaxed/simple;
	bh=hD86L6FsrlkjppEeAolQw2+wF9G9eL2p4jeufpqBKxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nz8Oxckp0BymRRHH2osrDZkMaSbERMMag4ODDRUdsSQsxNqAJ1VzOofgVZX0usn2MwTThYtH2eVSN/4Q+jJfHacwTaQe7/1sX6jpJ9MlThFh/Y1Mqiv9bGhQHswPY1wvUnNcQf5uEbc2nmcdTdKXAyBqKy3ab0iC8z2/APK5Kfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gna5kEEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B482C4CEFB;
	Wed, 23 Jul 2025 11:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753270044;
	bh=hD86L6FsrlkjppEeAolQw2+wF9G9eL2p4jeufpqBKxk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gna5kEEQO0FOgZEpDT/57P3FtgjTpO2uSn7YtKJvIt8uQQR2K96rr5I5udfJm84c7
	 hUCixUBGhFeFewlQZl5ImSC12rQ066qMf33T+t3KnfWw+hieP3bmovSIvdSeAyro8T
	 rDAvE+1zTwuK+7PZStdlqwoxksDnTVrcewtIfj0R90Lk/7OxSRV5htQPL9mATKUKqn
	 FNwWYdXoTMs9ewijIHqVuJHpbLeK6rcl8FxiEfKc5PDZ3OLEg2jRWi7e2qpVcLBpwt
	 iwQTgypKrgsoWPbsVBwEt0XAYFokUpVjX2z6qSPVn+usBpJA0Qs7v+HL/XzcT/azs+
	 7u/n5xDVV9aNQ==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-615950642d9so3685530eaf.1;
        Wed, 23 Jul 2025 04:27:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVA90WZwlVDKAAhkMgJ9pQs5ATm5vXqWNDP+sJCiVEAK78c41BTZ/U3FKkSEM7f7qdLw9WVTHHfTW3kTg==@vger.kernel.org, AJvYcCVlJyI9wxUCKkbpaZ/U2Xqljovewpkizp+6ECP7hfxBh4i5M0E5c35dzwNNYQKjtQqjd01/FfI7KnI2bq8M@vger.kernel.org, AJvYcCW/iGCLypQJwBalgOSD7vA1mW5xb/Hwz9yCttbSJlC0PoAAVvBU/LAWDhmQ/JBjJDvAtDnDJo+8SOOg@vger.kernel.org, AJvYcCWFvtxvIEDxM8Uyb1mglCpQ4LuT1AuxaCFT1i58qW8vwOGYzhnu9TWPrTiLJENx69c5aWmTVglfJr8=@vger.kernel.org, AJvYcCXng8T4on/6u7aTCHQPNAcmwa+KiIHwPQ3nu9T6CgSCT2LjeIhRCTcdloh4uhDCQ74HFOk/XrxdhZNs@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/9zDwljMwqXHSMsJ3UrKyvCrl2nRZUiylz3HYwvNUL004yDV5
	JXFopWExb/ZTLbZ/zzkUl7CmF9JV3tIpJQVdTcqNWPqu69A0TMeQniVQ2XOTB4I2Ee1TfDTi/27
	0p4CcGNwSjYSxNn6kLuJpHklzdhppHfk=
X-Google-Smtp-Source: AGHT+IFBBrTSzcKsgRsjEmVEi3AQj37BeFlkMYzSpLg5VvEYvowlyBOnql/yOqAWuu2WwDYjxLgaMwyjRGbr4TyyCQA=
X-Received: by 2002:a05:6820:1792:b0:615:d742:6672 with SMTP id
 006d021491bc7-6187d90ed5dmr1918110eaf.8.1753270043105; Wed, 23 Jul 2025
 04:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717103241.2806798-1-thierry.reding@gmail.com>
 <2025071716-phoney-object-1648@gregkh> <rzbzah5iigz25jtxyqadnitkzkazxsaxntajhlfrfdslyioevk@pylcjkfh5n42>
 <2025071919-patience-cattishly-cf7c@gregkh> <l54i36uk33je744w4f47tehdopk5dsjotvozfv5b2hehmxrwpq@eins7awyq4dy>
 <2025072218-decipher-spree-327d@gregkh> <awvdox3bgabbc42aamezlg33k4cje6y75qoxn7ruh3nhd4qv5n@u3spdahehad4>
In-Reply-To: <awvdox3bgabbc42aamezlg33k4cje6y75qoxn7ruh3nhd4qv5n@u3spdahehad4>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 23 Jul 2025 13:27:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iYBOephv29sj0DSKZVyF3JLBsoUCckhTbGcbYHUUhYyQ@mail.gmail.com>
X-Gm-Features: Ac12FXzC6e4YCoK78tnnsrW1OvCOkcpvLKri7HC2f5clbN5j5h64RJlwkH_QRPE
Message-ID: <CAJZ5v0iYBOephv29sj0DSKZVyF3JLBsoUCckhTbGcbYHUUhYyQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] syscore: Pass context data to callbacks
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-mips@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 11:01=E2=80=AFAM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> On Tue, Jul 22, 2025 at 04:08:09PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jul 22, 2025 at 03:56:40PM +0200, Thierry Reding wrote:
> > > On Sat, Jul 19, 2025 at 08:52:41AM +0200, Greg Kroah-Hartman wrote:
> > > > On Fri, Jul 18, 2025 at 03:49:37PM +0200, Thierry Reding wrote:
> > > > > On Thu, Jul 17, 2025 at 02:11:41PM +0200, Greg Kroah-Hartman wrot=
e:
> > > > > > On Thu, Jul 17, 2025 at 12:32:34PM +0200, Thierry Reding wrote:
> > > [...]
> > > > >         struct syscore;
> > > > >
> > > > >         struct syscore_ops {
> > > > >                 int (*suspend)(struct syscore *syscore);
> > > > >                 void (*resume)(struct syscore *syscore);
> > > > >                 void (*shutdown)(struct syscore *syscore);
> > > > >         };
> > > > >
> > > > >         struct syscore {
> > > > >                 const struct syscore_ops *ops;
> > > > >                 struct list_head node;
> > > > >         };
> > > > >
> > > > > Is that what you had in mind?
> > > >
> > > > I missed the list_head, so yes, this would be better, but don't pas=
s
> > > > back the syscore structure, how about just a void * instead, making=
 the
> > > > whole container_of() stuff go away?
> > >
> > > Yeah, that's a possibility. I personally don't like passing the void =
*
> > > around because it's easier to make mistakes that way. I also find it
> > > unintuitive because it doesn't immediately show you what the function=
s
> > > expect.
> > >
> > > My understanding is that the container_of() should get optimized away
> > > most of the time, so there aren't any obvious downsides that I can se=
e.
> >
> > container_of() is just pointer math, but a cast is even faster :)
> >
> > > But I don't feel very strongly, so if you have a strong preference fo=
r
> > > void pointers, I can do that.
> >
> > That's what you really want to have here, it's a syscore data type
> > thing, that the callback wants to reference.  Just like a irqrequest_t
> > function passes back a void * that the handler "knows" how to deal with
> > properly.
>
> IRQ handlers are different, though, because you pass the void * data
> when you register the interrupt. That void * then gets stored and passed
> to the handler when the interrupt is processed.
>
> We'd have to change it to something like this:
>
>         struct syscore_ops {
>                 /* parameters now changed to driver-specific data */
>                 int (*suspend)(void *data);
>                 void (*resume)(void *data);
>                 void (*shutdown)(void *data);
>         };
>
>         struct syscore {
>                 const struct syscore_ops *ops;
>                 struct list_head node;
>                 /* NEW driver-specific data */
>                 void *data;
>         };

I like this more than the original, but I would do

struct syscore_ops_ops {
                 int (*suspend)(void *data);
                 void (*resume)(void *data);
                 void (*shutdown)(void *data);
};

struct syscore_ops {
                 struct list_head node;
                 const struct syscore_ops_ops *ops;
                 void *data;
};

and change register_syscore_ops() to take three arguments, the struct
syscore_ops pointer, the (constified) struct syscore_ops_ops one, and
the (void *) data one.

Note that it is not necessary to change the signature of
unregister_syscore_ops() in this case.

> It ends up increasing the syscore structure's size, about 33%, though
> given that there aren't a lot of these that's probably negligible.

That's not a problem IMV.

> What I think is a bit more unnatural about it in this case is that we
> embed the struct syscore into some driver-private data anyway so that
> it becomes per instance, and then we have a circular reference:
>
>         foo->syscore.ops =3D &foo_syscore_ops;
>         foo->syscore.data =3D foo;

That depends because "data" need not be "foo" in all cases, but also
see above.  If the initialization of struct syscore_ops is all done by
register_syscore_ops(), it doesn't look circular any more.

> Which looks kind of weird. Alternatively I suppose we could completely
> rework it and make register_syscore_ops() allocate struct syscore, and
> hide the internals from drivers completely:
>
>         err =3D register_syscore(&foo_syscore_ops, foo);
>
> With that it may be problematic that register_syscore() can now fail.

Yes, that might be a problem.

