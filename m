Return-Path: <linux-pci+bounces-25900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C06FAA89344
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 07:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71EA73B2B0A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 05:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774131DED40;
	Tue, 15 Apr 2025 05:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="F+NgVsKF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49243.qiye.163.com (mail-m49243.qiye.163.com [45.254.49.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F6E16F8E5;
	Tue, 15 Apr 2025 05:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744694351; cv=none; b=XQch7UXvC12doL84YPC/sE+J28+QqvMVb6PsM5dJHoMnEWExj+Uo56cOD5GBIn8u97fmwmB90Fm2tOpkUyFL/aiYOGOEKaMTO42LkBRW5qi13VMPT3gxUEoW6vywViL85KZ4KuoIRGDi72m3g9ANplm59K5+PULbhaRXRD3wkSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744694351; c=relaxed/simple;
	bh=qFpwIxLkmlRcCCP6YKJbRCtaUYx+YjnwiBqW5Uy6wK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aZcCh7oWsdwhsYmbhUMAt67s1Il79HzvtqmDGexpAwiXmbWeN0nIpd4jkfUc4RB3uZrVhD6wCpDPSrYtusYcMQtXfsLGgUbXzMJugNam+DHJzolrBtLYyK9ka3DjfBTPMgEjcfYEA4imbiZFi3CcvLykBeswDkgzofr4vpxYY8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=F+NgVsKF; arc=none smtp.client-ip=45.254.49.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [103.29.142.67])
	by smtp.qiye.163.com (Hmail) with ESMTP id 11e6d965f;
	Tue, 15 Apr 2025 13:19:02 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Rob Herring <robh@kernel.org>,
	Simon Xue <xxm@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/7] dt-bindings: PCI: dwc: rockchip: Add rk3562 support
Date: Tue, 15 Apr 2025 13:18:49 +0800
Message-Id: <20250415051855.59740-2-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250415051855.59740-1-kever.yang@rock-chips.com>
References: <20250415051855.59740-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGB0ZVhoZHx9PTkhCQxhKSVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+
X-HM-Tid: 0a9637e2f41403afkunm11e6d965f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mhg6DTo*NDJMMBoXCgxJCj1C
	SlYKCUNVSlVKTE9PTUJPSE9PTUpCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlNTEw3Bg++
DKIM-Signature:a=rsa-sha256;
	b=F+NgVsKFaUSn4Iwqzeyqodc6EoWQjFO6FCY9RXrhSGCiozim14KILpMuE5Z+P+/th0PILqxmSLTfrTS3kBbRbQsOM/p3wpJKe0CzBj+iLPMagIEYPRGTBHaSZlu4KOeG+FS5kjjj3aRSDFpApRV9lSlhxT9j8z1BfwMLopm3MJQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=b4p/0VxIff/BqHY5k/CUxFW5zZdAT12GHojWa2aHOQo=;
	h=date:mime-version:subject:message-id:from;

rk3562 is using the same dwc controller as rk3576.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---

Changes in v4:
- Collect ack tag;

Changes in v3:
- Rebase the change base on rk3576 pcie patches

Changes in v2: None

 .../devicetree/bindings/pci/rockchip-dw-pcie.yaml        | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
index 4764a0173ae4..6c6d828ce964 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -22,6 +22,7 @@ properties:
       - const: rockchip,rk3568-pcie
       - items:
           - enum:
+              - rockchip,rk3562-pcie
               - rockchip,rk3576-pcie
               - rockchip,rk3588-pcie
           - const: rockchip,rk3568-pcie
@@ -76,7 +77,9 @@ allOf:
         properties:
           compatible:
             contains:
-              const: rockchip,rk3576-pcie
+              enum:
+                - rockchip,rk3562-pcie
+                - rockchip,rk3576-pcie
     then:
       required:
         - msi-map
@@ -85,7 +88,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: rockchip,rk3576-pcie
+            enum:
+              - rockchip,rk3562-pcie
+              - rockchip,rk3576-pcie
     then:
       properties:
         interrupts:
-- 
2.25.1


