Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACE9E19D7A5
	for <lists+linux-pci@lfdr.de>; Fri,  3 Apr 2020 15:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgDCNdH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Apr 2020 09:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbgDCNdH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Apr 2020 09:33:07 -0400
Received: from localhost (mobile-166-170-223-166.mycingular.net [166.170.223.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32436206B8;
        Fri,  3 Apr 2020 13:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585920786;
        bh=4+Ge8PvEmnW8cbRafpoa4DLnP6F51x6BK/hz8piFjgA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=U0xs/Qsz7Bb+JVjjkgP8LJAfHr1DAndu4Yyq6lBvOwCkhi+hCUS8XkjOWBbhRn9Qc
         P/LiCwVrnqrudu4Y1t1dQZLAMXaCKQjeZBpF5CqdMP7bbUOw76uAY//XCSoz5O/7fZ
         jOYsqvHpy+EgwRlQWxdMxJ6PkNPsLGsXfMBmif8c=
Date:   Fri, 3 Apr 2020 08:33:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Shiju Jose <shiju.jose@huawei.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        bp@alien8.de, james.morse@arm.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, zhangliguang@linux.alibaba.com,
        tglx@linutronix.de, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
        yangyicong@hisilicon.com
Subject: Re: [PATCH v5 2/2] PCI: HIP: Add handling of HiSilicon HIP PCIe
 controller errors
Message-ID: <20200403133303.GA213756@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403102313.GD2066@kadam>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 03, 2020 at 01:23:13PM +0300, Dan Carpenter wrote:
> On Wed, Mar 25, 2020 at 12:36:39PM -0500, Bjorn Helgaas wrote:
> > On Wed, Mar 25, 2020 at 01:55:18PM +0000, Shiju Jose wrote:
> > > The HiSilicon HIP PCIe controller is capable of handling errors
> > > on root port and perform port reset separately at each root port.
> > > 
> > > This patch add error handling driver for HIP PCIe controller to log
> > > and report recoverable errors. Perform root port reset and restore
> > > link status after the recovery.
> > > 
> > > Following are some of the PCIe controller's recoverable errors
> > > 1. completion transmission timeout error.
> > > 2. CRS retry counter over the threshold error.
> > > 3. ECC 2 bit errors
> > > 4. AXI bresponse/rresponse errors etc.
> > > 
> > > Also fix the following Smatch warning:
> > > warn: should '((((1))) << (9 + i))' be a 64 bit type?
> > > if (err->val_bits & BIT(HISI_PCIE_LOCAL_VALID_ERR_MISC + i))
> > >      ^^^ This should be BIT_ULL() because it goes up to 9 + 32.
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > I'm glad you did this fix, and thanks for acknowledging Dan, but I
> > don't think it's necessary to mention it in the commit log here
> > because it won't really be useful in the future.  It's only relevant
> > when comparing the unmerged versions of this series, e.g., v4 compared
> > to v3.

To elaborate on that a little, I think the commit log should describe
the change specifically made by the patch.  You should be able to
"git diff HEAD^" and match up the commit log with that diff output.
You can't do that with this Smatch paragraph.

> It's the kbuild template which suggests adding the Reported-by tags but
> you're right that it's not really appropriate for patches that haven't
> been merged yet.  I wish there were a correct tag.  I just saw yesterday
> where a maintainer insisted that someone add a Suggested-by tag and I
> don't think that's appropriate either.

Adding tags for every reviewer or bot comment seems like overkill.  I
think the "lore" links are about the right level of attribution for
this sort of thing, e.g., here:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=77d6b9094819ba55353de0ef92957f3f54f2c36c

The Link: tag there gives you the whole v2 thread including review
comments.  And Matthew's cover letter even included a link to the
original v1 posting.  That seems perfect to me.

Bjorn
