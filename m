Return-Path: <linux-pci+bounces-20607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BEAA242A3
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 19:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB462166F4A
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 18:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D897F1F2C2E;
	Fri, 31 Jan 2025 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsEC0FJp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44AD1F2C33
	for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2025 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738348233; cv=none; b=le8PKyI8IGFd5glPDnX021lkkb16YPgRfmKGgh98YVKIgGoq6jMLbm8xgePpSAhTdby1Udq1PX5OtaU3QpWuaFkZ3cHy88jJSYk5oZK3x8+RyhOccwzaeSXj2oTqKG1Kg/upBJfaeWveO+HFLvI6kfY1gr3/KK5PTHgP5YGoLYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738348233; c=relaxed/simple;
	bh=Bi1EDc1v8t/I1ufJIhDjHxnt+Ry1rozlhmo2/jK3fSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtTdJTm8z9ScdOWU/vG4ENTdWNw416E5AalWajX05wDXBeg+If3DudgBouY6AmQddDdLqWsXvOe7kkjg6FT+KXwBzJrQHEmrR9vrymC7cHfbJyTg1Gal1Ahu1Ldz/mZrBsY/PHhonFk9IdSH72RQ3m5xGELLExecTa+Oaw6ZgFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsEC0FJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E697BC4CED1;
	Fri, 31 Jan 2025 18:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738348233;
	bh=Bi1EDc1v8t/I1ufJIhDjHxnt+Ry1rozlhmo2/jK3fSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XsEC0FJpzfKnP9uc+4Yo38ZQXHaym3iM7LzL63lvkAffdXGalf83ctwIBsnk6Q91P
	 e4oWrrb1sMucYni6EAnJP5gt5O3anGDDvjA133I2+UZyG/F9mH/vfApJt0RrDX1XdW
	 MoTViE6qLnx+x46jkC0OyDYeT+gcFyf0E55HDPm7YEt6xBoqN/ZCKUsfrQyzuEBmT5
	 N5PRT6lCsxooO73GcdVHUt/2z9apJlOZmFcqX512sw3lmh7zOoCgRpdnTegDKTNad9
	 9Axp9KOna4IcR3KLdkXPrXcFp33xTkcXZFMUzaoaRkD7HGWUHzqyIGOmdQPQa3lIQ4
	 1sT/GUyS5jy9w==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 5/7] PCI: keystone: Describe Resizable BARs as Resizable BARs
Date: Fri, 31 Jan 2025 19:29:54 +0100
Message-ID: <20250131182949.465530-14-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131182949.465530-9-cassel@kernel.org>
References: <20250131182949.465530-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357; i=cassel@kernel.org; h=from:subject; bh=Bi1EDc1v8t/I1ufJIhDjHxnt+Ry1rozlhmo2/jK3fSQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLniq1+/GhFlFxJSLDZRW+eS9taetxS5GeF/dc7JRzKZ PXJ9FJRRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACayYAfDH36leoZpFpXLjAyW Nu6MM3sS022tXRyak/GPQ+0cd2nAJkaGr4tnrr3twKsZf1d+09/9+pVZvVl/Kie3u245tMejsjG PDwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Looking at "12.2.2.4.15 PCIe Subsystem BAR Configuration" in the
AM65x TRM:
https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf

We can see that BAR2 and BAR5 are not Fixed BARs, but actually Resizable
BARs.

Now when we actually have support for Resizable BARs, let's configure
these BARs as such.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 63bd5003da45..fdc610ec7e5e 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -966,10 +966,10 @@ static const struct pci_epc_features ks_pcie_am654_epc_features = {
 	.msix_capable = true,
 	.bar[BAR_0] = { .type = BAR_RESERVED, },
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
-	.bar[BAR_2] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
+	.bar[BAR_2] = { .type = BAR_RESIZABLE, },
 	.bar[BAR_3] = { .type = BAR_FIXED, .fixed_size = SZ_64K, },
 	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = 256, },
-	.bar[BAR_5] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
+	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
 	.align = SZ_1M,
 };
 
-- 
2.48.1


