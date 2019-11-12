Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0D04F94EF
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 17:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKLP7o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 10:59:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:56940 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfKLP7n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Nov 2019 10:59:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32F7DB3C9;
        Tue, 12 Nov 2019 15:59:40 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     andrew.murray@arm.com, maz@kernel.org,
        linux-kernel@vger.kernel.org, Tariq Toukan <tariqt@mellanox.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     james.quinlan@broadcom.com, mbrugger@suse.com,
        f.fainelli@gmail.com, phil@raspberrypi.org, wahrenst@gmx.net,
        jeremy.linton@arm.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH v2 1/6] linux/log2.h: Add roundup/rounddown_pow_two64() family of functions
Date:   Tue, 12 Nov 2019 16:59:20 +0100
Message-Id: <20191112155926.16476-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112155926.16476-1-nsaenzjulienne@suse.de>
References: <20191112155926.16476-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some users need to make sure their rounding function accepts and returns
64bit long variables regardless of the architecture. Sadly
roundup/rounddown_pow_two() takes and returns unsigned longs. Create a
new generic 64bit variant of the function and cleanup rougue custom
implementations.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/net/ethernet/mellanox/mlx4/en_clock.c |  3 +-
 drivers/pci/controller/pcie-cadence-ep.c      |  7 +--
 drivers/pci/controller/pcie-cadence.c         |  7 +--
 drivers/pci/controller/pcie-rockchip-ep.c     |  9 ++--
 include/linux/log2.h                          | 52 +++++++++++++++++++
 kernel/dma/direct.c                           |  3 +-
 6 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
index 024788549c25..027bd72505e2 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
@@ -33,6 +33,7 @@
 
 #include <linux/mlx4/device.h>
 #include <linux/clocksource.h>
+#include <linux/log2.h>
 
 #include "mlx4_en.h"
 
