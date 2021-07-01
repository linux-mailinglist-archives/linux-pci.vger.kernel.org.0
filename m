Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932C23B9195
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 14:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbhGAM24 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 08:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbhGAM2z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jul 2021 08:28:55 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B0AC061756
        for <linux-pci@vger.kernel.org>; Thu,  1 Jul 2021 05:26:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u8so7961370wrq.8
        for <linux-pci@vger.kernel.org>; Thu, 01 Jul 2021 05:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kssr4gmtp/IYFhUj7wTF1rAC75pSE7knZqtnbVaCSJQ=;
        b=bNldtXZX7OEsU7hC/ydIj5dZEObpyOXouxDSTP89Bgkm87aVhs+/bm1l7KCWSLfxUY
         +63/2TYNUoS4zfmhz64+zcyhyR+i9yXH910ON0rNU4Y1WQDxQ98gafnnx+XnYp5CfkpB
         tPmkpwU9vwlTeed7La9IgctWwoV91OfNryWv1O+tXb5Yj1aV1adqxcVoJDmjl/xjuldP
         O4vUhCVi2hOqheVzxcJTz8Ff1BTOJo6PF4iVhEbkB263lHY0zM9xJx+UKUXZGTKVJKrI
         Q/QPQqUu2EjkDt8Uakc7DwKgz6a3KEa/n5ZGqhBiC89+fLOCB64xhrzqQPEDj3ntuqle
         fY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kssr4gmtp/IYFhUj7wTF1rAC75pSE7knZqtnbVaCSJQ=;
        b=QhSgaOb6o5lPYfSJ9ruz61B2F9LUzGUYthLDGPQCD0x55raArf0Q8SUTqaj2mPPGT8
         RR6fEz+3TFh+A7+hyWeWJIV6suk1avadmskxowODiDBpSU2k6tCvdyBxk9ujcCV147Pz
         h2RD6eeFqrgLThJSWgfzNZ9xthwdNegyLloxIhCEBwiZ6Ho7MPjoLqg5NYWlJ54h0PVw
         E5v05jmiYtsjHYnA8jb/pfzNS71y0a4dbcHcWWbuXIVKXmmYIwkENlCWlABPvj0USQ6O
         Sc1aqfH0Ypo1gKtRE9bujf25ufhF4vVMqZzy6X0goZA0VnCdSh7Af070JWoeLLFmROLo
         s2LA==
X-Gm-Message-State: AOAM533FlYOyvEIC13QD+ddB44JvfXuWj9sKHvj6D/JwAratYNGn0e7f
        2qkt2hjv7GxdQk1txGp2A3qN4g==
X-Google-Smtp-Source: ABdhPJzBdFnxTWsk0egKHVdT1n4WauRyT1kSgT/Hb+MvhoTby5kBqrcZY9ZsQQ6/vghoUeShvliqvA==
X-Received: by 2002:a5d:564c:: with SMTP id j12mr46200631wrw.37.1625142382388;
        Thu, 01 Jul 2021 05:26:22 -0700 (PDT)
Received: from dell ([109.180.115.217])
        by smtp.gmail.com with ESMTPSA id n18sm4392386wms.3.2021.07.01.05.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 05:26:21 -0700 (PDT)
Date:   Thu, 1 Jul 2021 13:26:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/4] MFD: intel_pmt: Remove OOBMSM device
Message-ID: <YN20a95YllXYUwjG@dell>
References: <20210617215408.1412409-1-david.e.box@linux.intel.com>
 <20210617215408.1412409-3-david.e.box@linux.intel.com>
 <YNxENGGctLXmifzj@dell>
 <f590ee871d0527a12b307f1494cb4c8a91c5e3c2.camel@linux.intel.com>
 <e734a968-818a-380d-0ae5-fee41b3db246@redhat.com>
 <YN2lmdDAOaykCvHK@dell>
 <CAHp75Vfn6GKSj6USUPEWiPdhWRYcJbirqhU6aOeB4gruekmocg@mail.gmail.com>
 <YN2vwT+7sVRvz8iS@dell>
 <CAHp75VdmnRJKSBZ8dmU=7XsGOZ-wX6EpZhtC3X6JEE0mz-UJNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdmnRJKSBZ8dmU=7XsGOZ-wX6EpZhtC3X6JEE0mz-UJNg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 01 Jul 2021, Andy Shevchenko wrote:

