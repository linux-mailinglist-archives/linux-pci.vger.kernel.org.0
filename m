Return-Path: <linux-pci+bounces-30099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6318ADF33C
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 18:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DFA43BCF4C
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 16:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1F42FEE2B;
	Wed, 18 Jun 2025 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="FPLMlgln"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4207E2FEE16;
	Wed, 18 Jun 2025 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265819; cv=none; b=DJjYWDvzLSTXHmJjSgb1RVHaWClY63MyRx5cN6w1FVDf4Zk8VK6m47UfuUZx9Hn6pAQFJ+tALBh5xX9fEQrI0yOCUvwCh2HQY4SNNOcNYQvrOU+6U7Gg6CdmVjn5ZgrL5IFT/Dy7Ix4P70K1zHcwQzK+Cjy5kdfo6RQ/tuaFxws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265819; c=relaxed/simple;
	bh=GtU4YHodsG0/CIhLM5v4G6n95rh7zrUYrO5GWs4Y384=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=KzBqJyeZsEcmsJKJDdwlHJfO0JQKXq8Ijh+SiO7TOLS1qy7ZELpVQ02xPUq+4+Xk1LtW9HRbl6/bOZb5pL8XxyiyMmgh+dYHBvGxzoHvSKBV41kRFj683b5atlb/n0vBHznTf+3dVacnv0x/3U1L0yjfUDMb12TKX5oSoq/daM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=FPLMlgln; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 499608286FBD;
	Wed, 18 Jun 2025 11:56:55 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id OzwSo1i5lY-5; Wed, 18 Jun 2025 11:56:54 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id A66358287179;
	Wed, 18 Jun 2025 11:56:54 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com A66358287179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1750265814; bh=sREPJsWJTR+II/tfen1J5UvqEzkTitKMBh+Xdyx4rAM=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=FPLMlgln/Ncr+9I083bBPxQi6g4rRCiOdyqww8zDpkhfPuyneVgmqD2w9/pwRpEQm
	 M3fFKnX2Os14BnzxrmV0UU58L8pJAKY3s7O9nO2yXk2lUbO99ufwZtrpcn/SZXjDOl
	 8o/6Ia84kDydEcBhqIdC2LGd+YvkTFgqtdT3OVTA=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LlwZ-2WCS83M; Wed, 18 Jun 2025 11:56:54 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 7329E8286FBD;
	Wed, 18 Jun 2025 11:56:54 -0500 (CDT)
Date: Wed, 18 Jun 2025 11:56:54 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	christophe leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Shawn Anastasio <sanastasio@raptorengineering.com>
Message-ID: <1741778252.1310636.1750265814430.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <581463409.1310624.1750265668004.JavaMail.zimbra@raptorengineeringinc.com>
References: <581463409.1310624.1750265668004.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH v2 2/6] pci/hotplug/pnv_php: Work around switches with
 broken
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC137 (Linux)/8.5.0_GA_3042)
Thread-Topic: pci/hotplug/pnv_php: Work around switches with broken
Thread-Index: 7ViWVrejj338yZQm64sXoMCfdWvE4IAxp3+8

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
index aec0a6d594ac..bac8af3df41a 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -391,6 +391,20 @@ static int pnv_php_get_power_state(struct hotplug_slot *slot, u8 *state)
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
@@ -403,6 +417,19 @@ static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
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

