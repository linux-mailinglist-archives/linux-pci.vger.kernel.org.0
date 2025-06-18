Return-Path: <linux-pci+bounces-30103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6352CADF343
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 18:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFCCA1657D1
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 16:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F312FEE1B;
	Wed, 18 Jun 2025 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="A2Hd7zzk"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE502FEE2A;
	Wed, 18 Jun 2025 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265942; cv=none; b=aFdI6eB6EUa9V4jrk2hWiV5wAnq9uG50SD+o6xNBAw1N1OeaGmVcn1DjU1ZCt6ZHD4Q/L74r5ATt3Mm1HuVVRIYnh9OE0a9dqTGFI7cU65238EHmcew2Pti9GH8+WbJdTZ2AfqRUEm/4bx2X7cee7VwfXpzPhghY9fcxEwvFqBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265942; c=relaxed/simple;
	bh=xFaKsIUdVbLbloNEcOi9HJOJURbTFqzaCVjp5Ps04vY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=aHCpXR5FqCUcrzsVsgR6un4Lt1U6icAopjx7Jn0LI7NQWzx+03OxgQQI70En+NeLVkxzxcynFhhwJapOMlypIeuefBaafa2jk7l3JFADxhVFIjITQ7SO707OrRvkRmmELjwqr4aFDgkjkgbYMpba556Fj0/uqQDB72eUcfDW+Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=A2Hd7zzk; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 5F8A98288467;
	Wed, 18 Jun 2025 11:59:00 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 4xfm3ULz_6Gq; Wed, 18 Jun 2025 11:58:59 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 783828288670;
	Wed, 18 Jun 2025 11:58:59 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 783828288670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1750265939; bh=OlONqedgdZu8PeQ6IQKPSJGIJsQmR5PwabMbkbNrUiE=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=A2Hd7zzkPPZn5qnkUjG1tOwsNtgyxueq7hUjeHQEDPQEh6dHZ8JNQWk+g6ZOm+rFY
	 gbDwIHh6+nBmg3hjk6V5VK1mfM/a65FORGDtjcz13dn35Em98yVI6Mggi/ASkT5uNr
	 P5izOOF6fFUQjfdI0pnJjrIWAmtMJz/yc9R/IDgI=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mxrrclct1c8B; Wed, 18 Jun 2025 11:58:59 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 4EBDA8288467;
	Wed, 18 Jun 2025 11:58:59 -0500 (CDT)
Date: Wed, 18 Jun 2025 11:58:59 -0500 (CDT)
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
Message-ID: <300098407.1310656.1750265939231.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <581463409.1310624.1750265668004.JavaMail.zimbra@raptorengineeringinc.com>
References: <581463409.1310624.1750265668004.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH v2 6/6] pci/hotplug/pnv_php: Enable third attention
 indicator
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC137 (Linux)/8.5.0_GA_3042)
Thread-Topic: pci/hotplug/pnv_php: Enable third attention indicator
Thread-Index: 7ViWVrejj338yZQm64sXoMCfdWvE4ADzdyG8

 state

The PCIe specification allows three attention indicator states,
on, off, and blink.  Enable all three states instead of basic
on / off control.

Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 drivers/pci/hotplug/pnv_php.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 0ceb4a2c3c79..c3005324be3d 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -440,10 +440,23 @@ static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
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
@@ -461,7 +474,7 @@ static int pnv_php_set_attention_state(struct hotplug_slot *slot, u8 state)
 	mask = PCI_EXP_SLTCTL_AIC;
 
 	if (state)
-		new = PCI_EXP_SLTCTL_ATTN_IND_ON;
+		new = FIELD_PREP(PCI_EXP_SLTCTL_AIC, state);
 	else
 		new = PCI_EXP_SLTCTL_ATTN_IND_OFF;
 
-- 
2.39.5

