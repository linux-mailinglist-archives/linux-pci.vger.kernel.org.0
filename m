Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEFA3B0DB1
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 21:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhFVToP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 15:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbhFVToN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jun 2021 15:44:13 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C661EC061756
        for <linux-pci@vger.kernel.org>; Tue, 22 Jun 2021 12:35:15 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id g12so340424qtb.2
        for <linux-pci@vger.kernel.org>; Tue, 22 Jun 2021 12:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KbphWW+YCq0HiY8JKMK80s61y/VI/u5uRCvjvuYgRvo=;
        b=B0KKMBDv6mmc1lnaI4uPkAm6cPTmdb7TIXjhicSbGznIFUVv9JjjbjCqNCaOd7EpYM
         pnnEU8sbe0AVpMJXATFzGWXRlVkOSlojtJ9YUkl0HamHxDkd3CMgYIcUaibp/wBrGa39
         arNtBQL0FAKJSiCk0bIOZEIS47O+vz6l2FCAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KbphWW+YCq0HiY8JKMK80s61y/VI/u5uRCvjvuYgRvo=;
        b=jAFif77SVqq2oHqE6UBm+Nu7M7PpJxiTMcIYjJSA6MC+52dxBxlIckpej9AoA5snJC
         ieaOMK/iR/fDX9K6sF3xsYnIgqdOykySybKHoaALTGWg1tJD+t6yU0zc3e4Kq5nl2rs+
         9T0Vx1a3CmtXbv8nL12G4IRp9y8+IB+SB/cg+riyaFrVZM0AebdUAAjf14Z3Us/WiUVx
         xZNQRAiFccQ6L2h3SNTFdxM45aXBQoixYUaJS5esGkEUTAMju9VKB/QAgBLT7hVlOZHz
         V7awhqv+tFmg4hlRPIwXchn25B8ZqwF8vCf0EUZ9IytN2LDvPvli+U6fM/o1O3eMoKZb
         6lpQ==
X-Gm-Message-State: AOAM530Wa7lNVPz5zNmuNzwwHtrU8Pdgc7ha2wt3Z4HpyGKIBvodv+UN
        0Ni+T/AiDf+oebQQYQU5/OCWA/1wcRzSMQ==
X-Google-Smtp-Source: ABdhPJzk7B0TKE8iSeLUVIVdib/dwo4ZSI3WaZ82JYH3b6IT7N35K30+DglRHYaMSWDH9vOPi8+idQ==
X-Received: by 2002:a05:622a:11c3:: with SMTP id n3mr362939qtk.63.1624390514696;
        Tue, 22 Jun 2021 12:35:14 -0700 (PDT)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id o5sm13264056qkl.25.2021.06.22.12.35.12
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 12:35:13 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id bl4so6647531qkb.8
        for <linux-pci@vger.kernel.org>; Tue, 22 Jun 2021 12:35:12 -0700 (PDT)
X-Received: by 2002:a25:2405:: with SMTP id k5mr6758869ybk.405.1624390512166;
 Tue, 22 Jun 2021 12:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid> <CACK8Z6EVmnMx4X8ZF7QSm58KCMMAkgSa+S9YkH+mC5RfmeyYoA@mail.gmail.com>
In-Reply-To: <CACK8Z6EVmnMx4X8ZF7QSm58KCMMAkgSa+S9YkH+mC5RfmeyYoA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Jun 2021 12:35:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U9WqEKVgX6p1Eaf5hvpXet0e_rqKKS4YRNsDrLW5R5zg@mail.gmail.com>
Message-ID: <CAD=FV=U9WqEKVgX6p1Eaf5hvpXet0e_rqKKS4YRNsDrLW5R5zg@mail.gmail.com>
Subject: Re: [PATCH 4/6] iommu: Combine device strictness requests with the
 global default
To:     Rajat Jain <rajatja@google.com>
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
        Saravana Kannan <saravanak@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, Jun 22, 2021 at 11:45 AM Rajat Jain <rajatja@google.com> wrote:
>
> On Mon, Jun 21, 2021 at 4:53 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > In the patch ("drivers: base: Add bits to struct device to control
> > iommu strictness") we add the ability for devices to tell us about
> > their IOMMU strictness requirements. Let's now take that into account
> > in the IOMMU layer.
> >
> > A few notes here:
> > * Presumably this is always how iommu_get_dma_strict() was intended to
> >   behave. Had this not been the intention then it never would have
> >   taken a domain as a parameter.
> > * The iommu_set_dma_strict() feels awfully non-symmetric now. That
> >   function sets the _default_ strictness globally in the system
> >   whereas iommu_get_dma_strict() returns the value for a given domain
> >   (falling back to the default). Presumably, at least, the fact that
> >   iommu_set_dma_strict() doesn't take a domain makes this obvious.
> >
> > The function iommu_get_dma_strict() should now make it super obvious
> > where strictness comes from and who overides who. Though the function
> > changed a bunch to make the logic clearer, the only two new rules
> > should be:
> > * Devices can force strictness for themselves, overriding the cmdline
> >   "iommu.strict=0" or a call to iommu_set_dma_strict(false)).
> > * Devices can request non-strictness for themselves, assuming there
> >   was no cmdline "iommu.strict=1" or a call to
> >   iommu_set_dma_strict(true).
>
> Along the same lines, I believe a platform (device tree / ACPI) should
> also be able to have a say in this. I assume in your proposal, a
> platform would expose a property in device tree which the device
> driver would need to parse and then use it to set these bits in the
> "struct device"?

Nothing would prevent creating a device tree or ACPI property that
caused either "force-strict" or "request-non-strict" from being set if
everyone agrees that it's a good idea. I wouldn't reject the idea
myself, but I do worry that we'd devolve into the usual bikeshed for
exactly how this should look. I talked about this a bit in my response
to Saravana, but basically:

* If there was some generic property, would we call it "untrusted",
"external", or something else?

* How do you describe "trust" in a generic "objective" way? It's not
really boolean and trying to describe exactly how trustworthy
something should be considered is hard.

* At least for the device tree there's a general requirement that it
describes the hardware and not so much how the software should
configure the hardware. As I understand it there is _some_ leeway here
where it's OK to describe how the hardware was designed for the OS to
configure it, but it's a pretty high bar and a hard sell. In general
the device tree isn't supposed to be used to describe "policy". In
other words: if one OS might decide on one setting and another OS on
another then it doesn't really belong in the device tree.

* In general the kernel is also not really supposed to have policy
hardcoded in either, though it feels like we can get away with having
a good default/sane policy and allowing overriding the policy with
command line parameters (like iommu.strict). In the case where
something has to be configured at bootup there's not many ways to do
better.


tl;dr: I have no plans to try to make an overarching property, but my
patch series does allow subsystems to come up with and easily
implement their own rules as it makes sense. While this might seem
hodgepodge I prefer to see it as "flexible" since I'm not convinced
that we're going to be able to come up with an overarching trust
framework.

-Doug
