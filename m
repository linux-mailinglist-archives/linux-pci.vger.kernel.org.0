Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717AD3B0DD3
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 21:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhFVTxb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 15:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbhFVTxa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jun 2021 15:53:30 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1FEC06175F
        for <linux-pci@vger.kernel.org>; Tue, 22 Jun 2021 12:51:13 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id q190so39989078qkd.2
        for <linux-pci@vger.kernel.org>; Tue, 22 Jun 2021 12:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=USBo1K+DmBCyoc4we/K4NtH2MZwDh3wPfn1W7pcysQI=;
        b=UzpIm6Zjo8B35mkO06KKjZ/7tdc7aWvVpHE+DyYech/nqRwYKM+xQ6HCHr+kXTxGhz
         hZolfrm5Mxy6YRdHmzeQh1MC4XS3HTTGDVWUDQZ1Tpr3v4QG3sOrTWGUJ63edT2sqROA
         xB0EPqdmI9b3zprkXP4S7Rk5sHQt2oKxcE1OeLo9zwFhAvx+sAuOIAUKIjjo6OWZ0kL3
         7il0qhqbcejdwaBEayPaU6ZEQauEVumZFhtyUuwdlle/ZAxwTGbzck/jdSEeHYlAs8GU
         o5Lc4loRkObo2BwUEF/30n6WQLxjP6z9fn+/rW+jk+dPeslMOdyDSVI7cXFp+qTycWCj
         5QrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=USBo1K+DmBCyoc4we/K4NtH2MZwDh3wPfn1W7pcysQI=;
        b=qkn37jpSlHU8LLKkcJrAAEVCYxbQXuQbGGGTMADm3dJIKd6cFUldHk5S7Osr/y0Fzz
         JxannqS/6TwpN8NGaWY4MFGHEjgzWOMnG9Jqmec05uXJqt9nC08lyHsejvtxcaTDo1U3
         60UnYyZ54PmpDamHEajRMz3YFk+0omy/suWzA2RCYk0RjowRoPEGOmKDCML4CBSZkV2S
         eSpqzdkduFuwgO3hnbpKXtr9mZ6tz/5+7PfDJpwEmqnm6SPP4pd3IhveLwej4ifNIIk3
         2Utom4hZxF0CuWXQaC+/smQL5gL5kFXJhZjQxcv0hKM6ZsyQItlBWNAMhKMXWjjiZt/J
         d0Rg==
X-Gm-Message-State: AOAM533LG4UnEUxVtLN6OTB+YoGy8p4IWlHHdWaBDJR+K81DzIbCsAlc
        Fqx9EKtBdD5x4dAkVsvWItFwJFfvH9J2KVisoQizTA==
X-Google-Smtp-Source: ABdhPJz/t8Qc44mS/9KSpftXWjRILfA2XyIbZ1tlowZFFpQV24qFSdNw51EjR+Zq21K2UoT9etVyThjFR8NNkX5hY+Y=
X-Received: by 2002:a25:32d7:: with SMTP id y206mr6851770yby.228.1624391471949;
 Tue, 22 Jun 2021 12:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid>
 <CAGETcx-dZ_Wwjafk+5akWJwbrFx2rYNKZAU8tWhFUunEyn8sqQ@mail.gmail.com> <CAD=FV=VCgugY6veyqs09Owc72FSeuCJkNZEb93Or1Ud2jmfExw@mail.gmail.com>
In-Reply-To: <CAD=FV=VCgugY6veyqs09Owc72FSeuCJkNZEb93Or1Ud2jmfExw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 22 Jun 2021 12:50:35 -0700
Message-ID: <CAGETcx83qCZF5JN5cqXxdSFiEgfc4jYESJg-RepL2wJXJv0Eww@mail.gmail.com>
Subject: Re: [PATCH 4/6] iommu: Combine device strictness requests with the
 global default
