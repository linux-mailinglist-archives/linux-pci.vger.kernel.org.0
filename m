Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094803BF09C
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jul 2021 22:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhGGUKs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jul 2021 16:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhGGUKs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jul 2021 16:10:48 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18C3C061574
        for <linux-pci@vger.kernel.org>; Wed,  7 Jul 2021 13:08:06 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id i26-20020a4ad39a0000b02902554d87361cso796979oos.13
        for <linux-pci@vger.kernel.org>; Wed, 07 Jul 2021 13:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=96jWry9WOsdwKu+G0dTVRx+JdimFiJ2QAYFEbiH3H34=;
        b=RGANX0PGc0mFZu9cqrNOVbTfGn0v+kokDFQAPwfrxJwtPODfB/7BgVckPJVrWeW3aX
         Zq/e9LoJ0785EJh+wDzA6h31JQ0sQKhf5OC8+6825AOXSTrCQRvNmjr00Qv4QYBChNR1
         yEToxoe8pidstwnQJpDD7tRYOzkEa8SGd8UWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=96jWry9WOsdwKu+G0dTVRx+JdimFiJ2QAYFEbiH3H34=;
        b=Chlw9Eoon+7Rf3ep++ZDJxQIguDBqJgt2ZMnAJBxr0ouQSCVgb+XPT40lwJfipa+Yq
         DP4r+rh/KeLiJ/YMCOcf/hvD7bbsc49AyWXo4zneLdBudt+ZhEZmw/vHv5uR7g3geN19
         aIHJs4A2WPb55WqrjeYJgZNvRl2MnyAjv4zmMocc/4PlNhS2Dkx7N6DMcr0KvAewSqAI
         vpCLrO69er7Lx19kbghHta72dx/8x4WUnDI+NBw29PS7IIBsXxSoeguLOZXT3W8uQtso
         aVOzeYUPK9FCE/HLrDk32j0qsw7Di7rk3K8uDIUz3cjGWWKDnKRtycPS/WFwCWSucDfX
         Upaw==
X-Gm-Message-State: AOAM533AL/EFsVF3Y1IqJ6NgNCxCsl+lyFWD+wVuWR2SQsBpi7CR2Prl
        eJ3VodJ313OJuVU3VOPo81ZStliDXR/zFA==
X-Google-Smtp-Source: ABdhPJwgsJNt2jaidWKNb4kG1VEMUftN+r6EQfearpNZbh+Fb5Uefs1hjBop0HvNfpFPrywji4PIhg==
X-Received: by 2002:a4a:2242:: with SMTP id z2mr19434606ooe.90.1625688486117;
        Wed, 07 Jul 2021 13:08:06 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id p5sm16840oip.35.2021.07.07.13.08.06
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 13:08:06 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so3540509otl.0
        for <linux-pci@vger.kernel.org>; Wed, 07 Jul 2021 13:08:06 -0700 (PDT)
X-Received: by 2002:a25:d97:: with SMTP id 145mr35869561ybn.276.1625688024885;
 Wed, 07 Jul 2021 13:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210624171759.4125094-1-dianders@chromium.org>
 <YNXXwvuErVnlHt+s@8bytes.org> <CAD=FV=UFxZH7g8gH5+M=Fv4Y-e1bsLkNkPGJhNwhvVychcGQcQ@mail.gmail.com>
In-Reply-To: <CAD=FV=UFxZH7g8gH5+M=Fv4Y-e1bsLkNkPGJhNwhvVychcGQcQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jul 2021 13:00:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W=HmgH3O3z+nThWL6U+X4Oh37COe-uTzVB9SanP2n86w@mail.gmail.com>
Message-ID: <CAD=FV=W=HmgH3O3z+nThWL6U+X4Oh37COe-uTzVB9SanP2n86w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] iommu: Enable non-strict DMA on QCom SD/MMC
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Rob Clark <robdclark@chromium.org>, quic_c_gdjako@quicinc.com,
        Saravana Kannan <saravanak@google.com>,
        Rajat Jain <rajatja@google.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Reddy <vdumpa@nvidia.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, Jun 25, 2021 at 7:42 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Jun 25, 2021 at 6:19 AM Joerg Roedel <joro@8bytes.org> wrote:
