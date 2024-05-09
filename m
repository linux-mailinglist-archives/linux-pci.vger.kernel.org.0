Return-Path: <linux-pci+bounces-7307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E128C1495
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 20:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4F21C2174D
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 18:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A8B770FE;
	Thu,  9 May 2024 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0YvPFhM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7F8770FC;
	Thu,  9 May 2024 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715278508; cv=none; b=T2I4NbET7KJ+69hKh+qP5tQ1u49r6m6FnMmiFOUnSTBQL2oW00oThWHO2Jbq+ri33TqcAYvzoUrfHad0MQKs4Rh0VBP2BZfDjS63opzFEmA/PwT9C5jTK5+gxJGD3Kj2hMz+bD0JBqR+HPLeTGCR5YTgqvmKFTjwgLHmm+NgBDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715278508; c=relaxed/simple;
	bh=AeL9LgunDsJxfxIGjvMY8yxKOYDFDU8ptsor2SXkmQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtLrCYEag00S/9Z5JtvKl1ddOtSyuYtA3SKqt6xxn7Z9MGd7TThNLDhAg8ZsKpAuLzy4jNW6bxOeBG9B7Z6MWiO+2pG+0aLFFYiLLQiKtxyRb9aTsAkoD94dyOky3MV8wTp4S/EAgISjE6Y9jc0hEbHGodzOSJASl4QbkWEZRUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0YvPFhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14254C4AF09;
	Thu,  9 May 2024 18:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715278508;
	bh=AeL9LgunDsJxfxIGjvMY8yxKOYDFDU8ptsor2SXkmQ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i0YvPFhMxAEoDP9/kkO19OxPU8u9h8h9BpK4MGUx/KLjTyZYKN7cIgnbhgR+qqrGy
	 +cNNgWe+F8HSl5rIF2vAKIxCSb0RguEqnUyUxn8seFFhwPGV5oJQ3zBSuvc6zpJRSr
	 BT4/7oGG9260QEfx7fmJwLNtjK9SPYguk6tCUYx2DlcpMc+N45Fz2hkE/9bh5EA0EY
	 cNxTkDXfw27yK+dLqG4IAYB0ChA7o/w1s5ibIdYdhC1ZRhXP7msVk8rN4IPbQqIP0K
	 5SSW/lOpPHadp5/KoySLYlnhgLi5iRax1PSfVMBzdXWCsPfGJKGzE8F/mF33qmHZT1
	 RCo3KgIoyBO/Q==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51f72a29f13so1472550e87.3;
        Thu, 09 May 2024 11:15:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVExqMYYZPYceesxIFtlCFIFkwVmHJEbM3ceO1jGaD+nUrwsYuXkGLoaBCp9RdKUyyGKOR89kLd15YYWhuMZr9CN2vtBhIrx2iH1ASsCgVk6pV8JLXbKL2iRHwyk70eBFJ+76jK
X-Gm-Message-State: AOJu0Yy9oiGFcHWyeO+4moRiTPbXZf2kXdOP/x7pqYXxtPqU6LT5JEDX
	zgHn1uA+e/vYie3MdQhheusk5iWr/wfmdsF19qpOwIl7+S+hl+pb3pAVzOUAiDYAjiruue/vvmt
	hIzdISrkvpXHjxYxS2ShRjMnSa90=
X-Google-Smtp-Source: AGHT+IFt25421bbw8fFN46Y8CarsZWqdOO3XV0VuKAoUNWeFEJP7rP8mzOmxLlm40OwmPpTAuur0swieiO37Qx8DQhk=
X-Received: by 2002:a05:6512:318d:b0:51c:df1f:2edc with SMTP id
 2adb3069b0e04-5220ff71e0bmr257422e87.2.1715278506372; Thu, 09 May 2024
 11:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240506192712uscas1p225316f79bb69f979b647d2a06a00a25f@uscas1p2.samsung.com>
 <9bf86b97-319f-4f58-b658-1fe3ed0b1993@nmtadam.samsung> <66396c1938726_2f63a29443@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Zjp4DtkCFGOiFA6X@bombadil.infradead.org> <48a26545-5d41-47f4-95a6-e55395b63c66@nmtadam.samsung>
 <ZjvSxTvu_SHWVCVK@bombadil.infradead.org>
In-Reply-To: <ZjvSxTvu_SHWVCVK@bombadil.infradead.org>
From: Song Liu <song@kernel.org>
Date: Thu, 9 May 2024 11:14:54 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6VkLsOo1L6Y8ojsaS6pBZki9HyPtB7iJHC+BWXoC-87g@mail.gmail.com>
Message-ID: <CAPhsuW6VkLsOo1L6Y8ojsaS6pBZki9HyPtB7iJHC+BWXoC-87g@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] CXL Development Discussions
To: Luis Chamberlain <mcgrof@kernel.org>, Paul E Luse <paul.e.luse@linux.intel.com>
Cc: Adam Manzanares <a.manzanares@samsung.com>, Dan Williams <dan.j.williams@intel.com>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, "dave@stgolabs.net" <dave@stgolabs.net>, 
	Fan Ni <fan.ni@samsung.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>, 
	"ira.weiny@intel.com" <ira.weiny@intel.com>, 
	"alison.schofield@intel.com" <alison.schofield@intel.com>, 
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, 
	"gourry.memverge@gmail.com" <gourry.memverge@gmail.com>, "wj28.lee@gmail.com" <wj28.lee@gmail.com>, 
	"rientjes@google.com" <rientjes@google.com>, "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>, 
	"shradha.t@samsung.com" <shradha.t@samsung.com>, Jim Harris <jim.harris@samsung.com>, 
	"mhocko@suse.com" <mhocko@suse.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 12:30=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> On Wed, May 08, 2024 at 06:38:36PM +0000, Adam Manzanares wrote:
> > On Tue, May 07, 2024 at 11:50:54AM -0700, Luis Chamberlain wrote:
> > > On Mon, May 06, 2024 at 04:47:37PM -0700, Dan Williams wrote:
> > > > For testing I think it is an "all of the above plus hardware testin=
g if
> > > > possible" situation. My hope is to get to a point where CXL patchwo=
rk
> > > > lights up "S/W/F" columns with backend tests similar to NETDEV
> > > > patchwork:
> > > >
> > > > https://patchwork.kernel.org/project/netdevbpf/list/
> > > >
> > > > There are some initial discussions about how to do this likely we c=
an
> > > > grab some folks to discuss more.
> > > >
> > > > I think Paul and Song would be useful to have for this discussion.
> > >
> > > I think everyone and their aunt wants this to happen for their subsys=
tem,
> > > so a separate session to hear about how to get there would be nice.
> >
> > +1
>
> Song, at last year's LSFMM you had mentioned the above work by ebpf folks
> with patchwork integration. While it is great, I am not sure if folks
> realize the amount of work required to get the above up and running and
> then to maintain it. So I was wondering if perhaps at this year's LSFMM
> if we can have a lightning talk or BoF to review just that and give
> people clarity about the effort required to do get this going and
> maintaining it. Its clear not only CXL folks would be interested, but
> also filesystems and likely block layer folks. Would you be up to help
> review that with folks with a lightning talk or BoF session? Would there
> be anyone else who can talk about that?

Paul and I have worked on using the CI framework used by the BPF
subsystem with md/raid patches. We have a section at LSFMMBPF to
talk about it (Tuesday 11:30).

Thanks,
Song

