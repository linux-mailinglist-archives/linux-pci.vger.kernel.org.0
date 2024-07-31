Return-Path: <linux-pci+bounces-11076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C097E9438DC
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 00:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3351F227CE
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 22:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1307916D9DF;
	Wed, 31 Jul 2024 22:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DcfzGJv2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EA916D4FF
	for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 22:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722464919; cv=none; b=qDRN6cEc1lNHexcXEtrxncKIfseCnuUkHcV3a/BcOU/SMpptvrQGGLGTfLy2BtC4qzMBccr1ryLyDiY9tndPfwimIPeGUPyQtj3AOiJqOTFzzueeEF3ndQfpyXLottiKvAoXT+Fisy3NgHoA4VVGh+Vryou1OGv2uVqQEJTS6Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722464919; c=relaxed/simple;
	bh=xOGWNuaAupIgwPdS/rgbsjpjtqFXk6aLgk37BeHc+W8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=imgjcrgGUeIBMIHQQC1sIoHP9zN0Dd+0GqoSUPTxm01ZQeOPf6UsMrrKc6uvXzh+ISMhRHS30lKCvYihu5crAGyNP9Yov3+9CKwbGNYzpCu4QDU8R+jGXrw2S8dIIrnG1JPqx+88iEYundedQrYNQwIzpk3G6FPKKEynbNh5MB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DcfzGJv2; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44fffca4fb7so26244231cf.1
        for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 15:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722464916; x=1723069716; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b8cbkrXOvR65c0gzParSa3KyQFx/V1Yolb4QWEqbLeU=;
        b=DcfzGJv2t5cjo2d/zEOlWrQFvfvyOeBRtZqIE1mlPnGStKWv6fKIVgIdRgJt8A7/Tg
         s6XfO1X1q+9LUP0BZvCdnJUNN1Wj44F4QqHCnGKF6Rm/UV45KJmZ/iJ0au+ZyAJjRtZO
         5g8dwXbfGvSWFcklB+l0k/axfboqnNeFn/b/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722464916; x=1723069716;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8cbkrXOvR65c0gzParSa3KyQFx/V1Yolb4QWEqbLeU=;
        b=hg46e9CnQU3vgB5dx81AQXg/WeND8DsLXA63w+Nf+3gpIVqkfklreEygWJ3gPxU1qe
         jK9nrM37t+LOjeWnr0AnCAFPZGCyHRLoOdyPipkiybVdWY4BM0ALyN7Iipvo3oO/GHLd
         lcM2B9G5Cx5Qgdy3HNeHobaXjSz/weOIRkC0Mif4wIXR1oSBu2TToTfcLEcx3N+R+zS7
         Xnqvwtbe4LpmRqkReNnyGOEPjf/QO8zQdrc3TkQ6tkXzu+Fs6N21BDUy8DCXFt2BRfhQ
         NIC2E1uwSt9shJylOESmJYx90uqk8uD8NiVvyc1QNuL//d6f/POQxLNznNkH2ZXFzG6x
         rPJA==
X-Gm-Message-State: AOJu0Yzp6QdfS7cef26HCHw2pjA+CgG1AJYEigONK840qbkJwHXIdsDr
	WYPAco35UFlCmr60SdhJXDzWV+5LGVMyYiObA4I1830VUJxuNmss3KDkHyOWbfXOikrdaqxKbr0
	IcpsQEsNy712AlT1fbRQ8IAJJ7eDNzOtKBcobPC7GNE+SoD440e8nunPy+oaUk4/p0VjJaK24WA
	bRmZyopkTna9ZE7rYxAohuxQzDTXFM9asM69d9C6/BGiityw==
X-Google-Smtp-Source: AGHT+IEZ5zlpgTPjR0UxwHUMdNEmwri4DDnsPSxdW+UrsEfbtq1R2jA2OMG2gatPXhIqCCj0RHIJBQ==
X-Received: by 2002:a05:622a:548c:b0:44f:dcd2:613a with SMTP id d75a77b69052e-45167d0eaabmr7880061cf.41.1722464915714;
        Wed, 31 Jul 2024 15:28:35 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8416c80sm62359181cf.96.2024.07.31.15.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 15:28:35 -0700 (PDT)
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
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 01/12] dt-bindings: PCI: Cleanup of brcmstb YAML and add 7712 SoC
Date: Wed, 31 Jul 2024 18:28:15 -0400
Message-Id: <20240731222831.14895-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240731222831.14895-1-james.quinlan@broadcom.com>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

o Change order of the compatible strings to be alphabetical
o Use "maxItems" where needed.
o Change maintainer: Nicolas has not been active for a while.  It also
  makes sense for a Broadcom employee to be the maintainer as many of the
  details are privy to Broadcom.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 11f8ea33240c..7d2552192153 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Brcmstb PCIe Host Controller
 
 maintainers:
-  - Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
+  - Jim Quinlan <james.quinlan@broadcom.com>
 
 properties:
   compatible:
@@ -16,11 +16,11 @@ properties:
           - brcm,bcm2711-pcie # The Raspberry Pi 4
           - brcm,bcm4908-pcie
           - brcm,bcm7211-pcie # Broadcom STB version of RPi4
-          - brcm,bcm7278-pcie # Broadcom 7278 Arm
           - brcm,bcm7216-pcie # Broadcom 7216 Arm
-          - brcm,bcm7445-pcie # Broadcom 7445 Arm
+          - brcm,bcm7278-pcie # Broadcom 7278 Arm
           - brcm,bcm7425-pcie # Broadcom 7425 MIPs
           - brcm,bcm7435-pcie # Broadcom 7435 MIPs
+          - brcm,bcm7445-pcie # Broadcom 7445 Arm
 
   reg:
     maxItems: 1
@@ -95,6 +95,12 @@ properties:
       minItems: 1
       maxItems: 3
 
+  resets:
+    maxItems: 1
+
+  reset-names:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -118,8 +124,7 @@ allOf:
     then:
       properties:
         resets:
-          items:
-            - description: reset controller handling the PERST# signal
+          maxItems: 1
 
         reset-names:
           items:
@@ -136,8 +141,7 @@ allOf:
     then:
       properties:
         resets:
-          items:
-            - description: phandle pointing to the RESCAL reset controller
+          maxItems: 1
 
         reset-names:
           items:
-- 
2.17.1


