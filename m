Return-Path: <linux-pci+bounces-3226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1519984D580
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 23:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4867D1C22FAF
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 22:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104C51386A1;
	Wed,  7 Feb 2024 21:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAlMkAkQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D054D128374;
	Wed,  7 Feb 2024 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342037; cv=none; b=HdYOQoFnjKm0KYYkVNIBmyFAUSnyHaT7fzB6Lqxsl1bZGoFBIGUDaKAvhn16O7GubnpTI6WTegFElJgUSEmtfZ1uWTUQRbBC52peUi8+LfDnUub18t/oAR3ub9C7B9wrbg+7LAqCUxpsLngIR7frUND9JNQFKg+ggSSuGa0MFNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342037; c=relaxed/simple;
	bh=t1zaT2PqWJmTPD8CEXsvLf7gjiZz+GzDPD84WF2ALbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpA0t0YvxEA+rf9iEReTIdIuX15pRfm1XtHd7uKGzq7id9ooT5UjqRZKCIEw6crZ+9pzrr9rLOcmQ/zWEWwXrrVKBA0KIUYX+74p72laEVNVEAfA908xUVyqWF2TUKkslJHapOX2w2jbeUObQXtdiVIAmJ95D5B2ctcNX13pBz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAlMkAkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEADC433C7;
	Wed,  7 Feb 2024 21:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707342037;
	bh=t1zaT2PqWJmTPD8CEXsvLf7gjiZz+GzDPD84WF2ALbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XAlMkAkQFnmNijD641qDAcd7VaTGaSXSCSGvFklWFQSw4ksPQGcI5u56Vn0blhzP7
	 /TZkqtzbpBSW5ivJ7acNBK6M+4VrZJZg3Sg8rPuLTNGTc1kyq6lhGEl6aySjfVb/i/
	 4YhjqfgEEh8lozyo51MFER8EUw+43rkbLbcTozeKWMX9pf+C5G3Qx8EL20qARfK99Q
	 MyTF9DUzQkgMGW+a3mDwWATpuQMnH/IoDdZKDv3jzccIsYzrN6VGI6aR7RGyHeEO3e
	 IH9CmITZ381iVg1uiFEkdElYE3S0ARyNxaLvKHuiN5/Ds9dFVssWSB0hnBZRSySnal
	 5xnwg5/U1lP6w==
From: Niklas Cassel <cassel@kernel.org>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 4/4] PCI: endpoint: pci-epf-vntb: remove superfluous checks
Date: Wed,  7 Feb 2024 22:39:17 +0100
Message-ID: <20240207213922.1796533-5-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207213922.1796533-1-cassel@kernel.org>
References: <20240207213922.1796533-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove superfluous alignment checks, these checks are already done by
pci_epf_alloc_space().

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index ba509d67188b..eda4b906868b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -527,7 +527,6 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 {
 	const struct pci_epc_features *epc_features;
-	u32 align;
 	struct device *dev = &ntb->epf->dev;
 	int ret;
 	struct pci_epf_bar *epf_bar;
@@ -538,16 +537,6 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	epc_features = pci_epc_get_features(ntb->epf->epc,
 					    ntb->epf->func_no,
 					    ntb->epf->vfunc_no);
-	align = epc_features->align;
-
-	if (size < 128)
-		size = 128;
-
-	if (align)
-		size = ALIGN(size, align);
-	else
-		size = roundup_pow_of_two(size);
-
 	barno = ntb->epf_ntb_bar[BAR_DB];
 
 	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, epc_features, 0);
-- 
2.43.0


