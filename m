Return-Path: <linux-pci+bounces-7052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBE18BB3E5
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 21:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8823B241BE
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 19:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B977158874;
	Fri,  3 May 2024 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DBYVdxGW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0rqJFfKw"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7AE158844;
	Fri,  3 May 2024 19:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764210; cv=none; b=S/nkQf9IoduGsw2dwk4qGriVPDtk+XRKMqBYqCEWdfPOmy6UVuCmgmnRABMVlZvR7hc+P8PpLFDlLNiHTVFLsZ8mEoC36KmddK37E2U03wwvfc1bu6wwW6I69dZq7D+KVCVFFbf2zLFRGO6sLRmEQ+3LYwLNH+zbJDrzNSj6SjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764210; c=relaxed/simple;
	bh=JCwptbYruZjLqAtDL8TMWBeSIo+hkKvgWUdTdyJjyWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U0gaKHnw7IJ8BbxtClb/payzvCnNbP3S0Rp4UoMTeRDWVSof64ggeVjuZz5hHQACUKIZIBQdntLDnYzNXAKE4eDZoQKjcl7/OAUs+LoiD7Al1aywZ2V88fKL3s9cenIyPhyRfhN7WX8DwzIiw4aMlMP4cShVovawORlKgeTjq90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DBYVdxGW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0rqJFfKw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714764207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fc/r1OuWuEM/vzF5SITTG0OBh6zAtXYqIGqImW4XVPw=;
	b=DBYVdxGWNWaIJO+Zj8D+xlgfP+PZCeRi/A8087FnCrA13r3/+92+fF7V+NpSJKFUHaOGaH
	BWgrNrlCefUGHUTzi4i5inwViqOnTidI3G+sfqU5pLWxj1u9zo/VrWu6nCDHgeF337dAVJ
	j6DqbLPDu1l8thP9lQb3bVI5EEAHx/BmW+CMFo5dXR36/yWAlO004ClGbesJibw2y8vseK
	eOCKXo5XC8lAw27azVWaTtrlINiza0AhZ90wSPQjZwpy8fOfdo6+eqL8hRy4N9/c0VZ/DT
	AZIIVgDpR+JdvrCMmit7cyTT0aQxXWA0QU84EUDb/WrrPBNY+xLUDnVVUcXr+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714764207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fc/r1OuWuEM/vzF5SITTG0OBh6zAtXYqIGqImW4XVPw=;
	b=0rqJFfKwH8JGJ97Gnij8Qy15fC1+b170+RIXO5lheI+z1l6YJMrj0wysu0NUdWtpfnfWZD
	xghuX+hoBYZ2q/DA==
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rajesh Shah <rajesh.shah@intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 3/4] PCI: hotplug: document unchecked return value of pci_hp_add_bridge()
Date: Fri,  3 May 2024 21:23:21 +0200
Message-Id: <16a2442ea6ee896987a44df3ed509e4cfde44475.1714762038.git.namcao@linutronix.de>
In-Reply-To: <cover.1714762038.git.namcao@linutronix.de>
References: <cover.1714762038.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some hotplug drivers do not check the returned value of
pci_hp_add_bridge(). This may be probmatic if the driver proceed while
pci_hp_add_bridge() fails.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/pci/hotplug/TODO | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/hotplug/TODO b/drivers/pci/hotplug/TODO
index fdb8dd6ea24d..f0a1746c3c88 100644
--- a/drivers/pci/hotplug/TODO
+++ b/drivers/pci/hotplug/TODO
@@ -6,6 +6,8 @@ cpcihp:
   ->set_power callbacks in struct cpci_hp_controller_ops.  Why were they
   introduced?  Can they be removed from the struct?
 
+* Returned code from pci_hp_add_bridge() is not checked.
+
 cpqphp:
 
 * The driver spawns a kthread cpqhp_event_thread() which is woken by the
@@ -16,6 +18,8 @@ cpqphp:
 * A large portion of cpqphp_ctrl.c and cpqphp_pci.c concerns resource
   management.  Doesn't this duplicate functionality in the core?
 
+* Returned code from pci_hp_add_bridge() is not checked.
+
 ibmphp:
 
 * Implementations of hotplug_slot_ops callbacks such as get_adapter_present()
@@ -43,6 +47,8 @@ ibmphp:
 * A large portion of ibmphp_res.c and ibmphp_pci.c concerns resource
   management.  Doesn't this duplicate functionality in the core?
 
+* Returned code from pci_hp_add_bridge() is not checked.
+
 sgi_hotplug:
 
 * Several functions access the pci_slot member in struct hotplug_slot even
-- 
2.39.2


