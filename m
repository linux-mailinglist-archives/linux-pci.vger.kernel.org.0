Return-Path: <linux-pci+bounces-32176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F155B063A9
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 18:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F7F581748
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 16:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51235533D6;
	Tue, 15 Jul 2025 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lD9bdtUg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F6253B56;
	Tue, 15 Jul 2025 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595198; cv=none; b=CWSZx8QLjxra8zBxe9pvm3SUOV6PCjmdF5lUmouOtiO5um/YNWhq7TJ8RTn33QInUEKa8OZsKBEWdGIQdjNvqv3ce+UkxcE8b45CjofyN6fi377WRajPoutEQk/842bEwB4mXISbi//A+cTIte4Oitqi0pQO1Pb4RzSS6gtvesY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595198; c=relaxed/simple;
	bh=mRVDc7VBPUxcHyMhRkWzoKQfgdbXvRIk1kpQbOae6hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKk/z+sCcVq67x2ZSHo2PjvtvgqBPAdaczsyZtV1CSG3YvAfmZ1mEJQ1EoBu/u1dxzZRS+PD6bpx2gAVrvrDjlu9wSFgMSbnpajAYgmWfufqrKA+p7ZSIXpsI7fOthsJbOolNdLIH8iCzazthQpVBKADE94WlmsaisU5b/nEc3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lD9bdtUg; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ab61ecc1e8so19726871cf.1;
        Tue, 15 Jul 2025 08:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752595195; x=1753199995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpp6BY4iQxdZ1LY1LeK+b3jQoEtb6vrztAEcp2I/0D0=;
        b=lD9bdtUgdJT5lUwted+2zMSEnSHAXPd22Lsy2cWbBoi4D5RhQyBD+wNVPGQwQhVW2h
         7SmF808/t70uowesGNQR/hee3I3Pexmh3LFdS3uUd1GR7zvowfq419Aa7AgWnNkI+95n
         dJC1jZur6NRjG927uDI3n6ZTSjXotoBF3qPv4+e+es0/3jcEmRAkNvoww32NCRpZVrZv
         89Ro6clCJu4eTuI1XYkvGeM+KnjPJkWKDiDlvBMjSXt5XOw6apmfB1zQfvFEHG0wmZbK
         cd716GX6v2/wiuZO/Zlw+rOvd5OqS8nrntsLOnv5hwJHfU3jz7xpPZ/2Ef8n9cpeQiHB
         ZCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752595195; x=1753199995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpp6BY4iQxdZ1LY1LeK+b3jQoEtb6vrztAEcp2I/0D0=;
        b=oFZVdiBxDiWWcvE5X/2uzkzrXfH7N6l970WnP1CpgxMSm9INKm0TODkrqg7Qave82O
         iIil9rwDvee8LRzIxdXKcWw/yI1PQvvhd+TabHNLOE45RzskGVJT40tk3pz8Jvfvd/+R
         kN8US49unISqIh18/X/2a2kNjrZVdVeZ53F52TzCAkN6nGQOOd14u2D7utXdiZcKgUtn
         7o704vQvqruOgajVwuPY6auQtjif00poDnlEch0/KMfgmd8E/h2ZPXxVcDSozr3RKiU1
         wmcuJslBlgGRldty4f/EP3MIkfDBd/Bao4mWXbSJtRjoFDsZDUE/x3N0CZv6UAOAOHTr
         hpxg==
X-Forwarded-Encrypted: i=1; AJvYcCU22QTsk9OGwaBcrVdaHP1OthCZypuEaV1a3rlGXjRusnU5gpxN5KiHOyURxUQ8TSAq/K0RPAnYH8Hn@vger.kernel.org, AJvYcCU56eXKS1fqXx7CqMfbztc2cLj0NeewVUgbAZhY+SYkIY1Nr1yFUz7nwJ1kdeZN9Bc0A2OjbeDDPlu0mNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUvrcjtJqmCtRDpD1IRktNVU0C2eO5fbwSa50GrAWERrIomDlQ
	7cnGUrmXRH6K0FENr9irW+SPHGSEjOv8Atgj8JQcKgyueoczKKBxnEOA+jEsqdC5Caxc+H1JPeV
	vMQnW89BwYKoeA0YygdyIJ8dXNUKO2Bm/gvl+
