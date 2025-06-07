Return-Path: <linux-pci+bounces-29152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E417AD0F20
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 21:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38CC316A94A
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 19:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA33F21579F;
	Sat,  7 Jun 2025 19:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="B8wmFcSh";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rZjZLHUy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EA01990A7;
	Sat,  7 Jun 2025 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749325457; cv=none; b=rPW+QB4x3zwxvPDfD389CrkH9SSGLTsl3JPMxRBGJVVpD3FO8N/X7QoziWmjQ2hASR8t3T8Mfhr/peCr+qZ72LjXhstcuLIcBUl8NE8tt2rLIHTfpEbWPERBkwEE+d6f/sHWCESV7IXzwLzUOQUfbGkZ57OhKKkLjmudG05GyrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749325457; c=relaxed/simple;
	bh=HeQuThy1N1IZeImMdHxkz5s60e2a1U6OFxeJ6qxbARE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8lJR/mv2sHrTu2c0+sN/61gBA+3tVEB6fPeBOB9gEPIDBZX+0SDxRuSkp1REU72hAnbyPetcazDuYAewPgPb7ZKlKrafXZBX1kitqasLucfKFEA6J+ufEnV/LhGGyJFhBkUx96GbwC78IlF8dxZlv2jqm60kAU5A4QELaEY3vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=B8wmFcSh; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rZjZLHUy; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bF7t564njz9sR8;
	Sat,  7 Jun 2025 21:44:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749325453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hLbKLNDjtxbVMF5ETdYa9428/m9uNBsQgiB8dN56zpo=;
	b=B8wmFcShtOKUvAYME98xFT62ZRqGHHCQhe9a7/++NtHLbFoEOo7JTVdHKLhahTkc6BpjIp
	2mKo2TGY7um2NBcMYS7jxeEJUaDTd+T0lTXxbJSn6fRbM3pWv4PZ9vQBXNPupsDxs9Hv2U
	h/ePBfngwnKKrdaaikl6glfwSEWHfxP1EeSOFflnP0pqLjEbR0sx3wWMUCZK9FD6GpTfJa
	HlByS53U4IaG13CS2Gdv5d1QggAaJHGeQuRjZTx+Z/H5glrEVpBuz/Ue5qLUo7JZsK6QuM
	xsHc9rd6bBt++h4f9/ySj0rZRbjJJqpIVPRq/yZdP/oO5wWFmDDdxq/+edSBAg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749325451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hLbKLNDjtxbVMF5ETdYa9428/m9uNBsQgiB8dN56zpo=;
	b=rZjZLHUyn/+RaDF4E7gXke0p3zZhHbLcqwf/fgkMFm5VRfhqe4V2OP01L7XzCn3NDTE1qQ
	AoLhXc3LuLJX+3H0Lr/D/dDYUOf2WVFS2DHKuZQeOsSUVZED/oMO+eQ3yDGWfjyjUlhpQ0
	JpyqWhv18dfAspag1cPNdBy0JL6NiljpY2tgA+hs7t8mjX3Jfw9Y6R7p4c6fuu9Qbgjfm6
	ZJojBBy4eBXYgE/HF/G/Drn5qiivXtdTlC6BHWDcUYgck3pbif6eXRPVJvNQDV4SMr6iUc
	hIZ/gDJvmegjDjN9wxBaBtqJ4dp34nHeNxjc1/hSZAJzXsMaXT6lfJoFXpFYQg==
To: devicetree@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
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
Subject: [PATCH] schemas: pci: bridge: Document clocks
Date: Sat,  7 Jun 2025 21:43:24 +0200
Message-ID: <20250607194353.79124-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5a62b158240baca3793
X-MBO-RS-META: tm7tb873p8z3pq1mfj7hhqdxiq4rxajn

The PCIe slot may have clocks which are explicitly controlled
by the OS, describe the clocks property.

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


