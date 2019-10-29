Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21864E85F3
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 11:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfJ2KnF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 06:43:05 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39711 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfJ2KnF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2019 06:43:05 -0400
Received: by mail-oi1-f194.google.com with SMTP id v138so8507207oif.6;
        Tue, 29 Oct 2019 03:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSjPNv90mxoa4Qm6nfEtDVRJH8OLwkZxWcgMkuqr8yo=;
        b=bGxNvv0I7soLyaU5RO3amJ8UY4P89c8UoLbIQFC8q965tXolSK1ftj4zirr/CGRlA1
         5MS6HF+1hByzBdb/Y3u99ivirCq+WerZVFPSbV7YX0YFzXVbAyGIhUbTuJvzX8vD2pJn
         Q68h8y6hLKU2TLp9tDbc++GyNOS9xbtxsjqSswA/bKYLjm1HNgPvZqHJbqD0ye1fRV45
         MWViArvUau9meYlU+AUAWlbHQeVT8xLGvE3D7FuMLDXpCmIpotcta3l0Vm3u0ZWi00k3
         ihq3gc0uys5yl+gckypOnvF26QKTuqL6rnYWqroJNNKkBL88jXtqwa25nexyecyGuq3W
         Kgbg==
X-Gm-Message-State: APjAAAVBV/xCMJ738VF2TNJ75iauPibhbPUHLJ5/0zqI4VezmGHJJoMt
        fsSiMfmsiZ1wR/rvhLbcw674JhKZdtAdC1f9DDg=
X-Google-Smtp-Source: APXvYqzEI7Zev2Tj6Q3I2HWITMkXefnJLlyQjGXMoQC961y0B0n88iefi/CLfKVtZiYMOV/Mt2ZrHOzKRLY7NZFaPAw=
X-Received: by 2002:aca:d4c6:: with SMTP id l189mr3312579oig.68.1572345784471;
 Tue, 29 Oct 2019 03:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <187a1a7d-80bd-a0e9-a0d9-7fc53bff8907@linux.intel.com> <20191022125950.GA133170@google.com>
In-Reply-To: <20191022125950.GA133170@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Oct 2019 11:42:53 +0100
Message-ID: <CAJZ5v0jdxR4roEUC_Hs3puCzGY4ThdLsi_XcxfBUUxqruP4z7A@mail.gmail.com>
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
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 22, 2019 at 2:59 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rafael, linux-pm, beginning of discussion at
> https://lore.kernel.org/r/d8574605f8e70f41ce1e88ccfb56b63c8f85e4df.1571638827.git.eswara.kota@linux.intel.com]
>
> On Tue, Oct 22, 2019 at 05:27:38PM +0800, Dilip Kota wrote:
> > On 10/22/2019 1:18 AM, Bjorn Helgaas wrote:
> > > On Mon, Oct 21, 2019 at 02:38:50PM +0100, Andrew Murray wrote:
> > > > On Mon, Oct 21, 2019 at 02:39:20PM +0800, Dilip Kota wrote:
> > > > > PCIe RC driver on Intel Gateway SoCs have a requirement
> > > > > of changing link width and speed on the fly.
> > > Please add more details about why this is needed.  Since you're adding
> > > sysfs files, it sounds like it's not actually the *driver* that needs
> > > this; it's something in userspace?
>
> > We have use cases to change the link speed and width on the fly.
> > One is EMI check and other is power saving.  Some battery backed
> > applications have to switch PCIe link from higher GEN to GEN1 and
> > width to x1. During the cases like external power supply got
> > disconnected or broken. Once external power supply is connected then
> > switch PCIe link to higher GEN and width.
>
> That sounds plausible, but of course nothing there is specific to the
> Intel Gateway, so we should implement this generically so it would
> work on all hardware.
>
> I'm not sure what the interface should look like -- should it be a
> low-level interface as you propose where userspace would have to
> identify each link of interest, or is there some system-wide
> power/performance knob that could tune all links?  Cc'd Rafael and
> linux-pm in case they have ideas.

Frankly, I need some time to think about this and, in case you are
wondering about whether or not it has been discussed with me already,
it hasn't.

At this point I can only say that since we have an ASPM interface,
which IMO is not fantastic, it may be good to come up with a common
link management interface.

Cheers!
