Return-Path: <linux-pci+bounces-32196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 906B9B068A8
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 23:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE566563EA6
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 21:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE6229B8E4;
	Tue, 15 Jul 2025 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="BixKi5jV"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DD41C4A24;
	Tue, 15 Jul 2025 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752615457; cv=none; b=nSrHYUPdDa6oLcUBcxIZb1gZt/+o/jBaIrbuo/ccBJIiNGDs+4xA7HkQ6RXt/F4o0o/kMGJMYCneHgzgkkNzX7//e589mOyl4yIVyYXeFKRUT48HWl65R0IqDhnpo2FgWL/k81X5ZzNMt8RbpfjQCwGomlWyoXH9rtRfW77cVWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752615457; c=relaxed/simple;
	bh=gzsomBt1JFxUGu+9kwXv3urclaJVHAULxqDXl7LM9wM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qKoie3wY0CTY4qc0QUweFAV9ld4vesBYbAhqONMjznJeXNdv/woxR6ExcyqhsYxneCPjZM5IWTzZMbkYAJn9YfmaDasBBPg2BbOT38lo0KRR+9CwDZrMuBjTkhHaw1CTgBSGhDUKbCLo5nCVnAlmbj+2a+h2cy+TJFKt79NOXgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=BixKi5jV; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 8008B8287698;
	Tue, 15 Jul 2025 16:37:35 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id DXqvs6LDPYCI; Tue, 15 Jul 2025 16:37:35 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id E43148288591;
	Tue, 15 Jul 2025 16:37:34 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com E43148288591
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1752615454; bh=a/RHOZtuKI3IFnHAVZbUtLVWSIeWz5dK8J8PMYUdjSM=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=BixKi5jVzM1CraSKJsc/j0p65Q52gyeo3hTO/e4RST7uJhulhOPSkAzgY8mRW6vA6
	 vrsf58GgVMF8udf1XFP+aOqazqL/HsM3bZiTasLSxvthaY/FcScEKMms6dhypiuSxs
	 e3AJxjNziEmTIAPWG13wC8PSWiCGbb6zd1YBUPSQ=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jUiqRAhxzMqk; Tue, 15 Jul 2025 16:37:34 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id AB7398287698;
	Tue, 15 Jul 2025 16:37:34 -0500 (CDT)
Date: Tue, 15 Jul 2025 16:37:34 -0500 (CDT)
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
Message-ID: <1778535414.1359858.1752615454618.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <1268570622.1359844.1752615109932.JavaMail.zimbra@raptorengineeringinc.com>
References: <1268570622.1359844.1752615109932.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH v3 3/6] powerpc/eeh: Export eeh_unfreeze_pe()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC138 (Linux)/8.5.0_GA_3042)
Thread-Topic: powerpc/eeh: Export eeh_unfreeze_pe()
Thread-Index: XyF2OaMn/3q+H+nwsGaxXLVF4U4PF4wBZI2J

The PowerNV hotplug driver needs to be able to clear any frozen PE(s)
on the PHB after suprise removal of a downstream device.

Export the eeh_unfreeze_pe() symbol to allow implementation of this
functionality in the php_nv module.

Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 arch/powerpc/kernel/eeh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index ca7f7bb2b478..2b5f3323e107 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1139,6 +1139,7 @@ int eeh_unfreeze_pe(struct eeh_pe *pe)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(eeh_unfreeze_pe);
 
 
 static struct pci_device_id eeh_reset_ids[] = {
-- 
2.39.5


