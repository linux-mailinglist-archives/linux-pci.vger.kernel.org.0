Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAD61C79AE
	for <lists+linux-pci@lfdr.de>; Wed,  6 May 2020 20:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgEFSwE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 14:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729882AbgEFSwD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2020 14:52:03 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A85C061A0F
        for <linux-pci@vger.kernel.org>; Wed,  6 May 2020 11:52:02 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id g10so2244728lfj.13
        for <linux-pci@vger.kernel.org>; Wed, 06 May 2020 11:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dWjrdm6K70EqT5d4LDZfTq8Zq3YXbhyNb6Xh78v3UDo=;
        b=VaOBIqKilmudPa6Zm3OJr6fMmRXupnAfVmYDpkKju1f5UOE3VMx6s5kBlrZnEJTsbo
         qWAlmaOVUKiyFufaQIxmeTmDIrEF2RTjhcAxQ/6qCGewmXOvY+aMXi69wGN7iBZu3BZ4
         USB7kTjNRJ+LKAEVZq1HkOVPfMz8t+yrWpGorcfUWFD2+byYsGI81D9VhNpBgbQ2je92
         s0Fc+EGvuAsuU4jukcAcFx3O+y5bDQBowew0nw6sMeyilXhth10dTUAFxuKJU8hHHXb+
         XJQQv/blgmmnyht3/WM3+rcL5O5cXyzpEmXjWlpF+/y+tj5GJmervl4+/dCfuxFL6gsV
         dZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWjrdm6K70EqT5d4LDZfTq8Zq3YXbhyNb6Xh78v3UDo=;
        b=Vcqi4ZrAvaVn5UF2o0uDzuHFnhKXEsCE7a/1HSOP8872zKjc3GaZig5A/4Z8+MSrFM
         8Z6OE4Ge40gYCD9g3Q2okut2pIiq3EtDEfEbCHlPNiSVc93VIKLaSa4UyDCYfydrwA+o
         NIZrYxU0dkJ3GoOI4iICZy/g4oOvnPKAhigv4CGfHWFsJp6i+jEX927/Xkq6lNGen8Eo
         GJWP32G7pPXhalujnCmN2A1G+SVf+DWfHToz8HluZnv7BJhsOiJN0PjGmbZryL7mkQjv
         Yh0khO38yy1P4CP3TzXv5jojhYUpjHYn7ivBYUz6B2S28ZkEup807g8u3uFH6YAcECDV
         EUpQ==
X-Gm-Message-State: AGi0PubVX5Ef9NsLeGu8tXcT2vKpdL3AEPx4RKiOvpSkSf9aAsn61S7Y
        0Gg0v4pzxnQTbKdMtg0NgOz3FPjWNSH9DDa/rNwDtw==
X-Google-Smtp-Source: APiQypJCqAnVzC6G9rc2zVVOfJLy/ua+dWQhpYCsWkjfnJApzBJ5QwsCNZ1DGBi6L7EsJ3MdchvCRpXfqD33tGkrCAw=
X-Received: by 2002:a19:7418:: with SMTP id v24mr6147183lfe.15.1588791120944;
 Wed, 06 May 2020 11:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com>
 <20200505123306.GC487496@lahna.fi.intel.com>
In-Reply-To: <20200505123306.GC487496@lahna.fi.intel.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 6 May 2020 11:51:24 -0700
Message-ID: <CACK8Z6EF6pbFwWDTUiCKFs0NY47fmdRVOopR-fOPagmKsUpfLQ@mail.gmail.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        "Keany, Bernie" <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 5, 2020 at 5:33 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Fri, May 01, 2020 at 04:07:10PM -0700, Rajat Jain wrote:
> > Hi,
>
> Hi,
>
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
>
> In addition this could be a Kconfig option, I think.
>
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
> What about adding "module.whitelisted" parameter in the same way than we
> have for example "module.dyndbg"? Then you can pass these in the command
> line, during module load time and also trough /sys/module/.

Sure we can do that.

However, I suspect ability to add to the whitelist after booting up
might be frowned upon. May be if we do that, we can somehow ensure
that the drivers can only be removed from the whitelist, and not
added.

Thanks,

Rajat
