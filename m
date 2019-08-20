Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE1195BC9
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 11:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbfHTJ6Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 05:58:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:54192 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729374AbfHTJ6Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Aug 2019 05:58:25 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 02:58:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="195737781"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 20 Aug 2019 02:58:21 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 20 Aug 2019 12:58:20 +0300
Date:   Tue, 20 Aug 2019 12:58:20 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add sysfs attribute for disabling PCIe link to
 downstream component
Message-ID: <20190820095820.GD19908@lahna.fi.intel.com>
References: <20190529104942.74991-1-mika.westerberg@linux.intel.com>
 <20190703133953.GK128603@google.com>
 <20190703150341.GW2640@lahna.fi.intel.com>
 <20190801215339.GF151852@google.com>
 <20190806101230.GI2548@lahna.fi.intel.com>
 <20190819235245.GX253360@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819235245.GX253360@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 19, 2019 at 06:52:45PM -0500, Bjorn Helgaas wrote:
> > Right, it looks like we need some sort of flag there anyway.
> 
> Does this mean you're looking at getting rid of "has_secondary_link",
> you think it's impossible, or you think it's not worth trying?

I was of thinking that we need some flag anyway for the downstream port
(such as has_secondary_link) that tells us the which side of the port
the link is.

> I'm pretty sure we could get rid of it by looking upstream, but I
> haven't actually tried it.

So if we are downstream port, look at the parent and if it is also
downstream port (or root port) we change the type to upstream port
accordingly? That might work.

Another option may be to just add a quirk for these ports.

Only concern for both is that we have functions that rely on the type
such as pcie_capability_read_word() so if we change the type do we end
up breaking something? I did not check too closely, though.

I'm willing to cook a patch that fixes this once we have some consensus
what it should do ;-)
