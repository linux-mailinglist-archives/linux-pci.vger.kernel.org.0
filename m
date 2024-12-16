Return-Path: <linux-pci+bounces-18527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30249F3687
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3D616CF14
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 16:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C3820DD59;
	Mon, 16 Dec 2024 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltJu+eJe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60CE2066E0;
	Mon, 16 Dec 2024 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367363; cv=none; b=jIQVFrVWbYT/kiv2LoVGGTwqIrJXCqQqQRKtQU8FkYjpNqatyzyy2XBE+bDTDNiuZLMKHWA4L3av8GdEVTgXs0KQOLNfhOdR10FyKLRTs1U5p/6Rqt1gicu2+W82p/gKSxZPTNydZQwDAolKug7PfsX+13F/Dm9GHvvNNb99AO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367363; c=relaxed/simple;
	bh=/YZL8BCWUrGgnBHMRhMJrndei+MItSBCpjXPuhiodx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxjsW87p4DIz08tuCRb82+5GSSvzOoAIX6UYuO2KwWKUdEynLqL0Ai0a+lMDlE9+qLEvP5fHhCxCHBubw/YlG9g2hfncFedlCplCpCyXW35B/7uYPKYPmKRsGl+T39ihBVS3Dkyz6vr8vNKpmM5xABUHKKYOhF02BFFLkFBuaEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltJu+eJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B31C4AF0C;
	Mon, 16 Dec 2024 16:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734367362;
	bh=/YZL8BCWUrGgnBHMRhMJrndei+MItSBCpjXPuhiodx0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ltJu+eJeR3GVPWDizkM77lXgowRdcSjeVfd5GPbD227yBIXxqu2EAYCE39iRRdUt4
	 SpSB9VFKQcfVlXU/V/oMfWNazpYQ7e81rSLUbIHctVeIagYKBNKrky7f9MAa8LC0Oj
	 tTOQmJ7ZryVejBv6bhG8HJPeR2a9aNgpznsVCAE9z8VxSvQUsiPhdJWc/dIzYx/hxr
	 0CEHhhkbIyhImMh6SMZC3KuRVYxq82JmoJKdhvOujrJ9I1QM3nFxkrgaN+6A/9W3bS
	 Jjzi5snzhCdVCbQZpKNfo9bDa7gV72cCFX5paBnp5fFA3gCKc1tHsTVr1Lu+DFm3VZ
	 N+3FE7AcN9hHw==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eb98ad8caaso2275153b6e.0;
        Mon, 16 Dec 2024 08:42:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVc6IBKJkLjAfbHSxl/cynCpvO593RWmzrJJis0X1U6TvPotQSGE4d1O7+GDkmyOS88t4+zfHC2hhk=@vger.kernel.org, AJvYcCWA5hTdXYGGepBDv/lZ4YW/dsSqTC+Jw/yvxZlNvX04RtDevEcaeeXaH7KiSxz7naDFLUyucYIhY/Ah7uQ=@vger.kernel.org, AJvYcCXxz29GgqeMYvhnqRhPta+yi9NWjKvSrwQI75nS21IStPDLVOBd6IEZBReq3j9edQL3YkpDoz749hTR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy33+KSJ2iOE5tBpCwBFhTWt0t7j+1bN2miThFjoaBhkdEUO5W+
	pVi4BwKqIqnYXtzp125dfuNJQrYL9OMowxjLmqVizjqZeA4qejR6Uadzi/FMIFEkQ4glLd/KNSt
	j0WtxSMIKs0uf/DMydmIsf2a0NQw=
X-Google-Smtp-Source: AGHT+IHnMZjbo2UVibBmoMUnEzobdQTlLjR1cy109pM5/JrqwIVhmYAJg7QJ9Vp9yf3MkZqDb3PPIJV5mlF0UqPv0JE=
X-Received: by 2002:a05:6808:1887:b0:3eb:556e:dde6 with SMTP id
 5614622812f47-3eba6867bb5mr6716314b6e.12.1734367361510; Mon, 16 Dec 2024
 08:42:41 -0800 (PST)
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
In-Reply-To: <20241216162303.GA26434@lst.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Dec 2024 17:42:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
Message-ID: <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
To: Christoph Hellwig <hch@lst.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, 
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 5:23=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Sat, Dec 14, 2024 at 12:00:23PM +0530, Manivannan Sadhasivam wrote:
> > We need a PM core API that tells the device drivers when it is safe to =
powerdown
> > the devices. The usecase here is with PCIe based NVMe devices but the p=
roblem is
> > applicable to other devices as well.
>
> Maybe I'm misunderstanding things, but I think the important part is
> to indicate when a suspend actually MUST put the device into D3.  Because
> doing that should always be safe, but not always optimal.

I'm not aware of any cases when a device must be put into D3cold
(which I think is what you mean) during system-wide suspend.

Suspend-to-idle on x86 doesn't require this, at least not for
correctness.  I don't think any platforms using DT require it either.

In theory, ACPI S3 or hibernation may request that, but I've never
seen it happen in practice.

Suspend-to-idle on x86 may want devices to end up in specific power
states in order to be able to switch the entire platform into a deep
energy-saving mode, but that's never been D3cold so far.

