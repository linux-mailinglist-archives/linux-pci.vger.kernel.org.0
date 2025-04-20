Return-Path: <linux-pci+bounces-26309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D32A94882
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 19:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B903188B1E2
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 17:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4747E20B811;
	Sun, 20 Apr 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WP8Ty9zg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BZcbMBrg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4381DED4B;
	Sun, 20 Apr 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745170763; cv=none; b=p93i8/G6XkxBjeBDBr4y6O5JiPwfrNK+Fm9YwfN7BfUw1zPcrADi9Y9Cvtw+ONnpPXIESf5n3IcHVqhbvothNWSoit/68dI40f1dJGKwsGGzeqEjcFf+LJfxwUq78u1r5gtVrdf0QT7GZTZ95vgRJpQDM5iS84bMyBPhzlrxETo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745170763; c=relaxed/simple;
	bh=pgVts3zH8/3m01mUpr268z1ZNkTJdEHKJD4wiVVaTgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBuR8VcW3Tm0Xs+/UQBZVuCyip6BOIPJ1huiMnt5KURUGgYG2EUvrJFkEe1uJlT6gy8UqFzoVCidSODRcXgFOzbNhp8mVYg17ZC8d51QYdCcEEk6s7qZlWHLYmFRtDEVN9gCFdSjogwW5NeVzM1RcW1H+AnELz4wcxu56iRhz44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=WP8Ty9zg; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=BZcbMBrg; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZgbN55QxGz9t72;
	Sun, 20 Apr 2025 19:39:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1745170757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KLSTm2eAkY0GGbHRw8VQP7KYnuUYCyjh+76myopty7g=;
	b=WP8Ty9zgDEPJPjjgJfUI6a9Zo0jSm+sC5xSJQynbtc+5h83NOWaZO+uRP+FNAKDWAS3HqC
	WviBXRMzHyoB4woL3Kd0F7TWdkirA4L6uZIQsC9fb7jaJdcf8dBvCQPuDzl3vnnxmmiXut
	1T4i3iAOFF6LRHC3EYDdjZxMw5Oa2O1hwvzMUH8cf6n9/nVvbmaIcZ6dO992ZMhIjK+CZL
	Mcnuv35T+4xq/fmAxyFqMrpg14uar5B+v1mThMpGSYg7L7VsXZ4DY+NBNUEuGglrC4+quX
	w4YDAgPqG4rcaOmGUpOOvp/K5AGcvdKBsTsBRSxVyXJsCf4vbdo+fwVP6rPckg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1745170755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KLSTm2eAkY0GGbHRw8VQP7KYnuUYCyjh+76myopty7g=;
	b=BZcbMBrgar3ZHd+5I5TjGbywYr1hEUGLl0v4BvCPlzpy13A2iJbARKTWi59RN64MBvFpav
	eq6FF7U2EUU/memo2SD2v0L+OZ9Q22RJo4/HsVEYs8His9Eo/u/tUzmv0QzxRCDfeOJ2/V
	aDL9WgTrXmqzqJT+0P1U0tddzu7hUlrd6kGiAWp6uOCLRcHhOJ9ZohAayjZ/TaIfchC3Vk
	kJoUiT9ZqH8fopfB/c1Til/M4rUYzWv3vLrSOpQLZ8ociXtKC/En5NMly0AWNoiL0LoKI1
	6O4SDEvzk2RZ9TkybhhKrLErBKk9QEIkq89nXjiJKdVDXgL/ZnrphC4ZaZb4Ng==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
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
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add Retronix Technology Inc.
Date: Sun, 20 Apr 2025 19:36:27 +0200
Message-ID: <20250420173829.200553-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250420173829.200553-1-marek.vasut+renesas@mailbox.org>
References: <20250420173829.200553-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3dcd1b8fa1fd642b3a1
X-MBO-RS-META: y4gyayeuk88anxeym8ykb3wbk9orzzkc
X-Rspamd-Queue-Id: 4ZgbN55QxGz9t72

Add vendor prefix for Retronix Technology Inc.
https://www.retronix.com.tw/en/about.html

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
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
V2: - Add AB from Krzysztof
    - Add RB from Geert
    - Add TB from Niklas
V3: No change
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index c2753656ae8be..836b446132686 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1264,6 +1264,8 @@ patternProperties:
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


