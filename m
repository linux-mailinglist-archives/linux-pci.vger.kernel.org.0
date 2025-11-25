Return-Path: <linux-pci+bounces-42014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC5CC83AFC
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 08:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A16B4E490C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 07:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF592D6E74;
	Tue, 25 Nov 2025 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XSEegx2q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B775285404
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055108; cv=none; b=gtg+a8GHxMb0aAVhyAjOAb/QhZD2WrfqodEf/mqUpoMaPM5ciX35ATs6Moai8q/EirPxkwhUD4ItO8SU2SRep57fhHXWYhf5lUjd/fK6iL1cA4xYm3coL8+6Tngc2aaeKatR5R9JUBEO/1ezTntL/gjuet6ICKJT5Qv+81ZP/JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055108; c=relaxed/simple;
	bh=Tz3LbhzJhL2NF3VwtgFGi4NJlgrEkYE+TVA7VGJCjo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b866Hqf1LRQMgfz3BjhnAchLlSqqehAoOcX2Gv2DGpvhn36tMIPBXZAk5Fkzqy2dgkvYRbJuXmASoD0eBPhzcyPaKMR/xqtuDi5sWvDeMP+9Dh4tqeDw8WewSERCW7Q8T8m8mri0pVN6ScXynB8ONssomkPHxuCTYQze2JfTsio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XSEegx2q; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5957db5bdedso5345093e87.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 23:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764055104; x=1764659904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9KLrVH2R0wRtcEdh32X6NYZk3WdTp2IqjBZ1pxFS/A=;
        b=XSEegx2q41pvUJLinnDVwbpShi1OI0s6HwnzS4G2WOgUvdABQwbMb5hWtND2JPg0YN
         xXyKPpgmHokAznJfu3UR1xBISXTAn9yCZernqc6xTyklGoJtT1drq6OYEE8rOJCu8BMz
         CDzzhq1JDR9rTdOeyphpGJMxEKQ1Xwu4j8u8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764055104; x=1764659904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C9KLrVH2R0wRtcEdh32X6NYZk3WdTp2IqjBZ1pxFS/A=;
        b=k7zi1vibUKc5fZFbSWH4vl4y+oapBlljDzLgp0d5K4Rd9hx8Upl6CTzkpEM+eNkMUE
         gmlzKI+hW8Ga/m2i/kxnzn2yfDI7f9SEEugv8d6281j9p65AxP4aZN20mLB0OR3EahZ5
         E9GNMHVF+ya18BLQJu2HMM5uxsdDxbyKPzbCqFBIaWiWxFlZbRU9yekuUkWywKS2IoCs
         No8fmpOBqJPthIB6Yxuk06UNqNzjy8+Q/3ygkMGPOv+YIlx6Fqc3JTWgqBGs0AnNf2OM
         CQW5GEEtdRi7JjUnCmVvwAF5W5YKBBJGNANNfcQgDRyr7RKjbUVv28QJZ2XFSTYC4oT9
         Vv2w==
X-Forwarded-Encrypted: i=1; AJvYcCXxpC1T7SrBWviIzY4AH584PpISGFIDMW2cowRVH1+L0TM7sduO43v9AueollvmHFZmt1nnLiHDHb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzccMdCeOqvHPx7Cms/oO/+cbRIwNUWcNdn4PtLjEd5g9AYNvO8
	xxgewW9GHjxUpT9wPFnLg1RR0U/jDaL6sX07u82qeBAfgBwCLehrrK3Ri1flFRNLX7VHHlRV9Tq
	t/Yk7RGDeXCwRr5+U8rvVq3+LcnsBzEjWiJCs6pNN
