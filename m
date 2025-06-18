Return-Path: <linux-pci+bounces-30000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3469ADE24F
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 06:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8133B10DF
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 04:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439F51E3DF2;
	Wed, 18 Jun 2025 04:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="dTlfwXTN"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8171C5496;
	Wed, 18 Jun 2025 04:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750220562; cv=none; b=hseYSuvXR8FC6owQQ3ohZ7e4C6BiJ6Jrcbs2CVjnsGXs5sATuv79aYhLxoGK6+QySoJu7RUpIxzHM5MVVark6YOJj/92VRsd5nZeDNUf2ZI2ZhFZxckf21gaEQRSwGTOrFezsYs6jHPTv/VvlWBH3vcckQ5ssNREvMuO8KTyhfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750220562; c=relaxed/simple;
	bh=Bv0k7ERKHtFA6wHZXw0N2ETAUakd08PIls+issM1ZkI=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=Nh0+alnzCwGxQcEQvoS2zEgUglEb35WU02tEgV1RCsfgKR7khJyIpZEBn65cWniGvdWXK4koRI7G0FgMR+zIttajPCU+YCsS3Av+sd5+iBv20qD4PyV46J0EfixblFwZDBXeNx1IDkvg7EpMoPsO55EJZo8oYsQVSf6HsT+HJJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=dTlfwXTN; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id F247682887A2;
	Tue, 17 Jun 2025 23:22:39 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id CfkGZkyyXleX; Tue, 17 Jun 2025 23:22:39 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 69C74828884A;
	Tue, 17 Jun 2025 23:22:39 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 69C74828884A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1750220559; bh=JG6PHstQI5H5oe+I9jfK74vnZjEQG60lz7/1SwQnFDg=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=dTlfwXTNhotmxPS8lPKUJoJuLSjqgLezi0BQoMDnf3aivYJOK48S/RQqQL7YclVww
	 xnII/qbAAfOW1hqY4iXTQZw3RZwBEVRAIlQ7ahAiFK8kGCNiMZyW3VC97if2NqnYgv
	 apR1VLuk76oHJqGB+376zkfA/IH+xd03H4NOUdAY=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gDPUZFqiqKn5; Tue, 17 Jun 2025 23:22:39 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 402A082887A2;
	Tue, 17 Jun 2025 23:22:39 -0500 (CDT)
Date: Tue, 17 Jun 2025 23:22:39 -0500 (CDT)
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
Message-ID: <946966095.1309769.1750220559201.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH 3/8] powerpc/pseries/eeh: Export eeh_unfreeze_pe() and
 eeh_ops
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC137 (Linux)/8.5.0_GA_3042)
Thread-Index: Jx2/bwZfy/PY/F2nzIG8e+jlRecltQ==
Thread-Topic: powerpc/pseries/eeh: Export eeh_unfreeze_pe() and eeh_ops

The PowerNV hotplug driver needs to be able to detect and clear any
frozen PE on the PHB after suprise removal of a downstream device.

Export the eeh_unfreeze_pe() and eeh_ops symbols to allow implementation
of this functionality in the php_nv module.

Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 arch/powerpc/kernel/eeh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 83fe99861eb1..543d8323c1fb 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -107,6 +107,7 @@ bool eeh_debugfs_no_recover;
 
 /* Platform dependent EEH operations */
 struct eeh_ops *eeh_ops = NULL;
+EXPORT_SYMBOL(eeh_ops);
 
 /* Lock to avoid races due to multiple reports of an error */
 DEFINE_RAW_SPINLOCK(confirm_error_lock);
@@ -1139,6 +1140,7 @@ int eeh_unfreeze_pe(struct eeh_pe *pe)
 
 	return ret;
 }
+EXPORT_SYMBOL(eeh_unfreeze_pe);
 
 
 static struct pci_device_id eeh_reset_ids[] = {
-- 
2.39.5

