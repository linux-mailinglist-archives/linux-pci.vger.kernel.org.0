Return-Path: <linux-pci+bounces-6211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 043158A3C1F
	for <lists+linux-pci@lfdr.de>; Sat, 13 Apr 2024 12:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BA91F2220F
	for <lists+linux-pci@lfdr.de>; Sat, 13 Apr 2024 10:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE72C383AA;
	Sat, 13 Apr 2024 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqLjDwxp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795A61BDE6;
	Sat, 13 Apr 2024 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713003064; cv=none; b=qJsg57354Jhf7lciwIdop3CTlKP74F6TdeWOGPlegOTZqzTt0kpnVoc8WjAaESvggZJI7IrT6PYogfgQ4sbHfyidN/QF3D+1Mx5AUkmerKiQs2UwlDLIup/ZHvQRk98Mb5bFSlP+eopvUpA9sruzLPSf7jepJZ1jZBuBsyVb2F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713003064; c=relaxed/simple;
	bh=9n23xcSIvhfwRBwgRidm0Nmbhtmcr9UunIBGBhcaPyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KtiK0zBrIDu9+m8NykpO5fWi33A+tLl5ZhR+6oxJR+jlnlAByYfNmUcrgsKQXNuUkKWZQZcPoRlRv2t3qtsPIN6ylQIBUD1p2YLj1eUj+RDy7VhWcqDFrv6uoF02vM3H7heG+lSakN+nIONbU/ZCl0PRDukbrwwTzF0E1vXZLFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqLjDwxp; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2228c4c5ac3so983706fac.0;
        Sat, 13 Apr 2024 03:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713003062; x=1713607862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZBciApKLMvjxOVZYXzIoJbnqbwzjS65kVqw40ak0hE=;
        b=VqLjDwxpLKTEu8Xik0fzud+CmpPWjeXbobDI4Inyy//Lu0W2ukHT/xIIZmMrx9ZbUh
         NaDi7IpLcztY7w5+F9zONhxWe5wbrPnmXP1PCyUdpZjecnlH/LyiJCZVNNlszrmU8EOj
         ywN/Hfd9wVzBvjt3VjbWwfnXP1xv4m+W08ewvR+ghOjH6FlJlpn0zYMdwDQibFATSrAj
         CEFyIrFWonHRI2Zv04PkkHeMrDc6HpOX/cnN2s424c5LsugLhEgulrxu0xAzWeNOwvzA
         3mL14KY5Hld/2VVKEMHrMpEJY3XSX4EH5R/29EmymheI8d6n8rTF5nVpxTlU+yxKZxzg
         nU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713003062; x=1713607862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZBciApKLMvjxOVZYXzIoJbnqbwzjS65kVqw40ak0hE=;
        b=mT3GV/D2awhABYu4DEYGW3P//An0jkL8ZU/DVpTZ6Fmla9v40/T015FZOAeu3ByPW6
         KwuwjjjwvtMJxKSI4J1KKdA2VEWtU+mukxyxLUe4sILVwfwwH3gXdWv7bl8JXdcQ1gi2
         XWeDVyy+q2GyeowbDuq0CQHTCkhBdqJacLmnd5eOe7Zp6OpmmZsUvi8CqLAVLC6wRpxP
         xz7yFxcMnBGCi9K+WSPeMHoa9/UOgHLAgCOBU/3Nf280rqOHPp5IwcHyogygVGiKrRV4
         UThMALyYZKu17Frc9okuMRoHpTsz/Rzmn+3IGRhrw170iED53w/MwTe5WxFS5ribZkmR
         pUuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwMG/oMYNnjaFM6oQwRUQqCWyHk2t2T4Jdq/iULADE6+ul1TfC6g8eHKhFwilZ22UnNDPtb27uOIPLo99PYAAXKA2VGsCuxWLdM129
X-Gm-Message-State: AOJu0Yy4cTEa4gKD6GvrgEHanjqVnhGOfmM6Fy3J1FJQAqUVh59MrEE5
	DOpH3XH3fEF/ax4yz+trhmMSIkgBBlocWCCIHn584KHLuw8Ga3WJ2E63Jh/dvCOI+5G5fVWgcYL
	v2NG5wPnFlAKHP9XGDQCdvVrDINM=
X-Google-Smtp-Source: AGHT+IF6froqlMKKHPZGGxDZaZCd9+PLuvrqkLxfrrlHTkfygyF32u4tsaPghUAiwCTEKYeeEXNjwrVbcox5him7Ktc=
X-Received: by 2002:a05:6870:f10f:b0:21f:d2a0:60f with SMTP id
 k15-20020a056870f10f00b0021fd2a0060fmr5876813oac.51.1713003062633; Sat, 13
 Apr 2024 03:11:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111082704.2259450-1-sergio.paracuellos@gmail.com> <20240412213328.GA19361@bhelgaas>
In-Reply-To: <20240412213328.GA19361@bhelgaas>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Sat, 13 Apr 2024 12:10:51 +0200
Message-ID: <CAMhs-H-OWe3WRQb1iBj2oSy1s5wzazSo4ce9Hd+wxKUivy+3aQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: mt7621: Fix possible string truncation in snprintf
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 11:33=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Thu, Jan 11, 2024 at 09:27:04AM +0100, Sergio Paracuellos wrote:
> > The following warning appears when driver is compiled with W=3D1.
> >
> > CC      drivers/pci/controller/pcie-mt7621.o
> > drivers/pci/controller/pcie-mt7621.c: In function =E2=80=98mt7621_pcie_=
probe=E2=80=99:
> > drivers/pci/controller/pcie-mt7621.c:228:49: error: =E2=80=98snprintf=
=E2=80=99 output may
> > be truncated before the last format character [-Werror=3Dformat-truncat=
ion=3D]
> > 228 |         snprintf(name, sizeof(name), "pcie-phy%d", slot);
> >     |                                                 ^
> > drivers/pci/controller/pcie-mt7621.c:228:9: note: =E2=80=98snprintf=E2=
=80=99 output between
> > 10 and 11 bytes into a destination of size 10
> > 228 |         snprintf(name, sizeof(name), "pcie-phy%d", slot);
> >     |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Clean this up increasing destination buffer one byte.
> >
> > Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> > Closes: https://lore.kernel.org/linux-pci/20240110212302.GA2123146@bhel=
gaas/T/#t
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>
> Krzysztof applied this to pci/controller/mt7621 for v6.10, thanks!  I
> just pulled that branch into "next", so it should appear in the next
> linux-next.

Awesome. Thanks for letting me know.

Best regards,
    Sergio Paracuellos

