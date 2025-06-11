Return-Path: <linux-pci+bounces-29505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1664AD63F6
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 01:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D830B166305
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 23:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2776624BD1A;
	Wed, 11 Jun 2025 23:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="a/RmTaz3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="B2iSSqA2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8EA2F4301;
	Wed, 11 Jun 2025 23:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749685364; cv=none; b=dpWkstmaoUuJAq5NbEdWTtj8atlxEkfZlIsWSqSiq6TFwAXSnlNVIyberqFyrrgk+/aJ8sYVF3XWwJ5EC8XAJBpxQNkocXROoIrlbayh14Bx3tOakkqf3e+0MB5vmhw1Bxr4KxHW7C2bi6vApi+phnZ3cguMmqnEJ7I8XH4Q3MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749685364; c=relaxed/simple;
	bh=0Lqc05MJtF78yK+jzAavYAe3CiAx4jlNnkKQn6Lv8No=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RDiPOxC6VDBBzEAYRn65Q+mwmZv3B4kpSwApabAptjqdiERVwl1fBaZhuU5NkYkwLOyNcYn83EIN2NNMdcqaMKvjzvg+g+Cy9oG/FLXFVlJ/xPWUI7kNY7ERw7daCO866kgT16Eo3mPx0ITChbIJ8u3rX/S+4e4F+Ie+BsJfrCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=a/RmTaz3; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=B2iSSqA2; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bHhzM73Hdz9tNc;
	Thu, 12 Jun 2025 01:42:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749685360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Sn/l8L80yT8SucVw9NU1s346nJMf0F3z8P6jRYyvLow=;
	b=a/RmTaz3YfWVVWjzZArFwfkmO5NC2U5WzxmKcsMKd3U6l4ZgezdAN8KP0jRVfpL7g25t33
	J8EGbqMZOS6T4QgbR2kFxBRyixqIRpurcqrdgCHOj9+skydAhT4dmwp/iXkyNEhyEkMyMD
	/ejbjaAIUzAMFvOcwikq/xhffGYQ7+5WSO8BZyuG3tPoXVqzyFsVZYztd6k6guYbAY5nRd
	CAAbg2amqLuyafMiMBq+oyb7r2B5VSsOFs72OFGR2TrdaVY0SJaGNEEaMPYPnExYD/W+RB
	AdKd5OvLyb07PMHY95ePBah3ZbjxgxFdiflJlW8g0l4ePETYMF1CQtr9xC/kIA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749685357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Sn/l8L80yT8SucVw9NU1s346nJMf0F3z8P6jRYyvLow=;
	b=B2iSSqA2/FTGSOZmIvAH+X87Dq/xrDgQB1e2YPUH80LbhoEWLEUb3Hhj+jQbKDatdhoPzt
	K4Vo/9f/JQXhUzu07/Yrg+KmEM43q7qTCOgc9GvevJqzOcOJXqmNVlVSfoU1lzdSfpvIHs
	qwY5TIf/SeEl/L8txo1b3UySb5IJnB6J1gIjiBqOmBr13PqXfbkSxNZs4gPw9J3Ckyrxyl
	JEwdOoxOCbldFbj1ndhcV1/+Dk82+wHyEnTbAgzO+gw1jvusKsgwW1K9u1mbTT1pHaKcVw
	fgl6+rE8ydcdelnZ7EqpVrzA6kHl3+K+XdtDyEDHdsYCbEpOP6TKfnKDZfcMgg==
To: devicetree@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] schemas: pci: bridge: Document REFCLK slot clocks
Date: Thu, 12 Jun 2025 01:41:41 +0200
Message-ID: <20250611234206.159695-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: uwekucmigtd6pg4quuu68o8z5fztjfrb
X-MBO-RS-ID: 859cbe2a96078a63047
X-Rspamd-Queue-Id: 4bHhzM73Hdz9tNc

The PCIe slot may have 'REFCLK' clocks which are explicitly
controlled by the OS, describe the clocks property.

Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Related to https://lore.kernel.org/all/CAMuHMdUFHKHKfymqa6jwfNnxZTAuH3kbj5WL+-zN=TR6XGd0eA@mail.gmail.com/
---
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: - Update commit message
    - Add AB from Manivannan
---
 dtschema/schemas/pci/pci-bus-common.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
index ca97a00..3c512cf 100644
--- a/dtschema/schemas/pci/pci-bus-common.yaml
+++ b/dtschema/schemas/pci/pci-bus-common.yaml
@@ -82,6 +82,8 @@ properties:
     items:
       maximum: 255
 
+  clocks: true
+
   external-facing:
     description:
       When present, the port is externally facing. All bridges and endpoints
-- 
2.47.2


