Return-Path: <linux-pci+bounces-37555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCF9BB78CF
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 18:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10A904EDEDF
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 16:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3822C028A;
	Fri,  3 Oct 2025 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="asnvuUgI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0662C0294
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508920; cv=none; b=KKtiNpE86FPrO1sDQvQIjgIrN3rbQg6itqw2ZXj6HnH3KKWEEhtVEbIJdsR7+ccWaLpA8xe5u0XeCPDtSa71i2m873KhreBkI3+QoTX/qkIqn8CKJwqNVeX6Vl1jB74st1g2hSOwdEl7gxReoNLHh/j42eJp9169JwN+CYlRNrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508920; c=relaxed/simple;
	bh=cwz04LCVXZfN+AY4Qan7hQEjgfaTBfDS1fi9Fkv3U1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwAYGJ+1/VM960D5cnDCg5vJ8A0a0kJQSNBgtN8xVlw6k1CnXUkSmbfl/fLhTktxGPHtC9647mxgjgUiUc5bnAvrLMBEipxuiDL2iK2RHC9ZYFJKxksN0LNTmzOhQX1AyS03pEIEU9FQWGK1hzoxoZFd3DL1H8XvTdM/PlX/8Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=asnvuUgI; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8571a0947d1so254593785a.0
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759508918; x=1760113718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwz04LCVXZfN+AY4Qan7hQEjgfaTBfDS1fi9Fkv3U1k=;
        b=asnvuUgIJjQW1TanNasuRjI68hE/nnrni1rN3PR2na11AOQUVszaMw8psQjJb4fNnl
         ee4VmFQW9feoia5QiAeYH4K8Y5dAcp5/EmhRGekaU21Wv6h6DMJsAJkyTDUg2EUEbkiZ
         IUWMGsEEBJk0Z8sydOPTiKw9k0Cx0MOLnHX7yHCx3luDRo4WdY6oEkLmolAWtUGrQqm3
         eAhoH7dURIfPCUG362VgTJ29H0FdZj+N2A1D3TWH4xMmiXgofW6FKFBiqA/XjigNmAA2
         GTcV5+b6gnbf18MPeuXxA/56YHvU0szvnaPGdImqRJwWT/Stlk4dAHGZEIejnPFDwm9x
         wDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759508918; x=1760113718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwz04LCVXZfN+AY4Qan7hQEjgfaTBfDS1fi9Fkv3U1k=;
        b=fyI8JjxDl2AtbUmm26bTfQkYmQTT3zCTQQhRnk/nb98i1zMh1YvdrB1K0oO0KdRe0d
         cedq/utIohfL8s9rAtiQ5BgNU7zFZC4zjjZ1x+HEHSvbdrOb3Za81SK3Pnjcx1Hqdw+r
         Itzy0LXhJXF+VMLtkZtojhOlmqYcgeAMvWThKpJW1Dhn7zp4b0VwiQjbpHteB6nrOGh2
         B6m2Hxlvucwz2klTPiX2GnvzxXBThY1oqOL/QlrRnv+ZslUrzY5UUrsH25jVAhGvkqFc
         p0g/1RYP9If+5e4X/w38kOO3xwLQXmuoJ9Wk6RAzy/EPHRXK+kgek95e5n0t5BGaXIWq
         rZ/A==
X-Forwarded-Encrypted: i=1; AJvYcCU/bF5j8S96D3ISo3gQ20twjU2JAAomjnxXoJVlnkcG85V9J9vYYUC84BvXbi5qhGjcIBV4RlLRllI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqcaYMNI9tYmNTeJ9SJKOQQPfCLLFIRU+hLu2AVWKAvJJCRC4G
	5ACV+H5apQKIyxqI1im/ANYqYMqUapVsyn5ZIGY8PlyjEfJ4u7RsgXz5+8aTwPkI4w4pMmXtpP8
	gxQaTH+JsvcMLCgTOzmXALMB1OM78Z3vOwRVhq7F7Zg==
