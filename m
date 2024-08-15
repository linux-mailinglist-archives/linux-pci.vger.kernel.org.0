Return-Path: <linux-pci+bounces-11721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEB4953DAA
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 00:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F08C288F51
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 22:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690EA158555;
	Thu, 15 Aug 2024 22:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WdfsRyWO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCF0156F39
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 22:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762670; cv=none; b=rBcqDVeotEs9TY3ybxcnio5AAhIL7fXJk8PCON8C5fdg0e6YR4v7P+/O9A+SjZjVIFQ1iRb7xjjIl04o84St3PNTlcy8fUxh5BffYGBNrR5V4I5AWsC7QvX6/bAFV/AXZKNv59dUBwgd4vKF/2BrVgVXS/iz+APBSzSMIwdfaMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762670; c=relaxed/simple;
	bh=YyzGlfVd4RKKN8II8JgWABxKdyxEzCEe9Vs/cAPKijs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bZPs6+Wvv7q0sdH7YaMvLKD5Bw9PY/Epg/TplMBLk4SVQCvYx/f+HDmlmfXjlat2csdMDbHkG9/d3k7sGmjNLMdWQ9D2nkw2DefGfkV491Fl1Ssizim99UKHZuIp3FK//ThYSe4wz0pUyxgtdDoL9A2w00LoNNHoeXoWHbeD3Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WdfsRyWO; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d3c08541cdso1037281a91.2
        for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 15:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723762668; x=1724367468; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rVX8RgTSHm6Ud+EOy6KQv9jtPehvGxMYRqmnhzhp8AI=;
        b=WdfsRyWODnWN47RaPuvbm2ootc+sCkIOSKpKdWq2v4DU2EpelifmOLM4v4HlHEZAg6
         tsjL9L++f+tryoIOwSDzfvJgsUF1u2YIOERyAsct9TOV+LkEj34KlIFu+adZmN8LozVW
         e8rZmqvyH6DgYPGbUNXrsTdedjNMD9J3RGu2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723762668; x=1724367468;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rVX8RgTSHm6Ud+EOy6KQv9jtPehvGxMYRqmnhzhp8AI=;
        b=DA+11eM9nI6tr63c6H77AqZTODd/P+rgC4RHJ+TvTnPEOTQtQCBc0H6ii810/9DZeE
         wnA7wc+2FYpi9kSaXTYbRqjCMFNYn9Qv1ll6GnkNqjrPhYGzffyxb1RQKV5Z1ICr0b2Q
         9KEtt+r7qRrSoSqjs3CPlMYqm4Fv0Es7WGmquCcYhqoL79fyGYJQ3U4AugyynwKJnIiM
         WzUT7t+BYGOetiIkBMSpb2Un8fnAhs4zj6ttBbCj+CVK2FHkxC4Q2KZ8JrtHjWGSrlNY
         ubunBdh0r+ThBmtOlGsypijwhNEDmvECq8NS+Z7QCgLzN5Jc07KYfLCQ4pjtJdcU7t4J
         sSVg==
X-Gm-Message-State: AOJu0YzDMjI4VhxWnI8q4lWWAg4jUUikse0z7WnntIac6pvW7iQuAdDw
	bW/kbNN0DlIS9ymByGCcXKeCb3s+DzDstEtmk8xLtxrwGnY4S/O54nWfeBTxt8ice+YBrOeyI66
	hPAy1QMSIgrjoLeG2dVC7NMVkcDOMShFfLaYExr0CeOXVz5UKtAa/w/uuwuiRYh5DrxsjZ49+Pj
	f1dR0aX2nLikiJ/KaIU3VNazTXk5ELKoQcZYPcN0IPdpkpmQ==
X-Google-Smtp-Source: AGHT+IHSw9iGIF7jSQYmCh7ib0/magiimviqCOLAhlU6p/vcHiPwZp1T83vzp8QlMpOVHkAjvKbGiQ==
X-Received: by 2002:a17:90a:bd0c:b0:2d3:b83f:75a with SMTP id 98e67ed59e1d1-2d3dfc7d307mr1357300a91.21.1723762667484;
        Thu, 15 Aug 2024 15:57:47 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2e6b2d1sm373997a91.18.2024.08.15.15.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:57:47 -0700 (PDT)
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
Subject: [PATCH v6 02/13] dt-bindings: PCI: Use maxItems for reset controllers
Date: Thu, 15 Aug 2024 18:57:15 -0400
Message-Id: <20240815225731.40276-3-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240815225731.40276-1-james.quinlan@broadcom.com>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Provide the maxItem property for the reset controllers and drop their
superfluous descriptions.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index a95760357335..7d2552192153 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
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


