Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0270013CFD7
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 23:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbgAOWKM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 17:10:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729203AbgAOWKL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 17:10:11 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B32A7207E0;
        Wed, 15 Jan 2020 22:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579126211;
        bh=XQSPf1waxzfWN4+hrEHJUJPfNcBgaqmPOHCovZCd68E=;
        h=Date:From:To:Cc:Subject:From;
        b=Qlwc/0Z7tLVjpVVMSv+B5lepjF5B1a2vJlA/PcvS7hfQO7fLpyck4TvdA6AAnY9Fq
         WgaCXxU8Ts2eIbO96rHNZGbGz/KBHxKEgWni83jyxnEuoiPYyz5UWT57NvOb5xEMai
         y7skUmZh1hJ7gxAU2ZhgL9wIT3g98+x8LbNmMFEs=
Date:   Wed, 15 Jan 2020 16:10:08 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Jan Vesely <jano.vesely@gmail.com>, Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>,
        Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Issues with "PCI/LINK: Report degraded links via link bandwidth
 notification"
Message-ID: <20200115221008.GA191037@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I think we have a problem with link bandwidth change notifications
(see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/bw_notification.c).

Here's a recent bug report where Jan reported "_tons_" of these
notifications on an nvme device:
https://bugzilla.kernel.org/show_bug.cgi?id=206197

There was similar discussion involving GPU drivers at
https://lore.kernel.org/r/20190429185611.121751-2-helgaas@kernel.org

The current solution is the CONFIG_PCIE_BW config option, which
disables the messages completely.  That option defaults to "off" (no
messages), but even so, I think it's a little problematic.

Users are not really in a position to figure out whether it's safe to
enable.  All they can do is experiment and see whether it works with
their current mix of devices and drivers.

I don't think it's currently useful for distros because it's a
compile-time switch, and distros cannot predict what system configs
will be used, so I don't think they can enable it.

Does anybody have proposals for making it smarter about distinguishing
real problems from intentional power management, or maybe interfaces
drivers could use to tell us when we should ignore bandwidth changes?

Bjorn
