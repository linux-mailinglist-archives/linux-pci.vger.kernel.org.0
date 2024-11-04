Return-Path: <linux-pci+bounces-15930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E40B9BAFAA
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 10:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30AAF1C20D94
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 09:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0541ADFF6;
	Mon,  4 Nov 2024 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XdmhqKo1"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E63E1AD3E0
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730712607; cv=none; b=Hk/INfC0B3eMdMl9h/6ujeVTdgB3qkotG0u72QelLkLeftvJrG91yQikyHJw6kl2mtW/bD9GL4iNhrcItAJoJrnF8CtVEnQ64cgJ4xZFMazE+It/3SGpXhxXD6PmIZmt2XreKq9FjZzCTfbM3iiNG8rPDXdlzYaj2A1KWl8mnO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730712607; c=relaxed/simple;
	bh=sb4yWqpv6/YEDqWCs1cV14DXgP+M5wLtauRN1MCkkSc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q5bXCIMHyoVNy07HSgYJWKIE+N/FXKTfpoCLEw7DSwMxbLxrE45u7kq3OXo3S0cRpDqENj0YRQiu3J4med4cTeLGyOMeruRCSm9PlEQQNAtvN4+zsBOCPT9LxJWbuL3fV2MvYV1RlhfJKWXqE+zJuOId7BY4lJ5o5ogFlQpHrSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XdmhqKo1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730712604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gKtfGtvu9QuGOQ+mF1Y/MWcBZGqBG4faf6TA4C8EU4U=;
	b=XdmhqKo19dj6SyVCq+o7dDBMZUViZTkDARJAYQlLbzjayAyvrlQXqVn4oTXpPDh6Oqa5XM
	RMSEbkzvfmCci+JOCcnpXjQ0loiAChwKUtfsqOWT1xO7Y4H58JbJhz7ymeFTyRfVZV15BK
	3i3lB3Cldn+zSNazo/hwWNSbTRq1FwE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-ouhV2veHP-qEg1C19aLOCw-1; Mon, 04 Nov 2024 04:30:03 -0500
X-MC-Unique: ouhV2veHP-qEg1C19aLOCw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4314f023f55so27440275e9.2
        for <linux-pci@vger.kernel.org>; Mon, 04 Nov 2024 01:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730712602; x=1731317402;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gKtfGtvu9QuGOQ+mF1Y/MWcBZGqBG4faf6TA4C8EU4U=;
        b=SmsHpL25scRRor7KzPCb9n04GxLy/b9+bD42iehuKDEyCi6eErKBBQ5PlTJAne8Bu6
         Q0BlK4aa2deb72iFX/AzlmXzfJ+e8QZ2RXwSXpSAJimBNZO7kq6F8f7WRmjpVK1GhosU
         TLa/KeyeA4AtRt3kUlZObRj6XoWzgAwSwJEIWvhBzP/H2ACPs8Az3qARvvQpR6SLAKNO
         sKO14KC5gb1nYkh6wzqkKA4fBwT/7WRbuUz5mVOug/L8CHUNvWtf8AfR/tOq4v+aape4
         iFgK2sh/owgEoT4hLErD8AOI9kVuVIlhcCgIJtI9VyhHEPfTCSVL6rT3TjYSCmH9QSr7
         5aiw==
X-Forwarded-Encrypted: i=1; AJvYcCV/Inynqe/H8MY8//5HDjJD1VJrZs6O3AqWujhstIpTrAhLjIlcQmKcfyr8FOUdFgJiWhigNNxVtaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJS+ZATnU1GITsg/2wdU/ER9hWkOvK+3x5EG1UsleZwwb8gMHR
	Ur7y5Gi6zGhBZwVFmzD1ZLLbhdJzZMxUmGVLzIBY9RHnH3rxGIVOMeR0E3/T7JlGD+seeDBitGR
	karZYBweq4tKl1EWSkYaBAP+LRoA8BCRseFpWJPzVml1pNuYBlnjGKlM4oQ==
X-Received: by 2002:a05:600c:3b9c:b0:42c:bb10:7292 with SMTP id 5b1f17b1804b1-4319ac70754mr289713245e9.1.1730712601964;
        Mon, 04 Nov 2024 01:30:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhkGRUsLKoGes7Q+Gaa4JMpFBwwQDw4NqRdOi0qUWkq4kjb4UQjFbDvmfNCttWq+TBxtSH/Q==
X-Received: by 2002:a05:600c:3b9c:b0:42c:bb10:7292 with SMTP id 5b1f17b1804b1-4319ac70754mr289713005e9.1.1730712601522;
        Mon, 04 Nov 2024 01:30:01 -0800 (PST)
