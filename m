Return-Path: <linux-pci+bounces-37471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ADFBB5654
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 23:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F10673426CA
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 21:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2754B26C386;
	Thu,  2 Oct 2025 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtEpeJNV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006461E008B
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 20:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438691; cv=none; b=EUS0PE9L3ZgDbxtkKyrpJAoGOXWkD+q2mHwV8GiZGDvHh9ZXbHfuo8461ZJ16tq95DUW1fSK2QM2t8/x7zHeFXU0ffJ41nMzrz8+6CpGr1MzP6eezAUGARQMeGCY9YXzXvAb4YA/1cyQey1orlhtvaUO6Lo3HF90LVCRgL7yZag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438691; c=relaxed/simple;
	bh=QuDJLpxpgTWQCmC222wS5dcfHdTx1VhU/4n6fIF2MmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxErEwMpMxVhMsPSEKw1Hsf0b0A0shNDr2bVHPsczRdOeB+SRLL9cJVX54iNL/IM9QuNK+aOBWacO5IbxbOFZtA2UMcGlN7id4v6Kgt1X2i2A/ToaYMHH8dCa41q51SaP4MA65jfSowvjVf+7vgqS8S4uiECJH5vm0RaxLTTavg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtEpeJNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AED7C4CEFC
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 20:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759438690;
	bh=QuDJLpxpgTWQCmC222wS5dcfHdTx1VhU/4n6fIF2MmU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EtEpeJNVRuiZu5G7oyC8Z3/vMaWQlljjOrmDOjKfTsFakrX03uec8ls2fpn/E5f3t
	 lIIplvsd+9pHHCgVGqjx7TpQ0UrqG4qaYYuE55rPNr1PW561Cu7mZmAasXAFL9Wvug
	 2fnOatdLnNJWEowl/zQq97wi57EFG3PY+maVoDO3V0kMmaV8T20U6om3cIoCnAa3eU
	 xqF8d9lGR63189BuUFjJHwW93KnP697RnH94jFAaiHpJxkLG3Ti6Sd+k27Bym5nr59
	 U8RIOSEXr9O3L0WGE1iwwsLU1EHoX1w1fSsNIXGajLC2bJW6s5XRIzekb7VdCQ+QYo
	 0qlgkQTPW/5Jg==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7501c24a731so17923527b3.3
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 13:58:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCJL75jl0/Q1l8Jf3SVyGnJ7W04fMoCQdksc6yIi+8XC0ietzqcLd2YxNPRaTD0dSaRoUR7kDuY7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvaK3hxTGWbDaIlR2zkpJs97kE33zN2NIvoqT7d8G+oUFr1Nn+
	R1AkDcI+64tPjPgxOfGiliMWdNQ4jK1b1zNM/LRrbDUlof29/x2vdCNDtM5TvFT+d/2V/81Vnba
	+pNRI1t6P+BQiOFKzrcOniuUPk4QuqxX11XhigZStYQ==
X-Google-Smtp-Source: AGHT+IEBbilENRA97k78jKka8MhP7AcUg4QxD+YO/3Zll3QmQghhCutavFmrEEWz0n+RwUianEhLXkUhS+pXlsXCha4=
X-Received: by 2002:a53:4203:0:b0:632:eae9:5cfb with SMTP id
 956f58d0204a3-63b9a0eccdfmr465910d50.29.1759438689674; Thu, 02 Oct 2025
 13:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org> <20250929174831.GJ2695987@ziepe.ca>
 <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
 <20250930163837.GQ2695987@ziepe.ca> <aN7KUNGoHrFHzagu@google.com>
In-Reply-To: <aN7KUNGoHrFHzagu@google.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 2 Oct 2025 13:57:57 -0700
X-Gmail-Original-Message-ID: <CACePvbX6GfThDnwLdOUsdQ_54eqF3Ff=4hrGhDJ0Ba00-Q1qBw@mail.gmail.com>
X-Gm-Features: AS18NWDZJi8whgIGIZhrpcn5Z11nQX63ss5Yzm8TI207CY6N08iz9viqDQ579L4
Message-ID: <CACePvbX6GfThDnwLdOUsdQ_54eqF3Ff=4hrGhDJ0Ba00-Q1qBw@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
To: David Matlack <dmatlack@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 11:54=E2=80=AFAM David Matlack <dmatlack@google.com>=
 wrote:
> > Then don't do generic devices until we get iommufd done and you have a
> > meaningful in-tree driver to consume what you are adding.
>
> I agree with Jason. I don't think we can reasonably make the argument
> that we need this series until we have actualy use-cases for it.
>
> I think we should focus on vfio-pci device preservation next, and use
> that to incrementally drive whatever changes are necessary to the PCI
> and generic device layer bit by bit.

The feedback I got for the PCI V1 was to make it as minimal as
possible. We agree preserving the BUS MASTER bit is the first minimal
step. That is what I did in the V2 phase I series. Only the bus
master. I think the pci-lu-test driver did demo the bus master bit, it
is not vfio yet. At least that was the plan shared in the upstream
alignment meeting.

> For example, once we a basic vfio-pci device preservation working, we
> can start thinking about how to handle when that device is a VF, and we
> have to start also preserving the SR-IOV state on the PF and get the PF

SR-IOV is a much bigger step than the BUS Master bit. I recall at one
point in the upstream discussion meeting that we don't do SR-IOV as
the first step. I am not opposed to it, we need to get to vfio and
SR-IOV eventually. I just feel that the PCI + VFIO + SR-IOV will be a
much bigger series. I worry the series size is not friendly for
reviewers. I wish there could be smaller incremental steps digestible.

> driver involved in the process. At that point we can discuss how to
> solve that specific problem. Maybe the solution will look something like
> this series, maybe it will look like something else. There is open
> design space.

Yes doable, just will delay the LUO/PCI series by a bit and a much
bigger series.

> Without approaching it this way, I don't see how we can't reasonably
> argue that anything in this series is necessary. And I suspect some
> parts of this series truly are unnecessary, at least in the short term.

You have me on the double negatives, always not very good at those.
If the bigger series is what we want, I can do that. Just will have
some latency to get the VFIO.

> In our internal implementation, the only dependent device that truly
> needed to participate is the PF driver when a VF is preserved.
> Everything else (e.g. pcieport callbacks) have just been no-ops.

Your VF device does not need to preserve DMA? If you want to preserve
DMA the bus master bit is required, and the pcieport driver for the
PCI-PCI bridge is also required. I am not sure pure VF and PF without
any DMA makes practical sense.

Chris

