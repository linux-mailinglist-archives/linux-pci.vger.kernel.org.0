Return-Path: <linux-pci+bounces-17806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 277099E6077
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 23:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD7E51882C5B
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 22:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C351BBBF1;
	Thu,  5 Dec 2024 22:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXter7T3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5791C3C1F
	for <linux-pci@vger.kernel.org>; Thu,  5 Dec 2024 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437434; cv=none; b=ug9NMPimxWs/ek0yNz20nmEjpB1jWrT7q2Hq3vq1nlN1LIyliE/Y0/RHOAU9eS19NlT/I0/UEJeYmPUYB1eLmm5TqNIluirok9e7w+QcNRmd4Elx3EmfUZxaV69QPolywtQp6H7626QwUbcYFxSd/nr5UPL65eiVxCQglRsq4kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437434; c=relaxed/simple;
	bh=uHecfVPaOLaRsGOP2/OK7b0aURyas04W6K7zvYixjFk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvfKQIhS8UQYhR0mTxSDstA8pPfbfngvMMjIr4GLCAXDodaX4r20Otq1JwmOeayf37tXv1rcZoscPvmBuddJK3UR7hnEELtLZzckFEyxIYO4lZ+Io0gKqrofr59CWb46BmmSeXZ30kMCwxoPAFOI4CbG1NdNUapfd3Ms75mCLqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXter7T3; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733437432; x=1764973432;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uHecfVPaOLaRsGOP2/OK7b0aURyas04W6K7zvYixjFk=;
  b=lXter7T31AZ0uu2IIRyhyDhWXSQG3XiJo56DEQy5/D914zVMquOhTMi/
   3TUmJ0M3p6FMRBshS9a29EqLoEDDvCXccHau7mNtt8TNAiN7tohgY3aXS
   UK4n0JA11eLu/hp1tBf3s/XdGk1i3B1c7YSuS0GVsXR6VqpjDoA5gJMai
   FM6p5yFfaf9bNKMsn5SoKTMKLEe21944vEJwRmsPULFDgE9dla49j8EYs
   N9qTOpd2+fyYv2iZrflo7LA7Gf9XaDToBy4ECbPBPZvS/gYIsoJ5Dgm1t
   aP/ZcXLTNxJgWHCsyf0sBgw9Zxuq2lnuzNkaHq0q8/FetjnYWascn7MPM
   Q==;
X-CSE-ConnectionGUID: JTVj1pAHRXGqh/b9cSRCgg==
X-CSE-MsgGUID: /drtfDNXRuagwCvp8Qf5ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33910437"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="33910437"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:23:52 -0800
X-CSE-ConnectionGUID: ekrwlgpTSGq2cz/wt7BpFg==
X-CSE-MsgGUID: hCKqd+lHTeKfwdeBZI4RiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="99050136"
Received: from kcaccard-desk.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.108.178])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:23:51 -0800
Subject: [PATCH 06/11] samples/devsec: PCI device-security bus / endpoint
 sample
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>,
 Xu Yilun <yilun.xu@linux.intel.com>, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org
Date: Thu, 05 Dec 2024 14:23:51 -0800
Message-ID: <173343743095.1074769.17985181033044298157.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Establish just enough emulated PCI infrastructure to register a sample
TSM (platform security manager) driver and have it discover an IDE + TEE
(link encryption + device-interface security protocol (TDISP)) capable
device.

Use the existing a CONFIG_PCI_BRIDGE_EMUL to emulate an IDE capable root
port, and open code the emulation of an endpoint device via simulated
configuration cycle responses.

The devsec_tsm driver responds to the PCI core TSM operations as if it
successfully exercised the given interface security protocol message.

The devsec_bus and devsec_tsm drivers can be loaded in either order to
reflect cases like SEV-TIO where the TSM is PCI-device firmware, and
cases like TDX Connect where the TSM is a software agent running on the
host CPU.

