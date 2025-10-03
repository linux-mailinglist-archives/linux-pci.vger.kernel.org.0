Return-Path: <linux-pci+bounces-37548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5685DBB76F7
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 18:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B573A740C
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 16:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A2929D26D;
	Fri,  3 Oct 2025 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pG5pggDT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477504A23
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507452; cv=none; b=aozr7RmTPRRdqMu8DYOmCiIrgptSn8AolovbhDzOT0cS2Ui91E/YbejaVobolHThEb1ogsUVH86m7N6lLTsFOcjDPL/IjHhTLo4aHuYcSa1cbLzpl7Sg/3MP1yyzohEG6u9+G6rGQM7c9DrGyH0LhO9WfFYHpKzVg8gBEqwCwYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507452; c=relaxed/simple;
	bh=Mllrto1lI0Irl+/LejjLWiH35HKm+L9bOb7k3YgQoI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOhVryD+XdKTW1lvCIGJKUX7SHSLZ7T2M0co+ygfIUJ6/RJFrkucuBgw2RwgJCWl4h2GAmG7xskPEVLCH2ZCg9YGg3xbKwAGJE8qnwUJUIkVgqamnqvRromWXs3aMYuHdgaYEQXcZkp2vs8Fvfwi4E2JjhSqN8MUOWD4Tekc9II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pG5pggDT; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-36a448c8aa2so19724411fa.0
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 09:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759507448; x=1760112248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mllrto1lI0Irl+/LejjLWiH35HKm+L9bOb7k3YgQoI4=;
        b=pG5pggDTbkayQAHuailvhLOQaSc7f0QDJZxtRM5Ocgsg5GDVrJBKJYml1uV4MqtlH5
         x6gFylrPQoj14fnjLJtft8eE5mJStAZwpuuG4y1RSgajHoErEk7lTog7+i7P9Fbj8fQC
         v8+iTZRS4yLXZ+yDB2yq/aEZSPImwQ81G3zGAgghEPHumCrqaIp/Pfh1ucyrdvPoaPQO
         HrLFFL/+5zNSBZAWQHOsa2ZF63roT64VPM3vIEZDCiz0GHId6csOem/75byf9Knq0vlU
         +D+WQCfFWe1BGu2weYdIbdpc3cn75jBTgpqIFr64U7Dp6qxvExPMiE4UaTuP2c8o594+
         hoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759507448; x=1760112248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mllrto1lI0Irl+/LejjLWiH35HKm+L9bOb7k3YgQoI4=;
        b=mnbF74MIo9KvZFbHNcO6m9wx0+aGStAy/S+40XM7bCNSpiYXJPYQu8qtEJJ07j9Isj
         zNnKgBtyeVTxLCX91wW0lM5zYMiy5aF7UETGq+7eBo61G2KfwmVMiPvVQxzclYml/BBL
         5RXnhXjHUtaCGeEekrA+6akJifdKbG399ft4eaLul2G2Mn6g/WS8s4k4lu/Xgw3TwEd4
         eG1xClSussrLiJ/Fd+dJXwbdRZBPH/UgrYOy5T5KFWgNjJvE0O9pZoC4GJdVAnP0jNLA
         JIOo6JJ9bTnHAz1PW1d8HjurX+rUCeXgTS0v9M9+QRRgCOYgF8/dB8GsA473PttirIMr
         HADg==
X-Forwarded-Encrypted: i=1; AJvYcCXky8ysyz62ERUuimKGTuCypYk2oyLsy6T0qR8zZO+DAvHkN6NgXNH9hjfo7G/zxaN27NnaijgZM38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYpK7+qK75n7kX+VPsCJqMC0mwFDZWbeLT8Dl93RvLywCXxaOk
	Gdtq+nDfPv6gT+zDyI0WE2oyiJFbohQJJTx/jv1r9LTyMSXlxmzhkfJpAD06jiCCfaG/IdNkcdI
	zZ+SJ32yRyRf2EYGUjA00GGG01h6nV585/9rw7DWB
