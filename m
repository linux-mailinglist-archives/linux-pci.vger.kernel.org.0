Return-Path: <linux-pci+bounces-17531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FE59E0419
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 14:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7747116768B
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 13:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A90202F88;
	Mon,  2 Dec 2024 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAhUjGrF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E09A201265;
	Mon,  2 Dec 2024 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147740; cv=none; b=U0TUU5Kagpmv6gOrEhMM6zeoiOkm5vLTM4JhmiTKAcEnFYV+7NHhn8A4HUeyhc4Avcfu/KWneRuIskqoU0QWTS8QRC1oZc1Rtqu6YT3QxZEIu8e6qB6W5YOfLgqbyLyJL8E/laMNwqiiJLXv/1fbtUD+M0eJMcIn3kqcxdBV4TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147740; c=relaxed/simple;
	bh=dq4Jh03jp7zUkTIngyjCfTLx54OmCwD9dBaqhm8rzgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDbQ3Purzgl+xejzKakadhCNfSARj/hPQ1TkMQt6r8zyenbUtfM8n/cV1h4VaSlAwvYKtQJ3qQ+msLSXZhs9kzjE80OKoLGi0x6iTkoUrYnZ0KEv4J/4i+GbyNg3AF2wE43DkyLShXCfpXfsgjsLopr6VTzFZ0aYxjZgpV4mEmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAhUjGrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE35C4CED2;
	Mon,  2 Dec 2024 13:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733147739;
	bh=dq4Jh03jp7zUkTIngyjCfTLx54OmCwD9dBaqhm8rzgc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dAhUjGrFy+t0yWWW6wifd5lVcxk0seADD3UyqN+n6WrxU4siwWAXkxY0RSQkK4IBg
	 ffHcOtmEeAI6kcooy1Akm6nf8cYga9IZVNclTQjCz6I1VtnHTLPZUHz1XIqj9xcirb
	 8a0XvfL8BdASvcF85mpbA+PWKxtByeR3uRetd9zOJpLhSVNFrACsDtCu6RBaDcn71c
	 1ejZtWmth3fYcfOEfRognRByzojQLwBijpmecZlRNXu77gxqRkifux8dZS1jTGV1DX
	 P0u5iZ384qeHuLTkDWrRPSluGAUS1WI67s/gj3yOCoU46LfUi1fUciG2NQocFSpWCL
	 0eY4HkMHwaTGQ==
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e3984b1db09so2883051276.3;
        Mon, 02 Dec 2024 05:55:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVUL6NjA7JuiEi6iF0eNNbk8vmmME8II7IktjKWb3DjUjeEnbJNiTieJo4ri3L6o4JeYE6qpRueCGbpPac=@vger.kernel.org, AJvYcCWuZA2EoYlZCSlWWffE1akP/BYs6SiVkGypSmbHbgGvd7JbEuq19TgwJXF5G+f1tjoFaKXaRNcZqJ3G@vger.kernel.org
X-Gm-Message-State: AOJu0YyYHH/jzgQ8nPr7cd7oDoaVlBClMjE1vHrZp4f7F5aRfakjFomf
	wDhNL84aF2gwxI6L/uGmIwRKr7SyW83WW+iadmPzsZOxVtEC1KZzRofY8rK6s08RXa6BiVY4wZT
	s0jvM7P4f2UWG55jVcyTKEQ7X0w==
X-Google-Smtp-Source: AGHT+IEloSJqy4rZ6DCnksDhtDtEDdsyojNs8gKu6ZzXmsQp5EfloUDQsNAE4mivTYgMThyDNwRd9UClK2iTfoC/vNE=
X-Received: by 2002:a05:6902:160b:b0:e39:8b94:16e6 with SMTP id
 3f1490d57ef6-e398b941c20mr12631670276.39.1733147738911; Mon, 02 Dec 2024
 05:55:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028084644.3778081-1-peng.fan@oss.nxp.com>
 <20241115062005.6ifvr6ens2qnrrrf@thinkpad> <PAXPR04MB8459D1507CA69498D8C38E0488242@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20241115144720.ovsyq2ani47norby@thinkpad> <20241127195650.GA4132105-robh@kernel.org>
 <20241202092902.rp6xb3f64llpabbi@thinkpad>
In-Reply-To: <20241202092902.rp6xb3f64llpabbi@thinkpad>
From: Rob Herring <robh@kernel.org>
Date: Mon, 2 Dec 2024 07:55:27 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+R39jtCeDecpEHbKq+4N-uirMQmsuNG1NaVe1Vnnnv3Q@mail.gmail.com>
Message-ID: <CAL_Jsq+R39jtCeDecpEHbKq+4N-uirMQmsuNG1NaVe1Vnnnv3Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: check bridge->bus in pci_host_common_remove
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
	Will Deacon <will@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	"open list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-pci@vger.kernel.org>, 
	"moderated list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 3:29=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Wed, Nov 27, 2024 at 01:56:50PM -0600, Rob Herring wrote:
