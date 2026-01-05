Return-Path: <linux-pci+bounces-43991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3002DCF2E7B
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 11:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 890773004B84
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 10:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5762DAFBB;
	Mon,  5 Jan 2026 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c6rlWbkT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F082777F9
	for <linux-pci@vger.kernel.org>; Mon,  5 Jan 2026 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767607476; cv=none; b=L3vJuo0TW/oAAfv6QBvBMyo7DX3ZOfd3C+hgnjQSIcHU1prLhw9uYh4hRZejuzoIG50ojx8WfANoCl7T/7GbOTlkgRGne3ftTvGCUHET/oaKBnRNxDPHkdwA1+/SxqR9s+LeJgADJ35aq8Y9Kc29F1i8MRrkxT/dMOYMRGTHy5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767607476; c=relaxed/simple;
	bh=JkcfIl8BKcEojFGjIazk4MDWVe9rANBCsbOBtRi+yn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHWhBzT/RZbU3qz6iItWOKBMC06lWwaBPKkY4uTWdUmPBf/JVK4uSth3pzdAoEDodrx/yLFc2QMjntAMgGt49GS6ihrj3TV3z6yhL3nyEwXrCxWedofLqad/ZetlXR5Q4znvfw5Pv46I9myg2DwJB2b1QsgKx6mPHM4M/ppESM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c6rlWbkT; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so16533944a12.2
        for <linux-pci@vger.kernel.org>; Mon, 05 Jan 2026 02:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767607473; x=1768212273; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wcJVs11fw74WQ0Su67r8AFuKhGPgqhPXzmgguyrAPQM=;
        b=c6rlWbkTSakQeBUOj46LTKavFgnPX+u+Q/uSiPUVtJh5TbduOiMFALdZDU59jv/2FL
         nmoClixdrHbbI5yUYcn122psJ3fw1fc2V2MfU7VK741b7SSBQl3sCwKn3mPSbQsLMqi/
         elPyddW7nsDdPB3IZOWJJa400JnGZkGxHbbcMDeCNbXh6kImxyuo4SwRbAfWDNY2cRH0
         xYJttz0V+c3jnuey0evaxhAfPKSmZ5j3YlY5OxW+Q0JxgPuTJr13pBc2bB9vefugFV8d
         idFpor86HfdNQIGmoWGZVDMyv219epff4uSQKDgTD2Ww39ep6xHjJh2nNZ6WS+ZfNaL0
         tD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767607473; x=1768212273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcJVs11fw74WQ0Su67r8AFuKhGPgqhPXzmgguyrAPQM=;
        b=UDJQGe3PUUJ8O4Hx8gFg0Gf5KiQmdqqzwxiki0dNPycGDoxZvF0WYuKe4D/WWjnPkI
         E2IlUtv60/cacTSPMxz7u6opfBeu0E4n0FRdU+DkOLONDwFZGssQTUoYcbOGeAqJiPfg
         E82vyKC9fUV7SXdats3UzSv+SsdWVnyp0eZBSlGqbLK5k4T7SySzOv0y3xXnCn2CSE8Q
         I8HbrolnvNgqP0d8+gK2IqREk6+ie752zyfNbJzLtWGlyVjGUfKZJ6+k1f37s4zdcm2S
         Vxxv/vfDbe4oABHYV6l3hdrUCU96QSX2USM0qC/XNj6c66Lnv+Nvs2U8WbsYFSZp5FNA
         +ADw==
X-Forwarded-Encrypted: i=1; AJvYcCUC9dh7lMGJPSOGJZHg2O5lezW7eGR23f7742MWQiKNjpBrt/8+ncZBPXqPB+18mZKeTMZTKz0e9UU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB5IEhqak7i5WxnfWi4POLtFJ2Gy8JBcbCQZnmhKqJosbrwrpf
	DLrFJu6EVx9nlqD4f6bjUHaZL/vL9UKGxVNxiCLrJ3UE5rBAL2GKsLM38UJlFXtSDxY4qQzfHKg
	ksOVIvzmEZb5zhdz2gG4HC2PKwyoe5qblCp+Qq6dWZw==
X-Gm-Gg: AY/fxX75/D3s4Sq8wTrNAOyGVVhdRPMhDP4exF3pZewuDEAtnJzt5hhpOdqa9Vs9KPI
	fFY/Kt1v1+CHjmckC2k0//6uBuKjsrg0204oGpt7DD5rqxJYS/5WxxQ31gfJKxYF2qQZPf4Xkql
	MhkV3yEKy75dxXy6TTa+oCQbFFav0U0EopWRm3SQs9AwdQjLZBOMLgg7zn9hbqYqHDhasXmcSAY
	Bfhkz17GI+NMITgNiL9+cq3OF3vOihHkcYYfGW4Ms4mWGKLV7pd3UQauYXXwcE48CsfaZNNM2pX
	9EG3E+z3ZsAJ90thAS2gmqjn
