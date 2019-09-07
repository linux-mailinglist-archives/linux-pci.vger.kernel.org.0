Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AABFBAC3FD
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2019 03:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406441AbfIGBwT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Sep 2019 21:52:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:31367 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406415AbfIGBwT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Sep 2019 21:52:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 18:52:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,474,1559545200"; 
   d="scan'208";a="213345264"
Received: from dph9ls1.fm.intel.com (HELO dph9ls1) ([10.80.209.174])
  by fmsmga002.fm.intel.com with ESMTP; 06 Sep 2019 18:52:18 -0700
Date:   Fri, 6 Sep 2019 18:48:40 -0700
From:   Ivan Gorinov <ivan.gorinov@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>,
        Dilip Kota <eswara.kota@linux.intel.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
Message-ID: <20190907014840.GA45371@dph9ls1>
References: <cover.1567585181.git.eswara.kota@linux.intel.com>
 <fe9549470bc06ea0d0dfc80f46a579baa49b911a.1567585181.git.eswara.kota@linux.intel.com>
 <CAFBinCC5SH5OSUqOkLQhE2o7g5OhSuB_PBjsv93U2P=FNS5oPw@mail.gmail.com>
 <ce4e04ee-9a8f-fbe1-0133-4a18c92dc136@linux.intel.com>
 <CAFBinCABoe89Z9CiG=3Bz6+JoRCYcpxWJ6jzEqMo16SCCoXPmQ@mail.gmail.com>
 <20190906174815.GZ2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906174815.GZ2680@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 06, 2019 at 08:48:15PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 06, 2019 at 07:17:11PM +0200, Martin Blumenstingl wrote:
> > On Fri, Sep 6, 2019 at 5:22 AM Chuan Hua, Lei
> > <chuanhua.lei@linux.intel.com> wrote:
> 
> > >      type_index = fwspec->param[1]; // index.
> > >      if (type_index >= ARRAY_SIZE(of_ioapic_type))
> > >          return -EINVAL;
> > >
> > > I would not see this definition is user-friendly. But it is how x86
> > > handles at the moment.
> > thank you for explaining this - I had no idea x86 is different from
> > all other platforms I know
> > the only upstream x86 .dts I could find
> > (arch/x86/platform/ce4100/falconfalls.dts) also uses the magic x86
> > numbers
> > so I'm fine with this until someone else knows a better solution
> 
> Ivan, Cc'ed, had done few amendments to x86 DT support. Perhaps he may add
> something to the discussion.

I just fixed broken interrupt support in x86-specific DT implementation.

In CE4100, PCI devices are directly connected to I/O APIC input lines.
Conventional PCI devices other than bridges don't need to be described in
Device Tree or if they use standard PCI routing.
Mapping INTA .. INTD pins to inputs of the bridge's interrupt parent depends
on device number on the bus. In Device Tree, this mapping is described by
"interrupt-map-mask" and "interrupt-map" properties of the bridge device node.

Possible interrupt types described by Open Firmware Recomended Practice:

    0 - Rising Edge
    1 - Level triggered, active low

