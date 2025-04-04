Return-Path: <linux-pci+bounces-25280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77CDA7B8B8
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 10:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 146CB7A7D22
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 08:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE08518DB17;
	Fri,  4 Apr 2025 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eh6XwXgx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AC710A1F;
	Fri,  4 Apr 2025 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743754950; cv=none; b=QlrdONJevJoL+9O9k6bKSjnxWWKGUIfD1kiBYMlF015zgkU0CMOKYB3WABS4WNBo+utvzaOa1UmbkpaXR8gmGasPjnGmzecnvW0PSSXak6vWgXwyH8nfolPbmri6DgYhtYqfT9dgYSfrKRMWA8sgfRyi+1BV9DpWs+wWaBwj+1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743754950; c=relaxed/simple;
	bh=8w2ql223nYm+BErM3jbKkWekAvb+1IirdxYYwZl8YAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bWxiW3A1iSaJgH8ahPjdm2JZjSitonzrYWq0cKSQOIyBRfCSalfYUosMy/6eNBfwPrxjVlbhDtuyxeH5h56BaNenH2KZWKBh2HBdhI/ttimcFEkgcuppUCMiEKJykIZmvRcHHXMS/rzYLmCsW1FYr9qa1LxKpjPewHvN8lgDTnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eh6XwXgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C685C4CEE5;
	Fri,  4 Apr 2025 08:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743754950;
	bh=8w2ql223nYm+BErM3jbKkWekAvb+1IirdxYYwZl8YAY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eh6XwXgx7cKNxUXwPxIho+4bXpBveVNvDDkA/ph0m9rQg/+1K7OCcqv6/X9iigRQc
	 vieRfAHJEMe2AU8Vihyvxmta0SGeEd76KY6KCs0DrQcTa5zL9K00WxNBgThU6nRean
	 9DE0AEbsKsBv42AUFvSvz9Bk98TLEAaMu67vQzEe6hG9vXfN6mwRfWF0yGaryBPzCk
	 PQGwECDoCLhe85EbuulPcYlpkEvcXvarWvkqFk82hRgoE8HvddDY1EA0Jmw3H9FLml
	 3PWvHTLAXCVywGYniP0mgjPqG9JQH/UCrsbUA1fvCmCafxkZ9pAo5n6CFjgwehd1VA
	 tVi7eJWuJqdJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00E9C3601E;
	Fri,  4 Apr 2025 08:22:29 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Fri, 04 Apr 2025 13:52:21 +0530
Subject: [PATCH 1/4] PCI/ERR: Remove misleading TODO regarding kernel panic
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-pcie-reset-slot-v1-1-98952918bf90@linaro.org>
References: <20250404-pcie-reset-slot-v1-0-98952918bf90@linaro.org>
In-Reply-To: <20250404-pcie-reset-slot-v1-0-98952918bf90@linaro.org>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>
Cc: dingwei@marvell.com, cassel@kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=789;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=Aq+BoDTRwjfmiHKRLtODTEbwNFS8yDdFMEIJ4A/Pkz4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBn75bDaglwkHeKqhE9AYdkObam0SipeGIjgFjTC
 pJd4g4Uk5iJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ++WwwAKCRBVnxHm/pHO
 9WgUCAChvFjCnq6fJcYlGvuvxyMIhUB0WLffeiqVh6Ay4cY4LA0BJMn0P0zNDsqQ29uI4ys9zW/
 Cb9KhH9McHnBx4bibC2z1FV3VDtUEM40YhgFlSqdB5XHDVDc/1ZQd9Q57zNMevLyG8YmyfPD7gZ
 jSvBlbICm9jNYKuqgVblG45YAaBClN0wTRFGePyZmJbJvm83vnwMWACNI3Ek9cdVf5UVVensIxQ
 A56rmM9gaxYGrXjKY3769BDiCdL9/TV/KqDoTkz7rfOd219Kg9utVeKCKB+l1tpgYHX/vKB7Tf0
 PeQCXiiajJHNhxI9l+fudLfKR/qDu+2NuRZjWCMLMIdm30GF
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

A PCI device is just another peripheral in a system. So failure to
recover it, must not result in a kernel panic. So remove the TODO which
is quite misleading.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/pcie/err.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 31090770fffcc94e15ba6e89f649c6f84bfdf0d5..de6381c690f5c21f00021cdc7bde8d93a5c7db52 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -271,7 +271,6 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
 
-	/* TODO: Should kernel panic here? */
 	pci_info(bridge, "device recovery failed\n");
 
 	return status;

-- 
2.43.0



