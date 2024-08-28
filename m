Return-Path: <linux-pci+bounces-12358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F09962CCB
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 17:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B9C1F21C67
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 15:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F1C1A3BAA;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4Z4rbfF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDC81A2C20;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859984; cv=none; b=AQBs+JqsdwNaiSVEpgx27RTju6cmXnx9/a5bK1wcKAcuk2am7i2c2qekeQB3OXax/qDFzOpFZwLXulzZzEyP6YDQAQS/6BdtCKWtoBhtA6d8Vh2rW7CqBH7F6Jk5b/bao+x8z08ZfEoD6imiBp6OqijLDp0OJ3CYVB2WI5f2KH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859984; c=relaxed/simple;
	bh=Dynz9QHhPHZXKKO8GD6i2AnmK4GVgprdx9YpUpdCd88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I55X1T8b/h+GIbFnrzBzFOxJmxw/gsi42Ee7wHxpTifP1L5y1b8bW774PEevXHuRaprT1fOOxHPWL42uI7J98+9qunIZ6M9ELWVXQ3AlhO8uWuXKQW608UCN/tKOdSoBkvjq+GAExPkGz9g1WxouYHXPTJg8aYw3/ASKd37f+7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4Z4rbfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DB6AC4CECE;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724859984;
	bh=Dynz9QHhPHZXKKO8GD6i2AnmK4GVgprdx9YpUpdCd88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=F4Z4rbfFbsYLAEqCjFwS63fu1HWvCe5kXa1Ylq2xDV1rbs92LDmR/3+Uk2A9SePNl
	 NwHmWsdNIPGQioyz2NrocKh3Myc6dF+MeovRBlXg/sHyACGGiBZngZSzyd9Hz4Y98i
	 zTHqSmQ3qjvOQSlyKNT9xDQQkR+cutf2oKnB2maHxmJBh95ubA4OmlP439SCrkbN/J
	 lZaW1J23nAEMsNHEYyFN4o41kxtWWXzQrT5PINQt+Eg2tDou+MG4W9GHLTk0UrEy+V
	 2UAZVqsDIXKuIEt5Uk4JUisaUGAz0ZXNYoYZvN1chNE6YJ+1IG8RiVC+XcJQpHrxTe
	 26L6z+75OYPJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374A6C61DB8;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 28 Aug 2024 21:16:13 +0530
Subject: [PATCH v4 03/12] dt-bindings: PCI: pci-ep: Update Maintainers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-pci-qcom-hotplug-v4-3-263a385fbbcb@linaro.org>
References: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>
In-Reply-To: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1035;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=5QyilnsJ9fmtdU7GTZXO3WdPGs0Omyndpvk9fplsO9U=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmz0ZL9jhf9luAKQ8qfWImj9qozgYiGeIAlxwGL
 prt2m7x4peJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZs9GSwAKCRBVnxHm/pHO
 9T1+CACHbI2AivhKTRkze2MUArBxKQMu0jB/2dJ5a9eEid1AW1bg1voHlMvfKVnfrBW/PkvFf+1
 bd6g/ZBNzp1wu1vLZKCMmZU/jhNBOdb1ANYCE0hYmHd4VvBBO2tbPpPcjBcbicni6Jkf78JqcH9
 ssFKzRDcMViCUF/0Afu02ovq4o9PQTptUGVYksvd/pzlPLQlE1ndFgIvWvnzxua8xuz5ix29ceA
 giFSwuEkggtV0xcbedZUKkZmhO74SihSSYVRA4ElnStGan9MiZX4kl5BJj/Vq6jFvSfh5Gk8mR7
 DAei/rpgIHWqKfTpNlBNV517jJakADUbRc+D2XOn/HPgwI4g
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Kishon's TI email ID is not active anymore, so use his korg ID. Also, since
I've been maintaining the PCI endpoint framework, I'm willing to maintain
the DT binding as well. So add myself as the Co-maintainer.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/pci-ep.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-ep.yaml b/Documentation/devicetree/bindings/pci/pci-ep.yaml
index d1eef4825207..0b5456ee21eb 100644
--- a/Documentation/devicetree/bindings/pci/pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/pci-ep.yaml
@@ -10,7 +10,8 @@ description: |
   Common properties for PCI Endpoint Controller Nodes.
 
 maintainers:
-  - Kishon Vijay Abraham I <kishon@ti.com>
+  - Kishon Vijay Abraham I <kishon@kernel.org>
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 
 properties:
   $nodename:

-- 
2.25.1



