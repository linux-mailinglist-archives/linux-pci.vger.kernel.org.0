Return-Path: <linux-pci+bounces-15555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAC29B523D
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 19:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B3D285FFF
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 18:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE5B205159;
	Tue, 29 Oct 2024 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ht/8h+U7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A301D201022;
	Tue, 29 Oct 2024 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228267; cv=none; b=nKutT1Y9Qi5IXa7XK36w1EP7FhXk82/kPme/SQF10Cxibdkx2/hHb7AHmZRAZxga9SZn83NiaaF0p97Z+OmBZ0rg1ngf9jBFy9UiIW9ib/8g/5ygcDTU+StXClMtH1b5YMi6VWzLerlyNItlzt9U/KBlqh73GVdLwMysZXG0a0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228267; c=relaxed/simple;
	bh=D1tnc82FcEdTMHQqlb9wRa0oMIVi2ZiBsAuNNQ7hehQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9N8PjUjHzKugVI5zchGSRgHD80HfeFukZSi4iKj4zGipe9d9k9Wd5UttpbS293hprZ9kwJ4Q7AEBvORu5wzOdcKVzHB2ndTCFMY56ulbKKKo+ayTEPJ5jZhShim1qN94ZTOCmrfFT/XCvb1AKhImdAZYBZmwzvKJ0b8goIYfi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ht/8h+U7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EDAC4CEE5;
	Tue, 29 Oct 2024 18:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730228267;
	bh=D1tnc82FcEdTMHQqlb9wRa0oMIVi2ZiBsAuNNQ7hehQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ht/8h+U7JIgjTAlkj+TZnVnGjlgdl5AT9osPUYpI5DiZaEvYueHj+g10n/r/Ak/cH
	 nGXLVvR83MgcXasWOLZO94H9e0l3iHMGoOThgTeRleZsX1Rm7SwrcDeuyllU2u7qrL
	 etzjOD4vPF25GPugHtn1ie+VkfIOUfD59I9fA5tOULIz5M0ClNmlWFkJbJ7pJ125TR
	 wlWWsPu5br8jo3lNlyS0hScz+4zIleJ5oalUGi+XgD/Gaz3EKfXwZM0QW1bibjEdFH
	 g9X+Ufg3g8R4eiiWhqQyeEY03qay0oqLPW4mIKNj/JfP7OF9DzsmNdWGHdvVNwclaJ
	 ixaez7/4FtHHg==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7092dd03223so2000243a34.1;
        Tue, 29 Oct 2024 11:57:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZ65mBTm1lKS5v+kw0iLuPK4XkZswRIzNRgkUU/zx4KR4b3bi0Hl1/oZc2zvKbAcHb9KoKlKUww78=@vger.kernel.org, AJvYcCV3/MGkXgpW3T2QBit1ooyp+2y75YnPrSjzBV3o9xdUmtSXxRa4FeF6lgsHt/DcN2zTXumjLgjPzhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5/AYvMV7UU60gykjjsEXbozbGYKnnI6WfPYSJ4xBSzWSlwqYi
	dEx6uPDdvzwU5guOSBPlDPS1xCy25H4aWw2TD93U1zd9BbMVXDu/i78xS8lrWgmQqEUsIkyzZ3A
	kHDSeMbDDw7es5SX+T4ZpFePjGY0=
X-Google-Smtp-Source: AGHT+IE1WNmrSXoffbXTuDxeYOeJnmO3oQDL5oFexHmT4a7own5HBZ7JlmqDIIqTGgg4Q7b5FDnxt/rrmAuYEQVnL0k=
X-Received: by 2002:a05:6870:1654:b0:286:f24f:c231 with SMTP id
 586e51a60fabf-29051c046c4mr12408665fac.25.1730228266464; Tue, 29 Oct 2024
 11:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012004857.218874-1-marex@denx.de> <ZwupHAAwTo5mDyyA@wunner.de>
 <52b90ab1-2759-45e9-ae86-3d3073a0add0@denx.de> <7ad59d82-8122-438e-9682-791816ab0366@intel.com>
 <6b47cc49-dd3b-4c4f-827d-f9b3a8719eb9@denx.de>
In-Reply-To: <6b47cc49-dd3b-4c4f-827d-f9b3a8719eb9@denx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 29 Oct 2024 19:57:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h590S_6xcj_ydF+qrBk+OeF6-5r+YDTXhc1whArT=f+Q@mail.gmail.com>
Message-ID: <CAJZ5v0h590S_6xcj_ydF+qrBk+OeF6-5r+YDTXhc1whArT=f+Q@mail.gmail.com>
Subject: Re: [PATCH] [RFC] PCI/PM: Do not RPM suspend devices without drivers
To: Marek Vasut <marex@denx.de>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, linux-pci@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 7:58=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 10/28/24 6:52 PM, Wysocki, Rafael J wrote:
> > On 10/26/2024 2:19 AM, Marek Vasut wrote:
> >> On 10/13/24 1:03 PM, Lukas Wunner wrote:
> >>> On Sat, Oct 12, 2024 at 02:48:48AM +0200, Marek Vasut wrote:
> >>>> The pci_host_probe() does reallocate BARs for devices which start up
> >>>> with
> >>>> uninitialized BAR addresses set to 0 by calling
> >>>> pci_bus_assign_resources(),
> >>>> which updates the device config space content.
> >>>>
> >>>> At the same time, pci_pm_runtime_suspend() triggers pci_save_state()
> >>>> for
> >>>> all devices which do not have drivers assigned to them to store curr=
ent
> >>>> content of their config space registers.
> >
> > What exactly do you mean by "at the same time"?
> I mean these two blocks of code run in parallel and likely race each othe=
r.

Which two blocks of code?

I'm guessing one of them is pci_host_probe() and what's the other?

Unbound PCI devices have their PM-runtime usage counters incremented
at init time; see pci_pm_init().  This can be undone by user space if
it changes their /sys/devices/.../power/control attributes to "auto",
but in that case the device will be suspended immediately from
control_store().

If pci_host_probe() can race against this (and it looks like it can
from your problem description), it needs to call pm_runtime_get_sync()
on each PCI device before accessing its registers.

