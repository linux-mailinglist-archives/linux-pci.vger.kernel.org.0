Return-Path: <linux-pci+bounces-6917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720F88B849C
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 06:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70F7BB224AC
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 04:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9D544C73;
	Wed,  1 May 2024 04:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmfRuR4T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61557433CB;
	Wed,  1 May 2024 04:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714536489; cv=none; b=nK+F4B8US0CXVf9usmiDLieVCRXbSIXVaug0+DP4kdmBjRObG/0ksB37ip0Q3ZXnRloUCSyK27J6Hv+VhJHcfdU5L/4l6k3f6lGkGV85XJO0XSpckioH5ybGwcGJ/oqLmftIfhiMcskTsL679vQZMMeTuMdHhoZsTcPgPXegf3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714536489; c=relaxed/simple;
	bh=hTXTBAcEL8gMHMEYQjxjqOhus0GQvyCJWh1hLepjz8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F342le+1lJD/jXA0U7JHK7tICzWbVUrhm7X7MLYWiIKK860s7c5xGH01nA/8Wu2bV7nUGOLxcO7O9oC+VGenzl4KCwc/d0NMnP3pJCWal8tvKECu8TD1JilkPL+uGLEM84E5on+S4Mou3PWDiFD1OF3TT9YcLYvv9UWEptbmHTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmfRuR4T; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c8644aa3feso1980658b6e.1;
        Tue, 30 Apr 2024 21:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714536487; x=1715141287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53QnHnVF7bqkRAf/NYE3eZQ50tFTHOIRODlZaYfoSVE=;
        b=ZmfRuR4TxvkC5Vw0zjiIH8r9kBSFptuxZtGqLDKqce8S+UBRTaKuPi4xpXIt4ssChj
         tly43tHHFaul6HZW4AWrl0Q9PwBJCiR5uGJBclE4vpMIMO9wYKcaGTcrJSenNep4T/gs
         gKfeJgnQXHBKru0q4kiMUm6fzu4X4niBETYbh9GfvBBNyUnC1SvDvc/9vvOvioAJ7NpM
         u6D/C7qoqhMjUP8ys4I5xQ61JBOCB0+NbfRoMpoIMevBmTD6X+X/iGuSN0P+hK1eoKo3
         80vumvo4/JLVPQZEdv6/gFO3X99GZJkYHwV9QkEXQO+mgAvZpnqvyRD0AUXb0Iol3GdM
         EsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714536487; x=1715141287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53QnHnVF7bqkRAf/NYE3eZQ50tFTHOIRODlZaYfoSVE=;
        b=lPQ1T4DwHvb8L6SkAW++CnZNC8DD7p95dYiA1ElgkHPbCygNClgXhCXwJvwwyZ9ywN
         d6dy12ZRzLhAFDtqf4WIxeSIhS4/DM/Sp8fb8UBvNt4LFSq6msr7c7fPnmmFDTMDlgB/
         L5U5cDyZ4nh3cWKpqpXal48A438p22QMwgmdADUcJvt7UktpxC/+moUfCc5wEQx8tCmJ
         JvRk5J/asVL4+hawF+ZRM1dEYcj505LVapIqH1lvmhA4BGOlkYkwclZayrzc5QuXqCeM
         VU6h5G2wXGTtitfnmZx5OlSz3+Onpn5HuZrwKP06ACMlzqPknZX8FqChqF9auLuNyicO
         C0Cw==
X-Forwarded-Encrypted: i=1; AJvYcCW0Thr0sbAsybsR0e3WLzM8qBMhMhb4VouLHpLCN5eL3OErpFrBgvS374yJf+HE22iSKoGgSKIpb9UfDEaL9ByseK2l2TvI/6DkxYByGyceK4Dbmjg/NgfWPTicLS3glFpUgL1iQB2Lspz5rQpwQKX6hv5HvCDesQk9Z3Y9dQTCxzIlx1Q=
X-Gm-Message-State: AOJu0YxwCoMpoZWq0UHiVw6CLXPuEgm161zTD1ECusFhsf0ycTBlw9p1
	/woCMNmgDecOxGrAwj8axq80lcwNanc8rdAmyUAwZeA5xtFQMgkr
X-Google-Smtp-Source: AGHT+IHLjsBG7zzyJ43r+52W9nzgFGgnrrXmfIif9WOG2DGC2hwDYnPkLo+V/3KvGIUkIklJJw+RdQ==
X-Received: by 2002:a05:6808:d9:b0:3c5:fa5c:7762 with SMTP id t25-20020a05680800d900b003c5fa5c7762mr1514306oic.44.1714536487474;
        Tue, 30 Apr 2024 21:08:07 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id w2-20020a056808018200b003c8643f0e5csm1067872oic.16.2024.04.30.21.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:08:07 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	quic_kathirav@quicinc.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 3/8] dt-bindings: PCI: qcom: Add IPQ9574 PCIe controller
Date: Tue, 30 Apr 2024 23:07:45 -0500
Message-Id: <20240501040800.1542805-4-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
References: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPQ9574 has PCIe controllers which are almost identical to IPQ6018.
The difference is that the "iface" clock is replaced by the "snoc",
and "anoc". The "sleep" reset is replaced by an "aux" reset.
Document these differences along with the compatible string.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index cf9a6910b542..ac6d2b1b8702 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -26,6 +26,7 @@ properties:
           - qcom,pcie-ipq8064-v2
           - qcom,pcie-ipq8074
           - qcom,pcie-ipq8074-gen3
+          - qcom,pcie-ipq9574
           - qcom,pcie-msm8996
           - qcom,pcie-qcs404
           - qcom,pcie-sdm845
@@ -161,6 +162,7 @@ allOf:
             enum:
               - qcom,pcie-ipq6018
               - qcom,pcie-ipq8074-gen3
+              - qcom,pcie-ipq9574
     then:
       properties:
         reg:
@@ -397,6 +399,39 @@ allOf:
             - const: axi_m_sticky # AXI Master Sticky reset
             - const: axi_s_sticky # AXI Slave Sticky reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-ipq9574
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: axi_m # AXI Master clock
+            - const: axi_s # AXI Slave clock
+            - const: axi_bridge # AXI bridge clock
+            - const: anoc
+            - const: snoc
+            - const: rchng
+        resets:
+          minItems: 8
+          maxItems: 8
+        reset-names:
+          items:
+            - const: pipe # PIPE reset
+            - const: aux # AUX reset
+            - const: sticky # Core Sticky reset
+            - const: axi_m # AXI Master reset
+            - const: axi_s # AXI Slave reset
+            - const: axi_s_sticky # AXI Slave Sticky reset
+            - const: axi_m_sticky # AXI Master Sticky reset
+            - const: ahb # AHB Reset
+
   - if:
       properties:
         compatible:
@@ -507,6 +542,7 @@ allOf:
                 - qcom,pcie-ipq8064v2
                 - qcom,pcie-ipq8074
                 - qcom,pcie-ipq8074-gen3
+                - qcom,pcie-ipq9574
                 - qcom,pcie-qcs404
     then:
       required:
@@ -566,6 +602,7 @@ allOf:
               - qcom,pcie-ipq8064-v2
               - qcom,pcie-ipq8074
               - qcom,pcie-ipq8074-gen3
+              - qcom,pcie-ipq9574
               - qcom,pcie-qcs404
     then:
       properties:
-- 
2.40.1


