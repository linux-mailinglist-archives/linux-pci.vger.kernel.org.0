Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB7F20ECE3
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 06:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgF3EuM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 00:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbgF3EuC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jun 2020 00:50:02 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32297C03E979
        for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2020 21:50:02 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id fr7so9308233pjb.4
        for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2020 21:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4vDncP2teZqEXBfb800/aEh0NO8oHsdmcXXXRRGWulY=;
        b=qKfJwCm7AT0BlfktAUmwXkHFpGx7Oh79bjH+pxC9SFGuzzGtOsIQxWs5Yj5phY/cqR
         45gYinm4T35G4tjqFwkV9aSr7wWQxsY1P4wUDPVSLq7L144QzVPw9Je6ohlEDpSLC9nm
         Uqd6Gb5/YhRsTodxBhPYntMsn2Gfo/0bCSgfjk2MiN5Cc3Bivrb2skYwEKddwTq9qSSj
         31cbZbHQz15k9yatl1muDzJiSkFI+87X7Xa5iBSnZami9myyuYwEW/ifoFJAh5sMur4H
         zysOT+Xrvm66HaayFqV0f6nbFP2WrzQBAb4HBOufuAhGFqxcrqI+6IeKEiNqG8A/jaLj
         KggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4vDncP2teZqEXBfb800/aEh0NO8oHsdmcXXXRRGWulY=;
        b=bw6dpf79gnaNS471SXDImpw8HqQKx/pvUPIWV+BtQ2Ee3iUVuE2H/SfXbl9DHYTeOR
         V5TBveyPWh1tERGcIuRCHkeaF0+0i26ysg/oaqDtUonx4uHLWQ/r/ADU4YzD4sJSQ1Gk
         SyHKyXoshDOFhY7li+a2RM6fWg7cu6pI90JeC62ytdA5vurgXy0s+V3f1EQWW+xWv5R+
         r0i8rQYm9jDIrQdVrQk3BxsqtuU+ZDuxnhnk6FoLblfZyIN17/toASmUFveryOHXYB4Y
         6n/FNWYzNrfpXCmPXv+V00Qej726lmH/6TG2QqzSUwcvYE0HelF8u9Y0rG65+fMEoPhJ
         +ndQ==
X-Gm-Message-State: AOAM532odouNX0RWJfVKCjhU9/Mf2SdFsmr7NWdxIDdLPprONTq8S4da
        U3aZxaqQFTw/jkP4eNOr7wpz5+FmNWm8
X-Google-Smtp-Source: ABdhPJy7/9qcpqbednFkmBX9y9QX6DThdAm5Y+t91G8xTDRUtBBKWkL0VbqPTiirQl0bhQoYHnqP79Ft+Iel
X-Received: by 2002:a17:90a:304:: with SMTP id 4mr20033768pje.219.1593492601508;
 Mon, 29 Jun 2020 21:50:01 -0700 (PDT)
Date:   Mon, 29 Jun 2020 21:49:43 -0700
In-Reply-To: <20200630044943.3425049-1-rajatja@google.com>
Message-Id: <20200630044943.3425049-8-rajatja@google.com>
Mime-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 7/7] PCI: Add parameter to disable attaching external devices
From:   Rajat Jain <rajatja@google.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oohall@gmail.com, Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce a PCI parameter that disables the automatic attachment of
external devices to their drivers.

This is needed to allow an admin to control which drivers he wants to
allow on external ports. For more context, see threads at:
https://lore.kernel.org/linux-pci/20200609210400.GA1461839@bjorn-Precision-5520/
https://lore.kernel.org/linux-pci/CACK8Z6H-DZQYBMqtU5_H5TTwwn35Q7Yysm9a7Wj0twfQP8QBzA@mail.gmail.com/

drivers_autoprobe can only be disabled after userspace comes up. So
any external devices that were plugged in before boot may still bind
to drivers before userspace gets a chance to clear drivers_autoprobe.
Another problem is that even with drivers_autoprobe=0, the hot-added
PCI devices are bound to drivers because PCI explicitly calls
device_attach() asking driver core to find and attach a driver. This
patch helps with both of these problems.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: Use the newly introduced dev_is_external() from device core
    commit log elaborated

 drivers/pci/bus.c | 11 ++++++++---
 drivers/pci/pci.c |  9 +++++++++
 drivers/pci/pci.h |  1 +
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 3cef835b375fd..c11725bccffb0 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -321,9 +321,14 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_bridge_d3_update(dev);
 
 	dev->match_driver = true;
-	retval = device_attach(&dev->dev);
-	if (retval < 0 && retval != -EPROBE_DEFER)
-		pci_warn(dev, "device attach failed (%d)\n", retval);
+
+	if (pci_dont_attach_external_devs && dev_is_external(&dev->dev)) {
+		pci_info(dev, "not attaching external device\n");
+	} else {
+		retval = device_attach(&dev->dev);
+		if (retval < 0 && retval != -EPROBE_DEFER)
+			pci_warn(dev, "device attach failed (%d)\n", retval);
+	}
 
 	pci_dev_assign_added(dev, true);
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 35f25ac39167b..3ebcfa8b33178 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -128,6 +128,13 @@ static bool pcie_ats_disabled;
 /* If set, the PCI config space of each device is printed during boot. */
 bool pci_early_dump;
 
+/*
+ * If set, the devices behind external-facing bridges (as marked by firmware)
+ * shall not be attached automatically. Userspace will need to attach them
+ * manually: echo <pci device>  > /sys/bus/pci/drivers/<driver>/bind
+ */
+bool pci_dont_attach_external_devs;
+
 bool pci_ats_disabled(void)
 {
 	return pcie_ats_disabled;
@@ -6539,6 +6546,8 @@ static int __init pci_setup(char *str)
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
 			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
 				disable_acs_redir_param = str + 18;
+			} else if (!strcmp(str, "dont_attach_external_devs")) {
+				pci_dont_attach_external_devs = true;
 			} else {
 				pr_err("PCI: Unknown option `%s'\n", str);
 			}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12fb79fbe29d3..875fecb9b2612 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -13,6 +13,7 @@
 
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
+extern bool pci_dont_attach_external_devs;
 
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
 bool pcie_cap_has_rtctl(const struct pci_dev *dev);
-- 
2.27.0.212.ge8ba1cc988-goog

