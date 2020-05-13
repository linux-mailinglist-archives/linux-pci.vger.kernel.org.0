Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAFD1D2101
	for <lists+linux-pci@lfdr.de>; Wed, 13 May 2020 23:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgEMV07 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 May 2020 17:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728341AbgEMV06 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 May 2020 17:26:58 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACA8C061A0C
        for <linux-pci@vger.kernel.org>; Wed, 13 May 2020 14:26:57 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 188so754422lfa.10
        for <linux-pci@vger.kernel.org>; Wed, 13 May 2020 14:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/W+o7YHP3lg75QN3/B7uQ7cYG4Bys8qeWMpW35HopjI=;
        b=Ny9dClQHrmJlwSORDUon7gyF7V6mOKYxSyZzVU+es3pRb8WaB2aeQigtXonyCSRHrB
         hJHE/m+o6UBE8KDGie/VujPJBEIT1kp5yuxt9YC1zmiYSDIzMFYb1OI4o0ReA4aWC/6O
         Nq+ZFf1pFMmGRP37o1HfS8eZego0rVtdUlONVWhs7mJi2XmIdXk3UaYLzFs/yVnb6H5n
         TQJ9MYsBaTEpDgOpkFO2a0elvH9tMjHl6K7dWqI6GB19A1AooV4J841PywxpLCtAFzJ1
         Is7vs9hbZFCIS7pAcONVhE1SWQYEizxi3lNuNGo033VkGvZdlsAidxk7w6SOe0l7SWMO
         yFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/W+o7YHP3lg75QN3/B7uQ7cYG4Bys8qeWMpW35HopjI=;
        b=FRBdZGUvN76IJ62zokOXUlx46w9h+EtJ1TlRhteK7KZIZ1crxCsMutI1lSRAOMWnuL
         +Gu8QWk4E1ZwMGwSCkpZ/9PMKLFT8pL1DvUl9o7KcH5qhCz7laB/bi3A9gNp5q33pbU3
         QpSyTvmztwXNaSqddednWnzf2mdHTGeDnsgfoMyam/0X7pJGP1c4Khu37njJNZpklmv/
         RMabgCb9z2Os3mHztHGRmZDyNSC8O6apXIxhYJ9Awx32KxF1j4s5kM5HhBJAl9XQk6D6
         53aNSCh8VcPNHBbuceFkV9EaJcc+11tg8vUedULsYe8LTTGRZgGZptmet1kTf5kKxDvw
         nabw==
X-Gm-Message-State: AOAM53127QtB/fLCqkwEHge/qbtBLXG307YOgDLjqTjqyRctuNNiCMuJ
        Mp3XAEKisvAB7VJTLI9gDl5d09AqtqBxO6Z/juyqSg==
X-Google-Smtp-Source: ABdhPJyReN5AkiEmAc4JPH48eYZNHRN1WMeP6McL/zAhRSfl2MfAwt5bffwaZupYWz0gbWSTTbjz2e1gaY5/877wOIs=
X-Received: by 2002:ac2:48b2:: with SMTP id u18mr902531lfg.122.1589405215758;
 Wed, 13 May 2020 14:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com>
 <20200513151929.GA38418@bjorn-Precision-5520>
In-Reply-To: <20200513151929.GA38418@bjorn-Precision-5520>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 13 May 2020 14:26:18 -0700
Message-ID: <CACK8Z6F8ncByr92+PUHPAGudZBM4fqKiau+t=JE6P1963et3fQ@mail.gmail.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
To:     Bjorn Helgaas <helgaas@kernel.org>, ashok.raj@intel.com,
        lalithambika.krishnakumar@intel.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ashok.raj@intel.com
+lalithambika.krishnakumar@intel.com

