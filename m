Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0087C249D1F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 14:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgHSMBa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 08:01:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:49550 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbgHSL74 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 07:59:56 -0400
IronPort-SDR: wIxPof3BWspEKl2Cm1ww3To8qucSLttq8oVQI+DVAs2ad+tEUw8KmKd3X8P5n7wA6WDZufaOeD
 0rXPfVNl6tDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="239922678"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="239922678"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 04:59:17 -0700
IronPort-SDR: iWifSpr83vxu9j5doJ0hUGI4lOCtt6pV6KNeBswt6aumKvXT64PSjYZ5Ao9kXVI0pHR36ErZ+J
 rvebvyz7CrkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="329310787"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 19 Aug 2020 04:59:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id F31EB790; Wed, 19 Aug 2020 14:59:06 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Dana Alkattan <dana.alkattan@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 17/19] ACPI: Export acpi_get_first_physical_node() to modules
Date:   Wed, 19 Aug 2020 14:59:03 +0300
Message-Id: <20200819115905.59834-18-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
References: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This function will be needed by the Thunderbolt driver when it parses
ACPI description for linking tunneled ports to the Thunderbolt
controller device.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 54002670cb7a..53cc1e0cef21 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -551,6 +551,7 @@ struct device *acpi_get_first_physical_node(struct acpi_device *adev)
 	mutex_unlock(physical_node_lock);
 	return phys_dev;
 }
+EXPORT_SYMBOL_GPL(acpi_get_first_physical_node);
 
 static struct acpi_device *acpi_primary_dev_companion(struct acpi_device *adev,
 						      const struct device *dev)
-- 
2.28.0

