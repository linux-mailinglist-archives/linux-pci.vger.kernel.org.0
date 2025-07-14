Return-Path: <linux-pci+bounces-32038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC42B036A6
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 08:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B59174B37
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 06:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3891621882B;
	Mon, 14 Jul 2025 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKugY+EC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4B6212B0A;
	Mon, 14 Jul 2025 06:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752473552; cv=none; b=jvPGSBOYcQOCRuA7rMhwHDTa2c1mfKxrxrm1GtQawSDVzoFTVrtZAIM5X7bshYFilf9S78kzYGExzYyg4j/zTwF+ncANHs2n2Ti4W3j+Rb2WjVoJIokJmYXyozGHA1wIejF1+aH7kvOZVXKz+CYMgS6oAP3gnH5J8+Db58m8wzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752473552; c=relaxed/simple;
	bh=GCvuFIHfHnTY+lLbeieHAjb6PL9SdLYd5HNTQR33Wzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VeoghloAyfWQE41SClqTJFHeB73yQpVIhmuxph+brYa8xWldjZPEsrhcMvrXCoRBTFz2UH/KdgiZqNHNAUdV3yFyrXukzgbGNJzBtO2BvvIjTYCpM/JRzp6Htz/LmzfpsDDc63H5WgkLv4EkUFO22KQkoUXqgRbbvmqUkfY3i1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKugY+EC; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32f144d0db8so26256521fa.0;
        Sun, 13 Jul 2025 23:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752473548; x=1753078348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HclH83NzlDxFp3WCu9k+tiTs4nj/yAfFDR01jNUC5M=;
        b=nKugY+ECmULHuFBnZTezniRPGThSqsFexy1m1l8HZGSM/7PRbTvABsU3HYv6Lk52Uk
         Ysk5W7KI6hQnrpVCxUdyo4r0kS+pdTMhIJXlNeio9dtA5WRSoOd1pZkxDQNLdAZor8eo
         qwyKYmomhbD9QkAz01Gr92QTQdCRcHyeEVsDZsmpecqHrYJT5eiztrm/B6A5plJbIVXg
         31duqjZWcHJhjozHL7oGLl6kr26cguPPSzp7EI4OvsCtP6jtDl37HABgdkDdkN4fOu2r
         dP5umGnjP+LdgA7jf64BD9BgxBohFUMZ8IGeN8Vv1ORx8LEZN057dalkv9adGMPKjozy
         mzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752473548; x=1753078348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HclH83NzlDxFp3WCu9k+tiTs4nj/yAfFDR01jNUC5M=;
        b=WlTlYjJPhDeUwbmwLTecV/n36CAS0okYxau+f6UqQLV8lrxNp24OwC5KAezRkbCyWr
         cq1EedDqCauYcuRHctwuXvDUrA0ycfuDa0TjLUK3oNkQmXuMgLRip9KCn/ppelbSCLpP
         p3HvkFR40aZDZwhrsE6PdmlcNdrblnqFZ5z45a1cjQM+yjGwDILD7flWD4n5h3fycxVh
         Spu5m4fl2YbNCVTf7vh4wrcfVdSq5qHDaTHmwD1jzKmsoWZHAHxZSl1C6QXBZPRb8Fli
         FqORFjlT2Fb/VK6vnhI66uvr7vmYI/V9Me/EmcCYBvyzj7KhCMMMme1awnQKhZo1ZssT
         ZVyw==
X-Forwarded-Encrypted: i=1; AJvYcCUBNbaPkEEE3Wo4jJjPgTp8P4TlC1IQAKkg20rJnuXU6N2IOgPMIuGY+raG/WHsqzSsio9H8bk0jY+hiX8=@vger.kernel.org, AJvYcCUqtvWcrRfpsGN17b41ean25RH+JiFZ7RHpnn7J9mkTeholc4Eob8t9jRIwL0UC9sWLrYWjkYp9V6ye@vger.kernel.org, AJvYcCWiF1suW3LLxNbgXGXwcx88/mpx0I9qHpstatMUqoSW3yE/Pj6bceS4vamSq2MgZ6vuF8t7mbgVYaM=@vger.kernel.org, AJvYcCXEJJZYBxxGGKBCutmfC0P1PCXSWmzq8ry7235T6xbw+kl4tuSSc5+4+9VwLlMVZ8+hMCXEDQXEDyPoQNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0LFUl1J6XucQHa/SLe1l2i17z9JsrbptXMNzvyySq9EzVt98n
	3eXnJeqbGBb2Bdv1mt6dI29eWUC7UAobBdsUmFwYLQDRbb6O4KZbu990lZmqOOE08NYbdB4fBCT
	Re03XHpf9UR24uhh6rWvPgv7YZrORJwM=
