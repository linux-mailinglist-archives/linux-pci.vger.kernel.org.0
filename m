Return-Path: <linux-pci+bounces-6409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312928A9557
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 10:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B1E1F21BAB
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 08:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FC7158845;
	Thu, 18 Apr 2024 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Lfn+syQ8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="gmaJUfhe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901CF2E403;
	Thu, 18 Apr 2024 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430189; cv=none; b=l5RdX5UtuZ0Eq9/shUvRRJ0qKasYdZquQ1zuiEAaph9QAxLEE37nhAW8CED0eBXU6k5WlT0l7FXqR7Pop8VjTi85aVigKqGbRtK4Vna9opUYUSr/ZKR9pwTmxQ+GNsjz5MFqfaMsmJ6v28Pom4GPBrJ3XePI7ap1HBL1jX8ad4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430189; c=relaxed/simple;
	bh=v8ey8pLnPMHPS+YR/1R395XOGXpEXxuFJURGRT4H72I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kZILHP/4FpuUtF5Eww3WiV/lPuZKQwipLceaRZSviwyX+trdS3B8/wH3e9Rl3/aLP3sb/fM0PyIf82hxuXn2GVcQJX3NQWQtphELV1qF5obWqsGLHdpkDxefJvT7FDusGnuZeg97bVnCBhqNZnODA9XwHstBF4bdsAeMVso8Rjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Lfn+syQ8; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=gmaJUfhe reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713430186; x=1744966186;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3rUqLuOQrUnKu1iymZZlvviER4WCV8MyK6h8u/FdFt4=;
  b=Lfn+syQ8EubC45gL5m4s/yIW7BTTfqpF1/5BLodQxBS/fTEsmORcHYnq
   x07/33nFAkpk50ACmqVseBMBegpwh1uvLtHTaztJ6/ggjcd/Lxipq84ys
   rxrgJG5dmh1U3bA2nywsJCLCj6l6hdPfuXdJDw950wQr52mzOPLuPvxc6
   PIt6OvhzzHcfQODLgVhlRdvtOi61v3z36jxknOb4lqNaMEf367btbaAme
   FbGriJ2eSfYw/a3B7abAh03wOhdBSDnUQxtvQlEQWaij1o7tgABEfEK7B
   MHitRhvyhKL3mhXmrcd/VW7nuyoYQGjwMoTlOpEhelBhE+Tz5tvxjW2dh
   Q==;
X-IronPort-AV: E=Sophos;i="6.07,211,1708383600"; 
   d="scan'208";a="36485314"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 18 Apr 2024 10:49:37 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF0CD16FA86;
	Thu, 18 Apr 2024 10:49:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713430173; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=3rUqLuOQrUnKu1iymZZlvviER4WCV8MyK6h8u/FdFt4=;
	b=gmaJUfhel7zGiu146rY4WdAM+JHyFGnU+gzms20VAj9nOUGn5F5PXuxYyMH9vf0Rry2PDk
	K9ebc7TfHf+n6tUS4muncCeKzrsJiPa2VrXO1QtazGuwzQN+eZGSKRYZ+fFIGydcw7WLOo
	xI2HOaqLT2vD0E3iUbEMqUY0ccRHAseoxgHwO2XXGSncW2jXpvI55gTnRrR+r+kXCMsPl3
	+M9Oy4YjkPQP4FGRQaX6/YfMZKzar9bkeA/ViTWoXBnxZbw8WNHOi6L4seGkar1mey5XQ1
	Zq5uOHJai6Z6E3h8RLBmyW10NP18YFA/4fJNJ1v1oA/1Z4SsGZb167dyH0w8QA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] Documentation: PCI: pci-endpoint: Fix EPF ops list
Date: Thu, 18 Apr 2024 10:49:24 +0200
Message-Id: <20240418084924.1724703-1-alexander.stein@ew.tq-group.com>
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
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v3:
* s/config/configfs/ as suggested by Niklas
* Collected Niklas' and Manivannan R-b tags

Changes in v2:
* Separated paragraphs by blank line

 Documentation/PCI/endpoint/pci-endpoint.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
index 4f5622a655557..21507e3cc2385 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -172,8 +172,8 @@ by the PCI endpoint function driver.
 	 * bind: ops to perform when a EPC device has been bound to EPF device
 	 * unbind: ops to perform when a binding has been lost between a EPC
 	   device and EPF device
-	 * linkup: ops to perform when the EPC device has established a
-	   connection with a host system
+	 * add_cfs: optional ops to create function specific configfs
+	   attributes
 
   The PCI Function driver can then register the PCI EPF driver by using
   pci_epf_register_driver().
-- 
2.34.1


