Return-Path: <linux-pci+bounces-30565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6069AAE7311
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 01:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04A41BC20DF
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 23:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD3926B2A9;
	Tue, 24 Jun 2025 23:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RQ4vzUqr"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A746926AA88;
	Tue, 24 Jun 2025 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807585; cv=none; b=o2wdQmE1Cv/lITN34Z5WmFTK8OAdn5YLm7lXC/53ETllM15frQNcRI2lR1GIKtzZPkztG4in2TkLej6AqkY3M8hnj7MX3XZD41Zm19hfPs/tyO5YD9dqYmCWivafbIaOuFNrDMKIKxkrzUdXzg7BkwGTH/Ds41QHN+s7jP33K+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807585; c=relaxed/simple;
	bh=FsjEh05+sGxDJaw0PJ0WUTTvvhMZzvnQalQFoTt/Qrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfyD1zWSWiEAgJ0vdx/37LZcq+Q3FHYLpGdDSNAUqKHoCFCwxPKZpgQFHUtZRzK+vWC352jSHFQlr3ci3L7mEhdXT47CpY/JvwDVpmpOdMawJXI3VRT4wYP9ym6e7XfXlEXeqJ1lI5gmBL/n2M4lrgyfSfiXDt5EtR8d968ptLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RQ4vzUqr; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 72D6DC0004D8;
	Tue, 24 Jun 2025 16:26:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 72D6DC0004D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1750807577;
	bh=FsjEh05+sGxDJaw0PJ0WUTTvvhMZzvnQalQFoTt/Qrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RQ4vzUqrBpuKugpbEOZUrHWdr5fdWyRvqlZCcGb18nG+Ho/ERdruVDQvHT1KmGPod
	 NilHzd0cO5G50buZoGk0q118Yt7pC0cSZosVZLjsKx0dnaSK90iTLsyFdsdauxcK+y
	 ecczdLnnWrJGwXb7ps2UiFVgihr+XrDIi/X4BYow=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 43F4F180004FC;
	Tue, 24 Jun 2025 16:26:17 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-pci@vger.kernel.org (open list:BROADCOM STB PCIE DRIVER)
Subject: [PATCH 1/2] MAINTAINERS: Drop Nicolas from maintaining pcie-brcmstb
Date: Tue, 24 Jun 2025 16:19:22 -0700
Message-ID: <20250624231923.990361-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250624231923.990361-1-florian.fainelli@broadcom.com>
References: <20250624231923.990361-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nicolas indicated a long time back that he would not have the bandwidth
and indeed, has not provided any review or feedback since.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 41d95e7c60c6..439edc5babb3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5093,7 +5093,6 @@ F:	include/linux/platform_data/brcmnand.h
 
 BROADCOM STB PCIE DRIVER
 M:	Jim Quinlan <jim2101024@gmail.com>
-M:	Nicolas Saenz Julienne <nsaenz@kernel.org>
 M:	Florian Fainelli <florian.fainelli@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-pci@vger.kernel.org
-- 
2.43.0