Received: from ?IPv6:2001:16b8:2d7f:e400:7f8:722c:bb2e:bb7f? (200116b82d7fe40007f8722cbb2ebb7f.dip.versatel-1u1.de. [2001:16b8:2d7f:e400:7f8:722c:bb2e:bb7f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf447sm145387895e9.13.2024.11.04.01.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 01:30:00 -0800 (PST)
Message-ID: <a16dab7222bc1388f4a4d5b1baa6ce0c613d7933.camel@redhat.com>
Subject: Re: [PATCH] ALSA: hda: intel: Switch to pci_alloc_irq_vectors API
From: Philipp Stanner <pstanner@redhat.com>
To: Takashi Iwai <tiwai@suse.de>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	linux-sound@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, 
 "linux-pci@vger.kernel.org"
	 <linux-pci@vger.kernel.org>
Date: Mon, 04 Nov 2024 10:30:00 +0100
In-Reply-To: <87bjyzuyvz.wl-tiwai@suse.de>
References: <11c60429-9435-4666-8e27-77160abef68e@gmail.com>
	 <87bjyzuyvz.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-01 at 09:44 +0100, Takashi Iwai wrote:
> On Thu, 31 Oct 2024 20:41:12 +0100,
> Heiner Kallweit wrote:
> >=20
> > Switch from legacy pci_msi_enable()/pci_intx() API to the
> > pci_alloc_irq_vectors API.
> >=20
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>=20
> So, this change looks conflicting with the pcim_intx() cleanup patch
> set from Philipp.=C2=A0 I think we can take this one and drop the
> corresponding one from Philipp's patch set.
>=20
> Bjorn, Philipp, does it sound OK?

Yes, that will be trivial to do. I'll just drop my hda_intel patch and
that's it.

Thanks,
P.

>=20
>=20
> thanks,
>=20
> Takashi
>=20
> > ---
> > =C2=A0sound/pci/hda/hda_intel.c | 21 ++++++++++++---------
> > =C2=A01 file changed, 12 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index 9fc5e6c5d..fc329b6a7 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -773,6 +773,14 @@ static void azx_clear_irq_pending(struct azx
> > *chip)
> > =C2=A0static int azx_acquire_irq(struct azx *chip, int do_disconnect)
> > =C2=A0{
> > =C2=A0	struct hdac_bus *bus =3D azx_bus(chip);
> > +	int ret;
> > +
> > +	if (!chip->msi || pci_alloc_irq_vectors(chip->pci, 1, 1,
> > PCI_IRQ_MSI) < 0) {
> > +		ret =3D pci_alloc_irq_vectors(chip->pci, 1, 1,
> > PCI_IRQ_INTX);
> > +		if (ret < 0)
> > +			return ret;
> > +		chip->msi =3D 0;
> > +	}
> > =C2=A0
> > =C2=A0	if (request_irq(chip->pci->irq, azx_interrupt,
> > =C2=A0			chip->msi ? 0 : IRQF_SHARED,
> > @@ -786,7 +794,6 @@ static int azx_acquire_irq(struct azx *chip,
> > int do_disconnect)
> > =C2=A0	}
> > =C2=A0	bus->irq =3D chip->pci->irq;
> > =C2=A0	chip->card->sync_irq =3D bus->irq;
> > -	pci_intx(chip->pci, !chip->msi);
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > @@ -1879,13 +1886,9 @@ static int azx_first_init(struct azx *chip)
> > =C2=A0		chip->gts_present =3D true;
> > =C2=A0#endif
> > =C2=A0
> > -	if (chip->msi) {
> > -		if (chip->driver_caps & AZX_DCAPS_NO_MSI64) {
> > -			dev_dbg(card->dev, "Disabling 64bit
> > MSI\n");
> > -			pci->no_64bit_msi =3D true;
> > -		}
> > -		if (pci_enable_msi(pci) < 0)
> > -			chip->msi =3D 0;
> > +	if (chip->msi && chip->driver_caps & AZX_DCAPS_NO_MSI64) {
> > +		dev_dbg(card->dev, "Disabling 64bit MSI\n");
> > +		pci->no_64bit_msi =3D true;
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	pci_set_master(pci);
> > @@ -2037,7 +2040,7 @@ static int disable_msi_reset_irq(struct azx
> > *chip)
> > =C2=A0	free_irq(bus->irq, chip);
> > =C2=A0	bus->irq =3D -1;
> > =C2=A0	chip->card->sync_irq =3D -1;
> > -	pci_disable_msi(chip->pci);
> > +	pci_free_irq_vectors(chip->pci);
> > =C2=A0	chip->msi =3D 0;
> > =C2=A0	err =3D azx_acquire_irq(chip, 1);
> > =C2=A0	if (err < 0)
> > --=20
> > 2.47.0
> >=20
>=20


