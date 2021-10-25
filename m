Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B78543964E
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 14:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhJYM37 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 08:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbhJYM37 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 08:29:59 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F14C061745
        for <linux-pci@vger.kernel.org>; Mon, 25 Oct 2021 05:27:36 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id c28so7998548lfv.13
        for <linux-pci@vger.kernel.org>; Mon, 25 Oct 2021 05:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cWOZ10wj2v8xGCTkB4tkDGPE0ipYkZlGVNgK1wjlSKw=;
        b=iBb9cr5DvW2ttDUCpykmiohztN7R33oVN5Uzv47denlfZ3S10nnPCRIV2oR41D4oJ0
         fiUKRMDKPj8poOJOTAOwVcKq1vp/Nrru9Ooj7EMpncTk/tFPFRCdPajifeZsNkj5CUaw
         gPauzwfypIk/JVBtjptq7HigkNPjqdtii4W6RH4gOfJgW0pxzivUA6A8PX8SycbGKUTJ
         hqUhvnIhXq23gFKmOsRKmIhS7uB4TVMHfiAih56j3hNZe94fut/JT4Vr8cSxOwrbK+ff
         znQ5Tfs33QGMbPfIgz9YHGJlpe1SyAEIonzkCeTjaizM/Ygq9anFaJUTFVOnuhsLc5qJ
         mbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cWOZ10wj2v8xGCTkB4tkDGPE0ipYkZlGVNgK1wjlSKw=;
        b=vfaoGyGdmXGBiRZ4UgCqpCN0xUSoxyLiJxp7jlC+Ke09EUOXP0TBTHGugyeJP6mGhe
         iV831ciIZtlUfp60MlJOErksrB/IotbZixBgikucY7SxnUWGgdmY5HT8wnOHtcDg2CwN
         786RkmwbkQP+98df0j71YoBuTV0HstfLKgNwJ7b7T7zoR9Cc2w7KbmoSdAsjRh+vPGLu
         zsW7oQt5uWtLPil0U0sSVZM525KaG1+ec+Lc1wiulf0WjfGs0DHVZU+eC30xtslLmaPM
         F2+5XJEU41l2nNW/VHTzdlOw2gzcp4pBZtEhX21IzKe7DmgEO0v8Vh42oY5xQ9cn5IDP
         rIRw==
X-Gm-Message-State: AOAM532BwQrfuAFMKcx2CgGYMYAnybt5igUwXtSgez1nXKbeqeHcUjQc
        jhxeeYTGPuBEBd0F++/6fNKYTxhJQM+kKNOVpr0=
X-Google-Smtp-Source: ABdhPJzKdoy+jz5VQV5Ihbb1TCNijRakZIFx6FMRizoKZTvmhjIQMJT/zQWj2ePGI5xnyqAUpbTaxMlQh/TKk/n205A=
X-Received: by 2002:a05:6512:3d89:: with SMTP id k9mr7771626lfv.359.1635164855150;
 Mon, 25 Oct 2021 05:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <90277228-cf14-0cfa-c95e-d42e7d533353@oderland.se> <20211025012503.33172-1-jandryuk@gmail.com>
In-Reply-To: <20211025012503.33172-1-jandryuk@gmail.com>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Mon, 25 Oct 2021 08:27:23 -0400
Message-ID: <CAKf6xptSbuj3VGxzed1uPx59cA_BRJY5FDHczX744rvnTHB8Lg@mail.gmail.com>
Subject: Re: [PATCH] PCI/MSI: Fix masking MSI/MSI-X on Xen PV
To:     Josef Johansson <josef@oderland.se>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Juergen Gross <jgross@suse.com>, linux-pci@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        xen-devel <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 24, 2021 at 9:26 PM Jason Andryuk <jandryuk@gmail.com> wrote:
>
> commit fcacdfbef5a1 ("PCI/MSI: Provide a new set of mask and unmask
> functions") introduce functions pci_msi_update_mask() and
> pci_msix_write_vector_ctrl() that is missing checks for
> pci_msi_ignore_mask that exists in commit 446a98b19fd6 ("PCI/MSI: Use
> new mask/unmask functions").  The checks are in place at the high level
> __pci_msi_mask_desc()/__pci_msi_unmask_desc(), but some functions call
> directly to the helpers.
>
> Push the pci_msi_ignore_mask check down to the functions that make
> the actual writes.  This keeps the logic local to the writes that need
> to be bypassed.
>
> With Xen PV, the hypervisor is responsible for masking and unmasking the
> interrupts, which pci_msi_ignore_mask is used to indicate.
>
> This change avoids lockups in amdgpu drivers under Xen during boot.
>
> Fixes: commit 446a98b19fd6 ("PCI/MSI: Use new mask/unmask functions")
> Reported-by: Josef Johansson <josef@oderland.se>
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> ---

I should have written that this is untested.  If this is the desired
approach, Josef should test that it solves his boot hangs.

Regards,
Jason
