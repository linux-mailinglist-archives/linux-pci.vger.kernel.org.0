Return-Path: <linux-pci+bounces-17615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3572E9E3010
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 00:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5F4283FD6
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 23:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8852C1E4110;
	Tue,  3 Dec 2024 23:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdM8Mhbm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563831E0E16;
	Tue,  3 Dec 2024 23:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733269776; cv=none; b=lo3yD3zfrg3lR0s4Gg6O+YMX3fqA/XggUMkBpmT6g6XnDUTiAB7WRPgZYVC5cB5D0RBCbTRb/GsZoCCZ+3p56hloE0iDJv+J0LdTEqRHULepBG4/cMIPTJft7j4dAiORNSza/yEwZV0ZCZMVu8iH2lLbeKMPocpqdj3pDqTujeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733269776; c=relaxed/simple;
	bh=oBGSdGwFKttJK94EcGcr1B9zaIvf7CVE1OQjRO4AzTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scHtZSHYeBeTPqH0B2GG2LF+4t60TGaSV9AFy7IB0BxJhdcWmigv7TRbpLPVXdAcZfXdYaJZEoOVBsOm7XRtUiZ4aEkCYdL0RaYYqp8nYb6JYT9Feux3TgCCDmFpB5oky1fwMLGw5TN0mr+EIXW7hKU+pLb3Ojn98/Zj73lStdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdM8Mhbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAEDC4CEDF;
	Tue,  3 Dec 2024 23:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733269775;
	bh=oBGSdGwFKttJK94EcGcr1B9zaIvf7CVE1OQjRO4AzTU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PdM8MhbmgEc4KUnnH7l2Lyu99zwl7Z5OebgXLkLRbHHl3nlJBc943qLs2XN8Z47qO
	 QkDetjG0XTWQXSuAYjMyhISoerkUS+BC0ZyxlHW+jkIesqe0EuWzYa0+lxnbXGOz+i
	 y/iRwTcEB7kGl/XBI7vIncHFTXbYKk+EBje3v+16pez04w6sOZCYUc9NAs71+k4s+W
	 7tPLkwJY7GT/1WxvGvcjsKKfqwLcApQDr+Wl6K1uZv6vDyqt/QAMZ/8NGz9WZVgkaV
	 /3b3IdVB/KHADOtS9Ok2rUxKPdMq6KmUoDhJUS3MAUVfCsb0zeAnq/l1QakdVlOHkF
	 8aiauNIXH3AiQ==
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3995f1fe30so3640481276.3;
        Tue, 03 Dec 2024 15:49:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYDQM3o/P75+D8bl3cl/Ldpr0ercUnBZnN/5NpKnJU6f3wGO+JsrNcsr/g9sBBC67x8EOjB0y3cl/d@vger.kernel.org, AJvYcCVoV0Vps80yFHkUjeiGU5tcQ2rzFzYNuKSvgC74rYDOOld0egh3SK/y4fKGNYEAehjQ5MwFFQ2/vowdb9OF@vger.kernel.org, AJvYcCVxdMLrjgsD8Q3p3kUu9Xn1eXj9ITIDcXCQmPA1HSAnnZVD/lxN6xPVJnAzpME8UJTqKpLMA3MsXU0b@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw6a1paug2nYiRi70PAO8zuE2CTU5cotS923QB5FrQBghLzu0j
	TYjSJm6420Sp/loUHsy5Q3aIlHM94fJu37jKSTWOneNphw8ivZJm9Z/OsGc1v565NPYspcExpdz
	voVQeRUW+VGfGdkNFpvcYDFHPvg==
X-Google-Smtp-Source: AGHT+IEHwiS/Hv3MtPo4+oC2+2cXOibwYBmxjiIn4+KhsVq2OjzCoLHYn29mTnBeut5dsub41r+sQbgZVD6lI1xuV3Q=
X-Received: by 2002:a05:6902:f87:b0:e39:a780:d110 with SMTP id
 3f1490d57ef6-e39d438956emr4652958276.46.1733269774980; Tue, 03 Dec 2024
 15:49:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121094020.3679787-1-wenst@chromium.org> <20241121164648.GA2387727@bhelgaas>
In-Reply-To: <20241121164648.GA2387727@bhelgaas>
From: Rob Herring <robh@kernel.org>
Date: Tue, 3 Dec 2024 17:49:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL7w4BBOqb=NaOh7Xewe5QXrSF+7SYoFtay0O5hw1QnTw@mail.gmail.com>
Message-ID: <CAL_JsqL7w4BBOqb=NaOh7Xewe5QXrSF+7SYoFtay0O5hw1QnTw@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctl: Do not assume device node presence
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Klara Modin <klarasmodin@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable+noautosel@kernel.org, 
	Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 10:46=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> [+cc OF folks]
>
> On Thu, Nov 21, 2024 at 05:40:19PM +0800, Chen-Yu Tsai wrote:
> > A PCI device normally does not have a device node, since the bus is
> > fully enumerable. Assuming that a device node is presence is likely
> > bad.
>
> > The newly added pwrctl code assumes such and crashes with a NULL
> > pointer dereference.
>
> > Besides that, of_find_device_by_node(NULL)
> > is likely going to return some random device.
>
> I thought this sounded implausible, but after looking at the code, I
> think you're right, because bus_find_device() will use
> device_match_of_node(), which decides the device matches if
> "dev->of_node =3D=3D np" (where "np" is NULL in this case).
>
> I'm sure many devices will have "dev->of_node =3D=3D NULL", so it does
> seem like of_find_device_by_node(NULL) will return the first one it
> finds.
>
> This seems ... pretty janky and unexpected to me, but it's been this
> way for years, so maybe it's safe?  Cc'ing the OF folks just in case.

This is a surprise to me, too. I think ACPI matching is broken in this
way too. I'm sending out a fix.

Rob

