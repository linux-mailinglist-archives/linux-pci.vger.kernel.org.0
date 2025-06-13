Return-Path: <linux-pci+bounces-29791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA53AD976C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 23:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A1E189E0C7
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 21:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9681C28C02C;
	Fri, 13 Jun 2025 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LcRNuALu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80741E8338
	for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 21:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749850854; cv=none; b=g6DcZ6jjrnN7VuX2GToV/ynUyZ0AE3M+sSa94DgQw2Tlb7GMQyfabP1fLoIn0Vs0h3Dfzrm+a0WY0i0OJdWz8fL0I+EyhsxO03UDszGcDNH2li2u/xHha3Quf1HyLuWUiHwy3Z86YrkaxzJaTJBfTHwlkiaeiMI82qsmuGpLwkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749850854; c=relaxed/simple;
	bh=ZcoeBl1oYujZAp6bxXAb2ArnZ8wEspzdPox2tOMOAVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PhDR3whfD+8BCHTjce8TKl5Sk+pnPBEEg9CXcLTvzEDXR10ApuTax1pKrCtSwgk47vRbePDNyI0NyioTSfV5r9udKn0K4aVXkmez20XsV+Q4Gd7STewoPDQQ6ajbLbfwOSA6p2K2mhjueVvF9fpdHNnqusX1X9LES/ifUHb//7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LcRNuALu; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a58ef58a38so53771cf.0
        for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 14:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749850852; x=1750455652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JM2Ts82lf5QQvFrV+s/2evWQljauh/bsNUGeUyNRzHU=;
        b=LcRNuALugPaCbh5j7w1f5jaLJeU25rtU58LC28ZkS68MrBNrpdkwZMn6jCDgdVEma9
         7xBZgrK8OjSDbbOaUt0NuRs4iF7mQ6HpcmMQMzvd+qbqfzHo6/GxChuaGLiF82JJIvN1
         LlN4gnXqaKz2gSiXCogpy+tV+pXHWA/DE7P7YjbQEKVka7+/IKDHWclqk5+zmz1LkDsw
         VT+8i6b1q6LZJTN2uAU2gJby0Ign9CDiJdaXarsnkIi+g7H44DD4PnOQIojs6Q8lOQi2
         qCNKvCvJDT0IyOx5uiFo6zalU92UWe/I2QJCaQt/QZq542MFaJyErB91Jv3KKBOELP9+
         vGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749850852; x=1750455652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JM2Ts82lf5QQvFrV+s/2evWQljauh/bsNUGeUyNRzHU=;
        b=DW9wmL7TeQvJ//8NzmYETXw+5OxEM8oiA019mlygJliKUuUvy/3C1pPcavSY/+TXrE
         W4A6lm5dQjZqpo7DWAF7OOJ4+zUFFlE9sN6zoObGz/+fzJYcloAJxVtI94CeFe02tp7E
         K9X5Br9UDx3bgJO/ua7VxG/h4zGIUaRmRsux435vpjrjGQaRx0/neG9wiyD4cyOrV77I
         4Xgw+udivlPT9Pgc5820uayRH1sGjSUe2VWWee7SMIZnqyQ/UJx9hoct/a0iRzTtnCF9
         FXfJ2dKUlwQyD62OE9aRXc0bRPJqs657a13mcNGt4Z1ulGidtPwt8sUKp2Wh4dkiZHNj
         UDpw==
X-Forwarded-Encrypted: i=1; AJvYcCWbxmCRmy5KFjsfFf4Ukpw4+Sz1T2P8GKKKV82xKhdZ6dfrCq0LdzkWkGaTCEHbeqSadauJ3WgwsMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzs3FwKMpflcvcx5Nfa8zZndLFINsVs9RdaZQEwlO4xsPQLd+u
	t2zbdmKEIqeRm+ADEmjhIyZstwVodY7scgrgZsOUlsBqq/eGcYo+7avJJ7U1I6r2Hob/sNSdv+G
	rGizgZOItSmffAKUBY9RPGlaDjgXBNf8bmFmYxFKn
