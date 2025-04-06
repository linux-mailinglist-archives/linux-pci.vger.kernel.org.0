Return-Path: <linux-pci+bounces-25347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40226A7CE83
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 16:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03F83B04F6
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 14:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970D321885D;
	Sun,  6 Apr 2025 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JSTNlRyo";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oubgr8hK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FD61BC07A;
	Sun,  6 Apr 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743950963; cv=none; b=rti832lTNvMlMqrMmJt53t5AW3aHtsrGvuhqzaLyk/dEhPPa/4jth2lyWPIcj4c2QLRENeLWMZdAr9SH/IsPSUQ1UgxJXpeZ2LF1tX4qw8qIaby1wCnQ8PGWKcoZoejZRRIqa6aqgqg5noABQffQWz2FHEZFiQHAcJxBDVpAZfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743950963; c=relaxed/simple;
	bh=mRs9zH8dDKWt3kY2pX8lxVSIWQ0ALKKYLAcVldLkf3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTVnyvehBIudUhHSfAWHZttPeznYpwBmn7jITd4D/sp/QMoF8Uam0bY8Ly4TRrEZSBnzkPiLGpk4ombcbxoWqn78Vw5bdZUdb4in9pfxBWIoIUsRsRfUnHHK3U81PfI95UphvtQMkO/yQUB5BdXUhk5fylNEnPLDPLKAWOQ6+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JSTNlRyo; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=oubgr8hK; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZVwGK5NHKz9stN;
	Sun,  6 Apr 2025 16:49:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1743950953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWN4rK4Flr4QJJjckzrtsp2NO98+h/Gt6eIWZ9nsIDA=;
	b=JSTNlRyopSLAS88xEFPRaWogIBfStKOEk6pch9gBfDfYqsXupcPDNM75bRu7JDzDxtw4zk
	CR3g6m+OSonoleqHUZwGWr0RKNqpITDaAo5aFGU0hnPaC3R9MSGc11T3L9t7tRbom9er/3
	q2KYXNJE2pZV2hcyk+DIxeSZnF/T2rHudsGSO9KLXvrIu8PUqIsqvVSpLS/LyfhwXT1vtV
	5bqW3+4ym1APG1qaqq5uHSrH+hJnUk+BjFZkQubLXO5qDhGjdad+iIWshBcsiXWv9KGriO
	+Fhu2inT6Bh84OXaFDcJflCiF1I2YDdpsh75oXCmvKBS/b4Rbe2Hmc4m8/gAxA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1743950951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWN4rK4Flr4QJJjckzrtsp2NO98+h/Gt6eIWZ9nsIDA=;
	b=oubgr8hKjDgZ/PH3IDz8tYWBGeJw7P0u1xSBXWlEeBcbpmyKUqk8/DvkWYwrw3jkxrWNeW
	8NKc2lGioQDbF1ziQiitEebav5NasZXumV9xckF/5IX3egQVuEb/mLnfAaLx8Ip9V3vnXq
	bjmwhYJ4nkw1faGciXV+5wkGiPzSKgqGf9KwhSE3ALSkJI6mA3e1V+GdU07R1xreBWJrJV
	xU7f9E3F/P3hkN1U2dvl3zDgD9x0jeLy6PRM2lMoCuFcknTqP76Lu7KJFjmlGsXg0aRhii
	70qA8cOf+IjwewtvkhVWYsnG9URfAL23V4gyEuCF+hnLgPD9VePJg9/mcxVRgg==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
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
Subject: [PATCH v2 3/4] dt-bindings: soc: renesas: Document Retronix R-Car V4H Sparrow Hawk board support
Date: Sun,  6 Apr 2025 16:45:23 +0200
Message-ID: <20250406144822.21784-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250406144822.21784-1-marek.vasut+renesas@mailbox.org>
References: <20250406144822.21784-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 84dab855406a7822c6b
X-MBO-RS-META: qoifthtwm14o3m7bbrkb8kt3mrqm3m4w
X-Rspamd-Queue-Id: 4ZVwGK5NHKz9stN

Document Retronix R-Car V4H Sparrow Hawk board based on Renesas R-Car V4H ES3.0
(R8A779G3) SoC. This is a single-board computer with single gigabit ethernet,
DSI-to-eDP bridge, DSI and two CSI2 interfaces, audio codec, two CANFD ports,
micro SD card slot, USB PD supply, USB 3.0 ports, M.2 Key-M slot for NVMe SSD,
debug UART and JTAG.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
    - Add TB from Niklas
    - Rename {Renesas,Retronix} R-Car V4H Sparrow Hawk in commit message
      and update R-Car V4H ES3.0 to Renesas R-Car V4H ES3.0
---
 Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index 51a4c48eea6d7..201088277514d 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -375,6 +375,13 @@ properties:
               - renesas,r8a779g3 # ES3.x
           - const: renesas,r8a779g0
 
+      - description: R-Car V4H (R8A779G3)
+        items:
+          - enum:
+              - retronix,sparrow-hawk # Sparrow Hawk board
+          - const: renesas,r8a779g3 # ES3.x
+          - const: renesas,r8a779g0
+
       - description: R-Car V4M (R8A779H0)
         items:
           - enum:
-- 
2.47.2


