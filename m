Return-Path: <linux-pci+bounces-6284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 494D08A59C8
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 20:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71BA31C21153
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 18:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E6813C3FD;
	Mon, 15 Apr 2024 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fE2uEqRI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DB413C3D4;
	Mon, 15 Apr 2024 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205284; cv=none; b=CBONvkaWX4PPKK2pbjBTbhustWGPCnkIXMQjGm2PjnzAGg1RIqBXv2OtrzjO0sIuTGl8Hu1iDRfIGvi0uw0A8L3QGRkY92fAexXOXLVMzKAFWDpJfEIr1Vdq+mcqx+NLWyZ09qY1krbyQ8Zejxa6x6KSyiHzLqOW4b069h4eYpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205284; c=relaxed/simple;
	bh=Bi/K2DoHrhLP69oUmfE7G8EDr42IWdwAMdYVVLQinQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cP11pKW0D1eaBqq2GV7DnS4UaqcxvkKMUB96/SWJyDVeZioQmCoXylIDlhkNyJlPbASsDCnk9/XIpS8a1VhICwiVQJnvlIJOCecvopp1YqeqZlgSwyos2/7PlxRqhPIS2MfwdU2EENc2TBkwKm3GxH9+i8nhsbcm6RvZ2meOlXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fE2uEqRI; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a9ec68784cso2100159eaf.2;
        Mon, 15 Apr 2024 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713205282; x=1713810082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTnP6eipSs1lQbgXBNYS3udbxY0JHas09pkOXVb4n1w=;
        b=fE2uEqRIHdvYvWf2qg1OII8T2eQ5VaXiWmv//NPWUWSYr2hLlJCjmF83YG/PV/ZEVH
         CTbdChqr10thcNnPPaj3q1ErMukXzaVX5P+Goua7dgeQtzSbYQ/37vYoF5mIBhtiTBxY
         TQNdtaaL0xKOvWKGfoDDfT3VZ37/dejAIxVU75CwfK/QaZDJHb7KQdPGtIalHstGbNOs
         sBjhf6OFYE/ghIiBtYahdrBDbSakU6xLbFi9vt5PRfGF7IfK0EuahfoSLYOLaxbm3cOH
         E1UPcV2MLa+WLSBCKv2w3utgBwMpf8LAPDvey1Ttde8j8ag2c9e/FquYsiLI+xfQ+AIU
         5BRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713205282; x=1713810082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTnP6eipSs1lQbgXBNYS3udbxY0JHas09pkOXVb4n1w=;
        b=pWMZfZ1upI2upk+DULXJGujdaja4Ux9bhoy0vksxiHqhHRHhiHPYox7ZmFNSrfzxrV
         u6Ntr25D9hPsPvQX0GkH2tWN9xMFkbseoQuvdTyo3ygKeNfuW7PNImZ4m5hTDBfsQkoa
         Upa7aoiPjk6FZPm0+l+f9KZJUXGN3O18ly0Ll20yyp/KUgZXkt/1OZbyyG4n86N4Id+h
         +gakOcKvxVVA01oNA/e9K4YTzyqZNohLCjz+Jsl4720YxrdPtdYfHXue2GkIJmSgpKzA
         yGOcCF45a10zJNgHuVfAfoXk5xHhm0kB6VLRc1qnMAVz50zKHwQIZSUK1SBOXh8Hr4e7
         gABQ==
X-Forwarded-Encrypted: i=1; AJvYcCW15RxRrc7Nz2dmPsJOt2PkRTV92fONaUZ9GiitNs67w+Ev+Coj0lrN1+yPR/297BFGAkWQ7gxfcLvK3kQIeNqEd/ihYPFTqo5drkRLNIH8dupZ9kF/aBuuSj81C7Vwh19GdoJReacT3j57hQ46a/zYrnoRwRFBDkXCQA2OGdmDgmKrwLAXkdhPhO7Hi/MXroUuKkwOnUUQeozO0u5vlPK19oD23EMWyx0t79PfpyBvKqApECkt2k9XpyIVu4w=
X-Gm-Message-State: AOJu0Yz8zktAFvxawW9kaOTMbfztdx1NJospZ5p1v1SDhjcZHRQBQ/d7
	HxblcdreVRmRjM7qYwwqwpB+pxfd1Lgn4yvRRiYiK1iSRbC/BMYvgePOg3r1x4U=
X-Google-Smtp-Source: AGHT+IHg5ugq1lohZEm0ehzMxEcdWVwoP8XQwZRTCLQ22SHdryJbt4bEX3o8wVWphYHKU7n0nCcShA==
X-Received: by 2002:a4a:1482:0:b0:5ac:c39b:3a7a with SMTP id 124-20020a4a1482000000b005acc39b3a7amr1127677ood.1.1713205282432;
        Mon, 15 Apr 2024 11:21:22 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id x4-20020a056820104400b005a4dc7abc01sm2177494oot.11.2024.04.15.11.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 11:21:22 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-clk@vger.kernel.org
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH v3 5/7] dt-bindings: phy: qcom,ipq8074-qmp-pcie: add ipq9574 gen3x2 PHY
Date: Mon, 15 Apr 2024 13:20:50 -0500
Message-Id: <20240415182052.374494-6-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240415182052.374494-1-mr.nuke.me@gmail.com>
References: <20240415182052.374494-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IPQ9574 gen3x2 PHY is very similar to IPQ6018. It requires two
extra clocks named "anoc" and "snoc". Document this, and add a
new compatible string for this PHY.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
index 634cec5d57ea..89949f4e89db 100644
--- a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
@@ -19,19 +19,24 @@ properties:
       - qcom,ipq6018-qmp-pcie-phy
       - qcom,ipq8074-qmp-gen3-pcie-phy
       - qcom,ipq8074-qmp-pcie-phy
+      - qcom,ipq9574-qmp-gen3x2-pcie-phy
 
   reg:
     items:
       - description: serdes
 
   clocks:
-    maxItems: 3
+    minItems: 3
+    maxItems: 5
 
   clock-names:
+    minItems: 3
     items:
       - const: aux
       - const: cfg_ahb
       - const: pipe
+      - const: anoc
+      - const: snoc
 
   resets:
     maxItems: 2
@@ -61,6 +66,35 @@ required:
   - clock-output-names
   - "#phy-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq6018-qmp-pcie-phy
+              - qcom,ipq8074-qmp-gen3-pcie-phy
+              - qcom,ipq8074-qmp-pcie-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          maxItems: 3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq9574-qmp-gen3x2-pcie-phy
+    then:
+      properties:
+        clocks:
+          minItems: 5
+        clock-names:
+          minItems: 5
+
 additionalProperties: false
 
 examples:
-- 
2.40.1


