Return-Path: <linux-pci+bounces-11165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D80969457D3
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 07:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C0DEB23482
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 05:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE554501F;
	Fri,  2 Aug 2024 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fknCQwrK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBDB3D97F;
	Fri,  2 Aug 2024 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722578119; cv=none; b=f9R4AnNxg/v7SFQ7liAAxTViFzEkKUjfbUx7sTh+yRfqZljgZ8fXVEaJRovfGVVn7EXgksVrnOv12Uh76//ZZUfxe+vQjdX7LW6SCJtMOWhp398Av0u4YVXDnLbrQm2bQ8t+NjmpzYHC+EAtUSLqPozB8u+0zdE6UhrDJi3C6cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722578119; c=relaxed/simple;
	bh=oJ3IlqSiPUE/6vfvESym8bB1B3xRl0UDxfzGbgXtDaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lml+LHInJ3w55NI+969lNlMh9rOyrIFewCE7LZPUZwNw5Tq1kaCm8tGN6OtR1AlHlGVL8rpZqY3mAF6yBSCHXRbKGrgENsY70rij2lzYZuHW+78t2KSgOLy8/gH0hL+N4ObPMxZGTVnCDwzmVCZzXJT1kkAc0Y9Q+rl5WHWTozA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fknCQwrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DDA3C4AF14;
	Fri,  2 Aug 2024 05:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722578119;
	bh=oJ3IlqSiPUE/6vfvESym8bB1B3xRl0UDxfzGbgXtDaQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fknCQwrKbaeH+FLdDZ4sQrJDl+LtRbdRuC8NQss+/xaIMaAyf/+0v0ya3F6fwSeQ1
	 K3aZGf0RZ4FInf1OCJ9yYED6CmGzVflUgkuDE6K6F7gk7bDkmtfs8kQRT1okAeNabP
	 emQdoF2PwfEGVTkpLCDJUC9CQGt8BUTra1h+0y5R1SVZBfhTgTbJ1z66REsTgBBmfW
	 YM5gh+7gxAjLquTZO73PwqTYBqvq56fPHjwN5AgjBZ27s4/kiWDaR8fQpxHYR3IN6/
	 H5s2Xo+hTACWMntame/2jhoS99yw64smB6S4oPD42UPPoyLtMiAmwUTChGzqw5Euts
	 cGgnzGFmropbQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510CCC52D73;
	Fri,  2 Aug 2024 05:55:19 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Fri, 02 Aug 2024 11:25:03 +0530
Subject: [PATCH v5 4/4] PCI: Allow PCI bridges to go to D3Hot on all
 Devicetree based platforms
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-pci-bridge-d3-v5-4-2426dd9e8e27@linaro.org>
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
In-Reply-To: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, lukas@wunner.de, 
 mika.westerberg@linux.intel.com, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Hsin-Yi Wang <hsinyi@chromium.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1909;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=ysTqE45coqPvykQRZRe0VeyavgQ9+sgZKnMnxkXaMrs=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmrHTDk+wYKSA4ReZo++MT1k+y+mL9mpBeuq5iS
 rN1qLy+ebqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZqx0wwAKCRBVnxHm/pHO
 9bj2B/9CHofWJVlPBG6X2dbdioyUIDnUxWxbrl1XR2oQVu+HOTwlWR1Jk7diQuhO3z4OjhGUR0w
 R9l3pknbtJ982jDRmJDsHMK3y4rQj3hHflT9zMSeF4qnzGmHEk8V06arY61nfyDQYN8scYnz+hx
 8Jf1GktYNZKDlyfF5+oRkJcn3YYLd5pawJ/G21JvXgsmyUI01CKXjpXewgKJoRpanKDt8+YkZHv
 MY41deRlZ1Crer5imiCiS8WGeEA3Hq9mVA9W4VLS1+2qpAPpM4gQ4+PV1TcqeUPQd7PH7OJoqy/
 r6+Zldu8WZQpd8iKpFFT/uIcKjLIyuq6EMKvXh0Iw0+ZKF6d
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Unlike ACPI based platforms, there are no known issues with D3Hot for the
PCI bridges in the Devicetree based platforms. So let's allow the PCI
bridges to go to D3Hot during runtime. It should be noted that the bridges
need to be defined in Devicetree for this to work.

Currently, D3Cold is not allowed since Vcc supply which is required for
transitioning the device to D3Cold is not exposed on all Devicetree based
platforms.

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/pci.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c7a4f961ec28..bc1e1ca673f1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2992,6 +2992,18 @@ static bool pci_bridge_d3_allowed(struct pci_dev *bridge, pci_power_t state)
 		if (pci_bridge_d3_force)
 			return true;
 
+		/*
+		 * Allow D3Hot for all Devicetree based platforms having a
+		 * separate node for the bridge. We don't allow D3Cold for now
+		 * since not all platforms are exposing the Vcc supply in
+		 * Devicetree which is required for transitioning the bridge to
+		 * D3Cold.
+		 *
+		 * NOTE: The bridge is expected to be defined in Devicetree.
+		 */
+		if (state == PCI_D3hot && dev_of_node(&bridge->dev))
+			return true;
+
 		/* Even the oldest 2010 Thunderbolt controller supports D3. */
 		if (bridge->is_thunderbolt)
 			return true;
@@ -3042,7 +3054,7 @@ bool pci_bridge_d3cold_allowed(struct pci_dev *bridge)
  *
  * This function checks if the bridge is allowed to move to D3Hot.
  * Currently we only allow D3Hot for recent enough PCIe ports on ACPI based
- * platforms and Thunderbolt.
+ * platforms, Thunderbolt and Devicetree based platforms.
  */
 bool pci_bridge_d3hot_allowed(struct pci_dev *bridge)
 {

-- 
2.25.1