X-Gm-Gg: ASbGnctwDDeRiqZYubVE1wW4UO+qs+9q9McSe6uXnuDDZ8bAYaEb1sbBTPujaKFCT4v
	PfxCTNKxxqLXnx+lez7O5AMY70313qJOZ4lzDpOlE/Ooz7ER9JoYI6QOs0T4y235IO5ZZwqwV2V
	8QFztFNI9RJZrCELzogPYq+7B4lTVq/aGtpSrU1YgTKQB5OUd01SWbWV2Bu2DBT9Ufn8PajwdeD
	hFGM12fj6n7R8u5m7Kpe6nTl1iGW26DvJf/ICo03t2DnoEewnf8/SCL2+wkaUbdB+wndljpTI84
	ptT4Ol1AT2Cvh3gdFupAn9PO/UatL+Mkx621
X-Google-Smtp-Source: AGHT+IGrhybsyZ3HltBSJRrIxp5NbHesaqk0urlgmn2HoCi5Pbbf8Ic/TZ9/x6CZveL7/LiBNbNSgJFr7pcd5+HwKoo=
X-Received: by 2002:a05:6512:3b95:b0:594:2f1a:6ff0 with SMTP id
 2adb3069b0e04-596a3e9fc38mr6083359e87.9.1764055103647; Mon, 24 Nov 2025
 23:18:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com> <20251124-pci-pwrctrl-rework-v1-5-78a72627683d@oss.qualcomm.com>
In-Reply-To: <20251124-pci-pwrctrl-rework-v1-5-78a72627683d@oss.qualcomm.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 25 Nov 2025 15:18:12 +0800
X-Gm-Features: AWmQ_blmfM4D42BW0mtigbQ0zM4iSkiLMdvXtsaw49mXE-k5hVXEr2ekLrwjHJY
Message-ID: <CAGXv+5FnL_uvz2F6WDLwY-cwdQAqFicRTt26Pnqo-nqAhf4ikg@mail.gmail.com>
Subject: Re: [PATCH 5/5] PCI/pwrctrl: Switch to the new pwrctrl APIs
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Niklas Cassel <cassel@kernel.org>, 
	Alex Elder <elder@riscstar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 3:15=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> wrote:
>
> Adopt the recently introduced pwrctrl APIs to create, power on, destroy,
> and power off pwrctrl devices. In qcom_pcie_host_init(), call
> pci_pwrctrl_create_devices() to create devices, then
> pci_pwrctrl_power_on_devices() to power them on, both after controller
> resource initialization. Once successful, deassert PERST# for all devices=
.
>
> In qcom_pcie_host_deinit(), call pci_pwrctrl_power_off_devices() after
> asserting PERST#. Note that pci_pwrctrl_destroy_devices() is not called
> here, as deinit is only invoked during system suspend where device
> destruction is unnecessary. If the driver becomes removable in future,
> pci_pwrctrl_destroy_devices() should be called in the remove() handler.
>
> At last, remove the old pwrctrl framework code from the PCI core, as the
> new APIs are now the sole consumer of pwrctrl functionality. And also do
> not power on the pwrctrl drivers during probe() as this is now handled by
> the APIs.
>
> Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.=
com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c   | 22 ++++++++++--
>  drivers/pci/probe.c                      | 59 --------------------------=
------
>  drivers/pci/pwrctrl/core.c               | 15 --------
>  drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c |  5 ---
>  drivers/pci/pwrctrl/slot.c               |  2 --
>  drivers/pci/remove.c                     | 20 -----------
>  6 files changed, 20 insertions(+), 103 deletions(-)

[...]

> @@ -66,7 +47,6 @@ static void pci_destroy_dev(struct pci_dev *dev)
>         pci_doe_destroy(dev);
>         pcie_aspm_exit_link_state(dev);
>         pci_bridge_d3_update(dev);
> -       pci_pwrctrl_unregister(&dev->dev);
>         pci_free_resources(dev);
>         put_device(&dev->dev);

This hunk has a minor conflict with

    079115370d00 PCI/IDE: Initialize an ID for all IDE streams

already in linux-next.

>  }
>
> --
> 2.48.1
>

