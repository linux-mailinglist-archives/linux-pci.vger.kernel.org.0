Return-Path: <linux-pci+bounces-2642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEB683F77B
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 17:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F74B1F2375F
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 16:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8673174;
	Sun, 28 Jan 2024 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Va9lCwBI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD8D6EB66;
	Sun, 28 Jan 2024 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458486; cv=none; b=ASSdwqq/dS8C2u1B1Vi+AQHPxsIQvOka/dMcC10Ic+nv9Ke1oHT2zUUepFNZz0V8n8ROcDeamX60O9XMwcaDOuW0+sJdO03vM3XFqJMplkke8hKcdPxRHVjo3KIpGLGimCRnFi/uCGQmFIE2Aj1F250A+G+zNqtBLSBs7hLc89A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458486; c=relaxed/simple;
	bh=7Oc7XQZw0BQgE7vpQeYLErcpNOAZHMGGgfcBbkIJeDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1luvTwUBotib3X+sHcNXwCJvwfYcl1HAkawH7MZArun740wwNapXGclN/tZg1twX42ZDYBL/Fkzz/+A3HA+/SyvFQ/qQ8iHHFigZL+3E5pC+SQCimQBx7dJg/D9bYKwyaJR9cQXx1V9eXlcSyLcdxg4rPltgDkS2K86VVlzNps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Va9lCwBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3FFC433C7;
	Sun, 28 Jan 2024 16:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458485;
	bh=7Oc7XQZw0BQgE7vpQeYLErcpNOAZHMGGgfcBbkIJeDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Va9lCwBIIFEK8Wjzgae8HaljqSkHWgy/Ma9zzXoES1GmZH4rRLjjZzZ+7+FSiqBvK
	 X5Ypt/CMBm9OvZRhytTqxKr5NNtC7lqL6k55/eeSLMCgYS6O+kbpvY9ytRGECIX7L8
	 dHA8cwYU1Xotqq7Cgm2b82B961hzlPgjLG5PYToVDmMM77JWNGT2n/RGECOOtf2uEz
	 SNPRM7NeH7Ac08dscE14dUWsKCoJbwP0aShPYVIzq53RFA6mhleH/3beyOaVX76w3c
	 fCoBP8CxHVw4cKG32bsRJde1RhTr6WaGtx6kSg+c8KjPEYjenVKWtAT1xIErD5yTAg
	 WwoZCNBVCUK6Q==
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
Subject: [PATCH AUTOSEL 6.1 12/27] PCI/AER: Decode Requester ID when no error info found
Date: Sun, 28 Jan 2024 11:13:57 -0500
Message-ID: <20240128161424.203600-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161424.203600-1-sashal@kernel.org>
References: <20240128161424.203600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.75
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
index e2d8a74f83c3..5426f450ce91 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -748,7 +748,7 @@ static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
 	u8 bus = info->id >> 8;
 	u8 devfn = info->id & 0xff;
 
-	pci_info(dev, "%s%s error received: %04x:%02x:%02x.%d\n",
+	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
 		 info->multi_error_valid ? "Multiple " : "",
 		 aer_error_severity_string[info->severity],
 		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
@@ -936,7 +936,12 @@ static bool find_source_device(struct pci_dev *parent,
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


