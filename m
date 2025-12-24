Return-Path: <linux-pci+bounces-43628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4555DCDB2A2
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 03:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2403300E456
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 02:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCD427B34F;
	Wed, 24 Dec 2025 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAgs2BHo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CB313D891
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 02:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766543067; cv=none; b=Tmquh9BfurSpIhSo6DYiW1akrmGiemBD0AR8rQjmB3jD8rqaatr9G0Mlpaxl2q+hIsDamdq7a5i4sLyOxYGfYRH9TQXTK/VueTRQk3Zgl8FE7sMTNt/HTLQuz5sctcKBMamGqhSuXjmASXgtGJPtT7AZR3xIWse1r41Ziulq2TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766543067; c=relaxed/simple;
	bh=QFs4nzcXv0HDihtBzYZfePcfGomA84cu/tUIasZGPN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpEZIlG78JyEBCI4AbG9uKQzsv/M0VjW+hly4pJyhm25xEulr+hTK8U0NkxmaJeQuNmLcgbjJwjjRSYPV1hyA0zFVNc9+5QUm/JxI75da91ZxR0y5GwkzWRk7pvpJMPt9bom8vu1ZA9YyXsZEiUn+jG74ABH7Jx198zwIiaKc0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAgs2BHo; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5943b62c47dso5492351e87.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 18:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766543064; x=1767147864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1loIAAfZi3ARrBea2GD590U569CMRnH53n7SJVQ+fYg=;
        b=WAgs2BHodSTN8HmBAAONb4cs/IgGVcyf16ELPe2NS+jw8IYyLl7XwD2C7Dz1xVrcvv
         AzKK7rEEvcYobuhUuLOy6JL83lboBlR5gVUbe/C0augfesQHQj9MFroFLN1PJ3TOyXMG
         lEIHENWqa0cjb4RDnrjJu8w+NMezIMi7SN7+5HK0bdRbm5QKzW7F76PElOhT4Je++pvw
         GYZ3kV6zaz69KuCsaoyZravh1oaDOd2AojMMWC24UZJcb9N/ZjhioInn3y7m7yxKBYze
         UYYGI72rhhtNY7NdXKvEZSJW/o4y9DsVQAsWE0+BwGcabjqgp5m9+HnpkYRF9YGw3p6G
         EGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766543064; x=1767147864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1loIAAfZi3ARrBea2GD590U569CMRnH53n7SJVQ+fYg=;
        b=c/AhePcOmwVZ5F+gUDrSMpWwXVyeZAX54ZHEhspQIigxw6Ou3WPM3YfSwQc9bnXTGU
         jINVFsWpdf/u64tp0nYKi5V1sC54HIxVpCib/R+aa6F2VDKhG+6WLP4cj6/yKRcwssnJ
         DEbiCvqPVJav+W9NSeW5Zcs5gmze13rEhpVLWOMxQYWGTidoAyHMTKmjecpA2rvnHEA3
         gzVKGBW9VI3hdVYltn7N0GMoBj8Q/naWP2dvmu9uZH9Yek7OmZo7isFwaUIN24kbLUGQ
         L5ufQJ4Rf5Xp76L2+MVH2X5+xqM/t8uA15V/qGqbSMaBJzB3DUh9zxA0JaKLMFJK8278
         qIFw==
X-Forwarded-Encrypted: i=1; AJvYcCVNuYFabPyzuos2Wt8PX4AUom+NcYN2/U2/Z0Zcr82XR1hP45viwD/eqorJDtfUfrAY3rP0X1k4xX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY6LEGR/99YwBF3abXuxd3P0jbPN4lhVBymGS8I/svD7LQjbZd
	XcJp+7kJBd7pCFnF45HwHXv9KqFo6k+UKz/2mRM9+SU50zt9N8qwOLiqksDNyxBLzVVsImqfpT/
	Zmv6jRl2+nUIMyM9vWOk+5aYbcCAqMYA=
X-Gm-Gg: AY/fxX6tDBNi+faQ/GLKJoo4+PtdtzOvstt+RAIADIUEHfFgo3ZYsvXHUGX8Shnr6e/
	lb4q6OYteufeShdMllzk0AJYwJs44vx369++E947m0cokAWph9NSIyY44D1+cdmbZKxf/hkuvOG
	URd8fPcJf3rKWcHPhrJqw9PdGPlfxGx682BkntNBq3ZSVmaqnS7YnWParAiP/heB48gy7vtOUiR
	9wYq0wXxf/ZmqM2q4br65H1TXf4NAypKGRm1CL4kXm2aA3UD4WrBOzyLuiXWByzcO7256VH
X-Google-Smtp-Source: AGHT+IE/+50K3afhfndy8OOQCaT5Jx8UIeiRvbJr4DL0U3mNPbecM/23tUIstTpZgAeJvbIu4PB7SOkqEOl5NRqK1zg=
X-Received: by 2002:a05:6512:128c:b0:59a:10d9:72d with SMTP id
 2adb3069b0e04-59a17d498fbmr6776183e87.45.1766543063511; Tue, 23 Dec 2025
 18:24:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763415705.git.geraldogabriel@gmail.com>
 <eaa9c75ca02a53f8bcc293b8bc73d013e26ec253.1763415706.git.geraldogabriel@gmail.com>
 <qncj72c3owrw7rvnj6jit2sbn4ojyr3kztcjailfxtdboan6sy@ddh5g7v4fcvt>
 <3ea8ac20-6332-0c0c-645b-36ca4231c109@manjaro.org> <DF197NIRHLIJ.3LIG9GJGJQLQX@cknow-tech.com>
 <656e9b4e-c350-f808-701e-e49e8dad7062@manjaro.org>
