Return-Path: <linux-pci+bounces-40332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC5BC34CBD
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 10:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E193734D242
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 09:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4639D2FBE17;
	Wed,  5 Nov 2025 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GyNIZys1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423DD2FC004
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334489; cv=none; b=rqrOVTQ1D1LJraYtP4aA9vW0jBY4IgfFQShU4l/UTPYVhD8iH260cqxSvmPxorQhFKJxyYaIUwHvsEp+TwUNI83NVY11QGo9P3CpMiPx4PlfcwehT6reMmHfNVWdgwkOsgmXIjXVbrWUbNPTGAlig+Fv/F83Ls/RpmxZwneGrqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334489; c=relaxed/simple;
	bh=MsIGhFgmRY3shV51muuQARn7dSaDWqIQfo2RqSJEdV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=InoyjB64Xpjk2dHB8re8RWXnKQt38GpOEZbLKyY6BhaIhgWsn7RapKArpoa7Vx+mGor9huLH/how5jDuoMzdIbmF/wM+TaVfVi7E1c96KSWmot/T7RhGU9BiUj/5NgDscrAlESqASyj7OaklxGGai4CZOO1+v+b6pGF0NklTNfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GyNIZys1; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3737d0920e6so54373951fa.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 01:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762334485; x=1762939285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9Cz7QFeZXHx7n2GD0Sctn9Btu8KGfjVz7K3mbh7364=;
        b=GyNIZys1OAZAm+vHerp+X58IiegAzqoxjvafHezNTISZeaEOM3FJpERaXx9DT2FqsW
         lt9VQbL0HI9cXkRwUHezNGwVSZLB2QzxyCVXObenBmw7vKME3a/kJtInNgfKCBUVO2gi
         9FKF9jdOXUrR/kE67/qv9vL8ml1hPSPe+7k6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762334485; x=1762939285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9Cz7QFeZXHx7n2GD0Sctn9Btu8KGfjVz7K3mbh7364=;
        b=MbTmvESmt8ooc3BC5gpvkieuTURgCmASwS2+OtC1povyMudl721W5BfZTVFA/k/e1e
         bLh3QnGRxxZ2p0HEnLLpz1sGXG24H6ap4tDD6hFYynRMaEbwjMr++q+SbeebqcT7nGzg
         L7LvoYMOPtqaW8eFyBxbu1U/WtXFOdK1OygUAttIE/RG/aq0JMJLl6DZuB3N5Jzs9Fc7
         m60i4rt9VAfkz5m21AUMvazodz7A1zlKgkLCBH+TFWCTH2vaKynRw54YX5ICgLgELvua
         8YL5pXXollYu0zY+RYkul1iqRjUAoWpVKkDSeby8FzjUPWQRG8kPwfESE62yKTRY6X6C
         fq3g==
X-Forwarded-Encrypted: i=1; AJvYcCUrrq8IeJcc4yL5Z7CL9APRQFv48+3uw3KmzZ2eRdnNBMe6HQlgyMHkHUIz1RMpKhN487Q3kWwdAbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy7WwRruZU6DabVgW7RVtMrTzyyaGUJIbyqlYp6SvoToQtdY2n
	H1QCGS33cMgbRh8Q/faxMMfcgtgcBYboPuCvi7Ve+zBBwAFylwsntUa1t5MPCgo4bS7ULQx6qMq
	EHbH2hHibcLgkckTg72nHpA98iXIz+lbnpFRf52L1
X-Gm-Gg: ASbGncsyd24DalMiF+ODUDLUFTqw0ZTMdfxcIUEq4UzbPw7suANA1C16O4VNaGhsF1h
	vIFpPUd3nasB9pWuKs2hR/e9AH2h/lKDCqXFP/93tOyEtMqdlnKLTnMjAkpqWcK2ol1YuBCAe+c
	KAuRORZnPQ5n7h01Hi8ZAmj87zU1UCfjJM34lmUUgdoVGEzs1SL0TFjgEb4WPnwkjTdMst0GrNf
	CFTT0AHuSytksMDrDaZX59bl5zFdK4IjoFX1pwHUf5OpO5TocUeBhhYMwlyRsrOdzM9cSFgySKc
	Al9+6SECf7DjDF0=
X-Google-Smtp-Source: AGHT+IGQP2VVUJ5rUmY6C9xv2Mgt2qZpBhs2wiUlca0i0M5p6PJNG/u4WXKd81FDNk50RCsLvXv5mIlfnoCqea13DHc=
X-Received: by 2002:a05:6512:104b:b0:594:34c4:a352 with SMTP id
 2adb3069b0e04-5943d75dd17mr829339e87.23.1762334485335; Wed, 05 Nov 2025
 01:21:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105062815.966716-1-wenst@chromium.org> <7250ae04-866f-489c-b1b6-b8a3d8200529@collabora.com>
