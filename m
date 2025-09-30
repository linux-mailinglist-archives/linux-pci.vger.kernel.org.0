Return-Path: <linux-pci+bounces-37240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70530BAAF47
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 04:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A443B7AFF
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 02:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D72820FA81;
	Tue, 30 Sep 2025 02:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2b9h1Mu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F1220C461
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759198279; cv=none; b=vDrshSmNsgak8QYSOVDZke978MWGsZtQifmvTvDzt/CjTK8giupfy26sgDrOqoDuL+gnCvJNj2Z/hd41T96JzKp76Jq//iiix0vJ9iUDkHwo/pLsjH0dTi5LEUWuArWYyILRCdGZo1JF0QJtdA0iSHvdU/M0c7B4e+YqbCSdfvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759198279; c=relaxed/simple;
	bh=Qcg0Pez0p+DWdmYhXeRXKeDfcummUUl4iCcnUvf5h18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVZRfe0ITnHm3r5S9HB/zvanj1otphFMPRaDPsc+p1mFz9NqCyu/zwK6ZsPfmlIavpiGzpVZ3GWWFU46bgmmZ4XUXNbVMKkl3w6e1a1X4DROLqwz/VeHvzeeG2o2kc+KA+dVF8ZAdWpsHhFtswDeFR+3trot/sKsZqFYPb/W354=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2b9h1Mu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BA5C19425
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 02:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759198278;
	bh=Qcg0Pez0p+DWdmYhXeRXKeDfcummUUl4iCcnUvf5h18=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H2b9h1Munjxy3J0qb7PKYnc3I3htLeGVlHxZzvo1aScNpra2/flLbtoUvkUUjmoPA
	 brySsMl7JgKIAn1QyUnJe0wdznbzmuZ2KpY7LBYAWehbmoZ4a/plGDXIvaW7/WzDI5
	 do3r4uHhBQzwiRrkQ4Jl7emgGZpnGtz9rxjZf2f+VxHoSwkfrXkCQg3aJqdzJPW9Yu
	 Mthffr800IcPpow9hjG/SdSgS4Uv4CjDON3TPAaexHoZLUF1dqVS6Ngng0zGEflSn6
	 sV8tqbPBlC3wLugLoImWugB79u1i88ah+c5jgVDO5GvGxkKEg9grLnZaK8eUridARp
	 k55pH7UN6qxQw==
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e2b7eee0dso18015e9.1
        for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 19:11:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW7Gr1Vv3e1r95bV2ec+k4/31Zc2cTR/d993vy6OTuOKkuFyBZEHYWT/rA2X4BT16ba3yaINURtuZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2GPIxq6Jkt30AFdCbA1CZQmLs/IewcWwVBuABDVP/TI3Rpo1N
	ZgdWgqsBZrXb3yTdd/1kF0y8kdnQr749UDkdZh0dndMsGxd25P5cNW1UaOzJLAopUQUwWZ+ay8B
	gRJP6u3cE/qkWcLUa9O4zvCSVRK7oVxF0eyYGk5AC
X-Google-Smtp-Source: AGHT+IFu0rsT7acPHVfjOCERzKvRZnw//rb21LuRdVwrtJurZuHYmuG4hRgTmHgiPvtNFv9zuq75fzWyAk3h3wRQNOM=
X-Received: by 2002:a05:600c:4a88:b0:46e:251:b1c2 with SMTP id
 5b1f17b1804b1-46e5ab17debmr439105e9.7.1759198277218; Mon, 29 Sep 2025
 19:11:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org> <20250929174831.GJ2695987@ziepe.ca>
In-Reply-To: <20250929174831.GJ2695987@ziepe.ca>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 29 Sep 2025 19:11:06 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
X-Gm-Features: AS18NWCi8adg4cELGTsU1lnRXGe7mazBDOjS1QS4BB8iKUtyDujjd8aTlWrkbco
Message-ID: <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 10:48=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Tue, Sep 16, 2025 at 12:45:11AM -0700, Chris Li wrote:
> > After the list of preserved devices is constructed, the PCI subsystem c=
an
> > now forward the liveupdate request to the driver.
>
> This also seems completely backwards for how iommufd should be
> working. It doesn't want callbacks triggered on prepare, it wants to
> drive everything from its own ioctl.

This series is about basic PCI device support, not IOMMUFD.

> Let's just do one thing at a time please and make this series about
> iommufd to match the other luo series for iommufd.

I am confused by you.

> non-iommufd cases can be proposed in their own series.

This is that non-iommufd series.


Chris

