Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAAF45041E
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 13:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhKOMNA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 07:13:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:14027 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229613AbhKOMM4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Nov 2021 07:12:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="233266306"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="233266306"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 04:10:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="644818570"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Nov 2021 04:09:58 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v4 0/3] device property: Remove device_add_properties()
Date:   Mon, 15 Nov 2021 15:09:58 +0300
Message-Id: <20211115121001.77041-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

One more version. Hopefully the commit messages are now OK. No other
changes since v3:

https://lore.kernel.org/lkml/20211006112643.77684-1-heikki.krogerus@linux.intel.com/


v3 cover letter:

In this third version of this series, the second patch is now split in
two. The device_remove_properties() call is first removed from
device_del() in its own patch, and the
device_add/remove_properties() API is removed separately in the last
patch. I hope the commit messages are clear enough this time.


v2 cover letter:

This is the second version where I only modified the commit message of
the first patch according to comments from Bjorn.


Original cover letter:

There is one user left for the API, so converting that to use software
node API instead, and removing the function.


thanks,

Heikki Krogerus (3):
  PCI: Convert to device_create_managed_software_node()
  driver core: Don't call device_remove_properties() from device_del()
  device property: Remove device_add_properties() API

 drivers/base/core.c      |  1 -
 drivers/base/property.c  | 48 ----------------------------------------
 drivers/pci/quirks.c     |  2 +-
 include/linux/property.h |  4 ----
 4 files changed, 1 insertion(+), 54 deletions(-)

-- 
2.33.0

