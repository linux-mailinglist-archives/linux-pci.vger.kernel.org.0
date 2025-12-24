Return-Path: <linux-pci+bounces-43648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 980AECDBA2B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 09:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 200DE3010FCD
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 08:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEF52D3221;
	Wed, 24 Dec 2025 08:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHdvNRe9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CAC26158B
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 08:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766563484; cv=none; b=rE5t2g4OWwwICThXLw+TE1dOJmbLN+w7K0iqmEKGsagNVkPmy7FcEm4S7rAd9Q+PRslgEPSO+9TsbfrSQVzI4xb7zlTiObY0wLmE+vwuthXiR2MZ8k0PpvssvyOlS3QnVpancZxfnp3hyfn0Nlmxh2G8dyRnblrMBxIrBhl0Vj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766563484; c=relaxed/simple;
	bh=+TfuYlLvMaLWTZmZDZsnA49hO+ryorTTCnTkX2pKAFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSv+74M7sgbvTTF/EZMucscKdcmmEsGZiIqopKNvHQhk2OOID7yoL2x2CBt9GW+8kba+SDhB7IUa4uYHtTxTfqWKJj01E4naejQeXdRLtNa00+ob+iHcOveh42NRE9SsiaRqYMiksB8JxyEmVdkYfN/tmLog6pjBEa8AtLg3c/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHdvNRe9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64951939e1eso8645192a12.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 00:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766563481; x=1767168281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TfuYlLvMaLWTZmZDZsnA49hO+ryorTTCnTkX2pKAFY=;
        b=eHdvNRe9hkZqROWeFuDWFlc5wcSJy9zW490I34GWsdhhSgtxAcFToSHsGJwgFg2raq
         AnwMicqHza3dD0uHLZDzYR1Ynjvk9FO5bpodkKYRMSWaffXnRwLnsGesRV9Iufl/Gm6W
         0iCJD8fXjchWI9LyVnjjC9LoXNrJFkiTaNu00Ejb63kqZjpiMAiM0doIk9ti9XlQKb9z
         5HEK0fNHFPD+PSYcYR4PccovDC7H22IZcQ4hsJjJVhG7MaH7tMc2cV5OoqT430ms53tZ
         46eClMPO6msk1+4d2SDonlXKPegBIl/OHaZMdWXTWjAPmHHaAONMLd6M7pw8OOa5HmKq
         Q2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766563481; x=1767168281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+TfuYlLvMaLWTZmZDZsnA49hO+ryorTTCnTkX2pKAFY=;
        b=VdDzQ8Qv4E+usaZpJe8GEW+kHXN+G+YcUYOqUHGqaNQOKX5vGPsGDnP/WLAi7bvy6U
         LoN8xPWbg8H5qLmeaNwJ+Rio2j+jMbiX2S6X5PIIZ8k8fX6X1qyv9ro6a7GL06ID9GaX
         y5E/knQOLO74ttRtjjgeQhRCqGdaptqYi4aeLTLp1BNHGkEy1yWzKWO1af2OfzJAGVcC
         D2TmXsbOrZZRRMmkXxTvwzwmtRgR7LfimGuzuhA4XzXXVZxm2oabYBlq3hpKyVijJ9yv
         5R6vX+wqi0KkA8m5mW8191ji1ZNQhEpO3QgB6J/OEyMZkshlCljmwNESSePD/z2xoCam
         7kPg==
X-Forwarded-Encrypted: i=1; AJvYcCUH+rvJLhr2Ca05jbbKPUkXQi9BGCwswc1HAAQRXXqFcAuIfUHEq1sxXlIBEZzdj8fX7IeNRSWo74k=@vger.kernel.org
X-Gm-Message-State: AOJu0YySKiKgrJTp1iHUdMJlBQG3bI55+XjonAcBiswYQqXW1dJlPxh7
	/d6ypwEk7+ov99RJM1kNQ6RuXlgybWZhH9Chlmk/hrqYotZiK6kBPTlOMA167BNWol8IIg91rl9
	5uQp08m2oRIH4Fm/hbDttgAl8N/qNDSs=
