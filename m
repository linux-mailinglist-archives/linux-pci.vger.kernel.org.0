Return-Path: <linux-pci+bounces-14267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEB1999FB8
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 11:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3446A1F240C3
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 09:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EB120C491;
	Fri, 11 Oct 2024 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UjlKepA4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AB220B219
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637443; cv=none; b=cRMWN/J6rY4qpB8HHqa3ugnsXpx/D56VHZXf8sfmJOhx/9VJSQa/BifKE9cFl8XM96u3FtVPlRUY/i6B69TqSq4Pye185p+udcDx4wBnn7E1f5MwGMns3IXTHmk7qjd0duIHQf20OoWv3CYgBi/JTnamI/GlrpMDaGsiex+SqHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637443; c=relaxed/simple;
	bh=8d4yjmVwCnaXxPXrZ2Bik8WHksaHIVN+6JB2kOkIujY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZKgs8Svmvin/ElTNlcu7rcR7Co2hfuQhOzimLWRyEbGVnmeK2EoIq2TaT/u+5/0w3ThnWrrn5fA8n97TRmvaow3gSlje4Aw6X4e6KP5GNMYzGtEIsNP7ILM7aHqthDIbJa5kGDC8GJ8ThDZt736me7bYJZLgK6UjorldRgyxe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UjlKepA4; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so17361591fa.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 02:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728637439; x=1729242239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8d4yjmVwCnaXxPXrZ2Bik8WHksaHIVN+6JB2kOkIujY=;
        b=UjlKepA4hAD++SNdy4LOvTtOw5ntAamFNtOgJrl7dvwC8IUPOa7K/0XYwrqZLD31ru
         4FHGjztNtOMH2pb/w3YjJ3ikFns0urYSNzSahMYApTk0E7HQVGG/Maz1ccLZTYOAdZEJ
         wRxypVtkF30WHz4P7W9FdDRG2/gGZN/8j5TXxip8iAYo+SnIxf8xguNAJJ/S6El28LrX
         SuUv5Bwt9sIvdScFo4EIhNU4Qvhfgxk9/9PSe8irDOFwlPNV+MEpIaAk9aq+xIJYKaRm
         eEhF16Un5/CcK3UIixNmVn33BhtnM9CBj4/CpzdUPA9hiIwdFHpTC/pTG3GiIK2C+BQg
         qIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728637439; x=1729242239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8d4yjmVwCnaXxPXrZ2Bik8WHksaHIVN+6JB2kOkIujY=;
        b=daULyhqfC4RPBc0DaDvnchNXULZw42wez1pAeopykqKd9svuwkRSJwsfaOs5iaPK0l
         m07GOeh5AuR4KOpuS2N1n48Zrrg2Oh4ZZGrgjFrfE+SV4UikPyk4eeX9i2IQVfI8atKB
         H5UxgFJldYwyDUVDkvCME3lInBEm1pGFYKK4xJZaiK9bKpDdw/mtulE/0bAk25aqr5cq
         zLMH6ONBvyLMEe0tqWfN1spesF4B4GMEPWZxe/I4MH3QSdhz5DhaNYy/VeSuiSFLQvEo
         VGubfbkl/URyMs3xBtah2LGMiOgZuNSJtoYA2m3qu3RC9nx+db2zlcc7iFAN+C9QQjCe
         u8GA==
X-Forwarded-Encrypted: i=1; AJvYcCX4a1AdG5OR4xWuSO2p9awXvCoqYiT21Oh5HnsK+uf39Pl1QdYt6UpIID4nDF8fAjvpwnlZnKJwosY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcOyadw/+4GNlzhyywEyWllQLqXt9nlsbyAVjo4xLodN/TZFxK
	6rzm70LwfGNeVwUukWvqDBxxJYxqCquKpSwi0O9RaJ66MXCdlJVMw+CdlxNW5kyFc4tzBmUo7iU
	Jgijq2UzsZOyiQuDxPF+2b4BTJHwZw+yzCBya8w==
X-Google-Smtp-Source: AGHT+IE5OeNgFUzqHYTpHS7727BD0udgza39pHKdVWlcHOHz9ZIbGL1mxOhjbFQg5l0MRwkHUObjvdE6hjbd88hX09I=
X-Received: by 2002:a2e:f1a:0:b0:2fb:3a92:d1a7 with SMTP id
 38308e7fff4ca-2fb3a92d591mr3422661fa.33.1728637438600; Fri, 11 Oct 2024
 02:03:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728300189.git.andrea.porta@suse.com> <199a4994312b120c73c95fa368954ad5a2a8aee6.1728300190.git.andrea.porta@suse.com>
In-Reply-To: <199a4994312b120c73c95fa368954ad5a2a8aee6.1728300190.git.andrea.porta@suse.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 11:03:47 +0200
Message-ID: <CACRpkdb1muovPmKoUw=Q5sNXj3bsCt84LcKVDSLY09_5_1rXZQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] pinctrl: rp1: Implement RaspberryPi RP1 gpio support
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Derek Kiernan <derek.kiernan@amd.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, 
	Stefan Wahren <wahrenst@gmx.net>, Herve Codina <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 2:39=E2=80=AFPM Andrea della Porta <andrea.porta@sus=
e.com> wrote:

> The RP1 is an MFD supporting a gpio controller and /pinmux/pinctrl.
> Add minimum support for the gpio only portion. The driver is in
> pinctrl folder since upcoming patches will add the pinmux/pinctrl
> support where the gpio part can be seen as an addition.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

This is a nice driver and I find no issues with it, what causes
an issue is gpiochip_set_names() as pointed out by Bartosz.
If you can live without the names you can remove that part for
now and we can merge the driver, then you can add the names
later when we sorted out how to share that function.

Yours,
Linus Walleij

