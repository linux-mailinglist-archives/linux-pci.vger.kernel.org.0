Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBBDBAF89
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2019 10:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404981AbfIWI2j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Sep 2019 04:28:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:52622 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392172AbfIWI2i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Sep 2019 04:28:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 01:28:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,539,1559545200"; 
   d="scan'208";a="203078174"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 23 Sep 2019 01:28:32 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 23 Sep 2019 11:28:32 +0300
Date:   Mon, 23 Sep 2019 11:28:32 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Keith Busch <keith.busch@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Prevent deadlock on disconnect
Message-ID: <20190923082832.GD2773@lahna.fi.intel.com>
References: <20190812143133.75319-1-mika.westerberg@linux.intel.com>
 <20190812143133.75319-2-mika.westerberg@linux.intel.com>
 <20190923053403.jdjw6ed3sub6iuou@wunner.de>
 <20190923081237.GB2773@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923081237.GB2773@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 23, 2019 at 11:12:42AM +0300, Mika Westerberg wrote:
> Regarding suggestion of unbinding PCI drivers without
> pci_lock_rescan_remove() hold, I haven't looked it too closely but I
> think we need to take that lock anyway because when we are unbinding a
> hotplug driver it is supposed to remove the hierarchy below touching the
> shared structures, possibly concurrently. Unfortunately there is no
> documentation what data pci_lock_rescan_remove() actually protects so
> first one needs to understand that. I think one way to clean up this is
> to use finer grained locking (with documented lock ordering) for PCI bus
> structures that can be accessed simultaneusly by different threads. But
> that is not a simple task.

Now that I looked more closely, I realized it actually is not supposed
to remove the hierarchy below so indeed it might be possible to do that
without taking pci_lock_rescan_remove().
