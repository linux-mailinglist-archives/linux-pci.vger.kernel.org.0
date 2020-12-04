Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2499A2CF316
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 18:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgLDRZl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 12:25:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbgLDRZl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Dec 2020 12:25:41 -0500
Date:   Fri, 4 Dec 2020 11:24:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607102701;
        bh=iTGJnJveZ1JPdxHDy4lgNoqXVSHErcta5MseI1687Es=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=at1vtv1jRXO7DNFHV5M3AMYymgp8qmqMYd/OeyrVj5ylPI+BQnNx2vDcu0qymlQ1I
         +GeXe3MCitxTaao8BbcZhj2knF17YNgXaCNMDGSrDnhecv6bZXf6ZXLw9JeC0tLgTt
         dtwRTsqHxdd6wSaM9DGHOCXXkoY1Z6Ss/2/5pSwKXYqEfQBLYWqDq0CPH9lFYz7ZYz
         YPE7NPgBrbIy5mElw0W+H/PA0+fV6P67klRAHBloNKWXHXtk20celWDObhAnrmEsLw
         wXfRJRoHvNbrJhzEsdRlQYOz5aIffSJkSdeDC1tjQRvKdkfC5JXwWDSA9fCDlFDGJc
         diP6xV/XFY19A==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kelley, Sean V" <sean.v.kelley@intel.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "xerces.zhao@gmail.com" <xerces.zhao@gmail.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 12/15] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Message-ID: <20201204172459.GA1694978@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FD8E577-2F6A-4829-B92F-45D5E13BF9A4@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 04, 2020 at 05:17:58PM +0000, Kelley, Sean V wrote:
> On Dec 3, 2020, at 4:01 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> > OK, so if we want a comment here, I assume it would be along the lines
> > of:
> > 
> >  If "bridge" has no subordinate bus, it's an RCEC or an RCiEP.  In
> >  either of those cases, we want to call the callback on "bridge"
> >  itself.
> 
> Correct.

OK, good.  I think the function comment now captures this.

> > So IIUC, the code would be:
> > 
> >  if (bridge->subordinate)
> >    pci_walk_bus(bridge->subordinate, cb, userdata);
> >  else
> >    cb(bridge, userdata);    /* RCEC or RCiEP */
> > 
> > Right?
> 
> Right, as before.

Updated to match this.

> > I pushed a pci/err branch
> > (https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/err)
> > with some tweaks in these areas.  Diff from your v12 posting appended
> > below.  I split the RCEC/RCiEP error recovery pieces up a little bit
> > differently than in your posting.  Let me know if you see anything
> > that should be changed.  I dropped one of Jonathan's
> > reviewed/tested-by but probably should have dropped others to avoid
> > putting words in his mouth.
> 
> Thanks very much for doing this update.  It looks good to me.

I just updated this for the "rc used before initialization" error.
Current head f74d7cf9f2bc ("PCI/AER: Add RCEC AER error injection
support").
