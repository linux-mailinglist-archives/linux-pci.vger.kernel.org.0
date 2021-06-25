Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D123B460B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 16:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhFYOt6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 10:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFYOt5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jun 2021 10:49:57 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9828FC061574
        for <linux-pci@vger.kernel.org>; Fri, 25 Jun 2021 07:47:36 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r7so7623487qta.12
        for <linux-pci@vger.kernel.org>; Fri, 25 Jun 2021 07:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j8m5Di25YEHezMhSM0CIBaRcSl+2cupixwUQS08gJpo=;
        b=M6vw5n1mivkEmZrZaE7zieAlKLsTCL3sm9eT56bSI/8K31Go3QolQ35P0EOIUStr1i
         Ps9F1aHzu148M6CnpnCl479CYign0nk21Ld54dTETQxPeTlpC0v+vVMC1vqhwLBpIR1T
         3JmEdCj0y7cmRGSI/pvihxB5MGkxE/h5jVHys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j8m5Di25YEHezMhSM0CIBaRcSl+2cupixwUQS08gJpo=;
        b=hOcoeZ+TcBfI+lK32HLEo+G6iyYLF1IM24qUJzdjIHUNyl7GdzkMptsoYQ+rxakzVB
         Yok0VG+dDpAduq2bzB3zMXNNMUBMU8F8hrnc/8aS8UT2m1lGLJ41m8BLS1YqaR1MDDl6
         fxbjiif3Ord4/T3UZA8qTNNls3Bu/dEEfAiWCJjiJRzXM4fjfaa4EZIUCU8zw6RKEAB9
         6HN1CdM6ZeS2YpF8KYj3kS7K72kU4O4SL2+lIyXAW9cMBt4j6RwS3c4aopbAGYHisrMQ
         SEsNmf8/LKP0uQuSNmpRmKICwnd8XTYyOE57VWdRyI/FMWihW9z5Junzud/u+rkRcYEt
         AqQA==
X-Gm-Message-State: AOAM530JvPNhgKBOmRMWDaIdm74zq6pCJmr/Es2T/Mrvs62KJQAul1gX
        teyv79ZV6jWsxgT2LlkGCAzCT22sFWp0Rw==
X-Google-Smtp-Source: ABdhPJyAEKIyy1N41jI6ugwe3yRhuawsuf/qaJ2S7B7jFd/ckOwpqKEIRM55rtZKBYBPlgk2x4G2CA==
X-Received: by 2002:ac8:75d5:: with SMTP id z21mr1404303qtq.7.1624632455275;
        Fri, 25 Jun 2021 07:47:35 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id b2sm245720qte.18.2021.06.25.07.47.35
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 07:47:35 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id m9so4982650ybo.5
        for <linux-pci@vger.kernel.org>; Fri, 25 Jun 2021 07:47:35 -0700 (PDT)
X-Received: by 2002:a25:ad60:: with SMTP id l32mr10591974ybe.276.1624632147433;
 Fri, 25 Jun 2021 07:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210624171759.4125094-1-dianders@chromium.org> <YNXXwvuErVnlHt+s@8bytes.org>
In-Reply-To: <YNXXwvuErVnlHt+s@8bytes.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 25 Jun 2021 07:42:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UFxZH7g8gH5+M=Fv4Y-e1bsLkNkPGJhNwhvVychcGQcQ@mail.gmail.com>
Message-ID: <CAD=FV=UFxZH7g8gH5+M=Fv4Y-e1bsLkNkPGJhNwhvVychcGQcQ@mail.gmail.com>
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

On Fri, Jun 25, 2021 at 6:19 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> Hi Douglas,
>
> On Thu, Jun 24, 2021 at 10:17:56AM -0700, Douglas Anderson wrote:
> > The goal of this patch series is to get better SD/MMC performance on
> > Qualcomm eMMC controllers and in generally nudge us forward on the
> > path of allowing some devices to be in strict mode and others to be in
> > non-strict mode.
>
> So if I understand it right, this patch-set wants a per-device decision
> about setting dma-mode to strict vs. non-strict.
>
> I think we should get to the reason why strict mode is used by default
> first. Is the default on ARM platforms to use iommu-strict mode by
> default and if so, why?
>
> The x86 IOMMUs use non-strict mode by default (yes, it is a security
> trade-off).

It is certainly a good question. I will say that, as per usual, I'm
fumbling around trying to solve problems in subsystems I'm not an
expert at, so if something I'm saying sounds like nonsense it probably
is. Please correct me.

I guess I'd start out by thinking about what devices I think need to
be in "strict" mode. Most of my thoughts on this are in the 3rd patch
in the series. I think devices where it's important to be in strict
mode fall into "Case 1" from that patch description, copied here:

Case 1: IOMMUs prevent malicious code running on the peripheral (maybe
a malicious peripheral or maybe someone exploited a benign peripheral)
from turning into an exploit of the Linux kernel. This is particularly
important if the peripheral has loadable / updatable firmware or if
the peripheral has some type of general purpose processor and is
processing untrusted inputs. It's also important if the device is
something that can be easily plugged into the host and the device has
direct DMA access itself, like a PCIe device.


Using sc7180 as an example (searching for iommus in sc7180.dtsi), I'd
expect these peripherals to be in strict mode:

* WiFi / LTE - I'm almost certain we want this in "strict" mode. Both
have loadable / updatable firmware and both do complex processing on
untrusted inputs. Both have a history of being compromised over the
air just by being near an attacker. Note that on sc7180 these are
_not_ connected over PCI so we can't leverage any PCI mechanism for
deciding strict / non-strict.

* Video decode / encode - pretty sure we want this in strict. It's got
loadable / updatable firmware and processing complex / untrusted
inputs.

* LPASS (low power audio subsystem) - I don't know a ton and I think
we don't use this much on our designs, but I believe it meets the
definitions for needing "strict".

* The QUPs (handles UART, SPI, and i2c) - I'm not as sure here. These
are much "smarter" than you'd expect. They have loadable / updatable
firmware and certainly have a sort of general purpose processor in
them. They also might be processing untrusted inputs, but presumably
in a pretty simple way. At the moment we don't use a ton of DMA here
anyway and these are pretty low speed, so I would tend to leave them
as strict just to be on the safe side.


I'd expect these to be non-strict:

* SD/MMC - as described in this patch series.

* USB - As far as I know firmware isn't updatable and has no history
of being compromised.


Special:

* GPU - This already has a bunch of special cases, so we probably
don't need to discuss here.


As far as I can tell everything in sc7180.dtsi that has an "iommus"
property is classified above. So, unless I'm wrong and it's totally
fine to run LTE / WiFi / Video / LPASS in non-strict mode then:

* We still need some way to pick strict vs. non-strict.

* Since I've only identified two peripherals that I think should be
non-strict, having "strict" the default seems like fewer special
cases. It's also safer.


In terms of thinking about x86 / AMD where the default is non-strict,
I don't have any historical knowledge there. I guess the use of PCI
for connecting WiFi is more common (so you can use the PCI special
cases) and I'd sorta hope that WiFi is running in strict mode. For
video encode / decode, perhaps x86 / AMD are just accepting the risk
here because there was no kernel infrastructure for doing better? I'd
also expect that x86/AMD don't have something quite as crazy as the
QUPs for UART/I2C/SPI, but even if they do I wouldn't be terribly
upset if they were in non-strict mode.

...so I guess maybe the super short answer to everything above is that
I believe that at least WiFi ought to be in "strict" mode and it's not
on PCI so we need to come up with some type of per-device solution.


-Doug
