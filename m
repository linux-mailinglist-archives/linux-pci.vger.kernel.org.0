Return-Path: <linux-pci+bounces-44143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D07CFC879
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 09:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89E833041ACC
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 08:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5961A287510;
	Wed,  7 Jan 2026 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+gAtCmC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6D9284B58;
	Wed,  7 Jan 2026 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767773521; cv=none; b=XXU30IER2luXOFw2sDVuiC65HxvSZnfvdUZFHl5ym7xo7B2lljMRowwpDhAZJuxcBD2SS8RpBeH45murx0V0EF+anWeFJ++dkqJVfRzOef/gJ28W56tVBVmMYJdzm80eWh5k5aLIdxmkBH3rjmTy9SFvwAVrZMB34p5o4sOgNRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767773521; c=relaxed/simple;
	bh=1Bx83pDKo9jaY2lEHQcpiSEbGnUIKcROGAVfSg3BNeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PeQHL04OJXjxDlWKoYULqf6tzPSAZ/xxRSlKt+0AG4LxpfZ96AjagQmX+ZvCAS8XQDrik0fJsiw7DlumemOnX95QvIPzZCoXdRrr2Q3r1D6Tm2UbzZabPuHhm4jjbQFQBzuC2lNeZ+vX+MWibwh4U2vYc5IMIYcLS5jhabDPFZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+gAtCmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A41B1C19422;
	Wed,  7 Jan 2026 08:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767773520;
	bh=1Bx83pDKo9jaY2lEHQcpiSEbGnUIKcROGAVfSg3BNeM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=a+gAtCmCacrnISTlyMbHwvjqbEGLX04dC7IW7lwMsSZlRdOe8+uvscfBE2pOfVrRn
	 e1u2UOhdz5/CMHi30TuIuL51tBDqukB11Iu6EXEgDr+S6MpD3luyPPnihp0NkZqjt/
	 qmD7yp74LljJuHbQFjiBmiJsxFv8d+j0is4B3ZxwUz9MEiGAbTL6079fDxqR+tkQFM
	 KrLLzVjdxyqEnJcJpm9l13Ft94k7W5HxPRSvX6MgxpNmynrig0Q6GUgOVvCWAaMs3y
	 IcavZeyx8iSq7PkFTmE6SfsS62HcubtsQth/ZK4/av1xv2HepTzpQ+37FuDbv9QSeG
	 Q4gHmJE+X+ePA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9712DCF6C00;
	Wed,  7 Jan 2026 08:12:00 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 07 Jan 2026 13:41:56 +0530
Subject: [PATCH v4 3/6] PCI: dwc: Rework the error print of
 dw_pcie_wait_for_link()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-pci-dwc-suspend-rework-v4-3-9b5f3c72df0a@oss.qualcomm.com>
References: <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
In-Reply-To: <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, 
 Shawn Lin <shawn.lin@rock-chips.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=7kXiC+5h1EOCvJw9bEDf4bWdlgkGwkMaGfwFegH0XMU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpXhVO+wv6IqrXUHtZZ7pCoWCmyGAxjzy7H7TCb
 gQK13gxUTCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaV4VTgAKCRBVnxHm/pHO
 9U2KB/4m72B41t7n/mvH/degieIy7YePSsqP5IBleoaDzPOABR/ntbxCFhi9USstVjCjposC/1Y
 PeBT1LFHVwCe+ZI4a8ZQD8yBGdRVxcUdItAYYUvUuIa78PjPSHy7dJdqhYYqeb45E/812waSWOC
 e44WBUt4/UP8XNNN35fyk8QOoIz3lLo9o6+Ie9zXy2FX3I8tXNY3kb2yxdByomr4HLoQHvJHYqs
 CtZNrWzpvpdW9DmYjd9rLlDbBXVSW4qU8dbqWSxO8G8wFYgO/Kh6R8rNOjFKQMHQ1kWRYlnF8TI
 yvqeok1ufUpEnVSfef6J7BRzeqK9Tko1x1PFTa6hnrQdzeBa
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

If the link fails to come up even after detecting the device on the bus
i.e., if the LTSSM is not in Detect.Quiet and Detect.Active states, then
dw_pcie_wait_for_link() should log it as an error.

So promote dev_info() to dev_err(), reword the error log to make it clear
and also print the LTSSM state to aid debugging.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 87f2ebc134d6..c2dfadc53d04 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -776,7 +776,8 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 			return -ENODEV;
 		}
 
-		dev_info(pci->dev, "Phy link never came up\n");
+		dev_err(pci->dev, "Link failed to come up. LTSSM: %s\n",
+			dw_pcie_ltssm_status_string(ltssm));
 		return -ETIMEDOUT;
 	}
 

-- 
2.48.1



