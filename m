Return-Path: <linux-pci+bounces-30179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837E3AE05D6
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 14:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A623B6224
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 12:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836EC23B632;
	Thu, 19 Jun 2025 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aisiQ/LX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A37230BEC;
	Thu, 19 Jun 2025 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750336042; cv=none; b=T2FEzPbGJKKKoXOFj/oJqTEW0NDnGTsME/UbThdoVqq6tcknvQoOVz3E1ModqecG79jkZB2pgxF8EIYy3RRlqSzJaY6OjRwpD9yGRELNuUA6DCC9odOH+P0IkJovpbuSnwcf+8BNoiZxjpR35Wh+znd28kcp+hs0nNFpSTPhvOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750336042; c=relaxed/simple;
	bh=AK9gsNzBgo92LrWsapH+EkbciDumjfBEf5VT8yAuwkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7LBHiRn+a8QTQ7jbq90QBWw9pIAIFQYftFzJxa23vawtPPtDCzevNF2mi6/gSkCxJ/Qxeidh2hjoxs+yf5zG8x1JMDJGHUUck/aktlZD7CssyecwBEWGXRNEX03OQL56qBaV6v9/gCFKpWQEUi8beM3wbVu+ZyELOdJtTXStGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aisiQ/LX; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so1076950a12.2;
        Thu, 19 Jun 2025 05:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750336039; x=1750940839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXzG851x8092VcL5aMEVC4/pjvof2rTy3Q0YvYZaPso=;
        b=aisiQ/LXMhlN5588JBPXZpWlyxRuc5zBvFvJz2/MIaqPt45S1exVaSZ4V0YEh5gGCR
         i3zejZFKj3NCXNf7ua6EUEOPBbAoBG1wXCxwfWRM7BYu02TuU/vNfazpsb/ML940vC7y
         4v3dAhKAnt+IHyoAfpnfjxXI9keYA2jtg8dYuvZ2KYUuBLv0XX2RSn3rqkLuaWLh//hM
         IYY5Jtj/sk6kvqW+e3DxlAL4peXN2Zuaxgh+kIZPpbt30VLj+X5b1ZVI+rntIo73kpQR
         hc8MydDWmZdMXlmwMuvUze4GlvmN1O+jfgDO1QnKJr37IfwbH9oTVCBfAwgmVVpPSBoy
         8prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750336039; x=1750940839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXzG851x8092VcL5aMEVC4/pjvof2rTy3Q0YvYZaPso=;
        b=uX6frBA8587DLQJj3CYWBRe+ibnHUBbiQApsfO91SC5z3uiE0saSp0AfBdet8RWfXc
         sakiXTmiGGh3lrkxnEta1fVqVlaY9nq9jjV2uvtGYY8v+SIB2DPt5WNanIuBBvG9sGik
         WmN9QHfQ3bey7Fq0mj2NxsVU2vMm1XOF0Xc0gZIk2HQboQd47qa510lG8uNpA+hcXR2w
         y+yWCsRyUNIGV73aQaEmcvsV3s/b75lHHl/QAqWZmY27WdC9gWmQ4W9De9CYVSJtkowE
         EMwxnw4LvOZ3LjPgwQVMBv9nlZe5HW5l2ltYVMexgpWVVWGOImK92y/i5tvkOIrR0yGT
         c6MA==
X-Forwarded-Encrypted: i=1; AJvYcCWmr9aB2wyn4f/x4zA7vJ7gcPcdLYM7hF4oZK8e9nDOVte3QIETUMhrE6gRKc396m9vErHyduGUgdc=@vger.kernel.org, AJvYcCWqx0e4dbwhotxGz/ZkKdBGkbZThcgSwJ9lTNvEUUcoctiZrrjnoLBRz89BG9lI7xrTkM7troyJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyGq4VC1VhS6b3ezBS33+YQaQt9QsqIayOJWBRhFnNVQXVi8Twb
	Aj2SENJerL1Fk4tlnA9g1VAWKb6MbULPxz7Ci+sKTgj4utRWT7EPISdRDI76t3vSts7Nepa7Wfn
	reSl+kyYKBZmyK2/9CkQdyZuU1V759UZiA5h2U9MD/E0g
