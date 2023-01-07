Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F28660FEC
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jan 2023 16:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjAGPVL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Jan 2023 10:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjAGPVK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 Jan 2023 10:21:10 -0500
X-Greylist: delayed 402 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 07 Jan 2023 07:21:06 PST
Received: from smtp161.vfemail.net (smtp161.vfemail.net [146.59.185.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A827633B
        for <linux-pci@vger.kernel.org>; Sat,  7 Jan 2023 07:21:05 -0800 (PST)
Received: (qmail 20991 invoked from network); 7 Jan 2023 15:14:22 +0000
Received: from localhost (HELO nl101-3.vfemail.net) ()
  by smtpout.vfemail.net with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 7 Jan 2023 15:14:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=vfemail.net; h=message-id
        :date:mime-version:from:subject:to:cc:content-type
        :content-transfer-encoding; s=2018; bh=VcGThWdCpMi1lz2xt7wcGKjmb
        MrhXZJ/ocbcPi5BdBc=; b=UgxoabzhBwm3ps2oa0v6L/kObeXLmZ0x+rxbp/3eY
        2NQZXFcgFNDcFBKkJa7IAgJ8bSE8R/uFljg1GYcblRTdUCV4QA4M0AGgGX9St3Rw
        061f0D0Huo2YmYOVWbZSQYDnqf9KTV4YDU4lPTJ79rc5roE8eHK+l8qT/xhGa0GI
        lM=
Received: (qmail 42906 invoked from network); 7 Jan 2023 15:12:38 -0000
Received: by simscan 1.4.0 ppid: 42868, pid: 42898, t: 0.6880s
         scanners:none
Received: from unknown (HELO bmwxMDEudmZlbWFpbC5uZXQ=) (ZXF1dUBvcGVubWFpbC5jYw==@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 7 Jan 2023 15:12:38 -0000
Message-ID: <ea4e2fed-383d-829d-8a2a-9239768ccd94@openmail.cc>
Date:   Sat, 7 Jan 2023 23:14:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Mad Horse <equu@openmail.cc>
Subject: [PATCH] pci: Add functions to match pci dev or driver against OF DT
 node
To:     lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, Edward Chow <equu@openmail.cc>,
        linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, there seems no mechanism to check whether a compatibility
string within an OF DT node for a PCI device (whose spec is at
https://www.devicetree.org/open-firmware/bindings/pci/ ) matches the
vendor and device id of either the PCI device installed on the
corresponding location or the driver suggested by the compatibility
string, which can cause, for example, that an nvram cell defined
within an OF DT node for a driver may be erroneously applied to a
replaced device which should be powered with another driver capable to
accept an nvram cell with the same name, causing the driver
malfunctional or even kernel panic.

In order to resolve such issue, this patch introduces a function to
decode a compatibility string into a struct pci_device_id, which could
further be matched against PCI devices or drivers, as well as
functions to match a compatibility string or OF DT node against PCI
devices or drivers.

PCI drivers can then call these functions to check whether an OF DT
node matches themselves during driver enumeration, in order to accept
additional data provided by the node or ignore them when
incompatible.

Signed-off-by: Edward Chow <equu@openmail.cc>
---
drivers/pci/of.c | 304 +++++++++++++++++++++++++++++++++++++++
drivers/pci/pci-driver.c | 5 -
drivers/pci/pci.h | 56 ++++++++
include/linux/of_pci.h | 25 ++++
include/linux/pci.h | 6 +
5 files changed, 391 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 196834ed44fe..5d69bef67ef1 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -13,6 +13,8 @@
#include <linux/of_irq.h>
#include <linux/of_address.h>
#include <linux/of_pci.h>
+#include <linux/string.h>
+#include <linux/kstrtox.h>
#include "pci.h"
#ifdef CONFIG_PCI
@@ -251,6 +253,308 @@ void of_pci_check_probe_only(void)
}
EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
+/**
+ * of_pci_compat_to_device_id() - Decode an OF compatibility string into a
+ * pci_device_id structure.
+ * @compat: the compatibility string to decode, could be NULL
+ * @id: pointer to a struct pci_device_id, to store the result
+ * @rev: pointer to output revision info, PCI_ANY_ID if no revision in 
@compat
+ * @req_pcie: pointer to output whether @compat mandates PCI-E 
compatibility
+ *
+ * returns 0 when success, -EINVAL when failed.
+ */
+int of_pci_compat_to_device_id(const char *compat, struct pci_device_id 
*id,
+ __u32 *rev, __u32 *req_pcie)
+{
+ union {
+ __u8 u8;
+ __u16 u16;
+ __u32 u32;
+ } res = {0};
+ *req_pcie = 0;
+ *rev = PCI_ANY_ID;
+ if (!compat || strncasecmp(compat, "pci", 3) != 0)
+ goto failed;
+ compat += 3;
+
+ if (strncasecmp(compat, "class,", 6) == 0) {
+ /* pciclass,CCSSPP */
+ compat += 6;
+ if ((strlen(compat) < 4)
+ || kstrtouint(compat, 16, &id->class))
+ goto failed;
+ if (id->class < 0x10000) {
+ id->class <<= 8;
+ id->class_mask = 0xFFFF00;
+ } else {
+ id->class_mask = PCI_ANY_ID;
+ }
+ id->vendor = PCI_ANY_ID;
+ id->device = PCI_ANY_ID;
+ id->subvendor = PCI_ANY_ID;
+ id->subdevice = PCI_ANY_ID;
+ goto done;
+ }
+
+ if (strncasecmp(compat, "ex", 2) == 0) {
+ /* pciex... */
+ *req_pcie = 1;
+ compat += 2;
+ }
+ if (kstrtou16(compat, 16, &res.u16))
+ goto failed;
+ id->vendor = res.u16;
+ compat = strchr(compat, ',');
+ if (!compat)
+ goto failed;
+ compat++;
+ if (kstrtou16(compat, 16, &res.u16))
+ goto failed;
+ id->device = res.u16;
+ compat = strchr(compat, '.');
+ if (compat == NULL) {
+ /* pciVVVV,DDDD */
+ id->subvendor = PCI_ANY_ID;
+ id->subdevice = PCI_ANY_ID;
+ goto done;
+ }
+
+ compat++;
+ if (strlen(compat) == 2) {
+ /* pciVVVV,DDDD.RR */
+ if (kstrtou8(compat, 16, &res.u8))
+ goto failed;
+ *rev = res.u8;
+ id->subvendor = PCI_ANY_ID;
+ id->subdevice = PCI_ANY_ID;
+ goto done;
+ }
+
+ if (kstrtou16(compat, 16, &res.u16))
+ goto failed;
+ id->subvendor = res.u16;
+ compat = strchr(compat, '.');
+ if (!compat)
+ goto failed;
+ compat++;
+ if (kstrtou16(compat, 16, &res.u16))
+ goto failed;
+ id->subdevice = res.u16;
+ compat = strchr(compat, '.');
+ if (compat == NULL)
+ /* pciVVVV,DDDD.SSSS.ssss */
+ goto done;
+
+ compat++;
+ if (strlen(compat) == 2) {
+ /* pciVVVV,DDDD.SSSS.ssss.RR */
+ if (kstrtou8(compat, 16, &res.u8))
+ goto failed;
+ *rev = res.u8;
+ goto done;
+ }
+
+ failed:
+ return -EINVAL;
+ done:
+ return 0;
+}
+
+/**
+ * of_pci_compat_match_device() - Tell whether a PCI device structure 
matches
+ * a given OF compatibility string
+ * @compat: single OF compatibility string to match, could be NULL
+ * @dev the PCI device structure to match against
+ *
+ * Returns whether they match.
+ */
+bool of_pci_compat_match_device(const char *compat, const struct 
pci_dev *dev)
+{
+ __u32 rev = PCI_ANY_ID;
+ __u32 req_pcie = 0;
+ struct pci_device_id id = {0};
+
+ if (of_pci_compat_to_device_id(compat, &id, &rev, &req_pcie))
+ return false;
+ return pci_match_one_device(&id, dev) &&
+ (rev == PCI_ANY_ID || rev == dev->revision) &&
+ req_pcie ? dev->pcie_cap : true;
+}
+
+/**
+ * of_pci_node_match_device() - Tell whether an OF device tree node
+ * matches the given pci device
+ * @node: single OF device tree node to match, could be NULL
+ * @dev: the PCI device structure to match against, could be NULL
+ *
+ * Returns whether they match.
+ */
+bool of_pci_node_match_device(const struct device_node *node,
+ const struct pci_dev *dev)
+{
+ struct property *prop;
+ const char *cp;
+
+ if (!node || !dev)
+ return false;
+ prop = of_find_property(node, "compatible", NULL);
+ for (cp = of_prop_next_string(prop, NULL); cp;
+ cp = of_prop_next_string(prop, cp)) {
+ if (of_pci_compat_match_device(cp, dev))
+ return true;
+ }
+ return false;
+}
+EXPORT_SYMBOL_GPL(of_pci_node_match_device);
+
+/**
+ * of_pci_compat_match_one_id() - Tell whether a PCI device id 
structure matches
+ * a given OF compatibility string, note that there is no revision nor PCIe
+ * capability info in PCI device id structures
+ *
+ * @compat: single OF compatibility string to match, could be NULL
+ * @id the PCI device id structure to match against, could be NULL
+ *
+ * Returns the matching pci_device_id structure pointed by id
+ * or %NULL if there is no match.
+ */
+const struct pci_device_id *
+of_pci_compat_match_one_id(const char *compat, const struct 
pci_device_id *id)
+{
+ __u32 rev = PCI_ANY_ID;
+ __u32 req_pcie = 0;
+ struct pci_device_id pr = {0};
+
+ if (!compat || !id ||
+ of_pci_compat_to_device_id(compat, &pr, &rev, &req_pcie))
+ return NULL;
+ return pci_match_one_id(id, &pr);
+}
+
+/**
+ * of_pci_compat_match_id_table() - Tell whether a given OF 
compatibility string
+ * matches a given pci_id table
+ *
+ * @compat: single OF compatibility string to match, could be NULL
+ * @table the PCI device id table to match against, could be NULL
+ *
+ * Returns the matching pci_device_id structure or %NULL if there is no 
match.
+ */
+const struct pci_device_id *
+of_pci_compat_match_id_table(const char *compat, const struct 
pci_device_id *table)
+{
+ if (compat && table) {
+ while (table->vendor || table->subvendor || table->class_mask) {
+ if (of_pci_compat_match_one_id(compat, table))
+ return table;
+ table++;
+ }
+ }
+ return NULL;
+}
+
+/**
+ * of_pci_node_match_id_table() - Tell whether an OF device tree node
+ * matches the given pci_id table
+ * @node: single OF device tree node to match, could be NULL
+ * @table: the PCI device id table to match against, could be NULL
+ *
+ * Returns the matching pci_device_id structure
+ * or %NULL if there is no match.
+ */
+const struct pci_device_id *
+of_pci_node_match_id_table(const struct device_node *node,
+ const struct pci_device_id *table)
+{
+ struct property *prop;
+ const char *cp;
+ const struct pci_device_id *id;
+
+ if (!node || !table)
+ return NULL;
+ prop = of_find_property(node, "compatible", NULL);
+ for (cp = of_prop_next_string(prop, NULL); cp;
+ cp = of_prop_next_string(prop, cp)) {
+ id = of_pci_compat_match_id_table(cp, table);
+ if (id)
+ return id;
+ }
+ return NULL;
+}
+EXPORT_SYMBOL_GPL(of_pci_node_match_id_table);
+
+/**
+ * of_pci_compat_match_driver - See if a given OF compatibility string 
matches
+ * a driver's list of IDs
+ * @compat: single OF compatibility string to match, could be NULL
+ * @drv: the PCI driver to match against, could be NULL
+ *
+ * Used by a driver to check whether an OF compatibility string matches 
one of
+ * (dynamically) supported devices, which may have been augmented
+ * via the sysfs "new_id" file. Returns the matching pci_device_id
+ * structure or %NULL if there is no match.
+ */
+const struct pci_device_id *
+of_pci_compat_match_driver(const char *compat, struct pci_driver *drv)
+{
+ struct pci_dynid *dynid;
+ const struct pci_device_id *found_id = NULL, *ids;
+
+ if (!compat || !drv)
+ return NULL;
+ /* Look at the dynamic ids first, before the static ones */
+ spin_lock(&drv->dynids.lock);
+ list_for_each_entry(dynid, &drv->dynids.list, node) {
+ if (of_pci_compat_match_one_id(compat, &dynid->id)) {
+ found_id = &dynid->id;
+ break;
+ }
+ }
+ spin_unlock(&drv->dynids.lock);
+
+ if (found_id)
+ return found_id;
+
+ for (ids = drv->id_table; (found_id = 
of_pci_compat_match_one_id(compat, ids));
+ ids = found_id + 1) {
+ /* exclude ids in id_table with override_only */
+ if (!found_id->override_only)
+ return found_id;
+ }
+
+ return NULL;
+}
+
+/**
+ * of_pci_node_match_driver() - Tell whether an OF device tree node
+ * matches the given pci driver
+ * @node: single OF device tree node to match, could be NULL
+ * @drv: the PCI driver structure to match against, could be NULL
+ *
+ * Returns the matching pci_device_id structure
+ * or %NULL if there is no match.
+ */
+const struct pci_device_id *
+of_pci_node_match_driver(const struct device_node *node,
+ struct pci_driver *drv)
+{
+ struct property *prop;
+ const char *cp;
+ const struct pci_device_id *id;
+
+ if (!node || !drv)
+ return NULL;
+ prop = of_find_property(node, "compatible", NULL);
+ for (cp = of_prop_next_string(prop, NULL); cp;
+ cp = of_prop_next_string(prop, cp)) {
+ id = of_pci_compat_match_driver(cp, drv);
+ if (id)
+ return id;
+ }
+ return NULL;
+}
+EXPORT_SYMBOL_GPL(of_pci_node_match_driver);
+
/**
* devm_of_pci_get_host_bridge_resources() - Resource-managed parsing of PCI
* host bridge resources from DT
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index a2ceeacc33eb..aa212d12353f 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -24,11 +24,6 @@
#include "pci.h"
#include "pcie/portdrv.h"
-struct pci_dynid {
- struct list_head node;
- struct pci_device_id id;
-};
-
/**
* pci_add_dynid - add a new PCI device ID to this driver and re-probe 
devices
* @drv: target pci driver
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9ed3b5550043..e30652021a63 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -204,6 +204,29 @@ pci_match_one_device(const struct pci_device_id 
*id, const struct pci_dev *dev)
return NULL;
}
+/**
+ * pci_match_one_id - Tell if a PCI device id structure matches another
+ * PCI device id structure
+ * @id: single PCI device id structure to match, usually in a list or array
+ * @pr: the probing PCI device id structure to match against, usually 
converted from
+ * other format
+ *
+ * Returns the matching pci_device_id structure pointed by id
+ * or %NULL if there is no match.
+ */
+static inline const struct pci_device_id *
+pci_match_one_id(const struct pci_device_id *id, const struct 
pci_device_id *pr)
+{
+ if ((id->vendor == pr->vendor) &&
+ (id->device == pr->device) &&
+ (id->subvendor == pr->subvendor) &&
+ (id->subdevice == pr->subdevice) &&
+ (id->class == pr->class) &&
+ (id->class_mask == pr->class_mask))
+ return id;
+ return NULL;
+}
+
/* PCI slot sysfs helper code */
#define to_pci_slot(s) container_of(s, struct pci_slot, kobj)
@@ -638,6 +661,15 @@ void pci_release_bus_of_node(struct pci_bus *bus);
int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge 
*bridge);
+int of_pci_compat_to_device_id(const char *compat, struct pci_device_id 
*id,
+ __u32 *rev, __u32 *req_pcie);
+bool of_pci_compat_match_device(const char *compat, const struct 
pci_dev *dev);
+const struct pci_device_id *
+of_pci_compat_match_one_id(const char *compat, const struct 
pci_device_id *id);
+const struct pci_device_id *
+of_pci_compat_match_id_table(const char *compat, const struct 
pci_device_id *table);
+const struct pci_device_id *
+of_pci_compat_match_driver(const char *compat, struct pci_driver *drv);
#else
static inline int
of_pci_parse_bus_range(struct device_node *node, struct resource *res)
@@ -679,6 +711,30 @@ static inline int devm_of_pci_bridge_init(struct 
device *dev, struct pci_host_br
return 0;
}
+static inline int of_pci_compat_to_device_id(const char *compat, struct 
pci_device_id *id,
+ __u32 *rev, __u32 *req_pcie)
+{
+ return -EINVAL;
+}
+static inline bool of_pci_compat_match_device(const char *compat, const 
struct pci_dev *dev)
+{
+ return false;
+}
+static inline const struct pci_device_id *
+of_pci_compat_match_one_id(const char *compat, const struct 
pci_device_id *id)
+{
+ return NULL;
+}
+static inline const struct pci_device_id *
+of_pci_compat_match_id_table(const char *compat, const struct 
pci_device_id *table)
+{
+ return NULL;
+}
+static inline const struct pci_device_id *
+of_pci_compat_match_driver(const char *compat, struct pci_driver *drv)
+{
+ return NULL;
+}
#endif /* CONFIG_OF */
#ifdef CONFIG_PCIEAER
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 29658c0ee71f..eef1eaafc03d 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -13,6 +13,14 @@ struct device_node *of_pci_find_child_device(struct 
device_node *parent,
unsigned int devfn);
int of_pci_get_devfn(struct device_node *np);
void of_pci_check_probe_only(void);
+bool of_pci_node_match_device(const struct device_node *node,
+ const struct pci_dev *dev);
+const struct pci_device_id *
+of_pci_node_match_id_table(const struct device_node *node,
+ const struct pci_device_id *table);
+const struct pci_device_id *
+of_pci_node_match_driver(const struct device_node *node,
+ struct pci_driver *drv);
#else
static inline struct device_node *of_pci_find_child_device(struct 
device_node *parent,
unsigned int devfn)
@@ -26,6 +34,23 @@ static inline int of_pci_get_devfn(struct device_node 
*np)
}
static inline void of_pci_check_probe_only(void) { }
+static inline bool of_pci_node_match_device(const struct device_node *node,
+ const struct pci_dev *dev)
+{
+ return false;
+}
+static inline const struct pci_device_id *
+of_pci_node_match_id_table(const struct device_node *node,
+ const struct pci_device_id *table)
+{
+ return NULL;
+}
+static inline const struct pci_device_id *
+of_pci_node_match_driver(const struct device_node *node,
+ struct pci_driver *drv)
+{
+ return NULL;
+}
#endif
#if IS_ENABLED(CONFIG_OF_IRQ)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index adffd65e84b4..04c908d84b90 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1513,6 +1513,12 @@ void pci_unregister_driver(struct pci_driver *dev);
builtin_driver(__pci_driver, pci_register_driver)
struct pci_driver *pci_dev_driver(const struct pci_dev *dev);
+
+struct pci_dynid {
+ struct list_head node;
+ struct pci_device_id id;
+};
+
int pci_add_dynid(struct pci_driver *drv,
unsigned int vendor, unsigned int device,
unsigned int subvendor, unsigned int subdevice,

-- 
2.39.0