X-Google-Smtp-Source: AGHT+IEOkRWiaWbHsFNA0Xh1nF6WPLLBGqs3wNb+5iB674m6pjhEObn2ANSg0gr5GKFEms9hOIW3Npus/kadl5Ov+pc=
X-Received: by 2002:a05:6402:1474:b0:64b:588b:4375 with SMTP id
 4fb4d7f45d1cf-64b8eb62574mr45764212a12.2.1767607473153; Mon, 05 Jan 2026
 02:04:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com>
In-Reply-To: <20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 5 Jan 2026 11:04:21 +0100
X-Gm-Features: AQt7F2pI2rEFQniRu0nts8RkQpZQp4VTDXifbPjh7okMKWhQhyYthJoQyv7luHY
Message-ID: <CAKfTPtDgbkH57bahUAee8_N3QYWNuu6-jZFrJH1GW32aMiZ+og@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] PCI: dwc: Rework the error handling of
 dw_pcie_wait_for_link() API
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangsenchuan@eswincomputing.com, 
	Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Dec 2025 at 16:07, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> Hi,
>
> This series reworks the dw_pcie_wait_for_link() API to allow the callers to
> detect the absence of the device on the bus and skip the failure.
>
> Compared to v2, I've reworked the patch 2 to improve the API further and
> dropped the patch 1 that got applied (hence changed the subject). I've also
> modified the error code based on the feedback in v2 to return -ENODEV if device
> is not detected on the bus and -ETIMEDOUT otherwise. This allows the callers to
> skip the failure if device is not detected and handle error for other failure.
>
> Testing
> =======
>
> Tested this series on Rb3Gen2 board without powering on the PCIe switch. Now the
> dw_pcie_wait_for_link() API prints:
>
>         qcom-pcie 1c08000.pcie: Device not found
>
> Instead of the previous log:
>
>         qcom-pcie 1c08000.pcie: Phy link never came up

I tested the patchset with s32g399a-rdb3 and during the resume, I have:

[  460.255927] s32g-pcie 44100000.pcie: Device not found
[  460.256021] s32g-pcie 44100000.pcie: PM: dpm_run_callback():
s32g_pcie_resume_noirq returns -19
[  460.256278] s32g-pcie 44100000.pcie: PM: failed to resume noirq: error -19

I was not expecting more lines than the 1st line: Device not found,
like the init

[    2.668921] s32g-pcie 44100000.pcie: Device not found
[    2.675342] s32g-pcie 44100000.pcie: PCI host bridge to bus 0001:00

where with skip the -ENODEV case if dw_pcie_wait_for_link() fails

Should we skip the -ENODEV case in dw_pcie_resume_noirq() too ?

>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Changes in v3:
> - Dropped patch 1 that got appplied
> - Reworked the error handling of dw_pcie_wait_for_link() API further
> - Link to v2: https://lore.kernel.org/r/20251218-pci-dwc-suspend-rework-v2-0-5a7778c6094a@oss.qualcomm.com
>
> Changes in v2:
> - Changed the logic to check for Detect.Quiet/Active states
> - Collected tags and rebased on top of v6.19-rc1
> - Link to v1: https://lore.kernel.org/r/20251119-pci-dwc-suspend-rework-v1-0-aad104828562@oss.qualcomm.com
>
> ---
> Manivannan Sadhasivam (4):
>       PCI: dwc: Return -ENODEV from dw_pcie_wait_for_link() if device is not found
>       PCI: dwc: Rename and move ltssm_status_string() to pcie-designware.c
>       PCI: dwc: Rework the error print of dw_pcie_wait_for_link()
>       PCI: dwc: Only skip the dw_pcie_wait_for_link() failure if it returns -ENODEV
>
>  .../pci/controller/dwc/pcie-designware-debugfs.c   | 54 +---------------
>  drivers/pci/controller/dwc/pcie-designware-host.c  |  6 +-
>  drivers/pci/controller/dwc/pcie-designware.c       | 75 +++++++++++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h       |  2 +
>  4 files changed, 80 insertions(+), 57 deletions(-)
> ---
> base-commit: 68ac85fb42cfeb081cf029acdd8aace55ed375a2
> change-id: 20251119-pci-dwc-suspend-rework-8b0515a38679
>
> Best regards,
> --
> Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
>

