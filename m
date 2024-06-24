Return-Path: <linux-pci+bounces-9197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D62915266
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 17:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B01C1C223C1
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 15:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F414B19B5B4;
	Mon, 24 Jun 2024 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Np5jKcQT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2844F19B3CE;
	Mon, 24 Jun 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243069; cv=none; b=t43wwyp1zreNeErg9nNBiDOY5O9GE3tQL1cdzjIdrHcYVfP9LeUANCELoHUwkeDO015CszSjS3LKq8Ia9AFk1k+1UwSt0es1kFzqH903pq4IzIBAGW8LpXnLO9ltCQi5ffEw86IOQCDAahnGPXnMzTMagFf6Kto/0pwUjecDpv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243069; c=relaxed/simple;
	bh=Gj1ET0gnfPT9VVrwaIAa4qFWM+9FJ5WfJJ8Gaj9uoFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rG7jQXWnrqFPCSmaB3rPhKsk8S/ihYoCyP2VP2vHea52oVquvJtS56UObe6dW7EgAKG2R6XYcOocsqp/vMtdTCcQ/TI8jDOha3F1CLZ+wfYDuLgo/r3n/7Pa8PDUT4Zh5HBAcJHndMWwtIK+pvti5NNPUpgzqxo2yiCPzM4KDCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Np5jKcQT; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ec1620a956so53917731fa.1;
        Mon, 24 Jun 2024 08:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719243066; x=1719847866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj1ET0gnfPT9VVrwaIAa4qFWM+9FJ5WfJJ8Gaj9uoFQ=;
        b=Np5jKcQT3VicLmEeHbQATDn8nHhS56TAafc7WIztXw9MUD50bLFAIPlHKGwgncYl9M
         OLudoD2yFOv255gfGjZUr6VSeR9EuPFONBBDJ6/gIfFGNheCYOn/RKGb3HJ4n4ryA7HV
         pa8yzbokjvh23G7IouuQueF59W5CEBRJgcxqYDPnq/t+RNImeCHVAikOpNQuxP904cC0
         LY1JYgeKOWjBV/8loNsQWoo1n+d1LFiM6kJsplnxkm6C6xvcMLVJpBu0SbNTtumXonBf
         IYJkHZYeT65llHmlRU68xzwgtrQ4RzJR4fePabJQVzvndesL84GpU+nSoaK4RBUfOUID
         SGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719243066; x=1719847866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gj1ET0gnfPT9VVrwaIAa4qFWM+9FJ5WfJJ8Gaj9uoFQ=;
        b=hbogdj5gNsxc5n3wUTcpZa8ot7P/33ezWI1WwU5eIeFY/Lr4CXTg5Ck8U8HfiDe5hS
         Hsv/6vArqfSldsSUP6/4Cs9+h9Ej2qYGjSKBYiAiELFpaTMdfO+HIhLmiiQD1zlPujl5
         LwXNVZ0DnvOq6mtmEm9qZ1LGMBdyUoU/EWM88quweG8uPXTFYQXBCtGro2+ytzhepYnP
         FbmYy9imd3GjDpNqEgJiounU0TE479j9gFcS/Gc9TdiZ875qCotOpRLLF4jcT5ZcEAI6
         Sm7d39ZYn9eV+h/G38r3dobBi9hrfCVPjRqujVf4EfdneXSPy3qVPqGQMisQwZ+rDklW
         UULA==
X-Forwarded-Encrypted: i=1; AJvYcCV1mWyLVmIzOFZeBKSaL48HuBmIjS1fJbQ16e56dFQ9A6B2l24xq9YVp3iDOlm+sD3dwxxq/UubjdhK9RrbcgxSe8A1xdMJ8BTQ46PCrwLi3oo2wZIOAkkNXNWRwx2b7+jx5yJ2u45l8BHi1Oqalx5/VyWbuFC9PwlJh3OTqD9QIfzYZrWPXQpHT8z/43MtpcIK9iSG8R/y69+hbJZCe9HanMFBlnuOhVN3uxjmkrO+EyTGBxUu+zzaH7PkGLuPG6aACF10cStb5/ECOg0WB/qqBlfiPaC+Lz7t1FUQ/KQQXNfOnvx1dhrfCHxH8Hcn4/yGRsqoJUuB79Uct0Fva+Fn11rEKfYTHtYV7EnXO48Kgfm07KYX
X-Gm-Message-State: AOJu0YziUeJ4sGwa0ZUUiyZIjMoiBxULtra7D9VGImc5Q9+1S3YS1VNJ
	j+/HTusVLx8CWfAyOolPXVmbeZdd1ZuvNYm8pFRf3i/eys/M/V4a5r/XzysX9PlW3jhpWEjZUX3
	LfiBIkml/PDqSVv7YgPgI3GA79TQ=
