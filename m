Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B4A391CFD
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 18:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhEZQZw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 12:25:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35282 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhEZQZw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 12:25:52 -0400
Received: from mail-lf1-f71.google.com ([209.85.167.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1llwKR-0008Fe-Ij
        for linux-pci@vger.kernel.org; Wed, 26 May 2021 16:24:19 +0000
Received: by mail-lf1-f71.google.com with SMTP id d26-20020a194f1a0000b02902390d1deb9dso821873lfb.18
        for <linux-pci@vger.kernel.org>; Wed, 26 May 2021 09:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EaLER3aOaefvnJohx084gatUZrVitp6/k9BAoBcbFwQ=;
        b=nVP5PFYKn+A02d9pQRLjBuHG5+PSUJl7Qpc/qQ4IhbUxolcVWZRXhKU08Baqk+6JsU
         itKVdawg67dQWLDulLSNO/F6MM/Ce1b6zW9cS6ObK1ZKDZjyMx9hKoE5E50gUTiuGiJH
         A9W7LRgNnBycCv0FqVI3Q4aREXdIojcmSP565sJsWj1HSaP0OpvbSGHsMPympJB2ASsz
         SMAI1nO0k+azsXHw93T4L3ndvgzG/sC+17tlKMOpLkxGRM+gVldDDeZP7vMfRK5qnKSa
         Aq9SjDyAjSIcH23wpfyTnm3gmclCszjBqm6PoC1G0fKlGXc+SqowJs4Tb5IXKD4+QzMf
         Df5w==
X-Gm-Message-State: AOAM530v9eyi6YmfaS7mOUeLs8LZenYJvx7uYnoeLpc5a4HxBpD1fMHT
        OfoQBxL37r3L/L6IJfoFgKZoS0kko6L2IaTBftibnfPxVsqgp7SHE7K+DG0Q+MltbHkbf63uWSo
        G394JnylHaGkotMq8Lrna2AszRpw+JI7eDxVAslY4lu0tBUkaOFBojg==
X-Received: by 2002:ac2:4144:: with SMTP id c4mr2630895lfi.425.1622046258902;
        Wed, 26 May 2021 09:24:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTX2NBJBNN4eqh1bmc0CzSsdUjoLFqYdZdKExzytvKRntLCQ7lGSKYfKS2XXdeHamQs7tXA0/k/v58IQQ8mVE=
X-Received: by 2002:ac2:4144:: with SMTP id c4mr2630873lfi.425.1622046258620;
 Wed, 26 May 2021 09:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAAd53p6TJev=LgdvGxC92A9HOy3B6jbPLymAqeB5bDe2=5Fdsw@mail.gmail.com>
 <20210526150633.GA1291513@bjorn-Precision-5520>
In-Reply-To: <20210526150633.GA1291513@bjorn-Precision-5520>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 27 May 2021 00:24:06 +0800
Message-ID: <CAAd53p7Mnv6HUv8hfjnsCpGeaSPXVAiA4D8gMxxdn6Bz8Z1fBQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use npss.
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Koba Ko <koba.ko@canonical.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Henrik Juul Hansen <hjhansen2020@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 26, 2021 at 11:06 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, May 26, 2021 at 10:47:13PM +0800, Kai-Heng Feng wrote:
> > On Wed, May 26, 2021 at 10:28 PM Christoph Hellwig <hch@lst.de> wrote:
> > > On Wed, May 26, 2021 at 10:21:59PM +0800, Kai-Heng Feng wrote:
> > > > To be fair, resuming the NVMe from D3hot is much slower than keep it
> > > > at D0, which gives us a faster s2idle resume time. And now AMD also
> > > > requires s2idle on their latest laptops.
> > >
> > > We'd much prefer to use it, but due to the broken platforms we can't
> > > unfortunately.
> > >
> > > > And it's more like NVMe controllers don't respect PCI D3hot.
> > >
> > > What do you mean with that?
> >
> > Originally, we found that under s2idle, most NVMe controllers caused
> > substantially more power if D3hot was used.
> > We were told by all the major NVMe vendors that D3hot is not
> > supported.
>
> What is this supposed to mean?  PCIe r5.0, sec 5.3.1, says
>
>   All Functions must support the D0 and D3 states (both D3Hot and D3Cold).
>
> Since D3hot is required for all functions, I don't think there is a
> standard way to discover whether D3hot is supported.  The PM
> Capability (sec 7.5.2.1) has D1_Support and D2_Support bits, but no
> D3_Support bit.
>
> Are the vendors just saying "sorry, our devices don't conform to the
> spec"?

Yes, that's exactly what they said. Because Windows Modern Standby
always keep the NVMe at D0, so D3hot is untested by the vendors.

NVMe vendors explicitly asked us to keep the NVMe controllers at D0 for s2idle.

>
> If what you really mean is "D3hot is supported and it works, but it
> consumes more power than expected,

If D3hot consumes more power than D0, is it really supported?

> or the D3hot->D0 transition takes
> longer than expected," that's a totally different thing, and you should
> say *that*.

The D3hot->D0 transition doesn't take longer than expected. It's just
relatively slower than keeping the NVMe at D0.

Kai-Heng

>
> Bjorn
