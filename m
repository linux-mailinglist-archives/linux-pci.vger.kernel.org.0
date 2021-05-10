Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81244379613
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 19:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbhEJRhm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 13:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhEJRha (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 13:37:30 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A19C06135C
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 10:32:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id f24so25736276ejc.6
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 10:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fTRKZAFvqeeymDKM/r/UzLZvx5eNijO38qr4B7yUecU=;
        b=WG2cArXg2kBcywMKLErBIWqdK6ViZ+A43yHnNzCeEKDwl8ef6OOBCGGPsCNIhnwtgq
         OKnbg1pUoFa5NkOxx7p+eavNpuKHLmDTkGe52xEmPiPqZabIeotnZ8bVgdB8r/5A8p8z
         mbBqa7euwAldecqynHP+UET9zwKx/5FY7p4v4fR//02KPL5IbhAdR3a8NT6KJeHxRjdt
         IWDLz+xGWr7JetBx8yhlj2CMfGxO0XQZTFYvu52XIW5Nq8I5zEKidHQ2DCyVWKAqPpDg
         VuypFQIec2SfyXj0TN7fAr0ov+EjwMQgY+VWosh3M4NidaItw3pY91ciRmZPdX/O40vD
         q5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fTRKZAFvqeeymDKM/r/UzLZvx5eNijO38qr4B7yUecU=;
        b=ErgPLu1qStVEUTNOLR7rWO3eZ+SW4e5gr2Sydjm6O9GJzz4NFxgj4E+e0L0UxxdWD8
         yaBiWOJNj6RRlKfw1OQZ+jGsIP5TA6sot4vfeu1ht7tbGxgvI4xf55pWvuKOSck7/F/f
         ei4Bw8bX1brdk1Su4+uJbn+vIX1x8FAZYJ2n0epaYiI119LwA2icYkJpFYWNH4qAZjOx
         5kqCyzg2kJMnbfs0YuKOMGNAbQC1YCZfH1PQ3mUTbYz9kj9LQ36qcNKEaw1QikSwJNv0
         FlfapZTFtQbgm5W6zu2Gp+UtPJ24dA1ptblZhPMC2yO8/wCWbYm/EDIrEDE4vWjeYrtj
         qZ0A==
X-Gm-Message-State: AOAM530q1S9Sq5kKjvl9SHk2damU69ZobS9uxbjpCPTDZN7wtisndyMx
        l+gwvBvkAwHKsBQ7ETcJr+iy0IqZ/WOfN6CyrlKypQ==
X-Google-Smtp-Source: ABdhPJyHSjhlDK3zc/WiT+90p68knPbG/a4ZpLabkTJDhyCAwwOZ7p745kEgDnK2io0XqAhOvv5HP88IY4460qmOo88=
X-Received: by 2002:a17:906:33da:: with SMTP id w26mr27425953eja.472.1620667925736;
 Mon, 10 May 2021 10:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <162042787450.1202325.5718541949681409566.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210510182249.0000267f@Huawei.com>
In-Reply-To: <20210510182249.0000267f@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 10 May 2021 10:31:54 -0700
Message-ID: <CAPcyv4iMSvq17_0nLYgeKFKGWberEyG9HHK=+k+Zy9UQG+4iuw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] CXL Port Enumeration and Plans for v5.14
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 10, 2021 at 10:24 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 7 May 2021 15:51:14 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Changes since v2 [1]:
> > - Add some rationale for moving definitions out of mem.c into mem.h
> >   (Jonathan)
> >
> > - Fixup CXL_DEVICE_REGS kernel doc and declare the fixup for the
> >   struct cxl_mem kernel-doc in the changelog (Jonathan)
> >
> > - Fixup cxl_setup_device_regs() kernel-doc (Jonathan)
> >
> > - Cleanup comment in cxl_root_alloc() (Jonathan)
> >
> > - [not changed] refactor device creation into alloc_and_add()
> >   anti-pattern.
> >
> > - Add kernel doc to cxl_address_space_dev_add() to clarify why @host is
> >   needed as an arg. (Jonathan)
> >
> > - Describe what the port devices are representing in "cxl/port:
> >   Introduce cxl_port objects" (Jonathan)
> >
> > - Explain the rationale for /sys/bus/cxl (Bjorn)
> >
> > [1]: http://lore.kernel.org/r/161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com
>
> Hi Dan,
>
> What's the base for this series?  Given it was nearly ready to go
> (as far as I'm concerned anyway), I thought I'd give it a spin but
> seems it doesn't have some changes from fixes that have gone upstream.

I did fail to rebase, will rectify, but I did not fail to include a
base-commit entry at the bottom of this cover letter. Will resend
based on -rc1 now that it is out.
