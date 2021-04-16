Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46DE3629DF
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343968AbhDPU7o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:59:44 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:45753 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343999AbhDPU7m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 16:59:42 -0400
Received: by mail-ej1-f52.google.com with SMTP id sd23so35350818ejb.12
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 13:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9LJehf4vVA9YmkyMHVQoHumdkMO50bcEMXHF3G09jEo=;
        b=g7QSe0a9UNShTdiEw0IXUGIAHkhM23fsogYiDTlRbfk5e+npo+w2duKW/IXBNX7pTI
         x3HC4KLXxRYGUeRv21kDkjTABgi27C4HVGtoTe8nXquveHlZj2uica++bYTEQjv2d9MD
         +qnnbECDuCK7KpeI3nrihsrxhYFeLQ6ZFeg6G9kTQoOEhdBqcEmGKCzTxnduTpgnbFOE
         L2LOdYrXsWer5yAqPxGKNHcRUqXWTGJ1kqrtiKVdUwnIgdm66JNCZCCQXq3UYyRNaJct
         8HfDQtKuqqgIs227nRBB8s4t0mBeOpePFNTWlLwwhu3+3H9AFKDocPrb/1FQUVPobmP5
         XTPw==
X-Gm-Message-State: AOAM533kQeuju+OrsNV83/qohd9OTVXv4mhBCuzSdtX8ZmTbG7E3Vg8u
        xn42uM+e0wrUY2LAAWfqZuQ=
X-Google-Smtp-Source: ABdhPJwEp02/z4i4YJg2d09g160vVZ3k65Zvvi4TIp7pnWAR4n2d1xCdaybQ2eDBpscGa7ffmmvKoQ==
X-Received: by 2002:a17:906:c283:: with SMTP id r3mr10138830ejz.328.1618606756854;
        Fri, 16 Apr 2021 13:59:16 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm5103864ejg.43.2021.04.16.13.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:59:16 -0700 (PDT)
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
Subject: [PATCH 19/20] PCI: Rearrange attributes from the pci_bus_group
Date:   Fri, 16 Apr 2021 20:58:55 +0000
Message-Id: <20210416205856.3234481-20-kw@linux.com>
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

Thus, collect all the attributes that are part of the "pci_bus_group"
attribute group together and move to the top of the file sorting
everything attribute in the order of use.

No functional change intended.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 48 ++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 44ce65bcacba..c29a781efe55 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1010,26 +1010,6 @@ static const struct attribute_group pcie_dev_attr_group = {
 /*
  * PCI Bus Class Devices
  */
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
 static ssize_t rescan_store(struct bus_type *bus, const char *buf, size_t count)
 {
 	bool rescan;
@@ -1058,10 +1038,25 @@ static const struct attribute_group pci_bus_group = {
 	.attrs = pci_bus_attrs,
 };
 
-const struct attribute_group *pci_bus_groups[] = {
-	&pci_bus_group,
-	NULL,
-};
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
 
 static ssize_t bus_rescan_store(struct device *dev,
 				struct device_attribute *attr, const char *buf,
@@ -1603,6 +1598,11 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
 	NULL,
 };
 
+const struct attribute_group *pci_bus_groups[] = {
+	&pci_bus_group,
+	NULL,
+};
+
 const struct device_type pci_dev_type = {
 	.groups = pci_dev_attr_groups,
 };
-- 
2.31.0

