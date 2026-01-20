Return-Path: <linux-pci+bounces-45297-lists+linux-pci=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pci@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCuwBynMb2mgMQAAu9opvQ
	(envelope-from <linux-pci+bounces-45297-lists+linux-pci=lfdr.de@vger.kernel.org>)
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 19:40:41 +0100
X-Original-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C719C499FB
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 19:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 800687EAEF2
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F90A43C077;
	Tue, 20 Jan 2026 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jc9BbYc3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF30326D53;
	Tue, 20 Jan 2026 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931266; cv=none; b=IBOE4SQNVrYE0piWLI65SvPTfO75FRU6l33bVxGATN2mYZfEmR8FjHRJX9RtuArM1BHrxFKm0xVXtnyj4cuw3MQN1LwU1Ee/ihXcw93ny1x/p9H7g4YrxDdc8aRII6V7K7wM7tPnF+mYAmvrKLKWiXVp7kwavk3uOl26TQvsx10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931266; c=relaxed/simple;
	bh=o2bc49G4zzjwHJj3X8ryTWNjsLEUfank6fQaGgoABrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UJvl2SYzsvlLseFMp86FiC/aZKd67cLbbvTYEpA0bKe+Z8Fg0W8+8wDPfr+7nhaQVLfqJGp11Tl79jMiWJfNKL4+TkzJnRo8LolKerPhvr2vbzk4GXwiIAUGheLhLG/Yjtb02QFn1os9Cs0sH/jlJc67q3M8nuJuuS+4Cz5H97k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jc9BbYc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E987C2BC86;
	Tue, 20 Jan 2026 17:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768931266;
	bh=o2bc49G4zzjwHJj3X8ryTWNjsLEUfank6fQaGgoABrE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jc9BbYc33x1mdUIXXekN8Z5V5vETaj0f2fRXFfOQCJxFTxOOG2suv+fMms89pcH6A
	 PGs2h1xTSWrdH6USEKDIgEq6hh6AZPhE1LbtTeH4g2R5mUi+cA3weR7X/+R+daZ18v
	 Y3hIKjcdRb977L6BjNgRt0yiQMXgTYhxb66l7gegS/B3+ZzCrPtVcWsQmM95aMoDnx
	 GqS7yaCHEU6q2hYsbASnFh+RVqYmvOBZGTbxQyxMhHYF56SHrt5OUsVQ+XhwFX6OIb
	 UBhXt1bOo57S1bichmyzct8gKazdM41AniEY7erUuU67aqTWdPa9i6BTUk2+wquoPJ
	 z6SPisJRpCQ6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B72CCA5FBD;
	Tue, 20 Jan 2026 17:47:46 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 20 Jan 2026 23:17:41 +0530
Subject: [PATCH v4 2/5] PCI: dwc: Return -EIO from dw_pcie_wait_for_link()
 if device is not active
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-pci-dwc-suspend-rework-v4-2-2f32d5082549@oss.qualcomm.com>
References: <20260120-pci-dwc-suspend-rework-v4-0-2f32d5082549@oss.qualcomm.com>
In-Reply-To: <20260120-pci-dwc-suspend-rework-v4-0-2f32d5082549@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, 
 Shawn Lin <shawn.lin@rock-chips.com>, Niklas Cassel <cassel@kernel.org>, 
 Richard Zhu <hongxing.zhu@nxp.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2234;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=lJs2RDxnLG6iq+YlIuSttT/5SGXBjIWrnLIyz20iOiw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpb7/A0Z/hHcog/Tj52mcEMvbyI30KwG25mDnHY
 EgKLBn4PYeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaW+/wAAKCRBVnxHm/pHO
 9cDxB/92DSlhtWBAH6buRsxQAx6Dykvjva6+MO7NInFxA63xXOUb3f6ouifoWUrh4vEYQd1Z2WQ
 ynshL9xbNpxxTeqJD3GAUGljVOreDusYW6UKaRE8TsOu+AgpbMvG922Wxi86//lTz+59vuM2svk
 9xMQpmr8C6xAhqLatkD2BieP4xs3RizxVZX5YH9J7ZcZ6tjSMbiemYjorfyoP1vC8AMjntoztP4
 62c9K8m3XS4tl9A8NucNx1P6UQFZSQ2HvP6i7KWScwlPMqsulVN1u9Rwpx/skSR18hvPaagn19+
 WqfYVOPGi3gFn3n1SCneC6+GZK87qcwKBFHnpAqqgdNjakGe
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-45297-lists,linux-pci=lfdr.de,manivannan.sadhasivam.oss.qualcomm.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,google.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[manivannan.sadhasivam@oss.qualcomm.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pci@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-pci];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,oss.qualcomm.com:mid,oss.qualcomm.com:replyto,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: C719C499FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

There are cases where the PCIe device would be physically connected to the
bus, but the device firmware might not be active. So the LTSSM will
get stuck in POLL.{Active/Compliance} states.

This behavior is common with endpoint devices controlled by the PCI
Endpoint framework, where the device will wait for the user to start its
operation through configfs.

For those cases, print the relevant log and return -EIO to indicate that
the device is present, but not active. This will allow the callers to skip
the failure as the device might become active in the future.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 55c1c60f7f8f..aca5bbeade03 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -696,8 +696,9 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
  * dw_pcie_wait_for_link - Wait for the PCIe link to be up
  * @pci: DWC instance
  *
- * Returns: 0 if link is up, -ENODEV if device is not found, -ETIMEDOUT if the
- * link fails to come up for other reasons.
+ * Returns: 0 if link is up, -ENODEV if device is not found, -EIO if the device
+ * is found but not active and -ETIMEDOUT if the link fails to come up for other
+ * reasons.
  */
 int dw_pcie_wait_for_link(struct dw_pcie *pci)
 {
@@ -722,6 +723,16 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 		    ltssm == DW_PCIE_LTSSM_DETECT_ACT) {
 			dev_info(pci->dev, "Device not found\n");
 			return -ENODEV;
+
+		/*
+		 * If the link is in POLL.{Active/Compliance} state, then the
+		 * device is found to be connected to the bus, but it is not
+		 * active i.e., the device firmware might not yet initialized.
+		 */
+		} else if (ltssm == DW_PCIE_LTSSM_POLL_ACTIVE ||
+			   ltssm == DW_PCIE_LTSSM_POLL_COMPLIANCE) {
+			dev_info(pci->dev, "Device found, but not active\n");
+			return -EIO;
 		}
 
 		dev_info(pci->dev, "Phy link never came up\n");

-- 
2.51.0



