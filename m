Return-Path: <linux-pci+bounces-42684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D32FFCA76A0
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 12:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 256EA38D6090
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 08:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CE9345CA1;
	Fri,  5 Dec 2025 08:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhQbPuVn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADABE2745C
	for <linux-pci@vger.kernel.org>; Fri,  5 Dec 2025 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764921720; cv=none; b=s2+wZNbtpCPr6Wv5o7eFruPvxZCV6dNpr22Eb2n1LJtzaRDubFgGbaPaa9V6SOt18X5RDDvyBa97EYRuc81P63V2YV0GcNctPxJSR2Ar3IThjDed3LXbcT/aXHMyamO5T6hxq967k3LYaMIwZ6N6ulyqmmtoQSxjWNt5i2kSWqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764921720; c=relaxed/simple;
	bh=n46m8YV1SPjqmDDDhBwIkPV1tptJLwOdSlnleFqOCts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgE7wMcmu8XmrR4R4cMdaxAUXHAo8EoaeaLLSUxCmWGfrtSN5wY5TgIErZ0iOZlnmrNgqrmZKgrax6CBSTTExpT9YWlcAKRQsg6DhaTAH3dS9Iu9DZdq+dw3nT2cwJWsSr4X/gINWjFV99AVINqs7KGcMmS87VIYN53ulyEI5yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhQbPuVn; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64162c04f90so3488684a12.0
        for <linux-pci@vger.kernel.org>; Fri, 05 Dec 2025 00:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764921707; x=1765526507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZqjFJmgsvyAV8OLMiyLDL43e0L9PCAK+2slIeGx9Dk=;
        b=EhQbPuVnNh9vj8+CtutnsmC08QiCfNWGB9D0ufGxvZpiAZajwB+NYgcB9zfWRh33kx
         Eia6+RlF6MF3v4g9NnvZYu4wDbrfHZVSlRoORLCZc2a0XTwrvxPWLai4LNbGfNzWqIuo
         1ZynycFQW/XXcq8cVzpygMV++fDpivSc6TEHWFzB5nUjOUSDK7fY5vfNAWvqaAZyPkOP
         nx6K1avM6hb2BL1odIfm0Bh4Ud/w9FWBS4KXhYWJvzxrq5yBOD3O8qQBt7AIlzlZy7z2
         3d/6hceM5c43MKNTUfRh7XxsvjucuT3/1ZAlG11tBBeSYBvScu7bKthya9sMU80CcotV
         c5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764921707; x=1765526507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jZqjFJmgsvyAV8OLMiyLDL43e0L9PCAK+2slIeGx9Dk=;
        b=Y+JQQqiISujJL9sLzV1R0zaqQBwrvM1YMq0nEkiSILzY7qzljzi1FWiBXfoPgVUH+q
         U72Z4U/ujnSxbArpfkszAFgpq9kJliqIUNydeLvDcy3S9W9r2KYnFgQWjzCsSexYmVMd
         ECjBYGfgKQoXs3DGI9P7/Iohyp4sPRuz5R/xVFeE2ZVdnGfu8lvitRewlQSueKvcWFIw
         0HCtBZjxbiWjDF3Zcec7rCey0ezlI1FlgIXryyBcdRMZDvb08cWYM3I2IoV+hSERZEWM
         lQzL36vaJPxk5ur0QzcE78qDpL8C5R70wN36RU5ymzSqjm7STH9gLZ3ZltGJpXLMDq52
         /Vcg==
X-Forwarded-Encrypted: i=1; AJvYcCUyfxYV4106lTpdPTXwlo88g/aBJ88Epkn13DOLSTMc/Nn1SzsqrTEX/Y8MI13ITh9ZALC2ABB+blo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysjqk+SmoYHIPSws4F4MwhoGxSrsY9jiF3JcmbHIfGa6Q157nJ
	NxXhv/mdc50bu3e5F8HUnR9yMP4Gj7IBp50qrL2kYhgH3S2LH9BkxowYRmceu7ETjCLgDtvA9eQ
	EqPH+XBryq74F0t8WlhcQASBks/e6TEU=
X-Gm-Gg: ASbGncu57CEbZGvO+yqSS5oHapstRgF16BEvg5O8RpF3tuzMvhXwaAgP1Fc+lH+hzPw
	yoiRRFOtgE7r4XMN1hlcT19hlbIkCce7HH9rpCA/sNavQVbyoXUZloZYNAb1Bj3HADHNiDCTXoo
	PNPrV7UUM7DTOulNgGA2swRDXEMIwJrXUSyyT5H+ow6EQdPig5C9BEE4v+JlCbGqH1cUgaqfXry
	tbDERfCbeGsZVrI7P+V0R/+u/YhVdefTIXbtynwnuZLYvdn7GYn37kLrXVFLfBpup04Yg==
