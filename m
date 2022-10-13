Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467285FD516
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 08:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiJMGpQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 02:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJMGpP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 02:45:15 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C578558EC;
        Wed, 12 Oct 2022 23:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1665642445;
    s=strato-dkim-0002; d=ibv-augsburg.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=xnX52KDk//St768Jp7Wk2tbEVwKA3mValuHMrkOzHSg=;
    b=Oe5b47qhFAfgB0OyGYbbAmv/QlSg+txCRSMl0Poc1YtMXO+yVsWAXIB2Hgp8ZYL3mK
    LmPh2sU/NTS3gaAdtcZQG+pjCpz+AWxWqQ7fejGlOaX8i5jPD8EeEwuZF33rN25ftmjr
    7f73oRdNeqg+WyRncs7ZMPK/ZaUkiPcHciNz3XmoaerwjK8r9QIHepIeylVzS7+OZv8x
    nm4rOxPBvDy0R5Y3J43X3TZo5R3C1n3gjS0aRKl0ORg6TBXnZ2LQvv27r0YO0Ava6xGs
    3c19zWMULDDY29ZLRozWi/UEaOMSUK6HJIyxcyGLpL2FslUzb++klogqOydj+Zx4gfMH
    8yLg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":KGMJfE6heLGk8b3w7Oa1fDtXwBjeDczIOHPRx8yNRKhFG/cxcP9dNdI9SxioDT8RvZMqtMfbyXFLOT+8odoEkA=="
X-RZG-CLASS-ID: mo02
Received: from localhost.localdomain
    by smtp.strato.de (RZmta 48.2.0 DYNA|AUTH)
    with ESMTPSA id R6cb4ey9D6RPC0Z
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 13 Oct 2022 08:27:25 +0200 (CEST)
From:   Dominic Rath <dominic.rath@ibv-augsburg.de>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tjoseph@cadence.com
Cc:     bhelgaas@google.com, lpieralisi@kernel.org, nm@ti.com,
        vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Alexander Bahle <bahle@ibv-augsburg.de>,
        Dominic Rath <rath@ibv-augsburg.de>
Subject: [PATCH 2/3] PCI: cadence: Use DT bindings to set PHY latencies
Date:   Thu, 13 Oct 2022 08:26:48 +0200
Message-Id: <20221013062649.303184-3-dominic.rath@ibv-augsburg.de>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20221013062649.303184-1-dominic.rath@ibv-augsburg.de>
References: <20221013062649.303184-1-dominic.rath@ibv-augsburg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alexander Bahle <bahle@ibv-augsburg.de>

Use optional "cdns,tx-phy-latency-ps" and "cdns,rx-phy-latency-ps"
DeviceTree bindings to set the CDNS_PCIE_LM_PTM_LAT_PARAM(_IDX)
register(s) during PCIe host and ep setup.
The properties expect a list of uint32 PHY latencies in picoseconds for
every supported speed starting at PCIe Gen1, e.g.:

  max-link-speed = <2>;
  tx-phy-latency-ps = <100000 200000>; /* Gen1: 100ns, Gen2: 200ns */
  rx-phy-latency-ps = <150000 250000>; /* Gen1: 150ns, Gen2: 250ns */

There should be a value for every supported speed but it is not enforced or
necessary. A warning is emitted to let users know that the PTM timestamps
from this PCIe device may not be precise enough for some applications.

Signed-off-by: Alexander Bahle <bahle@ibv-augsburg.de>
Signed-off-by: Dominic Rath <rath@ibv-augsburg.de>
---
 .../pci/controller/cadence/pcie-cadence-ep.c  |  2 +
 .../controller/cadence/pcie-cadence-host.c    |  1 +
 drivers/pci/controller/cadence/pcie-cadence.c | 81 +++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h | 23 ++++++
 4 files changed, 107 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index b8b655d4047e..6e39126922d1 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -664,6 +664,8 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	}
 	pcie->mem_res = res;
 
+	cdns_pcie_init_ptm_phy_latency(dev, pcie);
+
 	ep->max_regions = CDNS_PCIE_MAX_OB;
 	of_property_read_u32(np, "cdns,max-outbound-regions", &ep->max_regions);
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 940c7dd701d6..8933002f828e 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -510,6 +510,7 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
 
 	cdns_pcie_host_enable_ptm_response(pcie);
