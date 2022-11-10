Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0532F624AFC
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 20:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiKJTxe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 14:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiKJTxc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 14:53:32 -0500
X-Greylist: delayed 150 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 11:53:19 PST
Received: from resqmta-h1p-028588.sys.comcast.net (resqmta-h1p-028588.sys.comcast.net [IPv6:2001:558:fd02:2446::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4817747332
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 11:53:19 -0800 (PST)
Received: from resomta-h1p-027912.sys.comcast.net ([96.102.179.201])
        by resqmta-h1p-028588.sys.comcast.net with ESMTP
        id t8NCo9FHCxitjtDZYoR0j0; Thu, 10 Nov 2022 19:50:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1668109848;
        bh=sofvAoEwaPb3mNtzuqfqCWvRe5407SRczb2NnSKewQY=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version:
         Xfinity-Spam-Result;
        b=UBKIwqr9wltygoaWs9pl4K2yPhxo48Yqp+O8k87EFPX+99XEw2K0QrsegdBU9Hptb
         geZuI7wvwBWoLPiUV4R0rH7nViMa9jnHCp9iVuXhmm1YUh+L8GLFqTaE5vbsCq839F
         KeQkMwAzv8LA7svaGoJLuHkewSt556O+914ye6WJutijNH1y8SDWAWa7kUjR7zrfvG
         DHtSLN1m5tEeKJVqSVEv+ukdCsAiOArUz86yvSZNprxt/jLuwNlkpCWraeivmmNi1X
         1MGlyl49eaKJtTljnR9Ltm2VaJ1L4cIJ0q71SAe02O9wUGylu6vP4OMWHBWlltKFz0
         0Lmx5xepaq4DA==
Received: from jderrick-mobl4.amr.corp.intel.com ([71.205.181.50])
        by resomta-h1p-027912.sys.comcast.net with ESMTPA
        id tDZ4oZTHiVTvltDZGokliB; Thu, 10 Nov 2022 19:50:31 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvgedrfeeggddufeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhgrthhhrghnucffvghrrhhitghkuceojhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvqeenucggtffrrghtthgvrhhnpedtteeljeffgfffveehhfetveefuedvheevffffhedtjeeuvdevgfeftddtheeftdenucfkphepjedurddvtdehrddukedurdehtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhephhgvlhhopehjuggvrhhrihgtkhdqmhhosghlgedrrghmrhdrtghorhhprdhinhhtvghlrdgtohhmpdhinhgvthepjedurddvtdehrddukedurdehtddpmhgrihhlfhhrohhmpehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehvihguhigrshesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgrnhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhrvghniihordhpihgvrhgrlhhishhisegrrhhmrdgtohhmpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
 hugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsseifuhhnnhgvrhdruggvpdhrtghpthhtohepphgrlhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvh
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH v2 4/7] PCI: Move pci_dev_str_match to search.c
Date:   Thu, 10 Nov 2022 12:50:12 -0700
Message-Id: <20221110195015.207-5-jonathan.derrick@linux.dev>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221110195015.207-1-jonathan.derrick@linux.dev>
References: <20221110195015.207-1-jonathan.derrick@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The method which extracts a string descriptor of one or more PCI devices
and matches to a struct pci_dev is useful in general to other subsystems
needing to match parameters or sysfs strings. Move this function to
search.c for general use.

Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
 drivers/pci/pci.c    | 163 -------------------------------------------
 drivers/pci/search.c | 162 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |   5 ++
 3 files changed, 167 insertions(+), 163 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2127aba3550b..b58a8f5a7654 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -250,169 +250,6 @@ void __iomem *pci_ioremap_wc_bar(struct pci_dev *pdev, int bar)
 EXPORT_SYMBOL_GPL(pci_ioremap_wc_bar);
 #endif
 
-/**
- * pci_dev_str_match_path - test if a path string matches a device
- * @dev: the PCI device to test
- * @path: string to match the device against
- * @endptr: pointer to the string after the match
- *
- * Test if a string (typically from a kernel parameter) formatted as a
- * path of device/function addresses matches a PCI device. The string must
- * be of the form:
- *
- *   [<domain>:]<bus>:<device>.<func>[/<device>.<func>]*
- *
- * A path for a device can be obtained using 'lspci -t'.  Using a path
- * is more robust against bus renumbering than using only a single bus,
- * device and function address.
- *
- * Returns 1 if the string matches the device, 0 if it does not and
- * a negative error code if it fails to parse the string.
- */
-static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
-				  const char **endptr)
-{
-	int ret;
-	unsigned int seg, bus, slot, func;
-	char *wpath, *p;
-	char end;
-
-	*endptr = strchrnul(path, ';');
-
-	wpath = kmemdup_nul(path, *endptr - path, GFP_ATOMIC);
-	if (!wpath)
-		return -ENOMEM;
-
-	while (1) {
-		p = strrchr(wpath, '/');
-		if (!p)
-			break;
-		ret = sscanf(p, "/%x.%x%c", &slot, &func, &end);
-		if (ret != 2) {
-			ret = -EINVAL;
-			goto free_and_exit;
-		}
-
-		if (dev->devfn != PCI_DEVFN(slot, func)) {
-			ret = 0;
-			goto free_and_exit;
-		}
-
-		/*
-		 * Note: we don't need to get a reference to the upstream
-		 * bridge because we hold a reference to the top level
-		 * device which should hold a reference to the bridge,
-		 * and so on.
-		 */
-		dev = pci_upstream_bridge(dev);
-		if (!dev) {
-			ret = 0;
-			goto free_and_exit;
-		}
-
-		*p = 0;
-	}
-
-	ret = sscanf(wpath, "%x:%x:%x.%x%c", &seg, &bus, &slot,
-		     &func, &end);
-	if (ret != 4) {
-		seg = 0;
-		ret = sscanf(wpath, "%x:%x.%x%c", &bus, &slot, &func, &end);
-		if (ret != 3) {
-			ret = -EINVAL;
-			goto free_and_exit;
-		}
-	}
-
-	ret = (seg == pci_domain_nr(dev->bus) &&
-	       bus == dev->bus->number &&
-	       dev->devfn == PCI_DEVFN(slot, func));
-
-free_and_exit:
-	kfree(wpath);
-	return ret;
-}
-
-/**
- * pci_dev_str_match - test if a string matches a device
- * @dev: the PCI device to test
- * @p: string to match the device against
- * @endptr: pointer to the string after the match
- *
- * Test if a string (typically from a kernel parameter) matches a specified
- * PCI device. The string may be of one of the following formats:
- *
- *   [<domain>:]<bus>:<device>.<func>[/<device>.<func>]*
- *   pci:<vendor>:<device>[:<subvendor>:<subdevice>]
- *
- * The first format specifies a PCI bus/device/function address which
- * may change if new hardware is inserted, if motherboard firmware changes,
- * or due to changes caused in kernel parameters. If the domain is
- * left unspecified, it is taken to be 0.  In order to be robust against
- * bus renumbering issues, a path of PCI device/function numbers may be used
- * to address the specific device.  The path for a device can be determined
- * through the use of 'lspci -t'.
- *
- * The second format matches devices using IDs in the configuration
- * space which may match multiple devices in the system. A value of 0
- * for any field will match all devices. (Note: this differs from
- * in-kernel code that uses PCI_ANY_ID which is ~0; this is for
- * legacy reasons and convenience so users don't have to specify
- * FFFFFFFFs on the command line.)
- *
- * Returns 1 if the string matches the device, 0 if it does not and
- * a negative error code if the string cannot be parsed.
- */
-static int pci_dev_str_match(struct pci_dev *dev, const char *p,
-			     const char **endptr)
-{
-	int ret;
-	int count;
-	unsigned short vendor, device, subsystem_vendor, subsystem_device;
-
-	if (strncmp(p, "pci:", 4) == 0) {
-		/* PCI vendor/device (subvendor/subdevice) IDs are specified */
-		p += 4;
-		ret = sscanf(p, "%hx:%hx:%hx:%hx%n", &vendor, &device,
-			     &subsystem_vendor, &subsystem_device, &count);
-		if (ret != 4) {
-			ret = sscanf(p, "%hx:%hx%n", &vendor, &device, &count);
-			if (ret != 2)
-				return -EINVAL;
-
-			subsystem_vendor = 0;
-			subsystem_device = 0;
-		}
-
-		p += count;
-
-		if ((!vendor || vendor == dev->vendor) &&
-		    (!device || device == dev->device) &&
-		    (!subsystem_vendor ||
-			    subsystem_vendor == dev->subsystem_vendor) &&
-		    (!subsystem_device ||
-			    subsystem_device == dev->subsystem_device))
-			goto found;
-	} else {
-		/*
-		 * PCI Bus, Device, Function IDs are specified
-		 * (optionally, may include a path of devfns following it)
-		 */
-		ret = pci_dev_str_match_path(dev, p, &p);
-		if (ret < 0)
-			return ret;
-		else if (ret)
-			goto found;
-	}
-
-	*endptr = p;
-	return 0;
-
-found:
-	*endptr = p;
-	return 1;
-}
-
 static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
 				  u8 pos, int cap, int *ttl)
 {
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index b4c138a6ec02..059fc5b9db4c 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -390,3 +390,165 @@ int pci_dev_present(const struct pci_device_id *ids)
 	return 0;
 }
 EXPORT_SYMBOL(pci_dev_present);
