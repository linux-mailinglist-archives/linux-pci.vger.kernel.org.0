Return-Path: <linux-pci+bounces-23885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D20A633CC
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 05:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46CE63A73E1
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 04:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11722DF49;
	Sun, 16 Mar 2025 04:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HbAmTkhJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B480C3596D
	for <linux-pci@vger.kernel.org>; Sun, 16 Mar 2025 04:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742098545; cv=none; b=A2C6OVP1WfkCnmU8VAwPaNjNnNWT2Lcp2FPYdEUTKxyx3JUJ90xfTkjqlScDY/KmkMDyzoTJPHc8ivPdfJ9tMqwJVd07tGy7dJDetmvuLVnymr6DEnfJ8XbfxdTO0706qTQ5LQvXMxrYQxoarfLYR+jkHqOxakfx6uq04Z4FFeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742098545; c=relaxed/simple;
	bh=m7IGz1Su6f3WyaLHo4IduccdGORIbl0HNVhX7LjFWSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kc5vmeDIzYjSbMYtBJqyTNbmfmHmtcR4VTIn/7i1WgiT4K/L0H1fv9L4Lw/uYPxbd9dcMjwNuGKPkVhhlq3gh0PSObuEdgnf/ZFzrD7GskAGz7LrT8dz7CDrUTV4irmZqwuOo99nlBeGnBqfF50MSImgaut3OMAy9BIU4WNCSPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HbAmTkhJ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bf5d7d107so30223681fa.2
        for <linux-pci@vger.kernel.org>; Sat, 15 Mar 2025 21:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742098541; x=1742703341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UM1L2R64O8F7JlGmLCnfToZ8ny94Rpb02pePzSUOCDQ=;
        b=HbAmTkhJ2Dt5ct1pddk+M4XRJk6N86EzpYUVhQMspxT4qa769/h6v3gqTOkC4n71mj
         ThjDucmxWYLvS/3P1rFAch7+fp8zxR1zdvf6HhSlm8i6DxdwGilBbEyRKH+kyqTFcSNN
         yZPiNa++y7IYcQAWMVXNVtsH4ExrilemoE7PxhQ9/efbStUCjvBVTyr7nc7NAeuMfAvm
         h3g3H15k+sUgVsVzv+8Q6++Ssluvt/FqFQYmOvF/cRJPH9TdBDjmxkYU9Pze3MWepnlp
         UAMbRysWT/rgdPwe7Eug4KGRzUWcCWCCBxL1OvYZlIXwKfEZRbP/y/sr+xEmlI7UX0JG
         dEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742098541; x=1742703341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UM1L2R64O8F7JlGmLCnfToZ8ny94Rpb02pePzSUOCDQ=;
        b=xA7Ypdc0TrSfn3SUnWZ7lilMihfbFlbZK5ABnBVe3fmZb1IaoIl8dKYG4kSD4I+nJg
         PRzYWmBzRMkKXTcc7uPTTeQXc030TgoPwK01euxY0/LNev40f2uuP5X0h3ceigB0gnpA
         +tyKQMO5dEmWQ5l77rwd9ScfCr9UMgu9fZNpOouivCcCmCcYehxBk4xkdlteWenK8Uvd
         u69u/ZpCK1hMD8xD0z5xjczQXdUTzanFHxbr+r/1beXHJ/3XfaeMlFkzdMEHBNsZqM50
         CtmqIkMX14U6OWDXEHd2TsrKzt8CzcVV441qiK7sOFlxdMgVP7VyFRPqyA1Joc/F9h1B
         NGAg==
X-Forwarded-Encrypted: i=1; AJvYcCW2NRY07gAYHRwvQut4FtlpHLMcWSyKedrmuG31DPN6w9FKZjTVLicMQ5Q63isYFMmbRbCmjFC1Zsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9SINLGyfeBQMMs7T2e/6xFfB4jhrPioWocVB25Az0me+PtnnV
	2u7V0Ys/XxPNODPAAFGtAF3jbPw2K9q6T65WzFSfP75jzCHg2uWR+lyTo6gsJ426mEL+IgMuxXv
	CgbUvyxtPU5I/N5qUm8juLHC7Tp/ukf/jCtjZzbbH/ZaOwqUR1sLYXHG+yfQ=
X-Gm-Gg: ASbGncsDNnRkJ2l16DoELEHvPiiDiblS1BD2aldVjINwzsSPLslMorGX09FmlUAF4lK
	VFQnT0Su2i+xu4YSVCH8ZWnc1gNKFzVYjWhBZ+Xe1SxlMkuOBoCJ9ObtXCez4ybqIL0x8Xc2phF
	IUand0WtrgiaJ9DE5SnYpRxiXprquYjtk=
