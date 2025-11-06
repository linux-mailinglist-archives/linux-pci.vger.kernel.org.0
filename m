Return-Path: <linux-pci+bounces-40523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A429C3C298
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 16:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F4364E590A
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 15:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81F8322A27;
	Thu,  6 Nov 2025 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vnxDit2v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568DC302175
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444114; cv=none; b=rDTg1oVZaKfxjjrpFp0odsi2nvjfypCvI93wqXI2dvgAPDdUNCGVJcrLn7f0sc2M9RGMhy9xTxt9tpeknr7jj3D5CjSw+gvgI62XDZRW4V396nA7aBW44lSJ7+dbSivvLmV6OG+gJ9TVrUURRECeZUwuNVzSwf2khXPEpYqhyYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444114; c=relaxed/simple;
	bh=IzsySpkujMcR4WoEBmC55L6jaGwoKuDh9CSfvagLBlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLe7O341TkQAdxf1lG2dCtXE2blWBKR7/BnguqqW760vUgcUrp+mSLOXLuUvMHkHSMbakBuEe7ScVsuayYL9FkR+626kiENWdMmkxQuOlWmtvr+wRdZ+0Ok+A4JC/aVx3TVi0pblfW1TJ5tLnnF5K817LIe+Sw3+xcvdEhvTsuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vnxDit2v; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso1166051b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 07:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762444112; x=1763048912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97N5NFxuu/uCytVCp353kHzM6K2Dbd7TnX+o0fzl0i0=;
        b=vnxDit2vauZQMJwZ2ytrCOVucQuUZyaX3P9jn9+sZGDLDkFHL61/EcEYrZunmkgqPo
         sfmeGvdn4+APinTvn5Z4sHdp2F4XCh2kLIdd3q3Y/SojuLAwfTkakZjYJbfoQBY4YtWj
         R19eO6GqGUfkTjzt1gSwoUa7YkVeEgPGQ+krmgF6Gp+3ndvjQtHECwBLOjSpNMAI4sS7
         O7k7L8OFkp8JZ8qsp1J1j3/IeRk9OnEy5O0zd6Y4j9Ko+cc+fOaPuiOYPx1g4yJbk03t
         /05SY0vuqfiu2h4ppZBoBLeNa6F0uYpZXZQdwudojfoC9s3gU/aIwdaOkMs8E0+xaoD9
         rc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762444112; x=1763048912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=97N5NFxuu/uCytVCp353kHzM6K2Dbd7TnX+o0fzl0i0=;
        b=ZI66+cY3xJh872Nh1csOyFMRFb3DLQKfn0nu66KX2u+nISQOaCydsGHhizpKICg5pP
         u/QpMm055H1QI9WfMxyEzy+rHl33YRFSNklyDfmAOmzz/hTQakD1VinNKy0My1A7yB57
         VqGIjyn0WBBYCAarPCkw+BieG3n0QpJis112gWvdq9enMeajHR8PMrd8gtvPmVj1NPNP
         xY8ThY3b4BQVkk3uQCz694ZBCu9tXvDxyEnZaHsrWYeGai0o6ddbaBWAy7CfVJ5L3J+X
         4Mx7iBITpWmUVqmguKTXBaJ1lQvarnbpA4ZD9Zc+INObOkgWfb4n6tbIULpDvRUjOqte
         /4Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWb+5VP9NYkG/UYABGpL6MD/eMX6nvsXQGBEAKiHn8jLcq/0ZfExL7QzfQf7AFbsVNwq6wRPCnKUqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7gd2k8HmzaaCgYuRq88W9fMNfUeBye9cmjEj+W4+r47XaLcuJ
	OM2EN5Gc4Nkso919FpjkGbKnp7AlQbnbJR2AN/snokiEPV1f2VyDH0BFmRYCSMedOTXWY2fDPtC
	adBR1s1tujcn9HiG7/z6cnCUNSBVHaC0yuQg7hShRUA==
X-Gm-Gg: ASbGncul4zi5t95iq8U2bAF/Hh2k0eccESheIqOKSChtAnMISrz2NF4zX7W0/shZ5DU
	ErT3mlfARrMYXUIq4drlvrR5p0z1kMbusHbevNMQnFycdyYVos7hQ+p1VHZQyXmIkZcDjIgT5Hx
	cqAuW1VnXxpoYQivn4p2LFjwsfSD+ljqUBXAXRudufaoqY0waXBhugaebec3fhwqFQct21VcHHh
	XL65zfw3OQ+By6T5TKd0qO7dm0q8UM1QNg8+Jir/KoSYOO47wZAJ/YKfzlcmXmmRmP1fuj3CNMq
	jramNTFDQ+cZChJW/FZgo+hisw==
X-Google-Smtp-Source: AGHT+IGkyMxFIxYqEfsxkoeH8/+bnCDt9rf3tx5Zv59yWcveQKoUxGPzEJY1muHMLt5mGF2Rg9TIu+z/TPDNf8xk2Uk=
X-Received: by 2002:a05:6a20:7488:b0:34f:ec32:6a4b with SMTP id
 adf61e73a8af0-35229d68476mr26916637.32.1762444112518; Thu, 06 Nov 2025
 07:48:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com>
 <20251105-pci-m2-v1-4-84b5f1f1e5e8@oss.qualcomm.com> <CAMRc=McB4Zk8WuSPL=7+7kX4RJbdFBNReWZyiFnH8vfVx3DxAg@mail.gmail.com>
 <tc2r2mme4wtre7vb7xj22vz55pks4fbdabyl62mgutyhcjxnlx@qn4jvx3jqhie>
 <CAMRc=McDYL_B+hFtLekevtB2XpUkaMN1dsDNeefvR+ppj4whFg@mail.gmail.com> <5wbwpr7ivnvpttacyl7b5fsexfda2uvoqau7yaaxuavskka4z6@vvntbnakzrjb>
In-Reply-To: <5wbwpr7ivnvpttacyl7b5fsexfda2uvoqau7yaaxuavskka4z6@vvntbnakzrjb>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 6 Nov 2025 16:48:18 +0100
X-Gm-Features: AWmQ_bkhQdbMkrAQ_h-vWt-L8tplAxdm964sVXmj6JsL9Vun-srDl-nRdBMs44k
Message-ID: <CAMRc=MfCQgMd-7QczbnRuBAvXnhJ5QyUzRswECfKC3NbQ=rArg@mail.gmail.com>
Subject: Re: [PATCH 4/4] power: sequencing: Add the Power Sequencing driver
 for the PCIe M.2 connectors
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 3:32=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.o=
rg> wrote:
>
> >
> > To answer your question: sure, there is nothing wrong with having a
> > default match callback but first: I'd like to see more than one user
> > before we generalize it, and second: it still needs some logic. What
> > is the relationship between the firmware nodes of dev and pwrseq here
> > exactly?
> >
>
> The 'dev' belongs to the PCIe Root Port node where the graph port is defi=
ned:
>
> &pcie6_port0 {
>         ...
>         port {
>                 pcie6a_port0_ep: endpoint {
>                         remote-endpoint =3D <&m2_pcie_ep>;
>                 };
>         };
> };
>
> So I have to do remote-endpoint lookup from the pwrseq and compare the of=
_node
> of the parent with 'dev->of_node', I believe. If so, this looks like a co=
mmon
> pattern.
>

Sounds right. I would still keep it in this driver until we have at
least a second user that wants to do the same thing.

Bartosz