X-Gm-Gg: ASbGncuLW79G96YJMT3PiUyvQG5l/yAcM6ONfD9ni44/6iTn1Pxk7VF7APRyvB7Qk8W
	jirMox6hIasBA1NQqxeUCZsAqQk2Hagr6ovWO9cDOcEpw6PrYOyXovcvGWC4l7auwaB2K4QAxum
	1BwPMxwum/UdCBUkoYzJy/j7d2snsUP9Q88uUIPVteIdYJ8gtlEdul7ADswbmfT4tbW8g2sz/ue
	iF4Fc0=
X-Google-Smtp-Source: AGHT+IEEmZLhzLOHhcNX69E4EEM1Zr6whZ6ca7n1lHdYKFmEhiFtuzgKib+HMpneZvKeFl2cpxv/6S8jqM6l32aEim0=
X-Received: by 2002:a2e:a902:0:b0:32b:a9a4:cd58 with SMTP id
 38308e7fff4ca-33052279345mr39539821fa.15.1752473548356; Sun, 13 Jul 2025
 23:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507-pci-tegra-module-v6-0-5fe363eaa302@gmail.com>
 <nz76wk5yqytag255jijxlyuodzpo3fm6d5coxutqrd7tgomzxm@pwzvpv4frjxu> <CALHNRZ9WYJef8+QyCfpkxLhUj_KRY=kZisEwq=arrTxXXfCknA@mail.gmail.com>
In-Reply-To: <CALHNRZ9WYJef8+QyCfpkxLhUj_KRY=kZisEwq=arrTxXXfCknA@mail.gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 14 Jul 2025 01:12:16 -0500
X-Gm-Features: Ac12FXxzicaLORWlI4imvwogYPOLZV3Z9geQKHYOjwVJ4Ej31UmrR1MncJN4u1E
Message-ID: <CALHNRZ84Xj=_HqrFWnYHdV-A9YM4yu2FhfYgHy4-sR65tsYbUA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] PCI: tegra: Allow building as a module
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 1:31=E2=80=AFPM Aaron Kling <webgeek1234@gmail.com>=
 wrote:
>
> On Fri, Jun 13, 2025 at 1:17=E2=80=AFAM Manivannan Sadhasivam <mani@kerne=
l.org> wrote:
> >
> > On Wed, May 07, 2025 at 10:25:51PM -0500, Aaron Kling via B4 Relay wrot=
e:
> >
> > You should always add the context of the series in the cover letter.
> >
> > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > ---
> > > Changes in v6:
> > > - Remove unused debugfs cleanup function, as caught by kernel ci
> > > - Link to v5: https://lore.kernel.org/r/20250505-pci-tegra-module-v5-=
0-827aaac998ba@gmail.com
> > >
> > > Changes in v5:
> > > - Copy commit message exactly word for word on patch 1, as required b=
y reviewer
> > > - Delete remove callback in patch 3, per request
> > > - Don't clean up debugfs, per request, which drops patch 4 entirely
> > > - Link to v4: https://lore.kernel.org/r/20250505-pci-tegra-module-v4-=
0-088b552c4b1a@gmail.com
> > >
> > > Changes in v4:
> > > - Updated commit messages for patches 1 and 2, per review
> > > - Link to v3: https://lore.kernel.org/r/20250502-pci-tegra-module-v3-=
0-556a49732d70@gmail.com
> > >
> > > Changes in v3:
> > > - Add patch to drop remove callback, per request
> > > - Link to v2: https://lore.kernel.org/r/20250428-pci-tegra-module-v2-=
0-c11a4b912446@gmail.com
> > >
> > > Changes in v2:
> > > - Add patch to export tegra_cpuidle_pcie_irqs_in_use as required when
> > >   building pci-tegra as a module for arm
> > > - Drop module exit to prevent module unloading, as requested
> > > - Link to v1: https://lore.kernel.org/r/20250420-pci-tegra-module-v1-=
0-c0a1f831354a@gmail.com
> > >
> > > ---
> > > Aaron Kling (3):
> > >       irqdomain: Export irq_domain_free_irqs
> > >       cpuidle: tegra: Export tegra_cpuidle_pcie_irqs_in_use
> >
> > I need an ACK from the cpuidle maintainers to take these 3 patches thro=
ugh PCI
> > tree.
>
> Reminder about this series. I'm normally interacting with the tegra
> maintainers, but I don't particularly care which tree it goes through
> as long as something that works gets merged. So, can one of the
> cpuidle maintainers take a quick look through this, please?
>
> Aaron

There's been no responses here for a month. If no cpuidle maintainers
wish to respond, then what?

It makes more sense to me to take this through the tegra tree. But
Thierry had concerns about removing functionality that was confirmed
working. Manivannan, if this was to go through the tegra tree, would
you still block this conversion if it didn't drop the unplug/unload
functionality? There's many existing drivers, including one for newer
tegra archs, that are unloadable modules that would be affected by the
IRQ concern. I don't want to cause friction here, but I do want to get
this merged before the next LTS, so I can use it for my projects.

Aaron