X-Gm-Gg: ASbGncv1P0CLF+ey7g8WDPIFIo6DOVN9DEBq6652OssRgbUCeS5sm9Q3K7XBkGZAUUU
	IItvUz4psUU0yOc8iVMQJo1xjvhaEnMcGIwbojOIr1+kjWedesRmawEPHPh2nx8Rw31rxdXc00Y
	pkFEKiRP3xkELLMFbn2/433LGLLuRYKUSgCzukRJdEJL3e2ZsE1BwvJHdB4F4IW+YIH9a7B6Qyx
	t4WodprgNy4tgE0PRVN67aDi/j0SytfcpBTp5hzt0l/Tln/
X-Google-Smtp-Source: AGHT+IGiMd7rKjwQRWLNmQV2ARjJ6CbLBvJ4uJ7+GgX8fPI3wLEN++8hxxM01GxQ22Ve+kjEe3XbnxIJhiOoe+F2QoQ=
X-Received: by 2002:a2e:be20:0:b0:371:fb14:39bb with SMTP id
 38308e7fff4ca-374c36cbf1bmr11636561fa.16.1759507447942; Fri, 03 Oct 2025
 09:04:07 -0700 (PDT)
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
 <CACePvbX6GfThDnwLdOUsdQ_54eqF3Ff=4hrGhDJ0Ba00-Q1qBw@mail.gmail.com>
 <CALzav=cKoG4QLp6YtqMLc9S_qP6v9SpEt5XVOmJN8WVYLxRmRw@mail.gmail.com>
 <20251002232153.GK3195829@ziepe.ca> <CALzav=cYBmn_t1w2jHicSbnX57whJYD9Cu84KJekL0n2gZxfmw@mail.gmail.com>
 <20251003120358.GL3195829@ziepe.ca>
In-Reply-To: <20251003120358.GL3195829@ziepe.ca>
From: David Matlack <dmatlack@google.com>
Date: Fri, 3 Oct 2025 09:03:36 -0700
X-Gm-Features: AS18NWC303vSFWFcWUMQr9iYimndopgbWOTEn34kaHamJm2L82qyIyCjJfpVv7M
Message-ID: <CALzav=fci3jPft+SXJ6tPG3=jRX7jjJPwnP=zWAb2Sui++vKPw@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Chris Li <chrisl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 5:04=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Thu, Oct 02, 2025 at 04:42:17PM -0700, David Matlack wrote:
> > On Thu, Oct 2, 2025 at 4:21=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> w=
rote:
> > > On Thu, Oct 02, 2025 at 02:31:08PM -0700, David Matlack wrote:
> > > > And we don't care about PF drivers until we get to
> > > > supporting SR-IOV. So the driver callbacks all seem unnecessary at
> > > > this point.
> > >
> > > I guess we will see, but I'm hoping we can get quite far using
> > > vfio-pci as the SRIOV PF driver and don't need to try to get a big PF
> > > in-kernel driver entangled in this.
> >
> > So far we have had to support vfio-pci, pci-pf-stub, and idpf as PF
> > drivers, and nvme looks like it's coming soon :(
>
> How much effort did you put into moving them to vfio though? Hack Hack
> in the kernel is easy, but upstreaming may be very hard :\
>
> Shutting down enough of the PF kernel driver to safely kexec is almost
> the same as unbinding it completely.

I think it's totally fair to tell us to replace pci-pf-stub with
vfio-pci. That gets rid of one PF driver.

idpf cannot be easily replaced with vfio-pci, since the PF is also
used for host networking. Brian Vazquez from Google will be giving a
talk about the idpf support at LPC so we can revisit this topic there.
We took the approach of only preserving the SR-IOV configuration in
the PF, everything else gets reset (so no DMA mapping preservation, no
driver state preservation, etc.).

We haven't looked into nvme yet so we'll have to revisit that discussion la=
ter.

