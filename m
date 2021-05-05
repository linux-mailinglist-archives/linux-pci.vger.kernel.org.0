Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6453A3747B0
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 20:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbhEESCB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 14:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbhEESBs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 May 2021 14:01:48 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E199C0612B2;
        Wed,  5 May 2021 10:40:48 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id i13so2653154pfu.2;
        Wed, 05 May 2021 10:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dnLyDfQDKmEAB/Zy+442w63QRqZp2WSqlDnxSjfCge4=;
        b=bXhTE29PQrwhDVpLwBQ4HUuP+kyBa2bSEZEcD0J+th4tx0C1f6RWKVmbl9HNi7oMJi
         PGS0jRpFGtWKoZRDOuTFZshYeRIjaAz8g3n+iElM1YJt+HetiLJ8wFMtezbArav7YhiB
         qAw333p8KmP07CS5K32SjNtLPYYH57odD8pNTcaNSGLIEJGsnB8gSspfGjx472rRa/Vh
         vIf4f1CSY3z8tljfG3rvXg7s2pxScfnPqjQKR2eqtgAyFzXEpbvbcEhGP2JpFxIaRRh7
         g//j922xF4QPxd7CsN90kTiqw9x9oWkATwcaSkD1qmAPmYwun2K1vYEqnudOlRqGO5fn
         esSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dnLyDfQDKmEAB/Zy+442w63QRqZp2WSqlDnxSjfCge4=;
        b=Oh+YjyaQh3k5UihFL9sTcy7TO3NDmRCbuqMBOEWYbfW+eUVR5j29KM/xq6KPPu97NG
         HJL9/hX5fdMJ09jVYEFkED6JYo2a8WKgJPYs3rlSzK01c97vcsYujX5vOtUewfUdnLK5
         dnXtykW4mN9TlR1QLNZtahg2kfhfQIEtmNydcvy30SIH6nWbbjWGFnrz9QJnbfzsHM5T
         l7CuR9iLn1txaVTeer2+noqDAyp/2mg1yywAYbOcUnwzJ4NiwRcq3ReZo0mWuNm0xoeD
         ggz63E3I9ch2mx9WuCA7mRDRBD1qmdEc7oLTvDvwA59E6Yn1iiqtG+t3BEckvyBApax/
         0E5A==
X-Gm-Message-State: AOAM532TYUl4RoolRVZ7eYTFzW+kuKvtRBM5VpLZCfLprbP8kttM8nsV
        kKwKyDMwlYq4cnkPKEo6nt6gVzq0mYI=
X-Google-Smtp-Source: ABdhPJzEpZaeUy588mWV1OdwjxOsiG2gfmbOpQ6PgYXLED86mFJrs1aRDuR5uHOCBeSOCX42qEAdww==
X-Received: by 2002:a63:ed17:: with SMTP id d23mr72055pgi.107.1620236447937;
        Wed, 05 May 2021 10:40:47 -0700 (PDT)
Received: from localhost ([103.248.31.167])
        by smtp.gmail.com with ESMTPSA id a190sm16363738pfd.118.2021.05.05.10.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 10:40:47 -0700 (PDT)
Date:   Wed, 5 May 2021 23:10:32 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Oliver O'Halloran <oohall@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Shanker R Donthineni <sdonthineni@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH v4 2/2] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
Message-ID: <20210505174032.sursnpwkfrc5qji2@archlinux>
References: <478efe56-fb64-6987-f64c-f3d930a3b330@nvidia.com>
 <20210505021236.GA1244944@bjorn-Precision-5520>
 <CAOSf1CFACC5V1OdA9i9APipTUE3GmXu487vt-btXWk5rP97UAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSf1CFACC5V1OdA9i9APipTUE3GmXu487vt-btXWk5rP97UAQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/05/05 01:56PM, Oliver O'Halloran wrote:
> On Wed, May 5, 2021 at 12:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Mon, May 03, 2021 at 09:07:11PM -0500, Shanker R Donthineni wrote:
> > > On 5/3/21 5:42 PM, Bjorn Helgaas wrote:
> > > > Obviously _RST only works for built-in devices, since there's no AML
> > > > for plug-in devices, right?  So if there's a plug-in card with this
> > > > GPU, neither SBR nor _RST will work?
> > > These are not plug-in PCIe GPU cards, will exist on upcoming server
> > > baseboards. ACPI-reset should wok for plug-in devices as well as long
> > > as firmware has _RST method defined in ACPI-device associated with
> > > the PCIe hot-plug slot.
> >
> > Maybe I'm missing something, but I don't see how _RST can work for
> > plug-in devices.  _RST is part of the system firmware, and that
> > firmware knows nothing about what will be plugged into the slot.  So
> > if system firmware supplies _RST that knows how to reset the Nvidia
> > GPU, it's not going to do the right thing if you plug in an NVMe
> > device instead.
> >
> > Can you elaborate on how _RST would work for plug-in devices?
>
> Power cycling the slot or just re-asserting #PERST probably. IBM has
> been doing that on Power boxes since forever and it mostly works.
> Mostly.
According to ACPI spec v6.3 section 7.3.25, _RST just performs normal
FLR in most cases but if the device supports _PRR(Power Resource for Reset)
then reset operation causes the device to be reported as missing from the bus
that indicates that it affects all the devices on the bus.

Thanks,
Amey
