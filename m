Return-Path: <linux-pci+bounces-17456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322469DE886
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 15:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2922B2814E2
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 14:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303294EB45;
	Fri, 29 Nov 2024 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TiaZ+6LR"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A415C22F11;
	Fri, 29 Nov 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732890629; cv=none; b=jdm3l4sb0KJsykZlju/0jFpRpFM5HWk6ghsLcrto55wsZ6+ExFqlkZTjPHTSsPmIMfAtTLXcpK15C/GG7pL8F9mon12sblFqZV4FnxzPTroEVXCsyaJG46w0ysxt2vHfD+EeoV6RzCRxdFbp73CQ771rpSukkjWk6rwCPm2RG4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732890629; c=relaxed/simple;
	bh=mI5lNGIrvnI0wLhpmyliPfoiK6Sq0DOPlU9HeeBbUv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GQdKgGh6nF0eJcObTfrkhjTr+rD8cBq4TpLVKs5ZoQKTzhOhyTs4qx8feWHHhMk+5KX5rB+hnHCKNKWjxBfVgdQNo8mbpGCJvtg1oaX+xudNQyvyxxnyUDylJ84Q+bps1rcarr6VhuTPLHqNS7nUUYUKNU7SCvJ4Ev7jenejwgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TiaZ+6LR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 21D7F2053077;
	Fri, 29 Nov 2024 06:30:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 21D7F2053077
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1732890626;
	bh=H1vVof/2pGhOEr3SPl2kANibaYCZWE2/N5q2dIXVdV8=;
	h=From:To:Cc:Subject:Date:From;
	b=TiaZ+6LRwZ7YFh9p7IDMuGe+3Z6kp0kXBnNaVP6yxnu2W0mQq1KAspKAfOYqNSKf+
	 ufcEerFLuFrsI2IJP8L//soQPP9mK8vEswV/X0oyphYW5iIMK4WEusuu1u5XGrBAM1
	 HOiQfbKoWIudkE9IMaooc4A/prj5NYE31ai0v650=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: bhelgaas@google.com,
	kwilczynski@kernel.org,
	bartosz.golaszewski@linaro.org,
	manivannan.sadhasivam@linaro.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com
Subject: [PATCH] PCI/pwrctrl: Check the device node exist before device removal
Date: Fri, 29 Nov 2024 06:30:21 -0800
Message-Id: <1732890621-19656-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There can be scenarios where device node is NULL, in such cases
of_node_clear_flag accessing the _flags object will cause a NULL
pointer dereference.

Add a check for NULL device node to fix this.

[  226.227601] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000c0
[  226.330031] pc : pci_stop_bus_device+0xe4/0x178
[  226.333117] lr : pci_stop_bus_device+0xd4/0x178
[  226.389703] Call trace:
[  226.391463]  pci_stop_bus_device+0xe4/0x178 (P)
[  226.394579]  pci_stop_bus_device+0xd4/0x178 (L)
[  226.397691]  pci_stop_and_remove_bus_device_locked+0x2c/0x58
[  226.401717]  remove_store+0xac/0xc8
[  226.404359]  dev_attr_store+0x24/0x48
[  226.406929]  sysfs_kf_write+0x50/0x70
[  226.409553]  kernfs_fop_write_iter+0x144/0x1e0
[  226.412682]  vfs_write+0x250/0x3c0
[  226.415003]  ksys_write+0x7c/0x120
[  226.417827]  __arm64_sys_write+0x28/0x40
[  226.420828]  invoke_syscall+0x74/0x108
[  226.423681]  el0_svc_common.constprop.0+0x4c/0x100
[  226.427205]  do_el0_svc+0x28/0x40
[  226.429748]  el0_svc+0x40/0x148
[  226.432295]  el0t_64_sync_handler+0x114/0x140
[  226.435528]  el0t_64_sync+0x1b8/0x1c0

Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Krzysztof Wilczyński <kwilczynski@kernel.org>
Fixes: 681725afb6b9 ("PCI/pwrctl: Remove pwrctl device without iterating over all children of pwrctl parent")
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/pci/remove.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 963b8d2855c1..474ec2453e4b 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -21,6 +21,9 @@ static void pci_pwrctrl_unregister(struct device *dev)
 {
 	struct platform_device *pdev;
 
+	if (!dev_of_node(dev))
+		return;
+
 	pdev = of_find_device_by_node(dev_of_node(dev));
 	if (!pdev)
 		return;
-- 
2.43.0


