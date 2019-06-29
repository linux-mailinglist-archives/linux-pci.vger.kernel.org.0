Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A57E95A9E6
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2019 11:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfF2JxI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Jun 2019 05:53:08 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61257 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfF2JxH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Jun 2019 05:53:07 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 2bca45c763b3ae74; Sat, 29 Jun 2019 11:53:04 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>,
        "Robert R. Howell" <RHowell@uwyo.edu>
Subject: [PATCH 6/6] ACPI: PM: Drop unused function and function header
Date:   Sat, 29 Jun 2019 11:52:26 +0200
Message-ID: <2601948.CB932FxA9G@kreacher>
In-Reply-To: <2318839.0szTqvJMZa@kreacher>
References: <2318839.0szTqvJMZa@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Remove a leftover function header and a static inline stub with no
users from the ACPI header file.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/acpi.h |    2 --
 1 file changed, 2 deletions(-)

Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -913,7 +913,6 @@ static inline int acpi_dev_pm_attach(str
 #endif
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)
-int acpi_dev_suspend_late(struct device *dev);
 int acpi_subsys_prepare(struct device *dev);
 void acpi_subsys_complete(struct device *dev);
 int acpi_subsys_suspend_noirq(struct device *dev);
@@ -921,7 +920,6 @@ int acpi_subsys_suspend(struct device *d
 int acpi_subsys_freeze(struct device *dev);
 int acpi_subsys_poweroff(struct device *dev);
 #else
-static inline int acpi_dev_resume_early(struct device *dev) { return 0; }
 static inline int acpi_subsys_prepare(struct device *dev) { return 0; }
 static inline void acpi_subsys_complete(struct device *dev) {}
 static inline int acpi_subsys_suspend_noirq(struct device *dev) { return 0; }




