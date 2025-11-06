Return-Path: <linux-pci+bounces-40450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B742FC3930D
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 06:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B8D54E313C
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 05:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC862D5410;
	Thu,  6 Nov 2025 05:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ru8uWZc5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7337C2D8764
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 05:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762408347; cv=none; b=U5hGHAndcQ6L4rTR2G8HRGSXvSaBaAZ0+kJ3F5fhwAZ48UsrytQpVaFbyx6RsG3YZPG6hR1qRxwqnNjP8UnzXs9H0At+vutlSmywdcIyiXDhK6Bz64u/XhemQVh88r1jxBA6anAodvwgBkGlBguYcg7UA0pyAHcx5jTUwhbX+W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762408347; c=relaxed/simple;
	bh=Ar6XPa34sSziNntlv9mHo/RlQeuYRRNaiX+hkKWgV/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdFC/CWDDIMVknbUw4WVGbiTUznETlnh3WXAQqU9cuMepFTSbXCPbgl9IgOSYYsb40SyytmnX9CHV/GlL44LIaBlWx+oZxoekzoqLozL46JAF0b3n2vofo9aYajC9Z59YOqn2llPuAJmgppRrvmXcdN/qj6Qn+TRvsRjtJFnZPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ru8uWZc5; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37902f130e1so4783771fa.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 21:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762408343; x=1763013143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2vFD9QfkLV1VBP+0tHhWY7UETMkdp6hXOZQ1SGqke4=;
        b=Ru8uWZc5qjOZb6kMOBQOVwwhYQSsIP0LRUJTDwXXHDcblW70IcRSiBhCKOWyZ5nRxD
         CKfiyDc31r1w3py1JYJOj06Y+GMAKaiQQwejdIlDgQXW1k9h2TaIfMgeYsNeYL6lYY6s
         dseGvEIAdDzH0UVh0rDntRWPze4yff0s631ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762408343; x=1763013143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2vFD9QfkLV1VBP+0tHhWY7UETMkdp6hXOZQ1SGqke4=;
        b=ZbuTzRhdzLh4UQ7sJZpJVcHQ/3nNip0AHGrRYl6GSJYD0g9hFVhHTwriktayvbZVFM
         nuvpuOmwwqMAlfygPQ4TzkmgK01koNjMu2HZReR9La/4YM9HMXKO4Q9SLUSPjW3Cmh59
         EF+sLMRGuruE+DwMtWmnGhBFxS1oqha+Eu9D3/ZKbkGa4ZPo/WVrDKNBqBBr8+RRdxLq
         oQpLg7hFqvvKfr7S3x+sHTIh7lyzQsQ4X2yBq6wyeiMnG8cjGXv8Ati0XnouRrhahLzI
         NgqQCe9WlAQ6KCyILmcBIgTRy57sS8jq9M2/OeRa4IxR+4b6fSOBwjR5uXDSi1wMcRCC
         49VA==
X-Forwarded-Encrypted: i=1; AJvYcCVXsV/nl5/bQMGZXsdZP71sReLxp86FPfGXGLOZ0pD/b4wJuyHPsVEsxwS2dmLktPD4EkMbPKR5cUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1eGV9oTnlFWDkrgpA9wvo5EuYmgP9+Pt1WYeiBcKRr/Lkc2Fg
	kKVwWov4saNfMBrxAhrrBt2dBA9Br2cPwp/aOgNCZ9OtlrOXJUQSq7VWMiarzgnkuj+E2aBw5/N
	yZAnMyA+0UO9n06Tdvuzz0Msc6U4y1O/EHid7bRiv
X-Gm-Gg: ASbGncsfRQcUyCj2h6tTwmDpRVyRPB5mOiYE5KyUV6OwLWQvMDygKN7N+CfchplWL6S
	wBiGoauMUvJ0s7FyCizkk67SP3VISk4HTcX/ISoU3UGZyYMLLiGirJmxQLv5O6lSckJVSysvpUm
	MDau/wRa4ShbM+teF9ceDjSejwTYQAfEFDCIS60YhF5mpEfBRP/ATN/KaQUJ8Nbf7j5EbjYkphq
	577e1irpDhC3TiWchFSBCK25xEtVr0205GMHIOOdlNPn0O4V4QBWPL9LXq1y4o6HUbPTZ3/unf/
	G515jiSLjbT2rw==
X-Google-Smtp-Source: AGHT+IHAob6MV1N00P20nCaMZ0Unl97QFU3xVJ0gGiBJjh2pPEuMa2JaMwEv5WW7Ej34ZKo8sZo0R1CpSdofm5d6p5s=
X-Received: by 2002:a05:6512:39d3:b0:594:29c8:9ae5 with SMTP id
 2adb3069b0e04-5943d8043damr2230852e87.53.1762408343267; Wed, 05 Nov 2025
 21:52:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105062815.966716-1-wenst@chromium.org> <7250ae04-866f-489c-b1b6-b8a3d8200529@collabora.com>
 <CAGXv+5EwiL_-ozRARH2UBm5znHi1egBoCjmELN=17hvFF_oeoQ@mail.gmail.com> <3e1ffe72-b6a4-45cc-a053-190077818f19@collabora.com>
