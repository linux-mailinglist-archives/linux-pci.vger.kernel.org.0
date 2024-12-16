Return-Path: <linux-pci+bounces-18531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 250379F378E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665E416260E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30AE205E01;
	Mon, 16 Dec 2024 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlnvwOof"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A449581ACA;
	Mon, 16 Dec 2024 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734370148; cv=none; b=YuG5IW51Xd/yRCCKSYgl06K6EPuLHcPwRY7cgP8riLvNNBkQx+XT/D7gOSbMh107taRfw7XuH6HSQUzQRIZKR4TdqmtqGkG7m+jHLc7tpkWi5+uXG6mEjbGe6D0qZs7iA3OgbCwHvYKKn6a/oDcBHqBJl5Zyr4LISNPqzI7FZtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734370148; c=relaxed/simple;
	bh=uO4RvUIsNNGHSqvi9NWA9W+sJAdveK70mBR5/s2dV7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kg0u2g5DMyvpcGjom4pvn+TGVmJ7supLUNwfrzirk+CnginsiufWMiwRcvRun4TZsHLsGOp7XU0zRMsAkoPOw7/kbl1QLBkQSkOnCSNa2o36UbDuyQ2fHuaAh9oYQFQvcEVAD1rfc48juzxkRpMMZvUYgClcRgRMG2RNwlfyowM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlnvwOof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B6BC4CEE2;
	Mon, 16 Dec 2024 17:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734370148;
	bh=uO4RvUIsNNGHSqvi9NWA9W+sJAdveK70mBR5/s2dV7o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QlnvwOofwMc2xXqXM79nNYMvdaL2/aqroltkRgfKLvUN9F7yYdB+NGwyKgk4JZIf7
	 7VaBVkrHNqDQIrMGxyq//QbJjOalGFYk4YEzDg36qwXzqYmifHwLZbRl4Rw+mGwLh9
	 1qXvB9XbtDxmJ1ujr5bqX50qpqVmMOPHuNr+a+UYI8UIKGX7qwuDH6P/su6JCc05hn
	 kLPh5mjprCsDgGh9TxpKuiXhzS5wn38yjkCcm4JhQs+dORvspvWYTaLy3uF1eB4QDH
	 6AWlS6+LbNwTmC/LoKxhu4AuIqoSUCxIzzy+jhOmoOgAHZ9XsxpfFxm/IFE3WVjZXC
	 lg6YlY+5IjAPA==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3eb7e725aa0so2073465b6e.0;
        Mon, 16 Dec 2024 09:29:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUR3JiYA4Og2oQE80u/K2DGIpEp+kKXRPfnxUgZtOOqK3s3CM/G2NDZLD+mH2uNx8BlVQa3PWjgGxo=@vger.kernel.org, AJvYcCWjtbEZBxDY/JgaOXBT9x0mElFVrRfhipflRvxtuvltE5vHD0zF83x3CKxaBa4O9Rebpxmze3h3+5JM@vger.kernel.org, AJvYcCXgZDIY7KLN4YfsVmzjAz1k+RMV7rBs4wt2huIhJe9G2/KTFVOn1ZitO9OcgE632PtIrIt6qM0wY0oELP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwByKnM2LzROdvBHB9ZUy/+dvq6xcBspqDuPBNIFubPLYoZqLZh
	OI5esgXtPmVdy7Mj75sG+vJU+J78cyeOBMjGnj8Tw9Avcf02HWScqiEa53QusO3YubBeqOTdcSU
	gu/rNnl5AMfITaZVtPs1cCaIBtzg=
X-Google-Smtp-Source: AGHT+IF3TcMdugshcb0ACvJieCHGeXkqH6Ge96ABjnS17IHSgmIjjh7HLYyc+Hm2VaaAjnQEBPZdSgJ7BTojcSgiNNU=
X-Received: by 2002:a05:6808:189e:b0:3eb:66d7:a33e with SMTP id
 5614622812f47-3eba67f9917mr8762730b6e.5.1734370147442; Mon, 16 Dec 2024
 09:29:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205232900.GA3072557@bhelgaas> <20241209143821.m4dahsaqeydluyf3@thinkpad>
 <20241212055920.GB4825@lst.de> <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de> <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad> <20241216162303.GA26434@lst.de>
 <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com> <20241216164830.36lpu6gfnapsdar4@thinkpad>
In-Reply-To: <20241216164830.36lpu6gfnapsdar4@thinkpad>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Dec 2024 18:28:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hxnYere19wXbua6zWEDRDgSPeJgSECugtwfgTP-UN8Bw@mail.gmail.com>
Message-ID: <CAJZ5v0hxnYere19wXbua6zWEDRDgSPeJgSECugtwfgTP-UN8Bw@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, 
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 5:48=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Dec 16, 2024 at 05:42:30PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Dec 16, 2024 at 5:23=E2=80=AFPM Christoph Hellwig <hch@lst.de> =
wrote:
> > >
> > > On Sat, Dec 14, 2024 at 12:00:23PM +0530, Manivannan Sadhasivam wrote=
:
> > > > We need a PM core API that tells the device drivers when it is safe=
 to powerdown
> > > > the devices. The usecase here is with PCIe based NVMe devices but t=
he problem is
> > > > applicable to other devices as well.
> > >
> > > Maybe I'm misunderstanding things, but I think the important part is
> > > to indicate when a suspend actually MUST put the device into D3.  Bec=
ause
> > > doing that should always be safe, but not always optimal.
> >
> > I'm not aware of any cases when a device must be put into D3cold
> > (which I think is what you mean) during system-wide suspend.
> >
> > Suspend-to-idle on x86 doesn't require this, at least not for
> > correctness.  I don't think any platforms using DT require it either.
> >
>
> On suspend-to-idle, yes D3Cold doesn't make sense,

Why?

> but on suspend-to-ram it is pretty much required.

Well, I know for a fact that on x86 platforms ACPI S3 does not require
putting devices into D3cold in general.

Why is it required for NVMe?

> That applies to DT as well.

Again, why?

