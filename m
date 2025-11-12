Return-Path: <linux-pci+bounces-41002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D2DC52F01
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 16:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2148D3545F9
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 15:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852EB34D38A;
	Wed, 12 Nov 2025 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="X0NM6JoW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A414634B1A9
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959610; cv=none; b=Gx1Asm6RronnACA2d6cxIKh+rnHzU0BAW09JSlB1BmCkE3mdu1xZ1ZpP/jMrYR7JElBgQCegyUVfy+5ip9DRHan+T2OM1uGaRKTr0A+NyGyKzhCIY0mNSOxbKJswboU0z5A+2pGDDEDly42J5a5rIMFsIPaA/s7mNYgHlpizFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959610; c=relaxed/simple;
	bh=AitKwurl0RZQ42Z6io85kiDDF35RvnC+HaXcObo6dj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFeWW9gaXbHl4Nd06GhuWcZ2MNfapkUXbYbASqtvEajC9snz3eOj1ZZ98nPeXhCC/zk2BHrXXCawcmTtFdjWagAKr7Jh+/IESV46VNOjYOMqK92VLfMy0N0wKRxw95L7QLxJNMp3uvx0Dy0DnDvsS8mSc8w6Ess2sj6w9xcl/cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=X0NM6JoW; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-592f7e50da2so1163640e87.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 07:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762959607; x=1763564407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AitKwurl0RZQ42Z6io85kiDDF35RvnC+HaXcObo6dj0=;
        b=X0NM6JoWO3vCIkMCOghqijtCg3SeWhol9lAhtWz18k6Sn8W3yt71kZD3JkmCK+4kR3
         MUnCp18H92Z1iff18JrNUpN/Rd6S6Z5aP2p051Eb8FrVcBoX1s+8YFxP3NgtIb6SxRtk
         k71ekbnddmkWRIJIThxNn3kGT37sYi5u+4eOYidWHisGrH8hJnOl4wlr1igPGFTgvamE
         3zwAODUkvTa4xWIx5sVjvN6qMNLk3wbun6lLxuifjUTKI0eJ9jWpgD7ly5JdtM+kaivM
         XLtdi7C74PsoMrI1aGGZWTI5aHDyXtgo15C8V834ysGrQepz0BMTRU1P4R76Py8iN3G6
         aWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762959607; x=1763564407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AitKwurl0RZQ42Z6io85kiDDF35RvnC+HaXcObo6dj0=;
        b=mw73tVn38CrAFyiBuiquIGNA/aDLAXhe8TROe+d5QkhfUVbR5pApcpQ0mlo24izlft
         xELf9sBFWxOGPxdMoWrBM7MeGglWTBv/07v26BRAbTockBcAkNZTMf7irNqL16ic83HD
         O+ccwLcJ6wvvsXD6TpZ4vUV3e+bd21TkEhvYY0/K0Hrjckh/E3qi6vN6bfXV/0wVmeQx
         VqlDHBPlxgDBGs5WCOOFtmQuKNzSi5ls2Lm9PQ7e9VIz8Q369udv5w3fTa9ikP2h8KUF
         RlXZdfj5eKAk2BmjXgAgK8vMv+uz6B9X2wsmRZeClQ/B2EBL9qVsRgToHCZjGgLk3v/I
         j/Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVq9SXiGbGVtj/nhEK+wvcz3cocgVQQrDB9znwdP0sgEGFBGEXhs4OUuIkiPYSKbgIIYEk/W7/nvTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrcdeBchJvjlVBDcuIhcQw/UYFcgBJmpvkwPUdjvg+do1K+Q+2
	re+kankmlY3HVE1NGcQoZWkGeBg3s/s1llEtWUu0/4FpGrAbV9H4pCWoCb14krVfT4O9Udll9VN
	6JZeh6tcyq4WZt0QvAoFp/diGxgwuv0Py6Y3+al+SnQ==
X-Gm-Gg: ASbGncs9uaQ5a6MiEErB+Y7ZyUUjPdbWz4qxF0A+KsZGQIGzJYsei+S7FMHbj8oS292
	gEqmh9NEdZgVICMmASADi8vHBs0BYuLLwlgq2a1mpA6aB+T8PdfjRPJvqSGA5ml/tHZY/QuIbJq
	AuXR0Wx3RLDD7IG3KSdMdigKPo48QRaHr7WDI3/mALg3ENJXXgg/ycGnbeLqggkjv9BmCAV945G
	7mvnrU20wdl0un8v7724ynK3ItOICcOZ5+GfSkqNX76kiTOV+o7wEYnDJuOKMlwdCdA3kN6bHoe
	+khxhSEoECIk
X-Google-Smtp-Source: AGHT+IHJlMhc97BIbUXAmDMRKBFEzcYUIzG9wOUoHY7EvexUIuj9NB/ckjr2BS4pe1nb7zekpoNjYTR8GQ8gWpKStzg=
X-Received: by 2002:a05:6512:12c5:b0:594:27de:77e7 with SMTP id
 2adb3069b0e04-59576e6adcbmr1074429e87.15.1762959606578; Wed, 12 Nov 2025
 07:00:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com> <20251108-pci-m2-v2-2-e8bc4d7bf42d@oss.qualcomm.com>
In-Reply-To: <20251108-pci-m2-v2-2-e8bc4d7bf42d@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 12 Nov 2025 15:59:53 +0100
X-Gm-Features: AWmQ_bmPrX98SnIay2Tpg2LShNsYicURP0Ag78YAbsYoHwDKuqWeMRjHIudWFWg
Message-ID: <CAMRc=Mcoi7koQBDyKPGet=FGX0emExRBhWMKW14fPmk217y2Ow@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] PCI/pwrctrl: Add support for handling PCIe M.2 connectors
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 4:23=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> wrote:
>
> Add support for handling the PCIe M.2 connectors as Power Sequencing
> devices. These connectors are exposed as the Power Sequencing devices
> as they often support multiple interfaces like PCIe/SATA, USB/UART to the
> host machine and each interfaces could be driven by different client
> drivers at the same time.
>
> This driver handles the PCIe interface of these connectors. It first chec=
ks
> for the presence of the graph port in the Root Port node with the help of
> of_graph_is_present() API, if present, it acquires/poweres ON the
> corresponding pwrseq device.
>
> Once the pwrseq device is powered ON, the driver will skip parsing the Ro=
ot
> Port/Slot resources and registers with the pwrctrl framework.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

