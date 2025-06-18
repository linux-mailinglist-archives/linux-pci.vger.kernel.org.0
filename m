Return-Path: <linux-pci+bounces-30003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237ABADE258
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 06:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BB117B889
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 04:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BF01C5496;
	Wed, 18 Jun 2025 04:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="RW36JUNL"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9273882866;
	Wed, 18 Jun 2025 04:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750220645; cv=none; b=TsDZjg/FFBk8oX9Lne4Y1AMWBoF7u0/sj+FsIjMeKeUu8yLXiWUBf8eiesFyGVPKBoHhVvQ8GBg+/vLuULiERW2RHBSJY1b2pn06Pmh7Miox0G5wx/IknFXqpdMcFsq7PnoDHoVg+QUZaBRq+8ENcdorLS13OEE+ctZzZH5Ek5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750220645; c=relaxed/simple;
	bh=mr5xkyIYAENNMenKiuaHIxWlFKxW3ImXxL3lR0fLT2s=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=EV8RFSBEtdD2Z2S1sXyl7ouR4zV6nNpPld4Gh6+BYkE81W1zzMurH+9Z/iE1x22++nShh8oYuv/sBMNH045x4QtjpDvOsWlJIvfs67sa1fB+zS5ljE5yG0BE5O1AfCcRO56x3ZqfGEBzCX8sDkHmzycmX0We7pXKgecu3Px3BHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=RW36JUNL; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id E18E48288AE9;
	Tue, 17 Jun 2025 23:24:02 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id SHe2gD1KcKYp; Tue, 17 Jun 2025 23:24:02 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 2D8B0828884A;
	Tue, 17 Jun 2025 23:24:02 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 2D8B0828884A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1750220642; bh=o/1IBINWMrVso6KNgb8gMd8huCPM66zxZkZ7bvMLpVQ=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=RW36JUNLcwayc7jLDx4GGxx7gpPVeCgX7oRK9NAHzdXjX3NlU2uTf2M0zh+meeOkr
	 BbL5v/HpIJTvlA0dwagL8ZTWhq9ox2vo6fh12OSC6njlxTAHqx6++MkngJKN7ktOC6
	 RWvUpioRJsl7IOWxhc8f9F4B4SYoU2jRcSl0LHxE=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9wY7-oK45MhH; Tue, 17 Jun 2025 23:24:02 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 0748082887A2;
	Tue, 17 Jun 2025 23:24:02 -0500 (CDT)
Date: Tue, 17 Jun 2025 23:24:01 -0500 (CDT)
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
Message-ID: <1984998826.1309773.1750220641884.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH 6/6] pci/hotplug/pnv_php: Enable third attention indicator
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC137 (Linux)/8.5.0_GA_3042)
Thread-Index: eLJahenhbKp2Kz5NYOtowJbZINMJBw==
Thread-Topic: pci/hotplug/pnv_php: Enable third attention indicator

 state

The PCIe specification allows three attention indicator states,
on, off, and blink.  Enable all three states instead of basic
on / off control.

Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 drivers/pci/hotplug/pnv_php.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 32f26f0d1ca6..c9003dec91c3 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -3,6 +3,7 @@
  * PCI Hotplug Driver for PowerPC PowerNV platform.
  *
  * Copyright Gavin Shan, IBM Corporation 2016.
+ * Copyright (C) 2025 Raptor Engineering, LLC
  */
 
 #include <linux/bitfield.h>
@@ -439,10 +440,23 @@ static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
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
@@ -460,7 +474,7 @@ static int pnv_php_set_attention_state(struct hotplug_slot *slot, u8 state)
 	mask = PCI_EXP_SLTCTL_AIC;
 
 	if (state)
-		new = PCI_EXP_SLTCTL_ATTN_IND_ON;
+		new = FIELD_PREP(PCI_EXP_SLTCTL_AIC, state);
 	else
 		new = PCI_EXP_SLTCTL_ATTN_IND_OFF;
 
-- 
2.39.5

