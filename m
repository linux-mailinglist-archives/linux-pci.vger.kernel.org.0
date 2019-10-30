Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAAD3EA7CB
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2019 00:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfJ3Xb6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Oct 2019 19:31:58 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41768 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfJ3Xb6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Oct 2019 19:31:58 -0400
Received: by mail-oi1-f193.google.com with SMTP id g81so3564757oib.8;
        Wed, 30 Oct 2019 16:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rXx2GYmLM7U7zBzNY7wC7H96LX/I00Fb3y4/X6I00lM=;
        b=hKByCjWvdYjFKbdtog7rWeR0HGGmf0Jr5yyzP5X7S1WtPL4m6Pgpvn5zydRkSDSm3U
         R/jqEnwseYIFN/rYz1GVnD4ruIpSvJLyt+sHGu3B1t7NKD41Kq3PgmiHWRgE8LEP5pqQ
         MixcmOd0ENTgjyL5IyOAZVAtup+t5AjR8Kl0apEApwx5WUAJ+YidobrTQNVC/szvOw4b
         wkpcEnq/1soPacFxuRwPsz+pUKMwHqp58eDswRRJQmzn4W6dd9eCM0ZJR4mGs583IABE
         JnRNF0Ub16APJTj+Eg9sLoDlF9RaMER+yFfXIA+/yu9DiP5LU5enms8YxICIWZr+cYU5
         0BJQ==
X-Gm-Message-State: APjAAAXUpfXOfmcKP/bWNyeRmImEHj8WqXua9zel/dOKmh5Cg5C5/SKa
        Xs/PMqJcR21GkvS3FP0Nwc8FhGQl8QID/x4Bwio=
X-Google-Smtp-Source: APXvYqw845lK8btbYbzWMJIQX20f12jmmkksgbHhAetNT1BSGuSrcZ+htSZfoomUuVAybDhFr7bRJXfzXcMuAzOrof4=
X-Received: by 2002:aca:bdc2:: with SMTP id n185mr1535587oif.103.1572478315453;
 Wed, 30 Oct 2019 16:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <c1aadeea-7904-1455-5393-c4998fbd8037@linux.intel.com> <20191030221436.GA261632@google.com>
In-Reply-To: <20191030221436.GA261632@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 31 Oct 2019 00:31:44 +0100
Message-ID: <CAJZ5v0jiSKza2rM9=4=qw5UEEp6rpBkJwPHePSzikQhJF7TpLw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] pci: intel: Add sysfs attributes to configure pcie link
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dilip Kota <eswara.kota@linux.intel.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        gustavo.pimentel@synopsys.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        martin.blumenstingl@googlemail.com,
        Linux PCI <linux-pci@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 30, 2019 at 11:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Heiner, Rajat]
>
> On Tue, Oct 29, 2019 at 05:31:18PM +0800, Dilip Kota wrote:
> > On 10/22/2019 8:59 PM, Bjorn Helgaas wrote:
> > > [+cc Rafael, linux-pm, beginning of discussion at
> > > https://lore.kernel.org/r/d8574605f8e70f41ce1e88ccfb56b63c8f85e4df.1571638827.git.eswara.kota@linux.intel.com]
> > >
> > > On Tue, Oct 22, 2019 at 05:27:38PM +0800, Dilip Kota wrote:
> > > > On 10/22/2019 1:18 AM, Bjorn Helgaas wrote:
> > > > > On Mon, Oct 21, 2019 at 02:38:50PM +0100, Andrew Murray wrote:
> > > > > > On Mon, Oct 21, 2019 at 02:39:20PM +0800, Dilip Kota wrote:
> > > > > > > PCIe RC driver on Intel Gateway SoCs have a requirement
> > > > > > > of changing link width and speed on the fly.
> > > > > Please add more details about why this is needed.  Since you're adding
> > > > > sysfs files, it sounds like it's not actually the *driver* that needs
> > > > > this; it's something in userspace?
> > > > We have use cases to change the link speed and width on the fly.
> > > > One is EMI check and other is power saving.  Some battery backed
> > > > applications have to switch PCIe link from higher GEN to GEN1 and
> > > > width to x1. During the cases like external power supply got
> > > > disconnected or broken. Once external power supply is connected then
> > > > switch PCIe link to higher GEN and width.
> > > That sounds plausible, but of course nothing there is specific to the
> > > Intel Gateway, so we should implement this generically so it would
> > > work on all hardware.
> > Agree.
> > >
> > > I'm not sure what the interface should look like -- should it be a
> > > low-level interface as you propose where userspace would have to
> > > identify each link of interest, or is there some system-wide
> > > power/performance knob that could tune all links?  Cc'd Rafael and
> > > linux-pm in case they have ideas.
> >
> > To my knowledge sysfs is the appropriate way to go.
> > If there are any other best possible knobs, will be helpful.
>
> I agree sysfs is the right place for it; my question was whether we
> should have files like:
>
>   /sys/.../0000:00:1f.3/pcie_speed
>   /sys/.../0000:00:1f.3/pcie_width
>
> as I think this patch would add (BTW, please include sample paths like
> the above in the commit log), or whether there should be a more global
> thing that would affect all the links in the system.
>
> I think the low-level files like you propose would be better because
> one might want to tune link performance differently for different
> types of devices and workloads.
>
> We also have to decide if these files should be associated with the
> device at the upstream or downstream end of the link.  For ASPM, the
> current proposal [1] has the files at the downstream end on the theory
> that the GPU, NIC, NVMe device, etc is the user-recognizable one.
> Also, neither ASPM nor link speed/width make any sense unless there
> *is* a device at the downstream end, so putting them there
> automatically makes them visible only when they're useful.
>
> Rafael had some concerns about the proposed ASPM interface [2], but I
> don't know what they are yet.

I was talking about the existing ASPM interface in sysfs.  The new one
I still have to review, but I'm kind of wondering what about people
who used the old one?  Would it be supported going forward?

> For ASPM we added a "link_pm" directory, and maybe that's too
> specific.  Maybe it should be a generic "link_mgt" or even "pcie"
> directory that could contain both the ASPM and width/speed files.
>
> There's also a change coming to put AER stats in something like this:
>
>   /sys/.../0000:00:1f.3/aer_stats/correctable_rx_err
>   /sys/.../0000:00:1f.3/aer_stats/correctable_timeout
>   /sys/.../0000:00:1f.3/aer_stats/fatal_TLP
>   ...
>
> It would certainly be good to have some organizational scheme or we'll
> end up with a real hodge-podge.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/aspm&id=ad46fe1c733656611788e2cd59793e891ed7ded7
> [2] https://lore.kernel.org/r/CAJZ5v0jdxR4roEUC_Hs3puCzGY4ThdLsi_XcxfBUUxqruP4z7A@mail.gmail.com
