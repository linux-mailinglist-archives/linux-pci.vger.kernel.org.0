Return-Path: <linux-pci+bounces-32663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A845EB0C7B9
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 17:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC02B3A9C27
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 15:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6005D2DEA93;
	Mon, 21 Jul 2025 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdpXppOs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342832D6639;
	Mon, 21 Jul 2025 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112217; cv=none; b=nSm/D1T32c+t1H0xqAmKmTJ/bMGscLk0QASG60H9yyAsaONS4JmfaFfJwMqin9yuULIVtp4fF0XqVqDlGgP+2mv6q1RS45ENm/tJYT8ImIcarumiwIp4mLn6OQTQoW28q2NJcGKfjTl5Jm8Q+Ot956dK4K1DylKPHlvnxNgQ8TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112217; c=relaxed/simple;
	bh=H7SIoY7UhYXgj19KT+9VPfKyOxw3tlbt63/7BfTcRzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3R3Z6txO8Ae/UD8WtCtZFhbe46G3BZkG3+dDEh+MwVt3QtbuCoFrB8p6l678lb8CSn0I2reoTdqApDq6u7mwJwcA8YybEwNUTbYzHboHcxn4v+ISwKh8RQ6H9Lu8F2+vhepHQJQzVNbalrA5THzkz0lWDc8SxP+Lfb7SEx4sNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdpXppOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D73C4CEED;
	Mon, 21 Jul 2025 15:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753112216;
	bh=H7SIoY7UhYXgj19KT+9VPfKyOxw3tlbt63/7BfTcRzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qdpXppOsgqBFK9pec7+NjI7X5NO2i/j/Er1p95jfCs9CjtroXPNCUqFV+/SG9PTek
	 W/QJp0cRuj6vPMDeRIsdJHvHH4HpIdzu7AayXRIiR6EpnpMOI+EghTsSv0HfvuNi75
	 CYEfyWnY7Ewm2zBgkaSA88712ZoT98pKvpfSeeG1y18auI3mF+2BVdutsZGl7JiUFI
	 08zSLO0E8msle0f4Sy37Vsk6RQ/prcZN7N8t+lVxRKkzCUMFaqNFN8WmrP5WSXoSpO
	 JEZrKdhXSmexqmcuS/Y4PBltEqDZ7+D9ioHHzuYSKcytBQzE03CV2NyHVFKhjaYwn2
	 HscvSbPgD9HrA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1udsZK-000000002Ff-0oAn;
	Mon, 21 Jul 2025 17:36:46 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] PCI/pwrctrl: Fix device leak at registration
Date: Mon, 21 Jul 2025 17:36:07 +0200
Message-ID: <20250721153609.8611-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250721153609.8611-1-johan+linaro@kernel.org>
References: <20250721153609.8611-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference to the pwrctrl device taken by
of_find_device_by_node() when registering a PCI device.

Fixes: b458ff7e8176 ("PCI/pwrctl: Ensure that pwrctl drivers are probed before PCI client drivers")
Cc: stable@vger.kernel.org	# 6.13
Cc: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/bus.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 69048869ef1c..0394a9c77b38 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -362,11 +362,15 @@ void pci_bus_add_device(struct pci_dev *dev)
 	 * before PCI client drivers.
 	 */
 	pdev = of_find_device_by_node(dn);
-	if (pdev && of_pci_supply_present(dn)) {
-		if (!device_link_add(&dev->dev, &pdev->dev,
-				     DL_FLAG_AUTOREMOVE_CONSUMER))
-			pci_err(dev, "failed to add device link to power control device %s\n",
-				pdev->name);
+	if (pdev) {
+		if (of_pci_supply_present(dn)) {
+			if (!device_link_add(&dev->dev, &pdev->dev,
+					     DL_FLAG_AUTOREMOVE_CONSUMER)) {
+				pci_err(dev, "failed to add device link to power control device %s\n",
+					pdev->name);
+			}
+		}
+		put_device(&pdev->dev);
 	}
 
 	if (!dn || of_device_is_available(dn))
-- 
2.49.1