> On Thursday, July 1, 2021, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > On Thu, 01 Jul 2021, Andy Shevchenko wrote:
> >
> > > On Thursday, July 1, 2021, Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > > On Thu, 01 Jul 2021, Hans de Goede wrote:
> > > >
> > > > > Hi,
> > > > >
> > > > > On 6/30/21 11:11 PM, David E. Box wrote:
> > > > > > On Wed, 2021-06-30 at 11:15 +0100, Lee Jones wrote:
> > > > > >> On Thu, 17 Jun 2021, David E. Box wrote:
> > > > > >>
> > > > > >>> Unlike the other devices in intel_pmt, the Out of Band Management
> > > > > >>> Services
> > > > > >>> Module (OOBMSM) is actually not a PMT dedicated device. It can
> > also
> > > > > >>> be used
> > > > > >>> to describe non-PMT capabilities. Like PMT, these capabilities
> > are
> > > > > >>> also
> > > > > >>> enumerated using PCIe Vendor Specific registers in config space.
> > In
> > > > > >>> order
> > > > > >>> to better support these devices without the confusion of a
> > > > > >>> dependency on
> > > > > >>> MFD_INTEL_PMT, remove the OOBMSM device from intel_pmt so that it
> > > > > >>> can be
> > > > > >>> later placed in its own driver. Since much of the same code will
> > be
> > > > > >>> used by
> > > > > >>> intel_pmt and the new driver, create a new file with symbols to
> > be
> > > > > >>> used by
> > > > > >>> both.
> > > > > >>>
> > > > > >>> While performing this split we need to also handle the creation
> > of
> > > > > >>> platform
> > > > > >>> devices for the non-PMT capabilities. Currently PMT devices are
> > > > > >>> named by
> > > > > >>> their capability (e.g. pmt_telemetry). Instead, generically name
> > > > > >>> them by
> > > > > >>> their capability ID (e.g. intel_extnd_cap_2). This allows the IDs
> > > > > >>> to be
> > > > > >>> created automatically.  However, to ensure that unsupported
> > devices
> > > > > >>> aren't
> > > > > >>> created, use an allow list to specify supported capabilities.
> > > > > >>>
> > > > > >>> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > > > >>> ---
> > > > > >>>  MAINTAINERS                                |   1 +
> > > > > >>>  drivers/mfd/Kconfig                        |   4 +
> > > > > >>>  drivers/mfd/Makefile                       |   1 +
> > > > > >>>  drivers/mfd/intel_extended_caps.c          | 208
> > > > > >>> +++++++++++++++++++++
> > > > > >>
> > > > > >> Please consider moving this <whatever this is> out to either
> > > > > >> drivers/pci or drivers/platform/x86.
> > > > > >
> > > > > > None of the cell drivers are in MFD, only the PCI drivers from
> > which
> > > > > > the cells are created. I understood that these should be in MFD.
> > But
> > > > > > moving it to drivers/platform/x86 would be fine with me. That
> > keeps the
> > > > > > code together in the same subsystem. Comment from Hans or Andy?
> > > > >
> > > > > I'm fine with moving everything to drivers/platform/x86, but AFAIK
> > > > > usually the actual code which has the MFD cells and creates the
> > > > > child devices usually lives under drivers/mfd
> > > >
> > > > Correct.  It must.
> > >
> > > It’s definitely not the first time you are talking about, but it may be
> > the
> > > first time I asked why it’s not enforced overall. Last time I have
> > checked
> > > it was like 5-7 MFD uses outside the MFD folder. Are you going to fix
> > that?
> >
> > Because I can't NACK patches that weren't sent to me. :)
> >
> >
> Hint: you may add regexp match to the maintainers database and you will see
> them more often

Good idea.  I'll add it to my TODO.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
