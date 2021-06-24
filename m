Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7B63B3075
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 15:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhFXNv3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 09:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhFXNv3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jun 2021 09:51:29 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B22BC061574
        for <linux-pci@vger.kernel.org>; Thu, 24 Jun 2021 06:49:09 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id g19so3277504qvx.12
        for <linux-pci@vger.kernel.org>; Thu, 24 Jun 2021 06:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yRRpyknNOYu61oOPsy3QfFe0DlnKqFXOFR/ODDvOpRA=;
        b=UtHXwFYLTrHgPc145mL3C9UB4ey+/nLdjIs7pvzujRNmQ5EAW+afyVO5yMkpxhaiYq
         EaZ0co1eAfBn5+AQMs9Q4Do4a1gFTjywNfS2sa9OFA0yAfKs040r9gAZmmies4dijQrQ
         9P1VJDPAdAgvB5owtJUn6dZ/rn754Mfv82gBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRRpyknNOYu61oOPsy3QfFe0DlnKqFXOFR/ODDvOpRA=;
        b=eC/EpTVmdThyrKQHS6QmzxLVQEHCAUJczMIlhjMqkQRDgjEbij3i8lZw6enueRGrA2
         v1AY/E8si7VZUSRgy+lY9JSeZ6eobw1M8L4nHv0tIaBB9boQwPLw+ql/by4ZNxjLQPoq
         8wPJFTOTlbGQmZCJR4PgxQe24mBG3lqwp4UUwKOfPTicCuKMQRufjpRZ4T0a6AlpMue6
         5EoL3l3wL0DWEt+SasK70ZeNMoq3YrYtEfUN7/QkWlpD+zvkgc6Dxfb1VDEEFzWJJNJr
         Vo9iA07QZiS0WZ+M+MunsiJI/oLCvtTvb+b4bj2JeIIeYb67MLieihjrhnrsvfYp0huw
         dGbg==
X-Gm-Message-State: AOAM531n7n+x64GmeosgGXIGAHBkmNr4fkAiPoAifeyHCnHMpnxPIGBs
        ii4G9ZqCwsKBR+K8OYMnmp+tp4Fcd4G+4A==
X-Google-Smtp-Source: ABdhPJzgs2S0WW/jyPZbwd+iX0C9t1VD2BlqFU8mxrpQeZeN4vD0G6Twm++k1iBm78x4oEn48xOBMA==
X-Received: by 2002:a0c:c3d1:: with SMTP id p17mr5214032qvi.44.1624542548588;
        Thu, 24 Jun 2021 06:49:08 -0700 (PDT)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id t62sm2539658qkc.26.2021.06.24.06.49.08
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 06:49:08 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id bl4so14585201qkb.8
        for <linux-pci@vger.kernel.org>; Thu, 24 Jun 2021 06:49:08 -0700 (PDT)
X-Received: by 2002:a25:6088:: with SMTP id u130mr5223275ybb.257.1624542133615;
 Thu, 24 Jun 2021 06:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.2.Icfe7cbb2cc86a38dde0ee5ba240e0580a0ec9596@changeid> <YNSKdhMACa9LFuVN@kroah.com>
In-Reply-To: <YNSKdhMACa9LFuVN@kroah.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 24 Jun 2021 06:42:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X1XSFRLfHOtA7Nk1NDqdBWHTOtPhdXVXk-+e_y9a=Rkg@mail.gmail.com>
Message-ID: <CAD=FV=X1XSFRLfHOtA7Nk1NDqdBWHTOtPhdXVXk-+e_y9a=Rkg@mail.gmail.com>
Subject: Re: [PATCH 2/6] drivers: base: Add bits to struct device to control
 iommu strictness
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pci@vger.kernel.org, quic_c_gdjako@quicinc.com,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Rajat Jain <rajatja@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, Jun 24, 2021 at 6:37 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 21, 2021 at 04:52:44PM -0700, Douglas Anderson wrote:
> > How to control the "strictness" of an IOMMU is a bit of a mess right
> > now. As far as I can tell, right now:
> > * You can set the default to "non-strict" and some devices (right now,
> >   only PCI devices) can request to run in "strict" mode.
> > * You can set the default to "strict" and no devices in the system are
> >   allowed to run as "non-strict".
> >
> > I believe this needs to be improved a bit. Specifically:
> > * We should be able to default to "strict" mode but let devices that
> >   claim to be fairly low risk request that they be run in "non-strict"
> >   mode.
> > * We should allow devices outside of PCIe to request "strict" mode if
> >   the system default is "non-strict".
> >
> > I believe the correct way to do this is two bits in "struct
> > device". One allows a device to force things to "strict" mode and the
> > other allows a device to _request_ "non-strict" mode. The asymmetry
> > here is on purpose. Generally if anything in the system makes a
> > request for strictness of something then we want it strict. Thus
> > drivers can only request (but not force) non-strictness.
> >
> > It's expected that the strictness fields can be filled in by the bus
> > code like in the patch ("PCI: Indicate that we want to force strict
> > DMA for untrusted devices") or by using the new pre_probe concept
> > introduced in the patch ("drivers: base: Add the concept of
> > "pre_probe" to drivers").
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  include/linux/device.h | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index f1a00040fa53..c1b985e10c47 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -449,6 +449,15 @@ struct dev_links_info {
> >   *           and optionall (if the coherent mask is large enough) also
> >   *           for dma allocations.  This flag is managed by the dma ops
> >   *           instance from ->dma_supported.
> > + * @force_strict_iommu: If set to %true then we should force this device to
> > + *                   iommu.strict regardless of the other defaults in the
> > + *                   system. Only has an effect if an IOMMU is in place.
>
> Why would you ever NOT want to do this?
>
> > + * @request_non_strict_iommu: If set to %true and there are no other known
> > + *                         reasons to make the iommu.strict for this device,
> > + *                         then default to non-strict mode. This implies
> > + *                         some belief that the DMA master for this device
> > + *                         won't abuse the DMA path to compromise the kernel.
> > + *                         Only has an effect if an IOMMU is in place.
>
> This feels in contrast to the previous field you just added, how do they
> both interact?  Would an enum work better?

Right that it never makes sense to set both bits so an enum could work
better, essentially it would be { dont_care, request_non_strict,
force_strict }.

In any case the whole idea of doing this at the device level looks
like it's not the right way to go anyway, so this patch and the
previous pre_probe one are essentially abandoned and I need to send
out a v2 with some different approaches.

-Doug
