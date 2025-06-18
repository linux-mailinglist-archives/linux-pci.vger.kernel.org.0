Return-Path: <linux-pci+bounces-29999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BA7ADE24B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 06:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29241899814
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 04:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541351D86FF;
	Wed, 18 Jun 2025 04:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="M7AcXOah"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343971D9A5D;
	Wed, 18 Jun 2025 04:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750220545; cv=none; b=iddYfrsHkszXpbTMqh7EURQRBxdZdS4enqxV4XiiO1nzouqKezhYt4IpOnKxKDSVCdHv3wTLtKQ0l5Uk9GXAkpA5u+l27lQiV2PTEWBOZpVbuXRYWbgXBVy5hISVhi9bW0OhTN+nYDHZy94GRgPuVsSDRp1DsbOEABDmJK5JEUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750220545; c=relaxed/simple;
	bh=KpPqzZym+fhwN+cj3wpK2zLOfL8Ssd11Gvpz7QvvfbA=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=nCq532PVmLuTxarB2/7wZIaeiNIgathCqnRvT0veaiJS8+AUBdOkrX3BBs2KM2xLKHnHIKdXmzEfLipiCITEH8CjImfcstLrSIedmbzgxtcrOcLA8cFzp4iAp8gUAAPt4Yry6Z4GmKaTBGAs1VUuoo3aAXpHpV/QwCZptI4cDkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=M7AcXOah; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 5770E82887A2;
	Tue, 17 Jun 2025 23:22:22 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id WHpS5KlGB3rH; Tue, 17 Jun 2025 23:22:21 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id A3AAE828884A;
	Tue, 17 Jun 2025 23:22:21 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com A3AAE828884A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1750220541; bh=IOinkmbct99ihAa2et65ViRn0B/Fv9hQ1/ek84lQs3k=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=M7AcXOahGvvCgVkFmVjJ5wRHsSc7qVe3B97YDIrb4hXPtH8cfwFar6RM5kgy8gfoz
	 jJ3WwcPewsAqUfr7fjQpGDqGIUwpCkL8/88AwGVKTrNceX2QfQB+4fOcVjqdkulJ5t
	 wafDb1OBefsFgUDmTu1uHEt5GMonI8bfUjTmmWsA=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qzE0J4bKH9Kd; Tue, 17 Jun 2025 23:22:21 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 7F82382887A2;
	Tue, 17 Jun 2025 23:22:21 -0500 (CDT)
Date: Tue, 17 Jun 2025 23:22:21 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>, 
	Timothy Pearson <tpearson@raptorengineering.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	christophe leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Shawn Anastasio <sanastasio@raptorengineering.com>
Message-ID: <303034157.1309767.1750220541428.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH 2/8] pci/hotplug/pnv_php: Work around switches with broken
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC137 (Linux)/8.5.0_GA_3042)
Thread-Index: lkiBXds83IiFLz5qs829T9eoZxietg==
Thread-Topic: pci/hotplug/pnv_php: Work around switches with broken

 presence detection

The Microsemi Switchtec PM8533 PFX 48xG3 [11f8:8533] PCIe switch system
was observed to incorrectly assert the Presence Detect Set bit in its
capabilities when tested on a Raptor Computing Systems Blackbird system,
resulting in the hot insert path never attempting a rescan of the bus
and any downstream devices not being re-detected.

Work around this by additionally checking whether the PCIe data link is
active or not when performing presence detection on downstream switches'
ports, similar to the pciehp_hpc.c driver.

Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 drivers/pci/hotplug/pnv_php.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 2c07544216fb..1a734adb5b10 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -390,6 +390,20 @@ static int pnv_php_get_power_state(struct hotplug_slot *slot, u8 *state)
 	return 0;
 }
 
+static int pcie_check_link_active(struct pci_dev *pdev)
+{
+	u16 lnk_status;
+	int ret;
+
+	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
+	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
+		return -ENODEV;
+
+	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
+
+	return ret;
+}
+
 static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
 {
 	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
@@ -402,6 +416,19 @@ static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
 	 */
 	ret = pnv_pci_get_presence_state(php_slot->id, &presence);
 	if (ret >= 0) {
+		if (pci_pcie_type(php_slot->pdev) == PCI_EXP_TYPE_DOWNSTREAM &&
+			presence == OPAL_PCI_SLOT_EMPTY) {
+			/*
+			 * Similar to pciehp_hpc, check whether the Link Active
+			 * bit is set to account for broken downstream bridges
+			 * that don't properly assert Presence Detect State, as
+			 * was observed on the Microsemi Switchtec PM8533 PFX
+			 * [11f8:8533].
+			 */
+			if (pcie_check_link_active(php_slot->pdev) > 0)
+				presence = OPAL_PCI_SLOT_PRESENT;
+		}
+
 		*state = presence;
 		ret = 0;
 	} else {
-- 
2.39.5

