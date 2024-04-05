Return-Path: <linux-pci+bounces-5755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B5B89927E
	for <lists+linux-pci@lfdr.de>; Fri,  5 Apr 2024 02:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3F32823C9
	for <lists+linux-pci@lfdr.de>; Fri,  5 Apr 2024 00:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E76C393;
	Fri,  5 Apr 2024 00:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7BMKCsk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA1236F;
	Fri,  5 Apr 2024 00:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712275948; cv=none; b=uViorCVDG+mBzutysrJec6BP07VO4fiNDnedUZQKK0fLdQhOo2/ZdHMBucDAFevYmnizlKI25FSGQyR4J5XRn7ClVLl27VFmR8cTkcTt3EJmokXE0BZTNNh7ugh2f2qz4Ne7ZKgAsRHjaX0KJFL+wjwO5IMwp2SOFTlZJk43J3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712275948; c=relaxed/simple;
	bh=omc4lpuY9giELKfLxMsx/Ib2N0mC7vAkFp7YcFSNEA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4E++KEO09mzf0HUwDtjmUbaaWl9GXjBRqDMMFgtuY+TXIMSq7rIZyAzFxFxtQSF2lZACzxLAdn1h9J8yx2S8ucudHUsF8CrtslXMdWroP4aOBdOmbcAks6umtHbcwkw+FrEh/BSqTvyRdZzQ5wSj2Zk6dbeDUQllvW0QQCUtDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7BMKCsk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3436b096690so2069005f8f.1;
        Thu, 04 Apr 2024 17:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712275945; x=1712880745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omc4lpuY9giELKfLxMsx/Ib2N0mC7vAkFp7YcFSNEA8=;
        b=c7BMKCskirYoKAX0keLUrkLkzgs5060XjfcPJs0R2ueG62eewntIe1km2Xvq+P+b9E
         LjGpWsV8vzXZuy+u0Fp8dQ2pAcwYTxifC9zlaO5NDcUfnAiwSiL+QgDsTaEHZlZ4PSm1
         oFcemBqm1QQkeuEdQWPFx2B28VnrhcD6HJxd3pbFW1Wx4ViXqk16Au9Z4Wyg7H/mdap3
         VszTt90gp09lb/XK1vWpIoZjXnF54s67GfdsWXUhoSH4x+piLUvOVOoPItydf41BkIRg
         w764cQsoBqdL8CzORNXIlz/XClMGhEbx4WdrT6+G3N7803Fzn5b7FUOJDzWXR7CFekUo
         elFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712275945; x=1712880745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omc4lpuY9giELKfLxMsx/Ib2N0mC7vAkFp7YcFSNEA8=;
        b=wArLB/pdkZwwHEcyHafIgv/3pwFHlGf495DEwfkO6QzVPjFQWoEgh17vXiPitdq4Nz
         ymIcdJ9fGjh2srJg7p1FKzrjpE60YnPTeWplOsSrfh8sgpETLok0t1H6/sxRgiuS1PWB
         esCAhGI64THw2Ipq9x7dXrrWU7oqNM8mOdOpWAZC7aLl+nuUEOJKHWYkjM22A60O3zTb
         rJAaGsqqcamakLXWQZzo6ud74nNGfeq6rfjZOPTUBdRRxB4CEla+q+tfariSLK3wewvY
         6TTlY3IXEpXGT7V9gxZx2V+gjogqnXwRkVDS3YVe4Pu76mZ3v6yLtH2T+M9+50Lx1Kc4
         ULgw==
X-Forwarded-Encrypted: i=1; AJvYcCU1uQ6OSwZHq5mvTPcBdG4ile9nCE0oX9JRJzRKQFalqcM2TA5bX+Kkysbxcels3PaGLWuAh+JeTpM+i5l6Ud+MXAnHxxwJ0mC9B5Tgf+8OyTqKGC63Roav8+AbbXBg80Yw
X-Gm-Message-State: AOJu0YzuFT5WMKMtVzl3W2mfB3sYL8IB8lsz9lYYenpX7WjmU0Uff6qy
	3LxWI9kA7RBF4Fh5q9QEL925fUFmisuhu9UP/3Hmg2HA6a/UcFDzayoFBs2APNih1zgTx72NAlC
	7ufMxBk/C/JSgpUfiiUIexHgz7n7m7WMq
