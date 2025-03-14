Return-Path: <linux-pci+bounces-23732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2783A60DC0
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 10:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2915517739A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 09:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0974E1C8623;
	Fri, 14 Mar 2025 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DOHOOvx/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938571EFFA9
	for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945704; cv=none; b=hCA6AuMizQF/JD6fXJ9zXdn3jGuM1BJQyZUT4uT0ekwCSPbTpzLkSpLBT5Rr1ouSUnXow8jJ1AywCHROChxFD+8dYJjOCRTCyRrsj8XDx+TP84jkBRzQHRyVuZOxJHm0acHD6l52YB+HotgDjA6NGw+zhZ23FCe8ZW6alXvrcqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945704; c=relaxed/simple;
	bh=ntrXBr+INEaTdjjIuTH+2ThTesvG7vd12dHm2Z44+kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtFN2z6OG13sOVfST9GwchI7xmMxpivz95naQohILTZcN+94+BtTqpwBfDOb7OgDVuU6CoBc06MufRDj5xkalI0RGxdfQ04rIQER5jhQMNNJrMkndlvme3JJo8xgaGKqLF8azrroUZYo/FUrb65hFby21smvX0MoUt3FACBygxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DOHOOvx/; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5439a6179a7so2199003e87.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 02:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741945701; x=1742550501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FD6bznsu01iYGcm6ewJe4RuYE462CwiH5xGheRZGZw0=;
        b=DOHOOvx/mmRGl3azR92KT5IuS/fBneL/4J9rWUDNTWUEiI+oIiI1GoWcLzxcKDwjqi
         6t3luIJollkQTLEgYJ4o7ZcwY//58IWreObq3DQvFjli1V/tLpzEMEracAOIpE3uuAsF
         FkUe3mUb8HDpL68m9UMEDjTLVhqkBS9g8wdFtjvp8eG2jejfge7hu9R9eVgSH+i0pemx
         yu8ZeN8tItXieyFGNWZdnxU4MebAk5bvY6+90x9WbF2f4BZxOas3KPATFMedRZwfCx3p
         I8mfL/LTXjKdvDHwlPlzFxTejZOgc6hRtU2OCRgcluxZr87CfRLjDXP7rZDRBqirM29p
         0n6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741945701; x=1742550501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FD6bznsu01iYGcm6ewJe4RuYE462CwiH5xGheRZGZw0=;
        b=hWMIQBD9zFfajYS5esnwVelCuHLQf/5peCFXABPop7ntuFdILOl7lGqQRGA/hPCiKv
         anQXKBQJhIDhiSB5DuvHRVuJ2b+CZb5IoBX5Lildx0cKw3h21Px7VXc16jigMzRrbszN
         N8Uz9Tyum5eUfpmdKOtzUgCNTCxKkWo3YfF+SydK+o/VSXgF6Sl8YFxMGEw0YKfGKrW9
         8r0yO/wgOxMM+8N32qfhFaxjgZcM3+xGcDCnec3WAysHKDP74zMow44TxLlea4/mGJLZ
         S6V54jfxq+NuUhwnuK7p1Fy2+sifdITfe1WSneDWRzmRs562qtRvoji3Fmn+q3Kg2x/z
         2LmA==
X-Forwarded-Encrypted: i=1; AJvYcCUoUYJF2xWCGO6e7oiaVnJg0IkpRqd79FEMwhkJD5owciaG5jBlNvQWyN4/Fm+TSsjGbEYVI/GDMOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4WE0Y3Af2YjKqY3yE8aQdOnwCq75gbKJFHlFWUcZxPeVZlaFl
	POO02uF/1kExzIz5i1jIQAEc+zERFiyKIIFX3k1b9eQkSuUOTr2a35Qh/919W59Dyo3m/Xqdin0
	9ozq5zroTLSGIzgyyH0H3IHS2y3r4vwAW3LEDkQ==
X-Gm-Gg: ASbGncv8zCznNrScGWZHqcfIUuLsEWs6Pw3KntYNLViuIg+1MJKoxu694kx5TsMY7M/
	sdQN7VnIaJa3f5FgiFvcl9Buq5UCtSHVw1AzGU05GZ/yuUjKeTqloOUSpLx0avKfDWvyWVVx0mZ
	Fm0EeHhq/y62QKAs+y+JkkBmtXMei7AeE=
