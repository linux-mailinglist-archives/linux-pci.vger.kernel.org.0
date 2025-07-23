Return-Path: <linux-pci+bounces-32786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642B0B0EDF9
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 11:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81953B4EB5
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 09:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8FB283CB8;
	Wed, 23 Jul 2025 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTnM5XzO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E751281526;
	Wed, 23 Jul 2025 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261274; cv=none; b=s03QXbsV7sh9n2S3Nx7tCjrhOOsAjNg5ACPBd3LpvPhtcpFVzl2qih2OCJ26g1WZzD4JjljwJ5s2xcWLUiee3hBWGZsJmqTqWn+76iZd/OWlwQTb3YI1ZEKBCZEvvbxFV8ZUp7cCCOyXIhzQPpUHR1R6ExNy6fPlG+msBDmUeUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261274; c=relaxed/simple;
	bh=HVQUD3Ib6X4vO1vXKL8LG+SI0kZlkOlq4KpZxCl65JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iks2YfScb2zL0OToQI07fr0RlB333hHC186ez81CewbAdtCyLnYEl+iugyCjQCXC2Yfe4aRvOFSN4JSaSWapi4+hN0FQNc0WYzRHMsNtlg/fJajb7Xh1BCN1DIT+PILSCGQ2VBHnrH7TvgdUbIRzjzCR0aKcz93N/bphD6lC3GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTnM5XzO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451d6ade159so46444785e9.1;
        Wed, 23 Jul 2025 02:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753261271; x=1753866071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vfi+7jzS+QroB9ovq5xCDmfLCYDKNlqIdXI2M9FMRkQ=;
        b=dTnM5XzOon+hYkFce4v6HlsQVUqWSbG+luh3GOazYDIB7lxmlTdOMNrGcYasjwDovO
         4nbUzlzZFZkMSyCBrM8Myz13/vVPmanODR1v4XUyK075zOua2KHIicFwNmek70NrQtQt
         mUBGB8kpoqoMx2JQEyqRyJBPVFKk/OzOA9nEqsXJfOAk8RS1EG/T+BEcNZJ0x1yNj8ww
         wpmGq0wqmBzOlCpNpBT46KlJ2y8bGAAwQNCV6P4+QonQ+ryOlZbMMmGI9oF8NbfJyUAJ
         ynQPMc7R++g8rtTl+jhlkidoXegIV0elaf9DkC90RstOK5C9qNaGliyFcLdvJteTKHM9
         pyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753261271; x=1753866071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfi+7jzS+QroB9ovq5xCDmfLCYDKNlqIdXI2M9FMRkQ=;
        b=tM95JbJknTO5amcvBuD9mqVZGSKJY1ikD1eQJuB6aSOJh4PBZgP3gOQ5AJsPUkonAh
         l811sjYVB/paJKdFQ7lbcg9/CFskbLwLEBAORARaA/HkGpuKbcxnLPo+ApMc7BFAYk1F
         HTJMGsqR6BA3JxCNWZtp6P6gahd9KrIB6AMIXQgCutZh4f/bYkhz94fHs5erX3ZX9uE5
         Au9rcJHDcPczKu0GNbVZk0ifoPBDJRoFXHzWjSYumcOWyY286F51cEJtFUhhME+b/vY7
         LNOdPCzIKAAdN0l+HuYgrLv/0qanhwOsmqh1PbyfuS7u9h4kKFyo1RWQMxOusssId3nS
         p96A==
X-Forwarded-Encrypted: i=1; AJvYcCVBdziDoIkGh+W77lsl9WRKyL7NhfQoOAjf1fxfNhkSCw4QI2r/L/R9By44M9D/Xdq/sm5pDRok4M5L@vger.kernel.org, AJvYcCVZxgL0MgnGcDZ04pTVQoh0OQpUYEyeHa/uSFyZCqgVrCUEkjrq5wUCdG1yho6a1iyCmyzFDYWpTqj8@vger.kernel.org, AJvYcCVlmwcdyKQsDj66H410QFs+ve00XquhBfULeTMV5BLElT3WOINaUGXpGsdp8U5gII1WDOGxhVuvm7s=@vger.kernel.org, AJvYcCWeqVyjBxeJ1+JE7DNtO+3Un7qqyvJ7HFZ8/u4TI8xTQyuw28IbdSDJ1WwRbi/GzQW7qnlpiMnexdDYbQ==@vger.kernel.org, AJvYcCX1vu+Axx8jhu0oo9Mo5/XjUREB+D4lpAD8eSor4VfxdQeY8EwSiZ2NMB6WK0/bPshnU53s1Stu4Q4eMuPe@vger.kernel.org
X-Gm-Message-State: AOJu0YyEZ+ZYurPG55EDoqwlFNpfrNNOdJi8ujOJY0bsWPzYCpT92pRR
	gKfNm8CMdFoNz2P1/2zhUw+vlocXS5c/z8OnUEyaivE4zeICT2fuOK0O
