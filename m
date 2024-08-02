Return-Path: <linux-pci+bounces-11183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CBC945D1A
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 13:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F20F3B22D3C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 11:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1933C1DF69F;
	Fri,  2 Aug 2024 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnNsIUHo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9891D0DF6;
	Fri,  2 Aug 2024 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722597577; cv=none; b=LsbUsHJj93/mjtKDsNwFLWL+J+ghkW1eaDVw8PY+sHAZ7F9kC+q+mIHnTa5Bbuq9J6oermp02scWCWgezyPMXYwJOO+32eOlb5IyLFmOC7SPFyMBclW3GG4KI4Cnbe1v1PNVCpfN/XzDKc8GQgSA/fe8ClkcolQJDdujo2xOT4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722597577; c=relaxed/simple;
	bh=gqsBN6zqTFSD7ewAm2umxOvDKgjjv/CXfra6NQYMzFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1mCMpFFu4BLFwBo1RzBCJGkvjccVHEzVPKsQqoCI9V95xOWveqwQ/KmBnu7fkk4t1JHsPfES9b1IUc5juLx/lB3Q23aRw0ttLfNbfCRxy5UrZNz7yT82w9kkNTHFsi2G8+qoV9JCMV1YUXd3QXBRc0IlolGIaKV43BB1/6TlDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnNsIUHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6712BC4AF0E;
	Fri,  2 Aug 2024 11:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722597576;
	bh=gqsBN6zqTFSD7ewAm2umxOvDKgjjv/CXfra6NQYMzFs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GnNsIUHo1U7Q3+q2lOTVERtnXZVaMZsF40tTkyBVjWoCk4WoOcEsyumPnyY8hOAAG
	 bO4C0INU+Xu4XK6eZJe/pj6j5mOMKrT5KqxYcsaaXj4D4hD5b/b3UNtEt5jeNKKfca
	 2/mrPxkD1b/bYY8HC9ME5+oH/XucAnkkB8Zej8MGGwUV4WNwa42ssGBNrhAp3f8Vfa
	 lOv+N5xLHEOmn6z19a1tN8Zh1j8ihjqH4EqBEwnFxSRpdN7ZxBkOdBtzBb1JlbhqBe
	 V05hr7Zmo0KunQDK/e5zI5IbUd/MY2Qbz9DwRu4JUIHxSf7T6OzQ/XTM9HPSEUqtoR
	 j+2RacmTzqHWA==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db192667f5so838745b6e.2;
        Fri, 02 Aug 2024 04:19:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTakE7VWQcc9Pq16SKTwrYZY6EAR2ToNzbl4bt1EWSI/DfZaHb9Y2Ehpi07uLDRNauD1g5XHi+ymLFW/aD@vger.kernel.org, AJvYcCWruGVJt1n1l7U/lmN4wwqikIljwm4mm4mays7cW4omUdyUWQIMjGoL/qRM/HkCTPKiUkQUqUEbdtxW@vger.kernel.org, AJvYcCXgshDPxv1ydBQITwXdGZzfYLiPCbg+TIoYpuiWCGNW83iWmgBX8ivhObpfy8XJiFbnzRYL0k1mrVX6@vger.kernel.org
X-Gm-Message-State: AOJu0YwSeQnU6OPizdxqcWkSh7A6yoFyB8OG10h1Y6w4bZk/6FHFb3Ru
	jih48Vq9GsRfsQ5JIEw29uStjDTiUvLgaxIMG0+v+CTSHjPMV6Ra2uEAMWNS3ab5D4opcBfUqC4
	cxOk2JNaPUtY9WvDYyR8MF7mnxpY=
X-Google-Smtp-Source: AGHT+IEFOJBPRGJ+jQDSEvY7zfLglLpbL6a2LYHNxsO87G/hgW3J4Eo6anzuRB7W2+CHwlIkOsxrmAvaFJkxfOT3+dA=
X-Received: by 2002:a05:6870:2054:b0:260:ccfd:1eff with SMTP id
 586e51a60fabf-26891e9f29fmr1899588fac.7.1722597575722; Fri, 02 Aug 2024
 04:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
 <20240802-pci-bridge-d3-v5-1-2426dd9e8e27@linaro.org> <Zqyro5mW-1kpFGQd@wunner.de>
In-Reply-To: <Zqyro5mW-1kpFGQd@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Aug 2024 13:19:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hw7C2dHC3yXAwya-KAjzYxU+QgavO_MkR9Rscsm_YHvg@mail.gmail.com>
Message-ID: <CAJZ5v0hw7C2dHC3yXAwya-KAjzYxU+QgavO_MkR9Rscsm_YHvg@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] PCI/portdrv: Make use of pci_dev::bridge_d3 for
 checking the D3 possibility
To: Lukas Wunner <lukas@wunner.de>, manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, mika.westerberg@linux.intel.com, 
	Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 11:49=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Fri, Aug 02, 2024 at 11:25:00AM +0530, Manivannan Sadhasivam via B4 Re=
lay wrote:
> > PCI core is already caching the value of pci_bridge_d3_possible() in
> > pci_dev::bridge_d3 during pci_pm_init(). Since the value is not going t=
o
> > change,

Is that really the case?

Have you seen pci_bridge_d3_update()?

> let's make use of the cached value.
> [...]
> > --- a/drivers/pci/pcie/portdrv.c
> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -702,7 +702,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
> >       dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
> >                                          DPM_FLAG_SMART_SUSPEND);
> >
> > -     if (pci_bridge_d3_possible(dev)) {
> > +     if (dev->bridge_d3) {
>
> I don't know if there was a reason to call pci_bridge_d3_possible()
> (instead of using the cached value) on probe, remove and shutdown.
>
> The change is probably safe but it would still be good to get some
> positive test results with Thunderbolt laptops etc to raise the
> confidence.

If I'm not mistaken, the change is not correct.

