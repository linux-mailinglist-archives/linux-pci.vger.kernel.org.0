Return-Path: <linux-pci+bounces-18026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BCD9EB10A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 13:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFFB6286978
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 12:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A431C1A9B31;
	Tue, 10 Dec 2024 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="R7ZkHnPB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FDB1A0BE3
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733834431; cv=none; b=O4BjTtOY0Oy+pSrriQZhNJZ4/pvcAr6N6uCZ7c+h//bPkopTr8vACjpURqk0QmWWyg9cNbCT7oH6zX1U7/Uy9uRDcmEde7jdlQOPxtVU7kXZ4IOE12fZBVGG6iigqgdyGnsug4K4w3ZWvaKMTyN8uhQHl4iHkjkM46Usksmy+h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733834431; c=relaxed/simple;
	bh=qoCJN0XDlVXX2rDBm9MupgcHVuexB/4QMq/Ob6ML5Mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRdBgNm/Zj2fN91W3npd0t/Ds/ksHKRT6cwbYasWBY9fsXyCkQS/lvy15IypQ2zvVTUumcCQM4ZKAANOSbvMJCMysGwuSnakawyc2bwT55fC4n6FJDOkYC5xI/Vh0t1H+aB+NSiIMtVeklrzd6rDXjgBBEMfBijk3zTKSJfd4Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=R7ZkHnPB; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54026562221so566286e87.1
        for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 04:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733834427; x=1734439227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uec8wtN5bXe/z6NMkpZDWqH1CVWwSVG3n4rX7hz3fG4=;
        b=R7ZkHnPB2KaMhz+CIlrSzDtLCdfvUz9lnID31x/AxCKNd22Bzhb5ZF4ue3m21E3Vhq
         wuYthkWDFMZggycfb3Y/ZarU9Y3esqtAwV2mAJ4oJr9pIm3bQGcK0IvY7PJZKgNXOfbG
         Xfwpuvq27yR8Ryl3bkI+5EWEA+oVHckneTn1vTlvEEfMoqhYFA4mvEd59ejOmkIUwFJE
         duzNdVic0KMFWfBK4w2U2ulw/CglfUBUlto5uBB+RGx7JimdeL2bFbHmJtLOSIm4pcf6
         hyNstnVpnXAUjTwg050g6x+M5DKqCCk3oscXJPLn7L4DMVy+FVVG9zkY3Mejl1xO5+Zq
         QIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733834427; x=1734439227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uec8wtN5bXe/z6NMkpZDWqH1CVWwSVG3n4rX7hz3fG4=;
        b=NYtf+NwoZFha+1dW7ehGIEuvbXUQYMm+Co51tt7aW/vI1O3PIe6CUPU4D8TZBSoOA5
         1PKkllicAH2hoS8RYJm8Xy7soVEx3FnNqBKh8m2itZR00+jIPtWB1iHER/4dGMKVMUb5
         t/gUmZJlb3qq9HweIzAgRCO1X9rZrkjr2BxkWdE89JyK8r7q12mx6jS0H4msf+IcnWbc
         EWyVx395qlpwNqKMvmS7z76UCypiQKA3rLo7uibEU2eT8I2Js0y5lpalIBIrPg1iakdP
         AwqKgTasxyhQPRB5UNz0DAfFzSU/4dfrqrtMFCdIIaOPCJpJSJE4p1Aoyg1Czsdi1aCc
         exGw==
X-Forwarded-Encrypted: i=1; AJvYcCXLwiH7sxBe3uzMF9x6jhrimhWqavrtQ4+S73oeqzgV9E6TPJfofq0GFAOhjolMPBu0K5Glgw+zZjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypET03UWrBfKir+apl+3mW83DpODUFWTT8mg2Gu9TyvnjFR/1+
	cozhdEH2hbFtJX3NE1VKEX+UrW5Ic+mtAtLCj1IxqhQ9399S0XW2yDKZVdrV/4rrmjVKQBT/u5m
	yjWtXKeHsaXtzqgjc8jMsXwO/S64Pr1EFuMJb+Q==
X-Gm-Gg: ASbGncurlAiQBIrPvUCPjbcgMOOiE/nIIOdS1Gil5DVoCmwFygfbwlGueDqHeprdqBO
	n589CoThvUczBf6QI7Gl3ypIP9aA7xz9xH/hJD+dvw7Z1wvWa0GAendmJya81WG4m35s=