Follow-on patches add common code for TSM managed IDE establishment. For
now, just successfully complete setup and teardown of the DSM (device
security manager) context as a building block for management of TDI
(trusted device interface) instances.

 # modprobe devsec_bus
    devsec_bus devsec_bus: PCI host bridge to bus 10000:00
    pci_bus 10000:00: root bus resource [bus 00-01]
    pci_bus 10000:00: root bus resource [mem 0xf000000000-0xffffffffff 64bit]
    pci 10000:00:00.0: [8086:7075] type 01 class 0x060400 PCIe Root Port
    pci 10000:00:00.0: PCI bridge to [bus 00]
    pci 10000:00:00.0:   bridge window [io  0x0000-0x0fff]
    pci 10000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
    pci 10000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
    pci 10000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
    pci 10000:01:00.0: [8086:ffff] type 00 class 0x000000 PCIe Endpoint
    pci 10000:01:00.0: BAR 0 [mem 0xf000000000-0xf0001fffff 64bit pref]
    pci_doe_abort: pci 10000:01:00.0: DOE: [100] Issuing Abort
    pci_doe_cache_protocols: pci 10000:01:00.0: DOE: [100] Found protocol 0 vid: 1 prot: 1
    pci 10000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
    pci 10000:00:00.0: PCI bridge to [bus 01]
    pci_bus 10000:01: busn_res: [bus 01] end is updated to 01
 # modprobe devsec_tsm
    devsec_tsm_pci_probe: pci 10000:01:00.0: devsec: tsm enabled
    __pci_tsm_init: pci 10000:01:00.0: TSM: Device security capabilities detected ( ide tee ), TSM attach

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 MAINTAINERS             |    1 
 samples/Kconfig         |   15 +
 samples/Makefile        |    1 
 samples/devsec/Makefile |   10 +
 samples/devsec/bus.c    |  695 +++++++++++++++++++++++++++++++++++++++++++++++
 samples/devsec/common.c |   26 ++
 samples/devsec/devsec.h |    7 
 samples/devsec/tsm.c    |  113 ++++++++
 8 files changed, 868 insertions(+)
 create mode 100644 samples/devsec/Makefile
 create mode 100644 samples/devsec/bus.c
 create mode 100644 samples/devsec/common.c
 create mode 100644 samples/devsec/devsec.h
 create mode 100644 samples/devsec/tsm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f28a2d9bbc6..9dba89d42af6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23848,6 +23848,7 @@ F:	drivers/virt/coco/guest/
 F:	drivers/virt/coco/host/
 F:	include/linux/pci-tsm.h
 F:	include/linux/tsm.h
+F:	samples/devsec/
 
 TRUSTED SERVICES TEE DRIVER
 M:	Balint Dobszay <balint.dobszay@arm.com>
diff --git a/samples/Kconfig b/samples/Kconfig
index b288d9991d27..9581757bfa67 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -293,6 +293,21 @@ config SAMPLE_CGROUP
 
 source "samples/rust/Kconfig"
 
+config SAMPLE_DEVSEC
+	tristate "Build a sample TEE Security Manager with an emulated PCI endpoint"
+	depends on PCI
+	depends on X86 # missing PCI_DOMAINS_GENERIC support
+	select PCI_BRIDGE_EMUL
+	select PCI_TSM
+	select TSM
+	help
+	  Build a sample platform TEE Security Manager (TSM) driver with a
+	  corresponding emulated PCIe topology. The resulting sample modules,
+	  devsec_bus and devsec_tsm, exercise device-security enumeration, PCI
+	  subsystem use ABIs, device security flows. For example, exercise IDE
+	  (link encryption) establishment and TDISP state transitions via a
+	  Device Security Manager (DSM).
+
 endif # SAMPLES
 
 config HAVE_SAMPLE_FTRACE_DIRECT
diff --git a/samples/Makefile b/samples/Makefile
index b85fa64390c5..da1829049249 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -39,3 +39,4 @@ obj-$(CONFIG_SAMPLE_KMEMLEAK)		+= kmemleak/
 obj-$(CONFIG_SAMPLE_CORESIGHT_SYSCFG)	+= coresight/
 obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
 obj-$(CONFIG_SAMPLES_RUST)		+= rust/
