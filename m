Return-Path: <linux-pci+bounces-14551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E866799ED7A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 15:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B86C28118E
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 13:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9691FC7CB;
	Tue, 15 Oct 2024 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEUSPReO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8E61FC7CD;
	Tue, 15 Oct 2024 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998918; cv=none; b=GKJ/La6Qq92qt/P1ig3SigRzd1M8p1nioHrd0hS77vvux85nuhmMbpWtfU1w9NfbVrJZ+GUhyhEhtUiB/wirdcVjywnuxoM1pfgLST7oe1ducmJRZIXykGMGik2Xa91VZmj1gbN+CVYzgnMBr+1UQHafY1VllyC7Kz9NKHC8RwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998918; c=relaxed/simple;
	bh=/MsYg14uU18vJk0xu//Ndklki5QRzqubg0xck9g27U0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/exbYolsdIeIUebSMfmzimJa/oegD6kwT9koMT8ECMhqwreCSsANURJpMjHgtNEQ6ohWS+VABMraVHuEfkU71VyN81AS5WkZ1kFQZVKSiRZv+1omaMEu4ZKRMcn821MycusZb6jRULJ85mLQNNUqfhu0iCrUDOZPrD6zrOduVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEUSPReO; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2884e7fad77so2971240fac.2;
        Tue, 15 Oct 2024 06:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728998916; x=1729603716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWqDxWvadGC9wDLvxZmIaej9XAk5rf8fvyRWEfaKRo4=;
        b=AEUSPReOphWg5cF/JeNZHIM4mP/pUGMQI1s/CwatP7VnoCScRdlDu44/TlCowZ6Nsx
         FbNEE/3PNetm7zJbIP4bDTIyG0jbUpfJ7et36KRWynh+6+qczZs8g8sSmAEeLIEZy+H/
         +i/gzOH4CBQRdJ3lOeA7gG7BXTuIA64+gr3ADOA7GlFZLhoM2MI4hKexFdNi2Jiky2Hb
         zwsEmCL3T+0viaD2FQY2iDogzyYDjdJQvOhNyqzrC0n8AzlN/uJCMeuO1dPiayxOYifk
         ekJ3PGea4MhyBw5YSCCiTxcS5udUpv0z1MsX4QvnjiXszIUmLx1MhJvtuDAXvse4sWWj
         PNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728998916; x=1729603716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWqDxWvadGC9wDLvxZmIaej9XAk5rf8fvyRWEfaKRo4=;
        b=WHMUWW1tTMvlrIGMSgagFXYGEjZEkBXsb8JmJ/s+jpxKGrKJv5V4BpASkXF0bH6Hck
         jOQpGi/kVooDokwlbJ14EUqbjumaKkJHsymO+pQvHBwLFOOEocPQUn6bX/qdDfIpiJH+
         KfsKvERfAdfEXTZNopgYI+7/Sfz9F6ZSgzRAGm6phR2sjyRa9+aSwCA25cIsUYIsDzz7
         x0Fh4pYvy5XqOvsWJXZd3V25AIc90U1wVI5Vnh7npNlaHVqoIeBgsdoPUDEJtyGw4Flg
         eTDzhmvu4PXvYKnJepWR9LTOMJmZkg/0qve0DNR//b40xZgt4ao2cRnG4V6zzEsTAzHg
         53Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUO3gXkj0E33Z9cby3IdWtvJDz8YRkF7zCByPawC0ipAT0+iQer1D0kGdyJSMbvf9qUx9pGgrPG/NDHrBo=@vger.kernel.org, AJvYcCWO4+A4kOj5u9USCwhkA62wyzJ3aQBY8O/8z7AyhYS7o1WHxuR0r/yIoXZDWSWKDUvh/SQ+W7PWaWiZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyepVKsuudowgPUg7mOEoUSTSFWGTyHdb97fuHZSeF7aNop7Vtk
	NyWDQeXXrYfyaYIFrXLCqwLxWIIKeWYbvkSJN2T9b0N+1pk6+zq/Q/1OgK0lN02SEOJbwb2sLi0
	6akUtlDLrPEbxxgh6kOirVGi9vDM=
X-Google-Smtp-Source: AGHT+IFq5fDn8nTrIwaQuJIlwbgEPSS6kplgVvXk88bZhmCkCgxZuKJP9hkf4XPeEazNKkgpfWnEYXf6QBIwrI+OjJ4=
X-Received: by 2002:a05:6870:1ecf:b0:287:3d2f:468c with SMTP id
 586e51a60fabf-288edfd2cb8mr240159fac.30.1728998911656; Tue, 15 Oct 2024
 06:28:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014135210.224913-1-linux.amoon@gmail.com>
 <20241014135210.224913-3-linux.amoon@gmail.com> <20241015051141.g6fh222zrkvnn4l6@thinkpad>
 <CANAwSgSEkFtY6-i3TOPZbwB5EuD4BHboh_jsTwByQw7NLLrstQ@mail.gmail.com> <20241015125945.llbyg6w7viucw5rh@thinkpad>
