Return-Path: <linux-pci+bounces-24989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4B5A75C06
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 21:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91873A5E1E
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 19:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDB71C5F1B;
	Sun, 30 Mar 2025 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xtEjQVcL";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AJAD76cw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37643C3C;
	Sun, 30 Mar 2025 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743364720; cv=none; b=NqlpWQXa0vUedK5KPAOdkKQIRU6wQBro7TOk7daVEEjyNOmEgrpSqzQ5ze2+aDBNaU3i5IStjUiVf1A0kKOjPUD8wMRZEvppeTIq+8rOwiyXRMot8BgCR7POZGMAEz84UQOkDt6QvC6amhOrk+/vg9wdKvEFfAGo4J6M8aUwtJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743364720; c=relaxed/simple;
	bh=f8DN0tQCvcx968ar0Zm25kr03aBahPDCYQonMwTxYfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aH4mBxNVvd6A6V5RWkRMo4W2RTKK7EJ5lEEoFID8a+QskSDyikzO6/X/uvRxa2Px4404DnVOx+JwTRz/7HSpjd7L46tXJJYCAl1Q3KJtJQgzZn4WmGeVUwW/fr4aqhFNCo7VGtU6e78m9EQmKdhrR0W/YHIGZMFkYjYJWj4IsLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xtEjQVcL; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=AJAD76cw; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZQlSX0yn0z9vKS;
	Sun, 30 Mar 2025 21:58:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1743364716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5zvtELYdfg78Sbj3ph4wBdcMnC22AQDDB19emjW67I=;
	b=xtEjQVcLyX+MDGVldXa/kbkIOOuMrjBjBezsfhWTSlfKy/+nTbA8sw2QFQNHv6ZCRYheKS
	VGhsCXor3b1cSuHwTKS1o5nZs7Qd3gAVzDmAedhQIAuKW0KYwwJSEcOZLLqX58AZ+mg+dQ
	zuDPqCviNDNewVpMCg3vRTiwgtcBwA7jTnHrHQ2KgmsiAIUumByv9I2PMqfilg8djXQND+
	JF+cXiZHiOrYC3Sp2Vu2qrcQnXkSB6kLVCDdZ49aSrFh73HHnyFpR8Nr2NOj4vTga4LhEl
	5G0VyXW6VwQvxp8pKPJh/pdAVgu8xvpGP8LRDsUn9tr8OX+YephyGIYrHfLm0A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1743364713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5zvtELYdfg78Sbj3ph4wBdcMnC22AQDDB19emjW67I=;
	b=AJAD76cwfcL1cADI3rx7/pIl5rjH53YlSC9uqGKTTvb00YK7VgoRGo3IM4lb8hQpHngjpZ
	gijY6wCpeXdEiR2EhVmrlAd5gArCquroty02GeSCWvZhwgOielC2wK5FVq+cxoiVgbquif
	whqdQEE8d7AuXdMBXFhZAI0oh1p14qfPqD/ei2rXqXUjNlitqaLK+XmZl84ZsyFECii5jb
	xDITMe4zoyeuoSVCTqcUmz/kFSrlAeKpJfHsu79YvGN10O9hYjQi4nWFVSuOFXwRXIeMTK
	xiNcikJiHN3gEl+kEM7nolkJ9q9jb/L/r92v6FBE8s07L+bqfQIdaKXvEQsm2g==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Heiko Stuebner <heiko@sntech.de>,
	Junhao Xie <bigfoot@classfun.cn>,
	Kever Yang <kever.yang@rock-chips.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: vendor-prefixes: Add Retronix Technology Inc.
Date: Sun, 30 Mar 2025 21:56:10 +0200
Message-ID: <20250330195715.332106-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250330195715.332106-1-marek.vasut+renesas@mailbox.org>
References: <20250330195715.332106-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b8661ee7c2dfdccacdf
X-MBO-RS-META: qixsr7raqyt3ypir5g31bn5b5xg8inia
X-Rspamd-Queue-Id: 4ZQlSX0yn0z9vKS

Add vendor prefix for Retronix Technology Inc.
https://www.retronix.com.tw/en/about.html

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: "Rafał Miłecki" <rafal@milecki.pl>
Cc: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Junhao Xie <bigfoot@classfun.cn>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 86f6a19b28ae2..2b1bf6709aac7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1262,6 +1262,8 @@ patternProperties:
     description: Renesas Electronics Corporation
   "^rervision,.*":
     description: Shenzhen Rervision Technology Co., Ltd.
+  "^retronix,.*":
+    description: Retronix Technology Inc.
   "^revotics,.*":
     description: Revolution Robotics, Inc. (Revotics)
   "^rex,.*":
-- 
2.47.2