+obj-y					+= devsec/
diff --git a/samples/devsec/Makefile b/samples/devsec/Makefile
new file mode 100644
index 000000000000..c8cb5c0cceb8
--- /dev/null
+++ b/samples/devsec/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SAMPLE_DEVSEC) += devsec_common.o
+devsec_common-y := common.o
+
+obj-$(CONFIG_SAMPLE_DEVSEC) += devsec_bus.o
+devsec_bus-y := bus.o
+
+obj-$(CONFIG_SAMPLE_DEVSEC) += devsec_tsm.o
+devsec_tsm-y := tsm.o
diff --git a/samples/devsec/bus.c b/samples/devsec/bus.c
new file mode 100644
index 000000000000..47dbe4e1b648
--- /dev/null
+++ b/samples/devsec/bus.c
@@ -0,0 +1,695 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2024 Intel Corporation. All rights reserved.
+
+#include <linux/platform_device.h>
+#include <linux/genalloc.h>
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/module.h>
+#include <linux/range.h>
+#include <uapi/linux/pci_regs.h>
+#include <linux/pci.h>
+
+#include "../../drivers/pci/pci-bridge-emul.h"
+#include "devsec.h"
+
+#define NR_DEVSEC_BUSES 1
+#define NR_DEVSEC_ROOT_PORTS 1
+#define NR_STREAMS 1
+#define NR_ADDR_ASSOC 1
+#define NR_DEVSEC_DEVS 1
+
+struct devsec {
+	struct pci_sysdata sysdata;
+	struct gen_pool *iomem_pool;
+	struct resource resource[2];
+	struct pci_bus *bus;
+	struct device *dev;
+	struct devsec_port {
+		union {
+			struct devsec_ide {
+				u32 cap;
+				u32 ctl;
+				struct devsec_stream {
+					u32 cap;
+					u32 ctl;
+					u32 status;
+					u32 rid1;
+					u32 rid2;
+					struct devsec_addr_assoc {
+						u32 assoc1;
+						u32 assoc2;
+						u32 assoc3;
+					} assoc[NR_ADDR_ASSOC];
+				} stream[NR_STREAMS];
+			} ide __packed;
+			char ide_regs[sizeof(struct devsec_ide)];
+		};
+		struct pci_bridge_emul bridge;
+	} *devsec_ports[NR_DEVSEC_ROOT_PORTS];
+	struct devsec_dev {
+		struct range mmio_range;
+		u8 __cfg[SZ_4K];
+		struct devsec_dev_doe {
+			int cap;
+			u32 req[SZ_4K / sizeof(u32)];
+			u32 rsp[SZ_4K / sizeof(u32)];
+			int write, read, read_ttl;
+		} doe;
+		u16 ide_pos;
+		union {
+			struct devsec_ide ide __packed;
+			char ide_regs[sizeof(struct devsec_ide)];
+		};
+	} *devsec_devs[NR_DEVSEC_DEVS];
+};
+
+#define devsec_base(x) ((void __force __iomem *) &(x)->__cfg[0])
+
+static struct devsec *bus_to_devsec(struct pci_bus *bus)
+{
+	return container_of(bus->sysdata, struct devsec, sysdata);
+}
+
+static int devsec_dev_config_read(struct devsec *devsec, struct pci_bus *bus,
+				  unsigned int devfn, int pos, int size,
+				  u32 *val)
+{
+	struct devsec_dev *devsec_dev;
+	struct devsec_dev_doe *doe;
+	void __iomem *base;
+
+	if (PCI_FUNC(devfn) != 0 ||
+	    PCI_SLOT(devfn) >= ARRAY_SIZE(devsec->devsec_devs))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	devsec_dev = devsec->devsec_devs[PCI_SLOT(devfn)];
+	base = devsec_base(devsec_dev);
+	doe = &devsec_dev->doe;
+
+	if (pos == doe->cap + PCI_DOE_READ) {
+		if (doe->read_ttl > 0) {
+			*val = doe->rsp[doe->read];
+			dev_dbg(&bus->dev, "devfn: %#x doe read[%d]\n", devfn,
+				doe->read);
+		} else {
+			*val = 0;
+			dev_dbg(&bus->dev, "devfn: %#x doe no data\n", devfn);
+		}
+		return PCIBIOS_SUCCESSFUL;
+	} else if (pos == doe->cap + PCI_DOE_STATUS) {
+		if (doe->read_ttl > 0) {
+			*val = PCI_DOE_STATUS_DATA_OBJECT_READY;
+			dev_dbg(&bus->dev, "devfn: %#x object ready\n", devfn);
+		} else if (doe->read_ttl < 0) {
+			*val = PCI_DOE_STATUS_ERROR;
+			dev_dbg(&bus->dev, "devfn: %#x error\n", devfn);
+		} else {
+			*val = 0;
+			dev_dbg(&bus->dev, "devfn: %#x idle\n", devfn);
+		}
+		return PCIBIOS_SUCCESSFUL;
+	} else if (pos >= devsec_dev->ide_pos &&
+		   pos < devsec_dev->ide_pos + sizeof(struct devsec_ide)) {
+		*val = *(u32 *) &devsec_dev->ide_regs[pos - devsec_dev->ide_pos];
+		return PCIBIOS_SUCCESSFUL;
+	}
+
+	switch (size) {
+	case 1:
+		*val = readb(base + pos);
+		break;
+	case 2:
+		*val = readw(base + pos);
+		break;
+	case 4:
+		*val = readl(base + pos);
+		break;
+	default:
+		PCI_SET_ERROR_RESPONSE(val);
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int devsec_port_config_read(struct devsec *devsec, unsigned int devfn,
+				   int pos, int size, u32 *val)
+{
+	struct devsec_port *devsec_port;
+
+	if (PCI_FUNC(devfn) != 0 ||
+	    PCI_SLOT(devfn) >= ARRAY_SIZE(devsec->devsec_ports))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	devsec_port = devsec->devsec_ports[PCI_SLOT(devfn)];
+	return pci_bridge_emul_conf_read(&devsec_port->bridge, pos, size, val);
+}
+
+static int devsec_pci_read(struct pci_bus *bus, unsigned int devfn, int pos,
+			   int size, u32 *val)
+{
+	struct devsec *devsec = bus_to_devsec(bus);
+
+	dev_vdbg(&bus->dev, "devfn: %#x pos: %#x size: %d\n", devfn, pos, size);
+
+	if (bus == devsec->bus)
+		return devsec_port_config_read(devsec, devfn, pos, size, val);
+	else if (bus->parent == devsec->bus)
+		return devsec_dev_config_read(devsec, bus, devfn, pos, size,
+					      val);
+
+	return PCIBIOS_DEVICE_NOT_FOUND;
+}
+
+#ifndef PCI_DOE_PROTOCOL_DISCOVERY
+#define PCI_DOE_PROTOCOL_DISCOVERY 0
+#define PCI_DOE_FEATURE_CMA 1
+#endif
+
+/* just indicate support for CMA */
+static void doe_process(struct devsec_dev_doe *doe)
+{
+	u8 type, index;
+	u16 vid;
+
+	vid = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, doe->req[0]);
+	type = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, doe->req[0]);
+
+	if (vid != PCI_VENDOR_ID_PCI_SIG) {
+		doe->read_ttl = -1;
+		return;
+	}
+
+	if (type != PCI_DOE_PROTOCOL_DISCOVERY) {
+		doe->read_ttl = -1;
+		return;
+	}
+
+	index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX, doe->req[2]);
+
+	doe->rsp[0] = doe->req[0];
+	doe->rsp[1] = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, 3);
+	doe->read_ttl = 3;
+	doe->rsp[2] = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID,
+				 PCI_VENDOR_ID_PCI_SIG) |
+		      FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
+				 PCI_DOE_FEATURE_CMA) |
+		      FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX, 0);
+}
+
+static int devsec_dev_config_write(struct devsec *devsec, struct pci_bus *bus,
+				   unsigned int devfn, int pos, int size,
+				   u32 val)
+{
+	struct devsec_dev *devsec_dev;
+	struct devsec_dev_doe *doe;
+	void __iomem *base;
+
+	dev_vdbg(&bus->dev, "devfn: %#x pos: %#x size: %d\n", devfn, pos, size);
+
+	if (PCI_FUNC(devfn) != 0 ||
+	    PCI_SLOT(devfn) >= ARRAY_SIZE(devsec->devsec_devs))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	devsec_dev = devsec->devsec_devs[PCI_SLOT(devfn)];
+	base = devsec_base(devsec_dev);
+	doe = &devsec_dev->doe;
+
+	if (pos >= PCI_BASE_ADDRESS_0 && pos <= PCI_BASE_ADDRESS_5) {
+		if (size != 4)
+			return PCIBIOS_BAD_REGISTER_NUMBER;
+		/* only one 64-bit mmio bar emulated for now */
+		if (pos == PCI_BASE_ADDRESS_0)
+			val &= ~lower_32_bits(range_len(&devsec_dev->mmio_range) - 1);
+		else if (pos == PCI_BASE_ADDRESS_1)
+			val &= ~upper_32_bits(range_len(&devsec_dev->mmio_range) - 1);
+		else
+			val = 0;
+	} else if (pos == PCI_ROM_ADDRESS) {
+		val = 0;
+	} else if (pos == doe->cap + PCI_DOE_CTRL) {
+		if (val & PCI_DOE_CTRL_GO) {
+			dev_dbg(&bus->dev, "devfn: %#x doe go\n", devfn);
+			doe_process(doe);
+		}
+		if (val & PCI_DOE_CTRL_ABORT) {
+			dev_dbg(&bus->dev, "devfn: %#x doe abort\n", devfn);
+			doe->write = 0;
+			doe->read = 0;
+			doe->read_ttl = 0;
+		}
+		return PCIBIOS_SUCCESSFUL;
+	} else if (pos == doe->cap + PCI_DOE_WRITE) {
+		if (doe->write < ARRAY_SIZE(doe->req))
+			doe->req[doe->write++] = val;
+		dev_dbg(&bus->dev, "devfn: %#x doe write[%d]\n", devfn,
+			doe->write - 1);
+		return PCIBIOS_SUCCESSFUL;
+	} else if (pos == doe->cap + PCI_DOE_READ) {
+		if (doe->read_ttl > 0) {
+			doe->read_ttl--;
+			doe->read++;
+			dev_dbg(&bus->dev, "devfn: %#x doe ack[%d]\n", devfn,
+				doe->read - 1);
+		}
+		return PCIBIOS_SUCCESSFUL;
+	}
+
+	switch (size) {
+	case 1:
+		writeb(val, base + pos);
+		break;
+	case 2:
+		writew(val, base + pos);
+		break;
+	case 4:
+		writel(val, base + pos);
+		break;
+	default:
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int devsec_port_config_write(struct devsec *devsec, struct pci_bus *bus,
+				    unsigned int devfn, int pos, int size,
+				    u32 val)
+{
+	struct devsec_port *devsec_port;
+
+	dev_vdbg(&bus->dev, "devfn: %#x pos: %#x size: %d\n", devfn, pos, size);
+
+	if (PCI_FUNC(devfn) != 0 ||
+	    PCI_SLOT(devfn) >= ARRAY_SIZE(devsec->devsec_ports))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	devsec_port = devsec->devsec_ports[PCI_SLOT(devfn)];
+	return pci_bridge_emul_conf_write(&devsec_port->bridge, pos, size, val);
+}
+
+static int devsec_pci_write(struct pci_bus *bus, unsigned int devfn, int pos,
+			    int size, u32 val)
+{
+	struct devsec *devsec = bus_to_devsec(bus);
+
+	dev_vdbg(&bus->dev, "devfn: %#x pos: %#x size: %d\n", devfn, pos, size);
+
+	if (bus == devsec->bus)
+		return devsec_port_config_write(devsec, bus, devfn, pos, size,
+						val);
+	else if (bus->parent == devsec->bus)
+		return devsec_dev_config_write(devsec, bus, devfn, pos, size,
+					       val);
+	return PCIBIOS_DEVICE_NOT_FOUND;
+}
+
+static struct pci_ops devsec_ops = {
+	.read = devsec_pci_read,
+	.write = devsec_pci_write,
+};
+
+/* borrowed from vmd_find_free_domain() */
+static int find_free_domain(void)
+{
+	int domain = 0xffff;
+	struct pci_bus *bus = NULL;
+
+	while ((bus = pci_find_next_bus(bus)) != NULL)
+		domain = max_t(int, domain, pci_domain_nr(bus));
+	return domain + 1;
+}
+
+static void destroy_iomem_pool(void *data)
+{
+	struct devsec *devsec = data;
+
+	gen_pool_destroy(devsec->iomem_pool);
+}
+
+static void destroy_bus(void *data)
+{
+	struct devsec *devsec = data;
+
+	pci_stop_root_bus(devsec->bus);
+	pci_remove_root_bus(devsec->bus);
+}
+
+static void destroy_devs(void *data)
+{
+	struct devsec *devsec = data;
+	int i;
+
+	for (i = ARRAY_SIZE(devsec->devsec_devs) - 1; i >= 0; i--) {
+		struct devsec_dev *devsec_dev = devsec->devsec_devs[i];
+
+		if (!devsec_dev)
+			continue;
+		gen_pool_free(devsec->iomem_pool, devsec_dev->mmio_range.start,
+			      range_len(&devsec_dev->mmio_range));
+		kfree(devsec_dev);
+		devsec->devsec_devs[i] = NULL;
+	}
+}
+
+static unsigned build_ext_cap_header(u32 id, u32 ver, u32 next)
+{
+	return FIELD_PREP(GENMASK(15, 0), id) |
+	       FIELD_PREP(GENMASK(19, 16), ver) |
+	       FIELD_PREP(GENMASK(31, 20), next);
+}
+
+static void init_ide(struct devsec_ide *ide)
+{
+	ide->cap = PCI_IDE_CAP_SELECTIVE | PCI_IDE_CAP_IDE_KM |
+		   PCI_IDE_CAP_TEE_LIMITED |
+		   FIELD_PREP(PCI_IDE_CAP_SELECTIVE_STREAMS_MASK, NR_STREAMS);
+
+	for (int i = 0; i < NR_STREAMS; i++)
+		ide->stream[i].cap =
+			FIELD_PREP(PCI_IDE_SEL_CAP_ASSOC_MASK, NR_ADDR_ASSOC);
+}
+
+static void init_dev_cfg(struct devsec_dev *devsec_dev)
+{
+	void __iomem *base = devsec_base(devsec_dev), *cap_base;
+	int pos, next;
+
+	/* BAR space */
+	writew(0x8086, base + PCI_VENDOR_ID);
+	writew(0xffff, base + PCI_DEVICE_ID);
+	writel(lower_32_bits(devsec_dev->mmio_range.start) |
+		       PCI_BASE_ADDRESS_MEM_TYPE_64 |
+		       PCI_BASE_ADDRESS_MEM_PREFETCH,
+	       base + PCI_BASE_ADDRESS_0);
+	writel(upper_32_bits(devsec_dev->mmio_range.start),
+	       base + PCI_BASE_ADDRESS_1);
+
+	/* Capability init */
+	writeb(PCI_HEADER_TYPE_NORMAL, base + PCI_HEADER_TYPE);
+	writew(PCI_STATUS_CAP_LIST, base + PCI_STATUS);
+	pos = 0x40;
+	writew(pos, base + PCI_CAPABILITY_LIST);
+
+	/* PCI-E Capability */
+	cap_base = base + pos;
+	writeb(PCI_CAP_ID_EXP, cap_base);
+	writew(PCI_EXP_TYPE_ENDPOINT, cap_base + PCI_EXP_FLAGS);
+	writew(PCI_EXP_LNKSTA_CLS_2_5GB | PCI_EXP_LNKSTA_NLW_X1, cap_base + PCI_EXP_LNKSTA);
+	writel(PCI_EXP_DEVCAP_FLR | PCI_EXP_DEVCAP_TEE, cap_base + PCI_EXP_DEVCAP);
+
+	/* DOE Extended Capability */
+	pos = PCI_CFG_SPACE_SIZE;
+	next = pos + PCI_DOE_CAP_SIZEOF;
+	cap_base = base + pos;
+	devsec_dev->doe.cap = pos;
+	writel(build_ext_cap_header(PCI_EXT_CAP_ID_DOE, 2, next), cap_base);
+
+	/* IDE Extended Capability */
+	pos = next;
+	cap_base = base + pos;
+	writel(build_ext_cap_header(PCI_EXT_CAP_ID_IDE, 1, 0), cap_base);
+	devsec_dev->ide_pos = pos + 4;
+	init_ide(&devsec_dev->ide);
+}
+
+#define MMIO_SIZE SZ_2M
+
+static int alloc_devs(struct devsec *devsec)
+{
+	struct device *dev = devsec->dev;
+	int i, rc;
+
+	rc = devm_add_action_or_reset(dev, destroy_devs, devsec);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < ARRAY_SIZE(devsec->devsec_devs); i++) {
+		struct devsec_dev *devsec_dev __free(kfree) =
+			kzalloc(sizeof(*devsec_dev), GFP_KERNEL);
+		struct genpool_data_align data = {
+			.align = MMIO_SIZE,
+		};
+		u64 phys;
+
+		if (!devsec_dev)
+			return -ENOMEM;
+
+		phys = gen_pool_alloc_algo(devsec->iomem_pool, MMIO_SIZE,
+					   gen_pool_first_fit_align, &data);
+		if (!phys)
+			return -ENOMEM;
+
+		devsec_dev->mmio_range = (struct range) {
+			.start = phys,
+			.end = phys + MMIO_SIZE - 1,
+		};
+		init_dev_cfg(devsec_dev);
+		devsec->devsec_devs[i] = no_free_ptr(devsec_dev);
+	}
+
+	return 0;
+}
+
+static void destroy_ports(void *data)
+{
+	struct devsec *devsec = data;
+	int i;
+
+	for (i = ARRAY_SIZE(devsec->devsec_ports) - 1; i >= 0; i--) {
+		struct devsec_port *devsec_port = devsec->devsec_ports[i];
+
+		if (!devsec_port)
+			continue;
+		pci_bridge_emul_cleanup(&devsec_port->bridge);
+		kfree(devsec_port);
+		devsec->devsec_ports[i] = NULL;
+	}
+}
+
+static pci_bridge_emul_read_status_t
+devsec_bridge_read_base(struct pci_bridge_emul *bridge, int pos, u32 *val)
+{
+	return PCI_BRIDGE_EMUL_NOT_HANDLED;
+}
+
+static pci_bridge_emul_read_status_t
+devsec_bridge_read_pcie(struct pci_bridge_emul *bridge, int pos, u32 *val)
+{
+	return PCI_BRIDGE_EMUL_NOT_HANDLED;
+}
+
+static pci_bridge_emul_read_status_t
+devsec_bridge_read_ext(struct pci_bridge_emul *bridge, int pos, u32 *val)
+{
+	struct devsec_port *devsec_port = bridge->data;
+
+	/* only one extended capability, IDE... */
+	if (pos == 0) {
+		*val = build_ext_cap_header(PCI_EXT_CAP_ID_IDE, 1, 0);
+		return PCI_BRIDGE_EMUL_HANDLED;
+	}
+
+	if (pos < 4)
+		return PCI_BRIDGE_EMUL_NOT_HANDLED;
+
+	pos -= 4;
+	if (pos < sizeof(struct devsec_ide)) {
+		*val = *(u32 *)(&devsec_port->ide_regs[pos]);
+		return PCI_BRIDGE_EMUL_HANDLED;
+	}
+
+	return PCI_BRIDGE_EMUL_NOT_HANDLED;
+}
+
+static void devsec_bridge_write_base(struct pci_bridge_emul *bridge, int pos,
+				     u32 old, u32 new, u32 mask)
+{
+}
+
+static void devsec_bridge_write_pcie(struct pci_bridge_emul *bridge, int pos,
+				     u32 old, u32 new, u32 mask)
+{
+}
+
+static void devsec_bridge_write_ext(struct pci_bridge_emul *bridge, int pos,
+				    u32 old, u32 new, u32 mask)
+{
+	struct devsec_port *devsec_port = bridge->data;
+
+	if (pos < sizeof(struct devsec_ide))
+		*(u32 *)(&devsec_port->ide_regs[pos]) = new;
+}
+
+static const struct pci_bridge_emul_ops devsec_bridge_ops = {
+	.read_base = devsec_bridge_read_base,
+	.write_base = devsec_bridge_write_base,
+	.read_pcie = devsec_bridge_read_pcie,
+	.write_pcie = devsec_bridge_write_pcie,
+	.read_ext = devsec_bridge_read_ext,
+	.write_ext = devsec_bridge_write_ext,
+};
+
+static int init_port(struct devsec_port *devsec_port)
+{
+	struct pci_bridge_emul *bridge = &devsec_port->bridge;
+	int rc;
+
+	bridge->conf.vendor = cpu_to_le16(0x8086);
+	bridge->conf.device = cpu_to_le16(0x7075);
+	bridge->subsystem_vendor_id = cpu_to_le16(0x8086);
+	bridge->conf.class_revision = cpu_to_le32(0x1);
+
+	bridge->conf.pref_mem_base = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);
+	bridge->conf.pref_mem_limit = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);
+
+	bridge->has_pcie = true;
+	bridge->pcie_conf.devcap = cpu_to_le16(PCI_EXP_DEVCAP_FLR);
+	bridge->pcie_conf.lnksta = cpu_to_le16(PCI_EXP_LNKSTA_CLS_2_5GB);
+
+	bridge->data = devsec_port;
+	bridge->ops = &devsec_bridge_ops;
+
+	init_ide(&devsec_port->ide);
+
+	rc = pci_bridge_emul_init(bridge, 0);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int alloc_ports(struct devsec *devsec)
+{
+	struct device *dev = devsec->dev;
+	int i, rc;
+
+	rc = devm_add_action_or_reset(dev, destroy_ports, devsec);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < ARRAY_SIZE(devsec->devsec_ports); i++) {
+		struct devsec_port *devsec_port __free(kfree) =
+			kzalloc(sizeof(*devsec_port), GFP_KERNEL);
+
+		if (!devsec_port)
+			return -ENOMEM;
+
+		rc = init_port(devsec_port);
+		if (rc)
+			return rc;
+		devsec->devsec_ports[i] = no_free_ptr(devsec_port);
+	}
+
+	return 0;
+}
+
+static int __init devsec_bus_probe(struct platform_device *pdev)
+{
+	int rc;
+	LIST_HEAD(resources);
+	struct devsec *devsec;
+	struct pci_sysdata *sd;
+	u64 mmio_size = SZ_64G;
+	struct device *dev = &pdev->dev;
+	u64 mmio_start = iomem_resource.end + 1 - SZ_64G;
+
+	devsec = devm_kzalloc(dev, sizeof(*devsec), GFP_KERNEL);
+	if (!devsec)
+		return -ENOMEM;
+
+	devsec->dev = dev;
+	devsec->iomem_pool = gen_pool_create(ilog2(SZ_2M), NUMA_NO_NODE);
+	if (!devsec->iomem_pool)
+		return -ENOMEM;
+
+	rc = devm_add_action_or_reset(dev, destroy_iomem_pool, devsec);
+	if (rc)
+		return rc;
+
+	rc = gen_pool_add(devsec->iomem_pool, mmio_start, mmio_size,
+			  NUMA_NO_NODE);
+	if (rc)
+		return rc;
+
+	devsec->resource[0] = (struct resource) {
+		.name = "DEVSEC BUSES",
+		.start = 0,
+		.end = NR_DEVSEC_BUSES + NR_DEVSEC_ROOT_PORTS - 1,
+		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
+	};
+	pci_add_resource(&resources, &devsec->resource[0]);
+
+	devsec->resource[1] = (struct resource) {
+		.name = "DEVSEC MMIO",
+		.start = mmio_start,
+		.end = mmio_start + mmio_size - 1,
+		.flags = IORESOURCE_MEM | IORESOURCE_MEM_64,
+	};
+	pci_add_resource(&resources, &devsec->resource[1]);
+
+	sd = &devsec->sysdata;
+	devsec_sysdata = sd;
+	sd->domain = find_free_domain();
+	if (sd->domain < 0)
+		return sd->domain;
+
+	devsec->bus = pci_create_root_bus(dev, 0, &devsec_ops,
+					  &devsec->sysdata, &resources);
+	if (!devsec->bus) {
+		pci_free_resource_list(&resources);
+		return -ENOMEM;
+	}
+
+	rc = devm_add_action_or_reset(dev, destroy_bus, devsec);
+	if (rc)
+		return rc;
+
+	rc = alloc_ports(devsec);
+	if (rc)
+		return rc;
+
+	rc = alloc_devs(devsec);
+	if (rc)
+		return rc;
+
+	pci_scan_child_bus(devsec->bus);
+
+	return 0;
+}
+
+static struct platform_driver devsec_bus_driver = {
+	.driver = {
+		.name = "devsec_bus",
+	},
+};
+
+static struct platform_device *devsec_bus;
+
+static int __init devsec_bus_init(void)
+{
+	struct platform_device_info devsec_bus_info = {
+		.name = "devsec_bus",
+		.id = -1,
+	};
+	int rc;
+
+	devsec_bus = platform_device_register_full(&devsec_bus_info);
+	if (IS_ERR(devsec_bus))
+		return PTR_ERR(devsec_bus);
+
+	rc = platform_driver_probe(&devsec_bus_driver, devsec_bus_probe);
+	if (rc)
+		platform_device_unregister(devsec_bus);
+	return 0;
+}
+module_init(devsec_bus_init);
+
+static void __exit devsec_bus_exit(void)
+{
+	platform_driver_unregister(&devsec_bus_driver);
+	platform_device_unregister(devsec_bus);
+}
+module_exit(devsec_bus_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Device Security Sample Infrastructure: TDISP Device Emulation");
diff --git a/samples/devsec/common.c b/samples/devsec/common.c
new file mode 100644
index 000000000000..9b6f4022f241
--- /dev/null
+++ b/samples/devsec/common.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2024 Intel Corporation. All rights reserved.
+
+#include <linux/pci.h>
+#include <linux/export.h>
+
+/*
+ * devsec_bus and devsec_tsm need a common location for this data to
+ * avoid depending on each other. Enables load order testing
+ */
+struct pci_sysdata *devsec_sysdata;
+EXPORT_SYMBOL_GPL(devsec_sysdata);
+
+static int __init common_init(void)
+{
+	return 0;
+}
+module_init(common_init);
+
+static void __exit common_exit(void)
+{
+}
+module_exit(common_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Device Security Sample Infrastructure: Shared data");
diff --git a/samples/devsec/devsec.h b/samples/devsec/devsec.h
new file mode 100644
index 000000000000..794a9898ee2d
--- /dev/null
+++ b/samples/devsec/devsec.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+// Copyright(c) 2024 Intel Corporation. All rights reserved.
+
+#ifndef __DEVSEC_H__
+#define __DEVSEC_H__
+extern struct pci_sysdata *devsec_sysdata;
+#endif /* __DEVSEC_H__ */
diff --git a/samples/devsec/tsm.c b/samples/devsec/tsm.c
new file mode 100644
index 000000000000..d446ab8879d8
--- /dev/null
+++ b/samples/devsec/tsm.c
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+// Copyright(c) 2024 Intel Corporation. All rights reserved.
+
+#define dev_fmt(fmt) "devsec: " fmt
+#include <linux/platform_device.h>
+#include <linux/pci-tsm.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/tsm.h>
+#include "devsec.h"
+
+struct devsec_dsm {
+	struct pci_dsm pci;
+};
+
+static struct devsec_dsm *to_devsec_dsm(struct pci_dsm *dsm)
+{
+	return container_of(dsm, struct devsec_dsm, pci);
+}
+
+static struct pci_dsm *devsec_tsm_pci_probe(struct pci_dev *pdev)
+{
+	struct devsec_dsm *devsec_dsm;
+
+	if (pdev->sysdata != devsec_sysdata)
+		return NULL;
+
+	devsec_dsm = kzalloc(sizeof(*devsec_dsm), GFP_KERNEL);
+	if (!devsec_dsm)
+		return NULL;
+
+	devsec_dsm->pci.pdev = pdev;
+	pci_dbg(pdev, "tsm enabled\n");
+	return &devsec_dsm->pci;
+}
+
+static void devsec_tsm_pci_remove(struct pci_dsm *dsm)
+{
+	struct devsec_dsm *devsec_dsm = to_devsec_dsm(dsm);
+
+	pci_dbg(dsm->pdev, "tsm disabled\n");
+	kfree(devsec_dsm);
+}
+
+static int devsec_tsm_connect(struct pci_dev *pdev)
+{
+	return -ENXIO;
+}
+
+static void devsec_tsm_disconnect(struct pci_dev *pdev)
+{
+}
+
+static const struct pci_tsm_ops devsec_pci_ops = {
+	.probe = devsec_tsm_pci_probe,
+	.remove = devsec_tsm_pci_remove,
+	.connect = devsec_tsm_connect,
+	.disconnect = devsec_tsm_disconnect,
+};
+
+static void devsec_tsm_remove(void *tsm)
+{
+	tsm_unregister(tsm);
+}
+
+static int devsec_tsm_probe(struct platform_device *pdev)
+{
+	struct tsm_subsys *tsm;
+
+	tsm = tsm_register(&pdev->dev, NULL, &devsec_pci_ops);
+	if (IS_ERR(tsm))
+		return PTR_ERR(tsm);
+
+	return devm_add_action_or_reset(&pdev->dev, devsec_tsm_remove,
+					tsm);
+}
+
+static struct platform_driver devsec_tsm_driver = {
+	.driver = {
+		.name = "devsec_tsm",
+	},
+};
+
+static struct platform_device *devsec_tsm;
+
+static int __init devsec_tsm_init(void)
+{
+	struct platform_device_info devsec_tsm_info = {
+		.name = "devsec_tsm",
+		.id = -1,
+	};
+	int rc;
+
+	devsec_tsm = platform_device_register_full(&devsec_tsm_info);
+	if (IS_ERR(devsec_tsm))
+		return PTR_ERR(devsec_tsm);
+
+	rc = platform_driver_probe(&devsec_tsm_driver, devsec_tsm_probe);
+	if (rc)
+		platform_device_unregister(devsec_tsm);
+	return rc;
+}
+module_init(devsec_tsm_init);
+
+static void __exit devsec_tsm_exit(void)
+{
+	platform_driver_unregister(&devsec_tsm_driver);
+	platform_device_unregister(devsec_tsm);
+}
+module_exit(devsec_tsm_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Device Security Sample Infrastructure: Platform TSM Driver");


