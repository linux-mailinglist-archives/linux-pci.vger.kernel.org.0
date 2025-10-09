Return-Path: <linux-pci+bounces-37745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E62BC71D4
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 03:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EC184E2629
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 01:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0F1F9C1;
	Thu,  9 Oct 2025 01:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="j2BraAd6"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A3D4C9D;
	Thu,  9 Oct 2025 01:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759973563; cv=none; b=usmOE8Gl1Lfo3KvrxvFF+advZHEyTCkKqDxdB5mRU7X0mTduZk4Hgu9FdZkAU5lZ89/B0qPg1V5jcetmUF+H00P6pnptpG6aQoJNwvk+Mp+kC0RuQfXBp/nSaUjvPKkQfA2+UwrvrExxCYHNdBG5PwQm0E5OCt15T01HVWngDZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759973563; c=relaxed/simple;
	bh=d57SCnCWxxiMpTZ5LqGems0CEklPoPhYbxwpDIfw4Mc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=bn+CHoEYvJsxj9rxYAeY2yyQX9t4sB0KGWXOgJY1Fh7RoY3EWTrVJa7jixhneWj4zqc0fluwC5ywt/fFQHT6dNpxBFdk0wRTfZ0zPdkGMUyUbYmLdMxIID+VXqw/cAoW2ydxUc+BY/kSD3XvUUNQ6JjBBJ5X1hnFQ7pLpDoIvKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=j2BraAd6; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 0ACFF8285375;
	Wed,  8 Oct 2025 20:24:12 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ry9d_JeTyqY6; Wed,  8 Oct 2025 20:24:11 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id F01058285568;
	Wed,  8 Oct 2025 20:24:10 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com F01058285568
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1759973051; bh=wH76QaA6cQIIFmvkWPd3MSINH29g1dYAewLynal9CZ0=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=j2BraAd69mxGNQJsEoom0NyNyG9ejKh734vs/s2BpNIRoNSbW3fI1tPNQy+XxhZCs
	 iBwvnIpgfcVeqTzgfw1wpMa0pcE4SvTFc8sZspS9xBW4u3/6r4Ahxz/rTW31bpieHj
	 Rm2AT1k041TXB5tuLhaG7HnVmFRZPEXJr9Q/q3Ps=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GmGs_Ytpky-r; Wed,  8 Oct 2025 20:24:10 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id B455B8285375;
	Wed,  8 Oct 2025 20:24:10 -0500 (CDT)
Date: Wed, 8 Oct 2025 20:24:08 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	christophe leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Shawn Anastasio <sanastasio@raptorengineering.com>
Message-ID: <97746540.1782404.1759973048120.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <304758063.1694752.1757427687463.JavaMail.zimbra@raptorengineeringinc.com>
References: <1268570622.1359844.1752615109932.JavaMail.zimbra@raptorengineeringinc.com> <2013845045.1359852.1752615367790.JavaMail.zimbra@raptorengineeringinc.com> <bf390f9e-e06f-4743-a9dc-e0b995c2bab2@kernel.org> <304758063.1694752.1757427687463.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH] PCI: pnv_php: Fix potential NULL dereference in slot
  allocator
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC141 (Linux)/8.5.0_GA_3042)
Thread-Topic: pnv_php: Fix potential NULL dereference in slot allocator
Thread-Index: zJ41UwgzYhwlCvtgYnXhkcd+rlAB7J0jwKRh

A highly unlikely NULL dereference in the allocation error handling path was
introduced in 466861909255.  Avoid dereferencing php_slot->bus by using
dev_warn() instead of SLOT_WARN() in the error path.

Fixes: 466861909255 ("PCI: pnv_php: Clean up allocated IRQs on unplug")
Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 drivers/pci/hotplug/pnv_php.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index c5345bff9a55..f735935d80e7 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -804,7 +804,7 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
 	/* Allocate workqueue for this slot's interrupt handling */
 	php_slot->wq = alloc_workqueue("pciehp-%s", 0, 0, php_slot->name);
 	if (!php_slot->wq) {
-		SLOT_WARN(php_slot, "Cannot alloc workqueue\n");
+		dev_warn(&bus->dev, "Cannot alloc workqueue\n");
 		kfree(php_slot->name);
 		kfree(php_slot);
 		return NULL;
-- 
2.39.5