X-Google-Smtp-Source: AGHT+IH/A1bDu+ZfR2zvqow6IEEeruRcPFjB/u+4/oPSeeNjvl37vt/MG/IPQnpIeLwVaSqEfw8ri/ih3A9wXOYJg1k=
X-Received: by 2002:a05:6512:6d6:b0:549:4b8c:a118 with SMTP id
 2adb3069b0e04-549c3900385mr2453886e87.17.1742098540708; Sat, 15 Mar 2025
 21:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315101319.5269-1-zhangfei.gao@linaro.org> <20250315184523.GA848225@bhelgaas>
In-Reply-To: <20250315184523.GA848225@bhelgaas>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sun, 16 Mar 2025 12:15:29 +0800
X-Gm-Features: AQ5f1JqAU9NOtpVBFyhTYYvnRxSZUPako8sV1dSH2-zJnWm6JJHjU4CXdg9YkTg
Message-ID: <CABQgh9E=z9SqbbnLfqQrSX8XqGMooz3EvUescpRY1XYQgvnHjA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Declare quirk_huawei_pcie_sva() as pci_fixup_header
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 16 Mar 2025 at 02:45, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sat, Mar 15, 2025 at 10:13:19AM +0000, Zhangfei Gao wrote:
> > The commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
> > probe path") changes the arm_smmu_probe_device() sequence.
>
> > The arm_smmu_probe_device() is now called earlier via pci_device_add(),
> > which calls pci_fixup_device() at the "pci_fixup_header" phase, while
> > originally it was called from the pci_bus_add_device(), which called
> > pci_fixup_device() at the "pci_fixup_final" phase.
> >
> > The callstack before:
> > [ 1121.314405]  arm_smmu_probe_device+0x48/0x450
> > [ 1121.314410]  __iommu_probe_device+0xc4/0x3c8
> > [ 1121.314412]  iommu_probe_device+0x40/0x90
> > [ 1121.314414]  acpi_dma_configure_id+0xb4/0x100
> > [ 1121.314417]  pci_dma_configure+0xf8/0x108
> > [ 1121.314421]  really_probe+0x78/0x278
> > [ 1121.314425]  __driver_probe_device+0x80/0x140
> > [ 1121.314427]  driver_probe_device+0x48/0x130
> > [ 1121.314430]  __device_attach_driver+0xc0/0x108
> > [ 1121.314432]  bus_for_each_drv+0x8c/0xf8
> > [ 1121.314435]  __device_attach+0x104/0x1a0
> > [ 1121.314437]  device_attach+0x1c/0x30
> > [ 1121.314440]  pci_bus_add_device+0xb8/0x1f0
> > [ 1121.314442]  pci_iov_add_virtfn+0x2ac/0x300
> >
> > And after:
> > [  215.072859]  arm_smmu_probe_device+0x48/0x450
> > [  215.072871]  __iommu_probe_device+0xc0/0x468
> > [  215.072875]  iommu_probe_device+0x40/0x90
> > [  215.072877]  iommu_bus_notifier+0x38/0x68
> > [  215.072879]  notifier_call_chain+0x80/0x148
> > [  215.072886]  blocking_notifier_call_chain+0x50/0x80
> > [  215.072889]  bus_notify+0x44/0x68
> > [  215.072896]  device_add+0x580/0x768
> > [  215.072898]  pci_device_add+0x1e8/0x568
> > [  215.072906]  pci_iov_add_virtfn+0x198/0x300
>
> The stacktraces definitely help connect the dots but don't integrate
> the fixup phases and the timestamps are unnecessary distraction.
>
> I would omit all the above except the first paragraph and include
> something like this instead, which shows how arm_smmu_probe_device()
> was previously after final fixups and is now between header and final
> fixups:
>
>   pci_iov_add_virtfn
>     pci_device_add
>       pci_fixup_device(pci_fixup_header)      <--
>       device_add
>         bus_notify
>           iommu_bus_notifier
>   +         iommu_probe_device
>   +           arm_smmu_probe_device
>     pci_bus_add_device
>       pci_fixup_device(pci_fixup_final)       <--
>       device_attach
>         driver_probe_device
>           really_probe
>             pci_dma_configure
>               acpi_dma_configure_id
>   -             iommu_probe_device
>   -               arm_smmu_probe_device
>
> This is the pci_iov_add_virtfn().  The non-SR-IOV case is similar in
> that pci_device_add() is called from pci_scan_single_device() in the
> generic enumeration path, and pci_bus_add_device() is called later,
> after all a host bridge has been enumerated.

Thanks Bjorn

Will update in v3.

One thing is the probe sequence change is the fixing result, not newly adde=
d.
iommu_bus_notifier
    iommu_probe_device
        __iommu_probe_device
            ops =3D iommu_fwspec_ops(dev_iommu_fwspec_get(dev));
             if (!ops)
                 return -ENODEV;
This calling sequence existed before but returned here since ops =3D NULL.
It is fixed in the commit bcb81ac6ae3c, so arm_smmu_probe_device
happens earlier and quicker.

>
> > Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe =
path")
> > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > [kwilczynski: commit log]
> > Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
>
> You should never include somebody else's Signed-off-by below yours.
> You should only add *your own* Signed-off-by:

OK

>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?id=3Dv6.13#n396
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks

