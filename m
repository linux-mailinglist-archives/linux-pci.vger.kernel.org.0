Return-Path: <linux-pci+bounces-25214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B12A79CA5
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 09:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3994417192B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 07:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA8923F26A;
	Thu,  3 Apr 2025 07:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="riYps+6s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F7C208997
	for <linux-pci@vger.kernel.org>; Thu,  3 Apr 2025 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743664281; cv=none; b=mQEBcWdXSTDrpNeneULn/S8kq1MW1m7z76J08jUTov69SbDJY8CRArPOk3+o/U+pgR18VdOuBn+79ypLK1ETF/w4XE68kaORCXVxYMP0K+/AlOtvmATci3RACmMjDO7Jy5LaFsmr6A3byFVElM+aF7/AeQWz5BzUwzfr6hAQzMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743664281; c=relaxed/simple;
	bh=vJ0Do/5yInpJts5TcS9oFarGP2cYAYOdQDj3i6kaNC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzEBnIF1KLCU2zr3g7f+G4XOi4uNGMigMg4rw+zvOSo3w5dDFiptUZ4Sh2ek0MYm/r8PP18Rj5WpZHie5bLrro99+QgVzGL2XmFRRcWmTKo3zDZBY3y3MVr565Ek8UUulxr16ikiOzOpq/Io4SVFqlsGXHxed57XCnF5cuTouyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=riYps+6s; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30c091b54aaso5420201fa.3
        for <linux-pci@vger.kernel.org>; Thu, 03 Apr 2025 00:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1743664278; x=1744269078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJ0Do/5yInpJts5TcS9oFarGP2cYAYOdQDj3i6kaNC8=;
        b=riYps+6sKJPSvRgNGshxMnSp0eYbkkbCMuLByP48sowp/ixmosWHsFey7dzgyiHwEy
         JGpIucDX3a16ZATLwQ1OkfFwq1vHTrAE2XIAGsHy4y4vM09N8q9RHPeHkH1jPCh5O8sT
         TN92hj+RqjgYOjIfbA+U/i6DKsBKWgutvh0Bd9T24zsfQ082k+9He3XLM+SDgtPL1w/V
         nUVN3JPq3wDtUDC9DtGfPPasLmpNMM6Wz6uLdwv6Jeey2rQy8sj3xPNxe6D2f8FxEoql
         ouAtd77f/tvehFO/8kqi8VVRnK11ZOE+zuKzWjH5pWk7Wvp121PgcsGgvJs6QrB9B+iK
         mieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743664278; x=1744269078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJ0Do/5yInpJts5TcS9oFarGP2cYAYOdQDj3i6kaNC8=;
        b=w8XRTWeIq2OLKuiT2t8zvbU66GotM1eQ1cu0KPI5tSl5fUo/GQPi8L7+pXRX52QI4A
         RmLDOSoA+kolmR5BV1RJrYb4cq1pgmXwxei3ItkSFuuFmw9CcowhOLLEkSIOQR7hQiT+
         YdezIxWiXDbJ9GIUJp58F0SpTpinDO4iX1i+B2sugLfovrTDHZm1FaZo6AkcQN/3iMAE
         RMG5RfGvEJP3AVo9ly2vI0VgIM2HXlqY9wYtBWKZNXIuvTpNM6aAQQ71JnB5aPdMKv9P
         Bs1xES37i5AMiaj5hOnnIZ97hvjE2r0vS5jxQFI/87tnPkkXTBffGyezTWNqSa9im4cs
         T6Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXjJS9/Rv7/ARN1LySqcCbjOTKMWwZHflqDv/GEpH85KRec3koifpWLM9eM3Z/2NrZDhg2vk4LeIzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx4dsUm2B9+E1B0flD2T0N6dMkpQkm/SgSYqr/ManFAQHbIjmK
	GQxNE4HOFTmERustRmNe6glxZw/7MVhAOIY9hmmymHYWaw+D+J0rDQUAOkpTqJ+dpxScTdhLWyv
	lAg3HA3q80413/PDMyNMVLjiKLtgSHENVg2yb1Xi4nsKqrIbV
X-Gm-Gg: ASbGncvCk74KgsTPAFHDADKHDl8DeXb66VJnDfKUrHTE1D5mslGx3Gk8K6VI9UhwRXt
	YHnir03tqfmUMEyB19/IzBB+Rd1EFiDxL2ykk0zuNBXGHn7GUBVJ0vBSAde6/ltbOI4gDdKdFYJ
	fePO0ZCL1G4Z/His9C1Vakyq3DKJd0U1g5ihhYgzeAhL2XHylEg46UIOwa
X-Google-Smtp-Source: AGHT+IFkpl28huUxLnkOG8+JoZRPAuyoYj8fAmCyXd4tv38/gNFXW7fiJiUp5ulgWcmnVTNmKGEylZ2WlPrLdyIQcMA=
X-Received: by 2002:a05:651c:1475:b0:30c:7a7:e87c with SMTP id
 38308e7fff4ca-30ef91e9c23mr19952681fa.35.1743664277849; Thu, 03 Apr 2025
 00:11:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402132634.18065-1-johan+linaro@kernel.org>
In-Reply-To: <20250402132634.18065-1-johan+linaro@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 3 Apr 2025 09:11:07 +0200
X-Gm-Features: AQ5f1JoNoWRTnOEMbH9dyhhofmJuk8_vYCLRQWl_3nQ0kPEBcd2NI2XoNIkV_Zo
Message-ID: <CAMRc=Mfpm8=q1mkfNfjPtogbh1S9PKU+w_2yMP+oE_Gj7-qemQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PCI/arm64/ath11k/ath12k: Rename pwrctrl Kconfig symbols
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jonas Gorski <jonas.gorski@gmail.com>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 3:27=E2=80=AFPM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> The PCI pwrctrl framework was renamed after being merged, but the
> Kconfig symbols still reflect the old name ("pwrctl" without an "r").
>
> This leads to people not knowing how to refer to the framework in
> writing, inconsistencies in module naming, etc.
>
> Let's rename also the Kconfig symbols before this gets any worse.
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I'm re-adding the tag here as otherwise b4 will only pick it up for
patch 4/4 on v2 of the series.

Bartosz

