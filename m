Return-Path: <linux-pci+bounces-23480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF30A5D843
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 09:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3177B18921AF
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 08:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F701233D99;
	Wed, 12 Mar 2025 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqtOvXIF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC82A20C472;
	Wed, 12 Mar 2025 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768380; cv=none; b=HoTG0bOGzY0+orogrx2XcUSJAgj2F8mJyb3G5HbG4mXUfZcZSVNt7VsyW47SnQP2yvw2E7tyfYVzWY1hG/1UP2kwOLd6dXJn9uDgxwwKmVYZq9JuLWOm4897NYjPPJ8tFQ8pzLn1+GQldKKFmDPV8hxQjEnb/pGyqSwBAbR0okQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768380; c=relaxed/simple;
	bh=RcBhlT2wJn3QV0h8NY8IhycUw8J//pMHO4F8vBiQQsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PXAOZvrJ1TyrNNKXTx8i9JsmcSYiwPU9dQpUO71QDcGyTC9OY0bhxQccpeD5MloVa+OQMxRsAlx18SQVbWRcLLKkGzrwZh7t+JOLFE11IVZiKTFbYAU7+JzNfPMDYjWbz7ss8PARn5oLEI51ZEmTjnKEQ+O+tafCJAR7Q4EvZeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqtOvXIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111C8C4CEE3;
	Wed, 12 Mar 2025 08:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741768379;
	bh=RcBhlT2wJn3QV0h8NY8IhycUw8J//pMHO4F8vBiQQsI=;
	h=From:Date:Subject:To:Cc:From;
	b=SqtOvXIFIZC+nqsLcY2N76Z77uJV4Rhpe2+LC5SYq7WYcQOlXvBugyewsD8fDuOBo
	 XwmB/diod4drV+uk8DfSUUuVy71cfBufMIlUss+0UvuFYQOuXc3xsLJBnVvalXwYIo
	 v+HBSmXJRXVe0QP+mNL4mJRzFEChCN8Wo73wHfvnoqzOsqg+VFX/ittlTLbnmaQN7B
	 3iYVlA6xJ0okgXnitcACBFdVHuwu5uiEMZdsj1V2a8NBsA3CwxqBF7OpBw0Gn+/AJo
	 WfktkVgtOW0fCFUb8xPI6v3oNXzFHIJJiUR0GWX7n2kYE9yq5mjW8NSkeH9ah70Zkq
	 1tW72tQaRTTfg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 12 Mar 2025 09:32:15 +0100
Subject: [PATCH v3] dt-bindings: mfd: syscon: Add the pbus-csr node for
 Airoha EN7581 SoC
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-en7581-pbus_csr-binding-v3-1-7bd9f00a25a4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAI5G0WcC/4XNTQ6CMBCG4auQrq3p9EfAlfcwxtgywERTSKuNh
 nB3CytdGJfvl8wzE4sYCCPbFxMLmCjS4HOoTcFcf/EdcmpyMymkEUpUHH1pKuCjfcSzi4Fb8g3
 5jtelRrBatFbtWL4eA7b0XOXjKXdP8T6E1/oowbL+NxNw4HVd28YJFFjqwxWDx9t2CB1b0CQ/I
 IDfkMwQtM5Yg7qSqL6geZ7f2m/3/wgBAAA=
X-Change-ID: 20250308-en7581-pbus_csr-binding-974e1b40fb36
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-pci@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce pbus-csr document bindings in syscon.yaml for EN7581 SoC.
The airoha pbus-csr block provides a configuration interface for the PBUS
controller used to detect if a given address is accessible on PCIe
controller.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v3:
- Fix commit subject
- Link to v2: https://lore.kernel.org/r/20250311-en7581-pbus_csr-binding-v2-1-1fc5b5e482e3@kernel.org

Changes in v2:
- Move EN7581 pbus-csr binding in syscon.yaml
- Link to v1: https://lore.kernel.org/r/20250308-en7581-pbus_csr-binding-v1-1-999bdc0e0e74@kernel.org
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 4d67ff26d445050cab2ca2fd8b49f734a93b8766..7639350e7ede40c8934f41f854ff219354fb3e5b 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -27,6 +27,7 @@ select:
     compatible:
       contains:
         enum:
+          - airoha,en7581-pbus-csr
           - al,alpine-sysfabric-service
           - allwinner,sun8i-a83t-system-controller
           - allwinner,sun8i-h3-system-controller
@@ -126,6 +127,7 @@ properties:
   compatible:
     items:
       - enum:
+          - airoha,en7581-pbus-csr
           - al,alpine-sysfabric-service
           - allwinner,sun8i-a83t-system-controller
           - allwinner,sun8i-h3-system-controller

---
base-commit: d71fc910c58ed85a2ad5143502030bff73fc2088
change-id: 20250308-en7581-pbus_csr-binding-974e1b40fb36

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


