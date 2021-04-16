Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5288A3629E0
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343791AbhDPU7p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:59:45 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:43977 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343943AbhDPU7n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 16:59:43 -0400
Received: by mail-ej1-f45.google.com with SMTP id l4so43964659ejc.10
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 13:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t1bw/7s+hujLwzSHRsIAXEJYLbGFg3ol96I/CZkwRFU=;
        b=pWlvMP6XWozybLLmpATcGbozuosVb0DX9LG48a8spd2r/jNkaQBudCdCyUTgCfHHuB
         Uena1pqwUDJqL+A5AUg5R1puAXCiC58yRQUD7A27cu1Bl6E8fcN99YPRcuBLEcDzjqNR
         EdW5TrHxjp+OlxtcMi9EYIMi/lRlG0S7SqisS1lZUTF8PiTwLOKBfyMlHU2YjMXFk79X
         w+NhDrNjqlp2ERN3JSrVjgaaxnCbUp5hJ5yJ07vAzvbhQdX3UqsD7CP8f8FJ+cFNOrv5
         2CPGs25T11mBh9Qcy/wFIYj+nPVsDOgL1mIJ+8p3YR0x+IAi4LdQiij5dnRFU+DtGpUg
         5L4g==
X-Gm-Message-State: AOAM5321uSWtYe8FDTZveeGR83uXbUvrWnakFnhw5Fb8fNztl7L/NLMe
        d5faYURnq/5fbsKWqsJ8YDY=
X-Google-Smtp-Source: ABdhPJzxVDhmhGXzEtaWzdnO0cmQUalLpylWyAtN6fPPStU4g0jVDbUJOqusSQ9DG389QhD7RgPeZA==
X-Received: by 2002:a17:906:4913:: with SMTP id b19mr10220540ejq.439.1618606757810;
        Fri, 16 Apr 2021 13:59:17 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm5103864ejg.43.2021.04.16.13.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:59:17 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joe Perches <joe@perches.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        David Sterba <dsterba@suse.com>, linux-pci@vger.kernel.org
Subject: [PATCH 20/20] PCI: Rearrange attributes from the pcibus_group
Date:   Fri, 16 Apr 2021 20:58:56 +0000
Message-Id: <20210416205856.3234481-21-kw@linux.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210416205856.3234481-1-kw@linux.com>
References: <20210416205856.3234481-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When new sysfs objects were added to the PCI device over time, the code
that implemented new attributes has been added in many different places
in the pci-sysfs.c file.  This makes it hard to read and also hard to
find relevant code.

Thus, collect all the attributes that are part of the "pcibus_group"
attribute group together and move to the top of the file sorting
everything attribute in the order of use.

No functional change intended.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 50 ++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index c29a781efe55..e2d3d214178a 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1038,26 +1038,6 @@ static const struct attribute_group pci_bus_group = {
 	.attrs = pci_bus_attrs,
 };
 
-static ssize_t cpuaffinity_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct pci_bus *bus = to_pci_bus(dev);
-	const struct cpumask *cpumask = cpumask_of_pcibus(bus);
-
-	return cpumap_print_to_pagebuf(false, buf, cpumask);
-}
-static DEVICE_ATTR_RO(cpuaffinity);
-
-static ssize_t cpulistaffinity_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct pci_bus *bus = to_pci_bus(dev);
-	const struct cpumask *cpumask = cpumask_of_pcibus(bus);
-
-	return cpumap_print_to_pagebuf(true, buf, cpumask);
-}
-static DEVICE_ATTR_RO(cpulistaffinity);
-
 static ssize_t bus_rescan_store(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
@@ -1082,6 +1062,26 @@ static ssize_t bus_rescan_store(struct device *dev,
 static struct device_attribute dev_attr_bus_rescan = __ATTR(rescan, 0200, NULL,
 							    bus_rescan_store);
 
+static ssize_t cpuaffinity_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct pci_bus *bus = to_pci_bus(dev);
+	const struct cpumask *cpumask = cpumask_of_pcibus(bus);
+
+	return cpumap_print_to_pagebuf(false, buf, cpumask);
+}
+static DEVICE_ATTR_RO(cpuaffinity);
+
+static ssize_t cpulistaffinity_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct pci_bus *bus = to_pci_bus(dev);
+	const struct cpumask *cpumask = cpumask_of_pcibus(bus);
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask);
+}
+static DEVICE_ATTR_RO(cpulistaffinity);
+
 static struct attribute *pcibus_attrs[] = {
 	&dev_attr_bus_rescan.attr,
 	&dev_attr_cpuaffinity.attr,
@@ -1093,11 +1093,6 @@ static const struct attribute_group pcibus_group = {
 	.attrs = pcibus_attrs,
 };
 
-const struct attribute_group *pcibus_groups[] = {
-	&pcibus_group,
-	NULL,
-};
-
 #ifdef HAVE_PCI_LEGACY
 /**
  * pci_read_legacy_io - read byte(s) from legacy I/O port space
@@ -1603,6 +1598,11 @@ const struct attribute_group *pci_bus_groups[] = {
 	NULL,
 };
 
+const struct attribute_group *pcibus_groups[] = {
+	&pcibus_group,
+	NULL,
+};
+
 const struct device_type pci_dev_type = {
 	.groups = pci_dev_attr_groups,
 };
-- 
2.31.0

