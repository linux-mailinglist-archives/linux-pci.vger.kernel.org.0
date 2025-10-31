Return-Path: <linux-pci+bounces-39982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA952C27202
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 23:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242621A26C02
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 22:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126AF32B989;
	Fri, 31 Oct 2025 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kmqv0t4r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577453081C2
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 22:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761949738; cv=none; b=tLy811NprxwObEbtpm2G2MDs9BklUsQHtNWjxzKPjWJWU0SJ4Tm7jQy06ZqhLNNR0joUIz1tQmig145x7W+Ityc41YMzf+wTOb5skLGEa2lEVlxNsrmfRC5pxJb1ULQs6ZCeiUBMyxpUMy1gUB1uBkBA5tGCV60HkoqKy/Ex3QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761949738; c=relaxed/simple;
	bh=VZXcKlS2NfJQUqJUaLkoMO31MbXfEPxVU5q67dhNYbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCdBPY3UrcAOWGWZ/Cdni0aAjQRdZdX7KfNMQ9tjeLZs3+vLPf/efeMiFTlH1D/ZDPZJWFHjHN9QGN5yaBmiRDrC35tf5YMlohlVMa4qkNMSKAMaCCohvAQZx9gSW03erx3X/NUJwJreB+Kii4rtP3IRZwJ/hGTNZDWpQjJA9aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kmqv0t4r; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-58b025fce96so2223980e87.1
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 15:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761949734; x=1762554534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4VDPOkfEPN3V+mmkEOqmJfTYjVG4ZaMp9wTEce6ggY=;
        b=kmqv0t4rwZ+OooujAZB89C6U1PE4NY/hxG/N3arnBNvt6gcdI5fjWrSGf9YrcyXxKN
         yGg9J1HH/8TDQyiQiH1cwV2QnT74vWm7ZDyzcEYxuprajEkVaX4f/gJzwKnq1HfQ20ZI
         X/H4W9dQ2Sgb7YJMKmtl9Y68AnxuYX3owuhcNhD5/lBrRXvnr8VB6MuiuH4tYrGBphz1
         FtPytlwa3a6X1saOPHQg4ZaGJlMimZNSNYSsVunvrU6M11Y6f++bi+QoWO4mJJIvDi44
         uv6MJFrni1aUExCr/m8s6EQTGCu1qWpjXecUUFYn+kyCivXg8JeMiTaqkLgHZZqwIxn1
         jxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761949734; x=1762554534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4VDPOkfEPN3V+mmkEOqmJfTYjVG4ZaMp9wTEce6ggY=;
        b=Urt5dfHl67ElaQauKb/Q0K7QyTOLc8VhkDDJ0WouOCeD2h1zKkGlmwScAswNmEtio2
         +B+X79r/+KzRbsuFv3gmZMuUgAcEXL3FlkJK8UgMVEQZ9O3VYfJCwdMMaVurBl0/271J
         oclRPxD8oI09e6ySsCU2wGvUnoWJshUnPuF7s13MjiVB21s4+c+kuAn2VHLJvGLLauGv
         rmWQeKXe42r3UZlk+ahjUgfqhv2alh6Aq8rM9FuzPy5FTnGrGolm6xgdOGl+OpUyHzDu
         5w5KBlI2mfAG7Rf/JgbJ7lexUCE1BgEp0DS1IyWsLieNJQOIB+B7JiMIObfLYyWMAdc2
         AheQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwOrhrE3qMOLd6dONCE2cyw4+66cCNGhb/Vj7PqA5A4YEsdgmGe7wKKDdBkOxgr+0Az9OYQ6MRPR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEU7LjKJKc5sg5gFBNIkPIxmZO7PwZwI7+da57Drehsu58lKuj
	b/Eln/+e+Xbah6psUDNrHgr9KTzzGZ0hSfh2lCdgaDWuvfeXJabj+5snHCZde3L77df2ApaV/D4
	PnEiSW/kmgdwIcQaky2dL3hyzoP5zaaA+7wOL+Xeu
X-Gm-Gg: ASbGncvSYm5YDHRuTVqkwjR9rPY90vSCzg89eSixYUYbU69cXOJ7oO5A3rC28svaKHV
	FsASrPWfLm9x1SgJn0yVMwXBRR5ZDd5JEPDkk3gAUZPllMKjvk4DXH2YDyf29KgJ4hsb2iygNLL
	NhpRGnI/6Xfl6TQKIq1Xa/SlpS5MkPigVQxuzIfC/lwD7DE8f4zh6anhvyfxHqaISLJ+k9mQ1Kt
	RGaH9Dh2/ORFtYaDoQ18K4kQNyUfRQGw27WiKIRVrFCNjgoxX3SvWwbZyMbQWisrzBer8w=
X-Google-Smtp-Source: AGHT+IFSwcMwTIDGFtEaqjdkz/AcJl72mmVl0IpQ+J78Aae+a4oANLR7hdtuxWyAxkV1yPdEbNFPfRUD01apBcVpx5M=
X-Received: by 2002:a05:6512:15a1:b0:593:11bd:9af7 with SMTP id
 2adb3069b0e04-5941d5586cemr1780294e87.36.1761949734165; Fri, 31 Oct 2025
 15:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com> <20251018000713.677779-6-vipinsh@google.com>
In-Reply-To: <20251018000713.677779-6-vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 31 Oct 2025 15:28:27 -0700
X-Gm-Features: AWmQ_bkJhwWK8iLPcHy-hUK2RP4WggOSXosGGLXjIhn9TKPWrHQgEkrODFylvq4
Message-ID: <CALzav=f9tjgyF7TBsfjCpmvRezkkgfQY-OXwj+TaebjeffK-0A@mail.gmail.com>
Subject: Re: [RFC PATCH 05/21] vfio/pci: Register VFIO live update file
 handler to Live Update Orchestrator
To: Vipin Sharma <vipinsh@google.com>
Cc: bhelgaas@google.com, pasha.tatashin@soleen.com, jgg@ziepe.ca, 
	graf@amazon.com, pratyush@kernel.org, gregkh@linuxfoundation.org, 
	chrisl@kernel.org, rppt@kernel.org, skhawaja@google.com, parav@nvidia.com, 
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 5:07=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:
> +static const struct liveupdate_file_ops vfio_pci_luo_fops =3D {
> +       .retrieve =3D vfio_pci_liveupdate_retrieve,
> +       .can_preserve =3D vfio_pci_liveupdate_can_preserve,
> +       .owner =3D THIS_MODULE,
> +};
> +
> +static struct liveupdate_file_handler vfio_pci_luo_handler =3D {
> +       .ops =3D &vfio_pci_luo_fops,
> +       .compatible =3D "vfio-v1",
> +};
> +
> +void __init vfio_pci_liveupdate_init(void)
> +{
> +       int err =3D liveupdate_register_file_handler(&vfio_pci_luo_handle=
r);
> +
> +       if (err)
> +               pr_err("VFIO PCI liveupdate file handler register failed,=
 error %d.\n", err);
> +}

Alex and Jason, should this go in the top-level VFIO directory? And
then have all the preservation logic go through vfio_device_ops? That
would make Live Update support for VFIO cdev files extensible to other
drivers in the future.