X-Google-Smtp-Source: AGHT+IFVqvL+/GHDQ61RDn9o0FC8nZtPyXuew4DHpnWom1eAfh3AOK8aU1e1lybYBJfU4Hxy8Svd7zdyP/lhOowaxnw=
X-Received: by 2002:a05:6512:33ca:b0:53f:8c46:42bb with SMTP id
 2adb3069b0e04-540241078d3mr1419815e87.40.1733834426836; Tue, 10 Dec 2024
 04:40:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
In-Reply-To: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 10 Dec 2024 13:40:16 +0100
Message-ID: <CAMRc=Me39w3oPWQkiGBqY3xSv6AphX6f2oBSEA6WHtmaSbKb3g@mail.gmail.com>
Subject: Re: [PATCH 0/4] PCI/pwrctrl: Rework pwrctrl driver integration and
 add driver for PCI slot
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Qiang Yu <quic_qianyu@quicinc.com>, Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 10:55=E2=80=AFAM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.linaro.org@kernel.org> wrote:
>
> Hi,
>
> This series reworks the PCI pwrctrl integration (again) by moving the cre=
ation
> and removal of pwrctrl devices to pci_scan_device() and pci_destroy_dev()=
 APIs.
> This is based on the suggestion provided by Lukas Wunner [1][2]. With thi=
s
> change, it is now possible to create pwrctrl devices for PCI bridges as w=
ell.
> This is required to control the power state of the PCI slots in a system.=
 Since
> the PCI slots are not explicitly defined in devicetree, the agreement is =
to
> define the supplies for PCI slots in PCI bridge nodes itself [3].
>
> Based on this, a pwrctrl driver to control the supplies of PCI slots are =
also
> added in patch 4. With this driver, it is now possible to control the vol=
tage
> regulators powering the PCI slots defined in PCI bridge nodes as below:
>
> ```
> pcie@0 {
>         compatible "pciclass,0604"
>         ...
>
>         vpcie12v-supply =3D <&vpcie12v_reg>;
>         vpcie3v3-supply =3D <&vpcie3v3_reg>;
>         vpcie3v3aux-supply =3D <&vpcie3v3aux_reg>;
> };
> ```
>
> To make use of this driver, the PCI bridge DT node should also have the
> compatible "pciclass,0604". But adding this compatible triggers the follo=
wing
> checkpatch warning:
>
> WARNING: DT compatible string vendor "pciclass" appears un-documented --
> check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
>
> For fixing it, I added patch 3. But due to some reason, checkpatch is not
> picking the 'pciclass' vendor prefix alone, and requires adding the full
> compatible 'pciclass,0604' in the vendor-prefixes list. Since my perl ski=
lls are
> not great, I'm leaving it in the hands of Rob to fix the checkpatch scrip=
t.
>
> [1] https://lore.kernel.org/linux-pci/Z0yLDBMAsh0yKWf2@wunner.de
> [2] https://lore.kernel.org/linux-pci/Z0xAdQ2ozspEnV5g@wunner.de
> [3] https://github.com/devicetree-org/dt-schema/issues/145
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> Manivannan Sadhasivam (4):
>       PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()
>       PCI/pwrctrl: Move pci_pwrctrl_unregister() to pci_destroy_dev()
>       dt-bindings: vendor-prefixes: Document the 'pciclass' prefix
>       PCI/pwrctrl: Add pwrctrl driver for PCI Slots
>
>  .../devicetree/bindings/vendor-prefixes.yaml       |  2 +-
>  drivers/pci/bus.c                                  | 43 ----------
>  drivers/pci/probe.c                                | 34 ++++++++
>  drivers/pci/pwrctrl/Kconfig                        | 11 +++
>  drivers/pci/pwrctrl/Makefile                       |  3 +
>  drivers/pci/pwrctrl/core.c                         |  2 +-
>  drivers/pci/pwrctrl/slot.c                         | 93 ++++++++++++++++=
++++++
>  drivers/pci/remove.c                               |  2 +-
>  8 files changed, 144 insertions(+), 46 deletions(-)
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241210-pci-pwrctrl-slot-02c0ec63172f
>
> Best regards,
> --
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
>

Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

