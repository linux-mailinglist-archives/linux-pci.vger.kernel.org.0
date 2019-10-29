Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A273E884B
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 13:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfJ2MgL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 08:36:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbfJ2MgL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 08:36:11 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67FEF214B2;
        Tue, 29 Oct 2019 12:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572352569;
        bh=QMnsZceNxEcrN9tSFrRt4Xg3wuFc/x194NzA1aT85TE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=w7aeQo1gk4oNam6lA+XYvRDr51NU3KISOEbXw/o1Y528ZLW/pEAeRNptnu8aIvH1G
         otckF6bUBfLsqHmH199BEfwPJjrc89B5U1NQn+IyzSuB7qZbiEJYH8CXhhg3qirGZp
         oYq1n4+lXs/VPTKhwqYV1MmY8eX2gxxyUAq313o4=
Date:   Tue, 29 Oct 2019 07:36:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
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
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v4 3/3] pci: intel: Add sysfs attributes to configure
 pcie link
Message-ID: <20191029123607.GA33916@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jdxR4roEUC_Hs3puCzGY4ThdLsi_XcxfBUUxqruP4z7A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Heiner for ASPM conversation]

On Tue, Oct 29, 2019 at 11:42:53AM +0100, Rafael J. Wysocki wrote:
> On Tue, Oct 22, 2019 at 2:59 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Rafael, linux-pm, beginning of discussion at
> > https://lore.kernel.org/r/d8574605f8e70f41ce1e88ccfb56b63c8f85e4df.1571638827.git.eswara.kota@linux.intel.com]
> >
> > On Tue, Oct 22, 2019 at 05:27:38PM +0800, Dilip Kota wrote:
> > > On 10/22/2019 1:18 AM, Bjorn Helgaas wrote:
> > > > On Mon, Oct 21, 2019 at 02:38:50PM +0100, Andrew Murray wrote:
> > > > > On Mon, Oct 21, 2019 at 02:39:20PM +0800, Dilip Kota wrote:
> > > > > > PCIe RC driver on Intel Gateway SoCs have a requirement
> > > > > > of changing link width and speed on the fly.
> > > > Please add more details about why this is needed.  Since you're adding
> > > > sysfs files, it sounds like it's not actually the *driver* that needs
> > > > this; it's something in userspace?
> >
> > > We have use cases to change the link speed and width on the fly.
> > > One is EMI check and other is power saving.  Some battery backed
> > > applications have to switch PCIe link from higher GEN to GEN1 and
> > > width to x1. During the cases like external power supply got
> > > disconnected or broken. Once external power supply is connected then
> > > switch PCIe link to higher GEN and width.
> >
> > That sounds plausible, but of course nothing there is specific to the
> > Intel Gateway, so we should implement this generically so it would
> > work on all hardware.
> >
> > I'm not sure what the interface should look like -- should it be a
> > low-level interface as you propose where userspace would have to
> > identify each link of interest, or is there some system-wide
> > power/performance knob that could tune all links?  Cc'd Rafael and
> > linux-pm in case they have ideas.
> 
> Frankly, I need some time to think about this and, in case you are
> wondering about whether or not it has been discussed with me already,
> it hasn't.
> 
> At this point I can only say that since we have an ASPM interface,
> which IMO is not fantastic, it may be good to come up with a common
> link management interface.

The ASPM interface hasn't been merged yet, so if you have better
ideas, now is the time.  That one is definitely very low-level, partly
because the first use case is working around defects in a specific
device.

Some sort of unification of link management does sound like a good
idea.

Bjorn