+
+/**
+ * pci_dev_str_match_path - test if a path string matches a device
+ * @dev: the PCI device to test
+ * @path: string to match the device against
+ * @endptr: pointer to the string after the match
+ *
+ * Test if a string (typically from a kernel parameter) formatted as a
+ * path of device/function addresses matches a PCI device. The string must
+ * be of the form:
+ *
+ *   [<domain>:]<bus>:<device>.<func>[/<device>.<func>]*
+ *
+ * A path for a device can be obtained using 'lspci -t'.  Using a path
+ * is more robust against bus renumbering than using only a single bus,
+ * device and function address.
+ *
+ * Returns 1 if the string matches the device, 0 if it does not and
+ * a negative error code if it fails to parse the string.
+ */
+static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
+				  const char **endptr)
+{
+	int ret;
+	unsigned int seg, bus, slot, func;
+	char *wpath, *p;
+	char end;
+
+	*endptr = strchrnul(path, ';');
+
+	wpath = kmemdup_nul(path, *endptr - path, GFP_ATOMIC);
+	if (!wpath)
+		return -ENOMEM;
+
+	while (1) {
+		p = strrchr(wpath, '/');
+		if (!p)
+			break;
+		ret = sscanf(p, "/%x.%x%c", &slot, &func, &end);
+		if (ret != 2) {
+			ret = -EINVAL;
+			goto free_and_exit;
+		}
+
+		if (dev->devfn != PCI_DEVFN(slot, func)) {
+			ret = 0;
+			goto free_and_exit;
+		}
+
+		/*
+		 * Note: we don't need to get a reference to the upstream
+		 * bridge because we hold a reference to the top level
+		 * device which should hold a reference to the bridge,
+		 * and so on.
+		 */
+		dev = pci_upstream_bridge(dev);
+		if (!dev) {
+			ret = 0;
+			goto free_and_exit;
+		}
+
+		*p = 0;
+	}
+
+	ret = sscanf(wpath, "%x:%x:%x.%x%c", &seg, &bus, &slot,
+		     &func, &end);
+	if (ret != 4) {
+		seg = 0;
+		ret = sscanf(wpath, "%x:%x.%x%c", &bus, &slot, &func, &end);
+		if (ret != 3) {
+			ret = -EINVAL;
+			goto free_and_exit;
+		}
+	}
+
+	ret = (seg == pci_domain_nr(dev->bus) &&
+	       bus == dev->bus->number &&
+	       dev->devfn == PCI_DEVFN(slot, func));
+
+free_and_exit:
+	kfree(wpath);
+	return ret;
+}
+
+/**
+ * pci_dev_str_match - test if a string matches a device
+ * @dev: the PCI device to test
+ * @p: string to match the device against
+ * @endptr: pointer to the string after the match
+ *
+ * Test if a string (typically from a kernel parameter) matches a specified
+ * PCI device. The string may be of one of the following formats:
+ *
+ *   [<domain>:]<bus>:<device>.<func>[/<device>.<func>]*
+ *   pci:<vendor>:<device>[:<subvendor>:<subdevice>]
+ *
+ * The first format specifies a PCI bus/device/function address which
+ * may change if new hardware is inserted, if motherboard firmware changes,
+ * or due to changes caused in kernel parameters. If the domain is
+ * left unspecified, it is taken to be 0.  In order to be robust against
+ * bus renumbering issues, a path of PCI device/function numbers may be used
+ * to address the specific device.  The path for a device can be determined
+ * through the use of 'lspci -t'.
+ *
+ * The second format matches devices using IDs in the configuration
+ * space which may match multiple devices in the system. A value of 0
+ * for any field will match all devices. (Note: this differs from
+ * in-kernel code that uses PCI_ANY_ID which is ~0; this is for
+ * legacy reasons and convenience so users don't have to specify
+ * FFFFFFFFs on the command line.)
+ *
+ * Returns 1 if the string matches the device, 0 if it does not and
+ * a negative error code if the string cannot be parsed.
+ */
+int pci_dev_str_match(struct pci_dev *dev, const char *p, const char **endptr)
+{
+	int ret;
+	int count;
+	unsigned short vendor, device, subsystem_vendor, subsystem_device;
+
+	if (strncmp(p, "pci:", 4) == 0) {
+		/* PCI vendor/device (subvendor/subdevice) IDs are specified */
+		p += 4;
+		ret = sscanf(p, "%hx:%hx:%hx:%hx%n", &vendor, &device,
+			     &subsystem_vendor, &subsystem_device, &count);
+		if (ret != 4) {
+			ret = sscanf(p, "%hx:%hx%n", &vendor, &device, &count);
+			if (ret != 2)
+				return -EINVAL;
+
+			subsystem_vendor = 0;
+			subsystem_device = 0;
+		}
+
+		p += count;
+
+		if ((!vendor || vendor == dev->vendor) &&
+		    (!device || device == dev->device) &&
+		    (!subsystem_vendor ||
+			    subsystem_vendor == dev->subsystem_vendor) &&
+		    (!subsystem_device ||
+			    subsystem_device == dev->subsystem_device))
+			goto found;
+	} else {
+		/*
+		 * PCI Bus, Device, Function IDs are specified
+		 * (optionally, may include a path of devfns following it)
+		 */
+		ret = pci_dev_str_match_path(dev, p, &p);
+		if (ret < 0)
+			return ret;
+		else if (ret)
+			goto found;
+	}
+
+	*endptr = p;
+	return 0;
+
+found:
+	*endptr = p;
+	return 1;
+}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 09f704337955..0c907f94bb61 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1182,6 +1182,7 @@ struct pci_dev *pci_get_domain_bus_and_slot(int domain, unsigned int bus,
 					    unsigned int devfn);
 struct pci_dev *pci_get_class(unsigned int class, struct pci_dev *from);
 int pci_dev_present(const struct pci_device_id *ids);
+int pci_dev_str_match(struct pci_dev *dev, const char *p, const char **endptr);
 
 int pci_bus_read_config_byte(struct pci_bus *bus, unsigned int devfn,
 			     int where, u8 *val);
@@ -1816,6 +1817,10 @@ static inline struct pci_dev *pci_get_class(unsigned int class,
 static inline int pci_dev_present(const struct pci_device_id *ids)
 { return 0; }
 
+static inline int pci_dev_str_match(struct pci_dev *dev, const char *p,
+				    const char **endptr)
+{ return 0; }
+
 #define no_pci_devices()	(1)
 #define pci_dev_put(dev)	do { } while (0)
 
-- 
2.30.2

