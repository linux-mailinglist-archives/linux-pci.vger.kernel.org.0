Return-Path: <linux-pci+bounces-36525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F142CB8A9F5
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 18:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B203A9956
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CBC31E0EB;
	Fri, 19 Sep 2025 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYf66mB+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1402831DDA4
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300265; cv=none; b=NUiBYKnP07nkuRyQGdm0JoLPS4J4a4nrwr6Rhw02Tro7luArqxoaiPGmowO1lT7U062RteAK8KRgpe63KH729nmMGFRfPlCvv1xJm3R8JvmyWDBafcGknr3Wl/CrDSnzEyWVB4lwZwo3vv5H1q/nrqiZO8eljdVk23jQgznUBGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300265; c=relaxed/simple;
	bh=Z+xzM+obmKSMpzn/dABZKz6aipanBmUTv2DoGD7N9mE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIzF8K7cf7tc+JxyqdSM6p30rc7gmqtqzjMuEPkT8kAtzj32YzZO8tH049PK8TNm9wnUFNQTUbL+cInhmwaYytlGf70lDpOxjHeihMiqIEDftxcWD8ty8OPB8+u5SJskNplzb7EkeqCzh8V6gH7d3GNF3pil60vLd4OSKqcvqng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYf66mB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEA5C4CEF9
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 16:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758300264;
	bh=Z+xzM+obmKSMpzn/dABZKz6aipanBmUTv2DoGD7N9mE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CYf66mB+BQiImf0tFPv+N9XufbB7fxxmib+kYYNEKULll3pZSLDjuDV9iOZ5/1id0
	 p2upv/ZX15dfodM4jhO6Vx5BSoApBg7sFYFbLs76Us+h68BzXkOYDaS70QNqfNaWvx
	 4BFQ786Mjsi+eoTAmNkOiF2zyxl60fMi+8gG9CtTihvHVgGn6rsKTaRW2eluVTKn8l
	 EVRLjG7cq9MB7W1Jf6+aLXHWIL5q7nB/NHXrQhCwq/m/DeMRHOgv8XiAmUrOH6Idkv
	 kGlpW2Lb5PHc7kA6VIdtUeopIVvtaHjHR5Uh9OJV34QsZH8SfF9nSky7y0dG/XKNQW
	 Mp9EIrTXkl4tg==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-75871cd9228so1990798a34.3
        for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 09:44:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9Zs7lbRt0hMwYzD/MbzSGw5I0NtzAXwbgK3p1uHS/MTtI4E0DZxkuUHzT3CuzeNEIPuXHbbL8vWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6tWK75pP6z1jJeJVKDBqN3qtSSKQKF2P/P6K9CXHw9pGPQSjo
	IOuEmVKf7BHDgtOszCYufS+dLWlTSQSKAugYryBWI1i7XijMxrzcxlkX5VN1N6r8EYJHaoMvq8Z
	lYxQr50kvKTGrswrWcQrIYyi3uufh7l8=
X-Google-Smtp-Source: AGHT+IF2QOIST06pA3nD4R/KEqiURx9SrJz60DzJRxUEb8e860tk5yEsf/9HjR+hu9LfY0LdFkJuTuZeobAThGHVA9Y=
X-Received: by 2002:a05:6808:238a:b0:439:b82f:ce with SMTP id
 5614622812f47-43d6c225ea7mr1757830b6e.31.1758300264006; Fri, 19 Sep 2025
 09:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919163147.4743-1-tiwai@suse.de>
In-Reply-To: <20250919163147.4743-1-tiwai@suse.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Sep 2025 18:44:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hjGi6vpgOYtjjX_Tmb47YPk4NSc97GuD-WnSQUsoBe5Q@mail.gmail.com>
X-Gm-Features: AS18NWD1rPmTQ-x-b1JHO9mEPl89PC8Zw6E5R985LVmsoOpd4z9dQ89-uz6WNoc
Message-ID: <CAJZ5v0hjGi6vpgOYtjjX_Tmb47YPk4NSc97GuD-WnSQUsoBe5Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] PM: runtime: New class macros for auto-cleanup
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 19, 2025 at 6:32=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
>
> Hi,
>
> this is a patch series to introduce the new class macros for easier
> usage of PM runtime auto-cleanup features.
>
> There is only one existing user of __free(pm_runtime_put) in PCI core,
> and this is converted with CLASS() macro, too.
> Then the pm_runtime_put __free definition is dropped.
>
> The first patch was from Rafael (as found in the thread below), and I
> left no sign-off as I expect he'll get and sign later again.
>
>
> Link: https://lore.kernel.org/878qimv24u.wl-tiwai@suse.de

I've just done the same thing:

https://lore.kernel.org/linux-pm/5049058.31r3eYUQgx@rafael.j.wysocki/

which I said I would do:

https://lore.kernel.org/linux-pm/CAJZ5v0jJjYoTceD2_pgvKgKuPypo+8osnAuCefgAj=
rzY_w2n8A@mail.gmail.com/

:-)

Sorry for the confusion.

Any issues with using my version?

