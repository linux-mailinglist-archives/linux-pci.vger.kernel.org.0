Return-Path: <linux-pci+bounces-27997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53287ABC420
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 18:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 708277AB376
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 16:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C2528CF51;
	Mon, 19 May 2025 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XH/baRnp"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63F528C5CA;
	Mon, 19 May 2025 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670736; cv=none; b=ZueXbzwGtHbrxycSGhCja5EUFqnwvwK485KEFJUL/y7emJvtGF+XsMSj/TjeZGoTaX8bedRkHFGm/RwgDsaD6sOX8l+liy7glF1lGqvJG5HXOJV0otscuKbToWXXvhah21mLmOFcL8sb0XlSyproUePvOoSnX6FUcfMqkTk+iyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670736; c=relaxed/simple;
	bh=UamZjfyN6na3p67Dkavvu/KY840DiztSpAhsgs34BpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p/in6YiAkIZk+c2pP6yOhzgjbKpOPn88CotD6uCAZZbxozknTqJC7uVF7DpPrLXD4C2XGXYReiIrxLdM/rxdPxZ1Q0bWurnKkE8OX+fW3yGpMmcU+307udqJ0zw2CCOrTcUJCcuUMhBs7fgcupr7xP010LZFsaThSwmPwchi4tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XH/baRnp; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ij
	u8xELG4+fnR3215qcICf+KmnT2kIbCVpbjooreXLw=; b=XH/baRnpZkoCFnUWlI
	8PdkaQFL2V/4NL010Kv9mP+kS7L9tWiD9zon/IGFbi2vFhromKdjzouFPXBemLel
	6fbPRXYIQjeqk79VmduLST9cOJzdtEaO2yDwYTX7iFD+Ay+S2STALDoC1QQLSOw6
	4c02GN5P1jtwdXWGlpED4V3ms=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDHWSeiVitokozvCQ--.46206S5;
	Tue, 20 May 2025 00:04:53 +0800 (CST)
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
Subject: [PATCH 3/3] PCI: of: Relax max-link-speed check to support PCIe Gen5/Gen6
Date: Tue, 20 May 2025 00:04:48 +0800
Message-Id: <20250519160448.209461-4-18255117159@163.com>
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
X-CM-TRANSID:_____wDHWSeiVitokozvCQ--.46206S5
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw43uFWDZw4fKFyUGrWDXFb_yoWfAwbE9F
	17XrWfGr4Fkry5Gw1YyrWavrn0v34rW3WUXFyFy3WfAa4UuFyDZFnxuF45Za93A3W3JF1U
	GFyDGr1UKr1DKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRifOzJUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhhSo2grT8qeFwAAsc

The existing code restricted `max-link-speed` to values 1~4 (Gen1~Gen4),
but current SOCs using Synopsys/Cadence IP may require Gen5/Gen6 support.
This patch updates the validation in `of_pci_get_max_link_speed` to allow
values up to 6, ensuring compatibility with newer PCIe generations.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index ab7a8252bf41..379d90913937 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -890,7 +890,7 @@ int of_pci_get_max_link_speed(struct device_node *node)
 	u32 max_link_speed;
 
 	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
-	    max_link_speed == 0 || max_link_speed > 4)
+	    max_link_speed == 0 || max_link_speed > 6)
 		return -EINVAL;
 
 	return max_link_speed;
-- 
2.25.1


