Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536563B0DFD
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 22:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhFVUEp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 16:04:45 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:40814 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbhFVUEn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jun 2021 16:04:43 -0400
Received: by mail-io1-f51.google.com with SMTP id r12so578304ioa.7;
        Tue, 22 Jun 2021 13:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cHgKFkKiVwlWA9PGboj9bFl3U4GDLSmFAWbpsPpKlY8=;
        b=lnvmXmQ6ux5nwNnr9zNqk9TSlAIC11rEgzHkTNSWBmXetuE6HPkWRUuUpE7rP3x6Yt
         bz8yBZiUbq5Ijk/uY+LvHJrrq//1SjVbDQYkI7zfEIwoZ3Pc7WALqQkU5CWugaJoWoss
         lRUrDabYB1/h7NEqBIaD27WaPoZwD+48L3+tfb3TQP2SXPoKvuRkLLa81o2exMOMuyFe
         h7gaLFH83NjQMFzlZOpjjc8nkcFHxLUg01w6fXl/IRVyrITAmBNXgymiIZ1cuzgM3mDf
         qPHp3WmCsbPUpo4TwT41RjrS4IPF5jOT2lMWKruSSqQOytLXPx45QQyGYNBW1uPdIfSJ
         7Kfw==
X-Gm-Message-State: AOAM5304WzfpdolxlexxqmMmMSO+nOCp0/90C2GIHuMjFwDfRRopW6+b
        8Kacjn5JGf+wEnDG/QLhoQ==
X-Google-Smtp-Source: ABdhPJxxdd4kzTggcCwybkWTv2zOSgkFmz0FX332alND13rIY3bkRC+6VNVOTtZUicM82zw9y/xWHg==
X-Received: by 2002:a05:6602:3155:: with SMTP id m21mr1560529ioy.145.1624392146242;
        Tue, 22 Jun 2021 13:02:26 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y13sm11816540ioa.51.2021.06.22.13.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 13:02:25 -0700 (PDT)
Received: (nullmailer pid 43641 invoked by uid 1000);
        Tue, 22 Jun 2021 20:02:19 -0000
Date:   Tue, 22 Jun 2021 14:02:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
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
        Andy Gross <agross@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] iommu: Enable devices to request non-strict DMA,
 starting with QCom SD/MMC
Message-ID: <20210622200219.GA28722@robh.at.kernel.org>
References: <20210621235248.2521620-1-dianders@chromium.org>
 <067dd86d-da7f-ac83-6ce6-b8fd5aba0b6f@arm.com>
 <CAD=FV=Vg7kqhgxZppHXwMPMc0xATZ+MqbrXx-FB0eg7pHhNE8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Vg7kqhgxZppHXwMPMc0xATZ+MqbrXx-FB0eg7pHhNE8w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 22, 2021 at 09:06:02AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jun 22, 2021 at 4:35 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > Hi Doug,
> >
> > On 2021-06-22 00:52, Douglas Anderson wrote:
> > >
> > > This patch attempts to put forward a proposal for enabling non-strict
> > > DMA on a device-by-device basis. The patch series requests non-strict
> > > DMA for the Qualcomm SDHCI controller as a first device to enable,
> > > getting a nice bump in performance with what's believed to be a very
> > > small drop in security / safety (see the patch for the full argument).
> > >
> > > As part of this patch series I am end up slightly cleaning up some of
> > > the interactions between the PCI subsystem and the IOMMU subsystem but
> > > I don't go all the way to fully remove all the tentacles. Specifically
> > > this patch series only concerns itself with a single aspect: strict
> > > vs. non-strict mode for the IOMMU. I'm hoping that this will be easier
> > > to talk about / reason about for more subsystems compared to overall
> > > deciding what it means for a device to be "external" or "untrusted".
> > >
> > > If something like this patch series ends up being landable, it will
> > > undoubtedly need coordination between many maintainers to land. I
> > > believe it's fully bisectable but later patches in the series
> > > definitely depend on earlier ones. Sorry for the long CC list. :(
> >
> > Unfortunately, this doesn't work. In normal operation, the default
> > domains should be established long before individual drivers are even
> > loaded (if they are modules), let alone anywhere near probing. The fact
> > that iommu_probe_device() sometimes gets called far too late off the
> > back of driver probe is an unfortunate artefact of the original
> > probe-deferral scheme, and causes other problems like potentially
> > malformed groups - I've been forming a plan to fix that for a while now,
> > so I for one really can't condone anything trying to rely on it.
> > Non-deterministic behaviour based on driver probe order for multi-device
> > groups is part of the existing problem, and your proposal seems equally
> > vulnerable to that too.
> 
> Doh! :( I definitely can't say I understand the iommu subsystem
> amazingly well. It was working for me, but I could believe that I was
> somehow violating a rule somewhere.
> 
> I'm having a bit of a hard time understanding where the problem is
> though. Is there any chance that you missed the part of my series
> where I introduced a "pre_probe" step? Specifically, I see this:
> 
> * really_probe() is called w/ a driver and a device.
> * -> calls dev->bus->dma_configure() w/ a "struct device *"
> * -> eventually calls iommu_probe_device() w/ the device.
> * -> calls iommu_alloc_default_domain() w/ the device
> * -> calls iommu_group_alloc_default_domain()
> * -> always allocates a new domain
> 
> ...so we always have a "struct device" when a domain is allocated if
> that domain is going to be associated with a device.
> 
> I will agree that iommu_probe_device() is called before the driver
> probe, but unless I missed something it's after the device driver is
> loaded.  ...and assuming something like patch #1 in this series looks
> OK then iommu_probe_device() will be called after "pre_probe".
> 
> So assuming I'm not missing something, I'm not actually relying the
> IOMMU getting init off the back of driver probe.
> 
> 
> > FWIW we already have a go-faster knob for people who want to tweak the
> > security/performance compromise for specific devices, namely the sysfs
> > interface for changing a group's domain type before binding the relevant
> > driver(s). Is that something you could use in your application, say from
> > an initramfs script?
> 
> We've never had an initramfs script in Chrome OS. I don't know all the
> history of why (I'm trying to check), but I'm nearly certain it was a
> conscious decision. Probably it has to do with the fact that we're not
> trying to build a generic distribution where a single boot source can
> boot a huge variety of hardware. We generally have one kernel for a
> class of devices. I believe avoiding the initramfs just keeps things
> simpler.
> 
> I think trying to revamp Chrome OS to switch to an initramfs type
> system would be a pretty big undertaking since (as I understand it)
> you can't just run a little command and then return to the normal boot
> flow. Once you switch to initramfs you're committing to finding /
> setting up the rootfs yourself and on Chrome OS I believe that means a
> whole bunch of dm-verity work.
> 
> 
> ...so probably the initramfs is a no-go for me, but I'm still crossing
> my fingers that the pre_probe() might be legit if you take a second
> look at it?

Couldn't you have a driver flag that has the same effect as twiddling 
sysfs? At the being of probe, check the flag and go set the underlying 
sysfs setting in the device.

Though you may want this to be per device, not per driver. To do that 
early, I think you'd need a DT property. I wouldn't be totally opposed 
to that and I appreciate you not starting there. :)

Rob