X-Gm-Gg: ASbGncvcFJlbV0HyrTaEzdTP3gi/TqrfsrI1FO3Xp+0d0kQ+lmsz0ZlGfxyah1FfQwD
	Hdovsew8ezjxiNUGnr3iTUyeJDUfccv9VLuHM7ctXdIG1bh6zsblTYs4Q9A6pUsYLOAHuM5ruKj
	MyAAwptw05uYxtGA35WfWRFHRz9oGnLeD+73hTLYVqPw==
X-Google-Smtp-Source: AGHT+IF1b2UgLmsiSS+z0RkWthS/dlSCcC9Pw7NBV8z1PEI8pTgd9oeFmyaIYLeABU4E561/h36S3mz0r6mmIAJgDPc=
X-Received: by 2002:a05:6402:d0e:b0:602:36ce:d0e7 with SMTP id
 4fb4d7f45d1cf-608d08658cemr18614741a12.14.1750336038738; Thu, 19 Jun 2025
 05:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511083413.3326421-1-chenhuacai@loongson.cn>
 <20250511083413.3326421-3-chenhuacai@loongson.cn> <2muq3nx6oyo3vf6qvil3oesq6luf67sjd6nxbigyxto7oxtteq@stji5xaidyye>
In-Reply-To: <2muq3nx6oyo3vf6qvil3oesq6luf67sjd6nxbigyxto7oxtteq@stji5xaidyye>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Thu, 19 Jun 2025 20:27:07 +0800
X-Gm-Features: AX0GCFtm0OAT-_i2fgZVeCmxYArFiX6-z6zBJWbX7IL5eNJ0-Wt9Gua99ll4w08
Message-ID: <CAAhV-H7VmYrs=kjFn=zaqwWfLvoGE9kVU1E9+r=OokxYddSd8A@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] PCI: Prevent LS7A Bus Master clearing on kexec
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	Jianmin Lv <lvjianmin@loongson.cn>, Xuefeng Li <lixuefeng@loongson.cn>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org, 
	Ming Wang <wangming01@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Manivannan,

Sorry for the late reply.

On Fri, Jun 13, 2025 at 3:15=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Sun, May 11, 2025 at 04:34:13PM +0800, Huacai Chen wrote:
> > This is similar to commit 62b6dee1b44a ("PCI/portdrv: Prevent LS7A Bus
> > Master clearing on shutdown"), which prevents LS7A Bus Master clearing
> > on kexec.
> >
>
> So 62b6dee1b44a never worked as intented because the PCI core still clear=
ed bus
> master bit?
Commit 62b6dee1b44a only solved the poweroff/reboot problem, because
in those cases kexec_in_progress is false and pci_clear_master() is
skipped.


>
> > The key point of this is to work around the LS7A defect that clearing
> > PCI_COMMAND_MASTER prevents MMIO requests from going downstream, and
> > we may need to do that even after .shutdown(), e.g., to print console
> > messages. And in this case we rely on .shutdown() for the downstream
> > devices to disable interrupts and DMA.
> >
> > Only skip Bus Master clearing on bridges because endpoint devices still
> > need it.
> >
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Ming Wang <wangming01@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/pci/pci-driver.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 602838416e6a..8a1e32367a06 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -517,7 +517,7 @@ static void pci_device_shutdown(struct device *dev)
> >        * If it is not a kexec reboot, firmware will hit the PCI
> >        * devices with big hammer and stop their DMA any way.
> >        */
> > -     if (kexec_in_progress && (pci_dev->current_state <=3D PCI_D3hot))
> > +     if (kexec_in_progress && !pci_is_bridge(pci_dev) && (pci_dev->cur=
rent_state <=3D PCI_D3hot))
>
> I'm not a Kexec expert, but wouldn't not clearing the bus mastering for a=
ll PCI
> bridges safe? You are making a generic change for a defect in your hardwa=
re, so
> it might not apply to all other hardwares.
I think most DMA comes from endpoint devices rather than bridges so
kexec is probably safe. When I solve the problem in commit
62b6dee1b44a I want to make a special case for Loongson but Bjorn
suggests doing a generic change, so I also do a generic change for
kexec.


Huacai

>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

