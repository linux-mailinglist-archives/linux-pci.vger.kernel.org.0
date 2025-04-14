Return-Path: <linux-pci+bounces-25839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F871A8847E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 16:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE4A1628B7
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 14:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04093252289;
	Mon, 14 Apr 2025 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqTqEbei"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2422252287;
	Mon, 14 Apr 2025 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744638625; cv=none; b=TucHVdob2AGcHMVLns4ltgh9cX2v7A9nZwMR3VF750ao7XVbyVIqhVM7y92ZR4ciSgZCoSrPH4xjmlumlcQnXEiTjawbLzCxkN26bA429xxikZh/mLA40bg12DZhqweAWks3b9pfU2k3HydyyC7z0voCVjQQ6l2Igd/vgX+bJKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744638625; c=relaxed/simple;
	bh=lDtbpfkDb0sbJyDh75g32G6rT05Ooc8LqydQ7WPPzwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poDezXBIboPbZMup7lx1XiUufdyUroIG03c7EBTdTkftcPq64IYabNeLmtYB3SSJ96BJYX4uUk3LAH0Noc8d9OMVnFkB82LHm3m8HQEkxAdKsLSHQJKCSzoi3lenVITJPzxoFeipqzUZwtjtFi6KODwIE0s9JaplX88glsZ9/rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqTqEbei; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so730868666b.1;
        Mon, 14 Apr 2025 06:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744638622; x=1745243422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrroSWvo72WiUi9EHy2B6vrgLkP9ABP6R6n5k4cIqGo=;
        b=fqTqEbei3jqsaBfSk5hNh2aQlOzwV+b8bDsPH56r6z4t9TwLGS7Qb/no+DoJUIlmgX
         Wcq9H/iwqDhXg/PtFwYAwwlX3nWe0yjcd9ysk1cjC32tAKkCaZFomefyI3uha+6JpyCr
         flbUMj5GfCzPMW5lpu19g+00K5vWqdIi82IzRbnjnxfYedCh4c3p9t/UEjKtBkjec3Ma
         0CcQssiA1mluRdtCzEFRNMzDrbwgzmWY++ZjAn13YpXEPUGedKPGUD88i7JMeiMm0MJn
         v9gayZNGoXClhFllUNpSN6Nznb17sF+JYAmwuYLY+C9oiAKl5h29VfIGrrxxlgNTm+vA
         vR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744638622; x=1745243422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrroSWvo72WiUi9EHy2B6vrgLkP9ABP6R6n5k4cIqGo=;
        b=b++HJ+Kf/9DDqpCxL+0l2UyIVUiDIJSPR2tQKudBTPBJtZ/RLy2pNgAas8naIwhK13
         mLfO8noTFmwe5RVAcKRx6J7v7OExzrFp2jLjowZRViSiDxvzq308VizoHY/o0jKRQ1EL
         jxM/GoORVvWB9HAEORSpoh+1xEzQWPqkQ7x6paWz9hd20a+M1fB/uY5eTZuCCiZEtPVL
         BCIpoUyKDqCIqxV3Xc9qj+TUefyVWot+NTvRgNahFQ64HQ37sNCyaOlrhXmuU0MySbkc
         BRsR+G1/U3V3PgjnUTtSksPVZwnWrnP+zD3obOZHYAWy71+Nu6kLdfey9F67mvo8QWod
         meng==
X-Forwarded-Encrypted: i=1; AJvYcCVvuiQs4i26UhVTRYX/KPNCu/6D8M7EO3mpYlTRb/1OB6sWw7x+Tzovu70lOt5gHo485I1TYLUjttM=@vger.kernel.org, AJvYcCWERwTjAdh42QNmed/1dUKWACa0ffjOdiN9Sr/wF5OvH9kUY/9D8a9rg7cHfAEWhZL4cYGyxF5E@vger.kernel.org
X-Gm-Message-State: AOJu0YzPrePLR4woPBwJUrlKhp9GF/TqCxsEGkM7WtGHoOY4OD4kHcGc
	owX4m1fSyPm5gX+4mSvO9UwKaG6JHDRVWdM9CeJAmmY0LeR3UXBcYRh1ga/ogWCDSpUmbl25hxR
	YGZ9Czv714VOUNVsiGg/fgD4cNXo=
X-Gm-Gg: ASbGnctGBaYIvC3YW0wAQPseUrNUEBsAcGDEdXo0n6TgrfN3B+lojRNXLxpD9emwcGN
	tnwGiNEwRpTV0i5Q+0//DgcA/5oqcyym6ePVwYXgCYRCqE+wR6709VSjZXFlLiMkSzGzkG9e8of
	eLD5NJfeKMeP60e+GWav4FAg==
