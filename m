Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5A23AF834
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 00:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFUWFF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 18:05:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230047AbhFUWFF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jun 2021 18:05:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 102D0611C1;
        Mon, 21 Jun 2021 22:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624312970;
        bh=N2Cxf3KNPe7fSYhVuWyCxsiFVba986fqvfTgr5xifMQ=;
        h=Date:From:To:Cc:Subject:From;
        b=auS5jJqwJrsoh+Ns1v2qjjbteorRwKTJVYE6cW50fq3Z8c/dwvn6c0Z5DIUd9489+
         qotwpICsuTyeSb30NHuJ/+TM0Y9biXIdUBcwxgl2OYHDu7UXzuot8Y6mRA4CUo93Vf
         MF0lbGj3itAyAg0zESkGyW/rSMjYyHdBb+RNVhOi74hGRTen/QBa1Df33PxcMPsfsV
         vSH5dNZnTBGoHEMJRa9Xkh2/PeNtxjN57Mb8Vo+kLIYEvo0NEwX0HtBwBscwzlYmKq
         5TDQjb9EkAs8EvFAuOkLxzfvyYafzqVQrw8bWdqBAz52RSP1vmZf9mxakMTIA2Dawm
         cgoGrlIoYdyCQ==
Date:   Mon, 21 Jun 2021 17:02:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Michael <phyre@rogers.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [bugzilla-daemon@bugzilla.kernel.org: [Bug 213481] e1000e hardware
 failure due to PCI patch in all kernels 5.10.36+ with Intel I219-V]
Message-ID: <20210621220249.GA3306177@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

FYI.  Looks like 4514d991d992 ("PCI: PM: Do not read power state in
pci_enable_device_flags()") appeared in v5.13-rc1, so it would be nice
to fix before v5.13.

https://bugzilla.kernel.org/show_bug.cgi?id=213481

Initial report:

  On the 4.19 kernel, this works perfect.  It also works perfectly in
  Windows.  If I reboot into 4.19, there is no problem with networking,
  however in 5.10, there is ZERO network connectivity.  The link NEVER
  comes up.  You can't assign an IP address to the interface.


From comment #2:

  If I revert commit 4514d991d99211f225d83b7e640285f29f0755d0 (
  https://github.com/torvalds/linux/commit/4514d991d99211f225d83b7e640285f29f0755d0)
  from the 5.10.36 kernel, I do NOT have this hardware failure
  message.  This commit relates to PCI power state.

  It would appear something about this change that the e1000e driver
  is not handling properly on this system, causing the card to not
  work.

  As mentioned this is in current kernel versions (5.13, 5.11, and
  5.10.36+).  Given that this is a regression, a breaking change for
  the usability of these cards, and we know exactly what causes it for
  a hopefully easy fix, I've upped the severity.
