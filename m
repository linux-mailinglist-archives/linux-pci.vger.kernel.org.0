Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B09C38B055
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 15:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhETNtV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 09:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhETNtU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 May 2021 09:49:20 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C258CC061574
        for <linux-pci@vger.kernel.org>; Thu, 20 May 2021 06:47:58 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id d14so14941308ybe.3
        for <linux-pci@vger.kernel.org>; Thu, 20 May 2021 06:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DHDvaaIezGXpJHcAM1BPRRBfXs3uMN/RnzsQE5fWsmw=;
        b=eFmsA7ZqGUTeykCkebVaCgdI/LQZXs9DhNdx3z4puGmQUAfiMV/UIL4ktgJrm8gVbh
         SqAfUnlO5830RFm9mplJgDsrn4oUjyt4o7j14c/hfXebK/LPqu6y20MjGuU+YgMWNl/m
         EixwxN2DmBsXe7Ecx7VKmzTp+XxMYSyC+N3bPU4lLYfxwRmSE3x9lBCxy49BJ98HEdsT
         q6xl08jxe4/80gZPDUyedENadvNWcOHRjtLOdRZKsw3osULpSb5ccfWgmqnwgBtJ92tp
         aJqph7kve+nAYbOWBu51Ea/6IL2N7CX3/be1/IaKam58u3hS0IwGYON96DwzgZPZIK5p
         UkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DHDvaaIezGXpJHcAM1BPRRBfXs3uMN/RnzsQE5fWsmw=;
        b=eF5+gkxe8ywxZ2onfn8qeW+Q55FoKgAVSuF8Cp9lxigLBso+HeauGhrdS+3q9cuEz9
         VilD103nK+JCZXnxqrUjvsjuRaNuV0CMcIQ5MMFo4XHAAE/Hv/FsWdWuBdpLmwHmsc/k
         VqS9a/kyz226rW7QMAM0mbPGU/rK4TzLY/3Xb0yDzoJ1BUXf55XXmvCgcSuYF4kZst3O
         JTES4UX81Vc8xuJch6Exx9yqUsz5H0JGb/zqnCernuTNj9wfk36r4yTe9QIMbMnho3dV
         FVckPuBc5dlO5k6jR2X9cU6ewTPtPR60ZGIUrRKCCOMd+uzsgKBJXdJDoraFXCiZzzt7
         V7xQ==
X-Gm-Message-State: AOAM533n38nHVdp6AWbPQsERZ3O07+X90fIHwOEMHdADts39pIdKaJDh
        Annq+FhuF5m90QxfN7XGD1bT/mCXQdJ9SbW9RLo=
X-Google-Smtp-Source: ABdhPJwiH0rI1qxvqkekh7AkXdIZrdFlCpK3N5q2xCZxOdWk5rfSa8QT+iV9uoqVy2p5q3HqFd0JndTb6mMBUx939TM=
X-Received: by 2002:a25:4f05:: with SMTP id d5mr6958365ybb.473.1621518478048;
 Thu, 20 May 2021 06:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120055.jl7vkqanv7wzeipq@pali>
In-Reply-To: <20210520120055.jl7vkqanv7wzeipq@pali>
From:   Sandor Bodo-Merle <sbodomerle@gmail.com>
Date:   Thu, 20 May 2021 15:47:46 +0200
Message-ID: <CABLWAfQbKy=fpaY6J=gqtJy5L+pqNeqwU6qkVswYaWnVjiwAHw@mail.gmail.com>
Subject: Re: pcie-iproc-msi.c: Bug in Multi-MSI support?
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,

thanks for catching this - i dig up the followup fixup commit we have
for the iproc multi MSI (it was sent to Broadcom - but unfortunately
we missed upstreaming it).

Commit fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
failed to reserve the proper number of bits from the inner domain.
We need to allocate the proper amount of bits otherwise the domains for
multiple PCIe endpoints may overlap and freeing one of them will result
in freeing unrelated MSI vectors.

Fixes: fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
---
 drivers/pci/host/pcie-iproc-msi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git drivers/pci/host/pcie-iproc-msi.c drivers/pci/host/pcie-iproc-ms=
i.c
index 708fdb1065f8..a00492dccb74 100644
--- drivers/pci/host/pcie-iproc-msi.c
+++ drivers/pci/host/pcie-iproc-msi.c
@@ -260,11 +260,11 @@ static int iproc_msi_irq_domain_alloc(struct
irq_domain *domain,

        mutex_lock(&msi->bitmap_lock);

-       /* Allocate 'nr_cpus' number of MSI vectors each time */
+       /* Allocate 'nr_irqs' multiplied by 'nr_cpus' number of MSI
vectors each time */
        hwirq =3D bitmap_find_next_zero_area(msi->bitmap, msi->nr_msi_vecs,=
 0,
-                                          msi->nr_cpus, 0);
+                                          msi->nr_cpus * nr_irqs, 0);
        if (hwirq < msi->nr_msi_vecs) {
-               bitmap_set(msi->bitmap, hwirq, msi->nr_cpus);
+               bitmap_set(msi->bitmap, hwirq, msi->nr_cpus * nr_irqs);
        } else {
                mutex_unlock(&msi->bitmap_lock);
                return -ENOSPC;
@@ -292,7 +292,7 @@ static void iproc_msi_irq_domain_free(struct
irq_domain *domain,
        mutex_lock(&msi->bitmap_lock);

        hwirq =3D hwirq_to_canonical_hwirq(msi, data->hwirq);
-       bitmap_clear(msi->bitmap, hwirq, msi->nr_cpus);
+       bitmap_clear(msi->bitmap, hwirq, msi->nr_cpus * nr_irqs);

        mutex_unlock(&msi->bitmap_lock);


On Thu, May 20, 2021 at 2:04 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Hello!
>
> I think there is a bug in pcie-iproc-msi.c driver. It declares
> Multi MSI support via MSI_FLAG_MULTI_PCI_MSI flag, see:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/pci/controller/pcie-iproc-msi.c?h=3Dv5.12#n174
>
> but its iproc_msi_irq_domain_alloc() function completely ignores nr_irqs
> argument when allocating interrupt numbers from bitmap, see:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/pci/controller/pcie-iproc-msi.c?h=3Dv5.12#n246
>
> I think this this is incorrect as alloc callback should allocate nr_irqs
> multi interrupts as caller requested. All other drivers with Multi MSI
> support are doing it.
>
> Could you look at it?
