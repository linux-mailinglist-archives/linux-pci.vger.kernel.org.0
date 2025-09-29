Return-Path: <linux-pci+bounces-37227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B00E7BAA433
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 20:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BAA1C243A
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 18:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7FE228CB8;
	Mon, 29 Sep 2025 18:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5XtjB2w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494FF21FF35
	for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759169599; cv=none; b=dZmNjBbvpkQmhK2XnE2jiZxksbiKYK72o7PnrB7m5JmQQUne/J2ec6zHruIU6ZqkWm85HzyguuDpCkb0AyYjXpOR4fjKrlREzFvxUEJxRavoiFZO87Ik3QPGZ+jdtvZyY1/HJFHkZ0vFTDX/oeYs0dTQRD5zX9Cs1n4qF2zRPUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759169599; c=relaxed/simple;
	bh=LbwCbJnwhsCtXCbxbZQZfXUROtJgENJZsEBiokVyt7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/YxuGTBHzm/jvdbvg3gNocgdabJ/YegcTNIm1qIvd7opGg42b4DFoW4SzD0kuZBvFmhEOObO4kw3S1Y/GhweJofdL/pIfd6Vn/yLF34RYv+aRabkOpL906Nrmt2z2kImwcr8l1x8L4RAaDWRyt0pPpm5tUyqWfZIyJtm6m31h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5XtjB2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83C5C113D0
	for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 18:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759169598;
	bh=LbwCbJnwhsCtXCbxbZQZfXUROtJgENJZsEBiokVyt7w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N5XtjB2wsRcOUPsEFE2+iKWzuUGJOJbCScsTnmLOh0ofzzrpaGIRg/OjHTAN4k3W3
	 GaDbhysZ/KwPfMinM/9FP0TtM0bV/WF/lRuQqI5XvyvvBx1FA3iLBLTeF+fx0ewrm9
	 XANGYLf09wykdBrKEjvFO4xvP7QRmgItTyN2eMbgSBM/0E60hlU1jUN3WcIVLp7/sW
	 6bDRmQJieYHU+p/sg+rbKYhaMUHb47z7P5TITIMJ6/fcRs3n6vZWFx3yJFNG3zajzp
	 RyqIVUX0MBEBj8aiZbSYyiyOpcMrCAFnEEkttuy3k+OPhcUDrlZfuyoIceDUZEme/J
	 xgYets+fFYfXQ==
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6353f2937f3so4114937d50.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 11:13:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXf2uqjjZ18Zs6EeIbpbrarSvRsjoKNvSpahStzkTMXsk44c0iNq5OEoW0qtpnGmFO6xZQ8d5pNHeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/2UQPguF+jJfdZF7lO9kRUE3bP5qnlQDhS1rfWhRS6Mq2uqQe
	Ce2oA9sqelymfvH8nNiJKW7mU9c4b/qpJFjGubRxbAL/IUxx+rvERYZneyU6mN+E8k/IJAluiZv
	lboDgy/CvMsWvLWYEKEtfmkosC3KzM5saKqPP13v90A==
X-Google-Smtp-Source: AGHT+IFg0OBCiBZqtizi3btuOfJ6EymPr85/ZCLZnPOFwkIJAPuGsn7pDtacbGVQYs+4GNGu2Du1Go3Fo+VIP+PYvcM=
X-Received: by 2002:a05:690e:2458:b0:635:4ece:240b with SMTP id
 956f58d0204a3-6361a88e946mr14562261d50.43.1759169597965; Mon, 29 Sep 2025
 11:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+CK2bAbB8YsheCwLi0ztY5LLWMyQ6He3sbYru697Ogq5+hR+Q@mail.gmail.com>
 <20250929150425.GA111624@bhelgaas>
In-Reply-To: <20250929150425.GA111624@bhelgaas>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 29 Sep 2025 11:13:06 -0700
X-Gmail-Original-Message-ID: <CACePvbV+D6nu=gqjavv+hve4tcD+6WxQjC0O9TbNxLCeBhi5nQ@mail.gmail.com>
X-Gm-Features: AS18NWBUaTdODdRMux0yKzkKlHMV32HuBLvBx3alg9CqrbonyaWXQPfEFzRGNtQ
Message-ID: <CACePvbV+D6nu=gqjavv+hve4tcD+6WxQjC0O9TbNxLCeBhi5nQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] LUO: PCI subsystem (phase I)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 8:04=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Sat, Sep 27, 2025 at 02:05:38PM -0400, Pasha Tatashin wrote:
> > Hi Bjorn,
> >
> > My latest submission is the following:
> > https://lore.kernel.org/all/20250807014442.3829950-1-pasha.tatashin@sol=
een.com/
> >
> > And github repo is in cover letter:
> >
> > https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v3
> >
> > It applies cleanly against the mainline without the first three
> > patches, as they were already merged.
>
> Not sure what I'm missing.  I've tried various things but none apply
> cleanly:

Sorry about that. Let me do a refresh of the LUOPCI V3 patch and send
out the git repo link as well. The issue is that there are other
patches not in the mainline kernel which luopci is dependent on. Using
a git repo would be easier to get a working tree.

Working on it now, please stay tuned.

Chris