> > On Fri, Nov 15, 2024 at 08:17:20PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Nov 15, 2024 at 10:14:10AM +0000, Peng Fan wrote:
> > > > Hi Manivannan,
> > > >
> > > > > Subject: Re: [PATCH] PCI: check bridge->bus in
> > > > > pci_host_common_remove
> > > > >
> > > > > On Mon, Oct 28, 2024 at 04:46:43PM +0800, Peng Fan (OSS) wrote:
> > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > >
> > > > > > When PCI node was created using an overlay and the overlay is
> > > > > > reverted/destroyed, the "linux,pci-domain" property no longer e=
xists,
> > > > > > so of_get_pci_domain_nr will return failure. Then
> > > > > > of_pci_bus_release_domain_nr will actually use the dynamic IDA,
> > > > > even
> > > > > > if the IDA was allocated in static IDA. So the flow is as below=
:
> > > > > > A: of_changeset_revert
> > > > > >     pci_host_common_remove
> > > > > >      pci_bus_release_domain_nr
> > > > > >        of_pci_bus_release_domain_nr
> > > > > >          of_get_pci_domain_nr      # fails because overlay is g=
one
> > > > > >          ida_free(&pci_domain_nr_dynamic_ida)
> > > > > >
> > > > > > With driver calls pci_host_common_remove explicity, the flow
> > > > > becomes:
> > > > > > B pci_host_common_remove
> > > > > >    pci_bus_release_domain_nr
> > > > > >     of_pci_bus_release_domain_nr
> > > > > >      of_get_pci_domain_nr      # succeeds in this order
> > > > > >       ida_free(&pci_domain_nr_static_ida)
> > > > > > A of_changeset_revert
> > > > > >    pci_host_common_remove
> > > > > >
> > > > > > With updated flow, the pci_host_common_remove will be called
> > > > > twice, so
> > > > > > need to check 'bridge->bus' to avoid accessing invalid pointer.
> > > > > >
> > > > > > Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()=
")
> > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > > I went through the previous discussion [1] and I couldn't see an
> > > > > agreement on the point raised by Bjorn on 'removing the host brid=
ge
> > > > > before the overlay'.
> > > >
> > > > This patch is an agreement to Bjorn's idea.
> > > >
> > > > I have added pci_host_common_remove to remove host bridge
> > > > before removing overlay as I wrote in commit log.
> > > >
> > > > But of_changeset_revert will still runs into pci_host_
> > > > common_remove to remove the host bridge again. Per
> > > > my view, the design of of_changeset_revert to remove
> > > > the device tree node will trigger device remove, so even
> > > > pci_host_common_remove was explicitly used before
> > > > of_changeset_revert. The following call to of_changeset_revert
> > > > will still call pci_host_common_remove.
> > > >
> > > > So I did this patch to add a check of 'bus' to avoid remove again.
> > > >
> > >
> > > Ok. I think there was a misunderstanding. Bjorn's example driver,
> > > 'i2c-demux-pinctrl' applies the changeset, then adds the i2c adapter =
for its
> > > own. And in remove(), it does the reverse.
> > >
> > > But in your case, the issue is with the host bridge driver that gets =
probed
> > > because of the changeset. While with 'i2c-demux-pinctrl' driver, it o=
nly
> > > applies the changeset. So we cannot compare both drivers. I believe i=
n your
> > > case, 'i2c-demux-pinctrl' becomes 'jailhouse', isn't it?
> > >
> > > So in your case, changeset is applied by jailhouse and that causes th=
e
> > > platform device to be created for the host bridge and then the host b=
ridge
> > > driver gets probed. So during destroy(), you call of_changeset_revert=
() that
> > > removes the platform device and during that process it removes the ho=
st bridge
> > > driver. The issue happens because during host bridge remove, it calls
> > > pci_remove_root_bus() and that tries to remove the domain_nr using
> > > pci_bus_release_domain_nr().
> > >
> > > But pci_bus_release_domain_nr() uses DT node to check whether to free=
 the
> > > domain_nr from static IDA or dynamic IDA. And because there is no DT =
node exist
> > > at this time (it was already removed by of_changeset_revert()), it fo=
rces
> > > pci_bus_release_domain_nr() to use dynamic IDA even though the IDA wa=
s initially
> > > allocated from static IDA.
> >
> > Putting linux,pci-domain in an overlay is the same problem as aliases i=
n
> > overlays[1]. It's not going to work well.
> >
> > IMO, you can have overlays, or you can have static domains. You can't
> > have both.
> >
>
> Okay.
>
> > > I think a neat way to solve this issue would be by removing the OF no=
de only
> > > after removing all platform devices/drivers associated with that node=
. But I
> > > honestly do not know whether that is possible or not. Otherwise, any =
other
> > > driver that relies on the OF node in its remove() callback, could suf=
fer from
> > > the same issue. And whatever fix we may come up with in PCI core, it =
will be a
> > > band-aid only.
> > >
> > > I'd like to check with Rob first about his opinion.
> >
> > If the struct device has an of_node set, there should be a reference
> > count on that node. But I think that only prevents the node from being
> > freed. It does not prevent the overlay from being detached. This is one
> > of many of the issues with overlays Frank painstakingly documented[2].
> >
>
> Ah, I do remember this page as Frank ended up creating it based on my
> continuous nudge to add CONFIG_FS interface for applying overlays.
>
> So why are we applying overlays in kernel now?

That's been the case for some time. Mostly it's been for fixups of old
to new bindings, but those all got dropped at some point. The in
kernel users are very specific use cases where we know something about
what's in the overlay. In contrast, configfs interface allows for any
change to any node or property with no control over it by the kernel.
Never say never, but I just don't see that ever happening upstream.

Rob

