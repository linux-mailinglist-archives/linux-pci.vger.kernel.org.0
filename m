Return-Path: <linux-pci+bounces-16082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D60C29BD7AB
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 22:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EFF11F23886
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 21:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AD61FF7AF;
	Tue,  5 Nov 2024 21:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uN+lO086"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F79B383;
	Tue,  5 Nov 2024 21:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842349; cv=none; b=e0jWgH55ZmZiCaBtQBHoByHXZaw30MREWUBRpkq09vTObpZzOxfnExsOCMgMleFy0P8ryIaxJJWuUZtcV8IhhKooWtqLBT+cEwU9eqwFa/qNHYFFgh1+BNLExycSoZYmi3fmnafLw0EyWemoP7xK8gI0XsvedQ/STiywDnydAYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842349; c=relaxed/simple;
	bh=VPn43wAZGoYXULMAO2M9B6irxJTqWWp/JJbEaT4o004=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mo78l07ljiXxpZTO8Hvzs+va6guxV1dh+QjYRiUmwBa6EoBaMry/XU9awpzcXjm6cZ+R25P3PIhUG+XxXBU5bxbw84+jVo33a4cxIOyL8RYkgzCSZtiAmYY4FRV4bf450/vt8POtBkio0XezAWzli/1OOUQ3Qgkh42+sFfSS9yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uN+lO086; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11D5C4CECF;
	Tue,  5 Nov 2024 21:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730842349;
	bh=VPn43wAZGoYXULMAO2M9B6irxJTqWWp/JJbEaT4o004=;
	h=From:To:Cc:Subject:Date:From;
	b=uN+lO086h278Di79DHySPggFnq3df/7yu5rD6fcMMpDgnbm5lDLai1iaqLyttZzGa
	 NvFrQtyfu6efJcOvc0Y1uV9JCkbORQLdhap2uAkuh23ZV24nlfJ3nfeYIxL5bagfaS
	 BlS/V51G5tfSkPFHtSmHZi7PW+gARDJABEe6xs1FNWsQgZK3oyKSJ2mknAVPkYnLzZ
	 my7nRbYlhG9MJkapuKox4v6V5HvuFn8puJ9BupdtLGkSIByjpPGPoMjWQbeb0nBvsd
	 5+GKUOLBQOLX89HNw4+C+Ne1ceP7s9N8CPzu/qh7A3JCiWWA+rD7YPjnhlyfUz2z/u
	 cQTDVKkiJxuGg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: snps,dw-pcie: Drop "#interrupt-cells" from example
Date: Tue,  5 Nov 2024 15:32:16 -0600
Message-ID: <20241105213217.442809-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"#interrupt-cells" is not valid without a corresponding "interrupt-map"
or "interrupt-controller" property. As the example has neither, drop
"#interrupt-cells". This fixes a dtc interrupt_provider warning.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 548f59d76ef2..205326fb2d75 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -230,7 +230,6 @@ examples:
 
       interrupts = <25>, <24>;
       interrupt-names = "msi", "hp";
-      #interrupt-cells = <1>;
 
       reset-gpios = <&port0 0 1>;
 
-- 
2.45.2


