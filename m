Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5C5423CCA
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 13:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbhJFL2g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 07:28:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:41644 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237936AbhJFL2f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Oct 2021 07:28:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="206091102"
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="206091102"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 04:26:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="623860168"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Oct 2021 04:26:36 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v3 0/3] device property: Remove device_add_properties()
Date:   Wed,  6 Oct 2021 14:26:40 +0300
Message-Id: <20211006112643.77684-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

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

