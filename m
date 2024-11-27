Return-Path: <linux-pci+bounces-17406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7519DA5CA
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 11:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95AB116287E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 10:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FB919883C;
	Wed, 27 Nov 2024 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMGRsGvb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D36918E0E
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703449; cv=none; b=ToEX5oO+EyJ24kWlMEKYWX7u8PTZvcix6PYboAjThV6brCzrcCfCBLTfGiQl5xCJjkLr5xzc7XIkoWe/PSgOPwVHliAvsDsUwD20gT3d1U2NFFJvGC0E3gijWMC5a3Jdd6cGSUC9lf35MUevHHSWfJRzhO5IbhXU03CAZmSXP0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703449; c=relaxed/simple;
	bh=yoUldh/uZchEIwYIHV5nk8tHJLu9/aT+70+9evMH1PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aME+cyEPobzSTjubLlQYJuoMF207LFdagJf9cy8utEVkL9khXdcbx555TDDvPVKWBjC1M3tkHgt37A6hsubML50E0LfZU+TNVJldRH7LJ8goFC0juiQ+llc6wDtOMV45lqgibz5qVaEKpXA2CZQ0do9AIBi5E0Q1h34pHkXNJTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMGRsGvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FDEC4CECC;
	Wed, 27 Nov 2024 10:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732703449;
	bh=yoUldh/uZchEIwYIHV5nk8tHJLu9/aT+70+9evMH1PU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TMGRsGvb8RZNXqcTGn7DIxihj81lfuvyOTfiVf6Wlmyhq0BIfTtMIT9RV+fkjIB5U
	 yPthu6bhlyWpJXvtnJ/qWinZQ7SyIjnEHmMrr3U+vdnfx6YvG6FmXQyojAGtL1+Vev
	 OsfC3sfPRREmgPCXhGjqR1JFM4pQlCOkP7XjRIo1aAluGAJn/ZEwJAxPCYoYDo2YpI
	 kZOgot/uNFmxu1GHUa1mHLUHkXTUp9tjpXTQRx6CCOxHQqmJhiI/DeVsmOtKNzqnsy
	 KcJiY5d/TeuhjxND4XEVztFDnM8WNi5pPC0GhNm+BtH+dJZPbAyysBwm2rTUoEsG7j
	 Sv1JZOyJVIyhw==
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
Subject: [PATCH v5 6/6] PCI: endpoint: Verify that requested BAR size is a power of two
Date: Wed, 27 Nov 2024 11:30:22 +0100
Message-ID: <20241127103016.3481128-14-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127103016.3481128-8-cassel@kernel.org>
References: <20241127103016.3481128-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=cassel@kernel.org; h=from:subject; bh=yoUldh/uZchEIwYIHV5nk8tHJLu9/aT+70+9evMH1PU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLdvuwL9V4w63ap//ytyo6T/aPtzrF9usD0e27O+Z3PA /nqwt5u6ihlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEWkUYGe49mVCx+fTV+Wou itViLLytoQlKrxTmBWy7ON/DfXqkvC8jw+R23cPnVSc/yH48bbrgg0Jzi7071Fh6He39tuatNHT UYAEA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

When allocating a BAR using pci_epf_alloc_space(), there are checks that
round up the size to a power of two.

However, there is no check in pci_epc_set_bar() which verifies that the
requested BAR size is a power of two.

Add a power of two check in pci_epc_set_bar(), so that we don't need to
add such a check in each and every PCI endpoint controller driver.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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


