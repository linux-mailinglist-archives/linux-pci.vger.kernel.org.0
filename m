Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AEA3C65FA
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 00:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhGLWKi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 18:10:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24455 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231289AbhGLWKh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jul 2021 18:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626127667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rC1yUGWBvIID360PWaPb4pUccgpGiNBVKC/0HCxB0ds=;
        b=MjQO2+Jp8Ah08jSRxzsQgdN0aSxDN2DpMYdUxFiDNgf60VKQjMIhnZgNaKRKirfj+kNuQV
        34FV8/ZM7TeS33oiA3Rw1XIQM243bKiatbJE8t9TIinZMjzjoHxxl7A9wdRufPlPrZwqXu
        mYtfEA71iE9qbIVpr/5IBluOPmMbcRg=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-NcVf5Q8EMoi_o-L0T0pZ8w-1; Mon, 12 Jul 2021 18:07:46 -0400
X-MC-Unique: NcVf5Q8EMoi_o-L0T0pZ8w-1
Received: by mail-ot1-f71.google.com with SMTP id 59-20020a9d0dc10000b02902a57e382ca1so14137251ots.7
        for <linux-pci@vger.kernel.org>; Mon, 12 Jul 2021 15:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rC1yUGWBvIID360PWaPb4pUccgpGiNBVKC/0HCxB0ds=;
        b=qF5SwolunZZ3xU3QylJSRTD8vA/XVZ6tfleppgUcirYtL3hPlvPPOEMFnH4tdMR4Ye
         GS54v6n4pdrgAkapExB3UhvnKcgIpRTYIilRtYWrYF+CGovWjOqWP8x+kBiydqz2NQtT
         lmJu7K/WBAhU3wufhcUxPFAARjB4kpHZyetC2ZIh6EcSiA5OWZB0+KXGzK1ghpeYSSDG
         UVXxVcxKEkhcM7OAj1sUlhlPJUT5qkux99SvPbdWGXClkFN37+Rpm86FaDEHn1y6tDm6
         sPfao8vFrYKqW5b/oQG3y+0PguMfSlLu95wbL+EwDF+gPLsLT3hZPNw/1yukoalxQgkZ
         oCtw==
X-Gm-Message-State: AOAM533j1S6tbrbYIFQbVrd7ZIchMS+LrbIvp5LvH0jlmIDMvKx8RNT5
        jcHk6NPYHWA/uNqXP+SYgS1kNb1U+IrJG+tSKLHRO2tyxvu7amiu6Xb4JiSvLBpjsneQOqvTNPD
        afF3biqzysfFB38E1Yeo3
X-Received: by 2002:a05:6808:2024:: with SMTP id q36mr713302oiw.130.1626127665777;
        Mon, 12 Jul 2021 15:07:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwom3gaAzIAzvPzYLLUu/UBp7QXOHYRTrnaYNmrGEcq8p2L2vUeBMc2AmGqe/dErID5t0VTsw==
X-Received: by 2002:a05:6808:2024:: with SMTP id q36mr713289oiw.130.1626127665590;
        Mon, 12 Jul 2021 15:07:45 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id o63sm3483664oih.32.2021.07.12.15.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 15:07:45 -0700 (PDT)
Date:   Mon, 12 Jul 2021 16:07:44 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 1/8] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Message-ID: <20210712160744.0a651364.alex.williamson@redhat.com>
In-Reply-To: <20210709123813.8700-2-ameynarkhede03@gmail.com>
References: <20210709123813.8700-1-ameynarkhede03@gmail.com>
        <20210709123813.8700-2-ameynarkhede03@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri,  9 Jul 2021 18:08:06 +0530
Amey Narkhede <ameynarkhede03@gmail.com> wrote:

> Add has_pcie_flr bitfield in struct pci_dev to indicate support for PCIe
> FLR to avoid reading PCI_EXP_DEVCAP multiple times.
> 
> Currently there is separate function pcie_has_flr() to probe if PCIe FLR
> is supported by the device which does not match the calling convention
> followed by reset methods which use second function argument to decide
> whether to probe or not. Add new function pcie_reset_flr() that follows
> the calling convention of reset methods.
> 
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +-
>  drivers/pci/pci.c                          | 59 +++++++++++-----------
>  drivers/pci/pcie/aer.c                     | 12 ++---
>  drivers/pci/probe.c                        |  6 ++-
>  drivers/pci/quirks.c                       |  9 ++--
>  include/linux/pci.h                        |  3 +-
>  6 files changed, 45 insertions(+), 48 deletions(-)

Looks good to me,

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

