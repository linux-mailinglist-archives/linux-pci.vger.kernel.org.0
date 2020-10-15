Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5160128ED30
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 08:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgJOGtj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 02:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgJOGtj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 02:49:39 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A70C061755;
        Wed, 14 Oct 2020 23:49:38 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id 67so1380045ybt.6;
        Wed, 14 Oct 2020 23:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mon8oii3zGIW2Gmixo1N9gE4BLHeCJtX3lO1sZeHShM=;
        b=Y04z49oMsViBHDeg9tl7gbxAqIKih4a/ICwylrucy+5oH1WhvaYmY5Iryh/VwH5DJU
         uyYowMpAlegTdDFyEhJANP+1OAEVqZTD90NwgdBHRZ7qn8T7cihqXQEv7y6YEHKYLZNy
         TZcxktyqKdKum0G8AraJYT5tOBVp+thCgmBJf3Nf5TpuTmGyiuA4ZiH6RZv3rFvVyNzp
         zjWAAUrpa0rVNzZ4xAyII+quG7jDqzGC7UenmlCAvAWXsJBTKit9gW5OfoC+zAyMI/1X
         0c10YPj232fb+8WUJnHJn7vceR+lYBvuVEDDI0WwiHrx3OPR7yN8JpPqz5km/udp5mbf
         qgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mon8oii3zGIW2Gmixo1N9gE4BLHeCJtX3lO1sZeHShM=;
        b=eFrIOo8gxiZPeuHP7IjHmcH4U67a8fQTFGzgBt4oXpzE7Y87WEpTRC9GEzOi4OTtbV
         eeVd9Ox9NObBjeluTSoCMoEYAYVkr1faAD/ri4An7pVfA6r0MrWTpXT5gmTN3Bwd7LxJ
         h0CNMwU9VRsInl+KpVIf5yuplnQ6ls6PoNcUwCHqxDtD3XNs7wuauZ5+FzZTmrGQOXgA
         TY+MAZCA1gm7rcBgvQVsAqsb1dIAg5EzUtUR9anvMaC7wUAnZOvovRdpnEhbOF4kfCjA
         q0E+CAl/rfYUpZC4wZVU2EvV45qqUWbegaO81QLBLMdNGxCVgZN5c2Ay3YJ1qufit/L8
         tWlw==
X-Gm-Message-State: AOAM5324QIZ7QzCCQL9/r0AaZEXGGnNjryPvH9sEGhB3b/WDwo83/TE6
        AYY7dGUZ5bg7ajGrlpX+whhcr5NB7Y096nAEgr0=
X-Google-Smtp-Source: ABdhPJymzt2IVpf+mOYKPkVDw+L9qfhrR9lFCZ9CgPzx+c8HMyWPCVLTaKG5TpRLT1ExJUW/Ud/Jj0uDNVx8wpzA10M=
X-Received: by 2002:a25:6755:: with SMTP id b82mr3319215ybc.485.1602744578322;
 Wed, 14 Oct 2020 23:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <5c5bca0bdb958e456176fe6ede10ba8f838fbafc.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <c6e3f1168d5d88b207b59c434792a10a7331bb89.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20201013115600.GA11976@infradead.org> <2fa2e5ed-dbfb-f335-5429-8bbb13f004e2@linux.intel.com>
 <20201015064329.GA12987@infradead.org>
In-Reply-To: <20201015064329.GA12987@infradead.org>
From:   Sathyanarayanan Kuppuswamy Natarajan 
        <sathyanarayanan.nkuppuswamy@gmail.com>
Date:   Wed, 14 Oct 2020 23:49:27 -0700
Message-ID: <CAC41dw9EUjJ7S2jo-m5kF+hYK31ApA7WK_PmXo13mwPOr_=goA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PCI/ERR: Split the fatal and non-fatal error
 recovery handling
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, okaya@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ashok <ashok.raj@intel.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 14, 2020 at 11:43 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Oct 13, 2020 at 08:17:39AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> >
> >
> > On 10/13/20 4:56 AM, Christoph Hellwig wrote:
> > > You might want to split out pcie_do_fatal_recovery and get rid of the
> > > state argument:
> > This is how it was before Keith merged fatal and non-fatal error recovery
> > paths. When the comparison is between additional-parameter vs new-interface
> > , I choose the former. But I can merge your change in next version.
>
> But now you split the implementation.  Keith merged made complete sense
> when the code was mostly identical.  But now that the code is separate
> again it doesn't make sense to hide it under a common interface that
> uses a flags value to call different functions.
Agreed. Already included this change in v6.
