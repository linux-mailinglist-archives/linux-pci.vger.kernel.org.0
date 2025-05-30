Return-Path: <linux-pci+bounces-28738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB2DAC97DC
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 00:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5359C1BA183B
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 22:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7926A28B4E1;
	Fri, 30 May 2025 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Cc8+WuBv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fU1pMUYi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890192367CA;
	Fri, 30 May 2025 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748645751; cv=none; b=I2U1VonEWY2BF+pp4ueP4O9FUXuy5a7D4foaXLhZNgG6WzEkItegl3+/8vsm3wnQCFMS+32KGJtB9ZXUP2eejtoiQS9nDBkaDJPek+XwtaC9MDbkrGORwVXorzlCJkQEngW8bdOVzbR7fwta/eNbd+HpqtNCWyzwzgqfNccxE/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748645751; c=relaxed/simple;
	bh=uJJuwZ6PBbIIWxoaccWNMJvc1de/B6IihV8ioH7Ho3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kt8whFYHztdMZkY8yvxAu9Ytri7/y5fkvMjBUtO6BzGVbXDbJQKIhbxmCCRUDfL9AWd6C3MGj2WaTja9eKN6FHCk1zbp8ouSLH3l97TwL9Jk2+PXSOniLwubRZOJgUnbleaRZKc6Yp64c7JVUpAufuDW6a49sJL0dPfkf73ZkY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Cc8+WuBv; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fU1pMUYi; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4b8JVq2wnmz9tVV;
	Sat, 31 May 2025 00:55:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1748645747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+XJoie9AEBmbqAgRJsukKa8ozih8Y1Wspy5pUrpo3Yo=;
	b=Cc8+WuBvUV7GDfqiD3oaC4MXKZzLaCbhehQRRGC3LvMoTOnMCvZelp3n0gO9Lvl0tIjYT2
	udXJ4PAfWCVooCp1cXugYZoMGckiStwp4RYj8ScAhCO5Uwlg7gPzO0pxfilxCprCOLdP9M
	MfwfYz0vCuNlFfNr4/F1pdNpVIWLn25FiL7DW9IVyvDxAMKEnc8rswdPnGxDbupzhQ9TIO
	fNE3ur+gpLjCTJpMgegG/UVEroZHi/BFy6Z/laIutQ3QrQXyK6iMqVA9zDqFoyCQuxvwB7
	sk0Yz6G4gY6niZsNgA2qsDaqabrd21hHyTPwol7OltI+UkFGbrlekBA2RtSFOg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1748645745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+XJoie9AEBmbqAgRJsukKa8ozih8Y1Wspy5pUrpo3Yo=;
	b=fU1pMUYiLd852k/Jf4hqU0aVVnYpuvq2UTDF7f6qzHb3GDiA0BwTQkBchsQL9zS+gMB37J
	/2otq3YSfwAtE798cSn+CS+TQRArWj0y4DR6vQ34kBRXjTOgDHtxkAHAWIz/4K2cANV9Ng
	Mb9hdju7ITDbmaylIL08ltHJzmGl6yIO5mJsZmmH/+lVySFjNa4eZdSJnrfpzwR3cRTeM0
	W7ubSTPculK9RHKmSHn7Xri1brYYa7qpihMTorAulAdDYSGAKyT7IcoyAwZknFZGP0+nVP
	Gn/1lUxa5r7nwjymr1jnKhZOqbpdFvxoVyuqDM4BnZVcv8vYeDxebmmyI3T8Bw==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Anand Moon <linux.amoon@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 1/3] PCI/pwrctrl: Add optional slot clock to pwrctrl driver for PCI slots
Date: Sat, 31 May 2025 00:53:19 +0200
Message-ID: <20250530225504.55042-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d7ac0f4db81ab4704d4
X-MBO-RS-META: f9zc6z889u3c4k9su4x5hdhkphnw59fm
X-Rspamd-Queue-Id: 4b8JVq2wnmz9tVV

Add the ability to enable optional slot clock into the pwrctrl driver.
This is used to enable slot clock in split-clock topologies, where the
PCIe host/controller supply and PCIe slot supply are not provided by
the same clock. The PCIe host/controller clock should be described in
the controller node as the controller clock, while the slot clock should
be described in controller bridge/slot subnode.

Example DT snippet:
&pcicontroller {
    clocks = <&clk_dif 0>;             /* PCIe controller clock */

    pci@0,0 {
        #address-cells = <3>;
        #size-cells = <2>;
        reg = <0x0 0x0 0x0 0x0 0x0>;
        compatible = "pciclass,0604";
        device_type = "pci";
        clocks = <&clk_dif 1>;         /* PCIe slot clock */
        vpcie3v3-supply = <&reg_3p3v>;
        ranges;
    };
};

Example clock topology:
 ____________                    ____________
|  PCIe host |                  | PCIe slot  |
|            |                  |            |
|    PCIe RX<|==================|>PCIe TX    |
|    PCIe TX<|==================|>PCIe RX    |
|            |                  |            |
|   PCIe CLK<|======..  ..======|>PCIe CLK   |
'------------'      ||  ||      '------------'
                    ||  ||
 ____________       ||  ||
|  9FGV0441  |      ||  ||
|            |      ||  ||
|   CLK DIF0<|======''  ||
|   CLK DIF1<|==========''
|   CLK DIF2<|
|   CLK DIF3<|
'------------'

Reviewed-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: - Fold PTR_ERR() into dev_err_probe()
    - Add RB from Anand and Manivannan
---
 drivers/pci/pwrctrl/slot.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 18becc144913e..dac1ae854f72e 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -4,6 +4,7 @@
  * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
  */
 
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -30,6 +31,7 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 {
 	struct pci_pwrctrl_slot_data *slot;
 	struct device *dev = &pdev->dev;
+	struct clk *clk;
 	int ret;
 
 	slot = devm_kzalloc(dev, sizeof(*slot), GFP_KERNEL);
@@ -50,6 +52,13 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 		goto err_regulator_free;
 	}
 
+	clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(clk)) {
+		ret = dev_err_probe(dev, PTR_ERR(clk),
+				    "Failed to enable slot clock\n");
+		goto err_regulator_disable;
+	}
+
 	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
 				       slot);
 	if (ret)
-- 
2.47.2