X-Google-Smtp-Source: AGHT+IEtba8dgXQ4QEsemJaFPww7CAC7Vm/VHKvp9nxvo9rouUeXAB0Hu4l+P++1InTuvbKunMVr5DbBgVKohUQ5PGc=
X-Received: by 2002:a17:907:2ce2:b0:ac1:f5a4:6da5 with SMTP id
 a640c23a62f3a-acad359b1e3mr1004798366b.37.1744638621723; Mon, 14 Apr 2025
 06:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403040756.720409-1-chenhuacai@loongson.cn>
In-Reply-To: <20250403040756.720409-1-chenhuacai@loongson.cn>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Mon, 14 Apr 2025 21:50:18 +0800
X-Gm-Features: ATxdqUFe-VE5EU624oOl8szgIy_2nN3Sdsg23Hn5hcZ5BlvhdRLC_V7ChQkKipA
Message-ID: <CAAhV-H4FwdDM9UEFE8hcsaL+pY1+ky5twrp3VLXGThX6qgkozQ@mail.gmail.com>
Subject: Re: [PATCH V2] PCI: Add ACS quirk for Loongson PCIe
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	Jianmin Lv <lvjianmin@loongson.cn>, Xuefeng Li <lixuefeng@loongson.cn>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org, 
	Xianglai Li <lixianglai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping?

Huacai

On Thu, Apr 3, 2025 at 12:08=E2=80=AFPM Huacai Chen <chenhuacai@loongson.cn=
> wrote:
>
> Loongson PCIe Root Ports don't advertise an ACS capability, but they do
> not allow peer-to-peer transactions between Root Ports. Add an ACS quirk
> so each Root Port can be in a separate IOMMU group.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Add more device ids.
>
>  drivers/pci/quirks.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 8d610c17e0f2..eee96ad03614 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4995,6 +4995,18 @@ static int pci_quirk_brcm_acs(struct pci_dev *dev,=
 u16 acs_flags)
>                 PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
>  }
>
> +static int pci_quirk_loongson_acs(struct pci_dev *dev, u16 acs_flags)
> +{
> +       /*
> +        * Loongson PCIe Root Ports don't advertise an ACS capability, bu=
t
> +        * they do not allow peer-to-peer transactions between Root Ports=
.
> +        * Allow each Root Port to be in a separate IOMMU group by maskin=
g
> +        * SV/RR/CR/UF bits.
> +        */
> +       return pci_acs_ctrl_enabled(acs_flags,
> +               PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
> +}
> +
>  /*
>   * Wangxun 40G/25G/10G/1G NICs have no ACS capability, but on
>   * multi-function devices, the hardware isolates the functions by
> @@ -5128,6 +5140,17 @@ static const struct pci_dev_acs_enabled {
>         { PCI_VENDOR_ID_BROADCOM, 0x1762, pci_quirk_mf_endpoint_acs },
>         { PCI_VENDOR_ID_BROADCOM, 0x1763, pci_quirk_mf_endpoint_acs },
>         { PCI_VENDOR_ID_BROADCOM, 0xD714, pci_quirk_brcm_acs },
> +       /* Loongson PCIe Root Ports */
> +       { PCI_VENDOR_ID_LOONGSON, 0x3C09, pci_quirk_loongson_acs },
> +       { PCI_VENDOR_ID_LOONGSON, 0x3C19, pci_quirk_loongson_acs },
> +       { PCI_VENDOR_ID_LOONGSON, 0x3C29, pci_quirk_loongson_acs },
> +       { PCI_VENDOR_ID_LOONGSON, 0x7A09, pci_quirk_loongson_acs },
> +       { PCI_VENDOR_ID_LOONGSON, 0x7A19, pci_quirk_loongson_acs },
> +       { PCI_VENDOR_ID_LOONGSON, 0x7A29, pci_quirk_loongson_acs },
> +       { PCI_VENDOR_ID_LOONGSON, 0x7A39, pci_quirk_loongson_acs },
> +       { PCI_VENDOR_ID_LOONGSON, 0x7A49, pci_quirk_loongson_acs },
> +       { PCI_VENDOR_ID_LOONGSON, 0x7A59, pci_quirk_loongson_acs },
> +       { PCI_VENDOR_ID_LOONGSON, 0x7A69, pci_quirk_loongson_acs },
>         /* Amazon Annapurna Labs */
>         { PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031, pci_quirk_al_acs }=
,
>         /* Zhaoxin multi-function devices */
> --
> 2.47.1
>