X-Gm-Gg: ASbGncubsZhoswdodswqlDjsQej4pkkl3RAD7hHv+5v0I0PQpV6CQ+SJmhv+DRfoqRx
	vnrusqD4/LKiqBiaJhA2a2mLNaXgaAwCWB3Hc2f6t1dG21D2xXmVXyD3ddjuj54LVQ0JW1x24Xf
	hDFYoH55crk/ljDrFK/fJaBuLCnqlVpWhmGz8tmuSp5vs3ocsCWwbKMo0cWETA/UH8I2zYwIzGt
	8Wxt5Um8oDgI4x6XKCb3sP85s8r
X-Google-Smtp-Source: AGHT+IGRIixVdtmeOFjO118a8JrECEI1Y4RPdInhz/esowkW/CRBGY/zsPPIbjs9YJ/9fXBRw/M8yAQgEqAmqYkP/Tc=
X-Received: by 2002:a05:620a:4004:b0:85e:95d9:8997 with SMTP id
 af79cd13be357-8776d89ab34mr1063023685a.43.1759508917927; Fri, 03 Oct 2025
 09:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929174831.GJ2695987@ziepe.ca> <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
 <20250930163837.GQ2695987@ziepe.ca> <aN7KUNGoHrFHzagu@google.com>
 <CACePvbX6GfThDnwLdOUsdQ_54eqF3Ff=4hrGhDJ0Ba00-Q1qBw@mail.gmail.com>
 <CALzav=cKoG4QLp6YtqMLc9S_qP6v9SpEt5XVOmJN8WVYLxRmRw@mail.gmail.com>
 <20251002232153.GK3195829@ziepe.ca> <CALzav=cYBmn_t1w2jHicSbnX57whJYD9Cu84KJekL0n2gZxfmw@mail.gmail.com>
 <20251003120358.GL3195829@ziepe.ca> <CALzav=fci3jPft+SXJ6tPG3=jRX7jjJPwnP=zWAb2Sui++vKPw@mail.gmail.com>
 <20251003161642.GQ3195829@ziepe.ca>
In-Reply-To: <20251003161642.GQ3195829@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 3 Oct 2025 12:28:00 -0400
X-Gm-Features: AS18NWC4qysxRWQgrKLz5j3weby2D_QNJ0TOooL4n65xeseqNhqAU98HM21pC0c
Message-ID: <CA+CK2bBLuGAMwVgj87p_H12P9yy6J99WwX8vwZbFfY0RTYsXDA@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Matlack <dmatlack@google.com>, Chris Li <chrisl@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 12:16=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Oct 03, 2025 at 09:03:36AM -0700, David Matlack wrote:
> > > Shutting down enough of the PF kernel driver to safely kexec is almos=
t
> > > the same as unbinding it completely.
> >
> > I think it's totally fair to tell us to replace pci-pf-stub with
> > vfio-pci. That gets rid of one PF driver.
> >
> > idpf cannot be easily replaced with vfio-pci, since the PF is also
> > used for host networking.
>
> Run host networking on a VF instead?

There is a plan for this, but not immediately. In upstream, I suspect
vfio-pci is all we need, and other drivers can be added when it really
necessary.

>
> > Brian Vazquez from Google will be giving a
> > talk about the idpf support at LPC so we can revisit this topic there.
> > We took the approach of only preserving the SR-IOV configuration in
> > the PF, everything else gets reset (so no DMA mapping preservation, no
> > driver state preservation, etc.).
>
> Yes, that's pretty much what you'd have to do, it sure would be nice
> to have some helper to manage this to minimize driver work. It really
> is remove the existing driver and just leave it idle unless luo fails
> then rebind it..
>
> > We haven't looked into nvme yet so we'll have to revisit that discussio=
n later.
>
> Put any host storage on a NVMe VF?
>
> Jason

