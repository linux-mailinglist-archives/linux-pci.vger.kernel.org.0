Return-Path: <linux-pci+bounces-12448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5746964840
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 16:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B301C2301D
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 14:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46121B0111;
	Thu, 29 Aug 2024 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ9UeZ0y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7C61AED4A;
	Thu, 29 Aug 2024 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941640; cv=none; b=eGx1jFiVA1MzbCF8bh2FCYD4iOfiX9njfwruvwtbFOvYy/zrcZLQs+YAZqdDdEgAw8o70rLsNH6Qcj/rQfKH+NXevwowZB5448sD45E8rvAohiX5VUDi/Yl3hdPI9DvBrIgD472TMbQtjg61RSEAOLC3ZVUBN1SZC7LZegIm02A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941640; c=relaxed/simple;
	bh=8RoE+cdozJ3A+shrfrungz4qyxcoLBGnk/z+3xmrit0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FS9GwS/QF3bOKo06kcQhaC936PL3bIsHSD8LJE1jP9/luUj2FRdnjOlpP5CnOPw0s0B+fr4uW4EpsSMwKslPmGsO37vWzNNCEYNy5RApwNPt5XYBXGcUl1uhnAwsw/VQVpVz2vZa8NPutOuHmEBA0EV7Kp4GKpaT6wqpjzdzXKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJ9UeZ0y; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c09fd20eddso819073a12.3;
        Thu, 29 Aug 2024 07:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724941637; x=1725546437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZpI4afRL2FMKQeKNliFKLWSQBi1pIyubvpJPETxetg=;
        b=kJ9UeZ0yirMCmPlj1FXkXZmD37bxwQC//lI2cZG3qnrGsxQdmCs9POtakmhXGMgBFB
         XtWCxT/VYU0r6Pfw2KcNQBkl0QYMA3CFGt1omOdWPztm/0j3JCgOTPq+h7CNo55E/T0r
         uF/bKev2eHDVY+dUnxfL/XhINttE6KVHVBj/9vMNErNw5RlJLexK05ctfFJMin5KMInO
         51+45TOo3nkH9UdYLrasMbHH6hBamg/Skx0ytGVF5ocr9kBd+SpKitcs24/cBa13DLV0
         SslQJCeE4r8JgvJp2mk9TdbKqA5Tv0aB+305mBjMegN7LJvEjoe3CJdvbOLkgnM4Cb0c
         iKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941637; x=1725546437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZpI4afRL2FMKQeKNliFKLWSQBi1pIyubvpJPETxetg=;
        b=iTZjb+9+d643SfbKaWbsPlSLpj5561ahl1gXqRI2aDxbFzXWrIr9XlKHho/LBnZ/Qn
         ZvWrdADbcQy+QGBpfhR/LpLvpNAGWr8PAlIY+28ZDYXzNuwy/RhsQmdenbyQUxe1Pmw5
         iHybQZaDemg/nueVx3gU3tH0zFZ9qB41aN2jNN1mG2BB+u03+oqJrVWHeZJPs3F3ji1q
         qhIOjqCs9NuWLdiA6QB1okDSc7+VQdAtpN2PSyYLuhpxg8u7BFNg/7nsLGfeTJZdwI+P
         SrF0LBwfRHTJZIB/gQeQAxoeNdSP4Yx+YsZWsPOPkJB3GbgByXOhe899/5JC9vocPyAs
         5p0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBEhz2xyOWl+7eQ37rCdIWyv1EhYcOdg/rII1domp/TvxiTWml4sElcPkcM0MDcipNmWdHZMLrIcwX@vger.kernel.org, AJvYcCWmBmVA17s/3QPRgzNg5hdOadz5mmKKR+b+wqgHmbfmwkqdhHMMpcMX8gWgW6RGakUoxT1YExecYZ/cNA==@vger.kernel.org, AJvYcCWn8dHGCniBLMIX3vEiVg3h6nsZJvAa3GQgAMmL3GJ014XRapmBJ0A3OQZuzaBfY7j+4umyvgTUQyayVg==@vger.kernel.org, AJvYcCWsLa1NxBojUIUgx0KZWF6JxfdFjn+SuZ/92OtF+JX4avor63p4KcWGEpkaaaw3EoKg7VUiZLmJ@vger.kernel.org, AJvYcCWy3HEBhsY8AszGyu8f1fmMjpB4YP9vjsQYoPdIBuwie2YVaanURov6JZH6Gdp8yg+aC6mN7QbPGhv4Sg==@vger.kernel.org, AJvYcCX8b4+FaKyS/ALiVXdKJvKLxqGDMWjxph81DSCAP8ea3LtiImZgsFbgiZBd6lIltO82KyJFIxQM@vger.kernel.org, AJvYcCXUlBgUgXQUPolb8sMfS/RyLXR6IxG4bNWB9oItDe5ozkXuW9kQY7wxC0aekWYTTp+DD0eW+D6d9D/BRaCJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyA0kwojVf8axXA2r5mDWu7iBvVYHeag64gVzzHwoCoYxrGv9Hu
	vE+knVZH6Gpk6HFzBC5UACPL0apn6FEU18hiUaaaFyWAUaOehwSBDa0pqtVUGWZS0039BVgKTcK
	4DaJPASoQnsxqEPT9VRqTHPh1lCA=
X-Google-Smtp-Source: AGHT+IFclKvq9CgocI4k5e6wl7aLHjazA02xjCsgy2N/rN/swL8vf/cOS87Uaf0R50FfdZ9+2VNUItD5IA3I6PEkM58=
X-Received: by 2002:a05:6402:348f:b0:5be:ed8c:de7 with SMTP id
 4fb4d7f45d1cf-5c21ed3e14bmr2812108a12.11.1724941636724; Thu, 29 Aug 2024
 07:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829141844.39064-1-pstanner@redhat.com> <20240829141844.39064-7-pstanner@redhat.com>
 <20240829102320-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240829102320-mutt-send-email-mst@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 29 Aug 2024 17:26:39 +0300
Message-ID: <CAHp75Ve7O6eAiNx0+v_SNR2vuYgnkeWrPD1Umb1afS3pf7m8MQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] vdpa: solidrun: Fix UB bug with devres
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Philipp Stanner <pstanner@redhat.com>, Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, 
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Alvaro Karsz <alvaro.karsz@solid-run.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Hannes Reinecke <hare@suse.de>, John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev, stable@vger.kernel.org, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 5:23=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Aug 29, 2024 at 04:16:25PM +0200, Philipp Stanner wrote:
> > In psnet_open_pf_bar() and snet_open_vf_bar() a string later passed to
> > pcim_iomap_regions() is placed on the stack. Neither
> > pcim_iomap_regions() nor the functions it calls copy that string.
> >
> > Should the string later ever be used, this, consequently, causes
> > undefined behavior since the stack frame will by then have disappeared.
> >
> > Fix the bug by allocating the strings on the heap through
> > devm_kasprintf().
> >
> > Cc: stable@vger.kernel.org    # v6.3
> > Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
> > Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > Closes: https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f89=
1@wanadoo.fr/
> > Suggested-by: Andy Shevchenko <andy@kernel.org>
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>
> Post this separately, so I can apply?

Don't you use `b4`? With it it as simple as

  b4 am -P 6 $MSG_ID_OF_THIS_SERIES

--=20
With Best Regards,
Andy Shevchenko

