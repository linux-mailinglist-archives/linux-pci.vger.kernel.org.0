Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010A8456156
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 18:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhKRRWV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 12:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbhKRRWV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 12:22:21 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0648C06173E;
        Thu, 18 Nov 2021 09:19:20 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 206so935896pgb.4;
        Thu, 18 Nov 2021 09:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lykREBl8vG1Uu8zpbqL+VsU8Cy8qTbm6RFYTKBhhUAM=;
        b=Jxpqep1+4wSCD4LZnvHMMuQFU4HKVfcGbs4v1aCQXAZ/uzWQijrsKMzTL4UqSsLpsp
         nHvrUl6UksQ6gWqc/vRmkQwT9oJRNdU2wZ5RuZT+LXr0w5VqliEdG8UWcw9OxqHZWmnH
         +9YXNIsRz2+U7AREWN9EZjlrrjqaRqtJ44FnDUeNcRcs8BBa5cAh+jPSpexBKUhhKdEl
         UOrRBKvVQhOJ7gCZ6qM9fd7ggXmoaEvgsLi23nXWhUTt6c3t6Ev64Gu87Njty5GxJlmP
         OrGF5v4gMW50Q89qD6y3e/V4x2Aot3l07MC5147PgGPI2xUYmpcGmKa6sVvgFzWtIXLg
         oK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lykREBl8vG1Uu8zpbqL+VsU8Cy8qTbm6RFYTKBhhUAM=;
        b=0tWD3aTiBS6P0JLowd3LNYH7YWzR6YJsU0OAVFPhbRmEiRcy11bO5dXrtXNO4Y0t3W
         YTElLK+NwCFIGAmqJZJdvXJYRD77FYti4+EaPACZBF/OaWe6OWCPO9ZJLNbOMqLz5yWp
         QIoKyCIOhTUtH2/jO++5+tOtCqkTPmfnsp6g6fOUHrfrTahbiotqGG8uq/E8ZatPmzig
         1BcsJQl/T10yVTJHAmO0WQIRiZUbVd3sh59vUQz5ibABbO7wAuFOcPpYuRsxKwH8W3bO
         ugoGP/JvOHn53SxI0gyU6nI/E53rycb6pWoJxLXzZXXOxM1HaUjXVd73CSPu+mp3LW+E
         /LcQ==
X-Gm-Message-State: AOAM532JCq+3I6NEBdvMnIwMwk8EyAaMHR3d4JTUljZxOGDyDiYhWjdq
        H+cbUq6AKv/98rIeHHim9pQ=
X-Google-Smtp-Source: ABdhPJwbbQ8ZoVJkUb0vgUP0mK/pneVtEhj+yp7hD4xU92iLHaqRNjUE4GlgjP88OE4lATMzvkMeoQ==
X-Received: by 2002:a63:501:: with SMTP id 1mr12227734pgf.78.1637255960243;
        Thu, 18 Nov 2021 09:19:20 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id u32sm191283pfg.220.2021.11.18.09.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 09:19:19 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 1/1] PCI: Add KUnit tests for __pci_read_base()
Date:   Thu, 18 Nov 2021 22:48:51 +0530
Message-Id: <07ce42cd2000acbff5f2fdfd8c15972a364b5cbd.1637250854.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637250854.git.naveennaidu479@gmail.com>
References: <cover.1637250854.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently it is hard to debug issues in the resource assignment code due
to long reporduction cycles between the developer trying to fix the code
and the user testing it due to the lack of hardware device with the
developer [1].

[1]:
https://lore.kernel.org/all/20210621123714.GA3286648@bjorn-Precision-5520/

This adds KUnit tests for __pci_read_base() which is only  dependent
on software structures, so no hardware is needed to run these.

This lays the foundation for test fixtures we can use to reproduce the
resource assignment code path of PCI.

