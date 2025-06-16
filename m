Return-Path: <linux-pci+bounces-29867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34972ADB1F5
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 15:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FD418872FD
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 13:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611AB2877C8;
	Mon, 16 Jun 2025 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cYlV4oAy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8097120C029
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080643; cv=none; b=AphOQXKheruPcieuLMp4JVporg/XAGF1vsV44A8kiW9LSTPhn7wP6hF4TEncKKzL8RM2HuSMGLJY6s+lJfQknUuqv3tERtBsMKihelIjWRGCyi0TQ+sdRuG8EGyiaDENx27Fj56wRU9b2FTynEpciaEzVwTxbOpklBkuDtdIkRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080643; c=relaxed/simple;
	bh=Set7ARbDGtVl+rypiAdzKX+Nu1RI6OmX9rgnwmZ6y4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6ooBsBESd/gisRzIae7l/Lm5MSeFLj9x1xR4fgmgvKO/k3hxuhFlrWxnxOeZy1kNR4tocMKUpkZ1phwBfDja8fFJEig9n1e5rYouOLdyIEw+ek28HjcExI+DEuLHdSrcXXEqv+LBXMVJYzU6GjM7E83mG4NSEGd5H8OYw9foMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=cYlV4oAy; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32b3a3a8201so29824151fa.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 06:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750080640; x=1750685440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpFwILv4epGn2GHEmYFKtiL50L1fsQYq7PF3nsB89Ng=;
        b=cYlV4oAyvGjKbkG0YWUekZpabHfvLEROpLCZRFgVyTafp7OnA2lBk9fxS9hrHKqv9D
         Ga3sA+N5rxNJP1w3rbx+Fwh2i9A6U6zin07vwT4odocivw++VaeEy+8W1KZigo+WSsT5
         wj6MdzFKsNIkvNJGCQAI6C+YVDELbkVRVlTr3RXtuFyZK9pqx9wR7+b4aiDCJiYbMg5J
         ewracz6DrS1drCUPQmUzHl0ol5v0Jmv7EUo4fdSGfsZVn6wH6sWoyrqLZDEHV7l3kv8G
         XREcNjpaZb07VueULpzOdKWGCMsSXYe+abbKBsy19piFeKMp2qlyVrH8GbUgkN+qqaex
         ymkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750080640; x=1750685440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpFwILv4epGn2GHEmYFKtiL50L1fsQYq7PF3nsB89Ng=;
        b=AgchPKZnN0HQ+UlNKkhkila9gE1KdzotP66YNmyiidYy1ByFkY5NuJciH8gp7OR3lw
         razZeX+Vg4zSteaM9XP5YrYCjlhzDow/6JaPXHtw1DVvW6CAs0pMzOl/GtkgSoe+vkBJ
         wrT+y6mh93Ocx18ezaiS3dleyMj7/hDPRLD0O7fCzAuPMZjYkLbguAe+GsY29RDk3lzu
         AzI7nNgd5zevK0WmH4AAglv+8iwn400fsbAQk67SWbqlezuqKZAtRFavCE29xscNTDpr
         HktZBFDeoKUflX1xjAYntG7gicWGg4MjeLvKwIw2SyUQB0/xTwjw299jOhyK3GPgmhtr
         bxKA==
X-Forwarded-Encrypted: i=1; AJvYcCW0lhUdglKrCady84o9hT+HmPJTvqpX+1LrCBnajsUJSH6WU5Q0l9JVmu66AFDVzpW5spzu2swBOfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAlOBJI1LA8n8MshUKPXzjTrMK28n/06UVo+Y1C2hW0wPNp5PD
	tWl64Yrc7qRY07tzBBDGyMbsiELydM3UAb71jm1gJfEYOr0oE917up6SyunFYR45wBGZZk94XW0
	SZLk3wRoHCv57J43q5OSvFTzJiZhlxq5k+g+Gr1vteQ==
X-Gm-Gg: ASbGnctXswO9ygWaCSDEeztGJw1+torYQDjOifXtGdf5tNiz8c6bxXUV83IT7wnBfqx
	LZEJzEWFYPjb19mvPCWdTWJpRB+qKhmh+dMTtxHnF/8pNI85EtLoTKt3rkrRqSo6KuVqn/xtl4Q
	9pManrp58X/Lez52INdv8tlKPqPa+xQsy+1T3KYe1i/Jw7zF+V3ZimdLiwAfPWGfkEU/+HigFYA
	mz2XPDqgtOb8Q==
X-Google-Smtp-Source: AGHT+IGDpPwrY/qezNWazK+rw//fC7hH97md4nyqXriaZInw5tKf/dsV1dwP+FB3JvLuRVtC7OZOgXl1b9/GYt16THo=
X-Received: by 2002:a05:651c:1505:b0:31e:261a:f3e2 with SMTP id
 38308e7fff4ca-32b4a2e35f0mr24206531fa.1.1750080639525; Mon, 16 Jun 2025
 06:30:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616053209.13045-1-mani@kernel.org> <202506162013.go7YyNYL-lkp@intel.com>
 <ji3pexgvdkfho6mnby5jumkeaxdbzom574kbiyfy4dcqumtgz2@h4nmwjvox7nl> <aFAZL1GgEH9l-zj9@wunner.de>
In-Reply-To: <aFAZL1GgEH9l-zj9@wunner.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 16 Jun 2025 15:30:27 +0200
X-Gm-Features: AX0GCFsuPlvNCKVZ42nqFo1y-oTylnUFxw211QqxqFtmolpwWlFQJ8VvyOnirMY
Message-ID: <CAMRc=Mf=Z+d3UKdwEXkw1Xm9G=qVwh6=fXsfgS6JiOM6Z7H50w@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/pwrctrl: Move pci_pwrctrl_create_device()
 definition to drivers/pci/pwrctrl/
To: Lukas Wunner <lukas@wunner.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>, kernel test robot <lkp@intel.com>, bhelgaas@google.com, 
	oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Quinlan <james.quinlan@broadcom.com>, 
	Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 3:16=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Mon, Jun 16, 2025 at 06:07:48PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jun 16, 2025 at 08:21:20PM +0800, kernel test robot wrote:
> > >    ld: drivers/pci/probe.o: in function `pci_scan_single_device':
> > > >> probe.c:(.text+0x2400): undefined reference to `pci_pwrctrl_create=
_device'
> >
> > Hmm, so we cannot have a built-in driver depend on a module...
> >
> > Bartosz, should we make CONFIG_PCI_PWRCTRL bool then? We can still allo=
w the
> > individual pwrctrl drivers be tristate.
>
> I guess the alternative is to just leave it in probe.c.  The function is
> optimized away in the CONFIG_OF=3Dn case because of_pci_find_child_device=
()
> returns NULL.  It's unpleasant that it lives outside of pwrctrl/core.c,
> but it doesn't occupy any space in the compiled kernel at least on non-OF
> (e.g. ACPI) platforms.
>

And there's a third option of having this function live in a separate
.c file under drivers/pci/pwrctl/ that would be always built-in even
if PWRCTL itself is a module. The best/worst of two worlds? :)

Bart

