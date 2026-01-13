Return-Path: <linux-pci+bounces-44658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3C4D1AC1C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 18:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48154306FC7A
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CCC393DD3;
	Tue, 13 Jan 2026 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gl5pM11Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F58438F258
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768326829; cv=none; b=RshcSK46udqktfL/FtKjD2nF4funKqb6JfrWAhJTXWU7pxdrnQkokR2krpnWk2UkMvajPUVrPKhHQA816MLrQONKTx1fT5WAdEA6FilN/IU5C/XujTH5t+G27+KchrM7b5AYuUFFcWnX0rTvHh1o8/2vR8aT13rI6jJo7LUyifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768326829; c=relaxed/simple;
	bh=seF3cu63YIHrYZBUcbRSE0NoZqRBzkw6qJFrJV/JCnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6nQ4SI3XyjVsy8ssNDiw5iQcuqH5FlaKfubFsvYCc9b13sb9wQsHXEp2pjsl9cnoonZvSn783cwvMXR+CT71p3GlKtf3R0U0CWB0wKK8+IzQcfGABpfsTYGcGsc8YdEM0eaqtKjgsamRD5GfUreCIO2HvAzpq4P/RUtj6m+svs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gl5pM11Z; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b5ed53d0aso11591376a12.3
        for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 09:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768326825; x=1768931625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CfgmTB1OpGhVzTurnEb+l+GPj9xwgr/BCYmpGUA7Vpg=;
        b=gl5pM11Zup4dlkS5/6tZoRcWc9zT5OZoUE9tQwRYOCrR1s+EY/a2iK5T+YKo7wUoot
         8EhkuaKsyePEwKphNvI3PwNv0+880M2250lQN/PFKWpefPfbvpWOFB6EIko8IBn8aa8t
         Znd+a7SWfffddFJo2ru3m9ENoA9IEsyH0szFx85y4BYVn4WFnXNaMjk6VPqSAQO+frYt
         QCWjIQjWzovzygXXzn7qnxyc/7nBxDmKogTpm4h1aWilDT0fwzqbNTPBFXEQeTYmDnPc
         0diGCzDaTIITkHCfK+kA2QCk1HCtRSbRwVJPnSww+CdS+tjkRl3x2bSMw+DFDggGiu6q
         MdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768326825; x=1768931625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfgmTB1OpGhVzTurnEb+l+GPj9xwgr/BCYmpGUA7Vpg=;
        b=XDjYzlCODJ+SqTF4TBWSgSD6pjJDYD3zk5OwIWxKeq97yIIwLtUJE/XPQBmhhiIXgV
         Vevutp+4gBH0hzR9MgFrIn6iAm1xK5Dlc2assgbVMJEXzSN387mynf+Qf9vbB19u0FWj
         FvBtkRazdZPUGwZTyEkjcUcwTh3yyaGJYlzRPQp1jHlk9PM6vjZqwTFbhboyKZoUsn6W
         kaj+cj0TZptEw3FTwknXw2JuII8THlQod+rF9D11m67SZnseZAGNvXGsggykYaigPjsW
         edL4zzRcUzcflWdMJJPJVhkHbwinzPuBP/uNqCvz5X1B/hewNxPYfhtoOseEylfRUhZ1
         xlnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrHbMTw3HAMYADWpY5C8sgxxK2sZzASXDAqTxsFuUY3dJPc0M8RHTPJq187VCoUAhcwFhBWyssSnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPYVeDE6wTYztj8HJ38wmtqtlepJxBpd24RRPkf8zHonLb+XQC
	oSig1XVaOOXd5jVJV6tjzcar4oEhxBXZBV4oeOOZpARfaWKlxWVCT7X7z2X8NmzEVheCYflKvOJ
	Biwh1Uw3sTRoPSC2q13xiHwSRl+7Sfnc7JJpNlltNug==
X-Gm-Gg: AY/fxX6mE9mYsBrYZx941vf9cXlJ+Arg8HTobk5iu+jo1Gdu5hJxgpI4bvE3iB/JSzu
	doI2OHwbTlAs1v6aa6Qg2Ktv5ZRIevL8PW85sE/HAIK7ty2kVTObxCluULhwG3mf4+bUqCN5VYs
	baTnJKUIpqnFVszD/YwP3CevA75bjpEdGIU7Jh/DpG2+3ESBAiogJWBL3Mu6/miffiEipqjCySM
	+4JdTML9J98vTeBKcWij8NXQKE73bI+ynS++4EmaNHIG6RNoSkChTuodNf1Ul/nbmvSmlcWxedO
	QVSXwGAxguzPYVE0C3jOBqpa
X-Google-Smtp-Source: AGHT+IEa4B1Rt4+BROQKR/u1/yxL9LXqOJEId8T+qR6e0Y3Coey1yaHpkUJxtDKCGYopclvH49OnnZLwjRw2Ches/VI=
X-Received: by 2002:a05:6402:1e91:b0:64d:1d2b:239c with SMTP id
 4fb4d7f45d1cf-65097e5fd39mr19704718a12.25.1768326824719; Tue, 13 Jan 2026
 09:53:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
In-Reply-To: <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 13 Jan 2026 18:53:33 +0100
X-Gm-Features: AZwV_QgR-Uxls38dUdYSDVaP19RAXI7bhaXQy51B8wCOuIxml8yrTiS16L7TkYU
Message-ID: <CAKfTPtADp2cxgXGOAVfHKtQ5Sb4MNTBJ4FAwKNgpvvkxtOupdQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] PCI: dwc: Rework the error handling of
 dw_pcie_wait_for_link() API
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangsenchuan@eswincomputing.com, 
	Shawn Lin <shawn.lin@rock-chips.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
	Frank Li <Frank.Li@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Jan 2026 at 09:12, Manivannan Sadhasivam via B4 Relay
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
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


FWIW I tested it on s32g399a-rdb3 with a ssd on pcie0 and nothing on pcie1
Tested-By: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> Changes in v4:
> - Skipped returning failure during resume as well if no device is found
> - Link to v3: https://lore.kernel.org/r/20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com
>
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
> Manivannan Sadhasivam (6):
>       PCI: dwc: Return -ENODEV from dw_pcie_wait_for_link() if device is not found
>       PCI: dwc: Rename and move ltssm_status_string() to pcie-designware.c
>       PCI: dwc: Rework the error print of dw_pcie_wait_for_link()
>       PCI: dwc: Only skip the dw_pcie_wait_for_link() failure if it returns -ENODEV
>       PCI: host-common: Add an API to check for any device under the Root Ports
>       PCI: dwc: Skip failure during dw_pcie_resume_noirq() if no device is available
>
>  .../pci/controller/dwc/pcie-designware-debugfs.c   | 54 +---------------
>  drivers/pci/controller/dwc/pcie-designware-host.c  | 23 +++++--
>  drivers/pci/controller/dwc/pcie-designware.c       | 75 +++++++++++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h       |  2 +
>  drivers/pci/controller/pci-host-common.c           | 21 ++++++
>  drivers/pci/controller/pci-host-common.h           |  2 +
>  6 files changed, 115 insertions(+), 62 deletions(-)
> ---
> base-commit: 68ac85fb42cfeb081cf029acdd8aace55ed375a2
> change-id: 20251119-pci-dwc-suspend-rework-8b0515a38679
>
> Best regards,
> --
> Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
>

