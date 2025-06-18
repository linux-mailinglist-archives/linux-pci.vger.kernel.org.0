Return-Path: <linux-pci+bounces-30100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6C9ADF335
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 18:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF77B7AE33B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 16:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C3A2FEE29;
	Wed, 18 Jun 2025 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="LFEN0DId"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D3F2FEE36;
	Wed, 18 Jun 2025 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265841; cv=none; b=LJDXUEd0r1Ww83Ep3tQFuUQ+hbpVaZgCZ8D+PQkvGedtNBR7pVN8/XPPMqMLXTS/hAMixzNMD8gAZj0dHyMMHHLyGhhQa+roZj8CBA/2Rr1jM4tZSQo1uqGo3v7888J01wTPKmUiSrBZm9DBz1befVbPmcoVxf1Acd0ZW2FzjTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265841; c=relaxed/simple;
	bh=EBV0EZxvuUqV5iGLVkQC/Gh2UeJ/c8RB1TdSZu699iE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=JhL7D3SSbLVsFKE3rASt9oVHVZN5Pr8u/7UhEPWyO6ALthh0/v//UV5g4tURu6YAUCfT1mCiJwdSUsfffpPtx3UlFAhj9t8lr4XOm5V0cHgBhgzC4tPsyWAMOdYnPiFyscPUhtLBdtRV9+4ZvpMQG7X8f4N7tU4a9M08KvZY8OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=LFEN0DId; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id C20468286FBD;
	Wed, 18 Jun 2025 11:57:17 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id kRel1SYbqiIX; Wed, 18 Jun 2025 11:57:17 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 319628287179;
	Wed, 18 Jun 2025 11:57:17 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 319628287179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1750265837; bh=USAGms6qzWe7rESrb9AGGpmLmspKTjgFGVbO0Q+1BzA=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=LFEN0DId7062kxNccMz/LnwhOwiWj4dMzKqnwFilyzqXGLpDuVEf3XpD8iZU4T0Nu
	 n4Q2hgjUDoFxzS35f4zaig8s01sjPr2hz56/z6acnphLNHLFa6qNIQQjPU91iSiXkx
	 Owd0NK0N5atfBk+HRHI+GZPxt1eeJZTgBsSC3FeI=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JsKIlELgcYoO; Wed, 18 Jun 2025 11:57:17 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id EDA928286FBD;
	Wed, 18 Jun 2025 11:57:16 -0500 (CDT)
Date: Wed, 18 Jun 2025 11:57:16 -0500 (CDT)
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
Message-ID: <374686472.1310637.1750265836363.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <581463409.1310624.1750265668004.JavaMail.zimbra@raptorengineeringinc.com>
References: <581463409.1310624.1750265668004.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH v2 3/6] powerpc/eeh: Export eeh_unfreeze_pe()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC137 (Linux)/8.5.0_GA_3042)
Thread-Topic: powerpc/eeh: Export eeh_unfreeze_pe()
Thread-Index: 7ViWVrejj338yZQm64sXoMCfdWvE4GWR/U+K

The PowerNV hotplug driver needs to be able to clear any frozen PE(s)
on the PHB after suprise removal of a downstream device.

Export the eeh_unfreeze_pe() symbol to allow implementation of this
functionality in the php_nv module.

Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 arch/powerpc/kernel/eeh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 83fe99861eb1..3a2a926fbd64 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1139,6 +1139,7 @@ int eeh_unfreeze_pe(struct eeh_pe *pe)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(eeh_unfreeze_pe);
 
 
 static struct pci_device_id eeh_reset_ids[] = {
-- 
2.39.5

