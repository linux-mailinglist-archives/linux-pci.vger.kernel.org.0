Return-Path: <linux-pci+bounces-10388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBB79330A9
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 20:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC74BB22487
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 18:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193121C6B7;
	Tue, 16 Jul 2024 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YZeiCBxt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784081B94F
	for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721155755; cv=none; b=Kv7HOJFdHynm+Bv3/pcKOF01xRXVQeFwYtzZ5vMZN5XV4MW/XNLjtqH0ggLAp9Q/eWDjBVBLjNiwYMD/xlSC5oexMv3oYQoGS4Ubur+IS1lZjkM9GCyKw/B7cj93S9wtRQQ3K/gM2VH2NCFxyE5q3aLJghfOPvGAx/t1VFYsZzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721155755; c=relaxed/simple;
	bh=cF3LVwQ6uUCjs8vvD7smezICijmUnzP/qRxxOPn0ueo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nouRz4LSndBCq69v2QnQMbDKfix1Kp2KvGUjEJ1tHEN3tUXFBAht5+5Oq6wYQ8b1F8mtC7Rxs04cszX0rYr/9hlR9iyTWq3L2aoQckBN45t+nC12lvPuZdwyNq26PmxIy97iKPmhGJpYEhh+2bmxqDz+7/dNmO+yj7XO1F3CxKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YZeiCBxt; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ee9b1b422fso542421fa.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 11:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721155752; x=1721760552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KhgLmJzF0SWWsLaDdoCGwx7sJaZZjiB4NDQ1hg4zPI=;
        b=YZeiCBxtSR3k8QS8qBZEhIPv/LF7JY9wZPhZV+Ll5T+w+uWwySlJ8V6MeLiTM5vOhB
         2BM2GSUL04dpiLGk9slYqbyG8rGfE+tP18j2SlIr8r+20uip4L2UNxZSFD6twSwuhHpq
         ZpuYLtRAycQbKDQw4LVbudB9tIpd3QFifUZOEUq5cqloVpgexU7XkpTM5vpMugtUosi2
         seXiOJO7RX/cbXTcuhxuUW1HP9vWaleBXjuQZsKUpL2swATJ2wOgEiVCmA/Iu+bOG6zY
         u/oT8czDVIkj8blkjT+DiPDBmujabEzDj89M1h1f9H92pbXCFs0uiRClhWDJXJXfNezK
         DhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721155752; x=1721760552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KhgLmJzF0SWWsLaDdoCGwx7sJaZZjiB4NDQ1hg4zPI=;
        b=dUvSsyxKruC5sXeMwozRT44rO4iW+lw6AspUGZA2epABjrAWxNa8iZTmjOhwuowBsn
         koV3anM8F7pRMmJkPvMTd3ixcV+/2FZRXpz0tEgDqIeSFwqm5tgh1+ngXxNj0uzpSRFW
         arIqIernfGhJQCK1bjqpqL4/tOn1NrbZprKlDjGozC6c2aGPPfIdhr142Zr/G3PR+ohm
         RzKNVzkAvJebC4bhQJlD0lmwWygVXG+0EXyhM+ojCELshYHVoQ5j2XQz+hk3bAtmyIDE
         BgG1GcOLOq0POzgLI4y8VyUi7EXEM2fsAU2yl5vSeRNSlpcZ2Pg66tCnaIKVr1dZLiR/
         DChw==
X-Forwarded-Encrypted: i=1; AJvYcCUTa1fKXYcbFVo3o/ai9Dwtb7e+Af7tu2CvFdqMy3yeGa7nFewCkus9qPOcRMaQAjTSWng5BNfjrVXw7uM8tyEpNVJvzvHSV8Vn
X-Gm-Message-State: AOJu0Yyk08WD8w4tbfVuJZc3I9nNibFyKlp9vBG2jSwDvI3at5mu/wgC
	/SflXPAv9Rhmn5ftL1bikg6JoUE/OwLM6QdfnhgOdP4ddIrL+sVPkBKlOM4ObfAYLVR6Bz2qiWQ
	A4cEoT+IcDXUXvm89FUt2O0hNQWq3Rs2RGINnSg==
X-Google-Smtp-Source: AGHT+IEZMw76FXm6ot0bsZAM4mhixLO229IEyn6XfMcbFPHJP6T9l/LLjNPp2I7LLmbp65K6cGxGFYcaG+fuqjewhOY=
X-Received: by 2002:a2e:a609:0:b0:2ec:5324:805c with SMTP id
 38308e7fff4ca-2eef56c6298mr8166411fa.11.1721155751656; Tue, 16 Jul 2024
 11:49:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716080418.34426-1-manivannan.sadhasivam@linaro.org> <CAHk-=wjxiAvNJejbpMbn_CMYzU97uHFPiRmYQ5Gaxw56UyK8sA@mail.gmail.com>
In-Reply-To: <CAHk-=wjxiAvNJejbpMbn_CMYzU97uHFPiRmYQ5Gaxw56UyK8sA@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 16 Jul 2024 20:49:00 +0200
Message-ID: <CAMRc=MdvZQSwC93MuAse2cGuKpNCHO+0jGOjMRNyXYwvCrY_dw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Check for the existence of 'dev.of_node' before
 calling of_platform_populate()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 8:02=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 16 Jul 2024 at 01:04, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > -       if (IS_ENABLED(CONFIG_OF) && pci_is_bridge(dev)) {
> > +       if (IS_ENABLED(CONFIG_OF) && dev_of_node(&dev->dev) && pci_is_b=
ridge(dev)) {
> >                 retval =3D of_platform_populate(dev->dev.of_node, NULL,=
 NULL,

While at it: you could replace the dev.of_node here with dev_of_node()
too. I seem to have missed this helper.

Bartosz

> >                                               &dev->dev);
>
> I think you should just drop the IS_ENABLED(CONFIG_OF) check entirely.
>
> afaik, dev_of_node() already returns NULL if CONFIG_OF isn't set.
>
> So the bug was literally that you based the decision on something
> pointless that shouldn't be there at all.
>
>                 Linus