@@ -252,7 +253,7 @@ static u32 freq_to_shift(u16 freq)
 {
 	u32 freq_khz = freq * 1000;
 	u64 max_val_cycles = freq_khz * 1000 * MLX4_EN_WRAP_AROUND_SEC;
-	u64 max_val_cycles_rounded = 1ULL << fls64(max_val_cycles - 1);
+	u64 max_val_cycles_rounded = roundup_pow_of_two64(max_val_cycles);
 	/* calculate max possible multiplier in order to fit in 64bit */
 	u64 max_mul = div64_u64(ULLONG_MAX, max_val_cycles_rounded);
 
diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index def7820cb824..26ff424b16f5 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -10,6 +10,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/sizes.h>
+#include <linux/log2.h>
 
 #include "pcie-cadence.h"
 
@@ -90,11 +91,7 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
 
 	/* BAR size is 2^(aperture + 7) */
 	sz = max_t(size_t, epf_bar->size, CDNS_PCIE_EP_MIN_APERTURE);
-	/*
-	 * roundup_pow_of_two() returns an unsigned long, which is not suited
-	 * for 64bit values.
-	 */
-	sz = 1ULL << fls64(sz - 1);
+	sz = roundup_pow_of_two64(sz);
 	aperture = ilog2(sz) - 7; /* 128B -> 0, 256B -> 1, 512B -> 2, ... */
 
 	if ((flags & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO) {
diff --git a/drivers/pci/controller/pcie-cadence.c b/drivers/pci/controller/pcie-cadence.c
index cd795f6fc1e2..b2278e6b955c 100644
--- a/drivers/pci/controller/pcie-cadence.c
+++ b/drivers/pci/controller/pcie-cadence.c
@@ -4,6 +4,7 @@
 // Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
 
 #include <linux/kernel.h>
+#include <linux/log2.h>
 
 #include "pcie-cadence.h"
 
@@ -11,11 +12,7 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 fn,
 				   u32 r, bool is_io,
 				   u64 cpu_addr, u64 pci_addr, size_t size)
 {
-	/*
-	 * roundup_pow_of_two() returns an unsigned long, which is not suited
-	 * for 64bit values.
-	 */
-	u64 sz = 1ULL << fls64(size - 1);
+	u64 sz = roundup_pow_of_two64(size);
 	int nbits = ilog2(sz);
 	u32 addr0, addr1, desc0, desc1;
 
diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index d743b0a48988..ed50aaf27784 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/pci-epf.h>
 #include <linux/sizes.h>
+#include <linux/log2.h>
 
 #include "pcie-rockchip.h"
 
@@ -70,7 +71,7 @@ static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
 					 u32 r, u32 type, u64 cpu_addr,
 					 u64 pci_addr, size_t size)
 {
-	u64 sz = 1ULL << fls64(size - 1);
+	u64 sz = roundup_pow_of_two64(size);
 	int num_pass_bits = ilog2(sz);
 	u32 addr0, addr1, desc0, desc1;
 	bool is_nor_msg = (type == AXI_WRAPPER_NOR_MSG);
@@ -172,11 +173,7 @@ static int rockchip_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
 	/* BAR size is 2^(aperture + 7) */
 	sz = max_t(size_t, epf_bar->size, MIN_EP_APERTURE);
 
-	/*
-	 * roundup_pow_of_two() returns an unsigned long, which is not suited
-	 * for 64bit values.
-	 */
-	sz = 1ULL << fls64(sz - 1);
+	sz = roundup_pow_of_two64(sz);
 	aperture = ilog2(sz) - 7; /* 128B -> 0, 256B -> 1, 512B -> 2, ... */
 
 	if ((flags & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO) {
diff --git a/include/linux/log2.h b/include/linux/log2.h
index 83a4a3ca3e8a..db12d92ab6eb 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -67,6 +67,24 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
 	return 1UL << (fls_long(n) - 1);
 }
 
+/**
+ * __roundup_pow_of_two64() - round 64bit value up to nearest power of two
+ * @n: value to round up
+ */
+static inline __attribute__((const)) __u64 __roundup_pow_of_two64(__u64 n)
+{
+	return 1UL << fls64(n - 1);
+}
+
+/**
+ * __rounddown_pow_of_two64() - round 64bit value down to nearest power of two
+ * @n: value to round down
+ */
+static inline __attribute__((const)) __u64 __rounddown_pow_of_two64(__u64 n)
+{
+	return 1UL << (fls64(n) - 1);
+}
+
 /**
  * const_ilog2 - log base 2 of 32-bit or a 64-bit constant unsigned value
  * @n: parameter
@@ -194,6 +212,40 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
 	__rounddown_pow_of_two(n)		\
  )
 
+/**
+ * roundup_pow_of_two64 - round the given 64bit value up to nearest power of
+ * two
+ * @n: parameter
+ *
+ * round the given value up to the nearest power of two
+ * - the result is undefined when n == 0
+ * - this can be used to initialise global variables from constant data
+ */
+#define roundup_pow_of_two64(n)			\
+(						\
+	__builtin_constant_p(n) ? (		\
+		(n == 1) ? 1 :			\
+		(1UL << (ilog2((n) - 1) + 1))	\
+				   ) :		\
+	__roundup_pow_of_two64(n)		\
+)
+
+/**
+ * rounddown_pow_of_two64 - round the given 64bit value down to nearest power
+ * of two
+ * @n: parameter
+ *
+ * round the given value down to the nearest power of two
+ * - the result is undefined when n == 0
+ * - this can be used to initialise global variables from constant data
+ */
+#define rounddown_pow_of_two64(n)		\
+(						\
+	__builtin_constant_p(n) ? (		\
+		(1UL << ilog2(n))) :		\
+	__rounddown_pow_of_two64(n)		\
+)
+
 static inline __attribute_const__
 int __order_base_2(unsigned long n)
 {
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index b9e1744999d9..a419530abd3e 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -15,6 +15,7 @@
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
 #include <linux/swiotlb.h>
+#include <linux/log2.h>
 
 /*
  * Most architectures use ZONE_DMA for the first 16 Megabytes, but some use it
@@ -53,7 +54,7 @@ u64 dma_direct_get_required_mask(struct device *dev)
 {
 	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
 
-	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
+	return rounddown_pow_of_two64(max_dma) * 2 - 1;
 }
 
 static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
-- 
2.24.0

