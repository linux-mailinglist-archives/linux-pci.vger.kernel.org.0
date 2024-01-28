Return-Path: <linux-pci+bounces-2649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF1283F7E9
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 17:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A42286FDC
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 16:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E0113DBB4;
	Sun, 28 Jan 2024 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XG+SMWEi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C35713DBB0;
	Sun, 28 Jan 2024 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458577; cv=none; b=bWkfQsVvO4ncQ/3mtbHD70pG/gT31Kh9Amp2y0z/vlphGv5ppf+spFd1HCqUOwh8J5SBim/MZb8CU+GY/CZlFPEmiz63Tu8iH2oXDj/pFRJas4qOkrvEJWF3XuRfv7JUikP8VPzHZlav/W/2FTm4C1+t7g4Sq6SMZ1ll6KTulrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458577; c=relaxed/simple;
	bh=rFEWieS7sAhrOlCXbHhvwHX29oyAK+tJzU1NGl+vTUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SusYGJLr/Lpju7PDo4DGUB18BPCR20Yu7iITzM6zkrtmX4yAVrX0H7+v1t9jWKYCA6ZSF6Vb6GuthzHudgeJ14+HVJF6qqldRxC4UC23Yuyy9lSt2d6LTAA3cpNyOJ6ipn1q+KHuSuKQqw5jPEIESdgiIv39FDX+xV7roBt/vy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XG+SMWEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFE5C433A6;
	Sun, 28 Jan 2024 16:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458576;
	bh=rFEWieS7sAhrOlCXbHhvwHX29oyAK+tJzU1NGl+vTUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XG+SMWEiJfde7X4SvhMXB+Cj7091j5oGgL26JGdC7tvmJFRKKmotAtxZa666FQ44e
	 J3voHaCwU/jFkKU0kvF5jZoZmhtwDe6ag2MXTYLbwhjqxBc7uAyqnlY2ERMJTbfosp
	 TioaVyyoHQwteDxda68OBKBl1gLzzubPgBYrP/f6O72VwJf4pGa5QlYFDECCiKczse
	 EExUtwEyQYkDepV00VVvsbfeiS0ClXEu7EhguAqaDmH2Ce+6i14K8zVpwnLQgrJTAO
	 w5IL5Bkg5FHye7b4Zq0bHWj3LKi4tN5AcVKATLX0enGcK5XHT0HEJAlVHY0JNr9/it
	 8MauSHWo+I2+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	mahesh@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 06/13] PCI/AER: Decode Requester ID when no error info found
Date: Sun, 28 Jan 2024 11:15:52 -0500
Message-ID: <20240128161606.205221-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161606.205221-1-sashal@kernel.org>
References: <20240128161606.205221-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit 1291b716bbf969e101d517bfb8ba18d958f758b8 ]

When a device with AER detects an error, it logs error information in its
own AER Error Status registers.  It may send an Error Message to the Root
Port (RCEC in the case of an RCiEP), which logs the fact that an Error
Message was received (Root Error Status) and the Requester ID of the
message source (Error Source Identification).

aer_print_port_info() prints the Requester ID from the Root Port Error
Source in the usual Linux "bb:dd.f" format, but when find_source_device()
finds no error details in the hierarchy below the Root Port, it printed the
raw Requester ID without decoding it.

Decode the Requester ID in the usual Linux format so it matches other
messages.

Sample message changes:

  - pcieport 0000:00:1c.5: AER: Correctable error received: 0000:00:1c.5
  - pcieport 0000:00:1c.5: AER: can't find device of ID00e5
  + pcieport 0000:00:1c.5: AER: Correctable error message received from 0000:00:1c.5
  + pcieport 0000:00:1c.5: AER: found no error details for 0000:00:1c.5

Link: https://lore.kernel.org/r/20231206224231.732765-3-helgaas@kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aer.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9564b74003f0..d58b02237075 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -741,7 +741,7 @@ static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
 	u8 bus = info->id >> 8;
 	u8 devfn = info->id & 0xff;
 
-	pci_info(dev, "%s%s error received: %04x:%02x:%02x.%d\n",
+	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
 		 info->multi_error_valid ? "Multiple " : "",
 		 aer_error_severity_string[info->severity],
 		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
@@ -926,7 +926,12 @@ static bool find_source_device(struct pci_dev *parent,
 	pci_walk_bus(parent->subordinate, find_device_iter, e_info);
 
 	if (!e_info->error_dev_num) {
-		pci_info(parent, "can't find device of ID%04x\n", e_info->id);
+		u8 bus = e_info->id >> 8;
+		u8 devfn = e_info->id & 0xff;
+
+		pci_info(parent, "found no error details for %04x:%02x:%02x.%d\n",
+			 pci_domain_nr(parent->bus), bus, PCI_SLOT(devfn),
+			 PCI_FUNC(devfn));
 		return false;
 	}
 	return true;
-- 
2.43.0