X-Google-Smtp-Source: AGHT+IF+BXUJPCiL1c7sbvSs4gfqol1v20qox8jtJslAuMcy8M2YGJF8kQcGGVoAZtCirbS3VlFVKlXtncaYF36CYig=
X-Received: by 2002:a05:6512:ba8:b0:549:7145:5d2d with SMTP id
 2adb3069b0e04-549c3f97f37mr544029e87.16.1741945700612; Fri, 14 Mar 2025
 02:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SJ1PR11MB61295DE21A1184AEE0786E25B9D22@SJ1PR11MB6129.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB61295DE21A1184AEE0786E25B9D22@SJ1PR11MB6129.namprd11.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri, 14 Mar 2025 17:48:09 +0800
X-Gm-Features: AQ5f1Jp8h2KQrj8cXSVVa65hkY1o46EVlIPZXIQrn2pTPHmKX_laXhYL3waLDDA
Message-ID: <CABQgh9HBqbJYnUqJzG+nOY=B8nQ-8Scy8i0ctszBm8rzpocNFw@mail.gmail.com>
Subject: Re: Regression on linux-next (next-20250312)
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "robin.murphy@arm.com" <robin.murphy@arm.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, 
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Saarinen, Jani" <jani.saarinen@intel.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi, Borah

On Fri, 14 Mar 2025 at 17:18, Borah, Chaitanya Kumar
<chaitanya.kumar.borah@intel.com> wrote:
>
> Hello Robin,
>
> Hope you are doing well. I am Chaitanya from the linux graphics team in Intel.
>
> This mail is regarding a regression we are seeing in our CI runs[1] on linux-next repository.
>
> Since the version next-20250312 [2], we are seeing the following regression
>
> `````````````````````````````````````````````````````````````````````````````````
> <4>[    6.246790] reg-dummy reg-dummy: late IOMMU probe at driver bind, something fishy here!
> <4>[    6.246812] WARNING: CPU: 0 PID: 1 at drivers/iommu/iommu.c:449 __iommu_probe_device+0x140/0x570
> <4>[    6.246822] Modules linked in:
> <4>[    6.246830] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc6-next-20250312-next-20250312-g9fbcd7b32bf7+ #1
> <4>[    6.246838] Hardware name: Intel Corporation Arrow Lake Client Platform/MTL-S UDIMM 2DPC EVCRB, BIOS MTLSFWI1.R00.4400.D85.2410100007 10/10/2024
> <4>[    6.246847] RIP: 0010:__iommu_probe_device+0x140/0x570
> `````````````````````````````````````````````````````````````````````````````````
> Details log can be found in [3].
>
> After bisecting the tree, the following patch [4] seems to be the first "bad" commit
>
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> commit bcb81ac6ae3c2ef95b44e7b54c3c9522364a245c
> Author: Robin Murphy mailto:robin.murphy@arm.com
> Date:   Fri Feb 28 15:46:33 2025 +0000
>
>     iommu: Get DT/ACPI parsing into the proper probe path
>
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
>
> We also verified that if we revert the patch the issue is not seen.
>
> Could you please check why the patch causes this regression and provide a fix if necessary?

I just send one fix caused by this patch
Just FYI

[PATCH] PCI: declare quirk_huawei_pcie_sva as FIXUP_HEADER

"bcb81ac6ae3c iommu: Get DT/ACPI parsing into the proper probe path"
changes arm_smmu_probe_device sequence.

From
pci_bus_add_device(virtfn)
-> pci_fixup_device(pci_fixup_final, dev)
-> arm_smmu_probe_device

To
pci_device_add(virtfn, virtfn->bus)
-> pci_fixup_device(pci_fixup_header, dev)
-> arm_smmu_probe_device

So declare the fixup as pci_fixup_header to take effect
before arm_smmu_probe_device.

If your system has fixup, it may need a change '
from
DECLARE_PCI_FIXUP_FINAL
to
DECLARE_PCI_FIXUP_HEADER

Thanks


>
> Thank you.
>
> Regards
>
> Chaitanya
>
> [1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
> [2] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250312
> [3] https://intel-gfx-ci.01.org/tree/linux-next/next-20250312/bat-arls-6/boot0.txt
> [4] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250312&id=bcb81ac6ae3c2ef95b44e7b54c3c9522364a245c
>
>