In-Reply-To: <3e1ffe72-b6a4-45cc-a053-190077818f19@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 6 Nov 2025 13:52:11 +0800
X-Gm-Features: AWmQ_bmokZWwcJ_dGdsfSVTeY3Z9us2jEl3U1CaBt3RNYP_UjKHxSJPC0zLeok0
Message-ID: <CAGXv+5GAyt6U710En_k=fq-CPrq_H6rmc=kpBNw4yXjj8qL2cw@mail.gmail.com>
Subject: Re: [PATCH] PCI: mediatek-gen3: Ignore link up timeout
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Manivannan Sadhasivam <mani@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Jianjun Wang <jianjun.wang@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 7:32=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 05/11/25 10:21, Chen-Yu Tsai ha scritto:
> > On Wed, Nov 5, 2025 at 4:45=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Il 05/11/25 07:28, Chen-Yu Tsai ha scritto:
> >>> As mentioned in commit 886a9c134755 ("PCI: dwc: Move link handling in=
to
> >>> common code") come up later" in the code, it is possible for link up =
to
> >>> occur later:
> >>>
> >>>     Let's standardize this to succeed as there are usecases where dev=
ices
> >>>     (and the link) appear later even without hotplug. For example, a
> >>>     reconfigured FPGA device.
> >>>
> >>> Another case for this is the new PCIe power control stuff. The power
> >>> control mechanism only gets triggered in the PCI core after the drive=
r
> >>> calls into pci_host_probe(). The power control framework then trigger=
s
> >>> a bus rescan. In most driver implementations, this sequence happens
> >>> after link training. If the driver errors out when link training time=
s
> >>> out, it will never get to the point where the device gets turned on.
> >>>
> >>> Ignore the link up timeout, and lower the error message down to a
> >>> warning.
> >>>
> >>> This makes PCIe devices that have not-always-on power rails work.
> >>> However there may be some reversal of PCIe power sequencing, since no=
w
> >>> the PERST# and clocks are enabled in the driver, while the power is
> >>> applied afterwards.
> >>>
> >>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >>
> >> Ok, that's sensible.
> >>
> >> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@col=
labora.com>
> >>
> >>> ---
> >>> The change works to get my PCIe WiFi device working, but I wonder if
> >>> the driver should expose more fine grained controls for the link cloc=
k
> >>> and PERST# (when it is owned by the controller and not just a GPIO) t=
o
> >>> the power control framework. This applies not just to this driver.
> >>>
> >>> The PCI standard says that PERST# should hold the device in reset unt=
il
> >>> the power rails are valid or stable, i.e. at their designated voltage=
s.
> >>
> >> I completely agree with all of the above - and I can imagine multiple =
PCI-Express
> >> controller drivers doing the same as what's being done in MTK Gen3.
> >>
> >> This means that the boot process may get slowed down by the port start=
up sequence
> >> on multiple PCI-Express controllers (again not just MediaTek) and it's=
 something
> >> that must be resolved in some way... with the fastest course of action=
 imo being
> >> giving controller drivers knowledge of whether there's any device that=
 is expected
> >> to be powered off at that time (in order to at least avoid all those w=
aits that
> >> are expected to fail).
> >
> > That also requires some refactoring, since all the drivers _wait_ for l=
ink
> > up before going into the PCI core, which does the actual child node par=
sing.
> >
> > I would like some input from Bartosz, who introduced the PCI power cont=
rol
> > framework, and Manivannan, who added slot power control.
> >
> >> P.S.: Chen-Yu, did you check if the same applies to the MTK previous g=
en driver?
> >>         Could you please check and eventually send a commit to do the =
same there?
> >
> > My quick survey last week indicated that all the drivers except for the
> > dwc family error out if link up timed out.
> >
> > I don't have any hardware for the older generation though. And it looks
> > like for the previous gen, the driver performs even worse, since it can
> > support multiple slots, and each slot is brought up sequentially. A slo=
t
> > is discarded if link up times out. And the whole driver errors out if n=
o
> > slots are working.
> >
>
> Hey, that's bold.
>
> If only one driver (DWC) is working okay, there's something wrong that mu=
st be
> fixed before that behavior change goes upstream (which it already did, ug=
h).

To be fair one only runs into it if they convert over to the PCI slot power
description in the device tree, and their hardware isn't DWC based. This
is pretty new.

> This needs attention from both Bartosz and Mani really-right-now.
>
> I'm not sure about possible good solutions, and unfortunately I don't rea=
lly have
> any time to explore, so I'm not spitting any words on that - leaving this=
 to both
> Bartosz and Mani as that's also the right thing to do anyway.

Mani mentioned [1] that work towards moving the pwrctrl stuff into drivers
is almost complete. So I think we're covered.

ChenYu

[1] https://lore.kernel.org/all/rz6ajnl7l25hfl2u7lloywtw7sq7smhb63hg76wjsly=
uwyjb7a@fhuafuino5kv/

