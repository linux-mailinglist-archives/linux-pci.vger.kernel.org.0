Return-Path: <linux-pci+bounces-25371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E31F9A7DCF5
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 13:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789E13A97A7
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C6922B8A5;
	Mon,  7 Apr 2025 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FVZoxeE9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B228B22371F
	for <linux-pci@vger.kernel.org>; Mon,  7 Apr 2025 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744027028; cv=none; b=XgS5wGQZ/YDhjPW2EYFXH/9ppq++Cooa2uVUf6P++/q4AbtL5OPpWm9si1/7QHdkQH078LMbftPgej4qn588ISVz9LcPa3LpidnKosZ2P1PyE6KnmKqSiNOrTGLIsghGcjpNO72NQPxd3osRIQjacQnbkWMrK07dcd95YRMzm28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744027028; c=relaxed/simple;
	bh=PbdMhMfjBduUwZfF5rKVVOOwgvHETSCbxx9ro5sIPQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgqILdkG3aXvfE3asq6JnFs0I3HnHS7tW/ngUbeQHuCKHi4SlcvC+LhXSjJpfR4HjgYcJCGQYq4gpPFo96JbPyMFZytM431zCw5yJ3yzPIza1b5mZ1OhF1h28dT/UBXV5Sh3hcmj6eHrURMoIEK5ut96guqMe0MrnYnCaVJds2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FVZoxeE9; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bef9b04adso40558121fa.1
        for <linux-pci@vger.kernel.org>; Mon, 07 Apr 2025 04:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744027025; x=1744631825; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VuEAK7onIXipyZd1ca+l7EoIcSYMPQnsm7F6wcaYXKE=;
        b=FVZoxeE9uGmeAdG2YPagDhkpwxH8suKxtgHD9vzH8McO0Qjkb3aLVODIbckbXe9wyC
         mQZlcQHOIE1HtIwv2J2nRuY0E0rNhoGjzP3OnP9TCzFVV9Fm34CKGPpXGiYReiH5C8qR
         809KPNsRR1Hv74wMGcLdnez3wjJ1kukcxGEpCQ+PY/sCQM2aG6IGNNqa1W+TExkKGSpf
         HTeg7UbDrWJZodAeYzrfOVzf7aEqN0t8NqsFi0EKHxmR7zDczk98ntvDKnPHcCEYBAL5
         1m0EqKwN5B8SARQH0i61L8ImU9LA0MDDKpS3j6n83Z/GcggygvjYnzEbTj9mTc/mp0Ag
         oviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744027025; x=1744631825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VuEAK7onIXipyZd1ca+l7EoIcSYMPQnsm7F6wcaYXKE=;
        b=dEwfnJoxFbZ51ROwAdEMLRNu5Y6d65NAQDnnOkfaqjmpDDq3V31/GCWKzyiyd4TpM7
         c/qzzjBsBm/gCxgv3iKgkjfBoRTlhO46/JXrYruJ+3TVc0u3SFbcfkNESu7oKhYaFLI8
         bQu5IW2valyEP0TvGLFG5p1puKymo12VaKNtNO6Y51APeuStlHv5Yp6VuEx1ZizzeCx4
         sZ+iSakXwVJ3UQyMPypYNxOCxhgeONPFKupJ7sJo7IvkvC4PvUPhqijSsKGWnBwPVTn9
         44avwCeVnHR3gZOqb9rG1H1115PwWRyM7OxCCt8Rc883385I8Y2uwMEjQ4PKfDt+ps4T
         7Jhg==
X-Forwarded-Encrypted: i=1; AJvYcCVHIR0ZCDEfCfUmmOUtDFcrhY03fiZ/5dcuMGTsu0l7IdzNLnrafR2I7/Ay7ev7v5TkhPuBe8IH83w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYgeJ8K3CTBR8rL/rAE9My5rblm+yvOtDtn0AcAB4LiRbb2Qov
	nlW0B3+nUjY6bVB/rx98EtQBMyIPxBTrSMt2lGoh/PysCMuRtAgG3GqCQ9TCAkcjqHlwNE42Qfg
	5gUthBHCRyrBP5+HBbACoSSewRQ2tlGSkeBicKQ==
X-Gm-Gg: ASbGncsVpX6SJ3a1HSc/mAiblL3jG6diHAwNq0r7iw6mrG17sIFuyGGnwC1K85LV2s4
	r22vt/u7bUYmf+dU9xkYaCtgpGozBezhmfKO5wHAnR7h2oKxDmO9oXEcfQeTDgEEUO3CojCmNrq
	8SXEijKDl5pDWvlKaVAW7mIaJv9BoXiek=
X-Google-Smtp-Source: AGHT+IGvd9l6oHOLE9fnxfE684zOBfeLzMgdLUIP7Dlo/5MmH56BWMQ4SvzpvsYGq7X+B76XwXqLUfBxwBV44JNMIjY=
X-Received: by 2002:a05:651c:150e:b0:30b:c328:3c9a with SMTP id
 38308e7fff4ca-30f165907d5mr25336491fa.29.1744027024752; Mon, 07 Apr 2025
 04:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315101032.5152-1-zhangfei.gao@linaro.org> <20250317011352.5806-1-zhangfei.gao@linaro.org>
In-Reply-To: <20250317011352.5806-1-zhangfei.gao@linaro.org>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 7 Apr 2025 19:56:53 +0800
X-Gm-Features: ATxdqUHUra-Tho__TVApIyf-WrBs147BbLBYcTvf1B00xAmjRluVy3FNIE4M4m4
Message-ID: <CABQgh9H9JTQz5V=O1MYCX=WqH-bz3oFfSzU-pLXVL4+xyqH72Q@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Declare quirk_huawei_pcie_sva() as pci_fixup_header
To: Bjorn Helgaas <bhelgaas@google.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, Bjorn

On Mon, 17 Mar 2025 at 09:14, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> The commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
> probe path") fixed the iommu_probe_device() flow to correctly initialize
> firmware operations, allowing arm_smmu_probe_device() to be invoked
> earlier. This changes the invocation timing of arm_smmu_probe_device
> from the final fixup phase to the header fixup phase.
>
> pci_iov_add_virtfn
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
>
> Declare the fixup as pci_fixup_header to ensure the configuration
> happens before arm_smmu_probe_device.
>
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

As  the commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
probe path") already merged in 6.15-rc1, would you mind taking this
patch for rc?

Now 6.15-rc1 can not work without this patch.

Thanks

