Return-Path: <linux-pci+bounces-23465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDADCA5D143
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 21:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F1E3B3906
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 20:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9A5264633;
	Tue, 11 Mar 2025 20:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUtrOvyY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C091EF368;
	Tue, 11 Mar 2025 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741726632; cv=none; b=Xz+GG5E9ytuFzL4smmgtC3/tzLNizDGxTelZsQN5ZefLzaO1NoltzOKkXUjRoqy5dmgFyBqyW7UjbK7Otr45hGqsEYHhAopXvDECo6xOWBDuc/x5bh7U8RnVfoviF5SqpmKJB5TF3hriT+d1ffuQTa9oNdK6K9mmwiETNOPc9Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741726632; c=relaxed/simple;
	bh=gBpUrcidbnHfQaEWdbVDXK2zU65oCxLuAp1amXO0y7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BEuP4dYorHI7nvT0nZtiZPDzGIpS0r6jRmysxzYUbLmU0wWVt9FsYRGvTvltDjppC/2HNyHEwigsnakihx49LYt/Z9gO0r0mH6iOQcvewi0FMGjQqoLqDhWCK3pSgKsIRiIqPqiRrw6ErHKwkS/OP0I0Dw/Yiay0dUP8MuCWuj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUtrOvyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C235C4CEE9;
	Tue, 11 Mar 2025 20:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741726631;
	bh=gBpUrcidbnHfQaEWdbVDXK2zU65oCxLuAp1amXO0y7Q=;
	h=From:Date:Subject:To:Cc:From;
	b=rUtrOvyYW+Gj1iZmchIJbovsyZT3h4CQuQMVGYsZ+VXVRQgCJ9qDsMrhwgR9bsX+g
	 lqdKH18WBX/cPusJ/Ls463IXwYO4icck+4tKO5NzTmnG9L/r2pW0g9aOqdWngKXP6g
	 PhCtB8xbH4khlrZPRxhZ7exd09hwIUvCcZOrfR6vfpIdBhnngq5qR/sCn+HRT0sPlE
	 Q3EVQoVgU7jJjG2TdNnvH3DjTX1lBmXza9xyWlGsgWfjK6BvCawprLe7+1C1xeS/Pd
	 BOG1Mo0+RQ/RXyM3NltPRLjMSk/k/P38Zfse0/yulB9a7mvedjF5vkkelZ8GWKG4N5
	 qcfJyGi2QoOoQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 11 Mar 2025 21:56:48 +0100
Subject: [PATCH v2] dt-bindings: soc: airoha: Add the pbus-csr node for
 EN7581 SoC
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-en7581-pbus_csr-binding-v2-1-1fc5b5e482e3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAI+j0GcC/4WNWw6CMBBFt0Lm2zEtD6F8uQ9DjC0DTDSFTJVoS
 PduZQN+npPcczcIJEwB2mwDoZUDzz5BfsjATTc/EnKfGHKVV6pQDZKvq0bjYl/h6oKgZd+zH9H
 UJWlbqsEWJ0jrRWjg916+dIknDs9ZPvvRqn/2f3PVqNEYY3unSFFdnu8knh7HWUboYoxfFir8E
 b8AAAA=
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


