Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1187810845
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 15:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfEANWE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 09:22:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:25692 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfEANWD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 May 2019 09:22:03 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 06:22:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,417,1549958400"; 
   d="scan'208";a="135945711"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 01 May 2019 06:22:01 -0700
Date:   Wed, 1 May 2019 07:16:15 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alex G <mr.nuke.me@gmail.com>, Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>,
        Sinan Kaya <okaya@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "PCI/LINK: Report degraded links via link
 bandwidth notification"
Message-ID: <20190501131614.GA26831@localhost.localdomain>
References: <20190429185611.121751-1-helgaas@kernel.org>
 <20190429185611.121751-2-helgaas@kernel.org>
 <d902522e-f788-5e12-6b63-18ac5d5fa955@gmail.com>
 <20190430161151.GB145057@google.com>
 <20190430180508.GB25654@localhost.localdomain>
 <20190430181813.GC25654@localhost.localdomain>
 <20190501021249.GD145057@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501021249.GD145057@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 30, 2019 at 09:12:49PM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 30, 2019 at 12:18:13PM -0600, Keith Busch wrote:
> > On Tue, Apr 30, 2019 at 12:05:09PM -0600, Keith Busch wrote:
> > > On Tue, Apr 30, 2019 at 11:11:51AM -0500, Bjorn Helgaas wrote:
> > > > > I'm not convinced a revert is the best call.
> > > > 
> > > > I have very limited options at this stage of the release, but I'd be
> > > > glad to hear suggestions.  My concern is that if we release v5.1
> > > > as-is, we'll spend a lot of energy on those false positives.
> > > 
> > > May be too late now if the revert is queued up, but I think this feature
> > > should have been a default 'false' Kconfig bool rather than always on.
> 
> Since this feature currently just adds a message in dmesg, which we
> don't really consider a stable API, I think a Kconfig switch is a
> reasonable option.
> 
> If you send me a signed-off-by for the following patch, I can apply it:

Sounds good, I'll need to resend though since I messed up the Makefile:

> +obj-$(CONFIG_PCIE_BW)		:= bw_notification.o

    s/:=/+=