X-Gm-Gg: ASbGncsz2JZ7zjRGCvouIh3wm00FDQCY4sf2uOgg/XKue/0oTznNnzMIj4xCVKx3hyv
	F/kwcrZyjeiVSm1gt7EH+sHKMQYVSH8AzWSgBjyOFQxhMhFoYRg9nO/WHKfyJjzVumSxOqyteyK
	q/9O4ZOX1VzVONzuAzS8T/shb2zgUEtFCRlUtXdvXNBITA+VlpAD51Jz4TC4z8GU2UEnTXxtKr6
	YZudr25w5gqHF5A+CNt+voxdO6blbG5a9d49ulDQw==
X-Google-Smtp-Source: AGHT+IEBXIaZhGQhCSSsOSP3twlWowibMpLtZUVFTzn/frLTUFIcCvnsGLq+1xzdsllFKnC3WQHhVfF50giWloHhub0=
X-Received: by 2002:a05:622a:5a9b:b0:4ab:8f1b:c032 with SMTP id
 d75a77b69052e-4ab8f1bc27dmr8635791cf.21.1752595195051; Tue, 15 Jul 2025
 08:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713011714.384621-1-thepacketgeek@gmail.com> <20250715121929.00007ef2@huawei.com>
In-Reply-To: <20250715121929.00007ef2@huawei.com>
From: Matthew Wood <thepacketgeek@gmail.com>
Date: Tue, 15 Jul 2025 08:59:42 -0700
X-Gm-Features: Ac12FXxAzW0uVtb36JCTyOcyzNQDeaDgZB89Uyif1-eOryyQh_h-ZsumrnHXf0k
Message-ID: <CADvopvZZKCdwT=XfaJzgFRgH=eXcTmjsdA8-86hJaki5PDjx=A@mail.gmail.com>
Subject: Re: [PATCH pci-next v1 0/1] PCI/sysfs: Expose PCIe device serial number
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 4:19=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sat, 12 Jul 2025 18:17:12 -0700
> Matthew Wood <thepacketgeek@gmail.com> wrote:
>
> > Add a single sysfs read-only interface for reading PCIe device serial
> > numbers from userspace in a programmatic way. This device attribute
> > uses the same 2-byte dashed formatting as lspci serial number capabilit=
y
> > output:
> >
> >     more /sys/devices/pci0000:c0/0000:c0:01.1/0000:c1:00.0/0000:c2:1f.0=
/0000:cc:00.0/device_serial_number
> >     00-80-ee-00-00-00-41-80
> >
>
> What is the use case for this? I can think of some possibilities but good=
 to
> see why you care here.

Two primary use cases we have are for inventory tooling and health
check tooling; being able to
reliably collect device serial numbers for tracking unique devices
whose BDFs could change is
critical. Sometimes in the process of hardware troubleshooting, cards
are swapped and BDF idents
change but we want to track devices by serial number without possibly
fragile regexps.

>
>
> > Accompanying lspci output:
> >
> >     sudo lspci -vvv -s cc:00.0
> >         cc:00.0 Serial Attached SCSI controller: Broadcom / LSI PCIe Sw=
itch management endpoint (rev b0)
> >             Subsystem: Broadcom / LSI Device 0144
> >             ...
> >             Capabilities: [100 v1] Device Serial Number 00-80-ee-00-00-=
00-41-80
> >             ...
> >
> > If a device doesn't support the serial number capability, userspace wil=
l receive
> > an empty read:
>
> Better if possible to not expose the sysfs attribute if no such capabilit=
y.
> We already have pcie_dev_attrs_are_visible() so easy to extend that.

That's a great point, it looks like I could match on the attribute
name to specifically hide device_serial_number
if the device does not support the cap, but I can't find any precedent
for matching on a->name in pci-sysfs.c.
Would something like this be alright after the check for pci_is_pcie(dev):

    if (a->name =3D=3D "device_serial_number") {
        // check if device has serial, if not return 0
    }

>
>
> >
> >     more /sys/devices/pci0000:00/0000:00:07.1/device_serial_number
> >     echo $?
> >     0
> >
> >
> > Matthew Wood (1):
> >   PCI/sysfs: Expose PCIe device serial number
> >
> >  drivers/pci/pci-sysfs.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
>

