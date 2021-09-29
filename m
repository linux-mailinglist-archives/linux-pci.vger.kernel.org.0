Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4827341C5CF
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 15:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344285AbhI2NjL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 09:39:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:59006 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344245AbhI2NjK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 09:39:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="212025186"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="212025186"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 06:37:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="617514188"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Sep 2021 06:37:23 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 0/2] device property: Remove device_add_properties()
Date:   Wed, 29 Sep 2021 16:37:27 +0300
Message-Id: <20210929133729.9427-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

There is one user left for the API, so converting that to use software
node API instead, and removing the function.

thanks,

Heikki Krogerus (2):
  PCI: Use software node API with additional device properties
  device property: Remove device_add_properties() API

 drivers/base/core.c      |  1 -
 drivers/base/property.c  | 48 ----------------------------------------
 drivers/pci/quirks.c     |  2 +-
 include/linux/property.h |  4 ----
 4 files changed, 1 insertion(+), 54 deletions(-)

-- 
2.33.0

