Return-Path: <linux-pci+bounces-31465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C0FAF82E3
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 23:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43456E2B57
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 21:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1162BF011;
	Thu,  3 Jul 2025 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iO6YMO/V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F662BE7BC
	for <linux-pci@vger.kernel.org>; Thu,  3 Jul 2025 21:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751579605; cv=none; b=thSeErF1U1Yiyp8qRlod1r46Yhs/GuiNBo86vdVRkksjOaBlAhvhBPzJrIcnsrtzdi2Cr5PmRVq2IynFJyrXXc7w5ShGH9rJmlQ+G4yL4OvRGf64aphdeCuPBHlJkYp/rjVRoaYIrFrhGvDSLl66xXB+rBML5uL3YCFYICjQRcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751579605; c=relaxed/simple;
	bh=7vPWxC3i0T1lMmsOVAXtGjJ/XmqPhC1ujaQsBuT5zmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZDTshA7XuWu60W/7sATaM707jiG0Qe1I8phP+NxGGd+PduldrLP1bJgQ62v1N1vbVo00IcAjqz3bHphRscX1ACBTiEWCsO0UeZG/WmVU5a3bfbQeqtp71KtRcyx8mjXU7vM4mETN7nbqGJBdO7lEeBxj3NTnxj7G4mzkxtWf1CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iO6YMO/V; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-235f9ea8d08so4235795ad.1
        for <linux-pci@vger.kernel.org>; Thu, 03 Jul 2025 14:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751579603; x=1752184403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wgwhd4uxfgsiFGznM9R+p5/1NcCXs+lUXw56p7CBPbs=;
        b=iO6YMO/VpXHtTIJQJKElUl5DZtymEdqWQADOU+DKNNaY22/RAe65NP4yVzvfKjtMPL
         3N7Y8dBMKTh+hOWn30hNWyclmtGnfbrPptDWzPAPTqao90BA6f6hqMT1SHvvWdmDGJQs
         iaMNEqYtPp6QkiG115T4GZ/qQDXwbNkqh4M58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751579603; x=1752184403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wgwhd4uxfgsiFGznM9R+p5/1NcCXs+lUXw56p7CBPbs=;
        b=vSIEc1T7pBELyPqgxvuh5yTyclCR/TA9WYNDfVyVZ4AK6hVuG9uxKgtvpvVJXdbCXj
         KHKg1GeWiGsftlMrycrU5v3HDjjpzCGQBT1lTkImVrKnvexWMNsiXq7VyxDqfHC1zJhg
         0YA57AhuA8JkaTji/cUzzM+e57OdApza7lUH4SViCefYLvnMLYKmWfTBPkU9VNF+DKpl
         Zr22LgUz687wY4telg+hm3aTac/3mVMN+HZR/oR1xRLwhdWpKtLd25yT1gxTf09+G4lr
         0eMFGLgmUtsyksCOWDC0ttoDyhuSrlQn598NCPLLv60HVjIUxdlQNfAcqbu1lcGbcrwq
         LaGQ==
X-Gm-Message-State: AOJu0YzF20JGmWTU55JTRk3WTidIwJ5aV9IRbWk1eoqJJyrw6EGCx7H8
	ROJ/3VjhDQkDoi6taPc71SPdJkem/91DYhc/tAPqXu6oNk3Bhni8uJSHZDfGVfjjSAYSf29fLS5
	7E+PcVYGYWUMAsEmesd9mybQORMweb2l6QwUBHiHLNl9sUM2K8K3uE2FkuMaHX8rSCV52q7in71
	XBRKXGGIhAeNsgyk1xt86J6i3XG+ekwsQoR0KhZmPSCrzp0S3o5w==
X-Gm-Gg: ASbGncumZ/KQWrSlP37yyTgF9hk+ENapYx9k/Y0QXq6lq3akR6enIYvnZYlp7yacYxM
	Pos6fqeeJ2fvo0mNdBUcvmNSblRhva35qLkAJ/KrvaA1p/yRCnHdR9WyYoel/vE9xMh29r7z98d
	zaKQTm9FIDUnmi1gf6AIM7aEEH1Wyxi2fLOCSCEKjZMJLs02jIEtAnVcLY3b6CKRqiZwvNezAqZ
	mH0zariE8XqUDmLYWJyiSGHOIZOhKW8DKXus0qhsFaRkBP3npuf59FYZFaJd5YCw+2r+L8oNNdB
	MmLb3oJ2pz7+jxHj6FQuwIm/tP7IP/BJHG0v4o6mXJj/0B8LhoKYal2yzgzurGU4B/YKnKxIXob
	VQffP61eOAMbbptxZWbNxlnMqHYCmfHTr2zDOlTs7zw==
X-Google-Smtp-Source: AGHT+IHxUkT3T1XrdvXj6lsZasXIIR1QuejltuaVBvB0AUtVnJ6flgqLggHU2VFll3S8pZy4clu9dA==
X-Received: by 2002:a17:903:2d2:b0:235:2e0:ab8 with SMTP id d9443c01a7336-23c8606721cmr3661665ad.6.1751579603171;
        Thu, 03 Jul 2025 14:53:23 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8459b3a0sm4249645ad.219.2025.07.03.14.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 14:53:22 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] dt-bindings: PCI: brcm,stb-pcie: Add 74110 SoC
Date: Thu,  3 Jul 2025 17:53:11 -0400
Message-Id: <20250703215314.3971473-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703215314.3971473-1-james.quinlan@broadcom.com>
References: <20250703215314.3971473-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds BCM74110, a Broadcom SetTop box ARM64 based SoC.  Its
inbound window may be set to any size, unlike previous STB
SoCs whose inbound window size must be a power of two.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 5a7b0ed9464d..36bebc290b42 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -27,6 +27,7 @@ properties:
           - brcm,bcm7445-pcie # Broadcom 7445 Arm
           - brcm,bcm7712-pcie # Broadcom STB sibling of Rpi 5
           - brcm,bcm33940-pcie # Broadcom DOCSIS 4.0 CM w/ 64b ARM
+          - brcm,bcm74110-pcie # Broadcom STB, Arm64
 
   reg:
     maxItems: 1
-- 
2.34.1


