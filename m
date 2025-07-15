Return-Path: <linux-pci+bounces-32199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 613C3B068B6
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 23:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88585643F6
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 21:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D70B1E501C;
	Tue, 15 Jul 2025 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="D3iAdAgV"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276E91C4A24;
	Tue, 15 Jul 2025 21:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752615587; cv=none; b=X5PBiwdNSsCOVjLq9I3FlnKkoeVzx+1mFCZrAwg+duGxAhLTCMTsnfBgJLdOGmsBwHuKkJw2vj37HblvLm5hoL7P3BVr97y1XSKdEzWMTEo0B2kxUCv6Do7+Y4prvANoL+tF/kOnB90LbkyoBIaEiDTaXQ+KFzqEX6QPxBL26QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752615587; c=relaxed/simple;
	bh=Lhc/UTs9aXQrD4O3R05g/Q2eQFWdW6oU8etPZNg2KyM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=bDnVERirGSVaIrJlJD6aV9iC0/YC0EGV4pCy/PWVl+Qjz4pN6XVIOvoNWZzSiG6GYZ57Qmq5AYBEKTs1cVcoqyEPBaDNnifxywoerNo9IY4cSuZ09m2sxqUE+B7ueaYkPGvuXEGAGlTT0nLN4MwANoWyDifQvD8r6p6Kb9sICqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=D3iAdAgV; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 57CE08286D62;
	Tue, 15 Jul 2025 16:39:43 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id tmyS4NZMKEi3; Tue, 15 Jul 2025 16:39:42 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 5087B8287698;
	Tue, 15 Jul 2025 16:39:42 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 5087B8287698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1752615582; bh=R/JTJdtwW+QkveuipqtnZ2LcFEWOkXpaagYwjf7bvsU=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=D3iAdAgVu/nXdic/B0Uspr+WTRVXdaQpR4f6o+2w4RVT6N/HZoVhElCyeQ8BlqXcW
	 29fuWOnScL8FRtP3mVPwyBGfmxY3fcBB5kC8gADmcvoOr0s6URKYGJcrkPAZyM81kv
	 pSqrk6Dsk01Muk1HWcjk7wIJlQ21qpkt0ZThnhgg=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1e5Fx11LJPWI; Tue, 15 Jul 2025 16:39:42 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 173C08286D62;
	Tue, 15 Jul 2025 16:39:42 -0500 (CDT)
Date: Tue, 15 Jul 2025 16:39:42 -0500 (CDT)
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
Message-ID: <1210309411.1359866.1752615582001.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <1268570622.1359844.1752615109932.JavaMail.zimbra@raptorengineeringinc.com>
References: <1268570622.1359844.1752615109932.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH v3 6/6] PCI: pnv_php: Enable third attention indicator state
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC138 (Linux)/8.5.0_GA_3042)
Thread-Topic: pnv_php: Enable third attention indicator state
Thread-Index: XyF2OaMn/3q+H+nwsGaxXLVF4U4PFzXTlJEB

The PCIe specification allows three attention indicator states,
on, off, and blink.  Enable all three states instead of basic
on / off control.

This changes the userspace API to match the behavior of pcihp.

Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 drivers/pci/hotplug/pnv_php.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 3533f7f23b71..c65460ced862 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -441,10 +441,23 @@ static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
 	return ret;
 }
 
+static int pnv_php_get_raw_indicator_status(struct hotplug_slot *slot, u8 *state)
+{
+	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
+	struct pci_dev *bridge = php_slot->pdev;
+	u16 status;
+
+	pcie_capability_read_word(bridge, PCI_EXP_SLTCTL, &status);
+	*state = (status & (PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC)) >> 6;
+	return 0;
+}
+
+
 static int pnv_php_get_attention_state(struct hotplug_slot *slot, u8 *state)
 {
 	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
 
+	pnv_php_get_raw_indicator_status(slot, &php_slot->attention_state);
 	*state = php_slot->attention_state;
 	return 0;
 }
@@ -462,7 +475,7 @@ static int pnv_php_set_attention_state(struct hotplug_slot *slot, u8 state)
 	mask = PCI_EXP_SLTCTL_AIC;
 
 	if (state)
-		new = PCI_EXP_SLTCTL_ATTN_IND_ON;
+		new = FIELD_PREP(PCI_EXP_SLTCTL_AIC, state);
 	else
 		new = PCI_EXP_SLTCTL_ATTN_IND_OFF;
 
-- 
2.39.5