X-Gm-Gg: ASbGncuZnvtMR52VXcMm8oi1MgrDo/nDbotQIHjfmUmdamFreKltkR9yJlLj1SW0IO9
	Qcs9XLeYC+hW6li8Di4Hz5irXZ1IqIpLrPq+wMTCBaFaScMyW90onAZD1G8dwxMMQ1lhD2T25wQ
	nlcWiLdaB+5A8ZqWa0DyO20L0eAn7i0I66gEtjvZYcUVXZBFPHcfwM8XYKgQRMRjcXBRLIbHsQo
	U+22lotcEfwHY3AZsNF6f6Igcb+c8V95LMXVfDNVwsUGkj3o/HdYQzYzmmiEQonSkbEFfy1/p5O
	c7RRq6x04hPmQMXRBLO4N3Cljui9H/tT7/aQV5thYes3Iq2tbxYeAE0itgOZN4GaDQPAift1iAP
	z3gUOEwEQeOrSgdaLeWaaNrwMd3v4rubNYnMhoAWIHd5nryMjpLk4h4QF/nZDBRYo07xJvCfa9Q
	sfxZwfkMqY
X-Google-Smtp-Source: AGHT+IEknrstHg6cUD/SgoHhNho7BNCTRJA/GS5vJOJzPvYI6zayldv/5uJL7C58FRXa6VpYJz8Fmg==
X-Received: by 2002:a05:600c:8b08:b0:456:1b93:76b with SMTP id 5b1f17b1804b1-45868c79052mr16967605e9.4.1753261270574;
        Wed, 23 Jul 2025 02:01:10 -0700 (PDT)
Received: from orome (p200300e41f4e9b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4e:9b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca25533sm15448303f8f.11.2025.07.23.02.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 02:01:09 -0700 (PDT)
Date: Wed, 23 Jul 2025 11:01:07 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] syscore: Pass context data to callbacks
Message-ID: <awvdox3bgabbc42aamezlg33k4cje6y75qoxn7ruh3nhd4qv5n@u3spdahehad4>
References: <20250717103241.2806798-1-thierry.reding@gmail.com>
 <2025071716-phoney-object-1648@gregkh>
 <rzbzah5iigz25jtxyqadnitkzkazxsaxntajhlfrfdslyioevk@pylcjkfh5n42>
 <2025071919-patience-cattishly-cf7c@gregkh>
 <l54i36uk33je744w4f47tehdopk5dsjotvozfv5b2hehmxrwpq@eins7awyq4dy>
 <2025072218-decipher-spree-327d@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t3b24mrvydogtoje"
Content-Disposition: inline
In-Reply-To: <2025072218-decipher-spree-327d@gregkh>


--t3b24mrvydogtoje
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/7] syscore: Pass context data to callbacks
MIME-Version: 1.0