> >
> > Hi Douglas,
> >
> > On Thu, Jun 24, 2021 at 10:17:56AM -0700, Douglas Anderson wrote:
> > > The goal of this patch series is to get better SD/MMC performance on
> > > Qualcomm eMMC controllers and in generally nudge us forward on the
> > > path of allowing some devices to be in strict mode and others to be in
> > > non-strict mode.
> >
> > So if I understand it right, this patch-set wants a per-device decision
> > about setting dma-mode to strict vs. non-strict.
> >
> > I think we should get to the reason why strict mode is used by default
> > first. Is the default on ARM platforms to use iommu-strict mode by
> > default and if so, why?
> >
> > The x86 IOMMUs use non-strict mode by default (yes, it is a security
> > trade-off).
>
> It is certainly a good question. I will say that, as per usual, I'm
> fumbling around trying to solve problems in subsystems I'm not an
> expert at, so if something I'm saying sounds like nonsense it probably
> is. Please correct me.
>
> I guess I'd start out by thinking about what devices I think need to
> be in "strict" mode. Most of my thoughts on this are in the 3rd patch
> in the series. I think devices where it's important to be in strict
> mode fall into "Case 1" from that patch description, copied here:
>
> Case 1: IOMMUs prevent malicious code running on the peripheral (maybe
> a malicious peripheral or maybe someone exploited a benign peripheral)
> from turning into an exploit of the Linux kernel. This is particularly
> important if the peripheral has loadable / updatable firmware or if
> the peripheral has some type of general purpose processor and is
> processing untrusted inputs. It's also important if the device is
> something that can be easily plugged into the host and the device has
> direct DMA access itself, like a PCIe device.
>
>
> Using sc7180 as an example (searching for iommus in sc7180.dtsi), I'd
> expect these peripherals to be in strict mode:
>
> * WiFi / LTE - I'm almost certain we want this in "strict" mode. Both
> have loadable / updatable firmware and both do complex processing on
> untrusted inputs. Both have a history of being compromised over the
> air just by being near an attacker. Note that on sc7180 these are
> _not_ connected over PCI so we can't leverage any PCI mechanism for
> deciding strict / non-strict.
>
> * Video decode / encode - pretty sure we want this in strict. It's got
> loadable / updatable firmware and processing complex / untrusted
> inputs.
>
> * LPASS (low power audio subsystem) - I don't know a ton and I think
> we don't use this much on our designs, but I believe it meets the
> definitions for needing "strict".
>
> * The QUPs (handles UART, SPI, and i2c) - I'm not as sure here. These
> are much "smarter" than you'd expect. They have loadable / updatable
> firmware and certainly have a sort of general purpose processor in
> them. They also might be processing untrusted inputs, but presumably
> in a pretty simple way. At the moment we don't use a ton of DMA here
> anyway and these are pretty low speed, so I would tend to leave them
> as strict just to be on the safe side.
>
>
> I'd expect these to be non-strict:
>
> * SD/MMC - as described in this patch series.
>
> * USB - As far as I know firmware isn't updatable and has no history
> of being compromised.
>
>
> Special:
>
> * GPU - This already has a bunch of special cases, so we probably
> don't need to discuss here.
>
>
> As far as I can tell everything in sc7180.dtsi that has an "iommus"
> property is classified above. So, unless I'm wrong and it's totally
> fine to run LTE / WiFi / Video / LPASS in non-strict mode then:
>
> * We still need some way to pick strict vs. non-strict.
>
> * Since I've only identified two peripherals that I think should be
> non-strict, having "strict" the default seems like fewer special
> cases. It's also safer.
>
>
> In terms of thinking about x86 / AMD where the default is non-strict,
> I don't have any historical knowledge there. I guess the use of PCI
> for connecting WiFi is more common (so you can use the PCI special
> cases) and I'd sorta hope that WiFi is running in strict mode. For
> video encode / decode, perhaps x86 / AMD are just accepting the risk
> here because there was no kernel infrastructure for doing better? I'd
> also expect that x86/AMD don't have something quite as crazy as the
> QUPs for UART/I2C/SPI, but even if they do I wouldn't be terribly
> upset if they were in non-strict mode.
>
> ...so I guess maybe the super short answer to everything above is that
> I believe that at least WiFi ought to be in "strict" mode and it's not
> on PCI so we need to come up with some type of per-device solution.

I guess this thread has been silent for a bit of time now. Given that
my previous version generated a whole bunch of traffic, I guess I'm
assuming this:

a) Nothing is inherently broken with my current approach.

b) My current approach doesn't make anybody terribly upset even if
nobody is totally in love with it.

c) Nobody has any other bright ideas for ways to solve this that would
make my patch series obsolete.

I guess I'll take that as a good sign and hope that it means that this
approach has a path forward. I suppose it could just be that everyone
is busy and/or on vacation, but I've always been an optimist!

My plan continues to be to send a v3 of my patch series atop Sai's
patch [1] and John's series [2]. I'll plan to wait a bit longer before
posting my v3 to allow for more feedback/thoughts and also to see if
either Sai's patches or John's patches land and/or have newer versions
posted. :-)

-Doug

[1] https://lore.kernel.org/r/20210623134201.16140-1-saiprakash.ranjan@codeaurora.org
[2] https://lore.kernel.org/linux-doc/1624016058-189713-1-git-send-email-john.garry@huawei.com
