Return-Path: <linux-pci+bounces-30567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CAFAE731E
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 01:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184855A57FE
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 23:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9E126AAA7;
	Tue, 24 Jun 2025 23:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GJcmcRUk"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A343E26AAB7;
	Tue, 24 Jun 2025 23:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807610; cv=none; b=cCXYmEa9e+CwoyrMs6LBc94pFAd2v1Qwqho7S41a6AAdsxALguBf9ZHck9b9ccMDlLVZ5xnv7MvtSdMTbW9ch02XlwTwkcNh+mMYiZyT9/DtAM7EEPWjThqe9g5o/7cMfyTXpe3dSaEpK3AwmpO4i2Cklhc22Rh+ItqCUnx9x+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807610; c=relaxed/simple;
	bh=MryCwuQ5UgpRpkPiut10MXF4O6MqDCKghsmv+2OB+JY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nwfpxu/A9u0zr3oQfuAQT6L5T5vr+RwspfHXVXqCeqh7HqfaFkL4CLJ9hMRaHGLU3r26Hz97gyeTqelfojRbSpMotg/w/qu3xlBR3l/9rBc0hzAq/Eh0nGPmsht2SBApn7NVmqSl2cIh1jTS+CXxePrXLBfREq+lDVneJ7A99cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GJcmcRUk; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 85629C000C95;
	Tue, 24 Jun 2025 16:26:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 85629C000C95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1750807607;
	bh=MryCwuQ5UgpRpkPiut10MXF4O6MqDCKghsmv+2OB+JY=;
	h=From:To:Cc:Subject:Date:From;
	b=GJcmcRUkZuoz94XL5ZAK8UH7RAU6imQOlEXiY88VUZLxxNAXEyUIfUcMoAC7UyOo+
	 CfVAJOkPj7fwVIOMrow9i0FaSzCubIlKRqasyysHuZfJXJBe9Ispa0Csey1LlmEbX4
	 KhbeAAJM1Mx8PJO7lt6AVKfPp7GQeBHIte6NeG88=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 12FEE18000530;
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
Subject: [PATCH 0/2] PCI: brcmstb: Trivial changes
Date: Tue, 24 Jun 2025 16:19:21 -0700
Message-ID: <20250624231923.990361-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch removes Nicolas from the maintainers list since he has
not been active and the second patch uses an existing constant rather
than open code the value.

Florian Fainelli (2):
  MAINTAINERS: Drop Nicolas from maintaining pcie-brcmstb
  PCI: brcmstb: Replace open coded value with PCIE_T_RRS_READY_MS

 MAINTAINERS                           | 1 -
 drivers/pci/controller/pcie-brcmstb.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.43.0


