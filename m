Return-Path: <linux-pci+bounces-27998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEB5ABC494
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 18:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1AE3BE3F0
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 16:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0EB2882C2;
	Mon, 19 May 2025 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EQhefIq4"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7623A287501;
	Mon, 19 May 2025 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672354; cv=none; b=bgZHsIe4KClXd9kHOr6kq0qtPiEO4lOJX5Z1WKXTEAO7v3J6R5Q3xPLQS++KmXoW8ajMfTvtHuoVS6DMuEsugvK8OMxV8BSh2Xd+o+K0ZxSQExb8nBvYmJQoWF8fB8V48MMAcR537AC920btp0wkW4SIVYrV9XTfq5En4lTTxzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672354; c=relaxed/simple;
	bh=VWQTTDD8HisB9NEM4ezmf9iZh/lAnzuvVionokqAlV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TX89lzMa/fGXgc8jCubJgh1OYKNJtvdlJBKn/F6awqV3MBPwZurOsaZg/twcQIAg06UFeIe3wW/yPMAWKx9uZCKrD/heAYNl5D8ILiPCZblzCSPp8EEe53wzZI6eW+pS3QlGlYu8wClpvECLaAq+enXqsnWib8rhAsBDpSfEkGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EQhefIq4; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=oZ
	cJF2JpoopsTyYlHBsjPAyggH5QqX4Y36kxOfVBgqg=; b=EQhefIq4ZftanfhflZ
	t00SkqTM5RkNKw4/9x9htauGITwaeOE0kjWkz7O/sykdOBUH7/gJZqGLD1V26aUi
	Ks8ik7385pO+Sg12dVbaYNe9BqgUpSSyquw61oEeMjmBnvRE3u0zSK1ZQXUezH8Y
	gmnzUt7Pu5xC2eE0KfqceKXyU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wC3vJ4CXStoPbk5Cg--.56045S3;
	Tue, 20 May 2025 00:32:03 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	krzk+dt@kernel.org,
	manivannan.sadhasivam@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	jingoohan1@gmail.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 1/3] PCI: Add PCIE_SPEED2LNKCTL2_TLS_ENC conversion macro
Date: Tue, 20 May 2025 00:31:54 +0800
Message-Id: <20250519163156.217567-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250519163156.217567-1-18255117159@163.com>
References: <20250519163156.217567-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3vJ4CXStoPbk5Cg--.56045S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF4UuryrZrW7AFWDZrWUArb_yoW8Jw18p3
	W7AFyUArWrW3W3C3s8Was2qa4rXFZ3GF4Uur47W39xXFyft34kAr12yFW7tr9xZr4jkry8
	ZanrKrWUCFyI9F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pio7KsUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxdSo2grV+Vn5gAAsZ

Introduce PCIE_SPEED2LNKCTL2_TLS_ENC macro to standardize the conversion
between PCIe speed enumerations and LNKCTL2_TLS register values. This
centralizes speed-to-register mapping logic, eliminating duplicated
conversion code across multiple drivers.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f92928dadc6a..b7e2d08825c6 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -415,6 +415,15 @@ void pci_bus_put(struct pci_bus *bus);
 	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_2_5GT ? PCIE_SPEED_2_5GT : \
 	 PCI_SPEED_UNKNOWN)
 
+#define PCIE_SPEED2LNKCTL2_TLS_ENC(speed) \
+	((speed) == PCIE_SPEED_2_5GT ? PCI_EXP_LNKCTL2_TLS_2_5GT : \
+	 (speed) == PCIE_SPEED_5_0GT ? PCI_EXP_LNKCTL2_TLS_5_0GT : \
+	 (speed) == PCIE_SPEED_8_0GT ? PCI_EXP_LNKCTL2_TLS_8_0GT : \
+	 (speed) == PCIE_SPEED_16_0GT ? PCI_EXP_LNKCTL2_TLS_16_0GT : \
+	 (speed) == PCIE_SPEED_32_0GT ? PCI_EXP_LNKCTL2_TLS_32_0GT : \
+	 (speed) == PCIE_SPEED_64_0GT ? PCI_EXP_LNKCTL2_TLS_64_0GT : \
+	 0)
+
 /* PCIe speed to Mb/s reduced by encoding overhead */
 #define PCIE_SPEED2MBS_ENC(speed) \
 	((speed) == PCIE_SPEED_64_0GT ? 64000*1/1 : \
-- 
2.25.1


