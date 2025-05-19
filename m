Return-Path: <linux-pci+bounces-27995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6E5ABC3F8
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 18:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F3617E3E5
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 16:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE23928C875;
	Mon, 19 May 2025 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hchNlW0r"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1131528C5DA;
	Mon, 19 May 2025 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670736; cv=none; b=rf6yxfX6BWquseQ/QjcFk+yMoJn2IvNz9KNmjvGmMeUZJWMUWxxRi+VpOt6lapAl1sITtrfuKIAebyZWG88HM7yPHZGOW46RLKuZT3QAeHSBHXM+sCuQC3g2kmap5hITh1bDgg0OFLxNekqeMWvh8NDSvkJ54O5Uw86Tug5BG4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670736; c=relaxed/simple;
	bh=utww61uElrub22E1MtpRbKG8U//tpCzjiYPFEae5sdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=liv+dedAFB5nZlzVial7BcGa6uji/YvZlS50dW4Gn8GC64LqCTYEk0LD23eSytxPQGQ/+ZdgVEJeRUjyjQtcspoMmzVn16QZBEPRwCSjkLjAZ+E6ZFaMkgJ7ZYIDTfcEZGU60ERl6ADlR/IAjTWRvVE76PvcX4eCX/QL1FmrlLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hchNlW0r; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=oo
	uxVGY9XhCCHgWc5NChF1kCY5VbzSOry8izreFrBRM=; b=hchNlW0rfDP0lWU9+9
	o4ruyDnnNyJCfloNN6GehWGo93BY/ouon5u03oY4ElbZU+vMZ7s2uToixTsdEMHG
	ja3+kDv7DwTSEjIpJs8rdq+tss/4YNJ0CkGTuzD8/nXGarI12BM3/I6aTlhatKqY
	6w74SO3vtfEQd9n68VRoCC0hg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDHWSeiVitokozvCQ--.46206S3;
	Tue, 20 May 2025 00:04:52 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	krzk+dt@kernel.org,
	manivannan.sadhasivam@linaro.org,
	conor+dt@kernel.org
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 1/3] dt-bindings: PCI: Extend max-link-speed to support PCIe Gen5/Gen6
Date: Tue, 20 May 2025 00:04:46 +0800
Message-Id: <20250519160448.209461-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250519160448.209461-1-18255117159@163.com>
References: <20250519160448.209461-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHWSeiVitokozvCQ--.46206S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4DuF1xZF1Dtw1rGFWkCrg_yoW8XF18pa
	y8CFyxtrW8Gr17W3ykXw1fAw4jqas3AayjkF98K3srtanxA3ZYyw43KFn8XF1xArWxZFW8
	XF4Y9F15Cw1DAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piyrWcUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgFSo2grT8qd+AAAsp

Update the device tree binding documentation for PCI to include
PCIe Gen5 and Gen6 support in the `max-link-speed` property.
The original documentation limited the value to 1~4 (Gen1~Gen4),
but the kernel now supports up to Gen6. This change ensures the
documentation aligns with the actual code implementation.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 Documentation/devicetree/bindings/pci/pci.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index 6a8f2874a24d..5ffd690e3fc7 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -22,8 +22,9 @@ driver implementation may support the following properties:
    If present this property specifies PCI gen for link capability.  Host
    drivers could add this as a strategy to avoid unnecessary operation for
    unsupported link speed, for instance, trying to do training for
-   unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
-   for gen2, and '1' for gen1. Any other values are invalid.
+   unsupported link speed, etc.  Must be '6' for gen6, '5' for gen5, '4' for
+   gen4, '3' for gen3, '2' for gen2, and '1' for gen1. Any other values are
+   invalid.
 - reset-gpios:
    If present this property specifies PERST# GPIO. Host drivers can parse the
    GPIO and apply fundamental reset to endpoints.
-- 
2.25.1


