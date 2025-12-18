Return-Path: <linux-pci+bounces-43321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE99CCD547
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 20:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53B213034EF0
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 19:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AE3313E1E;
	Thu, 18 Dec 2025 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aeHzHM0X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E99231282F
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766084804; cv=none; b=LUE/JRaMnkgQEd7hB07W6+PMTlMzui08Tg4JBHtVU+mlv5xkcqtN/fpxUKXWQegRpzAilRIbvaAA1umTNB2LH4g61mxJdWBWirTNaHSNpFvXdzptLnm7oHOnPmZ3x+f10Ayl3k3nSK2b7Vvzs49JtYN+bva+l29tLcND2opQIiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766084804; c=relaxed/simple;
	bh=6hWxr3YWtKXnIObjWNRmQ/1q6+pnF+M8PoYECdphDaw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duDOoSmfKsOhxL/xcc7w9Nm8rqAxcKHiNrJS1uWIWcsWhIK7o7cfm8UFQot3NUnGmbtBmkwbUrd4+cPiCcvvq+qZSftZrFpiG0lCIs2bkMkVKWMygfYYB/pWCejktPfKZXaxf+3m4ebBe+uShZcLMt67DDKuq7U702FC2JQYDEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aeHzHM0X; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so1840315a12.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 11:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766084801; x=1766689601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chaucy1e8lWQfwVdexQ24C/rG8+K3TB71NB1amH2+HE=;
        b=aeHzHM0XRImPe8X324y5qMGjSP2yYIlmfm1Vu0MHer3vUXQ8U3rTIjI9vi/0DqueOv
         e4l6XHy9lqevEIM8ZmCzaJTvZdGbQiBs35uK973qboJdCm4gzBRIv+nOJBxgLst6FxxB
         yTdRm1ceETlaa2bUWGeWIVAMVWTVMUYcW0ScIhmc2lBvyg7j3Rv1emoZdSwMXv/pVp+I
         S3DhoUSjPK/9zFy4qwz76kVwQZJPSZPE8JVI8MR5sC2LG4hfntAbbAG8QdglEMrti+M6
         RQ9gMu2e+fu/IweNoxmrv9hpGKyVSepabkHJFa6fotq4dhtN+7N+SwbRB4NBotog2BKH
         A1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766084801; x=1766689601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=chaucy1e8lWQfwVdexQ24C/rG8+K3TB71NB1amH2+HE=;
        b=ZHUUZPTQEpLPBAiclyx7eCOvRjMsdcfOYu7EN1Lkhcbz8Razs9JA46QfCroAZEJyes
         x3gWnwINauFSKlfgioYRq/KTbyci+XGopm9n4aBXqJP1cd+cheyESNHXuujih9FUmNbB
         3Ziap17TaoCEtYeDbGoVuS2a/3LKE8WUpyrBeGDBaiCfGdmJyQ4RypO1mpMY6Y3VZJyG
         TIbkK27edYEYTN6MPOKXIKDcRt7dlRapDBYggt1AcOpYaia86wZa9a62pgApox3vel4S
         97gWDs3k6LDAe64oh8JS5MSTuqtpQ4dJoD//DSqduzqVz6XrA559h4P1wcb6UBegIRrh
         DHQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiTXqOlAjDYgeY51OSqp0eP+1W55QgPxpW4bIuN49X6cIT2x86QUDTFSPb5FzhZgQCFszl1tX0G2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu/P3oubOUlCrRqgfqG0F+9GfGTudWbrJ/sO+1NHvehz/NiYMD
	+aSet0H1b55lRCgbttEwcoxXff9T6ChuVPT109pgGA/lZl0iucu1b7LOB/OR6v6RJ1M=
X-Gm-Gg: AY/fxX6sBj6motsPkQhTbSoWUxSfy7QQ/AXJ7FGJ4gUa7Hbv1NxPNteyVea8V9X3fVC
	wKujWIQp1ywN0LU3q/2ICajnkDmQwvgUCoAWioKFJYuj1lGeGEEMdBzHfElsuh8D5w+/HHCSylc
	PzQyIOav34mxLTxaRObLAWeDZWaS+zhWRcbgHL1NBoWe+/8Tc4QcKIorzgpDclmG1w23Aclc4UY
	cbaDnC/0GM8XumXbEy/yYywqf9giPn+hQ8GNBYqv8PjkY7LdNgeChfHcfZWp9DRieKLwAXziZn/
	x6GMt6Om1ePKvrr2OSlxJJAP3hNq+SQLvha9Y+ZkiayNxIMHJr86cYnDBenCOAtocog0HJK1t0U
	qtv2uU/yN1udDessorpBhDDQ71RVuNziCYmrJ/4nB5Q+2eyOWYeKQ2G+uadaYJZbv9/Il4kgIHN
	OZGtZhdkIGu4kDTx6+vbMKeTlE8bAhIdZr+14x+cpzK5xM05ZVOgYasYWaets+PkdQ
X-Google-Smtp-Source: AGHT+IGJ7OubBdUcx7Liyf+zesKkie0GYHAOmU4YtaOMc800CNMruH3bkATR+xrHJMNRK5MvnKCc8Q==
X-Received: by 2002:a17:907:72c8:b0:b73:6d56:7459 with SMTP id a640c23a62f3a-b803717a112mr37909566b.38.1766084800505;
        Thu, 18 Dec 2025 11:06:40 -0800 (PST)
Received: from localhost (host-79-37-15-246.retail.telecomitalia.it. [79.37.15.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a5bdf3sm18392666b.12.2025.12.18.11.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 11:06:40 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Phil Elwell <phil@raspberrypi.com>
Subject: [PATCH 1/4] dt-bindings: misc: pci1de4,1: add required reg property for endpoint
Date: Thu, 18 Dec 2025 20:09:06 +0100
Message-ID: <b58bfcd957b2270fcf932d463f2db534b2ae1a6d.1766077285.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1766077285.git.andrea.porta@suse.com>
References: <cover.1766077285.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI subsystem links an endpoint Device Tree node to its corresponding
pci_dev structure only if the Bus/Device/Function (BDF) encoded in the
'reg' property matches the actual hardware topology.

Add the 'reg' property and mark it as required to ensure proper binding
between the device_node and the pci_dev.

Update the example to reflect this requirement.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 Documentation/devicetree/bindings/misc/pci1de4,1.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/misc/pci1de4,1.yaml b/Documentation/devicetree/bindings/misc/pci1de4,1.yaml
index 2f9a7a554ed8a..17a8c19af8cc2 100644
--- a/Documentation/devicetree/bindings/misc/pci1de4,1.yaml
+++ b/Documentation/devicetree/bindings/misc/pci1de4,1.yaml
@@ -25,6 +25,10 @@ properties:
     items:
       - const: pci1de4,1
 
+  reg:
+    maxItems: 1
+    description: The PCI Bus-Device-Function address.
+
   '#interrupt-cells':
     const: 2
     description: |
@@ -101,6 +105,7 @@ unevaluatedProperties: false
 
 required:
   - compatible
+  - reg
   - '#interrupt-cells'
   - interrupt-controller
   - pci-ep-bus@1
@@ -111,8 +116,9 @@ examples:
         #address-cells = <3>;
         #size-cells = <2>;
 
-        rp1@0,0 {
+        dev@0,0 {
             compatible = "pci1de4,1";
+            reg = <0x10000 0x0 0x0 0x0 0x0>;
             ranges = <0x01 0x00 0x00000000  0x82010000 0x00 0x00  0x00 0x400000>;
             #address-cells = <3>;
             #size-cells = <2>;
-- 
2.35.3


