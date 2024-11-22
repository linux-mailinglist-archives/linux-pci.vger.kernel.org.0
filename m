Return-Path: <linux-pci+bounces-17209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3761B9D5E7A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 12:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8ECBB2506C
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 11:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2921DE8AD;
	Fri, 22 Nov 2024 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iG4AgvbG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869821DE891
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732276670; cv=none; b=ExKrtDN1Y2GLYedLbgWhAp1/kcBMd3PAxDkD1ZwJP03EmDJn0ybYrXYkZ4kI7A9LQ1VVvH3a9NmS4pD5Gf4JM0YhA1ajJ66wFrgYVEW9FMO/+J5jgd19qhfOLNrhlWaMYgUfe1H5pptZLMzTjZ8NRBoEZ4RMTCNAzBWZoJNgte4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732276670; c=relaxed/simple;
	bh=WVDkLSYz6JtRR+SLpXWshGrwSkHerX/M86Ha9lQyt2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZJASYEyXHhFvSd+5xm/pd/oN0b1YenilEtY3pWaqMbHtZGi3Zw/sC29cn56ABToPXMzuuuupfnYMpMJaCDh02p7L8jV4RgnttPrR0Qcb6xcpS293gJw20zhcU0QYa2MbfeIhj3b/0BEyDJN27YaPkBCDnG1e1uyOzMTFkwGpNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iG4AgvbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5B6C4AF09;
	Fri, 22 Nov 2024 11:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732276670;
	bh=WVDkLSYz6JtRR+SLpXWshGrwSkHerX/M86Ha9lQyt2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iG4AgvbGufvA0u+HZgoZY8zFnZ6ghs595MM+hszo+YYFIKwDp6dsVGSkmPDMVMz24
	 0eALzfJSmb+f1OYhEGYSfXzEr0H+J0RJ8RsQ/nG7UTdXd9pL/3l4ZUcqqnUYm0zmyC
	 FFyTpNDxbggMXbRTXTBmpfLjCBrmyfB4yr+TzTsKPd54NOLtMj1wGA03Osaz8mfGfL
	 N3d63UWIjAq7FhaiSjQh1YwQNoOLDHMeNCJEBBawpgnNCzYNiAJa5La0HdISILGcfk
	 bbUPaKeRMw9BuYri1/YB8NdNQ3GVZkYPIVN3lT+KP9OeEC7xF+vmATXc9c//pFYLMV
	 ZgVeDEeyDuXuw==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 5/5] PCI: endpoint: Verify that requested BAR size is a power of two
Date: Fri, 22 Nov 2024 12:57:14 +0100
Message-ID: <20241122115709.2949703-12-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122115709.2949703-7-cassel@kernel.org>
References: <20241122115709.2949703-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134; i=cassel@kernel.org; h=from:subject; bh=WVDkLSYz6JtRR+SLpXWshGrwSkHerX/M86Ha9lQyt2k=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIdCudMiPtqU2O08rGft0TCHXWr1t5DPyZZRH+uL/v3z O9E2b3ijlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExEt5uRob87JK20NedlxwKu VwuMZj5JXuD/Ikxon5An43+N2xwFOxgZZmmb7NvL2y19r/7gwVVb4j5Pki31VDkgXPAnR8PUSVG aDwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

When allocating a BAR using pci_epf_alloc_space(), there are checks that
round up the size to a power of two.

However, there is no check in pci_epc_set_bar() which verifies that the
requested BAR size is a power of two.

Add a power of two check in pci_epc_set_bar(), so that we don't need to
add such a check in each and every PCI endpoint controller driver.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index c69c133701c9..6062677e9ffe 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -622,6 +622,9 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	    (epc_features->bar[bar].fixed_size != epf_bar->size))
 		return -EINVAL;
 
+	if (!is_power_of_2(epf_bar->size))
+		return -EINVAL;
+
 	if ((epf_bar->barno == BAR_5 && flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ||
 	    (flags & PCI_BASE_ADDRESS_SPACE_IO &&
 	     flags & PCI_BASE_ADDRESS_IO_MASK) ||
-- 
2.47.0


