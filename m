Return-Path: <linux-pci+bounces-23055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C604A54A45
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 13:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFDE188E44F
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 12:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C98720B817;
	Thu,  6 Mar 2025 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKVVCaRE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F8A20AF9D
	for <linux-pci@vger.kernel.org>; Thu,  6 Mar 2025 12:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741262649; cv=none; b=MCVVjZmiy1CnGGjk2fJjPtTJxMUh2I9ZHEdFe4kWlAEo7PPy2JwfDsxiBOGc44lFURy/BymN9reonFLWBH8lXNCktn0seCECyr+NieqVu5t8LHBQ0xvHMriuHt47bBC79/iTBp4KIBvPMBEughLy0Cw4J/Nbrbx7Vt0PPTxuJxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741262649; c=relaxed/simple;
	bh=H+blN+AY6Sf32G1iImcjX++bgpIWJZ6HRPzxVBJtNh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K+yhNVggR8tspxfgDiT+s7xl/oeYGo3aHziCm2Acaw9QiUUqgqYHPQvy0KA4vhAdVFxMIq6QIlCOdW1OsY1yvtsl4YuPvba/Rw4pzo3vD7ZL6vMMvCw7mICnYAjJCseeTuzyE4ODQQ5zaYs6VGuLYjZkQk25TWXUjdmjlqkthPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FKVVCaRE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43ba8bbeae2so835455e9.0
        for <linux-pci@vger.kernel.org>; Thu, 06 Mar 2025 04:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741262644; x=1741867444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iW/7ufkwxaVfB6Z8KpV6A4TIvWsG8TiS8t8AIg7CwAk=;
        b=FKVVCaREBxQrjie7viqDy4VN2kKbatBkNhNP20StC1+nRkApaUm9hgiAekY5y4bHYF
         AV/rbs947G/AAEE28LmP+h/0S0wf5A7tsKwWMM7IQOrk1Gkk8PUStvSDVL3MaX/D7cCl
         xZ8aqZPWUNnlbccoA5pW8yK2SNzvh5S8AgO16vA0sqh+gdJYZ49YAoi43+/I0XQoFrQ+
         vbZ4WYV7rlxAyTxGGtZRpEluVQqfpmif0bQVxeqY4yFI3/xh3wfbTiMeEpvS9V3N6yOk
         hXFM5KOT2Xk9Vv1e7V1HwH46/rlsfi0EsL5i/HY4NdfFrm6CL/rhNIVDmQM/94SRPeg9
         Bpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741262644; x=1741867444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iW/7ufkwxaVfB6Z8KpV6A4TIvWsG8TiS8t8AIg7CwAk=;
        b=p4OaguqawRHtAe+7vexE/I5t2OR12bxeQULbKtBD+VnydaUTQdepdXWi/Kvr4Sy1Ou
         dvaM+p0Bk2X7QbqtkIWPLhgiiVPlWUChQFlIYquJcTQ55lbFsI7tvaUXivj/7MESlTba
         ZDp6mEjR2xYDBXGltaWJlh4oGk4yjxARtEl9GqV9quLnb7PDTuoJN8BgIhPGJ8IMSXRL
         VL3MO+cgMgfmeLlrizL1a6BtZjBnVN4wHRiC5M4zK6I0ph07Vn0CoOpSdMD2nVj7SYcv
         uRqXONEAQDKFnKffgFh3s8XKln3SZs16cY6VOIkURFM5HPTsttjKc+2n8dF7Koe4DoYE
         nrQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgXInVY1mH/6AUAD7XKRjbaxujyZFEPW3q4a/+bkrF/71atqeePbkk3pmPZPU/YTS07lGZrFFsS7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsULFLAOreRkhXs1Z+RsIOkWJgPrnPFY6tubd1AteSa/yN6TSg
	36obmAEpgeMcTL+Q2eKEMAjFnkylNC8zqq1vVoLRoQiO1dfQNQ09Lb77QqmMiLA=
X-Gm-Gg: ASbGncusvDP5Pg4QT/nD/89uFmYfEq02KKA6cHrIBvQSW2a3WOfkA2btlVpTlMbEQd+
	ngKd3hEUnxQT4gICSyak1ttNuZ/vIVBA9yIF2wydSB9sxmBW7lRqJL/wIdKGuO2wrEhRLuRVvzh
	ELiaPrhywWHNJ5uRR31zzETwYY/b86sLsZH8eSFSmbzGEijF1ECA1af8Nsl5C8LdLhwSj4JJpjD
	dt7c8vY4nCCFkG6l31/8BCL4POzyem3OFUISzUC/TG7TOGJlEk+Fh4onPGF31QyBGz2lREUpXaS
	2W7IEQCe9nrGWteMcmALnMp5wqyz+hfzTEgHJT921nrJCgJuYPapzn2Q58M=
X-Google-Smtp-Source: AGHT+IFtFIdlbkW37gMswhBT+eNceXtw518TWjmHeaXf4l5MtvNMofEYAjbb/s/QFM3RznHJQwe32w==
X-Received: by 2002:a05:6000:1f88:b0:390:dba1:9589 with SMTP id ffacd0b85a97d-3911f7b2c38mr2273730f8f.8.1741262644435;
        Thu, 06 Mar 2025 04:04:04 -0800 (PST)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8c3173sm18587315e9.11.2025.03.06.04.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 04:04:03 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v2] dt-bindings: PCI: Revert "dt-bindings: PCI: qcom: Use SDX55 'reg' definition for IPQ9574"
Date: Thu,  6 Mar 2025 13:03:59 +0100
Message-ID: <20250306120359.200369-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revert commit 829aa3693f8d ("dt-bindings: PCI: qcom: Use SDX55 'reg'
definition for IPQ9574") because it affected existing DTS (already
released), without any valid reason and without explanation.

Reverted commit 829aa3693f8d ("dt-bindings: PCI: qcom: Use SDX55 'reg'
definition for IPQ9574") also introduces new warnings:

  ipq9574-rdp449.dtb: pcie@10000000: reg-names:0: 'parf' was expected

Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Fixes: 829aa3693f8d ("dt-bindings: PCI: qcom: Use SDX55 'reg' definition for IPQ9574")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Drop double "::" in subject.
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 6696a36009da..8f628939209e 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -170,6 +170,7 @@ allOf:
             enum:
               - qcom,pcie-ipq6018
               - qcom,pcie-ipq8074-gen3
+              - qcom,pcie-ipq9574
     then:
       properties:
         reg:
@@ -210,7 +211,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,pcie-ipq9574
               - qcom,pcie-sdx55
     then:
       properties:
-- 
2.43.0


