Return-Path: <linux-pci+bounces-23808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C09FA62403
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 02:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35E73BDB39
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 01:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD37A16F0E8;
	Sat, 15 Mar 2025 01:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S6jQ4v4R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD2716EB42
	for <linux-pci@vger.kernel.org>; Sat, 15 Mar 2025 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742002174; cv=none; b=Kgj2mko7Q+ejZKp+uvQW0OhTxfq5lAhlDfAdd3h8+qV03hrhnAImzQxDtWcmY1yzYZ0u83MboifXF5geVAvhp7b10ZQvfWlbBfm5aAEKI1Pg+orATzIWMu+tVzk8af0HOn/5ypoZ/v2hZbMwbbfIkwE4Ne2kSuQpgNztGhhqrRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742002174; c=relaxed/simple;
	bh=bL3E6ZKdsE327UUQdlOSCxHKLR6a7H2JRLqB/6goHos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikt4oHQMz3teNok7WbJ7WwwwAcyZ0pYh0CZnfFbDgNK+JlJkbjF7Vsh9ERIRCpr5vHdO451OxpHo17LwqYD+FiIzVFJc7fEKIbgzzuXiOzqVr2zDTGL6CQZJCR6GNdTIPBEQWlJl+PI2HdII8ybkcFB64+izeqUXVfylRmRmNUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S6jQ4v4R; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54954fa61c8so2483647e87.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 18:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742002170; x=1742606970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6w0disyuUDvtQQ+N3XWfjRUpHu9jC93VlrnWH3RRULk=;
        b=S6jQ4v4RiZDaWdJ5uwqJ7dsOtltzLcWmBYqOwPWLjiSInftLAaPxVP8kqsFk6k38Oo
         QuAqqiKFlfQUqt6II8SPlwYzPJGvf+SikGi78MJfPjQ/zQTXhYk3SrmLxFW++97aebCS
         F7zo1JM/Ft/X3z5ljvpB14Ju4WRM6DTkQrwpvPAlg77CD26wd9r6GKuSJAfUTN9XUW+y
         ZAfwRvNATdIAKSblMn02efRQ0fQz54odxy3mFQuBM0Nh+VKuXEm1xEQufA7oXDEKgGEd
         XSp294eaS7HNZxzN9fnnG8O4zFTz1d9x5v5usOKGukUi3yfwZ7FVnVS999oeGkoJMq4y
         oqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742002170; x=1742606970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6w0disyuUDvtQQ+N3XWfjRUpHu9jC93VlrnWH3RRULk=;
        b=MvuqCJl/hh4i4VPILyq4MviGo6LzTy8XYeFgjd1N4i+wOeS0XULgDYJVDJVHUb4y5X
         w5hGVKPWDhg7oN3zqipptwc0cE02xLyPh5jlGPfP9o5P8gOniqiBE3PFrgkNQtp42Xji
         sjgLgY6YWigjaQ7lLh41pLfqWU7r8L9yzHNyR9FKZH3REOgIN4Gb4Pl6dCdYnhaTVvoM
         8Rtm80a4EyVnp/2bAXuTZp+w7fQmMMirIhQibkUVtdtBON8v6ebZ15sHYY6fuQY/1lRw
         WjbKGZdpElvj8zX//NBVx5YHU/5EwOJD4jqpX3hpEsqDjwkE+AS7lGGtovdRV+ZLD3Hp
         hM6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVot0itODj2n7xN41Qs0mfBiczQOEYM03m4omQw7i6My0PPPt/YFSSvoWzE4oUWKUeymfzxvOPqIxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrhA2Gjzxig4r+K8sls2BfjHg/hhP7GTLK6TJf4fdRKvy5vyJ0
	XthOtHU84tsFhoeexxrWdB7/mHGSJimHDaVnxWjMxlPJcyMzDC9I5X4jPYYI26ep64Ragzi3+lu
	dKO82YRjUFbCnZJgl8MJ1+Ur6IIleaSVFsTc07Q==
X-Gm-Gg: ASbGncsuPfjmXSdTtTgEDsBMNpynDZLYv6joXJTQzIP09z74VV5U7dfB3tryGm6OMvh
	X1CJEIPMBJItSqWJwGhvNqwdPV/t2Ruq5R890qihUSvayjNqONwHXQ+9utmmoGi6Gq2brY3bqVf
	6hwtDg8ygeawWvKHX1rabKcMgM
