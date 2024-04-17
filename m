Return-Path: <linux-pci+bounces-6377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6CF8A8CAF
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 22:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661CB281994
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 20:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6F036AE4;
	Wed, 17 Apr 2024 20:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4A/Zm5+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A8624B21;
	Wed, 17 Apr 2024 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713384311; cv=none; b=riRTKRzwKz3tel2CLwyv2VLGTMrw+5GqYqtXnW5UcWd6VEW27ZbkcQ8n/S1EAz5sTYnxg4GDutziJ/N9qBI9mZmq58KQyCDmRJ9Yrf0h3Ck42CsPdFyd/a+cnIIJ/T6kICC9wyi6IipRQxZSrHyhhl/zoKlHW9Dkrt4+dAAnyIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713384311; c=relaxed/simple;
	bh=3awQOdHTX/JaPbXW7mXrHqbLtpUvvBMlSihUEiwYNyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ui82XKz1B2TCH11YAGsE3RTu+KN+FjiJDLzdZU38LdarJqXfbdiDyBFek5Z/GC+I495Cpj/2y9oXJ8Soe6QeoLJAa1D/OnlMJb0Gv/HB7FxaeeWeVPd4eHmp6LQxPWYQ9CQW/teSMRhH73I64PTNP8Yvtp2hQ2i2eMRES2i8Pxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4A/Zm5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873ABC072AA;
	Wed, 17 Apr 2024 20:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713384310;
	bh=3awQOdHTX/JaPbXW7mXrHqbLtpUvvBMlSihUEiwYNyc=;
	h=From:To:Cc:Subject:Date:From;
	b=o4A/Zm5+Oh1EKYCKADawrdTF+Mq3xCK09TY8KV6CvyKPOyPKkrSeMUTvctyLfuopT
	 7oiwwKGGy/RSzrpphDkdkx1+N3UwHLk6vw/Z5TNXg7+rhpL1zPzmcjErnboO256Me+
	 7Ha/bANv7+xWWE2zje+SxaIi+Uw6AwWOliIyP4ln4+EX+6mBWY41uNi+PxI7aRND+F
	 qaD7vgc51AiXqChSjB0gZ/eBGZ4vKF5kXSfb1U9xEMZEgUxmDOPQHOkT8M/bAPnWN/
	 OT0O/mO2ylhs8eLSsDiVyKj4mrfa7KHGVxzgQzIPtFGt+XlnFZdrpAxnLVfK4ZuaEP
	 QExdMJQUjOl0g==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: qcom,pcie-sm8350: Drop redundant 'oneOf' sub-schema
Date: Wed, 17 Apr 2024 15:04:30 -0500
Message-ID: <20240417200431.3173953-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first entry in the 'oneOf' schema doesn't work because the top
level schema requires exactly 8 interrupt entries. The 2nd entry is just
redundant with the top level. Since 1 entry appears to have been a
mistake, let's just drop the entire 'oneOf' rather than reworking the
top-level to allow 1 entry.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/pci/qcom,pcie-sm8350.yaml        | 22 -------------------
 1 file changed, 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
index 9eb6e457b07f..2a4cc41fc710 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
@@ -71,28 +71,6 @@ properties:
     items:
       - const: pci
 
-oneOf:
-  - properties:
-      interrupts:
-        maxItems: 1
-      interrupt-names:
-        items:
-          - const: msi
-
-  - properties:
-      interrupts:
-        minItems: 8
-      interrupt-names:
-        items:
-          - const: msi0
-          - const: msi1
-          - const: msi2
-          - const: msi3
-          - const: msi4
-          - const: msi5
-          - const: msi6
-          - const: msi7
-
 allOf:
   - $ref: qcom,pcie-common.yaml#
 
-- 
2.43.0