Sample output from KUnit Test run:

      # Subtest: __pci_read_base()
      1..3
      # test_pci_read_base_type_0_hdr_approach_1: initializing __pci_read_base() tests
   (null): reg 0x18: [mem 0x4f400000-0x4f400fff]
      ok 1 - test_pci_read_base_type_0_hdr_approach_1
      # test_pci_read_base_type_0_hdr_approach_2: initializing __pci_read_base() tests
   (null): reg 0x18: [mem 0x4f400000-0x4f400fff]
   (null): reg 0x1c: [mem 0xaf400000-0xaf4000ff]
      ok 2 - test_pci_read_base_type_0_hdr_approach_2
      # test_pci_read_base_type_1_hdr: initializing __pci_read_base() tests
   (null): reg 0x10: [mem 0xaf400000-0xaf4000ff]
      ok 3 - test_pci_read_base_type_1_hdr
  # __pci_read_base(): pass:3 fail:0 skip:0 total:3
  # Totals: pass:3 fail:0 skip:0 total:3
  # ok 8 - __pci_read_base()

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/Kconfig              |   4 +
 drivers/pci/Makefile             |   3 +
 drivers/pci/pci-read-base-test.c | 803 +++++++++++++++++++++++++++++++
 3 files changed, 810 insertions(+)
 create mode 100644 drivers/pci/pci-read-base-test.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 43e615aa12ff..12b3779fb640 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -252,6 +252,10 @@ config PCIE_BUS_PEER2PEER
 
 endchoice
 
+config PCI_READ_BASE_KUNIT_TEST
+	tristate "KUnit tests for __pci_read_base() in probe.c"
+	depends on PCI && KUNIT=y
+
 source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/controller/Kconfig"
 source "drivers/pci/endpoint/Kconfig"
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index d62c4ac4ae1b..010a903c3d5d 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -36,4 +36,7 @@ obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
 obj-y				+= controller/
 obj-y				+= switch/
 
+# KUnit test files
+obj-$(CONFIG_PCI_READ_BASE_KUNIT_TEST) += pci-read-base-test.o
+
 subdir-ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