X-Google-Smtp-Source: AGHT+IGOXIoT1yyvzTU3Ej6Jnd5fItzJypxgtcq3Cn2K/G/HW2nUFkGYBhoo/Zo5wXa3klvOARHm0We8kMgwI5CBPKQ=
X-Received: by 2002:a2e:720b:0:b0:2ec:4096:4bc6 with SMTP id
 38308e7fff4ca-2ec5b318000mr28549631fa.7.1719243066027; Mon, 24 Jun 2024
 08:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605123850.24857-1-brgl@bgdev.pl> <171889385036.4585.6482250630135606154.git-patchwork-notify@kernel.org>
 <0b144517-4cc5-4c23-be57-d6f5323690ec@163.com> <CAMRc=Mf2C4ywa+wQ6pcq5RtehQD00dDhzvS6sDcD8tAn=UypUA@mail.gmail.com>
 <33c7587b-83a4-4be7-b00a-d30874df8c22@163.com>
In-Reply-To: <33c7587b-83a4-4be7-b00a-d30874df8c22@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 24 Jun 2024 11:30:53 -0400
Message-ID: <CABBYNZ+X+_RfZ-fVGrBHhAdbneU+613nx1NTw7+e8ep4JtF6nQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] pwrseq: introduce the subsystem and first driver
To: Lk Sii <lk_sii@163.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, patchwork-bot+bluetooth@kernel.org, marcel@holtmann.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	kvalo@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	lgirdwood@gmail.com, broonie@kernel.org, catalin.marinas@arm.com, 
	will@kernel.org, bhelgaas@google.com, saravanak@google.com, 
	geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org, 
	m.szyprowski@samsung.com, elder@linaro.org, srinivas.kandagatla@linaro.org, 
	gregkh@linuxfoundation.org, abel.vesa@linaro.org, mani@kernel.org, 
	lukas@wunner.de, dmitry.baryshkov@linaro.org, amit.pundir@linaro.org, 
	wuxilin123@gmail.com, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, bartosz.golaszewski@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 21, 2024 at 5:05=E2=80=AFAM Lk Sii <lk_sii@163.com> wrote:
>
> On 2024/6/21 14:36, Bartosz Golaszewski wrote:
> > On Fri, Jun 21, 2024 at 3:14=E2=80=AFAM Lk Sii <lk_sii@163.com> wrote:
> >>
> >>
> >>
> >> On 2024/6/20 22:30, patchwork-bot+bluetooth@kernel.org wrote:
> >>> Hello:
> >>>
> >>> This series was applied to bluetooth/bluetooth-next.git (master)
> >>> by Bartosz Golaszewski <bartosz.golaszewski@linaro.org>:
> >>>
> >> Hi luiz,
> >>
> >> i am curious why Bartosz is able to merge his changes into bluetooth
> >> development tree bluetooth-next directly.
> >>
> >
> > This conversation is getting progressively worse...
> >
> >> 1)
> >> his changes should belong to *POWER* scope instead of *Bluetooth*
> >> obviously, however, there are *NOT* any SOB tag from either power and
> >> bluetooth maintainer. these changes currently only have below Acked-by
> >> and Signed-off-by tags:
> >>
> >> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> >> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>
> >
> > It's a new subsystem that has been discussed and reviewed for months
> > and thoroughly tested. Please refer to the cover letter under v8
> > linked in this thread. It's not related to power-management or
> > power-supply, it's its own thing but IMO the best place to put it is
> > under drivers/power/. And I will maintain it.
> >
> >> 2)
> >> his changes have not merged into linus mainline tree yet.
> >>
> >
> > This is why they are in next! They are scheduled to go in during the
> > upcoming merge window. But since changes belong in multiple trees, we
> > need a cross-tree merge.
> >
> >> 3)
> >> perhaps, it is safer to pull his changes from linus mainline tree when
> >> merged than to merge into bluetooth-next firstly.
> >>
> >
> > It's not safer at all, why would spending less time in next be safer?
> >
> it seems this patch serial(new subsystem) does not depend on bluetooth
> and also does not belong to bluetooth subsystem, but have been contained
> by tip of bluetooth tree.
>
> why not follow below merging produce?
> 1) you send this patch serials to Linus to merge within linus mainline tr=
ee
> 2) luiz then pull your changes from linus mainline tree.

This was discussed already, but in case you didn't follow if we need
to incorporate changes earlier we can't really wait the merge window
for the changes to be merged first into the Linus tree. Anyway Bartosz
is the maintainer of Power Sequence subsystem, and several others
drivers, so I think it is safe to trust his judgment here.

