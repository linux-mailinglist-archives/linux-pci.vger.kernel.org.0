Return-Path: <linux-pci+bounces-28520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7854AC75AE
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 04:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1505DA20995
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 02:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B2D242D85;
	Thu, 29 May 2025 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gHkFM/fn"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A140242935;
	Thu, 29 May 2025 02:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748484674; cv=none; b=Hri5Xcp4J2e0IrLk4fvoJm1r2ORLWpSyOyJegPHUvP9W7VOQ2q7Iaym691HOE2Y1Ly3eCJ17N++mCga0sNOP3rz2LY9Znv48uwVld6YvG6p6zdnrpx8dJDQMPaiPBLwt7JzJh9bKhAtR+bMZMMhgzdBur+Dzl0YzbplH4rksMjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748484674; c=relaxed/simple;
	bh=UamZjfyN6na3p67Dkavvu/KY840DiztSpAhsgs34BpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f4shimrHyPbdBfA/T4R5PdcAamznIqQ8vnXQwU9pqf1aWPRn3jnOHqNAdLizwvYKsCMZimMjFs69plJOiKSZBnU3Lz/cnDG8vQWubIUbStoaYnFzkMKFs4axqRt17vMGBvKLf8wAb1Ym11Jj2TIsQ/XHBL5rFFDQAS6heTvPags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gHkFM/fn; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ij
	u8xELG4+fnR3215qcICf+KmnT2kIbCVpbjooreXLw=; b=gHkFM/fnJjff8yeMQq
	GhkZU7Mq0tueamWdq/cBysm9BloFqG828mZhXp2f8CXzl3SHl5NuxK05kRhA3XCT
	IFtoIopCq6zH8NrHXh2rkyxld8KM3/pZSYi8lc8BDvXh7kwnQTntSrjdkHvp4LQI
	SCbRaUUh2UvoDfMqHXtaycZ8Q=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wC3we4Uwjdot_dqEg--.40331S5;
	Thu, 29 May 2025 10:10:38 +0800 (CST)
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
Subject: [PATCH v2 3/3] PCI: of: Relax max-link-speed check to support PCIe Gen5/Gen6
Date: Thu, 29 May 2025 10:10:26 +0800
Message-Id: <20250529021026.475861-4-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250529021026.475861-1-18255117159@163.com>
References: <20250529021026.475861-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3we4Uwjdot_dqEg--.40331S5
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw43uFWDZw4fKFyUGrWDXFb_yoWfAwbE9F
	17XrWfGr4Fkry5Gw1YyrWavrn0v34rW3WUXFyFy3WfAa4UuFyDZFnxuF45Za93A3W3JF1U
	GFyDGr1UKr1DKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRuyIUUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxlco2g3vsGtewAAsL

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


