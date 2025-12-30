Return-Path: <linux-pci+bounces-43856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 596B6CEA082
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 16:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F448303ADF0
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 15:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10669319867;
	Tue, 30 Dec 2025 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sU5lb3Dp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CAD2E541F;
	Tue, 30 Dec 2025 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767107260; cv=none; b=hViZ1q/OFxLiMQAKmzeFZMAYdVNG4gEVIsr3by3td1vbcCJzR7myIIu0vx429J95+FDkZvNY8ulmxZs6MFJjsSW1CnGmz2n6rFF8JiCCq5RObKAlbA1fSkqfOxMCo0JFUAI9FLRVmbp05RoemLIbKPQGWNgyEThOOOl8iiqeN9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767107260; c=relaxed/simple;
	bh=1Bx83pDKo9jaY2lEHQcpiSEbGnUIKcROGAVfSg3BNeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TA1myN3niUQHGhV2yj7dd+D1vLRrNUBE0k+Ax/hyVATkTbvMEZkNYL1hRKmR7/0eijneK4eJaaFV1JUGAjRLykAJtIRfYabW2pI+wNrC56oPyxn6DXNh+IMDQ4K6IWo/EsIiFoiQczjpzv3ZE5AzJHzt9MAdQ9Wmbj52hz1VxZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sU5lb3Dp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72D8CC19423;
	Tue, 30 Dec 2025 15:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767107260;
	bh=1Bx83pDKo9jaY2lEHQcpiSEbGnUIKcROGAVfSg3BNeM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sU5lb3DpoafvKMuTWEFb5UHfAwpNhJtsaaEwfFIQwsZe8X9muLW575v0rzT1ver0o
	 adLEgfZCaoY9kEuXwLcnc2VJqq8Z+wi9T8rPtgNCJU4gItDZzqWX/Yq9JiG/ugRB/n
	 HEGx60J+W3MLUYUwbvbTsB4nO+8jlSHUN4QMPt5w3EpsLhtpZCL2oY3ftGe9+/FlD5
	 M+4iYVyAPh5L0jFigdDgIQsDprfPiEzfpmC0hzqQrehaAon/uDUSQ+9WeZANxOwQcv
	 Qxe7+C4wl1K60e7GsUc6cMUaK7Xmv+qXm3tmFo4YrMsc9NGxqzuvd+C9Kv9WHmm6DL
	 pPMbX7aRWPkXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C31AE92FC0;
	Tue, 30 Dec 2025 15:07:40 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 30 Dec 2025 20:37:34 +0530
Subject: [PATCH v3 3/4] PCI: dwc: Rework the error print of
 dw_pcie_wait_for_link()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251230-pci-dwc-suspend-rework-v3-3-40cd485714f5@oss.qualcomm.com>
References: <20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com>
In-Reply-To: <20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=7kXiC+5h1EOCvJw9bEDf4bWdlgkGwkMaGfwFegH0XMU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpU+q6W7XiwNgYjeIJKO9/5oCTCTTpJXIWw4ERM
 GMjRyRL+TGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVPqugAKCRBVnxHm/pHO
 9V3GB/9lz+R75Apz6yGZipqwoZk96F4W2VhtMJl8fr9rz2mdwHWme6XPl33nCqj/T1qPbn73B90
 cPZyekANCa7kPXk1vJxJw3vMcouc6DB0qQsyIwL4SG+fi71kwahO15YPu77mNS/GAKNORm9X78C
 CK5wwjS/E/hCfNQwp29qqGB5aaXc+MB+QE960T2ooiwHkSS4EzkWSsgFFi+WsjxgP2IHITt6K4z
 n/GYmnYw7OvO0pYe9Q5cFdNvUNM+CpW/oDxmtanaJ3oEWyxBHgxbGPSlk8elcS8Ce0Q4WK9yE4N
 Zn8VG9xluChkrtW6+pto4Ne8v1fdGon2PHZCz0MlfyJjr00Q
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



