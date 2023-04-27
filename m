Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CA96F008C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 07:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242672AbjD0F5I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 01:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242817AbjD0F5H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 01:57:07 -0400
X-Greylist: delayed 176 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Apr 2023 22:57:00 PDT
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de [IPv6:2a01:238:400:300::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A759835A5
        for <linux-pci@vger.kernel.org>; Wed, 26 Apr 2023 22:57:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1682574662; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=r2Z3H8w5RN9iabgAS20IvBBEqV0z3Fryt7OwrvD0t1HjgPacnxpFpV+mjDQ/GE7jKp
    m2l6PkvPY8uHHpOzSZF+WtgqwmDIncP64mRkD5XzZbUqYVGOaAkWbxpBFwpcachSKmAp
    /HD2tj1XSS7gYO8TgKhpEaKFGQX020O53BLD/dQDyNs9i32Trm7Vtc/6eMFztHBV151/
    4DDbHzGHrjjLREAa76e3BR7rEvhc92Btc2DGzoareB1JEyrJdRuwfN8s+Yjjcl4mDMwm
    eFbvCEtHqp+OIHHaksfz0lgbEfE10WcuyhAsq50cGk5HBFeLuSvhtlDzR0ASWWz1s38T
    Qjrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1682574662;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Ekspz/z9C11R1RgSuCJYQ6EmXeArkizPjSMN4em5BWI=;
    b=hzyxSD06rb+CcOo2KBQP42LfEMOknq2m81l4OFGabG4izAWXlklEBnagqTSDLzLQod
    naHYbBjMMCe/axjBehPuMqZ1lyDb5ZRoKNttTu1NE4ZBgJOSgRtdfPjSvyuZhqPTVRwd
    QgrxkVmhjJhqVEJFNAKxyLum+P3sul6wv/uHbWace3XcRA7e84jxKHBHqE5nMoZk6BlA
    jPim/z5p6gv82EZXbKs+0n9YYDEzkzFU8OQ5E9xZplfYM7X+4XVFxHUQOwqAYLXcdZES
    8OiLgbQeo+Hq+ydtStx9D0JxXMDHLbDwCRKg0ihtoCPi3p+V4znGhOkC/CZ+EufySKU+
    edeQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1682574662;
    s=strato-dkim-0002; d=ibv-augsburg.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Ekspz/z9C11R1RgSuCJYQ6EmXeArkizPjSMN4em5BWI=;
    b=YGqtHuIfhx98NtuFDlgR3XckLtXLdKSweb/Rj7HpaoXVDuRr38vWF7e5MxRi22+6ON
    IFFUyhfsBynhXs3tesoCkwz6nNqLxJAFJ2/mkUYwUfApF5pXJ/CkdfT0r+XE7+61Zz9A
    9naWl8Bky/9akbmGUMAsywU/Nb6GjPOIkBgxO6+wzu8iTqQ0VPo1/bfshDXj2YQxGFhX
    nr+iwSiH9ev6gI4ctO9hDFZyOpy7/0E+yvVueJ4QlQUtdq5IITsnMcdcxNr9Aw05FMVz
    N+eC0GldFjP9DnziUrLPyAM2bk8aMlk7OL7/P/Xkr/GVda0BHIl21ZR1LDUxgTYuPbcy
    yUhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1682574662;
    s=strato-dkim-0003; d=ibv-augsburg.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Ekspz/z9C11R1RgSuCJYQ6EmXeArkizPjSMN4em5BWI=;
    b=tmNqajGPwKIUyrR+a7TCU5US1S8cBMJ+p4YY7E7jZ6vTaweHjFUgg0DNQAWJarS8AQ
    vmVYQ9rwCEgwKgUT6BAg==
X-RZG-AUTH: ":KGMJfE6heLGk8b3w7Oa1fDtXwBjeDczIOHPRx8yNRKhFG/cxcP9dNdI9SxioDT8RvZMqtMfbyXFLOT+2odkF/80="
Received: from localhost.localdomain
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id d6376fz3R5p1NqO
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 27 Apr 2023 07:51:01 +0200 (CEST)
From:   Dominic Rath <rath@ibv-augsburg.de>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tjoseph@cadence.com
Cc:     bhelgaas@google.com, lpieralisi@kernel.org, nm@ti.com,
        vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        christian.gmeiner@gmail.com, bahle@ibv-augsburg.de,
        Dominic Rath <rath@ibv-augsburg.de>
Subject: [PATCH v2 2/3] PCI: cadence: Use DT bindings to set PHY latencies
Date:   Thu, 27 Apr 2023 07:50:31 +0200
Message-Id: <20230427055032.85015-3-rath@ibv-augsburg.de>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230427055032.85015-1-rath@ibv-augsburg.de>
References: <20230427055032.85015-1-rath@ibv-augsburg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alexander Bahle <bahle@ibv-augsburg.de>

Use optional "tx-phy-latency-ps" and "rx-phy-latency-ps"
DeviceTree bindings to set the CDNS_PCIE_LM_PTM_LAT_PARAM(_IDX)
register(s) during PCIe host and endpoint setup.

The properties are lists of uint32 PHY latencies in picoseconds for
every supported speed starting at PCIe Gen1, e.g.:

  tx-phy-latency-ps = <100000 200000>; /* Gen1: 100ns, Gen2: 200ns */
  rx-phy-latency-ps = <150000 250000>; /* Gen1: 150ns, Gen2: 250ns */

There should be a value for every supported speed, otherwise a info
message is emitted to let users know that the PTM timestamps from this
PCIe device may not be precise enough for some applications.

Signed-off-by: Alexander Bahle <bahle@ibv-augsburg.de>
Signed-off-by: Dominic Rath <rath@ibv-augsburg.de>
---
 .../pci/controller/cadence/pcie-cadence-ep.c  |  2 +
 .../controller/cadence/pcie-cadence-host.c    |  1 +
 drivers/pci/controller/cadence/pcie-cadence.c | 92 +++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h | 23 +++++
 4 files changed, 118 insertions(+)

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
index 13c4032ca379..1a282ed9b888 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -5,8 +5,100 @@
 
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
+	struct device_node *np;
+	int max_link_speed;
+	int param_count;
+	u32 latency;
+	int ret;
+	int i;
+
+	/* Do nothing if there is no phy */
+	if (pcie->phy_count < 1)
+		return 0;
+
+	np = dev->of_node;
+	max_link_speed = of_pci_get_max_link_speed(np);
+	if (max_link_speed < 1)
+		return -EINVAL;
+
+	/* Only check and use params of the first phy */
+	np = pcie->phy[0]->dev.of_node;
+	param_count = of_property_count_u32_elems(np, key);
+	if (param_count < 0 || param_count < max_link_speed) {
+		dev_info(dev,
+			 "PTM: no %s set for one or more speeds: %d\n",
+			 key, param_count);
+	}
+
+	/* Don't set param for unsupported speed */
+	if (param_count > max_link_speed)
+		param_count = max_link_speed;
+
+	for (i = 0; i < param_count; i++) {
+		ret = of_property_read_u32_index(np, key, i, &latency);
+		if (ret != 0) {
+			dev_err(dev, "failed to read PTM latency for speed %d from %s\n",
+				i, key);
+			return ret;
+		}
+
+		/* convert ps to ns */
+		latency /= 1000;
+
+		cdns_pcie_set_ptm_phy_latency_param(pcie, rx,
+						    i, latency);
+
+		dev_dbg(dev, "PTM: %s phy latency Gen.%d: %uns\n",
+			rx ? "rx" : "tx", i+1, latency);
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
+					    "tx-phy-latency-ps");
+	if (ret)
+		return ret;
+
+	ret = cdns_pcie_set_ptm_phy_latency(dev, pcie, true,
+					    "rx-phy-latency-ps");
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

