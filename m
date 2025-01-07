Return-Path: <linux-pci+bounces-19442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375F8A042FE
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E70A160908
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C421F1917;
	Tue,  7 Jan 2025 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AV/NC3sq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD151E491C;
	Tue,  7 Jan 2025 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261184; cv=none; b=Sfub65FgNabY72qIi/HIBhGU9EtsWBa/Qn9guFNy8W+2+4fS+Ow3cRF6wnvFu6oi0krLBqcElz4FqMYlyzd51t29ulSzQs3KbxvTqEoQ66pxTLyY9ExJSYkoZeffNyXSjtLqSLGEYjz9hItxESjtN+DpIp+B0VxAL5PSbu07vYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261184; c=relaxed/simple;
	bh=SCPRluSpt1qsGmWs0v+16rP68QASchnoXbBrVm2LWWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKmgxmp88hw4Eh+6z43Os33vMRYoZHE8/ZStLQoz2ba7M6PFSA0TgLQUHiLxCXLTi2DBxdkpqRDTKYypTYa+MN5NztHO5zoKesXoDX0XrEWt9+clt+j9oHg6GazQcCu8hgqVx5Gr6nhLYhGyVwsyKHL+VyFmBThP31kJwK1SXEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AV/NC3sq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068F3C4CED6;
	Tue,  7 Jan 2025 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736261184;
	bh=SCPRluSpt1qsGmWs0v+16rP68QASchnoXbBrVm2LWWs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AV/NC3sq+Z9GYsJSR0NRFgYXG/T/ExU+tJoGJpC3D2JSIQtPZ45HCZZ0G/jM08+D4
	 gkEreMEvVXEFCBjxS0KvJ39hE/weXWwnW1K0dsGA09TRe5qTAm37AN8WhWJhlRUDPr
	 ZjlT7HjUswAjz9JJZVK2uS4b+d8mxdIzhuQ551xlD2SdPxVeZOFJOdrbJ2abYwEDPQ
	 +4ne0EvViCBFU9E3V/svDm35NMnDc6hPvinLqybyS7FXo5vw/EPoXEimh2WH2CvNbY
	 wr/UJrLJvxPrUX19bNM9MX4qUj6KdWPcDgNyjGQDdczGmv6dcF3eCIsGv7SOLV2LDR
	 qfreVsNNLT0Iw==
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e46ebe19489so20285382276.2;
        Tue, 07 Jan 2025 06:46:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgKZGDymHO9ZgLXbj3KzZ81g/D6tf95/P7swIgk8fgsXwq0fEtJeULE62GV+TG8CEMO95qhofTieVEurU=@vger.kernel.org, AJvYcCWKl3D1Y2IpgRvoq/KoF0XSG8SB0uj8ajY7kZ/0oqB2PonjMZjUvyqfCTN5hVDhtzFDtCKsrcW0qXXR8w==@vger.kernel.org, AJvYcCWfKDhsR8v628dZHXVgBBipe3hHMjcxno6aLv+QZWraEKtPMWxmBgUn/yU5NMmACaR1Q2uYHLT5B5yf@vger.kernel.org
X-Gm-Message-State: AOJu0Ywso/qGlpri7KXz31uukhbXpZmAMthGuP7XBDp7NcPEeHYxCJhy
	9NZQbvaIW9eoGiAk/1GQAd2kHIcZ1iO5DCcUOpwVnQv0nuRNRVUM+uclM+iirkXRgY5clneRl5S
	j3/jJ+pmZgSwn+TjN8q4DW5Ch6w==
X-Google-Smtp-Source: AGHT+IFyV9lVUw16Rv8iHzwmUnZSkHsA5PPxxrnmceolsNmDmlhg4nana1IEH6m/uPeTPy+gpBY7jSdc1ZLsVgZS2Rw=
X-Received: by 2002:a05:690c:620c:b0:6ee:4209:731 with SMTP id
 00721157ae682-6f3f8239192mr443182597b3.39.1736261183298; Tue, 07 Jan 2025
 06:46:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103213129.5182-3-helgaas@kernel.org> <20250103213846.GA6313@bhelgaas>
In-Reply-To: <20250103213846.GA6313@bhelgaas>
From: Rob Herring <robh@kernel.org>
Date: Tue, 7 Jan 2025 08:46:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJjUyV8vr7HkcV4yneo6KNw2QRzxYmTXiNCk524KudCvw@mail.gmail.com>
Message-ID: <CAL_JsqJjUyV8vr7HkcV4yneo6KNw2QRzxYmTXiNCk524KudCvw@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: of: Simplify bus range parsing
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 3:38=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Fri, Jan 03, 2025 at 03:31:28PM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > of_pci_parse_bus_range() looks for a DT "bus-range" property.  If none
> > exists, devm_of_pci_get_host_bridge_resources() defaults to the [bus 00=
-ff]
> > range supplied by its caller, pci_parse_request_of_pci_ranges().
> >
> > devm_of_pci_get_host_bridge_resources() is static and has no other call=
ers,
> > so there's no reason to complicate its interface by passing the default=
 bus
> > range.
> >
> > Drop the busno and bus_max parameters and use 0x0 and 0xff directly in
> > devm_of_pci_get_host_bridge_resources().
>
> Since we default this if the DT lacks "bus-range", is there any point
> in repeating "bus-range =3D <0x00 0xff>;" in all the host bridge
> descriptions?

No. And I tell people to drop it if that's what they have.

Rob