X-Google-Smtp-Source: AGHT+IFE6UJtYE9mIS1oruoEjp4qDr83WNERh/nzYDna+THuvhPLJ9HPxcLjvEK47v4D3XzW4tAm0F6Bv4lRC3CXaA8=
X-Received: by 2002:a05:6402:518b:b0:641:66cc:9d91 with SMTP id
 4fb4d7f45d1cf-6479c519e8bmr7371624a12.27.1764921707253; Fri, 05 Dec 2025
 00:01:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125075604.69370-1-hal.feng@starfivetech.com>
 <20251125075604.69370-5-hal.feng@starfivetech.com> <CANAwSgQSBB_yTw5rDz2w6utvjUueWJi9tWUY9oZcpNAT8Wm8iA@mail.gmail.com>
 <ZQ2PR01MB13076311CBBFE5B948F394FCE6A72@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
In-Reply-To: <ZQ2PR01MB13076311CBBFE5B948F394FCE6A72@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 5 Dec 2025 13:31:30 +0530
X-Gm-Features: AQt7F2rB8dLMd_Fit7Ps6bUhIfDS-utXO0oh0y7DDayDYIxfnNEaF0b56EOtKqo
Message-ID: <CANAwSgTUqGcwcy_VBgttmzRs+v9Tp2fET43gFb=SiiFLxm2-Fg@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] riscv: dts: starfive: Add common board dtsi for
 VisionFive 2 Lite variants
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, E Shattow <e@freeshell.de>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hal,

On Fri, 5 Dec 2025 at 13:11, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> > On 05.12.25 01:05, Anand Moon wrote:
> > Hi Hal,
> >
> > On Tue, 25 Nov 2025 at 13:27, Hal Feng <hal.feng@starfivetech.com> wrot=
e:
> > >
> > > Add a common board dtsi for use by VisionFive 2 Lite and VisionFive 2
> > > Lite eMMC.
> > >
> > > Acked-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > > Tested-by: Matthias Brugger <mbrugger@suse.com>
> > > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > > ---
> > >  .../jh7110-starfive-visionfive-2-lite.dtsi    | 161 ++++++++++++++++=
++
> > >  1 file changed, 161 insertions(+)
> > >  create mode 100644
> > > arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi
> > >
> > > diff --git
> > > a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi
> > > b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi
> > > new file mode 100644
> > > index 000000000000..f8797a666dbf
> > > --- /dev/null
> > > +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.=
d
> > > +++ tsi
> > > @@ -0,0 +1,161 @@
> > > +// SPDX-License-Identifier: GPL-2.0 OR MIT
> > > +/*
> > > + * Copyright (C) 2025 StarFive Technology Co., Ltd.
> > > + * Copyright (C) 2025 Hal Feng <hal.feng@starfivetech.com>  */
> > > +
> > > +/dts-v1/;
> > > +#include "jh7110-common.dtsi"
> > > +
> > > +/ {
> > > +       vcc_3v3_pcie: regulator-vcc-3v3-pcie {
> > > +               compatible =3D "regulator-fixed";
> > > +               enable-active-high;
> > > +               gpio =3D <&sysgpio 27 GPIO_ACTIVE_HIGH>;
> > > +               regulator-name =3D "vcc_3v3_pcie";
> > > +               regulator-min-microvolt =3D <3300000>;
> > > +               regulator-max-microvolt =3D <3300000>;
> > > +       };
> > > +};
> >
> > The vcc_3v3_pcie regulator node is common to all JH7110 development
> > boards.
> > and it is enabled through the PWREN_H signal (PCIE0_PWREN_H_GPIO32).
> >
> > VisionFive 2 Product Design Schematics below [1] https://doc-
> > en.rvspace.org/VisionFive2/PDF/SCH_RV002_V1.2A_20221216.pdf
> >
> > Mars_Hardware_Schematics
> > [2] https://github.com/milkv-mars/mars-
> > files/blob/main/Mars_Hardware_Schematics/Milk-
> > V_Mars_SCH_V1.21_2024-0510.pdf
>
> No, GPIO32 is connected to the WAKE pin, it is not used to control the PC=
Ie slot power.
>
Ok, GPIO32 is used for pcie0 (PCIE0_PWREN_H_GPIO32)
Only PCIE0 supports power for the 4-port USB ports.

As per VisionFive 2 Single Board Computer Quick Start Guide
USB30 4 =C3=97 USB 3.0 ports (multiplexed with a PCIe 2.0 1x lane).

> Best regards,
> Hal

Thanks
-Anand