In-Reply-To: <20241015125945.llbyg6w7viucw5rh@thinkpad>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 15 Oct 2024 18:58:15 +0530
Message-ID: <CANAwSgRxNoZ2NuYZq47+SweF4oQSDHjJXDYdywOAnJpDuGPUEw@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] PCI: rockchip: Simplify reset control handling by
 using reset_control_bulk*() function
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>, 
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manivannan,

On Tue, 15 Oct 2024 at 18:29, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Oct 15, 2024 at 02:30:23PM +0530, Anand Moon wrote:
> > Hi Manivannan,
> >
> > Thanks for your review comments.
> >
> > On Tue, 15 Oct 2024 at 10:41, Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Mon, Oct 14, 2024 at 07:22:03PM +0530, Anand Moon wrote:
> > > > Refactor the reset control handling in the Rockchip PCIe driver,
> > > > introduce a more robust and efficient method for assert and
> > > > deassert reset controller using reset_control_bulk*() API. Using th=
e
> > > > reset_control_bulk APIs, the reset handling for the core clocks res=
et
> > > > unit becomes much simpler.
> > > >
> > > > Spilt the reset controller in two groups as per the
> > > >  RK3399 TM  17.5.8.1 PCIe Initialization Sequence
> > > >     17.5.8.1.1 PCIe as Root Complex.
> > > >
> > > > 6. De-assert the PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESE=
T_N
> > > >    simultaneously.
> > > >
> > >
> > > I'd reword it slightly:
> > >
> > > Following the recommendations in 'Rockchip RK3399 TRM v1.3 Part2':
> > >
> > > 1. Split the reset controls into two groups as per section '17.5.8.1.=
1 PCIe
> > > as Root Complex'.
> > >
> > > 2. Deassert the 'Pipe, MGMT Sticky, MGMT, Core' resets in groups as p=
er section
> > > '17.5.8.1.1 PCIe as Root Complex'. This is accomplished using the
> > > reset_control_bulk APIs.
> > >
> > > > - devm_reset_control_bulk_get_exclusive(): Allows the driver to get=
 all
> > > >   resets defined in the DT thereby removing the hardcoded reset nam=
es
> > > >   in the driver.
> > > > - reset_control_bulk_assert(): Allows the driver to assert the rese=
ts
> > > >   defined in the driver.
> > > > - reset_control_bulk_deassert(): Allows the driver to deassert the =
resets
> > > >   defined in the driver.
> > > >
> > >
> > > No need to list out the APIs. Just add them to the first paragraph it=
self to
> > > explain how they are used.
> > >
> >
> > Here is a short version of the commit message.
> >
> > Introduce a more robust and efficient method for assert and deassert
> > the reset controller using the reset_control_bulk*() API.
> > Simplify reset handling for the core clocks reset unit with the
> > reset_control_bulk APIs.
> >
> > devm_reset_control_bulk_get_exclusive(): Obtain all resets from the
> >             device tree, removing hardcoded names.
> > reset_control_bulk_assert(): assert the resets defined in the driver.
> > reset_control_bulk_deassert(): deassert the resets defined in the drive=
r..
> >
>
> How about,
>
> "Currently, the driver acquires and asserts/deasserts the resets individu=
ally
> thereby making the driver complex to read. But this can be simplified by =
using
> the reset_control_bulk APIs. Use devm_reset_control_bulk_get_exclusive() =
API to
> acquire all the resets and use reset_control_bulk_{assert/deassert}() API=
s to
> assert/deassert them in bulk.
>
> Also follow the recommendations provided in 'Rockchip RK3399 TRM v1.3 Par=
t2':
> ..."
>
> - Mani

Sorry for the trouble,.
Yes, I will try to incorporate your suggestions

Thanks
-Anand
>
> > Following the recommendations in 'Rockchip RK3399 TRM v1.3 Part2':
> >
> > 1. Split the reset controls into two groups as per section '17.5.8.1.1 =
PCIe
> > as Root Complex'.
> >
> > 2. Deassert the 'Pipe, MGMT Sticky, MGMT, Core' resets in groups as per=
 section
> > '17.5.8.1.1 PCIe as Root Complex'. This is accomplished using the
> > reset_control_bulk APIs.
> >
> > Does this look good to you? Let me know if you need any further adjustm=
ents!
> >
> > I will fix this for CLK bulk as well.
> >
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > >
> > > Some nitpicks below. Rest looks good.
> >
> > I will fix these in the next version.
> >
> > > - Mani
> > >
> > > --
> > > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D
> >
> > Thanks
> > -Anand
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

