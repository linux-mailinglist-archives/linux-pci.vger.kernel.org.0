Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14EA4FF45
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2019 20:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfD3SFH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Apr 2019 14:05:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:49225 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbfD3SFH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Apr 2019 14:05:07 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 11:05:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,414,1549958400"; 
   d="scan'208";a="138785887"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga008.jf.intel.com with ESMTP; 30 Apr 2019 11:05:05 -0700
Date:   Tue, 30 Apr 2019 11:59:17 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Sinan Kaya <Okaya@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        mr.nuke.me@gmail.com, linux-pci@vger.kernel.org,
        austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add link_change error handler and vfio-pci user
Message-ID: <20190430175917.GA25654@localhost.localdomain>
References: <155605909349.3575.13433421148215616375.stgit@gimli.home>
 <20190424175758.GC244134@google.com>
 <20190429085104.728aee75@x1.home>
 <76169da9-36cd-6754-41e7-47c8ef668648@kernel.org>
 <20190429105926.209d17d3@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429105926.209d17d3@x1.home>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 29, 2019 at 10:59:26AM -0600, Alex Williamson wrote:
> On Mon, 29 Apr 2019 09:45:28 -0700
> Sinan Kaya <Okaya@kernel.org> wrote:
> 
> > On 4/29/2019 10:51 AM, Alex Williamson wrote:
> > > So where do we go from here?  I agree that dmesg is not necessarily a
> > > great choice for these sorts of events and if they went somewhere else,
> > > maybe I wouldn't have the same concerns about them generating user
> > > confusion or contributing to DoS vectors from userspace drivers.  As it
> > > is though, we have known cases where benign events generate confusing
> > > logging messages, which seems like a regression.  Drivers didn't ask
> > > for a link_change handler, but nor did they ask that the link state to
> > > their device be monitored so closely.  Maybe this not only needs some
> > > sort of change to the logging mechanism, but also an opt-in by the
> > > driver if they don't expect runtime link changes.  Thanks,  
> > 
> > Is there anyway to detect autonomous hardware management support and
> > not report link state changes in that situation?
> > 
> > I thought there were some capability bits for these.
> 
> Not that we can find, this doesn't trigger the separate autonomous
> bandwidth notification interrupt.  Thanks,

I think the only control is to disable automomous lane and link rate
changes. When set, any changes to either should only be in response to
errors, so enabling those controls might be the right thing to do with
this feature.
