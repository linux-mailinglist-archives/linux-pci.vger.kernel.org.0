Return-Path: <linux-pci+bounces-5056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D553889E89
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 13:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB281C35B4B
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 12:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0526B1487C3;
	Mon, 25 Mar 2024 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/LGWM1B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE768181495;
	Mon, 25 Mar 2024 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350680; cv=none; b=KYX1lNiNOmXEmkCcAhbE/m2OuzN7wLNgvVfYq8ZIhDwxLkym0ICG8/eAhL/DEmgYBqKRvcBFpc4aQQPKGpjaEhfoAQnJrHZHUW5seab2qQb/PfTMoUjjkGnddTf4MxNwSw3hSY7v41RuMovKbYWrhhGZ4SYjS3yDci6qRVc9xEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350680; c=relaxed/simple;
	bh=bD3pn7waGVyabrrIrvOuivhv+kWsQE+KY0AsrDgUOwM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8wUEggiWrLqQO7GlSLRP+tJOzjCrJmxLwI/Dq6WdSK9sPi5xcYhO/pkfkgpo7r8r39+bhBy+X0rgQRgKsct9S5+wd/uKFB3AmArAjaia8GttQjQeqhZFv9uKlF7YFGTtFD1bdHDbpL7cKvGB31dQk4tPRd+C8ru9YO0mwsFh7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/LGWM1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66983C43394;
	Mon, 25 Mar 2024 07:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350679;
	bh=bD3pn7waGVyabrrIrvOuivhv+kWsQE+KY0AsrDgUOwM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=q/LGWM1B7C6oEXzLyn0OvSQrW0mAYOU7gObAFz+pNpqU7TWGiohm0kB2VOYMbAp6G
	 8XerHyhTXQ9lBuR1SvmU75R8uPyT300T1voZ4MRUXX78O32A4ws5P54ycc9hiEZIu0
	 iUGVY7pgXel5vb3yTJwmRm6sWrCF/joWvrZ5l/WPDwMwk4LzxA7JOuYTN//zUArb7g
	 Y5wwkRJBoJzSHlvM+90D35vHdP3cURyOeeYh4pljIZMKS4MGe4Z0edJl9+FOmBqN2+
	 1WNTb0dt7g+Qn2dYT0ZKSF7O5EZTCeifqWePGiAULS55uHgPhdxNsr7So3C4RV8Kul
	 lh45KDw/hcAFg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	ntb@lists.linux.dev,
	Lee Jones <lee@kernel.org>,
	David Airlie <airlied@gmail.com>,
	amd-gfx@lists.freedesktop.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 24/28] scsi: megaraid: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:35 +0900
Message-ID: <20240325070944.3600338-25-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325070944.3600338-1-dlemoal@kernel.org>
References: <20240325070944.3600338-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
macro.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 3d4f13da1ae8..631a24d91fa9 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -6300,7 +6300,7 @@ static int megasas_init_fw(struct megasas_instance *instance)
 	}
 
 	if (!instance->msix_vectors) {
-		i = pci_alloc_irq_vectors(instance->pdev, 1, 1, PCI_IRQ_LEGACY);
+		i = pci_alloc_irq_vectors(instance->pdev, 1, 1, PCI_IRQ_INTX);
 		if (i < 0)
 			goto fail_init_adapter;
 	}
@@ -7839,7 +7839,7 @@ megasas_resume(struct device *dev)
 
 	if (!instance->msix_vectors) {
 		rval = pci_alloc_irq_vectors(instance->pdev, 1, 1,
-					     PCI_IRQ_LEGACY);
+					     PCI_IRQ_INTX);
 		if (rval < 0)
 			goto fail_reenable_msix;
 	}
-- 
2.44.0


