Return-Path: <linux-pci+bounces-27688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBD3AB64C1
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 09:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3EB23A8580
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 07:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A7C201004;
	Wed, 14 May 2025 07:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFrO/CRq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7C51F78E0
	for <linux-pci@vger.kernel.org>; Wed, 14 May 2025 07:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747208622; cv=none; b=S5NOzyXufXU3jGWmlHdRyqQsrKdWhMDMAw0x+uBEU0h75DEpBh1YRb77VLbOahCAhlnRBhyzL1mnn92qGzAmu5Xtr+3jQ1FdD1F5XuMFlzEl4BKPs0Szhajz/zoNBDNyP2FcXb4mRMCccPRz0e/fKAMzF9moZhiq5Gb5DGLN9v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747208622; c=relaxed/simple;
	bh=RyhruE6zKmGxhOShSmyhroR/uyRb96m3QEDzAE+HDpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K40vDR5djfB9BT6HMwYZZdtgzs4WeObspRQlDMlSQrQWQ2ZwDQlYFENt7SbYg8/1N8uYYxiJ6+GMmcGaY8BewIomjmKaDjstsPy9xVydOGwyerXvoGCmxZqlxpojco3zCpiebYut2o0RN8mIWlC0/w5HaAKJCdkOjKX0Akx+AZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFrO/CRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B19C4CEF0;
	Wed, 14 May 2025 07:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747208621;
	bh=RyhruE6zKmGxhOShSmyhroR/uyRb96m3QEDzAE+HDpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZFrO/CRq3RlW7FjqktH9YzXLwHCJ8UTGw9upl/Z68dE+R9TOMi3z+pHNUl4mbyo5O
	 BFgcCQHj16+CryBr1CSoPwBHj9y15VArNdB0KdeXtUFvBZYgYiPKtB4EZ4+4v+2sI9
	 oqBcB26cW/FkETM0dEit7gw3uzZsHegg2etBCqcZKu+c6YGto5q8TIxXkzWGD/Nj7W
	 DEJSBXVsGe5hbiQvL6QnOVVkInirz3sJ4B6o9BrIzWEqkxQwu/DPWtbb8Y1mRVeurK
	 DNL0ndLu8UF20mbCtnH3rv5/A0odicU4vEa7qMHfaT6uz3yHZEm+8EeT2qlctkf5Lv
	 gCaoCD7aXGKuA==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	stable+noautosel@kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 4/6] PCI: endpoint: Cleanup get_msix() callback
Date: Wed, 14 May 2025 09:43:17 +0200
Message-ID: <20250514074313.283156-12-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514074313.283156-8-cassel@kernel.org>
References: <20250514074313.283156-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2726; i=cassel@kernel.org; h=from:subject; bh=RyhruE6zKmGxhOShSmyhroR/uyRb96m3QEDzAE+HDpo=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJUPCfnT8qqXn5Iq3J1z4YXNVXXhFb9VPicFLnuqtxMv xu/vVOXdZSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAi/1sZGS7NKrANm/G580LF mqTfjFuYmPKZenu4FirdKos/VSapW8jwi0k6eF6Jq4jbispZk4vFWOLLco6orVy34Me7tT3TtK6 1MgEA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The kdoc for pci_epc_get_msix() says:
"Invoke to get the number of MSI-X interrupts allocated by the RC"
the kdoc for the callback pci_epc_ops->get_msix() says:
"ops to get the number of MSI-X interrupts allocated by the RC from the
MSI-X capability register"

pci_epc_ops->get_msix() does however return the number of interrupts
in the encoding as defined by the Table Size field.

Nowhere in the kdoc does it say that the returned number of interrupts
is in Table Size encoding.

Thus, it is very confusing that the wrapper function (pci_epc_get_msix())
and the callback function (pci_epc_ops->get_msix()) don't return the same
value.

Cleanup the API so that the wrapper function and the callback function
will have the same semantics, i.e. return the number of interrupts,
regardless of the internal encoding of that value.

Cc: <stable+noautosel@kernel.org> # this is simply a cleanup
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c  | 2 +-
 drivers/pci/endpoint/pci-epc-core.c              | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 78b4d009cd04..569cb7481d45 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -281,7 +281,7 @@ static int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 
 	val &= PCI_MSIX_FLAGS_QSIZE;
 
-	return val;
+	return val + 1;
 }
 
 static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 03597551f4cd..307c862588a4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -575,7 +575,7 @@ static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 
 	val &= PCI_MSIX_FLAGS_QSIZE;
 
-	return val;
+	return val + 1;
 }
 
 static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index cc1456bd188e..092b14918b46 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -355,7 +355,7 @@ int pci_epc_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	if (interrupt < 0)
 		return 0;
 
-	return interrupt + 1;
+	return interrupt;
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_msix);
 
-- 
2.49.0