To:     Doug Anderson <dianders@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 22, 2021 at 9:46 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Jun 21, 2021 at 7:56 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Mon, Jun 21, 2021 at 4:53 PM Douglas Anderson <dianders@chromium.org> wrote:
> > >
> > > In the patch ("drivers: base: Add bits to struct device to control
> > > iommu strictness") we add the ability for devices to tell us about
> > > their IOMMU strictness requirements. Let's now take that into account
> > > in the IOMMU layer.
> > >
> > > A few notes here:
> > > * Presumably this is always how iommu_get_dma_strict() was intended to
> > >   behave. Had this not been the intention then it never would have
> > >   taken a domain as a parameter.
> > > * The iommu_set_dma_strict() feels awfully non-symmetric now. That
> > >   function sets the _default_ strictness globally in the system
> > >   whereas iommu_get_dma_strict() returns the value for a given domain
> > >   (falling back to the default). Presumably, at least, the fact that
> > >   iommu_set_dma_strict() doesn't take a domain makes this obvious.
> > >
> > > The function iommu_get_dma_strict() should now make it super obvious
> > > where strictness comes from and who overides who. Though the function
> > > changed a bunch to make the logic clearer, the only two new rules
> > > should be:
> > > * Devices can force strictness for themselves, overriding the cmdline
> > >   "iommu.strict=0" or a call to iommu_set_dma_strict(false)).
> > > * Devices can request non-strictness for themselves, assuming there
> > >   was no cmdline "iommu.strict=1" or a call to
> > >   iommu_set_dma_strict(true).
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > >  drivers/iommu/iommu.c | 56 +++++++++++++++++++++++++++++++++----------
> > >  include/linux/iommu.h |  2 ++
> > >  2 files changed, 45 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index 808ab70d5df5..0c84a4c06110 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -28,8 +28,19 @@
> > >  static struct kset *iommu_group_kset;
> > >  static DEFINE_IDA(iommu_group_ida);
> > >
> > > +enum iommu_strictness {
> > > +       IOMMU_DEFAULT_STRICTNESS = -1,
> > > +       IOMMU_NOT_STRICT = 0,
> > > +       IOMMU_STRICT = 1,
> > > +};
> > > +static inline enum iommu_strictness bool_to_strictness(bool strictness)
> > > +{
> > > +       return (enum iommu_strictness)strictness;
> > > +}
> > > +
> > >  static unsigned int iommu_def_domain_type __read_mostly;
> > > -static bool iommu_dma_strict __read_mostly = true;
> > > +static enum iommu_strictness cmdline_dma_strict __read_mostly = IOMMU_DEFAULT_STRICTNESS;
> > > +static enum iommu_strictness driver_dma_strict __read_mostly = IOMMU_DEFAULT_STRICTNESS;
> > >  static u32 iommu_cmd_line __read_mostly;
> > >
> > >  struct iommu_group {
> > > @@ -69,7 +80,6 @@ static const char * const iommu_group_resv_type_string[] = {
> > >  };
> > >
> > >  #define IOMMU_CMD_LINE_DMA_API         BIT(0)
> > > -#define IOMMU_CMD_LINE_STRICT          BIT(1)
> > >
> > >  static int iommu_alloc_default_domain(struct iommu_group *group,
> > >                                       struct device *dev);
> > > @@ -336,25 +346,38 @@ early_param("iommu.passthrough", iommu_set_def_domain_type);
> > >
> > >  static int __init iommu_dma_setup(char *str)
> > >  {
> > > -       int ret = kstrtobool(str, &iommu_dma_strict);
> > > +       bool strict;
> > > +       int ret = kstrtobool(str, &strict);
> > >
> > >         if (!ret)
> > > -               iommu_cmd_line |= IOMMU_CMD_LINE_STRICT;
> > > +               cmdline_dma_strict = bool_to_strictness(strict);
> > >         return ret;
> > >  }
> > >  early_param("iommu.strict", iommu_dma_setup);
> > >
> > >  void iommu_set_dma_strict(bool strict)
> > >  {
> > > -       if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
> > > -               iommu_dma_strict = strict;
> > > +       /* A driver can request strictness but not the other way around */
> > > +       if (driver_dma_strict != IOMMU_STRICT)
> > > +               driver_dma_strict = bool_to_strictness(strict);
> > >  }
> > >
> > >  bool iommu_get_dma_strict(struct iommu_domain *domain)
> > >  {
> > > -       /* only allow lazy flushing for DMA domains */
> > > -       if (domain->type == IOMMU_DOMAIN_DMA)
> > > -               return iommu_dma_strict;
> > > +       /* Non-DMA domains or anyone forcing it to strict makes it strict */
> > > +       if (domain->type != IOMMU_DOMAIN_DMA ||
> > > +           cmdline_dma_strict == IOMMU_STRICT ||
> > > +           driver_dma_strict == IOMMU_STRICT ||
> > > +           domain->force_strict)
> > > +               return true;
> > > +
> > > +       /* Anyone requesting non-strict (if no forces) makes it non-strict */
> > > +       if (cmdline_dma_strict == IOMMU_NOT_STRICT ||
> > > +           driver_dma_strict == IOMMU_NOT_STRICT ||
> > > +           domain->request_non_strict)
> > > +               return false;
> > > +
> > > +       /* Nobody said anything, so it's strict by default */
> >
> > If iommu.strict is not set in the command line, upstream treats it as
> > iommu.strict=1. Meaning, no drivers can override it.
> >
> > If I understand it correctly, with your series, if iommu.strict=1 is
> > not set, drivers can override the "default strict mode" and ask for
> > non-strict mode for their domain. So if this series gets in and future
> > driver changes start asking for non-strict mode, systems that are
> > expected to operate in fully strict mode will now have devices
> > operating in non-strict mode.
> >
> > That's breaking backward compatibility for the kernel command line
> > param. It looks like what you really need is to change iommu.strict
> > from 0/1 to lazy (previously 0), strict preferred, strict enforced
> > (previously 1) and you need to default it to "enforced".
>
> I'm not quite sure I'd agree, but certainly it could be up for debate.
> I think I'm keeping full compatibility with the kernel command line
> parameter, specifically:
>
> * iommu.strict=0: default to non-strict mode unless a driver overrides
>
> * iommu.strict=1: force everything to strict no matter what
>
> ...both of those two things are the same before and after my patchset.
>
> You're arguing that I'm changing the behavior of the system when no
> command line parameter is present. To me this seems a little bit of a
> stretch. If no command line parameter is present I'd assert that the
> kernel should do some sort of sane behavior and that we don't have to
> force 100% strictness if the command line parameter isn't present at
> all.
>
> I would also note that your assertion that the system is 100% strict
> under the "no command line parameter" case isn't actually true as far
> as I can tell. The code in mainline is a little hard to follow (for me
> the code after my patch is easier to follow), but you can see that
> even before my patch a call to iommu_set_dma_strict() could be used to
> make the system non-strict if no command-line parameter was passed.

Well, the kernel doc says if you don't list iommu.strict, it defaults
to 1. So no one would have a reason to set all the command line
options to their default values. You can't fit that all into the
commandline anyway :) That's why I think this breaks backward
compatibility. But I'll let the IOMMU folks Ack/Nak based on this. I
just wanted to highlight the difference in behavior.

>
>
> > Alternately (and potentially a better option?), you really should be
> > changing/extending dev_is_untrusted() so that it applies for any
> > struct device (not just PCI device) and then have this overridden in
> > DT (or ACPI or any firmware) to indicate a specific device is safe to
> > use non-strict mode on.
>
> I was really trying _not_ to do that. I believe this has been talked
> about several times, including at last year's Linux Plumbers
> conference. As far as I can tell it always ends in a shouting match w/
> no forward progress.

I feel you :) DT changes can be painful. But in this case, it seems
like the right path. We'll see what other think. Looks like Rajat has
a similar view.