In-Reply-To: <7250ae04-866f-489c-b1b6-b8a3d8200529@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 5 Nov 2025 17:21:13 +0800
X-Gm-Features: AWmQ_bndGi-pOLYUZIEExvSxZWBBRpwVWURG5nTKgeks0Y9s12nRjMsAjohzleQ
Message-ID: <CAGXv+5EwiL_-ozRARH2UBm5znHi1egBoCjmELN=17hvFF_oeoQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: mediatek-gen3: Ignore link up timeout
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Manivannan Sadhasivam <mani@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Jianjun Wang <jianjun.wang@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:45=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 05/11/25 07:28, Chen-Yu Tsai ha scritto:
> > As mentioned in commit 886a9c134755 ("PCI: dwc: Move link handling into
> > common code") come up later" in the code, it is possible for link up to
> > occur later:
> >
> >    Let's standardize this to succeed as there are usecases where device=
s
> >    (and the link) appear later even without hotplug. For example, a
> >    reconfigured FPGA device.
> >
> > Another case for this is the new PCIe power control stuff. The power
> > control mechanism only gets triggered in the PCI core after the driver
> > calls into pci_host_probe(). The power control framework then triggers
> > a bus rescan. In most driver implementations, this sequence happens
> > after link training. If the driver errors out when link training times
> > out, it will never get to the point where the device gets turned on.
> >
> > Ignore the link up timeout, and lower the error message down to a
> > warning.
> >
> > This makes PCIe devices that have not-always-on power rails work.
> > However there may be some reversal of PCIe power sequencing, since now
> > the PERST# and clocks are enabled in the driver, while the power is
> > applied afterwards.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
> Ok, that's sensible.
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
>
> > ---
> > The change works to get my PCIe WiFi device working, but I wonder if
> > the driver should expose more fine grained controls for the link clock
> > and PERST# (when it is owned by the controller and not just a GPIO) to
> > the power control framework. This applies not just to this driver.
> >
> > The PCI standard says that PERST# should hold the device in reset until
> > the power rails are valid or stable, i.e. at their designated voltages.
>
> I completely agree with all of the above - and I can imagine multiple PCI=
-Express
> controller drivers doing the same as what's being done in MTK Gen3.
>
> This means that the boot process may get slowed down by the port startup =
sequence
> on multiple PCI-Express controllers (again not just MediaTek) and it's so=
mething
> that must be resolved in some way... with the fastest course of action im=
o being
> giving controller drivers knowledge of whether there's any device that is=
 expected
> to be powered off at that time (in order to at least avoid all those wait=
s that
> are expected to fail).

That also requires some refactoring, since all the drivers _wait_ for link
up before going into the PCI core, which does the actual child node parsing=
.

I would like some input from Bartosz, who introduced the PCI power control
framework, and Manivannan, who added slot power control.

> P.S.: Chen-Yu, did you check if the same applies to the MTK previous gen =
driver?
>        Could you please check and eventually send a commit to do the same=
 there?

My quick survey last week indicated that all the drivers except for the
dwc family error out if link up timed out.

I don't have any hardware for the older generation though. And it looks
like for the previous gen, the driver performs even worse, since it can
support multiple slots, and each slot is brought up sequentially. A slot
is discarded if link up times out. And the whole driver errors out if no
slots are working.


ChenYu

> Cheers,
> Angelo
>
> > ---
> >   drivers/pci/controller/pcie-mediatek-gen3.c | 13 +++++++++----
> >   1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/=
controller/pcie-mediatek-gen3.c
> > index 75ddb8bee168..5bdb312c9f9b 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -504,10 +504,15 @@ static int mtk_pcie_startup_port(struct mtk_gen3_=
pcie *pcie)
> >               ltssm_index =3D PCIE_LTSSM_STATE(val);
> >               ltssm_state =3D ltssm_index >=3D ARRAY_SIZE(ltssm_str) ?
> >                             "Unknown state" : ltssm_str[ltssm_index];
> > -             dev_err(pcie->dev,
> > -                     "PCIe link down, current LTSSM state: %s (%#x)\n"=
,
> > -                     ltssm_state, val);
> > -             return err;
> > +             dev_warn(pcie->dev,
> > +                      "PCIe link down, current LTSSM state: %s (%#x)\n=
",
> > +                      ltssm_state, val);
> > +
> > +             /*
> > +              * Ignore the timeout, as the link may come up later,
> > +              * such as when the PCI power control enables power to th=
e
> > +              * device, at which point it triggers a rescan.
> > +              */
> >       }
> >
> >       mtk_pcie_enable_msi(pcie);
>
>

