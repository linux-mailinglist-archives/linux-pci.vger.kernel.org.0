Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8008233DB4
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jul 2020 05:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbgGaDab (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jul 2020 23:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730820AbgGaDab (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2020 23:30:31 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D840DC061574
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2020 20:30:30 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v6so15165702iow.11
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2020 20:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Su5lKFNWeulhsct9iwtDAxmGUMKFC2lpWVUWlye0WBs=;
        b=HnoN+fOjIxv1/Df2dvqEhUbB7GLtOExM56z76Ap6dpEUm9CQfbm37z+IXIaLZnuuYc
         hyAfyFxOlLTsUkjKTCDPjA3LeUuQJ7FrJPOJYbUQlYV2XqzAvBR/N0F6vddyhySelAsG
         a2uz++Su+vpLvOqFZG13Z74k2E4BtXiPEFqpueqZKiWCeod90yQlAKH+OP2Fhg36X1ck
         fsPp5cKMpoOiW0UMfL6AcOdDdR87n1fHkl9u6pBS+XXiOkGQHcYDuxMfxeHcmjJEKLNY
         yx5EjjBizz8v4PRTRd3Vyw1/qCpZNiF7C/tbcLfxb9ELxjLuZxNck7L43y+N1JsUQVmq
         gj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Su5lKFNWeulhsct9iwtDAxmGUMKFC2lpWVUWlye0WBs=;
        b=hwd2PVHPWfajpQ2boXLrvDmygb71h8bZYXwd+aRzaucW8O78K0NOggefR5ZTwgX6Tq
         oW0A/dNkvMRIeSLNkSRDiqcn4i35P2b2wcsXfgewHJWJGu/k9EcEjBKWDOYJVtixhUPl
         PtjNsGolMJRT+u1Pa7Nv9kPtRKgJxmlaDrMgFIjogzPJwJdbaBbEwWySVznNabEOrkRq
         J2bDw3QeYpiwXUWzOyx5jFAhG7JBVCaWAjhCbvbUagYTUuCm1dj40K1ZwSg4wjcxorlk
         5hCMxOVt9KoTDyLXBkz05c82yFlkBqpAnA/r8V8zajFGJaWFRTW/0G1XNdrFRLkxkqr+
         sveg==
X-Gm-Message-State: AOAM532cYnPDaHXVqYjMgVP5RA0WmwwkdpRKB0boGnp41BEHLLLok3T/
        euyeoggQQxH+tpFgz7Wd4cRnwvFAsy8l12yzrnwJiD8+
X-Google-Smtp-Source: ABdhPJxvvO1IcEtJ+7bcSB6kUy2CcSTiVMB06Q2hv1UyFbElqivrTTce1lNxaVdPclzUoXfd4OaoGuVoXGKM0N99IVI=
X-Received: by 2002:a05:6638:2401:: with SMTP id z1mr2673950jat.97.1596166230243;
 Thu, 30 Jul 2020 20:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200430131520.51211-1-maxg@mellanox.com>
In-Reply-To: <20200430131520.51211-1-maxg@mellanox.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Fri, 31 Jul 2020 13:30:19 +1000
Message-ID: <CAOSf1CERo2EGafcjOPfJ7NNFwE2Y7OJ_yGbR7xOGvf+PnrxSfw@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] powerpc/dma: Define map/unmap mmio resource callbacks
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        israelr@mellanox.com, idanw@mellanox.com, vladimirk@mellanox.com,
        shlomin@mellanox.com, Frederic Barrat <fbarrat@linux.ibm.com>,
        Carol L Soto <clsoto@us.ibm.com>, aneela@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 30, 2020 at 11:15 PM Max Gurtovoy <maxg@mellanox.com> wrote:
>
> Define the map_resource/unmap_resource callbacks for the dma_iommu_ops
> used by several powerpc platforms. The map_resource callback is called
> when trying to map a mmio resource through the dma_map_resource()
> driver API.
>
> For now, the callback returns an invalid address for devices using
> translations, but will "direct" map the resource when in bypass
> mode. Previous behavior for dma_map_resource() was to always return an
> invalid address.
>
> We also call an optional platform-specific controller op in
> case some setup is needed for the platform.

Hey Max,

Sorry for not getting to this sooner. Fred has been dutifully nagging
me to look at it, but people are constantly throwing stuff at me so
it's slipped through the cracks.

Anyway, the changes here are fine IMO. The only real suggestion I have
is that we might want to move the direct / bypass mode check out of
the arch/powerpc/kernel/dma-iommu.c and into the PHB specific function
in pci_controller_ops. I don't see any real reason p2p support should
be limited to devices using bypass mode since the data path is the
same for translated and untranslated DMAs. We do need to impose that
restriction for OPAL / PowerNV IODA PHBs due to the implementation of
the opal_pci_set_p2p() has the side effect of forcing the TVE into
no-translate mode. However, that's a platform issue so the restriction
should be imposed in platform code.

I'd like to fix that, but I'd prefer to do it as a follow up change
since I need to have a think about how to fix the firmware bits.

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>