+	cdns_pcie_init_ptm_phy_latency(dev, pcie);
 
 	ret = cdns_pcie_start_link(pcie);
 	if (ret) {
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 13c4032ca379..f0370a10640b 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -5,8 +5,89 @@
 
 #include <linux/kernel.h>
 
+#include "../../pci.h"
 #include "pcie-cadence.h"
 
+void cdns_pcie_set_ptm_phy_latency_param(struct cdns_pcie *pcie, bool rx,
+					 u32 speed_index, u32 latency)
+{
+	u32 val;
+
+	/* Set the speed index */
+	val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_LAT_PARAM_IDX);
+	val = ((val & ~CDNS_PCIE_LM_PTM_LAT_PARAM_IDX_PTMLATIN_MASK) |
+		CDNS_PCIE_LM_PTM_LAT_PARAM_IDX_PTMLATIN(speed_index));
+	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_LAT_PARAM_IDX, val);
+
+	val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_LAT_PARAM);
+	if (rx)	{
+		/* Set the RX direction latency */
+		val = ((val & ~CDNS_PCIE_LM_PTM_LAT_PARAM_PTMRXLAT_MASK) |
+			CDNS_PCIE_LM_PTM_LAT_PARAM_PTMRXLAT(latency));
+	} else {
+		/* Set TX direction latency */
+		val = ((val & ~CDNS_PCIE_LM_PTM_LAT_PARAM_PTMTXLAT_MASK) |
+			CDNS_PCIE_LM_PTM_LAT_PARAM_PTMTXLAT(latency));
+	}
+	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_LAT_PARAM, val);
+}
+
+static int cdns_pcie_set_ptm_phy_latency(struct device *dev, struct cdns_pcie *pcie,
+					 bool rx, const char *key)
+{
+	struct device_node *np = dev->of_node;
+	int max_link_speed;
+	int param_count;
+	u32 latency;
+	int i;
+
+	max_link_speed = of_pci_get_max_link_speed(np);
+	if (max_link_speed < 1)
+		return -EINVAL;
+
+	param_count = of_property_count_u32_elems(np, key);
+	if (param_count < 0 || param_count < max_link_speed) {
+		dev_warn(dev,
+			"no %s set for one or more speeds: %d\n",
+			key, param_count);
+	}
+
+	/* Don't set param for unsupported speed */
+	if (param_count > max_link_speed)
+		param_count = max_link_speed;
+
+	for (i = 0; i < param_count; i++) {
+		if (of_property_read_u32_index(np, key, i,
+					       &latency) < 0) {
+			dev_err(dev, "failed to set latency for speed %d. %s\n",
+				i, key);
+			return -EINVAL;
+		}
+
+		/* convert ps to ns */
+		latency /= 1000;
+
+		cdns_pcie_set_ptm_phy_latency_param(pcie, rx,
+						    i, latency);
+	}
+
+	return 0;
+}
+
+int cdns_pcie_init_ptm_phy_latency(struct device *dev, struct cdns_pcie *pcie)
+{
+	int ret;
+
+	ret = cdns_pcie_set_ptm_phy_latency(dev, pcie, false,
+					    "cdns,tx-phy-latency-ps");
+	if (ret)
+		return ret;
+
+	ret = cdns_pcie_set_ptm_phy_latency(dev, pcie, true,
+					    "cdns,rx-phy-latency-ps");
+	return ret;
+}
+
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
 {
 	u32 delay = 0x3;
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 190786e47df9..483b957a8212 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -120,6 +120,26 @@
 #define CDNS_PCIE_LM_PTM_CTRL 	(CDNS_PCIE_LM_BASE + 0x0da8)
 #define CDNS_PCIE_LM_TPM_CTRL_PTMRSEN 	BIT(17)
 
+/* PTM Latency Parameters Index Register */
+#define CDNS_PCIE_LM_PTM_LAT_PARAM_IDX \
+				(CDNS_PCIE_LM_BASE + 0x0db0)
+#define  CDNS_PCIE_LM_PTM_LAT_PARAM_IDX_PTMLATIN_MASK \
+					GENMASK(3, 0)
+#define  CDNS_PCIE_LM_PTM_LAT_PARAM_IDX_PTMLATIN(a) \
+	(((a) << 0) & CDNS_PCIE_LM_PTM_LAT_PARAM_IDX_PTMLATIN_MASK)
+
+/* PTM Latency Parameters Register */
+#define CDNS_PCIE_LM_PTM_LAT_PARAM \
+				(CDNS_PCIE_LM_BASE + 0x0db4)
+#define  CDNS_PCIE_LM_PTM_LAT_PARAM_PTMTXLAT_MASK \
+					GENMASK(9, 0)
+#define  CDNS_PCIE_LM_PTM_LAT_PARAM_PTMTXLAT(a) \
+	(((a) << 0) & CDNS_PCIE_LM_PTM_LAT_PARAM_PTMTXLAT_MASK)
+#define  CDNS_PCIE_LM_PTM_LAT_PARAM_PTMRXLAT_MASK \
+					GENMASK(19, 10)
+#define  CDNS_PCIE_LM_PTM_LAT_PARAM_PTMRXLAT(b) \
+	(((b) << 10) & CDNS_PCIE_LM_PTM_LAT_PARAM_PTMRXLAT_MASK)
+
 /*
  * Endpoint Function Registers (PCI configuration space for endpoint functions)
  */
@@ -541,6 +561,9 @@ static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 #endif
 
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
+void cdns_pcie_set_ptm_phy_latency_param(struct cdns_pcie *pcie, bool rx,
+					 u32 speed_index, u32 latency);
+int cdns_pcie_init_ptm_phy_latency(struct device *dev, struct cdns_pcie *pcie);
 
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
 				   u32 r, bool is_io,
-- 
2.36.0

