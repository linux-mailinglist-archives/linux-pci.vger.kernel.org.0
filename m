Return-Path: <linux-pci+bounces-28391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 768F6AC35A4
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 18:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D34177A8041
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 16:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCDC1F4C8B;
	Sun, 25 May 2025 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="q7fH74UC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vx6ZmcZP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782D21DFF0;
	Sun, 25 May 2025 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748189140; cv=none; b=kK3yObruykVYVbNX5cptNRrwKwgt8ZLLkXqm+qL6CBxV+pZF/wvV6r+ZKJEKTlGrKJn9IifdkJhNLgjOJY58XUM/ETCpVAQV62B/dR6F8A/VypJSQyFIpF7yMjfianc1BICZKg5Ud/jdc8g1CB0igxsX7KV0bDk+sHo8NI31TkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748189140; c=relaxed/simple;
	bh=pTuymkOrpS5RFKgxJt6ziJrv8AvrrjbLS7gvg7FVyKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AKc5/qbZCZ4vWqhHUDnfLtCBGgclTfsNqaCUr2QU6RgyNZK8Wc/2g4lhBU7iwPTSEvcM0UoO/rDmGB0Y19k7FcoclIH2eDdxqL8qoCKbKXr+EZq9Qtt9GafuhYf9JfUbFThik31jI+WobQ4ehlrhIeR6JPHJmeLCnYmf/zVckTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=q7fH74UC; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vx6ZmcZP; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4b53dj5TXkz9sQv;
	Sun, 25 May 2025 18:05:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1748189129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r6Bs6NUrhRuWdYh2pTI3k1vpGojw0BMsDwh3G1I30Yc=;
	b=q7fH74UCiGjUCtvewWiab8OveZ5LFfVl9RJXCN5M9knYjnkHpJqEsniAcQWLHFxnNMRY6p
	VhvvsZLioOVUlULBNftr27WstEet3ye5HnImH0lEiBiNyjd93xB7iIw65EonLNdiT9XyPX
	B+dDkbahyv+9EU1qjZjRl8BQymJ9csoIcI2U1zruVAcG/6+KgZKn3c+/dB3b8SRddCqlEO
	toR9v919wd8D7oojYKCqsIpoWadCQ+WF/xNe4IdaBIM9kptE8LwVcry4DThrpHvAjUfQG9
	jevQ1iFJ1hSEPyXwQfRCqODsT0qsAcW7Y+uG4ANxWAp7UG+4TjN9w7I3/0M8ow==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1748189127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r6Bs6NUrhRuWdYh2pTI3k1vpGojw0BMsDwh3G1I30Yc=;
	b=vx6ZmcZPScSAn+W0D42gmSdW6iD/n6XE/QL1GTl3QAvdSlTquHt+DbX6am6Sw38qYKcmGM
	FqVLWzkEBhhTMMM6I1TCohAlcDAHuHhdDMfyeG0dxylpZ2aKvo77hkxZNgeAbGnlnKE05Z
	2NFit28YckLdWUrHYKZzKl/JI4UnSF4vY2Idp9R6L30YGkTzu5YuxLt2mHLF6q1oFd+EaS
	Y4PLbrYd6j69/bqxYPhPG6pT1iuhycP6bv8Yems+1UOw6eUp0qf3/3LXiHmz3fMcnZjcqi
	OKGqecvgw/FmT+l3l7CxzIqb6CkU1JQNAonDFamQo86Qcjq6yeMK4coRSn4SaA==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/2] PCI/pwrctrl: Add optional slot clock to pwrctrl driver for PCI slots
Date: Sun, 25 May 2025 18:04:03 +0200
Message-ID: <20250525160513.83029-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a0166e157057709b695
X-MBO-RS-META: 54eity3pg7adano1bw754w6wzqd8pdzu
X-Rspamd-Queue-Id: 4b53dj5TXkz9sQv

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
 drivers/pci/pwrctrl/slot.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 18becc144913e..222c14056cfae 100644
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
+		ret = PTR_ERR(clk);
+		dev_err_probe(dev, ret, "Failed to enable slot clock\n");
+		goto err_regulator_disable;
+	}
+
 	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
 				       slot);
 	if (ret)
-- 
2.47.2


