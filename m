Return-Path: <linux-pci+bounces-12698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B3796A99C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 23:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021391C20AB3
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 21:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E671D7E35;
	Tue,  3 Sep 2024 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEU9mtrE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1251D7E34
	for <linux-pci@vger.kernel.org>; Tue,  3 Sep 2024 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396569; cv=none; b=ONWUix5em1OlS5TA5+yZszdEfIVXJraKZRUg6GROxHJ5Jt/tVK/HdCvsAVS6aWW/d5+O/qq77w54+Co9k82mhF1tMH0ZZcvNJjv6Vg9pNQ+CEALo9ztuTSofZfdhGFC+E0TN4+EeoLkE69kdaoRvqRuC0oQ2ckI+gWsAFbQ9XnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396569; c=relaxed/simple;
	bh=4OLwVcrZnoDASRAmIuGASm3uvI9fO2dlr62fLWOhAuM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PjrQTrTP+aL4CYmO4LYVkoEanB4F74qlKUZkX6XeBqK8KSqzdblXpoyJrubzZtwtRQ6RtMdxWT+hwGmQXvrZq7kaTku2qpMe49GhIuXkfcwTWgQB4OxX/2J72Feat6Mjlysbzj8u4ly5E6fcmn3b8ZAXNWrLJuVF0GP2XctB7Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEU9mtrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DFFC4CEC4;
	Tue,  3 Sep 2024 20:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396569;
	bh=4OLwVcrZnoDASRAmIuGASm3uvI9fO2dlr62fLWOhAuM=;
	h=From:To:Cc:Subject:Date:From;
	b=hEU9mtrEVeoLbA+HpCXcLnTeUHBuhCNYlwxjvLUUoTytOdMAWLl63nx+IK/vrqA5H
	 7gZ77AOfpkXcMlw3rNKA/HmDOTTc5tBsBg6gcNyRI2wqPmhnfPS9OvhxwhY9m+TLQS
	 BdAP4bO5XtO4DTQusbqj/2WbxlE44p7KQ1alcLPvnDFxh2n30IR39QRP6zx0eW9/a/
	 I8jQ61cPr+dvuri/vQcYWfLJRISG+uEMo6lZkC51Hpm36H2Ee+9BO0UsetPzQ+bciK
	 Uy/L3le7JXyWvQDQvboTJLxOtOknna2BDNCe+CQKFcT+cjcxH3mF/2uGUmSoGzE+Q6
	 +GBa8yqIgdNJw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: cadence: Drop excess cdns_pcie_rc.dev description
Date: Tue,  3 Sep 2024 15:49:26 -0500
Message-Id: <20240903204926.276913-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Struct cdns_pcie_rc once had a .dev member, but it was removed by
bd22885aa188 ("PCI: cadence: Refactor driver to use as a core library").
Drop the extra kerneldoc for it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/cadence/pcie-cadence.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 7a66a2f815dc..9e6f602ac79f 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -314,7 +314,6 @@ struct cdns_pcie {
 /**
  * struct cdns_pcie_rc - private data for this PCIe Root Complex driver
  * @pcie: Cadence PCIe controller
- * @dev: pointer to PCIe device
  * @cfg_res: start/end offsets in the physical system memory to map PCI
  *           configuration space accesses
  * @cfg_base: IO mapped window to access the PCI configuration space of a
-- 
2.34.1


