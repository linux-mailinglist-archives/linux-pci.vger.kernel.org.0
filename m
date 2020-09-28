Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8BB27A51A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 03:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgI1BLy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 21:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgI1BLq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Sep 2020 21:11:46 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3668C0613CE;
        Sun, 27 Sep 2020 18:11:46 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x123so7836400pfc.7;
        Sun, 27 Sep 2020 18:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Vl8gEipEWFjtKnsD5TCOnh7pXRZTpm9ErODvxhpYYr8=;
        b=oc6URP/tlotHZFjHTHAGYwIbg+2JDZkT18pW5MvMoRfRLMa+oouyj2V8x5a2DJ2ZrD
         SxYROFREbDj872/sKYteXuNqQ7Ou+3cwXqQljtVlxL8GwA572A8BYT4saK6LHNOVzx1c
         FlxLrgFd/u1cnuEU9SdtJzuabH/6iW0+jDWuW3ahXnktSbCYAsWVkyKAxA7Vvv7KHyk2
         /FMtwmUJFze1zB0GCz0PY7odp7ssuF6hpVEzj77XLcGUkhTSV8XdeKe8MdcAY0JiQS0Q
         acY4uMR/053a+jj3yQQQ0xxFTmEybdPvW9oK05RaM/awNTRsF/qeE/nELWQ18UV9jFyJ
         ubMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Vl8gEipEWFjtKnsD5TCOnh7pXRZTpm9ErODvxhpYYr8=;
        b=IcpmGG2IJHGsf2rOru8zyhiXI7wdKIoTcrnrvPadkliWy0XwjftHa8YkaN9ESBA4S2
         QUHfcnfKzIHaSsFiwU4uMTRbAd3ys4VhbFcAtb5Koxf3l0o7QzDylQifkrTVa017/qTY
         SAdYCDapu/XfVa9cD7OkMTHk5AZojKTnCllNBS8PiNK20qA4Et93Z2xGQ76pCwNePOaI
         gd71zIx7hkr6fu2GPGr+B7a61F5e6YYAOpnQFhFU+k61UQzP0yn58E9lVdBmlwy0rizP
         FaBU+w8fgMNpxmxfNWtIsnPkRB+B5jBDnNSNMvgToCGx8VplsEW3iJo8HY+O49IOvZrD
         AKCA==
X-Gm-Message-State: AOAM5337IwN8hdhgtcEjZrg4CwYTG1MZqlU/IPZxq2QA3Icxj3CkMdhy
        8/th73r9RXhsq6B4i6r+ZEHFiMLdioBw8A==
X-Google-Smtp-Source: ABdhPJxsF9Z6lUWGxKwl8mwA6yl2ksl55JaRMke1uVGP+78uJYH0uaWKYnVi1EkWdxxiaHuFGxvgxg==
X-Received: by 2002:a17:902:bc81:b029:d2:2988:4781 with SMTP id bb1-20020a170902bc81b02900d229884781mr9049034plb.50.1601255506318;
        Sun, 27 Sep 2020 18:11:46 -0700 (PDT)
Received: from skuppusw-mobl5.amr.corp.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id 137sm9368048pfb.183.2020.09.27.18.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 18:11:45 -0700 (PDT)
From:   Kuppuswamy Sathyanarayanan <sathyanarayanan.nkuppuswamy@gmail.com>
X-Google-Original-From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v9 3/5] ACPI/PCI: Ignore _OSC DPC negotiation result if pcie_ports_dpc_native is set.
Date:   Sun, 27 Sep 2020 18:11:34 -0700
Message-Id: <be30aae22a3e9604d0fc39c56245d12856b35ff0.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcie_ports_dpc_native is set only if user requests native handling
of PCIe DPC capability via pcie_port_setup command line option.
User input takes precedence over _OSC based control negotiation
result. So consider the _OSC negotiated result for DPC ownership
only if pcie_ports_dpc_native is unset.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/acpi/pci_root.c         | 8 ++++++--
 drivers/pci/pcie/dpc.c          | 3 ++-
 drivers/pci/pcie/portdrv.h      | 2 --
 drivers/pci/pcie/portdrv_core.c | 2 +-
 include/linux/pci.h             | 2 ++
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 9749b7abdd7e..979d03494476 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -935,8 +935,12 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 			    host_bridge->native_ltr);
 		  OSC_OWNER(ctrl, OSC_PCI_EXPRESS_DPC_CONTROL,
 			    host_bridge->native_dpc);
-	  }
-
+		  if (pcie_ports_dpc_native)
+			  dev_warn(&bus->dev, "OS forcibly taking over DPC\n");
+		  else
+			  OSC_OWNER(ctrl, OSC_PCI_EXPRESS_DPC_CONTROL,
+				    host_bridge->native_dpc);
+		}
 	if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
 		host_bridge->native_shpc_hotplug = 0;
 
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index daa9a4153776..5b1025a2994d 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -280,11 +280,12 @@ void pci_dpc_init(struct pci_dev *pdev)
 static int dpc_probe(struct pcie_device *dev)
 {
 	struct pci_dev *pdev = dev->port;
+	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
 	struct device *device = &dev->device;
 	int status;
 	u16 ctl, cap;
 
-	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
+	if (!pcie_aer_is_native(pdev) && !host->native_dpc)
 		return -ENOTSUPP;
 
 	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index af7cf237432a..0ac20feef24e 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -25,8 +25,6 @@
 
 #define PCIE_PORT_DEVICE_MAXSERVICES   5
 
-extern bool pcie_ports_dpc_native;
-
 #ifdef CONFIG_PCIEAER
 int pcie_aer_init(void);
 int pcie_aer_is_native(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index ccd5e0ce5605..2c0278f0fdcc 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -253,7 +253,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	 */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
 	    pci_aer_available() &&
-	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
+	    (host->native_dpc || (services & PCIE_PORT_SERVICE_AER)))
 		services |= PCIE_PORT_SERVICE_DPC;
 
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 835530605c0d..dc03b6c65742 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1556,9 +1556,11 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
 #ifdef CONFIG_PCIEPORTBUS
 extern bool pcie_ports_disabled;
 extern bool pcie_ports_native;
+extern bool pcie_ports_dpc_native;
 #else
 #define pcie_ports_disabled	true
 #define pcie_ports_native	false
+#define pcie_ports_dpc_native	false
 #endif
 
 #define PCIE_LINK_STATE_L0S		BIT(0)
-- 
2.17.1

