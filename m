Return-Path: <linux-pci+bounces-11722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B80953DAD
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 00:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1231C25131
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 22:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686991591E3;
	Thu, 15 Aug 2024 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K+oJ6o5A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA659158DD0
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 22:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762674; cv=none; b=odNyiijOqNrfLojJ+Vyrm2VsRq8IkK0Alo1hGRS2sMs2ha3RP35ztpmGytHmCU3ef1+M6IdPRIJza36RlckJc+S/g2/wKZTLIA4lvBV7R9VOyxFDJTVrGY6L3xQWjX4HN23iBwrsStL3P+TWnYfgatMYJxQ3GMbhkosJuiIWblw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762674; c=relaxed/simple;
	bh=hTD9OmJB81cIRNMB8r5RWcIaSLzWceBhC8SGhS5dFxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gfqfirC9Mtuj82geDdjuI/45iYq7jaXNmbs8+1wgNCrNljuKq0L8CDfdfOflS40DYzDUIAjw//p5cXDAKSpxbdwWMKUEeLwQR9kym9bKLWcZAky8dooM4yr7GkV30cMU+1JwVOn3D1kTvxi1erOjmzhS+WtqUnmoZWgauhHhAFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=K+oJ6o5A; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d3ec4bacc5so8935a91.1
        for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 15:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723762672; x=1724367472; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WH+rdrTcxkg59J1njd2uJ3iEEueSc8kUH0E7SDV6ulc=;
        b=K+oJ6o5A0rm8lb4wQx+hvjd+tlKc+s2yLLRVrDOETfzcuxaj1EWOfGY8httsYL2E+0
         l2UbF54L9RKwkcKdqwLPPMrVo1DalVq80qwmPPvRAPQPWV5xWq1WRiwKyjkvX1mW2KNg
         amrcqRHnzQviVY9ov7qtki0hEGhyGXuHQCJwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723762672; x=1724367472;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WH+rdrTcxkg59J1njd2uJ3iEEueSc8kUH0E7SDV6ulc=;
        b=guWVqO6eE+JwjvjWeCP2aWAA0ycuGSFBkcmosRCJEj9iMhOZ+3KTWepa6JNGKIaiOu
         3ZfiCCUA40qOuJkTR6EVunjO9tPXJxM5/umZvho6mMZG+t4Oy3Ch4lhu57N9qfKqpv3x
         a0TNHGKNMWIO2vhI5/kroVFHjmzBgvy6/uqRxBmfUppQFigiOsyHNS3DSlInCeasJife
         74LfJDv2sH/Wi5NRGvKUmUDeaeVqm8GOuQDPj03x3+t6QqZENWAmw8nMXCSBY8/tv4Ni
         vFuEb65WUg2qsX+CvPzftkq9PzRZW1nht60eBKv5koLPi6cgrIYJkXHNCogQ44RJ3C3n
         qmKg==
X-Gm-Message-State: AOJu0YyAdrCvxonzlZ68wGE2zvXfWjWRlA2NESmL/O18nhNiOhRy93S2
	xeTpPs/7axiuegkw89/RksdA0jo/9UoCBIIQOi8/9u/ujnQv/fU5c4jSJ251WW7THITat9NtYXe
	/UFf0X1DRYYIjHcQQ6uqHsxed8zhcl0TqosyM7nJ+qC3t+L3l0wOwfdOPc0jXrQD+oduYUa7++v
	S1tbFGbEXpiQr7vAQq5V8iQwCp9D3RAyK6p+nKjsU4F7ALIA==
X-Google-Smtp-Source: AGHT+IG376HhZUZrhW7Ph9mF+C01Bg0t7yn8TgdDnPPnyffSrZWUI6fa4Ar3i5RUImonP2U2TFaBsQ==
X-Received: by 2002:a17:90a:b114:b0:2cf:f860:f13b with SMTP id 98e67ed59e1d1-2d3e45d598bmr1129974a91.17.1723762671402;
        Thu, 15 Aug 2024 15:57:51 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2e6b2d1sm373997a91.18.2024.08.15.15.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:57:51 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 03/13] dt-bindings: PCI: brcmstb: Add 7712 SoC description
Date: Thu, 15 Aug 2024 18:57:16 -0400
Message-Id: <20240815225731.40276-4-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240815225731.40276-1-james.quinlan@broadcom.com>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add description for the 7712 SoC, a Broadcom STB sibling chip of the RPi 5.
The 7712 uses three reset controllers: rescal, for phy reset calibration;
bridge, for the bridge between the PCIe bus and the memory bus; and swinit,
which is a "soft" initialization of the PCIe HW.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pci/brcm,stb-pcie.yaml           | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 7d2552192153..0925c520195a 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -21,6 +21,7 @@ properties:
           - brcm,bcm7425-pcie # Broadcom 7425 MIPs
           - brcm,bcm7435-pcie # Broadcom 7435 MIPs
           - brcm,bcm7445-pcie # Broadcom 7445 Arm
+          - brcm,bcm7712-pcie # Broadcom STB sibling of Rpi 5
 
   reg:
     maxItems: 1
@@ -96,10 +97,12 @@ properties:
       maxItems: 3
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   reset-names:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
 required:
   - compatible
@@ -151,6 +154,27 @@ allOf:
         - resets
         - reset-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm7712-pcie
+    then:
+      properties:
+        resets:
+          minItems: 3
+          maxItems: 3
+
+        reset-names:
+          items:
+            - const: rescal
+            - const: bridge
+            - const: swinit
+
+      required:
+        - resets
+        - reset-names
+
 unevaluatedProperties: false
 
 examples:
-- 
2.17.1