X-Gm-Gg: ASbGncvMzOhvKrYsNTwJPpJ6siVCSh4oHLGR+6Dn9Du9nNRXG3jvIlEWmeShSKTWC3c
	8NtIFkU+97NAb26bfaUtaIpsqjG6WEwvFjbB0iRoTqqnxz51NmV7Kr2RhqwnbVYFYqvkeo/62lg
	qkRdUcvaA6MO0DTF7FGHhYLQ2QnKkF1RudCTyS5Xz2ieEyloAdr5eUdbKgjQamtjMRfBs23p4jw
	0bU
X-Google-Smtp-Source: AGHT+IG1idNpNGEh1fsqXcIdT6pKKaSZNTI8gzltM9eiWquOgOiErFBOQySl4sbq198P8GJJ+W4YyiKJNaw+aMDYCFo=
X-Received: by 2002:ac8:5707:0:b0:480:dde:aa4c with SMTP id
 d75a77b69052e-4a73d613ef7mr570401cf.4.1749850851523; Fri, 13 Jun 2025
 14:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507232919.801801-1-ammarq@google.com> <56cc4h6daxofmooafh2ifquwtf37jajuaed7otdmkhozfnawz4@5zon6ttwegqf>
In-Reply-To: <56cc4h6daxofmooafh2ifquwtf37jajuaed7otdmkhozfnawz4@5zon6ttwegqf>
From: Ammar Qadri <ammarq@google.com>
Date: Fri, 13 Jun 2025 14:40:40 -0700
X-Gm-Features: AX0GCFs5j8js_AAU9D3E_39hMGItksLQLbdYIFR-SkVPVUr1wCAoLUTCmNHTdbA
Message-ID: <CAFbbpayW+y8s3i4qxzHcoY0Yz5qeAhb7ziey=FayDiZbC_mm7w@mail.gmail.com>
Subject: Re: [PATCH] PCI: Reduce verbosity of device enable messages
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mani,

The issue we are experiencing is not caused from removing/reattaching
the device driver, so the other messages have not been problematic.

The vfio-pci driver is attached to each VF once. Clients in our system call
open and close on the vfio-pci driver, respectively, at the start and
end of their use,
with fairly short-term tenancy, which ends up triggering these enable messa=
ges.
This message is proving challenging not only because they are not particula=
rly
useful,  but because they are causing log files to rotate once every 30 min=
utes
or so, and we lose a lot of other more valuable logging as a consequence.
I'm open to other solutions, but in my opinion this preserves the message,
without over-engineering and introducing throttling or other behaviour.


On Thu, Jun 12, 2025 at 11:12=E2=80=AFPM Manivannan Sadhasivam <mani@kernel=
.org> wrote:
>
> On Wed, May 07, 2025 at 11:29:19PM +0000, Ammar Qadri wrote:
> > Excessive logging of PCIe device enable operations can create significa=
nt
> > noise in system logs, especially in environments with a high number of
> > such devices, especially VFs.
> >
> > High-rate logging can cause log files to rotate too quickly, losing
> > valuable information from other system components.This commit addresses
> > this issue by downgrading the logging level of "enabling device" messag=
es
> > from `info` to `dbg`.
> >
>
> While I generally prefer reduced verbosity of the device drivers, demotin=
g an
> existing log to debug might surprise users. Especially in this case, the =
message
> is widely used to identify the enablement of a PCI device. So I don't thi=
nk it
> is a good idea to demote it to a debug log.
>
> But I'm surprised that this single message is creating much overhead in t=
he
> logging. I understand that you might have 100s of VFs in cloud environmen=
ts, but
> when a VF is added, a bunch of other messages would also get printed (res=
ource,
> IRQ, device driver etc...). Or you considered that this message is not th=
at
> important compared to the rest?
>
> - Mani
>
> > Signed-off-by: Ammar Qadri <ammarq@google.com>
> > ---
> >  drivers/pci/setup-res.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> > index c6657cdd06f67..be669ff6ca240 100644
> > --- a/drivers/pci/setup-res.c
> > +++ b/drivers/pci/setup-res.c
> > @@ -516,7 +516,7 @@ int pci_enable_resources(struct pci_dev *dev, int m=
ask)
> >       }
> >
> >       if (cmd !=3D old_cmd) {
> > -             pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd=
, cmd);
> > +             pci_dbg(dev, "enabling device (%04x -> %04x)\n", old_cmd,=
 cmd);
> >               pci_write_config_word(dev, PCI_COMMAND, cmd);
> >       }
> >       return 0;
> > --
> > 2.49.0.987.g0cc8ee98dc-goog
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

