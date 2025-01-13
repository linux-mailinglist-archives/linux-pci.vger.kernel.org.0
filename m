Return-Path: <linux-pci+bounces-19662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0F3A0B4F1
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 11:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A0A167E4A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 10:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5D222AE48;
	Mon, 13 Jan 2025 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjoGlL0+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED4A1C1F00;
	Mon, 13 Jan 2025 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736765992; cv=none; b=Lkx6snADC93Ynvqnpr4BlW+8sX16CdxtAy69/JdcA3jjvYta0z1sRXAyTFqytRQ1Nf7d9Q9y3wcTteQf8wRewLYZdjIT/Is9Ls8uUak4lKRJxByHr7m2xFc3eZaPpCTfgIax3aPGdrqy0BXZY2PPlSNjJtjuEGJSLt34rBJK4Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736765992; c=relaxed/simple;
	bh=QIWLDCAmcI1C+xvUDFC7xp8Yn/Gi3b0khk0TnqElATQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PBJcP1sdRSJSl7ji0cWmDcAB4QX4n0ws8kNUOcDKLugb5rJKmxQojRuAbLTyuTY+qKQ5PZMPiQzxtz7dApPuvS4EAHMi29RaWMDC0lg1PylGjBqP3wDHJ/WyGjJXFxpPMgCoRs/L69q1bQzhA2zgOmjDWp1fiTJP923iZpVVO0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjoGlL0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E513FC4CED6;
	Mon, 13 Jan 2025 10:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736765991;
	bh=QIWLDCAmcI1C+xvUDFC7xp8Yn/Gi3b0khk0TnqElATQ=;
	h=From:Date:Subject:To:Cc:From;
	b=jjoGlL0+Uy+eDbOExpu6Pn9TRlQ5ZGhlp1GN9Q3LgRjHfA9SdeElCX+nlXjGZE4Zb
	 vRKGAsp4zVpJCJ5ZI5oleD2VC7fNUL2zcEQnaUpJZdMlEIFPmSjd5vz4VR11LRDc0o
	 AMWvRW3/c64M/UbhWcOV1wBJN52e1BrG5QojGDmUTe6cy5Dnlo13w/0AAVGiwIJbZj
	 ICU5FtJupJeEQOWIhmBWtvlOxjZ4hZWIvbYQEJ00IIyRu8HVQpFK4yvWjj8Lu+Ie40
	 SVoc4wLHhXmuUhJXNE6XqNBfFEltijb8+maPBJHvZyDDUS3pIC6NkftT/aNuvqUxye
	 gQdU/bkNaZchw==
From: Niklas Cassel <cassel@kernel.org>
Date: Mon, 13 Jan 2025 11:59:34 +0100
Subject: [PATCH] PCI: dw-rockchip: Skip waiting for link up
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-rockchip-no-wait-v1-1-25417f37b92f@kernel.org>
X-B4-Tracking: v=1; b=H4sIABXyhGcC/x3MTQqAIBBA4avErBvwpzZdJVqYjTkEKhoVSHdPW
 n6L9yoUykwFpq5CposLx9Ag+w6sN2En5K0ZlFCjkFJjjvawnhOGiLfhEwehnVvtoLTU0LKUyfH
 zL+flfT8OWRQhYgAAAA==
X-Change-ID: 20250113-rockchip-no-wait-403ffbc42313
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Anand Moon <linux.amoon@gmail.com>, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Niklas Cassel <cassel@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1285; i=cassel@kernel.org;
 h=from:subject:message-id; bh=QIWLDCAmcI1C+xvUDFC7xp8Yn/Gi3b0khk0TnqElATQ=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJbPqmYqOpeqY05+MXbvOGK0ZtZrkU2Hi0rufiTuJ6au
 4rv2W3XUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgImwKTL8z9E/tSODJaq3VWFq
 W5d83n+fe5OWlbFfOSd6sDBUQaZYg5FhatCf175aTldnTm572Pi2sv/x5JBbOyeoa9WsSNZYvtq
 UFwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

The Root Complex specific device tree binding for pcie-dw-rockchip has the
'sys' interrupt marked as required.

The driver requests the 'sys' IRQ unconditionally, and errors out if not
provided.

Thus, we can unconditionally set use_linkup_irq before calling
dw_pcie_host_init().

This will skip the wait for link up (since the bus will be enumerated once
the link up IRQ is triggered), which reduces the bootup time.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 1170e1107508bd793b610949b0afe98516c177a4..62034affb95fbb965aad3cebc613a83e31c90aee 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -435,6 +435,7 @@ static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
 
 	pp = &rockchip->pci.pp;
 	pp->ops = &rockchip_pcie_host_ops;
+	pp->use_linkup_irq = true;
 
 	return dw_pcie_host_init(pp);
 }

---
base-commit: 2adda4102931b152f35d054055497631ed97fe73
change-id: 20250113-rockchip-no-wait-403ffbc42313

Best regards,
-- 
Niklas Cassel <cassel@kernel.org>