In-Reply-To: <656e9b4e-c350-f808-701e-e49e8dad7062@manjaro.org>
From: Geraldo Nascimento <geraldogabriel@gmail.com>
Date: Tue, 23 Dec 2025 23:24:12 -0300
X-Gm-Features: AQt7F2qM7hLDFS0yoRUqiACBfHqK5NSRbS9YoOFtrIx5Y1oXB1EP6whymdD-2I8
Message-ID: <CAEsQvcv_8HnWNHAQGKs3pzBqrO_9+HsMr9w-F=pZJ1oEXeC=Bw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PCI: rockchip: limit RK3399 to 2.5 GT/s to prevent damage
To: Dragan Simic <dsimic@manjaro.org>
Cc: Diederik de Haas <diederik@cknow-tech.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Jonker <jbx6244@gmail.com>, linux-rockchip@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Mani, Dragan, Diederik, and all,

I'm currently facing banking issues in Brazil which means I'm
refraining from fetching my email through POP3 with mutt to do proper
kernel development.
I usually fetch my mail through POP3 and have the server delete it, to
save space on my free tier.
But I found out I have a 20-year old bank account open that I had
forgot about, and with this bureaucracy hell I can't have the server
delete the messages for now.
I'll send v3 with more proper and illustrative wording once I get this done=
.

Thanks,
Geraldo Nascimento

On Thu, Dec 18, 2025 at 7:13=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Diederik,
>
> On Thursday, December 18, 2025 11:01 CET, "Diederik de Haas" <diederik@ck=
now-tech.com> wrote:
> > On Thu Dec 18, 2025 at 10:47 AM CET, Dragan Simic wrote:
> > > On Thursday, December 18, 2025 09:05 CET, Manivannan Sadhasivam <mani=
@kernel.org> wrote:
> > >> On Mon, Nov 17, 2025 at 06:47:05PM -0300, Geraldo Nascimento wrote:
> > >> > Shawn Lin from Rockchip has reiterated that there may be danger in=
 using
> > >> > their PCIe with 5.0 GT/s speeds. Warn the user if they make a DT c=
hange
> > >> > from the default and drive at 2.5 GT/s only, even if the DT
> > >> > max-link-speed property is invalid or inexistent.
> > >> >
> > >> > This change is corroborated by RK3399 official datasheet [1], whic=
h
> > >> > says maximum link speed for this platform is 2.5 GT/s.
> > >> >
> > >> > [1] https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_=
Datasheet_V2.1-20200323.pdf
> > >> >
> > >> > Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC =
driver")
> > >> > Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4=
c21b@rock-chips.com/
> > >> > Cc: stable@vger.kernel.org
> > >> > Reported-by: Dragan Simic <dsimic@manjaro.org>
> > >> > Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> > >> > Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> > >> > Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> > >> > ---
> > >> >  drivers/pci/controller/pcie-rockchip.c | 10 ++++++++--
> > >> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >> >
> > >> > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/=
controller/pcie-rockchip.c
> > >> > index 0f88da378805..992ccf4b139e 100644
> > >> > --- a/drivers/pci/controller/pcie-rockchip.c
> > >> > +++ b/drivers/pci/controller/pcie-rockchip.c
> > >> > @@ -66,8 +66,14 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie=
 *rockchip)
> > >> >          }
> > >> >
> > >> >          rockchip->link_gen =3D of_pci_get_max_link_speed(node);
> > >> > -        if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
> > >> > -                rockchip->link_gen =3D 2;
> > >> > +        if (rockchip->link_gen < 0 || rockchip->link_gen > 2) {
> > >> > +                rockchip->link_gen =3D 1;
> > >> > +                dev_warn(dev, "invalid max-link-speed, set to 2.5=
 GT/s\n");
> > >> > +        }
> > >> > +        else if (rockchip->link_gen =3D=3D 2) {
> > >> > +                rockchip->link_gen =3D 1;
> > >> > +                dev_warn(dev, "5.0 GT/s is dangerous, set to 2.5 =
GT/s\n");
> > >>
> > >> What does 'danger' really mean here? Link instability or something e=
lse?
> > >> Error messages should be precise and not fearmongering.
> > >
> > > I agree that the original wording is a bit suboptimal, and I'd sugges=
t
> > > to Geraldo that the produced warning message is changed to
> > >
> > >   "5.0 GT/s may cause data corruption, limited to to 2.5 GT/s\n"
> > >
> > > or something similar, to better reflect the actual underlying issue.
> >
> > s/limited to to/therefore limit speed to/ ?
>
> That would work well in a book or an article, while slightly terse
> wording is usually preferred in the messages produced by the kernel,
> or in log messages in general.  Such an approach compacts as much
> information as possible in as few words as possible, while still
> remaining (mostly) grammatically correct.
>