X-Gm-Gg: AY/fxX7rcmv9zIwHryNQM8WtJVhHeC/RIRTrRr6UUMPnwGyyyEK/OCr73X/mMtpra+J
	kwbot5CfrI3jNVOX+cYB+4M2Xo05Scp/d0KOP2Wq042bQFtAmkdzVkM8DwNzxHsbh5QnpMCiVC4
	/1j3qUpFdQ9fjEehTpgq2kv3GWVUUH+OB4WIpnJqIasxFcMCBOAUCxq+dPtuP3J+1hPqeyKgMj3
	/4lJavIzxk+Be2xnkfhtgvecBvFTspZdMnjJ2mrAFkFF7tyR8vjJSkU2bAKpOfZ3VM=
X-Google-Smtp-Source: AGHT+IFNXz2QU01SE+DL2c1ZCqqAJiAT079DS2+XmSlL7nM5RGPoflTCsCJq7MHCePPbrmgdDllZFgH4/zk85C3yl5w=
X-Received: by 2002:a05:6402:50cc:b0:64d:4a01:fc23 with SMTP id
 4fb4d7f45d1cf-64d4a020dfamr9289029a12.10.1766563480975; Wed, 24 Dec 2025
 00:04:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763415705.git.geraldogabriel@gmail.com>
 <eaa9c75ca02a53f8bcc293b8bc73d013e26ec253.1763415706.git.geraldogabriel@gmail.com>
 <CANAwSgQ726J_vnDKEKd94Kq62kx8ToZzUGysz4r3tNAXvfAbGA@mail.gmail.com> <CAEsQvctSY7-RQEQF2TmJU2qKPZOe9TC5g-7Jat0LQKRHYz_6dQ@mail.gmail.com>
In-Reply-To: <CAEsQvctSY7-RQEQF2TmJU2qKPZOe9TC5g-7Jat0LQKRHYz_6dQ@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 24 Dec 2025 13:34:23 +0530
X-Gm-Features: AQt7F2qzfCdogAfkIVvQ40sYz72XmKQPz1kBLtv40YPxaEuaYu_edJzXc4ZwP9s
Message-ID: <CANAwSgQPQUBi6VVb+hZNraMt71vnRpki+YK_at=Luo4aPVtOPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PCI: rockchip: limit RK3399 to 2.5 GT/s to prevent damage
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Jonker <jbx6244@gmail.com>, Dragan Simic <dsimic@manjaro.org>, 
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geraldo,

On Wed, 24 Dec 2025 at 11:08, Geraldo Nascimento
<geraldogabriel@gmail.com> wrote:
>
> On Wed, Dec 24, 2025 at 2:18=E2=80=AFAM Anand Moon <linux.amoon@gmail.com=
> wrote:
> >
> > Hi Geraldo,
> >
> > On Tue, 18 Nov 2025 at 03:17, Geraldo Nascimento
> > <geraldogabriel@gmail.com> wrote:
> > >
> > > Shawn Lin from Rockchip has reiterated that there may be danger in us=
ing
> > > their PCIe with 5.0 GT/s speeds. Warn the user if they make a DT chan=
ge
> > > from the default and drive at 2.5 GT/s only, even if the DT
> > > max-link-speed property is invalid or inexistent.
> > >
> > > This change is corroborated by RK3399 official datasheet [1], which
> > > says maximum link speed for this platform is 2.5 GT/s.
> > >
> > > [1] https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Dat=
asheet_V2.1-20200323.pdf
> > >
> > To accurately determine the operating speed, we can leverage the
> > PCIE_CLIENT_BASIC_STATUS0/1 fields.
> > This provides a dynamic mechanism to resolve the issue.
> >
> > [1] https://github.com/torvalds/linux/blob/master/drivers/pci/controlle=
r/pcie-rockchip-ep.c#L533-L595
> >
> > Thanks
> > -Anand
>
> Hi Anand,
>
> not to put you down but I think your approach adds unnecessary complexity=
.
>
> All I care really is that the Kernel Project isn't blamed in the
> future if someone happens to lose their data.
>
Allow the hardware to negotiate the link speed based on the available
number of lanes.
I don=E2=80=99t anticipate any data loss, since PCIe will automatically
configure the device speed
with link training..

> Thanks,
> Geraldo Nascimento

Thanks
-Anand

