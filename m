Return-Path: <linux-pci+bounces-9556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A91D91EFB2
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 09:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82B128430B
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 07:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9623577119;
	Tue,  2 Jul 2024 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFykPYTU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69C43EA69;
	Tue,  2 Jul 2024 07:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719903864; cv=none; b=hOb1zOnaq0sDR5fNuyqpREKjq8lzcwY0fg+axfb3hm3XyHoZVpGbbmA/5Hqk0XklACeH3NTLikamAU28Qu9ajgupk0umNH5r6frSB58QxPo/H0A4OSTXsv5Z17A4E5/P9wbjFhYs/tV2mK3HQ84BMRTuDjMnjSf/QR4ej+VUSkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719903864; c=relaxed/simple;
	bh=YVFF4aAP+ts/FhKDkV/8U1JQs5L0U2HH83zvE3B/8Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+RT2zjU8n1bJWPozhNLatuPDAUy9DzvV7PP5a/lZueuls2rUCrilD0KY4wLAEu4Mo4eFDTKzWigavs0n4eCY7jTFjS6BEjYQ+kUvttDqxWK/uCiP+kXsSctmuGbI5mSCGQEYJYCJUUSPNonwjQeAPz/ZaeneXqj83FUApKPFec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFykPYTU; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57cd26347d3so1473575a12.1;
        Tue, 02 Jul 2024 00:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719903861; x=1720508661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQI5KY7b4V/NKjyDGtRjIUo5iHSfmIyos5+Yth4NCP4=;
        b=mFykPYTUNSgX7Vxf7pObsEawm+kEcuIkndwWP7rDlc8jalKEPEr0KBN2j02v7zV2/d
         Y3Q36SNqNfLP83AecJDXSELi7V3+tLe0tz0XAQfhLpMrftkwYVCfXIsV/7rNZdtWY9HV
         kgZlAm+CJjhM1FPOM10w587qnMqqlux0KBFVXAjPOIzSyQvCAJHRjdRzcNTK7jeALuyh
         +6/U5DWHx2HAW21f5ykQBXp6GAuUPdbKWurqWQ7H+83TmaFO52sVX+uxxfLZJ3nuLMdY
         O2w/SNVUp/hHpaG+1ooS4I3rOObKv81W8/mIMIZz5qFYLWzBS8RrHpEMAjGQhnE7bQiU
         O+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719903861; x=1720508661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQI5KY7b4V/NKjyDGtRjIUo5iHSfmIyos5+Yth4NCP4=;
        b=ctUhw0sA+e2Y/PXWWkMOghj52PbZ+zU6kPpCkZk672x892oTqzdH8yOwdANCiLFpZ2
         DO3AaR6RPqZaTeK9HoxED6RkrLabcnTJMQ3lrGkJCH53XccMf+Pnp/NLNU4FUF02VR39
         BBKXRp51hw5UrVH4d+t+8kcHw7AqB4G5kgD+O2WZD+rhW1lMwvOCW7hV/iz3rgTojepW
         /nyf+qaEAt3H29a2/SLLf8YFC7Nc2uLl4ROfQVScFVVtt6MHt5ORUw2fr8jXvulqQibe
         sk0s6+hqh0kAQuFmrpp11onR08FM+Ll+vnqgOoCPWxFDCRn19Ngy0f5kDlntKT2+rGxF
         4tgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpLpk9BoKra+E2X35HHJKHT86+Ysui1EvT4jlnr+7aAXJiSlaFaYNZ0wK5WWU1+/d2//PPKE2oX2LwZH8fpxWzfMA+bVybByo9T6ceykYj9RbGvxu7HvYNQbQA2TxGnx8c
X-Gm-Message-State: AOJu0Yxtiqw4dhiGMWdTkSxrHSKvs8SrzKKedtZEOmSPJJbFweiZFv+W
	IqL2XuHXnl0EKDaahkpunC2COVqk66E1ZnKWlLY0B0v4qyDd3a7Bynvw1oTN9uygoZv6dasWN2U
	Im5+vTjXXLNcJ3N31Sy4BHwSRRS8=
X-Google-Smtp-Source: AGHT+IETBtsFH66UIhhBi/KnrWiGDixnvcbv9sP8NLo+IwVLaksKMLUOBXYh86aoFLWOwbHdU9uVQ/PQgxRyP78lbCI=
X-Received: by 2002:a17:906:6a0d:b0:a6f:6b6a:e8d2 with SMTP id
 a640c23a62f3a-a7514462e35mr519886566b.11.1719903860483; Tue, 02 Jul 2024
 00:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623033940.1806616-1-chenhuacai@loongson.cn> <20240626150820.GA1466617@bhelgaas>
In-Reply-To: <20240626150820.GA1466617@bhelgaas>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Tue, 2 Jul 2024 15:04:08 +0800
Message-ID: <CAAhV-H4ug-ioXDCB9=LuaXUDHA2jLErhQAtexrUtxjmCmN-Stg@mail.gmail.com>
Subject: Re: [PATCH] PCI: PM: Fix PCIe MRRS restoring for Loongson
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	Jianmin Lv <lvjianmin@loongson.cn>, Xuefeng Li <lixuefeng@loongson.cn>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bjorn,

On Wed, Jun 26, 2024 at 11:08=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Sun, Jun 23, 2024 at 11:39:40AM +0800, Huacai Chen wrote:
> > Don't limit MRRS during resume, so that saved value can be restored,
> > otherwise the MRRS will become the minimum value after resume.
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: 8b3517f88ff2983f ("PCI: loongson: Prevent LS7A MRRS increases")
> > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/pci/pci.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 35fb1f17a589..bfc806d9e9bd 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -31,6 +31,7 @@
> >  #include <asm/dma.h>
> >  #include <linux/aer.h>
> >  #include <linux/bitfield.h>
> > +#include <linux/suspend.h>
> >  #include "pci.h"
> >
> >  DEFINE_MUTEX(pci_slot_mutex);
> > @@ -5945,7 +5946,7 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
> >
> >       v =3D FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
> >
> > -     if (bridge->no_inc_mrrs) {
> > +     if (bridge->no_inc_mrrs && (pm_suspend_target_state =3D=3D PM_SUS=
PEND_ON)) {
>
> I don't think we can check pm_suspend_target_state here.  That seems
> like a layering/encapsulation problem.  Are we failing to save this
> state at suspend?  Seems like something we should address more
> explicitly higher up in the suspend/resume path where we save/restore
> config space.
I'm sorry, after some deep analysis, we found this patch is
unnecessary, please ignore this.

Huacai

>
> >               int max_mrrs =3D pcie_get_readrq(dev);
> >
> >               if (rq > max_mrrs) {
> > --
> > 2.43.0
> >

