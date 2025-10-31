Return-Path: <linux-pci+bounces-39967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE4BC27068
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 22:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC431C21FD7
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 21:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B953164D3;
	Fri, 31 Oct 2025 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="idIKCFR8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073FE2D3737
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 21:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761945882; cv=none; b=ff64lyINTfz0nQL7B3fjomu8Mn1Wt4N0vHRzDHDlj4ioYHv28+9Qg3b0F+YibTO7ZbK3T62HTxb4dVmiO1zClQ2rCATOifBZI7Nwm9zQXOorbFRTBs/cs0HApxs5U1QOrTI06SnRnkgEUTcN+/LpvvOhuNlkbBn8eqMCd3NrJaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761945882; c=relaxed/simple;
	bh=9s6lBULnUl/YSXyAoY1qCPq6/SaViqv68dbwmyDt25w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMSb5+vsDjT6+FAGUQGPfTlXBFKOcEFK/ENEjFWFI+hm3hhdk3eAskbxwMwJrRr5ftGUknPbpbsVtv5u3zU6pY80zhbcBX815f7QbVQ7LAtvXvsHWoydHdRSKEg5/hptO5tWanbuyxpw4qBal4f0qOVEzamksXYXujETiayjSyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=idIKCFR8; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5db2593c063so1989293137.2
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 14:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761945879; x=1762550679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpjoY1kBRDb3U8mH54r0lGN10P1a/SXqiDQkhCichcA=;
        b=idIKCFR8YC5UL1Un9CI2YkQgM2SRjJ+pKECR1yynggD1gm7kI54LAIapppmLBni5tt
         LZ/52BUEhUG0RPwnB9x9seGY/wDOHbjCaqw4ISaE/xDiFGxaBBWnw3rJuEQuMZYmzXw9
         KvcmNGcVDmu6qtMfeA/pKj/ny/oZ81ez2M5/5CLsBng4waeqdTSs7PlciUgye940GP9R
         SU7vyNboObFckmC+dv/UqL6CYtUT9Q6GxpoqbUq+n5q6wHiBg9Iee8veGvM9WDxf2uOU
         NN/ZcmER4yf5poKTLDBVAFTAJhLQszY1C9R3gVzOoGMDIEgfWeVBvaoO8oRe4v5hAoJh
         Qr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761945879; x=1762550679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpjoY1kBRDb3U8mH54r0lGN10P1a/SXqiDQkhCichcA=;
        b=APn4ofeGqgHcmWPnc3Xc393WyeqWB1Z7PGgKmK1oZAHk0ylDwilWkGkux8/kOyrrly
         OpKBIRndBZ0tnvd5fewTkfzepi70Bp88hpQwcSYrDszkWr9I9+6TOJF0S5SVKNL+ygG+
         S61sYhsbbqQEAPEFuCP22aAIZGFzrA+RmUffm39pn3N4ERw5ghVMiUIu++pYPr2Q0BsB
         8iI6qkU0CkzSyFiVZVp4T3t2YBNO7LsgF1Xzsiv2UBYeaIDv3SIev8H6c06d8MIeSDE3
         xGIVGvZMZukgNV6dhHZOi1/0A/37JeMXYCaxg9/ZVrM52ApXnlhQcrbFt1KdZtbo+5tH
         rw9g==
X-Forwarded-Encrypted: i=1; AJvYcCVjjs2oMr78efIDNNvMs3RH3YFYm53zTpUp842AfYZi44basmf6xxuzBU8vMezwWunl73agoHPvnSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuSkQ6vHugIBu1PpISxd+ewcbcKlRgCBsmnA7nlF771xaRtPYU
	fUwRZCuP46y4QeUB8smA2BsjD6gX/RMID6SErLcXUk5cBQmZ4vptshxTk0YtjPPXeInlXRPcVwC
	0dsNVuohTnj+vTsOOyIwYQAKLF/M/OASezbvTIfEi
X-Gm-Gg: ASbGncsjxrv4PuLzidna9Gb0ouMzH/r+epQABMmDiP5TyCC2vR7ciuBxvjPtja2YVfZ
	xNSobK4zeOUkU77IAKNCysrh/YKzJabPJrsEP1yERjfxsnWogqn673mSylJZbFSZXWTtt95EwGv
	YPd4a6UGRYnZe7/qZyAV+/CTmSOHtV8IdXu228cYwBg2LwVVoLfhMd85zAqImx64wA6erazjTRk
	Dr/Ao8gY89EK7wOCsEtGvbnClhDuF9P0BHrwfBD3WzGWL9FPXJr9HRryCJcnxTdAgYu++tY/98v
	nj63Pw==
X-Google-Smtp-Source: AGHT+IEa8weTwiMv4+k9b5iS3dxJo7V7HJI0Y2IJFPjlhSxnxnH+h+0r1Y3lLUHs6JV9h5eOAClJX8/QV7LblzeB9fk=
X-Received: by 2002:a05:6102:2926:b0:5d5:f6ae:38f9 with SMTP id
 ada2fe7eead31-5dbb13777d3mr2038618137.38.1761945878741; Fri, 31 Oct 2025
 14:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com> <20251018000713.677779-6-vipinsh@google.com>
In-Reply-To: <20251018000713.677779-6-vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 31 Oct 2025 14:24:09 -0700
X-Gm-Features: AWmQ_blW-_jGmkpvjMwaGlbcIquIU3vgzEhEhObtmLexKwiUx2hVmj47uKbslig
Message-ID: <CALzav=dmx9ykjujAN0EiM3FPE9dFVaX4oXk=3Er9frtzsUT+1A@mail.gmail.com>
Subject: Re: [RFC PATCH 05/21] vfio/pci: Register VFIO live update file
 handler to Live Update Orchestrator
To: Vipin Sharma <vipinsh@google.com>
Cc: bhelgaas@google.com, alex.williamson@redhat.com, pasha.tatashin@soleen.com, 
	jgg@ziepe.ca, graf@amazon.com, pratyush@kernel.org, 
	gregkh@linuxfoundation.org, chrisl@kernel.org, rppt@kernel.org, 
	skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com, 
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 5:07=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
>  static int __init vfio_pci_core_init(void)
>  {
>         /* Allocate shared config space permission data used by all devic=
es */
> +       vfio_pci_liveupdate_init();
>         return vfio_pci_init_perm_bits();

The call to vfio_pci_liveupdate_init() should go before the comment
associated with vfio_pci_init_perm_bits().

> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vf=
io_pci_liveupdate.c
> +static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_hand=
ler *handler,
> +                                            struct file *file)
> +{
> +       return -EOPNOTSUPP;

can_preserve() returns a bool, so this should be "return false". But I
think we can just do the cdev fops check in this commit. It is a small
enough change.

> +static struct liveupdate_file_handler vfio_pci_luo_handler =3D {
> +       .ops =3D &vfio_pci_luo_fops,
> +       .compatible =3D "vfio-v1",

This should probably be something like "vfio-pci-v1"?