On Tue, Jul 22, 2025 at 04:08:09PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jul 22, 2025 at 03:56:40PM +0200, Thierry Reding wrote:
> > On Sat, Jul 19, 2025 at 08:52:41AM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Jul 18, 2025 at 03:49:37PM +0200, Thierry Reding wrote:
> > > > On Thu, Jul 17, 2025 at 02:11:41PM +0200, Greg Kroah-Hartman wrote:
> > > > > On Thu, Jul 17, 2025 at 12:32:34PM +0200, Thierry Reding wrote:
> > [...]
> > > > 	struct syscore;
> > > >=20
> > > > 	struct syscore_ops {
> > > > 		int (*suspend)(struct syscore *syscore);
> > > > 		void (*resume)(struct syscore *syscore);
> > > > 		void (*shutdown)(struct syscore *syscore);
> > > > 	};
> > > >=20
> > > > 	struct syscore {
> > > > 		const struct syscore_ops *ops;
> > > > 		struct list_head node;
> > > > 	};
> > > >=20
> > > > Is that what you had in mind?
> > >=20
> > > I missed the list_head, so yes, this would be better, but don't pass
> > > back the syscore structure, how about just a void * instead, making t=
he
> > > whole container_of() stuff go away?
> >=20
> > Yeah, that's a possibility. I personally don't like passing the void *
> > around because it's easier to make mistakes that way. I also find it
> > unintuitive because it doesn't immediately show you what the functions
> > expect.
> >=20
> > My understanding is that the container_of() should get optimized away
> > most of the time, so there aren't any obvious downsides that I can see.
>=20
> container_of() is just pointer math, but a cast is even faster :)
>=20
> > But I don't feel very strongly, so if you have a strong preference for
> > void pointers, I can do that.
>=20
> That's what you really want to have here, it's a syscore data type
> thing, that the callback wants to reference.  Just like a irqrequest_t
> function passes back a void * that the handler "knows" how to deal with
> properly.

IRQ handlers are different, though, because you pass the void * data
when you register the interrupt. That void * then gets stored and passed
to the handler when the interrupt is processed.

We'd have to change it to something like this:

	struct syscore_ops {
		/* parameters now changed to driver-specific data */
		int (*suspend)(void *data);
		void (*resume)(void *data);
		void (*shutdown)(void *data);
	};

	struct syscore {
		const struct syscore_ops *ops;
		struct list_head node;
		/* NEW driver-specific data */
		void *data;
	};

It ends up increasing the syscore structure's size, about 33%, though
given that there aren't a lot of these that's probably negligible.

What I think is a bit more unnatural about it in this case is that we
embed the struct syscore into some driver-private data anyway so that
it becomes per instance, and then we have a circular reference:

	foo->syscore.ops =3D &foo_syscore_ops;
	foo->syscore.data =3D foo;

Which looks kind of weird. Alternatively I suppose we could completely
rework it and make register_syscore_ops() allocate struct syscore, and
hide the internals from drivers completely:

	err =3D register_syscore(&foo_syscore_ops, foo);

With that it may be problematic that register_syscore() can now fail.

Thierry

--t3b24mrvydogtoje
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmiApM8ACgkQ3SOs138+
s6G76RAAlyjbBOBTf8eNokhrwb69GbuFv4iEunTnd/Xy91IhOncqHjdYHN3rqTn9
GZWy+L9VFYLaEmLV5W1ChOD3rYHCxZ3gep+jdE5ThLQvJaK4IBB4oGZ0OGXLHmVy
TqNy+Tq/dQi2jM2o7MW1DUDM8EunrbLmjBWZZONJzH18GqJPn3LWazuC7tBBL6vu
bmowzEXxm+4NWx5Ow3IvFnLzDa05JLaBKtVREPuf/UdRHcjzrra1RyYLyaYUI9Gy
pWZHkgUA+1gAO2hutK8eyL98cZlnl8zrArmduJZsyZQhcNe1ltwPTzUq9wejYOr+
Vywgy/CxznLtvKd0e27hP/I7zCx64ktofCb6l0SwueraLWYTcpJLQ23T93g1bDwY
02o6cq0874YQdndJytU7t3cKETe5uXF0AGmepX/+GKvcQN6lBqo04OL+Ge6yRMyy
G9gv6P2nxqY+RWkDrFtqO6RwFB+lJSwc2J3RfxHC/2ygMy2Zr2AJ5oeeAKOtTZ/0
smpK40Y2FB6y4ohGq3UK3uPyBvOJi/jw6sMuRyv2Ou7tJIFE2EtSpA5+m5DcwUcR
gRcfO6O0V9Y6qWBx2Tt+i6Fzekj/0xBzlQdyvCom8xrhRZ9VGbZBfpIaXDs/Anp6
ovlk/rkbo8DsYQQxINnmSBx2uQcWSCYAU53leg5fnr4EoSGPCsg=
=l8CI
-----END PGP SIGNATURE-----

--t3b24mrvydogtoje--

