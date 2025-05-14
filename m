Return-Path: <linux-pci+bounces-27687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7E6AB64BF
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 09:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66385174191
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 07:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21611201004;
	Wed, 14 May 2025 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XahU6G1Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED081F78E0;
	Wed, 14 May 2025 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747208618; cv=none; b=NUN/Kgr6XdQTQLTcI5lGoLoDCRUGq0+Uue3WRBr8ZKIf1JlnhZ5jyDePuRVy4r58GuPYfHqqi8KSKvMXFTWqu9iv+95zQXEOJhknBckVfPhS9vLhsmt1geLP84lEjREH5+wxuiWxM0xAlopyQSoOJRFpZpIgiSia2IZBhdoDyFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747208618; c=relaxed/simple;
	bh=MOjVq0wsI47Gay1z9sU3CotJFGegvueUV3NPqsKkawk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6KB0tk5e9K6NgMkbrPEGJqBHMvf25ejXV09PoslDy0A8vGouzVUFExnn74vWG9Eq1umqmyrgnV9FeI7sgBmWYlB8HMYxUixxvemVzefBklCh8yPgNGN7BjW3bSO0qI46J9wkTc5vfehJhgLzK+3SJyN8CxD6bFkb2AUyABMIQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XahU6G1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701F5C4CEF2;
	Wed, 14 May 2025 07:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747208617;
	bh=MOjVq0wsI47Gay1z9sU3CotJFGegvueUV3NPqsKkawk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XahU6G1ZXiiEREdHl/B2zjPLgtscLuPDObp0fhSW5DEA/6mvPJ4Ob5ydel/J60QPI
	 ujBGAn9acG63f97KvCips7XBNpQ8mq5qhomGwg5mr5fSmbR+DgVxw6+hkupDRP/M4F
	 ZzjPF4cKNm8oqfbuFnFt1rnFzT9g6qFTt+6lUsnu9vB19QpXYlSD/CxamQbvshmmeh
	 7fUui3mgixPpJwX82Z6MhEko/jyL0B+tcN0vMUn9NiSgFZnr/PoVYWy+Zovsmhumr3
	 hXWaeKFIz/L1EDzhiLBgM6HblTeq2e+duk57HGiPBwLknSaTWqmVm0NTVrbQ/PXGX+
	 9YRmEiEpAxcfA==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	stable+noautosel@kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/6] PCI: endpoint: Cleanup get_msi() callback
Date: Wed, 14 May 2025 09:43:16 +0200
Message-ID: <20250514074313.283156-11-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514074313.283156-8-cassel@kernel.org>
References: <20250514074313.283156-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4166; i=cassel@kernel.org; h=from:subject; bh=MOjVq0wsI47Gay1z9sU3CotJFGegvueUV3NPqsKkawk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJUPCfdPf5m68f6C+xcFUz+06tTy2qbsk2XtUpFCbjJO j+Z53Wgo5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABO5s4GR4YzKuvPtm693rSxa ffqmry7TiczbMQ1vn/ppnZn758WL9B5Ghq19R+LPBogo9n+c3bAr7K2Gy5euidE734UYx64O+HK ykBsA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The kdoc for pci_epc_get_msi() says:
"Invoke to get the number of MSI interrupts allocated by the RC"
the kdoc for the callback pci_epc_ops->get_msi() says:
"ops to get the number of MSI interrupts allocated by the RC from
the MSI capability register"

pci_epc_ops->get_msi() does however return the number of interrupts
in the encoding as defined by the MME Multiple Message Enable field.

Nowhere in the kdoc does it say that the returned number of interrupts
is in MME encoding.

Thus, it is very confusing that the wrapper function (pci_epc_get_msi())
and the callback function (pci_epc_ops->get_msi()) don't return the same
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
 drivers/pci/controller/pcie-rcar-ep.c            | 2 +-
 drivers/pci/controller/pcie-rockchip-ep.c        | 4 ++--
 drivers/pci/endpoint/pci-epc-core.c              | 2 --
 5 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 112ae200b393..78b4d009cd04 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -262,7 +262,7 @@ static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
 	 */
 	mme = FIELD_GET(PCI_MSI_FLAGS_QSIZE, flags);
 
-	return mme;
+	return 1 << mme;
 }
 
 static int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 24026f3f3413..03597551f4cd 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -532,7 +532,7 @@ static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 
 	val = FIELD_GET(PCI_MSI_FLAGS_QSIZE, val);
 
-	return val;
+	return 1 << val;
 }
 
 static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
index c5e0d025bc43..9da39a4617b6 100644
--- a/drivers/pci/controller/pcie-rcar-ep.c
+++ b/drivers/pci/controller/pcie-rcar-ep.c
@@ -280,7 +280,7 @@ static int rcar_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
 	if (!(flags & MSICAP0_MSIE))
 		return -EINVAL;
 
-	return ((flags & MSICAP0_MMESE_MASK) >> MSICAP0_MMESE_OFFSET);
+	return 1 << ((flags & MSICAP0_MMESE_MASK) >> MSICAP0_MMESE_OFFSET);
 }
 
 static int rcar_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 85ea36df2f59..85ca7d9b4c77 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -340,8 +340,8 @@ static int rockchip_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
 	if (!(flags & ROCKCHIP_PCIE_EP_MSI_CTRL_ME))
 		return -EINVAL;
 
-	return ((flags & ROCKCHIP_PCIE_EP_MSI_CTRL_MME_MASK) >>
-			ROCKCHIP_PCIE_EP_MSI_CTRL_MME_OFFSET);
+	return 1 << ((flags & ROCKCHIP_PCIE_EP_MSI_CTRL_MME_MASK) >>
+		     ROCKCHIP_PCIE_EP_MSI_CTRL_MME_OFFSET);
 }
 
 static void rockchip_pcie_ep_assert_intx(struct rockchip_pcie_ep *ep, u8 fn,
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index beabea00af91..cc1456bd188e 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -293,8 +293,6 @@ int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	if (interrupt < 0)
 		return 0;
 
-	interrupt = 1 << interrupt;
-
 	return interrupt;
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_msi);
-- 
2.49.0


