Return-Path: <linux-pci+bounces-11391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E9E9499B3
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 22:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715581F21B9F
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 20:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EE115B55E;
	Tue,  6 Aug 2024 20:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZPLbccxC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD6915573A
	for <linux-pci@vger.kernel.org>; Tue,  6 Aug 2024 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977917; cv=none; b=h/y0nQdvgeBpjQ6Dq6AzRduYZtwbjYD/f0Ikg5BXc1p7cFBIHevHAlRsiiCsUjsjSlQRALvZJ40NxS5wa33ub9lf5ZH6ZhhIHw8Jk4DKR+vBHwkCWQaoiLN1/GkCxVg684+AwCGorjL8bQWxJCloMcaBc6XmbDVHiRk9XUN9LRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977917; c=relaxed/simple;
	bh=nZfAx0s+w4iQejbkZTuFHn4biuzda0IB96F9dYK6Csc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXvOgyp8IZh3k9qkPrv6AL3Kzer5orNhLxHCIziyjtYlMvGN/5HFPnI4JkRpckJV7aladHVAnCBzvQN63Lv8tbbjS7SOaXHIlcPxdU8KjzYD4oNIHv9V86XbiVMoOjgfHQdiE1ieU0qJtY1/QDw3JVjuLuHWBhHTyEFfF0tjkdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZPLbccxC; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bba25c1e15so308237a12.2
        for <linux-pci@vger.kernel.org>; Tue, 06 Aug 2024 13:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722977914; x=1723582714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xvQ8q70+jopmdmtVnSXHJgxWGZAdLdmRhj5/9vncUA=;
        b=ZPLbccxC/nM00JL0ImqO6bB77shnm6JI5c5IVZ2BJyJ63HhAmqH80leytbCMdhoDGV
         SQT18Xx17Fj5TM7QFcWezOksKYLW48bL7wke5MqEgcCUmuf3hK5/Yq5oyfCZftKFB7rl
         HUtCrVmMcRoVMYeTXRFUkgoKLpGRDhyvUxlu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722977914; x=1723582714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xvQ8q70+jopmdmtVnSXHJgxWGZAdLdmRhj5/9vncUA=;
        b=fkT76bgdM7oxY/GJi9plPkK7Z2DRfnWCBQ9GAWYF7swasYf77KCfDisL8wdA+sNfkJ
         QjfAQq5IkrOnl3uHehMFo69S4/S7vwoRugSUEheqJ9a2Do37ddjUuocmd5bOR5l6+n1s
         6EjPnuAbcEi1tVH3GlvKM3jEUWHLeDmw6BsvYdgsvHODmWc4ySVW769/2M1grdWlYiP3
         lA7MQeV4ZiHaVDu+z/JPnDt8bfImR0I22DxdJl/s87H+HaFvTuPbyNQ4npw4gztOfn7n
         msz2tW+Ew6fE92jiQDPugF6WljkwQNd+A/t5/S8Gqu0X1ExrDLhfC/hO4IT5iGvtPKsI
         Tkvg==
X-Forwarded-Encrypted: i=1; AJvYcCU2E20ccG4L4MZDc5M/fA28pzgcXnfn+wen3H68Y+WfPAWfZlnRW1btjlnybUGEjkzd3CoS4T2WO1xewvXp6TKxAwUWlcCiGilj
X-Gm-Message-State: AOJu0YwGS7APA4ATN8Cq5ej1ILEeG+d1jI4bODB1oO7LuUkQEBLCt+fG
	pPnt+3b0WjQwEAlfI7YaRiwS/z6ECl+wh1hMp3Zz5PrmZpqwTQo07L3VIsHOmW8K5nOlS7o4AWz
	JxxA+9ruOrUZeoAs0EYsZYCSw1UhJlFcttB3F
