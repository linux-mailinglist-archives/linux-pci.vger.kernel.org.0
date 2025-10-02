Return-Path: <linux-pci+bounces-37470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC16BB524F
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 22:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D48319C7167
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 20:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A4E28507C;
	Thu,  2 Oct 2025 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J128CHNN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F93D27B326
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759437895; cv=none; b=hwxcOmyeYxYb6UqD30iMfIMHIco5uhuYfBbyh9WPAYRmuKN3pq2Fy0TODFWOcvjkEL84+huIMaom1ijKwexGaBOdixSfJmVX0KM0gGZPoq8IiDZvUljguI1P/75pED457XLTeOFnpJvURJCoq8fQooDwsigBcdXR2rrFCCZQbcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759437895; c=relaxed/simple;
	bh=hKSBKPUn0KtYkwrNAi2/QJF5mTYjg1FUxzH8RYbePCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQ2u6Dfe0VI5915JDTgkvtv7oAR5qVZC159EBIdeyF6WTGBQQO7xYcf8KZOvTf7mssEPgrXx5tmfbb8MvjHy2iotNGQrrfCUw96RoEM3H1KyJCtTw7yzktqh8tSyCULworYxo4jm71SGPh4ktTa5gNwBhjL8MIUsrHojlX0GTNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J128CHNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF73C2BC86
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 20:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759437894;
	bh=hKSBKPUn0KtYkwrNAi2/QJF5mTYjg1FUxzH8RYbePCA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J128CHNNN2Gnf5UZ0FQBHRn9HoX1endGPHVIUk6s/b7Vxsu5YLK57a9dYgCa8jK4t
	 LT7D3DfLBUE6DeATin32p3ow5aQkCAkhxdU0NIHHozLOETP1K/rRnmtmbRZJ4vKd96
	 ry5NBtPs4yiKjli10dCzP5mDz/ggYRQwTS4nzgQQvLF9a3UuFlcsnG7UnzsOkoafjB
	 a0IC/2Ml1xKw/otS3hBKIR5tAiSp+9MHcu8pXplc/l9eD2c+qWfWdS9mSnsaV5P6M+
	 Z5+F24F8DmOuR6eyxCDc1AeQubtFGVBk9/+6Yo84o/jYm1zv/Nw4FI8vR0TZakp4Xz
	 qeNB420l+4CNA==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-72ce9790acdso16787857b3.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 13:44:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXthE9cSq0Cd4OM0cLyqQknd4eUPSj+35QcZX5Bh3aNDMdIZUeEYuf6syfZ8t8Dumu7leZb1vbJKpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWRqwpojqcwyvbIDEJeAe+3bzl7jI02b7Cfi/QNzAgcSb1PjNM
	JiRugpTRsIW7osuolUzFM9+Pu637jhuxaXf7HsXpODTrpneQpomf69zLl1iRgcN7Jl22Os+OMOM
	sjPhowp8S29mgd8YDWswqlypDEDNEEKvhdbwRbVRnfg==
X-Google-Smtp-Source: AGHT+IFdJU4u8os/0qhWk76IsG78VAVZY0H9/AJIA1nsBjxK9HlSqePk9R+2jcRz9SmNovlcle92Yh7C3cYe0aAbrgg=
X-Received: by 2002:a53:bd8c:0:b0:635:4ecf:bdc9 with SMTP id
 956f58d0204a3-63b9a0f4bc5mr503820d50.43.1759437893829; Thu, 02 Oct 2025
 13:44:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org> <20250929174831.GJ2695987@ziepe.ca>
 <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com> <20250930163837.GQ2695987@ziepe.ca>
In-Reply-To: <20250930163837.GQ2695987@ziepe.ca>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 2 Oct 2025 13:44:42 -0700
X-Gmail-Original-Message-ID: <CACePvbURm0dYYkZ9V-j1fMMZo748KjOnk7L2S=Oascr1wbvSng@mail.gmail.com>
X-Gm-Features: AS18NWCCShE-pZOZmdXzyrAyC9-XgQ9ycKUnw8IRfsTUHXwdST3MtT-x-XHLZss
Message-ID: <CACePvbURm0dYYkZ9V-j1fMMZo748KjOnk7L2S=Oascr1wbvSng@mail.gmail.com>
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

On Tue, Sep 30, 2025 at 9:38=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
> >
> > > non-iommufd cases can be proposed in their own series.
> >
> > This is that non-iommufd series.
>
> Then don't do generic devices until we get iommufd done and you have a
> meaningful in-tree driver to consume what you are adding.

Thanks for the suggestion. See the above explanation why I add to
device struct. Because it was contained in both pci_dev, pci_bus and
pci_host_bridge struct. All PCI related, but device struct is the
common base.

I can move them into three PCI related struct separately then leave
the device struct alone. Will that be better?

I did add the pci-lu-test driver to consume and test the LUO/PCI
series for the bus master bits. Are you suggesting the LUO/PCI should
wait until VFIO can consume the LUO/PCI changes then  send them out as
a series.

That will delay the LUO/PCI a bit for the VFIO.

Chris

