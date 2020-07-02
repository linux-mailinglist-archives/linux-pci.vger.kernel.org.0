Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97569212AE3
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jul 2020 19:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgGBRJK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jul 2020 13:09:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:38715 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbgGBRJG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Jul 2020 13:09:06 -0400
IronPort-SDR: OfKnZNaWo9tZSYDQg5in4ZquJdXkki+OrYTE+SKy7ydZEgatmeqUUIwzmNziuL4Mp9NqLqUh/z
 rq3X9jZwI8NA==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="126587531"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="126587531"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 10:09:04 -0700
IronPort-SDR: R7toJ6iixRG/vnqiwrARIfQmWZWXdZ2wKYD6q2pcNGwZAod+Z+m96OadxJPjGWTRDblXw3IdfS
 2GiWo2SXTEBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="481763254"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jul 2020 10:09:04 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, bhelgaas@google.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     jeffrey.t.kirsher@intel.com, olof@lixom.net,
        dan.j.williams@intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 7/7] perf/x86/intel/uncore: Support PCIe3 unit on Snow Ridge
Date:   Thu,  2 Jul 2020 10:05:17 -0700
Message-Id: <1593709517-108857-8-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593709517-108857-1-git-send-email-kan.liang@linux.intel.com>
References: <1593709517-108857-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The Snow Ridge integrated PCIe3 uncore unit can be used to collect
performance data, e.g. utilization, between PCIe devices, plugged into
the PCIe port, and the components (in M2IOSF) responsible for
translating and managing requests to/from the device. The performance
data is very useful for analyzing the performance of PCIe devices.

The portdrv_pci driver creates a platform device,
"perf_uncore_pcieport", for PCIe3 uncore PMON unit. The uncore driver
probes the platform device, instead of device ID.

Here are some difference between PCIe3 uncore unit and other uncore
pci units.
- There may be several Root Ports on a system. But the uncore counters
  only exist in the Root Port A. A user can configure the channel mask
  to collect the data from other Root Ports.
- The event format of the PCIe3 uncore unit is the same as IIO unit of
  SKX.
- The Control Register of PCIe3 uncore unit is 64 bits.
- The offset of each counters is 8, which is the same as M2M unit of SNR.
- New MSR addresses for unit control, counter and counter config.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 60 ++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 62e88ad..34fc9d7 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -393,6 +393,11 @@
 #define SNR_M2M_PCI_PMON_BOX_CTL		0x438
 #define SNR_M2M_PCI_PMON_UMASK_EXT		0xff
 
+/* SNR PCIE3 */
+#define SNR_PCIE3_PCI_PMON_CTL0			0x508
+#define SNR_PCIE3_PCI_PMON_CTR0			0x4e8
+#define SNR_PCIE3_PCI_PMON_BOX_CTL		0x4e0
+
 /* SNR IMC */
 #define SNR_IMC_MMIO_PMON_FIXED_CTL		0x54
 #define SNR_IMC_MMIO_PMON_FIXED_CTR		0x38
@@ -4551,12 +4556,46 @@ static struct intel_uncore_type snr_uncore_m2m = {
 	.format_group	= &snr_m2m_uncore_format_group,
 };
 
+static void snr_uncore_pci_enable_event(struct intel_uncore_box *box, struct perf_event *event)
+{
+	struct pci_dev *pdev = box->pci_dev;
+	struct hw_perf_event *hwc = &event->hw;
+
+	pci_write_config_dword(pdev, hwc->config_base, (u32)(hwc->config | SNBEP_PMON_CTL_EN));
+	pci_write_config_dword(pdev, hwc->config_base + 4, (u32)(hwc->config >> 32));
+}
+
+static struct intel_uncore_ops snr_pcie3_uncore_pci_ops = {
+	.init_box	= snr_m2m_uncore_pci_init_box,
+	.disable_box	= snbep_uncore_pci_disable_box,
+	.enable_box	= snbep_uncore_pci_enable_box,
+	.disable_event	= snbep_uncore_pci_disable_event,
+	.enable_event	= snr_uncore_pci_enable_event,
+	.read_counter	= snbep_uncore_pci_read_counter,
+};
+
+static struct intel_uncore_type snr_uncore_pcie3 = {
+	.name		= "pcie3",
+	.num_counters	= 4,
+	.num_boxes	= 1,
+	.perf_ctr_bits	= 48,
+	.perf_ctr	= SNR_PCIE3_PCI_PMON_CTR0,
+	.event_ctl	= SNR_PCIE3_PCI_PMON_CTL0,
+	.event_mask	= SKX_IIO_PMON_RAW_EVENT_MASK,
+	.event_mask_ext	= SKX_IIO_PMON_RAW_EVENT_MASK_EXT,
+	.box_ctl	= SNR_PCIE3_PCI_PMON_BOX_CTL,
+	.ops		= &snr_pcie3_uncore_pci_ops,
+	.format_group	= &skx_uncore_iio_format_group,
+};
+
 enum {
 	SNR_PCI_UNCORE_M2M,
+	SNR_PCI_UNCORE_PCIE3,
 };
 
 static struct intel_uncore_type *snr_pci_uncores[] = {
 	[SNR_PCI_UNCORE_M2M]		= &snr_uncore_m2m,
+	[SNR_PCI_UNCORE_PCIE3]		= &snr_uncore_pcie3,
 	NULL,
 };
 
@@ -4573,6 +4612,25 @@ static struct pci_driver snr_uncore_pci_driver = {
 	.id_table	= snr_uncore_pci_ids,
 };
 
+static const struct pci_device_id snr_uncore_platform_pci_ids[] = {
+	{ /* PCIe3 RP */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x334a),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(4, 0, SNR_PCI_UNCORE_PCIE3, 0),
+	},
+	{ /* end: all zeroes */ }
+};
+
+static struct platform_driver snr_uncore_pcieport = {
+	.driver = {
+		.name = "perf_uncore_pcieport",
+	},
+};
+
+static struct uncore_platform_driver snr_uncore_platform_driver = {
+	.driver		= &snr_uncore_pcieport,
+	.pci_ids	= snr_uncore_platform_pci_ids,
+};
+
 int snr_uncore_pci_init(void)
 {
 	/* SNR UBOX DID */
@@ -4584,6 +4642,8 @@ int snr_uncore_pci_init(void)
 
 	uncore_pci_uncores = snr_pci_uncores;
 	uncore_pci_driver = &snr_uncore_pci_driver;
+	uncore_platform_driver = &snr_uncore_platform_driver;
+
 	return 0;
 }
 
-- 
2.7.4