On Wed, May 13, 2020 at 8:19 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Christian (bolt maintainer), Alex, Joerg (IOMMU folks)]
>
> On Fri, May 01, 2020 at 04:07:10PM -0700, Rajat Jain wrote:
> > Hi,
> >
> > Currently, the PCI subsystem marks the PCI devices as "untrusted", if
> > the firmware asks it to:
> >
> > 617654aae50e ("PCI / ACPI: Identify untrusted PCI devices")
> > 9cb30a71acd4 ("PCI: OF: Support "external-facing" property")
> >
> > An "untrusted" device indicates a (likely external facing) device that
> > may be malicious, and can trigger DMA attacks on the system. It may
> > also try to exploit any vulnerabilities exposed by the driver, that
> > may allow it to read/write unintended addresses in the host (e.g. if
> > DMA buffers for the device, share memory pages with other driver data
> > structures or code etc).
> >
> > High Level proposal
> > ===============
> > Currently, the "untrusted" device property is used as a hint to enable
> > IOMMU restrictions (on Intel), disable ATS (on ARM) etc. We'd like to
> > go a step further, and allow the administrator to build a list of
> > whitelisted drivers for these "untrusted" devices. This whitelist of
> > drivers are the ones that he trusts enough to have little or no
> > vulnerabilities. (He may have built this list of whitelisted drivers
> > by a combination of code analysis of drivers, or by extensive testing
> > using PCIe fuzzing etc). We propose that the administrator be allowed
> > to specify this list of whitelisted drivers to the kernel, and the PCI
> > subsystem to impose this behavior:
> >
> > 1) The "untrusted" devices can bind to only "whitelisted drivers".
> > 2) The other devices (i.e. dev->untrusted=0) can bind to any driver.
> >
> > Of course this behavior is to be imposed only if such a whitelist is
> > provided by the administrator.
> >
> > Details
> > ======
> >
> > 1) A kernel argument ("pci.impose_driver_whitelisting") to enable
> > imposing of whitelisting by PCI subsystem.
> >
> > 2) Add a flag ("whitelisted") in struct pci_driver to indicate whether
> > the driver is whitelisted.
> >
> > 3) Use the driver's "whitelisted" flag and the device's "untrusted"
> > flag, to make a decision about whether to bind or not in
> > pci_bus_match() or similar.
> >
> > 4) A mechanism to allow the administrator to specify the whitelist of
> > drivers. I think this needs more thought as there are multiple
> > options.
> >
> > a) Expose individual driver's "whitelisted" flag to userspace so a
> > boot script can whitelist that driver. There are questions that still
> > need answered though e.g. what to do about the devices that may have
> > already been enumerated and rejected by then? What to do with the
> > already bound devices, if the user changes a driver to remove it from
> > the whitelist. etc.
> >
> >       b) Provide a way to specify the whitelist via the kernel command
> > line. Accept a ("pci.whitelist") kernel parameter which is a comma
> > separated list of driver names (just like "module_blacklist"), and
> > then use it to initialize each driver's "whitelisted" flag as the
> > drivers are registered. Essentially this would mean that the whitelist
> > of devices cannot be changed after boot.
> >
> > To me (b) looks a better option but I think a future requirement would
> > be the ability to remove the drivers from the whitelist after boot
> > (adding drivers to whitelist at runtime may not be that critical IMO)
>
> We definitely have some problems in this area.
>
> - Thunderbolt has similar security issues, and "bolt"
>   (https://gitlab.freedesktop.org/bolt/bolt) provides a user interface
>   for authorizing devices.  Bolt is device-oriented (and specifically
>   for Thunderbolt), not driver-oriented, and I have no idea what
>   kernel interfaces it uses, but I wonder if there's some overlap with
>   this proposal.  It seems like both bolt and this proposal could
>   ultimately be part of the same user interface.

Thanks for pointing to it! My proposal does indeed stem from enabling
of thunderbolt in our devices, and the PCIe tunneling (and thus the
additional threat from external devices) that it brings along. I took
a brief look at its documentation and it seems (Christian can correct
me) that it identifies devices with "UUID" and then uses that to drive
all its decisions. So essentially the problem it is trying to solve is
determining whether or not to enable PCIe tunnels based on the UUID of
the device. It seems to me that it assumes that the devices are
trustworthy (i.e. for eg. they will not spoof any other whitelisted
UUID). Christian, can you please help explain if bolt is capable of
dealing with malicious devices that can spoof other devices in order
to try and do bad things to the system?

>
> - ATS allows PCIe endpoints to cache address translations so they
>   can generate DMAs with translated addresses (TLP Address Type 10b,
>   see PCIe r5.0, sec 10.2.1).  These DMAs can potentially bypass
>   the IOMMU.
>
>   AFAICT, amd_iommu always turns on ATS when possible.  It looks
>   like intel-iommu and arm-smmu-v3 turn it on except for "untrusted"
>   (external) devices.

Correct. The point here is to turn on more restrictions on "untrusted" devices.

>
>   There's nothing to prevent a malicious external device from
>   generating DMA with translated addresses even if we haven't
>   enabled ATS.
>
>   I think all three IOMMUs have mechanisms to block TLPs with
>   translated addresses, but I can't tell whether they all *use*
>   them.

Understood.

>
> - ACS is an optional capability, but if implemented at all, downstream
>   ports (including root ports) are required to implement Translation
>   Blocking.  When enabled, this blocks upstream memory requests with
>   non-default AT fields.
>
>   Linux currently never enables Translation Blocking.  Maybe the IOMMU
>   protection is sufficient, but I think we should consider enabling TB
>   by default and disabling it only when required to enable ATS.  That
>   may catch malicious TLPs closer to the source and help when there is
>   no IOMMU at all.

Understood and point taken. Note that enabling IOMMU protection (and
even disabling ATS and enabling TB) is not enough though. This isn't
to say that they shouldn't be done. Yes, they definitely need to be
done. As these can help ensure that a device can generate transactions
*only* to the memory areas (DMA buffers) that the driver has allotted
to it, [and thus all the security mitigations (IOMMU/ ACS/AT/TB) have
been configured so as to provide the device access for those areas].

What these settings can't help with, though, is a malicious device
trying to exploit certain driver vulnerabilities, that allow the
device to do bad things even while *restricting transactions within
the IOMMU allowed memory*. An attacker can do this by carefully
looking at drivers to identify and exploit driver vulnerabilities
(driver negligence). There is a lot of research work, but we for e.g.
are looking at this:
https://www.ndss-symposium.org/wp-content/uploads/2019/02/ndss2019_04A-1_Song_paper.pdf.
Here are the examples of driver vulnerabilities that it found, that
could be exploited even with the IOMMU/ACS and other restrictions in
place (please check case studies in sections F/G/H in the above paper)
since I may not be able to explain that well:

* A driver could be double fetching the memory, causing it to do
different things than intended. E.g.
* A driver could be (negligently) passing some kernel addresses to the device.
* A driver could be using (for memory dereferencing, for e.g.) the
address/indices, given by the device, without enough validation.
* A driver may negligently be sharing the DMA memory with some other
driver data in the same PAGE. Since the IOMMU restrictions are PAGE
granular, this might give device access to that driver data.

I think the points I am trying to make here are that

1) Since malicious devices can spoof other (potentially whitelisted)
devices, classifying devices into trusted and non-trusted is a good
step, but it is not enough. We do need to go one step further and
classify drivers into trusted/untrusted also, so as to (allow to)
impose more restrictions.

2) Drivers can be vulnerable / exploitable; and finding, fixing, and
introducing new exploits is a never ending cat and mouse game. But
everyone's appetite for risk is different depending on use case, and
thus administrators need a way to say, "I trust these drivers enough
that I consider them safe for my use, even on untrusted ports".

There is going to be a class of threat vectors that cannot be
addressed by IOMMU and ACS alone. And my proposal aims at those cases
specifically. It makes the case for an admin to actually look at the
various drivers and use various techniques available (PCIe fuzzing,
code analysis etc) to bless drivers. I once again suspect that I may
have failed to elaborate on the threat vectors clearly. Please let me
know if that is the case, and in that case, I'll probably ask our
security folks to chime in.

Thanks,

Rajat
