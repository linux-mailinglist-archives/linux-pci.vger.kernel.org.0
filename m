Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F28E41D96E
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 14:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349219AbhI3MOm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 08:14:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:38146 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348949AbhI3MOf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 08:14:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="223283950"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="223283950"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 05:12:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="618097796"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 30 Sep 2021 05:12:41 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 0/2] device property: Remove device_add_properties()
Date:   Thu, 30 Sep 2021 15:12:44 +0300
Message-Id: <20210930121246.22833-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This is the second version where I only modified the commit message of
the first patch according to comments from Bjorn.


Original cover letter:

There is one user left for the API, so converting that to use software
node API instead, and removing the function.

thanks,

Heikki Krogerus (2):
  PCI: Convert to device_create_managed_software_node()
  device property: Remove device_add_properties() API

 drivers/base/core.c      |  1 -
 drivers/base/property.c  | 48 ----------------------------------------
 drivers/pci/quirks.c     |  2 +-
 include/linux/property.h |  4 ----
 4 files changed, 1 insertion(+), 54 deletions(-)

-- 
2.33.0