X-Google-Smtp-Source: AGHT+IEcrCNfkXntuX0aeO1m76LAx6oQqfZga4okctB2AQ1NJbZPVtoeE1K8MorP61BHMqFs6rP9wk4g9/bvh9zwZ0k=
X-Received: by 2002:a05:6512:31c3:b0:549:8f06:8225 with SMTP id
 2adb3069b0e04-549c39507ebmr1467555e87.53.1742002169612; Fri, 14 Mar 2025
 18:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314071058.6713-1-zhangfei.gao@linaro.org> <20250314162838.GA781747@bhelgaas>
In-Reply-To: <20250314162838.GA781747@bhelgaas>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sat, 15 Mar 2025 09:29:18 +0800
X-Gm-Features: AQ5f1Jq548u8pPFXs_fox2r7erQleFFr1iIjN49eNipnJu4ChBbFpiLc4BGDKXE
Message-ID: <CABQgh9H_vGTPfB_dY+fT9gsWw5K53o0MBXf25LamaxBfVc2-Qw@mail.gmail.com>
Subject: Re: [PATCH] PCI: declare quirk_huawei_pcie_sva as FIXUP_HEADER
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 15 Mar 2025 at 00:28, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Mar 14, 2025 at 07:10:58AM +0000, Zhangfei Gao wrote:
> > "bcb81ac6ae3c iommu: Get DT/ACPI parsing into the proper probe path"
> > changes arm_smmu_probe_device sequence.
>
> Normal commit reference style is:
>
>   bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
>
> bcb81ac6ae3c is not a valid upstream commit.  It does appear in
> next-20250314, incorporated via f5a5f66e2791 ("Merge branches
> 'apple/dart', 'arm/smmu/updates', 'arm/smmu/bindings', 's390', 'core',
> 'intel/vt-d' and 'amd/amd-vi' into next") from
> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git.
>
> I think there's some value in keeping fixes close to whatever needs to
> be fixed, so since bcb81ac6ae3c came via the iommu tree, I would tend
> to merge the fix the same way.

OK, understand.
Then would you mind give an ack.

>
> Unless there's a rebase to merge this change before bcb81ac6ae3c, this
> probably needs a "Fixes:" tag so people who backport bcb81ac6ae3c have
> a hint that this quirk change should be backported along with it.
>
> > From
> > pci_bus_add_device(virtfn)
> > -> pci_fixup_device(pci_fixup_final, dev)
> > -> arm_smmu_probe_device
> >
> > To
> > pci_device_add(virtfn, virtfn->bus)
> > -> pci_fixup_device(pci_fixup_header, dev)
> > -> arm_smmu_probe_device
>
> This doesn't include enough detail to show the change.  I don't know
> the path to arm_smmu_probe_device() and how it relates to
> pci_bus_add_device() and pci_device_add().
>

Thanks Bjorn

How about changing to this.

Subject: [PATCH] PCI: declare quirk_huawei_pcie_sva as FIXUP_HEADER

The arm_smmu_probe_device is now called earlier via pci_device_add,
which calls pci_fixup_device(pci_fixup_header, dev),
while originally it is called from pci_bus_add_device,
which calls pci_fixup_device(pci_fixup_final, dev).

So declare the fixup as pci_fixup_header to take effect
before arm_smmu_probe_device.

Calling stack
Before:
[ 1121.314405]  arm_smmu_probe_device+0x48/0x450
[ 1121.314410]  __iommu_probe_device+0xc4/0x3c8
[ 1121.314412]  iommu_probe_device+0x40/0x90
[ 1121.314414]  acpi_dma_configure_id+0xb4/0x100
[ 1121.314417]  pci_dma_configure+0xf8/0x108
[ 1121.314421]  really_probe+0x78/0x278
[ 1121.314425]  __driver_probe_device+0x80/0x140
[ 1121.314427]  driver_probe_device+0x48/0x130
[ 1121.314430]  __device_attach_driver+0xc0/0x108
[ 1121.314432]  bus_for_each_drv+0x8c/0xf8
[ 1121.314435]  __device_attach+0x104/0x1a0
[ 1121.314437]  device_attach+0x1c/0x30
[ 1121.314440]  pci_bus_add_device+0xb8/0x1f0
[ 1121.314442]  pci_iov_add_virtfn+0x2ac/0x300

Now:
[  215.072859]  arm_smmu_probe_device+0x48/0x450
[  215.072871]  __iommu_probe_device+0xc0/0x468
[  215.072875]  iommu_probe_device+0x40/0x90
[  215.072877]  iommu_bus_notifier+0x38/0x68
[  215.072879]  notifier_call_chain+0x80/0x148
[  215.072886]  blocking_notifier_call_chain+0x50/0x80
[  215.072889]  bus_notify+0x44/0x68
[  215.072896]  device_add+0x580/0x768
[  215.072898]  pci_device_add+0x1e8/0x568
[  215.072906]  pci_iov_add_virtfn+0x198/0x300

Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Thanks

