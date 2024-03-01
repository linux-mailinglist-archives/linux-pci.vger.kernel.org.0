Return-Path: <linux-pci+bounces-4306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CF186DFC2
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 12:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 558C2B22761
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 11:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C0F6BFC6;
	Fri,  1 Mar 2024 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="kxy+jk46";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="cRTusQOj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8742E6BFA4;
	Fri,  1 Mar 2024 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709290816; cv=none; b=iPOx9Jc9CJIYnmIpiW/8L6HIkW6LnNrF4WraFhnmfVGq0s4eg2pWh2CSgrmXy1mbALOKzCWLF/6AnLWgw+/bloWpWSceepiRQKB8NAYdYddQiTYLDO1Ih7BU1ckLLPFbDF2SR3zVj/JTyBiZSl6nY/fv/NZSChYhVLLUWtKdoYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709290816; c=relaxed/simple;
	bh=I5D/3bnobwX7Ac7UCTSuLIAQ+6CbQGakUtamhWU7l+U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R6Z371UKT0xfFgbGtnSvIef4L919DnfBahuw9AwnF5LJeDYqlX1qU/01Zb+40nXWPQMkI3h5ogECsGzB3lq/VbKdcx6CFOqFofuXuMruV1xWUraa5lQz68nXNlJfW+l/GgJMmwidjsi/bXxywxl4B+6x/LCnRxht/w0AGwHuAdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=kxy+jk46; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=cRTusQOj reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1709290813; x=1740826813;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KWn9ETWMYyllftRlcaccANwIUfLMZ+9SpbMVRaxzAaU=;
  b=kxy+jk46WunQb7ZHcckVJni24kTsAMH0bSvElUathH+aDqWvmfQ6+Rta
   NhDjVrLJbedKqo5l96eOcLsA4L7CtC449VpJsZTmmww1YuRujQ8t8bGFR
   A5gfL5FA05Oi+Vbs0AeNvvHBse3rGLp5xwD9UeB6r+tWgjE6FqEnfp2PX
   PMhOgVrAAn3yeSfEYIo5wnc345Z9BuWL6kWqrQq283UuVyRYDQLnemA6n
   9G0gW5A9OcDzw4RcCHeRtYBINn8S112HDxFAXuJ/shvEEjB0Y7Msm4ODr
   SIK/DD0BaSGjxa5aTiBhBO7GeR/jfksjZZm0/uZPFneeBDwIiuA1Ql8aK
   w==;
X-IronPort-AV: E=Sophos;i="6.06,196,1705359600"; 
   d="scan'208";a="35687114"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 01 Mar 2024 12:00:03 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0B0D16C8AA;
	Fri,  1 Mar 2024 11:59:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1709290798; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=KWn9ETWMYyllftRlcaccANwIUfLMZ+9SpbMVRaxzAaU=;
	b=cRTusQOjduvkeIJfyRpgrpOJXYbw/zx0QcKrOmrHfXpsRdbnajlxBdc0NI/0tzRlWCJA45
	O010j5cejFcrVUAQcB1k3+mEm2jQHjDxQkgfwvvhHun9s5wvQ04Lw0hqxQ5Q8LP/eJNdSx
	e9tSNOyvsi6M3LjHeL8VrRZ0HwRcKNZSlfPfcq6pKN/gRZ5lxCc65ENO0G+l2NDf5wU4xx
	u6XxElgnGGvqeVHaRaHf198Aziqj0uGUgFqyfz+4tzy0+Qoc1tHrUynEtfUA1wrqouWxVP
	KJR5S85Ega5mIIO+SxgQTgT6ymAGJE1/kCOPxBu88sAg5Mw/7lObSz4ipSmDXg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Documentation: PCI: pci-endpoint: Fix EPF ops list
Date: Fri,  1 Mar 2024 11:59:50 +0100
Message-Id: <20240301105950.3067029-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

With commit 5779dd0a7dbd7 ("PCI: endpoint: Use notification chain
mechanism to notify EPC events to EPF") the linkup callback has been
removed and replaced by EPC event notifications.
With commit 256ae475201b1 ("PCI: endpoint: Add pci_epf_ops to expose
function-specific attrs") a new (optional) add_cfs callback was added.
Update documentation accordingly.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 Documentation/PCI/endpoint/pci-endpoint.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
index 4f5622a655557..3961ff4e5bebf 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -172,8 +172,7 @@ by the PCI endpoint function driver.
 	 * bind: ops to perform when a EPC device has been bound to EPF device
 	 * unbind: ops to perform when a binding has been lost between a EPC
 	   device and EPF device
-	 * linkup: ops to perform when the EPC device has established a
-	   connection with a host system
+	 * add_cfs: optional ops to create function specific config attributes
 
   The PCI Function driver can then register the PCI EPF driver by using
   pci_epf_register_driver().
-- 
2.34.1