diff --git a/drivers/pci/pci-read-base-test.c b/drivers/pci/pci-read-base-test.c
new file mode 100644
index 000000000000..df89d50b0321
--- /dev/null
+++ b/drivers/pci/pci-read-base-test.c
@@ -0,0 +1,803 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for __pci_read_base()
+ *
+ * Author: Naveen Naidu <naveennaidu479@gmail.com>
+ */
+#include <kunit/test.h>
+#include <linux/pci.h>
+#include <linux/math.h>
+#include <linux/errno.h>
+
+#include "pci.h"
+
+#define MY_PCI_BUS_NUM 0x011
+#define NUM_32_BITCONFIG_REGISTERS 16
+
+/*
+ * Representation of type 0/1 headers.
+ *
+ * Each element of the array represents one 32 bit register of the
+ * Type 0/1 Header register.
+ */
+u32 config_registers[NUM_32_BITCONFIG_REGISTERS];
+
+/* Type of the device you are testing */
+unsigned int type_header_test_case;
+
+/* Type 0/1 Header register values */
+struct config_space_bitfield {
+	char name[64];
+	unsigned int offset;
+	unsigned int size; /* In bytes */
+	unsigned int bit_array_index;
+	unsigned int value;
+};
+
+/*
+ * The index value of BARS in the type_0/1_header struct.
+ * Useful for setting the values for test cases.
+ */
+enum type_header_BAR_index {
+	BAR0 = 3,
+	BAR1,
+	BAR2,
+	BAR3,
+	BAR4,
+	BAR5
+};
+
+/* PCI Type 0 Header for Endpoints */
+static struct config_space_bitfield type_0_header[] = {
+	{"Vendor ID",	PCI_VENDOR_ID,		2,	0,	0},
+	{"Device ID",	PCI_DEVICE_ID,		2,	16,	0},
+	{"Command",	PCI_COMMAND,		2,	32,	0},
+	{"BAR 0",	PCI_BASE_ADDRESS_0,	4,	128,	0},
+	{"BAR 1",	PCI_BASE_ADDRESS_1,	4,	160,	0},
+	{"BAR 2",	PCI_BASE_ADDRESS_2,	4,	192,	0},
+	{"BAR 3",	PCI_BASE_ADDRESS_3,	4,	224,	0},
+	{"BAR 4",	PCI_BASE_ADDRESS_4,	4,	256,	0},
+	{"BAR 5",	PCI_BASE_ADDRESS_5,	4,	288,	0}
+};
+
+/* PCI Type 1 Header for Bridges */
+static struct config_space_bitfield type_1_header[] = {
+	{"Vendor ID",	PCI_VENDOR_ID,		2,	0,	0},
+	{"Device ID",	PCI_DEVICE_ID,		2,	16,	0},
+	{"Command",	PCI_COMMAND,		2,	32,	0},
+	{"BAR 0",	PCI_BASE_ADDRESS_0,	4,	128,	0},
+	{"BAR 1",	PCI_BASE_ADDRESS_1,	4,	160,	0}
+};
+
+/*
+ * -----------------------------------------------------------------------
+ * Data structures to hold test cases values
+ * -----------------------------------------------------------------------
+ */
+
+/* Used for setting the test values of BAR registers. */
+struct config_BARS {
+	char name[64];
+	unsigned int offset;
+	/*
+	 * Allocated Address size.
+	 *
+	 * Value to return, when all 1's are written to BAR registers.
+	 *
+	 * See (NOTE: How to calculate the allocated address size for the BAR
+	 * registers) comment below.
+	 */
+	unsigned int allocated_size;
+};
+
+enum config_BARS_index {
+	config_BAR0,
+	config_BAR1,
+	config_BAR2,
+	config_BAR3,
+	config_BAR4,
+	config_BAR5
+};
+
+static struct config_BARS type_0_BARS_config[] = {
+	{"BAR 0", PCI_BASE_ADDRESS_0, 0},
+	{"BAR 1", PCI_BASE_ADDRESS_1, 0},
+	{"BAR 2", PCI_BASE_ADDRESS_2, 0},
+	{"BAR 3", PCI_BASE_ADDRESS_3, 0},
+	{"BAR 4", PCI_BASE_ADDRESS_4, 0},
+	{"BAR 5", PCI_BASE_ADDRESS_5, 0},
+};
+
+static struct config_BARS type_1_BARS_config[] = {
+	{"BAR 0", PCI_BASE_ADDRESS_0, 0},
+	{"BAR 1", PCI_BASE_ADDRESS_1, 0},
+};
+
+/*
+ * -----------------------------------------------------------------------
+ * Setup FAKE PCI Hierarchy and resources
+ * -----------------------------------------------------------------------
+ */
+
+static struct config_space_bitfield *get_type_header(unsigned int address)
+{
+
+	unsigned int i, size;
+	struct config_space_bitfield *type_hdr;
+	struct kunit *test = current->kunit_test;
+
+	if (type_header_test_case == PCI_HEADER_TYPE_NORMAL) {
+		type_hdr = type_0_header;
+		size = ARRAY_SIZE(type_0_header);
+	} else {
+		type_hdr = type_1_header;
+		size = ARRAY_SIZE(type_1_header);
+	}
+
+	for (i = 0; i < size; i++, type_hdr++) {
+		if (type_hdr->offset == address)
+			return type_hdr;
+	}
+
+	/*
+	 * FAILS, when you try to access a register not present in type_0_header[]
+	 * or type_1_header[]
+	 */
+	KUNIT_FAIL(test, "Can not access address which is not in config headers\n");
+	return NULL;
+}
+
+static int get_BAR_alloc_size(unsigned int address)
+{
+	unsigned int i, array_size;
+	struct config_BARS *BARS_config;
+	struct kunit *test = current->kunit_test;
+
+	if (type_header_test_case == PCI_HEADER_TYPE_NORMAL) {
+		BARS_config = type_0_BARS_config;
+		array_size = ARRAY_SIZE(type_0_BARS_config);
+	} else {
+		BARS_config = type_1_BARS_config;
+		array_size = ARRAY_SIZE(type_1_BARS_config);
+	}
+
+	for (i = 0; i < array_size; i++, BARS_config++) {
+		if (BARS_config->offset == address)
+			return BARS_config->allocated_size;
+	}
+
+	/* FAIL, when you try to access a non BAR register */
+	KUNIT_FAIL(test, "Can not access non BAR register\n");
+	return -EFAULT;
+}
+
+/*
+ * FIXME: The following, read_register() and set_register() function is
+ * implemented on the assumption that, you always try to read/write values
+ * from within  the size of the register being accessed
+ *
+ * It DOES NOT handle the case where the value to write/read is greater
+ * than the length of the register being accessed.
+ */
+
+/* Set a register value in config_registers[] */
+static void set_register(unsigned int address, unsigned int value, unsigned int size)
+{
+	int index, reg_start_pos, shift;
+	unsigned int flag, mask;
+
+	struct config_space_bitfield *type_hdr = get_type_header(address);
+
+	/* The Array Element where the register is present */
+	index = type_hdr->bit_array_index/32;
+
+	/*
+	 * The bit in the config_registers[index] from where the register starts
+	 */
+	reg_start_pos = type_hdr->bit_array_index%32;
+
+	/*
+	 * The shift that needs to be done to access the bits of the register.
+	 *
+	 * FIXME: If (shift < 0) then it means that you are trying to access
+	 * values outside the register's 32 bit boundary. This code does not
+	 * support that as of now.
+	 *
+	 * TODO: Do we want to abort the test case here OR throw an error?
+	 */
+	shift = (32 - (size * 8)) - (reg_start_pos);
+
+	/* Clear the bits of the register we want to write the values to */
+	flag = ~(int_pow(2, size*8) - 1);
+	mask = flag << shift;
+
+	config_registers[index] &= mask;
+
+	/*
+	 * Set the value
+	 *
+	 * FIXME: Check if the value being written is greater than the size of
+	 * register? Should we handle that case?
+	 */
+	config_registers[index] |= (value << shift);
+
+	/* Update the value of struct */
+	type_hdr->value = value;
+}
+
+/* Read a register value from config_registers[] */
+static unsigned int read_register_value(unsigned int address, unsigned int size)
+{
+	int index, reg_start_pos, shift;
+	unsigned int array_value, flag, mask, value;
+
+	struct config_space_bitfield *type_hdr = get_type_header(address);
+
+	/* The Array Element where this register is present */
+	index = type_hdr->bit_array_index/32;
+
+	/*
+	 * The bit in the config_registers[index] from where the register starts
+	 */
+	reg_start_pos = type_hdr->bit_array_index%32;
+
+	/* The shift that needs to be done to access the bits of the register
+	 *
+	 * FIXME: If (shift < 0) then it means that you are trying to access
+	 * values outside the register's 32 bit boundary. This code does not
+	 * support that as of now.
+	 *
+	 * TODO: Do we want to abort the test case here OR throw an error?
+	 */
+	shift = (32 - (size * 8)) - (reg_start_pos);
+
+	/* Save the value from entire array index */
+	array_value = config_registers[index];
+
+	/* Clear the bits of register, we do not want to read */
+	flag = (int_pow(2, size * 8) - 1);
+	mask = flag << shift;
+
+	/* Get the value of the register */
+	array_value &= mask;
+	value = array_value >> shift;
+
+	return value;
+}
+
+static int fake_pci_read(struct pci_bus *bus, unsigned int devfn,
+				int where, int size, u32 *val)
+{
+	*val = read_register_value(where, size);
+	return 0;
+}
+
+static int fake_pci_write(struct pci_bus *bus, unsigned int devfn,
+				int where, int size, u32 val)
+{
+	unsigned int start_BAR_addr, end_BAR_addr;
+
+	if (type_header_test_case == PCI_HEADER_TYPE_NORMAL) {
+		start_BAR_addr = type_0_header[BAR0].offset;
+		end_BAR_addr = type_0_header[BAR5].offset;
+	} else {
+		start_BAR_addr = type_1_header[BAR0].offset;
+		end_BAR_addr = type_1_header[BAR1].offset;
+	}
+
+	/*
+	 * When the value 0xFFFFFFFF is written to BAR registers, update the BAR
+	 * register such that it contains that allocated address space for it.
+	 *
+	 * We get this value from 'struct BARS_config[]', which was set before the
+	 * test ran.
+	 */
+	if ((where >= start_BAR_addr && where <= end_BAR_addr)
+		&& (val == 0xFFFFFFFF)) {
+		unsigned int BAR_alloc_size = get_BAR_alloc_size(where);
+
+		set_register(where, BAR_alloc_size, size);
+		return 0;
+	}
+
+	set_register(where, val, size);
+	return 0;
+}
+
+static struct pci_ops fake_pci_ops = {
+		.read = fake_pci_read,
+		.write = fake_pci_write,
+};
+
+static void pci_fake_bus_init(struct kunit *test, struct pci_bus *bus,
+	struct pci_dev *dev, struct resource *res)
+{
+	struct pci_host_bridge *bridge;
+
+	bus->ops = &fake_pci_ops;
+	bus->number = MY_PCI_BUS_NUM;
+	bus->parent = NULL;
+
+	/* Allocate and initialize a FAKE host bridge, else Kernel Panics */
+	bus->bridge = kunit_kzalloc(test, sizeof(struct pci_host_bridge *),
+					GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, bus->bridge  != NULL);
+
+	bridge = to_pci_host_bridge(bus->bridge);
+
+	INIT_LIST_HEAD(&bridge->windows);
+
+	INIT_LIST_HEAD(&bus->node);
+	INIT_LIST_HEAD(&bus->children);
+	INIT_LIST_HEAD(&bus->devices);
+	INIT_LIST_HEAD(&bus->slots);
+	INIT_LIST_HEAD(&bus->resources);
+	bus->max_bus_speed = PCI_SPEED_UNKNOWN;
+	bus->cur_bus_speed = PCI_SPEED_UNKNOWN;
+
+	/* Attach the device to the Fake PCI Bus */
+	INIT_LIST_HEAD(&dev->bus_list);
+	dev->bus = bus;
+	list_add_tail(&dev->bus_list, &bus->devices);
+
+	/* Initialize the resource */
+	res->name = "FAKE CHILD DEVICE";
+	res->start = 0xFFFFFFFF;
+	res->end = 0xFFFFFFFF;
+}
+
+/*
+ * -----------------------------------------------------------------------
+ * Functions for managing test values
+ * -----------------------------------------------------------------------
+ */
+
+static void init_test_registers(void)
+{
+	unsigned int i, array_size;
+	struct config_space_bitfield *type_hdr;
+
+	if (type_header_test_case == PCI_HEADER_TYPE_NORMAL) {
+		type_hdr = type_0_header;
+		array_size = ARRAY_SIZE(type_0_header);
+	} else {
+		type_hdr = type_1_header;
+		array_size = ARRAY_SIZE(type_1_header);
+	}
+
+	for (i = 0; i < array_size; i++, type_hdr++)
+		set_register(type_hdr->offset, type_hdr->value, type_hdr->size);
+}
+
+static void clear_BAR_test_config(void)
+{
+	unsigned int i, config_BAR;
+
+	if (type_header_test_case == PCI_HEADER_TYPE_NORMAL) {
+
+		/* Clear the registers */
+		for (i = 0; i < ARRAY_SIZE(type_0_header); i++)
+			config_registers[i] = 0;
+
+		/* Clear the values of BAR from the headers */
+		for (i = BAR0; i <= BAR5; i++)
+			type_0_header[i].value = 0;
+
+		/* Clear the BAR configuration */
+		for (config_BAR = config_BAR0; config_BAR <= config_BAR5;
+				config_BAR++)
+			type_0_BARS_config[config_BAR].allocated_size = 0;
+
+	} else {
+		/* Clear the registers */
+		for (i = 0; i < ARRAY_SIZE(type_1_header); i++)
+			config_registers[i] = 0;
+
+		/* Clear the values of BAR from the headers */
+		for (i = BAR0; i <= BAR1; i++)
+			type_1_header[i].value = 0;
+
+		/* Clear the BAR configuration */
+		for (config_BAR = config_BAR0; config_BAR <= config_BAR1;
+				config_BAR++)
+			type_1_BARS_config[config_BAR].allocated_size = 0;
+		}
+}
+
+/*
+ * NOTE: How to calculate the allocated address size for the BAR registers
+ * -----------------------------------------------------------------------
+ *
+ * The updated value of BAR when all 1's are written to it.
+ *
+ * The hardware of BAR registers is designed such that, whenever all 1's
+ * or 0xFFFFFFFF is written to it, it gets updated with the allocated size
+ * for the device. This value is used by software to figure out the allocated
+ * device size
+ *
+ * To calculate the address size (PCI 3.0 specification section 6.2.5.1):
+ *	1. Clear the lower four bits to zeros (since they are read only)
+ *	2. Invert all 32 bits
+ *	3. Add one to the result
+ *
+ * Since we have to simulate what hardware does, For easy reference on how
+ * to determine what we have to return when all 1's are written to our mock
+ * method is:
+ *
+ *	1. Construct 0xFFFFFFF  (Note 7 F's)
+ *	2. Update the above value such that the last (log2(size in bytes) - 4)
+ *	   bits are zero
+ *	3. Finally to the updated value, append X (where X is the last 4 bit
+ *	   value from the BAR register)
+ *
+ * For eg:
+ *	Say the BAR0 register has the value 0x4F400008 and the allocated size for
+ *	this device is 4 KiB i.e 4096 bytes.
+ *
+ *	1. let val = 0xFFFFFFF
+ *	2. No: of last bits in val that needs to be zero = log2(4096) - 4 = 8 bits
+ *	   Therefore val = 0xFFFFF00
+ *	3. The last 4 bits in the BAR0 register is 8 (BAR0 value 0x4F400008).
+ *	   i.e X = 8
+ *	4. Final value = Append X to val => val = 0xFFFFF008
+ *
+ * This means, the value that needs to be returned when BAR0 in our example is
+ * written with all 1's is 0xFFFFF008. If you wish to confirm, you can follow
+ * the method as prescribed in the (PCI 3.0 specification section 6.2.5.1) to
+ * determine the allocated size from the value 0xFFFFF008
+ *
+ */
+
+struct type_0_header_test_data {
+	u32 BAR0_value;
+	u32 BAR1_value;
+	u32 BAR2_value;
+	u32 BAR3_value;
+	u32 BAR4_value;
+	u32 BAR5_value;
+
+	/*
+	 * It is mandatory to know/calculate the allocated size of a BAR register.
+	 *
+	 * Use the approach described in
+	 * (Note: How to calculate the allocated address size for the BAR
+	 * registers) comment above to calculate the allocated_size of
+	 * the BAR register.
+	 */
+	u32 BAR0_allocated_size;
+	u32 BAR1_allocated_size;
+	u32 BAR2_allocated_size;
+	u32 BAR3_allocated_size;
+	u32 BAR4_allocated_size;
+	u32 BAR5_allocated_size;
+
+	u32 res_flags;
+	u32 BAR_offset; /* BAR address to read data from */
+
+	/*
+	 * Values the resource should have with after the call to
+	 * __pci_read_base()
+	 */
+	u32 expected_res_start;
+	u32 expected_res_end;
+
+};
+
+struct type_1_header_test_data {
+	u32 BAR0_value;
+	u32 BAR1_value;
+
+	u32 BAR0_allocated_size;
+	u32 BAR1_allocated_size;
+
+	u32 res_flags;
+	/* BAR address to read data from */
+	u32 BAR_offset;
+
+	/* Values the resource should be set up with after __pci_read_base() */
+	u32 expected_res_start;
+	u32 expected_res_end;
+
+};
+
+static void set_test_data_type_0_headers(
+		const struct type_0_header_test_data test_data, struct resource *res)
+{
+	res->start = 0;
+	res->end = 0;
+	res->flags = test_data.res_flags;
+
+	type_0_header[BAR0].value = test_data.BAR0_value;
+	type_0_header[BAR1].value = test_data.BAR1_value;
+	type_0_header[BAR2].value = test_data.BAR2_value;
+	type_0_header[BAR3].value = test_data.BAR3_value;
+	type_0_header[BAR4].value = test_data.BAR4_value;
+	type_0_header[BAR5].value = test_data.BAR5_value;
+
+	type_0_BARS_config[config_BAR0].allocated_size =
+		test_data.BAR0_allocated_size;
+
+	type_0_BARS_config[config_BAR1].allocated_size =
+		test_data.BAR1_allocated_size;
+
+	type_0_BARS_config[config_BAR2].allocated_size =
+		test_data.BAR2_allocated_size;
+
+	type_0_BARS_config[config_BAR3].allocated_size =
+		test_data.BAR3_allocated_size;
+
+	type_0_BARS_config[config_BAR4].allocated_size =
+		test_data.BAR4_allocated_size;
+
+	type_0_BARS_config[config_BAR5].allocated_size =
+		test_data.BAR5_allocated_size;
+
+	init_test_registers();
+}
+
+static void set_test_data_type_1_headers(
+	const struct type_1_header_test_data test_data, struct resource *res)
+{
+	res->start = 0;
+	res->end = 0;
+	res->flags = test_data.res_flags;
+
+	type_1_header[BAR0].value = test_data.BAR0_value;
+	type_1_header[BAR1].value = test_data.BAR1_value;
+
+	type_1_BARS_config[config_BAR0].allocated_size =
+		test_data.BAR0_allocated_size;
+
+	type_1_BARS_config[config_BAR1].allocated_size =
+		test_data.BAR1_allocated_size;
+
+	init_test_registers();
+}
+
+/*
+ * Test __pci_read_base() for type 0 header devices i.e Endpoint devices
+ *
+ * Approach 1:
+ *  Test a single value.
+ *  In this method, always make sure to init_test_registers() after setting the
+ *	header values and run clear_BAR_test_config() after the test is run.
+ *
+ * Steps for setting up the test case is:
+ *	1. Create fake PCI BUS, device and resources
+ *	2. Set the "type_header_test_case" value as PCI_HEADER_TYPE_NORMAL
+ *	3. Initialize the flags and BAR register values of the resource
+ *	4. Run the test
+ */
+static void test_pci_read_base_type_0_hdr_approach_1(struct kunit *test)
+{
+
+	/* Fake PCI devices and resources */
+	struct pci_dev *fake_pci_dev;
+	struct pci_bus *fake_pci_bus;
+	struct resource *child_dev_res;
+
+	fake_pci_dev = kunit_kzalloc(test, sizeof(*fake_pci_dev), GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, fake_pci_dev != NULL);
+
+	fake_pci_bus = kunit_kzalloc(test, sizeof(*fake_pci_bus), GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, fake_pci_bus != NULL);
+
+	child_dev_res = kunit_kzalloc(test, sizeof(*child_dev_res), GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, child_dev_res != NULL);
+
+	pci_fake_bus_init(test, fake_pci_bus, fake_pci_dev, child_dev_res);
+
+	/* Set the type of header */
+	type_header_test_case = PCI_HEADER_TYPE_NORMAL;
+
+	/* Initialize flags and BAR register values of the resource */
+	child_dev_res->flags = IORESOURCE_MEM;
+	type_0_header[BAR2].value = 0x4F400006;
+
+	/*
+	 * Initialize the allocated address size for the BAR register
+	 *
+	 * Use the approach described in
+	 * (Note: How to calculate the allocated address size for the BAR
+	 * registers) comment above to calculate the allocated_size of
+	 * the BAR register will return when all 1's are written to it.
+	 */
+	type_0_BARS_config[config_BAR2].allocated_size = 0xfffff006;
+
+	/* Initialize the config_registers with the values set in the test case */
+	init_test_registers();
+
+	__pci_read_base(fake_pci_dev, pci_bar_unknown, child_dev_res,
+		type_0_header[BAR2].offset);
+
+	KUNIT_EXPECT_EQ(test, 0x4f400000, child_dev_res->start);
+	KUNIT_EXPECT_EQ(test, 0x4f400fff, child_dev_res->end);
+	clear_BAR_test_config();
+}
+
+/*
+ * Test __pci_read_base() for type 0 header devices i.e Endpoint devices
+ *
+ *
+ * Approach 2:
+ *  Test a series of values
+ *
+ * Steps for setting up the test case is:
+ *	1. Create fake PCI BUS, device and resources
+ *	2. Set the "type_header_test_case" value as PCI_HEADER_TYPE_NORMAL
+ *	3. Initialize the flags and BAR register values of the resource
+ *	4. Run the test
+ */
+static void test_pci_read_base_type_0_hdr_approach_2(struct kunit *test)
+{
+	/*
+	 * Values to initialize the resource and the BAR registers
+	 */
+	static const struct type_0_header_test_data test_data[] = {
+		{
+			.BAR0_value = 0,
+			.BAR1_value = 0,
+			.BAR2_value = 0x4F400006,
+			.BAR3_value = 0,
+			.BAR4_value = 0,
+			.BAR5_value = 0,
+
+			/*
+			 * Initialize the allocated address size for the BAR register
+			 *
+			 * Use the approach described in
+			 * (Note: How to calculate the allocated address size for the BAR
+			 * registers) comment above to calculate the allocated_size of
+			 * the BAR register will return when all 1's are written to it.
+			 */
+			.BAR0_allocated_size = 0,
+			.BAR1_allocated_size = 0,
+			.BAR2_allocated_size = 0xFFFFF006,
+			.BAR3_allocated_size = 0,
+			.BAR4_allocated_size = 0,
+			.BAR5_allocated_size = 0,
+
+			.res_flags = IORESOURCE_MEM,
+			.BAR_offset = PCI_BASE_ADDRESS_2,
+
+			.expected_res_start = 0x4F400000,
+			.expected_res_end = 0x4F400FFF,
+		},
+		{
+			.BAR0_value = 0,
+			.BAR1_value = 0,
+			.BAR2_value = 0,
+			.BAR3_value = 0xAF400006,
+			.BAR4_value = 0,
+			.BAR5_value = 0,
+
+			.BAR0_allocated_size = 0,
+			.BAR1_allocated_size = 0,
+			.BAR2_allocated_size = 0,
+			.BAR3_allocated_size = 0xFFFFFF00,
+			.BAR4_allocated_size = 0,
+			.BAR5_allocated_size = 0,
+
+			.res_flags = IORESOURCE_MEM,
+			.BAR_offset = PCI_BASE_ADDRESS_3,
+
+			.expected_res_start = 0xAF400000,
+			.expected_res_end = 0xAF4000FF,
+		},
+	};
+
+	unsigned int i;
+
+	/* Fake PCI devices and resources */
+	struct pci_dev *fake_pci_dev;
+	struct pci_bus *fake_pci_bus;
+	struct resource *child_dev_res;
+
+	fake_pci_dev = kunit_kzalloc(test, sizeof(*fake_pci_dev), GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, fake_pci_dev != NULL);
+
+	fake_pci_bus = kunit_kzalloc(test, sizeof(*fake_pci_bus), GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, fake_pci_bus != NULL);
+
+	child_dev_res = kunit_kzalloc(test, sizeof(*child_dev_res), GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, child_dev_res != NULL);
+
+	pci_fake_bus_init(test, fake_pci_bus, fake_pci_dev, child_dev_res);
+
+	/* Set the type of header */
+	type_header_test_case = PCI_HEADER_TYPE_NORMAL;
+
+	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
+		set_test_data_type_0_headers(test_data[i], child_dev_res);
+		__pci_read_base(fake_pci_dev, pci_bar_unknown, child_dev_res,
+			test_data[i].BAR_offset);
+		KUNIT_EXPECT_EQ(test, test_data[i].expected_res_start,
+			child_dev_res->start);
+		KUNIT_EXPECT_EQ(test, test_data[i].expected_res_end,
+			child_dev_res->end);
+		clear_BAR_test_config();
+	}
+}
+
+static void test_pci_read_base_type_1_hdr(struct kunit *test)
+{
+	/*
+	 * Values to initialize the resource and the BAR registers
+	 */
+	static const struct type_1_header_test_data test_data[] = {
+		{
+			.BAR0_value = 0xAF400006,
+			.BAR1_value = 0,
+
+			/*
+			 * Initialize the allocated address size for the BAR register
+			 *
+			 * Use the approach described in
+			 * (Note: How to calculate the allocated address size for the BAR
+			 * registers) comment above to calculate the allocated_size of
+			 * the BAR register will return when all 1's are written to it.
+			 */
+			.BAR0_allocated_size =  0xFFFFFF00,
+			.BAR1_allocated_size = 0,
+
+			.res_flags = IORESOURCE_MEM,
+			.BAR_offset = PCI_BASE_ADDRESS_0,
+
+			.expected_res_start = 0xAF400000,
+			.expected_res_end = 0xAF4000FF,
+		}
+	};
+
+	unsigned int i;
+
+	/* Fake PCI devices and resources */
+	struct pci_dev *fake_pci_dev;
+	struct pci_bus *fake_pci_bus;
+	struct resource *child_dev_res;
+
+	fake_pci_dev = kunit_kzalloc(test, sizeof(*fake_pci_dev), GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, fake_pci_dev != NULL);
+
+	fake_pci_bus = kunit_kzalloc(test, sizeof(*fake_pci_bus), GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, fake_pci_bus != NULL);
+
+	child_dev_res = kunit_kzalloc(test, sizeof(*child_dev_res), GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, child_dev_res != NULL);
+
+	pci_fake_bus_init(test, fake_pci_bus, fake_pci_dev, child_dev_res);
+
+	/* Set the type of header */
+	type_header_test_case = PCI_HEADER_TYPE_BRIDGE;
+
+	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
+		set_test_data_type_1_headers(test_data[i], child_dev_res);
+		__pci_read_base(fake_pci_dev, pci_bar_unknown, child_dev_res,
+			test_data[i].BAR_offset);
+		KUNIT_EXPECT_EQ(test, test_data[i].expected_res_start,
+			child_dev_res->start);
+		KUNIT_EXPECT_EQ(test, test_data[i].expected_res_end,
+			child_dev_res->end);
+		clear_BAR_test_config();
+	}
+}
+
+static int pci_read_base_test_init(struct kunit *test)
+{
+	kunit_info(test, "initializing __pci_read_base() tests\n");
+	return 0;
+}
+
+static struct kunit_case pci_read_base_test_cases[] = {
+	KUNIT_CASE(test_pci_read_base_type_0_hdr_approach_1),
+	KUNIT_CASE(test_pci_read_base_type_0_hdr_approach_2),
+	KUNIT_CASE(test_pci_read_base_type_1_hdr),
+	{}
+};
+
+static struct kunit_suite pci_read_base_test_suite = {
+	.name = "__pci_read_base()",
+	.init = pci_read_base_test_init,
+	.test_cases = pci_read_base_test_cases,
+};
+
+kunit_test_suites(&pci_read_base_test_suite);
-- 
2.25.1