X-Google-Smtp-Source: AGHT+IEj8sc/+KAf7eHTTyr96yYzknt0ODX9E3p8wLXyIvypdzWcRah8uQL6CjQ2KVr6hiltGcXoNBH8MCIKc3/5C5c=
X-Received: by 2002:adf:f14b:0:b0:343:ce15:fd3f with SMTP id
 y11-20020adff14b000000b00343ce15fd3fmr664071wro.29.1712275944522; Thu, 04 Apr
 2024 17:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <Zg6Q8Re0TlkDkrkr@nanopsycho> <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
 <Zg7JDL2WOaIf3dxI@nanopsycho> <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
 <20240404132548.3229f6c8@kernel.org> <660f22c56a0a2_442282088b@john.notmuch> <20240404165000.47ce17e6@kernel.org>
In-Reply-To: <20240404165000.47ce17e6@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 4 Apr 2024 17:11:47 -0700
Message-ID: <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 4:50=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 04 Apr 2024 14:59:33 -0700 John Fastabend wrote:
> > The alternative is much worse someone builds a team of engineers locks
> > them up they build some interesting pieces and we never get to see it
> > because we tried to block someone from opensourcing their driver?
>
> Opensourcing is just one push to github.
> There are guarantees we give to upstream drivers.

Are there? Do we have them documented somewhere?

> > Eventually they need some kernel changes and than we block those too
> > because we didn't allow the driver that was the use case? This seems
> > wrong to me.
>
> The flip side of the argument is, what if we allow some device we don't
> have access to to make changes to the core for its benefit. Owner
> reports that some changes broke the kernel for them. Kernel rules,
> regression, we have to revert. This is not a hypothetical, "less than
> cooperative users" demanding reverts, and "reporting us to Linus"
> is a reality :(
>
> Technical solution? Maybe if it's not a public device regression rules
> don't apply? Seems fairly reasonable.

This is a hypothetical. This driver currently isn't changing anything
outside of itself. At this point the driver would only be build tested
by everyone else. They could just not include it in their Kconfig and
then out-of-sight, out-of-mind.

> > Anyways we have zero ways to enforce such a policy. Have vendors
> > ship a NIC to somebody with the v0 of the patch set? Attach a picture?
>
> GenAI world, pictures mean nothing :) We do have a CI in netdev, which
> is all ready to ingest external results, and a (currently tiny amount?)
> of test for NICs. Prove that you care about the device by running the
> upstream tests and reporting results? Seems fairly reasonable.

That seems like an opportunity to be exploited through. Are the
results going to be verified in any way? Maybe cryptographically
signed? Seems like it would be easy enough to fake the results.

> > Even if vendor X claims they will have a product in N months and
> > than only sells it to qualified customers what to do we do then.
> > Driver author could even believe the hardware will be available
> > when they post the driver, but business may change out of hands
> > of the developer.
> >
> > I'm 100% on letting this through assuming Alex is on top of feedback
> > and the code is good.
>
> I'd strongly prefer if we detach our trust and respect for Alex
> from whatever precedent we make here. I can't stress this enough.
> IDK if I'm exaggerating or it's hard to appreciate the challenges
> of maintainership without living it, but I really don't like being
> accused of playing favorites or big companies buying their way in :(

Again, I would say we look at the blast radius. That is how we should
be measuring any change. At this point the driver is self contained
into /drivers/net/ethernet/meta/fbnic/. It isn't exporting anything
outside that directory, and it can be switched off via Kconfig.

When the time comes to start adding new features we can probably start
by looking at how to add either generic offloads like was done for
GSO, CSO, ect or how it can also be implemented on another vendor's
NIC.

At this point the only risk the driver presents is that it is yet
another driver, done in the same style I did the other Intel drivers,
and so any kernel API changes will end up needing to be applied to it
just like the other drivers.

> > I think any other policy would be very ugly to enforce, prove, and
> > even understand. Obviously code and architecture debates I'm all for.
> > Ensuring we have a trusted, experienced person signed up to review
> > code, address feedback, fix whatever syzbot finds and so on is also a
> > must I think. I'm sure Alex will take care of it.
>
> "Whatever syzbot finds" may be slightly moot for a private device ;)
> but otherwise 100%! These are exactly the kind of points I think we
> should enumerate. I started writing a list of expectations a while back:
>
> Documentation/maintainer/feature-and-driver-maintainers.rst
>
> I think we just need something like this, maybe just a step up, for
> non-public devices..

I honestly think we are getting the cart ahead of the horse. When we
start talking about kernel API changes then we can probably get into
the whole "private" versus "publicly available" argument. A good
example of the kind of thing I am thinking of is GSO partial where I
ended up with Mellanox and Intel sending me 40G and 100G NICs and
cables to implement it on their devices as all I had was essentially
igb and ixgbe based NICs.

Odds are when we start getting to those kind of things maybe we need
to look at having a few systems available for developer use, but until
then I am not sure it makes sense to focus on if the device is
publicly available or not.

