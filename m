Return-Path: <linux-pci+bounces-39706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F65BC1CA5A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5215B4E86DC
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52E63559EF;
	Wed, 29 Oct 2025 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="A+G8aKZK"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B8A355806;
	Wed, 29 Oct 2025 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760631; cv=none; b=j52E+OdY6LnqbZeKak4qSJrvg6h24LrAjU41PHcGG/JiOg2Pya543OELDRq7KZMIhyL/A9Tz8RCs5bkU03mt6uTGzVpJNN5p3z3xIrTqSfx8DaMVMqVvY5FD109cb+yDSFwibtZYpFAX6GWp21x9n9UbhLyiniIcZ90efUkXxeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760631; c=relaxed/simple;
	bh=k13cNh78f2SsMWLEgXiABWQ57IKXd/nXYc2niTuOENU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J5hql5ibmFQfy7pPnGggJ771o+kQOzRaEQULKyQg9yFcNUGZ0VkRFK3JKQ2agAdOzMGXW9SthEa8LIA1v9D/KwLLqCAGm8KdEwJhmUrZnEbH5rLOu8DLScQNbfx3/0c30ZWkqF5tKLorhXD7pHtR1wabWEW3Vlqc6rRtv0Ae778=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A+G8aKZK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761760623;
	bh=k13cNh78f2SsMWLEgXiABWQ57IKXd/nXYc2niTuOENU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A+G8aKZKZoQJhZ2r63Er3ESTCLUAGWRbu7+BKxqLwWR0cSy96jDfCG5znd3fuZaWU
	 NRBYQGFqEgC/on9T1UBI2dye05RJfIBTwEBQnaPP5bdX7s5ZoMjuHuk31IWe1zINUP
	 uSwAtzqLcHK7nBDEn6LNxOCl5uno8VBYoRa95eKW//Vd8tbz2IQkSmnp419BQYml65
	 LpfQ90LWjvzU8uYz7BZxkzzlD9znooaPA9fl4GzGC8ywJ3MefFCmx7pK48bHcXm2y+
	 Fuv2P7tYn0p+NAyd+PwHlX1ahZvY8riZy9vSJcfxCNzHvKyVRl+a6v5og9fZ6I8TEu
	 sAFp6GOhYyU7w==
Received: from jupiter.universe (dyndsl-091-248-085-053.ewe-ip-backbone.de [91.248.85.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E9D8F17E141E;
	Wed, 29 Oct 2025 18:57:02 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 2622C480067; Wed, 29 Oct 2025 18:57:02 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 29 Oct 2025 18:56:48 +0100
Subject: [PATCH v4 9/9] PCI: dwc: support missing PCIe device on resume
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-rockchip-pcie-system-suspend-v4-9-ce2e1b0692d2@collabora.com>
References: <20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com>
In-Reply-To: <20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=k13cNh78f2SsMWLEgXiABWQ57IKXd/nXYc2niTuOENU=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGkCVW7puYacCmFgJdWTqKj+Qh5jDC97SrAtp
 xZ17UhDM6EmyokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpAlVuAAoJENju1/PI
 O/qaeDsQAIIP71M1+TU3X3W6kWf7SlBQNcLuJtFUeN1eHFEH+QCIrjX8BolGbKr6yU4V916Ex5z
 zfdhyQXlMFVwpeODkmuT/6x143JVegZBHAborr80gBcFhxgve8zlHpGs54xc/b6fooU1j6m2eh0
 t6N2nwuqu4iX47PL48Aol7Nb5vQ8L16XfyvbapDlLfb/7dZ93bYD+xeO2qlSHGWND2EmUkWpQd1
 Wi73+1UjZSM0JGeXPcfZSLm2MbSjdQ6sFUyNKdOTDldDzJ/bJwbUCxBhwRU8wKz+quUDY/woo3m
 kPz9+RHL0/kFp52rfcl4gQdlHw9AUJv35af3Ii45liecfNansATiiriipmh9Tf93CbiXUmZLy8k
 kKYD+i4OBdYExn6cjEWnVkDCsRdlFpiefVUUic0fA/RhGML33KGoT5W/o/Ie8Bw++jgatGqHbzL
 wZdZqilIX5FrBohby7gsBwfpI8MYCdec4ywdGeGRWFZJZCi37wwA5vrJ0vPWsqjAniBNZzDpTb9
 IpncuzihfoqHsPmz2DJqNayvvurRNQZiy/7WjKWXnGtOPRiLVL3ROJsCaqQxLjUiCtNt2LqMBMI
 II9Pp5I6X10hfdAERoaZqG2DgQq+LM2tsd0CyU2LQhapp1A/LQvycTDbo2LIkjvRgij8o5ofIiO
 7RowZ/MZ6hJFmXmdjiZwuPw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

When dw_pcie_resume_noirq() is called for a PCIe root complex for a PCIe
slot with no device plugged on Rockchip RK3576, dw_pcie_wait_for_link()
will return -ETIMEDOUT. During probe time this does not happen, since
the platform sets 'use_linkup_irq'.

This adds the same logic from dw_pcie_host_init() to the PM resume
function to avoid the problem.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index e92513c5bda5..f25f1c136900 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1215,9 +1215,16 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
 	if (ret)
 		return ret;
 
-	ret = dw_pcie_wait_for_link(pci);
-	if (ret)
-		return ret;
+	/*
+	 * Note: Skip the link up delay only when a Link Up IRQ is present.
+	 * If there is no Link Up IRQ, we should not bypass the delay
+	 * because that would require users to manually rescan for devices.
+	 */
+	if (!pci->pp.use_linkup_irq) {
+		ret = dw_pcie_wait_for_link(pci);
+		if (ret)
+			return ret;
+	}
 
 	return ret;
 }

-- 
2.51.0


