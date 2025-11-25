Return-Path: <linux-pci+bounces-42039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7006C8546A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AF614E9311
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051CD267F57;
	Tue, 25 Nov 2025 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EtLpDZYZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4139F261B8F
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078936; cv=none; b=ZIJufQalbykDtM7/pqx6exFQ716R+LGeKGGkXNknmW422xCOq4IShktwLKLu6lUyDgTQaFavdm9Sw2M+EueZwRWDW6X2l7+iRE4gNTGMI9z1fwDu7cYAZVkLbvR4vA/OLtA6Tmm7L0SAIdM8WzRp0SLlpwpxygvMWnevjbYaFHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078936; c=relaxed/simple;
	bh=6dCigi9C/RGN6J99aEObFy3kqNHHN3O6GWyCMbyPKdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6+CrBmg2CTsQ5jNAEhB+JE7OLX+fcsD2eP5Vzz/Z4Z2YKGLp4hNaiDf8GQ7sbfSkxcunu0UHHNj2YmAoAl4C33W0+ItTawFs39jGYMqj7wy+FYNPmVca2kI2jgffeg5zYVmKgd0nBRqqpc0EUqgkWn2j9oxSttAU3s2RPTnIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EtLpDZYZ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-594516d941cso6321006e87.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 05:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764078933; x=1764683733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dCigi9C/RGN6J99aEObFy3kqNHHN3O6GWyCMbyPKdw=;
        b=EtLpDZYZTm5sviqXmm1Yu9cGrOG/07X+Fs1xGAyH7WLdSTXHenCv1GrMTrA1/tUqfl
         odvZ3rlFiH5VB2UAZj/rEg20K8GzAlSDysB2laiGxyC7AfAV2pFwAGEwRghEhZSFRa1j
         6TUqRjvw6O6fmHzln74stI+G0yAY1Y470dD9E2pgsGW+7tH6QCtfvNLBrGgszszz+dKh
         XJbVIzp7kC8QvY7c6LMyaC0Cir0goTBrGACTzg10DFqg52VKaUlJ6b6n5+af4E64puQ8
         v0EAaRhythb+yHYvblt2Y9iySCyWfK/5/bzoBqPAWpMRlkDIEojtus/sOh4l1LTykoVR
         vgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764078933; x=1764683733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6dCigi9C/RGN6J99aEObFy3kqNHHN3O6GWyCMbyPKdw=;
        b=Fl7q3ofcIb5wyvG7o+0Z1J4kuXFdEyOuGYFyMBXzGaPZy1ngEkYBRRJ3W6+Zt0jUNm
         Nik3wSFTzNh+n+HhSuY9isjn+916OTuMdVNIUto6ItQ9exHuwx29ug6PMCvyB+4BSVoI
         opZxHd9KuDVoj8zH4SnQWFBs9MBxN14zEuY/ngXdXMtN+n11nNTLVxkruRMUeTylTPr3
         35nE6e01OQwSCBTnarkkZIgTctpxIWbC/OAPa/g0Pgfu1YKifrrzW04lpyseWV4tgogR
         GVvqMRdSi4SO3BKRVvvm80qX86ctjrC9Pc+WXVLeXh0/sabuI7hw4PzRnNIZu2XGTV2Z
         7BRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcq2+cgQwAXJZXIFXV5Pk1OcCCT5k3Pq6ptyoozk+YfR/HvkLzsltPvLIAu363bAQeRDFlGuk9xZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD3cKvmdENvn7SsmDD1FnbS7Lybaybw1LGyXTj86XNfAeLVnu2
	wyiRA1N9bH44GI5l2Zp5ZK+v7WZoV2r6qnUb5WpHgWhG/js5m/b1H0TUC+sohdAFlZLPHQXBtOL
	H5mICSxQMcJg1+t78QJbvXZORY/1LG72aZ4tzcb0ABg==
X-Gm-Gg: ASbGncv0DFnt7tCR/yi2uOPu5XiYxxRSaJTiP+voqm8XZQwe9sf8hgXebWW0Dh/w75s
	snPIPukImWeRGFHPWm/+to6MJOdBX8al4AAn4VVQOs3Vd+Vdvds7k4rMM/bPk19YnUQjz1OaKvh
	PIegGwV4UhEBwW7DvO3Jwk7MAMPuCx0PWOlL9e8S2FugXrEJvElD9cw4xSLdhjb5DeCbaxNSFcV
	p3FIxck4ShhZKlKYJkncE2/cJ6RXszK97DGTgXuxdptZsEfIsrl4epvpMGAsuOC8pxd4rAnpYyn
	RM5KP6g14S6ovQ+JJ3qHsv+zJz8=
X-Google-Smtp-Source: AGHT+IHpODuwBQnk3mauQeq63RNOA2CwtokpJT3wujYxmcQIwnm5JZcn37KcCirO1/FKBMTqdAj2F0DUkO2X1fHKIP8=
X-Received: by 2002:a05:6512:e9d:b0:595:7e2f:cc61 with SMTP id
 2adb3069b0e04-596a3e987abmr6257240e87.3.1764078933200; Tue, 25 Nov 2025
 05:55:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com>
 <20251124-pci-pwrctrl-rework-v1-4-78a72627683d@oss.qualcomm.com>
 <CAMRc=MeRVLALxdPoFP2fXpq+inZpA7h-eCBRuegTkxWUGOpDew@mail.gmail.com> <rsfsl32fjfmke6ffvz6y3lvvh54rofnaetuxy4qo3niffjcaue@udb44lfwbfga>
In-Reply-To: <rsfsl32fjfmke6ffvz6y3lvvh54rofnaetuxy4qo3niffjcaue@udb44lfwbfga>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 25 Nov 2025 14:55:21 +0100
X-Gm-Features: AWmQ_bmYxURmm5WQPKpTKTEm06bHE4Lg4epdxsM3nQcjHmSJrDeaDSYcqbDrrE0
Message-ID: <CAMRc=MdcTWTWRRua=a5tUkmr3qtjMsRHcTOERGup+F0sgqwN1Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI/pwrctrl: Add APIs to power on/off the pwrctrl devices
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Niklas Cassel <cassel@kernel.org>, 
	Alex Elder <elder@riscstar.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 2:50=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> >
> > This is not an error though, is it? If there are multiple deferalls, we=
'll
> > spam the kernel log.
> >
>
> Good question. Initially, I made it as a debug log, but then realized tha=
t
> people may wonder why their controller driver encounters probe deferral w=
ithout
> much clue, especially when the driver spits out other logs before calling=
 this
> API. So decided to make it dev_err() to give a visual indication.
>
> If it is not preferred, I can demote it to debug log.

If we must log it, I'd say a dev_dbg() is enough. Probe deferral is not unu=
sual.

It would be awesome to be able to synchronize the controller probe
with the pwrctl device binding but I don't have an idea on how to do
it yet. :(

Bart