> There are a bunch of problems here, namely:
>
> * Trust isn't necessarily binary. There might be peripherals that you
> sort-of trust, others that you really trust, and others that you don't
> trust at all. For the ones you sort-of trust there may be some things
> you trust about them and other things you don't trust about them.

Right, then let's not create a boolean property. It also doesn't have
to be a "trust" property. It could simply be an "allow-lazy-tlb-flush"
property. Let's figure that out.

> * The firmware isn't necessarily the best arbitrar of trust. For
> instance, if the company that employs me (Google) compiled their own
> firmware for a given peripheral device and they were convinced that
> the peripheral firmware couldn't be compromised any more easily than
> code running in the kernel itself, they might assert that the
> peripheral device should be "trusted".

The peripheral manufacturer IS the right entity to decide if the
hardware is trustworthy or not. Saying you don't trust the DT from a
peripheral manufacturer is a whole other problem that isn't going to
be solved by one series.

> An individual Linux hacker,
> however, might not really trust the firmware blob that Google provides
> and might want the device to be "untrusted".

If the Linux hacker wants to overwrite the kernel in their device, I
expect they'd also be able to change the DT. And they always have
iommu.strict=1 if they don't trust the firmware.

> * In the PCI subsystem I believe that "trusted" vs "untrusted" is
> generally associated with whether a device is soldered down onto the
> board or in some type of slot (the "external" concept). That's been
> working OK for them, I think, but I'm not convinced it'd be easy to
> apply everywhere. One example problem: what do you do about SD cards?
> The thing doing the DMA (the SDHCI controller) is certainly "internal"
> but the cards are "external". I'm making the argument in my series
> that SDHCI should be considered at least trusted enough to use
> non-strict DMA, but it's still technically "external" and you wouldn't
> necessarily, for instance, trust the filesystem structure not to be
> crafted in a malicious way so as to exploit the kernel.

Right, I wasn't clear. I didn't say we should add a "trusted vs
untrusted" property to firmware. We can make it more granular and let
the DT/bus device. In this case, the DT could set it up and PCI can
override it if it wants to.

> > What you are trying to capture (if the device
> > safe enough) really isn't a function of the DMA device's driver, but a
> > function of the DMA device.
>
> It's a function of the DMA device, but the entity in the kernel with
> the most knowledge about this is the device's driver. The driver also
> has the best ability to make informed decisions, perhaps looking at
> the device's properties (like the "non-removable" one for SD/MMC) to
> help make decisions without us having to create a new property to
> describe trust and then argue about who sets it and when.

I'd definitely disagree on this point. The driver doesn't know
anything about the hardware unless it comes from DT. It might not be
an explicit property and you might infer stuff from the compatible
string, but that's still coming from DT. In your example, the QC
SD/MMC driver always sets the flag because it assumes the specific
device (compatible string it's matching) is always secure. So the
driver is just passing along information from DT. So I'm saying let's
make it a generic property that says if a device is secure enough to
allow lazy-tlb-flush.

Again, I'm not going to Nak/Ack the series, but this is my 2 cents.

-Saravana