X-Google-Smtp-Source: AGHT+IEJSf52pY9j4pFPa4o6S67GFeLCHb6GBBPZf0aUJS5SUKeqMkhnpPp+zqohQkLtvrPq77O/VHzn/qsa/j3fBX0=
X-Received: by 2002:aa7:c2c5:0:b0:5bb:9aff:3e27 with SMTP id
 4fb4d7f45d1cf-5bb9aff3f07mr1686710a12.37.1722977914233; Tue, 06 Aug 2024
 13:58:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
 <20240802-pci-bridge-d3-v5-4-2426dd9e8e27@linaro.org> <ZqyxS8spZ-ohsP3R@wunner.de>
 <20240805133555.GC7274@thinkpad> <ZrHITXLkKrDbQKQp@wunner.de>
 <20240806124107.GB2968@thinkpad> <ZrIe70Z7uFven8HH@wunner.de> <20240806143918.GC2968@thinkpad>
In-Reply-To: <20240806143918.GC2968@thinkpad>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Tue, 6 Aug 2024 13:58:07 -0700
Message-ID: <CAJMQK-g6fM-MODqniNFMZ4hg28zE6eCeYzwZbNjy5_HtR3c9DA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] PCI: Allow PCI bridges to go to D3Hot on all
 Devicetree based platforms
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	mika.westerberg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 7:39=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Aug 06, 2024 at 03:02:39PM +0200, Lukas Wunner wrote:
> > On Tue, Aug 06, 2024 at 06:11:07PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Aug 06, 2024 at 08:53:01AM +0200, Lukas Wunner wrote:
> > > > AFAICS we always program the device to go to D3hot and the platform
> > > > then cuts power, thereby putting it into D3cold.  So D3hot is never
> > > > skipped.  See __pci_set_power_state():
> > > >
> > > >   if (state =3D=3D PCI_D3cold) {
> > > >           /*
> > > >            * To put the device in D3cold, put it into D3hot in the =
native
> > > >            * way, then put it into D3cold using platform ops.
> > > >            */
> > > >           error =3D pci_set_low_power_state(dev, PCI_D3hot, locked)=
;
> > > >
> > > >           if (pci_platform_power_transition(dev, PCI_D3cold))
> > > >                   return error;
> > > >
> > >
> > > This is applicable only to pci_set_power_state(), but AFAIK PCIe spec
> > > doesn't mandate switching to D3Hot for entering D3Cold.
> >
> > Per PCI Bus Power Management Interface Specification r1.2 sec 5.5 fig 5=
-1,
> > the only supported state transition to D3cold is from D3hot.
> >
> > Per PCIe r6.2 sec 5.2, "PM is compatible with the PCI Bus Power Managem=
ent
> > Interface Specification".
> >
> > Granted, PCI-PM is an ancient spec, so I think anyone can be forgiven
> > for not knowing its intricacies off-the-cuff. :)
> >
>
> Ah, the grand old PCI-PM... I don't remember the last time I looked into =
it :)
>
> >
> > > So the PCIe host controller drivers (especically non-ACPI platforms)
> > > may just send PME_Turn_Off followed by removing the slot power
> > > (which again is not controlled by pci_set_power_state())
> > > as there are no non-ACPI related hooks as of now.
> >
> > Ideally, devicetree-based platforms should be brought into the
> > platform_pci_*() fold to align them with ACPI and get common
> > behavior across all platforms.
> >
>
> Yeah, that would be the ideal case. Unfortunately, there is no ideal grou=
nd for
> DT :/ We do not even have the supplies populated properly. But with the a=
dvent
> of power sequencing framework, I think this can be fixed.
>

Looking in acpi_pci_bridge_d3(), it has several checkings about
whether d3 is supported, including reading power_manageable flag
(acpi_device_power_manageable) and reading the root port property.
For DT, does it make sense to have a chosen property about this?

> Regarding your comment on patch 3/4, we already have the sysfs attribute =
to
> control whether the device can be put into D3Cold or not and that is dire=
ctly
> coming from userspace. So there is no guarantee to assume that D3Hot supp=
ort is
> considered.
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

